Return-Path: <linux-rdma+bounces-1575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2B88CB2F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B11F6698F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795920B35;
	Tue, 26 Mar 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlFq7YbS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81185200D1
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475082; cv=none; b=T637/gM76mnGk0DMh9JigbneiPicAnbMk3w0TEw6gKWyFeCyRYqtdg6Hxj+GmGv85YH4tNqRdL19q6i/wPFjgafkNOwPFo85bbUrI5SqTXOoc0pGU90eYuv0DVBZM0o361Yy81zjoOiEr4BfEVxpkHQm75DN9ZDV56KJSRWC0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475082; c=relaxed/simple;
	bh=x5SWuSvv3SMTKBKxaAPrs628VcfWHAdoZKcjlwv9V7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN3/j89KO4O4vPOtzKzNYKCRkVTmJlg4afTwJdcExb4VORP9wPPcKRFWMHJIuLdVvuzhNbCz2b3BcAZGREvDpgP6nUoIySYwubLZkfs7f8yEMFpCSG7ox0aJvFMIzm0JicafcHkDX+i0CoKrLESdAR0FB9A2wKEXZPKVglnzDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlFq7YbS; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a53d5aaaa4so1447313eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475079; x=1712079879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCjztQYodtMXHgbrSSmzgM11j2HWm+7GDAVbEYgFieI=;
        b=ZlFq7YbSfFTQoHnVRMC2JvpkSYbH6TmGZWvw/K+8C2i/1BOXw+3qiYuDIQibXBZ+wz
         hX/UvattUZ/nwHaQSk0xbkcl6o52/STbl/dNv1yS1wtqvXR/UTlIDiOxJyzjGpwrvXou
         1B4+zO5icuJbToXbRJ6JVRDPc9iG7OS+zsXLPdl3hIX1kgCCs3fP5GdM6wQSjsnUXR3u
         2sXHD6JWSBrIXsQDMZ/7FVxJJPXc4SrUiyT/YWxVchfQkLTLpngzR1k9JS+dWkeYttfC
         CbNATdyVJk4DSdsXF8OkR2Wbda7pW5Mdq42Rjla7PC+b3wu03YDsWysI8M4P8verQvGn
         3NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475079; x=1712079879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCjztQYodtMXHgbrSSmzgM11j2HWm+7GDAVbEYgFieI=;
        b=VN6DA8PD9I2hm9W0qVsGtAHs9nW6vg0bkYoQBPbxUDN7YwX9EThYLLGyFu61Vxx5kH
         8xRHmeqoHrPdKGOjAYDc5UHYMlQIfNh5qhleCHaRmsV9w9xrRgK7Yi5cFPCP7usPS5cb
         W1U4Fihua7KcHOrAEY59kTgwGdLy0Msz/L/Dg1VRBddpEixoeaAKg3rOYwMFLK/ckrft
         HBU0IwaDcoEe6kbhM4HJfLVdzU+O0z8q5gGskAAkbaKyY77b9NFsHUwu6KvRxdmuhBEQ
         hz+45ayRd45ZTERaW/YJBlPHdZeF6pBDBqZI64ISGpV5Xt7IR/+i2K+r00CJGNqoFL18
         DmYg==
X-Forwarded-Encrypted: i=1; AJvYcCXet+q365fwwNMx0kBQ/M1DY1LEQBW+oSbyzBk+0w+jd/fJeEvAWvo3OKUpFwDo9eA8k/9CtkQo2B3jrS/Bugcx+KDl7aQ+girMhQ==
X-Gm-Message-State: AOJu0Yyr8e+3cpo8aZzcjsC4TlDMDYqCb25egXyK8DdeywVaV9CW9xcW
	7pc/1HhCFOXvrphZPXwpaSiE6di2e3fBVIIVbWRQd4iLVzdFD6xN
X-Google-Smtp-Source: AGHT+IHO528N7GUUMdImdoYZM/P2IPpmLrk/QbDTlSQFezayWxq/XIHy//6on8C3/2VpRW2R3wsGlQ==
X-Received: by 2002:a05:6820:2111:b0:5a5:639a:2fa0 with SMTP id cd17-20020a056820211100b005a5639a2fa0mr4623581oob.0.1711475079494;
        Tue, 26 Mar 2024 10:44:39 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:39 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 07/11] RDMA/rxe: Don't call rxe_requester from rxe_completer
Date: Tue, 26 Mar 2024 12:43:22 -0500
Message-ID: <20240326174325.300849-9-rpearsonhpe@gmail.com>
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


