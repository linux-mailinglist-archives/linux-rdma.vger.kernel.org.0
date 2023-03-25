Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B476C9029
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Mar 2023 19:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCYSot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Mar 2023 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYSoo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Mar 2023 14:44:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69BEC76
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 11:44:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw3so4744371plb.6
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679769881;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/wk4BmDzB193RfEIUJ9vAvka2wzdSE5XKr2TNVOG1w=;
        b=hrmOgoeYffDcrtdEZyAObYCMhIMbtlJxiMldIPDkdrFFHCkZXmPXnuTgbZ9GsaiHyv
         +pvnCVKP2md53AL6v48o5Gx8nXcgc0FVjTdEHTjmdjEUHxnQHGv2ccuVB3zKhWVzeItE
         PKLHHW7IUNtVlAulKBfEz4eq6CdwJFI00WLsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679769881;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/wk4BmDzB193RfEIUJ9vAvka2wzdSE5XKr2TNVOG1w=;
        b=hvP7DzeyVnfQRzseYrMWTIozu1e+ZCm7nQ7fynFN7LNQ/fzvTfIscO8bUNrI/Ba4jf
         EQ4lq04FOfxBBBOJkiCmic3rbO32Coj+7lo6IUHNz+gRtdPRWF9P3t5rTKumORuJ0d3j
         wDvA0tWC9pQuJD62sG3mPqDieFdlYQBr8ZoBVcWsB7O7YCPkFpy1H0T1Z7D+NtinW8nD
         fWgeozJ20vu8blnAIwqaY2Xn/T4Hc3I4Yzbg2WZThvtiHVo6bGefnj6Vbbll0CIWJj41
         b7XFdaRWpc6da9lZsa5SVWMtjQRGntSCHzk8vau4PqnHGAa1fRJx27RGdWJWUyqlpnjh
         nSqw==
X-Gm-Message-State: AAQBX9fec5GSGDLFZYMSmLKUqqP2wBl9nSLRkg1kF2FLXfWdxpVYByb5
        HAp+7rnaiSR/mgGFtZwa/1lpGw==
X-Google-Smtp-Source: AKy350Yqvnfn8tLmwZaK6vJpSD/pDtQqeja2isow2L+qoEMWRfclz6CNqBfG+2DmVcAvwch5nDYiFg==
X-Received: by 2002:a17:902:f785:b0:19e:2860:3ae8 with SMTP id q5-20020a170902f78500b0019e28603ae8mr7963464pln.33.1679769880909;
        Sat, 25 Mar 2023 11:44:40 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902b10c00b0019a70a42b0asm16283031plr.169.2023.03.25.11.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2023 11:44:39 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 4/7] RDMA/bnxt_re: Reduce number of argumets to control path command APIs
Date:   Sat, 25 Mar 2023 11:44:11 -0700
Message-Id: <1679769854-30605-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1679769854-30605-1-git-send-email-selvin.xavier@broadcom.com>
References: <1679769854-30605-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000014667505f7bde76b"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000014667505f7bde76b

Reducing the number of arguments to bnxt_qplib_rcfw_send_message
by enclosing all its arguments into a command message structure.
Use the same struct while passing the command information to
send_message.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 104 +++++++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  70 +++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  25 +++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 138 +++++++++++++++++------------
 4 files changed, 199 insertions(+), 138 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 6152df8..e2ab742 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -581,8 +581,9 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 			   struct bnxt_qplib_srq *srq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_destroy_srq req;
-	struct creq_destroy_srq_resp resp;
+	struct creq_destroy_srq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_destroy_srq req = {};
 	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -592,8 +593,8 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 	/* Configure the request */
 	req.srq_cid = cpu_to_le32(srq->id);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (struct cmdq_base *)&req,
