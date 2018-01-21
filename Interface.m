%% Diffusion Modeling in Tissue Constructs %%
% Richard J. McMurtrey, MD, MSc 
% Institute of Neural Regeneration & Tissue Engineering
% Copyright (c) 2017
% Special thanks to Brian Vincent for his assistance with the Graphical User Interface
% This work is made available under the GNU GPLv3 License https://choosealicense.com/licenses/gpl-3.0/
% In essence, you may freely use, modify, and build upon this work, subject to the following two conditions:
% (1) you must give credit to this original work and indicate changes made; 
% (2) your contributions and changes may only be distributed under the same license as the original. 

function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 06-Jun-2017 20:24:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

diffusant_choice = getappdata(0,'diffusant_Selection');
construct_choice = getappdata(0,'construct_Selection');
metabolism_choice = getappdata(0,'metabolism_Selection');
diffusion_choice = getappdata(0,'diffusion_Selection');


%% if Equation 1 %Slab_Outward_Diffusion_Limited  
if strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')

Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Tmax=str2num(maxString);
tend=str2num(tendString);
    
T=Tmax;
x=linspace(0,T,500);
t=linspace(0,tend,500);
[x, t]=meshgrid(x,t); 

Z1=0;   
Z2=0;
i=1000;
    for n=1:i;
        Z1=Z1+erf(((2.*n).*T+x)./(sqrt(4.*D.*t)));  
        Z2=Z2+erf(((2.*n).*T-x)./(sqrt(4.*D.*t)));  
    end   
C=(Co).*erf(x./(sqrt(4.*D.*t)))+(Co).*(Z2-Z1); 

