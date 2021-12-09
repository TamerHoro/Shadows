function varargout = Shade3D(varargin)
% SHADE3D MATLAB code for Shade3D.fig
%      SHADE3D, by itself, creates a new SHADE3D or raises the existing
%      singleton*.
%
%      H = SHADE3D returns the handle to a new SHADE3D or the handle to
%      the existing singleton*.
%
%      SHADE3D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHADE3D.M with the given input arguments.
%
%      SHADE3D('Property','Value',...) creates a new SHADE3D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Shade3D_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Shade3D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Shade3D

% Last Modified by GUIDE v2.5 29-Oct-2020 22:00:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Shade3D_OpeningFcn, ...
                   'gui_OutputFcn',  @Shade3D_OutputFcn, ...
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


% --- Executes just before Shade3D is made visible.
function Shade3D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Shade3D (see VARARGIN)

% Choose default command line output for Shade3D
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Shade3D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Shade3D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editFileName_Callback(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFileName as text
%        str2double(get(hObject,'String')) returns contents of editFileName as a double

fileName = get(hObject, 'string');

set(handles.NewFile, 'string',fileName);

% --- Executes during object creation, after setting all properties.
function editFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectFilename.
function SelectFilename_Callback(hObject, eventdata, handles)
% hObject    handle to SelectFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%EINLESEN UND VERARBEITEN DER OBJEKT DATEI ZUM ARRAY 

file = uigetfile('*.txt');
set(handles.NewFile, 'string',file);
set(handles.editFileName,'string',file);
[A,delimiterOut]=importdata(file);
[x,y,z]=ToVector(A);
[x,y,z]=Align_Object(x,y,z,4);
A=ToMatrix(x,y,z);
handles.A = A;
guidata(hObject,handles);


%ZEICHNEN UND ANZEIGEN DES OBJEKTES

% AxesA = alphaShape(A);
axes(handles.axes_Schatten)

[x_Max y_Min y_Max z_Min z_Max] = Skale_Axes(max(x),min(y),max(y), min(z),max(z))
% plot(AxesA)
% hold on
% xlabel('x-axis')
% ylabel('y-axis')
% zlabel('z-axis')
% xlim([0 x_Max])
% ylim([y_Min y_Max])
% zlim([z_Min z_Max])
grid on 
 plot3(A(:,1),A(:,2),A(:,3),'o')
% hold off
set(handles.axes_Schatten,'visible','on');


%PARAMETER FESTLEGEN FÜR DAS DREHEN DER ZEICHNUNG 

Diff_slider_V = 0
handles.Diff_slider_V = Diff_slider_V
guidata(hObject,handles);

Diff_slider_H = 0
handles.Diff_slider_H = Diff_slider_H
guidata(hObject,handles);

handles.val =0
guidata(hObject,handles);

handles.val_H = 0
guidata(hObject,handles);

% --- Executes on button press in pbProcess.
function pbProcess_Callback(hObject, eventdata, handles)
% hObject    handle to pbProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

textW = get(handles.editWinkelGr,'string');


% FEHELER ABFRAGE:
%    DATEIEN NOCH NICHT EINGELESEN
%    KEINE EINGABE GEMACHT  

if (get(handles.axes_Schatten,'visible')=='off')
    set(handles.textKW, 'visible', 'on')    
end;

if and((get(handles.NewFile,'visible')=='on'),(get(handles.editWinkelGr,'visible')=='off') ) 
    set(handles.textLichtWahl, 'visible', 'on') 
    set(handles.textKW, 'visible', 'off')
end;


% ANFANG DER SCHATTENBERECHNUNG 

if and ((get(handles.NewFile,'visible')=='on'),(get(handles.editWinkelGr,'visible')=='on') )   
    set(handles.textLichtWahl, 'visible', 'off')
    set(handles.textKW, 'visible', 'off')
    w= str2num(textW)*(pi/180);
    A=handles.A;
    [x,y,z] =ToVector(A);
    triangle_Matrix = handles.triangle_Matrix;
    Pa_o_Li=handles.Pa_o_Li

    
    %PARALLEL SCHATTENBERECHNUNG

    if Pa_o_Li==1   
        set(handles.textLichtWahl, 'visible', 'off')
        [Shadow_X,Shadow_Y] = Parallelprojection_Shadow(x,y,-w)
        Shadow_Matrix= ToMatrix(Shadow_X,Shadow_Y,z)
        s= size(triangle_Matrix,1)
        [y_Min, y_Max, z_Min, z_Max] = Min_Max_shadowPL(Shadow_Y,z,min(y),max(y),min(z),max(z))
        distance= max(x)  
    end;

    
    %LICHTQUELLEN SCHATTENBERECHNUNG

    if Pa_o_Li == 0 
        Set_Error = handles.Set_Error;                 
        set(handles.textLichtWahl, 'visible', 'off');
        if Set_Error == 0
            textE = get(handles.edit_Entfernung,'string');
            distance= str2num(textE);
            textH = get(handles.edit_LichtH,'string');
            height= str2num(textH);

            
            % MITTELPUNKT DES OBJEKTES FÜR HÖHE DES LICHTPUNKTES
            
            [mpX,mpY,mpZ] = Object_Center(x,y,z);
            height=mpZ+height;
            
            
            %X,Y KOORDINATE DURCH MAXIMUMSUNKT(X) UND WINKEL(Y)
            
            distance_Start = max(x);
            distance = distance_Start+distance;
            Y_Light = -distance*tan(w);

            
            %SCHATTENBERECHNUNG
            
            [Shadow_X,Shadow_Y,Shadow_Z] =  Centralprojection_Shadow(x,y,z,distance,Y_Light,height);
            Shadow_Matrix= ToMatrix(Shadow_X,Shadow_Y,Shadow_Z);
            s=size(triangle_Matrix,1);
            [y_Min, y_Max, z_Min, z_Max] = Min_Max_LP(Shadow_Y,Shadow_Z,Y_Light,height,y,z);

        end;        
    end;
    
    
    %  DREIECKE DES OBJEKTS & SCHATTENS FÜLLEN ,ZEICHNEN
    %  ÜBERSICHTSHALBER HIER AUF ZWEI FOR-SCHLEIFEN NICHT NUR EINE :)
    
     axes(handles.axes_Schatten)
     %hold on
    for i = 1:1:s
        triangle_Point_1 = triangle_Matrix(i,1);
        triangle_Point_2 = triangle_Matrix(i,2);
        triangle_Point_3 = triangle_Matrix(i,3);
        triangle_X =[Shadow_Matrix(triangle_Point_1,1) Shadow_Matrix(triangle_Point_2,1) Shadow_Matrix(triangle_Point_3,1)];
        triangle_Y =[Shadow_Matrix(triangle_Point_1,2) Shadow_Matrix(triangle_Point_2,2) Shadow_Matrix(triangle_Point_3,2)];
        triangle_Z = [Shadow_Matrix(triangle_Point_1,3) Shadow_Matrix(triangle_Point_2,3) Shadow_Matrix(triangle_Point_3,3)];
        fill3(triangle_X,triangle_Y,triangle_Z,'y');
        hold on
    end;
    
    for i = 1:1:s
        triangle_Point_1 = triangle_Matrix(i,1);
        triangle_Point_2 = triangle_Matrix(i,2);
        triangle_Point_3 = triangle_Matrix(i,3);
        triangle_X =[A(triangle_Point_1,1) A(triangle_Point_2,1) A(triangle_Point_3,1)];
        triangle_Y =[A(triangle_Point_1,2) A(triangle_Point_2,2) A(triangle_Point_3,2)];
        triangle_Z = [A(triangle_Point_1,3) A(triangle_Point_2,3) A(triangle_Point_3,3)];
        fill3(triangle_X,triangle_Y,triangle_Z,'g');
        hold on;
    end;
    
    [X_Max,Y_Min,Y_Max,Z_Min,Z_Max] = Skale_Axes(distance, y_Min, y_Max, z_Min, z_Max);
    xlabel('x-axis')
    ylabel('y-axis')
    zlabel('z-axis')    
    xlim([0 X_Max])
    ylim([Y_Min Y_Max])
    zlim([Z_Min Z_Max])
    grid on
     %LICHTPUNKT ZEICHNEN
    if Pa_o_Li == 0
    axes(handles.axes_Schatten)            
            [X,Y,Z] = sphere(12);
            
            r = 0.2;
            X2 = X * r;
            Y2 = Y * r;
            Z2 = Z * r;
            surf(X2+distance,Y2+Y_Light,Z2+height)
    end;
    hold off
    
    %SCHATTEN FÜR EXTRA FENSTER FÜLLEN UND ZEICHNEN 
    
    f1 =figure('Name','Shadow on detector','NumberTitle','off')   
    for i = 1:1:s        
        triangle_Point_1 = triangle_Matrix(i,1);
        triangle_Point_2 = triangle_Matrix(i,2);
        triangle_Point_3 = triangle_Matrix(i,3);
        triangle_Y =[Shadow_Matrix(triangle_Point_1,2) Shadow_Matrix(triangle_Point_2,2) Shadow_Matrix(triangle_Point_3,2)];
        triangle_Z = [Shadow_Matrix(triangle_Point_1,3) Shadow_Matrix(triangle_Point_2,3) Shadow_Matrix(triangle_Point_3,3)];
        fill(triangle_Y,triangle_Z,'y');
        hold on        
    end;
    
    [y2DMin, y2dMax, z2dMin, z2DMax] = Skale2D(min(Shadow_Matrix(:,2)),max(Shadow_Matrix(:,2)),min(Shadow_Matrix(:,3)),max(Shadow_Matrix(:,3)))
    xlabel('y-axis')
    ylabel('z-axis')
    xlim([y2DMin y2dMax])
    ylim([z2dMin z2DMax])
    hold off  
    
   
