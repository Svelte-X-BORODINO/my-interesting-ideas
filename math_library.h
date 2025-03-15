#ifndef MATH_LIB_H
#define MATH_LIB_H

#include <math.h>
#include <stdio.h>

#define __INCLUDES

#ifdef __INCLUDES
#include <math.h>
#include <stdio.h>
#endif

class Geometry {
public:
    static inline float area(float length, float width) {
        return length * width;
    }

    static inline float perimeter(float length, float width) {
        return 2 * (length + width);
    }

    static inline float circle_area(float radius) {
        const float PI = 3.14159265358979323846f;
        return PI * radius * radius;
    }
};

class Algebra {
public:
    static inline double root(double number, int n) {
        // Handle special cases
        if (n == 0) return 1;
        if (n == 1) return number;
        if (number == 0) return 0;

        // For negative numbers and even roots
        if (number < 0 && n % 2 == 0) {
            return NAN; // Not a number
        }

        // For negative numbers and odd roots
        if (number < 0 && n % 2 != 0) {
            return -pow(-number, 1.0 / n);
        }

        return pow(number, 1.0 / n);
    }

    static inline double degree(double num, int power) {
        return pow(num, power);
    }

    static inline int plus(int first, int second) {
        return first + second;
    }

    static inline int minus(int first, int second) {
        return first - second;
    }

    static inline int multiply(int first, int second) {
        return first * second;
    }

    static inline double divide(int first, int second) {
        if (second == 0) {
            return NAN; // Handle division by zero
        }
        return static_cast<double>(first) / second;
    }

    static inline double logarithm(double base, double x) {
        // Handle invalid inputs
        if (base <= 0 || base == 1 || x <= 0) {
            return NAN;
        }

        // Calculate logarithm using change of base formula
        return log(x) / log(base);
    }

    static inline unsigned long long factorial(int n) {
        if (n < 0) {
            return 0;
        }
        unsigned long long result = 1;
        for (int i = 1; i <= n; ++i) {
            result *= i;
        }
        return result;
    }
    
};

class Physics {
    public:
        // Calculate force using F = ma
        static inline float force(float mass, float acceleration) {
            return mass * acceleration;
        }
    
        // Calculate velocity using v = d/t
        static inline float velocity(float distance, float time) {
            if (time == 0) return NAN;
            return distance / time;
        }
    
        // Calculate kinetic energy using KE = 1/2 * m * v^2
        static inline float kinetic_energy(float mass, float velocity) {
            return 0.5f * mass * velocity * velocity;
        }
    
        // Calculate potential energy using PE = m * g * h
        static inline float potential_energy(float mass, float height, float gravity = 9.81f) {
            return mass * gravity * height;
        }
    
        // Calculate work done using W = F * d
        static inline float work(float force, float distance) {
            return force * distance;
        }
    
        // Calculate power using P = W/t
        static inline float power(float work, float time) {
            if (time == 0) return NAN;
            return work / time;
        }
    
        // Calculate momentum using p = m * v
        static inline float momentum(float mass, float velocity) {
            return mass * velocity;
        }
    
        // Calculate acceleration using a = (v - u)/t
        static inline float acceleration(float final_velocity, float initial_velocity, float time) {
            if (time == 0) return NAN;
            return (final_velocity - initial_velocity) / time;
        }
    };

#endif /* MATH_LIB_H */