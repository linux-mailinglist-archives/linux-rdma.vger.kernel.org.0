Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026F61F85B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKGQHF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiKGQGW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:06:22 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E120370
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:06:18 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t62so12580290oib.12
        for <linux-rdma@vger.kernel.org>; Mon, 07 Nov 2022 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1PmWesmDB3y9Hlad/mXuQSdn7BGdPXlpBDx4350r5c=;
        b=AT3lTkXfeXfvSzm/KZOOoVtaSJneiiPpGh1bZGE+fXPdKJvq8tuEQRIaQ4JNE5n+H5
         3e7mevS4C46p/gukyIDtkmG6ioGNjKcUabbIBBko8CN8lz18LnPoNHTlUkz7Nktm1YEv
         yTn5RGZjjqiGe6eqJEOKdEC1O2GGmvpsOV9rEFyak6kmavI93BmTE2ZeJMNwZJZHumUP
         YKdxBIHqFFbqgWjDitIVqkYSmZ7Bzt7vTz7xZ7nuQ+oJx+1n9N9VAYkv5wFANMsouv82
         kRV+gJjumXDIzDgqpyUAY8IiW1XTFomCnzAFCPqi5z3+aECP9o+/l0lEUGw3C90UAMSm
         iMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1PmWesmDB3y9Hlad/mXuQSdn7BGdPXlpBDx4350r5c=;
        b=eryb2aIOwA8K03jOrKZIJnDIbLiNnAge8IMyQMr4xeKIFe1fL27gq3HLVHhdmPQPxV
         J2I66cLMH+O9MJ97S1XkN6RqDACUqVgRonAMndk8vLq+3EmjXsDZ9DeD5zxx0TydW93q
         xELNBUN4Pfy36OOXEWp6ZN2Mh7/pj7h9oIkg6vWPWi0+Di7W4bqqWBThEh0dEeZRhqz9
         uH4f94SG55Oxs7OFAyWALQdBJykJEdZyOS6Gt5mFWG79Vq0rTOh74foJ+RbXs9Hyq9PU
         bCD5c5YLTMdykrw5NYP4NJ67pubpV9iUOPfc83DkSMcNYbLXgznph5E2mUsMN0lA5XCY
         KWtQ==
X-Gm-Message-State: ACrzQf0HAlS7sn5p6dLwVmPCVEoIZ8IxULk71rL/jORXok8KTbm6F3D3
        UtnqfA1VSWc2Zh0QsRbOk40=
X-Google-Smtp-Source: AMsMyM48ne4j+1GKpIGmaz5NnShWs2GeuJ9QQT8OFDl1K8NGFZmDvnluYEHvf4UqAjKk+u6z+xLvbQ==
X-Received: by 2002:a05:6808:1209:b0:353:92d1:2a0 with SMTP id a9-20020a056808120900b0035392d102a0mr27119371oil.51.1667837177536;
        Mon, 07 Nov 2022 08:06:17 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:b536:91e:6a44:646c? (2603-8081-140c-1a00-b536-091e-6a44-646c.res6.spectrum.com. [2603:8081:140c:1a00:b536:91e:6a44:646c])
        by smtp.gmail.com with ESMTPSA id eq42-20020a056870a92a00b0013626c1a5f6sm3250867oab.10.2022.11.07.08.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:06:17 -0800 (PST)
Message-ID: <c1016a97-80c5-349d-0238-a5d7d408950d@gmail.com>
Date:   Mon, 7 Nov 2022 10:06:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Content-Language: en-US
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
 <TYCPR01MB8455A2A6E317C08E2F9DF908E5399@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <3953c08a-8809-820d-0bb7-dc61eabc630c@gmail.com>
 <TYCPR01MB84558043C5E77ADE74E46AE6E53B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <da40d7cb-ef2d-15bf-54b2-2e21db11da47@gmail.com>
 <TYCPR01MB8455610B57F2EAE2A2691614E53C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB8455610B57F2EAE2A2691614E53C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/7/22 02:21, Daisuke Matsuda (Fujitsu) wrote:
