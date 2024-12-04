Return-Path: <linux-rdma+bounces-6227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADDF9E3519
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CE8B29D84
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF41AB507;
	Wed,  4 Dec 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MeagM2nd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833D1AB530
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299109; cv=none; b=kaiX1HMudIakj1XO1reJrfDG+uOI1EWfvhRxpZY7MFMg8W+taDrw/S1d2msPVRzkS4aj9OkIL0tDGHewsJYrAEXoyZ4dT0oaUP/cN7aXz4QZsQt6d5FGqBv71TYM8h/o2xBgBehkTyxDe+fP+KiljJgS39iC7h6RnMOpGwYuexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299109; c=relaxed/simple;
	bh=AXGTuJTqZOAIQI/HKQLVnb/MAJepzGSCrEd0wGlSDaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwUtNrNZGOvI27ExAJLbUb3Pm8QTupsmkx3RHz0hRGGA+xpcTgrP5XZ6Hl/zSxLes+x3J0EKuJtiCNOQWJR31sD8T9rq+uUEtx6R/UbzMu43PmJCScUX6d2jShtgpozrI4vgvPOw3uL/gIKABXH56l/TtKqIjBvA9u5k5rqx95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MeagM2nd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so6147726b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299107; x=1733903907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bAcPRtGaQrVg6bRpvOXOISCpRJ+uX1CF4h9ob/a/Ws=;
        b=MeagM2ndEKdtSvdWf9sE+RajJCI7pU15piRBYxwRPfthsPO2T3pSjtN8iOwUhQ8dvW
         MkRC/97Xm5ONTtzFqsohsUtig3X0oxtuMB6TuTbh/eUfNup5s21UbGZN0OITJ2n92z2m
         b4J4E7YDAlBLFiW9BueliK9khSmO8LQKlSMzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299107; x=1733903907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bAcPRtGaQrVg6bRpvOXOISCpRJ+uX1CF4h9ob/a/Ws=;
        b=enmH31chKs3vuwilGPAYz0lxrNWoHDOoeZtkxBenLlwbcUvxM4efFvIt4bhWSfitGz
         6OV/TzYSoF/CBC/MFNLmfocXZp9N1crOOJkzWZftPEtyTqIhb8zSGUTb+ylQ/cipbPHZ
         CzqmMZoHUNggKOtSLMf1gYqxArp6lWGq5Lce6sxc4b5XvUXTV+LaQ1D+OLnA3ztfT0SS
         H6K15mnO8GIZCc7OwDJImCGwuSckQsOylzQ/35nCqDF/GADH3QxEJpgprHdoLkH4cKWA
         4mHTOI2kBFBpD+LV43ihN/wK/DZEguINAbEpFmyIgKTzwiSANIaxoMXFE0eJSZlXVig7
         Uevg==
X-Gm-Message-State: AOJu0Yz+e7ILn1bNpiWZox3ouedkZZypmzI7LJGrxJBaAI3TAjVSLnmH
	KhTEBUFMC7dRc7at9UnA0EYXWUCTdPFIGm08c/oFlWsCKNtia9kqmRdTZLCeqg==
X-Gm-Gg: ASbGncvnknVUDOVc/nk0pjtde7l7vMlKYAZd8usdbnbvp8UOwMTLcYs9uS/1lAtS0BU
	/BKPyoqrNIgFJuYuiRFItkQ9RIktB5TPAj2Q2kj0LngiQwY7E3YuwlIys/YzWJT0BlSoE65H2Dl
	bgNYFzaR4GK3ye4SK5KMcEe8cD2jl//IjsISUSLAMr3SS6XiV5Xz6FD0OTUnvGKdwvv/OKL69eY
	TqS5TUk5LVOW7w8NmLnoohe8HN3w/zZSZFF6WfWJn2Q6UoDMYum0DJq/d3XFEtd9mKL6CzPrhsd
	il0NdXBZ/HLAz5NssNKp0ICvX/uHFcBD7owSLwWzBWz3IwZ9aGrL
X-Google-Smtp-Source: AGHT+IFTqxFShNT2Gi7Y0gifp3UHHx5hp6pXTo4ZoRRmFQ+FrESZsWaJO6N7GPgYBDIHhkRbb1uyLw==
X-Received: by 2002:a17:902:cecc:b0:215:a3e3:c86a with SMTP id d9443c01a7336-215bc426617mr87959035ad.0.1733299107322;
        Tue, 03 Dec 2024 23:58:27 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:26 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc 5/5] RDMA/bnxt_re: Fix bnxt_re_destroy_qp()
Date: Wed,  4 Dec 2024 13:24:16 +0530
Message-ID: <20241204075416.478431-6-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Fixed to return 0 always from bnxt_re_destroy_qp().
2. Moved the code to delete QP debufgs dentries to the
   beginning of the function.

Fixes: d7d54769c042 ("RDMA/bnxt_re: Add debugfs hook in the driver")

Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5428a1408cee..215074c0860b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -967,13 +967,13 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	bnxt_re_debug_rem_qpinfo(rdev, qp);
+
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
-	if (rc) {
+	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
-		return rc;
-	}
 
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
@@ -983,11 +983,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
 
-	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp) {
-		rc = bnxt_re_destroy_gsi_sqp(qp);
-		if (rc)
-			return rc;
-	}
+	if (ib_qp->qp_type == IB_QPT_GSI && rdev->gsi_ctx.gsi_sqp)
+		bnxt_re_destroy_gsi_sqp(qp);
 
 	mutex_lock(&rdev->qp_lock);
 	list_del(&qp->list);
@@ -998,8 +995,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	else if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_UD)
 		atomic_dec(&rdev->stats.res.ud_qp_count);
 
-	bnxt_re_debug_rem_qpinfo(rdev, qp);
-
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
-- 
2.31.1


