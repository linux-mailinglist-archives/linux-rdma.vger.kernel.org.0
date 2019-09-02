Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE81A5B4B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfIBQZg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 12:25:36 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30280 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfIBQZg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 12:25:36 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82GPTdA003048;
        Mon, 2 Sep 2019 09:25:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=iXpNzNe949NOhQ7YFyb2ERjHQ3Nli05o1IluebkZEms=;
 b=ZwUYsz5r7bhd7d6utCV7PQ342G7GBtrpHo3a9oP20uT46HVG9iP85vl+g/YH+evaEOMC
 VJ8/jinNEZJAWSqfO83iKiLH8qt0F/tP1AyUYOdsvDVeKuham5v7Dp7k25gL8eWJuUk/
 F95NYZIl4DpTV/zGOSNPyyPcckSiQyn/sSmwgXQWAwOPLKTjPDJ8+HxWkVObFZse3n0h
 GAzcFktU2OTu1BylFpzhvoZYrquay/jkvp04SVW7I5Df7GUiDhtwYqreoVdfY2TEm4et
 uL9GjI8cEBBYmaTkVro4A2IJFk9+Z+UQynkeNr5H42xGzB/iA8qAm3jg0ZUOroJu7PEw xg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdm6jt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Sep 2019 09:25:29 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 2 Sep
 2019 09:25:23 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 2 Sep 2019 09:25:23 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id F15133F7041;
        Mon,  2 Sep 2019 09:25:19 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v9 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Date:   Mon, 2 Sep 2019 19:23:12 +0300
Message-ID: <20190902162314.17508-6-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190902162314.17508-1-michal.kalderon@marvell.com>
References: <20190902162314.17508-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_06:2019-08-29,2019-09-02 signatures=0
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
 drivers/infiniband/hw/qedr/qedr.h  |  28 +++---
 drivers/infiniband/hw/qedr/verbs.c | 196 ++++++++++++++++++-------------------
 drivers/infiniband/hw/qedr/verbs.h |   3 +-
 4 files changed, 111 insertions(+), 117 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..aab269602284 100644
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
index 0cfd849b13d6..f273906fca19 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -230,14 +230,10 @@ struct qedr_ucontext {
 	struct qedr_dev *dev;
 	struct qedr_pd *pd;
 	void __iomem *dpi_addr;
+	u64 db_key;
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
@@ -300,14 +296,6 @@ struct qedr_pd {
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
@@ -476,6 +464,13 @@ struct qedr_mr {
 	u32 npages;
 };
 
+struct qedr_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 address;
+	size_t length;
+	u8 mmap_flag;
+};
+
 #define SET_FIELD2(value, name, flag) ((value) |= ((flag) << (name ## _SHIFT)))
 
 #define QEDR_RESP_IMM	(RDMA_CQE_RESPONDER_IMM_FLG_MASK << \
@@ -574,4 +569,11 @@ static inline struct qedr_srq *get_qedr_srq(struct ib_srq *ibsrq)
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
index 6f3ce86019b7..b796ce2c78bc 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -58,6 +58,10 @@
 
 #define DB_ADDR_SHIFT(addr)		((addr) << DB_PWM_ADDR_OFFSET_SHIFT)
 
+enum {
+	QEDR_USER_MMAP_IO_WC = 0,
+};
+
 static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
 					size_t len)
 {
@@ -256,60 +260,6 @@ int qedr_modify_port(struct ib_device *ibdev, u8 port, int mask,
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
@@ -318,6 +268,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	struct qedr_alloc_ucontext_resp uresp = {};
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_add_user_out_params oparams;
+	struct qedr_user_mmap_entry *entry;
 
 	if (!udata)
 		return -EFAULT;
@@ -334,13 +285,27 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
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
+	entry->address = ctx->dpi_phys_addr;
+	entry->length = ctx->dpi_size;
+	entry->mmap_flag = QEDR_USER_MMAP_IO_WC;
+	ctx->db_key = rdma_user_mmap_entry_insert(uctx, &entry->rdma_entry,
+						  ctx->dpi_size);
+	if (ctx->db_key == RDMA_USER_MMAP_INVALID) {
+		rc = -ENOMEM;
+		kfree(entry);
+		goto err;
+	}
 
 	uresp.dpm_enabled = dev->user_dpm_enabled;
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
-	uresp.db_pa = ctx->dpi_phys_addr;
+	uresp.db_pa = ctx->db_key;
 	uresp.db_size = ctx->dpi_size;
 	uresp.max_send_wr = dev->attr.max_sqe;
 	uresp.max_recv_wr = dev->attr.max_rqe;
@@ -352,82 +317,107 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (rc)
-		return rc;
+		goto err1;
 
 	ctx->dev = dev;
 
-	rc = qedr_add_mmap(ctx, ctx->dpi_phys_addr, ctx->dpi_size);
-	if (rc)
-		return rc;
-
 	DP_DEBUG(dev, QEDR_MSG_INIT, "Allocating user context %p\n",
 		 &ctx->ibucontext);
 	return 0;
+
+err1:
+	rdma_user_mmap_entry_remove(uctx, ctx->db_key);
+err:
+	dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
+	return rc;
 }
 
 void qedr_dealloc_ucontext(struct ib_ucontext *ibctx)
 {
 	struct qedr_ucontext *uctx = get_qedr_ucontext(ibctx);
-	struct qedr_mm *mm, *tmp;
 
 	DP_DEBUG(uctx->dev, QEDR_MSG_INIT, "Deallocating user context %p\n",
 		 uctx);
-	uctx->dev->ops->rdma_remove_user(uctx->dev->rdma_ctx, uctx->dpi);
 
-	list_for_each_entry_safe(mm, tmp, &uctx->mm_head, entry) {
-		DP_DEBUG(uctx->dev, QEDR_MSG_MISC,
-			 "deleted (addr=0x%llx,len=0x%lx) for ctx=%p\n",
-			 mm->key.phy_addr, mm->key.len, uctx);
-		list_del(&mm->entry);
-		kfree(mm);
-	}
+	rdma_user_mmap_entry_remove(ibctx, uctx->db_key);
+	uctx->dev->ops->rdma_remove_user(uctx->dev->rdma_ctx, uctx->dpi);
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
 
-	dpi_start = dev->db_phys_addr + (ucontext->dpi * ucontext->dpi_size);
-
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
+	u64 pfn;
+	int err;
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
+	rdma_entry = rdma_user_mmap_entry_get(ucontext, key, length, vma);
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
+		err = -EINVAL;
+		goto err;
+	}
 
-	if (vma->vm_flags & VM_READ) {
-		DP_ERR(dev, "failed mmap, cannot map doorbell bar for read\n");
-		return -EINVAL;
+	ibdev_dbg(dev,
+		  "Mapping address[%#llx], length[%#zx], mmap_flag[%d]\n",
+		  entry->address, length, entry->mmap_flag);
+
+	pfn = entry->address >> PAGE_SHIFT;
+	switch (entry->mmap_flag) {
+	case QEDR_USER_MMAP_IO_WC:
+		err = rdma_user_mmap_io(ucontext, vma, pfn, length,
+					pgprot_writecombine(vma->vm_page_prot));
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (err) {
+		ibdev_dbg(dev,
+			  "Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
+			  entry->address, length, entry->mmap_flag, err);
+		goto err;
 	}
 
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, len,
-				  vma->vm_page_prot);
+	return 0;
+
+err:
+	rdma_user_mmap_entry_put(ucontext, rdma_entry);
+	return err;
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

