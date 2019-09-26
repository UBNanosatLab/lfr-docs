LFR Command Format
=======================

LFR uses an efficient, byte oriented, binary protocol for interfacing with the
host computer. The protocol features synchronization words and checksums to
guard against errors from bus errors and host computer resets.

A LFR command packet is formatted as follows:

.. image:: protocol/generic.png
    :alt: Generic Packet Format
    :height: 0.4 cm

The synchronization word is the two byte sequence 0xBE, 0xEF. The command byte
consists of a reply indicator bit, a 3 bit group identifier, and a 4 bit 
command identifier. For convenience, commands are expressed below as a single 
byte. The length byte represents the length of the payload data, excluding the
header and checksum bytes. The payload follows, as a LEN byte long sequence, 
which is completely omitted in the case the length byte is zero. All data 
values are sent big-endian (network byte order) unless otherwise specified. 
Each packet ends with a 16-bit fletcher checksum, sent as sum, then sum of 
sums. The checksum includes the command, length, and payload bytes, but does
not include the sync word. Sample code to compute the checksum is given below::

    uint16_t fletcher(uint8_t *data, uint8_t len) {
        uint8_t lsb = 0, msb = 0;
        for (int i = 0; i < len; i++) {
            msb += c;
            lsb += msb;
        }
        return ((uint16_t) msb << 8) | (uint16_t) lsb;
    }


For most commands, LFR acknowledges the receipt of a command by sending a reply
command, which is the same command with the most significant bit of the command
byte set. The payload of the reply command includes any data LFR is returning
in response to that command. Some events may result in the spontaneous issuing
of a reply command without a matching command sent to LFR, including for 
commands that are not valid to issue to LFR. This behavior is described in the
command reference.

Error conditions are indicated through the sending of the error command 
replies. These may be sent in response to a specific command (``ERROR``), or 
may be general, and not attributable to a specific action by the host 
(``INTERNALERR``).

LFR Command Reference
=======================

Group 0: System
----------------------

CMD 0x00: NOP
^^^^^^^^^^^^^^^^^^^^^^
+------------------+-----------------------------------------------------------+
| No-Operation     | 0x00                                                      |
+==================+===========================================================+
|Payload Length:   | 0                                                         |
+------------------+-----------------------------------------------------------+
|Payload Contents: | None                                                      |
+------------------+-----------------------------------------------------------+
|Reply Length:     | 0                                                         |
+------------------+-----------------------------------------------------------+
|Reply Contents:   | None                                                      |
+------------------+-----------------------------------------------------------+

The no-operation command is sent from the host to the LFR, and is acknowledged
with a NOP reply. This can be used to verify the presence and normal operation 
of LFR.


CMD 0x01: RESET
^^^^^^^^^^^^^^^^^^^^^^
+------------------+-----------------------------------------------------------+
| Reset LFR        | 0x01                                                      |
+==================+===========================================================+
|Payload Length:   | 0                                                         |
+------------------+-----------------------------------------------------------+
|Payload Contents: | None                                                      |
+------------------+-----------------------------------------------------------+
|Reply Length:     | 0                                                         |
+------------------+-----------------------------------------------------------+
|Reply Contents:   | None                                                      |
+------------------+-----------------------------------------------------------+

The reset command will trigger a reset of the microcontroller in LFR and the 
RFIC. This is acknowledged by a RESET reply packet at start up. RESET reply
packets are sent any time the LFR microcontroller restarts, regardless of 
reason, including inital power on. A reset will discard any packets in the
transmit and receive buffers.

CMD 0x02: UPTIME
^^^^^^^^^^^^^^^^^^^^^^

+------------------+-----------------------------------------------------------+
| Get LFR Uptime   | 0x02                                                      |
+==================+===========================================================+
|Payload Length:   | 0                                                         |
+------------------+-----------------------------------------------------------+
|Payload Contents: | None                                                      |
+------------------+-----------------------------------------------------------+
|Reply Length:     | 4                                                         |
+------------------+-----------------------------------------------------------+
|Reply Contents:   | seconds since last reset as ``uint32_t``                  |
+------------------+-----------------------------------------------------------+

Not yet implemented.

Group 1: Data
----------------------