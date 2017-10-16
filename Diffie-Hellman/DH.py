import sys
#p shared prime
p=int(sys.argv[1])
#g shared base
g=int(sys.argv[2])


secret_client1=100
secret_client2=200

#sent through hostile network from client1 to client2

A=(g**secret_client1) % p

print "sent from client1 to client2 through hostile network: %d" % A

#sent through hostile network from client2 to client1

B=(g**secret_client2) % p

print "sent from client2 to client1 through hostile network: %d" % B

secret1=(B**secret_client1) % p
secret2=(A**secret_client2) % p

print secret1,secret2
