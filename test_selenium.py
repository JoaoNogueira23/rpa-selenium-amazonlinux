from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service


chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

# path chromedriver
path_chromedriver = ""

Service = Service(executable_path=path_chromedriver)
driver = webdriver.Chrome(service=Service, options=chrome_options)
driver.get("https://example.com")

title = driver.title
print("page title:", driver.title)

btn = driver.find_element(By.TAG_NAME, "a")

btn.click()

paragraphs = driver.find_elements(By.TAG_NAME, "p")

print("paragraphs found:", len(paragraphs))
# write paragraphs to file
with open("output.txt", "w") as file:
    for p in paragraphs:
        file.write(p.text + "\n")
                   

driver.quit()
