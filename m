Return-Path: <linux-rdma+bounces-4604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C232962004
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D17C1F25BBF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7BA158524;
	Wed, 28 Aug 2024 06:51:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9077C157493;
	Wed, 28 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827916; cv=none; b=Jf6E/7y3RvIUzvKP1bifDPgwpivUtDmOsAlXncxA0JVtm7myEX/RGxJLefQkMRs9ASiKqByR+iiGHPLeAIQzZAL2z0Wrq/foM6epcxmsN4jUWWfOw32r1nUMSvjzsjonb5h+r2uowe6UDxRMFRzzxk5m9rSwuVRRuW0o4vdNNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827916; c=relaxed/simple;
	bh=7oHNaEbdLWqpgyc5kEMiT0bhjnU7IlycbKbxzy4EBOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfuF6tnsd0uPyh5msRmgrfGwzI9yVLSNUnMbfKvFMI/Akx4jUyzdOPdRPsrT1nfinOhbiSFTVRDraDA5UAf97vjq05rH6mahiQuMZxD5gXLBYgAXPk3A/8CxhSCGc303K07oEDI7of0gcGI9jYRm5W8I7+KmUp/fYp+mqI68hRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wtw6Y75bfzyQX2;
	Wed, 28 Aug 2024 14:51:01 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D88214022E;
	Wed, 28 Aug 2024 14:51:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 14:51:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v3 for-next 1/2] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
Date: Wed, 28 Aug 2024 14:46:04 +0800
Message-ID: <20240828064605.887519-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Provide a new api rdma_user_mmap_disassociate() for drivers to
disassociate mmap pages for a device.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/uverbs.h      |  3 ++
 drivers/infiniband/core/uverbs_main.c | 45 +++++++++++++++++++++++++--
 include/rdma/ib_verbs.h               |  8 +++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 821d93c8f712..0999d27cb1c9 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -160,6 +160,9 @@ struct ib_uverbs_file {
 	struct page *disassociate_page;
 
 	struct xarray		idr;
+
+	struct mutex disassociation_lock;
+	atomic_t disassociated;
 };
 
 struct ib_uverbs_event {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bc099287de9a..589f27c09a2e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -76,6 +76,7 @@ static dev_t dynamic_uverbs_dev;
 static DEFINE_IDA(uverbs_ida);
 static int ib_uverbs_add_one(struct ib_device *device);
 static void ib_uverbs_remove_one(struct ib_device *device, void *client_data);
+static struct ib_client uverbs_client;
 
 static char *uverbs_devnode(const struct device *dev, umode_t *mode)
 {
@@ -217,6 +218,7 @@ void ib_uverbs_release_file(struct kref *ref)
 
 	if (file->disassociate_page)
 		__free_pages(file->disassociate_page, 0);
+	mutex_destroy(&file->disassociation_lock);
 	mutex_destroy(&file->umap_lock);
 	mutex_destroy(&file->ucontext_lock);
 	kfree(file);
@@ -700,6 +702,12 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 		ret = PTR_ERR(ucontext);
 		goto out;
 	}
+
+	if (atomic_read(&file->disassociated)) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	vma->vm_ops = &rdma_umap_ops;
 	ret = ucontext->device->ops.mmap(ucontext, vma);
 out:
@@ -726,7 +734,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 	/*
 	 * Disassociation already completed, the VMA should already be zapped.
 	 */
-	if (!ufile->ucontext)
+	if (!ufile->ucontext || atomic_read(&ufile->disassociated))
 		goto out_unlock;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -822,6 +830,8 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 	struct rdma_umap_priv *priv, *next_priv;
 
 	lockdep_assert_held(&ufile->hw_destroy_rwsem);
+	mutex_lock(&ufile->disassociation_lock);
+	atomic_set(&ufile->disassociated, 1);
 
 	while (1) {
 		struct mm_struct *mm = NULL;
@@ -847,8 +857,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 			break;
 		}
 		mutex_unlock(&ufile->umap_lock);
-		if (!mm)
+		if (!mm) {
+			mutex_unlock(&ufile->disassociation_lock);
 			return;
+		}
 
 		/*
 		 * The umap_lock is nested under mmap_lock since it used within
@@ -878,8 +890,34 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}
+
+	mutex_unlock(&ufile->disassociation_lock);
 }
 
+/**
+ * rdma_user_mmap_disassociate() - Revoke mmaps for a device
+ * @device: device to revoke
+ *
+ * This function should be called by drivers that need to disable mmaps for the
+ * device, for instance because it is going to be reset.
+ */
+void rdma_user_mmap_disassociate(struct ib_device *device)
+{
+	struct ib_uverbs_device *uverbs_dev =
+		ib_get_client_data(device, &uverbs_client);
+	struct ib_uverbs_file *ufile;
+
+	mutex_lock(&uverbs_dev->lists_mutex);
+	list_for_each_entry(ufile, &uverbs_dev->uverbs_file_list, list) {
+		down_read(&ufile->hw_destroy_rwsem);
+		if (ufile->ucontext && !atomic_read(&ufile->disassociated))
+			uverbs_user_mmap_disassociate(ufile);
+		up_read(&ufile->hw_destroy_rwsem);
+	}
+	mutex_unlock(&uverbs_dev->lists_mutex);
+}
+EXPORT_SYMBOL(rdma_user_mmap_disassociate);
+
 /*
  * ib_uverbs_open() does not need the BKL:
  *
@@ -949,6 +987,9 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	mutex_init(&file->umap_lock);
 	INIT_LIST_HEAD(&file->umaps);
 
+	mutex_init(&file->disassociation_lock);
+	atomic_set(&file->disassociated, 0);
+
 	filp->private_data = file;
 	list_add_tail(&file->list, &dev->uverbs_file_list);
 	mutex_unlock(&dev->lists_mutex);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1dcf812d787..09b80c8253e2 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2948,6 +2948,14 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+void rdma_user_mmap_disassociate(struct ib_device *device);
+#else
+static inline void rdma_user_mmap_disassociate(struct ib_device *device)
+{
+}
+#endif
+
 static inline int
 rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
 				  struct rdma_user_mmap_entry *entry,
-- 
2.33.0


