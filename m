Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C187572EAD8
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbjFMSYW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbjFMSYV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 14:24:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BCCE
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 11:24:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3b56dcf1bso28294125ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686680658; x=1689272658;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kh+sDQsrrvxORMzLqrKOGrI8+XtO9kGYuw6L/dbxgs=;
        b=T7JP96OndwbpNIhG8l0f49UVbmS80bDdffZqzd0Io8VKX+1EiSb29XI78DKV3FTW28
         uy4XlS7SZ2aibt5NSl7P+Mp5cKEaaYzRM5LvQ/fL5sKn5E8QdXh+u7UyWhfo0qKOpDkx
         5IS2qp/KxqggLdGSncjarDns+Xylqfu+UtTWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680658; x=1689272658;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kh+sDQsrrvxORMzLqrKOGrI8+XtO9kGYuw6L/dbxgs=;
        b=VfPPfJu2QrFr5F9mfrfojru2EXPBygdVpHOoUAWJu024KaYFmBfz1Osit7ML/3nocj
         EvefiC7aEBD7zAZf+Elc/GWagxi4I0VWHTUm/+fBZ4WvtKgtDsdE+AB+crMwq20p855d
         vOcAPCR4aF/Au1tAMBEwFbZ1V8TP2DvwGvuPZ0MMTEI+XApmPxZiF/328VozERe1uPzp
         IPpMT16i2AFQBg0kVV7oARp+xdMW0C3nXb1PMn4k2Ip7R6ZGUGUqNDAsFDW0OQHMtytp
         B760K9gpWerPi8soWSeNwRlfH5CkU/ksCJpBZk7nb5k7VkYrWZpHiXzhyXSAl7oo5Xou
         0YHQ==
X-Gm-Message-State: AC+VfDx+3jUSwhYomT4N44e9aICZgRXMGqzcKOK2wNyjTRHaq+dRH8Rd
        0Nky0kDfbdG+mkrIRo6XWnaFNg==
X-Google-Smtp-Source: ACHHUZ7n9XeRO5910Eg8gGzXSrYsftDr9MvJNitp98AceoX5f5ABNcJeV9zSsX+8PpvY73RS7aZ/Nw==
X-Received: by 2002:a17:902:8694:b0:1b3:d0f5:70ab with SMTP id g20-20020a170902869400b001b3d0f570abmr6019905plo.28.1686680657607;
        Tue, 13 Jun 2023 11:24:17 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001b3fb909f73sm285493plb.112.2023.06.13.11.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:24:16 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v6 for-next 6/7] RDMA/bnxt_re: Reorg the bar mapping
Date:   Tue, 13 Jun 2023 11:12:22 -0700
Message-Id: <1686679943-17117-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686679943-17117-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007808ff05fe06f186"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000007808ff05fe06f186

Reorganize the code for allocation and mapping of
Doorbell pages. Implements new HW command to get the BAR length
used by L2 driver. These changes are used by the future patch
which maps the WC Doorbell pages.

Also, introduced a new lock dpi_tbl_lock for synchronize the
DB page allocation from users.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c       |  71 +++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 174 +++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  28 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |   3 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   1 +
 8 files changed, 213 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1361330..8e3b45d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -618,8 +618,8 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 			 * ibv_devinfo and family of application when DPIs
 			 * are depleted.
 			 */
-			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res.dpi_tbl,
-						 &ucntx->dpi, ucntx)) {
+			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res,
+						 &ucntx->dpi, ucntx, BNXT_QPLIB_DPI_TYPE_UC)) {
 				rc = -ENOMEM;
 				goto dbfail;
 			}
@@ -4095,8 +4095,7 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 		/* Free DPI only if this is the first PD allocated by the
 		 * application and mark the context dpi as NULL
 		 */
-		bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
-				       &rdev->qplib_res.dpi_tbl, &uctx->dpi);
+		bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->dpi);
 		uctx->dpi.dbr = NULL;
 	}
 }
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f8b4265..0c68113 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -85,6 +85,40 @@ static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev);
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev);
 static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
 
