Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E9576D5C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Jul 2022 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiGPK7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Jul 2022 06:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPK7H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Jul 2022 06:59:07 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABA1D0E9
        for <linux-rdma@vger.kernel.org>; Sat, 16 Jul 2022 03:59:05 -0700 (PDT)
Message-ID: <9c85d14e-80db-97f1-f861-85a7d447406a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657969143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM9mncq1Ds5xR9P9o8Vc1jjzuBviWVhW1gHJVewM10Y=;
        b=fPUevt5b6/YOF2mvcxpjEKn4SalGT+i+waMXHs2/97+Dugx2po/FkKlwG2gX7yr8wFAFt6
        eqMG91Jwoa2GubypB1/AOGO3H1TjRulwbT3kbkFjcBz0tFxuBCcGa3/UswGVAPXvIG/vRO
        bgTafGRSGEsIvKn1jM9396VlCbJMb0o=
Date:   Sat, 16 Jul 2022 18:58:55 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix qp error handler
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
References: <20220710043709.707649-1-yanjun.zhu@linux.dev>
 <2faee762-d9d4-f2d0-30ae-cade450d6f71@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <2faee762-d9d4-f2d0-30ae-cade450d6f71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/15 0:54, Bob Pearson 写道:
> On 7/9/22 23:37, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> About 7 spin locks in qp creation needs to be initialized. Now these
>> spin locks are initialized in the function rxe_qp_init_misc. This
>> will avoid the error "initialize spin locks before use".
>>
>> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c   | 12 ++++++++----
>>   drivers/infiniband/sw/rxe/rxe_task.c |  1 -
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 8355a5b1cb60..259d8bb15116 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -172,6 +172,14 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   
>>   	spin_lock_init(&qp->state_lock);
>>   
>> +	spin_lock_init(&qp->req.task.state_lock);
>> +	spin_lock_init(&qp->resp.task.state_lock);
>> +	spin_lock_init(&qp->comp.task.state_lock);
>> +
>> +	spin_lock_init(&qp->sq.sq_lock);
>> +	spin_lock_init(&qp->rq.producer_lock);
>> +	spin_lock_init(&qp->rq.consumer_lock);
>> +
>>   	atomic_set(&qp->ssn, 0);
>>   	atomic_set(&qp->skb_out, 0);
>>   }
>> @@ -231,7 +239,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   	qp->req.opcode		= -1;
>>   	qp->comp.opcode		= -1;
>>   
>> -	spin_lock_init(&qp->sq.sq_lock);
>>   	skb_queue_head_init(&qp->req_pkts);
>>   
>>   	rxe_init_task(rxe, &qp->req.task, qp,
>> @@ -282,9 +289,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   		}
>>   	}
>>   
>> -	spin_lock_init(&qp->rq.producer_lock);
>> -	spin_lock_init(&qp->rq.consumer_lock);
>> -
>>   	skb_queue_head_init(&qp->resp_pkts);
>>   
>>   	rxe_init_task(rxe, &qp->resp.task, qp,
>> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
>> index 0c4db5bb17d7..77c691570673 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_task.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
>> @@ -98,7 +98,6 @@ int rxe_init_task(void *obj, struct rxe_task *task,
>>   	tasklet_setup(&task->tasklet, rxe_do_task);
>>   
>>   	task->state = TASK_STATE_START;
>> -	spin_lock_init(&task->state_lock);
>>   
>>   	return 0;
>>   }
> Zhu,
>
> The task.state_lock spinlocks are an implementation detail of the tasklet code. Seems strange to
> move the spin_lock_init() calls up into the qp code for these. This breaks encapsulation. We (HPE)
> have a patch coming that extends the tasklet code to support tasklets and/or work queues which allow
> steering the work to specific cpus. This gives a significant performance boost for IO intensive
> work flows.

OK. The reason that I move spin_lock_init() into rxe_qp_init_misc is to 
avoid the error "initialize spin locks before use".

Thanks for sharing your features in HPE. If you want to backport these 
new features into linux upstream, I can

keep spin_lock_init in rxe_init_task for future use.

I will send the latest commit very soon.

And look forward to your feature that extends the tasklet code to 
support tasklets and/or work queues which allow
steering the work to specific cpus in linux upstream.

I am curious about this feautre. And hope I can see it in linux upstream 
very soon ^_^

Zhu Yanjun

>
> The only other issue with this patch is that for xrc QPs, which we don't support yet, the QPs only
> have one side implemented and there won't be a reason to do unneeded work. Not a big issue though.
>
> Bob
