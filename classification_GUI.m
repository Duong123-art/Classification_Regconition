function varargout = classification_GUI(varargin)
%CLASSIFICATION_GUI MATLAB code file for classification_GUI.fig
%      CLASSIFICATION_GUI, by itself, creates a new CLASSIFICATION_GUI or raises the existing
%      singleton*.
%
%      H = CLASSIFICATION_GUI returns the handle to a new CLASSIFICATION_GUI or the handle to
%      the existing singleton*.
%
%      CLASSIFICATION_GUI('Property','Value',...) creates a new CLASSIFICATION_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to classification_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CLASSIFICATION_GUI('CALLBACK') and CLASSIFICATION_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CLASSIFICATION_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classification_GUI

% Last Modified by GUIDE v2.5 25-Nov-2021 14:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classification_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @classification_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before classification_GUI is made visible.
function classification_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for classification_GUI
handles.output = hObject;

handles.isInitialized = 0;

handles.checkClassifyVisible = true;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes classification_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classification_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function Display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Display


function display_Image(path,handles)
    im = imread(path);
    axis(handles.Display);
    imagesc(im);
 
    
    

% --- Executes on button press in Upload.

function Upload_Callback(hObject, eventdata, handles)
    setappdata(handles.Upload, 'isError', 0);
    
    isError = getappdata(handles.Upload, 'isError');
    
    if isError == 0
        set(handles.Error, 'Visible', 'off');
    end
    
    try
    
        if handles.isInitialized == 0
            numOfFile = 0;
            ordina_display = 0;
        
            setappdata(handles.Classification, 'isClassified', false);
        
            rawname = [];
            rawpath = [];
        
            handles.isInitialized = 1;
            guidata(hObject, handles);
        
        else
            
            numOfFile = getappdata(handles.Upload,'numOfFile');
            ordina_display = getappdata(handles.Upload,'ordina_display');
        
            rawname = getappdata(handles.Upload,'rawname');
            rawpath = getappdata(handles.Upload,'rawpath');
        end
  
        if numOfFile == 0
            [rawname,rawpath] = uigetfile({'*.Jpg*','*.png*'}, 'Select Image data', 'MultiSelect', 'on');
        
            type = class(rawname);
        
            switch type
                case 'double'
                    numOfFile = 0;
                case 'char'
                    numOfFile = 1;
                case 'cell'
                    numOfFile = length(rawname);
            end
        
        %Luu data da khoi tao de su dung o cac ham khac
            setappdata(handles.Upload,'numOfFile' ,numOfFile);
            setappdata(handles.Upload,'rawname' ,rawname);
            setappdata(handles.Upload,'rawpath' ,rawpath);
        
%-------------------------------------------------------------------------------------------------     
%--------------------------An/ Hien cac component theo dung logic--------------------------------- 

            if numOfFile > 1
                ordina_display = ordina_display + 1;
            
                setappdata(handles.Upload, 'ordina_display', ordina_display);
            
                set(handles.Display, 'Visible', 'on');
                set(handles.Imageamount, 'Visible', 'on');
                set(handles.Imageamount, 'String' , strcat(num2str(ordina_display),'/',num2str(numOfFile)));
            
                set(handles.Next, 'Visible', 'on');
            else
                setappdata(handles.Upload, 'ordina_display', 0);
                
                if numOfFile == 1
                    setappdata(handles.Upload, 'ordina_display', 1);
                    set(handles.Display, 'Visible', 'on');
                    set(handles.Next, 'Visible', 'off');
                    set(handles.Previous, 'Visible', 'off');
                    set(handles.Imageamount, 'String' , strcat(num2str(numOfFile),'/',num2str(numOfFile)), 'Visible', 'on', 'FontSize', 20);
                end
            end
        
            
            
          else
            
                if ordina_display > 1
                set(handles.Next, 'Visible', 'on');
                set(handles.Previous, 'Visible', 'on');
                end
           
           
        end
    
        if ordina_display == numOfFile && numOfFile ~= 1
            set(handles.Next, 'Visible', 'off');
            set(handles.Previous, 'Visible', 'on');
        end
        
        if ordina_display == 1 && numOfFile ~= 1
            set(handles.Next, 'Visible', 'on');
            set(handles.Previous, 'Visible', 'off');
        end
    