-					  (struct creq_base *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	kfree(srq->swq);
 	if (rc)
 		return;
@@ -605,8 +606,9 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
-	struct creq_create_srq_resp resp;
-	struct cmdq_create_srq req;
+	struct creq_create_srq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_create_srq req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u16 pg_sz_lvl;
 	int rc, idx;
@@ -646,8 +648,8 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	req.pd_id = cpu_to_le32(srq->pd->id);
 	req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto fail;
 
@@ -702,10 +704,11 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_query_srq req;
-	struct creq_query_srq_resp resp;
+	struct creq_query_srq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_srq_resp_sb *sb;
+	struct cmdq_query_srq req = {};
 	int rc = 0;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -719,8 +722,9 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
 	req.srq_cid = cpu_to_le32(srq->id);
 	sb = sbuf->sb;
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	srq->threshold = le16_to_cpu(sb->srq_limit);
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
 
@@ -814,10 +818,11 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct creq_create_qp1_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
-	struct creq_create_qp1_resp resp;
-	struct cmdq_create_qp1 req;
+	struct cmdq_create_qp1 req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
@@ -827,7 +832,6 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_QP1,
 				 sizeof(req));
-
 	/* General */
 	req.type = qp->type;
 	req.dpi = cpu_to_le32(qp->dpi->dpi);
@@ -895,8 +899,8 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	req.qp_flags = cpu_to_le32(qp_flags);
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto fail;
 
@@ -956,13 +960,14 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
+	struct creq_create_qp_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_q *sq = &qp->sq;
 	struct bnxt_qplib_q *rq = &qp->rq;
-	struct creq_create_qp_resp resp;
+	struct cmdq_create_qp req = {};
 	int rc, req_size, psn_sz = 0;
 	struct bnxt_qplib_hwq *xrrq;
 	struct bnxt_qplib_pbl *pbl;
-	struct cmdq_create_qp req;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
 	u32 tbl_indx;
@@ -1103,8 +1108,9 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	}
 	req.pd_id = cpu_to_le32(qp->pd->id);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto fail;
 
@@ -1236,8 +1242,9 @@ static void __filter_modify_flags(struct bnxt_qplib_qp *qp)
 int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_modify_qp req;
-	struct creq_modify_qp_resp resp;
+	struct creq_modify_qp_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_modify_qp req = {};
 	u32 temp32[4];
 	u32 bmask;
 	int rc;
@@ -1330,8 +1337,8 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	req.vlan_pcp_vlan_dei_vlan_id = cpu_to_le16(qp->vlan_id);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),  sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 	qp->cur_qp_state = qp->state;
@@ -1341,10 +1348,11 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_query_qp req;
-	struct creq_query_qp_resp resp;
+	struct creq_query_qp_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_qp_resp_sb *sb;
+	struct cmdq_query_qp req = {};
 	u32 temp32[4];
 	int i, rc = 0;
 
@@ -1359,8 +1367,9 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	req.qp_cid = cpu_to_le32(qp->id);
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto bail;
 	/* Extract the context from the side buffer */
@@ -1467,8 +1476,9 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_destroy_qp req;
-	struct creq_destroy_qp_resp resp;
+	struct creq_destroy_qp_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_destroy_qp req = {};
 	u32 tbl_indx;
 	int rc;
 
@@ -1481,8 +1491,9 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 				 sizeof(req));
 
 	req.qp_cid = cpu_to_le32(qp->id);
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc) {
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
@@ -2044,9 +2055,10 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
-	struct creq_create_cq_resp resp;
+	struct creq_create_cq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_create_cq req = {};
 	struct bnxt_qplib_pbl *pbl;
-	struct cmdq_create_cq req;
 	u32 pg_sz_lvl;
 	int rc;
 
@@ -2080,9 +2092,9 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	req.cq_fco_cnq_id = cpu_to_le32(
 			(cq->cnq_hw_ring_id & CMDQ_CREATE_CQ_CNQ_ID_MASK) <<
 			 CMDQ_CREATE_CQ_CNQ_ID_SFT);
-
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto fail;
 
@@ -2122,6 +2134,7 @@ int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_resize_cq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_resize_cq req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 pg_sz, lvl, new_sz;
@@ -2149,16 +2162,18 @@ int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
 	req.new_cq_size_pg_size_lvl = cpu_to_le32(new_sz | pg_sz | lvl);
 	req.new_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	return rc;
 }
 
 int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_destroy_cq req;
