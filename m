Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E661DE87
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Nov 2022 22:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiKEVP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Nov 2022 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKEVPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Nov 2022 17:15:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5D19280
        for <linux-rdma@vger.kernel.org>; Sat,  5 Nov 2022 14:15:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g10so8578575oif.10
        for <linux-rdma@vger.kernel.org>; Sat, 05 Nov 2022 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoWiE/JqEKNvluTlJXpyWEFvFeWckmLSevUgZtCLe6M=;
        b=WW+pKwV9P+b62MnNKMRIYQTjAms/PX2JKmRBMXtM3/3deN0KbTpiFqxPdIbM5mZdg+
         Ip3zjpGEIACDyTMHIoiZTgfMjWR+tdvWRH+VO7KdlVEznjVbtCx+pO3UWQN+z7fC2O+n
         wqc/F1KUkYVpXwXsmcJngi1Nl1PQbfqmvkVL+apDUuf9BRr8+OCqYIGG37XOrAVNkfnz
         A+BWGnZxbHYYEytBNkCuqsentzebf7PMxEGD7nvUTSTD0idirIQMNJZTjmh4Hs6Wt4To
         X+7RQ8nZz37RGzUPNWidO3uroP2RSAodVrmsXOYdq3NuOKUMh5eE+Muqow1lglSBnTIW
         QA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EoWiE/JqEKNvluTlJXpyWEFvFeWckmLSevUgZtCLe6M=;
        b=fAU5SWgzcnQ91MmIDo2pI0PJWVNX1nbty5EgHBLss2jcXXANJA7WiNhhHFPAdKxr5+
         SQE54m7ZYRNmUf19wX4nqHkwJtnUKrWZFtZnhDgwRARPI86jQualErpYpvcTtAkkYyWT
         aeQ5dWGd1v9p3dHaXQ5nmfo/qwYyFyQ/oDdi5qnlkTqEZv1ZlabALH+ro6BAXdL2j++1
         nYWJ2R26NJlnyHmBHGHWx6ljGHcbogZo2DwWguq7dsvYgovIBVeqcgOl9Scrb2ak/Wy1
         1ZJ1Yvox/YUa6Bkqjfh8Acwff8B5crO6FwUhaY7dxGjsTb1unRgKscCLGsvd4KCfAsxh
         jb6A==
X-Gm-Message-State: ACrzQf0V02a4c9lDT4UQ5a7NitHXOzaDgIQdTRbezHWT6Ii1nMGrvZHZ
        qsvpCrLb0tnuDCpu7jFEW6vHmuXwRto=
X-Google-Smtp-Source: AMsMyM6Qwr78VZg5QJCjfOq1Sm3MULFRdeSkt0UhbIpKe3MKNoz+KZUckqk2aCCgTYQjLc4X7SgtAA==
X-Received: by 2002:a05:6808:d50:b0:355:4cd9:e6ca with SMTP id w16-20020a0568080d5000b003554cd9e6camr22220479oik.160.1667682901928;
        Sat, 05 Nov 2022 14:15:01 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1a06:c596:48a3:39d5? (2603-8081-140c-1a00-1a06-c596-48a3-39d5.res6.spectrum.com. [2603:8081:140c:1a00:1a06:c596:48a3:39d5])
        by smtp.gmail.com with ESMTPSA id v7-20020a4aaec7000000b004768f725b7csm899552oon.23.2022.11.05.14.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 14:15:01 -0700 (PDT)
Message-ID: <da40d7cb-ef2d-15bf-54b2-2e21db11da47@gmail.com>
Date:   Sat, 5 Nov 2022 16:15:00 -0500
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
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB84558043C5E77ADE74E46AE6E53B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
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