%--------------------------------------------------------------------------
%-----------HIEN THI CAC LOP DA DUOC PHAN LOAI LEN GUI---------------------

        classLabel = '';
        classLabelColor = [];
    
        isClassified = getappdata(handles.Classification, 'isClassified');
        classificationResult = getappdata(handles.Classification, 'classificationResult');
    
        if isClassified == true
            if(classificationResult(1,ordina_display) == 1)
                classLabelColor = [1 0 0];
                classLabel = 'Chili';
     
            elseif(classificationResult(1,ordina_display) == 2)
                classLabelColor = [0.8 0.55 0.17];
                classLabel = 'Star Anise';
            elseif(classificationResult(1,ordina_display) == 3)
                classLabelColor = [0.93 0.69 0.13];
                classLabel = 'Ginger';
            elseif(classificationResult(1,ordina_display) == 4)
                classLabelColor = [0 1 0];
                classLabel = 'Lemongrass';
            else
                classLabelColor = [1 1 0];
                classLabel = 'Onion';
            end
        
            set(handles.Classlabel, 'String' , classLabel, 'BackgroundColor' , classLabelColor);
        end
    
        if numOfFile == 1
            fullname = strcat(char(rawpath) ,char(rawname));
   
        elseif numOfFile == 0
            fullname = '';
            set(handles.Next,'Visible', 'off');
            set(handles.Previous, 'Visible', 'off');
        else
            fullname = strcat(char(rawpath) ,char(rawname(1,ordina_display)));
        end
    
    
        if handles.checkClassifyVisible == true && numOfFile ~= 0
            set(handles.Classification, 'Visible', 'on', 'String', 'Classify', 'BackgroundColor', [0.85 0.33 0.1]);
        else
            set(handles.Classification, 'Visible', 'off','String', 'Classify', 'BackgroundColor', [0.85 0.33 0.1]);
            handles.checkClassifyVisible = true;
            guidata(hObject, handles);
        end
    
        if numOfFile > 0
            set(handles.Upload, 'Visible', 'off');
        
            display_Image(fullname, handles);
        end
   catch e
            setappdata(handles.Upload,'isError',1);
            TestAgain_Callback(hObject, eventdata, handles);
    end

% --- Executes during object creation, after setting all properties.
function Upload_CreateFcn(hObject, eventdata, handles)



% --- Executes on button press in Previous.
function Previous_Callback(hObject, eventdata, handles)
    try
%--------------------------------------------------------------------------
%---------- KIEM TA DATA CO BI THAY DOI O CAC HAM KHAC KHONG --------------

        ordina_display = getappdata(handles.Upload,'ordina_display') - 1;
        numOfFile = getappdata(handles.Upload,'numOfFile');
    
    
        setappdata(handles.Upload,'ordina_display', ordina_display);
   
    
        set(handles.Imageamount, 'String' , strcat(num2str(ordina_display),'/',num2str(numOfFile)));
    
        Upload_Callback(hObject, eventdata, handles);
    catch e
        setappdata(handles.Upload, 'isError', 1);
        TestAgain_Callback(hObject, eventdata, handles);
    end


% --- Executes on button press in Next.
function Next_Callback(hObject, eventdata, handles)
    try
        ordina_display = getappdata(handles.Upload,'ordina_display') + 1;
        numOfFile = getappdata(handles.Upload,'numOfFile');
    
        setappdata(handles.Upload,'ordina_display', ordina_display);
    
        set(handles.Imageamount, 'String' , strcat(num2str(ordina_display),'/',num2str(numOfFile)));
    
        Upload_Callback(hObject, eventdata, handles);
    catch e
        setappdata(handles.Upload, 'isError', 1);
        TestAgain_Callback(hObject, eventdata, handles);
    end



% --- Executes during object creation, after setting all properties.
function Imageamount_CreateFcn(hObject, eventdata, handles)


function Imageamount_Callback(hObject, eventdata, handles)


