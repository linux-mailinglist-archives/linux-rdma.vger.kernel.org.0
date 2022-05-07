Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ECC51E35C
	for <lists+linux-rdma@lfdr.de>; Sat,  7 May 2022 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379910AbiEGB7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 21:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445358AbiEGB7X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 21:59:23 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3606113EB2
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 18:55:37 -0700 (PDT)
Message-ID: <81571bbb-c5d2-9b68-765d-f004eb7ba6fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651888535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzyrypE+UWmQ1Ut3hy7AJHdTYoPAH+cLIiDk0Q82lpk=;
        b=Kbg871YCItbanOgwSWszq4E6mHQGrS2Yb1W8/I4fqoGw1t5XnAkZnkb8rdNV9828TGzgNa
        MWLQKVbhdDfc945LDWkk2a2c3FSbgRGJvkAT8OXffRBegXTonlxsdjZwM1yadKEiHzzJ/l
        VuzhMll1Yae8KDXMT3vSTyrzdBGbeJ4=
Date:   Sat, 7 May 2022 09:55:27 +0800
MIME-Version: 1.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220507012952.GH49344@nvidia.com>
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


在 2022/5/7 9:29, Jason Gunthorpe 写道:
> On Sat, May 07, 2022 at 08:29:31AM +0800, Yanjun Zhu wrote:
>
>>> If I try to run the SRP test 002 with the soft-RoCE driver, the
>>> following appears:
>>>
>>> [  749.901966] ================================
>>> [  749.903638] WARNING: inconsistent lock state
>>> [  749.905376] 5.18.0-rc5-dbg+ #1 Not tainted
>>> [  749.907039] --------------------------------
>>> [  749.908699] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>>> [  749.910646] ksoftirqd/5/40 [HC0[0]:SC1[1]:HE0:SE0] takes:
>>> [  749.912499] ffff88818244d350 (&xa->xa_lock#14){+.?.}-{2:2}, at:
>>> rxe_pool_get_index+0x73/0x170 [rdma_rxe]
>>> [  749.914691] {SOFTIRQ-ON-W} state was registered at:
>>> [  749.916648]   __lock_acquire+0x45b/0xce0
>>> [  749.918599]   lock_acquire+0x18a/0x450
>>> [  749.920480]   _raw_spin_lock+0x34/0x50
>>> [  749.922580]   __rxe_add_to_pool+0xcc/0x140 [rdma_rxe]
>>> [  749.924583]   rxe_alloc_pd+0x2d/0x40 [rdma_rxe]
>>> [  749.926394]   __ib_alloc_pd+0xa3/0x270 [ib_core]
>>> [  749.928579]   ib_mad_port_open+0x44a/0x790 [ib_core]
>>> [  749.930640]   ib_mad_init_device+0x8e/0x110 [ib_core]
>>> [  749.932495]   add_client_context+0x26a/0x330 [ib_core]
>>> [  749.934302]   enable_device_and_get+0x169/0x2b0 [ib_core]
>>> [  749.936217]   ib_register_device+0x26f/0x330 [ib_core]
>>> [  749.938020]   rxe_register_device+0x1b4/0x1d0 [rdma_rxe]
>>> [  749.939794]   rxe_add+0x8c/0xc0 [rdma_rxe]
>>> [  749.941552]   rxe_net_add+0x5b/0x90 [rdma_rxe]
>>> [  749.943356]   rxe_newlink+0x71/0x80 [rdma_rxe]
>>> [  749.945182]   nldev_newlink+0x21e/0x370 [ib_core]
>>> [  749.946917]   rdma_nl_rcv_msg+0x200/0x410 [ib_core]
>>> [  749.948657]   rdma_nl_rcv+0x140/0x220 [ib_core]
>>> [  749.950373]   netlink_unicast+0x307/0x460
>>> [  749.952063]   netlink_sendmsg+0x422/0x750
>>> [  749.953672]   __sys_sendto+0x1c2/0x250
>>> [  749.955281]   __x64_sys_sendto+0x7f/0x90
>>> [  749.956849]   do_syscall_64+0x35/0x80
>>> [  749.958353]   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [  749.959942] irq event stamp: 1411849
>>> [  749.961517] hardirqs last  enabled at (1411848): [<ffffffff810cdb28>]
>>> __local_bh_enable_ip+0x88/0xf0
>>> [  749.963338] hardirqs last disabled at (1411849): [<ffffffff81ebf24d>]
>>> _raw_spin_lock_irqsave+0x5d/0x60
>>> [  749.965214] softirqs last  enabled at (1411838): [<ffffffff82200467>]
>>> __do_softirq+0x467/0x6e1
>>> [  749.967027] softirqs last disabled at (1411843): [<ffffffff810cd947>]
>>> run_ksoftirqd+0x37/0x60
>> To this, Please use this patch series
>> news://nntp.lore.kernel.org:119/20220422194416.983549-1-yanjun.zhu@linux.dev
> No, that is the wrong fix for this. This is mismatched lock modes with
> the lookup path in the BH, the fix is to consistently use BH locking
> with the xarray everwhere or to use RCU. I'm expecting to go with
> Bob's RCU patch.

Bob's RCU patch causes some atomic problems. Not sure these problems can 
be fixed properly.

Zhu Yanjun

>
> We still need a proper patch for the AH problem.
>
> Jason
