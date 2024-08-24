Return-Path: <linux-rdma+bounces-4547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB495DAF4
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE8F282624
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285127DA86;
	Sat, 24 Aug 2024 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNBnf4ba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CD770E4;
	Sat, 24 Aug 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469654; cv=none; b=IQhn+hZKZBkRdzMRs77F7n2TUedVvWeKnLF4kcXzUs9XgMw03TOiH4xEhrdRAJzIrDvTAiiuzTXjxIq9hKPafLqAHj819xolquDh0H3lu+gU6nRcQNJz6y1eJy7dAuXob0K9gyWD1Pr1ERO23PHmeJU5WifD4x3w6KCLsgi/QoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469654; c=relaxed/simple;
	bh=R/oiJewUhwL8HA44QlFd/COJ/0OmEU9yyepfw2SG1Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tktnQXeFhD824kNbE0LmQFuYdd671o2nDzClwYTPzRmCkYbRs15XhPGc/QE47gkEOcWzwM+wQsqkap8I0blC7Q9kKJn8qTSDv1JpVhu7lw2Ia2ABqU09kog2XeVEeffw493FpLI0ntRsh/eZVdRMMUcw0x5kZ9b7m4ow4Av/HXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNBnf4ba; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469653; x=1756005653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/oiJewUhwL8HA44QlFd/COJ/0OmEU9yyepfw2SG1Ug=;
  b=mNBnf4bafdExxsD+p6S/lnRwpN/IapPGg0sZ/dmhmPkmcLWrhYg1N56D
   Nm4L0qcpdLfS5ZqRBm0FUgdJotM41BDZJoG4JtXKhkADEtFhdL6BkYR4/
   iGjswxNNfKqJ/bMqHlpnjbne+RoMpsa0RGFdD+A98sa+KWW+szmMLy0YT
   +OhetmN9SaWMf7sLrVgLeJYwvSI6zXeDsIRSenh+iXxTtH5245QrkJ/U7
   ohr4erRHHqXgtICHm35aa7O+c1h0TYG3GMf/sKcAqaoiZWZJWD+fVYNC7
   faojV9Dk7E1S46nsp00PLPk+JhOhVev6uhZPn+1bIELjhQtR5twB/W/Rb
   g==;
