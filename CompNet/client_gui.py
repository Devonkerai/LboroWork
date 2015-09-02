#-------------------------------client_gui.py-----------------------------#
#-------------------------------------------------------------------------#
#-----------------Computer Networks Coursework - 14ELC004-----------------#
#-------------------------------April 2015--------------------------------#
#-------------------------------Devon Kerai-------------------------------#
#-------------------------------James Moore-------------------------------#
#------------------------------James O'Neill------------------------------#
#------------------------------Mathew Baxter------------------------------#
#-------------------------------------------------------------------------#
#----This code has been built upon from the original source provided by---#
#----by Dr Y Gong---------------------------------------------------------#
#----This code is to be used in conjunction with server_gui.py------------#
#-------------------------------------------------------------------------#
from Tkinter import *
from socket import *
from sys import *
import struct, time, threading, Queue

Info1 = 'Input the user name and port you want to use in chat room.'
Info2 = 'Name length should at least one letter and no more than 16 letters.'
Info3 = 'Port number should be integar and over 2000'
Info3_1 = 'Port number should be integar'
Info4 = 'Not valid IPv4 address format. Example 192.168.2.1'

def pkg(Type, IPaddr, port, ID=""):
    """
    Package the clients (IP, Port):ID information in string for 
    transmit. 'Type' indicates the purpose of the package: 
    'R'(Requesting Information Package)
    'K'(Off-line Information Package)
    """
    if not ID:
        info = Type+':'+IPaddr + ':' + str(port)
    else:
        info = Type+':'+IPaddr + ':' + str(port) + ':' + ID
    return info
    
def dpkg(info):
    """
    De-package the packed received string to (IP, Port):ID format. 
    """
    n = info.split(':')
    if len(n)==4:
        return (n[0], n[1], int(n[2]), n[3])
    else:
        return (n[0], n[1], int(n[2]))


#---------------------------------------------------#
#----------------Quest GUI Window ------------------#
#---------------------------------------------------#

class Quest_GUI_Win(Tk):
    """ 
    Creating the Quest GUi window where asking client to input username
    and port number they want to use for communicate. It also request client
    to input the server IP address for accessing the latest client list
    """
    def __init__(self):
        
        Tk.__init__(self)
        self.title('Quest')
        questWindow = Frame(self)
        questWindow.grid()
        info1_lbl = Label(questWindow, text=Info1)
        info2_lbl = Label(questWindow, text=Info2)
        info3_lbl = Label(questWindow, text=Info3)
        user_lbl = Label(questWindow, text='user name')
        self.user_ent = Entry(questWindow)
        self.user_ent.insert(0, "")
        port_lbl = Label(questWindow, text='UDP port')
        self.port_ent = Entry(questWindow)
        self.port_ent.insert(0, "")
        server_add_lbl = Label(questWindow, text='server IP address')
        self.server_add_ent = Entry(questWindow)
        self.server_add_ent.insert(0, "")
        confirm_bttn = Button(questWindow, text='Confirm', command=self.reveal)
        quit_bttn = Button(questWindow, text='Cancel', command=self.destroy)
        
    ##  place wedges
        info1_lbl.grid(row=0, column=0, columnspan=3, sticky=W,padx=10)
        info2_lbl.grid(row=1, column=0,columnspan=3, sticky=W,padx=10)
        info3_lbl.grid(row=2, column=0,columnspan=3, sticky=W,padx=10)
        user_lbl.grid(row=3, column=0,sticky=W,padx=10)
        self.user_ent.grid(row=4, column=0,sticky=W,padx=10)
        port_lbl.grid(row=3, column=1,sticky=W)
        self.port_ent.grid(row=4, column=1, sticky=W)
        server_add_lbl.grid(row=5, column=0,sticky=W,padx=10)
        self.server_add_ent.grid(row=6, column=0,sticky=W,padx=10)
        confirm_bttn.grid(row=7, column=0, pady=10)
        quit_bttn.grid(row=7, column=1)

    def reveal(self):
        """ 
        Check the input information follows the instruction and create the
        first connection with server. Then start server_refresh thread and 
        open the user defined UDP socket listening thread
        """
        global myID
        global myIP
        global serverIP
        global myPort
        global sock
        global server_refresh
        global re
        myID = self.user_ent.get()
        myPort = self.port_ent.get()
        serverIP = self.server_add_ent.get()
        if (len(myID)<1) or (len(myID)>18):
            showerror("Name Length Error", Info2)
        else:
            try:
                val = int(myPort)
                if val<2000: #2048 check it later?
                    showerror("Port Number Error", Info3)
                else:
                    self.destroy()
                    NewTitle = 'Chat_dic v1.0:' +' '+myID+' (' + myIP + ':' + myPort+' )'
                    chat_win = Chat_GUI_Win(NewTitle)  
                    myAddress = (myIP, int(myPort)) # myIP is a string, myAddress is a tuple.
                    sock = socket(AF_INET, SOCK_DGRAM)
                    sock.bind(myAddress)
                    connect_server(myID, myPort, serverIP, 2002, 'R','[ Succesfully connected with server]\n')
                    server_refresh=Server_Alive()
                    re =  Receiving(sock)
                    server_refresh.start()
                    re.start()
            except ValueError:
                showerror("Port Number Error", Info3)
                

