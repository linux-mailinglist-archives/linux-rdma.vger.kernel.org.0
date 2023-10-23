Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980097D2C81
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjJWIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJWIUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 04:20:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878FEE;
        Mon, 23 Oct 2023 01:20:08 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N8GTQP025249;
        Mon, 23 Oct 2023 08:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XCFY9Zt73C/zdSBvzDn5qUMBCE/4dyHPB6YcoeLIraw=;
 b=ZgddJsDzHQOYtq6A6nqgQdZhrJkOVRI7/6nS3RwcJr8RIbK0kKgpkjbuJVjPxZFyr3PY
 JHFeBw+TFClQmtLjoW1nt18NGF6jCssRuh/KBa8RthSqpGMWc9NmgG+KxyE4Ozjlos2i
 9JgT1/7RAKGmrY4X17BlS2xBb4COzhOoufCHwaNI4S9VC8YVI8dWCdswnS480TK6/Gxm
 DXWGteUptCQ1sww+3BJX5eDY70/z4cCeSykOG8xYvH5jGMDZNQM+EAz4qrH4zylMFXxu
 gk9D0dagWEXMSxQOr5lMZwPz6cOFdbGmTwiBAJubsC43IYmd+RLJfNTRxXnJMM8KWAwl 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twmrhgswn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 08:19:59 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39N8GvUd028304;
        Mon, 23 Oct 2023 08:19:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twmrhgsw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 08:19:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7AgL3026833;
        Mon, 23 Oct 2023 08:19:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsynfbks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 08:19:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39N8JulW19661452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 08:19:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 582C758056;
        Mon, 23 Oct 2023 08:19:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9AA058052;
        Mon, 23 Oct 2023 08:19:54 +0000 (GMT)