mesh(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;

surf(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 


%% If Equation 2% Limited, Cylinder, No, Outward
elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');   
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);

R=Rmax;
r=linspace(0,R,500); 
t=linspace(0,tend,500);
[r, t]=meshgrid(r,t);
        lambda1= 2.4048./R; 
        lambda2= 5.5201./R; 
        lambda3= 8.6537./R; 
        lambda4= 11.7915./R; 
        lambda5= 14.9309./R; 
        lambda6= 18.0711./R;
        lambda7= 21.2116./R;
        lambda8= 24.3525./R;
        lambda9= 27.4935./R;
        lambda10= 30.6346./R;
        lambda11= 33.7758./R;
        lambda12= 36.9171./R;
        lambda13= 40.0584./R;
        lambda14= 43.1998./R;
        lambda15= 46.3412./R;
        lambda16= 49.4826./R;
        lambda17= 52.6241./R;
        lambda18= 55.7655./R;
        lambda19= 58.9070./R;
        lambda20= 62.0485./R;
        lambda21= 65.1900./R;
        lambda22= 68.3315./R;
        lambda23= 71.4730./R;
        lambda24= 74.6145./R;
        lambda25= 77.7560./R;
        lambda26= 80.8976./R;
        lambda27= 84.0391./R;
        lambda28= 87.1806./R;
        lambda29= 90.3222./R;
        lambda30= 93.4637./R;
        lambda31= 96.6053./R;
        lambda32= 99.7468./R;
        lambda33= 102.8884./R;
        lambda34= 106.0299./R;
        lambda35= 109.1715./R;
        lambda36= 112.3131./R;
        lambda37= 115.4546./R;
        lambda38= 118.5962./R;
        lambda39= 121.7377./R;
        lambda40= 124.8793./R;
        lambda41= 128.0209./R;
        lambda42= 131.1624./R;
        lambda43= 134.3040./R;
        lambda44= 137.4456./R;
        lambda45= 140.5872./R;
        lambda46= 143.7287./R;
        lambda47= 146.8703./R;
        lambda48= 150.0119./R;
        lambda49= 153.1534./R;
        lambda50= 156.2950./R;       
  
        Za1=(exp(-D.*t.*lambda1.^2)).*(besselj(0,(r.*lambda1)))./(lambda1.*(besselj(1,(R.*lambda1))));
        Za2=(exp(-D.*t.*lambda2.^2)).*(besselj(0,(r.*lambda2)))./(lambda2.*(besselj(1,(R.*lambda2))));
        Za3=(exp(-D.*t.*lambda3.^2)).*(besselj(0,(r.*lambda3)))./(lambda3.*(besselj(1,(R.*lambda3))));
        Za4=(exp(-D.*t.*lambda4.^2)).*(besselj(0,(r.*lambda4)))./(lambda4.*(besselj(1,(R.*lambda4))));
        Za5=(exp(-D.*t.*lambda5.^2)).*(besselj(0,(r.*lambda5)))./(lambda5.*(besselj(1,(R.*lambda5))));
        Za6=(exp(-D.*t.*lambda6.^2)).*(besselj(0,(r.*lambda6)))./(lambda6.*(besselj(1,(R.*lambda6))));
        Za7=(exp(-D.*t.*lambda7.^2)).*(besselj(0,(r.*lambda7)))./(lambda7.*(besselj(1,(R.*lambda7))));
        Za8=(exp(-D.*t.*lambda8.^2)).*(besselj(0,(r.*lambda8)))./(lambda8.*(besselj(1,(R.*lambda8))));
        Za9=(exp(-D.*t.*lambda9.^2)).*(besselj(0,(r.*lambda9)))./(lambda9.*(besselj(1,(R.*lambda9))));
        Za10=(exp(-D.*t.*lambda10.^2)).*(besselj(0,(r.*lambda10)))./(lambda10.*(besselj(1,(R.*lambda10))));
        Za11=(exp(-D.*t.*lambda11.^2)).*(besselj(0,(r.*lambda11)))./(lambda11.*(besselj(1,(R.*lambda11))));
        Za12=(exp(-D.*t.*lambda12.^2)).*(besselj(0,(r.*lambda12)))./(lambda12.*(besselj(1,(R.*lambda12))));
        Za13=(exp(-D.*t.*lambda13.^2)).*(besselj(0,(r.*lambda13)))./(lambda13.*(besselj(1,(R.*lambda13))));
        Za14=(exp(-D.*t.*lambda14.^2)).*(besselj(0,(r.*lambda14)))./(lambda14.*(besselj(1,(R.*lambda14))));
        Za15=(exp(-D.*t.*lambda15.^2)).*(besselj(0,(r.*lambda15)))./(lambda15.*(besselj(1,(R.*lambda15))));
        Za16=(exp(-D.*t.*lambda16.^2)).*(besselj(0,(r.*lambda16)))./(lambda16.*(besselj(1,(R.*lambda16))));
        Za17=(exp(-D.*t.*lambda17.^2)).*(besselj(0,(r.*lambda17)))./(lambda17.*(besselj(1,(R.*lambda17))));
        Za18=(exp(-D.*t.*lambda18.^2)).*(besselj(0,(r.*lambda18)))./(lambda18.*(besselj(1,(R.*lambda18))));
        Za19=(exp(-D.*t.*lambda19.^2)).*(besselj(0,(r.*lambda19)))./(lambda19.*(besselj(1,(R.*lambda19))));
        Za20=(exp(-D.*t.*lambda20.^2)).*(besselj(0,(r.*lambda20)))./(lambda20.*(besselj(1,(R.*lambda20))));
        Za21=(exp(-D.*t.*lambda21.^2)).*(besselj(0,(r.*lambda21)))./(lambda21.*(besselj(1,(R.*lambda21))));
        Za22=(exp(-D.*t.*lambda22.^2)).*(besselj(0,(r.*lambda22)))./(lambda22.*(besselj(1,(R.*lambda22))));
        Za23=(exp(-D.*t.*lambda23.^2)).*(besselj(0,(r.*lambda23)))./(lambda23.*(besselj(1,(R.*lambda23))));
        Za24=(exp(-D.*t.*lambda24.^2)).*(besselj(0,(r.*lambda24)))./(lambda24.*(besselj(1,(R.*lambda24))));
        Za25=(exp(-D.*t.*lambda25.^2)).*(besselj(0,(r.*lambda25)))./(lambda25.*(besselj(1,(R.*lambda25))));
        Za26=(exp(-D.*t.*lambda26.^2)).*(besselj(0,(r.*lambda26)))./(lambda26.*(besselj(1,(R.*lambda26))));
        Za27=(exp(-D.*t.*lambda27.^2)).*(besselj(0,(r.*lambda27)))./(lambda27.*(besselj(1,(R.*lambda27))));
        Za28=(exp(-D.*t.*lambda28.^2)).*(besselj(0,(r.*lambda28)))./(lambda28.*(besselj(1,(R.*lambda28))));
        Za29=(exp(-D.*t.*lambda29.^2)).*(besselj(0,(r.*lambda29)))./(lambda29.*(besselj(1,(R.*lambda29))));
        Za30=(exp(-D.*t.*lambda30.^2)).*(besselj(0,(r.*lambda30)))./(lambda30.*(besselj(1,(R.*lambda30))));
        Za31=(exp(-D.*t.*lambda31.^2)).*(besselj(0,(r.*lambda31)))./(lambda31.*(besselj(1,(R.*lambda31))));
        Za32=(exp(-D.*t.*lambda32.^2)).*(besselj(0,(r.*lambda32)))./(lambda32.*(besselj(1,(R.*lambda32))));
        Za33=(exp(-D.*t.*lambda33.^2)).*(besselj(0,(r.*lambda33)))./(lambda33.*(besselj(1,(R.*lambda33))));
        Za34=(exp(-D.*t.*lambda34.^2)).*(besselj(0,(r.*lambda34)))./(lambda34.*(besselj(1,(R.*lambda34))));
        Za35=(exp(-D.*t.*lambda35.^2)).*(besselj(0,(r.*lambda35)))./(lambda35.*(besselj(1,(R.*lambda35))));
        Za36=(exp(-D.*t.*lambda36.^2)).*(besselj(0,(r.*lambda36)))./(lambda36.*(besselj(1,(R.*lambda36))));
        Za37=(exp(-D.*t.*lambda37.^2)).*(besselj(0,(r.*lambda37)))./(lambda37.*(besselj(1,(R.*lambda37))));
        Za38=(exp(-D.*t.*lambda38.^2)).*(besselj(0,(r.*lambda38)))./(lambda38.*(besselj(1,(R.*lambda38))));
        Za39=(exp(-D.*t.*lambda39.^2)).*(besselj(0,(r.*lambda39)))./(lambda39.*(besselj(1,(R.*lambda39))));
        Za40=(exp(-D.*t.*lambda40.^2)).*(besselj(0,(r.*lambda40)))./(lambda40.*(besselj(1,(R.*lambda40))));
        Za41=(exp(-D.*t.*lambda41.^2)).*(besselj(0,(r.*lambda41)))./(lambda41.*(besselj(1,(R.*lambda41))));
        Za42=(exp(-D.*t.*lambda42.^2)).*(besselj(0,(r.*lambda42)))./(lambda42.*(besselj(1,(R.*lambda42))));
        Za43=(exp(-D.*t.*lambda43.^2)).*(besselj(0,(r.*lambda43)))./(lambda43.*(besselj(1,(R.*lambda43))));
        Za44=(exp(-D.*t.*lambda44.^2)).*(besselj(0,(r.*lambda44)))./(lambda44.*(besselj(1,(R.*lambda44))));
        Za45=(exp(-D.*t.*lambda45.^2)).*(besselj(0,(r.*lambda45)))./(lambda45.*(besselj(1,(R.*lambda45))));
        Za46=(exp(-D.*t.*lambda46.^2)).*(besselj(0,(r.*lambda46)))./(lambda46.*(besselj(1,(R.*lambda46))));
        Za47=(exp(-D.*t.*lambda47.^2)).*(besselj(0,(r.*lambda47)))./(lambda47.*(besselj(1,(R.*lambda47))));
        Za48=(exp(-D.*t.*lambda48.^2)).*(besselj(0,(r.*lambda48)))./(lambda48.*(besselj(1,(R.*lambda48))));
        Za49=(exp(-D.*t.*lambda49.^2)).*(besselj(0,(r.*lambda49)))./(lambda49.*(besselj(1,(R.*lambda49))));
        Za50=(exp(-D.*t.*lambda50.^2)).*(besselj(0,(r.*lambda50)))./(lambda50.*(besselj(1,(R.*lambda50))));
C=(Co.*((2./R).*(Za1+Za2+Za3+Za4+Za5+Za6+Za7+Za8+Za9+Za10+Za11+Za12+Za13+Za14+Za15+Za16+Za17+Za18+Za19+Za20+Za21+Za22+Za23+Za24+Za25+Za26+Za27+Za28+Za29+Za30+Za31+Za32+Za33+Za34+Za35+Za36+Za37+Za38+Za39+Za40+Za41+Za42+Za43+Za44+Za45+Za46+Za47+Za48+Za49+Za50)));
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 

%% If Equation 3% Limited, Sphere, No, Outward
elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);

