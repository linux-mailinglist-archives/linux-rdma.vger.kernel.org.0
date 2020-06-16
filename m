Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977701FAE6B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFPKqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 06:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKqh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 06:46:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A51B20767;
        Tue, 16 Jun 2020 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592304396;
        bh=sD5mKe+79l2vxuBCbSHda0hrdAiw7pSVGYGnMJx48Tk=;
        h=From:To:Cc:Subject:Date:From;
        b=EK6xzisVFuII/ZL28KonGjFwLa5bK0cQ2AI6BoO6gHMxniwMWl5Cv9jqaRRe4lKdJ
         xSk21fgqATXSn+yhdsiBqECYfBUHYtjBGdUdsc0igrbB1xIrns9bVUb3qw9vteer+U
         I8RJI8BQ+U2pga7AseXceBL8VhxGYURxkpgepvYg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/cma: Protect bind_list and listen_list while finding matching cm id
Date:   Tue, 16 Jun 2020 13:43:04 +0300
Message-Id: <20200616104304.2426081-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Add missing lock when the bind_list and listen_list must be accessed
with lock. In addition add lockdep asserts to verify that lock is held.

[14127.352448] general protection fault: 0000 [#1] SMP NOPTI
[14127.356017] CPU: 226 PID: 126135 Comm: kworker/226:1 Tainted: G OE 4.12.14-150.47-default #1 SLE15
[14127.363169] Hardware name: Cray Inc. Windom/Windom, BIOS 0.8.7 01-10-2020
[14127.368545] Workqueue: ib_cm cm_work_handler [ib_cm]
[14127.373185] task: ffff9c5a60a1d2c0 task.stack: ffffc1d91f554000
[14127.379151] RIP: 0010:cma_ib_req_handler+0x3f1/0x11b0 [rdma_cm]
[14127.382316] RSP: 0018:ffffc1d91f557b40 EFLAGS: 00010286
[14127.385693] RAX: deacffffffffff30 RBX: 0000000000000001 RCX: ffff9c2af5bb6000
[14127.391431] RDX: 00000000000000a9 RSI: ffff9c5aa4ed2f10 RDI: ffffc1d91f557b08
[14127.396263] RBP: ffffc1d91f557d90 R08: ffff9c340cc80000 R09: ffff9c2c0f901900
[14127.401531] R10: 0000000000000000 R11: 0000000000000001 R12: deacffffffffff30
[14127.410279] R13: ffff9c5a48aeec00 R14: ffffc1d91f557c30 R15: ffff9c5c2eea3688
[14127.418274] FS: 0000000000000000(0000) GS:ffff9c5c2fa80000(0000) knlGS:0000000000000000
[14127.427259] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14127.432108] CR2: 00002b5cc03fa320 CR3: 0000003f8500a000 CR4: 00000000003406e0
[14127.438461] Call Trace:
[14127.441557] ? rdma_addr_cancel+0xa0/0xa0 [ib_core]
[14127.447922] ? cm_process_work+0x28/0x140 [ib_cm]
[14127.454877] cm_process_work+0x28/0x140 [ib_cm]
[14127.458933] ? cm_get_bth_pkey.isra.44+0x34/0xa0 [ib_cm]
[14127.464246] cm_work_handler+0xa06/0x1a6f [ib_cm]
[14127.470069] ? __switch_to_asm+0x34/0x70
[14127.477089] ? __switch_to_asm+0x34/0x70
[14127.484283] ? __switch_to_asm+0x40/0x70
[14127.491010] ? __switch_to_asm+0x34/0x70
[14127.495557] ? __switch_to_asm+0x40/0x70
[14127.498530] ? __switch_to_asm+0x34/0x70
[14127.502205] ? __switch_to_asm+0x40/0x70
[14127.508609] ? __switch_to+0x7c/0x4b0
[14127.512301] ? __switch_to_asm+0x40/0x70
[14127.516245] ? __switch_to_asm+0x34/0x70
[14127.518631] process_one_work+0x1da/0x400
[14127.522672] worker_thread+0x2b/0x3f0
[14127.527426] ? process_one_work+0x400/0x400
[14127.534769] kthread+0x118/0x140
[14127.538181] ? kthread_create_on_node+0x40/0x40
[14127.544509] ret_from_fork+0x22/0x40
[14127.548842] Code: 00 66 83 f8 02 0f 84 ca 05 00 00 49 8b 84 24 d0 01 00 00 48 85 c0 0f 84 68 07 00 00 48 2d d0 01
00 00 49 89 c4 0f 84 59 07 00 00 <41> 0f b7 44 24 20 49 8b 77 50 66 83 f8 0a 75 9e 49 8b 7c 24 28
[14127.573512] Modules linked in: squashfs lz4_decompress loop rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache 8021q garp mrp stp llc af_packet iscsi_ibft iscsi_boot_sysfs rdma_ucm(OEX) ib_ucm(OEX) rdma_cm(OEX) iw_cm(OEX) configfs ib_ipoib(OEX) ib_cm(OEX) ib_umad(OEX) mlx5_fpga_tools(OEX) mlx4_en(OEX) mlx4_ib(OEX) mlx4_core(OEX) mlx5_ib(OEX) ib_uverbs(OEX) edac_mce_amd kvm_amd ib_core(OEX) kvm irqbypass crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd glue_helper cryptd pcspkr mlx5_core(OEX) mlxfw(OEX) devlink vfio_mdev(OEX) igb vfio_iommu_type1 ptp vfio ahci mdev(OEX) libahci xhci_pci pps_core xhci_hcd i2c_algo_bit libata mlx_compat(OEX) ccp dca usbcore i2c_piix4 shpchp pcc_cpufreq acpi_cpufreq button sg scsi_mod efivarfs autofs4

