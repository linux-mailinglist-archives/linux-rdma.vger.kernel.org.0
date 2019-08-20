Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2F95E48
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfHTMVF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 08:21:05 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:22232 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729409AbfHTMVF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 08:21:05 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KCAxCb028194;
        Tue, 20 Aug 2019 05:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=xcRkAyTfY+qoGiGRUiK245mDpgRUHQ7s3JSE5i0au8I=;
 b=C8jQEfVNJzhTNgw6oeT9ZqHuAlh+QhuabIvivT0+wWkbZrtHdM399smxImWz0d5KzyGT
 uRUaf3C5fu6Sz6Flf8TRKjp9F5KYy0dDnrUrfJjNkuIuKD9WReQGjudOb7Q7D8gBj4X5
 4zoE6etBTrbVacJ8ov+hCc9eUMYk035gUSzotocRoIkVOhn0wfo2vkhuJYaeMhT/K7dw
 KCsSpu+/srpIVyz/Ga4+/qkGbn23yehOoJurI2JYDhPKYvBtQ/R7EaSG5Oxl6dz05Rnj
 waO8Zbos6H2bp4i/xQefUlq55GsyjGVHLo86CCNzfoW2t3wIPIp0Kl7BLNLWFdnt3pAk iA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ug8a99p1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 05:20:59 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 05:20:58 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 20 Aug 2019 05:20:58 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id BDF133F703F;
        Tue, 20 Aug 2019 05:20:54 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
        <sleybo@amazon.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v7 rdma-next 6/7] RDMA/qedr: Add doorbell overflow recovery support
Date:   Tue, 20 Aug 2019 15:18:46 +0300
Message-ID: <20190820121847.25871-7-michal.kalderon@marvell.com>
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