R=Rmax;
r = linspace(0,R,500);
t = linspace(0,tend,500); 
[r, t]=meshgrid(r,t);
 
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((-1).^(n+1))./n).*(1./r).*exp(-D.*t.*(n.*pi./R).^2).*sin(n.*pi.*r./R);
    end
C=Co.*(2.*R./pi).*Z;
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% If equation 4% Unlimited, Slab, No, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');    
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Tmax=str2num(maxString);
tend=str2num(tendString);

T=Tmax;
x=linspace(0,T,500);
t=linspace(0,tend,500);
[x, t]=meshgrid(x,t); 

Z1=0;   
Z2=0;
i=1000;
    for n=1:i;
        Z1=Z1+((-1).^(n)).*erfc(((2.*n).*T+x)./(sqrt(4.*D.*t))); 
        Z2=Z2+((-1).^(n)).*erfc(((2.*n).*T-x)./(sqrt(4.*D.*t)));  
    end     
C=(Co).*erfc(x./(sqrt(4.*D.*t)))+(Co).*(Z1-Z2); 
 
mesh(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% if Equation 5% Unlimited, Cylinder, No, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String'); 
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);

R=Rmax;
r=linspace(0,R,500); 
t=linspace(0,tend,500); 
[r, t]=meshgrid(r,t);
        lambda1= 2.4048./R; 
        lambda2= 5.5201./R; 
        lambda3= 8.6537./R; 
        lambda4= 11.7915./R; 
        lambda5= 14.9309./R; 
        lambda6= 18.0711./R;
        lambda7= 21.2116./R;
        lambda8= 24.3525./R;
        lambda9= 27.4935./R;
        lambda10= 30.6346./R;
        lambda11= 33.7758./R;
        lambda12= 36.9171./R;
        lambda13= 40.0584./R;
        lambda14= 43.1998./R;
        lambda15= 46.3412./R;
        lambda16= 49.4826./R;
        lambda17= 52.6241./R;
        lambda18= 55.7655./R;
        lambda19= 58.9070./R;
        lambda20= 62.0485./R;
        lambda21= 65.1900./R;
        lambda22= 68.3315./R;
        lambda23= 71.4730./R;
        lambda24= 74.6145./R;
        lambda25= 77.7560./R;
        lambda26= 80.8976./R;
        lambda27= 84.0391./R;
        lambda28= 87.1806./R;
        lambda29= 90.3222./R;
        lambda30= 93.4637./R;
        lambda31= 96.6053./R;
        lambda32= 99.7468./R;
        lambda33= 102.8884./R;
        lambda34= 106.0299./R;
        lambda35= 109.1715./R;
        lambda36= 112.3131./R;
        lambda37= 115.4546./R;
        lambda38= 118.5962./R;
        lambda39= 121.7377./R;
        lambda40= 124.8793./R;
        lambda41= 128.0209./R;
        lambda42= 131.1624./R;
        lambda43= 134.3040./R;
        lambda44= 137.4456./R;
        lambda45= 140.5872./R;
        lambda46= 143.7287./R;
        lambda47= 146.8703./R;
        lambda48= 150.0119./R;
        lambda49= 153.1534./R;
        lambda50= 156.2950./R;       
 
        Za1=(exp(-D.*t.*lambda1.^2)).*(besselj(0,(r.*lambda1)))./(lambda1.*(besselj(1,(R.*lambda1))));
        Za2=(exp(-D.*t.*lambda2.^2)).*(besselj(0,(r.*lambda2)))./(lambda2.*(besselj(1,(R.*lambda2))));
        Za3=(exp(-D.*t.*lambda3.^2)).*(besselj(0,(r.*lambda3)))./(lambda3.*(besselj(1,(R.*lambda3))));
        Za4=(exp(-D.*t.*lambda4.^2)).*(besselj(0,(r.*lambda4)))./(lambda4.*(besselj(1,(R.*lambda4))));
        Za5=(exp(-D.*t.*lambda5.^2)).*(besselj(0,(r.*lambda5)))./(lambda5.*(besselj(1,(R.*lambda5))));
        Za6=(exp(-D.*t.*lambda6.^2)).*(besselj(0,(r.*lambda6)))./(lambda6.*(besselj(1,(R.*lambda6))));
        Za7=(exp(-D.*t.*lambda7.^2)).*(besselj(0,(r.*lambda7)))./(lambda7.*(besselj(1,(R.*lambda7))));
        Za8=(exp(-D.*t.*lambda8.^2)).*(besselj(0,(r.*lambda8)))./(lambda8.*(besselj(1,(R.*lambda8))));
        Za9=(exp(-D.*t.*lambda9.^2)).*(besselj(0,(r.*lambda9)))./(lambda9.*(besselj(1,(R.*lambda9))));
        Za10=(exp(-D.*t.*lambda10.^2)).*(besselj(0,(r.*lambda10)))./(lambda10.*(besselj(1,(R.*lambda10))));
        Za11=(exp(-D.*t.*lambda11.^2)).*(besselj(0,(r.*lambda11)))./(lambda11.*(besselj(1,(R.*lambda11))));
        Za12=(exp(-D.*t.*lambda12.^2)).*(besselj(0,(r.*lambda12)))./(lambda12.*(besselj(1,(R.*lambda12))));
        Za13=(exp(-D.*t.*lambda13.^2)).*(besselj(0,(r.*lambda13)))./(lambda13.*(besselj(1,(R.*lambda13))));
        Za14=(exp(-D.*t.*lambda14.^2)).*(besselj(0,(r.*lambda14)))./(lambda14.*(besselj(1,(R.*lambda14))));
        Za15=(exp(-D.*t.*lambda15.^2)).*(besselj(0,(r.*lambda15)))./(lambda15.*(besselj(1,(R.*lambda15))));
        Za16=(exp(-D.*t.*lambda16.^2)).*(besselj(0,(r.*lambda16)))./(lambda16.*(besselj(1,(R.*lambda16))));
        Za17=(exp(-D.*t.*lambda17.^2)).*(besselj(0,(r.*lambda17)))./(lambda17.*(besselj(1,(R.*lambda17))));
        Za18=(exp(-D.*t.*lambda18.^2)).*(besselj(0,(r.*lambda18)))./(lambda18.*(besselj(1,(R.*lambda18))));
        Za19=(exp(-D.*t.*lambda19.^2)).*(besselj(0,(r.*lambda19)))./(lambda19.*(besselj(1,(R.*lambda19))));
        Za20=(exp(-D.*t.*lambda20.^2)).*(besselj(0,(r.*lambda20)))./(lambda20.*(besselj(1,(R.*lambda20))));
        Za21=(exp(-D.*t.*lambda21.^2)).*(besselj(0,(r.*lambda21)))./(lambda21.*(besselj(1,(R.*lambda21))));
        Za22=(exp(-D.*t.*lambda22.^2)).*(besselj(0,(r.*lambda22)))./(lambda22.*(besselj(1,(R.*lambda22))));
        Za23=(exp(-D.*t.*lambda23.^2)).*(besselj(0,(r.*lambda23)))./(lambda23.*(besselj(1,(R.*lambda23))));
        Za24=(exp(-D.*t.*lambda24.^2)).*(besselj(0,(r.*lambda24)))./(lambda24.*(besselj(1,(R.*lambda24))));
        Za25=(exp(-D.*t.*lambda25.^2)).*(besselj(0,(r.*lambda25)))./(lambda25.*(besselj(1,(R.*lambda25))));
        Za26=(exp(-D.*t.*lambda26.^2)).*(besselj(0,(r.*lambda26)))./(lambda26.*(besselj(1,(R.*lambda26))));
        Za27=(exp(-D.*t.*lambda27.^2)).*(besselj(0,(r.*lambda27)))./(lambda27.*(besselj(1,(R.*lambda27))));
        Za28=(exp(-D.*t.*lambda28.^2)).*(besselj(0,(r.*lambda28)))./(lambda28.*(besselj(1,(R.*lambda28))));
        Za29=(exp(-D.*t.*lambda29.^2)).*(besselj(0,(r.*lambda29)))./(lambda29.*(besselj(1,(R.*lambda29))));
        Za30=(exp(-D.*t.*lambda30.^2)).*(besselj(0,(r.*lambda30)))./(lambda30.*(besselj(1,(R.*lambda30))));
        Za31=(exp(-D.*t.*lambda31.^2)).*(besselj(0,(r.*lambda31)))./(lambda31.*(besselj(1,(R.*lambda31))));
        Za32=(exp(-D.*t.*lambda32.^2)).*(besselj(0,(r.*lambda32)))./(lambda32.*(besselj(1,(R.*lambda32))));
        Za33=(exp(-D.*t.*lambda33.^2)).*(besselj(0,(r.*lambda33)))./(lambda33.*(besselj(1,(R.*lambda33))));
        Za34=(exp(-D.*t.*lambda34.^2)).*(besselj(0,(r.*lambda34)))./(lambda34.*(besselj(1,(R.*lambda34))));
        Za35=(exp(-D.*t.*lambda35.^2)).*(besselj(0,(r.*lambda35)))./(lambda35.*(besselj(1,(R.*lambda35))));
        Za36=(exp(-D.*t.*lambda36.^2)).*(besselj(0,(r.*lambda36)))./(lambda36.*(besselj(1,(R.*lambda36))));
        Za37=(exp(-D.*t.*lambda37.^2)).*(besselj(0,(r.*lambda37)))./(lambda37.*(besselj(1,(R.*lambda37))));
        Za38=(exp(-D.*t.*lambda38.^2)).*(besselj(0,(r.*lambda38)))./(lambda38.*(besselj(1,(R.*lambda38))));
        Za39=(exp(-D.*t.*lambda39.^2)).*(besselj(0,(r.*lambda39)))./(lambda39.*(besselj(1,(R.*lambda39))));
        Za40=(exp(-D.*t.*lambda40.^2)).*(besselj(0,(r.*lambda40)))./(lambda40.*(besselj(1,(R.*lambda40))));
        Za41=(exp(-D.*t.*lambda41.^2)).*(besselj(0,(r.*lambda41)))./(lambda41.*(besselj(1,(R.*lambda41))));
        Za42=(exp(-D.*t.*lambda42.^2)).*(besselj(0,(r.*lambda42)))./(lambda42.*(besselj(1,(R.*lambda42))));
        Za43=(exp(-D.*t.*lambda43.^2)).*(besselj(0,(r.*lambda43)))./(lambda43.*(besselj(1,(R.*lambda43))));
        Za44=(exp(-D.*t.*lambda44.^2)).*(besselj(0,(r.*lambda44)))./(lambda44.*(besselj(1,(R.*lambda44))));
        Za45=(exp(-D.*t.*lambda45.^2)).*(besselj(0,(r.*lambda45)))./(lambda45.*(besselj(1,(R.*lambda45))));
        Za46=(exp(-D.*t.*lambda46.^2)).*(besselj(0,(r.*lambda46)))./(lambda46.*(besselj(1,(R.*lambda46))));
        Za47=(exp(-D.*t.*lambda47.^2)).*(besselj(0,(r.*lambda47)))./(lambda47.*(besselj(1,(R.*lambda47))));
        Za48=(exp(-D.*t.*lambda48.^2)).*(besselj(0,(r.*lambda48)))./(lambda48.*(besselj(1,(R.*lambda48))));
        Za49=(exp(-D.*t.*lambda49.^2)).*(besselj(0,(r.*lambda49)))./(lambda49.*(besselj(1,(R.*lambda49))));
        Za50=(exp(-D.*t.*lambda50.^2)).*(besselj(0,(r.*lambda50)))./(lambda50.*(besselj(1,(R.*lambda50))));
