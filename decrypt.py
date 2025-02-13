def read_file(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def write_file(file_path, content):
    with open(file_path, 'w') as file:
        file.write(content)

def decrypt(text, key, mask=127):
    return ''.join(chr((ord(char) - key) & mask) for char in text)

def main():
    input_file = "encrypted.txt"
    output_file = "decrypted.txt"
    key = 5  # Use the same key as encryption

    encrypted_text = read_file(input_file)
    decrypted_text = decrypt(encrypted_text, key)
    write_file(output_file, decrypted_text)

    print(f"Decrypted text saved to {output_file}")

if __name__ == "__main__":
    main()
