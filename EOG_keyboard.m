function varargout = EOG_keyboard(varargin)
% EOG_KEYBOARD MATLAB code for EOG_keyboard.fig
%      EOG_KEYBOARD, by itself, creates a new EOG_KEYBOARD or raises the existing
%      singleton*.
%
%      H = EOG_KEYBOARD returns the handle to a new EOG_KEYBOARD or the handle to
%      the existing singleton*.
%
%      EOG_KEYBOARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EOG_KEYBOARD.M with the given input arguments.
%
%      EOG_KEYBOARD('Property','Value',...) creates a new EOG_KEYBOARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EOG_keyboard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EOG_keyboard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EOG_keyboard

% Last Modified by GUIDE v2.5 12-Apr-2019 13:03:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EOG_keyboard_OpeningFcn, ...
                   'gui_OutputFcn',  @EOG_keyboard_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before EOG_keyboard is made visible.
function EOG_keyboard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EOG_keyboard (see VARARGIN)

% Choose default command line output for EOG_keyboard
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EOG_keyboard wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EOG_keyboard_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in start.
% function start_Callback(hObject, eventdata, handles)
% % hObject    handle to start (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% set(hObject, 'UserData', false);
% realtimefunction(handles);
% 
% 
% % --- Executes on button press in stop.
% function stop_Callback(hObject, eventdata, handles)
% % hObject    handle to stop (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% set(handles.start, 'UserData', true);
% 
% function realtimefunction(handles)
%Reading the voltages
a = arduino();
n=1;
H = 0;
V = 0;
r=0;
c=0;
flag=0;
temp=0;
change=1;
str = ' ';
while(n>0)
    
    H = readVoltage(a,'A3');
    V = readVoltage(a,'A2');
    S = [V H];
    disp(S);
    
    %Classification
    %For selecting the row
    if(flag==0)
        if(H<0.9)
                disp("Left detected");
                set(handles.left,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.left,'BackgroundColor',[1 0 0]);
                r = 2;
                temp=1;
        
        elseif(H>2.5)
                disp("Right detected");
                set(handles.right,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.right,'BackgroundColor',[1 0 0]);
                r = 4;
                temp=1;
            
        
    
        elseif(V<0.5)
                disp("Down detected");
                set(handles.down,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.down,'BackgroundColor',[1 0 0]);
                r = 3;
                temp=1;
            
        
        elseif(V<1 && V>0.8)
                    pause(0.03);
                    V = readVoltage(a,'A2');
                    if(V>1)
                            disp("Inv blink detected");
                    else
                            disp("Up detected");
                            set(handles.up,'BackgroundColor',[0 1 0]);
                            pause(1);
                            set(handles.up,'BackgroundColor',[1 0 0]);
                            r = 1;
                            temp=1;
                    
                    end 
        end  
        
    %For selecting the column
    elseif(flag==1)
        
         if(H<0.9)
                disp("Left detected");
                set(handles.left,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.left,'BackgroundColor',[1 0 0]);
                c = 2;
                temp=0;
            
        
        elseif(H>2.5)
                disp("Right detected");
                set(handles.right,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.right,'BackgroundColor',[1 0 0]);
                c = 4;
                temp=0;
            
        
    
        elseif(V<0.5)
                disp("Down detected");
                set(handles.down,'BackgroundColor',[0 1 0]);
                pause(1);
                set(handles.down,'BackgroundColor',[1 0 0]);
                c = 3;
                temp=0;
            
        
        elseif(V<1 && V>0.8)
                pause(0.03);
                V = readVoltage(a,'A2');
                if(V>1)
                    disp("Inv blink detected");
                else
                    disp("Up detected");
                    set(handles.up,'BackgroundColor',[0 1 0]);
                    pause(1);
                    set(handles.up,'BackgroundColor',[1 0 0]);
                    c = 1;
                    temp=0;
                    
                end
        end
    end
    
    if(change==1)
        set(handles.text79,'BackgroundColor',[0 0 1]);
        set(handles.text80,'BackgroundColor',[0.94 0.94 0.94]);
        set(handles.text81,'BackgroundColor',[0.94 0.94 0.94]);
        pause(0.1)
        if(r==1)
                if(c==1)
                        str = strcat(str,'E');
                        set(handles.text51,'BackgroundColor',[0 1 0]);
                        pause(0.2);
                        set(handles.text51,'BackgroundColor',[0.94 0.94 0.94]);
                        set(handles.display,'String',str);
                        pause(0.1);
                        r=0;
                        c=0;
                elseif(c==2)
                        str = strcat(str,'A');
                        set(handles.text53,'BackgroundColor',[0 1 0]);
                        pause(0.2);
                        set(handles.text53,'BackgroundColor',[0.94 0.94 0.94]);
                        set(handles.display,'String',str);
                        pause(0.1);
                        r=0;
                        c=0;
                        
                elseif(c==3)
                        str = strcat(str,'R');
                        set( handles.text54,'BackgroundColor',[0 1 0]);
                        pause(0.2);
                        set(handles.text54,'BackgroundColor',[0.94 0.94 0.94]);
                        set(handles.display,'String',str);
                        pause(0.1);
                        r=0;    
                        c=0;
                elseif(c==4)
                        str = strcat(str,'I');
                        set( handles.text55,'BackgroundColor',[0 1 0]);
                        pause(0.2);
                        set(handles.text55,'BackgroundColor',[0.94 0.94 0.94]);
                        set(handles.display,'String',str);
                        pause(0.1);
                        r=0;
                        c=0;
                end
       
    
    elseif(r==2)
        if(c==1)
            str = strcat(str,'O');
            set( handles.text56,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text56,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'T');
            set( handles.text57,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text57,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'N');
            set( handles.text58,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text58,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'S');
            set( handles.text59,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text59,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
    
    
    elseif(r==3)
        if(c==1)
            str = strcat(str,'L');
            set( handles.text52,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text52,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'C');
            set( handles.text60,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text60,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'U');
            set( handles.text61,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text61,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'D');
            set( handles.text62,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text62,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
   
    
    elseif(r==4)
        if(c==2)
            %Clear
            str = str(1:end-1);
            set( handles.text70,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text70,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==1)
            %Space
            str = strcat(str,'_');
            set( handles.text65,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text65,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            %Change to panel 2
            change=2;
            set( handles.text64,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text64,'BackgroundColor',[0.94 0.94 0.94]);
            
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            %Change to panel 3
            change=3;
            set( handles.text63,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text63,'BackgroundColor',[0.94 0.94 0.94]);
            
            pause(0.1);
            r=0;
            c=0;
        end
        end
  %For the second panel
  elseif(change==2)
      set(handles.text81,'BackgroundColor',[0 0 1]);
      set(handles.text80,'BackgroundColor',[0.94 0.94 0.94]);
      set(handles.text79,'BackgroundColor',[0.94 0.94 0.94]);
      pause(0.1)
      if(r==1)
            if(c==1)
                str = strcat(str,'P');
                set( handles.text42,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text42,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            elseif(c==2)
                str = strcat(str,'M');
                set( handles.text28,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text28,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            elseif(c==3)
                str = strcat(str,'H');
                set( handles.text29,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text29,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;    
                c=0;
            elseif(c==4)
                str = strcat(str,'G');
                set( handles.text30,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text30,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            end
       
    
    elseif(r==2)
        if(c==1)
            str = strcat(str,'B');
            set( handles.text31,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text31,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'F');
            set( handles.text32,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text32,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'Y');
            set( handles.text33,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text33,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'W');
            set( handles.text34,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text34,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
    
    
    elseif(r==3)
        if(c==1)
            str = strcat(str,'K');
            set( handles.text27,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text27,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'V');
            set( handles.text35,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text35,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'X');
            set( handles.text36,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text36,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'Z');
            set( handles.text37,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text37,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
   
    
    elseif(r==4)
        if(c==2)
            %Clear
            str = str(1:end-1);
            set( handles.text41,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text41,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==1)
            %Space
            str = strcat(str,'_');
            set( handles.text40,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text40,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            %Change to panel 1
            change=1;
            set( handles.text39,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text39,'BackgroundColor',[0.94 0.94 0.94]);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            %Change to panel 3
            change=3;
            set( handles.text38,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text38,'BackgroundColor',[0.94 0.94 0.94]);
            pause(0.1);
            r=0;
            c=0;
        end
      end
 
  %For the third panel
  elseif(change==3)
      set(handles.text80,'BackgroundColor',[0 0 1]);
      set(handles.text79,'BackgroundColor',[0.94 0.94 0.94]);
      set(handles.text81,'BackgroundColor',[0.94 0.94 0.94]);
      pause(0.1)
       if(r==1)
            if(c==1)
                str = strcat(str,'J');
                set( handles.text3,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text3,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            elseif(c==2)
                str = strcat(str,'Q');
                set( handles.text5,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text5,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            elseif(c==3)
                str = strcat(str,'0');
                set( handles.text6,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text6,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;    
                c=0;
            elseif(c==4)
                str = strcat(str,'1');
                set( handles.text7,'BackgroundColor',[0 1 0]);
                pause(0.2);
                set(handles.text7,'BackgroundColor',[0.94 0.94 0.94]);
                set(handles.display,'String',str);
                pause(0.1);
                r=0;
                c=0;
            end
       
    
    elseif(r==2)
        if(c==1)
            str = strcat(str,'2');
            set( handles.text8,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text8,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'3');
            set( handles.text9,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text9,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'4');
            set( handles.text10,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text10,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'5');
            set( handles.text11,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text11,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
    
    
    elseif(r==3)
        if(c==1)
            str = strcat(str,'6');
            set( handles.text4,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text4,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==2)
            str = strcat(str,'7');
            set( handles.text12,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text12,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            str = strcat(str,'8');
            set( handles.text13,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text13,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            str = strcat(str,'9');
            set( handles.text14,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text14,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        end
   
    
    elseif(r==4)
        if(c==2)
            %Clear
            str = str(1:end-1);
            set( handles.text18,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text18,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==1)
            %Space
            str = strcat(str,'_');
            set( handles.text17,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text17,'BackgroundColor',[0.94 0.94 0.94]);
            set(handles.display,'String',str);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==3)
            %Change to panel 1
            change=1;
            set( handles.text16,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text16,'BackgroundColor',[0.94 0.94 0.94]);
            pause(0.1);
            r=0;
            c=0;
        elseif(c==4)
            %Change to panel 2
            change=2;
            set( handles.text15,'BackgroundColor',[0 1 0]);
            pause(0.2);
            set(handles.text15,'BackgroundColor',[0.94 0.94 0.94]);
            pause(0.1);
            r=0;
            c=0;
        end
       end
    end
    flag=temp;
%     need_to_stop = get(handles.start, 'UserData');
%      if (~isempty(need_to_stop) && need_to_stop)
%        break;
%      end
end
    