C=(Co.*(1-(2./R).*(Za1+Za2+Za3+Za4+Za5+Za6+Za7+Za8+Za9+Za10+Za11+Za12+Za13+Za14+Za15+Za16+Za17+Za18+Za19+Za20+Za21+Za22+Za23+Za24+Za25+Za26+Za27+Za28+Za29+Za30+Za31+Za32+Za33+Za34+Za35+Za36+Za37+Za38+Za39+Za40+Za41+Za42+Za43+Za44+Za45+Za46+Za47+Za48+Za49+Za50)));
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% if Equation 6% Unlimited, Sphere, No, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')

Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');    
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);

R=Rmax;
r = linspace(0,R,500);
t = linspace(0,tend,500); 
[r, t]=meshgrid(r,t);
 
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((((-1).^(n))./n).*exp(-D.*t.*(n.*pi./(R)).^2)).*(sin(((n.*pi)./(R)).*r)));
    end
C=Co+(2.*R.*Co./(pi.*r)).*Z;
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% if Equation 7% Unlimited, Slab, Yes, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');  
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Tmax=str2num(maxString);
tend=str2num(tendString);
    
T=Tmax;
x = linspace(0,T,500);
t = linspace(0,tend,500);
[x, t]=meshgrid(x,t);
 
Z=0;    
i=1000;
for n=1:i;
    Z=Z+((((1./n).*exp(-D.*t.*(n.*pi./T).^2)).*(sin(n.*pi.*(((2.*Phi.*T.*x-(Phi.*x.^2)))./(2.*(Co).*D)))))); 
