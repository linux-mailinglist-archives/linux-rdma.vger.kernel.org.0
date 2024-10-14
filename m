Return-Path: <linux-rdma+bounces-5404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C2599D645
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60928283969
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2E1C729B;
	Mon, 14 Oct 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="carahTfE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEA1FAA
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929826; cv=none; b=c7YKSQNwyI7NQuxlQWFpQRlwJ41frAqawQMTc/4WsQsiZilqB7piEJOjE4rtiKvM7e2qJtj6q9tfeN4/1EKz2G2yoLNE6iTBFpQYi0vi1GWGV3KQt6MgJgr2zet0qXqorwkZAq5K/Hr4A06FHnaiMiGjiVK31c7QBk5HYehnJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929826; c=relaxed/simple;
	bh=GgcxI1JQKOW+u3bJz41LoVT8hMoUWIkGj5pTHy0enR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BKOHqjcArHsJFzXSKeHqQ8VrtpEhFWj/5h2EX4NPlScrziPzFYoWy34kc/YMX/YsxAmkpbvznUhaRmI0exi2Of3HimmtRSnJ7POfVS1R8SiMKry9Co4/IfMTgGr8icx7uN2q/NY1cUfDUidrbWb/MvOg6f3FjI47UDW75bRlBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=carahTfE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2870338a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728929824; x=1729534624; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9nka0cMrTPC8jTn6S2p9S6qjLFYuiu+Pf0YA5YieN0=;
        b=carahTfEvSS9+oB0rviDZL2PB1z3Q+G8P4sxbiBuSUeAxwmHKjkWQRtWf556Y7Zj6o
         DprDPxLvPhy3U0js7ATUFf+VgyPD8AMYzCcb1L2DDy88TBREl+bX/ACAzKgakHFg17On
         m/3SBXZSno99f8/DfjnRBgt3fH+Z0OWlCXux8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929824; x=1729534624;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9nka0cMrTPC8jTn6S2p9S6qjLFYuiu+Pf0YA5YieN0=;
        b=s8vPLJV1D+QimBzz1WoXyT39kzIQW5F/aUSuXnrWX889nN/InHC8jG2dGr9J1Q4k64
         yYDuelnkh9RofcCmShMQF9W1YOlqYLUT9hr4CX+AyRvx2pYuefSiHDqtg5A39la2dLZ1
         mI3O9u0xPSUVGpd5t/otKxPSrISXbGR/mLhlI0DalLfmS9+uYsabAc26/ob0OAIJXLxD
         n13UpesLHRaWKnyQg3JUaSzWXY09IQp4H0TYAmIGsyEZTnbT8MmQWQ6FgNG73ESJFGVz
         PraxBlGgc/cJalWF7br8274vx1ZOZgHNAq415wgBvBsktIORkbR0TII+maU6U/Br92Hh
         OGAw==
X-Gm-Message-State: AOJu0YzuZql6m+SRvVlG65UQrRn+jnz1CL/OEMsIDrEo2h/sLdktHaGo
	B/QxW5EBTRm5SEFeE7Pnpww3l/KME9bP3yXBNP+L9cWzQddXbOCuErDxkiPRzDB30ZnBOwxKIrq
	Zeg==
X-Google-Smtp-Source: AGHT+IFkt+ek/HPSpW9Ey6gwVGmO/Nei6cxXSb0tjEsOsgruBeX+iijGLJy/JG9VtymRXAQNaW7LFw==
X-Received: by 2002:a17:903:41cd:b0:20b:7388:f74 with SMTP id d9443c01a7336-20cbb17d5f9mr145118525ad.12.1728929824422;
        Mon, 14 Oct 2024 11:17:04 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada14asm69245605ad.7.2024.10.14.11.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:17:03 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 4/4] RDMA/ bnxt_re: Fix access flags for MR and QP modify
Date: Mon, 14 Oct 2024 10:56:01 -0700
Message-Id: <1728928561-25607-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
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


