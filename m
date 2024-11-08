Return-Path: <linux-rdma+bounces-5857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 789319C18B5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C67C28237D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E81E0DFA;
	Fri,  8 Nov 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CxUkDfqK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB11494D4
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056613; cv=none; b=ZRvabd12mnuZxxNm7wryWfzOgzjcPo8AI+yJQE4EccluJJExrCgFgl1kIpNANYibfMmcBZKQzhgeywZ8gOaOhKp31NYCbDmD7mcdUCTJpeNIENObHtiKn2ZtsDzFXdNHMn1H1M0QWkKa0zsXrx7iuL28o2xJb6DlOy5Y8E06NeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056613; c=relaxed/simple;
	bh=zZ3CdcQt9lu2MaYLUeVrgF+JrGhTP0POQ7zU+WeqH3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XUe4AUlUMtvvCTvXRQxmfpXgxLX488qsMwkQkNdfx1cHcxsl+xWz+XM1mJ9uHoEkmEi/fJhi/0Fc4iX8qOA7lx09f+DboEOo3gc4Af1kzPu1E65Nx4AWWYT3XBEyqHbLA2BXURMBZFuvcxSHPdZS57zQOZoWMGq7VsHUvvTUwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CxUkDfqK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso1580496b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056611; x=1731661411; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJav06v2MeOZJydbujikXJRlSns/qhfi/G8J+CT9Kmk=;
        b=CxUkDfqKSx0sUqXDb2JOzGIqsuoHJKKqmc/gUJMG3cucT4kABY3Un8RBVhm+SbBjFy
         e3RvHG/RNVRRJGqaasR3ncVB+6zLZedaJ4ApmekoaIGhrwoBUjNx7Dxg1hhXA1HyrHsv
         Gcm4Nyw+8VogT9ObM0CNb5bbITOzkYCT1zhdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056611; x=1731661411;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJav06v2MeOZJydbujikXJRlSns/qhfi/G8J+CT9Kmk=;
        b=faAR0dSXzFJ14n7nC+1PkzfU4QTVjwDiokPUHPzUYRcmyH7YDQ6yfUtMf2u2u8RgIO
         OYs/2UyCLy2j5ZXmW+B+AvIl2T0BmvkmfZe1CiYmNJjE20zuUE94SAJ1pbsP+Xf4R7Wc
         NFg17EQbc4ilGplsqhq4T62xXfNYExGN3fm+w7GzJmsuvSt7H7zplOftOBmhZAyLf1G2
         VagIw1qyTrxTHpXDTsJPIQ2Ij3NqmKaadv5XgYVcR9yau1Xf0ZI8hHpHtbu/dL8VmXw4
         hDUb+2Z2LnxzzoRv1nydzSqyNsEEiYNNtN41NGRKgEUsxFLWD8feeIi1oSG6toq086As
         dWHQ==
X-Gm-Message-State: AOJu0YwBp4Kmh4R8znjYcnS58K/+lmK1th+PhbxJWwSEPLnvoFZa55HG
	7lS5uo4G5W2yZruJgbi3owYYY/3BbB38w98KcZGxn9vAJoPilN4e5gamuY+0Rg==
X-Google-Smtp-Source: AGHT+IE7VQttAIaA+UrpxOJx00vwvXj9U1cMQ6JzIPgB6kYpSzA07bwDWSMqglW6cWUAAGMqYec9Iw==
X-Received: by 2002:a05:6a20:7f81:b0:1db:c20f:2bfc with SMTP id adf61e73a8af0-1dc22b8ff46mr2857199637.37.1731056611202;
        Fri, 08 Nov 2024 01:03:31 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:30 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 1/5] RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are reserved
Date: Fri,  8 Nov 2024 00:42:35 -0800
Message-Id: <1731055359-12603-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
References: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c    | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

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
index cb61941..f9826c4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1936,6 +1936,17 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 
+	if (rdev->en_dev->ulp_tbl->msix_requested < BNXT_RE_MIN_MSIX) {
+		ibdev_err(&rdev->ibdev,
+			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
+			  rdev->en_dev->ulp_tbl->msix_requested);
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
@@ -1947,16 +1958,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
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


