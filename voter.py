from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import warnings
from fake_useragent import UserAgent
import threading
from webdriver_manager.chrome import ChromeDriverManager


warnings.filterwarnings("ignore", category=DeprecationWarning) 



def mainstart():
    x = 0
    while True:
        ua = UserAgent()
        userAgent = ua.random

        print("Iteration: " + str(x + 1))
        x += 1

        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument("--incognito")
        # chrome_options.add_argument("headless")
        chrome_options.add_experimental_option("useAutomationExtension", False)
        chrome_options.add_experimental_option("excludeSwitches",["enable-automation"])
        chrome_options.add_argument(f'user-agent={userAgent}')


        driver = webdriver.Chrome(ChromeDriverManager().install(), chrome_options=chrome_options)
        driver.get('https://www.silive.com/readerschoice/2024/04/vote-now-who-has-the-best-pasta-dish-on-staten-island-best-of-2024.html')


        element = driver.find_element(By.ID, "PDI_answer60748762")

        driver.execute_script("arguments[0].click();", element)
        time.sleep(2)

        element2 = driver.find_element(By.ID, "pd-vote-button13594396")

        driver.execute_script("arguments[0].click();", element2)

        time.sleep(2)

        print(driver.find_element(By.ID, "question-top-13594396").text)

        time.sleep(2)

        driver.quit()

mainstart()
