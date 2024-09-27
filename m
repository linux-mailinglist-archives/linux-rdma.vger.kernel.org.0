Return-Path: <linux-rdma+bounces-5131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA679882AB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC23A1C21720
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF48318950A;
	Fri, 27 Sep 2024 10:39:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235513698F;
	Fri, 27 Sep 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433578; cv=none; b=oo/r+BrVG7vfFOFP+KLa0x2QObZQCf7pYHDm7lnYMWi3iWuSO4p7Q7DHa17MCy9jdwpiJyGdMlQ5Tw9xkhCkYaL/p1ta2eYEeJpA7rYHacFPf5CAR5FXx5W2aA730VUolQBFAZfR27JxzsRgcMkALmo3fSSJV19OpxLt8g/UZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433578; c=relaxed/simple;
	bh=VaqY7fSnnc+sTwn1vuPDl7W9DTLaIQlQ/kU5WCPPduA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPiGOCuZrd8WCb7722SluUZ3tX/3rTTUXVIgjULXfAeT9fiWKi/LbrWvDrUax+Cu49+DxO1o8h3W1HhVfH6U0W4voBoIGOc7RSGJnGcPhPYWtkgbrb+ECuQPXtM7S5a0pbRTWXwWQBThgD90KNgDrlCM1dPOhOQS/hB8EddrEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XFRjl0HHKzWf0n;
	Fri, 27 Sep 2024 18:37:15 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 23D7F140393;
	Fri, 27 Sep 2024 18:39:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Sep 2024 18:39:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH v6 for-next 1/2] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
Date: Fri, 27 Sep 2024 18:33:22 +0800
Message-ID: <20240927103323.1897094-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240927103323.1897094-1-huangjunxian6@hisilicon.com>
References: <20240927103323.1897094-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

Provide a new api rdma_user_mmap_disassociate() for drivers to
disassociate mmap pages for a device.

Since drivers can now disassociate mmaps by calling this api,
introduce a new disassociation_lock to specifically prevent
races between this disassociation process and new mmaps. And
thus the old hw_destroy_rwsem is not needed in this api.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/uverbs.h      |  2 ++
 drivers/infiniband/core/uverbs_main.c | 43 +++++++++++++++++++++++++--
 include/rdma/ib_verbs.h               |  8 +++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 821d93c8f712..dfd2e5a86e6f 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -160,6 +160,8 @@ struct ib_uverbs_file {
 	struct page *disassociate_page;
 
 	struct xarray		idr;
+
+	struct mutex disassociation_lock;
 };
 
 struct ib_uverbs_event {
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bc099287de9a..48b97e6c1fc6 100644
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
@@ -700,8 +702,13 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 		ret = PTR_ERR(ucontext);
 		goto out;
 	}
+
+	mutex_lock(&file->disassociation_lock);
+
 	vma->vm_ops = &rdma_umap_ops;
 	ret = ucontext->device->ops.mmap(ucontext, vma);
+
+	mutex_unlock(&file->disassociation_lock);
 out:
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return ret;
@@ -723,6 +730,8 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 	/* We are racing with disassociation */
 	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
 		goto out_zap;
+	mutex_lock(&ufile->disassociation_lock);
+
 	/*
 	 * Disassociation already completed, the VMA should already be zapped.
 	 */
@@ -734,10 +743,12 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 		goto out_unlock;
 	rdma_umap_priv_init(priv, vma, opriv->entry);
 
+	mutex_unlock(&ufile->disassociation_lock);
 	up_read(&ufile->hw_destroy_rwsem);
 	return;
 
 out_unlock:
+	mutex_unlock(&ufile->disassociation_lock);
 	up_read(&ufile->hw_destroy_rwsem);
 out_zap:
 	/*
@@ -821,7 +832,7 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 {
 	struct rdma_umap_priv *priv, *next_priv;
 
-	lockdep_assert_held(&ufile->hw_destroy_rwsem);
+	mutex_lock(&ufile->disassociation_lock);
 
 	while (1) {
 		struct mm_struct *mm = NULL;
@@ -847,8 +858,10 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
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
@@ -878,7 +891,31 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}
+
+	mutex_unlock(&ufile->disassociation_lock);
+}
+
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
+		if (ufile->ucontext)
+			uverbs_user_mmap_disassociate(ufile);
+	}
+	mutex_unlock(&uverbs_dev->lists_mutex);
 }
+EXPORT_SYMBOL(rdma_user_mmap_disassociate);
 
 /*
  * ib_uverbs_open() does not need the BKL:
@@ -949,6 +986,8 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	mutex_init(&file->umap_lock);
 	INIT_LIST_HEAD(&file->umaps);
 
+	mutex_init(&file->disassociation_lock);
+
 	filp->private_data = file;
 	list_add_tail(&file->list, &dev->uverbs_file_list);
 	mutex_unlock(&dev->lists_mutex);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index aa8ede439905..9cb8b5fe7eee 100644
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


