Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745176C9B2
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHBJop (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjHBJon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 05:44:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC6210D
        for <linux-rdma@vger.kernel.org>; Wed,  2 Aug 2023 02:44:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso3743945a91.1
        for <linux-rdma@vger.kernel.org>; Wed, 02 Aug 2023 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690969475; x=1691574275;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PklRcQpm2ZCaRJllkkzv5zeMW3vEWNtZ4de4n8lHXCg=;
        b=VIqi7CaSU/kWIVmMYfp6dLekwMNwi/3JR+VXeYO4MZhS4i44D/LX9FWu6TYCml4cJv
         Nz+gjAk88axOaPDLgUe0cXEyV/TEthiFQv8ywCvzA6xBGFAq73epy6VGgJweBhdGfKG8
         AyFIRx1NzgvSQQ+5NAcZEX5BhSsilLAIhWKYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690969475; x=1691574275;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PklRcQpm2ZCaRJllkkzv5zeMW3vEWNtZ4de4n8lHXCg=;
        b=SfXpiEUBHuHnZavzU16vymKvXQUcxEty4NxMO9NyyVOogMn2/N3Gbp4syeorOV5u3D
         uGGIGAPykgWCPx9HF8afmOtdOLLOMSRcEx/fuinFP/rhNd9+OdjhjfzB4VsuCdxnL/Jr
         2ohC+6M+YvgFCANt+4uwNBEv3WQpZ6gNnw1AMuyGAcG89+FkYXPPq3UMSZbnhmsLmaig
         uGHpQXn0mNX+gjCHlKx8pGIZ+CXX08JgcNNjJdkm3sFcVaUu5jKGsoYS/hOL3OrX30Z8
         wnSVt5OJeBOOQvg0T+CYPkScUlC4zmubFpXxWdFwvzZJm9lWpELkpGvt9v8hECY5uAKQ
         mr9Q==
X-Gm-Message-State: ABy/qLbecAowT0Z8f/NWFTOVFNisaU6qxg5qdgXPaUTc7t4QBpI6xTZ2
        BaImZr9IQ3ZRxChTkvKmfF9gTA==
X-Google-Smtp-Source: APBJJlEBC8h6T9y+6JpahjmeMpznZlbxysPdv3wOnpAUmsJV42EWFc6Bs7xH1w164TjWrFEE+s6AJQ==
X-Received: by 2002:a17:90a:f083:b0:268:c29:52ad with SMTP id cn3-20020a17090af08300b002680c2952admr12837827pjb.13.1690969474773;
        Wed, 02 Aug 2023 02:44:34 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a000500b00263dfe9b972sm848790pja.0.2023.08.02.02.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2023 02:44:34 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 6/6] RDMA/bnxt_re: Remove unnecessary variable initializations
Date:   Wed,  2 Aug 2023 02:32:39 -0700
Message-Id: <1690968759-9142-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690968759-9142-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e4fdc90601ed82ae"
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

--000000000000e4fdc90601ed82ae

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Remove unnecessary variable initializations.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 14 +++++++-------
 drivers/infiniband/hw/bnxt_re/main.c       | 12 ++++++------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  8 ++++----
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  8 ++++----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 003a07c..c0a7181 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -284,7 +284,7 @@ int bnxt_re_query_gid(struct ib_device *ibdev, u32 port_num,
 		      int index, union ib_gid *gid)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	int rc = 0;
+	int rc;
 
 	/* Ignore port_num */
 	memset(gid, 0, sizeof(*gid));
@@ -684,7 +684,7 @@ int bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
 	struct bnxt_re_dev *rdev = ah->rdev;
 	bool block = true;
-	int rc = 0;
+	int rc;
 
 	block = !(flags & RDMA_DESTROY_AH_SLEEPABLE);
 	rc = bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah, block);
@@ -834,7 +834,7 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	struct bnxt_re_qp *gsi_sqp;
 	struct bnxt_re_ah *gsi_sah;
 	struct bnxt_re_dev *rdev;
-	int rc = 0;
+	int rc;
 
 	rdev = qp->rdev;
 	gsi_sqp = rdev->gsi_ctx.gsi_sqp;