Received: from [9.171.5.241] (unknown [9.171.5.241])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Oct 2023 08:19:54 +0000 (GMT)
Message-ID: <83476aac-a2f6-4705-8aec-762b1f165210@linux.ibm.com>
Date:   Mon, 23 Oct 2023 10:19:53 +0200
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
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <94f89147-cedc-b8b2-415f-942ec14cd670@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oiew6GEP6bnlVrDSVrvVm_dRJRq3_6Ba
X-Proofpoint-GUID: jzW80NNb-lmu6XtFigsua8tCnBNmers6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 20.10.23 04:41, D. Wythe wrote:
> 
> 
> On 10/20/23 1:40 AM, Wenjia Zhang wrote:
>>
>>
>> On 19.10.23 09:33, D. Wythe wrote:
>>>
>>>
>>> On 10/19/23 4:26 AM, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 17.10.23 04:06, D. Wythe wrote:
>>>>>
>>>>>
>>>>> On 10/13/23 3:04 AM, Wenjia Zhang wrote:
>>>>>>
>>>>>>
>>>>>> On 11.10.23 09:33, D. Wythe wrote:
>>>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>>>
>>>>>>> Note that we always hold a reference to sock when attempting
>>>>>>> to submit close_work. 
>>>>>> yes
>>>>>> Therefore, if we have successfully
>>>>>>> canceled close_work from pending, we MUST release that reference
>>>>>>> to avoid potential leaks.
>>>>>>>
>>>>>> Isn't the corresponding reference already released inside the 
>>>>>> smc_close_passive_work()?
>>>>>>
>>>>>
>>>>> Hi Wenjia,
>>>>>
>>>>> If we successfully cancel the close work from the pending state,
>>>>> it means that smc_close_passive_work() has never been executed.
>>>>>
>>>>> You can find more details here.
>>>>>
>>>>> /**
>>>>> * cancel_work_sync - cancel a work and wait for it to finish
>>>>> * @work:the work to cancel
>>>>> *
>>>>> * Cancel @work and wait for its execution to finish. This function
>>>>> * can be used even if the work re-queues itself or migrates to
>>>>> * another workqueue. On return from this function, @work is
>>>>> * guaranteed to be not pending or executing on any CPU.
>>>>> *
>>>>> * cancel_work_sync(&delayed_work->work) must not be used for
>>>>> * delayed_work's. Use cancel_delayed_work_sync() instead.
>>>>> *
>>>>> * The caller must ensure that the workqueue on which @work was last
>>>>> * queued can't be destroyed before this function returns.
>>>>> *
>>>>> * Return:
>>>>> * %true if @work was pending, %false otherwise.
>>>>> */
>>>>> boolcancel_work_sync(structwork_struct *work)
>>>>> {
>>>>> return__cancel_work_timer(work, false);
>>>>> }
>>>>>
>>>>> Best wishes,
>>>>> D. Wythe
>>>> As I understand, queue_work() would wake up the work if the work is 
>>>> not already on the queue. And the sock_hold() is just prio to the 
>>>> queue_work(). That means, cancel_work_sync() would cancel the work 
>>>> either before its execution or after. If your fix refers to the 
>>>> former case, at this moment, I don't think the reference can be 
>>>> hold, thus it is unnecessary to put it.
>>>>>
>>>
>>> I am quite confuse about why you think when we cancel the work before 
>>> its execution,
>>> the reference can not be hold ?
>>>
>>>
>>> Perhaps the following diagram can describe the problem in better way :
>>>
>>> smc_close_cancel_work
>>> smc_cdc_msg_recv_action
>>>
>>>
>>> sock_hold
>>> queue_work
>>> if (cancel_work_sync())        // successfully cancel before execution
>>> sock_put()                        //  need to put it since we already 
>>> hold a ref before   queue_work()
>>>
>>>
>> ha, I already thought you might ask such question:P
>>
>> I think here two Problems need to be clarified:
>>
>> 1) Do you think the bh_lock_sock/bh_unlock_sock in the 
>> smc_cdc_msg_recv does not protect the smc_cdc_msg_recv_action() from 
>> cancel_work_sync()?
>> Maybe that would go back to the discussion in the other patch on the 
>> behaviors of the locks.
>>
> 
> Yes. bh_lock_sock/bh_unlock_sock can not block code execution protected 
> by lock_sock/unlock(). That is to say, they are not exclusive.
> 
No, the logic of the inference is very vague to me. My understand is 
completely different. That is what I read from the kernel code. They are 
not *completely* exclusive, because while the bottom half context holds 
the lock i.e. bh_lock_sock, the process context can not get the lock by 
lock_sock. (This is actually my main point of my argument for these 
fixes, and I didn't see any clarify from you). However, while the 
process context holds the lock by lock_sock, the bottom half context can 
still get it by bh_lock_sock, this is just like what you showed in the 
code in lock_sock. Once it gets the ownership, it release the spinlock.

> We can use a very simple example to infer that since bh_lock_sock is 
> type of spin-lock, if bh_lock_sock/bh_unlock_sock can block 
> lock_sock/unlock(),
> then lock_sock/unlock() can also block bh_lock_sock/bh_unlock_sock.
> 
> If this is true, when the process context already lock_sock(), the 
> interrupt context must wait for the process to call
> release_sock(). Obviously, this is very unreasonable.
> 
> 
>> 2) If the queue_work returns true, as I said in the last main, the 
>> work should be (being) executed. How could the cancel_work_sync() 
>> cancel the work before execution successgully?
> 
> No, that's not true. In fact, if queue_work returns true, it simply 
> means that we have added the task to the queue and may schedule a worker 
> to execute it,
> but it does not guarantee that the task will be executed or is being 
> executed when it returns true,
> the task might still in the list and waiting some worker to execute it.
> 
> We can make a simple inference,
> 
> 1. A known fact is that if no special flag (WORK_UNBOUND) is given, 
> tasks submitted will eventually be executed on the CPU where they were 
> submitted.
> 
> 2. If the queue_work returns true, the work should be or is being executed
> 
> If all of the above are true, when we invoke queue_work in an interrupt 
> context, does it mean that the submitted task will be executed in the 
> interrupt context?
> 
> 
> Best wishes,
> D. Wythe
> 
If you say the thread is not gauranteed to be waken up in then 
queue_work to execute the work, please explain what the kick_pool 
function does.

However, the spin_lock understanding is still the key problem in the 
cases. As I said, if it is not get clarify, we don't really need to go 
on to disucss this.

>>
>>>>>>> Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD 
>>>>>>> link groups")
>>>>>>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>>>>>>> ---
>>>>>>>   net/smc/smc_close.c | 3 ++-
>>>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>>>>>>> index 449ef45..10219f5 100644
>>>>>>> --- a/net/smc/smc_close.c
>>>>>>> +++ b/net/smc/smc_close.c
>>>>>>> @@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct 
>>>>>>> smc_sock *smc)
>>>>>>>       struct sock *sk = &smc->sk;
>>>>>>>         release_sock(sk);
>>>>>>> -    cancel_work_sync(&smc->conn.close_work);
>>>>>>> +    if (cancel_work_sync(&smc->conn.close_work))
>>>>>>> +        sock_put(sk);
>>>>>>> cancel_delayed_work_sync(&smc->conn.tx_work);
>>>>>>>       lock_sock(sk);
>>>>>>>   }
>>>>>
>>>
>>>
> 
