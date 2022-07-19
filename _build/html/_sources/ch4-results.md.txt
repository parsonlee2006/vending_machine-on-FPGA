# Results 

I have used verilog to implement the entire system for the vending machine, its development platform:

Software
- Vivado® ML Standard Edition
- Visual Studio Code<br>

Hardware
- Xilinx Spartan-7 XC7S50-CSGA324 FPGA Board
- Screen
- HDMI cable

Figure 4.1 & 4.2 shows the functions on FPGA borad include:
1. 2 switch switches and 4 switch switches respectively control the input of the price of the commodity and the input of the payment amount
2. 4 buttons control state machine( confirm, finish, reselct, arst)
3. Two four-digit 7-segment displays show the price and total payment amount respectively
4. LED and Rled show the state of the systems.
5. The display interface of the product is output on the screen through the TDMS code.

<!-- ![Result](./_image/result.png) -->
<img src="_images/result2.png" alt="Result" width="480" height="360">
<img src="_images/result1.png" alt="Result" width="700" height="360">
<img src="_images/result3.png" alt="Result" width="440" height="400">

## Demo Video 
<video width="540" height="400" controls>
	<source
		src="_static/demo.webm"
		type="video/webm"
	>
</video>

## Conclusion & Discussion 

This topic uses Verilog, which uses language to describe the distribution and trend of circuits. It requires good logical concepts. Unlike general high-level languages ​​for programming, mathematics is the main way of writing. Although it is similar to C++, there are still big differences. Most of the solutions are to find the answers on the Internet or in books.

> The Internet is really convenient!！

In the process of coding, there are many problems to be solved.
The most difficult thing is to understand how to scan the output pixels when making the video output interface, and to understand how HDMI is encoded. In addition, the clock frequency of each block is also clarified.

Although I only completed a very basic topic this time, I not only became more familiar with the HDMI image concept, but also learned to distinguish the functions of the control system and the data computing unit.

Over all, the application of this kind of smart appliances will only become wider and wider in the future, and the code will only become more and more complex. However, technological progress and convenience are based on code that works at these low levels. Through this topic, I have a better understanding of the construction from transistors to digital circuits. 

>Going from encountering a difficulty to overcoming it and then doing it step by step is really a lot of fun!

# Reference 

[Intelligent-vending-machines-industry](https://www.grandviewresearch.com/industry-analysis/intelligent-vending-machines-industr)<br>
[HDMI wiki](https://en.wikipedia.org/wiki/HDMI)<br>
[HDMI tutorial](https://www.fpga4fun.com/HDMI.html)<br>
[HDMI on FPGA](https://www.youtube.com/watch?v=sMOZxOCfkBU)