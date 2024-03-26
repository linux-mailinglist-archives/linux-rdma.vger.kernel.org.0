Return-Path: <linux-rdma+bounces-1572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA9488CB2C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BA0B24C53
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0561F95A;
	Tue, 26 Mar 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V75IM9Q+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7841F944
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475080; cv=none; b=YpmHb0lUoqoT3phBKYrAxq1h5JFNp0FcQQu+ljgUy5JnWf48Q+UaujteNjeMUC1ZyKLKsXCO1IyHu9W+l1YxLj8mEi/zgmJyD0GwIsG8OdWvQXU+2qKs8ma6XNLM4Wg9MXDo3BRQ+uOjYf/7pGzn/Zz+wFm8sbOxlP7cgEAmLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475080; c=relaxed/simple;
	bh=XIImzMuwSkGxY8LRL32oWi/vfkg7DtdUs916utrYrLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bllZ8Ai91dt5ScD07jbxXJS6teSgLZ7cFQefQakw04oRdG2n28mqn+g0150DHATQxeDqCQ16NGWcHFW2EsJ6MVL2ZbDovEDMucBfzRc5v1Gvw0wsTA7nZ3e2Nn6ULTm7m/mk6f0VgCAg4beRXWLCkIyHMNuvOr3JgBbXGSUA4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V75IM9Q+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a51c063f99so1777711eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475077; x=1712079877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=V75IM9Q+kJZhp0W/sTkGAufOFWAhhE/QCksRYf/SZjAmPnx3XOhl0IdRkHQFGDkC5D
         xND3Bt+XGKPwwCwWp2oZH3tCmP3CAczS/kLTwBp7AxoR+KF22SrvZpT7WOeS8qx0RFSR
         r7rhZG0s5HjwsxOxdJOPRcI2hhRBG2YmoS+mwc0aCbsgIeX7Rs9rTa6NVgAgwvHba1c6
         AKxdPjN/tgIgrzguGDY7sEb1CJYfKGrHPc/GHjRGNzPSXJ98aFzR8boCbRHIbFMTT8GA
         1rCQnWXdmPmHyE9EwRRTsKaxpm+RxUHZ9orZQbFeWPiaP2/5+ODssLO2Ignr08nAVYOO
         JbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475077; x=1712079877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=LPDczKEl3VS2eIawFG0QjeAI/7spJJDnas5WRu98SfBWMrFMWP3zbBG/R6sHHusR0w
         OxyLwQ5QfwI37ce4SSe8Zzof6jUNixJGo3kVJ6zc4zfXmGyzOw6jn+B2uC/Tj+hbAkvk
         2b+qLtUVirgmDA7cWFd+kyEEmVTS5CjBUvsdFuNRWBlHDMVUvpjQHJyDfN9N32sYmFFM
         bgGvDOX/24YKEqP29J4xaOjPmkuFh9JLX6+j3QzADC1/efdTpq3VRnDU1YkvdPcUw8XW
         0KUWVdstLlgzj9wlBwgHyoxv5sL+nT00MqMXGRHlCThU5msEVPUTXKy0IW3SWn7xNmsJ
         WeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUK64pTfCzr6a1UDTPii7mhv19XxCaLaOJ6+U5HnTCllePxGetqgXmaAIKxgaoOsbiu8iwmek7QSQu+RjkUI2OCS+gbRgF0k/wg==
X-Gm-Message-State: AOJu0Yx9IWQ/YSPsXRrjJTdqcHO5nV0HIwUQBY5TQMa5Jp/499SyjYKK
	VRslQ4UxE4HESt4nKaL7dDnBzGyXt360i5BAmnqNbHIWQg9tqekv
X-Google-Smtp-Source: AGHT+IEr2DF0Z0sMKysZRWzPaY+qSNqLNUz/8hxSJ9ZPWB5j+Fjf+nxMrJ8RhxmPMHHDMddRGDzyYA==
X-Received: by 2002:a05:6820:1e01:b0:5a4:95e6:f15c with SMTP id dh1-20020a0568201e0100b005a495e6f15cmr621581oob.5.1711475077718;
        Tue, 26 Mar 2024 10:44:37 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:37 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 05/11] RDMA/rxe: Remove save/rollback_state in rxe_requester
Date: Tue, 26 Mar 2024 12:43:20 -0500
Message-ID: <20240326174325.300849-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that req.task and comp.task are merged it is no longer
necessary to call save_state() before calling rxe_xmit_pkt() and
rollback_state() if rxe_xmit_pkt() fails. This was done
originally to prevent races between rxe_completer() and
rxe_requester() which now cannot happen.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 40 ++---------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 31a611ced3c5..e20462c3040d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -573,30 +573,6 @@ static void update_wqe_psn(struct rxe_qp *qp,
 		qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
 }
 
-static void save_state(struct rxe_send_wqe *wqe,
-		       struct rxe_qp *qp,
-		       struct rxe_send_wqe *rollback_wqe,
-		       u32 *rollback_psn)
-{
-	rollback_wqe->state = wqe->state;
-	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn = wqe->last_psn;
-	rollback_wqe->dma = wqe->dma;
-	*rollback_psn = qp->req.psn;
-}
-
-static void rollback_state(struct rxe_send_wqe *wqe,
-			   struct rxe_qp *qp,
-			   struct rxe_send_wqe *rollback_wqe,
-			   u32 rollback_psn)
-{
-	wqe->state = rollback_wqe->state;
-	wqe->first_psn = rollback_wqe->first_psn;
-	wqe->last_psn = rollback_wqe->last_psn;
-	wqe->dma = rollback_wqe->dma;
-	qp->req.psn = rollback_psn;
-}
-
 static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	qp->req.opcode = pkt->opcode;
@@ -676,8 +652,6 @@ int rxe_requester(struct rxe_qp *qp)
 	int opcode;
 	int err;
 	int ret;
-	struct rxe_send_wqe rollback_wqe;
-	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
 	struct rxe_ah *ah;
 	struct rxe_av *av;
@@ -799,9 +773,6 @@ int rxe_requester(struct rxe_qp *qp)
 	pkt.mask = rxe_opcode[opcode].mask;
 	pkt.wqe = wqe;
 
-	/* save wqe state before we build and send packet */
-	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
-
 	av = rxe_get_av(&pkt, &ah);
 	if (unlikely(!av)) {
 		rxe_dbg_qp(qp, "Failed no address vector\n");
@@ -834,10 +805,6 @@ int rxe_requester(struct rxe_qp *qp)
 	if (ah)
 		rxe_put(ah);
 
-	/* update wqe state as though we had sent it */
-	update_wqe_state(qp, wqe, &pkt);
-	update_wqe_psn(qp, wqe, &pkt, payload);
-
 	err = rxe_xmit_packet(qp, &pkt, skb);
 	if (err) {
 		if (err != -EAGAIN) {
@@ -845,11 +812,6 @@ int rxe_requester(struct rxe_qp *qp)
 			goto err;
 		}
 
-		/* the packet was dropped so reset wqe to the state
-		 * before we sent it so we can try to resend
-		 */
-		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
-
 		/* force a delay until the dropped packet is freed and
 		 * the send queue is drained below the low water mark
 		 */
@@ -859,6 +821,8 @@ int rxe_requester(struct rxe_qp *qp)
 		goto exit;
 	}
 
+	update_wqe_state(qp, wqe, &pkt);
+	update_wqe_psn(qp, wqe, &pkt, payload);
 	update_state(qp, &pkt);
 
 	/* A non-zero return value will cause rxe_do_task to
-- 
2.43.0


