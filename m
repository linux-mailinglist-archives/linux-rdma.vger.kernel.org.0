Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C57B7609
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJDBA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Oct 2023 21:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDBA1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Oct 2023 21:00:27 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302D6AB
        for <linux-rdma@vger.kernel.org>; Tue,  3 Oct 2023 18:00:24 -0700 (PDT)
Message-ID: <f3c3f4bd-0375-41b4-b479-5d3194ecb985@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696381222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRBdpzml2ZCIZi5BWK8Cc6wMPYQn2q//bezmHocgblY=;
        b=jVRNH/jH3Zw0g07ypObVig5ibFd4lvz6ekNKTZ3ly1TqHZd/muLwnX6D49UfDO+F8qMxyy
        PhVaWnVETfKsJSm+JMILpVNI/a29OXEMLw7b0wieRhODdrO75uy4Bdpuecjbsjqb2qz6FX
        DpSh1mXELscjAvLR5S10T8Mmg4fG28Y=
Date:   Wed, 4 Oct 2023 09:00:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
To:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <6d9aaf05-c4cb-2b8e-c3dd-899e0360b6a1@gmail.com>
 <20231001063048.GA6351@unreal>
 <8afdc6ac-1f31-c12f-a60c-811a0101fc89@linux.dev>
 <88137631-028c-4a60-b7b1-ac55f98badbf@app.fastmail.com>
 <a0d05185-7f03-b3a8-1493-2b50302161d2@linux.dev>
 <e1576d79-642d-40bd-8e55-c37009cb6426@app.fastmail.com>
 <1290ba1d-6102-ea17-c80e-9f1280b26067@linux.dev>
 <20231003095901.GA51282@unreal>
 <5ea7795a-49a6-2ba0-4caf-02ba7b6961f9@linux.dev>
 <20231003181123.GD51282@unreal>
 <be4c9b0e-8acf-7fee-5ad0-209df5d3b0f9@linux.dev>
