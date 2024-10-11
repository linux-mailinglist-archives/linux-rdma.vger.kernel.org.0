Return-Path: <linux-rdma+bounces-5376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F3999C18
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 07:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEC1C217CD
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0B1F9406;
	Fri, 11 Oct 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LTMp54lU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D81F8F1A
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624299; cv=none; b=YEKVpg9ZXj78HKlvJEEdNGrS2uEFsrf8HxZ2KkryeEbzo1z0nk3gghri7Dm+KXHTHNM0rFaX5RKi6fGxgF1KtaHcuPQ5gVW5KDY1GoHW9Z2uEb4uUQczgGxZBpoU4w0WLK44//jYNuys05TPM4liHCkfgGwMR7IfuZTE4CyViYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624299; c=relaxed/simple;
	bh=60/kvCw8m5tsQdOMLYTihJN3UjmvfdZ9Ea6qu3hbx/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bmlujcO5WSaCvoLYAbUVendYG25ZZwkOUjfohsCfH7rxV0JBwDajvmqcIWp0tv/STRkc3dHSTppvx0AzzMrellJZo429//PUz/FH0KMJITcbLoqY4TGYCIFdp/2R15QUUR+qRAIl0IxnwwGlp/sKibqcMaK8APZ0TfYOTfeHmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LTMp54lU; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so1275689a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728624297; x=1729229097; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hqEetbwTXnyXO6RnSRXgjpBQzy/x3Y3nCcd44HheD4M=;
        b=LTMp54lUXzFi14JC6kcoS68gWzheRwQ4D9maGPvhl7U9uYztCCC7PbHuQsPt2EQTTP
         mcV7HNpBSguVGP7tyRZoujXYsRwxro9QLo2mMrAqTQMti7IjlEbgrhOx8wtkHhnJFA2h
         HcVJYFf00Uj6vgXHp/eNGG/bxd8PsOWobFUtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624297; x=1729229097;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqEetbwTXnyXO6RnSRXgjpBQzy/x3Y3nCcd44HheD4M=;
        b=ssPQJiP+UFu90z3tGJm8xXuJUiMLH9RR7l7rP11xG8+0nM4IEwsw9iFbJ3iPq5UD4K
         wuiYMbQTDWghGMKnOR+k6SMfbgw6xS27vbx9gPSMdZ0jGWejR0NTGYOgy9QZckbqd3G8
         r6RviBEznZnb7EiIlebcrux0cJrycqtwV/6fIQ9JRP1JKtOloqSkFlhduwIdReuuB+/g
         p7fywC7yVH/6t82NwXVocrKx225lgS0JVHgsw5iZrFvzgNRaNkDBKgNzy1r6gT5CvX7h
         7x1vc4cAw8F2pfonANnuSCCN0ZjKA76PlvhO4C5iVhsZJATm7L0MjNBAkgrZHEnEu1LV
         OJwQ==
X-Gm-Message-State: AOJu0YzClkiOuUSWOTVgO0wvSIdTGX4thkBbiW47LXK+E/dLNXJqxHhw
	NqJEQf3iRR4jeIstFp5X7qmzf3Hu2vZX9NtU01N04dIc+dVqCtqXHEz/RXiwKg==
X-Google-Smtp-Source: AGHT+IHbvsBzuXFVd11ENOGF3HqRlKeqNX1Lq7s5xi+5luLfF7t8GtLfzK/DhoU9K7MK4E+ayffSjQ==
X-Received: by 2002:a17:90b:110c:b0:2e2:92fe:35d5 with SMTP id 98e67ed59e1d1-2e2f0c5c21dmr2159781a91.31.1728624297470;
        Thu, 10 Oct 2024 22:24:57 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f09ff1sm2377069a91.26.2024.10.10.22.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 22:24:56 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/4] RDMA/ bnxt_re: Fix access flags for MR and QP modify
Date: Thu, 10 Oct 2024 22:03:55 -0700
Message-Id: <1728623035-30657-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Hongguang Gao <hongguang.gao@broadcom.com>

Access flag definition in MR and QP is different
in FW. Currently both reg/bind MR and modify/query QP uses
the same flags. Add a different function to map
the QP access flags for newer adapters.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 59 +++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2a21a90..5008c28 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -94,9 +94,9 @@ static int __from_ib_access_flags(int iflags)
 	return qflags;
 };
 
