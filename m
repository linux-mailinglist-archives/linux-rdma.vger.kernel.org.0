Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DF516A44C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXKuK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:50:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45662 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKuK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 05:50:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so9770962wrs.12
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 02:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=id9545e4k3uqojt7fpw66/OXpIo0MOpueljiI8GftZ0=;
        b=LQAQxvuwN/RTXpR1GcbVx5aegGLcwHkNFr2eGCyzLABxU3Y/gr022LtewgchLwp+S4
         cItZ3CJyjpxJHRL/dMhaobmfysR1IRkPqLOuFbcc8dI80yYt7e5mxq0zcvXeBVZe7t1m
         OmCyEeLfCUpu5IMnx2STodi5opSijwCjr6QvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=id9545e4k3uqojt7fpw66/OXpIo0MOpueljiI8GftZ0=;
        b=JkWZR9urvj8xh/6zm8ApsZlyMnz/c9E2Y/JmpxbPxx2zPmadi7CCWhwUGpnompiH06
         DYZXvsp9JtUYapMMesEw2D+c1iGWjqDLzjOmVhfzcYE/DHADn2TgNSGSIKPL7BfPPj5b
         spl9HXIZQzC4mucRaifVt5UskAbiAaKvoAwhltznVZH8mfVFiJgc3sYRdI513GTtBgRB
         txt9vpG5vptVE+kEoXjs6GhLV6UxLjamQ2G92tyJjYzbrwy+raTs194at6LBfdHtfP1G
         XCN76lU2RWPidm0YdFvHTsdnkb+tdgfyx3dChukzx904We+pQb5HNp1CgHbsPA9aiRME
         4N3Q==
X-Gm-Message-State: APjAAAWJer5dzTsY2ddFAV0c2iwoTZsUaZJxoDCIM/lw7J8ibim5fUOt
        fdK+4AcpEHmeEgS1013A8dB+yQ==
X-Google-Smtp-Source: APXvYqxY4Bfz8fjpLFd60hWboK4Yobnqr255WZuCm634VEBG3amhRMKtduN4X1Kcb8N4Cd5U9btaQw==
X-Received: by 2002:adf:e401:: with SMTP id g1mr10494254wrm.165.1582541407653;
        Mon, 24 Feb 2020 02:50:07 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c9sm18096426wrq.44.2020.02.24.02.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 02:50:06 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/3] RDMA/bnxt_re: Add more flags in device init and uninit path
Date:   Mon, 24 Feb 2020 02:49:53 -0800
Message-Id: <1582541395-19409-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add more flags for better granularity in in device init/uninit path

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 16 +++++++++----
 drivers/infiniband/hw/bnxt_re/main.c    | 41 ++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c736e82..0babc66 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -135,11 +135,17 @@ struct bnxt_re_dev {
 #define BNXT_RE_FLAG_IBDEV_REGISTERED		1
 #define BNXT_RE_FLAG_GOT_MSIX			2
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
-#define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
-#define BNXT_RE_FLAG_QOS_WORK_REG		5
-#define BNXT_RE_FLAG_RESOURCES_ALLOCATED	7
-#define BNXT_RE_FLAG_RESOURCES_INITIALIZED	8
-#define BNXT_RE_FLAG_ISSUE_ROCE_STATS          29
+#define BNXT_RE_FLAG_ALLOC_RCFW			4
+#define BNXT_RE_FLAG_NET_RING_ALLOC		5
+#define BNXT_RE_FLAG_RCFW_CHANNEL_EN		6
+#define BNXT_RE_FLAG_ALLOC_CTX			7
+#define BNXT_RE_FLAG_STATS_CTX_ALLOC		8
+#define BNXT_RE_FLAG_STATS_CTX2_ALLOC		9
+#define BNXT_RE_FLAG_RCFW_CHANNEL_INIT		10
+#define BNXT_RE_FLAG_QOS_WORK_REG		11
+#define BNXT_RE_FLAG_RESOURCES_ALLOCATED	12
+#define BNXT_RE_FLAG_RESOURCES_INITIALIZED	13
+#define BNXT_RE_FLAG_ISSUE_ROCE_STATS		29
 	struct net_device		*netdev;
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b5128cc..1402130 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1335,18 +1335,23 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_ALLOCATED, &rdev->flags))
 		bnxt_re_free_res(rdev);
 