end;
    

function editWinkelGr_Callback(hObject, eventdata, handles)
% hObject    handle to editWinkelGr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWinkelGr as text
%        str2double(get(hObject,'String')) returns contents of editWinkelGr as a double


% --- Executes during object creation, after setting all properties.
function editWinkelGr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWinkelGr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_Entfernung_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Entfernung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Entfernung as text
%        str2double(get(hObject,'String')) returns contents of edit_Entfernung as a double


distance = str2num(get(hObject,'string'));

% ABFRAGE DER ENTFERNUNG , MUSS GRÖ?ER NULL 
% SONST IN ODER AUF DEM OBJEKT
% SET_ERROR ENTSPRICHT EINER FEHLEINGABE :
%     0 KEINE FEHLEINGABE,1 FALSCHE EINGABE

Set_Error = 1;

if distance <=0
    set(handles.distance_Error, 'visible', 'on')
    Set_Error = 1;
else
    Set_Error =0;
    set(handles.distance_Error, 'visible', 'off')  
end;

handles.Set_Error = Set_Error;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit_Entfernung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Entfernung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbParallel.
function pbParallel_Callback(hObject, eventdata, handles)
% hObject    handle to pbParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%ANZEIGEN UND ENTFERNEN DER ENSPRECHENDEN EINGABE FELDER 

