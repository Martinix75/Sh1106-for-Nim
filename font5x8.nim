type
    CharDisp* = object
      byteChar*: array[0..95, array[0..4, byte]]
      xSize*, ySize*: int
const
  std = ([
              [0x00, 0x00, 0x00, 0x00, 0x00],#char 
              [0x00, 0x00, 0x5F, 0x00, 0x00],#char !
              [0x00, 0x07, 0x00, 0x07, 0x00],#char "
              [0x14, 0x7F, 0x14, 0x7F, 0x14],#char #
              [0x24, 0x2A, 0x7F, 0x2A, 0x12],#char $
              [0x23, 0x13, 0x08, 0x64, 0x62],#char %
              [0x36, 0x49, 0x56, 0x20, 0x50],#char &
              [0x08, 0x07, 0x03, 0x00, 0x00],#char '
              [0x00, 0x1C, 0x22, 0x41, 0x00],#char (
              [0x00, 0x41, 0x22, 0x1C, 0x00],#char )
              [0x14, 0x08, 0x3E, 0x08, 0x14],#char *
              [0x08, 0x08, 0x3E, 0x08, 0x08],#char +
              [0x00, 0xB0, 0x70, 0x00, 0x00],#char ,
              [0x08, 0x08, 0x08, 0x08, 0x08],#char -
              [0x00, 0x60, 0x60, 0x00, 0x00],#char .
              [0x20, 0x10, 0x08, 0x04, 0x02],#char /
              [0x3E, 0x51, 0x49, 0x45, 0x3E],#char 0
              [0x00, 0x42, 0x7F, 0x40, 0x00],#char 1
              [0x72, 0x49, 0x49, 0x49, 0x46],#char 2
              [0x21, 0x41, 0x49, 0x4D, 0x33],#char 3
              [0x18, 0x14, 0x12, 0x7F, 0x10],#char 4
              [0x27, 0x45, 0x45, 0x45, 0x39],#char 5
              [0x3C, 0x4A, 0x49, 0x49, 0x31],#char 6
              [0x41, 0x21, 0x11, 0x09, 0x07],#char 7
              [0x36, 0x49, 0x49, 0x49, 0x36],#char 8
              [0x46, 0x49, 0x49, 0x29, 0x1E],#char 9
              [0x00, 0x00, 0x14, 0x00, 0x00],#char :
              [0x00, 0x40, 0x34, 0x00, 0x00],#char ;
              [0x08, 0x14, 0x22, 0x41, 0x00],#char <
              [0x14, 0x14, 0x14, 0x14, 0x14],#char =
              [0x41, 0x22, 0x14, 0x08, 0x00],#char >
              [0x02, 0x01, 0x59, 0x09, 0x06],#char ?
              [0x3E, 0x41, 0x5D, 0x59, 0x4E],#char @
              [0x7C, 0x12, 0x11, 0x12, 0x7C],#char A
              [0x7F, 0x49, 0x49, 0x49, 0x36],#char B
              [0x3E, 0x41, 0x41, 0x41, 0x22],#char C
              [0x7F, 0x41, 0x41, 0x41, 0x3E],#char D
              [0x7F, 0x49, 0x49, 0x49, 0x49],#char E
              [0x7F, 0x09, 0x09, 0x09, 0x09],#char F
              [0x3E, 0x41, 0x41, 0x51, 0x73],#char G
              [0x7F, 0x08, 0x08, 0x08, 0x7F],#char H
              [0x00, 0x41, 0x7F, 0x41, 0x00],#char I
              [0x20, 0x40, 0x41, 0x3F, 0x01],#char J
              [0x7F, 0x08, 0x14, 0x22, 0x41],#char K
              [0x7F, 0x40, 0x40, 0x40, 0x40],#char L
              [0x7F, 0x02, 0x0C, 0x02, 0x7F],#char M
              [0x7F, 0x04, 0x08, 0x10, 0x7F],#char N
              [0x3E, 0x41, 0x41, 0x41, 0x3E],#char O
              [0x7F, 0x09, 0x09, 0x09, 0x06],#char P
              [0x3E, 0x41, 0x51, 0x21, 0x5E],#char Q
              [0x7F, 0x09, 0x19, 0x29, 0x46],#char R
              [0x26, 0x49, 0x49, 0x49, 0x32],#char S
              [0x01, 0x01, 0x7F, 0x01, 0x01],#char T
              [0x3F, 0x40, 0x40, 0x40, 0x3F],#char U
              [0x1F, 0x20, 0x40, 0x20, 0x1F],#char V
              [0x3F, 0x40, 0x38, 0x40, 0x3F],#char W
              [0x63, 0x14, 0x08, 0x14, 0x63],#char X
              [0x03, 0x04, 0x78, 0x04, 0x03],#char Y
              [0x61, 0x51, 0x49, 0x45, 0x43],#char Z
              [0x00, 0x7F, 0x41, 0x41, 0x00],#char [
              [0x02, 0x04, 0x08, 0x10, 0x20],#char BackSlash
              [0x00, 0x41, 0x41, 0x7F, 0x00],#char ]
              [0x04, 0x02, 0x01, 0x02, 0x04],#char ^
              [0x40, 0x40, 0x40, 0x40, 0x40],#char _
              [0x07, 0x0B, 0x00, 0x00, 0x00],#char `
              [0x20, 0x54, 0x54, 0x78, 0x40],#char a
              [0x7F, 0x28, 0x44, 0x44, 0x38],#char b
              [0x38, 0x44, 0x44, 0x44, 0x28],#char c
              [0x38, 0x44, 0x44, 0x28, 0x7F],#char d
              [0x38, 0x54, 0x54, 0x54, 0x18],#char e
              [0x00, 0x08, 0x7E, 0x09, 0x02],#char f
              [0x18, 0xA4, 0xA4, 0x9C, 0x78],#char g
              [0x7F, 0x08, 0x04, 0x04, 0x78],#char h
              [0x00, 0x44, 0x7D, 0x40, 0x00],#char i
              [0x20, 0x40, 0x40, 0x3D, 0x00],#char j
              [0x7F, 0x10, 0x28, 0x44, 0x00],#char k
              [0x00, 0x41, 0x7F, 0x40, 0x00],#char l
              [0x7C, 0x04, 0x78, 0x04, 0x78],#char m
              [0x7C, 0x08, 0x04, 0x04, 0x78],#char n
              [0x38, 0x44, 0x44, 0x44, 0x38],#char o
              [0xFC, 0x18, 0x24, 0x24, 0x18],#char p
              [0x18, 0x24, 0x24, 0x18, 0xFC],#char q
              [0x7C, 0x08, 0x04, 0x04, 0x08],#char r
              [0x48, 0x54, 0x54, 0x54, 0x24],#char s
              [0x04, 0x04, 0x3F, 0x44, 0x24],#char t
              [0x3C, 0x40, 0x40, 0x20, 0x7C],#char u
              [0x1C, 0x20, 0x40, 0x20, 0x1C],#char v
              [0x3C, 0x40, 0x30, 0x40, 0x3C],#char w
              [0x44, 0x28, 0x10, 0x28, 0x44],#char x
              [0x4C, 0x90, 0x90, 0x90, 0x7C],#char y
              [0x44, 0x64, 0x54, 0x4C, 0x44],#char z
              [0x00, 0x08, 0x36, 0x41, 0x00],#char {
              [0x00, 0x00, 0x77, 0x00, 0x00],#char |
              [0x00, 0x41, 0x36, 0x08, 0x00],#char }
              [0x04, 0x02, 0x04, 0x08, 0x04],#char ~
              [0x00, 0x7F, 0x41, 0x7F, 0x00] #char 
              ])

  test = ([
              [0x00, 0x00, 0x00, 0x00, 0x00],#char 
              [0x00, 0x00, 0x5F, 0x00, 0x00],#char !
              [0x00, 0x07, 0x00, 0x07, 0x00],#char "
              [0x14, 0x7F, 0x14, 0x7F, 0x14],#char #
              [0x24, 0x2A, 0x7F, 0x2A, 0x12],#char $
              [0x23, 0x13, 0x08, 0x64, 0x62],#char %
              [0x36, 0x49, 0x56, 0x20, 0x50],#char &
              [0x08, 0x07, 0x03, 0x00, 0x00],#char '
              [0x00, 0x1C, 0x22, 0x41, 0x00],#char (
              [0x00, 0x41, 0x22, 0x1C, 0x00],#char )
              [0x14, 0x08, 0x3E, 0x08, 0x14],#char *
              [0x08, 0x08, 0x3E, 0x08, 0x08],#char +
              [0x00, 0xB0, 0x70, 0x00, 0x00],#char ,
              [0x08, 0x08, 0x08, 0x08, 0x08],#char -
              [0x00, 0x60, 0x60, 0x00, 0x00],#char .
              [0x20, 0x10, 0x08, 0x04, 0x02],#char /
              [0x3E, 0x51, 0x49, 0x45, 0x3E],#char 0
              [0x00, 0x42, 0x7F, 0x40, 0x00],#char 1
              [0x72, 0x49, 0x49, 0x49, 0x46],#char 2
              [0x21, 0x41, 0x49, 0x4D, 0x33],#char 3
              [0x18, 0x14, 0x12, 0x7F, 0x10],#char 4
              [0x27, 0x45, 0x45, 0x45, 0x39],#char 5
              [0x3C, 0x4A, 0x49, 0x49, 0x31],#char 6
              [0x41, 0x21, 0x11, 0x09, 0x07],#char 7
              [0x36, 0x49, 0x49, 0x49, 0x36],#char 8
              [0x46, 0x49, 0x49, 0x29, 0x1E],#char 9
              [0x00, 0x00, 0x14, 0x00, 0x00],#char :
              [0x00, 0x40, 0x34, 0x00, 0x00],#char ;
              [0x08, 0x14, 0x22, 0x41, 0x00],#char <
              [0x14, 0x14, 0x14, 0x14, 0x14],#char =
              [0x41, 0x22, 0x14, 0x08, 0x00],#char >
              [0x02, 0x01, 0x59, 0x09, 0x06],#char ?
              [0x3E, 0x41, 0x5D, 0x59, 0x4E],#char @
              [0xFE, 0x09, 0x09, 0x09, 0xFE],#char A mod
              [0xFF, 0x89, 0x89, 0x89, 0x76],#char B mod
              [0x7E, 0x81, 0x81, 0x81, 0x42],#char C mod
              [0xFF, 0x81, 0x81, 0x42, 0x3C],#char D mod
              [0xFF, 0x89, 0x89, 0x81, 0x81],#char E mod
              [0xFF, 0x09, 0x09, 0x01, 0x01],#char F mod
              [0x7E, 0x81, 0x81, 0x89, 0x7A],#char G mod
              [0x7F, 0x08, 0x08, 0x08, 0x7F],#char H
              [0x00, 0x41, 0x7F, 0x41, 0x00],#char I
              [0x20, 0x40, 0x41, 0x3F, 0x01],#char J
              [0x7F, 0x08, 0x14, 0x22, 0x41],#char K
              [0x7F, 0x40, 0x40, 0x40, 0x40],#char L
              [0x7F, 0x02, 0x0C, 0x02, 0x7F],#char M
              [0x7F, 0x04, 0x08, 0x10, 0x7F],#char N
              [0x3E, 0x41, 0x41, 0x41, 0x3E],#char O
              [0x7F, 0x09, 0x09, 0x09, 0x06],#char P
              [0x3E, 0x41, 0x51, 0x21, 0x5E],#char Q
              [0x7F, 0x09, 0x19, 0x29, 0x46],#char R
              [0x26, 0x49, 0x49, 0x49, 0x32],#char S
              [0x01, 0x01, 0x7F, 0x01, 0x01],#char T
              [0x3F, 0x40, 0x40, 0x40, 0x3F],#char U
              [0x1F, 0x20, 0x40, 0x20, 0x1F],#char V
              [0x3F, 0x40, 0x38, 0x40, 0x3F],#char W
              [0x63, 0x14, 0x08, 0x14, 0x63],#char X
              [0x03, 0x04, 0x78, 0x04, 0x03],#char Y
              [0x61, 0x51, 0x49, 0x45, 0x43],#char Z
              [0x00, 0x7F, 0x41, 0x41, 0x00],#char [
              [0x02, 0x04, 0x08, 0x10, 0x20],#char BackSlash
              [0x00, 0x41, 0x41, 0x7F, 0x00],#char ]
              [0x04, 0x02, 0x01, 0x02, 0x04],#char ^
              [0x40, 0x40, 0x40, 0x40, 0x40],#char _
              [0x07, 0x0B, 0x00, 0x00, 0x00],#char `
              [0x20, 0x54, 0x54, 0x78, 0x40],#char a
              [0x7F, 0x28, 0x44, 0x44, 0x38],#char b
              [0x38, 0x44, 0x44, 0x44, 0x28],#char c
              [0x60, 0x90, 0x90, 0x50, 0xFC],#char d mod
              [0x78, 0x94, 0x94, 0x94, 0x18],#char e mod
              [0x00, 0x08, 0x7E, 0x09, 0x02],#char f
              [0x18, 0xA4, 0xA4, 0x9C, 0x78],#char g
              [0x7F, 0x08, 0x04, 0x04, 0x78],#char h
              [0x00, 0x44, 0x7D, 0x40, 0x00],#char i
              [0x20, 0x40, 0x40, 0x3D, 0x00],#char j
              [0x7F, 0x10, 0x28, 0x44, 0x00],#char k
              [0x00, 0x41, 0x7F, 0x40, 0x00],#char l
              [0x7C, 0x04, 0x78, 0x04, 0x78],#char m
              [0x7C, 0x08, 0x04, 0x04, 0x78],#char n
              [0x38, 0x44, 0x44, 0x44, 0x38],#char o
              [0xFC, 0x18, 0x24, 0x24, 0x18],#char p
              [0x18, 0x24, 0x24, 0x18, 0xFC],#char q
              [0x7C, 0x08, 0x04, 0x04, 0x08],#char r
              [0x48, 0x54, 0x54, 0x54, 0x24],#char s
              [0x04, 0x04, 0x3F, 0x44, 0x24],#char t
              [0x3C, 0x40, 0x40, 0x20, 0x7C],#char u
              [0x1C, 0x60, 0x80, 0x60, 0x1C],#char v mod
              [0x3C, 0x40, 0x30, 0x40, 0x3C],#char w
              [0x44, 0x28, 0x10, 0x28, 0x44],#char x
              [0x4C, 0x90, 0x90, 0x90, 0x7C],#char y
              [0x44, 0x64, 0x54, 0x4C, 0x44],#char z
              [0x00, 0x08, 0x36, 0x41, 0x00],#char {
              [0x00, 0x00, 0x77, 0x00, 0x00],#char |
              [0x00, 0x41, 0x36, 0x08, 0x00],#char }
              [0x04, 0x02, 0x04, 0x08, 0x04],#char ~
              [0x00, 0x7F, 0x41, 0x7F, 0x00] #char 
              ])

proc initChar*(charType="std"): CharDisp =
  var ct: array[0..95, array[0..4, int]]
  case charType
  of "std":
    ct = std
  of "test":
    ct = test
  var tempArray: array[0..95, array[0..4, byte]]
  for j in 0..<len(ct):
    #echo j
    for k in 0..<len(ct[j]):
      #echo k
      tempArray[j][k] = byte(ct[j][k])
  result = CharDisp(byteChar:tempArray, xSize:5, ySize:8)
    
when isMainModule:
  echo "Elementi in fontTest: ", len(std)-1
