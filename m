Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2C1EB6B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOJuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 05:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEOJuU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 05:50:20 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D21822084F;
        Wed, 15 May 2019 09:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557913819;
        bh=CwB9JUJpmBH1RtkA1QA/vUq4DAwDi+Drx6dh9p/taoc=;
        h=From:To:Cc:Subject:Date:From;
        b=UsfyZ6DxI09pn0tbgb1pbAenNmc1OjUJ5q/xtEBEqg2IAEtrHp8VdZzyMNp0lBfzq
         asX+SvfI5QohpRWXaE63IeRu2f0EpessyXck1pdII8D+7lB7PiTmBsxZWDnhd78445
         32tfOzJXdM5QsNHtLMCPDyb4OF/hhciTd1dG4PU8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part of sysfs name
Date:   Wed, 15 May 2019 12:50:13 +0300
Message-Id: <20190515095013.8141-1-leon@kernel.org>
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

Because the knowledge of connected IB device and port already exported
inside of SRP sysfs folder, we can safely remove SRP device to index based
scheme and drop any attempt to cache IB device name.

After this change:
[leonro@iserver ~]$ l /sys/class/infiniband_srp
lrwxrwxrwx  1 root root 0 May 15 09:01 srp0 -> ../../devices/pci0000:00/0000:00:0d.0/infiniband_srp/srp0
lrwxrwxrwx  1 root root 0 May 15 09:01 srp1 -> ../../devices/pci0000:00/0000:00:0e.0/infiniband_srp/srp1
[leonro@server ~]$ cat /sys/class/infiniband_srp/srp0/ibdev
ibp0s13
[leonro@server ~]$ cat /sys/class/infiniband_srp/srp0/port
1

The module load/unload sequence was used to trigger such kernel panic:
 sudo modprobe ib_srp
 sudo modprobe -r mlx5_ib
 sudo modprobe -r mlx5_core
 sudo modprobe mlx5_core

Fixes: d21943dd19b5 ("RDMA/core: Implement IB device rename function")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 ++++++++++++++----
 drivers/infiniband/ulp/srp/ib_srp.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index be9ddcad8f28..5e60622138bb 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -167,6 +167,9 @@ static struct ib_client srp_client = {

 static struct ib_sa_client srp_sa_client;

+#define SRP_MAX_DEVICES 1024
+static DECLARE_BITMAP(dev_map, SRP_MAX_DEVICES);
+
 static int srp_tmo_get(char *buffer, const struct kernel_param *kp)
 {
 	int tmo = *(int *)kp->arg;
@@ -4075,6 +4078,7 @@ static DEVICE_ATTR(port, S_IRUGO, show_port, NULL);
 static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 {
 	struct srp_host *host;
+	int devnum;

 	host = kzalloc(sizeof *host, GFP_KERNEL);
 	if (!host)
@@ -4089,11 +4093,15 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)

 	host->dev.class = &srp_class;
 	host->dev.parent = device->dev->dev.parent;
-	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
-		     port);
+	devnum = find_first_zero_bit(dev_map, SRP_MAX_DEVICES);
+	if (devnum >= SRP_MAX_DEVICES)
+		goto free_host;
+	set_bit(devnum, dev_map);
+	host->devnum = devnum;
+	dev_set_name(&host->dev, "srp%d", devnum);

 	if (device_register(&host->dev))
-		goto free_host;
+		goto free_num;
 	if (device_create_file(&host->dev, &dev_attr_add_target))
 		goto err_class;
 	if (device_create_file(&host->dev, &dev_attr_ibdev))
@@ -4105,7 +4113,8 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)

 err_class:
 	device_unregister(&host->dev);
-
+free_num:
+	clear_bit(devnum, dev_map);
 free_host:
 	kfree(host);

@@ -4215,6 +4224,7 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
 		 * target ports can be created.
 		 */
 		wait_for_completion(&host->released);
+		clear_bit(host->devnum, dev_map);

 		/*
 		 * Remove all target ports.
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index b2861cd2087a..d199afdeab52 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -122,6 +122,7 @@ struct srp_host {
 	struct completion	released;
 	struct list_head	list;
 	struct mutex		add_target_mutex;
+	int			devnum;
 };

 struct srp_request {
--
2.20.1

