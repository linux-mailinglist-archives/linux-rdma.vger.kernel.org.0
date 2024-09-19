Return-Path: <linux-rdma+bounces-4994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AAE97C324
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 05:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481EEB20E6D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD54125A9;
	Thu, 19 Sep 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LHFRSIS8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3472F28
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716425; cv=none; b=QYWGC1YNG9GF1uhLQPy195LEE7yGSP7UDMWtcByI+VKS/R9K34mDFZAQBl65xrkBZ9wh/eK4LpREIR+nkZlmuRyNNr+iepMFxZ/x9MnDM7jALlPa5dFxVOBqWNhLKkQ2XxHmmPajpkpIKzrkdYVJUSSfHoVqOL+HdLy/Kcw2nKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716425; c=relaxed/simple;
	bh=7XPNX3fmyCYlnzLWIzzORE/WQptsVAlPRa3b9shmw1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OLLXuk22CmILvDbudzXZ7DWeDqkFM91PGi95q3cHs3h4nSlDuS/Lf7UoVcy3PK6mp69QVMK4lI0lTxTnU5nNbCugu28fRjrUxhsk+3ZVPjVtFiFqylq7/G7+Dwlo0XsqcEwDXYA5/nRwyOvZAl7ShyKC5a7AjK9t0//i+xKQjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LHFRSIS8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so235023b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Sep 2024 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726716423; x=1727321223; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSkJDWnJKIbCs5q7SLBq9WfPGFHGoHkAEjyRoOKqySk=;
        b=LHFRSIS8zaOuUi2bVpkg0RovpedNMQs3hLnhxlhnudP+UFg2pgy0S92F95bkmj8Iv+
         VH0dCHoqcJVYll2QcFHSqv81htWhiSc68gBEVWgjQZtjhFH75F0Gl0z/Q3K/votUKLAX
         IguOVc/sHy4WgBTTag83qrYmopUXPPZcJGFdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716423; x=1727321223;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSkJDWnJKIbCs5q7SLBq9WfPGFHGoHkAEjyRoOKqySk=;
        b=m+nguEk7yV8Iwvoy5LzYUT/iLiLGyliWm7LyOHlx3rVWKVDRUHcZP1AU5OXzS8ggSK
         3aMEB1uX2eUcT0XOLKRPikKdKcbs9xRoXHNdBo9xCsh439jYwz5E8ib+QhIUIZGQXVFN
         mz5dTM48LrPVQpdgX0IErP9ck91HcQqmJMmmqv3t1A6/Hp87BlbRm7bayt1MffxCRAKE
         16kNHFzwRIEBwy3EnRxjUGkHCzjpMdMA9sJtns5mItEUVIH1mL+haeUwn+tcihGyZSnO
         feIsx1aC57boPpicOaWHEsFR95/hXKaV+PlzpQIXMyl6wO2nwMQf0S3YUiVKTMGY31Qn
         HVlA==
X-Gm-Message-State: AOJu0YwcixW9lUVHX0PlcMm2mwmgnynyBWo4cLvI4eclIsyXdpikVSLb
	3COkQgmzzm5njK8HEeU5c7kbvt9JWpw8mrl+gxXReU37ftLn2ZYgXHDifJByT12kBlVl7S5mkwk
	=
X-Google-Smtp-Source: AGHT+IG7OxCLwHnoKrrSqSq5br2Wq5Tglio3xYdKoCuf9j57DiVtO1hkeS+XieqaU8KRKZkEHLMkIg==
X-Received: by 2002:a05:6a00:2d05:b0:714:1bcf:3d93 with SMTP id d2e1a72fcca58-719260562d7mr35172042b3a.5.1726716422864;
        Wed, 18 Sep 2024 20:27:02 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a980b4sm7400686b3a.34.2024.09.18.20.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:27:02 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-rc 4/6] RDMA/bnxt_re: Fix the usage of control path spin locks
Date: Wed, 18 Sep 2024 20:05:59 -0700
Message-Id: <1726715161-18941-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
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
index 3ffaef0c..5bef9b4 100644
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


