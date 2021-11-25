Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5018445D3AE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 04:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhKYDln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 22:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbhKYDjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Nov 2021 22:39:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB14C061756
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 19:36:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so19304937edd.13
        for <linux-rdma@vger.kernel.org>; Wed, 24 Nov 2021 19:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/K1fuWfHILdOgx/z1ju403dd56V1mou8GsOP4DFL7vg=;
        b=AGdGSo0D6rBaEvxy2bmV8uVX8+4rLfiUWs1M88kd9vLYvGlRc2lGVn2z/VfhPPoNke
         sJ0QpmXQU1XUQiJm84cQqd2I0X/OZTFYvKQ/9AmXinrPipyJI4aUSU4OkZYVE5ZhVq15
         JnqhxZp+n5YtK9cW8FBUFlUOHg+VNMWnXD+TU2LYBOExBsTeKHY6SENOOBwMsUNHBhyH
         9oaASnPQzQemyqZbiF9Jq82wJ61MnH2YN6L+1cxj4D2S6PAsTEWfbegc6Ce4gbS5W7eR
         Tk0RlocpG1xBel38y+DfznMFbHHDuIYYuUWuLXSPIC6XIdrnfBmd0uQ7N+LI6qqKkZjF
         kwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/K1fuWfHILdOgx/z1ju403dd56V1mou8GsOP4DFL7vg=;
        b=bQMDqRkp7VdbMIQOvdKbG8Kd2VGZ2IR08PnQTq2Bw3HyOF1pw1R2XyFQNGreKCPhFa
         OP9fmFg0Svx+1A/BbGMSx6xLe1HNBZdZw37kE9FabtzMkrnx0wBbGwylvdWjR7kyo3WQ
         etGvNboCjMDEUhifX0aLoN/f/Xw1tsmkZMxFzDnL2xCw0dbVmV5Q9UxzbIlu+2y7XcX9
         iEMRHR/ao8IV/VwEI1iqzgB+eru7OntRzLUsBbp/lteVUY7LbW68RBMLeCoUpUze2cAG
         FSxnVP3Q8GSpX2QjA0LIlF4aKjUwNkDb8st/pIAs/oXel8luAhA0UB1vrgamJyVLdP5w
         DnGQ==
X-Gm-Message-State: AOAM5302vlZDxRsp9tdPtVeaLsMO5h0SBem6rS2ujfABQOm7o+Yff/uK
        So+r9yX1Oxpkdw8rXsg0kcdKUlVxjIM=
X-Google-Smtp-Source: ABdhPJyqn/fiZ9nPDbFsbATEabMhD+6WrRznLEy//Ga0DbnsN/hxY7U3iqSRcmuljF/GTH9WMtoUPA==
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr26445860ejb.69.1637811390952;
        Wed, 24 Nov 2021 19:36:30 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1003])
        by smtp.gmail.com with ESMTPSA id sh33sm836864ejc.56.2021.11.24.19.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 19:36:30 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Remove pkey table
Date:   Thu, 25 Nov 2021 05:36:15 +0200
Message-Id: <20211125033615.483750-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The RoCE spec requires RoCE devices to support only the default pkey.
However the bnxt_re driver maintains 0xFFFF entries pkey table and uses
only the first entry. Remove the pkey table and hard code a table of
length one hard wired with the default pkey.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  9 +--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 11 ++-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 50 ------------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  7 --
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 99 +----------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  9 ---
 6 files changed, 10 insertions(+), 175 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 29cc0d14399a..3224f18a66e5 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -262,13 +262,12 @@ void bnxt_re_query_fw_str(struct ib_device *ibdev, char *str)
 int bnxt_re_query_pkey(struct ib_device *ibdev, u32 port_num,
 		       u16 index, u16 *pkey)
 {
-	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
+	if (index > 0)
+		return -EINVAL;
 
-	/* Ignore port_num */
+	*pkey = IB_DEFAULT_PKEY_FULL;
 
-	memset(pkey, 0, sizeof(*pkey));
-	return bnxt_qplib_get_pkey(&rdev->qplib_res,
-				   &rdev->qplib_res.pkey_tbl, index, pkey);
+	return 0;
 }
 
 int bnxt_re_query_gid(struct ib_device *ibdev, u32 port_num,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index ca88849559bf..f6472cca9ec7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -46,6 +46,7 @@
 #include <linux/delay.h>
 #include <linux/prefetch.h>
 #include <linux/if_ether.h>
+#include <rdma/ib_mad.h>
 
 #include "roce_hsi.h"
 
@@ -1232,7 +1233,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct cmdq_modify_qp req;
 	struct creq_modify_qp_resp resp;
-	u16 cmd_flags = 0, pkey;
+	u16 cmd_flags = 0;
 	u32 temp32[4];
 	u32 bmask;
 	int rc;
@@ -1255,11 +1256,9 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS)
 		req.access = qp->access;
 