Use the doorbell recovery mechanism to register rdma related doorbells
that will be restored in case there is a doorbell overflow attention.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c  |   1 +
 drivers/infiniband/hw/qedr/qedr.h  |   7 +
 drivers/infiniband/hw/qedr/verbs.c | 308 +++++++++++++++++++++++++++++++------
 drivers/infiniband/hw/qedr/verbs.h |   2 +
 include/uapi/rdma/qedr-abi.h       |  25 +++
 5 files changed, 295 insertions(+), 48 deletions(-)

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
index 1e75dc8ad8de..cef94b3b9d74 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -234,6 +234,7 @@ struct qedr_ucontext {
 	u64 dpi_phys_addr;
 	u32 dpi_size;
 	u16 dpi;
+	bool db_rec;
 };
 
 union db_prod64 {
@@ -261,6 +262,12 @@ struct qedr_userq {
 	struct qedr_pbl *pbl_tbl;
 	u64 buf_addr;
 	size_t buf_len;
+
+	/* doorbell recovery */
+	void __iomem *db_addr;
+	struct qedr_user_db_rec *db_rec_data;
+	u64 db_rec_phys;
+	u64 db_rec_key;
 };
 
 struct qedr_cq {
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index ea5b56f190f4..a5c199ba9c7f 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -60,6 +60,7 @@
 
 enum {
 	QEDR_USER_MMAP_IO_WC = 0,
+	QEDR_USER_MMAP_PHYS_PAGE,
 };
 
 static inline int qedr_ib_copy_to_udata(struct ib_udata *udata, void *src,
@@ -266,12 +267,24 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	int rc;
 	struct qedr_ucontext *ctx = get_qedr_ucontext(uctx);
 	struct qedr_alloc_ucontext_resp uresp = {};
+	struct qedr_alloc_ucontext_req ureq = {};
 	struct qedr_dev *dev = get_qedr_dev(ibdev);
 	struct qed_rdma_add_user_out_params oparams;
 
 	if (!udata)
 		return -EFAULT;
 
+	if (udata->inlen) {
+		rc = ib_copy_from_udata(&ureq, udata,
+					min(sizeof(ureq), udata->inlen));
+		if (rc) {
+			DP_ERR(dev, "Problem copying data from user space\n");
+			return -EFAULT;
+		}
+
+		ctx->db_rec = !!(ureq.context_flags & QEDR_ALLOC_UCTX_DB_REC);
+	}
+
 	rc = dev->ops->rdma_add_user(dev->rdma_ctx, &oparams);
 	if (rc) {
 		DP_ERR(dev,
@@ -326,6 +339,13 @@ void qedr_dealloc_ucontext(struct ib_ucontext *ibctx)
 	uctx->dev->ops->rdma_remove_user(uctx->dev->rdma_ctx, uctx->dpi);
 }
 
+void qedr_mmap_free(struct rdma_user_mmap_entry *entry)
+{
+	/* DMA mapping is already gone, now free the pages */
+	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
+		free_page((unsigned long)phys_to_virt(entry->address));
+}
+
 int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 {
 	struct ib_device *dev = ucontext->device;
@@ -369,6 +389,9 @@ int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 		err = rdma_user_mmap_io(ucontext, vma, pfn, length,
 					pgprot_writecombine(vma->vm_page_prot));
 		break;
+	case QEDR_USER_MMAP_PHYS_PAGE:
+		err = vm_insert_page(vma, vma->vm_start, pfn_to_page(pfn));
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -610,16 +633,48 @@ static void qedr_populate_pbls(struct qedr_dev *dev, struct ib_umem *umem,
 	}
 }
 
+static int qedr_db_recovery_add(struct qedr_dev *dev,
+				void __iomem *db_addr,
+				void *db_data,
+				enum qed_db_rec_width db_width,
+				enum qed_db_rec_space db_space)
+{
+	if (!db_data) {
+		DP_DEBUG(dev, QEDR_MSG_INIT, "avoiding db rec since old lib\n");
+		return 0;
+	}
+
+	return dev->ops->common->db_recovery_add(dev->cdev, db_addr, db_data,
+						 db_width, db_space);
+}
+
+static void qedr_db_recovery_del(struct qedr_dev *dev,
+				 void __iomem *db_addr,
+				 void *db_data)
+{
+	if (!db_data) {
+		DP_DEBUG(dev, QEDR_MSG_INIT, "avoiding db rec since old lib\n");
+		return;
+	}
+
+	/* Ignore return code as there is not much we can do about it. Error
+	 * log will be printed inside.
+	 */
+	dev->ops->common->db_recovery_del(dev->cdev, db_addr, db_data);
+}
+
 static int qedr_copy_cq_uresp(struct qedr_dev *dev,
-			      struct qedr_cq *cq, struct ib_udata *udata)
+			      struct qedr_cq *cq, struct ib_udata *udata,
+			      u32 db_offset)
 {
 	struct qedr_create_cq_uresp uresp;
 	int rc;
 
 	memset(&uresp, 0, sizeof(uresp));
 
-	uresp.db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
+	uresp.db_offset = db_offset;
 	uresp.icid = cq->icid;
+	uresp.db_rec_addr = cq->q.db_rec_key;
 
 	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (rc)
@@ -647,10 +702,45 @@ static inline int qedr_align_cq_entries(int entries)
 	return aligned_size / QEDR_CQE_SIZE;
 }
 
+static int qedr_init_user_db_rec(struct ib_udata *udata,
+				 struct qedr_dev *dev, struct qedr_userq *q,
+				 bool requires_db_rec)
+{
+	struct qedr_ucontext *uctx =
+		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
+					  ibucontext);
+
+	/* Aborting for non doorbell userqueue (SRQ) or non-supporting lib */
+	if (requires_db_rec == 0 || !uctx->db_rec)
+		return 0;
+
+	/* Allocate a page for doorbell recovery, add to mmap ) */
+	q->db_rec_data = (void *)get_zeroed_page(GFP_USER);
+	if (!q->db_rec_data) {
+		DP_ERR(dev,
+		       "get_free_page failed\n");
+		return -ENOMEM;
+	}
+
+	q->db_rec_phys = virt_to_phys(q->db_rec_data);
+	q->db_rec_key = rdma_user_mmap_entry_insert(&uctx->ibucontext, q,
+						    q->db_rec_phys,
+						    PAGE_SIZE,
+						    QEDR_USER_MMAP_PHYS_PAGE);
+	if (q->db_rec_key == RDMA_USER_MMAP_INVALID) {
+		free_page((unsigned long)q->db_rec_data);
+		q->db_rec_data = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static inline int qedr_init_user_queue(struct ib_udata *udata,
 				       struct qedr_dev *dev,
 				       struct qedr_userq *q, u64 buf_addr,
-				       size_t buf_len, int access, int dmasync,
+				       size_t buf_len, bool requires_db_rec,
+				       int access, int dmasync,
 				       int alloc_and_init)
 {
 	u32 fw_pages;
@@ -688,7 +778,8 @@ static inline int qedr_init_user_queue(struct ib_udata *udata,
 		}
 	}
 
-	return 0;
+	/* mmap the user address used to store doorbell data for recovery */
+	return qedr_init_user_db_rec(udata, dev, q, requires_db_rec);
 
 err0:
 	ib_umem_release(q->umem);
@@ -774,6 +865,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	int entries = attr->cqe;
 	struct qedr_cq *cq = get_qedr_cq(ibcq);
 	int chain_entries;
+	u32 db_offset;
 	int page_cnt;
 	u64 pbl_ptr;
 	u16 icid;
@@ -793,8 +885,12 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	chain_entries = qedr_align_cq_entries(entries);
 	chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
 
+	/* calc db offset. user will add DPI base, kernel will add db addr */
+	db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
+
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
+		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
+							 udata->inlen))) {
 			DP_ERR(dev,
 			       "create cq: problem copying data from user space\n");
 			goto err0;
@@ -809,8 +905,9 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->cq_type = QEDR_CQ_TYPE_USER;
 
 		rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
-					  ureq.len, IB_ACCESS_LOCAL_WRITE, 1,
-					  1);
+					  ureq.len, true,
+					  IB_ACCESS_LOCAL_WRITE,
+					  1, 1);
 		if (rc)
 			goto err0;
 
