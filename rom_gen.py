import math
import sys

if __name__ == "__main__":
   inp_len = int(sys.argv[1]) if len(sys.argv)>1 else 10
   outp_len = int(sys.argv[2]) if len(sys.argv)>2 else 8
   print "Building a " + str(inp_len) + " to " + str(outp_len) + " ROM..."
   rom = open("rom.dat", "w")
   bound = 2**inp_len
   offset = 2**(outp_len-1)
   for i in range(0, bound/2):
      # s = offset + int((offset-1)*math.sin((2*math.pi*i)/bound)+0.5)
      s = int((offset-1)*math.sin((2*math.pi*i)/bound)+0.5)
      rom.write(str(bin(s))[2:] + " ")
   rom.close()
   print "Done"
