Return-Path: <linux-rdma+bounces-1600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6512C88EB66
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 17:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0FFB2CA49
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75774130497;
	Wed, 27 Mar 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBBJfhQQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060A12F5AD
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555068; cv=none; b=tCiLPKifbPDvvjKB28WLxaxeUuhy0V5zlbHTc3Lq6Cx6oJNvSe6On5bY3MJmctBLENxV8zHYGVrrLCgU37d0yfD7seN9NP10Twr1uSksFqIBquz3uZM+gFuLQyBOEAA7pmLY9UEpkBpYpXfmsSxg2Mvn5Zo0i8ONlUmJyY9gUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555068; c=relaxed/simple;
	bh=aVaT9oEgjB+t+ktYasHRoGdnbMAnICSWwDtQfMlVfwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTuFHzipYON1la1wrAm5GyljTQAMQNYUawPomPUT7hPWJ5vpdMh4pw6/p00r54fLnyU1B+4OZfAZgm14kki/ZfKKUyi+BA/UKcXVd9+QStI/vfyWgpds73AqH52UDIAaSnrkgkISxlOUapU7sr1kR9RaTt8hBivJ/ENkhvGmxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBBJfhQQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e6a00de24aso3249376a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555066; x=1712159866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzZlBTHvySRsZ3KRMvxE7Z6XgjpPewuA3TvQlMhf1s0=;
        b=MBBJfhQQM32UMWW7/Pw5JFChIMUWybmA71DRmGwLvCQiqq7H76RtuyQFkYsUPdG1Wc
         ApxE8ZAhvn2aG7U9RkLdXMLmk7B6O2FICL7EaOXmKZ5InAqjOJT7zEcRZ4W09dlwOris
         BNC4vQCEe59bNWlgoH2ltFNUWLYNU1qa897ljErm3IfpquObYykLvYFHoZdI9iVzOKWd
         gzDcWsoG7no+FFPC2VUiARdI14Tgwqj1LMZ6tLbEdJowUrDAWCcUON8Gr3Q0WMpyFGtD
         3YNIMX1y1tZS9NQGgbad950pTDyp97CiE+6eS944y8DgzQSla1VlN9Ql/m+iXt3BVrl4
         vCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555066; x=1712159866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzZlBTHvySRsZ3KRMvxE7Z6XgjpPewuA3TvQlMhf1s0=;
        b=XR1jmVvK0wmnxh6jRMt5QALH6i8zaQfx2NPYNyJDnG7Bsd/dr811UkXISVzLWC/J4K
         7RkXncJ5Rmis35oQ/0+R1t/GkY0AUZ8MyaYJJDGMqvYea92HQE19XYk9ChnS9n2vBOCJ
         5NIQpv7Etrs9seXjad1XFfrvrkOrI98BY/iUZZPCheCNXweO4qAq2GYze2tytKvzE6KI
         DSgszqIoEoF7lEqVlhlGmxVGnhSHglBzoEwOgHAkw7yuRTZafEk+yQ6LN7j/LAayVezU
         uobRkJBCxhnMEEWiVNxgk5+DxUJvpNaGjV8rvq1yFpJ8/BrLZZR0Dn1dUScHxBh1+tzF
         kEXg==
X-Forwarded-Encrypted: i=1; AJvYcCU1TUrqTbF10nHUX0dZEsCd1+df2hUoD7wjJMy9LOgSm4B/oOx81KmzfqmrOMDwaxgG4WHYbSKHwG/UYoa0vKBJB2AKoHZLhQf0sg==
X-Gm-Message-State: AOJu0YymeMoqcpZrKeCTdSJlvay/M+6kfnuhTOxbEIG5AB1AYORdr3oF
	QhNXqjxeod4A2YVAM7m2Kxe0Bczt4d7xC15I6O8tYRlbUh+cTFUV
X-Google-Smtp-Source: AGHT+IFiBMWZA54T4vv2MRm2GrY2wrOaFMZ8Ao7ORjvVllq5ypsGnjN+t8gz5cxIuKCReFPa2BLeLQ==
X-Received: by 2002:a05:6830:1e44:b0:6e5:23d8:a4c5 with SMTP id e4-20020a0568301e4400b006e523d8a4c5mr343661otj.34.1711555065909;
        Wed, 27 Mar 2024 08:57:45 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:45 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/12] RDMA/rxe: Don't call direct between tasks
Date: Wed, 27 Mar 2024 10:51:54 -0500
Message-ID: <20240327155157.590886-10-rpearsonhpe@gmail.com>
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


