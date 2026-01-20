Return-Path: <linux-rdma+bounces-15756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FADD3C35F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542485A9583
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F33BC4DE;
	Tue, 20 Jan 2026 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f0IsIPAn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2C334C20
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899736; cv=none; b=XIs1Xr+8DkWNflVU5NqPZrkpN33Akk9iEKzH/t3ZC03km7Dx58mbseSGqhm+xIyl3sLHkPTzxdQCqO9p098uGh3iKAY4sIpxm32PPAhBhISeiL0xyUqRdTZhN/BXd5Vphc9gvBm9KmT7/r227vkGFiLIiDQOEwj6W0nUdre3lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899736; c=relaxed/simple;
	bh=Aj4eenxyUpau79RViL1K8UZEluMRFUtOHa3lCa6Ps7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBHwkDOORoGC58Q1RdR8emFnmLNXi26Z2XW6q2dY7EKkCzP4HRAgxFM9zw62DNZaG1UAAaJDl6mxTvN1nAPr+ooCCUr1fIYCVEYIb2rderwRgWsc/qqHacXrPpBqKMhT0Y/aUjnblDW3HCuzopbUJw5rlhbLW0OEvAZ8V+Jjv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f0IsIPAn; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5eea35e808dso1631899137.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 01:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768899734; x=1769504534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duMmuof9RcxM6DFvgl7hVr1UuVyY9Crra4AGaZfc+2k=;
        b=bf7e+UzGiFbt4N/goSxZ32kqrdVyrE5SOFDUB3yW/sm6kVyM8Xg8WNGMnHcW93iDBh
         eg0pjAxsHSwiIuCizdrjS1jOAUBPkkblGRNJewM1GyYD+sp+2Ha/P7JqpIVeF7jKUjWs
         LDx9TULaeXW2NNUtGb0Z5CsMJV3iKhizh7hp27V3wMCal3l2og6alW+Hm2sQ21GGT+NQ
         a+ZyU5L7pMXoP6bcwb+eVdlBLtJd6abY27bhmE1oFbHMChFR+qtkYLpyBova82VASpEU
         HKQWbg6TcRmTNys9iCOjWOGkCZZwmFJjJlK85dGp9PzZaXA81W47oPQlog1/TFJlCjIZ
         ei9w==
X-Gm-Message-State: AOJu0YxX/L3MPbjX1zkT9MoEb23RnjvIMmCTEG8rh1cG2zbTjA35Zk0w
	xZfW5SdLxGsucrxAPmVtVNTfZ1SkroQnfge6DWUYQeamGppajvKADlvzHy36U1J8fRxDlQBDsI5
	5wra0uw8BSzdH3vg5y+GPsUVDPvRkUChpJr1rvo877YgFZD8OFH8D9DlY2yD7R7dq4fEQzAlOy5
	wX7UkTboqGCZU+5Cz1ZwzqglRperURN8UrkOB6nyQu3qypOpEokX15YWmu7tbd0cp306YwBcrNX
	dr0nVgEnG0/vKkeuQ==
X-Gm-Gg: AZuq6aKM9U2I/6XuLVd21DwddCmAOMPIm2+AWd/p/oLLqZNpUrT1JYb8NMiT1IMlhU6
	Q8uTFPZyxRTlTjexrXLX0KQQXaqrCI3vzixvgXDENm2OlD3l5zQUvkEq+gtE1ZK24j+7Pm7ziJi
	mxsWCuv3BBF1HzIKHnM80KwtT9Wv4JsaoJT8MGfXH1kLg7L2zNJSYhdneLSDbgXNzjIqnErqA1A
	s0OB8bjVh4zH/gxUjPZDpWgLlscz1z+TbHj4QKea2ytDJ4qNn4Jocju7u9qiZZzXow+EX7GVzwX
	QOQS22etIsKE9w8SRsbQWm0Q6Wu36KUY7kV4HfJVDgTt2D4soPZLQ31t9wVdNK3aQg7IMNpN9Nm
	3QC63SprCpEzykc9ojA+21bo2QIZYccz5VO1hLdpR7VCBtqXx7O3X936OaloYP5v9x8+hyHl/+2
	LxAu3x3otFCAqb2Xp9rXhBstkxhHzQIVOu0wZAlsIdFIo=
X-Received: by 2002:a05:6102:3a0b:b0:5e1:ef48:271f with SMTP id ada2fe7eead31-5f50ae0a70fmr220116137.24.1768899733765;
        Tue, 20 Jan 2026 01:02:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-947d043e057sm258268241.7.2026.01.20.01.02.13
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 01:02:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52c921886so645905085a.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768899733; x=1769504533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duMmuof9RcxM6DFvgl7hVr1UuVyY9Crra4AGaZfc+2k=;
        b=f0IsIPAnXzsKtjhns3eLcCt1zGu1Uce/2OW01yo2BF6iSe6GCvaeNXzfFLasNAsLHW
         cGbobf72UwSQolnqhK9dqOynheaFt+eRNQnIZ8xRgGtcx3gjKWBRk5fAA8M4lyc1uBx6
         ZsqMiiUq5iUDA3ORAbrto7oXD1hARKznn/ods=
