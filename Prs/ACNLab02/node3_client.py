# Node 3 (UDP Receiver with Packet Loss Tracking)
import socket

def main():
    # Set up UDP server for receiving data from Node 2
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_ip = '192.168.217.37'
    udp_port = 6000
    udp_socket.bind((udp_ip, udp_port))

    print(f"Node 3 listening for UDP packets on {udp_ip}:{udp_port}...")

    received_count = 0  # Track received packets
    expected_number = 1  # Start with the first expected number

    while True:
        try:
            # Set a timeout for receiving packets to detect loss
            udp_socket.settimeout(5.0)
            data, addr = udp_socket.recvfrom(1024)
            number = int(data.decode('utf-8'))
            print(f"Received {number} from Node 2")

            # Increment received count and update expected number
            received_count += 1

            # Detect any missed packets between expected and received
            if number > expected_number:
                lost_packets = number - expected_number
                print(f"Lost {lost_packets} packets.")
            else:
                lost_packets = 0

            expected_number = number + 1  # Update to the next expected number

        except socket.timeout:
            # If timeout occurs, assume the remaining packets are lost
            print(f"No more packets received. Assuming remaining packets lost.")
            break

    print(f"Total received packets: {received_count}")
    print(f"Total lost packets: {expected_number - 1 - received_count}")

if __name__ == "__main__":
    main()