end  
C=((Phi./(2.*D)).*x.^2-Phi.*T.*x./D)+(Co)-((2.*(Co))./pi).*Z; 
 
mesh(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 T 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
 
%% if Equation 8% Unlimited, Cylinder, Yes, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');    
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);

R=Rmax; 
r = linspace(0,R,500);
t = linspace(0,tend,500); 
[r, t]=meshgrid(r,t);
 
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((((-1).^(n))./n).*exp(-D.*t.*(n.*pi./(R)).^2)).*(sin(((n.*pi)./(R.^2)).*(r.^2))));
    end
C=((Co).*r.^2)./(R.^2)+((2.*(Co))./pi).*Z; 
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% if Equation 9% Unlimited, Sphere, Yes, Inward
elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')
 
Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String'); 
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);
    
R=Rmax;
r = linspace(0,R,500);
t = linspace(0,tend,500); 
[r, t]=meshgrid(r,t);
 
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((((-1).^(n))./n).*exp(-D.*t.*(n.*pi./(R)).^2)).*(sin(((n.*pi)./(R.^2)).*(r.^2))));
    end
C=((Co).*r.^2)./(R.^2)+((2.*(Co))./pi).*Z; 
 
mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
 
surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 
%% if Equation 10% Limited, Slab, Yes, Inward
elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String');  
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Tmax=str2num(maxString);
tend=str2num(tendString);
    
Phi=(2.*Co.*D)./(Tmax.^2);
Vc=1;
T=Tmax;
tend=(Co./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));
x = linspace(0,Tmax,500);
t = linspace(0,tend,500);
[x, t]=meshgrid(x,t);

ZC=0;    
i=1000;
for n=1:i;
    ZC=ZC+(1./((2.*n-1).^2)).*exp(-((((2.*n-1).*pi)./(2.*Tmax)).^2).*D.*t);
end  
Cbar=(Co).*(1-(8./(pi.^2)).*ZC);
Tmaxt=sqrt(2.*((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc/(Vc+Vm))).*D./Phi);
x(x(:,:)>Tmaxt(:,:))=nan;
Z=0;    
i=1000;
for n=1:i;
    Z=Z+((((1./n).*exp(-D.*t.*(n.*pi./Tmaxt).^2)).*(sin(n.*pi.*(((2.*Phi.*Tmaxt.*x-((Phi).*x.^2)))./(2.*(Co).*D)))))); 
end  
C=((Phi./(2.*D)).*x.^2-Phi.*Tmaxt.*x./D)+((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc/(Vc+Vm)))-((2.*((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc/(Vc+Vm))))./pi).*Z;
C=real(C);

