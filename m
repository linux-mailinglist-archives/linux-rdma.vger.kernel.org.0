Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6022974F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgGVLXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 07:23:40 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgGVLXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jul 2020 07:23:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MBKuln022237;
        Wed, 22 Jul 2020 04:23:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Hu/y/tgDj0Z5k33wfdBkDHNbHppIP8rxZCz9dsDDyrA=;
 b=jfd30I1D2Q3fLzoZUEFvR2UyZ/RBlncAgYXq+X01WqJ5JBjWZx4Oiib81drEkgHaw/OU
 6qS3gdjbG1tl9LJ58ASalBGtFbNXkkVu9Erk5DSsvk0GYZCPuJX1jztXXtuu2iAU9jpe
 1St2sC6ULuOYwYT3uSSs2PEpXjBgMAwvsC0/ZX+rnaZMR9ipOVBc9IAV7byBAWWcpoTb
 QomXF93yTm8upizkfqWMDvng+VNGfv/tb7/oa1Wh6VphN4V5qEx9MClnluLnh7u6YzWe
 CK5la2lHEP5JeCSg7EBbPdZnt7ue+nc6xm11sGniDLeSFJZoSfA4/9q34HTufqsW+Z6W QA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 32c0kkqjnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 04:23:33 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 04:23:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 04:23:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 04:23:30 -0700
Received: from lb-tlvb-ybason.il.qlogic.org (unknown [10.5.221.176])
        by maili.marvell.com (Postfix) with ESMTP id 4707A3F703F;
        Wed, 22 Jul 2020 04:23:29 -0700 (PDT)
From:   Yuval Basson <ybason@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Yuval Basson <ybason@marvell.com>,
        "Michal Kalderon" <mkalderon@marvell.com>
Subject: [PATCH rdma-next] qedr: Add support for user mode XRC-SRQ's
Date:   Wed, 22 Jul 2020 13:23:39 +0300
Message-ID: <20200722102339.30104-1-ybason@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_05:2020-07-22,2020-07-22 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the XRC specific verbs.
The additional QP type introduced new logic to the rest of the verbs that
now require distinguishing whether a QP has an "RQ" or an "SQ" or both.

Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Yuval Basson <ybason@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c  |  19 +++
 drivers/infiniband/hw/qedr/qedr.h  |  33 +++++
 drivers/infiniband/hw/qedr/verbs.c | 291 +++++++++++++++++++++++++------------
 drivers/infiniband/hw/qedr/verbs.h |   4 +-
 4 files changed, 255 insertions(+), 92 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index c9eeed2..b35d2e3 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -179,6 +179,8 @@ static int qedr_iw_register_device(struct qedr_dev *dev)
 static const struct ib_device_ops qedr_roce_dev_ops = {
 	.get_port_immutable = qedr_roce_port_immutable,
 	.query_pkey = qedr_query_pkey,
+	.alloc_xrcd = qedr_alloc_xrcd,
+	.dealloc_xrcd = qedr_dealloc_xrcd,
 };
 
 static void qedr_roce_register_device(struct qedr_dev *dev)
@@ -186,6 +188,10 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 	dev->ibdev.node_type = RDMA_NODE_IB_CA;
 
 	ib_set_device_ops(&dev->ibdev, &qedr_roce_dev_ops);
+
+	dev->ibdev.uverbs_cmd_mask |= QEDR_UVERBS(OPEN_XRCD) |
+		QEDR_UVERBS(CLOSE_XRCD) |
+		QEDR_UVERBS(CREATE_XSRQ);
 }
 
 static const struct ib_device_ops qedr_dev_ops = {
@@ -232,6 +238,7 @@ static void qedr_roce_register_device(struct qedr_dev *dev)
 	INIT_RDMA_OBJ_SIZE(ib_cq, qedr_cq, ibcq),
 	INIT_RDMA_OBJ_SIZE(ib_pd, qedr_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_srq, qedr_srq, ibsrq),
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, qedr_xrcd, ibxrcd),
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, qedr_ucontext, ibucontext),
 };
 
@@ -703,6 +710,18 @@ static void qedr_affiliated_event(void *context, u8 e_code, void *fw_handle)
 			event.event = IB_EVENT_SRQ_ERR;
 			event_type = EVENT_TYPE_SRQ;
 			break;
