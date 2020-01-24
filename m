Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA87A147854
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgAXFxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:53:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42949 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgAXFxF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:53:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so319531plk.9
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+d4/ajKqTprUSPQYAVhggBz1+wGyGiOaA02X4X3gkUc=;
        b=AEC2Mt3AypR/TQA5MvGDGTomwKKg8Cd7UruphMRhUxANhOM+mO4XZiXEupDvwrtCpW
         5UCpAl5PmlHsePlqXWRvp76ikFW/6yxvD3Oej76ODpp78/KyS8mhdtipAFnjom4jb8b6
         oicnHMCIR3URn76OjRBuEuSA5rjCiRCyiP+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+d4/ajKqTprUSPQYAVhggBz1+wGyGiOaA02X4X3gkUc=;
        b=I9+7uNP9TlwF4CE1B+9i1InkFhlJ81Bd9FTpVN68QqGm/BxYg83vK87A7OmnJgR6z3
         GBbAIVlMlCIQGroduVfYpY73h+r7TXOhgatRfsphz6OnsgFaVfpN216mq5jox4P4ki+k
         qupVBK49jA/SJnhtmRjE0TeOQchcZbU4PGOv0Oagqjfu2lqzx36lv8cxZ3uwtHBhpRj6
         VUrcv0fVajDg1yLbDzAUyEnf3gILObnxi4Ilqi9LNG70P9wz4EX3THB4B9FdSfGj1huS
         4UdIZ98knnNoB7Hg9hCeog3cpC81YKYPIQ1KAH4JUeulvfb1/nOyja3iy4oHOuDlJfwS
         HtPQ==
X-Gm-Message-State: APjAAAVamx+b9nC8cpJECdt2mlbh2Ae+0nLLueCCh1VRMjoS2br7LvA4
        onZwJ9xw4W+ZCvLW/Oc3DvL2fKPm2whmCIra1OimkTlFP9mm5H8doCmuvN8UH362ANjP6uwuHhf
        /a88HGq51CT73vWaqvHxiAARVNyw9hQLpuVPPwDVmiCVcUYNU9PSuqSM6uHE33YIc4HBpvM89K6
        1zB+aLZg==
X-Google-Smtp-Source: APXvYqxEBxFZB1L8+83Z4fmshpRLI+vA/lpWd3S/a5Nyw6gFJBicgjrpUUPt1ILeBSLsiA9W6GQc1g==
X-Received: by 2002:a17:90b:8c6:: with SMTP id ds6mr1409620pjb.111.1579845184490;
        Thu, 23 Jan 2020 21:53:04 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:53:03 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation function
Date:   Fri, 24 Jan 2020 00:52:42 -0500
Message-Id: <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introducing a new attribute structure to reduce
the long list of arguments passed in bnxt_re_net_ring_alloc()
function.

The caller of bnxt_re_net_ring_alloc should fill in
the list of attributes in bnxt_re_ring_attr structure
and then pass the pointer to the function.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  9 +++++
 drivers/infiniband/hw/bnxt_re/main.c    | 65 ++++++++++++++++++---------------
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 86274f4..c736e82 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -89,6 +89,15 @@
 
 #define BNXT_RE_DEFAULT_ACK_DELAY	16
 
+struct bnxt_re_ring_attr {
+	dma_addr_t	*dma_arr;
+	int		pages;
+	int		type;
+	u32		depth;
+	u32		lrid; /* Logical ring id */
+	u8		mode;
+};
+
 struct bnxt_re_work {
 	struct work_struct	work;
 	unsigned long		event;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a966c68..648a5ea 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -427,9 +427,9 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
-static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
-				  int pages, int type, u32 ring_mask,
-				  u32 map_index, u16 *fw_ring_id)
+static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
+				  struct bnxt_re_ring_attr *ring_attr,
+				  u16 *fw_ring_id)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ring_alloc_input req = {0};
@@ -443,18 +443,18 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev, dma_addr_t *dma_arr,
 	memset(&fw_msg, 0, sizeof(fw_msg));
 	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_RING_ALLOC, -1, -1);
 	req.enables = 0;