On 11/3/22 23:59, Daisuke Matsuda (Fujitsu) wrote:
> On Wed, Nov 2, 2022 8:21 PM Bob Pearson wrote:
>> On 11/2/22 05:17, Daisuke Matsuda (Fujitsu) wrote:
>>> On Sat, Oct 29, 2022 12:10 PM Bob Pearson wrote:
>>>> This patch series implements work queues as an alternative for
>>>> the main tasklets in the rdma_rxe driver. The patch series starts
>>>> with a patch that makes the internal API for task execution pluggable
>>>> and implements an inline and a tasklet based set of functions.
>>>> The remaining patches cleanup the qp reset and error code in the
>>>> three tasklets and modify the locking logic to prevent making
>>>> multiple calls to the tasklet scheduling routine. After
>>>> this preparation the work queue equivalent set of functions is
>>>> added and the tasklet version is dropped.
>>>
>>> Thank you for posting the 3rd series.
>>> It looks fine at a glance, but now I am concerned about problems
>>> that can be potentially caused by concurrency.
>>>
>>>>
>>>> The advantages of the work queue version of deferred task execution
>>>> is mainly that the work queue variant has much better scalability
>>>> and overall performance than the tasklet variant.  The perftest
>>>> microbenchmarks in local loopback mode (not a very realistic test
>>>> case) can reach approximately 100Gb/sec with work queues compared to
>>>> about 16Gb/sec for tasklets.
>>>
>>> As you wrote, the advantage of work queue version is that the number works
>>> that can run parallelly scales with the number of logical CPUs. However, the
>>> dispatched works (rxe_requester, rxe_responder, and rxe_completer) are
>>> designed for serial execution on tasklet, so we must not rely on them functioning
>>> properly on parallel execution.
>>
>> Work queues are serial for each separate work task just like tasklets. There isn't
>> a problem here. The tasklets for different tasks can run in parallel but tend to
>> do so less than work queue tasks. The reason is that tasklets are scheduled by
>> default on the same cpu as the thread that scheduled it while work queues are scheduled
>> by the kernel scheduler and get spread around.
> 
> =====
> rxe_wq = alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE, WQ_MAX_ACTIVE);
> =====
> You are using the WQ_CPU_INTENSIVE flag. This allows works to be scheduled by
> the system scheduler, but each work is still enqueued to worker pools of each CPU
> and thus bound to the CPU the issuer is running on. It seems the behaviour you
> expect can be achieved by the WQ_UNBOUND flag. Unbound work items will run
> on any CPU at the cost of cache utilization.
> 
> Two of the same tasklets never run concurrently on two different processors by nature,
> but that is not the case with work queues. If two softirqs running on different CPUs
> enqueue responder works at almost the same time, it is possible that they are dispatched
> and run on the different CPUs at the same time. I mean the problems may arise in such
> a situation.
> 
> Please let me know if I missed anything. I referred to the following document.
> The easiest solution is to use @flags= WQ_UNBOUND and @max_active=1 to let works
> run serially.
> cf. https://www.kernel.org/doc/html/latest/core-api/workqueue.html
> 
> Thanks,
> Daisuke
> 
According to this:

    Workqueue guarantees that a work item cannot be re-entrant if the following conditions hold
    after a work item gets queued:

        The work function hasn’t been changed.

        No one queues the work item to another workqueue.

        The work item hasn’t been reinitiated.

    In other words, if the above conditions hold, the work item is guaranteed to be executed by at
    most one worker system-wide at any given time.

    Note that requeuing the work item (to the same queue) in the self function doesn’t break these
    conditions, so it’s safe to do. Otherwise, caution is required when breaking the conditions
    inside a work function.

I should be OK. Each work item checks the state under lock before scheduling the item and
if it is free moves it to busy and then schedules it. Only one instance of a work item
at a time should be running.

I only know what I see from running top. It seems that the work items do get spread out over
time on the cpus.

The CPU_INTENSIVE is certainly correct for our application which will run all the cpus at
100% for extended periods of time. We are benchmarking storage with IOR.

Bob