+static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
+			     u32 *offset);
+static void bnxt_re_set_db_offset(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_en_dev *en_dev;
+	struct bnxt_qplib_res *res;
+	u32 l2db_len = 0;
+	u32 offset = 0;
+	u32 barlen;
+	int rc;
+
+	res = &rdev->qplib_res;
+	en_dev = rdev->en_dev;
+	cctx = rdev->chip_ctx;
+
+	/* Issue qcfg */
+	rc = bnxt_re_hwrm_qcfg(rdev, &l2db_len, &offset);
+	if (rc)
+		dev_info(rdev_to_dev(rdev),
+			 "Couldn't get DB bar size, Low latency framework is disabled\n");
+	/* set register offsets for both UC and WC */
+	res->dpi_tbl.ucreg.offset = res->is_vf ? BNXT_QPLIB_DBR_VF_DB_OFFSET :
+						 BNXT_QPLIB_DBR_PF_DB_OFFSET;
+	res->dpi_tbl.wcreg.offset = res->dpi_tbl.ucreg.offset;
+
+	/* If WC mapping is disabled by L2 driver then en_dev->l2_db_size
+	 * is equal to the DB-Bar actual size. This indicates that L2
+	 * is mapping entire bar as UC-. RoCE driver can't enable WC mapping
+	 * in such cases and DB-push will be disabled.
+	 */
+	barlen = pci_resource_len(res->pdev, RCFW_DBR_PCI_BAR_REGION);
+}
+
 static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 {
 	struct bnxt_qplib_chip_ctx *cctx;
@@ -116,6 +150,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
+	int rc;
 
 	en_dev = rdev->en_dev;
 
@@ -134,6 +169,12 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 
 	bnxt_re_set_drv_mode(rdev, wqe_mode);
+
+	bnxt_re_set_db_offset(rdev);
+	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
+	if (rc)
+		return rc;
+
 	if (bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
@@ -343,6 +384,30 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
 	fw_msg->timeout = timeout;
 }
 
+/* Query device config using common hwrm */
+static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
+			     u32 *offset)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_func_qcfg_output resp = {0};
+	struct hwrm_func_qcfg_input req = {0};
+	struct bnxt_fw_msg fw_msg;
+	int rc;
+
+	memset(&fw_msg, 0, sizeof(fw_msg));
+	bnxt_re_init_hwrm_hdr(rdev, (void *)&req,
+			      HWRM_FUNC_QCFG, -1, -1);
+	req.fid = cpu_to_le16(0xffff);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (!rc) {
+		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
+		*offset = PAGE_ALIGN(le16_to_cpu(resp.legacy_l2_db_size_kb) * 1024);
+	}
+	return rc;
+}
+
 /* Query function capabilities using common hwrm */
 int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 {
@@ -847,7 +912,6 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
 
 	if (rdev->qplib_res.dpi_tbl.max) {
 		bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
-				       &rdev->qplib_res.dpi_tbl,
 				       &rdev->dpi_privileged);
 	}
 	if (rdev->qplib_res.rcfw) {
@@ -875,9 +939,9 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_dpi(&rdev->qplib_res.dpi_tbl,
+	rc = bnxt_qplib_alloc_dpi(&rdev->qplib_res,
 				  &rdev->dpi_privileged,
-				  rdev);
+				  rdev, BNXT_QPLIB_DPI_TYPE_KERNEL);
 	if (rc)
 		goto dealloc_res;
 
@@ -917,7 +981,6 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		bnxt_qplib_free_nq(&rdev->nq[i]);
 	}
 	bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
-			       &rdev->qplib_res.dpi_tbl,
 			       &rdev->dpi_privileged);
 dealloc_res:
 	bnxt_qplib_free_res(&rdev->qplib_res);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d48a26e..d5d418a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -668,7 +668,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.xid = srq->id;
 	srq->dbinfo.db = srq->dpi->dbr;
 	srq->dbinfo.max_slot = 1;
-	srq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
+	srq->dbinfo.priv_db = res->dpi_tbl.priv_db;
 	if (srq->threshold)
 		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
 	srq->arm_req = false;
