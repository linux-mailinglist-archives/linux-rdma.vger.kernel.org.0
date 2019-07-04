Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34225F8B5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGDNAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 09:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfGDNAU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 09:00:20 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886122189E;
        Thu,  4 Jul 2019 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245219;
        bh=E7lkh/tqLxzypv8KvIW6CkDsgpOzrp+2Vm1W38mcEAo=;
        h=From:To:Cc:Subject:Date:From;
        b=mwAmrrVPnVkb/OTSm3ifwJUmD6HIsf6EmlLj0sfcvdgEo8uqEtVqTqMC5Bb+XWfyC
         N7sG5mXdm0acAGZf8QW8ohx3r4IRDhp70fAiDLpwl2da8iT6kl9kDYzaDmP5vNvAXf
         alIQ3sDWIduS+DjtXI2RoPCJLBK+nW7RrJCpnFig=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/core: Annotate destroy of mutex to ensure that it is released as unlocked
Date:   Thu,  4 Jul 2019 16:00:12 +0300
Message-Id: <20190704130012.8177-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

While compiled with CONFIG_DEBUG_MUTEXES, the kernel ensures that mutex
is not held during destroy.
Hence add mutex_destroy() for mutexes used in RDMA modules.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c        | 1 +
 drivers/infiniband/core/cma_configfs.c | 1 +
 drivers/infiniband/core/device.c       | 3 +++
 drivers/infiniband/core/user_mad.c     | 2 +-
 drivers/infiniband/core/uverbs_main.c  | 2 ++
 drivers/infiniband/core/verbs.c        | 1 +
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 18e476b3ced0..00fb3eacda19 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -810,6 +810,7 @@ static void release_gid_table(struct ib_device *device,
 	if (leak)
 		return;
 
+	mutex_destroy(&table->lock);
 	kfree(table->data_vec);
 	kfree(table);
 }
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 3ec2c415bb70..0a7b5eba2fc0 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -350,4 +350,5 @@ int __init cma_configfs_init(void)
 void __exit cma_configfs_exit(void)
 {
 	configfs_unregister_subsystem(&cma_subsys);
+	mutex_destroy(&cma_subsys.su_mutex);
 }
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 7f4affe8a10d..adf8d93bb42d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -508,6 +508,9 @@ static void ib_device_release(struct device *device)
 			  rcu_head);
 	}
 
+	mutex_destroy(&dev->unregistration_lock);
+	mutex_destroy(&dev->compat_devs_mutex);
+
 	xa_destroy(&dev->compat_devs);
 	xa_destroy(&dev->client_data);
 	kfree_rcu(dev, rcu_head);
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 9f8a48016b41..e0512aef033c 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1038,7 +1038,7 @@ static int ib_umad_close(struct inode *inode, struct file *filp)
 				ib_unregister_mad_agent(file->agent[i]);
 
 	mutex_unlock(&file->port->file_mutex);
-
+	mutex_destroy(&file->mutex);
 	kfree(file);
 	return 0;
 }
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 11c13c1381cf..4827aa3415ff 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -120,6 +120,8 @@ static void ib_uverbs_release_dev(struct device *device)
 
 	uverbs_destroy_api(dev->uapi);
 	cleanup_srcu_struct(&dev->disassociate_srcu);
+	mutex_destroy(&dev->lists_mutex);
+	mutex_destroy(&dev->xrcd_tree_mutex);
 	kfree(dev);
 }
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 92349bf37589..f974b6854224 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2259,6 +2259,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
 		if (ret)
 			return ret;
 	}
+	mutex_destroy(&xrcd->tgt_qp_mutex);
 
 	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
 }
-- 
2.20.1

