#include <iostream>

#include "../include/file_scaner.hpp"

int main (const int argc, const char **argv)
{

    MC::MC_Driver driver;
    driver.parse(argv[1], argv[2]);

    std::cout << "Completed" << std::endl;
    return 0;
}
