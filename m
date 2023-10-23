Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38D47D4141
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJWUw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWUw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 16:52:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAA10C0;
        Mon, 23 Oct 2023 13:52:25 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NKB33Z015542;
        Mon, 23 Oct 2023 20:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HOe7gnb40EBtnJckQPzahHQRjH+lBJ6KzUFjIpZ9CPs=;
 b=pRaLOxwHFxlYhubIz0er7jzFkDVILL5mnqQB+8JegW59atEYKlsKfeKBER/yI96Ww4V4
 dhtdE46Ff1VokaTqJc7n2pnmnWidyqLieKfBykz3fynnzF3/xU8nW8Ky5HFUhplmL8iS
 Q/Zq5e2HOBsM8ujGE+isoUZfFwct+lgI3rkaEHVFdBoemjZlj5PET/a5yDfEw1JRPVTO
 mkMwmgLPaXJOy+p3sXOWzlMNJIyh3UR3PcHEXDlhw2wj8qWWZEkkW0hOeV9yjmXat1/B
 bTnFXhPJL1FkySjn4ueAyDNr5m+Lj3D+IwBU2cTqBmODeS5GMKyxNrSZeHESksVwFUwB WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twymts9h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 20:52:20 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39NKZkTS011065;
        Mon, 23 Oct 2023 20:52:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twymts9gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 20:52:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NIL6mE010315;
        Mon, 23 Oct 2023 20:52:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyb6xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 20:52:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39NKqHY826280696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 20:52:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C87435805A;
        Mon, 23 Oct 2023 20:52:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535E158051;
        Mon, 23 Oct 2023 20:52:16 +0000 (GMT)
Received: from [9.171.5.241] (unknown [9.171.5.241])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Oct 2023 20:52:16 +0000 (GMT)
Message-ID: <b8b752c6-4d91-4849-8a71-e3f43a827a42@linux.ibm.com>
Date:   Mon, 23 Oct 2023 22:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Content-Language: en-GB
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
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
 <567c792e-33e0-9ff6-f5c2-0eae356c7eb1@linux.alibaba.com>
 <ea0dcf7d-8406-476c-b027-145af207873a@linux.ibm.com>
 <59c0c75f-e9df-2ef1-ead2-7c5c97f3e750@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <59c0c75f-e9df-2ef1-ead2-7c5c97f3e750@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oWAQEw4dMUa26dahpZIGDVi4jIo6HiN5
