Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56897D2D3D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjJWIw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjJWIw4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 04:52:56 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D437D6E;
        Mon, 23 Oct 2023 01:52:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuiM0ct_1698051163;
Received: from 30.221.149.80(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VuiM0ct_1698051163)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 16:52:48 +0800
Message-ID: <567c792e-33e0-9ff6-f5c2-0eae356c7eb1@linux.alibaba.com>
Date:   Mon, 23 Oct 2023 16:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
 <bdcb307f-d2a8-4aef-bb7d-dd87e56ff740@linux.ibm.com>
 <ee641ca5-104b-d1ec-5b2a-e20237c5378a@linux.alibaba.com>
 <ad5e4191-227e-4a62-a110-472618ef7de1@linux.ibm.com>
 <305c7ae2-a902-3e30-5e67-b590d848d0ba@linux.alibaba.com>
 <990a6b09-135a-41fb-a375-c37ffec6fe99@linux.ibm.com>
 <94f89147-cedc-b8b2-415f-942ec14cd670@linux.alibaba.com>
 <83476aac-a2f6-4705-8aec-762b1f165210@linux.ibm.com>
Content-Language: en-US
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <83476aac-a2f6-4705-8aec-762b1f165210@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/23/23 4:19 PM, Wenjia Zhang wrote:
>
>
> On 20.10.23 04:41, D. Wythe wrote:
>>
>>
>> On 10/20/23 1:40 AM, Wenjia Zhang wrote:
>>>
>>>
>>> On 19.10.23 09:33, D. Wythe wrote:
>>>>
>>>>
>>>> On 10/19/23 4:26 AM, Wenjia Zhang wrote:
>>>>>
>>>>>
>>>>> On 17.10.23 04:06, D. Wythe wrote:
>>>>>>
>>>>>>
>>>>>> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>>
>>>>>>>> Note that we always hold a reference to sock when attempting
>>>>>>>> to submit close_work. 
>>>>>>> yes
>>>>>>> Therefore, if we have successfully
>>>>>>>> canceled close_work from pending, we MUST release that reference
>>>>>>>> to avoid potential leaks.
>>>>>>>>
>>>>>>> Isn't the corresponding reference already released inside the 
>>>>>>> smc_close_passive_work()?
>>>>>>>
>>>>>>
>>>>>> Hi Wenjia,
>>>>>>
>>>>>> If we successfully cancel the close work from the pending state,
>>>>>> it means that smc_close_passive_work() has never been executed.
>>>>>>
>>>>>> You can find more details here.
>>>>>>
>>>>>> /**
>>>>>> * cancel_work_sync - cancel a work and wait for it to finish
>>>>>> * @work:the work to cancel
>>>>>> *
>>>>>> * Cancel @work and wait for its execution to finish. This function
>>>>>> * can be used even if the work re-queues itself or migrates to
>>>>>> * another workqueue. On return from this function, @work is
>>>>>> * guaranteed to be not pending or executing on any CPU.
>>>>>> *
>>>>>> * cancel_work_sync(&delayed_work->work) must not be used for
>>>>>> * delayed_work's. Use cancel_delayed_work_sync() instead.
>>>>>> *
>>>>>> * The caller must ensure that the workqueue on which @work was last
>>>>>> * queued can't be destroyed before this function returns.
>>>>>> *
>>>>>> * Return:
>>>>>> * %true if @work was pending, %false otherwise.
>>>>>> */
>>>>>> boolcancel_work_sync(structwork_struct *work)
>>>>>> {
>>>>>> return__cancel_work_timer(work, false);
>>>>>> }
>>>>>>
>>>>>> Best wishes,
>>>>>> D. Wythe
>>>>> As I understand, queue_work() would wake up the work if the work 
>>>>> is not already on the queue. And the sock_hold() is just prio to 
>>>>> the queue_work(). That means, cancel_work_sync() would cancel the 
>>>>> work either before its execution or after. If your fix refers to 
>>>>> the former case, at this moment, I don't think the reference can 
>>>>> be hold, thus it is unnecessary to put it.
>>>>>>
>>>>
>>>> I am quite confuse about why you think when we cancel the work 
>>>> before its execution,
>>>> the reference can not be hold ?
>>>>
>>>>
>>>> Perhaps the following diagram can describe the problem in better way :
>>>>
>>>> smc_close_cancel_work
>>>> smc_cdc_msg_recv_action
>>>>
>>>>
>>>> sock_hold
>>>> queue_work
>>>> if (cancel_work_sync())        // successfully cancel before execution
>>>> sock_put()                        //  need to put it since we 
>>>> already hold a ref before   queue_work()
>>>>
>>>>
>>> ha, I already thought you might ask such question:P
>>>
>>> I think here two Problems need to be clarified:
>>>
>>> 1) Do you think the bh_lock_sock/bh_unlock_sock in the 
>>> smc_cdc_msg_recv does not protect the smc_cdc_msg_recv_action() from 
>>> cancel_work_sync()?
>>> Maybe that would go back to the discussion in the other patch on the 
>>> behaviors of the locks.
>>>
>>
>> Yes. bh_lock_sock/bh_unlock_sock can not block code execution 
>> protected by lock_sock/unlock(). That is to say, they are not exclusive.
>>
> No, the logic of the inference is very vague to me. My understand is 
> completely different. That is what I read from the kernel code. They 
> are not *completely* exclusive, because while the bottom half context 
> holds the lock i.e. bh_lock_sock, the process context can not get the 
> lock by lock_sock. (This is actually my main point of my argument for 
> these fixes, and I didn't see any clarify from you). However, while 
> the process context holds the lock by lock_sock, the bottom half 
> context can still get it by bh_lock_sock, this is just like what you 
> showed in the code in lock_sock. Once it gets the ownership, it 
> release the spinlock.
>

“ while the process context holds the lock by lock_sock, the bottom half 
context can still get it by bh_lock_sock,  ”

You already got that, so why that sock_set_flag(DONE) and 
sock_set_flag(DEAD) can not happen concurrently ?


>> We can use a very simple example to infer that since bh_lock_sock is 
>> type of spin-lock, if bh_lock_sock/bh_unlock_sock can block 
>> lock_sock/unlock(),
>> then lock_sock/unlock() can also block bh_lock_sock/bh_unlock_sock.
>>
>> If this is true, when the process context already lock_sock(), the 
>> interrupt context must wait for the process to call
>> release_sock(). Obviously, this is very unreasonable.
>>
>>
>>> 2) If the queue_work returns true, as I said in the last main, the 
>>> work should be (being) executed. How could the cancel_work_sync() 
>>> cancel the work before execution successgully?
>>
>> No, that's not true. In fact, if queue_work returns true, it simply 
>> means that we have added the task to the queue and may schedule a 
>> worker to execute it,
>> but it does not guarantee that the task will be executed or is being 
>> executed when it returns true,
>> the task might still in the list and waiting some worker to execute it.
>>
>> We can make a simple inference,
>>
>> 1. A known fact is that if no special flag (WORK_UNBOUND) is given, 
>> tasks submitted will eventually be executed on the CPU where they 
>> were submitted.
>>
>> 2. If the queue_work returns true, the work should be or is being 
>> executed
>>
>> If all of the above are true, when we invoke queue_work in an 
>> interrupt context, does it mean that the submitted task will be 
>> executed in the interrupt context?
>>
>>
>> Best wishes,
>> D. Wythe
>>
> If you say the thread is not gauranteed to be waken up in then 
> queue_work to execute the work, please explain what the kick_pool 
> function does.

I never said that.

>
> However, the spin_lock understanding is still the key problem in the 
> cases. As I said, if it is not get clarify, we don't really need to go 
> on to disucss this.
>
>>>
>>>>>>>> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD 
>>>>>>>> link groups")
>>>>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>>>>> ---
>>>>>>>>   net/smc/smc_close.c | 3 ++-
>>>>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>>>>>>> index 449ef45..10219f5 100644
>>>>>>>> --- a/net/smc/smc_close.c
>>>>>>>> +++ b/net/smc/smc_close.c
>>>>>>>> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct 
>>>>>>>> smc_sock *smc)
>>>>>>>>       struct sock *sk = &smc->sk;
>>>>>>>>         release_sock(sk);
>>>>>>>> -    cancel_work_sync(&smc->conn.close_work);
>>>>>>>> +    if (cancel_work_sync(&smc->conn.close_work))
>>>>>>>> +        sock_put(sk);
>>>>>>>> cancel_delayed_work_sync(&smc->conn.tx_work);
>>>>>>>>       lock_sock(sk);
>>>>>>>>   }
>>>>>>
>>>>
>>>>
>>

