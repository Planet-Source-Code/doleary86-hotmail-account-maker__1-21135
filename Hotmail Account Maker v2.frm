VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form Form1 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Hotmail Account Maker v2"
   ClientHeight    =   1455
   ClientLeft      =   45
   ClientTop       =   300
   ClientWidth     =   4095
   BeginProperty Font 
      Name            =   "Arial Narrow"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Hotmail Account Maker v2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1455
   ScaleWidth      =   4095
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text3 
      Height          =   2970
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   6
      Top             =   1560
      Width           =   2895
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Create Hotmail Account"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   840
      Width           =   3855
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1200
      TabIndex        =   3
      Top             =   480
      Width           =   2775
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1200
      TabIndex        =   2
      Top             =   120
      Width           =   2775
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   2520
      Top             =   2760
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Idle"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1200
      Width           =   3855
   End
   Begin VB.Line Line1 
      BorderStyle     =   5  'Dash-Dot-Dot
      X1              =   120
      X2              =   3960
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Label Label2 
      Caption         =   "Password -"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Sign-In Name -"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1095
   End
   Begin VB.Shape Shape1 
      Height          =   1455
      Left            =   0
      Top             =   0
      Width           =   4095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hwndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal Cx As Long, ByVal Cy As Long, ByVal wflags As Long) As Long

Private Const HWND_TOPMOST = -1
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOSIZE = &H1
Private Const flags = SWP_NOMOVE Or SWP_NOSIZE

Public Sub FormOnTop(frm As Form)
Call SetWindowPos(frm.hwnd, HWND_TOPMOST, 0&, 0&, 0&, 0&, flags)
End Sub

Private Sub Command1_Click()
' Created by : Pro
' This code might be hard to follow, if you have
' any questions, email me at:
' todaysforecast@yahoo.com
' --------
' If you have any problems with the code please
' email, or if you fix anything, or add anything
' email me a new copy of the source, thanks!
' --------
' Here is a list of what the objects represent:
'
' Text1 is the Sign-In name
' Text2 is the Password
' Text3 is where the inet1.ocx opens the url's source
' Command1 is the 'Create Hotmail Account' button
' Label3 is the Status label

Text3 = "" ' clears the url source window
Label3 = "Creating " + Text1 + " - " + Text2 ' sets the status labels caption
theurl$ = "http://lc2.law13.hotmail.passport.com/cgi-bin/register_ssl/EN?id=2&ct=982536982&xfname=its&xlname=me&LanguageCode=&xlanguage=EN&CountryCode=&xcountry=US&Change_x=''>""""&xgeoid=14808&xzip=60655&xtz=America/New_York&xgender=male&month=5&day=22&xage=1967&xoccupation=G&reglogin=" + Text1 + "&passwd=" + Text2 + "&passwd1=" + Text2 + "&hintq=wtf am i&hinta=pro2k&memberdir=None&LinkAddrChoice=n&HTS=&SID=&us=&errmsg1=0&path=&js=no&nsframe=&submitType=no&id=2&ct=982536995" ' sets the url information
Call Inet1.OpenURL("http://lc2.law13.hotmail.passport.com/cgi-bin/logout?curmbox=F000000001&a=641a7b4c1596fe7e78ac312a242915f1&t=982540076&loru=&id=2&ct=982540076") ' opens url to logout of hotmail and passport
Text3 = Inet1.OpenURL(theurl$) ' makes the hotmail account
If InStr(Text3, "Registration Error") Then GoTo alreadymade ' if its already made, goto aaa1
If InStr(Text3, "Congratulations") Then GoTo justmade ' if it was made successfully
If InStr(Text3, "eight (8) characters long") Then GoTo pwtoshort ' if the password is less than 8 characters
alreadymade:
Label3 = "[" + Text1 + "] is already taken!" ' set status caption
Text3 = "" ' reset url source
Inet1.Cancel ' close url
Exit Sub ' exit current sub
justmade:
Label3 = "[" + Text1 + "] - [" + Text2 + "] has been created!" ' set status caption
Text3 = "" ' reset url source
Clipboard.Clear ' clear clipboard data
Clipboard.SetText "Hotmail Info: [Login] " + Text1 + " - [Password] " + Text2 ' set clipbaord data
Inet1.Cancel ' close url
Exit Sub ' exit current sub
pwtoshort:
Label3 = "Error! Make sure password is 8 char or more!" ' set status caption
Text3 = "" ' reset url source
Inet1.Cancel ' close url
Exit Sub ' exit current sub
End Sub

Private Sub Form_Load()
Call FormOnTop(Me) ' sets form ontop
End Sub
