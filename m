Return-Path: <linux-rdma+bounces-12585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF94B1B1AD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E13C17FD34
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03323A9B3;
	Tue,  5 Aug 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MQWah/cS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AF1E9B2A
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388241; cv=none; b=MUgDSw2D60SMZyfDPP88tz4nmAAt8FVQEyI53Kv3qm8VLJGHI4/Z29ud2wItnrRHd4/DHn1KMfra5eXps8wGOQ3rSPW12cUQ/HD9gz1LEQBwh2UlN3rJrnTCMhU3WNGkBl4rnHbRhtP91jtTAWM6vBj3FRjUuoc3veT5k/LlRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388241; c=relaxed/simple;
	bh=nSp/eaXaSMWMGJ3FAoEJXiYyxq9tFhv1R4pmRVZ9Ors=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbl+AQk92VkXkPht9L9atexjV/vVzzDHGJXXtm/O9Q4h4Q5MuAkRwDNzrLRaKVsvf4ZyWZsWPnJF9SYXmBrXavjMEsiJTA/qye9buunzEimRiUTLzmMjW3ruc5pa/qnstoxHA5EyjounjsKnQnQHqO+msKhkDMw+rTKtjbl89rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MQWah/cS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5856364b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754388239; x=1754993039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKvgw+2ClsOkBQn//pZ/8++/OE+BlUzgcPZ3tkzNYQ8=;
        b=MQWah/cSvWCUa97CUiBWjgACHP0egESWdmvQR6rzNZQ0sNQqULgqZ4bKkSz4zihFs6
         ErNihZTJXEQC4EWs8yNpAh+r6RYe6nkMyqqZ9HkxDrhros3lV+jCqiy/dfIOL1ai1wc3
         hWFrwZ5rTYN+EE0ar41/DHxjgRcma6zRVispA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388239; x=1754993039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKvgw+2ClsOkBQn//pZ/8++/OE+BlUzgcPZ3tkzNYQ8=;
        b=C/jyEN/9yPLLgx5sFqu5L9pnKeBbaBX00ocSYUQ+5GG2Pcni7HiZByIfJ/LL2btM5o
         9cchDO0x3CwJqUgRUQ687JXjSd1zr8JTOM/mhLUVSgFbMgf4h38OVIQjkycg4is1TRRr
         jn+/krN9SlCsTOL7G73ho2pEg/1/udm5+xLvJYaPm0lzTiIzmj4gTa0oEdVzJHh9XZ29
         uszqufxchpT78rwXA0q8MWm5l2ngttkwAYElfB2y4QA/V202ReuhSLpcXo4PwfMujKVl
         /AS5kg9gJL41by4Bev5klv2SFJfRX8kAHTXwmA+Kr0E9erFR1pAj7U5PPx6j5YvVX9b1
         l3uA==
X-Gm-Message-State: AOJu0YyCmZSvEFIi1S/hwZTTi6AVANiEROfZgSl3NcnQ+MALpJDG958p
	DhxhcEm0VygkwQa62VP0pOTgMK0/eE4FBS5+mpO2EBVXj1pztMGL/XgLTgfcC2CSjQ==
X-Gm-Gg: ASbGnctEYJfKmWvkLAUwDyey2N+zF4IIdtgybqUU+P6NorxsUEXBexyfpDt1a/Whzv5
	iOGRiCYbvR+AfRt2W1zD6QYd72O8TJuXl2i0SEHEgtVz+4vbh+FA94WZI3pmM6doW/E/vh/WF0x
	/gIk7xpOMxxScHVOaBk4kUZo8GAgOAcj+5xvIenjfOalyvJWun3FVczI4TimLyLr5XOyioUxLfn
	k6BFqGtxU/n+h5AHqOIijqjIpGeFtNHYZ/8YgSJD+mGxv4f3uyVEnUeFTNiamIExa+g/mYI7kGG
	jpkkdgHTR0duo0X+Xm3ff3pCM/sUcK/lafdIcgJ6Q3hC1Q/wVjxfw2kH8LG/SCy6Nfo4aBIYBkV
	P9dnb6WShiGUu2EwsYRGBYCdI6Va5+ier+TxqMOIyITW6K5ufvvbmwi1IC8C+URGnP7d4Q8YaDQ
	ha+74aEBPA59V0vEn8S2djS5bzOA==
X-Google-Smtp-Source: AGHT+IEvjvFizWE8f3ae0w5hc5/CVAjkBb3Qdk0HbhVGqyLQarDbr4nCMZhcCWT2ysYhr7/+ZflZvg==
X-Received: by 2002:a17:903:230f:b0:240:3ed3:13e7 with SMTP id d9443c01a7336-24247023c2emr164238385ad.42.1754388239028;
        Tue, 05 Aug 2025 03:03:59 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm96838595ad.51.2025.08.05.03.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:03:58 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Fix to remove workload check in SRQ limit path
Date: Tue,  5 Aug 2025 15:39:58 +0530
Message-ID: <20250805101000.233310-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

There should not be any checks of current workload to set
srq_limit value to SRQ hw context.

Remove all such workload checks and make a direct call to
set srq_limit via doorbell SRQ_ARM.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  8 ++-----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 27 ------------------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  2 --
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 063801384b2b..2e3866e74736 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1921,7 +1921,6 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
-	int rc;
 
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
@@ -1933,11 +1932,8 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 			return -EINVAL;
 
 		srq->qplib_srq.threshold = srq_attr->srq_limit;
-		rc = bnxt_qplib_modify_srq(&rdev->qplib_res, &srq->qplib_srq);
-		if (rc) {
-			ibdev_err(&rdev->ibdev, "Modify HW SRQ failed!");
-			return rc;
-		}
+		bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_srq.threshold);
+
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index eb82440cdded..c2784561156f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -706,7 +706,6 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.max_slot = 1;
 	srq->dbinfo.priv_db = res->dpi_tbl.priv_db;
 	bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
-	srq->arm_req = false;
 
 	return 0;
 fail:
@@ -716,24 +715,6 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	return rc;
 }
 
-int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
-			  struct bnxt_qplib_srq *srq)
-{
-	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
-	u32 count;
-
-	count = __bnxt_qplib_get_avail(srq_hwq);
-	if (count > srq->threshold) {
-		srq->arm_req = false;
-		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
-	} else {
-		/* Deferred arming */
-		srq->arm_req = true;
-	}
-
-	return 0;
-}
-
 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq)
 {
@@ -775,7 +756,6 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
 	struct rq_wqe *srqe;
 	struct sq_sge *hw_sge;
-	u32 count = 0;
 	int i, next;
 
 	spin_lock(&srq_hwq->lock);
@@ -807,15 +787,8 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 
 	bnxt_qplib_hwq_incr_prod(&srq->dbinfo, srq_hwq, srq->dbinfo.max_slot);
 
-	spin_lock(&srq_hwq->lock);
-	count = __bnxt_qplib_get_avail(srq_hwq);
-	spin_unlock(&srq_hwq->lock);
 	/* Ring DB */
 	bnxt_qplib_ring_prod_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ);
-	if (srq->arm_req == true && count > srq->threshold) {
-		srq->arm_req = false;
-		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 0d9487c889ff..846501f12227 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -543,8 +543,6 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 			 srqn_handler_t srq_handler);
 int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_srq *srq);
-int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
-			  struct bnxt_qplib_srq *srq);
 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq);
 void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
-- 
2.43.5