% --- Executes on button press in Classification.
function Classification_Callback(hObject, eventdata, handles)
  try 
    set(handles.Classification, 'String', 'Processing...', 'BackgroundColor', [0.8 0.8 0.8]);
    
    handles.checkClassifyVisible = false;
    guidata(hObject, handles);
    
    %update data from upload-callback
    numOfFile = getappdata(handles.Upload, 'numOfFile');
    rawname = getappdata(handles.Upload, 'rawname');
    rawpath = getappdata(handles.Upload, 'rawpath');
    ordina_display = getappdata(handles.Upload, 'ordina_display');
    rawpath = getappdata(handles.Upload, 'rawpath');
  
      
    set(handles.Display,'Visible', 'off');
    set(handles.Previous,'Visible', 'off');
    set(handles.Next,'Visible', 'off');
    set(handles.Imageamount,'Visible', 'off');
    
    all_distance = [];
    classificationResult = [];
    
    %Get K value from userInput
    k = str2num(get(handles.InputK,'String'));

    method = get(handles.SelectMethod,'Value');
    
    onionAmount = 0;
    chiliAmount = 0;
    gingerAmount = 0;
    starAniseAmount = 0;
    lemongrassAmount = 0;
    
    if  method == 1

    %---------------------------------------------------------------------
    %-------------------------- HOG --------------------------------------
  
        format long
    
        trainData = csvread('trainData.csv');

    %---------------------------------STEP 1----------------------------------
    %---------------------------------------------------------------------------
   

        for v = 1: numOfFile
            if numOfFile == 1
                im = imread(strcat(char(rawpath), char(rawname)));
            else
                im = imread(strcat(char(rawpath), char(rawname(1, v))));
            end

            imgray = imresize(im, [64 128]);

            [width, height] = size(imgray);

    %---------------------------------STEP 2----------------------------------
    %---------------------------------------------------------------------------

            hx = [-1, 0 ,+1];
            hy = hx';

            fx = imfilter(imgray, hx);
            fy = imfilter(imgray, hy);



    %---------------------------------STEP 3----------------------------------
    %---------------------------------------------------------------------------

            Gabs = sqrt(double(fx.^2 +fy.^2));
            Gtheta = atand(double(fy./fx));



    %---------------------------------STEP 4----------------------------------
    %---------------------------------------------------------------------------
    %Tao cell 8x8
            cell88 = [];

            for it = 1:(width/8)
                for j = 1 : (height/8)
                    cell88 = [cell88 ; [HOG_vector(imgray(8*it - 7: 8*it ,8*j - 7 : 8*j), Gabs(8*it - 7: 8*it ,8*j - 7 : 8*j),  Gtheta(8*it - 7: 8*it ,8*j - 7 : 8*j))]];
                end
            end

            his_norm = [];

            for wid = 1 : 119
                if rem(wid, 8) == 0
                    continue;
                end
                his_norm = [his_norm ; [cell88(wid,:) cell88(wid + 1, :) cell88(wid + 8, :) cell88(wid + 9, :)]]
   
            end

    %normlize histogram 16x16
            for in = 1: 400
                 all_distance = [all_distance distance(trainData((105 * in - 104):105*in ,:), his_norm)];
            end
        end
