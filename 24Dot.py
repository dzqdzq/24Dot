
numbers=[4, 9, 10, 12]

def Search(numbers):
    expression = list(map(str, numbers))
    def _Search(n):
        if n==0:
            return numbers[n] == 24

        for i in range(n+1):
            for j in range(i+1,n+1):
                a, b = numbers[i],numbers[j]
                expa, expb = expression[i],expression[j]

                numbers[j] = numbers[n]
                expression[j] = expression[n]

                expression[i] = '(%s+%s)' % (expa,expb)
                numbers[i] = a + b
                if _Search(n - 1):
                    return True

                expression[i] = '(%s-%s)' % (expa,expb)
                numbers[i] = a - b
                if _Search(n - 1):
                    return True

                expression[i] = '(%s-%s)' % (expb,expa)
                numbers[i] = b - a
                if _Search(n - 1):
                    return True

                
                expression[i] = '(%s*%s)' % (expa,expb)
                numbers[i] = a * b
                if _Search(n - 1):
                    return True

                if b != 0:
                    expression[i] = '(%s/%s)' % (expa,expb)
                    numbers[i] = a / b
                    if _Search(n - 1):
                        return True
                    
                if a != 0:
                    expression[i] = '(%s*%s)' % (expb,expa)
                    numbers[i] = b / a
                    if _Search(n - 1):
                        return True

                numbers[i],numbers[j] = a,b
                expression[i],expression[j] = expa,expb
        return False

    return expression[0] if _Search(len(numbers) -1) else "FAIL"

def main():
    print(Search(numbers))

if __name__ == '__main__':
    main()
