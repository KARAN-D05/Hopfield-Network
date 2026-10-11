def binary_to_bipolar(pattern):
    return [1 if bit == 1 else -1 for bit in pattern]

def calculate_weights(patterns, num_neurons):
    weights = [[0 for _ in range(num_neurons)] for _ in range(num_neurons)]

    for pattern in patterns:
        bipolar = binary_to_bipolar(pattern)
        for i in range(num_neurons):
            for j in range(num_neurons):
                if i != j:
                    weights[i][j] += bipolar[i] * bipolar[j]
    return weights

def main():
    num_neurons = int(input("Number of neurons: "))
    num_patterns = int(input("Number of stored patterns: "))

    if num_neurons <= 0 or num_patterns <= 0:
        print("Error: Both values must be positive.")
        return

    patterns = []

    for p in range(num_patterns):
        while True:
            raw = input(
                f"Enter pattern {p + 1} as {num_neurons} bits: "
            ).strip()

            if len(raw) == num_neurons and all(bit in "01" for bit in raw):
                patterns.append([int(bit) for bit in raw])
                break

            print(f"Invalid pattern. Enter exactly {num_neurons} bits.")

    weights = calculate_weights(patterns, num_neurons)

    print("\nStored patterns:")
    for pattern in patterns:
        print("".join(map(str, pattern)))

    print("\nHebbian Weight Matrix:")
    for row in weights:
        print(" ".join(f"{weight:4d}" for weight in row))

if __name__ == "__main__":
    main()
