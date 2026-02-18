#permute.py

#Function-based permutation
def permute1(seq):
    if not seq:
        return [seq]  # base case. Empty sequence - if list is empty, return empty list
    else:
        result = []
        for i in range(len(seq)):
            rest = seq[:i] + seq[i+1:]   # All elements except the current
            for x in permute1(rest):     # Recursively permute the rest
                result.append(seq[i:i+1] + x)  # Add node at front; seq[i:i+1] preserves the original sequence type
            #print(result)
        return result

#Generator-based permutation
def permute2(seq):
    if len(seq) == 1:    
        yield seq   # Base case
    else:
        for i in range(len(seq)):
            current = seq[i:i+1]
            rest = seq[:i] + seq[i+1:]    
            for x in permute2(rest): 
                #print(seq[i:i+1] + x)
                yield current + x 

                