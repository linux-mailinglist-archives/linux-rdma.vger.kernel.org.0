Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89B658409
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF0OAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:00:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:18798 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726431AbfF0OAW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:00:22 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDtlDt001955;
        Thu, 27 Jun 2019 07:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=xN9bBEnzYvemufnN/YcDa/7UFbm1mfhrA5PVXdqJGQs=;
 b=Vp6XwazYBIba7JdJyMbu6J0NJeZu0OiPWjWf2KetLDXVYIUatB04cWRijrWurxHKxiCe
 EThzYeCJKoWjYMV0a93yl6qw3VB+PbuHp/XR/jJD/ndG4J0UgTpuyz1t0uyl7Z2w+Slw
 ywHhrA9CW5rfVMeLofjV4f+TdAVfjj8F0QQz2Po2u1MMeVb5ZBehaOLTnOWbglPCGsvb
 Yyrf4eMd2g7sf6/GHPv4hoZcG5DpJ+NrRN/go+DprMXseBcKvDtVJIb2c0pu99Y69QmP
 DTp6Y4RvwBRooboQhbRjsDRNMb5aebldEHC3U8XVaLwc9G3KnkX/7DpbeeqThqlIVEJt CA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tcvrs8kdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 07:00:00 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 06:59:59 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 27 Jun 2019 06:59:59 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 4F7DE3F7040;
        Thu, 27 Jun 2019 06:59:57 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <galpress@amazon.com>, <jgg@ziepe.ca>, <dledford@redhat.com>,
        <leon@kernel.org>, <sleybo@amazon.com>,
        <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [RFC rdma 2/3] RDMA/efa: Use the common mmap API
Date:   Thu, 27 Jun 2019 16:58:24 +0300
Message-ID: <20190627135825.4924-3-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190627135825.4924-1-michal.kalderon@marvell.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_08:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the mmap API which was copied to the ib_core and use
the common API's instead

Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/efa/efa.h       |   2 -
 drivers/infiniband/hw/efa/efa_main.c  |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c | 248 +++++-----------------------------
 3 files changed, 32 insertions(+), 220 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 119f8efec564..a7adbf246b4d 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -71,8 +71,6 @@ struct efa_dev {
 
 struct efa_ucontext {
 	struct ib_ucontext ibucontext;
-	struct xarray mmap_xa;
-	u32 mmap_xa_page;
 	u16 uarn;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index dd1c6d49466f..ef18ea1aa63e 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -214,7 +214,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.destroy_qp = efa_destroy_qp,
 	.get_link_layer = efa_port_link_layer,
 	.get_port_immutable = efa_get_port_immutable,
-	.mmap = efa_mmap,
+	.mmap = rdma_user_mmap,
 	.modify_qp = efa_modify_qp,
 	.query_device = efa_query_device,
 	.query_gid = efa_query_gid,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7b4e0fa99817..c8a3ed556f7c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -13,34 +13,10 @@
 
 #include "efa.h"
 
-#define EFA_MMAP_FLAG_SHIFT 56
-#define EFA_MMAP_PAGE_MASK GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
-#define EFA_MMAP_INVALID U64_MAX
-
-enum {
-	EFA_MMAP_DMA_PAGE = 0,
-	EFA_MMAP_IO_WC,
-	EFA_MMAP_IO_NC,
-};
-
 #define EFA_AENQ_ENABLED_GROUPS \
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
 
-struct efa_mmap_entry {
-	void  *obj;
-	u64 address;
-	u64 length;
-	u32 mmap_page;
-	u8 mmap_flag;
-};
-
-static inline u64 get_mmap_key(const struct efa_mmap_entry *efa)
-{
-	return ((u64)efa->mmap_flag << EFA_MMAP_FLAG_SHIFT) |
-	       ((u64)efa->mmap_page << PAGE_SHIFT);
-}
-
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
 #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
 #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
@@ -145,95 +121,6 @@ static void *efa_zalloc_mapped(struct efa_dev *dev, dma_addr_t *dma_addr,
 	return addr;
 }
 
-/*
- * This is only called when the ucontext is destroyed and there can be no
- * concurrent query via mmap or allocate on the xarray, thus we can be sure no
- * other thread is using the entry pointer. We also know that all the BAR
- * pages have either been zap'd or munmaped at this point.  Normal pages are
- * refcounted and will be freed at the proper time.
- */
-static void mmap_entries_remove_free(struct efa_dev *dev,
-				     struct efa_ucontext *ucontext)
-{
-	struct efa_mmap_entry *entry;
-	unsigned long mmap_page;
-
-	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
-		xa_erase(&ucontext->mmap_xa, mmap_page);
-
-		ibdev_dbg(
-			&dev->ibdev,
-			"mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-			entry->obj, get_mmap_key(entry), entry->address,
-			entry->length);
-		if (entry->mmap_flag == EFA_MMAP_DMA_PAGE)
-			/* DMA mapping is already gone, now free the pages */
-			free_pages_exact(phys_to_virt(entry->address),
-					 entry->length);
-		kfree(entry);
-	}
-}
-
-static struct efa_mmap_entry *mmap_entry_get(struct efa_dev *dev,
-					     struct efa_ucontext *ucontext,
-					     u64 key, u64 len)
-{
-	struct efa_mmap_entry *entry;
-	u64 mmap_page;
-
-	mmap_page = (key & EFA_MMAP_PAGE_MASK) >> PAGE_SHIFT;
-	if (mmap_page > U32_MAX)
-		return NULL;
-
-	entry = xa_load(&ucontext->mmap_xa, mmap_page);
-	if (!entry || get_mmap_key(entry) != key || entry->length != len)
-		return NULL;
-
-	ibdev_dbg(&dev->ibdev,
-		  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx] removed\n",
-		  entry->obj, key, entry->address, entry->length);
-
-	return entry;
-}
-
-/*
- * Note this locking scheme cannot support removal of entries, except during
- * ucontext destruction when the core code guarentees no concurrency.
- */
-static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
-			     void *obj, u64 address, u64 length, u8 mmap_flag)
-{
-	struct efa_mmap_entry *entry;
-	int err;
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return EFA_MMAP_INVALID;
-
-	entry->obj = obj;
-	entry->address = address;
-	entry->length = length;
-	entry->mmap_flag = mmap_flag;
-
-	xa_lock(&ucontext->mmap_xa);
-	entry->mmap_page = ucontext->mmap_xa_page;
-	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
-	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
-			  GFP_KERNEL);
-	xa_unlock(&ucontext->mmap_xa);
-	if (err){
-		kfree(entry);
-		return EFA_MMAP_INVALID;
-	}
-
-	ibdev_dbg(
-		&dev->ibdev,
-		"mmap: obj[0x%p] addr[%#llx], len[%#llx], key[%#llx] inserted\n",
-		entry->obj, entry->address, entry->length, get_mmap_key(entry));
-
-	return get_mmap_key(entry);
-}
-
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata)
@@ -477,45 +364,52 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 				 struct efa_com_create_qp_params *params,
 				 struct efa_ibv_create_qp_resp *resp)
 {
+	u64 address;
+	u64 length;
 	/*
 	 * Once an entry is inserted it might be mmapped, hence cannot be
 	 * cleaned up until dealloc_ucontext.
 	 */
 	resp->sq_db_mmap_key =
-		mmap_entry_insert(dev, ucontext, qp,
-				  dev->db_bar_addr + resp->sq_db_offset,
-				  PAGE_SIZE, EFA_MMAP_IO_NC);
-	if (resp->sq_db_mmap_key == EFA_MMAP_INVALID)
+		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
+					    dev->db_bar_addr +
+					    resp->sq_db_offset,
+					    PAGE_SIZE, RDMA_USER_MMAP_IO_NC);
+	if (resp->sq_db_mmap_key == RDMA_USER_MMAP_INVALID)
 		return -ENOMEM;
 
 	resp->sq_db_offset &= ~PAGE_MASK;
 
