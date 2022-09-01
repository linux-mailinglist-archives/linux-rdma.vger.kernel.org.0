Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BB5A8EC2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiIAGw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiIAGwZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 02:52:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00E16216C;
        Wed, 31 Aug 2022 23:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30CFCB82484;
        Thu,  1 Sep 2022 06:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F06C433C1;
        Thu,  1 Sep 2022 06:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662015139;
        bh=02ejqo1B4LiFCxWh1MspI8vexk6nk4o45mua2xshV7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB6bAIBHvK67ebg7wJ4tk7+mqimP73hyWGnheVDKTiUUYyQJHrNXn30JBtavcSprn
         mHoV59R3bHDbP+bPHnSw3Nb/38DUI7ASsKM59wn1FLqdUL1aGg1BUCF3Nk02WrrBj1
         XC5lCw/7QBZGun3FAjna3l9WB1l/t4TEgcV1SE6iXQhl4zgtzaE3Kp4dADvnc0Kkg5
         3pRSax6Q5HReECAQuTbr0DaCkf5cPG4wO/sQCJIuTjQ5AqNlWGwHc+pRtz6c44B94X
         zlFPbmh3dX7zEVTFc7mhdYEYSWx8wn6UukWzIHwxqdxN6BXt4UU2rUMjWYZrSkPI21
         Fqx6eNvKCSfBw==
Date:   Thu, 1 Sep 2022 09:52:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2] RDMA/srp: Set scmnd->result only when scmnd is not
 NULL
Message-ID: <YxBWn+rzCnq2fhq7@unreal>
References: <20220831081626.18712-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831081626.18712-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 31, 2022 at 08:16:29AM +0000, yangx.jy@fujitsu.com wrote:
> This change fixes the following kernel NULL pointer dereference
> which is reproduced by blktests srp/007 occasionally.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000170
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0
> Oops: 0002 [#1] PREEMPT SMP NOPTI
> CPU: 0 PID: 9 Comm: kworker/0:1H Kdump: loaded Not tainted 6.0.0-rc1+ #37
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-29-g6a62e0cb0dfe-prebuilt.qemu.org 04/01/2014
> Workqueue:  0x0 (kblockd)
> RIP: 0010:srp_recv_done+0x176/0x500 [ib_srp]
> Code: 00 4d 85 ff 0f 84 52 02 00 00 48 c7 82 80 02 00 00 00 00 00 00 4c 89 df 4c 89 14 24 e8 53 d3 4a f6 4c 8b 14 24 41 0f b6 42 13 <41> 89 87 70 01 00 00 41 0f b6 52 12 f6 c2 02 74 44 41 8b 42 1c b9
> RSP: 0018:ffffaef7c0003e28 EFLAGS: 00000282
> RAX: 0000000000000000 RBX: ffff9bc9486dea60 RCX: 0000000000000000
> RDX: 0000000000000102 RSI: ffffffffb76bbd0e RDI: 00000000ffffffff
> RBP: ffff9bc980099a00 R08: 0000000000000001 R09: 0000000000000001
> R10: ffff9bca53ef0000 R11: ffff9bc980099a10 R12: ffff9bc956e14000
> R13: ffff9bc9836b9cb0 R14: ffff9bc9557b4480 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff9bc97ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000170 CR3: 0000000007e04000 CR4: 00000000000006f0
> Call Trace:
>  <IRQ>
>  __ib_process_cq+0xb7/0x280 [ib_core]
>  ib_poll_handler+0x2b/0x130 [ib_core]
>  irq_poll_softirq+0x93/0x150
>  __do_softirq+0xee/0x4b8
>  irq_exit_rcu+0xf7/0x130
>  sysvec_apic_timer_interrupt+0x8e/0xc0
>  </IRQ>
> 
> Fixes: ad215aaea4f9 ("RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks, applied.
