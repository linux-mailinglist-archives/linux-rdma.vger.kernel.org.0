Return-Path: <linux-rdma+bounces-4937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1921E978023
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56947B246ED
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779891DA2F5;
	Fri, 13 Sep 2024 12:36:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A41DA0E4;
	Fri, 13 Sep 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230961; cv=none; b=uF+vsJImDiZB4pc8l9PHX6NBcCPqt0iTPdHX5K+v0y77t4nx1Se72NZBF0VOVZgDl+jpkTpHwhpKYzHakEyg84wUoagsR/7vGVjIFoMsv6w+Ks40aaxkfq2eZn7m9OGFCtTCawPH6fnw/spD442A/TmzBxPss9aq2LZmBDd3roY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230961; c=relaxed/simple;
	bh=gpQAwDKw8Kf+lbReKVEjgA+iHO84l3ALkdLM5z4g1Fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fW8sZMIT443HjyL34djh+lt+wohI1T0HdWi7F4V4Ubqlll7p3FUnjwXddQgdjFFoOY0a2jCRxTOZUe4AklSJY7Vi4gDIJmasUBHFvXFc2x+kSkKTrEqNEJM1cD6A2f3YCOMWN7AeNlb2mMkhoFd6lNSK3m2WsA6c11Bx7RAOpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X4v0P4Kfwz2CpX9;
	Fri, 13 Sep 2024 20:35:17 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 995431402CD;
	Fri, 13 Sep 2024 20:35:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 20:35:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v5 for-next 1/2] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
Date: Fri, 13 Sep 2024 20:29:54 +0800
Message-ID: <20240913122955.1283597-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
References: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/infiniband/core/uverbs_main.c | 47 ++++++++++++++++++++++++---
 include/rdma/ib_verbs.h               |  8 +++++
 3 files changed, 53 insertions(+), 4 deletions(-)

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
index bc099287de9a..9b2073c8cc6e 100644
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
@@ -698,11 +700,16 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 	ucontext = ib_uverbs_get_ucontext_file(file);
 	if (IS_ERR(ucontext)) {
 		ret = PTR_ERR(ucontext);
-		goto out;
+		goto out_srcu;
 	}
+
+	mutex_lock(&file->disassociation_lock);
+
 	vma->vm_ops = &rdma_umap_ops;
 	ret = ucontext->device->ops.mmap(ucontext, vma);
-out:
+out_mutex:
+	mutex_unlock(&file->disassociation_lock);
+out_srcu:
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return ret;
 }
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
@@ -878,8 +891,32 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
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
+		if (ufile->ucontext)
+			uverbs_user_mmap_disassociate(ufile);
+	}
+	mutex_unlock(&uverbs_dev->lists_mutex);
+}
+EXPORT_SYMBOL(rdma_user_mmap_disassociate);
+
 /*
  * ib_uverbs_open() does not need the BKL:
  *
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


