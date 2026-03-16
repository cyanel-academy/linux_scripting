# linux_script_2024

# Before to begin

- Be sure you repect filename and result
- Try a command in the terminal first to avoid side effects
- Go step by step, try little pece of code first. As your program grow, complexity increase
- Use samples to test your program

# Practice - Parameter and math

Create a script that takes two numbers as parameters and make an addition « Add x to y »

## Synopsis

```Shell
./add.sh [x] [y]
```

## Samples

```Shell
./add.sh 3 9
or
bash add.sh 8 23
```

## Must return

The result: 
```Shell
$ ./add.sh 3 9
$ 12
$ ./add.sh 12 -3
$ 9
```

## Tips

### Parameters

A script can takes input parameters. You can access to parameter in your script by using $ and a number:
```Shell
echo $0 //script file name
echo $1 //parameter 1
echo $2 //parameter 2
...
```

10th parameter and more needs different syntax: ${14}


« bc » command allow you to make a string a math expression. bc can take a value in input from another command. To do that, you can use | (pipe). The pipe connect to command:

```Shell
$ echo "2 + 2" | bc -l
$ 4
$ echo "2 * 2" | bc -l
$ 4
$ echo "2 / 2" | bc -l
$ 1.000000
```

In these exemples, echo returns a string "2 + 2" and give it to bc thanks to the pipe |.

## More info

https://phoenixnap.com/kb/bash-math

## Goals are

- Discover parameters
- Learn to respect synopsis and result
- Declare and execute a script
- How to make arithmetic expression


# Practice 2

Create a script that display information given in input with a user-friendly format

## Synopsis

```Shell
line_order.sh [name] [price]

```

## Samples

```Shell
./line_order.sh Ukulele 9.90
or
./line_order.sh Piano 1220
```

## Returns 

UKULELE                   |      9.90

or 

PIANO                     |   1220.00


## Tips

printf or echo has many ways to format string. You can create tabulation spaces to align number like in a bill, also add decimal

Useful cmd:

- printf
- upper

### More info

https://www.journaldufreenaute.fr/comment-utiliser-la-commande-printf-de-bash-sous-linux/

# Practice 3

Create a script that ask to the user to enter a product and its price and display the result

## Synopsis

```Shell
order_from_input.sh
```

## Behaviour

Must ask to the user:
« What is the product name? (type a value)
« What is the price? (type a value)

## Sample 

```Shell

order_from_input.sh
What is the product name? (type a value)
What is the price? (type a value)

UKULELE                   |      9.00

```

## Tips

Think to reuse things you've already done^^

# Practice 4

Create a script that save the orders in a file

## Synopsis

```Shell
save_line_order.sh [name] [price] [file_name]
```

## Sample

```Shell
./save_line_order.sh Ukulele 9.90 order1.txt
./save_line_order.sh Piano 1220 order1.txt
./save_line_order.sh Guitar 440.90 order2txt
```

# Result

- Must create the file if not exists (tips: if –f)
- Must create a new line in the file if the file exists
- Must exit with the good status (0=ok, 1=ko)

# Tips

echo command can write in a file.

You can test your program with (« cat » can display the files)


# Practice 5 (IF)

Copy the previous script from practice (save_line_order.sh) and improve error management by checking the number of input parameters. It must match with your synopsis, if not, return a error

## Result

- Must return 0 if the line is saved
- check that the file exists. If not > exit 1 with a message for the user
- Check the price is an interger. If not > exit 1 with a message
- If error occurs, must return 1 and put the error in a file err.log


## Tips

When errors occurs with parameters, script usually print the error with the command:

« Wrong number of parameters. Usage ./save_line_order [product] [price] [file] »


# Practice 6 (CASE)

Create a script that return a category according instrument in input

Piano, drum, djumbe, tambourine are category « percussion »

Ukulele, guitar, bass, banjo are category « strings »

Others instruments are category « unknown »

## Synopsis

```Shell
get_category_of.sh [name]
```

## Result

Return the category

# Practice 7 (LOOP)

Create a program that help a user to create an invoice with several orders.

The program make a loop and finish when user choose no when "continue?" is prompted

The invoice will go to a file named with the invoice number that the user set

## Synopsis

```Shell
./create_invoice.sh -f [invoice_number]
```

## Sequence

```Shell
./create_invoice.sh -f 42

"What is the invoice number?" (This step is optional if -f is set)

Enter product 1 name: ukulele
Enter product ukulele's price: 9 

continue? (yes/no): y

Enter product 2 name: piano
Enter product piano's price: 1220.10

continue? (yes/no): y

Enter product 3 name: flute
Enter product piano's price: 50.00

continue? (yes/no): n

Your order is saved in the file: invoice_42.txt

This is the details:

UKULELE   (strings)       |      9.00
PIANO     (percussion)    |   1220.10
FLUTE     (unknown)       |     50.00
--------------------------------------
Total                     |   1279.10
```

## Tips 

- reuse all scripts you made before
- make a function to read the input. This function get a message and return the user response


> Pull Request

# Final practices

Create a directory run2 in your login directory

Develop a game. Either:

## Pendu (Run2)

1. The program ask the number of players (players work one by one)
2. The program ask the name of players
3. The program invite poeple to play
4. User propose a letter
5. If letter exist, add to the word
6. If not, draw:

|--------|

|        o

|       \|/

|        |

|       / \

7. The program give a score (good = 10, bad = -5) 
8. Make a high score top 10 in a file
  8.a if user already in high score > compute his score
  8.b if user is new > add
  8.c if user is new, he probably push away the worste gamer (the 11th) > remove the worste
  
9. Display the top 10

## Motus (Run3)

0. The program choose a word randomly in a file
1. Nb players + pseudo players + invite to play
2. Display for "bonjour" > b_ _ _ _ _r
3. Let the ployer give a proposition (e.g. bagares)
  a. If a letter is missplaced, display in uppercase (e.g. bagaRes) and then display the word again (e.g b _ _...)
  b. If a letter is at the good position, let it in the word (e.g. b _ n _ o _ r and let this letter visible

Notes: 
- all words have the same size
- after 10 errors, game is over

Tips: regular expression could be useful

8. Make a high score top 10 in a file
  8.a if user already in high score > replace
  8.b if user is new > add
  8.c if user is new, he probably push away the worste gamer (the 11th) > remove the worste
  
9. Display the top 10


# Simon (Run4)

1. Nb Users
2. Computer display a letter betwwen Q S D or F (e.g Q)
3. Computer clear the screen
4. User repeat the sequence
5. If the sequence is good the computer add randomly a letter (e.g Q F)
6. Computer clear the screen  
7. If the sequence is bad, slap the player :)

8. Make a high score top 10 in a file
  8.a if user already in high score > replace
  8.b if user is new > add
  8.c if user is new, he probably push away the worste gamer (the 11th) > remove the worste
  
9. Display the top 10


# Resolve expression (Run 5)

The program get an expression in input and resolve

- understand () []  = (priority)
- [ 2 * (1 + 1)] * 3 = 12
