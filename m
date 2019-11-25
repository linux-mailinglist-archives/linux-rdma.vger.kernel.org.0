Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5256108A27
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfKYIkF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:40:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:40:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so16793047wrv.4
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3kSw11JvHCo4FkPc2oNgF2bt6NULAqHJCzqBOnn9g+c=;
        b=Q7D2ZAlR7VrNTsEqXfnTRnZhIQ/gKFCTP+QwgrzfW9J0dYnOoeUb5XP6KubcfHMP7/
         T6YKzPGvX9mMybkg99UFcz04DrEgV0DjI3Gf5X9PwWMnuy8gOJUnsXq3PFCw2cH6ax5F
         ec+cqWYsUo/zc3TzKL1jn2teHshTJBXHvhjsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3kSw11JvHCo4FkPc2oNgF2bt6NULAqHJCzqBOnn9g+c=;
        b=AcHoZzkVGXMhALO0jbONH5sckKrQ6kh0y9c7Ho2OpId0oBD2jNaMZ8HIMG3NWnCVsJ
         jWjdkr/G011yXlA29rPwlCKOvYSolJd938qXR0KaziW77qrMnQbQEh3seAal9pEsSHmy
         B/T+X5+MSyA5piBhr9DFZC1bImnzfCpres5qyFHD8pdIcM6jLqJAFK8YcxUcb70lkbrX
         X2ENJNTVg9dC3SAjVZVXIIQDOjqvxbwN0gBXr4e5mjo4FzFGVg6C3igQ5ke+qG37d7pd
         siqLuP6IQVcI1vO20J97q8e/x3wzU3IarZwMheX+OqdzjiAnB+2bNICqk4dhMxZDWAXo
         1+Dw==
X-Gm-Message-State: APjAAAX/FhT8p2RrK+rpclJT9OO702R1gnMXz2SHad087wrt8J8Zqxxs
        kJ7BoqgAcriQNHqVZ2Hz7SJlS7YmtAs=
X-Google-Smtp-Source: APXvYqxkXknOQd4wDVuaJFxAegnS7jWzCaiiWIQhdHdq2bCNnAmcrdVIeN25/SrbdHSMsve8mhbeDw==
X-Received: by 2002:adf:f108:: with SMTP id r8mr18511696wro.390.1574671202471;
        Mon, 25 Nov 2019 00:40:02 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:40:01 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/6] RDMA/bnxt_re: Add more flags in device init and uninit path
Date:   Mon, 25 Nov 2019 00:39:31 -0800
Message-Id: <1574671174-5064-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add more flags for better granularity in in device init/uninit path

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 16 ++++++++----
 drivers/infiniband/hw/bnxt_re/main.c    | 45 ++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 725b235..3be495d 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -118,11 +118,17 @@ struct bnxt_re_dev {
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
 	struct bnxt_qplib_chip_ctx	chip_ctx;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e7e8a0f..fbe3192 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1315,18 +1315,23 @@ static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_ALLOCATED, &rdev->flags))
 		bnxt_re_free_res(rdev);
 
-	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags)) {
+	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_INIT, &rdev->flags)) {
 		rc = bnxt_qplib_deinit_rcfw(&rdev->rcfw);
 		if (rc)
 			dev_warn(rdev_to_dev(rdev),
 				 "Failed to deinitialize RCFW: %#x", rc);
+	}
+	if (test_and_clear_bit(BNXT_RE_FLAG_STATS_CTX_ALLOC, &rdev->flags))
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
+	if (test_and_clear_bit(BNXT_RE_FLAG_ALLOC_CTX, &rdev->flags))
 		bnxt_qplib_free_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx);
+	if (test_and_clear_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags))
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
-		type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+	type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
+	if (test_and_clear_bit(BNXT_RE_FLAG_NET_RING_ALLOC, &rdev->flags))
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
+	if (test_and_clear_bit(BNXT_RE_FLAG_ALLOC_RCFW, &rdev->flags))
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
-	}
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags)) {
 		rc = bnxt_re_free_msix(rdev);
 		if (rc)
@@ -1404,6 +1409,9 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 		pr_err("Failed to allocate RCFW Channel: %#x\n", rc);
 		goto fail;
 	}
+
+	set_bit(BNXT_RE_FLAG_ALLOC_RCFW, &rdev->flags);
+
 	type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
 	pg_map = rdev->rcfw.creq.pbl[PBL_LVL_0].pg_map_arr;
 	pages = rdev->rcfw.creq.pbl[rdev->rcfw.creq.level].pg_count;
@@ -1413,8 +1421,10 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 				    ridx, &rdev->rcfw.creq_ring_id);
 	if (rc) {
 		pr_err("Failed to allocate CREQ: %#x\n", rc);
-		goto free_rcfw;
+		goto fail;
 	}
+	set_bit(BNXT_RE_FLAG_NET_RING_ALLOC, &rdev->flags);
+
 	db_offt = bnxt_re_get_nqdb_offset(rdev, BNXT_RE_AEQ_IDX);
 	vid = rdev->msix_entries[BNXT_RE_AEQ_IDX].vector;
 	rc = bnxt_qplib_enable_rcfw_channel(rdev->en_dev->pdev, &rdev->rcfw,
@@ -1422,13 +1432,14 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 					    &bnxt_re_aeq_handler);
 	if (rc) {
 		pr_err("Failed to enable RCFW channel: %#x\n", rc);
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
 
@@ -1436,23 +1447,26 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 				  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx));
 	if (rc) {
 		pr_err("Failed to allocate QPLIB context: %#x\n", rc);
-		goto disable_rcfw;
+		goto fail;
 	}
+	set_bit(BNXT_RE_FLAG_ALLOC_CTX, &rdev->flags);
+
 	rc = bnxt_re_net_stats_ctx_alloc(rdev,
 					 rdev->qplib_ctx.stats.dma_map,
 					 &rdev->qplib_ctx.stats.fw_id);
 	if (rc) {
 		pr_err("Failed to allocate stats context: %#x\n", rc);
-		goto free_ctx;
+		goto fail;
 	}
+	set_bit(BNXT_RE_FLAG_STATS_CTX_ALLOC, &rdev->flags);
 
 	rc = bnxt_qplib_init_rcfw(&rdev->rcfw, &rdev->qplib_ctx,
 				  rdev->is_virtfn);
 	if (rc) {
 		pr_err("Failed to initialize RCFW: %#x\n", rc);
-		goto free_sctx;
+		goto fail;
 	}
-	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags);
+	set_bit(BNXT_RE_FLAG_RCFW_CHANNEL_INIT, &rdev->flags);
 
 	/* Resources based on the 'new' device caps */
 	rc = bnxt_re_alloc_res(rdev);
@@ -1496,17 +1510,6 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_PORT_ACTIVE);
 
 	return 0;
-free_sctx:
-	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-free_ctx:
-	bnxt_qplib_free_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx);
-disable_rcfw:
-	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
-free_ring:
-	type = bnxt_qplib_get_ring_type(&rdev->chip_ctx);
-	bnxt_re_net_ring_free(rdev, rdev->rcfw.creq_ring_id, type);
-free_rcfw:
-	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
 	if (!locked)
 		rtnl_lock();
-- 
2.5.5

