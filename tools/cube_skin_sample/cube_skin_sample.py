import cv2
import numpy as np
import os

MY_PATH = os.path.dirname(os.path.abspath(__file__))

im = np.zeros((8,64,4), np.float32)

for i in range(8):
    im[:,i,2] = i/7
    im[:,20+i,2] = 1-i/7

    im[i,0:39,1] = 1-i/7

    im[:,10+i,0] = 1-i/7
    im[:,30+i,0] = i/7

    im[i,40:48,0] = i/7
    im[:,40+i,2] = i/7

    im[i,50:58,0] = 1-i/7
    im[:,50+i,2] = i/7

im[:,10:18,2] = 1
im[:,0:8,0] = 1
im[:,40:48,1] = 1
im[:,:,3] = 1

for i in range(6):
    im[:,i*10+8,:] = im[:,i*10+7,:]
for i in range(1,6):
    im[:,i*10-1,:] = im[:,i*10+0,:]

im = im * 255

fn = os.path.join(MY_PATH,'cube_skin_sample.png')
cv2.imwrite(fn, im)
