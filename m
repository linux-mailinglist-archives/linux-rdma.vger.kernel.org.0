Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B180F1F57A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEONUe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 09:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfEONUe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 09:20:34 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB0020843;
        Wed, 15 May 2019 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557926432;
        bh=+8aAQdz0p1My25gYG5RlsnL7wCznsDGXGb3+/e8OvXw=;
        h=From:To:Cc:Subject:Date:From;
        b=iZEj97vr5f2uZac619KKUfOjay7h2eJSL+zzpgTIb8s8rclxzy3yW7x4JPYJmM5IE
         EHV3D0jwuwMTk5ncbbSlAQE/9/GWdjTHRWu/U/x5GEj0br9g9DTOZRTxSASCi5h4Wh
         G3Sy7rVges2qZOp1byIzzDyXBdGHp60ktTpwiedM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [RFC PATCH rdma-next v1] RDMA/srp: Rename SRP sysfs name after IB device rename trigger
Date:   Wed, 15 May 2019 16:20:26 +0300
Message-Id: <20190515132026.18768-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

SRP logic used device name and port index as symlink to relevant
kobject. This situation caused to device name to be cached and
triggered on the boot the kernel panic below.

[    8.163181] RPC: Registered rdma transport module.
[    8.163182] RPC: Registered rdma backchannel transport module.
[    8.319908] pps_core: LinuxPPS API ver. 1 registered
[    8.319910] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    8.346610] PTP clock support registered
[    9.317026] mlx5_core 0000:00:08.0: firmware version: 12.25.1020
[    9.317157] mlx5_core 0000:00:08.0: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
[    9.532121] mlx5_core 0000:00:08.0: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
[    9.694930] mlx5_core 0000:00:08.1: firmware version: 12.25.1020
[    9.694995] mlx5_core 0000:00:08.1: 126.016 Gb/s available PCIe bandwidth (8 GT/s x16 link)
[    9.904603] mlx5_core 0000:00:08.1: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
[    9.981334] mlx5_core 0000:00:08.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
[   10.161993] mlx5_core 0000:00:08.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256) RxCqeCmprss(0)
[   10.162424] mlx5_core 0000:00:08.0 ens8f0: renamed from eth0
[   10.357080] mlx5_core 0000:00:08.1 ens8f1: renamed from eth0
[   10.484528] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
[   10.622868] sysfs: cannot create duplicate filename '/class/infiniband_srp/srp-mlx5_0-1'
[   10.622871] CPU: 3 PID: 1107 Comm: modprobe Not tainted 5.1.0-for-upstream-perf-2019-05-12_15-09-52-87 #1
[   10.622872] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[   10.622873] Call Trace:
[   10.622883]  dump_stack+0x5a/0x73
[   10.622889]  sysfs_warn_dup+0x58/0x70
[   10.622891]  sysfs_do_create_link_sd.isra.2+0xa3/0xb0
[   10.622896]  device_add+0x33f/0x660
[   10.622900]  srp_add_one+0x301/0x4f0 [ib_srp]
[   10.622917]  add_client_context+0x99/0xe0 [ib_core]
[   10.622926]  enable_device_and_get+0xd1/0x1b0 [ib_core]
[   10.622934]  ib_register_device+0x533/0x710 [ib_core]
[   10.622938]  ? mutex_lock+0xe/0x30
[   10.622948]  __mlx5_ib_add+0x23/0x70 [mlx5_ib]
[   10.622983]  mlx5_add_device+0x4e/0xd0 [mlx5_core]
[   10.622999]  mlx5_register_interface+0x85/0xc0 [mlx5_core]
[   10.623000]  ? 0xffffffffa0791000
[   10.623003]  do_one_initcall+0x4b/0x1cb
[   10.623007]  ? kmem_cache_alloc_trace+0xc6/0x1d0
[   10.623009]  ? do_init_module+0x22/0x21f
[   10.623011]  do_init_module+0x5a/0x21f
[   10.623013]  load_module+0x17f2/0x1ca0
[   10.623015]  ? m_show+0x1c0/0x1c0
[   10.623017]  __do_sys_finit_module+0x94/0xe0
[   10.623019]  do_syscall_64+0x48/0x120
[   10.623022]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   10.623038] RIP: 0033:0x7f157cce10d9
[   10.623039] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 ad 2c 00 f7 d8 64 89 01 48
[   10.623040] RSP: 002b:00007ffd79f91538 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   10.623042] RAX: ffffffffffffffda RBX: 0000561a4a8f2d80 RCX: 00007f157cce10d9
[   10.623043] RDX: 0000000000000000 RSI: 0000561a48e1f85c RDI: 0000000000000001
[   10.623050] RBP: 0000561a48e1f85c R08: 0000000000000000 R09: 0000000000000000
[   10.623050] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
[   10.623051] R13: 0000561a4a8f2eb0 R14: 0000000000040000 R15: 0000561a4a8f2d80
[   10.858147] random: crng init done
[   10.858149] random: 7 urandom warning(s) missed due to ratelimiting
[   99.994965] FS-Cache: Loaded
[  100.283059] FS-Cache: Netfs 'nfs' registered for caching
[  100.322275] Key type dns_resolver registered
[  100.558079] NFS: Registering the id_resolver key type
[  100.558086] Key type id_resolver registered
[  100.558087] Key type id_legacy registered