-	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags)) {
+	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_INIT, &rdev->flags)) {
 		rc = bnxt_qplib_deinit_rcfw(&rdev->rcfw);
 		if (rc)
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to deinitialize RCFW: %#x", rc);
+	}
+	if (test_and_clear_bit(BNXT_RE_FLAG_STATS_CTX_ALLOC, &rdev->flags))
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
+	if (test_and_clear_bit(BNXT_RE_FLAG_ALLOC_CTX, &rdev->flags))
 		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
+	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags))
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
-		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
+	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
+	if (test_and_clear_bit(BNXT_RE_FLAG_NET_RING_ALLOC, &rdev->flags))
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
+	if (test_and_clear_bit(BNXT_RE_FLAG_ALLOC_RCFW, &rdev->flags))
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
-	}
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags)) {
 		rc = bnxt_re_free_msix(rdev);
 		if (rc)
@@ -1430,6 +1435,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 		goto fail;
 	}
 
+	set_bit(BNXT_RE_FLAG_ALLOC_RCFW, &rdev->flags);
 	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 	creq = &rdev->rcfw.creq;
 	rattr.dma_arr = creq->hwq.pbl[PBL_LVL_0].pg_map_arr;
@@ -1441,8 +1447,9 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	rc = bnxt_re_net_ring_alloc(rdev, &rattr, &creq->ring_id);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to allocate CREQ: %#x\n", rc);
-		goto free_rcfw;
+		goto fail;
 	}
+	set_bit(BNXT_RE_FLAG_NET_RING_ALLOC, &rdev->flags);
 	db_offt = bnxt_re_get_nqdb_offset(rdev, BNXT_RE_AEQ_IDX);
 	vid = rdev->msix_entries[BNXT_RE_AEQ_IDX].vector;
 	rc = bnxt_qplib_enable_rcfw_channel(&rdev->rcfw,
@@ -1451,13 +1458,14 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to enable RCFW channel: %#x\n",
 			  rc);
-		goto free_ring;
+		goto fail;
 	}
 
+	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags);
 	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr,
 				     rdev->is_virtfn);
 	if (rc)
-		goto disable_rcfw;
+		goto fail;
 
 	bnxt_re_set_resource_limits(rdev);
 
@@ -1466,25 +1474,27 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate QPLIB context: %#x\n", rc);
-		goto disable_rcfw;
+		goto fail;
 	}
+	set_bit(BNXT_RE_FLAG_ALLOC_CTX, &rdev->flags);
 	rc = bnxt_re_net_stats_ctx_alloc(rdev,
 					 rdev->qplib_ctx.stats.dma_map,
 					 &rdev->qplib_ctx.stats.fw_id);
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate stats context: %#x\n", rc);
-		goto free_ctx;
+		goto fail;
 	}
 
+	set_bit(BNXT_RE_FLAG_STATS_CTX_ALLOC, &rdev->flags);
 	rc = bnxt_qplib_init_rcfw(&rdev->rcfw, &rdev->qplib_ctx,
 				  rdev->is_virtfn);
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to initialize RCFW: %#x\n", rc);
-		goto free_sctx;
+		goto fail;
 	}
-	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags);
+	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_INIT, &rdev->flags);
 
 	/* Resources based on the 'new' device caps */
 	rc = bnxt_re_alloc_res(rdev);
@@ -1532,17 +1542,6 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_PORT_ACTIVE);
 
 	return 0;
-free_sctx:
-	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-free_ctx:
-	bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
-disable_rcfw:
-	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
-free_ring:
-	type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-	bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
-free_rcfw:
-	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
 	if (!locked)
 		rtnl_lock();
-- 
2.5.5

