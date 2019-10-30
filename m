Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CAE9965
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfJ3JrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 05:47:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41642 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbfJ3JrJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Oct 2019 05:47:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9U9iW7q028323;
        Wed, 30 Oct 2019 02:47:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=D00klWLG8S1r+WLwvUTPSp7RkC2R4MfFIRQhRKNjEY8=;
 b=abU13Wmm0/tVRjNZXH0nUd6UbMiM26pIGTcjP1J2vSmB8qEdZ2nrJNP5sPK6wSkIBIV+
 cmuDkQcmaWFndS2Nc9nd66heU4SsmldMRkGOX9BU77Y5O9nvq4cdzKOl6h10B4B3ODXO
 HG07hp8NJJDMV838fygXFweaYihgNW0YLb/F4wZTxpWecy6Q5/ydHTDJAg+aHjufZZ9N
 bN/d4A41H2OuTRdeS/r54AXYC1Snc89BbwwimB/JAU7UXuEvK0vBICh8r++PmH+Zv0jC
 vK4GXYWTjM3OxlAUQAqMGaWvn04gXq8cOPPxiqLFhGQ8DCYCNPdPoOl9ANqNlI9aRpTg lw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vxwjq9ysh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 02:47:03 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 30 Oct
 2019 02:47:01 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 30 Oct 2019 02:47:01 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 1302C3F7041;
        Wed, 30 Oct 2019 02:46:57 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>, <galpress@amazon.com>,
        <yishaih@mellanox.com>, <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [PATCH v12 rdma-next 6/8] RDMA/qedr: Use the common mmap API
Date:   Wed, 30 Oct 2019 11:44:15 +0200
Message-ID: <20191030094417.16866-7-michal.kalderon@marvell.com>
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

