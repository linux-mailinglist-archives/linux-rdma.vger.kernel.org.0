Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC339402E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhE1Jjh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:39:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5131 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhE1Jjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:39:32 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fs00N1DF5zYmqb;
        Fri, 28 May 2021 17:35:16 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml765-chm.china.huawei.com (10.1.199.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 07/12] RDMA/core: Use refcount_t instead of atomic_t on refcount of ib_uverbs_device
Date:   Fri, 28 May 2021 17:37:38 +0800
Message-ID: <1622194663-2383-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/uverbs.h      |  2 +-
 drivers/infiniband/core/uverbs_main.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 53a1047..821d93c 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -97,7 +97,7 @@ ib_uverbs_init_udata_buf_or_null(struct ib_udata *udata,
  */
 
 struct ib_uverbs_device {
-	atomic_t				refcount;
+	refcount_t				refcount;
 	u32					num_comp_vectors;
 	struct completion			comp;
 	struct device				dev;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index f173ecd..d544340 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -197,7 +197,7 @@ void ib_uverbs_release_file(struct kref *ref)
 		module_put(ib_dev->ops.owner);
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 
-	if (atomic_dec_and_test(&file->device->refcount))
+	if (refcount_dec_and_test(&file->device->refcount))
 		ib_uverbs_comp_dev(file->device);
 
 	if (file->default_async_file)
@@ -891,7 +891,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	int srcu_key;
 
 	dev = container_of(inode->i_cdev, struct ib_uverbs_device, cdev);
-	if (!atomic_inc_not_zero(&dev->refcount))
+	if (!refcount_inc_not_zero(&dev->refcount))
 		return -ENXIO;
 
 	get_device(&dev->dev);
@@ -955,7 +955,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 err:
 	mutex_unlock(&dev->lists_mutex);
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
-	if (atomic_dec_and_test(&dev->refcount))
+	if (refcount_dec_and_test(&dev->refcount))
 		ib_uverbs_comp_dev(dev);
 
 	put_device(&dev->dev);
@@ -1124,7 +1124,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
 	uverbs_dev->dev.release = ib_uverbs_release_dev;
 	uverbs_dev->groups[0] = &dev_attr_group;
 	uverbs_dev->dev.groups = uverbs_dev->groups;
-	atomic_set(&uverbs_dev->refcount, 1);
+	refcount_set(&uverbs_dev->refcount, 1);
 	init_completion(&uverbs_dev->comp);
 	uverbs_dev->xrcd_tree = RB_ROOT;
 	mutex_init(&uverbs_dev->xrcd_tree_mutex);
@@ -1166,7 +1166,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
 err_uapi:
 	ida_free(&uverbs_ida, devnum);
 err:
-	if (atomic_dec_and_test(&uverbs_dev->refcount))
+	if (refcount_dec_and_test(&uverbs_dev->refcount))
 		ib_uverbs_comp_dev(uverbs_dev);
 	wait_for_completion(&uverbs_dev->comp);
 	put_device(&uverbs_dev->dev);
@@ -1229,7 +1229,7 @@ static void ib_uverbs_remove_one(struct ib_device *device, void *client_data)
 		wait_clients = 0;
 	}
 
-	if (atomic_dec_and_test(&uverbs_dev->refcount))
+	if (refcount_dec_and_test(&uverbs_dev->refcount))
 		ib_uverbs_comp_dev(uverbs_dev);
 	if (wait_clients)
 		wait_for_completion(&uverbs_dev->comp);
-- 
2.7.4