#---------------------------------------------------#
#------------------ Chat Window  -------------------#
#---------------------------------------------------#            
class Chat_GUI_Win(Tk):
    """ 
    GUI for client communicate with each other. There are three main block 
    in layout: Chatlog, where show the communicate information including 
    chatting content and connection information; EntryBox, where for user to
    input the message for sending to other clients; FriList, where show the 
    on-line friends.
    """
    global multicastFlag
    multicastFlag = False

    def __init__(self,newtitle):
        global chat_Chatlog
        global chat_EntryBox
        global chat_FriList
        global chat_AddToGroupbttn
        global chat_ChatList
        
        Tk.__init__(self)
        self.title(newtitle)
        self.protocol("WM_DELETE_WINDOW", self.cls_chat_win)
        self.geometry("410x500")
        #-----Chat Window---------------- 
        chat_Chatlog = Text(self, bd=0, bg="white", height="8", width="50", font="Arial")
        #chat_Chatlog.insert(END, "Waiting for your friend to connect..\n")
        chat_Chatlog.config(state=DISABLED)

        #Bind a scrollbar to the Chat window
        chat_scrollbar = Scrollbar(self, command=chat_Chatlog.yview, cursor="heart")
        chat_Chatlog['yscrollcommand']=chat_scrollbar.set

        #Create the box to enter message
        chat_EntryBox = Text(self,bd=0, bg="white", width="29", height="5", font="Arial")
        chat_EntryBox.bind("<Return>", DisableEntry)
        chat_EntryBox.bind("<KeyRelease-Return>", PressAction)
                        
        # Create On-line Friend List
        chat_FriLIst_lbl = Label(self, font=22, text='Friend List')
        chat_FriList = Listbox(self)
        chat_FriList.bind("<Double-Button-1>", getFriendData) #On double click, run getFriendData function.

        # Create On-line Chat List
        chat_ChatList_lbl = Label(self, font=22, text='Connected To')
        chat_ChatList = Listbox(self)
        
        # Create the Button to send message
        chat_Sendbttn = Button(self, font=30, text="Send", width="12", height="5", command=ClickAction)

        # Creates buttons to add and remove yourself to a chat group
        chat_AddToGroupbttn = Button(self, font=30, text="Add to Group", width="12", height="5", command=AddToGroup)
       
        chat_Chatlog.place(x=6,y=6, height=386, width=265)
        chat_scrollbar.place(x=6,y=6, height=386, width=266)
        chat_EntryBox.place(x=6, y=401, height=90, width=265)
        chat_FriLIst_lbl.place(x=280, y=8, height=12, width=120)
        chat_FriList.place(x=280, y=22, height=120, width=120)
        chat_Sendbttn.place(x=280, y=401, height=90)

        #Locations of added GUI items.
        chat_ChatList_lbl.place(x=280, y=150, height=15, width=120)
        chat_ChatList.place(x=280, y=165, height=50, width=120)    
        chat_AddToGroupbttn.place(x=280, y=350, height=40)

    def cls_chat_win(self):
        """
        close the Chat_GUI_Win trigger function to stop the rest threads
        """
        self.destroy()
        cls_connect()
        
