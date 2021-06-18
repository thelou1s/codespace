#https://ideone.com/Cgi5aP

#https://zhuanlan.zhihu.com/p/104918655

#-*- coding:utf8 -*-

import asyncio
 
async def test(i):
    print('test_a', i)
    await asyncio.sleep(1)
    print('test_b', i)
 
if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    tasks = [test(i) for i in range(30)]
    loop.run_until_complete(asyncio.wait(tasks))
    loop.close()
    
    
# stdout:
# test_a 3
# test_a 14
# test_a 1
# test_a 15
# test_a 2
# test_a 16
# test_a 18
# test_a 0
# test_a 19
# test_a 4
# test_a 20
# test_a 5
# test_a 21
# test_a 6
# test_a 22
# test_a 7
# test_a 23
# test_a 8
# test_a 24
# test_a 17
# test_a 25
# test_a 9
# test_a 26
# test_a 10
# test_a 27
# test_a 11
# test_a 28
# test_a 12
# test_a 29
# test_a 13
# test_b 3
# test_b 14
# test_b 1
# test_b 15
# test_b 2
# test_b 16
# test_b 18
# test_b 0
# test_b 19
# test_b 4
# test_b 20
# test_b 5
# test_b 21
# test_b 6
# test_b 22
# test_b 7
# test_b 23
# test_b 8
# test_b 24
# test_b 17
# test_b 25
# test_b 9
# test_b 26
# test_b 10
# test_b 27
# test_b 11
# test_b 28
# test_b 12
# test_b 29
# test_b 13
