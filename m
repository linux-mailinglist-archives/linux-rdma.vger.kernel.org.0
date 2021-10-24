Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DABF438718
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhJXGKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 02:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhJXGKv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Oct 2021 02:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAB960EE9;
        Sun, 24 Oct 2021 06:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635055711;
        bh=A/eEkTxQ++avYteQ4U92t1rGwrjLLBkWKx5I0QmfWVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FG0QFd0sy1nzAGpCyixdQdwfL1sGdevi6kzsN0iOkU1ANhm1CxE4xB22rXzsV2Scs
         dxzR3r6D21K1hp/ubbHqi9jx98hXk9xaSe9WmFTDir6Ex6VmIReto93OzKMq5HIKdB
         2sUVVJJg7ifnbFxPRdYJJSGLlgUoFWKnKT0eQM652bTQTQRO2UCRgVf4MGK9ddK5aF
         t+QQzzvWOzIsI3dioqPMLxWvmTK0pPv59L/J4RWuHEQH8ShGjttBgnqaa7UpE8iFqJ
         WMaJpq3J+Zfl0md6y3uQQLQwjqNSnJ+Xe212x95I4oIbM0p73UsmJ3RzIOi0cIWeOm
         Yv7NrCRm0Q/Rg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-rc 1/2] RDMA/sa_query: Use strscpy_pad instead of memcpy to copy a string
Date:   Sun, 24 Oct 2021 09:08:20 +0300
Message-Id: <72ede0f6dab61f7f23df9ac7a70666e07ef314b0.1635055496.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635055496.git.leonro@nvidia.com>
References: <cover.1635055496.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

When copy the device name, the length of data memcpy copied exceeds
the length of the source buffer, which cause the KASAN issue below.
Use strscpy_pad instead.

 BUG: KASAN: slab-out-of-bounds in ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
 Read of size 64 at addr ffff88811a10f5e0 by task rping/140263
 CPU: 3 PID: 140263 Comm: rping Not tainted 5.15.0-rc1+ #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
 dump_stack_lvl+0x57/0x7d
 print_address_description.constprop.0+0x1d/0xa0
 kasan_report+0xcb/0x110
 ? lock_downgrade+0xb0/0xc0
 ? ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
 kasan_check_range+0x13d/0x180
 memcpy+0x20/0x60
 ib_nl_set_path_rec_attrs+0x136/0x320 [ib_core]
 ? init_mad+0xf0/0xf0 [ib_core]
 ? __nlmsg_put+0x9a/0xb0
 ? ibnl_put_msg+0x90/0xd0 [ib_core]
 ib_nl_make_request+0x1c6/0x380 [ib_core]
 ? ib_nl_set_path_rec_attrs+0x320/0x320 [ib_core]
 ? netlink_has_listeners+0x114/0x210
 send_mad+0x20a/0x220 [ib_core]
 ? ib_nl_make_request+0x380/0x380 [ib_core]
 ? memcpy+0x39/0x60
 ? value_read+0x20/0x80 [ib_core]
 ? ib_pack+0x140/0x2a0 [ib_core]
 ib_sa_path_rec_get+0x3e3/0x800 [ib_core]
 ? alloc_mad+0x390/0x390 [ib_core]
 ? __kasan_kmalloc+0x7c/0x90
 ? rdma_resolve_route+0x37b/0x3e0 [rdma_cm]
 ? ucma_resolve_route+0xe1/0x150 [rdma_ucm]
 ? ucma_write+0x17b/0x1f0 [rdma_ucm]
 ? vfs_write+0x142/0x4d0
 ? ksys_write+0x133/0x160
 ? do_syscall_64+0x43/0x90
 ? entry_SYSCALL_64_after_hwframe+0x44/0xae
 ? print_usage_bug+0x50/0x50
 ? lock_downgrade+0xc0/0xc0
 cma_query_ib_route+0x29b/0x390 [rdma_cm]
 ? rdma_set_ib_path+0x150/0x150 [rdma_cm]
 ? lockdep_hardirqs_on_prepare+0x12e/0x200
 ? rdma_create_user_id+0x80/0x80 [rdma_cm]
 ? rdma_resolve_route+0x37b/0x3e0 [rdma_cm]
 ? rdma_resolve_route+0x308/0x3e0 [rdma_cm]
 rdma_resolve_route+0x308/0x3e0 [rdma_cm]
 ucma_resolve_route+0xe1/0x150 [rdma_ucm]
 ? ucma_disconnect+0x140/0x140 [rdma_ucm]
 ucma_write+0x17b/0x1f0 [rdma_ucm]
 ? ucma_copy_ib_route+0x1a0/0x1a0 [rdma_ucm]
 ? __fget_files+0x146/0x240
 vfs_write+0x142/0x4d0
 ksys_write+0x133/0x160
 ? __ia32_sys_read+0x50/0x50
 ? lockdep_hardirqs_on_prepare+0x12e/0x200
 ? syscall_enter_from_user_mode+0x1d/0x50
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f26499aa90f
 Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 fd ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c fd ff ff 48
 RSP: 002b:00007f26495f2dc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 00000000000007d0 RCX: 00007f26499aa90f
 RDX: 0000000000000010 RSI: 00007f26495f2e00 RDI: 0000000000000003
 RBP: 00005632a8315440 R08: 0000000000000000 R09: 0000000000000001
 R10: 0000000000000000 R11: 0000000000000293 R12: 00007f26495f2e00
 R13: 00005632a83154e0 R14: 00005632a8315440 R15: 00005632a830a810

 Allocated by task 131419:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc+0x7c/0x90
 proc_self_get_link+0x8b/0x100
 pick_link+0x4f1/0x5c0
 step_into+0x2eb/0x3d0
 walk_component+0xc8/0x2c0
 link_path_walk+0x3b8/0x580
 path_openat+0x101/0x230
 do_filp_open+0x12e/0x240
 do_sys_openat2+0x115/0x280
 __x64_sys_openat+0xce/0x140
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

 The buggy address belongs to the object at ffff88811a10f5e0
 kmalloc-16 of size 16
 The buggy address is located 0 bytes inside of
10f5e0, ffff88811a10f5f0)
 The buggy address belongs to the page:
 page:000000007b6da7b1 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811a10f1e0 pfn:0x11a10f
 flags: 0x8000000000000200(slab|zone=2)
 raw: 8000000000000200 ffffea0004463040 0000001200000012 ffff8881000423c0
 raw: ffff88811a10f1e0 000000008080007f 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
 ffff88811a10f480: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff88811a10f500: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
 >ffff88811a10f580: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
 ^
 ffff88811a10f600: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff88811a10f680: 00 00 fc fc 00 00 fc fc fa fb fc fc 00 00 fc fc

Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sa_query.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 4220a545387f..74ecd7456a11 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -706,8 +706,9 @@ static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 
 	/* Construct the family header first */
 	header = skb_put(skb, NLMSG_ALIGN(sizeof(*header)));
-	memcpy(header->device_name, dev_name(&query->port->agent->device->dev),
-	       LS_DEVICE_NAME_MAX);
+	strscpy_pad(header->device_name,
+		    dev_name(&query->port->agent->device->dev),
+		    LS_DEVICE_NAME_MAX);
 	header->port_num = query->port->port_num;
 
 	if ((comp_mask & IB_SA_PATH_REC_REVERSIBLE) &&
-- 
2.31.1

