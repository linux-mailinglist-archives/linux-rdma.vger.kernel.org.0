Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473C526EA8
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiENC4o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiENCzx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 22:55:53 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6D2F0A65
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 19:30:51 -0700 (PDT)
Message-ID: <f3010b22-4c8c-9a9d-16ad-2341a76dbb68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652495449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGw0Km50Ry9Jhc0JRUpTnCdfqCKLOExwwcUdubZa8NY=;
        b=hBb6irFjhAzKrjSs+4W4zVld+CKLV73lkRLlnbJCcJRknwZ+a06I4oQY6e4omgdZeFcmeI
        cp1X+FpGeSjBvXtYaRaIRDnnU1ydh9+n1KDCGO8IBfvBAl7usJy1EEHNMCwOuiwn2lMCwe
        c7iJG1Hku6YvYfMgGS/cakaqwF25xL4=
Date:   Sat, 14 May 2022 10:30:41 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <e587f531-0650-1548-1fe0-04d0152a5082@linux.dev>
 <36f6e476-9762-6d39-e167-abb8dcc9f2bb@linux.dev>
 <25c4e1f7-54eb-456b-8020-b3b1e24a9ecb@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <25c4e1f7-54eb-456b-8020-b3b1e24a9ecb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/5/14 2:22, Bob Pearson 写道:
> On 5/13/22 08:38, Yanjun Zhu wrote:
>>
>> 在 2022/5/13 10:40, Yanjun Zhu 写道:
>>> 在 2022/5/13 3:49, Bob Pearson 写道:
>>>> Currently the completer tasklet when it sets the retransmit timer or the
>>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>>> timer fires it will attempt to perform a retry flow on the send queue.
>>>> This has the effect of responding to an RNR NAK at the first retransmit
>>>> timer event which does not allow for the requested rnr timeout.
>>>>
>>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>>> prevents a retry flow until the rnr nak timer fires.
>>>>
>>>> This patch fixes rnr retry errors which can be observed by running the
>>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>> Do you mean that running run_tests.py for 50-100times can reproduce this bug? I want to reproduce this problem.
>> Running run_tests.py for 50-100times, I can not reproduce this problem
> I went back and looked. The occasionally failing test case is:
>
> 	test_rdmacm_async_traffic_external_qp
>
> This test is normally skipped for rxe because of a hack in <path to rdma-core>/tests/base.py. I sent you
> a patch that enables these tests a few days ago.

What is the patch? Can you send me it again?

And what is the symptoms when this problem occurs?

I want to check if I can reproduce this problem.


Thanks and Regards,

Zhu Yanjun

>
> It randomly causes an rnr retry about 1/3 of the time. Most of these are repaired by the retry timer
> going off. A few ~1-2% are not.
>
> Bob
>> Zhu Yanjun
>>
>>> Thanks a lot.
>>> Zhu Yanjun
>>>
>>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>>    drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>>    drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>>    4 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>>                    if (qp->comp.rnr_retry != 7)
>>>>                        qp->comp.rnr_retry--;
>>>> -                qp->req.need_retry = 1;
>>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>>> -                     qp_num(qp));
>>>> +                qp->req.need_rnr_timeout = 1;
>>>>                    mod_timer(&qp->rnr_nak_timer,
>>>>                          jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>>                            & ~AETH_TYPE_MASK));
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> index 62acf890af6c..1c962468714e 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>>        atomic_set(&qp->ssn, 0);
>>>>        qp->req.opcode = -1;
>>>>        qp->req.need_retry = 0;
>>>> +    qp->req.need_rnr_timeout = 0;
>>>>        qp->req.noack_pkts = 0;
>>>>        qp->resp.msn = 0;
>>>>        qp->resp.opcode = -1;
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> index ae5fbc79dd5c..770ae4279f73 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>>    {
>>>>        struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>>> -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>>> +    qp->req.need_retry = 1;
>>>> +    qp->req.need_rnr_timeout = 0;
>>>>        rxe_run_task(&qp->req.task, 1);
>>>>    }
>>>> @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>>            qp->req.need_rd_atomic = 0;
>>>>            qp->req.wait_psn = 0;
>>>>            qp->req.need_retry = 0;
>>>> +        qp->req.need_rnr_timeout = 0;
>>>>            goto exit;
>>>>        }
>>>> -    if (unlikely(qp->req.need_retry)) {
>>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>>>            req_retry(qp);
>>>>            qp->req.need_retry = 0;
>>>>        }
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> index e7eff1ca75e9..ab3186478c3f 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>>        int            need_rd_atomic;
>>>>        int            wait_psn;
>>>>        int            need_retry;
>>>> +    int            need_rnr_timeout;
>>>>        int            noack_pkts;
>>>>        struct rxe_task        task;
>>>>    };
>>>>
>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
