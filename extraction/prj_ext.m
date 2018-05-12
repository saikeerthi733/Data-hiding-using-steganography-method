function varargout = prj_ext(varargin)
% PRJ_EXT M-file for prj_ext.fig
%      PRJ_EXT, by itself, creates a new PRJ_EXT or raises the existing
%      singleton*.
%
%      H = PRJ_EXT returns the handle to a new PRJ_EXT or the handle to
%      the existing singleton*.
%
%      PRJ_EXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRJ_EXT.M with the given input arguments.
%
%      PRJ_EXT('Property','Value',...) creates a new PRJ_EXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prj_ext_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prj_ext_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prj_ext

% Last Modified by GUIDE v2.5 08-Nov-2013 15:24:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prj_ext_OpeningFcn, ...
                   'gui_OutputFcn',  @prj_ext_OutputFcn, ...
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


% --- Executes just before prj_ext is made visible.
function prj_ext_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prj_ext (see VARARGIN)

% Choose default command line output for prj_ext
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prj_ext wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prj_ext_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

load out
%     [filename, pathname] = uigetfile('*.mat', 'Pick an M-file');
%     if isequal(filename,0) || isequal(pathname,0)
%        disp('User pressed cancel')
%     else
%         
%     end
imshow(out,[]);



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)



load out
extractinpu_t=Z;
[r c]=size(extractinpu_t);
for i=1:8:r-7;
    for j=1:8:c-7;
        bloc_kextract=extractinpu_t(i:i+7,j:j+7);
        YY(i:i+7,j:j+7)=forward_lift(bloc_kextract);
    end
end
save YY
helpdlg('Transformation completed');




% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

load YY
totalbits=handles.totalbits;
orig_key=handles.orig_key;
fil_e=YY;
% totalbits=8*len;
a=128;
jjj=1;
count=1;
k=0;
[r c]=size(YY);
for i=1:8:r-7;
    for j=1:8:c-7;
        block9=fil_e(i:i+7,j:j+7);
        for ii=1:8
            for jj=1:8;
                if orig_key(ii,jj)==1;
                    coeff=abs(block9(ii,jj));
                    %[ k,a,count,jjj,ff]=extrac_t(coeff,a,k,jjj,totalbits,count);
                    g=coeff;
                    if g>=64;
                        bits=6;

                        h=32;
                    elseif g<64 & g>=32;
                        bits=5;

                        h=16;
                    elseif g<32 & g>=16;
                        bits=4;

                        h=8;
                    elseif g<16
                        bits=3;
                        h=4;
                    end
                    l=bits;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    for iii=1:l;
                        if bitand(g,h)==h;
                            k= bitor(k,a);
                        end
                        count=count+1;
                        a=a/2;
                        h=h/2;
                        if a<1;
                            R(jjj)=k;
                            fid=fopen('output.txt','wb');
                            fwrite(fid,char(R),'char');
                            fclose(fid);jjj=jjj+1;
                            k=0;
                            a=128;
                        end
                        if count>totalbits;
                            break;
                        end
                    end
                    if count>totalbits;
                        break;
                    end
                end
                if count>totalbits;
                    break;
                end
            end
            if count>totalbits;
                break;
            end
        end
        if count>totalbits;
            break;
        end
    end
    if count>totalbits;
        break;
    end
end
helpdlg('Secret data was obtained in text file');




% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)


open('output.txt');



% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
