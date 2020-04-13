Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C771A66DB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgDMNVn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDMNVl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:21:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4182C20692;
        Mon, 13 Apr 2020 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586784100;
        bh=IUpuyYMqyoqUEFch1uaJhrD4demhi1X7r0uSrv4jup4=;
        h=From:To:Cc:Subject:Date:From;
        b=Vhyirrhm8l0BifVBwMgicSO7W4PMdqB/DRzQU6T9GNpgg6WRUiklHg0oYO/mCjUjK
         dBzHwThjrTUARfuZqtt28dA9c8RJNLKND9zDVvleENLpGzp6PmsQ/pdXh+/QD+CtL/
         I24UZtrnfWHIt5FYVctTA/wGKc16QVzoFm/qL3Iw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ariel Elior <ariel.elior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/uverbs: Fix a race with disassociate and exit_mmap()
Date:   Mon, 13 Apr 2020 16:21:36 +0300
Message-Id: <20200413132136.930388-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

If uverbs_user_mmap_disassociate() is called while the mmap is
concurrently doing exit_mmap then the ordering of the
rdma_user_mmap_entry_put() is not reliable.

The put must be done before uvers_user_mmap_disassociate() returns,
otherwise there can be a use after free on the ucontext, and a left over
entry in the xarray. If the put is not done here then it is done during
rdma_umap_close() later.

