import serial
import socket

SERIAL_PORT = "/dev/cu.usbmodem1101"  # On Mac it might be "/dev/cu.usbmodemXXXX", on Windows "COM3" or similar
BAUD_RATE = 9600
HOST = "127.0.0.1"
PORT = 12345

try:
    ser = serial.Serial(SERIAL_PORT, BAUD_RATE)
    print(f"Connected to Arduino on {SERIAL_PORT}")
except Exception as e:
    print("Could not open serial port:", e)
    exit(1)

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((HOST, PORT))
server_socket.listen(1)

print(f"Waiting for Godot to connect on {HOST}:{PORT}...")
conn, addr = server_socket.accept()
print(f"Godot connected from {addr}")

while True:
    try:
        line = ser.readline().decode().strip()
        if line:
            print(f"Sending to Godot: {line}")
            conn.sendall((line + "\n").encode())
    except Exception as e:
        print("Error:", e)
        break
