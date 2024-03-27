Return-Path: <linux-rdma+bounces-1599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568B88EA11
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86EA1C30407
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660912FF97;
	Wed, 27 Mar 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2KpPCQq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DA12FB05
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555067; cv=none; b=rtPxStqSdcFEv7FoeDpwx5FWA1t+S7P+GVjjB4WrtDtkt5inD+PUmHEvJ+N88lKdLSLlKrhu81NuKnszH37ZCKpyY63Dfxf/tk3bi4VfVUPb45C8JvLmJ7avKPmUY2L7NeEapHTcxCQqPFwIovb8uxn5+hXqk3I1S6AMK7Gh4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555067; c=relaxed/simple;
	bh=x5SWuSvv3SMTKBKxaAPrs628VcfWHAdoZKcjlwv9V7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZU3j1ycV9lj6UTBvWBheY4bfO5TjufNHxNSuj/szret8aWlcYtEtiktgMk4loPWRq9UNrtfi9MFhOEnfkczL4AI24EEJeHDHyQvi4xgBLrGN1OTMxk8/69G/gldVdF+D6iZF+yjsF/Z7ayxqpFKeQFGGlEoilA4y913sU6Mlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2KpPCQq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e675181ceaso3745577a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555065; x=1712159865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCjztQYodtMXHgbrSSmzgM11j2HWm+7GDAVbEYgFieI=;
        b=O2KpPCQqLx1CVIIAY7TLalZN0y2Lwn7XXiysdrFqUKSloVQhObxdq5vC5PEGuDD9zZ
         F4KHfPNsg/Hlz+KZk/CpQqGyZ74YXLgRCtjYedNgWnq0k4wmxbSwPpd5AWGF9eph8EZm
         6N5UNk28zYXrrCtJ7FpqgBMEjzLPnFQDK9gsi84gwFLgB5YUxLAJtAYF5DNWlcFine+2
         HqMAbVk+HI8yr+rr1EGLTHimnTw85mUW2iRqsqdHyNfjwJIbiOGlOO1GW7vy8pwzrOjP
         PK5PWun0LWg1veI4iVly9lFbOKX3xzzhoYEc+MuEvRDQI5U9gTbgy31O7rSqQk328IYD
         LoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555065; x=1712159865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCjztQYodtMXHgbrSSmzgM11j2HWm+7GDAVbEYgFieI=;
        b=ekqFt+uVD1jmTVJ0xHWlyPoPa9cJM7rgAhoCSAoa6Pc+bfK2CdaEbNxZgI/mO1vILN
         LWjbpXWvc3gswjxiyiilXycbv/Xkk0B01CLbzIZa7Ha+nY9e4TIji9LFexkHZjK9InF4
         wpsnKEOcnnHNuZ5CStyw5FgmCAoOtdQBiNZgT5CRxU6PzkFBVPYd2WTZP6qHxz8hETMo
         Bqm5AwZdzl5xHq/4jKMnD3DY1ZN6h01KdRtxSb4iGhUqTiBGi/FJX2aCkBUA/sR+0PbL
         Wx7h8Q6M6CojxEUgmSpP32bzRfaH0hfXQVL1hc/uk+LnCMHYliZFxUlvv9yilIonsthF
         sX7A==
X-Forwarded-Encrypted: i=1; AJvYcCVWxccEtAh7HnYsyIhbg1FZneEIv5GTb/4l8OaRUypbEsbdV8Dmqcei74SQTiVwdEgbTzhH79t6aJvFrflnr8MeptsVwxmrZWu/1Q==
X-Gm-Message-State: AOJu0YxCn9j1V2YLMaTRPQoY8V94lRW7a6Z4eLRxj9CiDx/8x43JSu4D
	nBwhCXMAWbm/0VJhnChTbvDbvJeb5PxvJTigAoudugjM+focXWID
X-Google-Smtp-Source: AGHT+IGo5BpQclghhkftGqKPvq4zB9T9L4Ksq86ZcoXASYe/9O1CZMgfai7i3zcIZoZF8suw8O26ig==
X-Received: by 2002:a05:6830:2085:b0:6e4:253f:c551 with SMTP id y5-20020a056830208500b006e4253fc551mr351428otq.29.1711555065053;
        Wed, 27 Mar 2024 08:57:45 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:44 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 07/12] RDMA/rxe: Don't call rxe_requester from rxe_completer
Date: Wed, 27 Mar 2024 10:51:53 -0500
Message-ID: <20240327155157.590886-9-rpearsonhpe@gmail.com>
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

Instead of rescheduling rxe_requester from rxe_completer() just extend
the duration of rxe_sender() by one pass. Setting run_requester_again
forces rxe_completer() to return 0 which will cause rxe_sender() to be
called at least one more time.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ea64a25fe876..c41743fbd5f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -82,6 +82,8 @@ static unsigned long rnrnak_usec[32] = {
 	[IB_RNR_TIMER_491_52] = 491520,
 };
 
+static int run_requester_again;
+
 static inline unsigned long rnrnak_jiffies(u8 timeout)
 {
 	return max_t(unsigned long,
@@ -325,7 +327,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_sched_task(&qp->send_task);
+						run_requester_again = 1;
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -476,7 +478,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_sched_task(&qp->send_task);
+		run_requester_again = 1;
 	}
 }
 
@@ -515,7 +517,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_sched_task(&qp->send_task);
+			run_requester_again = 1;
 		}
 	}
 
@@ -541,7 +543,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_sched_task(&qp->send_task);
+			run_requester_again = 1;
 		}
 	}
 
@@ -654,6 +656,8 @@ int rxe_completer(struct rxe_qp *qp)
 	int ret;
 	unsigned long flags;
 
+	run_requester_again = 0;
+
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
 			  qp_state(qp) == IB_QPS_RESET) {
@@ -737,7 +741,7 @@ int rxe_completer(struct rxe_qp *qp)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_sched_task(&qp->send_task);
+				run_requester_again = 1;
 			}
 
 			state = COMPST_DONE;
@@ -792,7 +796,7 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_sched_task(&qp->send_task);
+					run_requester_again = 1;
 				}
 				goto done;
 
@@ -843,8 +847,9 @@ int rxe_completer(struct rxe_qp *qp)
 	ret = 0;
 	goto out;
 exit:
-	ret = -EAGAIN;
+	ret = (run_requester_again) ? 0 : -EAGAIN;
 out:
+	run_requester_again = 0;
 	if (pkt)
 		free_pkt(pkt);
 	return ret;
-- 
2.43.0


