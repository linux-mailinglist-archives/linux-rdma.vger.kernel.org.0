Return-Path: <linux-rdma+bounces-1674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE18A892099
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A8B34449
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144414B09B;
	Fri, 29 Mar 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD81rSuJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A614B091
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724159; cv=none; b=M25a83I4Qb3qZrZh4S3QAHhbvpbTf+ZGZKZQ7Pn0A/Rdfd0VUJDo/cIH21ExR/vHNBAx1GptqXNVwDPrf5Sv6d0D1Mp4RovMKojZkr2T3M6K7AW82J9xFy1s4o/pMNbTDbg2xeJoAq/cbHtWIy/fQaAllC4IuMS1+TOvlfMpTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724159; c=relaxed/simple;
	bh=XIImzMuwSkGxY8LRL32oWi/vfkg7DtdUs916utrYrLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka0OT8offggmLQKv2lrSZqDFnbXCvYI/hPSByb1BvJ3DOdvr+fEAduGTyF+7ePvOCUbGlnyRrPlTvDi6tib6Fgb3UG7/mvWnLrEFHmp/IhZ5ajrBF4DLF8tHMgr3D2qJ0mgQ9iwiCOnZ7uWD3grSszmnqIeE4Rj8Cg48AsXPCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD81rSuJ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-221822a7dc7so914232fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724157; x=1712328957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=QD81rSuJqsVTfMm6X2YSqo6Ua7oQBw4B7qjNKgdDeAQK6WuUJJ/Lq3Q2TY6voP7cxh
         e2qAOW3g35T6U6niNlH6A9DLAotyInLwqDSDOcGPH0YR0QQXwUHFky2Gzde/5XnRCf9z
         yfqSrivCPDQlN1ZI0q+QmkZ2Sq35/MEaWNZnwhZK2nLWEJq9xFhRA3bSwLNwU7f+mW4Y
         tz+DUwp+QeYuUPpChkm+c7arXBQMb89tI0+X2xHUu0gmS47vcaXXeS6kouoI+9TdR/CK
         wb1IJ0vbO10jm5SMIajFdJOWl+0qyQQSuMYv3hNKMH3/TQujhjXV0Eq/L7bv6kzXzR8p
         v7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724157; x=1712328957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs13IV4o1jDjBU3SuR7/cEsZjlsaAJ4yfEzh55jmKHc=;
        b=I9x47eS3BmaCrZeY5qGqR4GUlxSpfIIYIzaM/Nayr0URIFRH6A1ziaMf0jMGU3OeOM
         JqtHpngKeu3RHLWyNqIEeX+QlN7IhUBk+TJFnJl6kZpuUjeZIMItUIqn4UuLUgOqGCAg
         ov3VX3+ZZxHjEbiCyJY4Nb0beehxbVvkhfMwOEzKON0pdNiC0ZqSxRrNqI0lt8XPHpDh
         5xseh0/guZAjucwXuu/L6Mx4VkHd0kv1tlIefwA1FtwbJnIluSaqddk3Q4UjzslSt37t
         dt2ICrTF17/WYsaAtXdHy45Y1PvHQWx45yEeZC8DGT1bp1VvEQhtGNKkYpw13BlZN2LH
         joNw==
X-Forwarded-Encrypted: i=1; AJvYcCUpkFwrB5nJ6QXW3thNDtlUmijCxpb5gAuLazc/2h0t4KviT65eVktyYoz7vtW4Hgo2bQekxUq2//N0MO6+O8xmkxZ56IxLbdsl9Q==
X-Gm-Message-State: AOJu0YwCDGcbBi7xJSiikIHo19GFGobyf/4dMjTOm4Mi9iGf1RjV+Ogm
	PWBJ8OeThV/ASb9Nppdh2X42y+8mGGm9gybJG3tTrlPxCyIs1uwo66wGOaZQLGw=
X-Google-Smtp-Source: AGHT+IHhauMxhn55RvcmIkpehXMENQlbJtbC2+Gf+1A6OJYgZKTTefWdpyZy72vAqgHreF/V7HaxfQ==
X-Received: by 2002:a05:6870:2f08:b0:222:619f:950f with SMTP id qj8-20020a0568702f0800b00222619f950fmr2346248oab.41.1711724156930;
        Fri, 29 Mar 2024 07:55:56 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:56 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 05/12] RDMA/rxe: Remove save/rollback_state in rxe_requester
Date: Fri, 29 Mar 2024 09:55:08 -0500
Message-ID: <20240329145513.35381-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
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


