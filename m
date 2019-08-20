Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1395E47
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfHTMU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:20:59 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:61718 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729409AbfHTMU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 08:20:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KCBG4u028267;
        Tue, 20 Aug 2019 05:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=ajq7CArU0Sa7HV7YTMOrbsT53XCVsJB0rmktwhDDI/A=;
 b=SPR0WZVpuBmTRASddU8X9TOfXLNinwCBrfgXa1SlpITfRRmQZOhlOjbH8iMLq8MYogyp
 8RoBqDZsQdkJ5BV3xUe05FNdILfaigN1uosNmuxAeAQwFp7fkYTj7qFmqq/QoPdmJcKM
 X7ateXV1daJWEos9veZnAHy7LTdRjcRmeo0Lh/EDWn50xf4fxeuUg+d+PtOuKWXpft0I
 /1Dv+sKEuarE5m5OJ356MnrXzF4rskaoZf1F7EaoOiQmq17sBjLplIXFrv1P0LodLPjv
 /f02nEiz2OcogGpTraJksWKyfBNtHzqp3FnDfsxWO5bcFkXjCpn7ymWjtWeoRP8xyoGL 2A== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ug8a99p19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 05:20:55 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 05:20:54 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 20 Aug 2019 05:20:54 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 3DBE33F7040;
        Tue, 20 Aug 2019 05:20:51 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v7 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Date:   Tue, 20 Aug 2019 15:18:45 +0300
Message-ID: <20190820121847.25871-6-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190820121847.25871-1-michal.kalderon@marvell.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_05:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove all function related to mmap from qedr and use the common
API

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr.h  |  14 +---
 drivers/infiniband/hw/qedr/verbs.c | 157 +++++++++++++------------------------
 drivers/infiniband/hw/qedr/verbs.h |   2 +-
 3 files changed, 57 insertions(+), 116 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 0cfd849b13d6..1e75dc8ad8de 100644
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
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..ea5b56f190f4 100644
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
@@ -334,13 +284,17 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	ctx->dpi_addr = oparams.dpi_addr;
 	ctx->dpi_phys_addr = oparams.dpi_phys_addr;
 	ctx->dpi_size = oparams.dpi_size;
-	INIT_LIST_HEAD(&ctx->mm_head);
-	mutex_init(&ctx->mm_list_lock);
+	ctx->db_key = rdma_user_mmap_entry_insert(uctx, ctx,
+						  ctx->dpi_phys_addr,
+						  ctx->dpi_size,
+						  QEDR_USER_MMAP_IO_WC);
+	if (ctx->db_key == RDMA_USER_MMAP_INVALID)
+		return -ENOMEM;
 
 	uresp.dpm_enabled = dev->user_dpm_enabled;
 	uresp.wids_enabled = 1;
 	uresp.wid_count = oparams.wid_count;
-	uresp.db_pa = ctx->dpi_phys_addr;
+	uresp.db_pa = ctx->db_key;
 	uresp.db_size = ctx->dpi_size;
 	uresp.max_send_wr = dev->attr.max_sqe;
 	uresp.max_recv_wr = dev->attr.max_rqe;
@@ -356,10 +310,6 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 
 	ctx->dev = dev;
 
-	rc = qedr_add_mmap(ctx, ctx->dpi_phys_addr, ctx->dpi_size);
-	if (rc)
-		return rc;
-
 	DP_DEBUG(dev, QEDR_MSG_INIT, "Allocating user context %p\n",
 		 &ctx->ibucontext);
 	return 0;
@@ -368,66 +318,69 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
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
+int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 {
-	struct qedr_ucontext *ucontext = get_qedr_ucontext(context);
-	struct qedr_dev *dev = get_qedr_dev(context->device);
-	unsigned long phys_addr = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long len = (vma->vm_end - vma->vm_start);
-	unsigned long dpi_start;
+	struct ib_device *dev = ucontext->device;
+	u64 length = vma->vm_end - vma->vm_start;
+	u64 key = vma->vm_pgoff << PAGE_SHIFT;
+	struct rdma_user_mmap_entry *entry;
+	u64 pfn;
+	int err;
 
-	dpi_start = dev->db_phys_addr + (ucontext->dpi * ucontext->dpi_size);
-
-	DP_DEBUG(dev, QEDR_MSG_INIT,
-		 "mmap invoked with vm_start=0x%pK, vm_end=0x%pK,vm_pgoff=0x%pK; dpi_start=0x%pK dpi_size=0x%x\n",
-		 (void *)vma->vm_start, (void *)vma->vm_end,
-		 (void *)vma->vm_pgoff, (void *)dpi_start, ucontext->dpi_size);
+	ibdev_dbg(dev,
+		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
+		  vma->vm_start, vma->vm_end, length, key);
 
-	if ((vma->vm_start & (PAGE_SIZE - 1)) || (len & (PAGE_SIZE - 1))) {
-		DP_ERR(dev,
-		       "failed mmap, addresses must be page aligned: start=0x%pK, end=0x%pK\n",
-		       (void *)vma->vm_start, (void *)vma->vm_end);
+	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
+		ibdev_dbg(dev,
+			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
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
+	entry = rdma_user_mmap_entry_get(ucontext, key, length, vma);
+	if (!entry) {
+		ibdev_dbg(dev, "key[%#llx] does not have valid entry\n",
+			  key);
 		return -EINVAL;
 	}
 
-	if (vma->vm_flags & VM_READ) {
-		DP_ERR(dev, "failed mmap, cannot map doorbell bar for read\n");
-		return -EINVAL;
+	ibdev_dbg(dev,
+		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
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
+			  "Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
+			  entry->address, length, entry->mmap_flag, err);
+		rdma_user_mmap_entry_put(ucontext, entry);
 	}
 
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, len,
-				  vma->vm_page_prot);
+	return err;
 }
 
 int qedr_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 9aaa90283d6e..724d0983e972 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -46,7 +46,7 @@ int qedr_query_pkey(struct ib_device *, u8 port, u16 index, u16 *pkey);
 int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
 void qedr_dealloc_ucontext(struct ib_ucontext *uctx);
 
-int qedr_mmap(struct ib_ucontext *, struct vm_area_struct *vma);
+int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
-- 
2.14.5

