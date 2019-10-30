Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903A1E9963
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3JrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 05:47:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6800 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfJ3JrB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Oct 2019 05:47:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U9jatT017060;
        Wed, 30 Oct 2019 02:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=kHNteMyE6QOlxnoMbsod+xa/x+qJxLmyG383eBhdGUs=;
 b=pHna5ErCdOAY2lnCi/U/Nxq+D4PvR/boptq6CG6Wnp/mUcBpjzoLl69zhCX2cATjtXG1
 POTwTsGzaWGb7Le2KNWQiIc7PRMYpa7YxZuNsI2lENsepP36ltwN9CtVh0fDqSxvvS4X
 Sru0+XBauza5jlQCGEXOg1oeNSoeAOVxzT8pNheIEZi/imeapAcOSq1Z+OnJlMTQRutM
 PdBzxUMJlPB4D9QQ8tWglpgqzh1UxYG/l7FOUg76R+96ot8l7kJVEgpjwzfUf/O8BNKr
 SZ96vv5zBX8yfIcm8o/yVlWfNyolR3+v4QxIxFVE/KZDtQIksp26ejzLWT2iqiLap4Ba kg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vxwjm21x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 02:46:54 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 30 Oct
 2019 02:46:52 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 30 Oct 2019 02:46:52 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 62BF03F703F;
        Wed, 30 Oct 2019 02:46:50 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <galpress@amazon.com>,
        <yishaih@mellanox.com>, <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v12 rdma-next 3/8] RDMA: Connect between the mmap entry and the umap_priv structure
Date:   Wed, 30 Oct 2019 11:44:12 +0200
Message-ID: <20191030094417.16866-4-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191030094417.16866-1-michal.kalderon@marvell.com>
References: <20191030094417.16866-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_04:2019-10-30,2019-10-30 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rdma_user_mmap_io interface created a common interface for drivers
to correctly map hw resources and zap them once the ucontext is
destroyed enabling the drivers to safely free the hw resources.
However, this meant the drivers need to delay freeing the resource
to the ucontext destroy phase to ensure they were no longer mapped.
The new mechanism for a common way of handling user/driver address
mapping enabled notifying the driver if all umap_priv mappings
were removed, and enabled freeing the hw resources when they
are done with and not delay it until ucontext destroy.

Since not all drivers use the mechanism, NULL can be sent to the
rdma_user_mmap_io interface to continue working as before.
Drivers that use the mmap_xa interface can pass the entry being
mapped to the rdma_user_mmap_io function to be linked together.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/core/core_priv.h       |  7 ++++-
 drivers/infiniband/core/ib_core_uverbs.c  | 47 +++++++++++++++++++++++--------
 drivers/infiniband/core/uverbs_main.c     | 14 ++++++++-
 drivers/infiniband/hw/efa/efa_verbs.c     |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c |  6 ++--
 drivers/infiniband/hw/mlx4/main.c         |  9 ++++--
 drivers/infiniband/hw/mlx5/main.c         |  8 ++++--
 include/rdma/ib_verbs.h                   | 13 ++-------
 8 files changed, 76 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 0252da9560f4..355c59d2eaa3 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -391,9 +391,14 @@ void rdma_nl_net_exit(struct rdma_dev_net *rnet);
 struct rdma_umap_priv {
 	struct vm_area_struct *vma;
 	struct list_head list;
+	struct rdma_user_mmap_entry *entry;
 };
 
 void rdma_umap_priv_init(struct rdma_umap_priv *priv,
-			 struct vm_area_struct *vma);
+			 struct vm_area_struct *vma,
+			 struct rdma_user_mmap_entry *entry);
+
+void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
+			      struct rdma_user_mmap_entry *entry);
 
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 1ffc89fd5d94..88d9d47fb8ad 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -8,23 +8,36 @@
 #include "uverbs.h"
 #include "core_priv.h"
 
