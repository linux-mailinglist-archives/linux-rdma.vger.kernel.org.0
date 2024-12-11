Return-Path: <linux-rdma+bounces-6424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E59EC78D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CC16A86A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B11E2007;
	Wed, 11 Dec 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bJeHSOxA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF31DE8B7
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906652; cv=none; b=FGFg5gGcaFEAYjx4A6W2gnNe4MD069rGxrQGX865BXEN7J2S+0V3dc3IZVQvOTgjZAuK6YWe/k3ed2gbMJVnv6XpJnDV/DcfK+JxsjqQLGUAvfXPFzsRzb9MAgoQ96npBo5IQ9eFniGmiGUNptrZYsT+ktj6umqZ8j7nIxd4Q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906652; c=relaxed/simple;
	bh=iC0eZmWoat9R67TXlnCfAg5RY/EwxobpMOdoMGHrRFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb92ZcnErhqLZ0ntb2h66cHW2fO7d+jq7L0uH5YkHLWqZ7sd7+k/e0opmghPfcXoP3YAYxkXME6WGWoBAU3JNam7SYXNvoLbS+Ry/i9aA1SwgfK1oNsIeT7HlB9lHj9yN0Br15U25k6KzuUgZryxo0Oaz70vw+WMaiWx3mQD964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bJeHSOxA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-723f37dd76cso5719073b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906650; x=1734511450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZnjkZelwJOROBz1YROF+KrWXEJ6KdTHprw3DY6m5hE=;
        b=bJeHSOxAorOGxSmSlWIUuXkOHYPdW1ErbJwUelZ9PWuy5NvUMIM3C3YXG3JliXhX2b
         d+SPgLaKar5uPQq3PgpKkXrJ/LRrVc+snv/xTJ/2OiW7qNn7aAHS6ZJnqnNtj/nFntsg
         7SQ2ViGvD8hr64OQ62ULAr69gRtdO/xaBJOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906650; x=1734511450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZnjkZelwJOROBz1YROF+KrWXEJ6KdTHprw3DY6m5hE=;
        b=t+NTs0qgQ0SGPcH91m2GkJ/J1fdZv7qeLpfjWHBK7Ofv9X8aZQalUCWob0r33tejaZ
         wAbFEA+53ThW3VYMxLrfFT56hAh41bBd0qlf9TuhItJyXlswSuBzfALsiVUbotFQ+pC9
         sRR2MTbynCSpvv4c+/OtPnWZdlFWqy2C5i7VZXcgVU5RLULbdEr1SQcLcHC/igibLxOg
         +5Awbr/1c0O7KaaWZt46vyEp4xDWrboac6RJmVvoL7mR2J4wdz2S+R2otH0wiqo1jpPA
         TqGE74AuCyh3D8Zn4JLerXehE8qf4RYjREEWRaEIhx6xWbbD9gWautG+3JSJ33flVmYk
         LGYQ==
X-Gm-Message-State: AOJu0YzhOrs5cXlQ85Lu3Xr/BVyrpU4KOwghPQiL65MCzCxJuwtNSH1/
	KM+qzfXTyALdyIehOjApW0a2lyLIUwrntM4tauIsYT8FJy63saqh0lMgSpRsa7gBFsu8QP8xC7Y
	BCA==
X-Gm-Gg: ASbGnctnGjrY0ddCb4C/vBNyauyEa3uhENsyr1xnvwURqxhjLNI1Sz/OrhDlc+TJm1/
	G8GACsLfGU47eP184vf7NWPH7z1wvGd9aPYcs4mFOE/qbJnfclkMb/1w2Y22SmonugcSO3od2f9
	3IxoJvE49mVn6QCgxPVkZAbs3FzT+1yYfc+pHlouzmDX0xUsc7Y0H9IHRBrl5DBU9w/81LrwldC
	1UOhRNasztWgEmiNbmryKGedcMgalgq5LuNscYFghqHocJLNqhZnDc2d/j/afmajun/0SSWihez
	zLfFKH8n8txhJh8yzgxmWT7Kw0miBf7xbFyvLo6iucifyRiudUrrxBS3