Remove all function related to mmap from qedr and use the common
API

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c  |   1 +
 drivers/infiniband/hw/qedr/qedr.h  |  30 +++---
 drivers/infiniband/hw/qedr/verbs.c | 201 ++++++++++++++++++-------------------
 drivers/infiniband/hw/qedr/verbs.h |   3 +-
 4 files changed, 118 insertions(+), 117 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 432dff95a7aa..f7879c5626dc 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -212,6 +212,7 @@ static const struct ib_device_ops qedr_dev_ops = {
 	.get_link_layer = qedr_link_layer,
 	.map_mr_sg = qedr_map_mr_sg,
 	.mmap = qedr_mmap,
+	.mmap_free = qedr_mmap_free,
 	.modify_port = qedr_modify_port,
 	.modify_qp = qedr_modify_qp,
 	.modify_srq = qedr_modify_srq,
diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index f89dafc0dbb8..8486fbfe5032 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -231,14 +231,10 @@ struct qedr_ucontext {
 	struct qedr_dev *dev;
 	struct qedr_pd *pd;
 	void __iomem *dpi_addr;
+	struct rdma_user_mmap_entry *db_mmap_entry;
 	u64 dpi_phys_addr;
 	u32 dpi_size;
 	u16 dpi;
-
-	struct list_head mm_head;
-
-	/* Lock to protect mm list */
-	struct mutex mm_list_lock;
 };
 
 union db_prod64 {
@@ -301,14 +297,6 @@ struct qedr_pd {
 	struct qedr_ucontext *uctx;
 };
 
-struct qedr_mm {
-	struct {
-		u64 phy_addr;
-		unsigned long len;
-	} key;
-	struct list_head entry;
-};
-
 union db_prod32 {
 	struct rdma_pwm_val16_data data;
 	u32 raw;
@@ -492,6 +480,15 @@ struct qedr_mr {
 	u32 npages;
 };
 
+struct qedr_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	struct qedr_dev *dev;
+	u64 io_address;
+	size_t length;
+	u16 dpi;
+	u8 mmap_flag;
+};
+
 #define SET_FIELD2(value, name, flag) ((value) |= ((flag) << (name ## _SHIFT)))
 
 #define QEDR_RESP_IMM	(RDMA_CQE_RESPONDER_IMM_FLG_MASK << \
@@ -590,4 +587,11 @@ static inline struct qedr_srq *get_qedr_srq(struct ib_srq *ibsrq)
 {
 	return container_of(ibsrq, struct qedr_srq, ibsrq);
 }
+
+static inline struct qedr_user_mmap_entry *
+get_qedr_mmap_entry(struct rdma_user_mmap_entry *rdma_entry)
+{
+	return container_of(rdma_entry, struct qedr_user_mmap_entry,
+			    rdma_entry);
+}
 #endif
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 0da977b203e9..87b1ae9c9d4a 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -59,6 +59,10 @@
 
 #define DB_ADDR_SHIFT(addr)		((addr) << DB_PWM_ADDR_OFFSET_SHIFT)
 
+enum {
+	QEDR_USER_MMAP_IO_WC = 0,
+};
+
 static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
 					size_t len)
 {
@@ -257,60 +261,6 @@ int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
 	return 0;
 }
 
-static int qedr_add_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
-			 unsigned long len)
-{
-	struct qedr_mm *mm;
-
-	mm = kzalloc(sizeof(*mm), GFP_KERNEL);
-	if (!mm)
-		return -ENOMEM;
-
-	mm->key.phy_addr = phy_addr;
-	/* This function might be called with a length which is not a multiple
-	 * of PAGE_SIZE, while the mapping is PAGE_SIZE grained and the kernel
-	 * forces this granularity by increasing the requested size if needed.
-	 * When qedr_mmap is called, it will search the list with the updated
-	 * length as a key. To prevent search failures, the length is rounded up
-	 * in advance to PAGE_SIZE.
-	 */
-	mm->key.len = roundup(len, PAGE_SIZE);
-	INIT_LIST_HEAD(&mm->entry);
-
-	mutex_lock(&uctx->mm_list_lock);
-	list_add(&mm->entry, &uctx->mm_head);
-	mutex_unlock(&uctx->mm_list_lock);
-
-	DP_DEBUG(uctx->dev, QEDR_MSG_MISC,
-		 "added (addr=0x%llx,len=0x%lx) for ctx=%p\n",
-		 (unsigned long long)mm->key.phy_addr,
-		 (unsigned long)mm->key.len, uctx);
-
-	return 0;
-}
-
-static bool qedr_search_mmap(struct qedr_ucontext *uctx, u64 phy_addr,
-			     unsigned long len)
-{
-	bool found = false;
-	struct qedr_mm *mm;
-
-	mutex_lock(&uctx->mm_list_lock);
-	list_for_each_entry(mm, &uctx->mm_head, entry) {
-		if (len != mm->key.len || phy_addr != mm->key.phy_addr)
-			continue;
-
-		found = true;
-		break;
-	}
-	mutex_unlock(&uctx->mm_list_lock);
-	DP_DEBUG(uctx->dev, QEDR_MSG_MISC,
-		 "searched for (addr=0x%llx,len=0x%lx) for ctx=%p, result=%d\n",
-		 mm->key.phy_addr, mm->key.len, uctx, found);
-
-	return found;
-}
-
 int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 {
 	struct ib_device *ibdev = uctx->device;
@@ -319,6 +269,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	struct qedr_alloc_ucontext_resp uresp = {};
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_add_user_out_params oparams;
+	struct qedr_user_mmap_entry *entry;
 
 	if (!udata)
 		return -EFAULT;
@@ -335,13 +286,29 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	ctx->dpi_addr = oparams.dpi_addr;
 	ctx->dpi_phys_addr = oparams.dpi_phys_addr;
 	ctx->dpi_size = oparams.dpi_size;
-	INIT_LIST_HEAD(&ctx->mm_head);
-	mutex_init(&ctx->mm_list_lock);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	entry->io_address = ctx->dpi_phys_addr;
+	entry->length = ctx->dpi_size;
+	entry->mmap_flag = QEDR_USER_MMAP_IO_WC;
+	entry->dpi = ctx->dpi;
+	entry->dev = dev;
+	rc = rdma_user_mmap_entry_insert(uctx, &entry->rdma_entry,
+					 ctx->dpi_size);
+	if (rc) {
+		kfree(entry);
+		goto err;
+	}
+	ctx->db_mmap_entry = &entry->rdma_entry;
 
 	uresp.dpm_enabled = dev->user_dpm_enabled;
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
-	uresp.db_pa = ctx->dpi_phys_addr;
+	uresp.db_pa = rdma_user_mmap_get_key(ctx->db_mmap_entry);
 	uresp.db_size = ctx->dpi_size;
 	uresp.max_send_wr = dev->attr.max_sqe;
 	uresp.max_recv_wr = dev->attr.max_rqe;
@@ -353,82 +320,110 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (rc)
-		return rc;
+		goto err;
 
 	ctx->dev = dev;
 
-	rc = qedr_add_mmap(ctx, ctx->dpi_phys_addr, ctx->dpi_size);
-	if (rc)
-		return rc;
-
 	DP_DEBUG(dev, QEDR_MSG_INIT, "Allocating user context %p\n",
 		 &ctx->ibucontext);
 	return 0;
+
+err:
+	if (!ctx->db_mmap_entry)
+		dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
+	else
+		rdma_user_mmap_entry_remove(uctx, ctx->db_mmap_entry);
+
+	return rc;
 }
 
 void qedr_dealloc_ucontext(struct ib_ucontext *ibctx)
 {
 	struct qedr_ucontext *uctx = get_qedr_ucontext(ibctx);
-	struct qedr_mm *mm, *tmp;
 
 	DP_DEBUG(uctx->dev, QEDR_MSG_INIT, "Deallocating user context %p\n",
 		 uctx);
-	uctx->dev->ops->rdma_remove_user(uctx->dev->rdma_ctx, uctx->dpi);
-
-	list_for_each_entry_safe(mm, tmp, &uctx->mm_head, entry) {
-		DP_DEBUG(uctx->dev, QEDR_MSG_MISC,
-			 "deleted (addr=0x%llx,len=0x%lx) for ctx=%p\n",
-			 mm->key.phy_addr, mm->key.len, uctx);
-		list_del(&mm->entry);
-		kfree(mm);
-	}
+
+	rdma_user_mmap_entry_remove(ibctx, uctx->db_mmap_entry);
 }
 
