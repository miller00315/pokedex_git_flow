#!/usr/bin/env bash

printf "\e[33;1m%s\e[0m\n" 'Pre-Commit'

# Testes de integração
printf "\e[33;1m%s\e[0m\n" '=== Running Integration Tests ==='
flutter drive --driver=test_driver/integration_driver.dart --target=integration_test/app_test.dart

if [ $? -ne 0 ]; then
  printf "\e[31;1m%s\e[0m\n" '=== Unit Integration error ==='
  exit 1
fi

printf "\e[33;1m%s\e[0m\n" 'Finished running Integration Tests'
printf '%s\n' "${avar}"
