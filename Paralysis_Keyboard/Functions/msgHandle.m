function [msg,speech] = msgHandle(msg,cursor,keyboard)
% handles message update

speech=0;
ch=keyboard(cursor==1);
if ch~='#' && ch~='$'
    msg=[msg ch];
elseif ch=='#'
    if ~isempty(msg)
        msg=msg(1:end-1);
    end
else
    if isempty(msg)
        speech=0;
    else
        speech=1;
    end
end

end