Add the missing put to the error exit path.

 [14951.039881] ------------[ cut here ]------------
 [14951.043244] WARNING: CPU: 7 PID: 7111 at drivers/infiniband/core/rdma_core.c:810 uverbs_destroy_ufile_hw+0x2a5/0x340 [ib_uverbs]
 [14951.048933] Modules linked in: bonding ipip tunnel4 geneve ip6_udp_tunnel udp_tunnel ip6_gre ip6_tunnel tunnel6 ip_gre ip_tunnel gre mlx5_ib mlx5_core mlxfw pci_hyperv_intf act_ct nf_flow_table ptp pps_core rdma_ucm ib_uverbs ib_ipoib ib_umad 8021q garp mrp openvswitch nsh nf_conncount nfsv3 nfs_acl xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype iptable_filter xt_conntrack br_netfilter bridge stp llc rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache overlay rpcrdma ib_isert iscsi_target_mod ib_iser kvm_intel ib_srpt iTCO_wdt target_core_mod iTCO_vendor_support kvm ib_srp nf_nat irqbypass crc32_pclmul crc32c_intel nf_conntrack rfkill nf_defrag_ipv6 virtio_net nf_defrag_ipv4 pcspkr ghash_clmulni_intel i2c_i801 net_failover failover i2c_core lpc_ich mfd_core rdma_cm ib_cm iw_cm button ib_core sunrpc sch_fq_codel ip_tables serio_raw [last unloaded: tunnel4]
 [14951.072124] CPU: 7 PID: 7111 Comm: python3 Tainted: G        W         5.6.0-rc6-for-upstream-dbg-2020-03-21_06-41-26-18 #1
 [14951.075343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 [14951.078497] RIP: 0010:uverbs_destroy_ufile_hw+0x2a5/0x340 [ib_uverbs]
 [14951.080275] Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 74 49 8b 84 24 08 01 00 00 48 85 c0 0f 84 13 ff ff ff 48 89 ef ff d0 e9 09 ff ff ff <0f> 0b e9 77 ff ff ff e8 0f d8 fa e0 e9 c5 fd ff ff e8 05 d8 fa e0
 [14951.085200] RSP: 0018:ffff88840e0779a0 EFLAGS: 00010286
 [14951.086776] RAX: dffffc0000000000 RBX: ffff8882a7721c00 RCX: 0000000000000000
 [14951.088682] RDX: 1ffff11054ee469f RSI: ffffffff8446d7e0 RDI: ffff8882a77234f8
 [14951.090586] RBP: ffff8882a7723400 R08: ffffed1085c0112c R09: 0000000000000001
 [14951.092489] R10: 0000000000000001 R11: ffffed1085c0112b R12: ffff888403c30000
 [14951.094394] R13: 0000000000000002 R14: ffff8882a7721cb0 R15: ffff8882a7721cd0
 [14951.096301] FS:  00007f2046089700(0000) GS:ffff88842de00000(0000) knlGS:0000000000000000
 [14951.098906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [14951.100576] CR2: 00007f7cfe9a6e20 CR3: 000000040b8ac006 CR4: 0000000000360ee0
 [14951.102499] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [14951.104420] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [14951.106347] Call Trace:
 [14951.107458]  ib_uverbs_remove_one+0x273/0x480 [ib_uverbs]
 [14951.109071]  ? up_write+0x15c/0x4a0
 [14951.110356]  remove_client_context+0xa6/0xf0 [ib_core]
 [14951.111925]  disable_device+0x12d/0x200 [ib_core]
 [14951.113409]  ? remove_client_context+0xf0/0xf0 [ib_core]
 [14951.114983]  ? mnt_get_count+0x1d0/0x1d0
 [14951.116351]  __ib_unregister_device+0x79/0x150 [ib_core]
 [14951.117937]  ib_unregister_device+0x21/0x30 [ib_core]
 [14951.119488]  __mlx5_ib_remove+0x91/0x110 [mlx5_ib]
 [14951.120981]  ? __mlx5_ib_remove+0x110/0x110 [mlx5_ib]
 [14951.122552]  mlx5_remove_device+0x241/0x310 [mlx5_core]
 [14951.124158]  mlx5_unregister_device+0x4d/0x1e0 [mlx5_core]
 [14951.125797]  mlx5_unload_one+0xc0/0x260 [mlx5_core]
 [14951.127340]  remove_one+0x5c/0x160 [mlx5_core]
 [14951.128771]  pci_device_remove+0xef/0x2a0
 [14951.130126]  ? pcibios_free_irq+0x10/0x10
 [14951.131512]  device_release_driver_internal+0x1d8/0x470
 [14951.133086]  unbind_store+0x152/0x200
 [14951.134373]  ? sysfs_kf_write+0x3b/0x180
 [14951.135724]  ? sysfs_file_ops+0x160/0x160
 [14951.137075]  kernfs_fop_write+0x284/0x460
 [14951.138424]  ? __sb_start_write+0x243/0x3a0
 [14951.139820]  vfs_write+0x197/0x4a0
 [14951.141077]  ksys_write+0x156/0x1e0
 [14951.142347]  ? __x64_sys_read+0xb0/0xb0
 [14951.143689]  ? do_syscall_64+0x73/0x1330
 [14951.145033]  ? do_syscall_64+0x73/0x1330
 [14951.146395]  do_syscall_64+0xe7/0x1330
 [14951.147753]  ? down_write_nested+0x3e0/0x3e0
 [14951.149183]  ? syscall_return_slowpath+0x970/0x970
 [14951.150683]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
 [14951.152281]  ? lockdep_hardirqs_off+0x1de/0x2d0
 [14951.153741]  ? trace_hardirqs_off_thunk+0x1a/0x1c
 [14951.155238]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 [14951.156771] RIP: 0033:0x7f20a3ff0cdb
 [14951.158044] Code: 53 48 89 d5 48 89 f3 48 83 ec 18 48 89 7c 24 08 e8 5a fd ff ff 48 89 ea 41 89 c0 48 89 de 48 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 90 fd ff ff 48
 [14951.162974] RSP: 002b:00007f2046087040 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
 [14951.165505] RAX: ffffffffffffffda RBX: 00007f2038016df0 RCX: 00007f20a3ff0cdb
 [14951.167407] RDX: 000000000000000d RSI: 00007f2038016df0 RDI: 0000000000000018
 [14951.169319] RBP: 000000000000000d R08: 0000000000000000 R09: 0000000000000000
 [14951.171241] R10: 0000000000000100 R11: 0000000000000293 R12: 00007f2046e29630
 [14951.173148] R13: 00007f20280035a0 R14: 0000000000000018 R15: 00007f2038016df0
 [14951.175109] irq event stamp: 38230
 [14951.176367] hardirqs last  enabled at (38229): [<ffffffff8184210c>] quarantine_put+0xbc/0x310
 [14951.179076] hardirqs last disabled at (38230): [<ffffffff81006943>] trace_hardirqs_off_thunk+0x1a/0x1c
 [14951.181886] softirqs last  enabled at (38174): [<ffffffff8360075a>] __do_softirq+0x75a/0xbd4
 [14951.184570] softirqs last disabled at (38159): [<ffffffff811e6e9e>] irq_exit+0x18e/0x1e0
 [14951.187221] ---[ end trace b12f13ae91584095 ]---

Fixes: c043ff2cfb7f ("RDMA: Connect between the mmap entry and the umap_priv structure")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 2d4083bf4a04..17fc25db0311 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -820,6 +820,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 			ret = mmget_not_zero(mm);
 			if (!ret) {
 				list_del_init(&priv->list);
+				if (priv->entry) {
+					rdma_user_mmap_entry_put(priv->entry);
+					priv->entry = NULL;
+				}
 				mm = NULL;
 				continue;
 			}
-- 
2.25.2

