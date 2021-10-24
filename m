Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB843871A
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Oct 2021 08:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJXGK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Oct 2021 02:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhJXGKz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 Oct 2021 02:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1623060EE3;
        Sun, 24 Oct 2021 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635055714;
        bh=SsA174+4TXZi25kx3XL5kr+aRC9yJYHOMKhChTRKux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcx+I0ikWaLmyF65GKbilgCQIZ2gBHffxCxE7UR9/T2d/ERm0l/wKqwLMC7mF51Yk
         DK8CYi9U1qvl6Mi8eQYxlL21OeIcZuFqtJzYr2fciXAeJ/8LgI9fyPNrX6jnvv/AY9
         MH9EOB5pBONu+7y2oX2iG1ct1lAyvJwv+lGrI/SXs+f+R/VxVxB/QgEWO40gGAmwUQ
         StksnTGxG4aWHaUvkXa4A+lcQSvnhuYXoaxN2yRI94b4U3cKwpHhiQA6fMPyJM00ey
         fWjNTfHMuq3B2Z0GrlDa/n5nBYOgHNBvGqZeht+F46qlsxyhkIwhEx74l6TFnk4xNC
         PCbGYZIAELDcw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-rc 2/2] RDMA/core: Initialize lock when allocate a rdma_hw_stats structure
