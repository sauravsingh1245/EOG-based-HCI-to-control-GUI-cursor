function initGlobals()

global bioRadioHandle isCollecting axisMetaData keyboard cursor rawdata test processingEN msg speech;
bioRadioHandle = -1;
isCollecting = 0;
axisMetaData=zeros(4,15);
keyboard=[  'ABCDEFG';
            'HIJKLMN';
            'OPQRSTU';
            'VWXYZ#$';
            '       '];
rawdata=[];
cursor=zeros(5,7);
cursor(4,7)=1;
msg=[];
speech=0;
test=false;         % test GUI without BioRadio150 with random signal
processingEN=true;  % enable signal processing before ploting and saving