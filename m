Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0376C9AE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjHBJoe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 05:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHBJob (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 05:44:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA692114
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 02:44:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so509093a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Aug 2023 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690969466; x=1691574266;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1diNXHWMqTBHLRVrjPb9IfiQr/v4rv7f2czfHdP0ui4=;
        b=OAUTzhSzz0pKF1D94vaGqDVvtiPSVeXrmZfOsDur8Z/SXnOzPziw3ZV3RRjFPun2LS
         vXc4nUEuwXvK9bLlGTxLzMHbdfig70rd22WpOwcl9CNiXOP9V3wYvY7n7yIkLGB29ebZ
         TsjKP5GkroJRinX8jFOv9qRd+N4P6tuDfGxxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690969466; x=1691574266;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1diNXHWMqTBHLRVrjPb9IfiQr/v4rv7f2czfHdP0ui4=;
        b=g5KhRAO2oQoRN9tzNHyigsdJZ/6XjalmQkYcs5mcDtn7A3vFc3hSSRWAX88VyofvP7
         ymom+oyuY1er7ydk5rdoZ7tyhXy0zfetP6BAndtouZPpNYzwbKkTibbLrZy8aC9Bh2O0
         +mBy+UEuj5P+/w0NhCEvOCbHNxv3pTRsrTu35vHsVuMEAA0X5Lm0b3mFdarrlLi4l8oe
         L0cTLnZNgc/IBoYqg/+SoxxECDlLn1PMYpoh+ZUDhoxa36fsXEo9IbzNlkRYA1dWf0qF
         32WoT4vv5Gzl2u6UMYvpC8c9XShmHnAn1uatMg78KrMLWrtaeYh7EhCiuub75S3kPHep
         Rlvw==
X-Gm-Message-State: ABy/qLYLZRgbLZsZPM1tSEK62Ca/NIJNjWpjcFXHs5iG/cAKe2Sj/1no
        0KazJ/HccVoh1rUeACqjG2foqA==
X-Google-Smtp-Source: APBJJlG1gXx0hhU9CFcl6+SKY6mNHeXwcwEzIcZwcWJZMmyouFjxnOSxnKgfGdLTnFkIsGU7+cCxaQ==
X-Received: by 2002:a17:90a:be10:b0:268:169e:8497 with SMTP id a16-20020a17090abe1000b00268169e8497mr19042709pjs.13.1690969466441;
        Wed, 02 Aug 2023 02:44:26 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a000500b00263dfe9b972sm848790pja.0.2023.08.02.02.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2023 02:44:25 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next 3/6] RDMA/bnxt_re: Fix the sideband buffer size handling for FW commands
Date:   Wed,  2 Aug 2023 02:32:36 -0700
Message-Id: <1690968759-9142-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000064c7bb0601ed827b"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000064c7bb0601ed827b

bnxt_qplib_rcfw_alloc_sbuf allocates 24 bytes for holding a temporary
data and it is better to fit them on stack variables. This way we can
avoid unwanted kmalloc call. Call dma_alloc_coherent directly instead of wrapper
bnxt_qplib_rcfw_alloc_sbuf.

Also, FW expects the side buffer to be aligned to
BNXT_QPLIB_CMDQE_UNITS(16B). So align the size to have the
extra padding data.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 38 +++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 31 --------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 65 ++++++++++++++----------------
 3 files changed, 53 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index f9dee0d..282e34e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -709,7 +709,7 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_query_srq_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct bnxt_qplib_rcfw_sbuf sbuf;
 	struct creq_query_srq_resp_sb *sb;
 	struct cmdq_query_srq req = {};
 	int rc = 0;
@@ -719,17 +719,20 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 				 sizeof(req));
 
 	/* Configure the request */
-	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
-	if (!sbuf)
+	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
 		return -ENOMEM;
-	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
 	req.srq_cid = cpu_to_le32(srq->id);
-	sb = sbuf->sb;
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+	sb = sbuf.sb;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	srq->threshold = le16_to_cpu(sb->srq_limit);
-	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
 
 	return rc;
 }
@@ -1347,24 +1350,26 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_query_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct bnxt_qplib_rcfw_sbuf sbuf;
 	struct creq_query_qp_resp_sb *sb;
 	struct cmdq_query_qp req = {};
 	u32 temp32[4];
 	int i, rc = 0;
 
+	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
+		return -ENOMEM;
+	sb = sbuf.sb;
+
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_QP,
 				 sizeof(req));
 
-	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
-	if (!sbuf)
-		return -ENOMEM;
-	sb = sbuf->sb;
-
 	req.qp_cid = cpu_to_le32(qp->id);
-	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
@@ -1423,7 +1428,8 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	memcpy(qp->smac, sb->src_mac, 6);
 	qp->vlan_id = le16_to_cpu(sb->vlan_pcp_vlan_dei_vlan_id);
 bail:
-	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4842a41..9d26871 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -1197,34 +1197,3 @@ int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 
 	return 0;
 }
