Return-Path: <linux-rdma+bounces-15337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79ECFCD3A
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742EF3017F21
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860672701DC;
	Wed,  7 Jan 2026 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NzC9yx5x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8469270EDF
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777380; cv=none; b=Qja6iwM5wjJbex3Af/NaVFhY2YSZpkqIS3TEYAfS2Sch/tjZuNQ4m9WcAxQAEi7RtpSleJkSaBcSFFaH7VES2xDfhNy/73ru+S4isySc6rPHs1LMxv5vGYUYzvwCO8wEctH8D6MT92kFzFExSsBqs4MbjGqU+0SrpoHEsxvuXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777380; c=relaxed/simple;
	bh=B13MzvXcJJhMuiN4jaD7sn9MwJxiVIbuYaCpimlZO5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8imtMWdo5gdgdE60NyC+MVjJk5AKyIYHsUhNnVyElWUGhElQADwARoxNhIV6GB+9sKaC9iLuGQlbAnaPHUMEINXaTZgD3F95px5Av+6bd3MZXwsfUHk9DZ6JdbVID25YNs7FM1FhMT9UP0tllB/StpYWocUkj89Gt+Spvj/rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NzC9yx5x; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b23b6d9f11so194588085a.3
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 01:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767777377; x=1768382177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARlawnekIKukM3JntDD8Tg/fn5lMz+uoaSPEBmagZ4E=;
        b=v45aHUuiTcPBmw3uEn8oLMcNv8NrFiRtHvbdD44yfirUO84CbzwiIa1i3KO3tRIEOM
         rzZM/l1pFws2HX4nJYwnHjwa/FlIQshExVYndcqJphUCcuLCzmSoJj60MGlFnWrWV4Bk
         S4vYJtOItV1JlpwKZf7j50k4AFuFvTL0NaagnDna9xWhexZPtTeZtj9sBr7yJ8upHioi
         gJGFBiZdvdDK759fNVkVTGz1WKLPy3vFhLHefaNz4crDiRRzZ93owVFAoWYW+8IlgREu
         2M/4U8dWQiL6XTzFWMM7vUvIl7OPa8M1OgLS2jNvVYz3wzKYXPs9K4VmHYOSp2GAbSG4
         5Cbw==
X-Gm-Message-State: AOJu0YzBZZaIdGOvtAT9h6QFHNzgq8L/AZM4S15MoXguJlM42xGqfWVO
	aMfYOn4vsTMvLXxWc6zjQ3iWqZ9o9shiewOTWeO9Ie/fuEARQahAc+8EaaZgfyQzI/oPIphWGYE
	4zs0AAkpG97fbMTMGULZWA9ZU6eJ5vdqSlaA1LtHCGt+5W+W3OivTF6tuRdN5yot07Mkjzhhif1
	yJqfw3tZh+hZHzzimb9cd4OeuXqH8hflQ99tpOVbYof36FFqGHxUKDVJ1g4Ctc4rJuXs0jO7Z5d
	l14OGiDpWWiGDvwzA==
X-Gm-Gg: AY/fxX6lOQ0o6Buc8Si1GBKl56S5ouLO0mejELmIGjPU6Z5XKBDmaubRG2pvp5aKY3w
	KSVvD2EjiQEqB2tGaByYQbmOPBwD62Gurck89qL/r91J2szIuHXkQG3Qvvc139p+1rzA6zvMb7+
	c7WCLz9yt1Iv/54XXE3jiWfaz4w4lhercISceol6mx8oLNIDgL/Jc1BhjAotdwOMp4WxAgwo4PV
	cOqYAPjO1SjkZl8h3yvCjyB5h2jYhSGz11tOctzjJe7ztK0fqFpFIM07NPXLULjS2Beam3FnADL
	/6d6YJNfp/Nn1IJdrxi6BJNhR9xyG2pLxAaVrGjYYDhrmjV2jvyfjsA8C/gOnmMcgNU8zZxLR1P
	/K8ZTcXQdV7uNpYHw2t3N2IfhfWQ8eluWSJoaWEXBqCkSZZ0onunupMu0T1OXRsF2OAoLyaSm3y
	7xPY9zJIHt/w+uQYcDOzCbs3uSv5Izd9smAVW4yKl8
X-Google-Smtp-Source: AGHT+IH7OyhNzgAE7AqC6sUh8s65mkXoHnih2ogug7zNo9XaTsEISdNQsvZZ+I4CiJz1BAN5ZTffa2abDDIa
X-Received: by 2002:a05:620a:1a90:b0:8c2:faed:ded3 with SMTP id af79cd13be357-8c3894210bbmr231907885a.89.1767777377360;
        Wed, 07 Jan 2026 01:16:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770947b0sm5115366d6.1.2026.01.07.01.16.16
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:16:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed7591799eso43165961cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767777376; x=1768382176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARlawnekIKukM3JntDD8Tg/fn5lMz+uoaSPEBmagZ4E=;
        b=NzC9yx5xJa8irVSMNIYXVcUy9hESEjJS0S99rodx9O6wGaOyrJ20EUmLPHufzIkGcC
         YBj08vyBxwMgxMhd1lXhS+3+jRmR59viHc4K2mrceoCyH5ggSe6pJ23i0XOUYdFqh3X5
         H6NzvpsSPyzQmhKX97bDTruWhab9MLB0XRjeA=
X-Received: by 2002:a05:622a:5814:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-4ffb4ae76f9mr31790261cf.65.1767777375843;
        Wed, 07 Jan 2026 01:16:15 -0800 (PST)
X-Received: by 2002:a05:622a:5814:b0:4f1:aa2d:81cd with SMTP id d75a77b69052e-4ffb4ae76f9mr31790041cf.65.1767777375451;
        Wed, 07 Jan 2026 01:16:15 -0800 (PST)
Received: from sjs-sai-83-64.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e6257esm26330811cf.31.2026.01.07.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:16:15 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] RDMA/bng_re: Unwind bng_re_dev_init properly and remove unnecessary rdev check
Date: Wed,  7 Jan 2026 09:16:07 +0000
Message-Id: <20260107091607.104468-1-siva.kallam@broadcom.com>
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

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 33 +++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d8f8d7f7075f..e2dd2c8eb6d2 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -124,9 +124,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 	struct bnge_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!rdev)
-		return rc;
-
 	if (!aux_dev)
 		return rc;
 
@@ -303,7 +300,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 				"Failed to register with netedev: %#x\n", rc);
-		return -EINVAL;
+		goto reg_netdev_fail;
 	}
 
 	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
@@ -312,19 +309,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
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
@@ -333,16 +327,14 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
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
@@ -411,9 +403,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 free_ring:
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
+	kfree(rdev->nqr);
+	rdev->nqr = NULL;
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
 
-- 
2.25.1