@@ -818,6 +915,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		page_cnt = cq->q.pbl_info.num_pbes;
 
 		cq->ibcq.cqe = chain_entries;
+		cq->q.db_addr = ctx->dpi_addr + db_offset;
 	} else {
 		cq->cq_type = QEDR_CQ_TYPE_KERNEL;
 
@@ -829,7 +927,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 						   sizeof(union rdma_cqe),
 						   &cq->pbl, NULL);
 		if (rc)
-			goto err1;
+			goto err0;
 
 		page_cnt = qed_chain_get_page_cnt(&cq->pbl);
 		pbl_ptr = qed_chain_get_pbl_phys(&cq->pbl);
@@ -841,21 +939,28 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	rc = dev->ops->rdma_create_cq(dev->rdma_ctx, &params, &icid);
 	if (rc)
-		goto err2;
+		goto err1;
 
 	cq->icid = icid;
 	cq->sig = QEDR_CQ_MAGIC_NUMBER;
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		rc = qedr_copy_cq_uresp(dev, cq, udata);
+		rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
+		if (rc)
+			goto err2;
+
+		rc = qedr_db_recovery_add(dev, cq->q.db_addr,
+					  &cq->q.db_rec_data->db_data,
+					  DB_REC_WIDTH_64B,
+					  DB_REC_USER);
 		if (rc)
-			goto err3;
+			goto err2;
+
 	} else {
 		/* Generate doorbell address. */
-		cq->db_addr = dev->db_addr +
-		    DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
 		cq->db.data.icid = cq->icid;
+		cq->db_addr = dev->db_addr + db_offset;
 		cq->db.data.params = DB_AGG_CMD_SET <<
 		    RDMA_PWM_VAL32_DATA_AGG_CMD_SHIFT;
 
@@ -865,6 +970,11 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		cq->latest_cqe = NULL;
 		consume_cqe(cq);
 		cq->cq_cons = qed_chain_get_cons_idx_u32(&cq->pbl);
+
+		rc = qedr_db_recovery_add(dev, cq->db_addr, &cq->db.data,
+					  DB_REC_WIDTH_64B, DB_REC_KERNEL);
+		if (rc)
+			goto err2;
 	}
 
 	DP_DEBUG(dev, QEDR_MSG_CQ,
@@ -873,18 +983,20 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	return 0;
 
-err3:
+err2:
 	destroy_iparams.icid = cq->icid;
 	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &destroy_iparams,
 				  &destroy_oparams);