-	struct creq_destroy_cq_resp resp;
+	struct creq_destroy_cq_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_destroy_cq req = {};
 	u16 total_cnq_events;
 	int rc;
 
@@ -2167,8 +2182,9 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 				 sizeof(req));
 
 	req.cq_cid = cpu_to_le32(cq->id);
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 	total_cnq_events = le16_to_cpu(resp.total_cnq_events);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 1eab451..7403a4e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -85,8 +85,8 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
 	return count ? 0 : -ETIMEDOUT;
 };
 
-static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
-			  struct creq_base *resp, void *sb, u8 is_block)
+static int __send_message(struct bnxt_qplib_rcfw *rcfw,
+			  struct bnxt_qplib_cmdqmsg *msg)
 {
 	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
 	struct bnxt_qplib_hwq *hwq = &cmdq->hwq;
@@ -101,7 +101,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 
 	pdev = rcfw->pdev;
 
-	opcode = req->opcode;
+	opcode = msg->req->opcode;
 	if (!test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
 	    (opcode != CMDQ_BASE_OPCODE_QUERY_FUNC &&
 	     opcode != CMDQ_BASE_OPCODE_INITIALIZE_FW &&
@@ -124,7 +124,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 	 * cmdqe
 	 */
 	spin_lock_irqsave(&hwq->lock, flags);
-	if (req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
+	if (msg->req->cmd_size >= HWQ_FREE_SLOTS(hwq)) {
 		dev_err(&pdev->dev, "RCFW: CMDQ is full!\n");
 		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EAGAIN;
@@ -133,36 +133,36 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 
 	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
 	cbit = cookie % rcfw->cmdq_depth;
-	if (is_block)
+	if (msg->block)
 		cookie |= RCFW_CMD_IS_BLOCKING;
 
 	set_bit(cbit, cmdq->cmdq_bitmap);
-	req->cookie = cpu_to_le16(cookie);
+	msg->req->cookie = cpu_to_le16(cookie);
 	crsqe = &rcfw->crsqe_tbl[cbit];
 	if (crsqe->resp) {
 		spin_unlock_irqrestore(&hwq->lock, flags);
 		return -EBUSY;
 	}
 
-	size = req->cmd_size;
+	size = msg->req->cmd_size;
 	/* change the cmd_size to the number of 16byte cmdq unit.
 	 * req->cmd_size is modified here
 	 */
-	bnxt_qplib_set_cmd_slots(req);
+	bnxt_qplib_set_cmd_slots(msg->req);
 
-	memset(resp, 0, sizeof(*resp));
-	crsqe->resp = (struct creq_qp_event *)resp;
-	crsqe->resp->cookie = req->cookie;
-	crsqe->req_size = req->cmd_size;
-	if (req->resp_size && sb) {
-		struct bnxt_qplib_rcfw_sbuf *sbuf = sb;
+	memset(msg->resp, 0, sizeof(*msg->resp));
+	crsqe->resp = (struct creq_qp_event *)msg->resp;
+	crsqe->resp->cookie = msg->req->cookie;
+	crsqe->req_size = msg->req->cmd_size;
+	if (msg->req->resp_size && msg->sb) {
+		struct bnxt_qplib_rcfw_sbuf *sbuf = msg->sb;
 
-		req->resp_addr = cpu_to_le64(sbuf->dma_addr);
-		req->resp_size = (sbuf->size + BNXT_QPLIB_CMDQE_UNITS - 1) /
+		msg->req->resp_addr = cpu_to_le64(sbuf->dma_addr);
+		msg->req->resp_size = (sbuf->size + BNXT_QPLIB_CMDQE_UNITS - 1) /
 				  BNXT_QPLIB_CMDQE_UNITS;
 	}
 
-	preq = (u8 *)req;
+	preq = (u8 *)msg->req;
 	do {
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(hwq->prod, hwq);
@@ -191,7 +191,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 		cmdq_prod |= BIT(FIRMWARE_FIRST_FLAG);
 		clear_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
 	}
-
 	/* ring CMDQ DB */
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
@@ -203,11 +202,9 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 }
 
 int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
-				 struct cmdq_base *req,
-				 struct creq_base *resp,
-				 void *sb, u8 is_block)
+				 struct bnxt_qplib_cmdqmsg *msg)
 {
-	struct creq_qp_event *evnt = (struct creq_qp_event *)resp;
+	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	u16 cookie;
 	u8 opcode, retry_cnt = 0xFF;
 	int rc = 0;
@@ -217,9 +214,9 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		return 0;
 
 	do {
-		opcode = req->opcode;
-		rc = __send_message(rcfw, req, resp, sb, is_block);
-		cookie = le16_to_cpu(req->cookie) & RCFW_MAX_COOKIE_VALUE;
+		opcode = msg->req->opcode;
+		rc = __send_message(rcfw, msg);
+		cookie = le16_to_cpu(msg->req->cookie) & RCFW_MAX_COOKIE_VALUE;
 		if (!rc)
 			break;
 
@@ -229,11 +226,11 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 				cookie, opcode);
 			return rc;
 		}
-		is_block ? mdelay(1) : usleep_range(500, 1000);
+		msg->block ? mdelay(1) : usleep_range(500, 1000);
 
 	} while (retry_cnt--);
 
-	if (is_block)
+	if (msg->block)
 		rc = __block_for_resp(rcfw, cookie);
 	else
 		rc = __wait_for_resp(rcfw, cookie);
@@ -452,15 +449,17 @@ static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
 /* RCFW */
 int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 {
-	struct cmdq_deinitialize_fw req;
-	struct creq_deinitialize_fw_resp resp;
+	struct creq_deinitialize_fw_resp resp = {};
+	struct cmdq_deinitialize_fw req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_DEINITIALIZE_FW,
 				 sizeof(req));
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL,
+				sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
@@ -471,8 +470,9 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn)
 {
-	struct creq_initialize_fw_resp resp;
-	struct cmdq_initialize_fw req;
+	struct creq_initialize_fw_resp resp = {};
+	struct cmdq_initialize_fw req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	u8 pgsz, lvl;
 	int rc;
 
@@ -547,8 +547,8 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 
 skip_ctx_setup:
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 	set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index b7f4d0a..5d619ce 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -61,7 +61,6 @@ struct bnxt_qplib_cmdqe {
 static inline void bnxt_qplib_rcfw_cmd_prep(struct cmdq_base *req,
 					    u8 opcode, u8 cmd_size)
 {
-	memset(req, 0, cmd_size);
 	req->opcode = opcode;
 	req->cmd_size = cmd_size;
 }
@@ -191,6 +190,27 @@ struct bnxt_qplib_rcfw {
 	u32 cmdq_depth;
 };
 
+struct bnxt_qplib_cmdqmsg {
+	struct cmdq_base	*req;
+	struct creq_base	*resp;
+	void			*sb;
+	u32			req_sz;
+	u32			res_sz;
+	u8			block;
+};
+
+static inline void bnxt_qplib_fill_cmdqmsg(struct bnxt_qplib_cmdqmsg *msg,
+					   void *req, void *resp, void *sb,
+					   u32 req_sz, u32 res_sz, u8 block)
+{
+	msg->req = req;
+	msg->resp = resp;
+	msg->sb = sb;
+	msg->req_sz = req_sz;
+	msg->res_sz = res_sz;
+	msg->block = block;
+}
+
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
@@ -211,8 +231,7 @@ struct bnxt_qplib_rcfw_sbuf *bnxt_qplib_rcfw_alloc_sbuf(
 void bnxt_qplib_rcfw_free_sbuf(struct bnxt_qplib_rcfw *rcfw,
 			       struct bnxt_qplib_rcfw_sbuf *sbuf);
 int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
-				 struct cmdq_base *req, struct creq_base *resp,
-				 void *sbuf, u8 is_block);
+				 struct bnxt_qplib_cmdqmsg *msg);
 
 int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4e27274..54c26c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -68,16 +68,17 @@ static bool bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
 static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 				     char *fw_ver)
 {
-	struct cmdq_query_version req;
-	struct creq_query_version_resp resp;
+	struct creq_query_version_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_query_version req = {};
 	int rc = 0;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_VERSION,
 				 sizeof(req));
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return;
 	fw_ver[0] = resp.fw_maj;
@@ -89,10 +90,11 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 			    struct bnxt_qplib_dev_attr *attr, bool vf)
 {
+	struct creq_query_func_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
-	struct creq_query_func_resp resp;
-	struct cmdq_query_func req;
+	struct cmdq_query_func req = {};
 	u8 *tqm_alloc;
 	int i, rc = 0;
 	u32 temp;
@@ -110,8 +112,9 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 
 	sb = sbuf->sb;
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto bail;
 
@@ -176,8 +179,9 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx)
 {
-	struct cmdq_set_func_resources req;
-	struct creq_set_func_resources_resp resp;
+	struct creq_set_func_resources_resp resp = {};
+	struct cmdq_set_func_resources req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	int rc = 0;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -195,9 +199,9 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 	req.max_cq_per_vf = cpu_to_le32(ctx->vf_res.max_cq_per_vf);
 	req.max_gid_per_vf = cpu_to_le32(ctx->vf_res.max_gid_per_vf);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp,
-					  NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc) {
 		dev_err(&res->pdev->dev, "Failed to set function resources\n");
 	}