mesh(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;

surf(x,t,C);
xlabel('x (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 T 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 

 
%% if equation 11% Limited, Cylinder, Yes, Inward
elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String'); 
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);
  
Vc=1;
R=Rmax;
Phi=(4.*Co.*D)./(Rmax.^2);
tend=((Co)./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));
r = linspace(0,Rmax,50);
t = linspace(0,tend,50);
[r, t]=meshgrid(r,t);

        lambda1= 2.4048./R; 
        lambda2= 5.5201./R; 
        lambda3= 8.6537./R; 
        lambda4= 11.7915./R; 
        lambda5= 14.9309./R; 
        lambda6= 18.0711./R;
        lambda7= 21.2116./R;
        lambda8= 24.3525./R;
        lambda9= 27.4935./R;
        lambda10= 30.6346./R;
        lambda11= 33.7758./R;
        lambda12= 36.9171./R;
        lambda13= 40.0584./R;
        lambda14= 43.1998./R;
        lambda15= 46.3412./R;
        lambda16= 49.4826./R;
        lambda17= 52.6241./R;
        lambda18= 55.7655./R;
        lambda19= 58.9070./R;
        lambda20= 62.0485./R;
        lambda21= 65.1900./R;
        lambda22= 68.3315./R;
        lambda23= 71.4730./R;
        lambda24= 74.6145./R;
        lambda25= 77.7560./R;
        lambda26= 80.8976./R;
        lambda27= 84.0391./R;
        lambda28= 87.1806./R;
        lambda29= 90.3222./R;
        lambda30= 93.4637./R;
        lambda31= 96.6053./R;
        lambda32= 99.7468./R;
        lambda33= 102.8884./R;
        lambda34= 106.0299./R;
        lambda35= 109.1715./R;
        lambda36= 112.3131./R;
        lambda37= 115.4546./R;
        lambda38= 118.5962./R;
        lambda39= 121.7377./R;
        lambda40= 124.8793./R;
        lambda41= 128.0209./R;
        lambda42= 131.1624./R;
        lambda43= 134.3040./R;
        lambda44= 137.4456./R;
        lambda45= 140.5872./R;
        lambda46= 143.7287./R;
        lambda47= 146.8703./R;
        lambda48= 150.0119./R;
        lambda49= 153.1534./R;
        lambda50= 156.2950./R;
ZC=0;    
i=1000;
for n=1:i;
    Z1=(4./((R.^2).*(lambda1).^2)).*exp(-((((lambda1)).^2)).*D.*t);
    Z2=(4./((R.^2).*(lambda2).^2)).*exp(-((((lambda2)).^2)).*D.*t);
    Z3=(4./((R.^2).*(lambda3).^2)).*exp(-((((lambda3)).^2)).*D.*t);
    Z4=(4./((R.^2).*(lambda4).^2)).*exp(-((((lambda4)).^2)).*D.*t);
    Z5=(4./((R.^2).*(lambda5).^2)).*exp(-((((lambda5)).^2)).*D.*t);
    Z6=(4./((R.^2).*(lambda6).^2)).*exp(-((((lambda6)).^2)).*D.*t);
    Z7=(4./((R.^2).*(lambda7).^2)).*exp(-((((lambda7)).^2)).*D.*t);
    Z8=(4./((R.^2).*(lambda8).^2)).*exp(-((((lambda8)).^2)).*D.*t);
    Z9=(4./((R.^2).*(lambda9).^2)).*exp(-((((lambda9)).^2)).*D.*t);
    Z10=(4./((R.^2).*(lambda10).^2)).*exp(-((((lambda10)).^2)).*D.*t);
    Z11=(4./((R.^2).*(lambda11).^2)).*exp(-((((lambda11)).^2)).*D.*t);
    Z12=(4./((R.^2).*(lambda12).^2)).*exp(-((((lambda12)).^2)).*D.*t);
    Z13=(4./((R.^2).*(lambda13).^2)).*exp(-((((lambda13)).^2)).*D.*t);
    Z14=(4./((R.^2).*(lambda14).^2)).*exp(-((((lambda14)).^2)).*D.*t);
    Z15=(4./((R.^2).*(lambda15).^2)).*exp(-((((lambda15)).^2)).*D.*t);
    Z16=(4./((R.^2).*(lambda16).^2)).*exp(-((((lambda16)).^2)).*D.*t);
    Z17=(4./((R.^2).*(lambda17).^2)).*exp(-((((lambda17)).^2)).*D.*t);
    Z18=(4./((R.^2).*(lambda18).^2)).*exp(-((((lambda18)).^2)).*D.*t);
    Z19=(4./((R.^2).*(lambda19).^2)).*exp(-((((lambda19)).^2)).*D.*t);
    Z20=(4./((R.^2).*(lambda20).^2)).*exp(-((((lambda20)).^2)).*D.*t);
    Z21=(4./((R.^2).*(lambda21).^2)).*exp(-((((lambda21)).^2)).*D.*t);
    Z22=(4./((R.^2).*(lambda22).^2)).*exp(-((((lambda22)).^2)).*D.*t);
    Z23=(4./((R.^2).*(lambda23).^2)).*exp(-((((lambda23)).^2)).*D.*t);
    Z24=(4./((R.^2).*(lambda24).^2)).*exp(-((((lambda24)).^2)).*D.*t);
    Z25=(4./((R.^2).*(lambda25).^2)).*exp(-((((lambda25)).^2)).*D.*t);
    Z26=(4./((R.^2).*(lambda26).^2)).*exp(-((((lambda26)).^2)).*D.*t);
    Z27=(4./((R.^2).*(lambda27).^2)).*exp(-((((lambda27)).^2)).*D.*t);
    Z28=(4./((R.^2).*(lambda28).^2)).*exp(-((((lambda28)).^2)).*D.*t);
    Z29=(4./((R.^2).*(lambda29).^2)).*exp(-((((lambda29)).^2)).*D.*t);
    Z30=(4./((R.^2).*(lambda30).^2)).*exp(-((((lambda30)).^2)).*D.*t);   
    Z31=(4./((R.^2).*(lambda31).^2)).*exp(-((((lambda31)).^2)).*D.*t);
    Z32=(4./((R.^2).*(lambda32).^2)).*exp(-((((lambda32)).^2)).*D.*t);
    Z33=(4./((R.^2).*(lambda33).^2)).*exp(-((((lambda33)).^2)).*D.*t);
    Z34=(4./((R.^2).*(lambda34).^2)).*exp(-((((lambda34)).^2)).*D.*t);
    Z35=(4./((R.^2).*(lambda35).^2)).*exp(-((((lambda35)).^2)).*D.*t);
    Z36=(4./((R.^2).*(lambda36).^2)).*exp(-((((lambda36)).^2)).*D.*t);
    Z37=(4./((R.^2).*(lambda37).^2)).*exp(-((((lambda37)).^2)).*D.*t);
    Z38=(4./((R.^2).*(lambda38).^2)).*exp(-((((lambda38)).^2)).*D.*t);
    Z39=(4./((R.^2).*(lambda39).^2)).*exp(-((((lambda39)).^2)).*D.*t);
    Z40=(4./((R.^2).*(lambda40).^2)).*exp(-((((lambda40)).^2)).*D.*t); 
    Z41=(4./((R.^2).*(lambda41).^2)).*exp(-((((lambda41)).^2)).*D.*t);
    Z42=(4./((R.^2).*(lambda42).^2)).*exp(-((((lambda42)).^2)).*D.*t);
    Z43=(4./((R.^2).*(lambda43).^2)).*exp(-((((lambda43)).^2)).*D.*t);
    Z44=(4./((R.^2).*(lambda44).^2)).*exp(-((((lambda44)).^2)).*D.*t);
    Z45=(4./((R.^2).*(lambda45).^2)).*exp(-((((lambda45)).^2)).*D.*t);
    Z46=(4./((R.^2).*(lambda46).^2)).*exp(-((((lambda46)).^2)).*D.*t);
    Z47=(4./((R.^2).*(lambda47).^2)).*exp(-((((lambda47)).^2)).*D.*t);
    Z48=(4./((R.^2).*(lambda48).^2)).*exp(-((((lambda48)).^2)).*D.*t);
    Z49=(4./((R.^2).*(lambda49).^2)).*exp(-((((lambda49)).^2)).*D.*t);
    Z50=(4./((R.^2).*(lambda50).^2)).*exp(-((((lambda50)).^2)).*D.*t);    
    
