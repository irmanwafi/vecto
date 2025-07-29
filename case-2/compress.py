import json

def pack_data(voltage, energy, current):
    # we only have 3 bytes to work with, sooooo scaled down energy and current
    # dividing by 25 brings them down to fit into 6 bits (max 63)
    energy_small = energy // 25
    current_small = current // 25

    # format: 8 bits for voltage, 6 for energy, 6 for current = 20 bits total
    # shift everything into place and combine into one number
    packed = (voltage << 12) | (energy_small << 6) | current_small

    # convert the packed int into 3 bytes (big-endian)
    return packed.to_bytes(3, 'big')


def unpack_data(data_bytes):
    # turn the 3 bytes back into a single integer
    packed = int.from_bytes(data_bytes, 'big')

    # grab each part by shifting and masking
    voltage = (packed >> 12) & 0xFF
    energy_small = (packed >> 6) & 0x3F
    current_small = packed & 0x3F

    # scale them back up to get the approximate original values
    energy = energy_small * 25
    current = current_small * 25

    # return the result in a clean JSON format
    return json.dumps({
        "Voltage": voltage,
        "Energy": energy,
        "Current": current
    }, indent=2)

# test run
data = pack_data(254, 1450, 1580)
print("Raw bytes:", data)

print("Decoded:")
print(unpack_data(data))
