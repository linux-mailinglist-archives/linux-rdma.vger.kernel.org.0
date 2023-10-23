Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787887D390D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJWOPX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJWOPW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 10:15:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF9CB3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 07:15:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2649091b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698070518; x=1698675318; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/S7ArsA9xnotyaWEB4C3IL20lC7Dpbe4Gbke3+MgM8=;
        b=LggVYpNNWXBXjzgyrLfSxmUDx1hMBoaKSrlsOqgcE+P4xy5d+vOMTwGvPYeQE1KEPd
         vkrOjJ21Lmx7PkaLe3iqsONegy6T5jOGKJRVww+PzM7IHgrfcA/f8dX2VGaprLqCt4db
         uayd3hq98IIDgY9ZZ5Hs5IwK4WlnBbOhKyKwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698070518; x=1698675318;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/S7ArsA9xnotyaWEB4C3IL20lC7Dpbe4Gbke3+MgM8=;
        b=h28cijM7Q5NMTYDoqxtzLLd60Ii1pACb+WrIpaL8/I7XRJeGJpF3afFTbt42gQqRFZ
         5hz4ZMt0Zx5mVfcp9sjcbjS1V/HkggADiI1OK/eOJe5AIR9T441qAe0Z45CU4yMtZQLZ
         6E3l2j6xPYeJc3nWlpV6wGyEgVx2oCGS7qoZNQPa60t4BxbF1nmNgG4QG4L0E4SLFf1u
         uIQH0SCmhloZG3rWhyZq8fIJyTWY6j+DgD+zsWe4slvrjAzaR8/TelC/Kk3R+ULxmBHj
         PJLBqUR6Omjt51HIubwXT6wF1vQgFDMjyORtEqLRhjeW2AeHw35Lnm6IVCYKyphd6b2p
         oAlg==
X-Gm-Message-State: AOJu0YxttX23+kd4AifZ0Q4e/vugVXlDDdE6ZlnvwOIo8WlQr2Xoaz6c
        hz5cJVuoKGXEXuJPCbSnCTgLuw==
X-Google-Smtp-Source: AGHT+IHw+fq8rpkcY7ZPQwFksmW7vs4xm2RoBpg9ZkPdoemIcJbyXSHg1+V3KxSyU3MrGs/m8DK1MQ==
X-Received: by 2002:a05:6a21:3282:b0:17b:689e:c757 with SMTP id yt2-20020a056a21328200b0017b689ec757mr7963206pzb.11.1698070517781;
        Mon, 23 Oct 2023 07:15:17 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y10-20020a62ce0a000000b0069ea08a2a99sm6404299pfg.211.2023.10.23.07.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2023 07:15:16 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/2] RDMA/bnxt_re: Refactor the queue index update
Date:   Mon, 23 Oct 2023 07:03:22 -0700
Message-Id: <1698069803-1787-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
References: <1698069803-1787-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000d5bed060862da2a"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000000d5bed060862da2a

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

The queue index wrap around logic is based on power of 2 size depth.
All queues are created with power of 2 depth. This increases the
memory usage by the driver. This change is required for the next
patches that avoids the power of 2 depth requirement for each of
the queues.

Update the function that increments producer index and consumer
index during wrap around. Also, changes the index handling across
multiple functions.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 138 ++++++++++++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  20 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  17 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  37 +++++---
 6 files changed, 123 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index abbabea..b821c37 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -237,18 +237,15 @@ static void clean_nq(struct bnxt_qplib_nq *nq, struct bnxt_qplib_cq *cq)
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	struct nq_base *nqe, **nq_ptr;
 	int budget = nq->budget;
-	u32 sw_cons, raw_cons;
 	uintptr_t q_handle;
 	u16 type;
 
 	spin_lock_bh(&hwq->lock);
 	/* Service the NQ until empty */
