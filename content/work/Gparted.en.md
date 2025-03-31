+++
authors = ["Li Jialu"]
title = "Gparted"
date = "2025-01-19"
categories = [
    "Software"
]
series = [""]
tags = [
   "Memory Management"
]
+++

# Gparted Disk Space Allocation

Delete the Windows partition and allocate the freed space to Ubuntu

1. **Enter the "TRY UBUNTU" Mode**
   (1) Insert the USB drive to boot Ubuntu, press F12 to enter the USB boot menu.
   (2) Select the USB drive to boot into Ubuntu, then enter the "Try Ubuntu" mode.
    <div class="container">
        <div class="image">
            <figure>
                    <img src="/images/work-record/gparted.png">
                    <figcaption>Choose to enter Ubuntu</figcaption>
            </figure>
        </div>
    </div>

2. **Launch Gparted**
   (1) Delete the partition you want to remove.
   (2) Expand a partition: The partition must be expanded to both the left and right sides.
        - **Free space preceding**: Amount of space to reserve on the left side.
        - **New size**: The size of the expanded partition.
        - **Free space following**: Amount of space to reserve on the right side, adjacent to the partition.
   (3) After expanding, click the checkmark to save the changes.

3. **Exit "Try Ubuntu" and reboot into your normal system.**
