Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017EF56890D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 15:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGFNKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiGFNKQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 09:10:16 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026412125D
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 06:10:11 -0700 (PDT)
Message-ID: <1a57273c-0427-959d-8ed4-9be1e1c7b9bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657113009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thi4+vD234aA229R1iIHws5EiRrVz0/BzcBz9PZFYTk=;
        b=FUDmqxw2uWt+wmvnQfifmggH80CsSZqBAHe6Xc59CyubQ2CR/tWVoYORyqbJupv3CbbMFi
        0aYeZV48NbXf9VcRFoP1X0HIi396MFux3xer/et3QyL39omcvInGt0xUB/Hs1rEjodwpJ3
        EWpAuMZPo9ZxzcEBOXh5aj+jY5rn0o0=
Date:   Wed, 6 Jul 2022 21:10:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in
 rxe_qp_do_cleanup
To:     Haris Iqbal <haris.iqbal@ionos.com>, yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220705225414.315478-1-yanjun.zhu@linux.dev>
 <CAJpMwyg8YF30W_43oKD=cQ8b9pWaSh-aPON4u50b2VG==WXBwQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <CAJpMwyg8YF30W_43oKD=cQ8b9pWaSh-aPON4u50b2VG==WXBwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/7/5 18:35, Haris Iqbal 写道:
> On Tue, Jul 5, 2022 at 8:28 AM <yanjun.zhu@linux.dev> wrote:
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The function rxe_create_qp calls rxe_qp_from_init. If some error
>> occurs, the error handler of function rxe_qp_from_init will set
>> both scq and rcq to NULL.
>>
>> Then rxe_create_qp calls rxe_put to handle qp. In the end,
>> rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
>> accesses scq and rcq before checking them. This will cause
>> null-ptr-deref error.
>>
>> The call graph is as below:
>>
>> rxe_create_qp {
>>    ...
>>    rxe_qp_from_init {
>>      ...
>>    err1:
>>      ...
>>      qp->rcq = NULL;  <---rcq is set to NULL
>>      qp->scq = NULL;  <---scq is set to NULL
>>      ...
>>    }
>>
>> qp_init:
>>    rxe_put{
>>      ...
>>      rxe_qp_do_cleanup {
>>        ...
>>        atomic_dec(&qp->scq->num_wq); <--- scq is accessed
>>        ...
>>        atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
>>      }
>> }
>>
>> Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V1->V2: Describe the error flows.
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 22e9b85344c3..b79e1b43454e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -804,13 +804,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>>          if (qp->rq.queue)
>>                  rxe_queue_cleanup(qp->rq.queue);
>>
>> -       atomic_dec(&qp->scq->num_wq);
>> -       if (qp->scq)
>> +       if (qp->scq) {
>> +               atomic_dec(&qp->scq->num_wq);
>>                  rxe_put(qp->scq);
>> +       }
>>
>> -       atomic_dec(&qp->rcq->num_wq);
>> -       if (qp->rcq)
>> +       if (qp->rcq) {
>> +               atomic_dec(&qp->rcq->num_wq);
>>                  rxe_put(qp->rcq);
>> +       }
>>
>>          if (qp->pd)
>>                  rxe_put(qp->pd);
>> --
>> 2.34.1
> 
> Looks good.
> 
> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> 
> Should the check for "rxe_cleanup_task(&qp->comp.task);" also happen
> in this commit? or would it be covered in a different one?

It is in a different commit. I will send it out very soon.

Zhu Yanjun

> 
>>

