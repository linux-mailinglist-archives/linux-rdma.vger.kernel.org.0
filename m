Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C6E1054E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 07:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfEAFrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 01:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfEAFrC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 01:47:02 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4014421734;
        Wed,  1 May 2019 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556689620;
        bh=oIjMnF23zySCU3WaKmys2ae4swAb3+6LlfQ77XJRERw=;
        h=From:To:Cc:Subject:Date:From;
        b=MQmewgyMYv1bYlUk6q66Jf91/h8mbWG5sXt7JJ90Vsx6ZmwyjlTchZFgiYUDvmT0C
         tsZ1LP6NIYS/k25dQiHbMGicdaiqqaQPJLYM+FwjTc9PcVVCwN+4j/a2E8JbBzjuAp
         KkBAf/xAjTb0qocehc9Mx3YaZ5ANckoU/SSfHGMs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/core: Do not invoke init_port on compat devices
Date:   Wed,  1 May 2019 08:46:55 +0300
Message-Id: <20190501054655.15525-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

As compat devices in net namespaces may not need vendor specific control
attributes, avoid invoking init_port() on them.

This avoids below reported call trace.

Call Trace:
dump_stack+0x5a/0x73
kobject_init+0x74/0x80
kobject_init_and_add+0x35/0xb0
hfi1_create_port_files+0x6e/0x3c0 [hfi1]
ib_setup_port_attrs+0x43b/0x560 [ib_core]
add_one_compat_dev+0x16a/0x230 [ib_core]
rdma_dev_init_net+0x110/0x160 [ib_core]
ops_init+0x38/0xf0
setup_net+0xcf/0x1e0
copy_net_ns+0xb7/0x130
create_new_namespaces+0x11a/0x1b0
unshare_nsproxy_namespaces+0x55/0xa0
ksys_unshare+0x1a7/0x340
__x64_sys_unshare+0xe/0x20
do_syscall_64+0x5b/0x180
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 5417783eabb2 ("RDMA/core: Support core port attributes in non init_net")
Reported-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/sysfs.c     | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 2764647056d8..77956c42358e 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -342,7 +342,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 
 void ib_free_port_attrs(struct ib_core_device *coredev);
 int ib_setup_port_attrs(struct ib_core_device *coredev,
-			bool alloc_hw_stats);
+			bool init_port_alloc_stats);
 
 int rdma_compatdev_set(u8 enable);
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 1d264db61988..1909d8a6694f 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1025,7 +1025,7 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 }
 
 static int add_port(struct ib_core_device *coredev,
-		    int port_num, bool alloc_stats)
+		    int port_num, bool init_port_alloc_stats)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
 	struct ib_port *p;
@@ -1066,7 +1066,7 @@ static int add_port(struct ib_core_device *coredev,
 		goto err_put;
 	}
 
-	if (device->ops.process_mad && alloc_stats) {
+	if (device->ops.process_mad && init_port_alloc_stats) {
 		p->pma_table = get_counter_table(device, port_num);
 		ret = sysfs_create_group(&p->kobj, p->pma_table);
 		if (ret)
@@ -1122,7 +1122,7 @@ static int add_port(struct ib_core_device *coredev,
 	if (ret)
 		goto err_free_pkey;
 
-	if (device->ops.init_port) {
+	if (device->ops.init_port && init_port_alloc_stats) {
 		ret = device->ops.init_port(device, port_num, &p->kobj);
 		if (ret)
 			goto err_remove_pkey;
@@ -1133,7 +1133,7 @@ static int add_port(struct ib_core_device *coredev,
 	 * port, so holder should be device. Therefore skip per port conunter
 	 * initialization.
 	 */
-	if (device->ops.alloc_hw_stats && port_num && alloc_stats)
+	if (device->ops.alloc_hw_stats && port_num && init_port_alloc_stats)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
@@ -1317,7 +1317,8 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 	kobject_put(coredev->ports_kobj);
 }
 
-int ib_setup_port_attrs(struct ib_core_device *coredev, bool alloc_stats)
+int ib_setup_port_attrs(struct ib_core_device *coredev,
+			bool init_port_alloc_stats)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
 	unsigned int port;
@@ -1329,7 +1330,7 @@ int ib_setup_port_attrs(struct ib_core_device *coredev, bool alloc_stats)
 		return -ENOMEM;
 
 	rdma_for_each_port (device, port) {
-		ret = add_port(coredev, port, alloc_stats);
+		ret = add_port(coredev, port, init_port_alloc_stats);
 		if (ret)
 			goto err_put;
 	}
-- 
2.20.1

