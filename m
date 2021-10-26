Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879BB43AE47
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhJZIpi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 04:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233821AbhJZIpc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 04:45:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A11AD60F0F;
        Tue, 26 Oct 2021 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635237789;
        bh=h43NCwa9ubJX4Wst6s4xQvESgGFgW4Qr8HEznAtMvLo=;
        h=From:To:Cc:Subject:Date:From;
        b=hEIMK5wFoFUSNYyEwIgrA3+kv0wZXUvyJ2C8qweR4lEfDyLos4FI6qrw3vKeF1Tkb
         qUAp2DIEo9HW4xGVPoLWNZ0h9FEMG9cWfGHVyywa8dA4F+JwnALt9y3i2l+7ygAySs
         dDlB+RzGktfU26mgkXCy5lUaXOOTxfWDrEs7jNVoPwsBH5ridFI0yRq/qzYCe0SYyL
         cDiV8LtO+mbnzLjagNf1LgVrnNwT5iPmWTRDwlm403d4kv57TL/2sBT/ecC2L+H+RZ
         JA+i3YVM87xI5lD+NC3GpGaEz6aUBVXDvcBFV14zwpGRfKP956bHC2TEqYuSnzwR6c
         s0Sqx8io9XP6g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next v1] RDMA/core: Initialize lock when allocate a rdma_hw_stats structure