> On Sun, Nov 6, 2022 6:15 AM Bob Pearson
>> On 11/3/22 23:59, Daisuke Matsuda (Fujitsu) wrote:
>>> On Wed, Nov 2, 2022 8:21 PM Bob Pearson wrote:
>>>> On 11/2/22 05:17, Daisuke Matsuda (Fujitsu) wrote:
>>>>> On Sat, Oct 29, 2022 12:10 PM Bob Pearson wrote:
>>>>>> This patch series implements work queues as an alternative for
>>>>>> the main tasklets in the rdma_rxe driver. The patch series starts
>>>>>> with a patch that makes the internal API for task execution pluggable
>>>>>> and implements an inline and a tasklet based set of functions.
>>>>>> The remaining patches cleanup the qp reset and error code in the
>>>>>> three tasklets and modify the locking logic to prevent making
>>>>>> multiple calls to the tasklet scheduling routine. After
>>>>>> this preparation the work queue equivalent set of functions is
>>>>>> added and the tasklet version is dropped.
>>>>>
>>>>> Thank you for posting the 3rd series.
>>>>> It looks fine at a glance, but now I am concerned about problems
>>>>> that can be potentially caused by concurrency.
>>>>>
>>>>>>
>>>>>> The advantages of the work queue version of deferred task execution
>>>>>> is mainly that the work queue variant has much better scalability
>>>>>> and overall performance than the tasklet variant.  The perftest
>>>>>> microbenchmarks in local loopback mode (not a very realistic test
>>>>>> case) can reach approximately 100Gb/sec with work queues compared to
>>>>>> about 16Gb/sec for tasklets.
>>>>>
>>>>> As you wrote, the advantage of work queue version is that the number works
>>>>> that can run parallelly scales with the number of logical CPUs. However, the
>>>>> dispatched works (rxe_requester, rxe_responder, and rxe_completer) are
>>>>> designed for serial execution on tasklet, so we must not rely on them functioning
>>>>> properly on parallel execution.
>>>>
>>>> Work queues are serial for each separate work task just like tasklets. There isn't
>>>> a problem here. The tasklets for different tasks can run in parallel but tend to
>>>> do so less than work queue tasks. The reason is that tasklets are scheduled by
>>>> default on the same cpu as the thread that scheduled it while work queues are scheduled
>>>> by the kernel scheduler and get spread around.
>>>
>>> =====
>>> rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE, WQ_MAX_ACTIVE);
>>> =====
>>> You are using the WQ_CPU_INTENSIVE flag. This allows works to be scheduled by
>>> the system scheduler, but each work is still enqueued to worker pools of each CPU
>>> and thus bound to the CPU the issuer is running on. It seems the behaviour you
>>> expect can be achieved by the WQ_UNBOUND flag. Unbound work items will run
>>> on any CPU at the cost of cache utilization.
>>>
>>> Two of the same tasklets never run concurrently on two different processors by nature,
>>> but that is not the case with work queues. If two softirqs running on different CPUs
>>> enqueue responder works at almost the same time, it is possible that they are dispatched
>>> and run on the different CPUs at the same time. I mean the problems may arise in such
>>> a situation.
>>>
>>> Please let me know if I missed anything. I referred to the following document.
>>> The easiest solution is to use @flags= WQ_UNBOUND and @max_active=1 to let works
>>> run serially.
>>> cf. https://www.kernel.org/doc/html/latest/core-api/workqueue.html
>>>
>>> Thanks,
>>> Daisuke
>>>
>> According to this:
>>
>>     Workqueue guarantees that a work item cannot be re-entrant if the following conditions hold
>>     after a work item gets queued:
>>
>>         The work function hasn’t been changed.
>>
>>         No one queues the work item to another workqueue.
>>
>>         The work item hasn’t been reinitiated.
>>
>>     In other words, if the above conditions hold, the work item is guaranteed to be executed by at
>>     most one worker system-wide at any given time.
>>
>>     Note that requeuing the work item (to the same queue) in the self function doesn’t break these
>>     conditions, so it’s safe to do. Otherwise, caution is required when breaking the conditions
>>     inside a work function.
>>
>> I should be OK. Each work item checks the state under lock before scheduling the item and
>> if it is free moves it to busy and then schedules it. Only one instance of a work item
>> at a time should be running.
> 
> Thank you for the explanation.
> Per-qp work items should meet the three conditions. That is what I have missing.
> Now I see. You are correct.
> 
>>
>> I only know what I see from running top. It seems that the work items do get spread out over
>> time on the cpus.
> 
> It seems process_one_work() schedules items for both UNBOUND and CPU_INTENSIVE
> workers in the same way. This is not stated explicitly in the document.
> 
>>
>> The CPU_INTENSIVE is certainly correct for our application which will run all the cpus at
>> 100% for extended periods of time. We are benchmarking storage with IOR.
> 
> It is OK with me. I have not come up with any situations where the CPU_INTENSIVE
> flag bothers other rxe users.
> 
> Thanks,
> Daisuke
> 
>>
>> Bob
>>
>>>>>
>>>>> There could be 3 problems, which stem from the fact that works are not necessarily
>>>>> executed in the same order the packets are received. Works are enqueued to worker
>>>>> pools on each CPU, and each CPU respectively schedules the works, so the ordering
>>>>> of works among CPUs is not guaranteed.
>>>>>
>>>>> [1]
>>>>> On UC/UD connections, responder does not check the psn of inbound packets,
>>>>> so the payloads can be copied to MRs without checking the order. If there are
>>>>> works that write to overlapping memory locations, they can potentially cause
>>>>> data corruption depending the order.
>>>>>
>>>>> [2]
>>>>> On RC connections, responder checks the psn, and drops the packet if it is not
>>>>> the expected one. Requester can retransmit the request in this case, so the order
>>>>> seems to be guaranteed for RC.
>>>>>
>>>>> However, responder updates the next expected psn (qp->resp.psn) BEFORE
>>>>> replying an ACK packet. If the work is preempted soon after storing the next psn,
>>>>> another work on another CPU can potentially reply another ACK packet earlier.
>>>>> This behaviour is against the spec.
>>>>> Cf. IB Specification Vol 1-Release-1.5 " 9.5 TRANSACTION ORDERING"
>>>>>
>>>>> [3]
>>>>> Again on RC connections, the next expected psn (qp->resp.psn) can be
>>>>> loaded and stored at the same time from different threads. It seems we
>>>>> have to use a synchronization method, perhaps like READ_ONCE() and
>>>>> WRITE_ONCE() macros, to prevent loading an old value. This one is just an
>>>>> example; there can be other variables that need similar consideration.
>>>>>
>>>>>
>>>>> All the problems above can be solved by making the work queue single-
>>>>> threaded. We can do it by using flags=WQ_UNBOUND and max_active=1
>>>>> for alloc_workqueue(), but this should be the last resort since this spoils
>>>>> the performance benefit of work queue.
>>>>>
>>>>> I am not sure what we can do with [1] right now.
>>>>> For [2] and [3], we could just move the update of psn later than the ack reply,
>>>>> and use *_ONCE() macros for shared variables.
>>>>>
>>>>> Thanks,
>>>>> Daisuke

