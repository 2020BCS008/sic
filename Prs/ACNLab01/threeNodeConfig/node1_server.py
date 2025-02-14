# Node 1 (Server)
import socket
import time

def main():
    # Set up TCP server
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = '127.0.0.1'  # Localhost
    port = 12345
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"Node 1 (Server) listening on {host}:{port}...")

    while True:
        # Accept connection from Node 2
        client_socket, addr = server_socket.accept()
        print(f"Connected with Node 2 at {addr}")

        # Ask for sequence upper limit from user
        upper_limit = int(input("Enter upper limit for the sequence (e.g., 100): "))

        for i in range(1, upper_limit + 1):
            message = str(i)  # Prepare each number as a message
            client_socket.send(message.encode('utf-8'))  # Send message to Node 2
            print(f"Sent {message} to Node 2")
            time.sleep(0.5)  # Delay to simulate interval between packets

        print("Sequence transmission complete.")
        client_socket.send(b'q')  # Signal end of sequence
        client_socket.close()
        break  # Exit loop after one client session

if __name__ == "__main__":
    main()
