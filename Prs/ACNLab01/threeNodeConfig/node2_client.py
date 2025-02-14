# Node 2 (TCP-to-UDP Forwarder)
import socket
import random
import time

def main():
    # Set up TCP client to Node 1
    tcp_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = '127.0.0.1'  # IP of Node 1
    port = 12345
    tcp_client.connect((host, port))
    print("Connected to Node 1 over TCP.")

    # Set up UDP socket to send to Node 3
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_ip = '127.0.0.1'  # IP of Node 3
    udp_port = 6000

    while True:
        # Receive data from Node 1 over TCP
        data = tcp_client.recv(1024).decode('utf-8')
        if data == 'q':  # Check for end of sequence
            break
        print(f"Received {data} from Node 1")

        # Simulate packet loss (10% drop chance)
        if random.random() < 0.1:
            print(f"Packet {data} lost (simulated).")
            continue

        # Forward data to Node 3 over UDP
        udp_socket.sendto(data.encode('utf-8'), (udp_ip, udp_port))
        print(f"Forwarded {data} to Node 3 via UDP")

        time.sleep(0.1)  # Small delay to mimic network conditions

    tcp_client.close()
    udp_socket.close()

if __name__ == "__main__":
    main()
