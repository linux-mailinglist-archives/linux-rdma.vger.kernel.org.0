Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1639D6D58DD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjDDGml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDGmk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 02:42:40 -0400
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [IPv6:2001:41d0:203:375::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A3E1BE3
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 23:42:38 -0700 (PDT)
Message-ID: <be9eab80-05f9-21f1-e45d-d859a6bb3324@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680590556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RzmsM9ms8EYeNXDDQhWrUbm9nu0xKNLnQDrazYhQIl8=;
        b=mIwt9mAYPF49de5sT0o6hYSD8WN4+EGfy6/3Slyx/YTyHDkWPnF7YpriP5y4AYZchGwF15
        BtlEa/dccgXMOtz1jrwapcYGtZUXx8sko8/99jf07YGeiWFYrMwP+kEV4k0UP/qdDll5Nd
        7sW9Z0kLMh+9QU7+IC/0VivWDtE3s3A=
Date:   Tue, 4 Apr 2023 14:42:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
References: <095b1562-0c5e-4390-adf3-59ec0ed3e97e@linux.dev>
 <20230401024417.3334889-1-yanjun.zhu@intel.com>
 <20230403181026.GB4514@unreal>
 <8ddeafc2-bc5d-e84a-0abd-9b48ab68e68e@linux.dev>
 <20230404055801.GF4514@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230404055801.GF4514@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/4/4 13:58, Leon Romanovsky 写道:
> On Tue, Apr 04, 2023 at 08:13:22AM +0800, Zhu Yanjun wrote:
>> 在 2023/4/4 2:10, Leon Romanovsky 写道:
>>> On Sat, Apr 01, 2023 at 10:44:17AM +0800, Zhu Yanjun wrote:
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> In the function rxe_create_qp(), rxe_qp_from_init() is called to
>>>> initialize qp, internally things like rxe_init_task are not setup until
>>>> rxe_qp_init_req().
>>>>
>>>> If an error occures before this point then the unwind will call
>>>> rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
>>>> which will oops when trying to access the uninitialized spinlock.
>>>>
>>>> If rxe_init_task is not executed, rxe_cleanup_task will not be called.
>>>>
>>>> Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
>>>> Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
>>>>
>>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>>> Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_qp.c | 15 ++++++++++++---
>>>>    1 file changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> index ab72db68b58f..7856c02c1b46 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> @@ -176,6 +176,10 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>>>>    	spin_lock_init(&qp->rq.producer_lock);
>>>>    	spin_lock_init(&qp->rq.consumer_lock);
>>>> +	memset(&qp->req.task, 0, sizeof(struct rxe_task));
>>>> +	memset(&qp->comp.task, 0, sizeof(struct rxe_task));
>>>> +	memset(&qp->resp.task, 0, sizeof(struct rxe_task));
>>> IMHO QP is already zeroed here.
>> Sure. Exactly. Here I just confirm that req.task, comp.task and resp.task
>> are zeroed explicitly.
> There is no need to do so. It is quite misleading to read the code and
> see these memset() functions as they give false impression that QP is
> not zeroed.

I will remove these memset function in the latest commit.

Thanks,

Zhu Yanjun

>
>> If you think it had better remove these memset functions, I will follow your
>> advice.
> Yes, please.
>
> Thanks
