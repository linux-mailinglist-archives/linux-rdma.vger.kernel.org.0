Return-Path: <linux-rdma+bounces-1603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51F88EA14
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFDB28B25A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41105130A51;
	Wed, 27 Mar 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs6+HfZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E431304AF
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555071; cv=none; b=cwKOjeJSjTrb8YiaBEuJHUE7ShFxRLx+h7Myg6TJYs2s24OCgR6os7o5VzOjXDzcXlTWImQ1Ag52R1qnGFr/pQG0P/sh2qGo+vebSHjIWz9Abtc3aALyHqY2twboHTsM0LQYWzfbUJXy/Ovf8mrven5aygkpbZ7SU63+n/+Z5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555071; c=relaxed/simple;
	bh=UZ1/DCPLtR3mduOS71FDyDDnkpBv8+SGmdEPh7DHYY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq3V51hCiraus2DEOMOr/m6X+aB6fXKPSwxKdqkhzFy+JtDfczRkwpdc//eTQqutgeHv8K0LXxse+SyUssEOtGpIRmmgC7cfNy7OePASBYBMoKuhgMN1UINuqhXZCN2dmwofsdWZwyA3iifM4BaKniEDk9OBn2vgxq2Fnwilzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gs6+HfZM; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e68d358974so3267429a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555069; x=1712159869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iLVySYmuqx2nSAqtlxR4y9KeR6C9kAhC4jpyCkS8UA=;
        b=Gs6+HfZMxZahWPqm4h7P5zZ2aA0RmSiX6GVlMkhm4SkF+Qw4I2vUSUPI0/FMbY67vx
         4Yjj+OdDCiuEGhK1wfAfWLgAkUTsoc2HyFVH2B+MazwRnrG+Z3OeM3Lf84fDqdbcAc0C
         NhlylzXmGmptKtmxOXdeKYp1Lz7Y42BNR3zcXfK1FwYts6s2rwrvZfi6P70cG+3/Wjd9
         Cyhzwu5WzAUcXlAoIyLrgTDb6uveImG3MHOuzoWHxP5+asowBSQXSYTvaNpFa/xmKsNb
         Yi8YMJhLqq8SYsXVPQxsCWUvD90qmNfu+/H14ISjlC4FIcIgg1ObwVkWFenj0D/SXG0w
         6ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555069; x=1712159869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iLVySYmuqx2nSAqtlxR4y9KeR6C9kAhC4jpyCkS8UA=;
        b=xCKfUrYfsLN5xQlOK8doPzcp1a/1dhxvraYyFgYhT8WvmbQj3LgQ6BJ2678unugWP5
         a49ybUsjZktdcOE5rfn3M9RMwpBwYQyHXytVgCRy8XsFZFZ+EMD3QcXVwd6PMYZPbeQk
         BH7QfSr2PxZOqtPUkujogbtMn7amAdpqG27H97hhiFyUhmYXqCGKnCLrotobAoK6WpBx
         NvbE6GTQ7SafYlzTG3+iYHLCrWbzT7hey2hlJ1D7cOB5CsD/EVKx9itWeqg8wBVsF/vg
         SHqrZ5qj+5IjvJIzaC1QHqljJ/fjujdM85EkaxBRLg5YA1BOwSGkXepiobPjXlvi81au
         y5gA==
X-Forwarded-Encrypted: i=1; AJvYcCVFkHiVKNmweMge86yvzkD6O5HsNgvbik9Mh+586UYjtphPQdHPj9cnzeuZZwY5NpeNwrk6xLmcUX9GjfHOSTIVWSjASNaUqb5GTA==
X-Gm-Message-State: AOJu0YwcrTa1PNPrNB0dB74gWff0hEUjIDTRAkIEeWXzngKd67bJ3yV6
	PpLS55adlZFqW4d3q0LIPsGGOqVmaSJv+auePiCOSOKe8XPGoKZtLo93ma4fuWM=
X-Google-Smtp-Source: AGHT+IEUUzMgRFd1Loso9emtp0DWE8GcVat4T2Nof4Xd+K/GCPTW+26n1QhWyBk6dPYCr1HPNhKtBQ==
X-Received: by 2002:a05:6830:d4:b0:6e6:9547:bce4 with SMTP id x20-20020a05683000d400b006e69547bce4mr225737oto.2.1711555068730;
        Wed, 27 Mar 2024 08:57:48 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:48 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 11/12] RDMA/rxe: Get rid of pkt resend on err
Date: Wed, 27 Mar 2024 10:51:57 -0500
Message-ID: <20240327155157.590886-13-rpearsonhpe@gmail.com>
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