#---------------------------------------------------#
#----------------- KEYBOARD EVENTS -----------------#
#---------------------------------------------------#
def PressAction(event):
    global chat_EntryBox
    chat_EntryBox.config(state=NORMAL)
    ClickAction()
def DisableEntry(event):
    global chat_EntryBox
    chat_EntryBox.config(state=DISABLED)

#---------------------------------------------------#
#------------------ MOUSE EVENTS -------------------#
#---------------------------------------------------#

def ClickAction():
    """
    Send button in main chat GUI. Formats text input, clears input box,
    sends the message dependant on multicastFlag state.
    """
    global multicastFlag
    global chat_EntryBox
    EntryText = FilteredMessage(chat_EntryBox.get("0.0",END)) # Write message to chat window
    LoadMyEntry(EntryText)
    EntryText += "+%s"%myID # Adds user name of sender to friend.
    chat_EntryBox.delete("0.0",END) # Erase previous message in Entry Box

    if multicastFlag == False:
        SendMessageToFriend(EntryText)               
        # Send message to all others
    else:
        SendMulticast(EntryText)
        # Enable group chat

def getFriendData(event):
    """ 
    Gets IP and Port number when clicking name in friend list box.
    """
    global friendIpAddr, friendIpPort, friendName
    widget = event.widget
    selection = widget.curselection()
	# Checks to see if any clients online otherwise returns an error message.
    try:
        friendName = widget.get(selection[0])
    except (IndexError):
        print "There is currently no one online. :(" 
    # Format data and assign to new variables
    for i in neighbour:
        if friendName in i:
            friendIpAddr = i.split(":")[1]
            friendIpPort = i.split(":")[2]
            friendName = i.split(":")[3]
    chat_ChatList.delete(0) # Empties friend list before populating it.

    if friendName not in chat_ChatList.get(0,END):
        chat_ChatList.insert(END, friendName)

def AddToGroup():
    """
    Adds client to a group chat.
    """
	# Changes button once pressed
    chat_AddToGroupbttn.configure(text = "Rmv frm group", command = RemoveFromGroup)
    LoadMyEntry("Added to group.\n")
    chat_ChatList.delete(0) # Empties friend list before populating it.
    chat_ChatList.insert(END, "Group")

    global multicastFlag
    global mSock
    global mSockRecvThread
    multicastFlag = True

    # Setting up the multicast group
    MCAST_GRP = '224.1.1.1' # IP within multicast range
    MCAST_PORT = 5007

    mSock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
    mSock.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
    mSock.bind(('', MCAST_PORT))
    mreq = struct.pack("4sl", inet_aton(MCAST_GRP), INADDR_ANY)
    mSock.setsockopt(IPPROTO_IP, IP_ADD_MEMBERSHIP, mreq)

    mSockRecvThread = Receiving(mSock, multicastFlag)
    mSockRecvThread.start() # Starts the multicast receiving thread

def RemoveFromGroup():
    """
    Removes client from a group chat.
    """
    global mSock
    global mSockRecvThread
    global multicastFlag
    multicastFlag = False

    chat_AddToGroupbttn.configure(text = "Add to group", command = AddToGroup)
    LoadMyEntry("Left from group.\n")
    chat_ChatList.delete(0) # Empties friend list before populating it.

    # Stop all threads and closes the sockets
    mSockRecvThread.stop()
    mSock.close()
    re.stop()
    sock.close()

def SendMessageToFriend(EntryText):
    """
    Action of send button if multicast flag is false.
    Will send a message to the person who has been double clicked in the friend list.
    """
	# Takes variables from double clicking of name in the friend list.
    FRIEND_ADD = friendIpAddr
    FRIEND_PORT = int(friendIpPort)
    FRIEND_NAME = friendName
    
	# Uses python library to send message using UDP protocol.
    sock.connect((FRIEND_ADD, FRIEND_PORT)) # Connects to required client
    sock.sendto(EntryText, (FRIEND_ADD, FRIEND_PORT)) # Takes edited text and sends to client