+	address = dev->mem_bar_addr + resp->llq_desc_offset;
+	length = PAGE_ALIGN(params->sq_ring_size_in_bytes +
+			    (resp->llq_desc_offset & ~PAGE_MASK));
 	resp->llq_desc_mmap_key =
-		mmap_entry_insert(dev, ucontext, qp,
-				  dev->mem_bar_addr + resp->llq_desc_offset,
-				  PAGE_ALIGN(params->sq_ring_size_in_bytes +
-					     (resp->llq_desc_offset & ~PAGE_MASK)),
-				  EFA_MMAP_IO_WC);
-	if (resp->llq_desc_mmap_key == EFA_MMAP_INVALID)
+		rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
+					    address,
+					    length,
+					    RDMA_USER_MMAP_IO_WC);
+	if (resp->llq_desc_mmap_key == RDMA_USER_MMAP_INVALID)
 		return -ENOMEM;
 
 	resp->llq_desc_offset &= ~PAGE_MASK;
 
 	if (qp->rq_size) {
+		address = dev->db_bar_addr + resp->rq_db_offset;
 		resp->rq_db_mmap_key =
-			mmap_entry_insert(dev, ucontext, qp,
-					  dev->db_bar_addr + resp->rq_db_offset,
-					  PAGE_SIZE, EFA_MMAP_IO_NC);
-		if (resp->rq_db_mmap_key == EFA_MMAP_INVALID)
+			rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
+						    address, PAGE_SIZE,
+						    RDMA_USER_MMAP_IO_NC);
+		if (resp->rq_db_mmap_key == RDMA_USER_MMAP_INVALID)
 			return -ENOMEM;
 
 		resp->rq_db_offset &= ~PAGE_MASK;
 
+		address = virt_to_phys(qp->rq_cpu_addr);
 		resp->rq_mmap_key =