-	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_PKEY) {
-		if (!bnxt_qplib_get_pkey(res, &res->pkey_tbl,
-					 qp->pkey_index, &pkey))
-			req.pkey = cpu_to_le16(pkey);
-	}
+	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_PKEY)
+		req.pkey = IB_DEFAULT_PKEY_FULL;
+
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_QKEY)
 		req.qkey = cpu_to_le32(qp->qkey);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index bc1ba4b51ba4..126d4f26f75a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -649,31 +649,6 @@ static void bnxt_qplib_init_sgid_tbl(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	memset(sgid_tbl->hw_id, -1, sizeof(u16) * sgid_tbl->max);
 }
 
-static void bnxt_qplib_free_pkey_tbl(struct bnxt_qplib_res *res,
-				     struct bnxt_qplib_pkey_tbl *pkey_tbl)
-{
-	if (!pkey_tbl->tbl)
-		dev_dbg(&res->pdev->dev, "PKEY tbl not present\n");
-	else
-		kfree(pkey_tbl->tbl);
-
-	pkey_tbl->tbl = NULL;
-	pkey_tbl->max = 0;
-	pkey_tbl->active = 0;
-}
-
-static int bnxt_qplib_alloc_pkey_tbl(struct bnxt_qplib_res *res,
-				     struct bnxt_qplib_pkey_tbl *pkey_tbl,
-				     u16 max)
-{
-	pkey_tbl->tbl = kcalloc(max, sizeof(u16), GFP_KERNEL);
-	if (!pkey_tbl->tbl)
-		return -ENOMEM;
-
-	pkey_tbl->max = max;
-	return 0;
-};
-
 /* PDs */
 int bnxt_qplib_alloc_pd(struct bnxt_qplib_pd_tbl *pdt, struct bnxt_qplib_pd *pd)
 {
@@ -843,24 +818,6 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res     *res,
 	return -ENOMEM;
 }
 
-/* PKEYs */
-static void bnxt_qplib_cleanup_pkey_tbl(struct bnxt_qplib_pkey_tbl *pkey_tbl)
-{
-	memset(pkey_tbl->tbl, 0, sizeof(u16) * pkey_tbl->max);
-	pkey_tbl->active = 0;
-}
-
-static void bnxt_qplib_init_pkey_tbl(struct bnxt_qplib_res *res,
-				     struct bnxt_qplib_pkey_tbl *pkey_tbl)
-{
-	u16 pkey = 0xFFFF;
-
-	memset(pkey_tbl->tbl, 0, sizeof(u16) * pkey_tbl->max);
-
-	/* pkey default = 0xFFFF */
-	bnxt_qplib_add_pkey(res, pkey_tbl, &pkey, false);
-}
-
 /* Stats */
 static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
 				      struct bnxt_qplib_stats *stats)
