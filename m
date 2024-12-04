Return-Path: <linux-rdma+bounces-6224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76B9E34D9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26073166316
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739A1AB528;
	Wed,  4 Dec 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fQEqtm6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999E1AB501
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299101; cv=none; b=FxshPVsPsi0zeP32X9ilTLgEoibbSrTJXqF0tua39Usdzu3y5ZERroeF9Zlfm/vrmv0eYNnnYxw2e08c/Us5Z6ojqGGPnThDt1zmNVSfykhPlxB9US414bg+Wo6mmwB6C9cvrtkGoRdFnV1qiU6BrqLDZ+LeIpit5356Gd1QLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299101; c=relaxed/simple;
	bh=2OS2zUTgtvDoh1fvmb2LNQUqY839JigLMxipLoSRvSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLQYMqbKDsuzHxqXjep8P8CHzXd4gR9DJfc1mo5WjX0yE7F+pOWqxGnZL3ReQOV8Gu+ykTMowHx/T6ikFacLhPG1H9U2Dq75kQjMbiFVMyHmKtNHvRd7DCnwUODx1DKbUsRTwfjtgbNQgKt+mTZmX6HwCfuS3bbgsqkaIHZ+MN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fQEqtm6j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215513ea198so4625645ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299098; x=1733903898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0GrmD7fuDxexIQTSHtiuTT8aeBAoifZAomwRb9faCw=;
        b=fQEqtm6jTsRAfw2i+bt+FZreIGgFMP3Otzv8Tf/BG4PplyF2vpNVWaI8OHhWspBOVf
         EOtIkzGZIGkPBcDzNYMqAkawNe9cga/qcH0O6/FoKBkHIw8+8hUY8drxCQeJaUOuMFlF
         W4ZhK1RcF50CnZlosrAN3cRrQPATs4HZosffE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299098; x=1733903898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0GrmD7fuDxexIQTSHtiuTT8aeBAoifZAomwRb9faCw=;
        b=OI18VBf77HygkzzWay9FooIf3wb6ibTIQ89tN9ZcZYL2wrgkuO5M+B6LJ+QMZKFJLb
         I0atidGs8T+GMXDmRzjUCtXtOCFFOegXFyfeGHYqJQDUtRXGawBcQAvXRmjIomALLYGk
         y5HCSC8f+fDHLTr0L+dnq8wT1Nle4nJK66MAIEI+2KzvUn8od/qxthjKuIch70i3ZlVN
         LbTOSCGHDvzNlr6SNMMduL9YbwvN0SUme3FpK8bPUbI7cnbGuZ4JZj4rnJQMLfByXQ5E
         Vdx81jShPASoO46ZM5ztxCdGqsCguklx4Eik9RrTdzki0K93WM0Fb1gHzMPW/QOUgTiN
         OKuw==
X-Gm-Message-State: AOJu0YyiHGMX6km8LvkDcIb1Fc5YSKXzGQd9lC6PKJs6XPZlu6ZDIiMH
	VDwKYsUqcOdBehRh+0zbUb5gQgHzg9ju5tVWiljYwmxySpe5ntOuKCdslkyoaw==
X-Gm-Gg: ASbGncsVwXtcuocApjqfhwN3edECTDWadReeZFddsE/kfy0k22Mrf5MYYxa3y5c5wdI
	8kNLkthkMjWEpUDm1YKLqqYmG99phdXmR/91cdFmTxSCuI+L1Rw/VhkITAg7lCR4pXWsXXV4avo
	OCo6dCy7urSOYZXD4M1epu7pr8pUPrcHwFhSV6XvcdSPY/0j8oyrcKTxf9VIE2KtYPdmr7G0csL
	Wu4tERhcIh3lpKAGUxgDcYOXtV7nHdXVqCxvR3Q20ayVxT0l6uK3zZ+up0iNt0TS/eH1syYCoFo
	zditPJeNmYL/mZ+RePneohy6lrV60saqI6EQ5Tqe40/1b7PTpCyl