-err2:
-	if (udata)
-		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
-	else
-		dev->ops->common->chain_free(dev->cdev, &cq->pbl);
 err1:
-	if (udata)
+	if (udata) {
+		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
 		ib_umem_release(cq->q.umem);
+		if (cq->q.db_rec_data)
+			rdma_user_mmap_entry_remove(&ctx->ibucontext,
+						    cq->q.db_rec_key);
+	} else {
+		dev->ops->common->chain_free(dev->cdev, &cq->pbl);
+	}
 err0:
 	return -EINVAL;
 }
@@ -904,6 +1016,8 @@ int qedr_resize_cq(struct ib_cq *ibcq, int new_cnt, struct ib_udata *udata)
 
 void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
+	struct qedr_ucontext *ctx = rdma_udata_to_drv_context(udata,
+		struct qedr_ucontext, ibucontext);
 	struct qedr_dev *dev = get_qedr_dev(ibcq->device);
 	struct qed_rdma_destroy_cq_out_params oparams;
 	struct qed_rdma_destroy_cq_in_params iparams;
@@ -915,8 +1029,10 @@ void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	cq->destroyed = 1;
 
 	/* GSIs CQs are handled by driver, so they don't exist in the FW */
-	if (cq->cq_type == QEDR_CQ_TYPE_GSI)
+	if (cq->cq_type == QEDR_CQ_TYPE_GSI) {
+		qedr_db_recovery_del(dev, cq->db_addr, &cq->db.data);
 		return;
+	}
 
 	iparams.icid = cq->icid;
 	dev->ops->rdma_destroy_cq(dev->rdma_ctx, &iparams, &oparams);
@@ -925,6 +1041,15 @@ void qedr_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	if (udata) {
 		qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
 		ib_umem_release(cq->q.umem);
+
+		if (cq->q.db_rec_data) {
+			qedr_db_recovery_del(dev, cq->q.db_addr,
+					     &cq->q.db_rec_data->db_data);
+			rdma_user_mmap_entry_remove(&ctx->ibucontext,
+						    cq->q.db_rec_key);
+		}
+	} else {
+		qedr_db_recovery_del(dev, cq->db_addr, &cq->db.data);
 	}
 
 	/* We don't want the IRQ handler to handle a non-existing CQ so we
@@ -1089,8 +1214,8 @@ static int qedr_copy_srq_uresp(struct qedr_dev *dev,
 }
 
 static void qedr_copy_rq_uresp(struct qedr_dev *dev,
-			       struct qedr_create_qp_uresp *uresp,
-			       struct qedr_qp *qp)
+			      struct qedr_create_qp_uresp *uresp,
+			      struct qedr_qp *qp)
 {
 	/* iWARP requires two doorbells per RQ. */
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
@@ -1103,6 +1228,7 @@ static void qedr_copy_rq_uresp(struct qedr_dev *dev,
 	}
 
 	uresp->rq_icid = qp->icid;
