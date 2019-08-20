Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1CA95E40
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHTMUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:20:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34728 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfHTMUr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:47 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KCA3Zd030599;
        Tue, 20 Aug 2019 05:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=q5mA04B5vcEVOK5uiWnLqAHGYVic8f+MKOdvtclgvWg=;
 b=XkzOTNzUwIrwPoiicIXm/T1rDIPKGOupvtWUL9EUhOv4TiFomZB/g7tOVsEV79ewbr2G
 CRcorgKEb63Trqt1tQyF+DU7S6kLqmosfFOhwh117DNSD/Wu/mBMG5ZyjwevCofQJjPs
 9v9GUJOc9XJNm35Sk8JPlLxldpv2601AbaHL9VY6Me0tmQDzj9SxxXwBZiDrt+R48s2J
 GyzILNyMYzNqqJp+EBn1RXsel1h44Ni+vTrXgE5DMr7VHJTesNs3MAyek0nIhaAyA0Qj
 QYcOVCFWNbUnrsVLbJmFKODhgMmbggfHCCmG1rDQ1sKNlPE5dopTDcTWbpIHqKAde1ty SA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ug8d79m9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 05:20:41 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 05:20:39 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 20 Aug 2019 05:20:39 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id A03EB3F703F;
        Tue, 20 Aug 2019 05:20:36 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from ib_uverbs to ib_core
Date:   Tue, 20 Aug 2019 15:18:41 +0300
Message-ID: <20190820121847.25871-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190820121847.25871-1-michal.kalderon@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_04:2019-08-19,2019-08-20 signatures=0
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
 drivers/infiniband/core/Makefile         |   2 +-
 drivers/infiniband/core/core_priv.h      |   9 +++
 drivers/infiniband/core/ib_core_uverbs.c | 100 +++++++++++++++++++++++++++++++
 drivers/infiniband/core/uverbs_main.c    |  74 +----------------------
 4 files changed, 113 insertions(+), 72 deletions(-)
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
index 589ed805e0ad..6850e973401c 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -384,4 +384,13 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 
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
index 000000000000..cab7dc922cf0
--- /dev/null
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
+ * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2019 Marvell. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
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