-			mmap_entry_insert(dev, ucontext, qp,
-					  virt_to_phys(qp->rq_cpu_addr),
-					  qp->rq_size, EFA_MMAP_DMA_PAGE);
-		if (resp->rq_mmap_key == EFA_MMAP_INVALID)
+			rdma_user_mmap_entry_insert(&ucontext->ibucontext, qp,
+						    address, qp->rq_size,
+						    RDMA_USER_MMAP_DMA_PAGE);
+		if (resp->rq_mmap_key == RDMA_USER_MMAP_INVALID)
 			return -ENOMEM;
 
 		resp->rq_mmap_size = qp->rq_size;
@@ -864,11 +758,13 @@ void efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
 				 struct efa_ibv_create_cq_resp *resp)
 {
+	struct efa_ucontext *ucontext = cq->ucontext;
 	resp->q_mmap_size = cq->size;
-	resp->q_mmap_key = mmap_entry_insert(dev, cq->ucontext, cq,
-					     virt_to_phys(cq->cpu_addr),
-					     cq->size, EFA_MMAP_DMA_PAGE);
-	if (resp->q_mmap_key == EFA_MMAP_INVALID)
+	resp->q_mmap_key =
+		rdma_user_mmap_entry_insert(&ucontext->ibucontext, cq,
+					    virt_to_phys(cq->cpu_addr),
+					    cq->size, RDMA_USER_MMAP_DMA_PAGE);
+	if (resp->q_mmap_key == RDMA_USER_MMAP_INVALID)
 		return -ENOMEM;
 
 	return 0;
@@ -1520,7 +1416,6 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 
 	ucontext->uarn = result.uarn;
-	xa_init(&ucontext->mmap_xa);
 
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
 	resp.cmds_supp_udata_mask |= EFA_USER_CMDS_SUPP_UDATA_CREATE_AH;
@@ -1549,90 +1444,9 @@ void efa_dealloc_ucontext(struct ib_ucontext *ibucontext)
 	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
 	struct efa_dev *dev = to_edev(ibucontext->device);
 
-	mmap_entries_remove_free(dev, ucontext);
 	efa_dealloc_uar(dev, ucontext->uarn);
 }
 
-static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
-		      struct vm_area_struct *vma, u64 key, u64 length)
-{
-	struct efa_mmap_entry *entry;
-	unsigned long va;
-	u64 pfn;
-	int err;
-
-	entry = mmap_entry_get(dev, ucontext, key, length);
-	if (!entry) {
-		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid entry\n",
-			  key);
-		return -EINVAL;
-	}
-
-	ibdev_dbg(&dev->ibdev,
-		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
-		  entry->address, length, entry->mmap_flag);
-
-	pfn = entry->address >> PAGE_SHIFT;
-	switch (entry->mmap_flag) {
-	case EFA_MMAP_IO_NC:
-		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
-					pgprot_noncached(vma->vm_page_prot));
-		break;
-	case EFA_MMAP_IO_WC:
-		err = rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
-					pgprot_writecombine(vma->vm_page_prot));
-		break;
-	case EFA_MMAP_DMA_PAGE:
-		for (va = vma->vm_start; va < vma->vm_end;
-		     va += PAGE_SIZE, pfn++) {
-			err = vm_insert_page(vma, va, pfn_to_page(pfn));
-			if (err)
-				break;
-		}
-		break;
-	default:
-		err = -EINVAL;
-	}
-
-	if (err) {
-		ibdev_dbg(
-			&dev->ibdev,
-			"Couldn't mmap address[%#llx] length[%#llx] mmap_flag[%d] err[%d]\n",
-			entry->address, length, entry->mmap_flag, err);
-		return err;
-	}
-
-	return 0;
-}
-
-int efa_mmap(struct ib_ucontext *ibucontext,
-	     struct vm_area_struct *vma)
-{
-	struct efa_ucontext *ucontext = to_eucontext(ibucontext);
-	struct efa_dev *dev = to_edev(ibucontext->device);
-	u64 length = vma->vm_end - vma->vm_start;
-	u64 key = vma->vm_pgoff << PAGE_SHIFT;
-
-	ibdev_dbg(&dev->ibdev,
-		  "start %#lx, end %#lx, length = %#llx, key = %#llx\n",
-		  vma->vm_start, vma->vm_end, length, key);
-
-	if (length % PAGE_SIZE != 0 || !(vma->vm_flags & VM_SHARED)) {
-		ibdev_dbg(&dev->ibdev,
-			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not set [%#lx]\n",
-			  length, PAGE_SIZE, vma->vm_flags);
-		return -EINVAL;
-	}
-
-	if (vma->vm_flags & VM_EXEC) {
-		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
-		return -EPERM;
-	}
-	vma->vm_flags &= ~VM_MAYEXEC;
-
-	return __efa_mmap(dev, ucontext, vma, key, length);
-}
-
 static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
 {
 	struct efa_com_destroy_ah_params params = {
-- 
2.14.5

