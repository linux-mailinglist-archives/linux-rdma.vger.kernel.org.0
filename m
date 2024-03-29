Return-Path: <linux-rdma+bounces-1680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E586889201E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1633288C67
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5A14BF94;
	Fri, 29 Mar 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI/hul7W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061C914BF8E
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724165; cv=none; b=vBr/fhnGXxhJA2IKuoDKao2SiqOf9mQdKKVGWaBpfzbt712QuiYpIK9ShQ+qp6d66vVgEt8r50j8Oc1n3vr21aPJ1vBKTVqTKXr2zWdzuedz+ujZGX4Ptt0BKP4s1k0xevnZDJ3FFOwuDRr3ENb24O6JcBfNEN0wKSkd41vyXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724165; c=relaxed/simple;
	bh=UZ1/DCPLtR3mduOS71FDyDDnkpBv8+SGmdEPh7DHYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWxV5zCaTlMveLruqMj4IAy5GmXOAUo0U8tzTurMg+Oeb/6QZ2qpd+fOtRYaAv4b3ZdOHHXy6o0VbTsnkK0aeHwjHK0ZxJCimWhl43C92i+XCjmh3sUJFU1TuGmxWkNagcVnZ/8icXTD9pb6J+dnjuoBoViqmyIcstqKG+DAyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI/hul7W; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22a353217c3so1051808fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724163; x=1712328963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iLVySYmuqx2nSAqtlxR4y9KeR6C9kAhC4jpyCkS8UA=;
        b=bI/hul7WlnCeMh38IGlEhpktQK45g3NhdBWuPnvn/XnIqFj5po7B52zUIyXMCs4iBM
         lb/YnnAUv8Iwa92t+jwPfTwcUIoEK8QOgoS0FewaPYSLSYHqHMOp4oBz1E9+W98fGn8T
         ROep4GKuygFVtnPSWtFLSmcUEscGJc2QqVrc3TabKhZKoo2cAbjAYt52LpQNd0Vrvx7C
         zqDLFKlIDWvUq+ygvSLlCra9DoIShBDp1oFml2e5zW0PAVQaFl5M6kKYLx+nLABclTzW
         IFSrCmtSZU0DjTFmSWfx0HaHSCLbU1qbj9EtRDXz+EaLGQD7djWW/ConMIXoD4ANvy1G
         lJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724163; x=1712328963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iLVySYmuqx2nSAqtlxR4y9KeR6C9kAhC4jpyCkS8UA=;
        b=j9ceVq0XIrAE3g/pngfV+Kn7YXZg75Jmc83kRrF+AnSwgqQwV1GhRf4iqhfgBUQPrt
         jtvsto7BPIfcec/MDRrOHMShxDs8kqJhfb3q4VSxRbgAbWVmcDyiq/K0EqFuIlloqYY3
         D/aK/4djbcV45mFY0gnQ9hNgJ3ZqyLsOyenYrCPPB2pPh5Amaxt3qsCwfGSFcmWPpfEZ
         99F+fBg2US2ZEqZx4ZhruUD3+jyfgXTRBs01TSF9WbwyqLQH812N4+kg7hhY/b5N4OKZ
         DGugtF7bo5+xPSct7GS9cAoeFpBxojGeE3TzDuiRmeyd3raL7aTPeKXjQx9BS5r4qnjt
         Zqbw==
X-Forwarded-Encrypted: i=1; AJvYcCWjnDIrQ3uR3s7rVVtrQjt5vI2cw1tN7393ZTMIpduy41tXs9RrCsKCud9DcyAft2H4VAVi90ofiz71rg8FkzMjYeQUzQYJwI8Asw==
X-Gm-Message-State: AOJu0YxaS+ewg/7E8heConLyB3CCWsh5K6Dvv05idWzzeYW3DikW+Q7Q
	ScCRV/922mz9nnJklGVtsgdpbPS+0/WUP7Z5Pq4pi41X62PZjZUB
X-Google-Smtp-Source: AGHT+IGskac9aMgj8cz83DlVRuK9sAHuazojSv622gQgjVGhAsOLb8AfqFhFGZZ6VxBM14KHStHo1Q==
X-Received: by 2002:a05:6870:e394:b0:229:800f:3ed6 with SMTP id x20-20020a056870e39400b00229800f3ed6mr2699803oad.36.1711724163232;
        Fri, 29 Mar 2024 07:56:03 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:56:02 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 11/12] RDMA/rxe: Get rid of pkt resend on err
Date: Fri, 29 Mar 2024 09:55:14 -0500
Message-ID: <20240329145513.35381-14-rpearsonhpe@gmail.com>
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

Currently the rxe_driver detects packet drops by ip_local_out()
which occur before the packet is sent on the wire and attempts to
resend them. This is redundant with the usual retry mechanism which
covers packets that get dropped in transit to or from the remote node.

The way this is implemented is not robust since it sets need_req_skb
and waits for the number of local skbs outstanding for this qp to
drop below a low water mark. This is racy since the skb may
be sent to the destructor before the requester can set the
need_req_skb flag. This will cause a deadlock in the send path for
that qp.

This patch removes this mechanism since the normal retry path will
correct the error and resend the packet and it makes no difference
if the packet is dropped locally or later.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c |  7 +------
 drivers/infiniband/sw/rxe/rxe_req.c | 14 ++------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index d081409450a4..b58eab75df97 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -371,12 +371,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	else
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 
-	if (unlikely(net_xmit_eval(err))) {
-		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
-		return -EAGAIN;
-	}
-
-	return 0;
+	return err;
 }
 
 /* fix up a send packet to match the packets
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 34c55dee0774..cd14c4c2dff9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -802,18 +802,8 @@ int rxe_requester(struct rxe_qp *qp)
 
 	err = rxe_xmit_packet(qp, &pkt, skb);
 	if (err) {
-		if (err != -EAGAIN) {
-			wqe->status = IB_WC_LOC_QP_OP_ERR;
-			goto err;
-		}
-
-		/* force a delay until the dropped packet is freed and
-		 * the send queue is drained below the low water mark
-		 */
-		qp->need_req_skb = 1;
-
-		rxe_sched_task(&qp->send_task);
-		goto exit;
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		goto err;
 	}
 
 	update_wqe_state(qp, wqe, &pkt);
-- 
2.43.0


