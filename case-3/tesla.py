def calculate_overtime(years, hours, rate):
    # check seniority multiplier
    if years <= 1:
        senior = 1
    elif years <= 3:
        senior = 1.1
    elif years <= 5:
        senior = 1.2
    else:
        senior = 1.7

    total = 0
    current_hour = 1
    remaining = hours

    while remaining > 0:
        # max 1 hour per loop
        h = min(1, remaining)

        # overtime multiplier
        if current_hour <= 1:
            ot = 2
        elif current_hour <= 3:
            ot = 2.1
        else:
            ot = 3

        # calculate pay for this hour
        pay = h * senior * ot * rate
        total += pay

        remaining -= h
        current_hour += 1

    return round(total, 2)


# example
print("Total OT pay: RM", calculate_overtime(2, 2.5, 20))