@@ -248,8 +252,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	}
 	/* Remove GID from the SGID table */
 	if (update) {
-		struct cmdq_delete_gid req;
-		struct creq_delete_gid_resp resp;
+		struct creq_delete_gid_resp resp = {};
+		struct bnxt_qplib_cmdqmsg msg = {};
+		struct cmdq_delete_gid req = {};
 		int rc;
 
 		bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -261,8 +266,9 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			return -EINVAL;
 		}
 		req.gid_index = cpu_to_le16(sgid_tbl->hw_id[index]);
-		rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-						  (void *)&resp, NULL, 0);
+		bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+					sizeof(resp), 0);
+		rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 		if (rc)
 			return rc;
 	}
@@ -319,8 +325,9 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		return -ENOMEM;
 	}
 	if (update) {
-		struct cmdq_add_gid req;
-		struct creq_add_gid_resp resp;
+		struct creq_add_gid_resp resp = {};
+		struct bnxt_qplib_cmdqmsg msg = {};
+		struct cmdq_add_gid req = {};
 		int rc;
 
 		bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -350,8 +357,9 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		req.src_mac[1] = cpu_to_be16(((u16 *)smac)[1]);
 		req.src_mac[2] = cpu_to_be16(((u16 *)smac)[2]);
 
-		rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-						  (void *)&resp, NULL, 0);
+		bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+					sizeof(resp), 0);
+		rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 		if (rc)
 			return rc;
 		sgid_tbl->hw_id[free_idx] = le32_to_cpu(resp.xid);
