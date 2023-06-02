Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB96F71F859
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 04:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjFBCWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 22:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFBCWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 22:22:14 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F113E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 19:22:12 -0700 (PDT)
Message-ID: <60985df6-b50f-56bf-0e7f-73061209c8b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685672530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cOPnEXlzzwq0QdULyoJxzcu8ApiykSaabz7AZp4eEs=;
        b=u+cNhX6EOqj5z2wrKZKcpnLldUqrQAZ0bWVYGrTV4FymP1pzBkcIR4XJNtNwjtwfFqyJSX
        rhWjI4d2dpTKqQH47LtP8glEdcJ+rDc72bhWgNU6O/zxqHJQ0LWWIS/tGaSJE3adNp9f5K
        XiaPa5WwdYEmegnuxprDYnvtWfesnC4=
Date:   Fri, 2 Jun 2023 10:22:02 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the use-before-initialization error of
 resp_pkts
To:     Jason Gunthorpe <jgg@nvidia.com>,
        00000000000063657005fbf44fb2@google.com
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
References: <20230523054739.594384-1-yanjun.zhu@intel.com>
 <ZHjAPwKB/si3qJSb@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZHjAPwKB/si3qJSb@nvidia.com>
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


在 2023/6/1 23:58, Jason Gunthorpe 写道:
> On Tue, May 23, 2023 at 01:47:39PM +0800, Zhu Yanjun wrote:
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
>> Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> This needs a fixes line and a link line to the syzkaller report email

Got it. I will fix it ASAP.

Zhu Yanjun

>
> Jason