-
-struct bnxt_qplib_rcfw_sbuf *bnxt_qplib_rcfw_alloc_sbuf(
-		struct bnxt_qplib_rcfw *rcfw,
-		u32 size)
-{
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
-
-	sbuf = kzalloc(sizeof(*sbuf), GFP_KERNEL);
-	if (!sbuf)
-		return NULL;
-
-	sbuf->size = size;
-	sbuf->sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf->size,
-				      &sbuf->dma_addr, GFP_KERNEL);
-	if (!sbuf->sb)
-		goto bail;
-
-	return sbuf;
-bail:
-	kfree(sbuf);
-	return NULL;
-}
-
-void bnxt_qplib_rcfw_free_sbuf(struct bnxt_qplib_rcfw *rcfw,
-			       struct bnxt_qplib_rcfw_sbuf *sbuf)
-{
-	if (sbuf->sb)
-		dma_free_coherent(&rcfw->pdev->dev, sbuf->size,
-				  sbuf->sb, sbuf->dma_addr);
-	kfree(sbuf);
-}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 89acb66..05ee8fd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -94,7 +94,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_query_func_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct bnxt_qplib_rcfw_sbuf sbuf;
 	struct cmdq_query_func req = {};
 	u8 *tqm_alloc;
 	int i, rc = 0;
@@ -104,16 +104,14 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 				 CMDQ_BASE_OPCODE_QUERY_FUNC,
 				 sizeof(req));
 
-	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
-	if (!sbuf) {
-		dev_err(&rcfw->pdev->dev,
-			"SP: QUERY_FUNC alloc side buffer failed\n");
+	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
 		return -ENOMEM;
-	}
-
-	sb = sbuf->sb;
-	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+	sb = sbuf.sb;
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
@@ -174,7 +172,8 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 
 	attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
 bail:
-	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
 
@@ -717,23 +716,22 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_query_roce_stats_resp_sb *sb;
 	struct cmdq_query_roce_stats req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
+	struct bnxt_qplib_rcfw_sbuf sbuf;
 	int rc = 0;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_ROCE_STATS,
 				 sizeof(req));
 
-	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
-	if (!sbuf) {
-		dev_err(&rcfw->pdev->dev,
-			"SP: QUERY_ROCE_STATS alloc side buffer failed\n");
+	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
 		return -ENOMEM;
-	}
+	sb = sbuf.sb;
 
-	sb = sbuf->sb;
-	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
@@ -789,7 +787,8 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 	}
 
 bail:
-	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
 
@@ -800,34 +799,31 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	struct creq_query_roce_stats_ext_resp_sb *sb;
 	struct cmdq_query_roce_stats_ext req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
-	struct bnxt_qplib_rcfw_sbuf *sbuf;
-	u32 size;
+	struct bnxt_qplib_rcfw_sbuf sbuf;
 	int rc;
 
-	size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
-	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, size);
-	if (!sbuf) {
-		dev_err(&rcfw->pdev->dev,
-			"SP: QUERY_ROCE_STATS_EXT alloc sb failed");
+	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
 		return -ENOMEM;
-	}
 
+	sb = sbuf.sb;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_QUERY_ROCE_STATS_EXT_OPCODE_QUERY_ROCE_STATS,
 				 sizeof(req));
 
-	req.resp_size = size / BNXT_QPLIB_CMDQE_UNITS;
-	req.resp_addr = cpu_to_le64(sbuf->dma_addr);
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
 	req.function_id = cpu_to_le32(fid);
 	req.flags = cpu_to_le16(CMDQ_QUERY_ROCE_STATS_EXT_FLAGS_FUNCTION_ID);
 
-	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, sbuf, sizeof(req),
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
 				sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
 	if (rc)
 		goto bail;
 
-	sb = sbuf->sb;
 	estat->tx_atomic_req = le64_to_cpu(sb->tx_atomic_req_pkts);
 	estat->tx_read_req = le64_to_cpu(sb->tx_read_req_pkts);
 	estat->tx_read_res = le64_to_cpu(sb->tx_read_res_pkts);
@@ -851,7 +847,8 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	estat->rx_ecn_marked = le64_to_cpu(sb->rx_ecn_marked_pkts);
 
 bail:
-	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
+			  sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
 
-- 
2.5.5


--00000000000064c7bb0601ed827b
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICS/cpMo++i1
W5hZ56Py8mF0w9nSB1BHRehyFhk8xmp6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgwMjA5NDQyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQChRT8pO/C0q+4di85FTxS7oNAjNJcZ
XBewQJqn2Hjp6Kh88azZOm2CICB85mVYYwiSespZMC0hOdcvZEv4tAeOayb+xXBK7hYon33nX/Qf
LtH3xVcMG1clD0SoqIxHVQwTbuzKrTJhEvld3A83asskCmG9QE3d+VpkJEFwgmcANLb/zUuc7GvE
tk5XzUlnKxlDG9YOHrIr0dzwNKu26EmStAb4bBlVfuVcdmpDXlKpWVvxvbbVmNu+WlIqtc74E/Bm
1V6Zg0tLv1Zp2IohH41r8xTaWjaKlp9T8boLI/tQIgNhIKwBmP74yhdoI8tUSqFEeXeu7uKBBqVu
K95JZkiO
--00000000000064c7bb0601ed827b--
