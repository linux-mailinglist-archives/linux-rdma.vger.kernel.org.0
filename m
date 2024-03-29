Return-Path: <linux-rdma+bounces-1675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F23F89201A
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F66F1C22838
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7509114B09A;
	Fri, 29 Mar 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzlRdssF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AF14B08A
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724160; cv=none; b=WQOnRCR21Rru+QZF3PZS6uv1wU9L1ADGmySisnHDkhvGPsNPaUUml7UQrloH5Ts9yMwDO/Bzi0fJEEVWzf7p+M86ko3iT/6Qae+XLhadkwvlqJF5DKyDlYX7ckEEhdAzOJuYXrlyHzYgNI0Ejv70cp5VG0odcxzgLspJ18lepRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724160; c=relaxed/simple;
	bh=nK/eWvmC9NoeXAd3HPKwxgaAueONSiU99ZwEabcO0kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwYImDgyW4W/dY7//aFipGJrd8Ll/AV0Y24OrEh0XnQfNEstEirb1klpNLlVCpnniE5ZxfUaM9/oe6GSAKzXiNEBwlQBg9p1+MTR1ZyeetoRLwEnWZ2gdsFDuqCgEQdpSRsSQm6k6h3TtTjhEDI3qV2ICdnZtrgI8xKiBZVSJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzlRdssF; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22215ccbafeso1122882fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724158; x=1712328958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nS56B9R0MASjlXMNQV3RCH6VoFkteo8/PCt+i+tEO8=;
        b=KzlRdssFy0iGn1KukSGELbtSIIzLHADOMHH546MN0VrUV+HuFboxxd68Cp1Rh13ewr
         OAJ1pdOBHONsqGi/kGFHeqoxfLovlNkCb5EGES9OUY7itFGT6U8T4MrF67jB8fZ7tciC
         7JgBl1yh8qa9tR533uYMf9PIKNjR4Xdtyy8BXQg0bYCGvL7wh5jZ29IsqEMWnecUpvbs
         CAk0aw8zD/glLGjZZwI5ZXJeTgKL21VQ7LKpbh3FlOVKrD1YhY6EQpZLSlaQ/49YIlVy
         6nTHLyej5EAYYjuy9Vh6WaZ0/rTLV5aA5q2tSnK9svebPMzD5ve5cVv0OegumACWdr0j
         /h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724158; x=1712328958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nS56B9R0MASjlXMNQV3RCH6VoFkteo8/PCt+i+tEO8=;
        b=v0gKQeo1P0okjrJBIzE0gVdofTOXzh0PPopHhkM4djUg4J5vmy9fZa1PJnKZzvFW8M
         D416EwpSEPsL9op/dl3QBdbxAUSJcymxLiIbyu99ArCxc7QmfeF1cMW2fW028ZIlUcAA
         Uni1WUjXWqYYgw+Q+eV0yoQncg+YGFFRHaKejBXe8m9SsA7Mmux+/vHRR2Mejtii35Jl
         9b1vM4CLrqKlWBp7D0KB217H/3wbBOZf1BAbs/b73dCI0lnjd7YXifqve21c3es1N0Kg
         Hzim8crZJ1E04THbKtW4Mnt8IsaN764UyfDVG4MGOkQg4uQXE7sZNqHQ8rs5S9ekYGVe
         rX/w==
X-Forwarded-Encrypted: i=1; AJvYcCX7uPby9YLshBSoExckFkEFPyJlmRRobcl4uLf4qZTust70DEqWqSFIfOcLwVm7MSLW8w6TXcPTrFb3x2HwzZTYdIPYucuPbhZCQg==
X-Gm-Message-State: AOJu0YwCRZXnsiwP3/zgM+KnLzSYZUAmxik0vanMgLMDMQmfKxfL0Qct
	w61qxyFLWiJjUIUQhjcUtS0Cs/VtMfDcM1fF8xmO5uwMuazmfLmo
X-Google-Smtp-Source: AGHT+IGu50oy444FxyD3P6hMuI1LF4S5SGlvrdrFk5LYSZubzIASQYUXV1cDd+4VhgxeKAz0TzY4qQ==
X-Received: by 2002:a05:6871:1c2:b0:22a:5bae:9cd5 with SMTP id q2-20020a05687101c200b0022a5bae9cd5mr2472866oad.48.1711724157819;
        Fri, 29 Mar 2024 07:55:57 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:55:57 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 06/12] RDMA/rxe: Don't schedule rxe_completer from rxe_requester
Date: Fri, 29 Mar 2024 09:55:09 -0500
Message-ID: <20240329145513.35381-9-rpearsonhpe@gmail.com>
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


