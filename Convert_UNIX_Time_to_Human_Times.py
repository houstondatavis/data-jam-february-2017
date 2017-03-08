#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 25 09:02:21 2017

@author: salientintent
"""

import pandas as pd

#%% import data

df_flights = pd.read_csv('flights.csv')
df_routes = pd.read_csv('routes.csv')
df_tracks = pd.read_csv('tracks.csv')
df_weather = pd.read_csv('weather.csv')

#%% set definitions

# converting data in df_flights
def convert_time_flight(df_input):
    df_input['departuretime_human'] = pd.to_datetime(df_input['departuretime'],unit='s')
    df_input['arrivaltime_human'] = pd.to_datetime(df_input['arrivaltime'],unit='s')
    df_input['depart_date'] = df_input['departuretime_human'].dt.date
    df_input['arrive_date'] = df_input['arrivaltime_human'].dt.date
    df_input['depart_timestamp'] = df_input['departuretime_human'].dt.time
    df_input['arrive_timestamp'] = df_input['arrivaltime_human'].dt.time
    df_input['depart_time_hour_stamp'] = df_input['departuretime_human'].dt.hour
    df_input['arrive_time_hour_stamp'] = df_input['arrivaltime_human'].dt.hour
    return df_input

# converting data in df_tracks
def convert_time_track(df_input):
    df_input['track_human'] = pd.to_datetime(df_input['timestamp'],unit='s')
    df_input['track_date'] = df_input['track_human'].dt.date
    df_input['track_timestamp'] = df_input['track_human'].dt.time
    df_input['track_time_hour_stamp'] = df_input['track_human'].dt.hour
    return df_input

# converting data in df_weather
def convert_time_weather(df_input):
    df_input['time_human'] = pd.to_datetime(df_input['time'],unit='s')
    df_input['time_date'] = df_input['time_human'].dt.date
    df_input['time_timestamp'] = df_input['time_human'].dt.time
    df_input['time_time_hour_stamp'] = df_input['time_human'].dt.hour
    return df_input


#%% initial processing
df_flights = convert_time_flight(df_flights)
df_tracks = convert_time_track(df_tracks)
df_weather = convert_time_weather(df_weather)

#%% outputting my new time data into CSV files
df_flights.to_csv('new_flights.csv')
df_tracks.to_csv('new_tracks.csv')
df_weather.to_csv('new_weather.csv')
