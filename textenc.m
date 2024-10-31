
    [audioData, sampleRate] = audioread('Some.wav');
    
    % Convert the audio data to integer format if needed
    audioInt = int16(audioData * 32767);  % Assuming 16-bit PCM audio
    
    % Open the text file and read the contents
    fileID = fopen('anna.txt', 'r');
    textData = fread(fileID, '*char')';
    fclose(fileID);
    
    % Convert the text data to binary
    binaryText = dec2bin(textData, 8)';  % Convert each character to 8-bit binary
    binaryText = binaryText(:)';         % Reshape into a single row vector
    binaryText = binaryText - '0';       % Convert char '0' and '1' to numerical 0 and 1
    
    % Check if the audio file can hold the entire text
    numSamples = length(audioInt);
    if length(binaryText) > numSamples
        error('Text file is too large to fit in the audio file.');
    end
    
    % Hide the text in the least significant bit (LSB) of each audio sample
    for i = 1:length(binaryText)
        audioInt(i) = bitset(audioInt(i), 1, binaryText(i));
    end
    
    % Normalize the audio back to -1 to 1 range
    audioDataModified = double(audioInt) / 32767;
    outputfile='C:\Users\godes\OneDrive\Documents\MATLAB\outputt.wav'
    % Write the modified audio data to a new file
    audiowrite(outputfile , audioDataModified, sampleRate);
    
    disp('Text file successfully hidden in audio file.');