def SendMulticast(EntryText):
    """
    Action of send button if multicast flag is true.
    Will send message (EntryText) via multicast to all in group chat
    """

    MCAST_GRP = '224.1.1.1'
    MCAST_PORT = 5007

    mSock = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
    mSock.setsockopt(IPPROTO_IP, IP_MULTICAST_TTL, 2)
    mSock.sendto(EntryText, (MCAST_GRP, MCAST_PORT)) 

#---------------------------------------------------#
#------------------ Load Entry's  -------------------#
#---------------------------------------------------#
def FilteredMessage(EntryText):
    """
    Filter out all useless white lines at the end of a string,
    returns a new, beautifully filtered string.
    """
    EndFiltered = ''
    for i in range(len(EntryText)-1,-1,-1):
        if EntryText[i]!='\n':
            EndFiltered = EntryText[0:i+1]
            break
    for i in range(0,len(EndFiltered), 1):
            if EndFiltered[i] != "\n":
                    return EndFiltered[i:]+'\n'
    return ''

def LoadconnectInfo(EntryText):
    """ 
    Load the connection information and put them on Chatlog
    """
    global chat_Chatlog
    if EntryText != '':
        chat_Chatlog.config(state=NORMAL)
        if chat_Chatlog.index('end') != None:
            chat_Chatlog.insert(END, EntryText+'\n')
            chat_Chatlog.config(state=DISABLED)
            chat_Chatlog.yview(END)

def LoadMyEntry(EntryText):
    """ 
    Load user input information and put them on Chatlog
    """
    global chat_Chatlog
    if EntryText != '':
        chat_Chatlog.config(state=NORMAL)
        if chat_Chatlog.index('end') != None:
            LineNumber = float(chat_Chatlog.index('end'))-1.0
            chat_Chatlog.insert(END, "You: " + EntryText)
            chat_Chatlog.tag_add("You", LineNumber, LineNumber+0.4)
            chat_Chatlog.tag_config("You", foreground="#FF8000", font=("Arial", 12, "bold"))
            chat_Chatlog.config(state=DISABLED)
            chat_Chatlog.yview(END)

def LoadOtherEntry(otherID, EntryText):
    """ 
    Manage the received information from others and put them on Chatlog
    """
    global chat_Chatlog
    otherID += ": "

    if EntryText != '':
        chat_Chatlog.config(state=NORMAL)
        if chat_Chatlog.index('end') != None:
            try:
                LineNumber = float(chat_Chatlog.index('end'))-1.0
            except:
                pass
            chat_Chatlog.insert(END, otherID + EntryText)
            chat_Chatlog.tag_add(otherID, LineNumber, LineNumber+0.5)
            chat_Chatlog.tag_config(otherID, foreground="#04B404", font=("Arial", 12, "bold"))
            chat_Chatlog.config(state=DISABLED)
            chat_Chatlog.yview(END)
            
#---------------------------------------------------#
#------------------ Connections  -------------------#
#---------------------------------------------------#
class Server_Alive(threading.Thread):
    """ 
    Thread keep connect with server every 30s, and receive the client_list 
    information saved on server.
    """
    def __init__(self):
        threading.Thread.__init__(self)
        self.flag= True
        self.Type= 'R'

    def run(self):
        global myID
        global myPort
        global serverIP
        global serverPort

        while self.flag:
            time.sleep(5)
            connect_server(myID, myPort, serverIP, serverPort, self.Type)

    def stop(self):
        self.flag = False
        self.Type = 'K'
        self._Thread__stop()

