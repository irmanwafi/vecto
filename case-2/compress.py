import json

def pack_data(voltage, energy, current):
    # we only have 3 bytes = 24 bits to store everything
    # voltage is fine as-is (fits in 8 bits)
    # but energy and current are too big, so I scale them down
    # dividing by 25 keeps them within 6 bits (0–63)
    energy_small = energy // 25
    current_small = current // 25

    # I’m packing everything into a single 20-bit value:
    # 8 bits for voltage, then 6 bits for energy, then 6 bits for current
    packed = (voltage << 12) | (energy_small << 6) | current_small

    # now convert that packed value into 3 bytes (big-endian)
    return packed.to_bytes(3, 'big')


def unpack_data(data_bytes):
    # first, turn the 3 bytes back into a single integer
    packed = int.from_bytes(data_bytes, 'big')

    # extract each original value using bit shifting and masking
    voltage = (packed >> 12) & 0xFF          # top 8 bits
    energy_small = (packed >> 6) & 0x3F       # next 6 bits
    current_small = packed & 0x3F             # last 6 bits

    # scale energy and current back to approximate their original values
    energy = energy_small * 25
    current = current_small * 25

    # return everything nicely formatted as JSON
    return json.dumps({
        "Voltage": voltage,
        "Energy": energy,
        "Current": current
    }, indent=2)


# test run to see if everything works
data = pack_data(254, 1450, 1580)
print("Raw bytes:", data)
print("Decoded:")
print(unpack_data(data))
