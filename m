Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8321A7C90
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 09:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfIDHRM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 03:17:12 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:51542 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbfIDHRL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 03:17:11 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x847ExA1014484;
        Wed, 4 Sep 2019 00:17:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=HMx3TPwtlpCG08Zr7DCgQJQq95fgKCfHPEi3Q9uEsn8=;
 b=jeMcapCbfGogIdNTrR7or1iwX0jsrGdlKM+lM6nvICf1OtBbpnFutPs5s+D1T1zX4zMW
 fGdw278gZ0xSY1c0t4FLn2UnRjCJe29a6NZ+vT4xlPXneHovKTw46aOeQRyQb3yY1o+i
 VZvuVqbFPOYAj3j4gEPgc5wzbaUwiOaQXuXif9WxOkrdHWD3wiwGpJTkzhSHpzlEKvgr
 nnNR78n4dv7vC4Wpgv1iiTxngehnfT3U+Rfg7bxWWAvwD0lj9oCNm3nrQOgBXWGz6MSA
 Ydetfjz6kqK1JFweFUl0aZ/5JuTWv3w1WPdltRSmrHHEJlbaye7KZn6Del0WOMawj3uJ IA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmcthc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 00:17:05 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 4 Sep
 2019 00:17:04 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 4 Sep 2019 00:17:03 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 41FD63F7040;
        Wed,  4 Sep 2019 00:17:00 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v10 rdma-next 1/7] RDMA/core: Move core content from ib_uverbs to ib_core
Date:   Wed, 4 Sep 2019 10:15:01 +0300
Message-ID: <20190904071507.8232-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190904071507.8232-1-michal.kalderon@marvell.com>
References: <20190904071507.8232-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_01:2019-09-03,2019-09-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move functionality that is called by the driver, which is
related to umap, to a new file that will be linked in ib_core.
This is a first step in later enabling ib_uverbs to be optional.
vm_ops is now initialized in ib_uverbs_mmap instead of
priv_init to avoid having to move all the rdma_umap functions
as well.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/core/Makefile         |  2 +-
 drivers/infiniband/core/core_priv.h      |  9 ++++
 drivers/infiniband/core/ib_core_uverbs.c | 73 +++++++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_main.c    | 74 ++------------------------------
 4 files changed, 86 insertions(+), 72 deletions(-)
 create mode 100644 drivers/infiniband/core/ib_core_uverbs.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 09881bd5f12d..9a8871e21545 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -11,7 +11,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o counters.o
+				nldev.o restrack.o counters.o ib_core_uverbs.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3a8b0911c3bc..0252da9560f4 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -387,4 +387,13 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet);
 void rdma_nl_net_exit(struct rdma_dev_net *rnet);
+
+struct rdma_umap_priv {
+	struct vm_area_struct *vma;
+	struct list_head list;
+};
+
+void rdma_umap_priv_init(struct rdma_umap_priv *priv,
+			 struct vm_area_struct *vma);
+
 #endif /* _CORE_PRIV_H */
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
new file mode 100644
index 000000000000..b74d2a2fb342
--- /dev/null
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2019 Marvell. All rights reserved.
+ */
+#include <linux/xarray.h>
+#include "uverbs.h"
+#include "core_priv.h"
+
+/*
+ * Each time we map IO memory into user space this keeps track of the mapping.
+ * When the device is hot-unplugged we 'zap' the mmaps in user space to point
+ * to the zero page and allow the hot unplug to proceed.
+ *
+ * This is necessary for cases like PCI physical hot unplug as the actual BAR
+ * memory may vanish after this and access to it from userspace could MCE.
+ *
+ * RDMA drivers supporting disassociation must have their user space designed
+ * to cope in some way with their IO pages going to the zero page.
+ */
+void rdma_umap_priv_init(struct rdma_umap_priv *priv,
+			 struct vm_area_struct *vma)
+{
+	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
+
+	priv->vma = vma;
+	vma->vm_private_data = priv;
+	/* vm_ops is setup in ib_uverbs_mmap() to avoid module dependencies */
+
+	mutex_lock(&ufile->umap_lock);
+	list_add(&priv->list, &ufile->umaps);
+	mutex_unlock(&ufile->umap_lock);
+}
+EXPORT_SYMBOL(rdma_umap_priv_init);
+
+/*
+ * Map IO memory into a process. This is to be called by drivers as part of
+ * their mmap() functions if they wish to send something like PCI-E BAR memory
+ * to userspace.
+ */
+int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
+		      unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	struct ib_uverbs_file *ufile = ucontext->ufile;
+	struct rdma_umap_priv *priv;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (vma->vm_end - vma->vm_start != size)
+		return -EINVAL;
+
+	/* Driver is using this wrong, must be called by ib_uverbs_mmap */
+	if (WARN_ON(!vma->vm_file ||
+		    vma->vm_file->private_data != ufile))
+		return -EINVAL;
+	lockdep_assert_held(&ufile->device->disassociate_srcu);
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	vma->vm_page_prot = prot;
+	if (io_remap_pfn_range(vma, vma->vm_start, pfn, size, prot)) {
+		kfree(priv);
+		return -EAGAIN;
+	}
+
+	rdma_umap_priv_init(priv, vma);
+	return 0;
+}
+EXPORT_SYMBOL(rdma_user_mmap_io);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 02b57240176c..180a5e0f70e4 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -772,6 +772,8 @@ static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
 	return (ret) ? : count;
 }
 