@@ -2104,7 +2104,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	cq->dbinfo.hwq = &cq->hwq;
 	cq->dbinfo.xid = cq->id;
 	cq->dbinfo.db = cq->dpi->dbr;
-	cq->dbinfo.priv_db = res->dpi_tbl.dbr_bar_reg_iomem;
+	cq->dbinfo.priv_db = res->dpi_tbl.priv_db;
 
 	bnxt_qplib_armen_db(&cq->dbinfo, DBC_DBC_TYPE_CQ_ARMENA);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index f46de07..7b31bee 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -130,6 +130,8 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 #define RCFW_MAX_COOKIE_VALUE		(BNXT_QPLIB_CMDQE_MAX_CNT - 1)
 #define RCFW_CMD_IS_BLOCKING		0x8000
 
+#define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
+
 /* Crsq buf is 1024-Byte */
 struct bnxt_qplib_crsbe {
 	u8			data[1024];
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 920ab87..e1cbe59 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -704,44 +704,73 @@ static int bnxt_qplib_alloc_pd_tbl(struct bnxt_qplib_res *res,
 }
 
 /* DPIs */
-int bnxt_qplib_alloc_dpi(struct bnxt_qplib_dpi_tbl *dpit,
-			 struct bnxt_qplib_dpi     *dpi,
-			 void                      *app)
+int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_dpi *dpi,
+			 void *app, u8 type)
 {
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+	struct bnxt_qplib_reg_desc *reg;
 	u32 bit_num;
+	u64 umaddr;
+
+	reg = &dpit->wcreg;
+	mutex_lock(&res->dpi_tbl_lock);
 
 	bit_num = find_first_bit(dpit->tbl, dpit->max);
-	if (bit_num == dpit->max)
+	if (bit_num == dpit->max) {
+		mutex_unlock(&res->dpi_tbl_lock);
 		return -ENOMEM;
+	}
 
 	/* Found unused DPI */
 	clear_bit(bit_num, dpit->tbl);
 	dpit->app_tbl[bit_num] = app;
 
-	dpi->dpi = bit_num;
-	dpi->dbr = dpit->dbr_bar_reg_iomem + (bit_num * PAGE_SIZE);
-	dpi->umdbr = dpit->unmapped_dbr + (bit_num * PAGE_SIZE);
+	dpi->bit = bit_num;
+	dpi->dpi = bit_num + (reg->offset - dpit->ucreg.offset) / PAGE_SIZE;
+
+	umaddr = reg->bar_base + reg->offset + bit_num * PAGE_SIZE;
+	dpi->umdbr = umaddr;
+
+	switch (type) {
+	case BNXT_QPLIB_DPI_TYPE_KERNEL:
+		/* priviledged dbr was already mapped just initialize it. */
+		dpi->umdbr = dpit->ucreg.bar_base +
+			     dpit->ucreg.offset + bit_num * PAGE_SIZE;
+		dpi->dbr = dpit->priv_db;
+		dpi->dpi = dpi->bit;
+		break;
+	default:
+		dpi->dbr = ioremap(umaddr, PAGE_SIZE);
+		break;
+	}
 
+	dpi->type = type;
+	mutex_unlock(&res->dpi_tbl_lock);
 	return 0;
+
 }
 
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
-			   struct bnxt_qplib_dpi_tbl *dpit,
-			   struct bnxt_qplib_dpi     *dpi)
+			   struct bnxt_qplib_dpi *dpi)
 {
-	if (dpi->dpi >= dpit->max) {
-		dev_warn(&res->pdev->dev, "Invalid DPI? dpi = %d\n", dpi->dpi);
-		return -EINVAL;
-	}
-	if (test_and_set_bit(dpi->dpi, dpit->tbl)) {
-		dev_warn(&res->pdev->dev, "Freeing an unused DPI? dpi = %d\n",
-			 dpi->dpi);
+	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
+
+	mutex_lock(&res->dpi_tbl_lock);
+	if (dpi->dpi && dpi->type != BNXT_QPLIB_DPI_TYPE_KERNEL)
+		pci_iounmap(res->pdev, dpi->dbr);
+
+	if (test_and_set_bit(dpi->bit, dpit->tbl)) {
+		dev_warn(&res->pdev->dev,
+			 "Freeing an unused DPI? dpi = %d, bit = %d\n",
+				dpi->dpi, dpi->bit);
+		mutex_unlock(&res->dpi_tbl_lock);
 		return -EINVAL;
 	}
 	if (dpit->app_tbl)
-		dpit->app_tbl[dpi->dpi] = NULL;
+		dpit->app_tbl[dpi->bit] = NULL;
 	memset(dpi, 0, sizeof(*dpi));
-
+	mutex_unlock(&res->dpi_tbl_lock);
 	return 0;
 }
 
@@ -750,52 +779,38 @@ static void bnxt_qplib_free_dpi_tbl(struct bnxt_qplib_res     *res,
 {
 	kfree(dpit->tbl);
 	kfree(dpit->app_tbl);
-	if (dpit->dbr_bar_reg_iomem)
-		pci_iounmap(res->pdev, dpit->dbr_bar_reg_iomem);
-	memset(dpit, 0, sizeof(*dpit));
+	dpit->tbl = NULL;
+	dpit->app_tbl = NULL;
+	dpit->max = 0;
 }
 
-static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res     *res,
-				    struct bnxt_qplib_dpi_tbl *dpit,
-				    u32                       dbr_offset)
+static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res *res,
+				    struct bnxt_qplib_dev_attr *dev_attr)
 {
-	u32 dbr_bar_reg = RCFW_DBR_PCI_BAR_REGION;
-	resource_size_t bar_reg_base;
-	u32 dbr_len, bytes;
-
-	if (dpit->dbr_bar_reg_iomem) {
-		dev_err(&res->pdev->dev, "DBR BAR region %d already mapped\n",
-			dbr_bar_reg);
-		return -EALREADY;
-	}
-
-	bar_reg_base = pci_resource_start(res->pdev, dbr_bar_reg);
-	if (!bar_reg_base) {
-		dev_err(&res->pdev->dev, "BAR region %d resc start failed\n",
-			dbr_bar_reg);
-		return -ENOMEM;
-	}
+	struct bnxt_qplib_dpi_tbl *dpit;
+	struct bnxt_qplib_reg_desc *reg;
+	unsigned long bar_len;
+	u32 dbr_offset;
+	u32 bytes;
 
-	dbr_len = pci_resource_len(res->pdev, dbr_bar_reg) - dbr_offset;
-	if (!dbr_len || ((dbr_len & (PAGE_SIZE - 1)) != 0)) {
-		dev_err(&res->pdev->dev, "Invalid DBR length %d\n", dbr_len);
-		return -ENOMEM;
-	}
+	dpit = &res->dpi_tbl;
+	reg = &dpit->wcreg;
 
-	dpit->dbr_bar_reg_iomem = ioremap(bar_reg_base + dbr_offset,
-						  dbr_len);
-	if (!dpit->dbr_bar_reg_iomem) {
-		dev_err(&res->pdev->dev,
-			"FP: DBR BAR region %d mapping failed\n", dbr_bar_reg);
-		return -ENOMEM;
+	if (!bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+		/* Offest should come from L2 driver */
+		dbr_offset = dev_attr->l2_db_size;
+		dpit->ucreg.offset = dbr_offset;
+		dpit->wcreg.offset = dbr_offset;
 	}
 
-	dpit->unmapped_dbr = bar_reg_base + dbr_offset;
-	dpit->max = dbr_len / PAGE_SIZE;
+	bar_len = pci_resource_len(res->pdev, reg->bar_id);
+	dpit->max = (bar_len - reg->offset) / PAGE_SIZE;
+	if (dev_attr->max_dpi)
+		dpit->max = min_t(u32, dpit->max, dev_attr->max_dpi);
 
-	dpit->app_tbl = kcalloc(dpit->max, sizeof(void *), GFP_KERNEL);
+	dpit->app_tbl = kcalloc(dpit->max,  sizeof(void *), GFP_KERNEL);
 	if (!dpit->app_tbl)
-		goto unmap_io;
+		return -ENOMEM;
 
 	bytes = dpit->max >> 3;
 	if (!bytes)
@@ -805,17 +820,14 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res     *res,
 	if (!dpit->tbl) {
 		kfree(dpit->app_tbl);
 		dpit->app_tbl = NULL;
-		goto unmap_io;
+		return -ENOMEM;
 	}
 
 	memset((u8 *)dpit->tbl, 0xFF, bytes);
+	dpit->priv_db = dpit->ucreg.bar_reg + dpit->ucreg.offset;
 
 	return 0;
 
-unmap_io:
-	iounmap(dpit->dbr_bar_reg_iomem);
-	dpit->dbr_bar_reg_iomem = NULL;
-	return -ENOMEM;
 }
 
 /* Stats */
@@ -882,7 +894,7 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_dpi_tbl(res, &res->dpi_tbl, dev_attr->l2_db_size);
+	rc = bnxt_qplib_alloc_dpi_tbl(res, dev_attr);
 	if (rc)
 		goto fail;
 
@@ -892,6 +904,46 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 	return rc;
 }
 
