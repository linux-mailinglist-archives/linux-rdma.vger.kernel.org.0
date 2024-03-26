Return-Path: <linux-rdma+bounces-1577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6733588CB31
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A264DB24EAB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E2482EE;
	Tue, 26 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYiuDcWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F6721344
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475083; cv=none; b=ut+xPvN4cLiVIisERq5zbDqDb4LhngL6wCbJsOOAhOixoN8cW6CCPua10ALdS9+dOhTFiHseyV2zIVsojb7TEDSZ49kTG8o81gBIfPxTYPtsVRc6SPoqx+TYmoLb/5AxGj8UnxDd46bJEPatA7peEBnr6qsgoNj8bh6BVIONnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475083; c=relaxed/simple;
	bh=aVaT9oEgjB+t+ktYasHRoGdnbMAnICSWwDtQfMlVfwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4nimgDk3W1KeK/43Q9jpkx9ctQMkeQLti0MHtMPUut0+zaXrW7diX9Rrxx3XcipPfaADNPPfe5XqAD2/3DZDUvO3WlgjsfdJY8OYAKuYB5uxvE5wVn3cu2C54kYdyfw4riAN2SuwZ6Vz7X5OmhF/dJpEHv70k/zR+f93Z6aNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYiuDcWj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a558d9c33aso1092143eaf.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475080; x=1712079880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzZlBTHvySRsZ3KRMvxE7Z6XgjpPewuA3TvQlMhf1s0=;
        b=HYiuDcWjjFWRcMb6gXj1J2t1dPC/TQ7PLEGUo5vLT1OUpkXgV5B4AlcpoD1r3ocUCI
         l6PrbdaqTqRoXyBhrDwShS8XnwfI5pgjbP3vbDBH69hvvUhKHWxRVJ4p1iB20ytGOStI
         zECZSvXnmREclsu6ZGJQhGOrb9Mfj+PFtwmdXggWKf1RxrPIyjlRbtWTFPoI4LVtPLL7
         s0u1/eNORgmdK9m6qEWa/oXrl09h9fWPkkCBAZURe+p3m4QfdZnkjrw+OTWqR2jF6Lar
         Wvit920UmflAtKS/HHaZgsJN6GWksR3Juc7QoInkyMvmPrkZJERUMA+KMr2AslvSXE7b
         I5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475080; x=1712079880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzZlBTHvySRsZ3KRMvxE7Z6XgjpPewuA3TvQlMhf1s0=;
        b=c4yl6BjlwPVDIlYzRu6UCB4mQjz7FSfYskKrpq97TxcIidMO25vRHsMnPuoLcj+sXr
         vbBd9pxjfYi8F5YHLXLlmsdlT2a2ZhwTyOTphFzemfgYBokv9k4A3j0cdehI8yk5DGIL
         4DpFTBFYP9rVeiqltHyqWx9N0QM3edQoAZBuRFA5desek5Yi81jfluwW28plSPY+03ko
         5J0CfIEWdzRv9EC1P47AuNJdQ7CPwVJSin1hswm87hUMaj9NXONsdflfQpBfROWXCLJQ
         pt+w9gMD09Y6FxI9HEZNJiaG6y7sWE9RUqWvb9g3FKPbJerxmvZtcb02H21BW2T9tNWD
         86og==
X-Forwarded-Encrypted: i=1; AJvYcCUO3kEn/qhqEX8fgxj2oMkGl5WIYq4LuH4r18rh2DDagiQFvpbV6hrdSaf+AI4HbKxpvBW+Kw2hkQZEVm6+XjgBbk3eaJP7gGENQw==
X-Gm-Message-State: AOJu0YxjIEVhckwaVo/VbcZx2ytE9FWeJLZ0QKB5qfy8pb+wDishCoFX
	DqpmTFIl7zwDDk7iUL0FMoypE9GPzmp5oQ2S6rMce+hU8o12sD91
X-Google-Smtp-Source: AGHT+IGLO74eWsp4oSRFRlPbCbr6IPsDWcU6VFN1AwKp7QKLCP0cRW+J0ftLOfCJEizFmLXK1Oq2bg==
X-Received: by 2002:a4a:ee86:0:b0:5a5:639a:2fa4 with SMTP id dk6-20020a4aee86000000b005a5639a2fa4mr4546112oob.0.1711475080512;
        Tue, 26 Mar 2024 10:44:40 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:39 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/11] RDMA/rxe: Don't call direct between tasks
Date: Tue, 26 Mar 2024 12:43:23 -0500
Message-ID: <20240326174325.300849-10-rpearsonhpe@gmail.com>
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
index c41743fbd5f1..26c06f840184 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -131,18 +131,9 @@ void retransmit_timer(struct timer_list *t)
 
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


