Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6A6161A1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 12:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKBLU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKBLU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 07:20:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F20120A0
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 04:20:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n186so1562983oih.7
        for <linux-rdma@vger.kernel.org>; Wed, 02 Nov 2022 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KI6fdlEw5UrXTTUuKGWrgvBBxOlFLb2RlFlLnzsaUi8=;
        b=bVYuES+qgV6/7eLolekEOVELJLBjXUWQeXgpMWDghPzwtpGadTuBrny1/MpXk4wIv+
         OOYPE5XXHQSTD50Duq1sfCv3LhQvl0IdXyAzsQUQPScAb8DKosV2Z1U8mV0qVKmlvrUT
         8xEPA0j2ms/5Y2ADMgZXK8mPXi3nZwWjZYQaZixugiOfSZ+w92OUSSnWCTLpr4zha1p8
         VIL9ZZ9T7liQmOwaSS3vHo0e1zSPVWijnS1h0CxREotG/w5dS7fmDxShSK0sNIJGOmfa
         0bWq2vbFM0lTXmCIIjx3qWp5SOkKiXKvjZaMlZ+wVJKmmhtuOttOyvYOqoDbaOxX1a9a
         pZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI6fdlEw5UrXTTUuKGWrgvBBxOlFLb2RlFlLnzsaUi8=;
        b=DS+qdFzGtJ34jhiR+5boAN4ejR2bN0PT7od0rH62G13M1A2Vp7PbSH5ldZvwGu6bcP
         spItZTgV6FnrX/d+f0dBRnrXkPToqYOUjccldcupI/YxQ/UUH9hil6G3ACtyXgOVI4pV
         XdsmS6YeUwq4C1VXuWouzNF0fB76Ho8LfIuLXy2nYRUg3KS/f9HXJl+kO/9LbuAZOJ+J
         0sbt6hKPgu7HRhOJ/55JqhMT/mX9DxQN7n/PgdKHmNYJhKKZMRHqOF8SKO9WZ2y6wsVc
         XkCsTDhtdJddq9InKQPcRqiDbYG2NS97YzWhzwqc1lhBXy+SegBNEYm5zVRQ68fHOFj5
         /NLQ==
X-Gm-Message-State: ACrzQf2OMNa8YIkSYhx5niJhuNeucu0ID8mDNYyZXYYFIOP3XgMscscr
        iB1yBmf1MsW0z8g0NxsxUFc=
X-Google-Smtp-Source: AMsMyM4y4aWZaJkNsw7lEBAYWe/Hhp5AGdbh6TUFNi9LCQZYGYrijHYWuqdEuOXF91cA7sd3KOyk0Q==
X-Received: by 2002:a05:6808:254:b0:359:f10b:5469 with SMTP id m20-20020a056808025400b00359f10b5469mr11033923oie.248.1667388056950;
        Wed, 02 Nov 2022 04:20:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e36a:cf0:97b7:4cd3? (2603-8081-140c-1a00-e36a-0cf0-97b7-4cd3.res6.spectrum.com. [2603:8081:140c:1a00:e36a:cf0:97b7:4cd3])
        by smtp.gmail.com with ESMTPSA id l16-20020a9d6a90000000b0066c3ca7b12csm2717545otq.61.2022.11.02.04.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 04:20:56 -0700 (PDT)
Message-ID: <3953c08a-8809-820d-0bb7-dc61eabc630c@gmail.com>
Date:   Wed, 2 Nov 2022 06:20:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
 <TYCPR01MB8455A2A6E317C08E2F9DF908E5399@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <TYCPR01MB8455A2A6E317C08E2F9DF908E5399@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/22 05:17, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, Oct 29, 2022 12:10 PM Bob Pearson wrote:
>> This patch series implements work queues as an alternative for
>> the main tasklets in the rdma_rxe driver. The patch series starts
>> with a patch that makes the internal API for task execution pluggable
>> and implements an inline and a tasklet based set of functions.
>> The remaining patches cleanup the qp reset and error code in the
>> three tasklets and modify the locking logic to prevent making
>> multiple calls to the tasklet scheduling routine. After
>> this preparation the work queue equivalent set of functions is
>> added and the tasklet version is dropped.
> 
> Thank you for posting the 3rd series.
> It looks fine at a glance, but now I am concerned about problems
> that can be potentially caused by concurrency.
> 
>>
>> The advantages of the work queue version of deferred task execution
>> is mainly that the work queue variant has much better scalability
>> and overall performance than the tasklet variant.  The perftest
>> microbenchmarks in local loopback mode (not a very realistic test
>> case) can reach approximately 100Gb/sec with work queues compared to
>> about 16Gb/sec for tasklets.
> 
> As you wrote, the advantage of work queue version is that the number works
> that can run parallelly scales with the number of logical CPUs. However, the
> dispatched works (rxe_requester, rxe_responder, and rxe_completer) are
> designed for serial execution on tasklet, so we must not rely on them functioning
> properly on parallel execution.