@@ -380,8 +388,9 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 						   struct bnxt_qplib_res,
 						   sgid_tbl);
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct creq_modify_gid_resp resp;
-	struct cmdq_modify_gid req;
+	struct creq_modify_gid_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_modify_gid req = {};
 	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -405,8 +414,9 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 
 	req.gid_index = cpu_to_le16(gid_idx);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	return rc;
 }
 
@@ -415,8 +425,9 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			 bool block)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_create_ah req;
-	struct creq_create_ah_resp resp;
+	struct creq_create_ah_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_create_ah req = {};
 	u32 temp32[4];
 	u16 temp16[3];
 	int rc;
@@ -446,8 +457,9 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	req.dest_mac[1] = cpu_to_le16(temp16[1]);
 	req.dest_mac[2] = cpu_to_le16(temp16[2]);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, block);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), block);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
@@ -459,8 +471,9 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			   bool block)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_destroy_ah req;
-	struct creq_destroy_ah_resp resp;
+	struct creq_destroy_ah_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_destroy_ah req = {};
 
 	/* Clean up the AH table in the device */
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -469,16 +482,18 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 
 	req.ah_cid = cpu_to_le32(ah->id);
 
-	bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp, NULL,
-				     block);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), block);
+	bnxt_qplib_rcfw_send_message(rcfw, &msg);
 }
 
 /* MRW */
 int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 {
+	struct creq_deallocate_key_resp resp = {};
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_deallocate_key req;
-	struct creq_deallocate_key_resp resp;
+	struct cmdq_deallocate_key req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	int rc;
 
 	if (mrw->lkey == 0xFFFFFFFF) {
@@ -499,8 +514,9 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	else
 		req.key = cpu_to_le32(mrw->lkey);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
@@ -514,8 +530,9 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_allocate_mrw req;
-	struct creq_allocate_mrw_resp resp;
+	struct creq_allocate_mrw_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_allocate_mrw req = {};
 	unsigned long tmp;
 	int rc;
 
@@ -533,8 +550,9 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	tmp = (unsigned long)mrw;
 	req.mrw_handle = cpu_to_le64(tmp);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
@@ -551,8 +569,9 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 			 bool block)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_deregister_mr req;
-	struct creq_deregister_mr_resp resp;
+	struct creq_deregister_mr_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_deregister_mr req = {};
 	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -560,8 +579,9 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 				 sizeof(req));
 
 	req.lkey = cpu_to_le32(mrw->lkey);
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, block);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), block);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		return rc;
 