+	uresp->rq_db_rec_addr = qp->urq.db_rec_key;
 }
 
 static void qedr_copy_sq_uresp(struct qedr_dev *dev,
@@ -1116,22 +1242,24 @@ static void qedr_copy_sq_uresp(struct qedr_dev *dev,
 		uresp->sq_icid = qp->icid;
 	else
 		uresp->sq_icid = qp->icid + 1;
+
+	uresp->sq_db_rec_addr = qp->usq.db_rec_key;
 }
 
 static int qedr_copy_qp_uresp(struct qedr_dev *dev,
-			      struct qedr_qp *qp, struct ib_udata *udata)
+			      struct qedr_qp *qp, struct ib_udata *udata,
+			      struct qedr_create_qp_uresp *uresp)
 {
-	struct qedr_create_qp_uresp uresp;
 	int rc;
 
-	memset(&uresp, 0, sizeof(uresp));
-	qedr_copy_sq_uresp(dev, &uresp, qp);
-	qedr_copy_rq_uresp(dev, &uresp, qp);
+	memset(uresp, 0, sizeof(*uresp));
+	qedr_copy_sq_uresp(dev, uresp, qp);
+	qedr_copy_rq_uresp(dev, uresp, qp);
 
-	uresp.atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
-	uresp.qp_id = qp->qp_id;
+	uresp->atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
+	uresp->qp_id = qp->qp_id;
 
-	rc = qedr_ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	rc = qedr_ib_copy_to_udata(udata, uresp, sizeof(*uresp));
 	if (rc)
 		DP_ERR(dev,
 		       "create qp: failed a copy to user space with qp icid=0x%x.\n",
@@ -1175,16 +1303,35 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 		 qp->sq.max_sges, qp->sq_cq->icid);
 }
 
-static void qedr_set_roce_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
+static int qedr_set_roce_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
 {
+	int rc;
+
 	qp->sq.db = dev->db_addr +
 		    DB_ADDR_SHIFT(DQ_PWM_OFFSET_XCM_RDMA_SQ_PROD);
 	qp->sq.db_data.data.icid = qp->icid + 1;
+	rc = qedr_db_recovery_add(dev, qp->sq.db,
+				  &qp->sq.db_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_KERNEL);
+	if (rc)
+		return rc;
+
 	if (!qp->srq) {
 		qp->rq.db = dev->db_addr +
 			    DB_ADDR_SHIFT(DQ_PWM_OFFSET_TCM_ROCE_RQ_PROD);
 		qp->rq.db_data.data.icid = qp->icid;
+
+		rc = qedr_db_recovery_add(dev, qp->rq.db,
+					  &qp->rq.db_data,
+					  DB_REC_WIDTH_32B,
+					  DB_REC_KERNEL);
+		if (rc)
+			qedr_db_recovery_del(dev, qp->sq.db,
+					     &qp->sq.db_data);
 	}
+
+	return rc;
 }
 
 static int qedr_check_srq_params(struct qedr_dev *dev,
@@ -1238,7 +1385,7 @@ static int qedr_init_srq_user_params(struct ib_udata *udata,
 	int rc;
 
 	rc = qedr_init_user_queue(udata, srq->dev, &srq->usrq, ureq->srq_addr,
-				  ureq->srq_len, access, dmasync, 1);
+				  ureq->srq_len, false, access, dmasync, 1);
 	if (rc)
 		return rc;
 
@@ -1334,7 +1481,8 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	hw_srq->max_sges = init_attr->attr.max_sge;
 
 	if (udata) {
-		if (ib_copy_from_udata(&ureq, udata, sizeof(ureq))) {
+		if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
+							 udata->inlen))) {
 			DP_ERR(dev,
 			       "create srq: problem copying data from user space\n");
 			goto err0;
@@ -1523,13 +1671,29 @@ qedr_iwarp_populate_user_qp(struct qedr_dev *dev,
 			   &qp->urq.pbl_info, FW_PAGE_SHIFT);
 }
 