>>>
>>> There could be 3 problems, which stem from the fact that works are not necessarily
>>> executed in the same order the packets are received. Works are enqueued to worker
>>> pools on each CPU, and each CPU respectively schedules the works, so the ordering
>>> of works among CPUs is not guaranteed.
>>>
>>> [1]
>>> On UC/UD connections, responder does not check the psn of inbound packets,
>>> so the payloads can be copied to MRs without checking the order. If there are
>>> works that write to overlapping memory locations, they can potentially cause
>>> data corruption depending the order.
>>>
>>> [2]
>>> On RC connections, responder checks the psn, and drops the packet if it is not
>>> the expected one. Requester can retransmit the request in this case, so the order
>>> seems to be guaranteed for RC.
>>>
>>> However, responder updates the next expected psn (qp->resp.psn) BEFORE
>>> replying an ACK packet. If the work is preempted soon after storing the next psn,
>>> another work on another CPU can potentially reply another ACK packet earlier.
>>> This behaviour is against the spec.
>>> Cf. IB Specification Vol 1-Release-1.5 " 9.5 TRANSACTION ORDERING"
>>>
>>> [3]
>>> Again on RC connections, the next expected psn (qp->resp.psn) can be
>>> loaded and stored at the same time from different threads. It seems we
>>> have to use a synchronization method, perhaps like READ_ONCE() and
>>> WRITE_ONCE() macros, to prevent loading an old value. This one is just an
>>> example; there can be other variables that need similar consideration.
>>>
>>>
>>> All the problems above can be solved by making the work queue single-
>>> threaded. We can do it by using flags=WQ_UNBOUND and max_active=1
>>> for alloc_workqueue(), but this should be the last resort since this spoils
>>> the performance benefit of work queue.
>>>
>>> I am not sure what we can do with [1] right now.
>>> For [2] and [3], we could just move the update of psn later than the ack reply,
>>> and use *_ONCE() macros for shared variables.
>>>
>>> Thanks,
>>> Daisuke
>>>
>>>>
>>>> This version of the patch series drops the tasklet version as an option
>>>> but keeps the option of switching between the workqueue and inline
>>>> versions.
>>>>
>>>> This patch series is derived from an earlier patch set developed by
>>>> Ian Ziemba at HPE which is used in some Lustre storage clients attached
>>>> to Lustre servers with hard RoCE v2 NICs.
>>>>
>>>> It is based on the current version of wip/jgg-for-next.
>>>>
>>>> v3:
>>>> Link: https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/
>>>> The v3 version drops the first few patches which have already been accepted
>>>> in for-next. It also drops the last patch of the v2 version which
>>>> introduced module parameters to select between the task interfaces. It also
>>>> drops the tasklet version entirely. It fixes a minor error caught by
>>>> the kernel test robot <lkp@intel.com> with a missing static declaration.
>>>>
>>>> v2:
>>>> The v2 version of the patch set has some minor changes that address
>>>> comments from Leon Romanovsky regarding locking of the valid parameter
>>>> and the setup parameters for alloc_workqueue. It also has one
>>>> additional cleanup patch.
>>>>
>>>> Bob Pearson (13):
>>>>   RDMA/rxe: Make task interface pluggable
>>>>   RDMA/rxe: Split rxe_drain_resp_pkts()
>>>>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>>>>   RDMA/rxe: Handle qp error in rxe_resp.c
>>>>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>>>>   RDMA/rxe: Remove __rxe_do_task()
>>>>   RDMA/rxe: Make tasks schedule each other
>>>>   RDMA/rxe: Implement disable/enable_task()
>>>>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>>>>   RDMA/rxe: Replace task->destroyed by task state INVALID.
>>>>   RDMA/rxe: Add workqueue support for tasks
>>>>   RDMA/rxe: Make WORKQUEUE default for RC tasks
>>>>   RDMA/rxe: Remove tasklets from rxe_task.c
>>>>
>>>>  drivers/infiniband/sw/rxe/rxe.c      |   9 +-
>>>>  drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
>>>>  drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
>>>>  drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
>>>>  drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
>>>>  drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
>>>>  drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
>>>>  7 files changed, 329 insertions(+), 172 deletions(-)
>>>>
>>>>
>>>> base-commit: 692373d186205dfb1b56f35f22702412d94d9420
>>>> --
>>>> 2.34.1
>>>
> 

