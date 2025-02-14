import socket

def main():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = '192.168.202.37'
    port = 12345
    client_socket.connect((host, port))

    print("Available operations: 'sqrt', 'square', 'factorial' (or 1, 2, 3)")
    print("Enter 'q' to quit.")

    while True:
        operation = input("Enter the operation you want to perform (q to quit): ")
        
        if operation == 'q':
            client_socket.send(b'q')  # Send quit command to server
            print('Exiting...')
            break

        number = int(input("Enter the number: "))
        data = "{} {}".format(operation, number)
        client_socket.send(data.encode('utf-8'))

        result = client_socket.recv(1024).decode('utf-8')
        print("Result: {}".format(result))

    client_socket.close()

if __name__ == "__main__":
    main()
