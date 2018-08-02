Interfacing
====================

LFR uses a simple, binary protocol over UART to communicate with the flight
computer. Each command to the radio is prefixed with a synchronization word and
ended with a checksum to ensure data integrity even in the case of bus errors.
Commands to the radio are acknowledged with a reply indicating successful
execution of a command or an error condition with error code indicating the
source of the error. Received packets and resets result in spontaneous replies
being sent over the serial connection. These do not reqiure acknowledgement from
the flight computer.

LFR is capable of buffering packets internally. Commanding LFR to transmit adds
a packet to this internal buffer. When the buffer is full, attempting to add a
packet to the queue results in an error reply indicating the buffer is full.

The UART connection can be run at up to 115200 baud, allowing saturation of the
radio channel. LFR hardware also supports the use of I:sup:`2`C as the command
interface. This is pending future firmware support for I:sup:`2`C.

Further details of the command protocol can be found in the LFR User's Guide.
