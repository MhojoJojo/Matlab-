
% script to 
% Usage: 
% Input parameter:
%       
% Output parameter:
%       
% Output:
%    

% Author: Max Zimmermann
% Version History:

% ------------------------------------------------------------------------
% Samples Anfang/Ende, in welchen S�tzen: Datei + Satz, Ordner
% 
% function [SampleBegin, SampleEnd, FileName, Sentence, FolderName] = ...
%                                          WordSearch(word)
SampleBegin = [];
SampleEnd = [];
FileName = [];
Sentence = [];
FolderName = [];                    
begin = [];
fin = [];
word='greasy';

cd timit/'TIMIT MIT'
y = dir;
folders = [];

for folderidx = 1:length(y)
    folders = [folders regexp(y(folderidx).name,'.+-.+','match')];
end

for searchidx=1:length(folders)
    cd(char(folders(searchidx)))
    x = dir;
    names = [];

    for nameidx=1:length(x)
        names = [names regexp(x(nameidx).name,'.+\.wrd','match')];
    end

    for fileidx=1:length(names)
        fid = fopen(char(names(fileidx)));
        data = textscan(fid, '%s %s %[^0123456789]');
        fclose(fid);
        for wrdidx=1:length(data{3})
            wrd = data{3}{wrdidx};
            if length(word) == length(char(wrd(1:end-1)))
                FolderName = [FolderName ; folders(searchidx)];   
                begin = [begin '.' data{1}{wrdidx}];
                SampleBegin2 = strsplit(begin, '.');
                SampleBegin = SampleBegin2(2:end)';
                fin = [fin '.' data{2}{wrdidx}];
                SampleEnd2 = strsplit(fin,'.');
                SampleEnd = SampleEnd2(2:end)';
                FileName = [FileName ; names(fileidx)];
                file = char(names(fileidx));
                file = [file(1:end-3) 'txt'];
                fid = fopen(file);
                SenData = textscan(fid, '%s %s %[^0]');
                fclose(fid);
                Sentence = [Sentence SenData{3}{1}];
%                 break
            end
        end
           
    end
    cd ..
end
cd ../..

% [SampleBegin SampleEnd FileName Sentence FolderName]
length(SampleBegin)
length(SampleEnd)
length(FileName)
length(FolderName)
o = strsplit(Sentence,'.');
for idx=1:length(o)
    sen = o(idx);
    Sentence = [Sentence sen{1}];
end
length(Sentence)
% -------------------Licence ---------------------------------------------
% Copyright (c) <2015> Max Zimmermann
% Institute for Hearing Technology and Audiology
% Jade University of Applied Sciences Oldenburg 
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files 
% (the "Software"), to deal in the Software without restriction, including 
% without limitation the rights to use, copy, modify, merge, publish, 
% distribute, sublicense, and/or sell copies of the Software, and to 
% permit persons to whom the Software is furnished to do so, subject 
% to the following conditions:
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
% OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
