import socket

def main():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    host = 'localhost'
    port = 12345
    addr = (host, port)

    print("Available operations: 'sqrt', 'square', 'factorial' (or 1, 2, 3)")
    print("Enter 'q' to quit.")

    while True:
        operation = input("Enter the operation you want to perform (q to quit): ")
        
        if operation == 'q':
            client_socket.sendto(b'q', addr)  # Send quit command to server
            print('Exiting...')
            break

        number = int(input("Enter the number: "))
        data = "{} {}".format(operation, number)
        client_socket.sendto(data.encode('utf-8'), addr)

        result, _ = client_socket.recvfrom(1024)
        print("Result: {}".format(result.decode('utf-8')))

    client_socket.close()

if __name__ == "__main__":
    main()
