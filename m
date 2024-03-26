Return-Path: <linux-rdma+bounces-1579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013188CB32
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB2308362
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8E52F8A;
	Tue, 26 Mar 2024 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHhz09vb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC0200D1
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475085; cv=none; b=UhkfdKx/VOxmkOMi7fX6qxwfNNUfE4CajCswbA6VfJfqdxoY8a7xT1ePAPlX4Vda9w1aBgYLzyKTxSdAZLWHLdZser8jNzN12CIbmOHs15VnZYWtjyfrPi7kXdMobr1QJGDTLsA38lWOtBZC8X9VD59bXYQtsQcTBO6Cv19nSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475085; c=relaxed/simple;
	bh=SoU3uetKGqIojlNPGwhfWHAZhxbc+tHc2KJgZrh2Nd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxT16A4239qF0kUlvQl2Z24algijSb/Rav/Wyhzm11s2g8+QSPZGKfKM9RZsjJ/EB3TCDu8bePNiR9j+i17dMNXDJ0y1pbZWraupsX5i6zV0zfmPKFz+prteVkA0gfU7jRHRyMBVDbqj7I3JdFCjVig/WTl042UNW6GQhMAHQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHhz09vb; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a50880ce2aso2906486eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475083; x=1712079883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1POE8I9KwEedXg0bNWgQbP3KFGe4zNce0lmHwN/JY0=;
        b=YHhz09vbP2Nq1xj9w4DBhTZJ+QnCmptaLIX1EPAQs0/1NdOT6y1ZfNTxG69ZEquTrT
         wMog5W/+4k+K0YDrNDKvJqN/DLw2OQpuYGJBdrinGIKqjHSoQypaFHu5fecpSxsLjqCq
         79Mn3czo7BIQEKLm12GISib0x4hqrXmMliF4ymF1hXiai8fycM6rKSh/IHyRXcEZXuLN
         GSNKuoLKVef+o7gj1dueYCKY6PJE6rH10sUiocZ9RmA1dgXRPd72Vaf3V/VL3PHBTzEQ
         a+GyBsxpA7Cgc6C05b/jYxEhIfuAIPdtk00+sitKRQFjoZD7sEVb12ktDMETTC9++AMb
         oD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475083; x=1712079883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1POE8I9KwEedXg0bNWgQbP3KFGe4zNce0lmHwN/JY0=;
        b=VTh2qGHXUFph0SwYgha7xBQVpKmZIfxDbjTCYxx4RtxUNGwpQox+VrJSgLCf7mwWB9
         RG7r5+/2ZgZck0NcAYm5TiA/6jROM5ene88k4z0sDNOk4IIdaMzM3MMD1+SarXhQCO//
         cPL72/vinFDvu9egOA3IeflsN6q2hfhCU7YF1+hHURiundQCZe8adlMRhzuXT7E9iHOT
         AYn125d9Psz/HYkkF5FS9M4/kuBvrqrRo7XPNWPRxipQJ1xN1SiJ5OBGy7DIf/FnVGZP
         qtoKUS5Acznlp/K/ulDjHwLMZIyPlYTKIpraxDXl77kCdXZ6Nek7ZJbiFmw8a2XnY+gF
         Y4dg==
X-Forwarded-Encrypted: i=1; AJvYcCW2GmVwT8A7QI0wwxJCncQXfUrdPDjz+Z43ug6be+n50nZbDKva+7kA3sY7Oc/B5dy7asPT7wGUbJrWfvsX7Fvo+MEpeQZtUoCUFg==
X-Gm-Message-State: AOJu0YwysGwl5HfFjAW1pIXUKTLH8HhjKuNn51xFmX9h94hQz01Y9TFc
	gNoyFSDVLUcnesWcENAHDk05Sczobq+8UStce3SHnS8i4uWeJrIg
X-Google-Smtp-Source: AGHT+IHqkAhUGgT5WsWGXYpH+xssnmR8QZxRntIQLKSXjHIPNmav6NyjyqjC1DLLfmovpr6WA1zwBA==
X-Received: by 2002:a4a:e910:0:b0:5a5:46e:d0f with SMTP id bx16-20020a4ae910000000b005a5046e0d0fmr2123906oob.1.1711475083043;
        Tue, 26 Mar 2024 10:44:43 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:42 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/11] RDMA/rxe: Get rid of pkt resend on err
Date: Tue, 26 Mar 2024 12:43:26 -0500
Message-ID: <20240326174325.300849-13-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_req.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index b217fa94ff03..445650b73b19 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -800,18 +800,8 @@ int rxe_requester(struct rxe_qp *qp)
 
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