set(handles.textEntfernung,'visible','off');
set(handles.edit_Entfernung,'visible','off');
set(handles.edit_LichtH,'visible','off');
set(handles.textLichtH,'visible','off');
set(handles.textWinkel,'visible','on');
set(handles.editWinkelGr,'visible','on');
set(handles.slider_Camara,'visible','on');
set(handles.text_Vertikal,'visible','on');
set(handles.slider_Vertical,'visible','on');


% Pa_o_Li = Parallel_or_Lightpoint

Pa_o_Li=1;
handles.Pa_o_Li = Pa_o_Li;
guidata(hObject,handles);


% --- Executes on button press in pbLichtquelle.
function pbLichtquelle_Callback(hObject, eventdata, handles)
% hObject    handle to pbLichtquelle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%ANZEIGEN UND ENTFERNEN DER ENSPRECHENDEN EINGABE FELDER 

set(handles.textEntfernung,'visible','on');
set(handles.edit_Entfernung,'visible','on');
set(handles.edit_LichtH,'visible','on');
set(handles.textLichtH,'visible','on');
set(handles.textWinkel,'visible','on');
set(handles.editWinkelGr,'visible','on');
set(handles.text_Horizontal,'visible','on');
set(handles.slider_Camara,'visible','on');
set(handles.text_Vertikal,'visible','on');
set(handles.slider_Vertical,'visible','on');

%Pa_o_Li=Parallel_oder_Lichtquelle
Pa_o_Li=0;
handles.Pa_o_Li = Pa_o_Li;
guidata(hObject,handles);


