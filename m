Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25E647BB6F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 09:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhLUIFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 03:05:01 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37818 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235383AbhLUIFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 03:05:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V.JqAWK_1640073898;
Received: from 30.225.24.143(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V.JqAWK_1640073898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 16:04:59 +0800
Message-ID: <9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com>
Date:   Tue, 21 Dec 2021 16:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Alaa Hleihel <alaa@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org
From:   Tony Lu <tonylu@linux.alibaba.com>
Subject: RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called
 ib_dereg_mr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

During developing and testing of SMC (net/smc), We found a problem,
when SMC released linkgroup or link, it called ib_dereg_mr to release
resources, then it panicked in mlx5_ib_dereg_mr. After investigation,
we found this panic was introduce by this commit:

    f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")

After reverting this patch, SMC works fine. It looks like that
mlx5_ib_dereg_mr should check udata to determine to release umem,
because umem is union in struct, it is available when both kernel mr
and user mr. It is determined by the value of udata to distinguish
from ibv_reg_mr and ib_dereg_mr_user.

int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
{
        // udata is NULL when called from ib_dereg_mr
        if (mr->umem) { // check udata too
                bool is_odp = is_odp_mr(mr);

                if (!is_odp)
                        atomic_sub(ib_umem_num_pages(mr->umem),
                                   &dev->mdev->priv.reg_pages);
                ib_umem_release(mr->umem);
                if (is_odp)
                        mlx5_ib_free_odp_mr(mr);
        }

To be caution, this issue would cause local kernel panic, also,
it would cause remote kernel panic. SMC would setup passive close
progress when server's gone, the clients connected to this server would
go to release link, call ib_dreg_mr, and then panic.

[   30.083527] smc: adding ib device mlx5_0 with port count 1
[   30.084281] smc:    ib device mlx5_0 port 1 has pnetid
[   30.085006] smc: adding ib device mlx5_1 with port count 1
[   30.085765] smc:    ib device mlx5_1 port 1 has pnetid
[   33.883596] smc: SMC-R lg 00010000 link added: id 00000101, peerid 00000101, ibdev mlx5_1, ibport 1
[   33.884894] smc: SMC-R lg 00010000 state changed: SINGLE, pnetid
[   33.894387] smc: SMC-R lg 00010000 link added: id 00000102, peerid 00000102, ibdev mlx5_0, ibport 1
[   33.895612] smc: SMC-R lg 00010000 state changed: SYMMETRIC, pnetid
[  696.351054] general protection fault, probably for non-canonical address 0x300610d01000000: 0000 [#1] PREEMPTI
[  696.352522] CPU: 0 PID: 976 Comm: kworker/0:0 Not tainted 5.16.0-rc5+ #41
[  696.353490] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.q4
[  696.355112] Workqueue: events smc_lgr_terminate_work [smc]
[  696.355914] RIP: 0010:__ib_umem_release+0x21/0xa0 [ib_uverbs]
[  696.356751] Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 55 41 54 41 89 d4 55 53 48 89 f5 f6 46 28 01 76
[  696.359372] RSP: 0018:ffffc9000045bd30 EFLAGS: 00010246
[  696.360096] RAX: 0000000000000000 RBX: ffff8881108bd000 RCX: ffff888141a3a1a0
[  696.361110] RDX: 0000000000000001 RSI: ffff8881108bd000 RDI: 0300610d01000000
[  696.362113] RBP: ffff8881108bd000 R08: ffffc9000045bd60 R09: 0000000000000000
[  696.363136] R10: ffff888140052864 R11: 0000000000000008 R12: 0000000000000000
[  696.364145] R13: ffff888114310000 R14: 0000000000000000 R15: ffff8881426ac168
[  696.365153] FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
[  696.366279] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  696.367101] CR2: 00007ffeb4ede000 CR3: 0000000147b06006 CR4: 0000000000770ef0
[  696.368121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  696.369118] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  696.370112] PKRU: 55555554
[  696.370528] Call Trace:
[  696.370877]  <TASK>
[  696.371187]  ib_umem_release+0x2a/0x90 [ib_uverbs]
[  696.371889]  mlx5_ib_dereg_mr+0x19b/0x400 [mlx5_ib]
[  696.372612]  ib_dereg_mr_user+0x40/0xc0 [ib_core]
[  696.373293]  smcr_buf_unmap_link+0x3b/0xa0 [smc]
[  696.373962]  smcr_link_clear.part.33+0x6d/0x1e0 [smc]
[  696.374685]  smc_lgr_free+0x101/0x150 [smc]
[  696.375271]  process_one_work+0x1af/0x3c0
[  696.375865]  worker_thread+0x4c/0x390
[  696.376383]  ? preempt_count_add+0x56/0xa0
[  696.376961]  ? rescuer_thread+0x300/0x300
[  696.377543]  kthread+0x149/0x190
[  696.378003]  ? set_kthread_struct+0x40/0x40
[  696.378584]  ret_from_fork+0x1f/0x30
[  696.379763]  </TASK>
[  696.380723] Modules linked in: smc rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_isers
[  696.406206] ---[ end trace 235afb848459d626 ]---
[  696.407707] RIP: 0010:__ib_umem_release+0x21/0xa0 [ib_uverbs]
[  696.409254] Code: ff ff 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 55 41 54 41 89 d4 55 53 48 89 f5 f6 46 28 01 76
[  696.413326] RSP: 0018:ffffc9000045bd30 EFLAGS: 00010246
[  696.414811] RAX: 0000000000000000 RBX: ffff8881108bd000 RCX: ffff888141a3a1a0
[  696.416544] RDX: 0000000000000001 RSI: ffff8881108bd000 RDI: 0300610d01000000
[  696.418257] RBP: ffff8881108bd000 R08: ffffc9000045bd60 R09: 0000000000000000
[  696.420076] R10: ffff888140052864 R11: 0000000000000008 R12: 0000000000000000
[  696.421776] R13: ffff888114310000 R14: 0000000000000000 R15: ffff8881426ac168
[  696.423456] FS:  0000000000000000(0000) GS:ffff88881fc00000(0000) knlGS:0000000000000000
[  696.425284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  696.426733] CR2: 00007fc639600000 CR3: 0000000147b06006 CR4: 0000000000770ef0
[  696.428347] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  696.429953] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  696.431575] PKRU: 55555554
[  696.432641] Kernel panic - not syncing: Fatal exception
[  696.434024] Kernel Offset: disabled
[  696.435126] Rebooting in 1 seconds..

Thanks,
Tony Lu