%--------------------------------------------------------------------------
%------------------------ KNN ---------------------------------------------

    %Sort and choose k of minimum and decision
        for il = 1 : numOfFile
            each_image_distance = all_distance(1, 400 * il - 399 : il * 400);
            minIndex = [1:1:length(each_image_distance)];
 
            for ir = 1 : length(each_image_distance)
                for j = 1: length(each_image_distance) - ir
                    if each_image_distance(1,j) >= each_image_distance(1,j+1)
                        
                        temp = each_image_distance(1,j);
                        each_image_distance(1,j) = each_image_distance(1,j+1);
                        each_image_distance(1,j + 1) = temp;
              
                        temp1 = minIndex(1,j);
                        minIndex(1,j) = minIndex(1,j + 1);
                        minIndex(1,j+ 1) = temp1;
                    end
                end
      
            end
    
    %count amount of gingerresult in which class has more
        k_mins = minIndex(1:k);
        chili = 0;
        onion = 0;
        lemonGrass = 0;
        ginger = 0;
        starAnise = 0;
    
    % 1-Ot  2-Hanh tay
        for iter = 1 : k
            if k_mins(1,iter) >= 1 && k_mins(1,iter) <= 80
                chili = chili + 1;
            elseif k_mins(1,iter) > 80 && k_mins(1,iter) <= 160
                starAnise = starAnise + 1;
            elseif k_mins(1,iter) > 160 && k_mins(1,iter) <= 240
                ginger = ginger + 1;
            elseif k_mins(1,iter) > 240 && k_mins(1,iter) <= 320
                lemonGrass = lemonGrass + 1;
            else
                onion = onion + 1;
            end
        
        end
    
   %classification
    
        maxAmount = max([chili lemonGrass ginger onion starAnise]);
        
        switch maxAmount
        case chili
            classificationResult = [classificationResult [1]];
        case starAnise
            classificationResult = [classificationResult [2]];
        case ginger
            classificationResult = [classificationResult [3]];
        case lemonGrass
            classificationResult = [classificationResult [4]];
        case onion
            classificationResult = [classificationResult [5]];
        end
    
        end
        
        for i = 1 : numOfFile
            if (classificationResult(1,i) == 1) 
                chiliAmount = chiliAmount + 1;
            end
            if classificationResult(1,i) == 2 
                starAniseAmount = starAniseAmount + 1;
            end
             if classificationResult(1,i) == 3 
                 gingerAmount = gingerAmount + 1;
             end
             if classificationResult(1,i) == 4 
                 lemongrassAmount = lemongrassAmount + 1;
             end
             if classificationResult(1,i) == 5 
                 onionAmount = onionAmount + 1;
             end
   
        end
        
    else
        
%--------------------------------------------------------------------------
%------------------ HU MOMENTS --------------------------------------------

        fe = xlsread('extract_feature.xlsx');
        nu = 400;


        for v = 1: numOfFile
            if numOfFile == 1
                im = imread(strcat(char(rawpath), char(rawname)));
            else
                im = imread(strcat(char(rawpath), char(rawname(1, v))));
            end
            
            vark(1,k) = 0;
            
            [hs h] = Recognition_Hu(im,k,fe,nu);
            for a = 1:400
                for c = 1:k
                    if(hs(1,c)== h(a,1))
                        vark(1,c) = a;
                    end
                end
            end