class Receiving(threading.Thread):
    """ 
    Thread keep watching the user defined UDP socket and receiving the messages
    from other clients. 
    """
    def __init__(self, sock, multicastFlag=False):
        threading.Thread.__init__(self)
        self.sock = sock
        self.flag = True
        self.multicastFlag = multicastFlag

    def run(self):        
        while self.flag:
            while self.multicastFlag:
                msg, addr = self.sock.recvfrom(1024)
                cliname = msg.split('+')[1]
                msg = msg.split('+')[0]
                self.ShowMessages(msg, cliname)
            
            msg, addr = self.sock.recvfrom(1024)
            # 'msg' contains other data, need to split it accordingly
            cliname = msg.split('+')[1] 
            msg = msg.split('+')[0]
            self.ShowMessages(msg, cliname)
            
    def stop(self):
        self.flag = False
        self._Thread__stop()
            
    def ShowMessages(self, msg, cliname):
        """ 
        Show the received message from other clients in the chat log.
        """
        otherID = cliname + ": " # Format user name
        nameLen = len(otherID) # Calculates length of name
        deciNameLen = float("0." + str(nameLen)) # Counts letters and then colours the user name
        global chat_Chatlog
		
        if msg != '': # Don't display an empty message.
            chat_Chatlog.config(state=NORMAL)
            if chat_Chatlog.index('end') != None:
                try:
                    LineNumber = float(chat_Chatlog.index('end'))-1.0
                except:
                    pass
                if cliname != myID: # Checks to see if you've received your own message
                    chat_Chatlog.insert(END, otherID + msg) # Insert the message and user name into the GUI
                    chat_Chatlog.tag_add(otherID, LineNumber, LineNumber + deciNameLen) # Makes everything up to the colon in bold.
                    chat_Chatlog.tag_config(otherID, foreground="#04B404", font=("Arial", 12, "bold"))
                    chat_Chatlog.config(state=DISABLED)
                    chat_Chatlog.yview(END)
                else:
                    pass

def connect_server(myID, myPort, SERVER_ADD, SERVER_PORT, Type, Info=''):
    """ 
    Configure the server. If Type is Requesting('R'), then receive the 
    client_list transmitted from server. If Type is Offline('K'), then
    close down without expecting receive anything from server
    """
    global neighbour
    s = socket(AF_INET, SOCK_STREAM)
    s.connect((SERVER_ADD, SERVER_PORT))
    LoadconnectInfo(Info)
    s.send(pkg(Type, myIP, myPort, myID))

    if Type == 'R':
        data = s.recv(1024)
        server_recv=data

        if data:
            if data.split('-')[0] == 'Null':
                print 'no neighbours right now'

            else:
                count = 0
                while (count < int(data.split('-')[0])):
                    info = s.recv(1024)
                    server_recv += info
                    count += 1
                    
                neighbour = server_recv.split('-')
                refresh_friend_box(neighbour)
                count = 0
                while (count < int(neighbour[0])):
                    IP_addr = neighbour[count+1].split(':')
                    if (myIP, int(myPort)) != (IP_addr[1],int(IP_addr[2])):
                        neighbour_list.append((IP_addr[1],int(IP_addr[2])))
                    count += 1
    s.close()

def refresh_friend_box(neighbour):
    """ 
    Refreshes the friend list to show who's connected to the server.
    """
    chat_FriList.delete(0) # Empties friend list before populating it.
	# Cycle through neighbour list from server
    for i in neighbour:
        if i[0] == "R": # R represents online
            ipadd = i[2:]
            clientName = ipadd.split(":")[2] # Split neighbour and assign client's name to a variable.
			# If your own name is in the list ignore it, otherwise populate the friend list.
            if clientName not in chat_FriList.get(0,END):
                if clientName != myID: 
                    chat_FriList.insert(END, clientName)

def client_offline():
    """ 
    Send the off-line information to server
    """
    global myID
    global myPort
    global serverIP
    global serverPort
    connect_server(myID, myPort, serverIP, serverPort,  'K')

def cls_connect():
    """ 
    Close all the threads and socket 
    """
    server_refresh.stop()
    client_offline()
    re.stop()
    mSockRecvThread.stop()
    sock.close()
    mSock.close()

myID=''
myIP = gethostbyname(gethostname())
myPort=''
chat_Chatlog=''
chat_EntryBox=''
serverIP=''
serverPort=2002
neighbour_list = [] #[(IP,Port),(IP,Port)]
sock=''
server_refresh=''
re=''

app = Quest_GUI_Win()
app.mainloop()