-int qedr_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
+void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 {
-	struct qedr_ucontext *ucontext = get_qedr_ucontext(context);
-	struct qedr_dev *dev = get_qedr_dev(context->device);
-	unsigned long phys_addr = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long len = (vma->vm_end - vma->vm_start);
-	unsigned long dpi_start;
+	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
+	struct qedr_dev *dev = entry->dev;
 
-	dpi_start = dev->db_phys_addr + (ucontext->dpi * ucontext->dpi_size);
+	if (entry->mmap_flag == QEDR_USER_MMAP_IO_WC)
+		dev->ops->rdma_remove_user(dev->rdma_ctx, entry->dpi);
 
-	DP_DEBUG(dev, QEDR_MSG_INIT,
-		 "mmap invoked with vm_start=0x%pK, vm_end=0x%pK,vm_pgoff=0x%pK; dpi_start=0x%pK dpi_size=0x%x\n",
-		 (void *)vma->vm_start, (void *)vma->vm_end,
-		 (void *)vma->vm_pgoff, (void *)dpi_start, ucontext->dpi_size);
+	kfree(entry);
+}
 
-	if ((vma->vm_start & (PAGE_SIZE - 1)) || (len & (PAGE_SIZE - 1))) {
-		DP_ERR(dev,
-		       "failed mmap, addresses must be page aligned: start=0x%pK, end=0x%pK\n",
-		       (void *)vma->vm_start, (void *)vma->vm_end);
+int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
+{
+	struct ib_device *dev = ucontext->device;
+	size_t length = vma->vm_end - vma->vm_start;
+	u64 key = vma->vm_pgoff << PAGE_SHIFT;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct qedr_user_mmap_entry *entry;
+	int rc = 0;
+	u64 pfn;
+
+	ibdev_dbg(dev,
+		  "start %#lx, end %#lx, length = %#zx, key = %#llx\n",
+		  vma->vm_start, vma->vm_end, length, key);
+
+	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
+		ibdev_dbg(dev,
+			  "length[%#zx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
+			  length, PAGE_SIZE, vma->vm_flags);
 		return -EINVAL;
 	}
 
-	if (!qedr_search_mmap(ucontext, phys_addr, len)) {
-		DP_ERR(dev, "failed mmap, vm_pgoff=0x%lx is not authorized\n",
-		       vma->vm_pgoff);
-		return -EINVAL;
+	if (vma->vm_flags & VM_EXEC) {
+		ibdev_dbg(dev, "Mapping executable pages is not permitted\n");
+		return -EPERM;
 	}
+	vma->vm_flags &= ~VM_MAYEXEC;
 
-	if (phys_addr < dpi_start ||
-	    ((phys_addr + len) > (dpi_start + ucontext->dpi_size))) {
-		DP_ERR(dev,
-		       "failed mmap, pages are outside of dpi; page address=0x%pK, dpi_start=0x%pK, dpi_size=0x%x\n",
-		       (void *)phys_addr, (void *)dpi_start,
-		       ucontext->dpi_size);
+	rdma_entry = rdma_user_mmap_entry_get(ucontext, key, vma);
+	if (!rdma_entry) {
+		ibdev_dbg(dev, "key[%#llx] does not have valid entry\n",
+			  key);
 		return -EINVAL;
 	}
+	entry = get_qedr_mmap_entry(rdma_entry);
+	if (entry->length != length) {
+		ibdev_dbg(dev,
+			  "key[%#llx] does not have valid length[%#zx] expected[%#zx]\n",
+			  key, length, entry->length);
+		rc = -EINVAL;
+		goto out;
+	}
 
-	if (vma->vm_flags & VM_READ) {
-		DP_ERR(dev, "failed mmap, cannot map doorbell bar for read\n");
-		return -EINVAL;
+	ibdev_dbg(dev,
+		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
+		  entry->io_address, length, entry->mmap_flag);
+
+	switch (entry->mmap_flag) {
+	case QEDR_USER_MMAP_IO_WC:
+		pfn = entry->io_address >> PAGE_SHIFT;
+		rc = rdma_user_mmap_io(ucontext, vma, pfn, length,
+				       pgprot_writecombine(vma->vm_page_prot),
+				       rdma_entry);
+		break;
+	default:
+		rc = -EINVAL;
 	}
 
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, len,
-				  vma->vm_page_prot);
+	if (rc)
+		ibdev_dbg(dev,
+			  "Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
+			  entry->io_address, length, entry->mmap_flag, rc);
+
+out:
+	rdma_user_mmap_entry_put(ucontext, rdma_entry);
+
+	return rc;
 }
 
 int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9aaa90283d6e..3606e97e95da 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -46,7 +46,8 @@ int qedr_query_pkey(struct ib_device *, u8 port, u16 index, u16 *pkey);
 int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
 void qedr_dealloc_ucontext(struct ib_ucontext *uctx);
 
-int qedr_mmap(struct ib_ucontext *, struct vm_area_struct *vma);
+int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
+void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
-- 
2.14.5