%--------------------------------------------------------------------------
%--------------------------- KNN ------------------------------------------

            lop(1,5) = 0;
            result(1,1) = 0;
            lon = 0;
            i = 1;
            
            for j = 1:k
                if (vark(i,j) >= 0 && vark(i,j) <= 80) 
                    lop(1,1) = lop(1,1) + 1; 
                end
                if (vark(i,j)>= 81 && vark(i,j) <= 160) 
                    lop(1,2) = lop(1,2) + 1; 
                end
                if (vark(i,j) >= 161 && vark(i,j) <= 240) 
                    lop(1,3) = lop(1,3) + 1; 
                end
                if (vark(i,j) >= 241 && vark(i,j) <= 320) 
                    lop(1,4) = lop(1,4)+ 1;
                end
                if (vark(i,j) >= 321 && vark(i,j)<= 400) 
                    lop(1,5) = lop(1,5) + 1; 
                end
                
                lon = lop(1,1);
                
                for a = 1:5
                    if(lon < lop(1,a)) 
                        lon = lop(1,a);
                    end
                end
                for a = 1:5
                    if(lon == lop(1,a)) 
                        result(i,1) = a;
                    end
                end
                for a = 1:5
                    lop(1,a) = 0;
                end
            end
            result2(1,v) = result;
        end
    
        classificationResult=result2;
   
   
        for i = 1 : v
            if (classificationResult(1,i) == 1) 
                chiliAmount = chiliAmount + 1;
            end
            if classificationResult(1,i) == 2 
                starAniseAmount = starAniseAmount + 1;
            end
             if classificationResult(1,i) == 3 
                 gingerAmount = gingerAmount + 1;
             end
             if classificationResult(1,i) == 4 
                 lemongrassAmount = lemongrassAmount + 1;
             end
             if classificationResult(1,i) == 5 
                 onionAmount = onionAmount + 1;
             end
   
        end
    end
    
    
   

    
    setappdata(handles.Classification,'classificationResult', classificationResult);
    
    set(handles.Display,'Visible', 'on', 'Position' , [53 32 85.85 20]);
    set(handles.Previous,'Position', [45.95 25 18.28 3.588]);
    set(handles.Next, 'Position', [128.286 25 18.28 3.588]);
    
    if ordina_display > 1
        set(handles.Previous,'Visible', 'on','Position', [45.95 25 18.28 3.588]);
    end
    
    if ordina_display < numOfFile
        set(handles.Next,'Visible', 'on', 'Position', [128.286 25 18.28 3.588]);
    end
    
    set(handles.Imageamount,'Visible', 'on', 'Position', [82.14 26 27 3.117], 'FontSize' , 12);
    
    if(classificationResult(1,ordina_display) == 1)
        classLabelColor = [1 0 0];
        classLabel = 'Chili';
     
    elseif(classificationResult(1,ordina_display) == 2)
        classLabelColor = [0.8 0.55 0.17];
        classLabel = 'Star Anise';
    elseif(classificationResult(1,ordina_display) == 3)
        classLabelColor = [0.93 0.69 0.13];
        classLabel = 'Ginger';
    elseif(classificationResult(1,ordina_display) == 4)
        classLabelColor = [0 1 0];
        classLabel = 'Lemongrass';
    else
        classLabelColor = [1 1 0];
        classLabel = 'Onion';
    end
    
    set(handles.Classlabel, 'String' , classLabel , 'Visible', 'on', 'BackgroundColor' , classLabelColor);
    
    setappdata(handles.Classification, 'isClassified', true);
   
    
    set(handles.TotalOfGinger, 'Visible', 'On', 'String', 'Total of ginger:', 'FontWeight' , 'normal');
    set(handles.GingerResult, 'Visible', 'On', 'String', num2str(gingerAmount));
    
    set(handles.TotalOfChili, 'Visible', 'On','String', 'Total of chili:', 'FontWeight' , 'normal');
    set(handles.ChiliResult, 'Visible', 'On', 'String', num2str(chiliAmount));
    
    set(handles.TotalOfOnion, 'Visible', 'On','String', 'Total of onion:', 'FontWeight' , 'normal');
    set(handles.OnionResult, 'Visible', 'On', 'String', num2str(onionAmount));
    
    set(handles.TotalOflemonGrass, 'Visible', 'On','String', 'Total of lemongrass:', 'FontWeight' , 'normal');
    set(handles.LemonGrassResult, 'Visible', 'On', 'String', num2str(lemongrassAmount));
    
    set(handles.TotalOfStarAnise, 'Visible', 'On','String', 'Total of star anise:', 'FontWeight' , 'normal');
    set(handles.StarAniseResult, 'Visible', 'On', 'String', num2str(starAniseAmount));
    
    
    set(handles.ViewConfusionMatrix, 'Visible', 'On');
    set(handles.TestAgain, 'Visible', 'on');
   
    Upload_Callback(hObject, eventdata, handles);
  catch e
      setappdata(handles.Upload, 'isError', 1);
      TestAgain_Callback(hObject, eventdata, handles);
  end


% --- Executes on button press in ViewConfusionMatrix.
function ViewConfusionMatrix_Callback(hObject, eventdata, handles)
    close(classification_GUI);


