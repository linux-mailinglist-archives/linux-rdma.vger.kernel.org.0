Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BD6C6302
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCWJNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjCWJNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 05:13:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692D1C304
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c18so21694902ple.11
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679562780;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ms/XX7KRyq8CiSq7I5q+5IreuMpH/WHIKY0nwRenyck=;
        b=fNMIxzgqd+eAqVbxd2Z+ETSbHs3eNtblSSJHl8m2Zlad5SRhIDXinRcEwlZVAJLMq2
         jeHYKGOkCWUEoAKT3/ADInhQ28hzF6xBfbL0VQcAzVWSHeaenxLV+tAB29j8g8lPgQBS
         t2DDbF+/eBwvf0Tw27OIbg+Nv2hhJBfdXzI28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562780;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms/XX7KRyq8CiSq7I5q+5IreuMpH/WHIKY0nwRenyck=;
        b=ZqhbMNDGorh6VzWh8fsb5XTtvlEwr09ELUKIW3d403HfQ5ylBXj+gMVRh/fYDCYAHN
         aaXZKpHuxK9Ph163D3Ty5W19BMNkqyOBMEAwoMU/7RgQodTzl9HjqGxPEpXrWe+3i28k
         c2fu2LFAPOzFy5AHA1cpP4oLUUhAks3LatUYULfyjC+spAQg1+U2SodUtle8oidKR+ro
         hPBxlH+6CRz4wV9mI5cZ+Ofvty8AOhEqEasJS8Wx0RriDz3aQZZ8cFsYrBbG1dCFFJHj
         aahqoIm6WCP+QkzD6U2tz17r1xLzTatXqTdIui+W9zvNblRo4duemvrrYC1KzBEtktlO
         9ibw==
X-Gm-Message-State: AO0yUKU41h6V9m4lg/gYSTGAfqGojQv3SD3Tb/LxYGlFPwNjpQVPNibe
        XXyh6eqAIshOWaq63KedLIBHhQ==
X-Google-Smtp-Source: AK7set8i8bRwor9ZNS6VeDe9iSuFHrjntW8A9F6bdPV6SKTQeWEIjg1avks2lLUF3wXfKdj6CIe6qA==
X-Received: by 2002:a05:6a20:4a04:b0:d9:eb9e:c2c1 with SMTP id fr4-20020a056a204a0400b000d9eb9ec2c1mr1957042pzb.27.1679562780067;
        Thu, 23 Mar 2023 02:13:00 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b00627e9ab34b3sm9055114pff.91.2023.03.23.02.12.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:12:59 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/7] RDMA/bnxt_re: Convert RCFW_CMD_PREP macro to static inline function
Date:   Thu, 23 Mar 2023 02:12:15 -0700
Message-Id: <1679562739-24472-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
References: <1679562739-24472-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e787c605f78daead"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000e787c605f78daead

Convert RCFW_CMD_PREP macro to static inline function.
Also, remove the cmd_flags passed as none of the functions
are using it.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 55 ++++++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 23 ++++-----
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 79 ++++++++++++++++++------------
 4 files changed, 98 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e104ca9..6152df8 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -583,10 +583,11 @@ void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_destroy_srq req;
 	struct creq_destroy_srq_resp resp;
-	u16 cmd_flags = 0;
 	int rc;
 
-	RCFW_CMD_PREP(req, DESTROY_SRQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DESTROY_SRQ,
+				 sizeof(req));
 
 	/* Configure the request */
 	req.srq_cid = cpu_to_le32(srq->id);
@@ -607,7 +608,6 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	struct creq_create_srq_resp resp;
 	struct cmdq_create_srq req;
 	struct bnxt_qplib_pbl *pbl;
-	u16 cmd_flags = 0;
 	u16 pg_sz_lvl;
 	int rc, idx;
 
@@ -627,7 +627,9 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 		goto fail;
 	}
 