Work queues are serial for each separate work task just like tasklets. There isn't
a problem here. The tasklets for different tasks can run in parallel but tend to
do so less than work queue tasks. The reason is that tasklets are scheduled by
default on the same cpu as the thread that scheduled it while work queues are scheduled
by the kernel scheduler and get spread around.
> 
> There could be 3 problems, which stem from the fact that works are not necessarily
> executed in the same order the packets are received. Works are enqueued to worker
> pools on each CPU, and each CPU respectively schedules the works, so the ordering
> of works among CPUs is not guaranteed.
> 
> [1]
> On UC/UD connections, responder does not check the psn of inbound packets,
> so the payloads can be copied to MRs without checking the order. If there are
> works that write to overlapping memory locations, they can potentially cause
> data corruption depending the order.
> 
> [2]
> On RC connections, responder checks the psn, and drops the packet if it is not
> the expected one. Requester can retransmit the request in this case, so the order
> seems to be guaranteed for RC.
> 
> However, responder updates the next expected psn (qp->resp.psn) BEFORE
> replying an ACK packet. If the work is preempted soon after storing the next psn,
> another work on another CPU can potentially reply another ACK packet earlier.
> This behaviour is against the spec.
> Cf. IB Specification Vol 1-Release-1.5 " 9.5 TRANSACTION ORDERING"
> 
> [3]
> Again on RC connections, the next expected psn (qp->resp.psn) can be
> loaded and stored at the same time from different threads. It seems we
> have to use a synchronization method, perhaps like READ_ONCE() and
> WRITE_ONCE() macros, to prevent loading an old value. This one is just an
> example; there can be other variables that need similar consideration.
> 
> 
> All the problems above can be solved by making the work queue single-
> threaded. We can do it by using flags=WQ_UNBOUND and max_active=1
> for alloc_workqueue(), but this should be the last resort since this spoils
> the performance benefit of work queue.
> 
> I am not sure what we can do with [1] right now.
> For [2] and [3], we could just move the update of psn later than the ack reply,
> and use *_ONCE() macros for shared variables.
> 
> Thanks,
> Daisuke
> 
>>
>> This version of the patch series drops the tasklet version as an option
>> but keeps the option of switching between the workqueue and inline
>> versions.
>>
>> This patch series is derived from an earlier patch set developed by
>> Ian Ziemba at HPE which is used in some Lustre storage clients attached
>> to Lustre servers with hard RoCE v2 NICs.
>>
>> It is based on the current version of wip/jgg-for-next.
>>
>> v3:
>> Link: https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.com/
>> The v3 version drops the first few patches which have already been accepted
>> in for-next. It also drops the last patch of the v2 version which
>> introduced module parameters to select between the task interfaces. It also
>> drops the tasklet version entirely. It fixes a minor error caught by
>> the kernel test robot <lkp@intel.com> with a missing static declaration.
>>
>> v2:
>> The v2 version of the patch set has some minor changes that address
>> comments from Leon Romanovsky regarding locking of the valid parameter
>> and the setup parameters for alloc_workqueue. It also has one
>> additional cleanup patch.
>>
>> Bob Pearson (13):
>>   RDMA/rxe: Make task interface pluggable
>>   RDMA/rxe: Split rxe_drain_resp_pkts()
>>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>>   RDMA/rxe: Handle qp error in rxe_resp.c
>>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>>   RDMA/rxe: Remove __rxe_do_task()
>>   RDMA/rxe: Make tasks schedule each other
>>   RDMA/rxe: Implement disable/enable_task()
>>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>>   RDMA/rxe: Replace task->destroyed by task state INVALID.
>>   RDMA/rxe: Add workqueue support for tasks
>>   RDMA/rxe: Make WORKQUEUE default for RC tasks
>>   RDMA/rxe: Remove tasklets from rxe_task.c
>>
>>  drivers/infiniband/sw/rxe/rxe.c      |   9 +-
>>  drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
>>  drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
>>  drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
>>  drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
>>  drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
>>  drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
>>  7 files changed, 329 insertions(+), 172 deletions(-)
>>
>>
>> base-commit: 692373d186205dfb1b56f35f22702412d94d9420
>> --
>> 2.34.1
> 

