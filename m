Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A224334B2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhJSLca (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 07:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhJSLc3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 07:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D49FD60EB1;
        Tue, 19 Oct 2021 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634643017;
        bh=CkIpTrvJrVYZ2k7deZPRG2DkNi3i+k3B57ddYgcdY4A=;
        h=From:To:Cc:Subject:Date:From;
        b=MXm3UPpmicuDgDsA0CGVu9acCTderVQc04V4Btz15V98UKK8ku1+Nkyw4v9yTvDZV
         pZADC1jxGq0ZOThDWPko88Ocj5E9/Qc/CVWftWj4yVyihvfT7S9tuMrDSUuaHCUJLk
         6WfmmPdth+BHaP2MMf+SyGbkGBfeJeGSh4/MsU8cAnSXHnaMHWd0CsSAxjvFQQ3Idn
         bpQeNnGYXMYfgwk650VhCjdx+1GqrLiolo2WVAAb43PycKMZ/7ixM1+oHXy20YrjVX
         ppXIKfnx57kYvylXdSwoQS9R8N8oVJ5QpwaclZBn2JhNCmTmnbLYSTdQW3wyOrARYw
         iwfUEBul9D1Yg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc v1] RDMA/mlx5: Don't set desc_size in user mr
Date:   Tue, 19 Oct 2021 14:30:10 +0300
Message-Id: <a4846a11c9de834663e521770da895007f9f0d30.1634642730.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

reg_create() is used for user MRs only and should not set desc_size at
all. Attempt to set it causes to the following trace:

BUG: unable to handle page fault for address: 0000000800000000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 5 PID: 890 Comm: ib_write_bw Not tainted 5.15.0-rc4+ #47
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5_ib_dereg_mr+0x14/0x3b0 [mlx5_ib]
Code: 48 63 cd 4c 89 f7 48 89 0c 24 e8 37 30 03 e1 48 8b 0c 24 eb a0 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 30 <48> 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 8b 87 c8
RSP: 0018:ffff88811afa3a60 EFLAGS: 00010286
RAX: 000000000000001c RBX: 0000000800000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000800000000
RBP: 0000000800000000 R08: 0000000000000000 R09: c0000000fffff7ff
R10: ffff88811afa38f8 R11: ffff88811afa38f0 R12: ffffffffa02c7ac0
R13: 0000000000000000 R14: ffff88811afa3cd8 R15: ffff88810772fa00
FS:  00007f47b9080740(0000) GS:ffff88852cd40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000800000000 CR3: 000000010761e003 CR4: 0000000000370ea0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mlx5_ib_free_odp_mr+0x95/0xc0 [mlx5_ib]
 mlx5_ib_dereg_mr+0x128/0x3b0 [mlx5_ib]
 ib_dereg_mr_user+0x45/0xb0 [ib_core]
 ? xas_load+0x8/0x80
 destroy_hw_idr_uobject+0x1a/0x50 [ib_uverbs]
 uverbs_destroy_uobject+0x2f/0x150 [ib_uverbs]
 uobj_destroy+0x3c/0x70 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x467/0xb00 [ib_uverbs]
 ? uverbs_finalize_object+0x60/0x60 [ib_uverbs]
 ? ttwu_queue_wakelist+0xa9/0xe0
 ? pty_write+0x85/0x90
 ? file_tty_write.isra.33+0x214/0x330
 ? process_echoes+0x60/0x60
 ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
 __x64_sys_ioctl+0x10d/0x8e0
 ? vfs_write+0x17f/0x260
 do_syscall_64+0x3c/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: a639e66703ee ("RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
v1:
 * Added Jason's hunk to initialize implicit_children.
v0: https://lore.kernel.org/all/f60a002566ae19014659afe94d7fcb7a10cfb353.1634033956.git.leonro@nvidia.com
---
 drivers/infiniband/hw/mlx5/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6fbc281a8881..018d70bf36fb 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1339,7 +1339,6 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 		goto err_2;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->desc_size = sizeof(struct mlx5_mtt);
 	mr->umem = umem;
 	set_mr_fields(dev, mr, umem->length, access_flags);
 	kvfree(in);
@@ -1538,6 +1537,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 		ib_umem_release(&odp->umem);
 		return ERR_CAST(mr);
 	}
+	xa_init(&mr->implicit_children);
 
 	odp->private = mr;
 	err = mlx5r_store_odp_mkey(dev, &mr->mmkey);
-- 
2.31.1

