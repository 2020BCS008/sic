import socket
import math

def calculate_sqrt(number):
    return math.sqrt(number)

def calculate_square(number):
    return number ** 2

def calculate_factorial(number):
    if number == 0:
        return 1
    return number * calculate_factorial(number - 1)

def main():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = '0.0.0.0'
    port = 12345
    server_socket.bind((host, port))

    server_socket.listen(5)
    print("Server is listening on {}:{}".format(host, port))

    while True:
        client_socket, addr = server_socket.accept()
        print("Accepted connection from {}:{}".format(addr[0], addr[1]))

        while True:
            data = client_socket.recv(1024).decode('utf-8')
            if data == 'q':  
                print("Client {}:{} disconnected.".format(addr[0], addr[1]))
                break  

            if data == '':
                print("Disconnected - from {}:{}".format(addr[0], addr[1]))
                break
            
            operation, number = data.split()
            number = float(number)

            if operation == 'sqrt' or operation == '1':
                result = calculate_sqrt(number)
            elif operation == 'square' or operation == '2':
                result = calculate_square(number)
            elif operation == 'factorial' or operation == '3':
                result = calculate_factorial(int(number))
            else:
                result = "Invalid operation"

            client_socket.send(str(result).encode('utf-8'))

        client_socket.close()  # Close the client socket after exiting the loop

if __name__ == "__main__":
    main()