X-Google-Smtp-Source: AGHT+IGc8TXuXEhihIG8QjimZJI9ZQOKdkrMSg9cqU4x28U0h7QtXvjoF1jYQPlxRbgepwnPmWv5gA==
X-Received: by 2002:a05:6a21:918c:b0:1e1:afa9:d38b with SMTP id adf61e73a8af0-1e1c126ef7bmr4674988637.8.1733906649652;
        Wed, 11 Dec 2024 00:44:09 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:09 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 3/5] RDMA/bnxt_re: Fix setting mandatory attributes for modify_qp
Date: Wed, 11 Dec 2024 14:09:29 +0530
Message-ID: <20241211083931.968831-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

Firmware expects "min_rnr_timer" as a mandatory attribute in
MODIFY_QP command during the RTR-RTS transition. This needs
to be enforced by the driver which is missing while setting
bnxt_set_mandatory_attributes that sends these flags as part
of modify_qp optimization.

Fixes: 82c32d219272 ("RDMA/bnxt_re: Add support for optimized modify QP")
Reviewed-by: Rukhsana Ansari <rukhsana.ansari@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 13 +++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 +++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 093bfb748cdf..5169804e6f12 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1285,7 +1285,8 @@ static void __filter_modify_flags(struct bnxt_qplib_qp *qp)
 	}
 }
 
-static void bnxt_set_mandatory_attributes(struct bnxt_qplib_qp *qp,
+static void bnxt_set_mandatory_attributes(struct bnxt_qplib_res *res,
+					  struct bnxt_qplib_qp *qp,
 					  struct cmdq_modify_qp *req)
 {
 	u32 mandatory_flags = 0;
@@ -1300,6 +1301,14 @@ static void bnxt_set_mandatory_attributes(struct bnxt_qplib_qp *qp,
 		mandatory_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PKEY;
 	}
 
+	if (_is_min_rnr_in_rtr_rts_mandatory(res->dattr->dev_cap_flags2) &&
+	    (qp->cur_qp_state == CMDQ_MODIFY_QP_NEW_STATE_RTR &&
+	     qp->state == CMDQ_MODIFY_QP_NEW_STATE_RTS)) {
+		if (qp->type == CMDQ_MODIFY_QP_QP_TYPE_RC)
+			mandatory_flags |=
+				CMDQ_MODIFY_QP_MODIFY_MASK_MIN_RNR_TIMER;
+	}
+
 	if (qp->type == CMDQ_MODIFY_QP_QP_TYPE_UD ||
 	    qp->type == CMDQ_MODIFY_QP_QP_TYPE_GSI)
 		mandatory_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_QKEY;
@@ -1340,7 +1349,7 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		/* Set mandatory attributes for INIT -> RTR and RTR -> RTS transition */
 		if (_is_optimize_modify_qp_supported(res->dattr->dev_cap_flags2) &&
 		    is_optimized_state_transition(qp))
-			bnxt_set_mandatory_attributes(qp, &req);
+			bnxt_set_mandatory_attributes(res, qp, &req);
 	}
 	bmask = qp->modify_flags;
 	req.modify_mask = cpu_to_le32(qp->modify_flags);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 21fb148713a6..cbfc49a1a56d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -584,6 +584,11 @@ static inline bool _is_optimize_modify_qp_supported(u16 dev_cap_ext_flags2)
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED;
 }
 
+static inline bool _is_min_rnr_in_rtr_rts_mandatory(u16 dev_cap_ext_flags2)
+{
+	return !!(dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED);
+}
+
 static inline bool _is_cq_coalescing_supported(u16 dev_cap_ext_flags2)
 {
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED;
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index a98fc9c2313e..0ee60fdc18b3 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -2215,6 +2215,7 @@ struct creq_query_func_resp_sb {
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
 			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
+	#define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED            0x1000UL
 	__le16	max_xp_qp_size;
 	__le16	create_qp_batch_size;
 	__le16	destroy_qp_batch_size;
-- 
2.43.5


