import random, math

def generate(data):
    # generates 2 random addresses between 0x2000_0000 and 0x2000_1000, 4 byte aligned
    i = random.randint(0x20000000>>2, 0x20002000>>2)<<2
    j = random.randint(0x20000000>>2, 0x20002000>>2)<<2
    # ensures i and j are different
    while j == i:
        j = random.randint(0x20000000>>2, 0x20002000>>2)<<2

    # sets a_adr and b_adr to a hex string of i and j
    data['params']['a_adr'] = "0x%0.8X" % i
    data['params']['b_adr'] = "0x%0.8X" % j
    # sets the add amount to a random value between 5 and 10
    data['params']['add_amnt'] = random.randint(5, 10)