Date:   Tue, 26 Oct 2021 11:43:03 +0300
Message-Id: <4a22986c4685058d2c735d91703ee7d865815bb9.1635237668.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
warning below. Then we don't need to initialize it in sysfs, remove it.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 4 PID: 64464 at kernel/locking/mutex.c:575 __mutex_lock+0x9c3/0x12b0
 Modules linked in: bonding ip_gre mlx5_ib geneve ib_ipoib ip6_gre gre nf_tables ip6_tunnel tunnel6 ib_umad mlx5_core rdma_ucm ib_uverbs ipip tunnel4 openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core overlay fuse [last unloaded: nf_tables]
 CPU: 4 PID: 64464 Comm: rdma Not tainted 5.15.0-rc5_for_upstream_debug_2021_10_14_11_06 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__mutex_lock+0x9c3/0x12b0
 Code: 08 84 d2 0f 85 cd 08 00 00 8b 05 00 7e 70 01 85 c0 0f 85 51 f7 ff ff 48 c7 c6 00 a4 89 83 48 c7 c7 c0 a1 89 83 e8 b8 97 f0 ff <0f> 0b e9 37 f7 ff ff 48 8b 44 24 40 48 8d b8 f0 06 00 00 48 89 f8
 RSP: 0018:ffff88822d016d18 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed1045a02d95
 RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8884d322f8fb
 R10: ffffed109a645f1f R11: 0000000000000001 R12: dffffc0000000000
 R13: ffff88819f846000 R14: ffff888102ad6060 R15: ffff88819f846000
 FS:  00007f149943f800(0000) GS:ffff8884d3200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fff4fd8cff8 CR3: 000000017c108001 CR4: 0000000000370ea0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? fill_res_counter_entry+0x6ee/0x1020 [ib_core]
  ? mutex_lock_io_nested+0x1130/0x1130
  ? fill_res_counter_entry+0x5c7/0x1020 [ib_core]
  ? lock_downgrade+0x6e0/0x6e0
  ? memcpy+0x39/0x60
  ? nla_put+0x15f/0x1c0
  fill_res_counter_entry+0x6ee/0x1020 [ib_core]
  ? fill_res_srq_entry+0x940/0x940 [ib_core]
  ? rdma_restrack_count+0x440/0x440 [ib_core]
  ? memcpy+0x39/0x60
  ? nla_put+0x15f/0x1c0
  res_get_common_dumpit+0x907/0x10a0 [ib_core]
  ? fill_res_srq_entry+0x940/0x940 [ib_core]
  ? _nldev_get_dumpit+0x4c0/0x4c0 [ib_core]
  ? mark_lock+0xf7/0x2e60
  ? nla_get_range_signed+0x540/0x540
  ? mark_lock+0xf7/0x2e60
  ? lock_chain_count+0x20/0x20
  nldev_stat_get_dumpit+0x20a/0x290 [ib_core]
  ? res_get_common_dumpit+0x10a0/0x10a0 [ib_core]
  ? memset+0x20/0x40
  ? __build_skb_around+0x1f8/0x2b0
  ? netlink_skb_set_owner_r+0xc6/0x1e0
  netlink_dump+0x451/0x1040
  ? netlink_deliver_tap+0xb10/0xb10
  ? __netlink_dump_start+0x222/0x830
  __netlink_dump_start+0x583/0x830
  rdma_nl_rcv_msg+0x3f3/0x7c0 [ib_core]
  ? rdma_nl_chk_listeners+0xb0/0xb0 [ib_core]
  ? res_get_common_dumpit+0x10a0/0x10a0 [ib_core]
  ? netlink_deliver_tap+0xbc/0xb10
  rdma_nl_rcv+0x264/0x410 [ib_core]
  ? rdma_nl_rcv_msg+0x7c0/0x7c0 [ib_core]
  ? netlink_deliver_tap+0x140/0xb10
  ? netlink_deliver_tap+0x14c/0xb10
  ? _copy_from_iter+0x282/0xbe0
  netlink_unicast+0x433/0x700
  ? netlink_attachskb+0x740/0x740
  ? __alloc_skb+0x117/0x2c0
  netlink_sendmsg+0x707/0xbf0
  ? netlink_unicast+0x700/0x700
  ? netlink_unicast+0x700/0x700
  sock_sendmsg+0xb0/0xe0
  __sys_sendto+0x193/0x240
  ? __x64_sys_getpeername+0xb0/0xb0
  ? _copy_to_user+0x94/0xb0
  ? __x64_sys_connect+0xb0/0xb0
  ? __x64_sys_socketpair+0xf0/0xf0
  ? __sys_socket+0x11a/0x1a0
  ? sock_ioctl+0x610/0x610
  __x64_sys_sendto+0xdd/0x1b0
  ? syscall_enter_from_user_mode+0x1d/0x50
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f1499622cba
 Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
 RSP: 002b:00007fff4fd8e9a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 00007fff4fd8ec70 RCX: 00007f1499622cba
 RDX: 0000000000000028 RSI: 0000000000c43910 RDI: 0000000000000004
 RBP: 00007fff4fd8ec70 R08: 00007f14996ee000 R09: 000000000000000c
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000c44940
 R13: 0000000000000000 R14: 00007fff4fd8ec90 R15: 00007fff4fd8ec70
 irq event stamp: 44063
 hardirqs last  enabled at (44063): [<ffffffff83349157>] _raw_spin_unlock_irqrestore+0x47/0x50
 hardirqs last disabled at (44062): [<ffffffff83348f50>] _raw_spin_lock_irqsave+0x50/0x60
 softirqs last  enabled at (43932): [<ffffffff82a74532>] netlink_insert+0x172/0x11d0
 softirqs last disabled at (43930): [<ffffffff828490db>] release_sock+0x1b/0x170
 ---[ end trace 48c63b35e252a166 ]---

Fixes: 0a0800ce2a6a ("RDMA/core: Add a helper API rdma_free_hw_stats_struct")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Changed Fixes line
 * Removed timestamps from the kernel panic
 * Change target from rdma-rc to rdma-next
v0:
https://lore.kernel.org/all/89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com/
---
 drivers/infiniband/core/sysfs.c | 2 --
 drivers/infiniband/core/verbs.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 8626dfbf2199..a3f84b50c46a 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -911,7 +911,6 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	if (!data->group.attrs)
 		goto err_free_data;
 
-	mutex_init(&stats->lock);
 	data->group.name = "hw_counters";
 	data->stats = stats;
 	return data;
@@ -1018,7 +1017,6 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 	if (!group->attrs)
 		goto err_free_data;
 
-	mutex_init(&stats->lock);
 	group->name = "hw_counters";
 	data->stats = stats;
 	return data;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 47cf273d0678..692d5ff657df 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -3002,6 +3002,7 @@ struct rdma_hw_stats *rdma_alloc_hw_stats_struct(
 	stats->descs = descs;
 	stats->num_counters = num_counters;
 	stats->lifespan = msecs_to_jiffies(lifespan);
+	mutex_init(&stats->lock);
 
 	return stats;
 
-- 
2.31.1

