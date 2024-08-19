Return-Path: <linux-rdma+bounces-4409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54109956306
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 07:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F488B21EAF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 05:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFC14A0A4;
	Mon, 19 Aug 2024 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UaaAV5Qe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC514883B
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044132; cv=none; b=MgtQQsb9UMaqfus0+jbf0Wf4dkFBIDeQ8/orXsRnd5xG12fYWNUeQF0zrwQ9viLaWJbI5IU/4xMBoX6dzA0qXkS8ts+yBCr7GA+3yIVmsZHvOmtL+DPf/qvKnA6uhWkh/htS6Btgnnl+OeozxeJUyVZ6VXLMD30X1ep/VFxPuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044132; c=relaxed/simple;
	bh=w6IQfTEVVPAsP5lfJO1aCy8NvzAtX6hYoyolL216CZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZP4bldrScDLmOQIM1WgS6RF8V7+v/rcgSsUxZ9saNj4lnXuC/xG/K3XuOeoX1ejVYEyrJgnUEI0sioWNySg0g/6U7NHPi8w+Ha3Xdjz8ZjHBd0Ie3mIz2Za5K07UPN2D/gSG4UODF9ZdG3FDqNoQYBbdnK90u8BP2GU92fSSSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UaaAV5Qe; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d34be8b64so5626335ab.1
        for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724044129; x=1724648929; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYN45UtvNHksfr/cCY907kDlv6PSMGdis2SyWN7h9Eg=;
        b=UaaAV5Qe/r1cgMF3GsJSkLI7TDoUn9pkuQfYd0a6NY1+P50VeJZDhhxAYN1RfubtWW
         fcKKfKuHd1bgCpt9/RGA17tNYTSUfFeG+qKPpP6bQCkUSw7BmEFJhiG5jgYipB4rrSN5
         SIvYwNTcuYuY/kseyziTJh1zRY/8MaBj1ObSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724044129; x=1724648929;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYN45UtvNHksfr/cCY907kDlv6PSMGdis2SyWN7h9Eg=;
        b=lxaFnelY9IczOfeaAS/DPkF46y8l+YYTmTimQJ1wBhYcSDWZPfyTYZyMHpBzbT+0EQ
         0AkTaVjXniqLr7e87+4jqbJG3hamRLQu0Mzz+Z4joXK1ommlS/NEqgL11+n1DlKlQz14
         VUOKCn9gw8svp1SCEH7LVnkde7Guu5TziAPULk55EEiloUbKfoyJ697wCpMNMms2KIDy
         wK54iavSnKLu57plqfnwZMYen+BR5BMnLFazwr83GqUXRQFKfAg8hsj3n8oS5ni11ql9
         kLumZlWwabnVMTJI1n9n8w4FQGrhcec79YdgIgFJB9BVZysA3ZAP/ekK6NHo9ZTcEn32
         vh2Q==
X-Gm-Message-State: AOJu0YxTJFXL07rBAt6cC+BoIr7b7fgi+xdec61iGK6umpbvoSGgdMRV
	PuaShg2wFWvmvy962gk7Vqeb7Yn2+E/e0xIZhlUJpf4lyDenFIdjZ6cUFiPV2g==
X-Google-Smtp-Source: AGHT+IGbomdJl2LAuRmX/Ipe7qGY40zEyymTzopR39fJcI8O0avnn8EiGtVyHYxcdR4YHQiSeob1Pw==
X-Received: by 2002:a92:cd82:0:b0:39d:1a7d:71ea with SMTP id e9e14a558f8ab-39d26d615fdmr118120035ab.19.1724044129435;
        Sun, 18 Aug 2024 22:08:49 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a7672sm6908021a12.4.2024.08.18.22.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 22:08:48 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v3 2/5] RDMA/bnxt_re: Get the WQE index from slot index while completing the WQEs
Date: Sun, 18 Aug 2024 21:47:24 -0700
Message-Id: <1724042847-1481-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724042847-1481-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 43 +++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 10 ++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 0af09e7..2810ffe 100644
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
@@ -2478,9 +2504,10 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 {
 	struct bnxt_qplib_swq *swq;
 	struct bnxt_qplib_cqe *cqe;
+	u32 cqe_sq_cons, slot_num;
 	struct bnxt_qplib_qp *qp;
 	struct bnxt_qplib_q *sq;
-	u32 cqe_sq_cons;
+	int cqe_cons;
 	int rc = 0;
 
 	qp = (struct bnxt_qplib_qp *)((unsigned long)
@@ -2498,6 +2525,20 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			"%s: QP in Flush QP = %p\n", __func__, qp);
 		goto done;
 	}
+
+	if (__is_err_cqe_for_var_wqe(qp, hwcqe->status)) {
+		slot_num = le16_to_cpu(hwcqe->sq_cons_idx);
+		cqe_cons = bnxt_qplib_get_cqe_sq_cons(sq, slot_num);
+		if (cqe_cons < 0) {
+			dev_err(&cq->hwq.pdev->dev, "%s: Wrong SQ cons cqe_slot_indx = %d\n",
+				__func__, slot_num);
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


