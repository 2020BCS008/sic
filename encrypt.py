def read_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def write_file(file_path, content):
    with open(file_path, 'w') as file:
        file.write(content)

def encrypt(text, key, mask=127):
    return ''.join(chr((ord(char) + key) & mask) for char in text)

def main():
    input_file = "/home/chaitanya/Documents/Mtech/SEM_II/SecurityInComputing/PR/encryption-decryption-algo/input.txt"
    output_file = "encrypted.txt"
    key = 5  # Change key as needed

    text = read_file(input_file)
    encrypted_text = encrypt(text, key)
    write_file(output_file, encrypted_text)

    print(f"Encrypted text saved to {output_file}")

if __name__ == "__main__":
    main()
