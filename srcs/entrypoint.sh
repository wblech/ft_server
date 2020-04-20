#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wbertoni <wbertoni@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/20 13:29:32 by wbertoni          #+#    #+#              #
#    Updated: 2020/04/20 13:29:37 by wbertoni         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

service mysql start
service nginx start
service php7.3-fpm start
tail -F /dev/null
