Return-Path: <linux-rdma+bounces-1598-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8588EA10
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D33D1F345C1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B212FB23;
	Wed, 27 Mar 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3kRbMu4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443212FB2F
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555066; cv=none; b=Bn3gIFLVFysUEUbw0BQx/ABnJer497xcR0gTrhyFg2KXN5wWlCprxJxjrp9oFM7SgMLd0j0yLYysAoFPagi1IS4xEIsL3NliKSMfstfmBU8OWIwrurULAiiv2wh9iosiCNoeTEpbnJNRJOjKXXZ9POadBCnRBCk8dm4qkB6rz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555066; c=relaxed/simple;
	bh=nK/eWvmC9NoeXAd3HPKwxgaAueONSiU99ZwEabcO0kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6+lZkSDnnRTOSorE+Zyea/E5pXHZRPy88FT4T6+vi1Mx1AHRY0o8Y/sU9S9VG7Fiq2jcjBtAKz2IVdBq6K//UHjzK+X8HkqQkRskdLovrBt20ZQHpic2G5o/1fF3zD8s1fD6HBTZJxE3ot05f3zvSdxkHt2BKXywrA8Yh5AGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3kRbMu4; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a4716cfbbcso3854689eaf.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555064; x=1712159864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nS56B9R0MASjlXMNQV3RCH6VoFkteo8/PCt+i+tEO8=;
        b=O3kRbMu46MfEoBvAuPGFY84aJfI6k3nfPZGNE6CUn8xeIx1d/GnssF4KhAd2DrsGYw
         sunltseByEswO4bkfWWM6m0GsqapZVjG7GHX6BycdNzwoXzPW6jNU/0x5aTqSKsf0nfI
         FlLCEcJAg5j+hKZuvb4eqBBotcUR98ohqo+sH46BHc/UkvuSFoxYaZG6rheEzs6bz0QK
         0TKsU6n8F8IoxxXMTUUAxknuQrZU3hRrGiMzDOQ++bt1op6Rl7mSbDvOuQ/UTukz6b9q
         asQNs6xV6cq0NlKdH99So3iMgAQzPCRJPVERCPZ2umBlvOW0nNiwWwOP/TXTojo1qEKe
         aNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555064; x=1712159864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nS56B9R0MASjlXMNQV3RCH6VoFkteo8/PCt+i+tEO8=;
        b=jEWj/KBhfxfqT0dkn71iqIiAdYQnBbTFIl5pDLkuA3xVtLusNwBupc/Dp9nolmFKCD
         Y9psV8DMqcgJ32gEzqGm7nT1gWqiizs3Ad9n+Dwfy5hkibZx5LznRXAwfWCYiJUWU/rV
         7WIFiKt4FpN0VSARQKC/fCLXK9rwpy5PCqLjugGW3MfyWKCvonRq7TbZthIfCWh+DSso
         OlDTvgraQMs/i7Q0XYayPZr6MCl5oDuuiUUh1dsorfvkYnCQbKzfp3q9mf+6LF8QHCVQ
         REXXOCjdrPUPD9j7IaPf+KL/WusZSMaLt0fZdSUWrq4fkFaq5MQsV7rLlHkWbtz5Bvsj
         YalQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt//c+V/+vZcXoaYe/l66zZ/EHKLtgnNdbCKDURkauCwq91ZicwZ1qSznA4+/4S9VBsllqDZslQwnNhX+HLIsCz0i9hoctae/xEg==
X-Gm-Message-State: AOJu0YyERH+ac3Zy7h4hOh9UzyBtfsCDiu6pKNzQkWcg2X4SwNMmxFbO
	EPID9LOZl4My9Seijiua5YWswAtvXglnXcMhj/B1PULqX9UevvQb
X-Google-Smtp-Source: AGHT+IHgA8HBbv6h8JjJSzS5Z6C1DMQ7kRcm0ZumvFNBJaBo8ml6pTtt+5fjaG81AYr86eiIluqkiA==
X-Received: by 2002:a4a:e917:0:b0:5a4:71b3:d090 with SMTP id bx23-20020a4ae917000000b005a471b3d090mr637613oob.5.1711555064282;
        Wed, 27 Mar 2024 08:57:44 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:43 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 06/12] RDMA/rxe: Don't schedule rxe_completer from rxe_requester
Date: Wed, 27 Mar 2024 10:51:52 -0500
Message-ID: <20240327155157.590886-8-rpearsonhpe@gmail.com>
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

Now that rxe_completer() is always called serially after
rxe_requester() there is no reason to schedule rxe_completer()
from rxe_requester().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 6 ------
 drivers/infiniband/sw/rxe/rxe_req.c | 9 ++-------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 928508558df4..a2fc118e7ec1 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -440,12 +440,6 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		return err;
 	}
 
-	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_END_MASK)) {
-		pkt->wqe->state = wqe_state_done;
-		rxe_sched_task(&qp->send_task);
-	}
-
 	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
 	goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e20462c3040d..34c55dee0774 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -545,6 +545,8 @@ static void update_wqe_state(struct rxe_qp *qp,
 	if (pkt->mask & RXE_END_MASK) {
 		if (qp_type(qp) == IB_QPT_RC)
 			wqe->state = wqe_state_pending;
+		else
+			wqe->state = wqe_state_done;
 	} else {
 		wqe->state = wqe_state_processing;
 	}
@@ -631,12 +633,6 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	wqe->status = IB_WC_SUCCESS;
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 
-	/* There is no ack coming for local work requests
-	 * which can lead to a deadlock. So go ahead and complete
-	 * it now.
-	 */
-	rxe_sched_task(&qp->send_task);
-
 	return 0;
 }
 
@@ -760,7 +756,6 @@ int rxe_requester(struct rxe_qp *qp)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_sched_task(&qp->send_task);
 			goto done;
 		}
 		payload = mtu;
-- 
2.43.0