-/*
- * Each time we map IO memory into user space this keeps track of the mapping.
- * When the device is hot-unplugged we 'zap' the mmaps in user space to point
- * to the zero page and allow the hot unplug to proceed.
+/**
+ * rdma_umap_priv_init() - Initialize the private data of a vma
+ *
+ * @vma: The vm area struct that needs private data
+ * @entry: entry into the mmap_xa that needs to be linked with
+ *       this vma
+ *
+ * Each time we map IO memory into user space this keeps track
+ * of the mapping. When the device is hot-unplugged we 'zap' the
+ * mmaps in user space to point to the zero page and allow the
+ * hot unplug to proceed.
  *
  * This is necessary for cases like PCI physical hot unplug as the actual BAR
  * memory may vanish after this and access to it from userspace could MCE.
  *
  * RDMA drivers supporting disassociation must have their user space designed
  * to cope in some way with their IO pages going to the zero page.
+ *
  */
 void rdma_umap_priv_init(struct rdma_umap_priv *priv,
-			 struct vm_area_struct *vma)
+			 struct vm_area_struct *vma,
+			 struct rdma_user_mmap_entry *entry)
 {
 	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
 
 	priv->vma = vma;
+	if (entry) {
+		kref_get(&entry->ref);
+		priv->entry = entry;
+	}
 	vma->vm_private_data = priv;
 	/* vm_ops is setup in ib_uverbs_mmap() to avoid module dependencies */
 
@@ -34,13 +47,25 @@ void rdma_umap_priv_init(struct rdma_umap_priv *priv,
 }
 EXPORT_SYMBOL(rdma_umap_priv_init);
 
-/*
- * Map IO memory into a process. This is to be called by drivers as part of
- * their mmap() functions if they wish to send something like PCI-E BAR memory
- * to userspace.
+/**
+ * rdma_user_mmap_io() - Map IO memory into a process.
+ *
+ * @ucontext: associated user context
+ * @vma: the vma related to the current mmap call.
+ * @pfn: pfn to map
+ * @size: size to map
+ * @prot: pgprot to use in remap call
+ *
+ * This is to be called by drivers as part of their mmap()
+ * functions if they wish to send something like PCI-E BAR
+ * memory to userspace.
+ *
+ * Return -EINVAL on wrong flags or size, -EAGAIN on failure to
+ * map. 0 on success.
  */
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
-		      unsigned long pfn, unsigned long size, pgprot_t prot)
+		      unsigned long pfn, unsigned long size, pgprot_t prot,
+		      struct rdma_user_mmap_entry *entry)
 {
 	struct ib_uverbs_file *ufile = ucontext->ufile;
 	struct rdma_umap_priv *priv;
@@ -67,7 +92,7 @@ int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		return -EAGAIN;
 	}
 
-	rdma_umap_priv_init(priv, vma);
+	rdma_umap_priv_init(priv, vma, entry);
 	return 0;
 }
 EXPORT_SYMBOL(rdma_user_mmap_io);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index b1f5334ff907..dbe9bd3d389a 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -819,7 +819,7 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		goto out_unlock;
-	rdma_umap_priv_init(priv, vma);
+	rdma_umap_priv_init(priv, vma, opriv->entry);
 
 	up_read(&ufile->hw_destroy_rwsem);
 	return;
@@ -844,6 +844,11 @@ static void rdma_umap_close(struct vm_area_struct *vma)
 	if (!priv)
 		return;
 
+	if (priv->entry) {
+		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
+		priv->entry = NULL;
+	}
+
 	/*
 	 * The vma holds a reference on the struct file that created it, which
 	 * in turn means that the ib_uverbs_file is guaranteed to exist at
@@ -946,6 +951,13 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 
 			if (vma->vm_mm != mm)
 				continue;
+
+			if (priv->entry) {
+				rdma_user_mmap_entry_put(ufile->ucontext,
+							 priv->entry);
+				priv->entry = NULL;
+			}
+
 			list_del_init(&priv->list);
 
 			zap_vma_ptes(vma, vma->vm_start,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 4edae89e8e3c..37e3d62bbb51 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1612,11 +1612,13 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
 	switch (entry->mmap_flag) {
 	case EFA_MMAP_IO_NC:
 		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
-					pgprot_noncached(vma->vm_page_prot));
+					pgprot_noncached(vma->vm_page_prot),
+					NULL);
 		break;
 	case EFA_MMAP_IO_WC:
 		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
-					pgprot_writecombine(vma->vm_page_prot));
+					pgprot_writecombine(vma->vm_page_prot),
+					NULL);
 		break;
 	case EFA_MMAP_DMA_PAGE:
 		for (va = vma->vm_start; va < vma->vm_end;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b5d196c119ee..803dc6f4b496 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -359,7 +359,8 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 		return rdma_user_mmap_io(context, vma,
 					 to_hr_ucontext(context)->uar.pfn,
 					 PAGE_SIZE,
-					 pgprot_noncached(vma->vm_page_prot));
+					 pgprot_noncached(vma->vm_page_prot),
+					 NULL);
 
 	/* vm_pgoff: 1 -- TPTR */
 	case 1:
@@ -372,7 +373,8 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 		return rdma_user_mmap_io(context, vma,
 					 hr_dev->tptr_dma_addr >> PAGE_SHIFT,
 					 hr_dev->tptr_size,
-					 vma->vm_page_prot);
+					 vma->vm_page_prot,
+					 NULL);
 
 	default:
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 8d2f1e38b891..f89b129b7e3a 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1146,7 +1146,8 @@ static int mlx4_ib_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 		return rdma_user_mmap_io(context, vma,
 					 to_mucontext(context)->uar.pfn,
 					 PAGE_SIZE,
-					 pgprot_noncached(vma->vm_page_prot));
+					 pgprot_noncached(vma->vm_page_prot),
+					 NULL);
 
 	case 1:
 		if (dev->dev->caps.bf_reg_size == 0)
@@ -1155,7 +1156,8 @@ static int mlx4_ib_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 			context, vma,
 			to_mucontext(context)->uar.pfn +
 				dev->dev->caps.num_uars,
-			PAGE_SIZE, pgprot_writecombine(vma->vm_page_prot));
+			PAGE_SIZE, pgprot_writecombine(vma->vm_page_prot),
+			NULL);
 
 	case 3: {
 		struct mlx4_clock_params params;
@@ -1171,7 +1173,8 @@ static int mlx4_ib_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 					    params.bar) +
 			 params.offset) >>
 				PAGE_SHIFT,
-			PAGE_SIZE, pgprot_noncached(vma->vm_page_prot));
+			PAGE_SIZE, pgprot_noncached(vma->vm_page_prot),
+			NULL);
 	}
 
 	default:
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b95c2b05f682..eff96303f086 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2168,7 +2168,7 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 	mlx5_ib_dbg(dev, "uar idx 0x%lx, pfn %pa\n", idx, &pfn);
 
 	err = rdma_user_mmap_io(&context->ibucontext, vma, pfn, PAGE_SIZE,
-				prot);
+				prot, NULL);
 	if (err) {
 		mlx5_ib_err(dev,
 			    "rdma_user_mmap_io failed with error=%d, mmap_cmd=%s\n",
@@ -2210,7 +2210,8 @@ static int dm_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	      PAGE_SHIFT) +
 	      page_idx;
 	return rdma_user_mmap_io(context, vma, pfn, map_size,
-				 pgprot_writecombine(vma->vm_page_prot));
+				 pgprot_writecombine(vma->vm_page_prot),
+				 NULL);
 }
 
 static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
@@ -2248,7 +2249,8 @@ static int mlx5_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vm
 			PAGE_SHIFT;
 		return rdma_user_mmap_io(&context->ibucontext, vma, pfn,
 					 PAGE_SIZE,
-					 pgprot_noncached(vma->vm_page_prot));
+					 pgprot_noncached(vma->vm_page_prot),
+					 NULL);
 	case MLX5_IB_MMAP_CLOCK_INFO:
 		return mlx5_ib_mmap_clock_info_page(dev, vma, context);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8a87c9d442bc..456d888be411 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2811,18 +2811,9 @@ void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 void ib_set_device_ops(struct ib_device *device,
 		       const struct ib_device_ops *ops);
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
-		      unsigned long pfn, unsigned long size, pgprot_t prot);
-#else
-static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
-				    struct vm_area_struct *vma,
-				    unsigned long pfn, unsigned long size,
-				    pgprot_t prot)
-{
-	return -EINVAL;
-}
-#endif
+		      unsigned long pfn, unsigned long size, pgprot_t prot,
+		      struct rdma_user_mmap_entry *entry);
 int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 				struct rdma_user_mmap_entry *entry,
 				size_t length);
-- 
2.14.5

