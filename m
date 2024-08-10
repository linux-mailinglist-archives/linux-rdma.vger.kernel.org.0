Return-Path: <linux-rdma+bounces-4299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4A94DE4C
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1562F1F21F24
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Aug 2024 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E313CFB9;
	Sat, 10 Aug 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dhMIOIkK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798813B5B9
	for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723318813; cv=none; b=AFKJ9WZvfop100T13RFIk4Ugq0nqZWDqB+uGXCk3tlsuSWah+XvK6VyxihUv9pRzDui1PLJI5YUn6YjejyTDVKj2Whg5hFzwJJInND8jB/T35sB+n6JoHoE8E+DRH2yqBv+3/DKY/5frFHgJOGir4kqInbyQV60pB0E7rEO9OiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723318813; c=relaxed/simple;
	bh=wIlkqgNSpjUbUZv6WBml/FOSJOTC3594X91lhBJMaqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Rc/oECmg1cMbg6ngz5bQPaGfwhsmzQj9dGfvjpbfgV7AUovkch0ZA0Nw0xJbO1zKiIQMRf0SH3I0nnWux4mtLxMH31UNelGYTXMdVXqJWw6jOo3JYjasGmjZbqPZPruOZzxJZGJYjzQVrzbZvCjwPlmgOk/OiQQi9ZMKJW5WwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dhMIOIkK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so2208523a12.3
        for <linux-rdma@vger.kernel.org>; Sat, 10 Aug 2024 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723318811; x=1723923611; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Q3TLE6KSLzQUt0egmg82VwS+JTUPaV5SlHOuElDS8w=;
        b=dhMIOIkKzaOKPzqK+C2L9+uc2/Z6E8Q/WUNwkFQqTnH3YXKfXf9OvjOin8x7qKmKo2
         YWTTTzMJyJEiXWPUJGPC+ARrqFSGx34sT/n2fTqTnhP8TFM6q5pgPAMfKjel3i0z+R5z
         6o1+rZQr6JSISS6fci+DPjUK5hSUkCM/8zekM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723318811; x=1723923611;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q3TLE6KSLzQUt0egmg82VwS+JTUPaV5SlHOuElDS8w=;
        b=NLWG1icw0FlpO8EJf/g2AGxKV7892/N0oojrPuj2O71L4JN3erH5Ydsn1YnlFdFpUg
         V6B/aTA5M9lvJ3rWr2HAYACrMdKJkyxARZjS9BKze8CEkM/AtNdqmK100ksH+1gGsEAZ
         cQnycnVQmi3LW1uhO7eco2/02U+mc7H7zKlOJL11YewJc52zoZwUmdkKwmDK42ihRjuv
         2yHQ0FEbjy98rPNRMpUwhPsqLSO2HkaAbyLkrW+EMmeIO5is9/nItuBGJrf2/8TnUPUa
         NylrZTutjP8Q2ZOoj+Izz8DzHh9uFneCkJ/bQBEvCEiWTolxIVdLrwj04Q/qh4BM09BO
         pS5w==
X-Gm-Message-State: AOJu0YzgF0xMn+H9Dc3QAfajjD6py4//7LJjjbVJsgl7BpaPt7yeOjFn
	li0oGQ6Sn1H8jOXlr8qCPWNb4Vb/h22XCRIFNgQ2HjrnzUW4KChQqR8YujnG/MLFUpqdJdgPMNU
	=
X-Google-Smtp-Source: AGHT+IEL8EeqjXGKnI2KncPi7o/G5IO31HRun/QLglRKuR8M7W/O46saGPqSJa4F/E0wOxYU4LYOCg==
X-Received: by 2002:a05:6a20:d489:b0:1c6:ed5e:241 with SMTP id adf61e73a8af0-1c89fce032amr8288123637.15.1723318811142;
        Sat, 10 Aug 2024 12:40:11 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([42.104.124.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a437b7sm1541513b3a.128.2024.08.10.12.40.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2024 12:40:09 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hong``guang.gao@broadcom.com>
Subject: [PATCH for-next 2/4] RDMA/bnxt_re: Get the WQE index from slot index while completing the WQEs
Date: Sat, 10 Aug 2024 12:19:11 -0700
Message-Id: <1723317553-13002-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723317553-13002-1-git-send-email-selvin.xavier@broadcom.com>
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

Signed-off-by: Hongguang Gao <hong``guang.gao@broadcom.com>
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


