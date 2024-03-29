Return-Path: <linux-rdma+bounces-1676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE646892113
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300E9B26B75
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA114BF8D;
	Fri, 29 Mar 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2gOIIXV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0D14B07F
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724161; cv=none; b=WXN1rbkrTlSCm2zsZdYWJfev5IyEB6IkLvmJZhKm3RJ8gEfNfNey4+T7T324kheYrskAgJ9h25rnYKHxZmKnAZBJYVXOxdgzQ24DgM4hON1j/2Y80jqQsLumgnGvizf2dt0OL3MwnFFbVsss1F7lwK14wYH1rwkDa2fVm90zfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724161; c=relaxed/simple;
	bh=3Lsdl3bUk1eghZI7pfT2uqcGv1yrMB6KXmFLotShHrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8tmPe5nuO2/29hz1lHfrr6Ul/YAD55C8Prbpia7zbBs72/ZCmIFQkN5N64dRYeYmKue/mlFcL69Hq/59UJMlG3Zulb6KroLWCyQt8RXPKY4jFfNPk56KA+Qtnzpn7krOlLnjzeIWRbGLXXpf4SjbsdRd00vx4aVpFneiwwQbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2gOIIXV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6d0bf038fso971993a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724159; x=1712328959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIzk7mNVCul3dJBEzUlME8AqbvH1WAEWuhcv1rlDPV8=;
        b=P2gOIIXV83HlLqcrI3ZL0n4GiN+FWmv9XqinVkDGMb61VIBcb0aHldClpZsZeFYDE8
         rxC8un2i7TsmepJgUSvQmNXI0KT1bucElzXpvd5CwjvL2cyF8RCxKoDlYKrdTgX97dMH
         6utU8esIYow6P6UdOwkzY2Ud8gqcTnSC3pv5EE9PBojxp8r6m20nnndpiyzSsjaR6L6l
         MqVl6j90wI+T5X9VkVNHrQ1K5tTQuHj5cGqlGliX9kdNEW7MjAtQlZa6Yt1rRi+kbnha
         rLaMfrh7myMh+3dczr5NKkAI8rE9dSsywj/fHj4vX3kMKV2mnXYjEdXx5KoUXCnypjUk
         jmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724159; x=1712328959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIzk7mNVCul3dJBEzUlME8AqbvH1WAEWuhcv1rlDPV8=;
        b=XFDexT3dPSAvyjHvyQBUYuRottsfSnnn6nHdikkGZ08vnODmr8zC6u9vbx6s/2SakW
         +LCrD2gHUf46Nm1eGf1oGKjTa3KL8LzARXhMUNBLhYmDDKDdXSX+B6l30Yhhn7MTwxoY
         oB7eb5liXRHp9I4jaYA9Kjm2ETQzHKzzDuqkQ1gKimU9+7EsP5MSRjGiq3w64O079nE9
         oUMq4rZmEg3awmg1uUBDqyZ68Uj0KkfWhKDq1fDkAKF7LBhlYze244V1R6ucR29Fnf7D
         XvmHg2yZv18OHvw9IscKu7sTnfbROAwUmiOCGp1DiR0u1am+PqsYFqYp3ttUfYYBcCRy
         eEHA==
X-Forwarded-Encrypted: i=1; AJvYcCVQMH4mehLB0xT3o6S4YCBaoLg4UcyIv1gWp0f8oUskZRC7tP5aUdpYtlNhEqm4JfRVsr1OL0lA4LLT8k7JRJGV8odsodnc5NSEog==
X-Gm-Message-State: AOJu0YyhZOC/kNzG6PhpjOzdBlSESefpFY45o3KIki6M6qjRfk8jnGci
	HBEHT/rQz3u9uK0iOYjom+Rs2Wnuk4u3p0kPTqul+Cn21Bb200qj
X-Google-Smtp-Source: AGHT+IGiuBzf0EutxnDtNlTGzC/2S/B+gz+24rHdO4Bpkh07Y9vGAX2aH0DAXQRrfrNmNP3qq67CYg==
X-Received: by 2002:a05:6870:5314:b0:22a:a167:50fe with SMTP id j20-20020a056870531400b0022aa16750femr2682809oan.3.1711724159109;
        Fri, 29 Mar 2024 07:55:59 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:58 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 07/12] RDMA/rxe: Don't call rxe_requester from rxe_completer
Date: Fri, 29 Mar 2024 09:55:10 -0500
Message-ID: <20240329145513.35381-10-rpearsonhpe@gmail.com>
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

Instead of rescheduling rxe_requester from rxe_completer() just extend
the duration of rxe_sender() by one pass. Setting run_requester_again
forces rxe_completer() to return 0 which will cause rxe_sender() to be
called at least one more time.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 17 ++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ea64a25fe876..357c1d516efb 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -325,7 +325,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_sched_task(&qp->send_task);
+						qp->req.again = 1;
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -476,7 +476,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_sched_task(&qp->send_task);
+		qp->req.again = 1;
 	}
 }
 
@@ -515,7 +515,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_sched_task(&qp->send_task);
+			qp->req.again = 1;
 		}
 	}
 
@@ -541,7 +541,7 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 
 		if (qp->req.wait_psn) {
 			qp->req.wait_psn = 0;
-			rxe_sched_task(&qp->send_task);
+			qp->req.again = 1;
 		}
 	}
 
@@ -654,6 +654,8 @@ int rxe_completer(struct rxe_qp *qp)
 	int ret;
 	unsigned long flags;
 
+	qp->req.again = 0;
+
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
 			  qp_state(qp) == IB_QPS_RESET) {
@@ -737,7 +739,7 @@ int rxe_completer(struct rxe_qp *qp)
 
 			if (qp->req.wait_psn) {
 				qp->req.wait_psn = 0;
-				rxe_sched_task(&qp->send_task);
+				qp->req.again = 1;
 			}
 
 			state = COMPST_DONE;
@@ -792,7 +794,7 @@ int rxe_completer(struct rxe_qp *qp)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_sched_task(&qp->send_task);
+					qp->req.again = 1;
 				}
 				goto done;
 
@@ -843,8 +845,9 @@ int rxe_completer(struct rxe_qp *qp)
 	ret = 0;
 	goto out;
 exit:
-	ret = -EAGAIN;
+	ret = (qp->req.again) ? 0 : -EAGAIN;
 out:
+	qp->req.again = 0;
 	if (pkt)
 		free_pkt(pkt);
 	return ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index af8939b8c7a1..3c1354f82283 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -113,6 +113,7 @@ struct rxe_req_info {
 	int			need_retry;
 	int			wait_for_rnr_timer;
 	int			noack_pkts;
+	int			again;
 };
 
 struct rxe_comp_info {
-- 
2.43.0