end  
ZC=Z1+Z2+Z3+Z4+Z5+Z6+Z7+Z8+Z9+Z10+Z11+Z12+Z13+Z14+Z15+Z16+Z17+Z18+Z19+Z20+Z21+Z22+Z23+Z24+Z25+Z26+Z27+Z28+Z29+Z30+Z31+Z32+Z33+Z34+Z35+Z36+Z37+Z38+Z39+Z40+Z41+Z42+Z43+Z44+Z45+Z46+Z47+Z48+Z49+Z50;
Cbar=(Co).*(1-ZC);   
Rmaxt=(sqrt(4.*D.*((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm)))./Phi));
r(r(:,:)<(Rmax-Rmaxt(:,:)))=nan;
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((((-1).^(n))./n).*exp(-D.*t.*(n.*pi./(Rmaxt)).^2)).*(sin(((n.*pi)./(Rmaxt.^2)).*((r-Rmax+Rmaxt).^2))));
    end
C=(((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm))).*(r-Rmax+Rmaxt).^2)./(Rmaxt.^2)+((2.*(((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm)))))./pi).*Z; 
C=real(C);

mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;

surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 
 

%% if Equation 12% Limited, Sphere, Yes, Inward
elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

Dstring = get(handles.dTag,'String');
cString = get(handles.cTag,'String');
vmString = get(handles.vmTag,'String');
maxString = get(handles.maxTag,'String');
phiString = get(handles.phiTag, 'String'); 
tendString = get(handles.tendTag, 'String');

D=str2num(Dstring);
Co=str2num(cString);
Vm=str2num(vmString);
Phi=str2num(phiString);
Rmax=str2num(maxString);
tend=str2num(tendString);
 
Vc=1;
R=Rmax;
Phi=(6.*Co.*D)./(Rmax.^2);
tend=((Co)./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));
r = linspace(0,Rmax,500);
t = linspace(0,tend,500);
[r, t]=meshgrid(r,t);

ZC=0;    
i=1000;
for n=1:i;
    ZC=ZC+(1./((n.^2))).*exp(-D.*t.*((n.*pi./R).^2));
end  
Cbar=(Co).*(1-(6./(pi.^2)).*ZC);

Z=0;    
Rmaxt=(sqrt(6.*D.*((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm)))./Phi));
r(r(:,:)<(Rmax-Rmaxt(:,:)))=nan;
Z=0;    
i=1000;
    for n=1:i;
        Z=Z+(((((-1).^(n))./n).*exp(-D.*t.*(n.*pi./(Rmaxt)).^2)).*(sin(((n.*pi)./(Rmaxt.^2)).*((r-Rmax+Rmaxt).^2))));
    end
C=(((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm))).*(r-Rmax+Rmaxt).^2)./(Rmaxt.^2)+((2.*(((Co)-Phi.*t.*(Vc./Vm)-Cbar.*(Vc./(Vc+Vm)))))./pi).*Z; 
C=real(C);