@@ -1441,7 +1441,7 @@ static int bnxt_re_create_gsi_qp(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 {
 	struct bnxt_re_dev *rdev;
 	struct bnxt_qplib_qp *qplqp;
-	int rc = 0;
+	int rc;
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
@@ -1872,7 +1872,7 @@ static int bnxt_re_modify_shadow_qp(struct bnxt_re_dev *rdev,
 				    int qp_attr_mask)
 {
 	struct bnxt_re_qp *qp = rdev->gsi_ctx.gsi_sqp;
-	int rc = 0;
+	int rc;
 
 	if (qp_attr_mask & IB_QP_STATE) {
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_STATE;
@@ -2222,7 +2222,7 @@ static int bnxt_re_build_qp1_send_v2(struct bnxt_re_qp *qp,
 	u8 ip_version = 0;
 	u16 vlan_id = 0xFFFF;
 	void *buf;
-	int i, rc = 0;
+	int i, rc;
 
 	memset(&qp->qp1_hdr, 0, sizeof(qp->qp1_hdr));
 
@@ -3586,7 +3586,7 @@ static int send_phantom_wqe(struct bnxt_re_qp *qp)
 {
 	struct bnxt_qplib_qp *lib_qp = &qp->qplib_qp;
 	unsigned long flags;
-	int rc = 0;
+	int rc;
 
 	spin_lock_irqsave(&qp->sq_lock, flags);
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c728694..f34ce49 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -360,7 +360,7 @@ static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
 static int bnxt_re_register_netdev(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev;
-	int rc = 0;
+	int rc;
 
 	en_dev = rdev->en_dev;
 
@@ -1145,7 +1145,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_re_ring_attr rattr = {};
 	int num_vec_created = 0;
-	int rc = 0, i;
+	int rc, i;
 	u8 type;
 
 	/* Configure and allocate resources for qplib */
@@ -1343,7 +1343,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 	struct hwrm_ver_get_input req = {};
 	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_fw_msg fw_msg = {};
-	int rc = 0;
+	int rc;
 
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VER_GET);
 	req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
@@ -1373,7 +1373,7 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 {
-	int rc = 0;
+	int rc;
 	u32 event;
 
 	/* Register ib dev */
@@ -1613,7 +1613,7 @@ static int bnxt_re_add_device(struct auxiliary_device *adev, u8 wqe_mode)
 		container_of(adev, struct bnxt_aux_priv, aux_dev);
 	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
-	int rc = 0;
+	int rc;
 
 	/* en_dev should never be NULL as long as adev and aux_dev are valid. */
 	en_dev = aux_priv->edev;
@@ -1859,7 +1859,7 @@ static struct auxiliary_driver bnxt_re_driver = {
 
 static int __init bnxt_re_mod_init(void)
 {
-	int rc = 0;
+	int rc;
 
 	pr_info("%s: %s", ROCE_DRV_MODULE_NAME, version);
 	rc = auxiliary_driver_register(&bnxt_re_driver);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 282e34e..db9890e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -517,7 +517,7 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 			 cqn_handler_t cqn_handler,
 			 srqn_handler_t srqn_handler)
 {
-	int rc = -1;
+	int rc;
 
 	nq->pdev = pdev;
 	nq->cqn_handler = cqn_handler;
@@ -712,7 +712,7 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_rcfw_sbuf sbuf;
 	struct creq_query_srq_resp_sb *sb;
 	struct cmdq_query_srq req = {};
-	int rc = 0;
+	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_SRQ,
@@ -1354,7 +1354,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct creq_query_qp_resp_sb *sb;
 	struct cmdq_query_qp req = {};
 	u32 temp32[4];
-	int i, rc = 0;
+	int i, rc;
 
 	sbuf.size = ALIGN(sizeof(*sb), BNXT_QPLIB_CMDQE_UNITS);
 	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 9d26871..287117e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -488,7 +488,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_crsqe *crsqe;
 	unsigned long flags;
 	u16 cookie;
-	int rc = 0;
+	int rc;
 	u8 opcode;
 
 	opcode = __get_cmdq_base_opcode(msg->req, msg->req_sz);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index d47764c..6f1e8b7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -385,7 +385,7 @@ static int bnxt_qplib_alloc_tqm_rings(struct bnxt_qplib_res *res,
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
 	struct bnxt_qplib_tqm_ctx *tqmctx;
-	int rc = 0;
+	int rc;
 	int i;
 
 	tqmctx = &ctx->tqm_ctx;
@@ -463,7 +463,7 @@ static void bnxt_qplib_map_tqm_pgtbl(struct bnxt_qplib_tqm_ctx *ctx)
 static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
 				      struct bnxt_qplib_ctx *ctx)
 {
-	int rc = 0;
+	int rc;
 
 	rc = bnxt_qplib_alloc_tqm_rings(res, ctx);
 	if (rc)
@@ -501,7 +501,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
-	int rc = 0;
+	int rc;
 
 	if (virt_fn || is_p5)
 		goto stats_alloc;
@@ -876,7 +876,7 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 			 struct net_device *netdev,
 			 struct bnxt_qplib_dev_attr *dev_attr)
 {
-	int rc = 0;
+	int rc;
 
 	res->pdev = pdev;
 	res->netdev = netdev;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 05ee8fd..a27b685 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -72,7 +72,7 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_query_version_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_query_version req = {};
-	int rc = 0;
+	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_VERSION,
@@ -97,7 +97,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_rcfw_sbuf sbuf;
 	struct cmdq_query_func req = {};
 	u8 *tqm_alloc;
-	int i, rc = 0;
+	int i, rc;
 	u32 temp;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -184,7 +184,7 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 	struct creq_set_func_resources_resp resp = {};
 	struct cmdq_set_func_resources req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
-	int rc = 0;
+	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_SET_FUNC_RESOURCES,
@@ -717,7 +717,7 @@ int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 	struct cmdq_query_roce_stats req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct bnxt_qplib_rcfw_sbuf sbuf;
-	int rc = 0;
+	int rc;
 
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_QUERY_ROCE_STATS,
-- 
2.5.5


--000000000000e4fdc90601ed82ae
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPU6SgsmrdOF
Sj++hDAMkL5H6UBJRKY3Ys/xvzucXadCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDgwMjA5NDQzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBPOxZv4ylwc5uxHLfpN8YR975D/0fs
l0L8ewSCu14OH7ZAco5Ex1ecScJ4Z0jzv8dKBeCqUvr7s4AHmJFLBawd1E5NeySxnvHgHOlO6yZs
O+qAnDXmEDCCXBwIiqhspouxh+Q9xf1M2CN/FNONLZXRTV4bhz9cvSKDaAvSs+Ek4dK62NQKmmk3
8m9ZIkUOjjF4n/CeqqcPlMxtRtKRYGhghwk8uPXkeZ3qrWmHWVsljOWQPx0C5ODAG/4Ip2PYQtLD
ClzvmFEFZKCPtqjyhLM37iD1L17KaQI2rvn4AxGDeMwTpFEIbEU0Ase8oMeRdvGbdYNZ6cOZNCYb
3rJid6ad
--000000000000e4fdc90601ed82ae--