Thank you for taking the time to review this.

Bob
>>>>>
>>>>>>
>>>>>> This version of the patch series drops the tasklet version as an option
>>>>>> but keeps the option of switching between the workqueue and inline
>>>>>> versions.
>>>>>>
>>>>>> This patch series is derived from an earlier patch set developed by
>>>>>> Ian Ziemba at HPE which is used in some Lustre storage clients attached
>>>>>> to Lustre servers with hard RoCE v2 NICs.
>>>>>>
>>>>>> It is based on the current version of wip/jgg-for-next.
>>>>>>
>>>>>> v3:
>>>>>> Link: https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/
>>>>>> The v3 version drops the first few patches which have already been accepted
>>>>>> in for-next. It also drops the last patch of the v2 version which
>>>>>> introduced module parameters to select between the task interfaces. It also
>>>>>> drops the tasklet version entirely. It fixes a minor error caught by
>>>>>> the kernel test robot <lkp@intel.com> with a missing static declaration.
>>>>>>
>>>>>> v2:
>>>>>> The v2 version of the patch set has some minor changes that address
>>>>>> comments from Leon Romanovsky regarding locking of the valid parameter
>>>>>> and the setup parameters for alloc_workqueue. It also has one
>>>>>> additional cleanup patch.
>>>>>>
>>>>>> Bob Pearson (13):
>>>>>>   RDMA/rxe: Make task interface pluggable
>>>>>>   RDMA/rxe: Split rxe_drain_resp_pkts()
>>>>>>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>>>>>>   RDMA/rxe: Handle qp error in rxe_resp.c
>>>>>>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>>>>>>   RDMA/rxe: Remove __rxe_do_task()
>>>>>>   RDMA/rxe: Make tasks schedule each other
>>>>>>   RDMA/rxe: Implement disable/enable_task()
>>>>>>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>>>>>>   RDMA/rxe: Replace task->destroyed by task state INVALID.
>>>>>>   RDMA/rxe: Add workqueue support for tasks
>>>>>>   RDMA/rxe: Make WORKQUEUE default for RC tasks
>>>>>>   RDMA/rxe: Remove tasklets from rxe_task.c
>>>>>>
>>>>>>  drivers/infiniband/sw/rxe/rxe.c      |   9 +-
>>>>>>  drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
>>>>>>  drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
>>>>>>  drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
>>>>>>  drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
>>>>>>  drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
>>>>>>  drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
>>>>>>  7 files changed, 329 insertions(+), 172 deletions(-)
>>>>>>
>>>>>>
>>>>>> base-commit: 692373d186205dfb1b56f35f22702412d94d9420
>>>>>> --
>>>>>> 2.34.1
>>>>>
>>>
> 