mesh(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;

surf(r,t,C);
xlabel('r (mm)');
ylabel('t (s)'); 
zlabel('C (M)');
axis auto;
axis([0 R 0 tend 0 Co]);
colormap bone; 
cmap=colormap;
cmap=flipud(colormap);
colormap(cmap);
shading flat; 
shading interp; 

else
    msgbox('Please choose a different configuration and then click Apply Choices');
    
    
end


%end Run callback function%



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;


function vmTag_Callback(hObject, eventdata, handles)
% hObject    handle to vmTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vmTag as text
%        str2double(get(hObject,'String')) returns contents of vmTag as a double


% --- Executes during object creation, after setting all properties.
function vmTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vmTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phiTag_Callback(hObject, eventdata, handles)
% hObject    handle to phiTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phiTag as text
%        str2double(get(hObject,'String')) returns contents of phiTag as a double


% --- Executes during object creation, after setting all properties.
function phiTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phiTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxTag_Callback(hObject, eventdata, handles)
% hObject    handle to maxTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxTag as text
%        str2double(get(hObject,'String')) returns contents of maxTag as a double


% --- Executes during object creation, after setting all properties.
function maxTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cTag_Callback(hObject, eventdata, handles)
% hObject    handle to cTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cTag as text
%        str2double(get(hObject,'String')) returns contents of cTag as a double


% --- Executes during object creation, after setting all properties.
function cTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dTag_Callback(hObject, eventdata, handles)
% hObject    handle to dTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dTag as text
%        str2double(get(hObject,'String')) returns contents of dTag as a double


% --- Executes during object creation, after setting all properties.
function dTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in applyChoicesTag.
function applyChoicesTag_Callback(hObject, eventdata, handles)
% hObject    handle to applyChoicesTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla;

 
diffusant = get(handles.diffusantButtonGroup, 'SelectedObject');
diffusantSelection = get(diffusant, 'String');
setappdata(0,'diffusant_Selection',diffusantSelection);

construct = get(handles.constructButtonGroup, 'SelectedObject');
constructSelection = get(construct, 'String');
setappdata(0,'construct_Selection',constructSelection);
 
metabolism = get(handles.metabolismButtonGroup, 'SelectedObject');
metabolismSelection = get(metabolism, 'String');
setappdata(0,'metabolism_Selection',metabolismSelection);
 
diffusion = get(handles.diffusionButtonGroup, 'SelectedObject');
diffusionSelection = get(diffusion, 'String');
setappdata(0,'diffusion_Selection',diffusionSelection);

defaultValuesTag_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in unlimitedTag.
function unlimitedTag_Callback(hObject, eventdata, handles)
% hObject    handle to unlimitedTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of unlimitedTag


% --- Executes when selected object is changed in diffusantButtonGroup.
function diffusantButtonGroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in diffusantButtonGroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function diffusantButtonGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to diffusantButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in defaultValuesTag.
function defaultValuesTag_Callback(hObject, eventdata, handles)
% hObject    handle to defaultValuesTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%add set data option

diffusant_choice = getappdata(0,'diffusant_Selection');
construct_choice = getappdata(0,'construct_Selection');
metabolism_choice = getappdata(0,'metabolism_Selection');
diffusion_choice = getappdata(0,'diffusion_Selection');

if strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')

%Estalibshes Initial Default Values
D=0.0001;
Co=0.01; 
Phi=0;
tend=120000;
Vm=5;
Tmax=4;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = num2str(Vm);
phiTagString = num2str(Phi); 
maxTagString = num2str(Tmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);

elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')

%Estalibshes Initial Default Values
D=0.0001; 
Co=0.01; 
tend=8000;
Rmax=1;
Phi=0;


dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);


elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Outward')

D=0.0001; 
Co=0.01; 
tend=8000;
Rmax=1;
Phi=0;


dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);


elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')

D=0.001; 
Co=0.00022; 
Tmax=4;
Phi=0;
tend=4000;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Tmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);


elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')

D=0.001;
Co=0.00022;
tend=1000;
Rmax=1;
Phi=0;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);



elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'No') && strcmp(diffusion_choice,'Inward')

D=0.001;
Co=0.00022; 
tend=1000;
Rmax=1;
Phi=0;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);



elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')
 
D=0.001; 
Co=0.00022; 
T=4; 
Tmax=T;
Phi=(2.*Co.*D)./(Tmax.^2);
tend=4000;


dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Tmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);

elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')
 
D=0.001;
Co=0.00022; 
Rmax=1;
Phi=(4.*Co.*D)./(Rmax.^2);
tend=1000;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);


set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);



elseif strcmp(diffusant_choice,'Unlimited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

D=0.001; 
Co=0.00022;
Rmax=1;
Phi=(6.*Co.*D)./(Rmax.^2);
tend=1000;

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = ' ';
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);


set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);



elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Slab') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

D=0.0001;
Co=0.01; 
Vm=5;
Vc=1;
T=4;
Tmax=T;
Phi=(2.*Co.*D)./(Tmax.^2);
tend=(Co./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));

dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = num2str(Vm);
phiTagString = num2str(Phi);
maxTagString = num2str(Tmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);

elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Cylinder') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

D=0.0001; 
Co=0.01; 
Vm=5;
Vc=1;
Rmax=1;
Phi=(4.*Co.*D)./(Rmax.^2);
tend=(Co./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));


dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = num2str(Vm);
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);


set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);


elseif strcmp(diffusant_choice,'Limited') && strcmp(construct_choice,'Sphere') && strcmp(metabolism_choice,'Yes') && strcmp(diffusion_choice,'Inward')

D=0.0001; 
Co=0.01; 
Vm=5;
Vc=1;
Rmax=1;
Phi=(6.*Co.*D)./(Rmax.^2);
tend=(Co./Phi).*((Vm.^2)./(Vc.^2+Vc.*Vm));


dTagString = num2str(D);
cTagString = num2str(Co);
vmTagString = num2str(Vm);
phiTagString = num2str(Phi);
maxTagString = num2str(Rmax);
tendTagString = num2str(tend);

set(handles.dTag,'String',dTagString);
set(handles.cTag,'String',cTagString);
set(handles.vmTag,'String',vmTagString);
set(handles.maxTag,'String',maxTagString);
set(handles.phiTag, 'String', phiTagString);
set(handles.tendTag, 'String', tendTagString);

else
    msgbox('Please select a valid set of initial settings and then click Apply Choices');

end



function tendTag_Callback(hObject, eventdata, handles)
% hObject    handle to tendTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tendTag as text
%        str2double(get(hObject,'String')) returns contents of tendTag as a double


% --- Executes during object creation, after setting all properties.
function tendTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tendTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over defaultValuesTag.
function defaultValuesTag_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to defaultValuesTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