-static enum ib_access_flags __to_ib_access_flags(int qflags)
+static int __to_ib_access_flags(int qflags)
 {
-	enum ib_access_flags iflags = 0;
+	int iflags = 0;
 
 	if (qflags & BNXT_QPLIB_ACCESS_LOCAL_WRITE)
 		iflags |= IB_ACCESS_LOCAL_WRITE;
@@ -113,7 +113,49 @@ static enum ib_access_flags __to_ib_access_flags(int qflags)
 	if (qflags & BNXT_QPLIB_ACCESS_ON_DEMAND)
 		iflags |= IB_ACCESS_ON_DEMAND;
 	return iflags;
-};
+}
+
+static u8 __qp_access_flags_from_ib(struct bnxt_qplib_chip_ctx *cctx, int iflags)
+{
+	u8 qflags = 0;
+
+	if (!bnxt_qplib_is_chip_gen_p5_p7(cctx))
+		/* For Wh+ */
+		return (u8)__from_ib_access_flags(iflags);
+
+	/* For P5, P7 and later chips */
+	if (iflags & IB_ACCESS_LOCAL_WRITE)
+		qflags |= CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE;
+	if (iflags & IB_ACCESS_REMOTE_WRITE)
+		qflags |= CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE;
+	if (iflags & IB_ACCESS_REMOTE_READ)
+		qflags |= CMDQ_MODIFY_QP_ACCESS_REMOTE_READ;
+	if (iflags & IB_ACCESS_REMOTE_ATOMIC)
+		qflags |= CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC;
+
+	return qflags;
+}
+
+static int __qp_access_flags_to_ib(struct bnxt_qplib_chip_ctx *cctx, u8 qflags)
+{
+	int iflags = 0;
+
+	if (!bnxt_qplib_is_chip_gen_p5_p7(cctx))
+		/* For Wh+ */
+		return __to_ib_access_flags(qflags);
+
+	/* For P5, P7 and later chips */
+	if (qflags & CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE)
+		iflags |= IB_ACCESS_LOCAL_WRITE;
+	if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE)
+		iflags |= IB_ACCESS_REMOTE_WRITE;
+	if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_READ)
+		iflags |= IB_ACCESS_REMOTE_READ;
+	if (qflags & CMDQ_MODIFY_QP_ACCESS_REMOTE_ATOMIC)
+		iflags |= IB_ACCESS_REMOTE_ATOMIC;
+
+	return iflags;
+}
 
 static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *rdev,
 						   struct bnxt_qplib_mrw *qplib_mr)
@@ -2053,12 +2095,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	if (qp_attr_mask & IB_QP_ACCESS_FLAGS) {
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS;
 		qp->qplib_qp.access =
-			__from_ib_access_flags(qp_attr->qp_access_flags);
+			__qp_access_flags_from_ib(qp->qplib_qp.cctx,
+						  qp_attr->qp_access_flags);
 		/* LOCAL_WRITE access must be set to allow RC receive */
-		qp->qplib_qp.access |= BNXT_QPLIB_ACCESS_LOCAL_WRITE;
-		/* Temp: Set all params on QP as of now */
-		qp->qplib_qp.access |= CMDQ_MODIFY_QP_ACCESS_REMOTE_WRITE;
-		qp->qplib_qp.access |= CMDQ_MODIFY_QP_ACCESS_REMOTE_READ;
+		qp->qplib_qp.access |= CMDQ_MODIFY_QP_ACCESS_LOCAL_WRITE;
 	}
 	if (qp_attr_mask & IB_QP_PKEY_INDEX) {
 		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PKEY;
@@ -2263,7 +2303,8 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->qp_state = __to_ib_qp_state(qplib_qp->state);
 	qp_attr->cur_qp_state = __to_ib_qp_state(qplib_qp->cur_qp_state);
 	qp_attr->en_sqd_async_notify = qplib_qp->en_sqd_async_notify ? 1 : 0;
-	qp_attr->qp_access_flags = __to_ib_access_flags(qplib_qp->access);
+	qp_attr->qp_access_flags = __qp_access_flags_to_ib(qplib_qp->cctx,
+							   qplib_qp->access);
 	qp_attr->pkey_index = qplib_qp->pkey_index;
 	qp_attr->qkey = qplib_qp->qkey;
 	qp_attr->ah_attr.type = RDMA_AH_ATTR_TYPE_ROCE;
-- 
2.5.5