% --- Executes on button press in TestAgain.
function TestAgain_Callback(hObject, eventdata, handles)
    handles.isInitialized = 0;
    guidata(hObject, handles);
    
    isError = getappdata(handles.Upload, 'isError');
 
    if isError == 1
        set(handles.Error,'Visible','on');
        setappdata(handles.Upload,'isError', 0);
    end
    
    setappdata(handles.Upload, 'numOfFile', 0);
    
    set(handles.TotalOfGinger, 'Visible', 'off');
    set(handles.GingerResult, 'Visible', 'off');
    
    set(handles.TotalOfChili, 'Visible', 'off');
    set(handles.ChiliResult, 'Visible', 'off');
    
    set(handles.TotalOfOnion, 'Visible', 'off');
    set(handles.OnionResult, 'Visible', 'off');
    
    
    set(handles.ViewConfusionMatrix, 'Visible', 'off');
    set(handles.TestAgain, 'Visible', 'off');

    set(handles.TotalOflemonGrass, 'Visible', 'off');
    set(handles.LemonGrassResult, 'Visible', 'off');
    
    set(handles.TotalOfStarAnise, 'Visible', 'Off');
    set(handles.StarAniseResult, 'Visible', 'Off');
    
    set(handles.Classification, 'Visible', 'off');
    set(handles.Previous, 'Position',[45.85 17.94 18.28 3.588], 'Visible', 'off');
    set(handles.Next, 'Position',[128.28 17.94 18.28 3.588], 'Visible', 'off');
    set(handles.Classlabel, 'Visible', 'off');
    set(handles.Imageamount,'Position',[82.14 17.94 27 3.117], 'Visible', 'off');
    
    
    %delete showed image before
    imageAxies = findobj(gca, 'Type', 'image');
    if ~isempty(imageAxies)
        delete(imageAxies);
    end
    set(handles.Display,'Position',[53 25.23 85.85 28.17], 'Visible', 'off');
   
    
    set(handles.Upload,'Visible', 'on');
    


% --- Executes during object creation, after setting all properties.
function TotalOfGinger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalOfGinger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function InputOnion_Callback(hObject, eventdata, handles)
% hObject    handle to InputOnion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputOnion as text
%        str2double(get(hObject,'String')) returns contents of InputOnion as a double


% --- Executes during object creation, after setting all properties.
function InputOnion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputOnion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputChili_Callback(hObject, eventdata, handles)
% hObject    handle to InputChili (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputChili as text
%        str2double(get(hObject,'String')) returns contents of InputChili as a double


% --- Executes during object creation, after setting all properties.
function InputChili_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputChili (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputLemongrass_Callback(hObject, eventdata, handles)
% hObject    handle to InputLemongrass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputLemongrass as text
%        str2double(get(hObject,'String')) returns contents of InputLemongrass as a double


% --- Executes during object creation, after setting all properties.
function InputLemongrass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputLemongrass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputStarAnise_Callback(hObject, eventdata, handles)
% hObject    handle to InputStarAnise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputStarAnise as text
%        str2double(get(hObject,'String')) returns contents of InputStarAnise as a double


% --- Executes during object creation, after setting all properties.
function InputStarAnise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputStarAnise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputGinger_Callback(hObject, eventdata, handles)
% hObject    handle to InputGinger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputGinger as text
%        str2double(get(hObject,'String')) returns contents of InputGinger as a double


% --- Executes during object creation, after setting all properties.
function InputGinger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputGinger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SelectMethod.
function SelectMethod_Callback(hObject, eventdata, handles)
% hObject    handle to SelectMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SelectMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SelectMethod


% --- Executes during object creation, after setting all properties.
function SelectMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function InputK_Callback(hObject, eventdata, handles)
% hObject    handle to InputK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputK as text
%        str2double(get(hObject,'String')) returns contents of InputK as a double


% --- Executes during object creation, after setting all properties.
function InputK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Train.
function Train_Callback(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Test.
function Test_Callback(hObject, eventdata, handles)
    set(handles.Upload,'Visible', 'on');
    
    set(handles.Test,'Visible', 'off');
    set(handles.Method, 'Visible', 'off');
    set(handles.KValue, 'Visible', 'off');
    set(handles.WarmUp, 'Visible', 'off');
    set(handles.ModelGoal, 'Visible', 'off');
    set(handles.InputK, 'Visible', 'off');
    set(handles.SelectMethod, 'Visible', 'off');
    set(handles.ClassifyMethod, 'Visible', 'off');
    set(handles.Knumber, 'Visible', 'off');
    
    


% --- Executes on selection change in ClassifyMethod.
function ClassifyMethod_Callback(hObject, eventdata, handles)
    classifyMethod = get(handles.ClassifyMethod, 'Value');
    
    if classifyMethod == 1
        set(handles.InputK, 'Visible', 'on');
        set(handles.Knumber, 'Visible', 'on');
    else
        set(handles.InputK, 'Visible', 'off');
        set(handles.Knumber, 'Visible', 'off');
    end
% hObject    handle to ClassifyMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ClassifyMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ClassifyMethod


% --- Executes during object creation, after setting all properties.
function ClassifyMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ClassifyMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