+static const struct vm_operations_struct rdma_umap_ops;
+
 static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct ib_uverbs_file *file = filp->private_data;
@@ -785,45 +787,13 @@ static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
 		ret = PTR_ERR(ucontext);
 		goto out;
 	}
-
+	vma->vm_ops = &rdma_umap_ops;
 	ret = ucontext->device->ops.mmap(ucontext, vma);
 out:
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 	return ret;
 }
 
-/*
- * Each time we map IO memory into user space this keeps track of the mapping.
- * When the device is hot-unplugged we 'zap' the mmaps in user space to point
- * to the zero page and allow the hot unplug to proceed.
- *
- * This is necessary for cases like PCI physical hot unplug as the actual BAR
- * memory may vanish after this and access to it from userspace could MCE.
- *
- * RDMA drivers supporting disassociation must have their user space designed
- * to cope in some way with their IO pages going to the zero page.
- */
-struct rdma_umap_priv {
-	struct vm_area_struct *vma;
-	struct list_head list;
-};
-
-static const struct vm_operations_struct rdma_umap_ops;
-
-static void rdma_umap_priv_init(struct rdma_umap_priv *priv,
-				struct vm_area_struct *vma)
-{
-	struct ib_uverbs_file *ufile = vma->vm_file->private_data;
-
-	priv->vma = vma;
-	vma->vm_private_data = priv;
-	vma->vm_ops = &rdma_umap_ops;
-
-	mutex_lock(&ufile->umap_lock);
-	list_add(&priv->list, &ufile->umaps);
-	mutex_unlock(&ufile->umap_lock);
-}
-
 /*
  * The VMA has been dup'd, initialize the vm_private_data with a new tracking
  * struct
@@ -931,44 +901,6 @@ static const struct vm_operations_struct rdma_umap_ops = {
 	.fault = rdma_umap_fault,
 };
 
-/*
- * Map IO memory into a process. This is to be called by drivers as part of
- * their mmap() functions if they wish to send something like PCI-E BAR memory
- * to userspace.
- */
-int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
-		      unsigned long pfn, unsigned long size, pgprot_t prot)
-{
-	struct ib_uverbs_file *ufile = ucontext->ufile;
-	struct rdma_umap_priv *priv;
-
-	if (!(vma->vm_flags & VM_SHARED))
-		return -EINVAL;
-
-	if (vma->vm_end - vma->vm_start != size)
-		return -EINVAL;
-
-	/* Driver is using this wrong, must be called by ib_uverbs_mmap */
-	if (WARN_ON(!vma->vm_file ||
-		    vma->vm_file->private_data != ufile))
-		return -EINVAL;
-	lockdep_assert_held(&ufile->device->disassociate_srcu);
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	vma->vm_page_prot = prot;
-	if (io_remap_pfn_range(vma, vma->vm_start, pfn, size, prot)) {
-		kfree(priv);
-		return -EAGAIN;
-	}
-
-	rdma_umap_priv_init(priv, vma);
-	return 0;
-}
-EXPORT_SYMBOL(rdma_user_mmap_io);
-
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 {
 	struct rdma_umap_priv *priv, *next_priv;
-- 
2.14.5