X-Received: by 2002:a05:620a:4015:b0:8c6:ae63:dbc0 with SMTP id af79cd13be357-8c6ccf06c37mr107344785a.55.1768899732506;
        Tue, 20 Jan 2026 01:02:12 -0800 (PST)
X-Received: by 2002:a05:620a:4015:b0:8c6:ae63:dbc0 with SMTP id af79cd13be357-8c6ccf06c37mr107342285a.55.1768899732037;
        Tue, 20 Jan 2026 01:02:12 -0800 (PST)
Received: from sjs-sai-83-64.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a70f1fe1sm969650585a.0.2026.01.20.01.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:02:11 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [v2] RDMA/bng_re: Unwind bng_re_dev_init properly and remove unnecessary rdev check
Date: Tue, 20 Jan 2026 09:02:04 +0000
Message-Id: <20260120090204.635526-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Fix below smatch warnings:
drivers/infiniband/hw/bng_re/bng_dev.c:113
bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
(see line 107)
drivers/infiniband/hw/bng_re/bng_dev.c:270
bng_re_dev_init() warn: missing unwind goto?

The first warning is due to accessing rdev before validity check in
bng_re_net_ring_free.So, removed unnecessary rdev check in
bng_re_net_ring_free.
The smatch also flagged about unwinding bng_re_dev_init. So, added proper
unwinding ladder in bng_re_dev_init.

------
Changes from:
v1->v2
Addressed the following comments by Leon Romanovsky:
- provide proper commit message
- remove aux_dev check in bng_re_net_ring_free
- remove uncessary validity checks in driver paths
- remove uncessary NULL assignment to rdev->nqr in bng_re_dev_init.
--------

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 56 +++++++++-----------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d8f8d7f7075f..fd0a4fe274ca 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -54,9 +54,6 @@ static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
 {
 	struct bng_re_chip_ctx *chip_ctx;
 
-	if (!rdev->chip_ctx)
-		return;
-
 	kfree(rdev->dev_attr);
 	rdev->dev_attr = NULL;
 
@@ -124,12 +121,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 	struct bnge_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!rdev)
-		return rc;
-
-	if (!aux_dev)
-		return rc;
-
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
 	req.ring_type = type;
 	req.ring_id = cpu_to_le16(fw_ring_id);
@@ -150,10 +141,7 @@ static int bng_re_net_ring_alloc(struct bng_re_dev *rdev,
 	struct hwrm_ring_alloc_input req = {};
 	struct hwrm_ring_alloc_output resp;
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
-
-	if (!aux_dev)
-		return rc;
+	int rc;
 
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
 	req.enables = 0;
@@ -184,10 +172,7 @@ static int bng_re_stats_ctx_free(struct bng_re_dev *rdev)
 	struct hwrm_stat_ctx_free_input req = {};
 	struct hwrm_stat_ctx_free_output resp = {};
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
-
-	if (!aux_dev)
-		return rc;
+	int rc;
 
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
 	req.stat_ctx_id = cpu_to_le32(rdev->stats_ctx.fw_id);
@@ -208,13 +193,10 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
 	struct hwrm_stat_ctx_alloc_output resp = {};
 	struct hwrm_stat_ctx_alloc_input req = {};
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
+	int rc;
 
 	stats->fw_id = BNGE_INVALID_STATS_CTX_ID;
 
-	if (!aux_dev)
-		return rc;
-
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
@@ -303,7 +285,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 				"Failed to register with netedev: %#x\n", rc);
-		return -EINVAL;
+		goto reg_netdev_fail;
 	}
 
 	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
@@ -312,19 +294,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		ibdev_err(&rdev->ibdev,
 			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
 			  rdev->aux_dev->auxr_info->msix_requested);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto msix_ctx_fail;
 	}
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->aux_dev->auxr_info->msix_requested);
 
 	rc = bng_re_setup_chip_ctx(rdev);
 	if (rc) {
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
-		return -EINVAL;
+		goto msix_ctx_fail;
 	}
 
 	bng_re_query_hwrm_version(rdev);
@@ -333,16 +312,14 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate RCFW Channel: %#x\n", rc);
-		goto fail;
+		goto alloc_fw_chl_fail;
 	}
 
 	/* Allocate nq record memory */
 	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
 	if (!rdev->nqr) {
-		bng_re_destroy_chip_ctx(rdev);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto nq_alloc_fail;
 	}
 
 	rdev->nqr->num_msix = rdev->aux_dev->auxr_info->msix_requested;
@@ -411,9 +388,15 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 free_ring:
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
+	kfree(rdev->nqr);
+nq_alloc_fail:
 	bng_re_free_rcfw_channel(&rdev->rcfw);
-fail:
-	bng_re_dev_uninit(rdev);
+alloc_fw_chl_fail:
+	bng_re_destroy_chip_ctx(rdev);
+msix_ctx_fail:
+	bnge_unregister_dev(rdev->aux_dev);
+	clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+reg_netdev_fail:
 	return rc;
 }
 
@@ -486,8 +469,7 @@ static void bng_re_remove(struct auxiliary_device *adev)
 
 	rdev = dev_info->rdev;
 
-	if (rdev)
-		bng_re_remove_device(rdev, adev);
+	bng_re_remove_device(rdev, adev);
 	kfree(dev_info);
 }
 
-- 
2.25.1