-static void qedr_cleanup_user(struct qedr_dev *dev, struct qedr_qp *qp)
+static void qedr_cleanup_user(struct qedr_dev *dev,
+			      struct qedr_ucontext *ctx,
+			      struct qedr_qp *qp)
 {
 	ib_umem_release(qp->usq.umem);
 	qp->usq.umem = NULL;
 
 	ib_umem_release(qp->urq.umem);
 	qp->urq.umem = NULL;
+
+	if (qp->usq.db_rec_data) {
+		qedr_db_recovery_del(dev, qp->usq.db_addr,
+				     &qp->usq.db_rec_data->db_data);
+		rdma_user_mmap_entry_remove(&ctx->ibucontext,
+					    qp->usq.db_rec_key);
+	}
+
+	if (qp->urq.db_rec_data) {
+		qedr_db_recovery_del(dev, qp->urq.db_addr,
+				     &qp->urq.db_rec_data->db_data);
+		rdma_user_mmap_entry_remove(&ctx->ibucontext,
+					    qp->urq.db_rec_key);
+	}
 }
 
 static int qedr_create_user_qp(struct qedr_dev *dev,
@@ -1541,12 +1705,14 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	struct qed_rdma_create_qp_in_params in_params;
 	struct qed_rdma_create_qp_out_params out_params;
 	struct qedr_pd *pd = get_qedr_pd(ibpd);
+	struct qedr_create_qp_uresp uresp;
+	struct qedr_ucontext *ctx = NULL;
 	struct qedr_create_qp_ureq ureq;
 	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
 	int rc = -EINVAL;
 
 	memset(&ureq, 0, sizeof(ureq));
-	rc = ib_copy_from_udata(&ureq, udata, sizeof(ureq));
+	rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq), udata->inlen));
 	if (rc) {
 		DP_ERR(dev, "Problem copying data from user space\n");
 		return rc;
@@ -1554,14 +1720,16 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 
 	/* SQ - read access only (0), dma sync not required (0) */
 	rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
-				  ureq.sq_len, 0, 0, alloc_and_init);
+				  ureq.sq_len, true, 0, 0,
+				  alloc_and_init);
 	if (rc)
 		return rc;
 
 	if (!qp->srq) {
 		/* RQ - read access only (0), dma sync not required (0) */
 		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
-					  ureq.rq_len, 0, 0, alloc_and_init);
+					  ureq.rq_len, true,
+					  0, 0, alloc_and_init);
 		if (rc)
 			return rc;
 	}
@@ -1591,29 +1759,56 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	qp->qp_id = out_params.qp_id;
 	qp->icid = out_params.icid;
 
-	rc = qedr_copy_qp_uresp(dev, qp, udata);
+	rc = qedr_copy_qp_uresp(dev, qp, udata, &uresp);
 	if (rc)
 		goto err;
 
+	/* db offset was calculated in copy_qp_uresp, now set in the user q */
+	ctx = pd->uctx;
+	qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
+	qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
+
+	rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
+				  &qp->usq.db_rec_data->db_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_USER);
+	if (rc)
+		goto err;
+
+	rc = qedr_db_recovery_add(dev, qp->urq.db_addr,
+				  &qp->urq.db_rec_data->db_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_USER);
+	if (rc)
+		goto err;
 	qedr_qp_user_print(dev, qp);
 
-	return 0;
+	return rc;
 err:
 	rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
 	if (rc)
 		DP_ERR(dev, "create qp: fatal fault. rc=%d", rc);
 
 err1:
-	qedr_cleanup_user(dev, qp);
+	qedr_cleanup_user(dev, ctx, qp);
 	return rc;
 }
 
-static void qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
+static int qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
 {
+	int rc;
+
 	qp->sq.db = dev->db_addr +
 	    DB_ADDR_SHIFT(DQ_PWM_OFFSET_XCM_RDMA_SQ_PROD);
 	qp->sq.db_data.data.icid = qp->icid;
 
+	rc = qedr_db_recovery_add(dev, qp->sq.db,
+				  &qp->sq.db_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_KERNEL);
+	if (rc)
+		return rc;
+
 	qp->rq.db = dev->db_addr +
 		    DB_ADDR_SHIFT(DQ_PWM_OFFSET_TCM_IWARP_RQ_PROD);
 	qp->rq.db_data.data.icid = qp->icid;
@@ -1621,6 +1816,13 @@ static void qedr_set_iwarp_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
 			   DB_ADDR_SHIFT(DQ_PWM_OFFSET_TCM_FLAGS);
 	qp->rq.iwarp_db2_data.data.icid = qp->icid;
 	qp->rq.iwarp_db2_data.data.value = DQ_TCM_IWARP_POST_RQ_CF_CMD;
+
+	rc = qedr_db_recovery_add(dev, qp->rq.db,
+				  &qp->rq.db_data,
+				  DB_REC_WIDTH_32B,
+				  DB_REC_KERNEL);
+
+	return rc;
 }
 
 static int
