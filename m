Return-Path: <linux-rdma+bounces-16995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMzGKKyClWlrSAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:13:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE51549D4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37B063004624
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7A33769B;
	Wed, 18 Feb 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a/mVfRDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D9336EC6
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405984; cv=none; b=ZV6RRl70b5wEXVf6nLMosVpz7gNRvKeEe9UHJvrSFApzRKWdwYQ/upppa9BPDFpnfXap4s/nS4Mb3ImWEz8EA80MnSZHW/sh3TCYq8wSnBxB1PiJ/DEudbDOtkqqKoY3JTHLIJiIXbuYtRVr7McPSXRGL4ufV5AVG9EuwVhI/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405984; c=relaxed/simple;
	bh=cnCWEy/NxRuJ7YKvKqtM/u89WTxziF/kn57vbWTExwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMdbcCJpovJB+sA+Ryc8sj+JoHIPppvI5LhocO0CbdUa3k7PmZ/KczBvWYOVNFqlad61OmvGIlCqqjdQsRc6gdNxtnxRvXaYv98nyYzjRl59BDhEKsrZDWulG2zr9cYYCZWkI1ey03gVXSIAVf4bRsoWw0XAGPTLv1PD7jNazEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a/mVfRDh; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so3535330a91.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771405981; x=1772010781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxRsA+xPATOyeXeKaiMWZiN34jdomrOG6mbXigI6gTE=;
        b=IKq7ToGRdr6aMVc5pDiA8yGPYIfSLlbaPZ+QglbpEtwuwU7uv8dS3QsNUOVVEoo3Wu
         UxDTP7Bn2VXYTgqrj1erL+wobmWCx84SWlEnOiKow/8xpsNYPeuGpGrCN3Tcjui0bQWX
         WIiIY4GxfbweKBQFn2gB+4f1mpkTx5ONjakOxL9s5kZWHlOjD5M3Ld5PUYzefvbXNlQU
         PEaVkRI74zpjPAHpaov0WNWcIX5V5uwo6ZU/Y7RTW4bn6WKy5eNjwk1yu9n8o+twJNlZ
         yiSZie+1mfLiFfcSa5J1kfXKUt9Ai1cFiPTE8DsmKcXQzPnc4cP0V2+7DmdqrNmFfj70
         gmCQ==
X-Gm-Message-State: AOJu0YzEQ2ZTYp9JaW51LWfHF+LKwGhhYlah9dQX/nbqVFn8WI7ddQTd
	/TOR+nMuh/1SvqzPh2GB3zSlFOhhgZ32FTxmlLMXtjMTlnN1/IPGW4ePMM3pEnH2ql6o2qVJRvP
	Q4OwucTQOuz1FDHAkqaAzHDk20tOU7UXB026lyZf3tc3DxihORoejTM5r+oKCD2YoO+dlUbJ0vg
	7lyrrCTCS7PXvzramKW5UtDGG5gGGm6TtRmTGUUnKLQ3c4lDpTwzmGUn3rToaHCURP/XYTSegiN
	90f60Ujo9143B9/7g==
X-Gm-Gg: AZuq6aKjohZo2bi4zrOTU4hlhI27FagEYm1BlVa5cYLkKY0A3gj95XL/UB+j2AkLlbT
	XfFK/lKyt2Q9+MIFJC17Zk9RpZUWlmoWJ7EO81G8e7JwhfUlG9+tfMZs5ATLiG76DL4Amr/pRWv
	/cPjE7f+Mc1OZKjmRRAEtQlDRCBMiGEqqLTZoe3T72h9mU3D747OnBVNpFXd/6/8s4vomZ75ZTK
	zjroQq6uuCcG/k7k/UGq541+WXJVjyzI2ZaLwPLEzNclc2nnSVgLrvjtEELqeA7zHT01ib3jm8i
	tE1jstMgwr6/3KsejcQunxgjXsgmWl5lWoJaUHSju6R+DFAMSVn1wLYud1EXHtSWzr6g+leepfx
	7Bk2kq1VgTGGh77YxsDvcM3PUyrC9g8cvENif6oySIRt8RRWybWEI4ffc4GFo5VrBgsLdO9572N
	mhoYqaQ9qMni7/xyuUm7XEdeluaeeaKHTJaLswiZ566QbWnl897V6qamg=
X-Received: by 2002:a17:90a:d40b:b0:354:bf10:e6a3 with SMTP id 98e67ed59e1d1-358890ddc3fmr1193847a91.11.1771405980707;
        Wed, 18 Feb 2026 01:13:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35662f4e49csm3409618a91.6.2026.02.18.01.13.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:13:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c71500f274so559811685a.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771405979; x=1772010779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxRsA+xPATOyeXeKaiMWZiN34jdomrOG6mbXigI6gTE=;
        b=a/mVfRDhZT7+NjjWHPdxNAIJj92X+eYgEqmpgVqVDZvvtRXSsDtPBM9FOFjbSHELbO
         dgmsqDV2Jr/zdXBHlMrvF2+h2JTLEyk6SQLDn0hQW+7X+8UvxNYb8v+YxWHhFFk/E/sP
         WTz4Hb/vr8gUq+DnzrWKE9ZiRoOXnHl2yCnJg=
X-Received: by 2002:a05:620a:40d3:b0:8ca:3854:80e5 with SMTP id af79cd13be357-8cb740f5c61mr115406985a.88.1771405979129;
        Wed, 18 Feb 2026 01:12:59 -0800 (PST)
X-Received: by 2002:a05:620a:40d3:b0:8ca:3854:80e5 with SMTP id af79cd13be357-8cb740f5c61mr115404785a.88.1771405978624;
        Wed, 18 Feb 2026 01:12:58 -0800 (PST)
Received: from S1-NIC-server-2.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4a395cf2sm1180245285a.18.2026.02.18.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:12:58 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 1/2] RDMA/bng_re: Remove unnessary validity checks
Date: Wed, 18 Feb 2026 09:12:45 +0000
Message-Id: <20260218091246.1764808-2-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260218091246.1764808-1-siva.kallam@broadcom.com>
References: <20260218091246.1764808-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16995-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,intel.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45BE51549D4
X-Rspamd-Action: no action

Fix below smatch warning:
drivers/infiniband/hw/bng_re/bng_dev.c:113
bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
(see line 107)

current driver has unnessary validity checks. So, removing these
unnessary validity checks.

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
Fixes: 04e031ff6e60 ("RDMA/bng_re: Initialize the Firmware and Hardware")
Fixes: d0da769c19d0 ("RDMA/bng_re: Add Auxiliary interface")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 27 ++++----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d8f8d7f7075f..0678aaecb3b5 100644
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
@@ -486,8 +468,7 @@ static void bng_re_remove(struct auxiliary_device *adev)
 
 	rdev = dev_info->rdev;
 
-	if (rdev)
-		bng_re_remove_device(rdev, adev);
+	bng_re_remove_device(rdev, adev);
 	kfree(dev_info);
 }
 
-- 
2.25.1