Fixes: 4c21b5bcef73 ("IB/cma: Add net_dev and private data checks to RDMA CM")
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 3d7cc9f0f3d4..c30cf5307ce3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1624,6 +1624,8 @@ static struct rdma_id_private *cma_find_listener(
 {
 	struct rdma_id_private *id_priv, *id_priv_dev;

+	lockdep_assert_held(&lock);
+
 	if (!bind_list)
 		return ERR_PTR(-EINVAL);

@@ -1670,6 +1672,7 @@ cma_ib_id_from_event(struct ib_cm_id *cm_id,
 		}
 	}

+	mutex_lock(&lock);
 	/*
 	 * Net namespace might be getting deleted while route lookup,
 	 * cm_id lookup is in progress. Therefore, perform netdevice
@@ -1711,6 +1714,7 @@ cma_ib_id_from_event(struct ib_cm_id *cm_id,
 	id_priv = cma_find_listener(bind_list, cm_id, ib_event, req, *net_dev);
 err:
 	rcu_read_unlock();
+	mutex_unlock(&lock);
 	if (IS_ERR(id_priv) && *net_dev) {
 		dev_put(*net_dev);
 		*net_dev = NULL;
@@ -2492,6 +2496,8 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
 	struct net *net = id_priv->id.route.addr.dev_addr.net;
 	int ret;

+	lockdep_assert_held(&lock);
+
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
 		return;

@@ -3342,6 +3348,8 @@ static void cma_bind_port(struct rdma_bind_list *bind_list,
 	u64 sid, mask;
 	__be16 port;

+	lockdep_assert_held(&lock);
+
 	addr = cma_src_addr(id_priv);
 	port = htons(bind_list->port);

@@ -3370,6 +3378,8 @@ static int cma_alloc_port(enum rdma_ucm_port_space ps,
 	struct rdma_bind_list *bind_list;
 	int ret;

+	lockdep_assert_held(&lock);
+
 	bind_list = kzalloc(sizeof *bind_list, GFP_KERNEL);
 	if (!bind_list)
 		return -ENOMEM;
@@ -3396,6 +3406,8 @@ static int cma_port_is_unique(struct rdma_bind_list *bind_list,
 	struct sockaddr  *saddr = cma_src_addr(id_priv);
 	__be16 dport = cma_port(daddr);

+	lockdep_assert_held(&lock);
+
 	hlist_for_each_entry(cur_id, &bind_list->owners, node) {
 		struct sockaddr  *cur_daddr = cma_dst_addr(cur_id);
 		struct sockaddr  *cur_saddr = cma_src_addr(cur_id);
@@ -3435,6 +3447,8 @@ static int cma_alloc_any_port(enum rdma_ucm_port_space ps,
 	unsigned int rover;
 	struct net *net = id_priv->id.route.addr.dev_addr.net;

+	lockdep_assert_held(&lock);
+
 	inet_get_local_port_range(net, &low, &high);
 	remaining = (high - low) + 1;
 	rover = prandom_u32() % remaining + low;
@@ -3482,6 +3496,8 @@ static int cma_check_port(struct rdma_bind_list *bind_list,
 	struct rdma_id_private *cur_id;
 	struct sockaddr *addr, *cur_addr;

+	lockdep_assert_held(&lock);
+
 	addr = cma_src_addr(id_priv);
 	hlist_for_each_entry(cur_id, &bind_list->owners, node) {
 		if (id_priv == cur_id)
@@ -3512,6 +3528,8 @@ static int cma_use_port(enum rdma_ucm_port_space ps,
 	unsigned short snum;
 	int ret;

+	lockdep_assert_held(&lock);
+
 	snum = ntohs(cma_port(cma_src_addr(id_priv)));
 	if (snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
 		return -EACCES;
--
2.26.2

