#!/usr/bin/python3
import requests


def number_of_subscibers(subreddit):
    ''' Finds the number of subscribers in subreddit'''

    if subreddit is None or type(subreddit) is not str:
        return 0

    header = {'User-Agent': 'Chrome/66.0.3359.139 Mobile Safari/537.36'}
    url = "https://api.reddit.com/r/{}/about/".format(subreddit)

    response = requests.get(url, headers=header)

    if response.status_code == 200:
        subs = response.json()["data"]["subscribers"]
    else:
        subs = 0

    return subs
