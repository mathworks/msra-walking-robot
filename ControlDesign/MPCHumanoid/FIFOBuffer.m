classdef FIFOBuffer < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon & matlab.system.mixin.SampleTime
    % FIFOBuffer Implements a FIFO Buffer
    %
    % Copyright 2018 The MathWorks, Inc.


    % Public, tunable properties
    properties(Dependent)
        NumElements
        Elements
    end

    % Public, non-tunable properties
    properties(Nontunable)
        % Buffer capacity
        Capacity = 5;
        
        % Number of states
        NumStates = 2;
        
        % Sample time
        SampleTime = 5e-3;
        
    end
    
    properties(Logical)        
        % Fill buffer at startup
        FillBufferAtStartup = false;        
    end
    
    properties(Nontunable)
        % Buffer data at startup [numStates x capacity]
        BufferStartupFillupData = zeros(2,5);
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        pIndexIn = 1;
        pIndexOut = 1;
        pNumElements = 0;        
        pBuffer;        
    end

    methods
        % Constructor
        function obj = FIFOBuffer(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:})
        end
    end

    methods(Access = protected)
        %% My functions       
       
        
        %% Common functions
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.initialize();
            
            % Fill buffer at startup
            if obj.FillBufferAtStartup
               obj.fillBuffer(obj.BufferStartupFillupData); 
            end
        end

        function [buffer, isFull] = stepImpl(obj,dataIn)
            %stepImpl - Add one data sample to buffer and return the
            %   whole buffer. The way we return the buffer is
            %  [oldestState, ... newestState]
            %  If the buffer is not full we add padding to represent
            %  the oldest values. You can also fill the buffer at startup
            %  by checking the flag FillBufferAtStartup if you are using
            %  simulink. Otherwise you can use the fillBuffer method in
            %  MATLAB.
            
            obj.push(dataIn);
            
            paddingValue = zeros(obj.NumStates,1);
            buffer = obj.getElementsWithPadding(paddingValue);
            
            %oldestState = obj.getOldestState(paddingValue);
            
            %buffer = obj.pBuffer;
            isFull = obj.isFull();
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        %% Backup/restore functions
        function s = saveObjectImpl(obj)
            % Set properties in structure s to values in object obj

            % Set public properties and states
            s = saveObjectImpl@matlab.System(obj);

            % Set private and protected properties
            %s.myproperty = obj.myproperty;
        end

        function loadObjectImpl(obj,s,wasLocked)
            % Set properties in object obj to values in structure s

            % Set private and protected properties
            % obj.myproperty = s.myproperty; 

            % Set public properties and states
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end

        %% Simulink functions
        function ds = getDiscreteStateImpl(obj)
            % Return structure of properties with DiscreteState attribute
            ds = struct([]);
        end

        function validateInputsImpl(obj,dataIn)
            % Validate inputs to the step method at initialization
            [numStates,~] = size(dataIn);
            if obj.NumStates ~= numStates
                error('Number of states of input data doesn''t match buffer number of states');
            end
        end

        function flag = isInputSizeMutableImpl(obj,index)
            % Return false if input size cannot change
            % between calls to the System object
            flag = false;
        end

        function [out1,out2] = getOutputSizeImpl(obj)
            % Return size for each output port
            out1 = [obj.NumStates obj.Capacity];
            out2 = 1;
        end

        function [out1,out2] = getOutputDataTypeImpl(obj)
            % Return data type for each output port
            out1 = "double";
            out2 = "logical";

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function [out1,out2] = isOutputComplexImpl(obj)
            % Return true for each output port with complex data
            out1 = false;
            out2 = false;

            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end

        function [out1,out2] = isOutputFixedSizeImpl(obj)
            % Return true for each output port with fixed size
            out1 = false;
            out2 = true;

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end

        function sts = getSampleTimeImpl(obj)
            % Define sample time type and parameters
            %sts = obj.createSampleTime("Type", "Inherited");

            % Example: specify discrete sample time
            sts = obj.createSampleTime("Type","Discrete","SampleTime",obj.SampleTime);
        end

        function icon = getIconImpl(obj)
            % Define icon for System block
            icon = mfilename("class"); % Use class name
            % icon = "My System"; % Example: text icon
            % icon = ["My","System"]; % Example: multi-line text icon
            % icon = matlab.system.display.Icon("myicon.jpg"); % Example: image file icon
        end
    end

    methods(Static, Access = protected)
        %% Simulink customization functions
        function header = getHeaderImpl
            % Define header panel for System block dialog
            header = matlab.system.display.Header(mfilename("class"));
        end

        function group = getPropertyGroupsImpl
            % Define property section(s) for System block dialog
            group = matlab.system.display.Section(mfilename("class"));
        end
    end
    
    methods
        function numElements = get.NumElements(obj)
            numElements = obj.pNumElements;
        end
        
        function elements = get.Elements(obj)
            if obj.pNumElements >= 1
                if obj.pIndexOut < obj.pIndexIn
                   elements = obj.pBuffer(:,obj.pIndexOut:obj.pIndexIn-1);
                else 
                   elements = [obj.pBuffer(:,obj.pIndexOut:end) obj.pBuffer(:,1:obj.pIndexIn-1)];
                end
            else
                elements = zeros(obj.NumStates,0);
            end            
        end
        
        function elements = getElementsWithPadding(obj,paddingValue)
            elements = zeros(obj.NumStates,obj.Capacity);
            if obj.pNumElements >= 1 && obj.pNumElements == obj.Capacity
                elements = obj.Elements(:,1:obj.pNumElements);
            elseif obj.pNumElements >=1 && obj.NumElements < obj.Capacity
                elements = [repmat(paddingValue, 1, obj.Capacity-obj.pNumElements),obj.Elements(:,1:obj.pNumElements)];
            else
                error('case not considered');
            end            
        end
        
        function rawBuffer = getRawBuffer(obj)
            rawBuffer = obj.pBuffer;
        end
        
         function initialize(obj)
            obj.pBuffer = zeros(obj.NumStates,obj.Capacity);
            obj.pIndexIn = 1;
            obj.pIndexOut = 1;
            obj.pNumElements = 0;
        end
        
        function isFull = isFull(obj)
            if(obj.pNumElements == obj.Capacity)
                isFull = true;
            else
                isFull = false;
            end
        end
        
        function success = push(obj, data)
            % Add new element to buffer             
            obj.pBuffer(:,obj.pIndexIn) = data;
            
            % Update new dataIn index
            obj.pIndexIn = mod(obj.pIndexIn,obj.Capacity)+1;
                        
            % If buffer is full we overwrite (Move outIndex in one)
            % If not full we increment the elements
            if obj.isFull()
                obj.pIndexOut = mod(obj.pIndexOut,obj.Capacity)+1;
            else
                % Update elements
                obj.pNumElements = obj.pNumElements + 1;
            end           
                       
            success = true;
        end
        
        function data = pop(obj)
            % If no elements do nothing
            if obj.pNumElements < 1
               data = zeros(obj.NumStates,0); 
            else
               % If it has elements take out oldest item
               data = obj.pBuffer(:,obj.pIndexOut);
               % Update IndexOut
               obj.pIndexOut = mod(obj.pIndexOut,obj.Capacity)+1;
               % Update elements
               obj.pNumElements = obj.pNumElements - 1;
            end
        end
        
        function data = getOldestState(obj,paddingValue)
            if obj.pNumElements >= 1
                data = obj.pBuffer(:,obj.pIndexOut);
            else
                data = paddingValue;
            end
        end
        
        function fillBuffer(obj, bufferData)
            % Validate inputs
            [r,c] = size(bufferData);
            if r ~= obj.NumStates || c ~= obj.Capacity
               error('FIFOBuffer::Buffer data is not the correct size');  
            end
            
            % Clean buffer and reset index
            obj.initialize();
            % Fill up buffer
            obj.pBuffer = bufferData;
            obj.pIndexOut = 1;
            obj.pIndexIn = 1;
            obj.pNumElements = obj.Capacity;
        end
        
    end
end
