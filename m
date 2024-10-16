Return-Path: <linux-rdma+bounces-5423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BA9A03F6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED471C2A893
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4581D2211;
	Wed, 16 Oct 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O1sQz+/Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0A1D1E89
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066605; cv=none; b=IaXlHZw6p/P+34Jcr2Pye6xqpOa/Z+67oAIObPn4/pUA1V2exxSWADJfsQjIm+53SE60KrW6xoy2uFy6NtQ5xE7eZ09RjlanndGHIeQIshonHrdwYLvER1HZGhJgnaaiMzzKYdlQX0NeQAF28ViQJiXCj28/0HRYRnHqdA+NF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066605; c=relaxed/simple;
	bh=V58i4FmvFs4evebdN+YJRsMVUZWUp0uztxzriLTInr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n/cyp3nT0juefkf3M5mlLfci6hKdl1wZrZZeWM8DK3+Q/d2U0MnL+WriCkQnqNgJeoPrKYTRo6qyiB4q4GgZehleNvfQFpUpV0hccJFdT4iJq/zMD7Xho1YcYaz9FqjI4Ln6X9Tq9lR+jlWjXXotnKXeTcmXENsgfiPygrU0qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O1sQz+/Z; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso2548849a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729066603; x=1729671403; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UF85Z9xOg9gfInIBQdEmoWXg0ECKsJ5B5973kWAy5AY=;
        b=O1sQz+/Z8yxnrpeB1gcu3ikiOMYNnKcuwQBKKB/9dITP4yc3xyhUcqpfS0skWS6Zjp
         acvVC0LzHo54jLwVWqr9wI7Pv5USMoEnrKpyOC1ISFHAHRZhBhwaG83usJSai7ogioXP
         e4vkWI2/7otZPpz9q3W/9qIAH1Kmreih7y10Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066603; x=1729671403;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UF85Z9xOg9gfInIBQdEmoWXg0ECKsJ5B5973kWAy5AY=;
        b=JOhhf3nfap+VqjvlEMyga0KWwhspBC10FwvKFYfUVLqz9h3YlVZiLRoxOVPTmAc4Wx
         6JeV1RMRHgO/TB+MOQdyeg9xJfRZOMqKMwqOHBOQzPOfNSJT93h1NKph81a3Qct5ZGCM
         fXKBgIfwPrnZWvn/z5EMFEYk9ZIgeePY3rIwqJDjP4famAL2hKCBTsZOnx8fK57IVSsK
         doRwrMatwH+/+cxXFGFhk8n2gERSXta23gTjL36z8DPSvdIgP/OQ006+0PX3dAHcvpob
         cVKVcB1JlqA58xIvgBxyGUkYYlWWqUA5CVMX3alpoBzRI1e07b9Rg9tpzASnMd2iANOZ
         KH0Q==
X-Gm-Message-State: AOJu0YzG/JEbbueL9oh7KDTGZ/jl32qQEV6AYB9HzJbEyEAi9+PtVJNr
	nWkzVi8cxS2sxzXwcyQ7rvTLyADnATZ3CqKk9c7zt2r47gBF67eTZFhIA7UI1Q==
X-Google-Smtp-Source: AGHT+IHJDH5Bl5QuUA5MTH+8To92BGUtzA1XWD2GyzXoUbQh0wB1NjDxBZkx2NdPPdB83rmdTcXKRg==
X-Received: by 2002:a05:6a21:1519:b0:1d0:56b1:1aec with SMTP id adf61e73a8af0-1d8c9699ad7mr23413055637.35.1729066603375;
        Wed, 16 Oct 2024 01:16:43 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371099sm2632667b3a.15.2024.10.16.01.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:16:42 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH] RDMA/bnxt_re: Fix access flags for MR and QP modify
Date: Wed, 16 Oct 2024 00:55:43 -0700
Message-Id: <1729065346-1364-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
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

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 59 +++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2a21a90..e610807 100644
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
+	qp_attr->qp_access_flags = __qp_access_flags_to_ib(qp->qplib_qp.cctx,
+							   qplib_qp->access);
 	qp_attr->pkey_index = qplib_qp->pkey_index;
 	qp_attr->qkey = qplib_qp->qkey;
 	qp_attr->ah_attr.type = RDMA_AH_ATTR_TYPE_ROCE;
-- 
2.5.5


