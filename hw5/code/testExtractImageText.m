clear variables
close all 
clc

fname1='../images/01_list.jpg';
text1 = extractImageText(fname1)
textgt1='TODOLIST1MAKEATODOLIST2CHECKOFFTHEFIRSTTHINGONTODOLIST3REALIZEYOUHAVEALREADYCOMPLETED2THINDS4REWARDYOURSELFWITHANAP';
numcorrect1=sum(text1==textgt1);
accuracy1=numcorrect1/length(text1);

fname2='../images/02_letters.jpg';
text2= extractImageText(fname2)
textgt2='ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
numcorrect2=sum(text2==textgt2);
accuracy2=numcorrect2/length(text2);

fname3='../images/03_haiku.jpg';
text3= extractImageText(fname3)
textgt3='HAIKUSAREEASYBUTSOMETIMESTHEYDONTMAKESENSEREFRIGERATOR';
numcorrect3=sum(text3==textgt3);
accuracy3=numcorrect3/length(text3);

fname4='../images/04_deep.jpg';
text4= extractImageText(fname4)
textgt4='DEEPLEARNINGDEEPERLEARNINGDEEPESTLEARNING';
numcorrect4=sum(text4==textgt4);
accuracy4=numcorrect4/length(text4);
