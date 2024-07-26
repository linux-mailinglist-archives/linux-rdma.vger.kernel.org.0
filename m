Return-Path: <linux-rdma+bounces-4001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02893CECC
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 09:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B4A1C211B3
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFE176AAF;
	Fri, 26 Jul 2024 07:24:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6EA1741C3;
	Fri, 26 Jul 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978687; cv=none; b=VfzmGuV29VlVzKRz9M1TYgm/ULqlEVQDU2pgj3YV5RNt/wUdVUPXW+0cI2lu7GRKAxk4oWMjFAx7luD05oQWhlS9TNXdqgq3a1qqbtF90nJHtdGxDBS16yLoYhkRyQpPwE16eRa5Ba6Mv9tZKtG3NKX9lLnEYMDBi9x5pQwrPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978687; c=relaxed/simple;
	bh=Tsw5OhV4f4IyQdap6kmuzvQ8xK9TFRXPDuKndjHnCjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Alt+QWaUToYVAloPZdTzLWKvjx8rvGFt+rP2nHGJLQLbcryiENNrCkm++rBeQ9ZWOYHTIWGIXqsWDmMeP6KQz5VCxjcKC5UhgK8WEmJx63twCY9KjwAJPyYgYDHYeYBHAG69ZeWRD7IwyLWu4h9rgzCtyScIS581F7OH0edb98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WVfPY4vZHzncbr;
	Fri, 26 Jul 2024 15:23:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BB6718009E;
	Fri, 26 Jul 2024 15:24:37 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jul 2024 15:24:36 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 1/3] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
Date: Fri, 26 Jul 2024 15:19:08 +0800
Message-ID: <20240726071910.626802-2-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
References: <20240726071910.626802-1-huangjunxian6@hisilicon.com>
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
disassociate mmap pages for ucontext.

This api relies on uverbs_user_mmap_disassociate() in ib_uverbs,
causing ib_core relying on ib_uverbs. To avoid this, move
uverbs_user_mmap_disassociate() to ib_core_uverbs.c.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/ib_core_uverbs.c | 85 ++++++++++++++++++++++++
 drivers/infiniband/core/rdma_core.h      |  1 -
 drivers/infiniband/core/uverbs_main.c    | 64 ------------------
 include/rdma/ib_verbs.h                  |  3 +
 4 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index b51bd7087a88..4e27389a75ad 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Marvell. All rights reserved.
  */
 #include <linux/xarray.h>
+#include <linux/sched/mm.h>
 #include "uverbs.h"
 #include "core_priv.h"
 
@@ -365,3 +366,87 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 						 U32_MAX);
 }
 EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
+
+void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
+{
+	struct rdma_umap_priv *priv, *next_priv;
+
+	lockdep_assert_held(&ufile->hw_destroy_rwsem);
+
+	while (1) {
+		struct mm_struct *mm = NULL;
+
+		/* Get an arbitrary mm pointer that hasn't been cleaned yet */
+		mutex_lock(&ufile->umap_lock);
+		while (!list_empty(&ufile->umaps)) {
+			int ret;
+
+			priv = list_first_entry(&ufile->umaps,
+						struct rdma_umap_priv, list);
+			mm = priv->vma->vm_mm;
+			ret = mmget_not_zero(mm);
+			if (!ret) {
+				list_del_init(&priv->list);
+				if (priv->entry) {
+					rdma_user_mmap_entry_put(priv->entry);
+					priv->entry = NULL;
+				}
+				mm = NULL;
+				continue;
+			}
+			break;
+		}
+		mutex_unlock(&ufile->umap_lock);
+		if (!mm)
+			return;
+
+		/*
+		 * The umap_lock is nested under mmap_lock since it used within
+		 * the vma_ops callbacks, so we have to clean the list one mm
+		 * at a time to get the lock ordering right. Typically there
+		 * will only be one mm, so no big deal.
+		 */
+		mmap_read_lock(mm);
+		mutex_lock(&ufile->umap_lock);
+		list_for_each_entry_safe(priv, next_priv, &ufile->umaps, list) {
+			struct vm_area_struct *vma = priv->vma;
+
+			if (vma->vm_mm != mm)
+				continue;
+			list_del_init(&priv->list);
+
+			zap_vma_ptes(vma, vma->vm_start,
+				     vma->vm_end - vma->vm_start);
+
+			if (priv->entry) {
+				rdma_user_mmap_entry_put(priv->entry);
+				priv->entry = NULL;
+			}
+		}
+		mutex_unlock(&ufile->umap_lock);
+		mmap_read_unlock(mm);
+		mmput(mm);
+	}
+}
+EXPORT_SYMBOL(uverbs_user_mmap_disassociate);
+
+/**
+ * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
+ *
+ * @ucontext: associated user context.
+ *
+ * This function should be called by drivers that need to disable mmap for
+ * some ucontexts.
+ */
+void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
+{
+	struct ib_uverbs_file *ufile = ucontext->ufile;
+
+	/* Racing with uverbs_destroy_ufile_hw */
+	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
+		return;
+
+	uverbs_user_mmap_disassociate(ufile);
+	up_read(&ufile->hw_destroy_rwsem);
+}
+EXPORT_SYMBOL(rdma_user_mmap_disassociate);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 33706dad6c0f..ad01fbd52c48 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -149,7 +149,6 @@ void uverbs_disassociate_api(struct uverbs_api *uapi);
 void uverbs_destroy_api(struct uverbs_api *uapi);
 void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 			      unsigned int num_attrs);