+void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res)
+{
+	struct bnxt_qplib_reg_desc *reg;
+
+	reg = &res->dpi_tbl.ucreg;
+	if (reg->bar_reg)
+		pci_iounmap(res->pdev, reg->bar_reg);
+	reg->bar_reg = NULL;
+	reg->bar_base = 0;
+	reg->len = 0;
+	reg->bar_id = 0;
+}
+
+int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res)
+{
+	struct bnxt_qplib_reg_desc *ucreg;
+	struct bnxt_qplib_reg_desc *wcreg;
+
+	wcreg = &res->dpi_tbl.wcreg;
+	wcreg->bar_id = RCFW_DBR_PCI_BAR_REGION;
+	wcreg->bar_base = pci_resource_start(res->pdev, wcreg->bar_id);
+
+	ucreg = &res->dpi_tbl.ucreg;
+	ucreg->bar_id = RCFW_DBR_PCI_BAR_REGION;
+	ucreg->bar_base = pci_resource_start(res->pdev, ucreg->bar_id);
+	ucreg->len = ucreg->offset + PAGE_SIZE;
+	if (!ucreg->len || ((ucreg->len & (PAGE_SIZE - 1)) != 0)) {
+		dev_err(&res->pdev->dev, "QPLIB: invalid dbr length %d",
+			(int)ucreg->len);
+		return -EINVAL;
+	}
+	ucreg->bar_reg = ioremap(ucreg->bar_base, ucreg->len);
+	if (!ucreg->bar_reg) {
+		dev_err(&res->pdev->dev, "priviledged dpi map failed!");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 int bnxt_qplib_determine_atomics(struct pci_dev *dev)
 {
 	int comp;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 070451a..398a469 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -60,6 +60,9 @@ struct bnxt_qplib_chip_ctx {
 	u64	hwrm_intf_ver;
 };
 
+#define BNXT_QPLIB_DBR_PF_DB_OFFSET     0x10000
+#define BNXT_QPLIB_DBR_VF_DB_OFFSET     0x4000
+
 #define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
 #define PTR_MAX_IDX_PER_PG	(PTR_CNT_PER_PG - 1)
 #define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
@@ -111,6 +114,7 @@ enum bnxt_qplib_hwrm_pg_size {
 struct bnxt_qplib_reg_desc {
 	u8		bar_id;
 	resource_size_t	bar_base;
+	unsigned long	offset;
 	void __iomem	*bar_reg;
 	size_t		len;
 };
@@ -187,18 +191,26 @@ struct bnxt_qplib_sgid_tbl {
 	u8				*vlan;
 };
 
+enum {
+	BNXT_QPLIB_DPI_TYPE_KERNEL      = 0,
+	BNXT_QPLIB_DPI_TYPE_UC          = 1,
+};
+
 struct bnxt_qplib_dpi {
 	u32				dpi;
+	u32				bit;
 	void __iomem			*dbr;
 	u64				umdbr;
+	u8				type;
 };
 
 struct bnxt_qplib_dpi_tbl {
 	void				**app_tbl;
 	unsigned long			*tbl;
 	u16				max;
-	void __iomem			*dbr_bar_reg_iomem;
-	u64				unmapped_dbr;
+	struct bnxt_qplib_reg_desc	ucreg; /* Hold entire DB bar. */
+	struct bnxt_qplib_reg_desc	wcreg;
+	void __iomem			*priv_db;
 };
 
 struct bnxt_qplib_stats {
@@ -254,6 +266,8 @@ struct bnxt_qplib_res {
 	struct bnxt_qplib_pd_tbl	pd_tbl;
 	struct bnxt_qplib_sgid_tbl	sgid_tbl;
 	struct bnxt_qplib_dpi_tbl	dpi_tbl;
+	/* To protect the dpi table bit map */
+	struct mutex                    dpi_tbl_lock;
 	bool				prio;
 	bool                            is_vf;
 };
@@ -345,11 +359,10 @@ int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pd_tbl,
 int bnxt_qplib_dealloc_pd(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_pd_tbl *pd_tbl,
 			  struct bnxt_qplib_pd *pd);
-int bnxt_qplib_alloc_dpi(struct bnxt_qplib_dpi_tbl *dpit,
-			 struct bnxt_qplib_dpi     *dpi,
-			 void                      *app);
+int bnxt_qplib_alloc_dpi(struct bnxt_qplib_res *res,
+			 struct bnxt_qplib_dpi *dpi,
+			 void *app, u8 type);
 int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
-			   struct bnxt_qplib_dpi_tbl *dpi_tbl,
 			   struct bnxt_qplib_dpi *dpi);
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
@@ -362,6 +375,9 @@ void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx,
 			 bool virt_fn, bool is_p5);
+int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res);
+void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res);
+
 int bnxt_qplib_determine_atomics(struct pci_dev *dev);
 
 static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_hwq *hwq, u32 cnt)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 910d17d..d5ad086 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -170,6 +170,9 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 		attr->tqm_alloc_reqs[i * 4 + 3] = *(++tqm_alloc);
 	}
 
