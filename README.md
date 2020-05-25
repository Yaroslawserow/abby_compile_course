## Зависимости
### компилятор clang++

`sudo apt-get install -y clang`

### bison 3.4
установка:

скачать архив: http://ftp.gnu.org/gnu/bison/bison-3.4.tar.gz, далее распаковать.

`cd bison-3.4/`

`sudo ./configure`

`sudo make`

`sudo make install`

### flex 2.6.4

`sudo apt-get install flex`

## Getting Started
после клонирвоания репризитория создайте папку build, далее соберите cmake. 

После чего запускайте
`./run_1_test.sh` - для разбора 1 java файла
или же 
`./run_all_test.sh` - для разбора всех файлов в папке tests/auto

укажите путь к файлу(который будет компиллироваться), а так же файл в который будет записыватсья ответ.

## abbyy_compile_course
курс ABBYY по компиляторам
### Состав:
Серов Ярослав

Арман Степанян

Архипов Александр
