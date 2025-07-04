Return-Path: <linux-rdma+bounces-11896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D27AF86D3
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 06:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952A91C43AAA
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 04:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404981E5201;
	Fri,  4 Jul 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h3Xwb1Gw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218C15E5DC
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603591; cv=none; b=T0p1Rq6aujDvWB+fRgfWodtFFxl0UCGK7cX1PfY7grIfCwJJhfww7aPBiPbyVgwpd3PJG+5uQSeSx+bMxOuxMHZvX3hOW3iPF/NvFpnY4LKsHyCKzmeoVCekpfjIIb/Itv/6gmV8aGryznAav0wecCOVSTv9a0wOKWYW8jDB8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603591; c=relaxed/simple;
	bh=1ivgTPkJ8kbdvg1QqzdH8/yWUNzDNo9LpxH1aD82n2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQFCy6d0FMxx45rbHLA0Cfv4QAdeOgo8J3v69zfJGVaN/UxR11DuN/GxZA6Co61kD8TKipEfEgAvlYzAifRbnOce5O3jywughoBpmgWFbphq5njZVD/H6ZCIE6Vpp17jZaQmt9u3NFhS+aBtiuFsS0Sdgy3umDIqSeqsLcfb7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h3Xwb1Gw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748d982e97cso628735b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jul 2025 21:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751603589; x=1752208389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW1T0Zf5bXUUtMIZj6KeHmDmuHwmSmHPG2SrPQf37eo=;
        b=h3Xwb1GwZzPxahf4NeYmnM+ZlRRDo8HD/lJGLHXSI6ZjitVWMHF26OjudL/hMrTpoX
         dkS6FfPRvSTHuDWEUWR/UUiQ8OXJOlucMdCJqWw1w4VHuDTNMA5pchnxlJMYrMg8t8tx
         4hxi3bLzDPJMLajL3hC0wVrVhaFoyg/eLE6Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751603589; x=1752208389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW1T0Zf5bXUUtMIZj6KeHmDmuHwmSmHPG2SrPQf37eo=;
        b=CF3l6/ZTodoURknndoRQSh3xAV7Vwd0lZ/sk2QKXYhczGP6QmJiH+T9yoF8GLAJLdD
         ha7pOkj2DntVdmgU33YXiZjPLlIPAvAM27WvUsen5WtuIi7Oz/ACCrA3mbbtST5vFalY
         I1RALE/NLOWRBrk5upGzevg4S8x2Z6ME0tWv5+q+kp/zYjUV7OFvca/hGCbCqTZlkJL2
         trIseeqKxLiz3UQGtkJ2sdkoArm4CIYwtqHw1H6stbkn+rHH87n0DZpW6sKhxq7rGRoW
         01V36O7d9f+WI/r+uDSDzsO7/blss9jjf7nu/h7o7HnHRNOPRnEqVSuy0kDjkeSRxlKw
         RTNg==
X-Gm-Message-State: AOJu0Yy3DV/PB7fN/E169Tv1sKVqvUU6e0VPKaZe/d8xposRw2UM3vxR
	7n4F4XGolRckAot3r67GSigtZpO71RcxjHzCH+gM5wWqTSmExJnpZ99cmLDezTcskw==
X-Gm-Gg: ASbGncsIiTaYxhz8f/jaB3LoQssDNyoYgSArigxDWoR5iA+QEnR7xv1KOgchVUyuvZJ
	RCSmVsJlaRfexeePPFKVxgbQdNIMh9yksIp3lRYi8Lg4RHBeirXhyV5Km63YLfwlAgFJnPGtsY5
	+cFN0SJRrbEfzDh71ZoxE9I9gQ/2w88u2L+EU9D2IdF1Q9ndD8PABKcst95rWy2hJqNgUgUEnAE
	Snrat2LLSYxDCHAsCh4si5aWJDX69Jy3x9nOFeQkB04LDtB4hpKFCN88Qp2BqMQd5oT/RoxuNPG
	fKCoAuQTEZm9KaywZoD6fbABWvTY92EbjdifV+acHBrVHrK3IH04gQeE/4shllFSQb4pBJNGmBL
	QNFL+xubpcQCnBG/QjLuN2GYwU/l63wsfwr+VO/sjCfYs9FI+TLbe4p5h3SWmWZV1Ag==