@@ -891,21 +848,18 @@ static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
 
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res)
 {
-	bnxt_qplib_cleanup_pkey_tbl(&res->pkey_tbl);
 	bnxt_qplib_cleanup_sgid_tbl(res, &res->sgid_tbl);
 }
 
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res)
 {
 	bnxt_qplib_init_sgid_tbl(&res->sgid_tbl, res->netdev);
-	bnxt_qplib_init_pkey_tbl(res, &res->pkey_tbl);
 
 	return 0;
 }
 
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 {
-	bnxt_qplib_free_pkey_tbl(res, &res->pkey_tbl);
 	bnxt_qplib_free_sgid_tbl(res, &res->sgid_tbl);
 	bnxt_qplib_free_pd_tbl(&res->pd_tbl);
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
@@ -924,10 +878,6 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_pkey_tbl(res, &res->pkey_tbl, dev_attr->max_pkey);
-	if (rc)
-		goto fail;
-
 	rc = bnxt_qplib_alloc_pd_tbl(res, &res->pd_tbl, dev_attr->max_pd);
 	if (rc)
 		goto fail;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index e1411a2352a7..982e2c96dac2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -185,12 +185,6 @@ struct bnxt_qplib_sgid_tbl {
 	u8				*vlan;
 };
 
-struct bnxt_qplib_pkey_tbl {
-	u16				*tbl;
-	u16				max;
-	u16				active;
-};
-
 struct bnxt_qplib_dpi {
 	u32				dpi;
 	void __iomem			*dbr;
@@ -258,7 +252,6 @@ struct bnxt_qplib_res {
 	struct bnxt_qplib_rcfw		*rcfw;
 	struct bnxt_qplib_pd_tbl	pd_tbl;
 	struct bnxt_qplib_sgid_tbl	sgid_tbl;
-	struct bnxt_qplib_pkey_tbl	pkey_tbl;
 	struct bnxt_qplib_dpi_tbl	dpi_tbl;
 	bool				prio;
 	bool                            is_vf;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 379e715ebd30..b802981b7171 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -146,17 +146,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	attr->max_srq = le16_to_cpu(sb->max_srq);
 	attr->max_srq_wqes = le32_to_cpu(sb->max_srq_wr) - 1;
 	attr->max_srq_sges = sb->max_srq_sge;
-	attr->max_pkey = le32_to_cpu(sb->max_pkeys);
-	/*
-	 * Some versions of FW reports more than 0xFFFF.
-	 * Restrict it for now to 0xFFFF to avoid
-	 * reporting trucated value
-	 */
-	if (attr->max_pkey > 0xFFFF) {
-		/* ib_port_attr::pkey_tbl_len is u16 */
-		attr->max_pkey = 0xFFFF;
-	}
-
+	attr->max_pkey = 1;
 	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
 	attr->l2_db_size = (sb->l2_db_space_size + 1) *
 			    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
@@ -414,93 +404,6 @@ int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 	return rc;
 }
 
-/* pkeys */
-int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 index,
-			u16 *pkey)
-{
-	if (index == 0xFFFF) {
-		*pkey = 0xFFFF;
-		return 0;
-	}
-	if (index >= pkey_tbl->max) {
-		dev_err(&res->pdev->dev,
-			"Index %d exceeded PKEY table max (%d)\n",
-			index, pkey_tbl->max);
-		return -EINVAL;
-	}
-	memcpy(pkey, &pkey_tbl->tbl[index], sizeof(*pkey));
-	return 0;
-}
-
-int bnxt_qplib_del_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
-			bool update)
-{
-	int i, rc = 0;
-
-	if (!pkey_tbl) {
-		dev_err(&res->pdev->dev, "PKEY table not allocated\n");
-		return -EINVAL;
-	}
-
-	/* Do we need a pkey_lock here? */
-	if (!pkey_tbl->active) {
-		dev_err(&res->pdev->dev, "PKEY table has no active entries\n");
-		return -ENOMEM;
-	}
-	for (i = 0; i < pkey_tbl->max; i++) {
-		if (!memcmp(&pkey_tbl->tbl[i], pkey, sizeof(*pkey)))
-			break;
-	}
-	if (i == pkey_tbl->max) {
-		dev_err(&res->pdev->dev,
-			"PKEY 0x%04x not found in the pkey table\n", *pkey);
-		return -ENOMEM;
-	}
-	memset(&pkey_tbl->tbl[i], 0, sizeof(*pkey));
-	pkey_tbl->active--;
-
-	/* unlock */
-	return rc;
-}
-
-int bnxt_qplib_add_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
-			bool update)
-{
-	int i, free_idx, rc = 0;
-
-	if (!pkey_tbl) {
-		dev_err(&res->pdev->dev, "PKEY table not allocated\n");
-		return -EINVAL;
-	}
-
-	/* Do we need a pkey_lock here? */
-	if (pkey_tbl->active == pkey_tbl->max) {
-		dev_err(&res->pdev->dev, "PKEY table is full\n");
-		return -ENOMEM;
-	}
-	free_idx = pkey_tbl->max;
-	for (i = 0; i < pkey_tbl->max; i++) {
-		if (!memcmp(&pkey_tbl->tbl[i], pkey, sizeof(*pkey)))
-			return -EALREADY;
-		else if (!pkey_tbl->tbl[i] && free_idx == pkey_tbl->max)
-			free_idx = i;
-	}
-	if (free_idx == pkey_tbl->max) {
-		dev_err(&res->pdev->dev,
-			"PKEY table is FULL but count is not MAX??\n");
-		return -ENOMEM;
-	}
-	/* Add PKEY to the pkey_tbl */
-	memcpy(&pkey_tbl->tbl[free_idx], pkey, sizeof(*pkey));
-	pkey_tbl->active++;
-
-	/* unlock */
-	return rc;
-}
-
 /* AH */
 int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			 bool block)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index a18f568cb23e..5939e8fc8353 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -255,15 +255,6 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-int bnxt_qplib_get_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 index,
-			u16 *pkey);
-int bnxt_qplib_del_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
-			bool update);
-int bnxt_qplib_add_pkey(struct bnxt_qplib_res *res,
-			struct bnxt_qplib_pkey_tbl *pkey_tbl, u16 *pkey,
-			bool update);
 int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 			    struct bnxt_qplib_dev_attr *attr, bool vf);
 int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
-- 
2.31.1