X-Proofpoint-GUID: Jv1WP46DJkhPj05E1BY6ukTygZgS5CCi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 23.10.23 14:18, D. Wythe wrote:
> 
> 
> On 10/23/23 6:28 PM, Wenjia Zhang wrote:
>>
>>
>> On 23.10.23 10:52, D. Wythe wrote:
>>>
>>>
>>> On 10/23/23 4:19 PM, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 20.10.23 04:41, D. Wythe wrote:
>>>>>
>>>>>
>>>>> On 10/20/23 1:40 AM, Wenjia Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 19.10.23 09:33, D. Wythe wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/19/23 4:26 AM, Wenjia Zhang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 17.10.23 04:06, D. Wythe wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>>>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>>>>>
>>>>>>>>>>> Note that we always hold a reference to sock when attempting
>>>>>>>>>>> to submit close_work. 
>>>>>>>>>> yes
>>>>>>>>>> Therefore, if we have successfully
>>>>>>>>>>> canceled close_work from pending, we MUST release that reference
>>>>>>>>>>> to avoid potential leaks.
>>>>>>>>>>>
>>>>>>>>>> Isn't the corresponding reference already released inside the 
>>>>>>>>>> smc_close_passive_work()?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Wenjia,
>>>>>>>>>
>>>>>>>>> If we successfully cancel the close work from the pending state,
>>>>>>>>> it means that smc_close_passive_work() has never been executed.
>>>>>>>>>
>>>>>>>>> You can find more details here.
>>>>>>>>>
>>>>>>>>> /**
>>>>>>>>> * cancel_work_sync - cancel a work and wait for it to finish
>>>>>>>>> * @work:the work to cancel
>>>>>>>>> *
>>>>>>>>> * Cancel @work and wait for its execution to finish. This function
>>>>>>>>> * can be used even if the work re-queues itself or migrates to
>>>>>>>>> * another workqueue. On return from this function, @work is
>>>>>>>>> * guaranteed to be not pending or executing on any CPU.
>>>>>>>>> *
>>>>>>>>> * cancel_work_sync(&delayed_work->work) must not be used for
>>>>>>>>> * delayed_work's. Use cancel_delayed_work_sync() instead.
>>>>>>>>> *
>>>>>>>>> * The caller must ensure that the workqueue on which @work was 
>>>>>>>>> last
>>>>>>>>> * queued can't be destroyed before this function returns.
>>>>>>>>> *
>>>>>>>>> * Return:
>>>>>>>>> * %true if @work was pending, %false otherwise.
>>>>>>>>> */
>>>>>>>>> boolcancel_work_sync(structwork_struct *work)
>>>>>>>>> {
>>>>>>>>> return__cancel_work_timer(work, false);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> Best wishes,
>>>>>>>>> D. Wythe
>>>>>>>> As I understand, queue_work() would wake up the work if the work 
>>>>>>>> is not already on the queue. And the sock_hold() is just prio to 
>>>>>>>> the queue_work(). That means, cancel_work_sync() would cancel 
>>>>>>>> the work either before its execution or after. If your fix 
>>>>>>>> refers to the former case, at this moment, I don't think the 
>>>>>>>> reference can be hold, thus it is unnecessary to put it.
>>>>>>>>>
>>>>>>>
>>>>>>> I am quite confuse about why you think when we cancel the work 
>>>>>>> before its execution,
>>>>>>> the reference can not be hold ?
>>>>>>>
>>>>>>>
>>>>>>> Perhaps the following diagram can describe the problem in better 
>>>>>>> way :
>>>>>>>
>>>>>>> smc_close_cancel_work
>>>>>>> smc_cdc_msg_recv_action
>>>>>>>
>>>>>>>
>>>>>>> sock_hold
>>>>>>> queue_work
>>>>>>> if (cancel_work_sync())        // successfully cancel before 
>>>>>>> execution
>>>>>>> sock_put()                        //  need to put it since we 
>>>>>>> already hold a ref before   queue_work()
>>>>>>>
>>>>>>>
>>>>>> ha, I already thought you might ask such question:P
>>>>>>
>>>>>> I think here two Problems need to be clarified:
>>>>>>
>>>>>> 1) Do you think the bh_lock_sock/bh_unlock_sock in the 
>>>>>> smc_cdc_msg_recv does not protect the smc_cdc_msg_recv_action() 
>>>>>> from cancel_work_sync()?
>>>>>> Maybe that would go back to the discussion in the other patch on 
>>>>>> the behaviors of the locks.
>>>>>>
>>>>>
>>>>> Yes. bh_lock_sock/bh_unlock_sock can not block code execution 
>>>>> protected by lock_sock/unlock(). That is to say, they are not 
>>>>> exclusive.
>>>>>
>>>> No, the logic of the inference is very vague to me. My understand is 
>>>> completely different. That is what I read from the kernel code. They 
>>>> are not *completely* exclusive, because while the bottom half 
>>>> context holds the lock i.e. bh_lock_sock, the process context can 
>>>> not get the lock by lock_sock. (This is actually my main point of my 
>>>> argument for these fixes, and I didn't see any clarify from you). 
>>>> However, while the process context holds the lock by lock_sock, the 
>>>> bottom half context can still get it by bh_lock_sock, this is just 
>>>> like what you showed in the code in lock_sock. Once it gets the 
>>>> ownership, it release the spinlock.
>>>>
>>>
>>> “ while the process context holds the lock by lock_sock, the bottom 
>>> half context can still get it by bh_lock_sock,  ”
>>>
>>> You already got that, so why that sock_set_flag(DONE) and 
>>> sock_set_flag(DEAD) can not happen concurrently ?
>>>
>>
>> Then I'd ask how do you understand this sentence I wrote? "while the 
>> bottom half context holds the lock i.e. bh_lock_sock, the process 
>> context can not get the lock by lock_sock."
>>>
> 
> That's also true.  I have no questions on it.  They are asymmetrical.
> 
> But we cannot guarantee that the interrupt context always holds the lock 
> before the process context, that's why i think
> that sock_set_flag(DONE) and sock_set_flag(DEAD) can run concurrently.
> 
ok, I have to agree with that. I did too much focus on this case :(
So I think the approach of the 1st patch is also appropriate. Thank you 
for taking time to let me out!

>>>>> We can use a very simple example to infer that since bh_lock_sock 
>>>>> is type of spin-lock, if bh_lock_sock/bh_unlock_sock can block 
>>>>> lock_sock/unlock(),
>>>>> then lock_sock/unlock() can also block bh_lock_sock/bh_unlock_sock.
>>>>>
>>>>> If this is true, when the process context already lock_sock(), the 
>>>>> interrupt context must wait for the process to call
>>>>> release_sock(). Obviously, this is very unreasonable.
>>>>>
>>>>>
>>>>>> 2) If the queue_work returns true, as I said in the last main, the 
>>>>>> work should be (being) executed. How could the cancel_work_sync() 
>>>>>> cancel the work before execution successgully?
>>>>>
>>>>> No, that's not true. In fact, if queue_work returns true, it simply 
>>>>> means that we have added the task to the queue and may schedule a 
>>>>> worker to execute it,
>>>>> but it does not guarantee that the task will be executed or is 
>>>>> being executed when it returns true,
>>>>> the task might still in the list and waiting some worker to execute 
>>>>> it.
>>>>>
>>>>> We can make a simple inference,
>>>>>
>>>>> 1. A known fact is that if no special flag (WORK_UNBOUND) is given, 
>>>>> tasks submitted will eventually be executed on the CPU where they 
>>>>> were submitted.
>>>>>
>>>>> 2. If the queue_work returns true, the work should be or is being 
>>>>> executed
>>>>>
>>>>> If all of the above are true, when we invoke queue_work in an 
>>>>> interrupt context, does it mean that the submitted task will be 
>>>>> executed in the interrupt context?
>>>>>
>>>>>
>>>>> Best wishes,
>>>>> D. Wythe
>>>>>
>>>> If you say the thread is not gauranteed to be waken up in then 
>>>> queue_work to execute the work, please explain what the kick_pool 
>>>> function does.
>>>
>>> I never said that.
>>>
>> What do you understand on the kick_pool there?
> 
> 
> 
> 
> I think this simple logic-code graph can totally explain my point of 
> view in clear.
> 
> My key point is queue_work can not guarantee the work_1 is executed or 
> being executed, the work_1 might still be
> in the list ( before executed ) .
> 
> The kick_pool() might wake up the 'a_idle_worker' from schedule(), and 
> then the work_1 can be executed soon.
> But we can not said that the  work_1 is already executed or being executed.
> 
> In fact, we can invoke cancel_work_syn() to delete the work_1 from the 
> list to avoid to be executed, when the
> a_idle_worker_main has not delete(or pop) the work_1 yet.
> 
> Besides, there is a upper limit to the number of idle workers. If the 
> current number of work_x being executed exceeds this number,
> the work_1 must wait until there are idle_workers available. In that 
> case, we can not said that the  work_1 is already executed
> or being executed as well.
> 
I do agree with this explaination. My thought was that cancel_work_syn() 
deleting the work_1 from the list to avoid to be executed would rarely 
happen, as I was focusing the scenario above. Since we have the 
agreement on the locks now, I agree that would happen.

Thanks again!
Here you are:
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