-	req.page_tbl_addr =  cpu_to_le64(dma_arr[0]);
-	if (pages > 1) {
+	req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
+	if (ring_attr->pages > 1) {
 		/* Page size is in log2 units */
 		req.page_size = BNXT_PAGE_SHIFT;
 		req.page_tbl_depth = 1;
 	}
 	req.fbo = 0;
 	/* Association of ring index with doorbell index and MSIX number */
-	req.logical_id = cpu_to_le16(map_index);
-	req.length = cpu_to_le32(ring_mask + 1);
-	req.ring_type = type;
-	req.int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+	req.logical_id = cpu_to_le16(ring_attr->lrid);
+	req.length = cpu_to_le32(ring_attr->depth + 1);
+	req.ring_type = ring_attr->type;
+	req.int_mode = ring_attr->mode;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
 	rc = en_dev->en_ops->bnxt_send_fw_msg(en_dev, BNXT_ROCE_ULP, &fw_msg);
@@ -1006,12 +1006,13 @@ static void bnxt_re_free_res(struct bnxt_re_dev *rdev)
 
 static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_ctx *qplib_ctx;
+	struct bnxt_re_ring_attr rattr;
 	int num_vec_created = 0;
-	dma_addr_t *pg_map;
 	int rc = 0, i;
-	int pages;
 	u8 type;
 
+	memset(&rattr, 0, sizeof(rattr));
 	/* Configure and allocate resources for qplib */
 	rdev->qplib_res.rcfw = &rdev->rcfw;
 	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr,
@@ -1030,10 +1031,13 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
+	qplib_ctx = &rdev->qplib_ctx;
 	for (i = 0; i < rdev->num_msix - 1; i++) {
-		rdev->nq[i].res = &rdev->qplib_res;
-		rdev->nq[i].hwq.max_elements = BNXT_RE_MAX_CQ_COUNT +
-			BNXT_RE_MAX_SRQC_COUNT + 2;
+		struct bnxt_qplib_nq *nq;
+
+		nq = &rdev->nq[i];
+		nq->hwq.max_elements = (qplib_ctx->cq_count +
+					qplib_ctx->srqc_count + 2);
 		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev), "Alloc Failed NQ%d rc:%#x",
@@ -1041,12 +1045,13 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 			goto free_nq;
 		}
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		pg_map = rdev->nq[i].hwq.pbl[PBL_LVL_0].pg_map_arr;
-		pages = rdev->nq[i].hwq.pbl[rdev->nq[i].hwq.level].pg_count;
-		rc = bnxt_re_net_ring_alloc(rdev, pg_map, pages, type,
-					    BNXT_QPLIB_NQE_MAX_CNT - 1,
-					    rdev->msix_entries[i + 1].ring_idx,
-					    &rdev->nq[i].ring_id);
+		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
+		rattr.pages = nq->hwq.pbl[rdev->nq[i].hwq.level].pg_count;
+		rattr.type = type;
+		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
+		rattr.lrid = rdev->msix_entries[i + 1].ring_idx;
+		rc = bnxt_re_net_ring_alloc(rdev, &rattr, &nq->ring_id);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev),
 				"Failed to allocate NQ fw id with rc = 0x%x",
@@ -1371,10 +1376,10 @@ static void bnxt_re_worker(struct work_struct *work)
 
 static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 {
-	dma_addr_t *pg_map;
-	u32 db_offt, ridx;
-	int pages, vid;
+	struct bnxt_re_ring_attr rattr;
+	u32 db_offt;
 	bool locked;
+	int vid;
 	u8 type;
 	int rc;
 
@@ -1383,6 +1388,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	locked = true;
 
 	/* Registered a new RoCE device instance to netdev */
+	memset(&rattr, 0, sizeof(rattr));
 	rc = bnxt_re_register_netdev(rdev);
 	if (rc) {
 		rtnl_unlock();
@@ -1422,12 +1428,13 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	}
 
 	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-	pg_map = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
-	pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
-	ridx = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
-	rc = bnxt_re_net_ring_alloc(rdev, pg_map, pages, type,
-				    BNXT_QPLIB_CREQE_MAX_CNT - 1,
-				    ridx, &rdev->rcfw.creq_ring_id);
+	rattr.dma_arr = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
+	rattr.pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
+	rattr.type = type;
+	rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+	rattr.depth = BNXT_QPLIB_CREQE_MAX_CNT - 1;
+	rattr.lrid = rdev->msix_entries[BNXT_RE_AEQ_IDX].ring_idx;
+	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &rdev->rcfw.creq_ring_id);
 	if (rc) {
 		pr_err("Failed to allocate CREQ: %#x\n", rc);
 		goto free_rcfw;
-- 
1.8.3.1

