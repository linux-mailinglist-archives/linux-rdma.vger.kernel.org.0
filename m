Return-Path: <linux-rdma+bounces-5979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA2B9C8759
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B992812FD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131B1F8F02;
	Thu, 14 Nov 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OUA9POLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C841F9402
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578999; cv=none; b=i8Od21q68RbZ/bWceDVYiP0WqZ6oKuDP5EDQ9KqRw1qvA5z9jK+Vn99R/ebmGg0KdMnrN5LlyaySsiJ06F9HAryvClSQQwbYOPbLDbxN2vLYxTumPxXPMSobL+x6OBasRMJetfyWJrFZMJUsVf1rvLqvTeG9CV3nuY48F3YUBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578999; c=relaxed/simple;
	bh=O71aN2JbigWuk34uSQkNwJuIEcj/OKyfbDig1P0aKk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iefyMV2KINBMk9etONkrohBowo5pAHNXVu+f3YffwYrhy/v6xVsKVb6uu4xQ2QnNrPHYs4uNkLTVQIdsCaHzrZo/l62Q009mM4UwfUkc6Lb6GpUv2rF3yG+quJ3etlxRmrzSNkoLX6E8500vZGuK/Xker8mkQEREqbQWV4pCtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OUA9POLm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c803787abso3229205ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731578997; x=1732183797; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFkF6hN7CIrpVleCjythFCzqJs/7/QyjmUB4pSrKtVk=;
        b=OUA9POLmNFqz7IOhkCQhL7rahfbViv+2d2cNAjSuKZQCWvObc9MHBwHjQqePS///rU
         xTx70OeRAB4V0sDS9XrF8xxRBFNMRj1UVp9KI6ax2v9VwathTBkzHD/E8nprnQQYFeaP
         GUZEH7aBt40CEATq8M8Y1DBbMTSfar4LdDHbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578997; x=1732183797;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFkF6hN7CIrpVleCjythFCzqJs/7/QyjmUB4pSrKtVk=;
        b=hgII68UrCsdVOqO53uLJa8eZVPd8EPCuHlKRwWh1dl3cPUsHCmP4wu4iYltijZtflw
         KSpmhFZ2zglCzSi/dO6MLQo+xwX8V3CO57cysCrLs7LnS49S5uk3KGXtmkVXALl5MsVQ
         ZTXzTh097SvICnP5KT0BxFwneWRE84XFCME2wEVezqRYeeDI4A4lt+goGd9JlhzQ5aDV
         /GXYsyxRB4r4a5VcDfGEL2mU+tr6l7+VhjrDn+hOMn7gJndZ5e0szXh6M7IOyn7Q3tG0
         rh2Ly4y109Vw+EzloMfnb43t1hHdKxdaXUsW//BzYZF023+cOrUyYPUkw6HgbvBiCJru
         t/9Q==
X-Gm-Message-State: AOJu0YyCxv8LeT5ogFXZc42ZFmDfv3M7K8vKYI83dcLoH1QTG9lt8SRT
	N5RZaZAEBLua+VyhXuPJ0bnBJpJyWYfmrkz6BHuQISr8KpnGEfjJmR/CbaxwT4oU6iVWPSJ6a3y
	xNQ==
X-Google-Smtp-Source: AGHT+IFmG+p0wfeaPELqYwmEMPdSFi/xoF4jNe4BgG6nNP91y5zUW5SGXD+ETkCiL/VUzo5Vv7dyGg==
X-Received: by 2002:a17:903:244b:b0:20c:c18f:c39e with SMTP id d9443c01a7336-211c0fab017mr40978525ad.21.1731578997294;
        Thu, 14 Nov 2024 02:09:57 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d062absm7251135ad.206.2024.11.14.02.09.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:09:56 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 1/4] RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are reserved
Date: Thu, 14 Nov 2024 01:49:05 -0800
Message-Id: <1731577748-1804-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

L2 driver allocates and populates the MSI-x vector details for RoCE
in the en_dev structure. RoCE driver requires minimum 2 MSIx vectors.
Hence during probe, driver has to check and bail out if there are not
enough MSI-x vectors reserved for it before proceeding further
initialization.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c    | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index d1b7c20..7abc37b 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -154,6 +154,8 @@ struct bnxt_re_pacing {
 
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
+#define BNXT_RE_MIN_MSIX		2
+
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index cb61941..c262a16 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1936,6 +1936,18 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
+	if (rdev->en_dev->ulp_tbl->msix_requested < BNXT_RE_MIN_MSIX) {
+		ibdev_err(&rdev->ibdev,
+			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
+			  rdev->en_dev->ulp_tbl->msix_requested);
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return -EINVAL;
+	}
+	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
+		  rdev->en_dev->ulp_tbl->msix_requested);
+	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+
 	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
 		bnxt_unregister_dev(rdev->en_dev);
@@ -1947,16 +1959,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-	if (!rdev->en_dev->ulp_tbl->msix_requested) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to get MSI-X vectors: %#x\n", rc);
-		rc = -EINVAL;
-		goto fail;
-	}
-	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
-		  rdev->en_dev->ulp_tbl->msix_requested);
-	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
-
 	bnxt_re_query_hwrm_intf_version(rdev);
 
 	/* Establish RCFW Communication Channel to initialize the context
-- 
2.5.5