X-CSE-ConnectionGUID: 7XhPuZJBTwSpu57xkoc/1w==
X-CSE-MsgGUID: T2DqIM+WTPO3OlHcqNHQ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187816"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187816"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:48 -0700
X-CSE-ConnectionGUID: WxeUEmgATsS8UDis4aPelA==
X-CSE-MsgGUID: AmXrILgySWaFoTZFpKLy7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492125"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:47 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 17/25] RDMA/irdma: Add GEN3 virtual QP1 support
Date: Fri, 23 Aug 2024 22:19:16 -0500
Message-Id: <20240824031924.421-18-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Add a new RDMA virtual channel op during QP1 creation that allow the
Control Plane (CP) to virtualize a regular QP as QP1 on non-default
RDMA capable vPorts. Additionally, the CP will return the Qsets to use
on the ib_device of the vPort.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c     | 10 ++-
 drivers/infiniband/hw/irdma/main.h     |  1 +
 drivers/infiniband/hw/irdma/utils.c    | 30 ++++++++-
 drivers/infiniband/hw/irdma/verbs.c    | 84 ++++++++++++++++++++------
 drivers/infiniband/hw/irdma/virtchnl.c | 52 ++++++++++++++++
 drivers/infiniband/hw/irdma/virtchnl.h | 19 ++++++
 6 files changed, 174 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 88eb7a088ee7..4f05d0e57114 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -74,6 +74,14 @@ static void irdma_set_qos_info(struct irdma_sc_vsi  *vsi,
 {
 	u8 i;
 
+	if (vsi->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_3) {
+		for (i = 0; i < IRDMA_MAX_USER_PRIORITY; i++) {
+			vsi->qos[i].qs_handle = vsi->dev->qos[i].qs_handle;
+			vsi->qos[i].valid = true;
+		}
+
+		return;
+	}
 	vsi->qos_rel_bw = l2p->vsi_rel_bw;
 	vsi->qos_prio_type = l2p->vsi_prio_type;
 	vsi->dscp_mode = l2p->dscp_mode;
@@ -1873,7 +1881,7 @@ void irdma_sc_vsi_init(struct irdma_sc_vsi  *vsi,
 		mutex_init(&vsi->qos[i].qos_mutex);
 		INIT_LIST_HEAD(&vsi->qos[i].qplist);
 	}
-	if (vsi->register_qset) {
+	if (vsi->dev->hw_attrs.uk_attrs.hw_rev == IRDMA_GEN_2) {
 		vsi->dev->ws_add = irdma_ws_add;
 		vsi->dev->ws_remove = irdma_ws_remove;
 		vsi->dev->ws_reset = irdma_ws_reset;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 1dab2ffba5e5..f0196aafe59b 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -260,6 +260,7 @@ struct irdma_pci_f {
 	bool reset:1;
 	bool rsrc_created:1;
 	bool msix_shared:1;
+	bool hwqp1_rsvd:1;
 	u8 rsrc_profile;
 	u8 *hmc_info_mem;
 	u8 *mem_rsrc;
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index e940d32c9dbb..894ced3a8989 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1184,6 +1184,26 @@ static void irdma_dealloc_push_page(struct irdma_pci_f *rf,
 	irdma_put_cqp_request(&rf->cqp, cqp_request);
 }
 
+static void irdma_free_gsi_qp_rsrc(struct irdma_qp *iwqp, u32 qp_num)
+{
+	struct irdma_device *iwdev = iwqp->iwdev;
+	struct irdma_pci_f *rf = iwdev->rf;
+	unsigned long flags;
+
+	if (rf->sc_dev.hw_attrs.uk_attrs.hw_rev < IRDMA_GEN_3)
+		return;
+
+	irdma_vchnl_req_del_vport(&rf->sc_dev, iwdev->vport_id, qp_num);
+
+	if (qp_num == 1) {
+		spin_lock_irqsave(&rf->rsrc_lock, flags);
+		rf->hwqp1_rsvd = false;
+		spin_unlock_irqrestore(&rf->rsrc_lock, flags);
+	} else if (qp_num > 2) {
+		irdma_free_rsrc(rf, rf->allocated_qps, qp_num);
+	}
+}
+
 /**
  * irdma_free_qp_rsrc - free up memory resources for qp
  * @iwqp: qp ptr (user or kernel)
@@ -1192,7 +1212,7 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
 {
 	struct irdma_device *iwdev = iwqp->iwdev;
 	struct irdma_pci_f *rf = iwdev->rf;
-	u32 qp_num = iwqp->ibqp.qp_num;
+	u32 qp_num = iwqp->sc_qp.qp_uk.qp_id;
 
 	irdma_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
 	irdma_dealloc_push_page(rf, &iwqp->sc_qp);
@@ -1202,8 +1222,12 @@ void irdma_free_qp_rsrc(struct irdma_qp *iwqp)
 					   iwqp->sc_qp.user_pri);
 	}
 
-	if (qp_num > 2)
-		irdma_free_rsrc(rf, rf->allocated_qps, qp_num);
+	if (iwqp->ibqp.qp_type == IB_QPT_GSI) {
+		irdma_free_gsi_qp_rsrc(iwqp, qp_num);
+	} else {
+		if (qp_num > 2)
+			irdma_free_rsrc(rf, rf->allocated_qps, qp_num);
+	}
 	dma_free_coherent(rf->sc_dev.hw->device, iwqp->q2_ctx_mem.size,
 			  iwqp->q2_ctx_mem.va, iwqp->q2_ctx_mem.pa);
 	iwqp->q2_ctx_mem.va = NULL;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index d1bce0b155f1..149adf0dad56 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -545,6 +545,9 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
 
 	irdma_remove_push_mmap_entries(iwqp);
+
+	if (iwqp->sc_qp.qp_uk.qp_id == 1)
+		iwdev->rf->hwqp1_rsvd = false;
 	irdma_free_qp_rsrc(iwqp);
 
 	return 0;
@@ -723,6 +726,7 @@ static int irdma_setup_kmode_qp(struct irdma_device *iwdev,
 		info->rq_pa + (ukinfo->rq_depth * IRDMA_QP_WQE_MIN_SIZE);
 	ukinfo->sq_size = ukinfo->sq_depth >> ukinfo->sq_shift;
 	ukinfo->rq_size = ukinfo->rq_depth >> ukinfo->rq_shift;
+	ukinfo->qp_id = info->qp_uk_init_info.qp_id;
 
 	iwqp->max_send_wr = (ukinfo->sq_depth - IRDMA_SQ_RSVD) >> ukinfo->sq_shift;
 	iwqp->max_recv_wr = (ukinfo->rq_depth - IRDMA_RQ_RSVD) >> ukinfo->rq_shift;
@@ -779,6 +783,8 @@ static void irdma_roce_fill_and_set_qpctx_info(struct irdma_qp *iwqp,
 	roce_info = &iwqp->roce_info;
 	ether_addr_copy(roce_info->mac_addr, iwdev->netdev->dev_addr);
 
+	if (iwqp->ibqp.qp_type == IB_QPT_GSI && iwqp->ibqp.qp_num != 1)
+		roce_info->is_qp1 = true;
 	roce_info->rd_en = true;
 	roce_info->wr_rdresp_en = true;
 	roce_info->bind_en = true;
@@ -868,6 +874,47 @@ static void irdma_flush_worker(struct work_struct *work)
 	irdma_generate_flush_completions(iwqp);
 }
 
+static int irdma_setup_gsi_qp_rsrc(struct irdma_qp *iwqp, u32 *qp_num)
+{
+	struct irdma_device *iwdev = iwqp->iwdev;
+	struct irdma_pci_f *rf = iwdev->rf;
+	unsigned long flags;
+	int ret;
+
+	if (rf->rdma_ver <= IRDMA_GEN_2) {
+		*qp_num = 1;
+		return 0;
+	}
+
+	spin_lock_irqsave(&rf->rsrc_lock, flags);
+	if (!rf->hwqp1_rsvd) {
+		*qp_num = 1;
+		rf->hwqp1_rsvd = true;
+		spin_unlock_irqrestore(&rf->rsrc_lock, flags);
+	} else {
+		spin_unlock_irqrestore(&rf->rsrc_lock, flags);
+		ret = irdma_alloc_rsrc(rf, rf->allocated_qps, rf->max_qp,
+				       qp_num, &rf->next_qp);
+		if (ret)
+			return ret;
+	}
+
+	ret = irdma_vchnl_req_add_vport(&rf->sc_dev, iwdev->vport_id, *qp_num,
+					(&iwdev->vsi)->qos);
+	if (ret) {
+		if (*qp_num != 1) {
+			irdma_free_rsrc(rf, rf->allocated_qps, *qp_num);
+		} else {
+			spin_lock_irqsave(&rf->rsrc_lock, flags);
+			rf->hwqp1_rsvd = false;
+			spin_unlock_irqrestore(&rf->rsrc_lock, flags);
+		}
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * irdma_create_qp - create qp
  * @ibqp: ptr of qp
@@ -929,16 +976,20 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	init_info.host_ctx = (__le64 *)(init_info.q2 + IRDMA_Q2_BUF_SIZE);
 	init_info.host_ctx_pa = init_info.q2_pa + IRDMA_Q2_BUF_SIZE;
 
-	if (init_attr->qp_type == IB_QPT_GSI)
-		qp_num = 1;
-	else
+	if (init_attr->qp_type == IB_QPT_GSI) {
+		err_code = irdma_setup_gsi_qp_rsrc(iwqp, &qp_num);
+		if (err_code)
+			goto error;
+		iwqp->ibqp.qp_num = 1;
+	} else {
 		err_code = irdma_alloc_rsrc(rf, rf->allocated_qps, rf->max_qp,
 					    &qp_num, &rf->next_qp);
-	if (err_code)
-		goto error;
+		if (err_code)
+			goto error;
+		iwqp->ibqp.qp_num = qp_num;
+	}
 
 	iwqp->iwpd = iwpd;
-	iwqp->ibqp.qp_num = qp_num;
 	qp = &iwqp->sc_qp;
 	iwqp->iwscq = to_iwcq(init_attr->send_cq);
 	iwqp->iwrcq = to_iwcq(init_attr->recv_cq);
@@ -998,10 +1049,17 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	ctx_info->send_cq_num = iwqp->iwscq->sc_cq.cq_uk.cq_id;
 	ctx_info->rcv_cq_num = iwqp->iwrcq->sc_cq.cq_uk.cq_id;
 
-	if (rdma_protocol_roce(&iwdev->ibdev, 1))
+	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
+		if (dev->ws_add(&iwdev->vsi, 0)) {
+			irdma_cqp_qp_destroy_cmd(&rf->sc_dev, &iwqp->sc_qp);
+			err_code = -EINVAL;
+			goto error;
+		}
+		irdma_qp_add_qos(&iwqp->sc_qp);
 		irdma_roce_fill_and_set_qpctx_info(iwqp, ctx_info);
-	else
+	} else {
 		irdma_iw_fill_and_set_qpctx_info(iwqp, ctx_info);
+	}
 
 	err_code = irdma_cqp_create_qp_cmd(iwqp);
 	if (err_code)
@@ -1013,16 +1071,6 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	iwqp->sig_all = init_attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	rf->qp_table[qp_num] = iwqp;
 
-	if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
-		if (dev->ws_add(&iwdev->vsi, 0)) {
-			irdma_cqp_qp_destroy_cmd(&rf->sc_dev, &iwqp->sc_qp);
-			err_code = -EINVAL;
-			goto error;
-		}
-
-		irdma_qp_add_qos(&iwqp->sc_qp);
-	}
-
 	if (udata) {
 		/* GEN_1 legacy support with libi40iw does not have expanded uresp struct */
 		if (udata->outlen < sizeof(uresp)) {
diff --git a/drivers/infiniband/hw/irdma/virtchnl.c b/drivers/infiniband/hw/irdma/virtchnl.c
index fc669b5a6b77..9f39cd69d85d 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.c
+++ b/drivers/infiniband/hw/irdma/virtchnl.c
@@ -110,6 +110,8 @@ static int irdma_vchnl_req_verify_resp(struct irdma_vchnl_req *vchnl_req,
 	case IRDMA_VCHNL_OP_GET_REG_LAYOUT:
 	case IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP:
 	case IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP:
+	case IRDMA_VCHNL_OP_ADD_VPORT:
+	case IRDMA_VCHNL_OP_DEL_VPORT:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -315,6 +317,56 @@ int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev)
 	return 0;
 }
 
+int irdma_vchnl_req_add_vport(struct irdma_sc_dev *dev, u16 vport_id,
+			      u32 qp1_id, struct irdma_qos *qos)
+{
+	struct irdma_vchnl_resp_vport_info resp_vport = { 0 };
+	struct irdma_vchnl_req_vport_info req_vport = { 0 };
+	struct irdma_vchnl_req_init_info info = { 0 };
+	int ret, i;
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_ADD_VPORT;
+	info.op_ver = IRDMA_VCHNL_OP_ADD_VPORT_V0;
+	req_vport.vport_id = vport_id;
+	req_vport.qp1_id = qp1_id;
+	info.req_parm_len = sizeof(req_vport);
+	info.req_parm = &req_vport;
+	info.resp_parm = &resp_vport;
+	info.resp_parm_len = sizeof(resp_vport);
+
+	ret = irdma_vchnl_req_send_sync(dev, &info);
+	if (ret)
+		return ret;
+
+	for (i = 0;  i < IRDMA_MAX_USER_PRIORITY; i++) {
+		qos[i].qs_handle = resp_vport.qs_handle[i];
+		qos[i].valid = true;
+	}
+
+	return 0;
+}
+
+int irdma_vchnl_req_del_vport(struct irdma_sc_dev *dev, u16 vport_id, u32 qp1_id)
+{
+	struct irdma_vchnl_req_init_info info = { 0 };
+	struct irdma_vchnl_req_vport_info req_vport = { 0 };
+
+	if (!dev->vchnl_up)
+		return -EBUSY;
+
+	info.op_code = IRDMA_VCHNL_OP_DEL_VPORT;
+	info.op_ver = IRDMA_VCHNL_OP_DEL_VPORT_V0;
+	req_vport.vport_id = vport_id;
+	req_vport.qp1_id = qp1_id;
+	info.req_parm_len = sizeof(req_vport);
+	info.req_parm = &req_vport;
+
+	return irdma_vchnl_req_send_sync(dev, &info);
+}
+
 /**
  * irdma_vchnl_req_aeq_vec_map - Map AEQ to vector on this function
  * @dev: RDMA device pointer
diff --git a/drivers/infiniband/hw/irdma/virtchnl.h b/drivers/infiniband/hw/irdma/virtchnl.h
index 3af725587754..23e66bc2aa44 100644
--- a/drivers/infiniband/hw/irdma/virtchnl.h
+++ b/drivers/infiniband/hw/irdma/virtchnl.h
@@ -17,6 +17,8 @@
 #define IRDMA_VCHNL_OP_GET_REG_LAYOUT_V0 0
 #define IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP_V0 0
 #define IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP_V0 0
+#define IRDMA_VCHNL_OP_ADD_VPORT_V0 0
+#define IRDMA_VCHNL_OP_DEL_VPORT_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_V0 0
 #define IRDMA_VCHNL_OP_GET_RDMA_CAPS_MIN_SIZE 1
 
@@ -57,6 +59,8 @@ enum irdma_vchnl_ops {
 	IRDMA_VCHNL_OP_GET_RDMA_CAPS = 13,
 	IRDMA_VCHNL_OP_QUEUE_VECTOR_MAP = 14,
 	IRDMA_VCHNL_OP_QUEUE_VECTOR_UNMAP = 15,
+	IRDMA_VCHNL_OP_ADD_VPORT = 16,
+	IRDMA_VCHNL_OP_DEL_VPORT = 17,
 };
 
 struct irdma_vchnl_req_hmc_info {
@@ -81,6 +85,15 @@ struct irdma_vchnl_qvlist_info {
 	struct irdma_vchnl_qv_info qv_info[];
 };
 
+struct irdma_vchnl_req_vport_info {
+	u16 vport_id;
+	u32 qp1_id;
+};
+
+struct irdma_vchnl_resp_vport_info {
+	u16 qs_handle[IRDMA_MAX_USER_PRIORITY];
+};
+
 struct irdma_vchnl_op_buf {
 	u16 op_code;
 	u16 op_ver;
@@ -141,6 +154,8 @@ struct irdma_vchnl_req_init_info {
 	u16 op_ver;
 } __packed;
 
+struct irdma_qos;
+
 int irdma_sc_vchnl_init(struct irdma_sc_dev *dev,
 			struct irdma_vchnl_init_info *info);
 int irdma_vchnl_send_sync(struct irdma_sc_dev *dev, u8 *msg, u16 len,
@@ -156,4 +171,8 @@ int irdma_vchnl_req_get_reg_layout(struct irdma_sc_dev *dev);
 int irdma_vchnl_req_aeq_vec_map(struct irdma_sc_dev *dev, u32 v_idx);
 int irdma_vchnl_req_ceq_vec_map(struct irdma_sc_dev *dev, u16 ceq_id,
 				u32 v_idx);
+int irdma_vchnl_req_add_vport(struct irdma_sc_dev *dev, u16 vport_id,
+			      u32 qp1_id, struct irdma_qos *qos);
+int irdma_vchnl_req_del_vport(struct irdma_sc_dev *dev, u16 vport_id,
+			      u32 qp1_id);
 #endif /* IRDMA_VIRTCHNL_H */
-- 
2.42.0