In-Reply-To: <be4c9b0e-8acf-7fee-5ad0-209df5d3b0f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/10/4 8:46, Zhu Yanjun 写道:
>
> 在 2023/10/4 2:11, Leon Romanovsky 写道:
>> On Tue, Oct 03, 2023 at 11:29:42PM +0800, Zhu Yanjun wrote:
>>> 在 2023/10/3 17:59, Leon Romanovsky 写道:
>>>> On Tue, Oct 03, 2023 at 04:55:40PM +0800, Zhu Yanjun wrote:
>>>>> 在 2023/10/1 14:50, Leon Romanovsky 写道:
>>>>>> On Sun, Oct 1, 2023, at 09:47, Zhu Yanjun wrote:
>>>>>>> 在 2023/10/1 14:39, Leon Romanovsky 写道:
>>>>>>>> On Sun, Oct 1, 2023, at 09:34, Zhu Yanjun wrote:
>>>>>>>>> 在 2023/10/1 14:30, Leon Romanovsky 写道:
>>>>>>>>>> On Wed, Sep 27, 2023 at 11:51:12AM -0500, Bob Pearson wrote:
>>>>>>>>>>> On 9/26/23 15:24, Bart Van Assche wrote:
>>>>>>>>>>>> On 9/26/23 11:34, Bob Pearson wrote:
>>>>>>>>>>>>> I am working to try to reproduce the KASAN warning. 
>>>>>>>>>>>>> Unfortunately,
>>>>>>>>>>>>> so far I am not able to see it in Ubuntu + Linus' kernel 
>>>>>>>>>>>>> (as you described) on metal. The config file is different 
>>>>>>>>>>>>> but copies the CONFIG_KASAN_xxx exactly as yours. With 
>>>>>>>>>>>>> KASAN enabled it hangs on every iteration of srp/002 but 
>>>>>>>>>>>>> without a KASAN warning. I am now building an openSuSE VM 
>>>>>>>>>>>>> for qemu and will see if that causes the warning.
>>>>>>>>>>>> Hi Bob,
>>>>>>>>>>>>
>>>>>>>>>>>> Did you try to understand the report that I shared? My 
>>>>>>>>>>>> conclusion from
>>>>>>>>>>>> the report is that when using tasklets rxe_completer() only 
>>>>>>>>>>>> runs after
>>>>>>>>>>>> rxe_requester() has finished and also that when using work 
>>>>>>>>>>>> queues that
>>>>>>>>>>>> rxe_completer() may run concurrently with rxe_requester(). 
>>>>>>>>>>>> This patch
>>>>>>>>>>>> seems to fix all issues that I ran into with the rdma_rxe 
>>>>>>>>>>>> workqueue
>>>>>>>>>>>> patch (I have not tried to verify the performance 
>>>>>>>>>>>> implications of this
>>>>>>>>>>>> patch):
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c 
>>>>>>>>>>>> b/drivers/infiniband/sw/rxe/rxe_task.c
>>>>>>>>>>>> index 1501120d4f52..6cd5d5a7a316 100644
>>>>>>>>>>>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>>>>>>>>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>>>>>>>>>>>> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
>>>>>>>>>>>>
>>>>>>>>>>>>       int rxe_alloc_wq(void)
>>>>>>>>>>>>       {
>>>>>>>>>>>> -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 
>>>>>>>>>>>> WQ_MAX_ACTIVE);
>>>>>>>>>>>> +       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
>>>>>>>>>>>>              if (!rxe_wq)
>>>>>>>>>>>>                      return -ENOMEM;
>>>>> With this commit, a test run for several days. The similar problem 
>>>>> still
>>>>> occurred.
>>>>>
>>>>> The problem is very similar with the one that Bart mentioned.
>>>>>
>>>>> It is very possible that WQ_MAX_ACTIVE is changed to 1, then this 
>>>>> problem is
>>>>> alleviated.
>>>>>
>>>>> In the following
>>>>>
>>>>> 4661 __printf(1, 4)
>>>>> 4662 struct workqueue_struct *alloc_workqueue(const char *fmt,
>>>>> 4663                                          unsigned int flags,
>>>>> 4664                                          int max_active, ...)
>>>>> 4665 {
>>>>> 4666         va_list args;
>>>>> 4667         struct workqueue_struct *wq;
>>>>> 4668         struct pool_workqueue *pwq;
>>>>> 4669
>>>>> 4670         /*
>>>>> 4671          * Unbound && max_active == 1 used to imply ordered, 
>>>>> which is
>>>>> no longer
>>>>> 4672          * the case on many machines due to per-pod pools. While
>>>>> 4673          * alloc_ordered_workqueue() is the right way to 
>>>>> create an
>>>>> ordered
>>>>> 4674          * workqueue, keep the previous behavior to avoid subtle
>>>>> breakages.
>>>>> 4675          */
>>>>> 4676         if ((flags & WQ_UNBOUND) && max_active == 1)
>>>>> <---This means that workqueue is ordered.
>>>>> 4677                 flags |= __WQ_ORDERED;
>>>>> ...
>>>>>
>>>>> Do this mean that the ordered workqueue covers the root cause? When
>>>>> workqueue is changed to ordered, it is difficult to reproduce this 
>>>>> problem.

>>>>> Got it.
>
> Is there any way to ensure the following?
>
> if a mail does not appear in the rdma maillist, this mail will not be 
> reviewed?


Sorry. My bad. I used the wrong rdma maillist.


>
>>
>>> The analysis is as below:
>>>
>>> Because workqueue will sleep when it is preempted, sometimes the 
>>> sleep time
>>> will exceed the timeout
>>>
>>> of rdma packets. As such, rdma stack or ULP will oom or hang. This 
>>> is why
>>> workqueue will cause ULP hang.
>>>
>>> But tasklet will not sleep. So this kind of problem will not occur with
>>> tasklet.
>>>
>>> About the performance, currently ordered workqueue can only execute 
>>> at most
>>> one work item at any given
>>>
>>> time in the queued order. So in RXE, workqueue will not execute more 
>>> jobs
>>> than tasklet.
>> It is because of changing max_active to be 1. Once that bug will be
>> fixed, RXE will be able to spread traffic on all CPUs.
>

Sure. I agree with you.


After max_active is changed to 1, the workqueue is the ordered workqueue.

The ordered workqueue will execute the work item one by one on differen 
CPUs,

that is, after one work item is complete, the ordered workqueue will 
execute another one

in the queued order on different CPUs. Tasklet will execute the jobs in 
the same CPU one by one.

So if the total job number is the same, the ordered workqueue will have 
the same execution time with the tasklet.

But the ordered workqueue has more overhead in scheduling than the tasklet.

In total, the performance of the ordered workqueue is not good compared 
with the tasklet.

Zhu Yanjun
