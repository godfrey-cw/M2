p = 13;
K0=ZZ/p[a];
K1=K0/ideal(a^4-a^3+a^2-a+1);
KK=toField K1;
M=matrix {{0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128, 0, 0, 128}, {0, 192, -64*a^3-64*a^2-64*a, 0, 192, -64*a^2+128*a-64, 0, 192, 128*a^3+64*a-64, 0, 192, -64*a^3+128*a^2-128*a+64, 0, 192, -64*a^3+64*a^2-64, 0, 192, 64*a^3-64*a^2-128, 0, 192, -128*a^3+64*a^2-64*a+128, 0, 192, 64*a^3-64*a+64, 0, 192, 64*a^3-128*a^2+64*a, 0, 192, 64*a^2+64*a+64}, {64*a^3-64*a^2+64*a-64, 64*a^2+64*a+64, 0, 64*a^2, 64*a^3-64*a+64, 0, -64*a, -128*a^3+64*a^2-64*a+128, 0, -64*a^3, 64*a^3-128*a^2+64*a, 0, 64, -64*a^3+64*a^2-64, 0, 64, 64*a^3-64*a^2-128, 0, -64*a^3, -64*a^3-64*a^2-64*a, 0, -64*a, -64*a^3+128*a^2-128*a+64, 0, 64*a^3-64*a^2+64*a-64, -64*a^2+128*a-64, 0, 64*a^2, 128*a^3+64*a-64, 0}, {96, -96*a^3-96*a^2-96*a, 192*a^3-96*a^2+96*a-192, 96, -96*a^2+192*a-96, -96*a^3+192*a^2-96*a, 96, 192*a^3+96*a-96, -96*a^2-96*a-96, 96, -96*a^3+192*a^2-192*a+96, -96*a^3+96*a-96, 96, -96*a^3+96*a^2-96, 96*a^3-96*a^2+96, 96, 96*a^3-96*a^2-192, -96*a^3+96*a^2+192, 96, -192*a^3+96*a^2-96*a+192, -192*a^3-96*a+96, 96, 96*a^3-96*a+96, 96*a^2-192*a+96, 96, 96*a^3-192*a^2+96*a, 96*a^3-192*a^2+192*a-96, 96, 96*a^2+96*a+96, 96*a^3+96*a^2+96*a}, {32*a^2+32*a+32, 32*a^3, -448, 32*a^3-32*a+32, -32*a^3+32*a^2-32*a+32, -448, -64*a^3+32*a^2-32*a+64, -32*a^2, -448, 32*a^3-64*a^2+32*a, 32*a, -448, -32*a^3+32*a^2-32, -32, -448, 32*a^3-32*a^2-64, -32, -448, -32*a^3-32*a^2-32*a, 32*a, -448, -32*a^3+64*a^2-64*a+32, -32*a^2, -448, -32*a^2+64*a-32, 32*a^3, -448, 64*a^3+32*a-32, -32*a^3+32*a^2-32*a+32, -448}, {0, 288*a^3-288*a^2+288*a-288, 0, 0, 288*a^2, 0, 0, -288*a, 0, 0, -288*a^3, 0, 0, 288, 0, 0, 288, 0, 0, -288*a^3, 0, 0, -288*a, 0, 0, 288*a^3-288*a^2+288*a-288, 0, 0, 288*a^2, 0}, {0, 480*a^3-480*a^2+480*a-480, 0, 0, 480*a^2, 0, 0, -480*a, 0, 0, -480*a^3, 0, 0, 480, 0, 0, 480, 0, 0, -480*a^3, 0, 0, -480*a, 0, 0, 480*a^3-480*a^2+480*a-480, 0, 0, 480*a^2, 0}, {0, -720, 240*a^3+240*a^2+240*a, 0, -720, 240*a^2-480*a+240, 0, -720, -480*a^3-240*a+240, 0, -720, 240*a^3-480*a^2+480*a-240, 0, -720, 240*a^3-240*a^2+240, 0, -720, -240*a^3+240*a^2+480, 0, -720, 480*a^3-240*a^2+240*a-480, 0, -720, -240*a^3+240*a-240, 0, -720, -240*a^3+480*a^2-240*a, 0, -720, -240*a^2-240*a-240}, { -240*a^3+240*a^2-240*a+240, -240*a^2-240*a-240, 0, -240*a^2, -240*a^3+240*a-240, 0, 240*a, 480*a^3-240*a^2+240*a-480, 0, 240*a^3, -240*a^3+480*a^2-240*a, 0, -240, 240*a^3-240*a^2+240, 0, -240, -240*a^3+240*a^2+480, 0, 240*a^3, 240*a^3+240*a^2+240*a, 0, 240*a, 240*a^3-480*a^2+480*a-240, 0, -240*a^3+240*a^2-240*a+240, 240*a^2-480*a+240, 0, -240*a^2, -480*a^3-240*a+240, 0}, {160, -160*a^3-160*a^2-160*a, 320*a^3-160*a^2+160*a-320, 160, -160*a^2+320*a-160, -160*a^3+320*a^2-160*a, 160, 320*a^3+160*a-160, -160*a^2-160*a-160, 160, -160*a^3+320*a^2-320*a+160, -160*a^3+160*a-160, 160, -160*a^3+160*a^2-160, 160*a^3-160*a^2+160, 160, 160*a^3-160*a^2-320, -160*a^3+160*a^2+320, 160, -320*a^3+160*a^2-160*a+320, -320*a^3-160*a+160, 160, 160*a^3-160*a+160, 160*a^2-320*a+160, 160, 160*a^3-320*a^2+160*a, 160*a^3-320*a^2+320*a-160, 160, 160*a^2+160*a+160, 160*a^3+160*a^2+160*a}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, { -120, 120*a^3+120*a^2+120*a, -240*a^3+120*a^2-120*a+240, -120, 120*a^2-240*a+120, 120*a^3-240*a^2+120*a, -120, -240*a^3-120*a+120, 120*a^2+120*a+120, -120, 120*a^3-240*a^2+240*a-120, 120*a^3-120*a+120, -120, 120*a^3-120*a^2+120, -120*a^3+120*a^2-120, -120, -120*a^3+120*a^2+240, 120*a^3-120*a^2-240, -120, 240*a^3-120*a^2+120*a-240, 240*a^3+120*a-120, -120, -120*a^3+120*a-120, -120*a^2+240*a-120, -120, -120*a^3+240*a^2-120*a, -120*a^3+240*a^2-240*a+120, -120, -120*a^2-120*a-120, -120*a^3-120*a^2-120*a}, { -200*a^2-200*a-200, -200*a^3, 400, -200*a^3+200*a-200, 200*a^3-200*a^2+200*a-200, 400, 400*a^3-200*a^2+200*a-400, 200*a^2, 400, -200*a^3+400*a^2-200*a, -200*a, 400, 200*a^3-200*a^2+200, 200, 400, -200*a^3+200*a^2+400, 200, 400, 200*a^3+200*a^2+200*a, -200*a, 400, 200*a^3-400*a^2+400*a-200, 200*a^2, 400, 200*a^2-400*a+200, -200*a^3, 400, -400*a^3-200*a+200, 200*a^3-200*a^2+200*a-200, 400}, {0, -360*a^3+360*a^2-360*a+360, 0, 0, -360*a^2, 0, 0, 360*a, 0, 0, 360*a^3, 0, 0, -360, 0, 0, -360, 0, 0, 360*a^3, 0, 0, 360*a, 0, 0, -360*a^3+360*a^2-360*a+360, 0, 0, -360*a^2, 0}, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, { -120*a^2-120*a-120, -120*a^3, -12, -120*a^3+120*a-120, 120*a^3-120*a^2+120*a-120, -12, 240*a^3-120*a^2+120*a-240, 120*a^2, -12, -120*a^3+240*a^2-120*a, -120*a, -12, 120*a^3-120*a^2+120, 120, -12, -120*a^3+120*a^2+240, 120, -12, 120*a^3+120*a^2+120*a, -120*a, -12, 120*a^3-240*a^2+240*a-120, 120*a^2, -12, 120*a^2-240*a+120, -120*a^3, -12, -240*a^3-120*a+120, 120*a^3-120*a^2+120*a-120, -12}, {0, -840*a^3+840*a^2-840*a+840, 0, 0, -840*a^2, 0, 0, 840*a, 0, 0, 840*a^3, 0, 0, -840, 0, 0, -840, 0, 0, 840*a^3, 0, 0, 840*a, 0, 0, -840*a^3+840*a^2-840*a+840, 0, 0, -840*a^2, 0}, {0, 900, -300*a^3-300*a^2-300*a, 0, 900, -300*a^2+600*a-300, 0, 900, 600*a^3+300*a-300, 0, 900, -300*a^3+600*a^2-600*a+300, 0, 900, -300*a^3+300*a^2-300, 0, 900, 300*a^3-300*a^2-600, 0, 900, -600*a^3+300*a^2-300*a+600, 0, 900, 300*a^3-300*a+300, 0, 900, 300*a^3-600*a^2+300*a, 0, 900, 300*a^2+300*a+300}, {300*a^3-300*a^2+300*a-300, 300*a^2+300*a+300, 0, 300*a^2, 300*a^3-300*a+300, 0, -300*a, -600*a^3+300*a^2-300*a+600, 0, -300*a^3, 300*a^3-600*a^2+300*a, 0, 300, -300*a^3+300*a^2-300, 0, 300, 300*a^3-300*a^2-600, 0, -300*a^3, -300*a^3-300*a^2-300*a, 0, -300*a, -300*a^3+600*a^2-600*a+300, 0, 300*a^3-300*a^2+300*a-300, -300*a^2+600*a-300, 0, 300*a^2, 600*a^3+300*a-300, 0}, { -280, 280*a^3+280*a^2+280*a, -560*a^3+280*a^2-280*a+560, -280, 280*a^2-560*a+280, 280*a^3-560*a^2+280*a, -280, -560*a^3-280*a+280, 280*a^2+280*a+280, -280, 280*a^3-560*a^2+560*a-280, 280*a^3-280*a+280, -280, 280*a^3-280*a^2+280, -280*a^3+280*a^2-280, -280, -280*a^3+280*a^2+560, 280*a^3-280*a^2-560, -280, 560*a^3-280*a^2+280*a-560, 560*a^3+280*a-280, -280, -280*a^3+280*a-280, -280*a^2+560*a-280, -280, -280*a^3+560*a^2-280*a, -280*a^3+560*a^2-560*a+280, -280, -280*a^2-280*a-280, -280*a^3-280*a^2-280*a}, { -120*a^2-120*a-120, -120*a^3, -12, -120*a^3+120*a-120, 120*a^3-120*a^2+120*a-120, -12, 240*a^3-120*a^2+120*a-240, 120*a^2, -12, -120*a^3+240*a^2-120*a, -120*a, -12, 120*a^3-120*a^2+120, 120, -12, -120*a^3+120*a^2+240, 120, -12, 120*a^3+120*a^2+120*a, -120*a, -12, 120*a^3-240*a^2+240*a-120, 120*a^2, -12, 120*a^2-240*a+120, -120*a^3, -12, -240*a^3-120*a+120, 120*a^3-120*a^2+120*a-120, -12}, {0, 162, -54*a^3-54*a^2-54*a, 0, 162, -54*a^2+108*a-54, 0, 162, 108*a^3+54*a-54, 0, 162, -54*a^3+108*a^2-108*a+54, 0, 162, -54*a^3+54*a^2-54, 0, 162, 54*a^3-54*a^2-108, 0, 162, -108*a^3+54*a^2-54*a+108, 0, 162, 54*a^3-54*a+54, 0, 162, 54*a^3-108*a^2+54*a, 0, 162, 54*a^2+54*a+54}, {54*a^3-54*a^2+54*a-54, 54*a^2+54*a+54, 0, 54*a^2, 54*a^3-54*a+54, 0, -54*a, -108*a^3+54*a^2-54*a+108, 0, -54*a^3, 54*a^3-108*a^2+54*a, 0, 54, -54*a^3+54*a^2-54, 0, 54, 54*a^3-54*a^2-108, 0, -54*a^3, -54*a^3-54*a^2-54*a, 0, -54*a, -54*a^3+108*a^2-108*a+54, 0, 54*a^3-54*a^2+54*a-54, -54*a^2+108*a-54, 0, 54*a^2, 108*a^3+54*a-54, 0}, { -90, 90*a^3+90*a^2+90*a, -180*a^3+90*a^2-90*a+180, -90, 90*a^2-180*a+90, 90*a^3-180*a^2+90*a, -90, -180*a^3-90*a+90, 90*a^2+90*a+90, -90, 90*a^3-180*a^2+180*a-90, 90*a^3-90*a+90, -90, 90*a^3-90*a^2+90, -90*a^3+90*a^2-90, -90, -90*a^3+90*a^2+180, 90*a^3-90*a^2-180, -90, 180*a^3-90*a^2+90*a-180, 180*a^3+90*a-90, -90, -90*a^3+90*a-90, -90*a^2+180*a-90, -90, -90*a^3+180*a^2-90*a, -90*a^3+180*a^2-180*a+90, -90, -90*a^2-90*a-90, -90*a^3-90*a^2-90*a}, { -70*a^2-70*a-70, -70*a^3, -50, -70*a^3+70*a-70, 70*a^3-70*a^2+70*a-70, -50, 140*a^3-70*a^2+70*a-140, 70*a^2, -50, -70*a^3+140*a^2-70*a, -70*a, -50, 70*a^3-70*a^2+70, 70, -50, -70*a^3+70*a^2+140, 70, -50, 70*a^3+70*a^2+70*a, -70*a, -50, 70*a^3-140*a^2+140*a-70, 70*a^2, -50, 70*a^2-140*a+70, -70*a^3, -50, -140*a^3-70*a+70, 70*a^3-70*a^2+70*a-70, -50}, {0, -270*a^3+270*a^2-270*a+270, 0, 0, -270*a^2, 0, 0, 270*a, 0, 0, 270*a^3, 0, 0, -270, 0, 0, -270, 0, 0, 270*a^3, 0, 0, 270*a, 0, 0, -270*a^3+270*a^2-270*a+270, 0, 0, -270*a^2, 0}, {0, 162, -54*a^3-54*a^2-54*a, 0, 162, -54*a^2+108*a-54, 0, 162, 108*a^3+54*a-54, 0, 162, -54*a^3+108*a^2-108*a+54, 0, 162, -54*a^3+54*a^2-54, 0, 162, 54*a^3-54*a^2-108, 0, 162, -108*a^3+54*a^2-54*a+108, 0, 162, 54*a^3-54*a+54, 0, 162, 54*a^3-108*a^2+54*a, 0, 162, 54*a^2+54*a+54}, {54*a^3-54*a^2+54*a-54, 54*a^2+54*a+54, 0, 54*a^2, 54*a^3-54*a+54, 0, -54*a, -108*a^3+54*a^2-54*a+108, 0, -54*a^3, 54*a^3-108*a^2+54*a, 0, 54, -54*a^3+54*a^2-54, 0, 54, 54*a^3-54*a^2-108, 0, -54*a^3, -54*a^3-54*a^2-54*a, 0, -54*a, -54*a^3+108*a^2-108*a+54, 0, 54*a^3-54*a^2+54*a-54, -54*a^2+108*a-54, 0, 54*a^2, 108*a^3+54*a-54, 0}, { -9, 9*a^3+9*a^2+9*a, -18*a^3+9*a^2-9*a+18, -9, 9*a^2-18*a+9, 9*a^3-18*a^2+9*a, -9, -18*a^3-9*a+9, 9*a^2+9*a+9, -9, 9*a^3-18*a^2+18*a-9, 9*a^3-9*a+9, -9, 9*a^3-9*a^2+9, -9*a^3+9*a^2-9, -9, -9*a^3+9*a^2+18, 9*a^3-9*a^2-18, -9, 18*a^3-9*a^2+9*a-18, 18*a^3+9*a-9, -9, -9*a^3+9*a-9, -9*a^2+18*a-9, -9, -9*a^3+18*a^2-9*a, -9*a^3+18*a^2-18*a+9, -9, -9*a^2-9*a-9, -9*a^3-9*a^2-9*a}, { -3*a^2-3*a-3, -3*a^3, -3, -3*a^3+3*a-3, 3*a^3-3*a^2+3*a-3, -3, 6*a^3-3*a^2+3*a-6, 3*a^2, -3, -3*a^3+6*a^2-3*a, -3*a, -3, 3*a^3-3*a^2+3, 3, -3, -3*a^3+3*a^2+6, 3, -3, 3*a^3+3*a^2+3*a, -3*a, -3, 3*a^3-6*a^2+6*a-3, 3*a^2, -3, 3*a^2-6*a+3, -3*a^3, -3, -6*a^3-3*a+3, 3*a^3-3*a^2+3*a-3, -3}, {0, 3*a^3-3*a^2+3*a-3, 0, 0, 3*a^2, 0, 0, -3*a, 0, 0, -3*a^3, 0, 0, 3, 0, 0, 3, 0, 0, -3*a^3, 0, 0, -3*a, 0, 0, 3*a^3-3*a^2+3*a-3, 0, 0, 3*a^2, 0}, {0, 30, -10*a^3-10*a^2-10*a, 0, 30, -10*a^2+20*a-10, 0, 30, 20*a^3+10*a-10, 0, 30, -10*a^3+20*a^2-20*a+10, 0, 30, -10*a^3+10*a^2-10, 0, 30, 10*a^3-10*a^2-20, 0, 30, -20*a^3+10*a^2-10*a+20, 0, 30, 10*a^3-10*a+10, 0, 30, 10*a^3-20*a^2+10*a, 0, 30, 10*a^2+10*a+10}, {10*a^3-10*a^2+10*a-10, 10*a^2+10*a+10, 0, 10*a^2, 10*a^3-10*a+10, 0, -10*a, -20*a^3+10*a^2-10*a+20, 0, -10*a^3, 10*a^3-20*a^2+10*a, 0, 10, -10*a^3+10*a^2-10, 0, 10, 10*a^3-10*a^2-20, 0, -10*a^3, -10*a^3-10*a^2-10*a, 0, -10*a, -10*a^3+20*a^2-20*a+10, 0, 10*a^3-10*a^2+10*a-10, -10*a^2+20*a-10, 0, 10*a^2, 20*a^3+10*a-10, 0}, {1, -a^3-a^2-a, 2*a^3-a^2+a-2, 1, -a^2+2*a-1, -a^3+2*a^2-a, 1, 2*a^3+a-1, -a^2-a-1, 1, -a^3+2*a^2-2*a+1, -a^3+a-1, 1, -a^3+a^2-1, a^3-a^2+1, 1, a^3-a^2-2, -a^3+a^2+2, 1, -2*a^3+a^2-a+2, -2*a^3-a+1, 1, a^3-a+1, a^2-2*a+1, 1, a^3-2*a^2+a, a^3-2*a^2+2*a-1, 1, a^2+a+1, a^3+a^2+a}, { -3*a^2-3*a-3, -3*a^3, -3, -3*a^3+3*a-3, 3*a^3-3*a^2+3*a-3, -3, 6*a^3-3*a^2+3*a-6, 3*a^2, -3, -3*a^3+6*a^2-3*a, -3*a, -3, 3*a^3-3*a^2+3, 3, -3, -3*a^3+3*a^2+6, 3, -3, 3*a^3+3*a^2+3*a, -3*a, -3, 3*a^3-6*a^2+6*a-3, 3*a^2, -3, 3*a^2-6*a+3, -3*a^3, -3, -6*a^3-3*a+3, 3*a^3-3*a^2+3*a-3, -3}, {0, -27*a^3+27*a^2-27*a+27, 0, 0, -27*a^2, 0, 0, 27*a, 0, 0, 27*a^3, 0, 0, -27, 0, 0, -27, 0, 0, 27*a^3, 0, 0, 27*a, 0, 0, -27*a^3+27*a^2-27*a+27, 0, 0, -27*a^2, 0}};
r1 = rank M
r2 = rank syz M
r3 = rank ker M
KK=GF K1;
M=value toString M;
r1' = rank M
r2' = rank syz M
r3' = rank ker M
assert( r1 == r1' )
assert( r2 == r2' )
assert( r3 == r3' )