+	if (rcfw->res->cctx->hwrm_intf_ver >= HWRM_VERSION_DEV_ATTR_MAX_DPI)
+		attr->max_dpi = le32_to_cpu(sb->max_dpi);
+
 	attr->is_atomic = bnxt_qplib_is_atomic_cap(rcfw);
 bail:
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 4061616..264ef3c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -72,6 +72,7 @@ struct bnxt_qplib_dev_attr {
 	u8				tqm_alloc_reqs[MAX_TQM_ALLOC_REQ];
 	bool				is_atomic;
 	u16                             dev_cap_flags;
+	u32                             max_dpi;
 };
 
 struct bnxt_qplib_pd {
-- 
2.5.5


--0000000000007808ff05fe06f186
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIH8NHc62D7tl
jClbA0hJPRO5TE9VyxSELK1rXlEzvBW/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMzE4MjQxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBc9qfWgJ3bkRBSQwPEOqTw/2QU2F20
fNlYqlL64WyHC3qgxfRKGNcV8Cru3WH4/4THKyYviIHmTfz2tnQCB8XImzhuSfvd0543rS3mP2nj
ulSuIipDX7YraMrimDDG8RDmYsT94BAGukjffT5qhzHq65zpYySmAxq2XRWD2600KjDFmQO30CB6
dJv1XO9gzS5T8ewxDxCafqpitgfYmpBfSnAAHq1p0cs4A3McsTCl1O96Gx1CgR7QXaEcQlRUc5oa
OJm88a+zidMpM63mNVmso7oDZY8IO+thMOr6ajdR3FVBDTQpfKYzdr+BkBiqMdJqVFcNHYVKnxhX
jpSPyWjA
--0000000000007808ff05fe06f186--
