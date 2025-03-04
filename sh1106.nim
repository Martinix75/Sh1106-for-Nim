#import picostdlib/[stdio, gpio, time, i2c]
import picostdlib
import picostdlib/hardware/[i2c, gpio]
import picostdlib/pico/[time, stdio]
import std/[options, strformat]
import frameBuffer
from sequtils import insert
#import strformat
export frameBuffer

const
  sh1106Ver = "0.4.0" #piscostd 0.4.0
  setContrast = 0x81
  setNormInv = 0xA6
  setDisp = 0xAE
  setScanDir = 0xC0
  setSegRemap = 0xA0
  lowColumnAddress = 0x00
  highColumnAddress = 0x10
  setPageAddress = 0xB0

type 
  SH1106 = ref object of Framebuffer
    i2c: ptr I2cInst
    lcdAdd, rotate, pagesToUpDate: uint8
    temp: array[0..1, byte]
    width, height, pages, bufSize: int
    externalVcc: bool
    displayBuff: seq[byte]
    delay: uint32

# ---------- INIZIO Prototipi Procedura Private   ----------
proc initDisplay(self: SH1106)
proc writeCdm(self: SH1106; cdm: byte)
proc writeData(self: SH1106; buf: seq[byte])
proc registerUpDate(self: SH1106; yZero: int; yOne=none(int))
# ---------- FINE   Prototipi Procedura Private   ----------
# ---------- INIZIO Prototipi Procedura Pubbliche ----------
proc newSh1106*(i2c: ptr I2cInst; lcdAdd: uint8; width, height: int; externalVcc=false, rotate=uint8(0), delay=uint32(0)): SH1106
proc clear*(self:SH1106, color=0)
proc powerOn*(self: SH1106)
proc powerOff*(self: SH1106)
proc hline*(self: SH1106; x, y, width, color: int)
proc vline*(self: SH1106; x, y, height, color: int)
proc line*(self: SH1106; xZero, yZero, xOne, yOne, color: int; size=1)
proc rect*(self: SH1106; x, y, width, height, color: int; fill=false)
proc circle*(self: SH1106; xCenter, yCenter, radius, color: int)
proc text*(self: SH1106; text: string; x, y, color: int; size=1)
proc show*(self: SH1106; fullUpDate=false)
proc invert*(self: SH1106; invert=false)
# ---------- FINE   Prototipi Procedura Pubbliche ----------
proc newSh1106*(i2c: ptr I2cInst; lcdAdd: uint8; width, height: int; externalVcc=false, rotate=uint8(0), delay=uint32(0)): SH1106 =
  let 
    pagesSh = height div 8
    bufSizeSh = pagesSh*width
    renderBuffSh = newSeqOfCap[byte](bufSizeSh+1)
    pagesToUpDateSh = uint8(0)
  var
    displayBuffSh = if rotate == 0: renderBuffSh else: newSeqOfCap[byte](bufSizeSh) #da studiare in caso di rotazione!!
  displayBuffSh.setLen(bufSizeSh+1)
  result = SH1106(i2c: i2c, lcdAdd: lcdAdd, width: width, height: height, externalVcc: externalVcc,
                  pages: pagesSh, bufSize: bufSizeSh, pagesToUpDate: pagesToUpDateSh, fbRotation: 0,
                  delay: delay, fbStride: width, fbWidth: width, fbHeight: height, fbBuff: displayBuffSh)
  result.initDisplay()

proc initDisplay(self: SH1106) =
  self.powerOn()
  #self.loadChars()

proc writeCdm(self: SH1106; cdm: byte) =
  self.temp[0] = 0x80
  self.temp[1] = cdm
  let addrElementCdm = self.temp[0].unsafeAddr
  discard writeBlocking(self.i2c, self.lcdAdd.I2cAddress, addrElementCdm,
                csize_t(self.temp.len()*sizeof(self.temp[0])), true)
  
proc writeData(self: SH1106; buf: seq[byte]) = 
  let paramWD: byte = 0x40
  var buffWD = buf
  buffWD.insert(paramWD, 0)
  let addrElementBuffWD = buffWD[0].unsafeAddr
  discard writeBlocking(self.i2c, self.lcdAdd.I2cAddress, addrElementBuffWD,
                csize_t(buffWD.len()*sizeof(buffWD[0])), false)

