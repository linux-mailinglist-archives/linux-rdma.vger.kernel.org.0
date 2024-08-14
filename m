Return-Path: <linux-rdma+bounces-4362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A251395160C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 10:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CF01F22E93
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAA13DDB9;
	Wed, 14 Aug 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IRxsBmKw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14213DDB8
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622585; cv=none; b=HXF0YOD77gkPjp80LYOfftkkyBxlrMq2aGwCwpDtiFWZ2nyrgaLwXJRNNIjzNSe5cMmU/LyuDaep8psMFY1at2hL/0r34KHkATRZodPaNEBdf/E/AaPHKm7dLtDdA4LbhXDK4mHufzHj5PhR326DxCNnoUKcLQOt4eQXUSc1ILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622585; c=relaxed/simple;
	bh=ao/wWhveVu5QBfZT09zaMhBfE8oXztAb+VQzGh51WLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V9O1IQPOVnwp6JT7X64ePk0c1ao85bGoT9T7QJzfDHyF0yw89/Jrfy96DtK7kjSIZPZpY/V//gCGuy2k4PxignGUNq61FqTSO6qeS8qSCxO1h4/WFoZpphop0nOL2kqw6ohBdmiODpZntW1KdvTY+v4szvZa/XfDrHbENAbpBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IRxsBmKw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4555980b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723622583; x=1724227383; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFxMvaJm1XZaJKSDs7e/vMMcPSpSlLubv3x6ytcxlpw=;
        b=IRxsBmKwg4/zQtkfP9tQ5msb01HkuuNTF+i2VCSDQjeHeTL2tiUG27rEKqzG9fp/ek
         qEfE+8YQ/3zMmMqpR2uY16dCRsWMnw43bQnecHjofKTVOT/z0Djv/o8nRs4m9S+5klsG
         WNB6gnTp2BxkkSRvpm4szwfAG5SJ3LiUJR64E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622583; x=1724227383;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFxMvaJm1XZaJKSDs7e/vMMcPSpSlLubv3x6ytcxlpw=;
        b=aB3CNqE03zzZTxrpEy0oRPvloFUJENsdsS6JBExU+YwdveSv4i8ki2ZLXFF1iYybSB
         3sXmxf9iKqfLW3Vc9dx2qQIxrTGwPNoIvVIirOHGNuPX2nkaL8SVU7ahMlVpYa32JDan
         In5x8KdkJEBNsODHrif4FHj6hZHuON7EApwM9rZTynsf8TmxSatihFbSQujjcK/7atn7
         V6sdWyIttyq2YIuwZyU0CoEhTKFfezab0WzDfuetnZ7+gwQhTuYKFfbEsmGrI8/myiI2
         Wy7R0XeqbtbFJhVm7emj9a3NGvpBUfhaLiJ8Na65l2iaBg0Y65+UDDnHWFRWJtmdHMKA
         K3UA==
X-Gm-Message-State: AOJu0Yz6X46wuLHDfSsVVTHgSTbMAc9TAN+rVIvyF2RjDdgu5Z84nMrn
	ugFejJy2ESMpxwyL9Lf5GX33wOnQlRbemoH+VBzjnwt3D8HvTpXifkXOE1tEGw==
X-Google-Smtp-Source: AGHT+IFzqQ+YZ+9VbQxkuVm7SpKW2wD06It/CtSkS5yTm7X95yWWg/HkSuA2jdkO8G2KTYFmAXOajQ==
X-Received: by 2002:a05:6a00:80f:b0:70a:f576:beeb with SMTP id d2e1a72fcca58-712671207f0mr3075082b3a.15.1723622583190;
        Wed, 14 Aug 2024 01:03:03 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([115.110.236.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac40e0sm6782479b3a.216.2024.08.14.01.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 01:03:02 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Get the WQE index from slot index while completing the WQEs
Date: Wed, 14 Aug 2024 00:42:00 -0700
Message-Id: <1723621322-6920-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

While reporting the completions, SQ Work Queue index is required to
identify the WQE that generated the completions. In variable WQE mode,
FW returns the slot index for Error completions. Driver need to walk
through the shadow queue between the consumer index  and producer index
and matches the slot index returned by FW. If a match is found, the next
index of the shadow queue is the WQE index to be considered for remaining
poll_cq loop.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 40 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 10 ++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 0af09e7..b49f49c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2471,6 +2471,32 @@ static int do_wa9060(struct bnxt_qplib_qp *qp, struct bnxt_qplib_cq *cq,
 	return rc;
 }
 
+static int bnxt_qplib_get_cqe_sq_cons(struct bnxt_qplib_q *sq, u32 cqe_slot)
+{
+	struct bnxt_qplib_hwq *sq_hwq;
+	struct bnxt_qplib_swq *swq;
+	int cqe_sq_cons = -1;
+	u32 start, last;
+
+	sq_hwq = &sq->hwq;
+
+	start = sq->swq_start;
+	last = sq->swq_last;
+
+	while (last != start) {
+		swq = &sq->swq[last];
+		if (swq->slot_idx  == cqe_slot) {
+			cqe_sq_cons = swq->next_idx;
+			dev_err(&sq_hwq->pdev->dev, "%s: Found cons wqe = %d slot = %d\n",
+				__func__, cqe_sq_cons, cqe_slot);
+			break;
+		}
+
+		last = swq->next_idx;
+	}
+	return cqe_sq_cons;
+}
+
 static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 				     struct cq_req *hwcqe,
 				     struct bnxt_qplib_cqe **pcqe, int *budget,
@@ -2481,6 +2507,7 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *sq;
 	u32 cqe_sq_cons;
+	int cqe_cons;
 	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
@@ -2498,6 +2525,19 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
 		goto done;
 	}
+
+	if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
+		cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, hwcqe->sq_cons_idx);
+		if (cqe_cons < 0) {
+			dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
+				__func__, hwcqe->sq_cons_idx);
+			goto done;
+		}
+		cqe_sq_cons = cqe_cons;
+		dev_err(&cq->hwq.pdev->dev, "%s: cqe_sq_cons = %d swq_last = %d swq_start = %d\n",
+			__func__, cqe_sq_cons, sq->swq_last, sq->swq_start);
+	}
+
 	/* Require to walk the sq's swq to fabricate CQEs for all previously
 	 * signaled SWQEs due to CQE aggregation from the current sq cons
 	 * to the cqe_sq_cons
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index f54d7a0..2e7a4fd 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -649,4 +649,14 @@ static inline __le64 bnxt_re_update_msn_tbl(u32 st_idx, u32 npsn, u32 start_psn)
 		(((start_psn) << SQ_MSN_SEARCH_START_PSN_SFT) &
 		SQ_MSN_SEARCH_START_PSN_MASK));
 }
+
+static inline bool __is_var_wqe(struct bnxt_qplib_qp *qp)
+{
+	return (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE);
+}
+
+static inline bool __is_err_cqe_for_var_wqe(struct bnxt_qplib_qp *qp, u8 status)
+{
+	return (status != CQ_REQ_STATUS_OK) && __is_var_wqe(qp);
+}
 #endif /* __BNXT_QPLIB_FP_H__ */
-- 
2.5.5


