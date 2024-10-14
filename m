Return-Path: <linux-rdma+bounces-5397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8AD99CC09
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AEA1C2322F
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2601AAE1A;
	Mon, 14 Oct 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MDq2xkvh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFED1AAE32
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914231; cv=none; b=Wff7BpfFpUgD/BXeu2IwJ6DuLIeL9acQqjqx6LvzEuNNCY0weAdcvAWHCQXARTe9vLh9eZ9M598YvAC8jsXiPZ3DNRX1PHE4Yna9vFtjHgTGYRClnfC4WDLiVhZANJmQDg49J06BB3aVXJ7F5AD8Syy3Xo3sb9vkD6dcHZqyc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914231; c=relaxed/simple;
	bh=9AFS5UoEBlRDR5rVubBsxWWmdKHez4Fh5V0d4S0CvZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kIrVpoyNznT6lT1hDmxA0u3Ldzzv6cDfX20wxUG3+alLVbFMbdbd2nSPzijt9gTe2mGkwfW+4qjj0yCr2OSufw8sutSPH9GcJpKceWI0KOLL3BVXoOxMO4aoAafEd4KIWWWvPQTXtfKiGjqcGb+3vnKYmcHW0kTLm6TMytDCKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MDq2xkvh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ceb8bd22fso7655025ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728914229; x=1729519029; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Q47Wwlt1a6dXlWE+83kDPV60KfmHLzrqSfAEX3qqyc=;
        b=MDq2xkvhgMh4M2vXPAsyZNiYMPCZhKuy7LCjAD45GCYAKANBRGlUW7UgdRaXfeTa2m
         H9l3tFI7pVYLOMNA537qzuV2BhSbUtNExZxhnB0SpSfrkEB1QgrFowC6q4UD7DkcjUgD
         N3iRs647VQIDnHaJrFNNxQUDsh7eq0lmK4iNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914229; x=1729519029;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q47Wwlt1a6dXlWE+83kDPV60KfmHLzrqSfAEX3qqyc=;
        b=dQR9t0ahupFQyOSuY0nlI4iR8JWAxZUkIhyGoNQNjQSA5T+Oo0sS8EmnVgPlS4bKj9
         I38v9nRXQFyGm47M8Wx36I4vl1oVQqgQfgPztxKTK3g7Y8dOrjp8Hgk3WiegIPCaecOK
         VK/R+vKQ4VbU9b0SzdSXoGLDA13uZ/gON+sAhOzYIKCSrIt6pVS+c3ca2DVQVoz8+oIn
         y+gaNK9x2ZICwm6KhxZpgWqUAlofVDMsaWmVL1Hst7n9ogVJbeZpB/Xx5KtEUSWX6Xvh
         oTkGJ4j6CLLSsWAT7hZMVgErUpZCPQg+sqc7w2D0O0BBpsCTsk0fRcuFZm8hlUyNGPgH
         7Isg==
X-Gm-Message-State: AOJu0YzPNK9S5c4CQrUGceMDra7EHlGc3yeBW2elWw/LxmvNw5hZdhkx
	fBu+g97OTEmbm1xR97X5qT8EF7XVQBlIka48YniC48WSr0RPprkom+mEit8uJQ==
X-Google-Smtp-Source: AGHT+IHUupcfT45Q7nQ+rFEQvzhjXzi2SO0Lcxck1DSzA6f/wcmsZtO4eQtXotaAGJSxl8KdBIM5pQ==
X-Received: by 2002:a17:902:f68a:b0:20c:f6c5:7f76 with SMTP id d9443c01a7336-20cf6c57fd9mr33905545ad.6.1728914229432;
        Mon, 14 Oct 2024 06:57:09 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c35697dsm66129525ad.297.2024.10.14.06.57.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:57:08 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc v3 1/2] RDMA/bnxt_re: Fix the usage of control path spin locks
Date: Mon, 14 Oct 2024 06:36:14 -0700
Message-Id: <1728912975-19346-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728912975-19346-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Control path completion processing always runs in
tasklet context. To synchronize with the posting
thread, there is no need to use the irq variant of
spin lock. Use spin_lock_bh instead.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 7294221..ca26b88 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -290,7 +290,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct bnxt_qplib_hwq *hwq;
 	u32 sw_prod, cmdq_prod;
 	struct pci_dev *pdev;
