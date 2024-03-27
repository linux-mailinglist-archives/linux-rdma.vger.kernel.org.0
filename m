Return-Path: <linux-rdma+bounces-1597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18D88EA0E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F8F28F6CE
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641012FF69;
	Wed, 27 Mar 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSlCBUhP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D412FB1D
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555065; cv=none; b=OwbcRBfzV64clvmzcPPEL/j3gwxMjHcCfhGd+sj2PmON83YI7ToVlP5muGzQYEd21dv1NzPC632qZlBE5oC57mgqe4PtpBIMpeSMSOawNfJBeg9ya1tlbZ6xJnf7qOILFWc6DPR6dDcfnuZ9elYkB23LwYo5/a8vQlw0LfqmjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555065; c=relaxed/simple;
	bh=XIImzMuwSkGxY8LRL32oWi/vfkg7DtdUs916utrYrLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgrYslu22TuEWXWAf8WAk1OAxMqWAG2geRs+wpWSiXzQ3QgA0qQoN8tTp2n+SAx7ap8pdGEGlyttAhIR/na6qlpbH0ha10TYQT+5YOwW6dBkD8UHi9KLWR7mrafQBWjZh3R1MuImui8DT7x8ICT4yRZrv79vD8eWCpj4a1sJqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSlCBUhP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e673ffbd79so3920059a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555063; x=1712159863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=ZSlCBUhPiySXYLBmDsgKLy8V8pBROPo2EkkLByvQJxfogsFNzpCfKh8W+ClieSL/AC
         689a/hS5+FclA7uAqp2fmCynOvXXrf+xtgFBYLZ0Ku6fnxIfr5aU88YwyWKL4LyDOpho
         Erg8hiCGFj8ELG7iQ3x9e/MUSS+hIq5/qECzO8Hnep7XSX0f4saD9fyD5oTweW0UsgTo
         84obOh0rOx4LL112sJLjVexVQR+XtXQhELpEyTA1c4RbhSA6CGCQTAnvgVuldGtfd8NY
         Y+6EvMdt28CFx7N5DZuDP1qtoBXOJ5B4b2dGQDPawF/YKX4fNsH2Du9NLAjkBzmfza6h
         SBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555063; x=1712159863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=ehSmZJmGOzvyop2dYJPfoliM77pnswNXLtuKvV5N49R9PC1j1Yp6avC0O+FN9wUWmJ
         0JbJWbAV3WfL2oExcYVk9B2g/GDX7fHUmCKjIEgn6z1db8dY0Q/HlqyMsFxgIBF5u8hB
         OmckJmFGlzUtXbjpiShNfXwIU6yaATBXRxjNrB5/e/g3W50VTbKeK9V4cG/kqVGYRuAj
         ITUTsARlDMWk7geu1T0fhbQjlRLSAjNk3ElU1T3ou6m/KlJHguRXPzjG8ojhuJnCXmJn
         T31hMJKNIqPLf9nLvysA2RJ57RmqN4hLIfja603iDF4gs/q2FV/DSqYdzSuas9AYeUKK
         SDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl88zlIIoROiay9q6wEXbWU/aeqKWMSZbUAnaZhLNoHkohXwlNQpp+KuVjtk/mCSbeiBjlngrJwMkFF45DGsdsLGOfnGhPuxHqxA==
X-Gm-Message-State: AOJu0Ywukz6kjJBC7cdYjEBQ8jQWRLuZP3WmH3bTGU0xC5wzUee1/7xC
	ztghoUMYgWXUs14NqM0k3GHhQAKo6o58m4CmfqYDPiBFtag6n/n5
X-Google-Smtp-Source: AGHT+IHitvDh2N5HNCgmVFZ/RWG6yvwvgJ1tnIe0Iee4t1bGWAJwAY2qTobeo+zyOzc/V16LoWYKfw==
X-Received: by 2002:a05:6830:204b:b0:6e6:b2c4:3b9d with SMTP id f11-20020a056830204b00b006e6b2c43b9dmr368440otp.30.1711555063474;
        Wed, 27 Mar 2024 08:57:43 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:43 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/12] RDMA/rxe: Remove save/rollback_state in rxe_requester
Date: Wed, 27 Mar 2024 10:51:51 -0500
Message-ID: <20240327155157.590886-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155157.590886-2-rpearsonhpe@gmail.com>
References: <20240327155157.590886-2-rpearsonhpe@gmail.com>
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


