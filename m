Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682495B0CF2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 21:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIGTNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiIGTNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 15:13:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCF97B15
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662578017; x=1694114017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+LHi4TEQfGqOCb4UJ8IrM/1a/61kQPvJ1m+E4Ttx24=;
  b=FwatfzBakcEcDhRTUcu8O73aiaSmCrRXh8molrEGAsB69pkWNdtPg1lK
   DyCSQKWNvJJfEhr+S0lIvv+KRbZGU+agwD9/Npyr1nyW7sfHfUK9exM/q
   URJmJW9zN8hiHhUZyE5yo5kAO58NTfNxm3W13b5DsQAZUPqIKpmAUnpfu
   Sk/c4kUklJ4Qr7qHguEna3ghpak91iZRf9h9CpUbCUcOnp1WBZPB6NPDO
   9akSIXBv2cAOCPt37i3teyTSsJ758ABFpxBqQMWUhQU5lpIug8K03zKOG
   ARtXiTp+aeRor9Pj7UmpSC1XMsamgS1S67oZP1dL87HluYTrafa2dIofR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295709243"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="295709243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676339043"
Received: from sveedu-mobl.amr.corp.intel.com (HELO ssaleem-mobl1.amr.corp.intel.com) ([10.255.37.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:13:37 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH for-next 2/2] RDMA/irdma: Validate udata inlen and outlen
Date:   Wed,  7 Sep 2022 14:13:24 -0500
Message-Id: <20220907191324.1173-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220907191324.1173-1-shiraz.saleem@intel.com>
References: <20220907191324.1173-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently ib_copy_from_udata and ib_copy_to_udata could underfill
the request and response buffer if the user-space passes an undersized
value for udata->inlen or udata->outlen respectively [1]
This could lead to undesirable behavior.

Zero initing the buffer only goes as far as preventing using the buffer
uninitialized.

Validate udata->inlen and udata->outlen passed from user-space to ensure
they are at least the required minimum size.

[1] https://lore.kernel.org/linux-rdma/MWHPR11MB0029F37D40D9D4A993F8F549E9D79@MWHPR11MB0029.namprd11.prod.outlook.com/

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 67 +++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f3925f1..ba403cc 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -296,13 +296,19 @@ static void irdma_alloc_push_page(struct irdma_qp *iwqp)
 static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 				struct ib_udata *udata)
 {
+#define IRDMA_ALLOC_UCTX_MIN_REQ_LEN offsetofend(struct irdma_alloc_ucontext_req, rsvd8)
+#define IRDMA_ALLOC_UCTX_MIN_RESP_LEN offsetofend(struct irdma_alloc_ucontext_resp, rsvd)
 	struct ib_device *ibdev = uctx->device;
 	struct irdma_device *iwdev = to_iwdev(ibdev);
-	struct irdma_alloc_ucontext_req req;
+	struct irdma_alloc_ucontext_req req = {};
 	struct irdma_alloc_ucontext_resp uresp = {};
 	struct irdma_ucontext *ucontext = to_ucontext(uctx);
 	struct irdma_uk_attrs *uk_attrs;
 
+	if (udata->inlen < IRDMA_ALLOC_UCTX_MIN_REQ_LEN ||
+	    udata->outlen < IRDMA_ALLOC_UCTX_MIN_RESP_LEN)
+		return -EINVAL;
+
 	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen)))
 		return -EINVAL;
 
@@ -314,7 +320,7 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 
 	uk_attrs = &iwdev->rf->sc_dev.hw_attrs.uk_attrs;
 	/* GEN_1 legacy support with libi40iw */