-	raw_cons = hwq->cons;
 	while (budget--) {
-		sw_cons = HWQ_CMP(raw_cons, hwq);
 		nq_ptr = (struct nq_base **)hwq->pbl_ptr;
-		nqe = &nq_ptr[NQE_PG(sw_cons)][NQE_IDX(sw_cons)];
-		if (!NQE_CMP_VALID(nqe, raw_cons, hwq->max_elements))
+		nqe = &nq_ptr[NQE_PG(hwq->cons)][NQE_IDX(hwq->cons)];
+		if (!NQE_CMP_VALID(nqe, nq->nq_db.dbinfo.flags))
 			break;
 
 		/*
@@ -276,7 +273,8 @@ static void clean_nq(struct bnxt_qplib_nq *nq, struct bnxt_qplib_cq *cq)
 		default:
 			break;
 		}
-		raw_cons++;
+		bnxt_qplib_hwq_incr_cons(hwq->max_elements, &hwq->cons,
+					 1, &nq->nq_db.dbinfo.flags);
 	}
 	spin_unlock_bh(&hwq->lock);
 }
@@ -302,18 +300,16 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
 	struct bnxt_qplib_cq *cq;
 	int budget = nq->budget;
-	u32 sw_cons, raw_cons;
 	struct nq_base *nqe;
 	uintptr_t q_handle;
+	u32 hw_polled = 0;
 	u16 type;
 
 	spin_lock_bh(&hwq->lock);
 	/* Service the NQ until empty */
-	raw_cons = hwq->cons;
 	while (budget--) {
-		sw_cons = HWQ_CMP(raw_cons, hwq);
-		nqe = bnxt_qplib_get_qe(hwq, sw_cons, NULL);
-		if (!NQE_CMP_VALID(nqe, raw_cons, hwq->max_elements))
+		nqe = bnxt_qplib_get_qe(hwq, hwq->cons, NULL);
+		if (!NQE_CMP_VALID(nqe, nq->nq_db.dbinfo.flags))
 			break;
 
 		/*
@@ -372,12 +368,12 @@ static void bnxt_qplib_service_nq(struct tasklet_struct *t)
 				 "nqe with type = 0x%x not handled\n", type);
 			break;
 		}
-		raw_cons++;
+		hw_polled++;
+		bnxt_qplib_hwq_incr_cons(hwq->max_elements, &hwq->cons,
+					 1, &nq->nq_db.dbinfo.flags);
 	}
-	if (hwq->cons != raw_cons) {
-		hwq->cons = raw_cons;
+	if (hw_polled)
 		bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
-	}
 	spin_unlock_bh(&hwq->lock);
 }
 
@@ -505,6 +501,7 @@ static int bnxt_qplib_map_nq_db(struct bnxt_qplib_nq *nq,  u32 reg_offt)
 	pdev = nq->pdev;
 	nq_db = &nq->nq_db;
 
+	nq_db->dbinfo.flags = 0;
 	nq_db->reg.bar_id = NQ_CONS_PCI_BAR_REGION;
 	nq_db->reg.bar_base = pci_resource_start(pdev, nq_db->reg.bar_id);
 	if (!nq_db->reg.bar_base) {
@@ -649,7 +646,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 		rc = -ENOMEM;
 		goto fail;
 	}
-
+	srq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_SRQ,
 				 sizeof(req));
@@ -703,13 +700,9 @@ int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_srq *srq)
 {
 	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
-	u32 sw_prod, sw_cons, count = 0;
-
-	sw_prod = HWQ_CMP(srq_hwq->prod, srq_hwq);
-	sw_cons = HWQ_CMP(srq_hwq->cons, srq_hwq);
+	u32 count;
 
-	count = sw_prod > sw_cons ? sw_prod - sw_cons :
-				    srq_hwq->max_elements - sw_cons + sw_prod;
+	count = __bnxt_qplib_get_avail(srq_hwq);
 	if (count > srq->threshold) {
 		srq->arm_req = false;
 		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
@@ -761,7 +754,7 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
 	struct rq_wqe *srqe;
 	struct sq_sge *hw_sge;
-	u32 sw_prod, sw_cons, count = 0;
+	u32 count = 0;
 	int i, next;
 
 	spin_lock(&srq_hwq->lock);
@@ -775,8 +768,7 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	srq->start_idx = srq->swq[next].next_idx;
 	spin_unlock(&srq_hwq->lock);
 
-	sw_prod = HWQ_CMP(srq_hwq->prod, srq_hwq);
-	srqe = bnxt_qplib_get_qe(srq_hwq, sw_prod, NULL);
+	srqe = bnxt_qplib_get_qe(srq_hwq, srq_hwq->prod, NULL);
 	memset(srqe, 0, srq->wqe_size);
 	/* Calculate wqe_size16 and data_len */
 	for (i = 0, hw_sge = (struct sq_sge *)srqe->data;
@@ -792,17 +784,10 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	srqe->wr_id[0] = cpu_to_le32((u32)next);
 	srq->swq[next].wr_id = wqe->wr_id;
 
-	srq_hwq->prod++;
+	bnxt_qplib_hwq_incr_prod(&srq->dbinfo, srq_hwq, srq->dbinfo.max_slot);
 
 	spin_lock(&srq_hwq->lock);
-	sw_prod = HWQ_CMP(srq_hwq->prod, srq_hwq);
-	/* retaining srq_hwq->cons for this logic
-	 * actually the lock is only required to
-	 * read srq_hwq->cons.
-	 */
-	sw_cons = HWQ_CMP(srq_hwq->cons, srq_hwq);
-	count = sw_prod > sw_cons ? sw_prod - sw_cons :
-				    srq_hwq->max_elements - sw_cons + sw_prod;
+	count = __bnxt_qplib_get_avail(srq_hwq);
 	spin_unlock(&srq_hwq->lock);
 	/* Ring DB */
 	bnxt_qplib_ring_prod_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ);
@@ -849,6 +834,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u32 tbl_indx;
 	int rc;
 
+	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP1,
 				 sizeof(req));
@@ -885,6 +871,7 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* RQ */
 	if (rq->max_wqe) {
+		rq->dbinfo.flags = 0;
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
 		hwq_attr.stride = sizeof(struct sq_sge);
@@ -992,6 +979,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	u32 tbl_indx;
 	u16 nsge;
 
+	sq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP,
 				 sizeof(req));
@@ -1040,6 +1028,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* RQ */
 	if (!qp->srq) {
+		rq->dbinfo.flags = 0;
 		hwq_attr.res = res;
 		hwq_attr.sginfo = &rq->sg_info;
 		hwq_attr.stride = sizeof(struct sq_sge);
@@ -1454,12 +1443,15 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp)
 {
 	struct bnxt_qplib_hwq *cq_hwq = &cq->hwq;
+	u32 peek_flags, peek_cons;
 	struct cq_base *hw_cqe;
 	int i;
 
+	peek_flags = cq->dbinfo.flags;
+	peek_cons = cq_hwq->cons;
 	for (i = 0; i < cq_hwq->max_elements; i++) {
-		hw_cqe = bnxt_qplib_get_qe(cq_hwq, i, NULL);
-		if (!CQE_CMP_VALID(hw_cqe, i, cq_hwq->max_elements))
+		hw_cqe = bnxt_qplib_get_qe(cq_hwq, peek_cons, NULL);
+		if (!CQE_CMP_VALID(hw_cqe, peek_flags))
 			continue;
 		/*
 		 * The valid test of the entry must be done first before
@@ -1489,6 +1481,8 @@ static void __clean_cq(struct bnxt_qplib_cq *cq, u64 qp)
 		default:
 			break;
 		}
+		bnxt_qplib_hwq_incr_cons(cq_hwq->max_elements, &peek_cons,
+					 1, &peek_flags);
 	}
 }
 
@@ -1961,7 +1955,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	bnxt_qplib_fill_psn_search(qp, wqe, swq);
 queue_err:
 	bnxt_qplib_swq_mod_start(sq, wqe_idx);
-	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
+	bnxt_qplib_hwq_incr_prod(&sq->dbinfo, hwq, swq->slots);
 	qp->wqe_cnt++;
 done:
 	if (sch_handler) {
@@ -2049,7 +2043,7 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	base_hdr->wr_id[0] = cpu_to_le32(wqe_idx);
 queue_err:
 	bnxt_qplib_swq_mod_start(rq, wqe_idx);
-	bnxt_qplib_hwq_incr_prod(hwq, swq->slots);
+	bnxt_qplib_hwq_incr_prod(&rq->dbinfo, hwq, swq->slots);
 done:
 	if (sch_handler) {
 		nq_work = kzalloc(sizeof(*nq_work), GFP_ATOMIC);
@@ -2086,6 +2080,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 		return -EINVAL;
 	}
 
+	cq->dbinfo.flags = 0;
 	hwq_attr.res = res;
 	hwq_attr.depth = cq->max_wqe;
 	hwq_attr.stride = sizeof(struct cq_base);
@@ -2101,7 +2096,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 	req.dpi = cpu_to_le32(cq->dpi->dpi);
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
-	req.cq_size = cpu_to_le32(cq->hwq.max_elements);
+	req.cq_size = cpu_to_le32(cq->max_wqe);
 	pbl = &cq->hwq.pbl[PBL_LVL_0];
 	pg_sz_lvl = (bnxt_qplib_base_pg_size(&cq->hwq) <<
 		     CMDQ_CREATE_CQ_PG_SIZE_SFT);
@@ -2144,6 +2139,8 @@ void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
 {
 	bnxt_qplib_free_hwq(res, &cq->hwq);
 	memcpy(&cq->hwq, &cq->resize_hwq, sizeof(cq->hwq));
+       /* Reset only the cons bit in the flags */
+	cq->dbinfo.flags &= ~(1UL << BNXT_QPLIB_FLAG_EPOCH_CONS_SHIFT);
 }
 
 int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
@@ -2240,7 +2237,8 @@ static int __flush_sq(struct bnxt_qplib_q *sq, struct bnxt_qplib_qp *qp,
 		cqe++;
 		(*budget)--;
 skip_compl:
-		bnxt_qplib_hwq_incr_cons(&sq->hwq, sq->swq[last].slots);
+		bnxt_qplib_hwq_incr_cons(sq->hwq.max_elements, &sq->hwq.cons,
+					 sq->swq[last].slots, &sq->dbinfo.flags);
 		sq->swq_last = sq->swq[last].next_idx;
 	}
 	*pcqe = cqe;
@@ -2287,7 +2285,8 @@ static int __flush_rq(struct bnxt_qplib_q *rq, struct bnxt_qplib_qp *qp,
 		cqe->wr_id = rq->swq[last].wr_id;
 		cqe++;
 		(*budget)--;
-		bnxt_qplib_hwq_incr_cons(&rq->hwq, rq->swq[last].slots);
+		bnxt_qplib_hwq_incr_cons(rq->hwq.max_elements, &rq->hwq.cons,
+					 rq->swq[last].slots, &rq->dbinfo.flags);
 		rq->swq_last = rq->swq[last].next_idx;
 	}
 	*pcqe = cqe;
@@ -2316,7 +2315,7 @@ void bnxt_qplib_mark_qp_error(void *qp_handle)
 static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 		     u32 cq_cons, u32 swq_last, u32 cqe_sq_cons)
 {
-	u32 peek_sw_cq_cons, peek_raw_cq_cons, peek_sq_cons_idx;
+	u32 peek_sw_cq_cons, peek_sq_cons_idx, peek_flags;
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct cq_req *peek_req_hwcqe;
 	struct bnxt_qplib_qp *peek_qp;
@@ -2347,16 +2346,14 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 	}
 	if (sq->condition) {
 		/* Peek at the completions */
-		peek_raw_cq_cons = cq->hwq.cons;
+		peek_flags = cq->dbinfo.flags;
 		peek_sw_cq_cons = cq_cons;
 		i = cq->hwq.max_elements;
 		while (i--) {
-			peek_sw_cq_cons = HWQ_CMP((peek_sw_cq_cons), &cq->hwq);
 			peek_hwcqe = bnxt_qplib_get_qe(&cq->hwq,
 						       peek_sw_cq_cons, NULL);
 			/* If the next hwcqe is VALID */
-			if (CQE_CMP_VALID(peek_hwcqe, peek_raw_cq_cons,
-					  cq->hwq.max_elements)) {
+			if (CQE_CMP_VALID(peek_hwcqe, peek_flags)) {
 			/*
 			 * The valid test of the entry must be done first before
 			 * reading any further.
@@ -2399,8 +2396,9 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 				rc = -EINVAL;
 				goto out;
 			}
-			peek_sw_cq_cons++;
-			peek_raw_cq_cons++;
+			bnxt_qplib_hwq_incr_cons(cq->hwq.max_elements,
+						 &peek_sw_cq_cons,
+						 1, &peek_flags);
 		}
 		dev_err(&cq->hwq.pdev->dev,
 			"Should not have come here! cq_cons=0x%x qp=0x%x sq cons sw=0x%x hw=0x%x\n",
@@ -2487,7 +2485,8 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			}
 		}
 skip:
-		bnxt_qplib_hwq_incr_cons(&sq->hwq, swq->slots);
+		bnxt_qplib_hwq_incr_cons(sq->hwq.max_elements, &sq->hwq.cons,
+					 swq->slots, &sq->dbinfo.flags);
 		sq->swq_last = swq->next_idx;
 		if (sq->single)
 			break;
@@ -2514,7 +2513,8 @@ static void bnxt_qplib_release_srqe(struct bnxt_qplib_srq *srq, u32 tag)
 	srq->swq[srq->last_idx].next_idx = (int)tag;
 	srq->last_idx = (int)tag;
 	srq->swq[srq->last_idx].next_idx = -1;
-	srq->hwq.cons++; /* Support for SRQE counter */
+	bnxt_qplib_hwq_incr_cons(srq->hwq.max_elements, &srq->hwq.cons,
+				 srq->dbinfo.max_slot, &srq->dbinfo.flags);
 	spin_unlock(&srq->hwq.lock);
 }
 
@@ -2583,7 +2583,8 @@ static int bnxt_qplib_cq_process_res_rc(struct bnxt_qplib_cq *cq,
 		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		bnxt_qplib_hwq_incr_cons(rq->hwq.max_elements, &rq->hwq.cons,
+					 swq->slots, &rq->dbinfo.flags);
 		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
@@ -2669,7 +2670,8 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		bnxt_qplib_hwq_incr_cons(rq->hwq.max_elements, &rq->hwq.cons,
+					 swq->slots, &rq->dbinfo.flags);
 		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
@@ -2686,14 +2688,11 @@ static int bnxt_qplib_cq_process_res_ud(struct bnxt_qplib_cq *cq,
 bool bnxt_qplib_is_cq_empty(struct bnxt_qplib_cq *cq)
 {
 	struct cq_base *hw_cqe;
-	u32 sw_cons, raw_cons;
 	bool rc = true;
 
-	raw_cons = cq->hwq.cons;
-	sw_cons = HWQ_CMP(raw_cons, &cq->hwq);
-	hw_cqe = bnxt_qplib_get_qe(&cq->hwq, sw_cons, NULL);
+	hw_cqe = bnxt_qplib_get_qe(&cq->hwq, cq->hwq.cons, NULL);
 	 /* Check for Valid bit. If the CQE is valid, return false */
-	rc = !CQE_CMP_VALID(hw_cqe, raw_cons, cq->hwq.max_elements);
+	rc = !CQE_CMP_VALID(hw_cqe, cq->dbinfo.flags);
 	return rc;
 }
 
@@ -2775,7 +2774,8 @@ static int bnxt_qplib_cq_process_res_raweth_qp1(struct bnxt_qplib_cq *cq,
 		cqe->wr_id = swq->wr_id;
 		cqe++;
 		(*budget)--;
-		bnxt_qplib_hwq_incr_cons(&rq->hwq, swq->slots);
+		bnxt_qplib_hwq_incr_cons(rq->hwq.max_elements, &rq->hwq.cons,
+					 swq->slots, &rq->dbinfo.flags);
 		rq->swq_last = swq->next_idx;
 		*pcqe = cqe;
 
@@ -2848,7 +2848,8 @@ static int bnxt_qplib_cq_process_terminal(struct bnxt_qplib_cq *cq,
 			cqe++;
 			(*budget)--;
 		}
-		bnxt_qplib_hwq_incr_cons(&sq->hwq, sq->swq[swq_last].slots);
+		bnxt_qplib_hwq_incr_cons(sq->hwq.max_elements, &sq->hwq.cons,
+					 sq->swq[swq_last].slots, &sq->dbinfo.flags);
 		sq->swq_last = sq->swq[swq_last].next_idx;
 	}
 	*pcqe = cqe;
@@ -2933,19 +2934,17 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 		       int num_cqes, struct bnxt_qplib_qp **lib_qp)
 {
 	struct cq_base *hw_cqe;
-	u32 sw_cons, raw_cons;
 	int budget, rc = 0;
+	u32 hw_polled = 0;
 	u8 type;
 
-	raw_cons = cq->hwq.cons;
 	budget = num_cqes;
 
 	while (budget) {
-		sw_cons = HWQ_CMP(raw_cons, &cq->hwq);
-		hw_cqe = bnxt_qplib_get_qe(&cq->hwq, sw_cons, NULL);
+		hw_cqe = bnxt_qplib_get_qe(&cq->hwq, cq->hwq.cons, NULL);
 
 		/* Check for Valid bit */
-		if (!CQE_CMP_VALID(hw_cqe, raw_cons, cq->hwq.max_elements))
+		if (!CQE_CMP_VALID(hw_cqe, cq->dbinfo.flags))
 			break;
 
 		/*
@@ -2960,7 +2959,7 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 			rc = bnxt_qplib_cq_process_req(cq,
 						       (struct cq_req *)hw_cqe,
 						       &cqe, &budget,
-						       sw_cons, lib_qp);
+						       cq->hwq.cons, lib_qp);
 			break;
 		case CQ_BASE_CQE_TYPE_RES_RC:
 			rc = bnxt_qplib_cq_process_res_rc(cq,
@@ -3006,12 +3005,13 @@ int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
 				dev_err(&cq->hwq.pdev->dev,
 					"process_cqe error rc = 0x%x\n", rc);
 		}
-		raw_cons++;
+		hw_polled++;
+		bnxt_qplib_hwq_incr_cons(cq->hwq.max_elements, &cq->hwq.cons,
+					 1, &cq->dbinfo.flags);
+
 	}
-	if (cq->hwq.cons != raw_cons) {
-		cq->hwq.cons = raw_cons;
+	if (hw_polled)
 		bnxt_qplib_ring_db(&cq->dbinfo, DBC_DBC_TYPE_CQ);
-	}
 exit:
 	return num_cqes - budget;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 404b851..23c27cb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -348,9 +348,21 @@ struct bnxt_qplib_qp {
 #define CQE_IDX(x)		((x) & CQE_MAX_IDX_PER_PG)
 
 #define ROCE_CQE_CMP_V			0
-#define CQE_CMP_VALID(hdr, raw_cons, cp_bit)			\
+#define CQE_CMP_VALID(hdr, pass)			\
 	(!!((hdr)->cqe_type_toggle & CQ_BASE_TOGGLE) ==		\
-	   !((raw_cons) & (cp_bit)))
+	   !((pass) & BNXT_QPLIB_FLAG_EPOCH_CONS_MASK))
+
+static inline u32 __bnxt_qplib_get_avail(struct bnxt_qplib_hwq *hwq)
+{
+	int cons, prod, avail;
+
+	cons = hwq->cons;
+	prod = hwq->prod;
+	avail = cons - prod;
+	if (cons <= prod)
+		avail += hwq->depth;
+	return avail;
+}
 
 static inline bool bnxt_qplib_queue_full(struct bnxt_qplib_q *que,
 					 u8 slots)
@@ -443,9 +455,9 @@ struct bnxt_qplib_cq {
 #define NQE_PG(x)		(((x) & ~NQE_MAX_IDX_PER_PG) / NQE_CNT_PER_PG)
 #define NQE_IDX(x)		((x) & NQE_MAX_IDX_PER_PG)
 
-#define NQE_CMP_VALID(hdr, raw_cons, cp_bit)			\
+#define NQE_CMP_VALID(hdr, pass)			\
 	(!!(le32_to_cpu((hdr)->info63_v[0]) & NQ_BASE_V) ==	\
-	   !((raw_cons) & (cp_bit)))
+	   !((pass) & BNXT_QPLIB_FLAG_EPOCH_CONS_MASK))
 
 #define BNXT_QPLIB_NQE_MAX_CNT		(128 * 1024)
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index c8c4017..7ca2bda 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -727,17 +727,15 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
 	struct creq_base *creqe;
-	u32 sw_cons, raw_cons;
 	unsigned long flags;
 	u32 num_wakeup = 0;
+	u32 hw_polled = 0;
 
 	/* Service the CREQ until budget is over */
 	spin_lock_irqsave(&hwq->lock, flags);
-	raw_cons = hwq->cons;
 	while (budget > 0) {
-		sw_cons = HWQ_CMP(raw_cons, hwq);
-		creqe = bnxt_qplib_get_qe(hwq, sw_cons, NULL);
-		if (!CREQ_CMP_VALID(creqe, raw_cons, hwq->max_elements))
+		creqe = bnxt_qplib_get_qe(hwq, hwq->cons, NULL);
+		if (!CREQ_CMP_VALID(creqe, creq->creq_db.dbinfo.flags))
 			break;
 		/* The valid test of the entry must be done first before
 		 * reading any further.
@@ -768,15 +766,15 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 					 type);
 			break;
 		}
-		raw_cons++;
 		budget--;
+		hw_polled++;
+		bnxt_qplib_hwq_incr_cons(hwq->max_elements, &hwq->cons,
+					 1, &creq->creq_db.dbinfo.flags);
 	}
 
-	if (hwq->cons != raw_cons) {
-		hwq->cons = raw_cons;
+	if (hw_polled)
 		bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo,
 				      rcfw->res->cctx, true);
-	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
 	if (num_wakeup)
 		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
@@ -1106,6 +1104,7 @@ static int bnxt_qplib_map_creq_db(struct bnxt_qplib_rcfw *rcfw, u32 reg_offt)
 	pdev = rcfw->pdev;
 	creq_db = &rcfw->creq.creq_db;
 
+	creq_db->dbinfo.flags = 0;
 	creq_db->reg.bar_id = RCFW_COMM_CONS_PCI_BAR_REGION;
 	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
 	if (!creq_db->reg.bar_id)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 7b31bee..45996e6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -141,9 +141,9 @@ struct bnxt_qplib_crsbe {
 /* Allocate 1 per QP for async error notification for now */
 #define BNXT_QPLIB_CREQE_MAX_CNT	(64 * 1024)
 #define BNXT_QPLIB_CREQE_UNITS		16	/* 16-Bytes per prod unit */
-#define CREQ_CMP_VALID(hdr, raw_cons, cp_bit)			\
+#define CREQ_CMP_VALID(hdr, pass)			\
 	(!!((hdr)->v & CREQ_BASE_V) ==				\
-	   !((raw_cons) & (cp_bit)))
+	   !((pass) & BNXT_QPLIB_FLAG_EPOCH_CONS_MASK))
 #define CREQ_ENTRY_POLL_BUDGET		0x100
 
 /* HWQ */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 157db6b..ae2bde3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -343,7 +343,7 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 	hwq->cons = 0;
 	hwq->pdev = pdev;
 	hwq->depth = hwq_attr->depth;
-	hwq->max_elements = depth;
+	hwq->max_elements = hwq->depth;
 	hwq->element_size = stride;
 	hwq->qe_ppg = pg_size / stride;
 	/* For direct access to the elements */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 5949f00..3e3383b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -186,6 +186,14 @@ struct bnxt_qplib_db_info {
 	struct bnxt_qplib_hwq	*hwq;
 	u32			xid;
 	u32			max_slot;
+	u32                     flags;
+};
+
+enum bnxt_qplib_db_info_flags_mask {
+	BNXT_QPLIB_FLAG_EPOCH_CONS_SHIFT        = 0x0UL,
+	BNXT_QPLIB_FLAG_EPOCH_PROD_SHIFT        = 0x1UL,
+	BNXT_QPLIB_FLAG_EPOCH_CONS_MASK         = 0x1UL,
+	BNXT_QPLIB_FLAG_EPOCH_PROD_MASK         = 0x2UL,
 };
 
 /* Tables */
@@ -396,24 +404,34 @@ void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res);
 
 int bnxt_qplib_determine_atomics(struct pci_dev *dev);
 
-static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
+static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_db_info *dbinfo,
+					    struct bnxt_qplib_hwq *hwq, u32 cnt)
 {
-	hwq->prod = (hwq->prod + cnt) % hwq->depth;
+	/* move prod and update toggle/epoch if wrap around */
+	hwq->prod += cnt;
+	if (hwq->prod >= hwq->depth) {
+		hwq->prod %= hwq->depth;
+		dbinfo->flags ^= 1UL << BNXT_QPLIB_FLAG_EPOCH_PROD_SHIFT;
+	}
 }
 
-static inline void bnxt_qplib_hwq_incr_cons(struct bnxt_qplib_hwq *hwq,
-					    u32 cnt)
+static inline void bnxt_qplib_hwq_incr_cons(u32 max_elements, u32 *cons, u32 cnt,
+					    u32 *dbinfo_flags)
 {
-	hwq->cons = (hwq->cons + cnt) % hwq->depth;
+	/* move cons and update toggle/epoch if wrap around */
+	*cons += cnt;
+	if (*cons >= max_elements) {
+		*cons %= max_elements;
+		*dbinfo_flags ^= 1UL << BNXT_QPLIB_FLAG_EPOCH_CONS_SHIFT;
+	}
 }
 
 static inline void bnxt_qplib_ring_db32(struct bnxt_qplib_db_info *info,
 					bool arm)
 {
-	u32 key;
+	u32 key = 0;
 
-	key = info->hwq->cons & (info->hwq->max_elements - 1);
-	key |= (CMPL_DOORBELL_IDX_VALID |
+	key |= info->hwq->cons | (CMPL_DOORBELL_IDX_VALID |
 		(CMPL_DOORBELL_KEY_CMPL & CMPL_DOORBELL_KEY_MASK));
 	if (!arm)
 		key |= CMPL_DOORBELL_MASK;
@@ -427,8 +445,7 @@ static inline void bnxt_qplib_ring_db(struct bnxt_qplib_db_info *info,
 
 	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
 	key <<= 32;
-	key |= (info->hwq->cons & (info->hwq->max_elements - 1)) &
-		DBC_DBC_INDEX_MASK;
+	key |= (info->hwq->cons & DBC_DBC_INDEX_MASK);
 	writeq(key, info->db);
 }
 
-- 
2.5.5


--0000000000000d5bed060862da2a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN2K2fv8o6cU
geQGUurcMsbEv6684hVCuVDsVMNCVSJTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTAyMzE0MTUxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA8l8ykp749dQgGNZ9nZETHYxEUHasM
QFR37fvQA18fCjRxdV2cSj3G2u9/j5dz+e5TG4bKbRwKgaCNl1Sl6oRHdaQcJRD1IFfk+FpldiLi
6t6Vl7FgEkzb49nL5zqfOMJGJD3Kh+x8KM7+iH+hAh2Eot4NpR4UB57ndWfdJEQHQIyetvIkuDDC
l4D/8FGZYottBWNXz3hDzbTyf5fqwYNst/MHjuqT6mcTNFEjCbABr27/msLy3mHNOrkvwKdxX7XH
SGqBxvSsPQFscGuNKzW4ThgQ4vAFLZjfv/Rn0/4ZU5EtCB+eoM5BhaOIRkhftA5MkuwkPl07wO0O
VWrgTZfv
--0000000000000d5bed060862da2a--
