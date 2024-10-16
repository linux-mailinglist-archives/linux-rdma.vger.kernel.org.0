Return-Path: <linux-rdma+bounces-5426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9A9A03FB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A9B25B95
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0491D1747;
	Wed, 16 Oct 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DXhctMZ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACA1D1F7B
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066614; cv=none; b=bnBSA8Z356mttn1Y1EWE0pftjOmGeN/9JypmYliiFuQttbuD7kNcKiuEtGHWqCyUBidsRbgk+XCIVHDMPyf37PBIgxp6CKpUOtFOUxL7XjC9+ws4rKLt9CAn//SqNkAw6FVH474Jsqb9OB7YkZgPWWl2VmhXi7tJqQfkVI10r7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066614; c=relaxed/simple;
	bh=/AoMQ85Rsieg6fL7IVo6orZA6e+C0G2k1GxjBFgBTOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dA9jd7GY7Rc22h+YT1iWvCYJFpO+99YGaanMauZHCpam57gqj8rpIh1YXQiUuaMtnUWgKGj6mCFqjCzl+E6QfsVLHEJh2yNYMejkn1wZBxvPvIh7uW9k++iLGQOs8NWqSoLEKWgNrX26J09PlCxjCCi+lrnTnLrToXbL+G5Zo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DXhctMZ4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4718824a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729066612; x=1729671412; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0NyQhkTt1DgVKYF1AhaZw/E6Y4WNFX/D1aPLsV8EWE=;
        b=DXhctMZ46GkiXH2BfZR9DUaLCgOsho5nI/oF73CoOOjpEo7cka0G+47kEWeUHNEGxq
         moun+ldfr1kSBkkHa6BMkfaOh06tCr4FDBBK0wUPjjslCEbbyJKoRyfpbM++Q8rsXjbJ
         PvVFYm1hN/3nCSgnmPOOZswVcU7b7jG21eLrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066612; x=1729671412;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0NyQhkTt1DgVKYF1AhaZw/E6Y4WNFX/D1aPLsV8EWE=;
        b=InL7REZCCXgqtKiMCN0CHqB2XIk2QqmcVn2KIsSvhqqVPmp2Sdy+OpChJr3jKygsxb
         GtgwHaTtnj6GNXxOzoShbUEhp8yVLjp5I4Z3Ds53Yw2Ic4khuPS49fNlpeANPx22HfPv
         6A3gSE/JdjyDmz54SYtuUbxA+FxUISc+07n7KsTx5yb7DXsWU3/BstqhaWsABh0rHgRe
         nIX3TGBWW7uLQJo5Pd1eW/E7+HmB3VENQc/8HdVmZ5yLtZBO0q5kWaGVCVOThOdJGReh
         9hji32wB8nEqFLmEWmdu1vON0KVtF6nypzCuRyj1BIeWZtoAfqhEdXDADWlcNn6POrT3
         rNUA==
X-Gm-Message-State: AOJu0YwDS2IGYd27qVQl/my92f0CS2juegomuNW/7paEcZw/Njgig6yO
	eJWe9kCdEIP0yLDtDEMTYEqjxqZw8zXK6+ZyZKo4m+0u4u0EqPsh3zIIOqrhDQ==
X-Google-Smtp-Source: AGHT+IFLNQzg/B92beHjnaP/SL4AqxxMS50gCIRZZgKUrpDLTDuKa4/lOXP2Bb0saEqBDw3w9SA/ow==
X-Received: by 2002:a05:6a21:4d8b:b0:1cf:4ad8:83b9 with SMTP id adf61e73a8af0-1d905f7601emr3940213637.43.1729066612122;
        Wed, 16 Oct 2024 01:16:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371099sm2632667b3a.15.2024.10.16.01.16.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:16:51 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 4/4] RDMA/bnxt_re: Fix access flags for MR and QP modify
Date: Wed, 16 Oct 2024 00:55:46 -0700
Message-Id: <1729065346-1364-6-git-send-email-selvin.xavier@broadcom.com>
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
v2 -> v3 :
	Use qp->qplib_qp.cctx instead of the local variable qplib_qp->cctx
	in bnxt_re_query_qp
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


