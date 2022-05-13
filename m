Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69873526324
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiEMNuF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381139AbiEMNjT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 09:39:19 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4AD186FD
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 06:39:10 -0700 (PDT)
Message-ID: <36f6e476-9762-6d39-e167-abb8dcc9f2bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652449147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKbJo7u0mq53IP0kxUg0o4JJVIeZtixajxdkRIOhpY4=;
        b=ccihyCcKe+8ITYb3bJO/L/ylZLI5resc941r8Oh5h/NXzcU3BNs7/Qny/trLoQpxkhh6fm
        bv7A9hpjXokopl6Nyrwn6JvnwAqBNjjfZIG1n+2/MEXyMOA4fxed/lbsffJmdE1JPOcDG9
        kjCRRxlk8p/HMUobiIfqUuLqXz2j2T0=
Date:   Fri, 13 May 2022 21:38:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <e587f531-0650-1548-1fe0-04d0152a5082@linux.dev>
In-Reply-To: <e587f531-0650-1548-1fe0-04d0152a5082@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



在 2022/5/13 10:40, Yanjun Zhu 写道:
> 在 2022/5/13 3:49, Bob Pearson 写道:
>> Currently the completer tasklet when it sets the retransmit timer or the
>> nak timer sets the same flag (qp->req.need_retry) so that if either
>> timer fires it will attempt to perform a retry flow on the send queue.
>> This has the effect of responding to an RNR NAK at the first retransmit
>> timer event which does not allow for the requested rnr timeout.
>>
>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>> prevents a retry flow until the rnr nak timer fires.
>>
>> This patch fixes rnr retry errors which can be observed by running the
>> pyverbs test suite 50-100X. With this patch applied they do not occur.
> 
> Do you mean that running run_tests.py for 50-100times can reproduce this 
> bug? I want to reproduce this problem.

Running run_tests.py for 50-100times, I can not reproduce this problem

Zhu Yanjun

> 
> Thanks a lot.
> Zhu Yanjun
> 
>>
>> Link: 
>> https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/ 
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>   drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>   4 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c 
>> b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 138b3e7d3a5f..bc668cb211b1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>                   if (qp->comp.rnr_retry != 7)
>>                       qp->comp.rnr_retry--;
>> -                qp->req.need_retry = 1;
>> -                pr_debug("qp#%d set rnr nak timer\n",
>> -                     qp_num(qp));
>> +                qp->req.need_rnr_timeout = 1;
>>                   mod_timer(&qp->rnr_nak_timer,
>>                         jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>                           & ~AETH_TYPE_MASK));
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c 
>> b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 62acf890af6c..1c962468714e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>       atomic_set(&qp->ssn, 0);
>>       qp->req.opcode = -1;
>>       qp->req.need_retry = 0;
>> +    qp->req.need_rnr_timeout = 0;
>>       qp->req.noack_pkts = 0;
>>       qp->resp.msn = 0;
>>       qp->resp.opcode = -1;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c 
>> b/drivers/infiniband/sw/rxe/rxe_req.c
>> index ae5fbc79dd5c..770ae4279f73 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>   {
>>       struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>> -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>> +    qp->req.need_retry = 1;
>> +    qp->req.need_rnr_timeout = 0;
>>       rxe_run_task(&qp->req.task, 1);
>>   }
>> @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>           qp->req.need_rd_atomic = 0;
>>           qp->req.wait_psn = 0;
>>           qp->req.need_retry = 0;
>> +        qp->req.need_rnr_timeout = 0;
>>           goto exit;
>>       }
>> -    if (unlikely(qp->req.need_retry)) {
>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>           req_retry(qp);
>>           qp->req.need_retry = 0;
>>       }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h 
>> b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> index e7eff1ca75e9..ab3186478c3f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>       int            need_rd_atomic;
>>       int            wait_psn;
>>       int            need_retry;
>> +    int            need_rnr_timeout;
>>       int            noack_pkts;
>>       struct rxe_task        task;
>>   };
>>
>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> 
