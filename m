Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B242B0F7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 02:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhJMAdE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 20:33:04 -0400
Received: from ale.deltatee.com ([204.191.154.188]:54912 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhJMAdE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Oct 2021 20:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=GGZ1kt1fwmQJieh8C8EqERas2+SAGyWKMWRG/LEXnjg=; b=RQE4QuPymGB2Ru2nFoFT93ojmR
        P4+pkO9uARC0sOOveTAyehvaG9lGN7dmCfxjVwt5gCih6RnpiGYn+5oGntEMga6qov4hryX668Cqo
        ak3kLKGaOFe7sMmkQVIE0wwL08hIXKbFYLTTJU2ZMLkrvkC6kr4IQeCVH07vMeeiOfv7YuAzDvk66
        j8y2ES6xn6nKKc4Tul/9k0/tdCaTHEO46YiJlOKhygfUBNPbqR9uGFqke/WMvp3c8mRKZFvCaPDgB
        7CCPhW784vU4B6xmn4uxQhdk+W5hbcsP3CEOW6aKbVhULn0qtaZVzQH+UlMowPMeXaGn3keW4uGf8
        M3r277Dg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1maSAV-0002oJ-Di; Tue, 12 Oct 2021 18:30:57 -0600
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
Date:   Tue, 12 Oct 2021 18:30:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jgg@nvidia.com, linux-rdma@vger.kernel.org, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: Kernel warning at drivers/infiniband/core/rw.c:349
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021-10-12 6:07 p.m., Bart Van Assche wrote:
> Hi,
> 
> If I run the SRP tests against the for-next branch of the RDMA git tree
> then the following warning appears (commit 2a152512a155 ("RDMA/efa: CQ 
> notifications")):
> 
> ------------[ cut here ]------------
> WARNING: CPU: 69 PID: 838 at drivers/infiniband/core/rw.c:349 
> rdma_rw_ctx_init+0x63b/0x690 [ib_core]
> CPU: 69 PID: 838 Comm: kworker/69:1H Tainted: G    E   5.15.0-rc4-dbg+ #2
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> RIP: 0010:rdma_rw_ctx_init+0x63b/0x690 [ib_core]
> Code: 8b 45 10 49 8d 7e 48 49 89 46 40 e8 cf 32 ca e0 8b 45 18 49 8d 7e 
> 04 41 89 46 48 e8 df 30 ca e0 41 c6 46 04 00 e9 61 fe ff ff <0f> 0b 41 
> bc fb ff ff ff e9 3e fe ff ff 48 8b 9d 70 ff ff ff 48 8d
> RSP: 0018:ffff88810b867968 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000024 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: ffff888169ee9a40 RDI: ffff888169ee9a58
> RBP: ffff88810b867a20 R08: ffffffffa081b01b R09: 0000000000000000
> R10: ffffed1085d2e3f1 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff888169ee9a58 R15: ffff888169ee9a40
> FS:  0000000000000000(0000) GS:ffff88842e940000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4720169e88 CR3: 00000001895d9006 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   srpt_alloc_rw_ctxs+0x2f2/0x560 [ib_srpt]
>   srpt_get_desc_tbl.constprop.0+0x289/0x2e0 [ib_srpt]
>   srpt_handle_cmd+0x17f/0x2b0 [ib_srpt]
>   srpt_handle_new_iu+0x27e/0x520 [ib_srpt]
>   srpt_recv_done+0x9b/0xd0 [ib_srpt]
>   __ib_process_cq+0x121/0x3d0 [ib_core]
>   ib_cq_poll_work+0x37/0xb0 [ib_core]
>   process_one_work+0x585/0xae0
>   worker_thread+0x2e7/0x700
>   kthread+0x1f6/0x220
>   ret_from_fork+0x1f/0x30
> irq event stamp: 1255
> hardirqs last  enabled at (1263): [<ffffffff811ab2c8>] 
> __up_console_sem+0x58/0x60
> hardirqs last disabled at (1270): [<ffffffff811ab2ad>] 
> __up_console_sem+0x3d/0x60
> softirqs last  enabled at (1290): [<ffffffff82200473>] 
> __do_softirq+0x473/0x6ed
> softirqs last disabled at (1279): [<ffffffff810e2152>] 
> __irq_exit_rcu+0xf2/0x140
> ---[ end trace 81a8636fba7e1a77 ]---
> 
> Does this perhaps indicate a regression in the RDMA rw code?

Hmm, yes looks like a regression with my recent patch.

Best I can see from the code is that someone is passing an sg_cnt of
zero. Previously that would have returned -ENOMEM, but now it might be
ignored, in which case it would hit that WARNING and return -EIO.

We can try a patch such as below to confirm.

Logan

--

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5a3bd41b331c..4eb9781ccfaf 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -331,6 +331,10 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx,
struct ib_qp *qp, u3>
                return ret;
        sg_cnt = sgt.nents;

+       ret = -EIO;
+       if (!sg_cnt)
+               goto out_unmap_sg;
+
        /*
         * Skip to the S/G entry that sg_offset falls into:
         */