-	if (udata->outlen < sizeof(uresp)) {
+	if (udata->outlen == IRDMA_ALLOC_UCTX_MIN_RESP_LEN) {
 		if (uk_attrs->hw_rev != IRDMA_GEN_1)
 			return -EOPNOTSUPP;
 
@@ -386,6 +392,7 @@ static void irdma_dealloc_ucontext(struct ib_ucontext *context)
  */
 static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
+#define IRDMA_ALLOC_PD_MIN_RESP_LEN offsetofend(struct irdma_alloc_pd_resp, rsvd)
 	struct irdma_pd *iwpd = to_iwpd(pd);
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_sc_dev *dev = &iwdev->rf->sc_dev;
@@ -395,6 +402,9 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 	u32 pd_id = 0;
 	int err;
 
+	if (udata && udata->outlen < IRDMA_ALLOC_PD_MIN_RESP_LEN)
+		return -EINVAL;
+
 	err = irdma_alloc_rsrc(rf, rf->allocated_pds, rf->max_pd, &pd_id,
 			       &rf->next_pd);
 	if (err)
@@ -811,12 +821,14 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 			   struct ib_qp_init_attr *init_attr,
 			   struct ib_udata *udata)
 {
+#define IRDMA_CREATE_QP_MIN_REQ_LEN offsetofend(struct irdma_create_qp_req, user_compl_ctx)
+#define IRDMA_CREATE_QP_MIN_RESP_LEN offsetofend(struct irdma_create_qp_resp, rsvd)
 	struct ib_pd *ibpd = ibqp->pd;
 	struct irdma_pd *iwpd = to_iwpd(ibpd);
 	struct irdma_device *iwdev = to_iwdev(ibpd->device);
 	struct irdma_pci_f *rf = iwdev->rf;
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
-	struct irdma_create_qp_req req;
+	struct irdma_create_qp_req req = {};
 	struct irdma_create_qp_resp uresp = {};
 	u32 qp_num = 0;
 	int err_code;
@@ -833,6 +845,10 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 	if (err_code)
 		return err_code;
 
+	if (udata && (udata->inlen < IRDMA_CREATE_QP_MIN_REQ_LEN ||
+		      udata->outlen < IRDMA_CREATE_QP_MIN_RESP_LEN))
+		return -EINVAL;
+
 	sq_size = init_attr->cap.max_send_wr;
 	rq_size = init_attr->cap.max_recv_wr;
 
@@ -1117,6 +1133,8 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			 int attr_mask, struct ib_udata *udata)
 {
+#define IRDMA_MODIFY_QP_MIN_REQ_LEN offsetofend(struct irdma_modify_qp_req, rq_flush)
+#define IRDMA_MODIFY_QP_MIN_RESP_LEN offsetofend(struct irdma_modify_qp_resp, push_valid)
 	struct irdma_pd *iwpd = to_iwpd(ibqp->pd);
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
 	struct irdma_device *iwdev = iwqp->iwdev;
@@ -1135,6 +1153,13 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	roce_info = &iwqp->roce_info;
 	udp_info = &iwqp->udp_info;
 
+	if (udata) {
+		/* udata inlen/outlen can be 0 when supporting legacy libi40iw */
+		if ((udata->inlen && udata->inlen < IRDMA_MODIFY_QP_MIN_REQ_LEN) ||
+		    (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN))
+			return -EINVAL;
+	}
+
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
@@ -1371,7 +1396,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
-				if (udata) {
+				if (udata && udata->inlen) {
 					if (ib_copy_from_udata(&ureq, udata,
 					    min(sizeof(ureq), udata->inlen)))
 						return -EINVAL;
@@ -1423,7 +1448,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		} else {
 			iwqp->ibqp_state = attr->qp_state;
 		}
-		if (udata && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
+		if (udata && udata->outlen && dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
 			struct irdma_ucontext *ucontext;
 
 			ucontext = rdma_udata_to_drv_context(udata,
@@ -1463,6 +1488,8 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		    struct ib_udata *udata)
 {
+#define IRDMA_MODIFY_QP_MIN_REQ_LEN offsetofend(struct irdma_modify_qp_req, rq_flush)
+#define IRDMA_MODIFY_QP_MIN_RESP_LEN offsetofend(struct irdma_modify_qp_resp, push_valid)
 	struct irdma_qp *iwqp = to_iwqp(ibqp);
 	struct irdma_device *iwdev = iwqp->iwdev;
 	struct irdma_sc_dev *dev = &iwdev->rf->sc_dev;
@@ -1477,6 +1504,13 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 	int err;
 	unsigned long flags;
 
+	if (udata) {
+		/* udata inlen/outlen can be 0 when supporting legacy libi40iw */
+		if ((udata->inlen && udata->inlen < IRDMA_MODIFY_QP_MIN_REQ_LEN) ||
+		    (udata->outlen && udata->outlen < IRDMA_MODIFY_QP_MIN_RESP_LEN))
+			return -EINVAL;
+	}
+
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
 		return -EOPNOTSUPP;
 
@@ -1562,7 +1596,7 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		case IB_QPS_RESET:
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
-				if (udata) {
+				if (udata && udata->inlen) {
 					if (ib_copy_from_udata(&ureq, udata,
 					    min(sizeof(ureq), udata->inlen)))
 						return -EINVAL;
@@ -1659,7 +1693,7 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 			}
 		}
 	}
-	if (attr_mask & IB_QP_STATE && udata &&
+	if (attr_mask & IB_QP_STATE && udata && udata->outlen &&
 	    dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
 		struct irdma_ucontext *ucontext;
 
@@ -1794,6 +1828,7 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 			   struct ib_udata *udata)
 {
+#define IRDMA_RESIZE_CQ_MIN_REQ_LEN offsetofend(struct irdma_resize_cq_req, user_cq_buffer)
 	struct irdma_cq *iwcq = to_iwcq(ibcq);
 	struct irdma_sc_dev *dev = iwcq->sc_cq.dev;
 	struct irdma_cqp_request *cqp_request;
@@ -1816,6 +1851,9 @@ static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
 	    IRDMA_FEATURE_CQ_RESIZE))
 		return -EOPNOTSUPP;
 
+	if (udata && udata->inlen < IRDMA_RESIZE_CQ_MIN_REQ_LEN)
+		return -EINVAL;
+
 	if (entries > rf->max_cqe)
 		return -EINVAL;
 
@@ -1948,6 +1986,8 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			   const struct ib_cq_init_attr *attr,
 			   struct ib_udata *udata)
 {
+#define IRDMA_CREATE_CQ_MIN_REQ_LEN offsetofend(struct irdma_create_cq_req, user_cq_buf)
+#define IRDMA_CREATE_CQ_MIN_RESP_LEN offsetofend(struct irdma_create_cq_resp, cq_size)
 	struct ib_device *ibdev = ibcq->device;
 	struct irdma_device *iwdev = to_iwdev(ibdev);
 	struct irdma_pci_f *rf = iwdev->rf;
@@ -1966,6 +2006,11 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 	err_code = cq_validate_flags(attr->flags, dev->hw_attrs.uk_attrs.hw_rev);
 	if (err_code)
 		return err_code;
+
+	if (udata && (udata->inlen < IRDMA_CREATE_CQ_MIN_REQ_LEN ||
+		      udata->outlen < IRDMA_CREATE_CQ_MIN_RESP_LEN))
+		return -EINVAL;
+
 	err_code = irdma_alloc_rsrc(rf, rf->allocated_cqs, rf->max_cq, &cq_num,
 				    &rf->next_cq);
 	if (err_code)
@@ -2743,6 +2788,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 				       u64 virt, int access,
 				       struct ib_udata *udata)
 {
+#define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_ucontext *ucontext;
 	struct irdma_pble_alloc *palloc;
@@ -2760,6 +2806,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
+	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
+		return ERR_PTR(-EINVAL);
+
 	region = ib_umem_get(pd->device, start, len, access);
 
 	if (IS_ERR(region)) {
@@ -4291,12 +4340,16 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 				struct rdma_ah_init_attr *attr,
 				struct ib_udata *udata)
 {
+#define IRDMA_CREATE_AH_MIN_RESP_LEN offsetofend(struct irdma_create_ah_resp, rsvd)
 	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
 	struct irdma_create_ah_resp uresp;
 	struct irdma_ah *parent_ah;
 	int err;
 
+	if (udata && udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
+		return -EINVAL;
+
 	err = irdma_setup_ah(ibah, attr);
 	if (err)
 		return err;
-- 
1.8.3.1

