Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61F72A6E7
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjFIX7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIX7N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 19:59:13 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62248CE
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 16:59:12 -0700 (PDT)
Message-ID: <6b35e9a2-8ad5-cdc9-aef2-f1477ddda6eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686355149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fkUsQJQ3ZrohqzGZsoGGnhzPfGRE8GbgwcnEUR1PHo=;
        b=lwtx2rEArMVwn3U5BIFjqandm5wPIjqviIZpVEQQot1V1GCxBB+uvFhovubLBjdnsu2Wbd
        AhbkzPR6Dljwtlt1FS193SX+GdVPCg3pqyNNTfuUy3U89KbOLyL5H2Iqs0wpZxNnCXdamW
        tNwUyYDFQzwV9k+H82g+kyGVLZKZlzc=
Date:   Sat, 10 Jun 2023 07:59:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix the use-before-initialization error
 of resp_pkts
To:     Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
References: <20230602035408.741534-1-yanjun.zhu@intel.com>
 <ZINbszg48aMRrbFP@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZINbszg48aMRrbFP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/10 1:04, Jason Gunthorpe 写道:
> On Fri, Jun 02, 2023 at 11:54:08AM +0800, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In the following:
>> "
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>>   assign_lock_key kernel/locking/lockdep.c:982 [inline]
>>   register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
>>   __lock_acquire+0x10a/0x5df0 kernel/locking/lockdep.c:4951
>>   lock_acquire kernel/locking/lockdep.c:5691 [inline]
>>   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>   _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>>   skb_dequeue+0x20/0x180 net/core/skbuff.c:3639
>>   drain_resp_pkts drivers/infiniband/sw/rxe/rxe_comp.c:555 [inline]
>>   rxe_completer+0x250d/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:652
>>   rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
>>   execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
>>   __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
>>   rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583
>> ...
>> "
>> This is a use-before-initialization problem.
>>
>> In the following function
>> "
>> 291 /* called by the create qp verb */
>> 292 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
>> struct rxe_pd *pd,
>> 297 {
>>              ...
>> 317         rxe_qp_init_misc(rxe, qp, init);
>>              ...
>> 322
>> 323         err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
>> 324         if (err)
>> 325                 goto err2;   <--- error
>>
>>              ...
>>
>> 334 err2:
>> 335         rxe_queue_cleanup(qp->sq.queue); <--- Goto here
>> 336         qp->sq.queue = NULL;
>> "
>> In rxe_qp_init_resp, the error occurs before skb_queue_head_init.
>> So this call trace appeared.
>>
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/lkml/000000000000235bce05fac5f850@google.com/T/
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V1->V2: Add Fixes and Link.
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Applied to for-rc, thanks

Thanks.

Zhu Yanjun

> 
> Jason

