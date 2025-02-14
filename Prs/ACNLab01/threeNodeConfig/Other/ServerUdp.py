import socket

def main():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    host = '0.0.0.0'
    port = 12345
    server_socket.bind((host, port))

    print("Server is listening on {}:{}".format(host, port))

    while True:
        data, addr = server_socket.recvfrom(1024)
        print("Received from {}: {}".format(addr, data.decode('utf-8')))
        if data.decode('utf-8') == 'q':
            print("Client {}:{} disconnected.".format(addr[0], addr[1]))
            break

if __name__ == "__main__":
    main()