+		case ROCE_ASYNC_EVENT_XRC_DOMAIN_ERR:
+			event.event = IB_EVENT_QP_ACCESS_ERR;
+			event_type = EVENT_TYPE_QP;
+			break;
+		case ROCE_ASYNC_EVENT_INVALID_XRCETH_ERR:
+			event.event = IB_EVENT_QP_ACCESS_ERR;
+			event_type = EVENT_TYPE_QP;
+			break;
+		case ROCE_ASYNC_EVENT_XRC_SRQ_CATASTROPHIC_ERR:
+			event.event = IB_EVENT_CQ_ERR;
+			event_type = EVENT_TYPE_CQ;
+			break;
 		default:
 			DP_ERR(dev, "unsupported event %d on handle=%llx\n",
 			       e_code, roce_handle64);
diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 4602921..d0b3a7a 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -310,6 +310,11 @@ struct qedr_pd {
 	struct qedr_ucontext *uctx;
 };
 
+struct qedr_xrcd {
+	struct ib_xrcd ibxrcd;
+	u16 xrcd_id;
+};
+
 struct qedr_qp_hwq_info {
 	/* WQE Elements */
 	struct qed_chain pbl;
@@ -361,6 +366,7 @@ struct qedr_srq {
 	struct ib_umem *prod_umem;
 	u16 srq_id;
 	u32 srq_limit;
+	bool is_xrc;
 	/* lock to protect srq recv post */
 	spinlock_t lock;
 };
@@ -573,6 +579,11 @@ static inline struct qedr_pd *get_qedr_pd(struct ib_pd *ibpd)
 	return container_of(ibpd, struct qedr_pd, ibpd);
 }
 
+static inline struct qedr_xrcd *get_qedr_xrcd(struct ib_xrcd *ibxrcd)
+{
+	return container_of(ibxrcd, struct qedr_xrcd, ibxrcd);
+}
+
 static inline struct qedr_cq *get_qedr_cq(struct ib_cq *ibcq)
 {
 	return container_of(ibcq, struct qedr_cq, ibcq);
@@ -598,6 +609,28 @@ static inline struct qedr_srq *get_qedr_srq(struct ib_srq *ibsrq)
 	return container_of(ibsrq, struct qedr_srq, ibsrq);
 }
 
