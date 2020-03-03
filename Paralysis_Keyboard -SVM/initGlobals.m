function initGlobals()

global svm axisMetaData keyboard cursor msg speech;
axisMetaData=zeros(4,15);
keyboard=[  'ABCDEFG';
            'HIJKLMN';
            'OPQRSTU';
            'VWXYZ#$';
            '       '];
cursor=zeros(5,7);
cursor(4,7)=1;
msg=[];
speech=0;
svm={};