This panic is caused due to races between device rename during boot and
initialization of new devices for multi-adapter system.

The module load/unload sequence was used to trigger such kernel panic:
 sudo modprobe ib_srp
 sudo modprobe -r mlx5_ib
 sudo modprobe -r mlx5_core
 sudo modprobe mlx5_core

Fixes: d21943dd19b5 ("RDMA/core: Implement IB device rename function")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog v0->v1:
 * Reimplemented

This is marked as RFC because it didn't pass our regression yet and
posted here to gather feedback.

The patch solves the issue for me.

Thanks
---
 drivers/infiniband/core/device.c    | 16 ++++++++++++++++
 drivers/infiniband/ulp/srp/ib_srp.c | 18 +++++++++++++++++-
 include/rdma/ib_verbs.h             |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index a67aaf0e1f76..64f777e757f6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -410,6 +410,9 @@ static int rename_compat_devs(struct ib_device *device)

 int ib_device_rename(struct ib_device *ibdev, const char *name)
 {
+	struct ib_client *client;
+	unsigned long index;
+	void *client_data;
 	int ret;

 	down_write(&devices_rwsem);
@@ -428,6 +431,19 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 		goto out;
 	strlcpy(ibdev->name, name, IB_DEVICE_NAME_MAX);
 	ret = rename_compat_devs(ibdev);
+
+	downgrade_write(&devices_rwsem);
+	down_read(&clients_rwsem);
+	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
+		if (client->rename) {
+			client_data =
+				xa_load(&ibdev->client_data, client->client_id);
+			client->rename(ibdev, client_data);
+		}
+	}
+	up_read(&clients_rwsem);
+	up_read(&devices_rwsem);
+	return 0;
 out:
 	up_write(&devices_rwsem);
 	return ret;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index be9ddcad8f28..2edd014e62db 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -148,6 +148,7 @@ MODULE_PARM_DESC(ch_count,

 static void srp_add_one(struct ib_device *device);
 static void srp_remove_one(struct ib_device *device, void *client_data);
+static void srp_rename_dev(struct ib_device *device, void *client_data);
 static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc);
 static void srp_handle_qp_err(struct ib_cq *cq, struct ib_wc *wc,
 		const char *opname);
@@ -162,7 +163,8 @@ static struct workqueue_struct *srp_remove_wq;
 static struct ib_client srp_client = {
 	.name   = "srp",
 	.add    = srp_add_one,
-	.remove = srp_remove_one
+	.remove = srp_remove_one,
+	.rename = srp_rename_dev
 };

 static struct ib_sa_client srp_sa_client;
@@ -4112,6 +4114,20 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 	return NULL;
 }

+static void srp_rename_dev(struct ib_device *device, void *client_data)
+{
+	struct srp_device *srp_dev = client_data;
+	struct srp_host *host, *tmp_host;
+
+	list_for_each_entry_safe (host, tmp_host, &srp_dev->dev_list, list) {
+		char name[IB_DEVICE_NAME_MAX * 2] = {};
+
+		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
+			 dev_name(&device->dev), host->port);
+		device_rename(&host->dev, name);
+	}
+}
+
 static void srp_add_one(struct ib_device *device)
 {
 	struct srp_device *srp_dev;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e9fffa55426b..59d0fffbf192 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2727,6 +2727,7 @@ struct ib_client {
 	const char *name;
 	void (*add)   (struct ib_device *);
 	void (*remove)(struct ib_device *, void *client_data);
+	void (*rename)(struct ib_device *, void *client_data);

 	/* Returns the net_dev belonging to this ib_client and matching the
 	 * given parameters.
--
2.20.1

