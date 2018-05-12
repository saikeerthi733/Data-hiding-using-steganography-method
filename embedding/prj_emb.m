function varargout = prj_emb(varargin)
% PRJ_EMB M-file for prj_emb.fig
%      PRJ_EMB, by itself, creates a new PRJ_EMB or raises the existing
%      singleton*.
%
%      H = PRJ_EMB returns the handle to a new PRJ_EMB or the handle to
%      the existing singleton*.
%
%      PRJ_EMB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRJ_EMB.M with the given input arguments.
%
%      PRJ_EMB('Property','Value',...) creates a new PRJ_EMB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prj_emb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prj_emb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prj_emb

% Last Modified by GUIDE v2.5 22-Nov-2013 15:41:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prj_emb_OpeningFcn, ...
                   'gui_OutputFcn',  @prj_emb_OutputFcn, ...
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


% --- Executes just before prj_emb is made visible.
function prj_emb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prj_emb (see VARARGIN)

% Choose default command line output for prj_emb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prj_emb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prj_emb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)


keygener=zeros(8,8);
key=[0 0 1 0 ;0 0 1 1 ;0 1 0 1; 0 1 1 1; 1 0 0 0; 1 0 1 0; 1 1 0 1; 1 0 1 1];
key1=[0 0 1 0 0 0 1 0 ;0 0 1 1 0 0 1 1 ;0 1 0 1 0 1 0 1; 0 1 1 1 0 1 1 1];
keygener(1:8,5:8)=key;
keygener(5:8,1:8)=key1;
orig_key=keygener;
handles.orig_key=orig_key;
guidata(hObject, handles);
helpdlg('Secret key generated');




% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

Y=handles.Y;
orig_key=handles.orig_key;
[file path]=uigetfile('*.txt','choose txt file');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    data1=fopen(file,'r');
    F=fread(data1);
    fclose(data1);
end
len=length(F);
count=1;
totalbits=8*len;
a=128;
k=1;
[r c]=size(Y);
for i=1:8:r-7;
    for j=1:8:c-7;
        block3=Y(i:i+7,j:j+7);
        for ii=1:8
            for jj=1:8;
                if orig_key(ii,jj)==1;
                    coeff=abs(block3(ii,jj));
                    [ block3(ii,jj),a,k,count]=bitlength(coeff,a,k,F,totalbits,count,len);
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
        Y(i:i+7,j:j+7)=block3;
        Y=abs(Y);
        if count>totalbits;
            break;
        end
    end
    if count>totalbits;
        break;
    end
end
outpu_t=Y;
handles.outpu_t=outpu_t;
handles.totalbits=totalbits;
guidata(hObject, handles);
helpdlg('Process completed');









% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)



guidata(hObject, handles);
Z=handles.Z;
outpu_t=handles.outpu_t;
totalbits=handles.totalbits;

embededimage=outpu_t;
%embededimage=handles.embededimage;
[r c]=size(embededimage);
m=1;
n=1;
for i=1:8:r-7;
    for j=1:8:c-7;
        bloc_k11=embededimage(i:i+7,j:j+7);
        LL=bloc_k11(m:m+3,n:n+3);
        LH=bloc_k11(m:m+3,n+4:n+7);
        HL=bloc_k11(m+4:m+7,n:n+3);
        HH=bloc_k11(m+4:m+7,n+4:n+7);
        Z(i:i+7,j:j+7)=reversedwt(LL,LH,HL,HH);
        out=Z;
    end
end


axes(handles.axes2);
imshow(out,[]);
save out;
handles.out=out;
guidata(hObject, handles);
helpdlg('Inverse Transformation completed');
helpdlg('Output Image is obtained');






% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

[file,path] = uigetfile('*.png;*.bmp;*.jpg','Pick an Image File');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    Z = imread(file);
    Z=imresize(Z,[256 256]);
[r c p]=size(Z);
if p==3
    axes(handles.axes1);
    imshow(Z);
    r=Z(:,:,1);
    g=Z(:,:,2);
    b=Z(:,:,3);
    handles.b=b;
    handles.Z=Z;
    F=Z;
    handles.F=F;
    guidata(hObject, handles);
    helpdlg('input image is selected');
else
 warndlg('please select colour image');
end
end




% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

guidata(hObject, handles);
minvalue=15;
maxvalue=240;
b=handles.b;
[r c]=size(b);
for i=1:r;
    for j=1:c;
        if b(i,j)<=minvalue;
            b(i,j)=minvalue;
        elseif b(i,j)>=maxvalue;
            b(i,j)=maxvalue;
        end
    end
end
histmod=b;
figure(11);
imshow(histmod);
handles.histmod=histmod;
guidata(hObject, handles);
helpdlg('histogram modification done');







% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

%%%%%%%%%%dividing the image into 8x8 block and IWT%%%%%%

histmod=handles.histmod;
[r c]=size(histmod);
for i=1:8:r-7;
    for j=1:8:c-7;
        bloc_k=histmod(i:i+7,j:j+7);
        Y(i:i+7,j:j+7)=forward_lift(bloc_k);
    end
end
axes(handles.axes2);
imshow(Y,[]);
handles.Y=Y;
guidata(hObject, handles);
helpdlg('Transformation completed');




% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

 guidata(hObject, handles);
 Z=handles.Z;
 %Z=Z(:,:,3);
 out=handles.out;
 [r c]=size(out);
 
MSE = sqrt(sum(sum((Z - out).^2))/(r * c));
set(handles.text2,'string',MSE);
%%%%%%%%%%%%%%%%%%PSNR%%%%%%%%%%%
 PSNR = 10*log(255*MSE) / log(10);
set(handles.text3,'string',PSNR);







% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)

a=ones([500 500]);
axes(handles.axes1);
imshow(a);

axes(handles.axes2);
imshow(a);

set(handles.text2,'string','');
set(handles.text3,'string','');

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