-void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bc099287de9a..e7cacbc3fe03 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -45,7 +45,6 @@
 #include <linux/cdev.h>
 #include <linux/anon_inodes.h>
 #include <linux/slab.h>
-#include <linux/sched/mm.h>
 
 #include <linux/uaccess.h>
 
@@ -817,69 +816,6 @@ static const struct vm_operations_struct rdma_umap_ops = {
 	.fault = rdma_umap_fault,
 };
 
-void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
-{
-	struct rdma_umap_priv *priv, *next_priv;
-
-	lockdep_assert_held(&ufile->hw_destroy_rwsem);
-
-	while (1) {
-		struct mm_struct *mm = NULL;
-
-		/* Get an arbitrary mm pointer that hasn't been cleaned yet */
-		mutex_lock(&ufile->umap_lock);
-		while (!list_empty(&ufile->umaps)) {
-			int ret;
-
-			priv = list_first_entry(&ufile->umaps,
-						struct rdma_umap_priv, list);
-			mm = priv->vma->vm_mm;
-			ret = mmget_not_zero(mm);
-			if (!ret) {
-				list_del_init(&priv->list);
-				if (priv->entry) {
-					rdma_user_mmap_entry_put(priv->entry);
-					priv->entry = NULL;
-				}
-				mm = NULL;
-				continue;
-			}
-			break;
-		}
-		mutex_unlock(&ufile->umap_lock);
-		if (!mm)
-			return;
-
-		/*
-		 * The umap_lock is nested under mmap_lock since it used within
-		 * the vma_ops callbacks, so we have to clean the list one mm
-		 * at a time to get the lock ordering right. Typically there
-		 * will only be one mm, so no big deal.
-		 */
-		mmap_read_lock(mm);
-		mutex_lock(&ufile->umap_lock);
-		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
-					  list) {
-			struct vm_area_struct *vma = priv->vma;
-
-			if (vma->vm_mm != mm)
-				continue;
-			list_del_init(&priv->list);
-
-			zap_vma_ptes(vma, vma->vm_start,
-				     vma->vm_end - vma->vm_start);
-
-			if (priv->entry) {
-				rdma_user_mmap_entry_put(priv->entry);
-				priv->entry = NULL;
-			}
-		}
-		mutex_unlock(&ufile->umap_lock);
-		mmap_read_unlock(mm);
-		mmput(mm);
-	}
-}
-
 /*
  * ib_uverbs_open() does not need the BKL:
  *
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6c5712ae559d..4175e3588b77 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2947,6 +2947,7 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      struct rdma_user_mmap_entry *entry,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
+void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext);
 
 static inline int
 rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
@@ -4729,6 +4730,8 @@ struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
 
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
 
+void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
+
 struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
 				     enum rdma_netdev_t type, const char *name,
 				     unsigned char name_assign_type,
-- 
2.33.0