Date:   Sun, 24 Oct 2021 09:08:21 +0300
Message-Id: <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635055496.git.leonro@nvidia.com>
References: <cover.1635055496.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
warning below. Then we don't need to initialize it in sysfs, remove it.

 [ 1460.517202] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 [ 1460.517223] WARNING: CPU: 4 PID: 64464 at kernel/locking/mutex.c:575 __mutex_lock+0x9c3/0x12b0
 [ 1460.520539] Modules linked in: bonding ip_gre mlx5_ib geneve ib_ipoib ip6_gre gre nf_tables ip6_tunnel tunnel6 ib_umad mlx5_core rdma_ucm ib_uverbs ipip tunnel4 openvswitch nsh xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter rpcrdma ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core overlay fuse [last unloaded: nf_tables]
 [ 1460.528622] CPU: 4 PID: 64464 Comm: rdma Not tainted 5.15.0-rc5_for_upstream_debug_2021_10_14_11_06 #1
 [ 1460.530762] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 1460.533280] RIP: 0010:__mutex_lock+0x9c3/0x12b0
 [ 1460.534385] Code: 08 84 d2 0f 85 cd 08 00 00 8b 05 00 7e 70 01 85 c0 0f 85 51 f7 ff ff 48 c7 c6 00 a4 89 83 48 c7 c7 c0 a1 89 83 e8 b8 97 f0 ff <0f> 0b e9 37 f7 ff ff 48 8b 44 24 40 48 8d b8 f0 06 00 00 48 89 f8
 [ 1460.538488] RSP: 0018:ffff88822d016d18 EFLAGS: 00010282
 [ 1460.539733] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 [ 1460.541308] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed1045a02d95
 [ 1460.542868] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8884d322f8fb
 [ 1460.544554] R10: ffffed109a645f1f R11: 0000000000000001 R12: dffffc0000000000
 [ 1460.546323] R13: ffff88819f846000 R14: ffff888102ad6060 R15: ffff88819f846000
 [ 1460.548037] FS:  00007f149943f800(0000) GS:ffff8884d3200000(0000) knlGS:0000000000000000
 [ 1460.550036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 1460.551446] CR2: 00007fff4fd8cff8 CR3: 000000017c108001 CR4: 0000000000370ea0
 [ 1460.553112] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 1460.554836] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 1460.556517] Call Trace:
 [ 1460.557231]  ? fill_res_counter_entry+0x6ee/0x1020 [ib_core]
 [ 1460.558885]  ? mutex_lock_io_nested+0x1130/0x1130
 [ 1460.560082]  ? fill_res_counter_entry+0x5c7/0x1020 [ib_core]
 [ 1460.561587]  ? lock_downgrade+0x6e0/0x6e0
 [ 1460.562646]  ? memcpy+0x39/0x60
 [ 1460.563529]  ? nla_put+0x15f/0x1c0
 [ 1460.564447]  fill_res_counter_entry+0x6ee/0x1020 [ib_core]
 [ 1460.565906]  ? fill_res_srq_entry+0x940/0x940 [ib_core]
 [ 1460.567346]  ? rdma_restrack_count+0x440/0x440 [ib_core]
 [ 1460.568763]  ? memcpy+0x39/0x60
 [ 1460.569441]  ? nla_put+0x15f/0x1c0
 [ 1460.570226]  res_get_common_dumpit+0x907/0x10a0 [ib_core]
 [ 1460.571251]  ? fill_res_srq_entry+0x940/0x940 [ib_core]
 [ 1460.572292]  ? _nldev_get_dumpit+0x4c0/0x4c0 [ib_core]
 [ 1460.573526]  ? mark_lock+0xf7/0x2e60
 [ 1460.574451]  ? nla_get_range_signed+0x540/0x540
 [ 1460.575505]  ? mark_lock+0xf7/0x2e60
 [ 1460.576192]  ? lock_chain_count+0x20/0x20
 [ 1460.576935]  nldev_stat_get_dumpit+0x20a/0x290 [ib_core]
 [ 1460.577948]  ? res_get_common_dumpit+0x10a0/0x10a0 [ib_core]
 [ 1460.579026]  ? memset+0x20/0x40
 [ 1460.579642]  ? __build_skb_around+0x1f8/0x2b0
 [ 1460.580452]  ? netlink_skb_set_owner_r+0xc6/0x1e0
 [ 1460.581327]  netlink_dump+0x451/0x1040
 [ 1460.582032]  ? netlink_deliver_tap+0xb10/0xb10
 [ 1460.582863]  ? __netlink_dump_start+0x222/0x830
 [ 1460.583686]  __netlink_dump_start+0x583/0x830
 [ 1460.584487]  rdma_nl_rcv_msg+0x3f3/0x7c0 [ib_core]
 [ 1460.585445]  ? rdma_nl_chk_listeners+0xb0/0xb0 [ib_core]
 [ 1460.595904]  ? res_get_common_dumpit+0x10a0/0x10a0 [ib_core]
 [ 1460.596962]  ? netlink_deliver_tap+0xbc/0xb10
 [ 1460.597765]  rdma_nl_rcv+0x264/0x410 [ib_core]
 [ 1460.598631]  ? rdma_nl_rcv_msg+0x7c0/0x7c0 [ib_core]
 [ 1460.599612]  ? netlink_deliver_tap+0x140/0xb10
 [ 1460.600415]  ? netlink_deliver_tap+0x14c/0xb10
 [ 1460.601210]  ? _copy_from_iter+0x282/0xbe0
 [ 1460.601964]  netlink_unicast+0x433/0x700
 [ 1460.602691]  ? netlink_attachskb+0x740/0x740
 [ 1460.603486]  ? __alloc_skb+0x117/0x2c0
 [ 1460.604184]  netlink_sendmsg+0x707/0xbf0
 [ 1460.604912]  ? netlink_unicast+0x700/0x700
 [ 1460.605669]  ? netlink_unicast+0x700/0x700
 [ 1460.606414]  sock_sendmsg+0xb0/0xe0
 [ 1460.607097]  __sys_sendto+0x193/0x240
 [ 1460.607788]  ? __x64_sys_getpeername+0xb0/0xb0
 [ 1460.608589]  ? _copy_to_user+0x94/0xb0
 [ 1460.609292]  ? __x64_sys_connect+0xb0/0xb0
 [ 1460.610039]  ? __x64_sys_socketpair+0xf0/0xf0
 [ 1460.610864]  ? __sys_socket+0x11a/0x1a0
 [ 1460.611594]  ? sock_ioctl+0x610/0x610
 [ 1460.612297]  __x64_sys_sendto+0xdd/0x1b0
 [ 1460.613041]  ? syscall_enter_from_user_mode+0x1d/0x50
 [ 1460.613965]  do_syscall_64+0x3d/0x90
 [ 1460.614648]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [ 1460.615582] RIP: 0033:0x7f1499622cba
 [ 1460.616275] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 c3 0f 1f 44 00 00 55 48 83 ec 30 44 89 4c
 [ 1460.619476] RSP: 002b:00007fff4fd8e9a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 [ 1460.620843] RAX: ffffffffffffffda RBX: 00007fff4fd8ec70 RCX: 00007f1499622cba
 [ 1460.622088] RDX: 0000000000000028 RSI: 0000000000c43910 RDI: 0000000000000004
 [ 1460.623341] RBP: 00007fff4fd8ec70 R08: 00007f14996ee000 R09: 000000000000000c
 [ 1460.624577] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000c44940
 [ 1460.625818] R13: 0000000000000000 R14: 00007fff4fd8ec90 R15: 00007fff4fd8ec70
 [ 1460.627074] irq event stamp: 44063
 [ 1460.627736] hardirqs last  enabled at (44063): [<ffffffff83349157>] _raw_spin_unlock_irqrestore+0x47/0x50
 [ 1460.629415] hardirqs last disabled at (44062): [<ffffffff83348f50>] _raw_spin_lock_irqsave+0x50/0x60
 [ 1460.631072] softirqs last  enabled at (43932): [<ffffffff82a74532>] netlink_insert+0x172/0x11d0
 [ 1460.632707] softirqs last disabled at (43930): [<ffffffff828490db>] release_sock+0x1b/0x170
 [ 1460.634227] ---[ end trace 48c63b35e252a166 ]---

Fixes: e945130b52be ("IB/core: Protect against concurrent access to hardware stats")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
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

