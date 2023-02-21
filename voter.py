from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import warnings
from fake_useragent import UserAgent
import threading
from webdriver_manager.chrome import ChromeDriverManager


warnings.filterwarnings("ignore", category=DeprecationWarning) 



def mainstart():
    for x in range(1000):
        ua = UserAgent()
        userAgent = ua.random

        print("Iteration: " + str(x + 1))

        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument("--incognito")
        chrome_options.add_experimental_option("useAutomationExtension", False)
        chrome_options.add_experimental_option("excludeSwitches",["enable-automation"])
        chrome_options.add_argument(f'user-agent={userAgent}')


        driver = webdriver.Chrome(ChromeDriverManager().install(), chrome_options=chrome_options)
        driver.get('https://www.silive.com/readerschoice/2023/02/which-of-these-68-bacon-egg-and-cheese-sandwiches-deserve-the-title-of-best-of-staten-island.html')


        element = driver.find_element(By.ID, "PDI_answer53130235")

        driver.execute_script("arguments[0].click();", element)
        time.sleep(2)

        element2 = driver.find_element(By.ID, "pd-vote-button11649767")

        driver.execute_script("arguments[0].click();", element2)

        time.sleep(2)

        driver.quit()

mainstart()