function edit_LichtH_Callback(hObject, eventdata, handles)
% hObject    handle to edit_LichtH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_LichtH as text
%        str2double(get(hObject,'String')) returns contents of edit_LichtH as a double


% --- Executes during object creation, after setting all properties.
function edit_LichtH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_LichtH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editDreiecksM_Callback(hObject, eventdata, handles)
% hObject    handle to editDreiecksM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDreiecksM as text
%        str2double(get(hObject,'String')) returns contents of editDreiecksM as a double
fileName = get(hObject, 'string');

set(handles.textDreiecksM, 'string',fileName);


% --- Executes during object creation, after setting all properties.
function editDreiecksM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDreiecksM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbDreiecksM.
function pbDreiecksM_Callback(hObject, eventdata, handles)
% hObject    handle to pbDreiecksM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% EINLESEN UND VERARBEITUNG DER DREIECKSMATRIX 

fileD = uigetfile('*.txt');
set(handles.textDreiecksM, 'string',fileD);
set(handles.editDreiecksM,'string',fileD);
[triangle_Matrix,delimiterOut]=importdata(fileD);
handles.triangle_Matrix = triangle_Matrix;
guidata(hObject,handles);
s=size(triangle_Matrix,1);
A = handles.A;


% ZEICHNEN DES OBJEKTS MIT DEN DREIECKEN
for i = 1:1:s
    triangle_Point_1 = triangle_Matrix(i,1);
    triangle_Point_2 = triangle_Matrix(i,2);
    triangle_Point_3 = triangle_Matrix(i,3);
    axes(handles.axes_Schatten)
    triangle_X =[A(triangle_Point_1,1) A(triangle_Point_2,1) A(triangle_Point_3,1)];
    triangle_Y =[A(triangle_Point_1,2) A(triangle_Point_2,2) A(triangle_Point_3,2)];
    triangle_Z = [A(triangle_Point_1,3) A(triangle_Point_2,3) A(triangle_Point_3,3)];
    fill3(triangle_X,triangle_Y,triangle_Z,'g');
    hold on;
end;


axes(handles.axes_Schatten)
[x_Max y_Min y_Max z_Min z_Max] = Skale_Axes(max(A(:,1)),min(A(:,2)),max(A(:,2)), min(A(:,3)),max(A(:,3)))
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
xlim([0 x_Max])
ylim([y_Min y_Max])
zlim([z_Min z_Max])
grid on
hold off


% --- Executes on slider movement.
function slider_Camara_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Diff_slider_H = handles.Diff_slider_H 

set(handles.slider_Camara, 'Max',360);
set(handles.slider_Camara, 'Min', 0);

set(handles.slider_Camara, 'SliderStep' , [1,0.1] );
sliderValue_H = get(handles.slider_Camara,'Value');

% DIFF_SLIDER_H MERKT DEN SCHON GEDREHTEN ANTEIL
% MUSS SOMIT IMMER ABGEZOGEN WERDEN DAMIT AUF 0 ANFANGSBEDINGUNG LIEGT

val_H = sliderValue_H - Diff_slider_H;
handles.val_H =val_H
guidata(hObject,handles);

Diff_slider_H =sliderValue_H 
handles.Diff_slider_H = Diff_slider_H
guidata(hObject,handles);

axes(handles.axes_Schatten)
camorbit(val_H,0)
hold off;


% --- Executes during object creation, after setting all properties.
function slider_Camara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_Vertical_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Diff_slider_V =handles.Diff_slider_V
set(handles.slider_Vertical, 'Max',360);
set(handles.slider_Vertical, 'Min', 0);
set(handles.slider_Vertical, 'SliderStep' , [1,0.1] );
sliderValue_V = get(handles.slider_Vertical,'Value');


% DIFF_SLIDER_V MERKT DEN SCHON GEDREHTEN ANTEIL
% MUSS SOMIT IMMER ABGEZOGEN WERDEN DAMIT AUF 0 ANFANGSBEDINGUNG LIEGT

val = sliderValue_V - Diff_slider_V
handles.val =val
guidata(hObject,handles);
Diff_slider_V = sliderValue_V
handles.Diff_slider_V =Diff_slider_V
guidata(hObject,handles);
axes(handles.axes_Schatten)

camorbit(0,val)
hold off

% --- Executes during object creation, after setting all properties.
function slider_Vertical_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
