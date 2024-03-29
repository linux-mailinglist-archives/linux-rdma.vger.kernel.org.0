Return-Path: <linux-rdma+bounces-1677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC889201B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AECD1C26313
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB81414BF92;
	Fri, 29 Mar 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV1RoVkK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2E14B08A
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724162; cv=none; b=JvorylgnRchC/c3S2q0xjpnVzEjjtlaNZFAnr2SKSwjVRMepuSWkWjHPTuRSGHtY7+HZjjmLMwRRG1yqpOuYm5j9VMHjjciTToDTTHn/m0FlUSCVtQ+pXPJRrhnGoLhV0Xb2WF+aZYA+NojvMaOLu8/zkI10mNqbkioyP+TDe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724162; c=relaxed/simple;
	bh=PT3Hyfl2+cjTVzOKRQDvmFYUsqsoFkkSrYuXVUTmopA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8xNW7WKZNyfUoLlJ//NyFqQE4oWS3p3fDwOkEyJcGaw6c3lhA1YjPLYcg76ZYi67meYrX1zq3PwII59phAJBQ+F1ETDyYyAEG01pH6Vx602XkYSnYqqpUt+8CTABNxrO4vVtnxJAAPzLjEuGYkVoyM0FOqEXotDTmQmvsaJJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV1RoVkK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e673ffbd79so1187289a34.2
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724160; x=1712328960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gozE0JJHyUjE/6EGOn8n1lFvwBFFZIhulDryp2rMcl0=;
        b=RV1RoVkKPFjfDhj46tnnMKfGmAfAK7I3VcDyK2pSq9bpknf4O1lM7LFSgVJPxdSOxN
         uEei9danvYngfqpl95zth61M/UQnSX7O5/fBPzbUJKN6eKGH40w+0tx4mbTkKgEHrBQ6
         koYtWHvUmDRVmmBNrPCYDhbBh89gVfNsmPaA5XcVMdrALFUKpuUFmUot4f6aU2rh5e20
         UgeK08U1tF6rQfQsc4WBD22I31LJE74Z/XIHZAwlzC2dCG1ZpLwWQbMseh5qC589Ujir
         u4mX4XHLcbnywVWfOZY0cmcN4TjYeTgdfq1mXMjLjjfz54pwQq6pfsl+drLoCR4gs6xf
         JIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724160; x=1712328960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gozE0JJHyUjE/6EGOn8n1lFvwBFFZIhulDryp2rMcl0=;
        b=Qt6nRQV0Szq1yDpbiN7Ai5glSiW4V7odod1PTq5afJPwt3o/NsVtYa+uCN6JFP+M2T
         32AwYm+rTpf2GAuL7D4Go0Abcy7ZtOkeOTVCGIIVKD5kxkGpeep3p+jISfQuX/+F/Vq6
         62GlKN6Zxwm/airiZJVL0t5NvpFktvwpn7uBtoPSPWrtt4WXPXo0UkBBX/LiM0P/6TCI
         m+43VeRPevkznNIHWJ1xu9gfQvOMM0rJO/VxCDXyd3vvcWdwrAkaJCr4yvoodh2/P6Rm
         IKIxyl+JSwoMUGDgYBB9qtt4yeYQf3Oi0lUZQ5vyBLmN1G2Up8tG5tPMoEvDbF79o0/0
         DHuA==
X-Forwarded-Encrypted: i=1; AJvYcCWi9FOGhm8rMcWJpZmW2lvCbxYmPyezI/9ajhdVdh0FiT8wG8gTHoAOaQWPkzpVVEvbfM/kyBd19V+lLmpuHK+PIOReSI30gkeA+g==
X-Gm-Message-State: AOJu0YwMZF/GQ9dYDBvUMMzTlZ1Ez2cFVsjPZi4SRXazRtg6IlUuRbm/
	y+lOMm/tlizUssNHBGXTaI1syz6JDm0UhKpDbp/hbeO0viDDOcR2hBFNCvKPKeE=
X-Google-Smtp-Source: AGHT+IEpVm1xPMmRSMNFtP2iitIXjDd93xaV9t14C+VxX2f/q573l7oT8hi+gQ9k8tU1+4wIbtgksQ==
X-Received: by 2002:a05:6870:a1a0:b0:22a:a17d:e19 with SMTP id a32-20020a056870a1a000b0022aa17d0e19mr2692331oaf.15.1711724160072;
        Fri, 29 Mar 2024 07:56:00 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:59 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 08/12] RDMA/rxe: Don't call direct between tasks
Date: Fri, 29 Mar 2024 09:55:11 -0500
Message-ID: <20240329145513.35381-11-rpearsonhpe@gmail.com>
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

Replace calls to rxe_run_task() with rxe_sched_task().
This prevents the tasks from all running on the same cpu.

This change slightly reduces performance for single qp send and write
benchmarks in loopback mode but greatly improves the performance
with multiple qps because if run task is used all the work tends
to be performed on one cpu. For actual on the wire benchmarks there
is no noticeable performance change.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 13 ++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 12 +-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 357c1d516efb..d48af2180745 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -129,18 +129,9 @@ void retransmit_timer(struct timer_list *t)
 
 void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
-	if (must_sched != 0)
-		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_SENDER_SCHED);
-
+	rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_SENDER_SCHED);
 	skb_queue_tail(&qp->resp_pkts, skb);
-
-	if (must_sched)
-		rxe_sched_task(&qp->send_task);
-	else
-		rxe_run_task(&qp->send_task);
+	rxe_sched_task(&qp->send_task);
 }
 
 static inline enum comp_state get_wqe(struct rxe_qp *qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 3ce7a32b5dcf..c6a7fa3054fa 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -49,18 +49,8 @@ static char *resp_state_name[] = {
 /* rxe_recv calls here to add a request packet to the input queue */
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
-	int must_sched;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
-
 	skb_queue_tail(&qp->req_pkts, skb);
-
-	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
-			(skb_queue_len(&qp->req_pkts) > 1);
-
-	if (must_sched)
-		rxe_sched_task(&qp->recv_task);
-	else
-		rxe_run_task(&qp->recv_task);
+	rxe_sched_task(&qp->recv_task);
 }
 
 static inline enum resp_states get_req(struct rxe_qp *qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index d07f7bd3b2ae..c7d4d8ab5a09 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -935,7 +935,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
-		rxe_run_task(&qp->send_task);
+		rxe_sched_task(&qp->send_task);
 	} else {
 		err = rxe_post_send_kernel(qp, wr, bad_wr);
 		if (err)
-- 
2.43.0


