Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BAE9961
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfJ3Jqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 05:46:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35064 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfJ3Jqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Oct 2019 05:46:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U9jEg9010080;
        Wed, 30 Oct 2019 02:46:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=/OsMzp2NbFqzpf2lIrt5XZTHUy36mHeypyBE6RQj+Ow=;
 b=qyS7yPjaFVyAa/Fw7I10+ULjcADBBV1Od9rqBNYoSmnItvGXbU5jmezmpdMAi1VQcVaB
 G9lK37d0PvqADEsXYIHuiSqSJdESaflwn9LI2eFgSGvxII5gUtJFYAg89i4u+uqpQ35n
 jxq7feq8WqZbAy9hgddLt8f4XCmAUNOWOdD2FaP15fh+1ii06o5XwCJzA+ulQuKExa1/
 Skz2MiVtf+1SKc0Lrafx39Z7Bl7WhCuK2srxVBBF8tLNOIafBGROu0+z4kC1HuYlwNCT
 msqqVO3xbQpJJkI4gQHmpGQKgg45uJlMtW2tCfc5h6IP76v9UHrLj8hzKNHA99EvGiQe XA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vxwjm21wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 02:46:48 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 30 Oct
 2019 02:46:47 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 30 Oct 2019 02:46:47 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 7F35F3F703F;
        Wed, 30 Oct 2019 02:46:45 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <galpress@amazon.com>,
        <yishaih@mellanox.com>, <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v12 rdma-next 1/8] RDMA/core: Move core content from ib_uverbs to ib_core
Date:   Wed, 30 Oct 2019 11:44:10 +0200
Message-ID: <20191030094417.16866-2-michal.kalderon@marvell.com>
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
index db98111b47f4..b1f5334ff907 100644
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

