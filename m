Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1B5826D3
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiG0Mij (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 08:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiG0Mii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 08:38:38 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CA2D1DC
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 05:38:36 -0700 (PDT)
Message-ID: <bf38ea5b-84c3-55d5-2337-4ea6c3756f1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658925514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=STsEPXQUDu/XtgVnzBgvUDG3CcpBq9K89sH21CW6kFY=;
        b=XAah5G6kBkPp/QOkRVUf9xt5ucQadaY6uiC3pWCjICMdNJ1qn3gcXkxLm8OEno8WUgvwMg
        jSsYp8kVUECodA/CAZ1Ee/bmKaI1SCBYvMQATYkq0FKFBu0dA1g30/4n71CZAZrx10KcTF
        Rb5hIyOD1sc4rE8C0Xcsi0L0XMmMPac=
Date:   Wed, 27 Jul 2022 20:38:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix qp error handler
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
References: <20220726045631.183632-1-yanjun.zhu@linux.dev>
 <YuECen5fE+T8M1hj@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YuECen5fE+T8M1hj@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/27 17:16, Leon Romanovsky 写道:
> On Tue, Jul 26, 2022 at 12:56:31AM -0400, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> About 7 spin locks in qp creation needs to be initialized. Now these
>> spin locks are initialized in the function rxe_qp_init_misc. This
>> will avoid the error "initialize spin locks before use".
>>
>> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V2->V3: Keep the spin_lock_init in rxe_init_task for future use.
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
> Fixes line?

The Fixes line should be:


Fixes: 8700e3e7c485 ("Soft RoCE driver")


Thanks and Regards,

Zhu Yanjun

>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 22e9b85344c3..ae8c51ef2db6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -174,6 +174,14 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
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
>> @@ -233,7 +241,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   	qp->req.opcode		= -1;
>>   	qp->comp.opcode		= -1;
>>   
>> -	spin_lock_init(&qp->sq.sq_lock);
>>   	skb_queue_head_init(&qp->req_pkts);
>>   
>>   	rxe_init_task(rxe, &qp->req.task, qp,
>> @@ -284,9 +291,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>>   		}
>>   	}
>>   
>> -	spin_lock_init(&qp->rq.producer_lock);
>> -	spin_lock_init(&qp->rq.consumer_lock);
>> -
>>   	skb_queue_head_init(&qp->resp_pkts);
>>   
>>   	rxe_init_task(rxe, &qp->resp.task, qp,
>> -- 
>> 2.34.1
>>