@@ -1668,8 +1870,7 @@ qedr_roce_create_kernel_qp(struct qedr_dev *dev,
 	qp->qp_id = out_params.qp_id;
 	qp->icid = out_params.icid;
 
-	qedr_set_roce_db_info(dev, qp);
-	return rc;
+	return qedr_set_roce_db_info(dev, qp);
 }
 
 static int
@@ -1727,8 +1928,7 @@ qedr_iwarp_create_kernel_qp(struct qedr_dev *dev,
 	qp->qp_id = out_params.qp_id;
 	qp->icid = out_params.icid;
 
-	qedr_set_iwarp_db_info(dev, qp);
-	return rc;
+	return qedr_set_iwarp_db_info(dev, qp);
 
 err:
 	dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
@@ -1743,6 +1943,15 @@ static void qedr_cleanup_kernel(struct qedr_dev *dev, struct qedr_qp *qp)
 
 	dev->ops->common->chain_free(dev->cdev, &qp->rq.pbl);
 	kfree(qp->rqe_wr_id);
+
+	/* GSI qp is not registered to db mechanism so no need to delete */
+	if (qp->qp_type == IB_QPT_GSI)
+		return;
+
+	qedr_db_recovery_del(dev, qp->sq.db, &qp->sq.db_data);
+
+	if (!qp->srq)
+		qedr_db_recovery_del(dev, qp->rq.db, &qp->rq.db_data);
 }
 
 static int qedr_create_kernel_qp(struct qedr_dev *dev,
@@ -2382,7 +2591,10 @@ int qedr_query_qp(struct ib_qp *ibqp,
 static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
 				  struct ib_udata *udata)
 {
-	int rc = 0;
+	struct qedr_ucontext *ctx =
+		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
+					  ibucontext);
+	int rc;
 
 	if (qp->qp_type != IB_QPT_GSI) {
 		rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
@@ -2391,7 +2603,7 @@ static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
 	}
 
 	if (udata)
-		qedr_cleanup_user(dev, qp);
+		qedr_cleanup_user(dev, ctx, qp);
 	else
 		qedr_cleanup_kernel(dev, qp);
 
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 724d0983e972..830c86561e23 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -47,6 +47,8 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
 void qedr_dealloc_ucontext(struct ib_ucontext *uctx);
 
 int qedr_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
+void qedr_mmap_free(struct rdma_user_mmap_entry *entry);
+
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index 7a10b3a325fa..c022ee26089b 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -38,6 +38,15 @@
 #define QEDR_ABI_VERSION		(8)
 
 /* user kernel communication data structures. */
+enum qedr_alloc_ucontext_flags {
+	QEDR_ALLOC_UCTX_RESERVED	= 1 << 0,
+	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1
+};
+
+struct qedr_alloc_ucontext_req {
+	__u32 context_flags;
+	__u32 reserved;
+};
 
 struct qedr_alloc_ucontext_resp {
 	__aligned_u64 db_pa;
@@ -74,6 +83,7 @@ struct qedr_create_cq_uresp {
 	__u32 db_offset;
 	__u16 icid;
 	__u16 reserved;
+	__aligned_u64 db_rec_addr;
 };
 
 struct qedr_create_qp_ureq {
@@ -109,6 +119,13 @@ struct qedr_create_qp_uresp {
 
 	__u32 rq_db2_offset;
 	__u32 reserved;
+
+	/* address of SQ doorbell recovery user entry */
+	__aligned_u64 sq_db_rec_addr;
+
+	/* address of RQ doorbell recovery user entry */
+	__aligned_u64 rq_db_rec_addr;
+
 };
 
 struct qedr_create_srq_ureq {
@@ -128,4 +145,12 @@ struct qedr_create_srq_uresp {
 	__u32 reserved1;
 };
 
+/* doorbell recovery entry allocated and populated by userspace doorbelling
+ * entities and mapped to kernel. Kernel uses this to register doorbell
+ * information with doorbell drop recovery mechanism.
+ */
+struct qedr_user_db_rec {
+	__aligned_u64 db_data; /* doorbell data */
+};
+
 #endif /* __QEDR_USER_H__ */
-- 
2.14.5