X-Google-Smtp-Source: AGHT+IHOy4JQgFFNEkcAgEc+eVWu5llLaUJV89+5trQRg1rqiBuZGBxt5iEwtyQEDEfufsxbjZYdfA==
X-Received: by 2002:a05:6a20:4389:b0:21f:e9be:7c3f with SMTP id adf61e73a8af0-225b85f3de8mr2363742637.11.1751603588862;
        Thu, 03 Jul 2025 21:33:08 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm976223a12.77.2025.07.03.21.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:33:08 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 2/3] RDMA/bnxt_re: Support 2G message size
Date: Fri,  4 Jul 2025 10:08:56 +0530
Message-ID: <20250704043857.19158-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Selvin Xavier <selvin.xavier@broadcom.com>

bnxt_qplib_put_sges is calculating the length in
a signed int. So handling the 2G message size
is not working since it is considered as negative.

Use a unsigned number to calculate the total message
length. As per the spec, IB message size shall be
between zero and 2^31 bytes (inclusive). So adding
a check for 2G message size.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 28 ++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  3 +++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index be34c605d516..dfe3177123e5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1750,9 +1750,9 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	}
 }
 
-static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
-				 struct bnxt_qplib_swqe *wqe,
-				 u16 *idx)
+static unsigned int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
+					  struct bnxt_qplib_swqe *wqe,
+					  u32 *idx)
 {
 	struct bnxt_qplib_hwq *hwq;
 	int len, t_len, offt;
@@ -1769,7 +1769,7 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 		il_src = (void *)wqe->sg_list[indx].addr;
 		t_len += len;
 		if (t_len > qp->max_inline_data)
-			return -ENOMEM;
+			return BNXT_RE_INVAL_MSG_SIZE;
 		while (len) {
 			if (pull_dst) {
 				pull_dst = false;
@@ -1795,9 +1795,9 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 	return t_len;
 }
 
-static u32 bnxt_qplib_put_sges(struct bnxt_qplib_hwq *hwq,
-			       struct bnxt_qplib_sge *ssge,
-			       u16 nsge, u16 *idx)
+static unsigned int bnxt_qplib_put_sges(struct bnxt_qplib_hwq *hwq,
+					struct bnxt_qplib_sge *ssge,
+					u32 nsge, u32 *idx)
 {
 	struct sq_sge *dsge;
 	int indx, len = 0;
@@ -1878,14 +1878,12 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_hwq *hwq;
 	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
+	u32 wqe_idx, slots, idx;
 	u16 wqe_sz, qdf = 0;
 	bool msn_update;
 	void *base_hdr;
 	void *ext_hdr;
 	__le32 temp32;
-	u32 wqe_idx;
-	u32 slots;
-	u16 idx;
 
 	hwq = &sq->hwq;
 	if (qp->state != CMDQ_MODIFY_QP_NEW_STATE_RTS &&
@@ -1937,8 +1935,10 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
 	else
 		data_len = bnxt_qplib_put_sges(hwq, wqe->sg_list, wqe->num_sge,
 					       &idx);
-	if (data_len < 0)
-		goto queue_err;
+	if (data_len > BNXT_RE_MAX_MSG_SIZE) {
+		rc = -EINVAL;
+		goto done;
+	}
 	/* Make sure we update MSN table only for wired wqes */
 	msn_update = true;
 	/* Specifics */
@@ -2139,8 +2139,8 @@ int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
 	struct bnxt_qplib_hwq *hwq;
 	struct bnxt_qplib_swq *swq;
 	bool sch_handler = false;
-	u16 wqe_sz, idx;
-	u32 wqe_idx;
+	u32 wqe_idx, idx;
+	u16 wqe_sz;
 	int rc = 0;
 
 	hwq = &rq->hwq;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 0d9487c889ff..ab125f1d949e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -346,6 +346,9 @@ struct bnxt_qplib_qp {
 	u8				tos_dscp;
 };
 
+#define BNXT_RE_MAX_MSG_SIZE	0x80000000
+#define BNXT_RE_INVAL_MSG_SIZE	0xFFFFFFFF
+
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
 
 #define CQE_CNT_PER_PG		(PAGE_SIZE / BNXT_QPLIB_MAX_CQE_ENTRY_SIZE)
-- 
2.43.5