+static inline bool qedr_qp_has_srq(struct qedr_qp *qp)
+{
+	return !!qp->srq;
+}
+
+static inline bool qedr_qp_has_sq(struct qedr_qp *qp)
+{
+	if (qp->qp_type == IB_QPT_GSI || qp->qp_type == IB_QPT_XRC_TGT)
+		return 0;
+
+	return 1;
+}
+
+static inline bool qedr_qp_has_rq(struct qedr_qp *qp)
+{
+	if (qp->qp_type == IB_QPT_GSI || qp->qp_type == IB_QPT_XRC_INI ||
+	    qp->qp_type == IB_QPT_XRC_TGT || qedr_qp_has_srq(qp))
+		return 0;
+
+	return 1;
+}
+
 static inline struct qedr_user_mmap_entry *
 get_qedr_mmap_entry(struct rdma_user_mmap_entry *rdma_entry)
 {
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index bd37eaf..6bddbaa 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -136,6 +136,8 @@ int qedr_query_device(struct ib_device *ibdev,
 	    IB_DEVICE_RC_RNR_NAK_GEN |
 	    IB_DEVICE_LOCAL_DMA_LKEY | IB_DEVICE_MEM_MGT_EXTENSIONS;
 
+	if (!rdma_protocol_iwarp(&dev->ibdev, 1))
+		attr->device_cap_flags |= IB_DEVICE_XRC;
 	attr->max_send_sge = qattr->max_sge;
 	attr->max_recv_sge = qattr->max_sge;
 	attr->max_sge_rd = qattr->max_sge;
@@ -480,6 +482,23 @@ void qedr_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	dev->ops->rdma_dealloc_pd(dev->rdma_ctx, pd->pd_id);
 }
 
+
+int qedr_alloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct qedr_dev *dev = get_qedr_dev(ibxrcd->device);
+	struct qedr_xrcd *xrcd = get_qedr_xrcd(ibxrcd);
+
+	return dev->ops->rdma_alloc_xrcd(dev->rdma_ctx, &xrcd->xrcd_id);
+}
+
+void qedr_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata)
+{
+	struct qedr_dev *dev = get_qedr_dev(ibxrcd->device);
+	u16 xrcd_id = get_qedr_xrcd(ibxrcd)->xrcd_id;
+
+	dev->ops->rdma_dealloc_xrcd(dev->rdma_ctx, xrcd_id);
+
+}
 static void qedr_free_pbl(struct qedr_dev *dev,
 			  struct qedr_pbl_info *pbl_info, struct qedr_pbl *pbl)
 {
@@ -1184,7 +1203,10 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
 	struct qedr_device_attr *qattr = &dev->attr;
 
 	/* QP0... attrs->qp_type == IB_QPT_GSI */
-	if (attrs->qp_type != IB_QPT_RC && attrs->qp_type != IB_QPT_GSI) {
+	if (attrs->qp_type != IB_QPT_RC &&
+	    attrs->qp_type != IB_QPT_GSI &&
+	    attrs->qp_type != IB_QPT_XRC_INI &&
+	    attrs->qp_type != IB_QPT_XRC_TGT) {
 		DP_DEBUG(dev, QEDR_MSG_QP,
 			 "create qp: unsupported qp type=0x%x requested\n",
 			 attrs->qp_type);
@@ -1227,6 +1249,22 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
 		return -EINVAL;
 	}
 
+	/* verify consumer QPs are not trying to use GSI QP's CQ.
+	 * TGT QP isn't associated with RQ/SQ
+	 */
+	if ((attrs->qp_type != IB_QPT_GSI) && (dev->gsi_qp_created) &&
+	    (attrs->qp_type != IB_QPT_XRC_TGT)) {
+		struct qedr_cq *send_cq = get_qedr_cq(attrs->send_cq);
+		struct qedr_cq *recv_cq = get_qedr_cq(attrs->recv_cq);
+
+		if ((send_cq->cq_type == QEDR_CQ_TYPE_GSI) ||
+		    (recv_cq->cq_type == QEDR_CQ_TYPE_GSI)) {
+			DP_ERR(dev,
+			       "create qp: consumer QP cannot use GSI CQs.\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -1289,8 +1327,12 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
 	int rc;
 
 	memset(uresp, 0, sizeof(*uresp));
-	qedr_copy_sq_uresp(dev, uresp, qp);
-	qedr_copy_rq_uresp(dev, uresp, qp);
+
+	if (qedr_qp_has_sq(qp))
+		qedr_copy_sq_uresp(dev, uresp, qp);
+
+	if (qedr_qp_has_rq(qp))
+		qedr_copy_rq_uresp(dev, uresp, qp);
 
 	uresp->atomic_supported = dev->atomic_cap != IB_ATOMIC_NONE;
 	uresp->qp_id = qp->qp_id;
@@ -1314,18 +1356,25 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 		kref_init(&qp->refcnt);
 		init_completion(&qp->iwarp_cm_comp);
 	}
+
 	qp->pd = pd;
 	qp->qp_type = attrs->qp_type;
 	qp->max_inline_data = attrs->cap.max_inline_data;
-	qp->sq.max_sges = attrs->cap.max_send_sge;
 	qp->state = QED_ROCE_QP_STATE_RESET;
 	qp->signaled = (attrs->sq_sig_type == IB_SIGNAL_ALL_WR) ? true : false;
-	qp->sq_cq = get_qedr_cq(attrs->send_cq);
 	qp->dev = dev;
+	if (qedr_qp_has_sq(qp)) {
+		qp->sq.max_sges = attrs->cap.max_send_sge;
+		qp->sq_cq = get_qedr_cq(attrs->send_cq);
+		DP_DEBUG(dev, QEDR_MSG_QP,
+			 "SQ params:\tsq_max_sges = %d, sq_cq_id = %d\n",
+			 qp->sq.max_sges, qp->sq_cq->icid);
+	}
 
-	if (attrs->srq) {
+	if (attrs->srq)
 		qp->srq = get_qedr_srq(attrs->srq);
-	} else {
+
+	if (qedr_qp_has_rq(qp)) {
 		qp->rq_cq = get_qedr_cq(attrs->recv_cq);
 		qp->rq.max_sges = attrs->cap.max_recv_sge;
 		DP_DEBUG(dev, QEDR_MSG_QP,
@@ -1344,30 +1393,26 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 
 static int qedr_set_roce_db_info(struct qedr_dev *dev, struct qedr_qp *qp)
 {
-	int rc;
+	int rc = 0;
 
-	qp->sq.db = dev->db_addr +
-		    DB_ADDR_SHIFT(DQ_PWM_OFFSET_XCM_RDMA_SQ_PROD);
-	qp->sq.db_data.data.icid = qp->icid + 1;
-	rc = qedr_db_recovery_add(dev, qp->sq.db,
-				  &qp->sq.db_data,
-				  DB_REC_WIDTH_32B,
-				  DB_REC_KERNEL);
-	if (rc)
-		return rc;
+	if (qedr_qp_has_sq(qp)) {
+		qp->sq.db = dev->db_addr +
+			    DB_ADDR_SHIFT(DQ_PWM_OFFSET_XCM_RDMA_SQ_PROD);
+		qp->sq.db_data.data.icid = qp->icid + 1;
+		rc = qedr_db_recovery_add(dev, qp->sq.db, &qp->sq.db_data,
+					  DB_REC_WIDTH_32B, DB_REC_KERNEL);
+		if (rc)
+			return rc;
+	}
 
-	if (!qp->srq) {
+	if (qedr_qp_has_rq(qp)) {
 		qp->rq.db = dev->db_addr +
 			    DB_ADDR_SHIFT(DQ_PWM_OFFSET_TCM_ROCE_RQ_PROD);
 		qp->rq.db_data.data.icid = qp->icid;
-
-		rc = qedr_db_recovery_add(dev, qp->rq.db,
-					  &qp->rq.db_data,
-					  DB_REC_WIDTH_32B,
-					  DB_REC_KERNEL);
-		if (rc)
-			qedr_db_recovery_del(dev, qp->sq.db,
-					     &qp->sq.db_data);
+		rc = qedr_db_recovery_add(dev, qp->rq.db, &qp->rq.db_data,
+					  DB_REC_WIDTH_32B, DB_REC_KERNEL);
+		if (rc && qedr_qp_has_sq(qp))
+			qedr_db_recovery_del(dev, qp->sq.db, &qp->sq.db_data);
 	}
 
 	return rc;
@@ -1390,6 +1435,10 @@ static int qedr_check_srq_params(struct qedr_dev *dev,
 		DP_ERR(dev,
 		       "create srq: unsupported sge=0x%x requested (max_srq_sge=0x%x)\n",
 		       attrs->attr.max_sge, qattr->max_sge);
+	}
+
+	if (!udata && attrs->srq_type == IB_SRQT_XRC) {
+		DP_ERR(dev, "XRC SRQs are not supported in kernel-space\n");
 		return -EINVAL;
 	}
 
@@ -1512,6 +1561,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 		return -EINVAL;
 
 	srq->dev = dev;
+	srq->is_xrc = (init_attr->srq_type == IB_SRQT_XRC);
 	hw_srq = &srq->hw_srq;
 	spin_lock_init(&srq->lock);
 
@@ -1553,6 +1603,14 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
 	in_params.prod_pair_addr = phy_prod_pair_addr;
 	in_params.num_pages = page_cnt;
 	in_params.page_size = page_size;
+	if (srq->is_xrc) {
+		struct qedr_xrcd *xrcd = get_qedr_xrcd(init_attr->ext.xrc.xrcd);
+		struct qedr_cq *cq = get_qedr_cq(init_attr->ext.cq);
+
+		in_params.is_xrc = 1;
+		in_params.xrcd_id = xrcd->xrcd_id;
+		in_params.cq_cid = cq->icid;
+	}
 
 	rc = dev->ops->rdma_create_srq(dev->rdma_ctx, &in_params, &out_params);
 	if (rc)
@@ -1595,6 +1653,7 @@ void qedr_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 
 	xa_erase_irq(&dev->srqs, srq->srq_id);
 	in_params.srq_id = srq->srq_id;
+	in_params.is_xrc = srq->is_xrc;
 	dev->ops->rdma_destroy_srq(dev->rdma_ctx, &in_params);
 
 	if (ibsrq->uobject)
@@ -1645,6 +1704,20 @@ int qedr_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	return 0;
 }
 
+static enum qed_rdma_qp_type qedr_ib_to_qed_qp_type(enum ib_qp_type ib_qp_type)
+{
+	switch (ib_qp_type) {
+	case IB_QPT_RC:
+		return QED_RDMA_QP_TYPE_RC;
+	case IB_QPT_XRC_INI:
+		return QED_RDMA_QP_TYPE_XRC_INI;
+	case IB_QPT_XRC_TGT:
+		return QED_RDMA_QP_TYPE_XRC_TGT;
+	default:
+		return QED_RDMA_QP_TYPE_INVAL;
+	}
+}
+
 static inline void
 qedr_init_common_qp_in_params(struct qedr_dev *dev,
 			      struct qedr_pd *pd,
@@ -1659,20 +1732,27 @@ int qedr_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 
 	params->signal_all = (attrs->sq_sig_type == IB_SIGNAL_ALL_WR);
 	params->fmr_and_reserved_lkey = fmr_and_reserved_lkey;
-	params->pd = pd->pd_id;
-	params->dpi = pd->uctx ? pd->uctx->dpi : dev->dpi;
-	params->sq_cq_id = get_qedr_cq(attrs->send_cq)->icid;
+	params->qp_type = qedr_ib_to_qed_qp_type(attrs->qp_type);
 	params->stats_queue = 0;
-	params->srq_id = 0;
-	params->use_srq = false;
 
-	if (!qp->srq) {
+	if (pd) {
+		params->pd = pd->pd_id;
+		params->dpi = pd->uctx ? pd->uctx->dpi : dev->dpi;
+	}
+
+	if (qedr_qp_has_sq(qp))
+		params->sq_cq_id = get_qedr_cq(attrs->send_cq)->icid;
+
+	if (qedr_qp_has_rq(qp))
 		params->rq_cq_id = get_qedr_cq(attrs->recv_cq)->icid;
 
-	} else {
+	if (qedr_qp_has_srq(qp)) {
 		params->rq_cq_id = get_qedr_cq(attrs->recv_cq)->icid;
 		params->srq_id = qp->srq->srq_id;
 		params->use_srq = true;
+	} else {
+		params->srq_id = 0;
+		params->use_srq = false;
 	}
 }
 
@@ -1686,8 +1766,10 @@ static inline void qedr_qp_user_print(struct qedr_dev *dev, struct qedr_qp *qp)
 		 "rq_len=%zd"
 		 "\n",
 		 qp,
-		 qp->usq.buf_addr,
-		 qp->usq.buf_len, qp->urq.buf_addr, qp->urq.buf_len);
+		 qedr_qp_has_sq(qp) ? qp->usq.buf_addr : 0x0,
+		 qedr_qp_has_sq(qp) ? qp->usq.buf_len : 0,
+		 qedr_qp_has_rq(qp) ? qp->urq.buf_addr : 0x0,
+		 qedr_qp_has_sq(qp) ? qp->urq.buf_len : 0);
 }
 
 static inline void
@@ -1713,11 +1795,15 @@ static void qedr_cleanup_user(struct qedr_dev *dev,
 			      struct qedr_ucontext *ctx,
 			      struct qedr_qp *qp)
 {
-	ib_umem_release(qp->usq.umem);
-	qp->usq.umem = NULL;
+	if (qedr_qp_has_sq(qp)) {
+		ib_umem_release(qp->usq.umem);
+		qp->usq.umem = NULL;
+	}
 
-	ib_umem_release(qp->urq.umem);
-	qp->urq.umem = NULL;
+	if (qedr_qp_has_rq(qp)) {
+		ib_umem_release(qp->urq.umem);
+		qp->urq.umem = NULL;
+	}
 
 	if (rdma_protocol_roce(&dev->ibdev, 1)) {
 		qedr_free_pbl(dev, &qp->usq.pbl_info, qp->usq.pbl_tbl);
@@ -1752,28 +1838,38 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 {
 	struct qed_rdma_create_qp_in_params in_params;
 	struct qed_rdma_create_qp_out_params out_params;
-	struct qedr_pd *pd = get_qedr_pd(ibpd);
-	struct qedr_create_qp_uresp uresp;
-	struct qedr_ucontext *ctx = pd ? pd->uctx : NULL;
-	struct qedr_create_qp_ureq ureq;
+	struct qedr_create_qp_uresp uresp = {};
+	struct qedr_create_qp_ureq ureq = {};
 	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
-	int rc = -EINVAL;
+	struct qedr_ucontext *ctx = NULL;
+	struct qedr_pd *pd = NULL;
+	int rc = 0;
 
 	qp->create_type = QEDR_QP_CREATE_USER;
-	memset(&ureq, 0, sizeof(ureq));
-	rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq), udata->inlen));
-	if (rc) {
-		DP_ERR(dev, "Problem copying data from user space\n");
-		return rc;
+
+	if (ibpd) {
+		pd = get_qedr_pd(ibpd);
+		ctx = pd->uctx;
 	}
 
-	/* SQ - read access only (0) */
-	rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
-				  ureq.sq_len, true, 0, alloc_and_init);
-	if (rc)
-		return rc;
+	if (udata) {
+		rc = ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
+					udata->inlen));
+		if (rc) {
+			DP_ERR(dev, "Problem copying data from user space\n");
+			return rc;
+		}
+	}
 
-	if (!qp->srq) {
+	if (qedr_qp_has_sq(qp)) {
+		/* SQ - read access only (0) */
+		rc = qedr_init_user_queue(udata, dev, &qp->usq, ureq.sq_addr,
+					  ureq.sq_len, true, 0, alloc_and_init);
+		if (rc)
+			return rc;
+	}
+
+	if (qedr_qp_has_rq(qp)) {
 		/* RQ - read access only (0) */
 		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
 					  ureq.rq_len, true, 0, alloc_and_init);
@@ -1785,9 +1881,21 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	qedr_init_common_qp_in_params(dev, pd, qp, attrs, false, &in_params);
 	in_params.qp_handle_lo = ureq.qp_handle_lo;
 	in_params.qp_handle_hi = ureq.qp_handle_hi;
-	in_params.sq_num_pages = qp->usq.pbl_info.num_pbes;
-	in_params.sq_pbl_ptr = qp->usq.pbl_tbl->pa;
-	if (!qp->srq) {
+
+	if (qp->qp_type == IB_QPT_XRC_TGT) {
+		struct qedr_xrcd *xrcd = get_qedr_xrcd(attrs->xrcd);
+
+		in_params.xrcd_id = xrcd->xrcd_id;
+		in_params.qp_handle_lo = qp->qp_id;
+		in_params.use_srq = 1;
+	}
+
+	if (qedr_qp_has_sq(qp)) {
+		in_params.sq_num_pages = qp->usq.pbl_info.num_pbes;
+		in_params.sq_pbl_ptr = qp->usq.pbl_tbl->pa;
+	}
+
+	if (qedr_qp_has_rq(qp)) {
 		in_params.rq_num_pages = qp->urq.pbl_info.num_pbes;
 		in_params.rq_pbl_ptr = qp->urq.pbl_tbl->pa;
 	}
@@ -1809,39 +1917,32 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	qp->qp_id = out_params.qp_id;
 	qp->icid = out_params.icid;
 
-	rc = qedr_copy_qp_uresp(dev, qp, udata, &uresp);
-	if (rc)
-		goto err;
+	if (udata) {
+		rc = qedr_copy_qp_uresp(dev, qp, udata, &uresp);
+		if (rc)
+			goto err;
+	}
 
 	/* db offset was calculated in copy_qp_uresp, now set in the user q */
-	ctx = pd->uctx;
-	qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
-	qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
-
-	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
-		qp->urq.db_rec_db2_addr = ctx->dpi_addr + uresp.rq_db2_offset;
-
-		/* calculate the db_rec_db2 data since it is constant so no
-		 *  need to reflect from user
-		 */
-		qp->urq.db_rec_db2_data.data.icid = cpu_to_le16(qp->icid);
-		qp->urq.db_rec_db2_data.data.value =
-			cpu_to_le16(DQ_TCM_IWARP_POST_RQ_CF_CMD);
+	if (qedr_qp_has_sq(qp)) {
+		qp->usq.db_addr = ctx->dpi_addr + uresp.sq_db_offset;
+		rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
+					  &qp->usq.db_rec_data->db_data,
+					  DB_REC_WIDTH_32B,
+					  DB_REC_USER);
+		if (rc)
+			goto err;
 	}
 
-	rc = qedr_db_recovery_add(dev, qp->usq.db_addr,
-				  &qp->usq.db_rec_data->db_data,
-				  DB_REC_WIDTH_32B,
-				  DB_REC_USER);
-	if (rc)
-		goto err;
-
-	rc = qedr_db_recovery_add(dev, qp->urq.db_addr,
-				  &qp->urq.db_rec_data->db_data,
-				  DB_REC_WIDTH_32B,
-				  DB_REC_USER);
-	if (rc)
-		goto err;
+	if (qedr_qp_has_rq(qp)) {
+		qp->urq.db_addr = ctx->dpi_addr + uresp.rq_db_offset;
+		rc = qedr_db_recovery_add(dev, qp->urq.db_addr,
+					  &qp->urq.db_rec_data->db_data,
+					  DB_REC_WIDTH_32B,
+					  DB_REC_USER);
+		if (rc)
+			goto err;
+	}
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		rc = qedr_db_recovery_add(dev, qp->urq.db_rec_db2_addr,
@@ -1852,7 +1953,6 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 			goto err;
 	}
 	qedr_qp_user_print(dev, qp);
-
 	return rc;
 err:
 	rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
@@ -2115,12 +2215,21 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 			     struct ib_qp_init_attr *attrs,
 			     struct ib_udata *udata)
 {
-	struct qedr_dev *dev = get_qedr_dev(ibpd->device);
-	struct qedr_pd *pd = get_qedr_pd(ibpd);
+	struct qedr_xrcd *xrcd = NULL;
+	struct qedr_pd *pd = NULL;
+	struct qedr_dev *dev;
 	struct qedr_qp *qp;
 	struct ib_qp *ibqp;
 	int rc = 0;
 
+	if (attrs->qp_type == IB_QPT_XRC_TGT) {
+		xrcd = get_qedr_xrcd(attrs->xrcd);
+		dev = get_qedr_dev(xrcd->ibxrcd.device);
+	} else {
+		pd = get_qedr_pd(ibpd);
+		dev = get_qedr_dev(ibpd->device);
+	}
+
 	DP_DEBUG(dev, QEDR_MSG_QP, "create qp: called from %s, pd=%p\n",
 		 udata ? "user library" : "kernel", pd);
 
@@ -2151,7 +2260,7 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 		return ibqp;
 	}
 
-	if (udata)
+	if (udata || xrcd)
 		rc = qedr_create_user_qp(dev, qp, ibpd, udata, attrs);
 	else
 		rc = qedr_create_kernel_qp(dev, qp, ibpd, attrs);
diff --git a/drivers/infiniband/hw/qedr/verbs.h b/drivers/infiniband/hw/qedr/verbs.h
index 39dd628..bb09c64 100644
--- a/drivers/infiniband/hw/qedr/verbs.h
+++ b/drivers/infiniband/hw/qedr/verbs.h
@@ -48,7 +48,9 @@ int qedr_iw_query_gid(struct ib_device *ibdev, u8 port,
 void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 int qedr_alloc_pd(struct ib_pd *pd, struct ib_udata *udata);
 void qedr_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
-
+int qedr_alloc_xrcd(struct ib_xrcd *ibxrcd,
+				struct ib_udata *udata);
+void qedr_dealloc_xrcd(struct ib_xrcd *ibxrcd, struct ib_udata *udata);
 int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		   struct ib_udata *udata);
 int qedr_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
-- 
1.8.3.1