-	unsigned long flags;
 	u16 cookie;
 	u8 *preq;
 
@@ -301,7 +300,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	/* Cmdq are in 16-byte units, each request can consume 1 or more
 	 * cmdqe
 	 */
-	spin_lock_irqsave(&hwq->lock, flags);
+	spin_lock_bh(&hwq->lock);
 	required_slots = bnxt_qplib_get_cmd_slots(msg->req);
 	free_slots = HWQ_FREE_SLOTS(hwq);
 	cookie = cmdq->seq_num & RCFW_MAX_COOKIE_VALUE;
@@ -311,7 +310,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 		dev_info_ratelimited(&pdev->dev,
 				     "CMDQ is full req/free %d/%d!",
 				     required_slots, free_slots);
-		spin_unlock_irqrestore(&hwq->lock, flags);
+		spin_unlock_bh(&hwq->lock);
 		return -EAGAIN;
 	}
 	if (msg->block)
@@ -367,7 +366,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	wmb();
 	writel(cmdq_prod, cmdq->cmdq_mbox.prod);
 	writel(RCFW_CMDQ_TRIG_VAL, cmdq->cmdq_mbox.db);
-	spin_unlock_irqrestore(&hwq->lock, flags);
+	spin_unlock_bh(&hwq->lock);
 	/* Return the CREQ response pointer */
 	return 0;
 }
@@ -486,7 +485,6 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	struct bnxt_qplib_crsqe *crsqe;
-	unsigned long flags;
 	u16 cookie;
 	int rc;
 	u8 opcode;
@@ -512,12 +510,12 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		rc = __poll_for_resp(rcfw, cookie);
 
 	if (rc) {
-		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
+		spin_lock_bh(&rcfw->cmdq.hwq.lock);
 		crsqe = &rcfw->crsqe_tbl[cookie];
 		crsqe->is_waiter_alive = false;
 		if (rc == -ENODEV)
 			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
-		spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
+		spin_unlock_bh(&rcfw->cmdq.hwq.lock);
 		return -ETIMEDOUT;
 	}
 
@@ -628,7 +626,6 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cookie, blocked = 0;
 	bool is_waiter_alive;
 	struct pci_dev *pdev;
-	unsigned long flags;
 	u32 wait_cmds = 0;
 	int rc = 0;
 
@@ -659,8 +656,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		 *
 		 */
 
-		spin_lock_irqsave_nested(&hwq->lock, flags,
-					 SINGLE_DEPTH_NESTING);
+		spin_lock_nested(&hwq->lock, SINGLE_DEPTH_NESTING);
 		cookie = le16_to_cpu(qp_event->cookie);
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
 		cookie &= RCFW_MAX_COOKIE_VALUE;
@@ -672,7 +668,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			dev_info(&pdev->dev,
 				 "rcfw timedout: cookie = %#x, free_slots = %d",
 				 cookie, crsqe->free_slots);
-			spin_unlock_irqrestore(&hwq->lock, flags);
+			spin_unlock(&hwq->lock);
 			return rc;
 		}
 
@@ -720,7 +716,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 			__destroy_timedout_ah(rcfw,
 					      (struct creq_create_ah_resp *)
 					      qp_event);
-		spin_unlock_irqrestore(&hwq->lock, flags);
+		spin_unlock(&hwq->lock);
 	}
 	*num_wait += wait_cmds;
 	return rc;
@@ -734,12 +730,11 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	u32 type, budget = CREQ_ENTRY_POLL_BUDGET;
 	struct bnxt_qplib_hwq *hwq = &creq->hwq;
 	struct creq_base *creqe;
-	unsigned long flags;
 	u32 num_wakeup = 0;
 	u32 hw_polled = 0;
 
 	/* Service the CREQ until budget is over */
-	spin_lock_irqsave(&hwq->lock, flags);
+	spin_lock_bh(&hwq->lock);
 	while (budget > 0) {
 		creqe = bnxt_qplib_get_qe(hwq, hwq->cons, NULL);
 		if (!CREQ_CMP_VALID(creqe, creq->creq_db.dbinfo.flags))
@@ -782,7 +777,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	if (hw_polled)
 		bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo,
 				      rcfw->res->cctx, true);
-	spin_unlock_irqrestore(&hwq->lock, flags);
+	spin_unlock_bh(&hwq->lock);
 	if (num_wakeup)
 		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
-- 
2.5.5