proc registerUpDate(self: SH1106; yZero: int; yOne=none(int)) =
  var
    startPageUD = max(0, (yZero div 8))
    endPageUD = if isNone(yOne): startPageUD else: max(0, (yOne.get() div 8))
  if startPageUD > endPageUD:
    startPageUD = endPageUD; endPageUD = startPageUD
  for pageUD in countup(startPageUD, endPageUD):
    self.pagesToUpDate = self.pagesToUpDate or uint8((1 shl pageUD))
    
proc clear*(self:SH1106, color=0) =
  self.clearFb(color=color)
  
proc powerOn*(self: SH1106) =
  self.writeCdm(setDisp or 0x01)
  if self.delay != 0:
    sleepMs(self.delay)

proc powerOff*(self: SH1106) =
  self.writeCdm(setDisp or 0x00)

#[proc fill*(self: SH1106; color=0) =
  self.fillFb(color)
  self.pagesToUpDate = uint8((1 shl self.pages)-1)]#

proc hline*(self: SH1106; x, y, width, color: int) =
  self.hlineFb(x=x, y=y, width=width, color=color)
  self.registerUpDate(yZero=y)

proc vline*(self: SH1106; x, y, height, color: int) =
  self.vlineFb(x=x, y=y, height=height, color=color)
  self.registerUpDate(yZero=y, yOne=some(y+height-1))

proc line*(self: SH1106; xZero, yZero, xOne, yOne, color: int; size=1) =
  self.lineFb(xStr=xZero, yStr=yZero, xEnd=xOne, yEnd=yOne, color=color)
  self.registerUpDate(yZero=yZero, yOne=some(yOne))

proc rect*(self: SH1106; x, y, width, height, color: int; fill=false) =
  self.rectFb(x=x, y=y, width=width, height=height, color=color, fill=fill)
  self.registerUpDate(yZero=y, yOne=some(y+height-1))

proc circle*(self: SH1106; xCenter, yCenter, radius, color: int) =
  self.circleFb(xCenter=xCenter, yCenter=yCenter, radius=radius, color=color)
  self.registerUpDate(yZero=yCenter)#, yOne=some()

proc text*(self: SH1106; text: string; x, y, color: int; size=1) =
  self.textFb(text=text, x=x, y=y, color=color)
  self.registerUpDate(yZero=y, yOne=some(y+7))

proc invert*(self: SH1106; invert=false) =
  let sysInvert = if invert == false: 0 else: 1
  self.writeCdm(uint8(setNormInv or (sysInvert and 1)))
  
proc show*(self: SH1106; fullUpDate=false) =
  let
    widthSW = self.width
    #pageSW =self.page #futre applicazioni
    displayBuffSW = self.fbBuff
    #renderBuffSW = self.renderBuff
  var
    pagetoUpdateSW: uint8
  if fullUpDate == true:
    pageToUpdateSW = uint8((1 shl self.pages)-1)
  else:
    pagetoUpdateSW = self.pagesToUpDate
  for pageSW in countup(0, (self.pages)-1):
    if (pagetoUpdateSW and uint8((1 shl pageSW))) != 0:
      self.writeCdm(uint8(setPageAddress or pageSW))
      self.writeCdm(lowColumnAddress or 2)
      self.writeCdm(highColumnAddress or 0)
      self.writeData(displayBuffSW[(widthSW*pageSw)..(widthSW*pageSW+widthSW)])
  self.pagesToUpDate = 0
  
when isMainModule:
  import picostdlib/[stdio, gpio, time, i2c]
  stdioInitAll()
  sleepMs(1500)
  print("Test SH1106")
  i2cSetupNim(blokk=i2c1, psda=2.Gpio, pscl=3.Gpio, freq=300_000)
  let oled = newSh1106(i2c=i2c1, lcdAdd=0x3C, width=128, height=64)
  print("--- Fill ---")
  oled.clear(0)
  sleepMs(1000)
  print(" ---- Linea ---")
  oled.line(1, 10, 80, 10,1)
  oled.hline(3, 3, 55, 1)
  oled.vline(90, 6, 45, 1)
  #oled.rect(1, 15, 30, 18, 1, true)
  oled.circle(30, 40, 20,1)
  oled.text("rev " & sh1106Ver , 2, 30 ,1)
  oled.text("go Home", 30, 56, 1)
  sleepMs(2000)
   #oled.invert(true)
  
  print("---- SHOW------")
  oled.show() 
