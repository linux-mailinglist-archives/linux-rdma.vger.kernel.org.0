Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAB2539976
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiEaWYY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 May 2022 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiEaWYX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 May 2022 18:24:23 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD120BE1
        for <linux-rdma@vger.kernel.org>; Tue, 31 May 2022 15:24:21 -0700 (PDT)
Message-ID: <363a175a-ef3c-e66c-a193-1fd331a48045@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654035859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpUbXy+on4DtGFsEsUDzL2tVxRbeECPkrqUkqxqOPys=;
        b=Ff1lpVKEH/bmMdbXcuINHmaURKadgYyItCR5LAQg6UmNzjHGL2MpBP/LmRnhoZrHWseSQ0
        TExynKOZHDP9XsL4BqVu8Zf1OKLiOH/ACqx/S67KZI9UkwYnWlzMkNy5VKi3nX3nOv3FBT
        qHprgs90lPrzO9DoU8wC2BkMP5oA59w=
Date:   Wed, 1 Jun 2022 06:24:13 +0800
MIME-Version: 1.0
Subject: Re: rdma-for-next, rdma_rxe: inconsistent lock state
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <24ed4fac-0519-be62-6817-b4a73050e805@acm.org>
 <MW4PR84MB23075334E3E1CD9483BF4EDABCDC9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <MW4PR84MB23075334E3E1CD9483BF4EDABCDC9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
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

在 2022/6/1 4:55, Pearson, Robert B 写道:
> 
> 
> -----Original Message-----
> From: Bart Van Assche <bvanassche@acm.org>
> Sent: Tuesday, May 31, 2022 3:47 PM
> To: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: linux-rdma@vger.kernel.org
> Subject: rdma-for-next, rdma_rxe: inconsistent lock state
> 
> Hi Bob,
> 
> With the rdma-for-next branch (commit 9c477178a0a1 ("RDMA/rtrs-clt: Fix one kernel-doc comment")) I see the following:
> 
> ================================
> WARNING: inconsistent lock state
> 5.18.0-dbg #4 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> ksoftirqd/2/25 [HC0[0]:SC1[1]:HE0:SE0] takes:
> ffff888116f0d350 (&xa->xa_lock#12){+.?.}-{2:2}, at: rxe_pool_get_index+0x73/0x170 [rdma_rxe] {SOFTIRQ-ON-W} state was registered at:
>     __lock_acquire+0x45b/0xce0
>     lock_acquire+0x18a/0x450
>     _raw_spin_lock+0x34/0x50
>     __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
>     rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
>     __ib_alloc_pd+0xa3/0x270 [ib_core]
>     ib_mad_port_open+0x44a/0x790 [ib_core]
>     ib_mad_init_device+0x8e/0x110 [ib_core]
>     add_client_context+0x26a/0x330 [ib_core]
>     enable_device_and_get+0x169/0x2b0 [ib_core]
>     ib_register_device+0x26f/0x330 [ib_core]
>     rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
>     rxe_add+0x8c/0xc0 [rdma_rxe]
>     rxe_net_add+0x5b/0x90 [rdma_rxe]
>     rxe_newlink+0x71/0x80 [rdma_rxe]
>     nldev_newlink+0x21e/0x370 [ib_core]
>     rdma_nl_rcv_msg+0x200/0x410 [ib_core]
>     rdma_nl_rcv+0x140/0x220 [ib_core]
>     netlink_unicast+0x307/0x460
>     netlink_sendmsg+0x422/0x750
>     __sys_sendto+0x1c2/0x250
>     __x64_sys_sendto+0x7f/0x90
>     do_syscall_64+0x35/0x80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> irq event stamp: 71543
> hardirqs last  enabled at (71542): [<ffffffff810cdc28>] __local_bh_enable_ip+0x88/0xf0 hardirqs last disabled at (71543): [<ffffffff81e9d67d>] _raw_spin_lock_irqsave+0x5d/0x60 softirqs last  enabled at (71532): [<ffffffff82200467>] __do_softirq+0x467/0x6e1 softirqs last disabled at (71537): [<ffffffff810cda47>] run_ksoftirqd+0x37/0x60
> 
> other info that might help us debug this:
>    Possible unsafe locking scenario:
>          CPU0
>          ----
>     lock(&xa->xa_lock#12);
>     <Interrupt>
>       lock(&xa->xa_lock#12);
> 
>    *** DEADLOCK ***
> no locks held by ksoftirqd/2/25.
> 
> stack backtrace:
> CPU: 2 PID: 25 Comm: ksoftirqd/2 Not tainted 5.18.0-dbg #4 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014 Call Trace:
>    <TASK>
>    show_stack+0x52/0x58
>    dump_stack_lvl+0x5b/0x82
>    dump_stack+0x10/0x12
>    print_usage_bug.part.0+0x29c/0x2ab
>    mark_lock_irq.cold+0x54/0xbf
>    mark_lock.part.0+0x3f5/0xa70
>    mark_usage+0x74/0x1a0
>    __lock_acquire+0x45b/0xce0
>    lock_acquire+0x18a/0x450
>    _raw_spin_lock_irqsave+0x43/0x60
>    rxe_pool_get_index+0x73/0x170 [rdma_rxe]
>    rxe_get_av+0xcc/0x140 [rdma_rxe]
>    rxe_requester+0x34c/0xe60 [rdma_rxe]
>    rxe_do_task+0xcc/0x140 [rdma_rxe]
>    tasklet_action_common.constprop.0+0x168/0x1b0
>    tasklet_action+0x42/0x60
>    __do_softirq+0x1d8/0x6e1
>    run_ksoftirqd+0x37/0x60
>    smpboot_thread_fn+0x302/0x410
>    kthread+0x183/0x1c0
>    ret_from_fork+0x1f/0x30
>    </TASK>
> 
> Is this perhaps the same issue as what I reported on May 6 (https://lore.kernel.org/all/cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org/)?
> 
> Thanks,
> 
> Bart.
> 
> (from windows)
> 
> Yes. There is a lock level bug in rxe_pool.c that requires a patch to fix. I have one that is a temporary fix.
> Zhu had one that he posted  while ago but was never accepted. I don't want to step on his toes.
> This is related to the "AH bug" i.e. rdmacm holding locks while calling into the verbs APIs which is just plain evil.

Yes. This patch is not accepted. And it seems that all expect that this 
problem should be fixed in your rcu patch series.

Zhu Yanjun

> 
> I'll send you my patch.
> 
> Bob