X-Google-Smtp-Source: AGHT+IHKJ/5Vd2rZ5QXxYn4QLV5HBX4GVpfCu74LlfVq1FUgP4TsIZo3xny6KqziGjPTaeED9TTZ7Q==
X-Received: by 2002:a17:902:d4c9:b0:215:86c2:3ff4 with SMTP id d9443c01a7336-21586c243e0mr155713095ad.28.1733299097722;
        Tue, 03 Dec 2024 23:58:17 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:16 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH for-rc 2/5] RDMA/bnxt_re: Avoid initializing the software queue for user queues
Date: Wed,  4 Dec 2024 13:24:13 +0530
Message-ID: <20241204075416.478431-3-kalesh-anakkur.purayil@broadcom.com>
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

Software Queues to hold the WRs needs to be created
for only kernel queues. Avoid allocating the unnecessary
memory for user Queues.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Fixes: 159fb4ceacd7 ("RDMA/bnxt_re: introduce a function to allocate swq")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 42 +++++++++++++-----------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index e42abf5be6c0..8c6a09ac14ef 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -659,13 +659,6 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_alloc_init_hwq(&srq->hwq, &hwq_attr);
 	if (rc)
 		return rc;
-
-	srq->swq = kcalloc(srq->hwq.max_elements, sizeof(*srq->swq),
-			   GFP_KERNEL);
-	if (!srq->swq) {
-		rc = -ENOMEM;
-		goto fail;
-	}
 	srq->dbinfo.flags = 0;
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
 				 CMDQ_BASE_OPCODE_CREATE_SRQ,
@@ -694,9 +687,17 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	spin_lock_init(&srq->lock);
 	srq->start_idx = 0;
 	srq->last_idx = srq->hwq.max_elements - 1;
-	for (idx = 0; idx < srq->hwq.max_elements; idx++)
-		srq->swq[idx].next_idx = idx + 1;
-	srq->swq[srq->last_idx].next_idx = -1;
+	if (!srq->hwq.is_user) {
+		srq->swq = kcalloc(srq->hwq.max_elements, sizeof(*srq->swq),
+				   GFP_KERNEL);
+		if (!srq->swq) {
+			rc = -ENOMEM;
+			goto fail;
+		}
+		for (idx = 0; idx < srq->hwq.max_elements; idx++)
+			srq->swq[idx].next_idx = idx + 1;
+		srq->swq[srq->last_idx].next_idx = -1;
+	}
 
 	srq->id = le32_to_cpu(resp.xid);
 	srq->dbinfo.hwq = &srq->hwq;
@@ -1044,13 +1045,14 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (rc)
 		return rc;
 
-	rc = bnxt_qplib_alloc_init_swq(sq);
-	if (rc)
-		goto fail_sq;
-
-	if (psn_sz)
-		bnxt_qplib_init_psn_ptr(qp, psn_sz);
+	if (!sq->hwq.is_user) {
+		rc = bnxt_qplib_alloc_init_swq(sq);
+		if (rc)
+			goto fail_sq;
 
+		if (psn_sz)
+			bnxt_qplib_init_psn_ptr(qp, psn_sz);
+	}
 	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
 	pbl = &sq->hwq.pbl[PBL_LVL_0];
 	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
@@ -1076,9 +1078,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
 		if (rc)
 			goto sq_swq;
-		rc = bnxt_qplib_alloc_init_swq(rq);
-		if (rc)
-			goto fail_rq;
+		if (!rq->hwq.is_user) {
+			rc = bnxt_qplib_alloc_init_swq(rq);
+			if (rc)
+				goto fail_rq;
+		}
 
 		req.rq_size = cpu_to_le32(rq->max_wqe);
 		pbl = &rq->hwq.pbl[PBL_LVL_0];
-- 
2.31.1