-	RCFW_CMD_PREP(req, CREATE_SRQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_CREATE_SRQ,
+				 sizeof(req));
 
 	/* Configure the request */
 	req.dpi = cpu_to_le32(srq->dpi->dpi);
@@ -704,10 +706,11 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 	struct creq_query_srq_resp resp;
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_srq_resp_sb *sb;
-	u16 cmd_flags = 0;
 	int rc = 0;
 
-	RCFW_CMD_PREP(req, QUERY_SRQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_QUERY_SRQ,
+				 sizeof(req));
 
 	/* Configure the request */
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
@@ -816,13 +819,14 @@ int bnxt_qplib_create_qp1(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct creq_create_qp1_resp resp;
 	struct cmdq_create_qp1 req;
 	struct bnxt_qplib_pbl *pbl;
-	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	int rc;
 
-	RCFW_CMD_PREP(req, CREATE_QP1, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_CREATE_QP1,
+				 sizeof(req));
 
 	/* General */
 	req.type = qp->type;
@@ -959,13 +963,14 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_hwq *xrrq;
 	struct bnxt_qplib_pbl *pbl;
 	struct cmdq_create_qp req;
-	u16 cmd_flags = 0;
 	u32 qp_flags = 0;
 	u8 pg_sz_lvl;
 	u32 tbl_indx;
 	u16 nsge;
 
-	RCFW_CMD_PREP(req, CREATE_QP, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_CREATE_QP,
+				 sizeof(req));
 
 	/* General */
 	req.type = qp->type;
@@ -1233,12 +1238,13 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_modify_qp req;
 	struct creq_modify_qp_resp resp;
-	u16 cmd_flags = 0;
 	u32 temp32[4];
 	u32 bmask;
 	int rc;
 
-	RCFW_CMD_PREP(req, MODIFY_QP, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_MODIFY_QP,
+				 sizeof(req));
 
 	/* Filter out the qp_attr_mask based on the state->new transition */
 	__filter_modify_flags(qp);
@@ -1339,11 +1345,12 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct creq_query_qp_resp resp;
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_qp_resp_sb *sb;
-	u16 cmd_flags = 0;
 	u32 temp32[4];
 	int i, rc = 0;
 
-	RCFW_CMD_PREP(req, QUERY_QP, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_QUERY_QP,
+				 sizeof(req));
 
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
 	if (!sbuf)
@@ -1462,7 +1469,6 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_destroy_qp req;
 	struct creq_destroy_qp_resp resp;
-	u16 cmd_flags = 0;
 	u32 tbl_indx;
 	int rc;
 
@@ -1470,7 +1476,9 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
 
-	RCFW_CMD_PREP(req, DESTROY_QP, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DESTROY_QP,
+				 sizeof(req));
 
 	req.qp_cid = cpu_to_le32(qp->id);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
@@ -2039,7 +2047,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct creq_create_cq_resp resp;
 	struct bnxt_qplib_pbl *pbl;
 	struct cmdq_create_cq req;
-	u16 cmd_flags = 0;
 	u32 pg_sz_lvl;
 	int rc;
 
@@ -2052,7 +2059,9 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	if (rc)
 		goto exit;
 
-	RCFW_CMD_PREP(req, CREATE_CQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_CREATE_CQ,
+				 sizeof(req));
 
 	if (!cq->dpi) {
 		dev_err(&rcfw->pdev->dev,
@@ -2116,10 +2125,11 @@ int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
 	struct cmdq_resize_cq req = {};
 	struct bnxt_qplib_pbl *pbl;
 	u32 pg_sz, lvl, new_sz;
-	u16 cmd_flags = 0;
 	int rc;
 
-	RCFW_CMD_PREP(req, RESIZE_CQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_RESIZE_CQ,
+				 sizeof(req));
 	hwq_attr.sginfo = &cq->sg_info;
 	hwq_attr.res = res;
 	hwq_attr.depth = new_cqes;
@@ -2150,10 +2160,11 @@ int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	struct cmdq_destroy_cq req;
 	struct creq_destroy_cq_resp resp;
 	u16 total_cnq_events;
-	u16 cmd_flags = 0;
 	int rc;
 
-	RCFW_CMD_PREP(req, DESTROY_CQ, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DESTROY_CQ,
+				 sizeof(req));
 
 	req.cq_cid = cpu_to_le32(cq->id);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 061b289..1eab451 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -454,10 +454,11 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw)
 {
 	struct cmdq_deinitialize_fw req;
 	struct creq_deinitialize_fw_resp resp;
-	u16 cmd_flags = 0;
 	int rc;
 
-	RCFW_CMD_PREP(req, DEINITIALIZE_FW, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DEINITIALIZE_FW,
+				 sizeof(req));
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
 					  NULL, 0);
 	if (rc)
@@ -472,11 +473,12 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct creq_initialize_fw_resp resp;
 	struct cmdq_initialize_fw req;
-	u16 cmd_flags = 0;
 	u8 pgsz, lvl;
 	int rc;
 
-	RCFW_CMD_PREP(req, INITIALIZE_FW, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_INITIALIZE_FW,
+				 sizeof(req));
 	/* Supply (log-base-2-of-host-page-size - base-page-shift)
 	 * to bono to adjust the doorbell page sizes.
 	 */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 0a3d8e7..b7f4d0a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -51,25 +51,26 @@
 #define RCFW_DBR_PCI_BAR_REGION		2
 #define RCFW_DBR_BASE_PAGE_SHIFT	12
 
-#define RCFW_CMD_PREP(req, CMD, cmd_flags)				\
-	do {								\
-		memset(&(req), 0, sizeof((req)));			\
-		(req).opcode = CMDQ_BASE_OPCODE_##CMD;			\
-		(req).cmd_size = sizeof((req));				\
-		(req).flags = cpu_to_le16(cmd_flags);			\
-	} while (0)
-
-#define RCFW_CMD_WAIT_TIME_MS		20000 /* 20 Seconds timeout */
-
 /* Cmdq contains a fix number of a 16-Byte slots */
 struct bnxt_qplib_cmdqe {
 	u8		data[16];
 };
 
+#define BNXT_QPLIB_CMDQE_UNITS		sizeof(struct bnxt_qplib_cmdqe)
+
+static inline void bnxt_qplib_rcfw_cmd_prep(struct cmdq_base *req,
+					    u8 opcode, u8 cmd_size)
+{
+	memset(req, 0, cmd_size);
+	req->opcode = opcode;
+	req->cmd_size = cmd_size;
+}
+
+#define RCFW_CMD_WAIT_TIME_MS		20000 /* 20 Seconds timeout */
+
 /* CMDQ elements */
 #define BNXT_QPLIB_CMDQE_MAX_CNT_256	256
 #define BNXT_QPLIB_CMDQE_MAX_CNT_8192	8192
-#define BNXT_QPLIB_CMDQE_UNITS		sizeof(struct bnxt_qplib_cmdqe)
 #define BNXT_QPLIB_CMDQE_BYTES(depth)	((depth) * BNXT_QPLIB_CMDQE_UNITS)
 
 static inline u32 bnxt_qplib_cmdqe_npages(u32 depth)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 3f4998a..4e27274 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -70,10 +70,11 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct cmdq_query_version req;
 	struct creq_query_version_resp resp;
-	u16 cmd_flags = 0;
 	int rc = 0;
 
-	RCFW_CMD_PREP(req, QUERY_VERSION, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_QUERY_VERSION,
+				 sizeof(req));
 
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
 					  (void *)&resp, NULL, 0);
@@ -88,16 +89,17 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 			    struct bnxt_qplib_dev_attr *attr, bool vf)
 {
-	struct cmdq_query_func req;
-	struct creq_query_func_resp resp;
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_func_resp_sb *sb;
-	u16 cmd_flags = 0;
-	u32 temp;
+	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct creq_query_func_resp resp;
+	struct cmdq_query_func req;
 	u8 *tqm_alloc;
 	int i, rc = 0;
+	u32 temp;
 
-	RCFW_CMD_PREP(req, QUERY_FUNC, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_QUERY_FUNC,
+				 sizeof(req));
 
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
 	if (!sbuf) {
@@ -176,10 +178,11 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 {
 	struct cmdq_set_func_resources req;
 	struct creq_set_func_resources_resp resp;
-	u16 cmd_flags = 0;
 	int rc = 0;
 
-	RCFW_CMD_PREP(req, SET_FUNC_RESOURCES, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_SET_FUNC_RESOURCES,
+				 sizeof(req));
 
 	req.number_of_qp = cpu_to_le32(ctx->qpc_count);
 	req.number_of_mrw = cpu_to_le32(ctx->mrw_count);
@@ -247,10 +250,11 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	if (update) {
 		struct cmdq_delete_gid req;
 		struct creq_delete_gid_resp resp;
-		u16 cmd_flags = 0;
 		int rc;
 
-		RCFW_CMD_PREP(req, DELETE_GID, cmd_flags);
+		bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+					 CMDQ_BASE_OPCODE_DELETE_GID,
+					 sizeof(req));
 		if (sgid_tbl->hw_id[index] == 0xFFFF) {
 			dev_err(&res->pdev->dev,
 				"GID entry contains an invalid HW id\n");
@@ -317,10 +321,11 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	if (update) {
 		struct cmdq_add_gid req;
 		struct creq_add_gid_resp resp;
-		u16 cmd_flags = 0;
 		int rc;
 
-		RCFW_CMD_PREP(req, ADD_GID, cmd_flags);
+		bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+					 CMDQ_BASE_OPCODE_ADD_GID,
+					 sizeof(req));
 
 		req.gid[0] = cpu_to_be32(((u32 *)gid->data)[3]);
 		req.gid[1] = cpu_to_be32(((u32 *)gid->data)[2]);
@@ -378,9 +383,10 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	struct creq_modify_gid_resp resp;
 	struct cmdq_modify_gid req;
 	int rc;
-	u16 cmd_flags = 0;
 
-	RCFW_CMD_PREP(req, MODIFY_GID, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_MODIFY_GID,
+				 sizeof(req));
 
 	req.gid[0] = cpu_to_be32(((u32 *)gid->data)[3]);
 	req.gid[1] = cpu_to_be32(((u32 *)gid->data)[2]);
@@ -411,12 +417,13 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_create_ah req;
 	struct creq_create_ah_resp resp;
-	u16 cmd_flags = 0;
 	u32 temp32[4];
 	u16 temp16[3];
 	int rc;
 
-	RCFW_CMD_PREP(req, CREATE_AH, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_CREATE_AH,
+				 sizeof(req));
 
 	memcpy(temp32, ah->dgid.data, sizeof(struct bnxt_qplib_gid));
 	req.dgid[0] = cpu_to_le32(temp32[0]);
@@ -454,10 +461,11 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_destroy_ah req;
 	struct creq_destroy_ah_resp resp;
-	u16 cmd_flags = 0;
 
 	/* Clean up the AH table in the device */
-	RCFW_CMD_PREP(req, DESTROY_AH, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DESTROY_AH,
+				 sizeof(req));
 
 	req.ah_cid = cpu_to_le32(ah->id);
 
@@ -471,7 +479,6 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_deallocate_key req;
 	struct creq_deallocate_key_resp resp;
-	u16 cmd_flags = 0;
 	int rc;
 
 	if (mrw->lkey == 0xFFFFFFFF) {
@@ -479,7 +486,9 @@ int bnxt_qplib_free_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 		return 0;
 	}
 
-	RCFW_CMD_PREP(req, DEALLOCATE_KEY, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DEALLOCATE_KEY,
+				 sizeof(req));
 
 	req.mrw_flags = mrw->type;
 
@@ -507,11 +516,12 @@ int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_allocate_mrw req;
 	struct creq_allocate_mrw_resp resp;
-	u16 cmd_flags = 0;
 	unsigned long tmp;
 	int rc;
 
-	RCFW_CMD_PREP(req, ALLOCATE_MRW, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_ALLOCATE_MRW,
+				 sizeof(req));
 
 	req.pd_id = cpu_to_le32(mrw->pd->id);
 	req.mrw_flags = mrw->type;
@@ -543,10 +553,11 @@ int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_deregister_mr req;
 	struct creq_deregister_mr_resp resp;
-	u16 cmd_flags = 0;
 	int rc;
 
-	RCFW_CMD_PREP(req, DEREGISTER_MR, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_DEREGISTER_MR,
+				 sizeof(req));
 
 	req.lkey = cpu_to_le32(mrw->lkey);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
@@ -572,9 +583,9 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 	struct bnxt_qplib_sg_info sginfo = {};
 	struct creq_register_mr_resp resp;
 	struct cmdq_register_mr req;
-	u16 cmd_flags = 0, level;
 	int pages, rc;
 	u32 pg_size;
+	u16 level;
 
 	if (num_pbls) {
 		pages = roundup_pow_of_two(num_pbls);
@@ -602,7 +613,9 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		}
 	}
 
-	RCFW_CMD_PREP(req, REGISTER_MR, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_REGISTER_MR,
+				 sizeof(req));
 
 	/* Configure the request */
 	if (mr->hwq.level == PBL_LVL_MAX) {
@@ -686,10 +699,11 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_query_roce_stats_resp resp;
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
 	struct creq_query_roce_stats_resp_sb *sb;
-	u16 cmd_flags = 0;
 	int rc = 0;
 
-	RCFW_CMD_PREP(req, QUERY_ROCE_STATS, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_QUERY_ROCE_STATS,
+				 sizeof(req));
 
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
 	if (!sbuf) {
@@ -766,7 +780,6 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	struct creq_query_roce_stats_ext_resp_sb *sb;
 	struct cmdq_query_roce_stats_ext req = {};
 	struct bnxt_qplib_rcfw_sbuf *sbuf;
-	u16 cmd_flags = 0;
 	int rc;
 
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
@@ -776,7 +789,9 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 		return -ENOMEM;
 	}
 
-	RCFW_CMD_PREP(req, QUERY_ROCE_STATS_EXT, cmd_flags);
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_QUERY_ROCE_STATS_EXT_OPCODE_QUERY_ROCE_STATS,
+				 sizeof(req));
 
 	req.resp_size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
 	req.resp_addr = cpu_to_le64(sbuf->dma_addr);
-- 
2.5.5


--000000000000e787c605f78daead
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAstQPusH06f
6F9DBPVaCyucvSvTvTe+a4BT4nbsXruRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyMzA5MTMwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCCQzvmowQ11Hey9PM0ht8UYM1M1Bmz
uyKomKn+pmdIKsU2S1d8h56Jx56ea0jse6C5EnN4Uc9VVB+ajvwrJnkoWan3KTaDa5xOkwSdVT9f
ZA9X2oAGs+h+x5cSMBw/t7skr/Cu36a4u776GhfSoEf5xdhY/wFdHuaVy9u7Au8FeXzbVTydBaGj
BQg3dWpm16t596IvTjcnLMdJkJww0xCdbew4+e7FE4vwmn8ggsr33dd+NOFBs4iT1F+cGY0dNrtu
b1xeJTSknZl9qhg1m69zzQqr7RZE60jUlFsjFqw/MezfMj7An23OznRlZZeXQIaFU0mPTiYieyXA
H95WVclc
--000000000000e787c605f78daead--