@@ -581,8 +601,9 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
-	struct creq_register_mr_resp resp;
-	struct cmdq_register_mr req;
+	struct creq_register_mr_resp resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_register_mr req = {};
 	int pages, rc;
 	u32 pg_size;
 	u16 level;
@@ -640,8 +661,9 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	req.key = cpu_to_le32(mr->lkey);
 	req.mr_size = cpu_to_le64(mr->total_size);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, NULL, false);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto fail;
 
@@ -695,10 +717,11 @@ int bnxt_qplib_free_fast_reg_page_list(struct bnxt_qplib_res *res,
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 			      struct bnxt_qplib_roce_stats *stats)
 {
-	struct cmdq_query_roce_stats req;
-	struct creq_query_roce_stats_resp resp;
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct creq_query_roce_stats_resp resp = {};
 	struct creq_query_roce_stats_resp_sb *sb;
+	struct cmdq_query_roce_stats req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	int rc = 0;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -714,8 +737,9 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 
 	sb = sbuf->sb;
 	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-					  (void *)sbuf, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto bail;
 	/* Extract the context from the side buffer */
@@ -779,6 +803,7 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	struct creq_query_roce_stats_ext_resp resp = {};
 	struct creq_query_roce_stats_ext_resp_sb *sb;
 	struct cmdq_query_roce_stats_ext req = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	int rc;
 
@@ -798,8 +823,9 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	req.function_id = cpu_to_le32(fid);
 	req.flags = cpu_to_le16(CMDQ_QUERY_ROCE_STATS_EXT_FLAGS_FUNCTION_ID);
 
-	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
-					  (void *)&resp, (void *)sbuf, 0);
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto bail;
 
-- 
2.5.5


--00000000000014667505f7bde76b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIZKDeZFY96F
x5Cv7nzhyGmNsQQGdhNITkg1+MME7OKBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyNTE4NDQ0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDGGo35FiwqM/jkmlkVOgT50ku2+t9C
YRu1+6rz7nxY+5lvUoo34QZJqlbyftAOKn+xxmdPOYFlAqstK151e2Gt1T5oglCkGkabBoqi+A9+
Zzaux82/istkINww6RrgwrCDRNpt+qSs7rq8jizV8OGPg7G+4LrpJ4hBQs5n92WCoZtWTYK/vBm/
WtxOzcLyt8tjP9ED6PgTVMh3yraFFtiLXfek8Sm8nXZJRc7wf+nw73sOT0gS7uqE7AGZlosxswhm
FFv8kzlk3UlW9rkf/JtwCSF/E1nqgIpJn282faAzozP0Nl41eG8qtuMlHIMubCE0b5wqIL2ndIoL
+UNOpAcc
--00000000000014667505f7bde76b--
