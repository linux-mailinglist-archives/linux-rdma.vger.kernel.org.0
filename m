Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD774379137
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbhEJOsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 10:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238072AbhEJOrK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 10:47:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87261613B6;
        Mon, 10 May 2021 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620657965;
        bh=963xyWxrxaFm3Qj1vBdphhOwWkD8Vkj0yfQ/keBcj3k=;
        h=From:To:Cc:Subject:Date:From;
        b=LxpGV1g23ipeYPdDHVbAMG8Xt5H06IVyCmMlLx0v9i4UnZJr7JbtjMngVQrlCr0q2
         sRto11FS5HhDpTCVzvuMfxiQbOI/2ENeT13bYlvQhtqozy44seWsV6Fai2N72zNBih
         c+L2LsTRIjY24AcJymndnRky6jSc8UWxAJ/FKTxqAR//aqgTfdBU4zd7oaPgDcDemM
         ig00i1KgW7wJqST5vBTk1Cpa2kePR66r6th4knW84iUsSyGFjrU1dN5lKJNTT7J5Py
         /v3vGFQLh/9ascAibNFCXCkM0vlJVRDd/Nfmqt4fW0nqPiLHia0jJFeEGqsnyJ9lZn
         ihCLViJPHIjLw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/core: Prevent divide-by-zero error triggered by the user
Date:   Mon, 10 May 2021 17:46:00 +0300
Message-Id: <b971cc70a8b240a8b5eda33c99fa0558a0071be2.1620657876.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The user_entry_size is supplied by the user and later used as a
denominator to calculate number of entries. The zero supplied by
the user will trigger the following divide-by-zero error:

 divide error: 0000 [#1] SMP KASAN PTI
 CPU: 4 PID: 497 Comm: c_repro Not tainted 5.13.0-rc1+ #281
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE+0x1b1/0x510
 Code: 87 59 03 00 00 e8 9f ab 1e ff 48 8d bd a8 00 00 00 e8 d3 70 41 ff 44 0f b7 b5 a8 00 00 00 e8 86 ab 1e ff 31 d2 4c 89 f0 31 ff <49> f7 f5 48 89 d6 48 89 54 24 10 48 89 04 24 e8 1b ad 1e ff 48 8b
 RSP: 0018:ffff88810416f828 EFLAGS: 00010246
 RAX: 0000000000000008 RBX: 1ffff1102082df09 RCX: ffffffff82183f3d
 RDX: 0000000000000000 RSI: ffff888105f2da00 RDI: 0000000000000000
 RBP: ffff88810416fa98 R08: 0000000000000001 R09: ffffed102082df5f
 R10: ffff88810416faf7 R11: ffffed102082df5e R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000008 R15: ffff88810416faf0
 FS:  00007f5715efa740(0000) GS:ffff88811a700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000020000840 CR3: 000000010c2e0001 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? ib_uverbs_handler_UVERBS_METHOD_INFO_HANDLES+0x4b0/0x4b0
  ? __radix_tree_lookup+0x190/0x190
  ? write_comp_data+0x2a/0x80
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? __bitmap_subset+0x9a/0x130
  ib_uverbs_cmd_verbs+0x1546/0x1940
  ? __kernel_text_address+0xe/0x30
  ? ib_uverbs_handler_UVERBS_METHOD_INFO_HANDLES+0x4b0/0x4b0
  ? uverbs_fill_udata+0x510/0x510
  ? putname+0xa8/0xc0
  ? kasan_set_free_info+0x20/0x30
  ? __kasan_slab_free+0xed/0x130
  ? kmem_cache_free+0x94/0x410
  ? putname+0xa8/0xc0
  ? do_sys_openat2+0x477/0x780
  ? do_sys_open+0xc8/0x150
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? restore_nameidata+0x8a/0xb0
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? do_filp_open+0x166/0x1f0
  ? should_fail+0x78/0x2a0
  ? may_open_dev+0x80/0x80
  ? write_comp_data+0x2a/0x80
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ib_uverbs_ioctl+0x186/0x240
  ? ib_uverbs_cmd_verbs+0x1940/0x1940
  ? fsnotify+0xba0/0xba0
  ? write_comp_data+0x2a/0x80
  ? write_comp_data+0x2a/0x80
  ? ib_uverbs_cmd_verbs+0x1940/0x1940
  __x64_sys_ioctl+0x38a/0x1220
  ? generic_block_fiemap+0x60/0x60
  ? putname+0xa8/0xc0
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? do_sys_openat2+0x47c/0x780
  ? file_open_root+0x420/0x420
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? cgroup_rstat_updated+0x66/0x1a0
  ? do_sys_open+0xc8/0x150
  ? filp_open+0x80/0x80
  ? write_comp_data+0x2a/0x80
  ? fpregs_assert_state_consistent+0x90/0xa0
  ? __sanitizer_cov_trace_pc+0x1d/0x50
  ? exit_to_user_mode_prepare+0x35/0x160
  do_syscall_64+0x3f/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f5715ff0f59
 Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffd33031858 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5715ff0f59
 RDX: 0000000020000180 RSI: 00000000c0181b01 RDI: 0000000000000003
 RBP: 00007ffd33031870 R08: 00007ffd33031950 R09: 00007ffd33031950
 R10: 0000000000000000 R11: 0000000000000213 R12: 0000558a0989b060
 R13: 00007ffd33031950 R14: 0000000000000000 R15: 0000000000000000
 Modules linked in:
 Dumping ftrace buffer:
    (ftrace buffer empty)
 ---[ end trace 7776f38b0b269133 ]---
 RIP: 0010:ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE+0x1b1/0x510
 Code: 87 59 03 00 00 e8 9f ab 1e ff 48 8d bd a8 00 00 00 e8 d3 70 41 ff 44 0f b7 b5 a8 00 00 00 e8 86 ab 1e ff 31 d2 4c 89 f0 31 ff <49> f7 f5 48 89 d6 48 89 54 24 10 48 89 04 24 e8 1b ad 1e ff 48 8b
 RSP: 0018:ffff88810416f828 EFLAGS: 00010246
 RAX: 0000000000000008 RBX: 1ffff1102082df09 RCX: ffffffff82183f3d
 RDX: 0000000000000000 RSI: ffff888105f2da00 RDI: 0000000000000000
 RBP: ffff88810416fa98 R08: 0000000000000001 R09: ffffed102082df5f
 R10: ffff88810416faf7 R11: ffffed102082df5e R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000008 R15: ffff88810416faf0
 FS:  00007f5715efa740(0000) GS:ffff88811a700000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000020000840 CR3: 000000010c2e0001 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Kernel panic - not syncing: Fatal exception
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: disabled
 Rebooting in 1 seconds..

Fixes: 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query API to user space")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 9ec6971056fa..a03021d94e11 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -331,6 +331,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
 	if (ret)
 		return ret;
 
+	if (!user_entry_size)
+		return -EINVAL;
+
 	max_entries = uverbs_attr_ptr_get_array_size(
 		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
 		user_entry_size);
-- 
2.31.1

