# Relevant concepts

## What is a "Intelligent Vending Machine" ?

It is a new generation of vending machines and belongs to one of the **IOT (Internet of thing)**. The Intelligent vending machine is based on the improvement of the traditional vending machine, adding a variety of new technological elements such as cloud, electronic payment, face recognition, vein authentication and other technologies.

At present, intelligent vending machines have begun to be equipped with network communication and touch screens with the promotion of smart city policies, and the vigorous development of the **O2O(online To offline)** transaction model.

<!-- ![Trend chart](https://www.grandviewresearch.com/static/img/research/us-intelligent-vending-machines-market.png)Figure 2.1  -->
<img alt="Trend chart vending machine" src="https://www.grandviewresearch.com/static/img/research/us-intelligent-vending-machines-market.png" width="540" height="360"/>

Figure 2.1 shows that the global intelligent vending machines market size is expected to expand at a compound annual growth rate (CAGR) of 13.3% from 2022 to 2030. 

It have penetrated into office buildings, schools, communities and other urban residents 'gathering places to meet consumers demand' shopping anytime, anywhere.

## Basic Features

Figure 2.2
<!-- ![Smart vending machine](https://www.limitlessmobil.com/wp-content/uploads/2020/04/Defining-Features-of-a-Smart-vending-machine.jpg) -->
<img alt="Smart vending machine" src="https://www.limitlessmobil.com/wp-content/uploads/2020/04/Defining-Features-of-a-Smart-vending-machine.jpg" width="540" height="300"/>

- Unmanned store
- 24/7 
- Contactless
- Inventory management
- Low cost 

## How to implemented a vending machine circuit?

The system consists of an **FPGA development platform**, and a **screen**. 
The main system uses clk and input to select the product and pay, and then transmit the signal to HDMI to convert the image displayed on the screen. This project is to implement a vending machine with **verilog**. 

Figure 2.3 shows a system architecture. 
1. State Machine 
2. Operational Unit
3. BCD/LED Interface
4. HDMI Interface

<!-- ![system architecture ](./_image/system.png) -->
<img alt="system" src="_images/system.png" width="540" height="300"/>

## What is HDMI?

[HDMI(High Definition Multimedia Interface)](https://en.wikipedia.org/wiki/HDMI) is a fully digital video and audio transmission interface that can transmit uncompressed audio and video signals. HDMI can be used for equipment such as set-top boxes, DVD players, personal computers, video game instruments, integrated amplifiers, digital audio and TV sets. 

HDMI can transmit audio and video signals at the same time. Since the audio and video signals use the same wire, it greatly simplifies the installation difficulty of the system circuit. 

## Principle of HDMI

The transmission principle of HDMI is the same as that of DVI, and the TMDS (Time Minimized Differential Signal) minimized transmission differential signal transmission technology invented by Silicon Image Company.

[TMDS](https://www.fpga4fun.com/HDMI.html) is a differential signal mechanism that uses the voltage difference between two  pins to transmit signals. The value of the transmitted data ("0" or "1") is determined by the positive and negative polarity and magnitude of the voltage between the two pins. 

> That is, two lines are used to transmit the signal, one line transmits the original signal, and the other line transmits the signal opposite to the original signal. In this way, 

The receiving end can shield electromagnetic interference by subtracting the signal on one line from the signal on the other line, so as to obtain the correct signal.






