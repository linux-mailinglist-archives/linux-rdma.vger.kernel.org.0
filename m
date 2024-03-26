Return-Path: <linux-rdma+bounces-1576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D0688CB30
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557131C64199
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58203398B;
	Tue, 26 Mar 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDPrb/5P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41829210E4
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475083; cv=none; b=paW1FEqUHE2SgKe6cczFW+5ullx6TJVzVEXxjsXUjfvKwXB0MZN2aepKnFI7Spu/9j196g/sAprKTeMLifeapQMNQylRmLWCktBapqUfStgS3d/BulC35BwSBKi2gZNbYfLsL+FhjiTtvs3VzhHU/ZDSUnE2M1UsTuPwBmECq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475083; c=relaxed/simple;
	bh=P7tOOgeY0L2CvvM2QtJqeSL/YwkPxpl3T6DkGN+oUBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj1b5sYAi1HlqBN1iDIiGattdOD0kcjC307Tk4rluLyA82PgiXOjCwLQ64xkpJwLgmpALl7yqDKDjTyk403N+wSjkNxIxnvlm1SHhwnKhb0nrVhuCVrqP81zn886OfJSiuMdaFp0SLLUhqOFF9CEb0Tqr7Z9uej5oVws/LIvbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDPrb/5P; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a5508007fcso1157881eaf.2
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475081; x=1712079881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofF1b+zvHAVjiqjOdcrJdzZ1L5D5MRm+IjXlS0QMc+8=;
        b=JDPrb/5Pcx96pJDa7ZJ8OwEXSKWb4te9qi67NtUQFqpOuuIDO9jku4oSEpFZK7cBye
         Cec1OitnatvGcb1VzlOiTeiH4JGEJRPJzULFlEEcwbYtADgBp3DMFr1mvMx0f3COPyrr
         H8/dQaF+70zM7piw0Kp/SE/vTkBAkF7nr4kKGZUDQBR4IBX8+Rw5+SF35FnH51TKkzjK
         mDywDNK+yHlpfJSV+YgzByl8A/lQBlroHX4IYGUYMMjT0CWXNeWbvjsxHBual/u+cNsv
         R3D8y5Dc8fC7B1NPST4cJC+Q+zYK4IIc1XHDeKzzyFkDbuEKkUxf28izAhQfs0IQDG6E
         OslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475081; x=1712079881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofF1b+zvHAVjiqjOdcrJdzZ1L5D5MRm+IjXlS0QMc+8=;
        b=GBKj+/vgOrHSmBHmSQDXT0pgZmo0XUXIyGkmHwA/Ee9xqCodg69ZvVKn66Dzsfu78l
         B9k9qL1CbIY18MiqpmQbKKx+kDTBKP07WhYI+DpQuYyJGfEDOwrJsYHe0Q79mglneBio
         VKLayoXiEor6auXKt8hJwgEWBitxyTf2z4hz+vNK1B5EQWgPDHCSk6Ms2w6w9adMxErx
         F1UdcCsiSYQ5XS0E52vKgTk9zJM3oDSLKCR6I/64Pfoqi9dfDIE97IKdAcRBjanqHmwT
         QchcePAuSwedmv1MyBF/1Mb4enS9hoMYzZRccoyBEptXBCEI+PkcIkLm/RB0BptpQeaQ
         UQTw==
X-Forwarded-Encrypted: i=1; AJvYcCUnQ2oplhFhbp3G95HtlmWrEVI4NNTDGGI2GQiYian1sPnXzk9hZlLp0RCghv+ZQUvTocZRGK6j2DUhFZY8oqv7UmvX1G3tZRX/Xg==
X-Gm-Message-State: AOJu0YysvUd31wWwJJnWc7ZH/akeiL0Rpj8cHXtsxcCVwc1SWaqfkkSd
	ZohdzSYHzlNWaORjUEki637wy6TrON0x5qSn3+9Qp3Fa7o5V935f1roWL6Ok+kA=
X-Google-Smtp-Source: AGHT+IFHxDOKjZsXWsyb1UkXdg8X/1kkT0Q5iAS0Kkp6smZ9Hdk++fIlCjlkjdBEqsl3BHzXMzhLag==
X-Received: by 2002:a05:6820:20d:b0:5a1:a7b3:3d0 with SMTP id bw13-20020a056820020d00b005a1a7b303d0mr625767oob.4.1711475081321;
        Tue, 26 Mar 2024 10:44:41 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:40 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 09/11] RDMA/rxe: Fix incorrect rxe_put in error path
Date: Tue, 26 Mar 2024 12:43:24 -0500
Message-ID: <20240326174325.300849-11-rpearsonhpe@gmail.com>
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

In rxe_send() a ref is taken on the qp to keep it alive until the
kfree_skb() has a chance to call the skb destructor rxe_skb_tx_dtor()
which drops the reference. If the packet has an incorrect protocol
the error path just calls kfree_skb() which will call the destructor
which will drop the ref. Currently the driver also calls rxe_put()
which is incorrect. Additionally since the packets sent to rxe_send()
are under the control of the driver and it only ever produces
IPV4 or IPV6 packets the simplest fix is to remove all the code in
this block.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 9eb7f8e44d13 ("IB/rxe: Move refcounting earlier in rxe_send()")
---
 drivers/infiniband/sw/rxe/rxe_net.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 928508558df4..d1dd440b1e4f 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -366,18 +366,10 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
-	if (skb->protocol == htons(ETH_P_IP)) {
+	if (skb->protocol == htons(ETH_P_IP))
 		err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	else
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else {
-		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
-				skb->protocol);
-		atomic_dec(&pkt->qp->skb_out);
-		rxe_put(pkt->qp);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	if (unlikely(net_xmit_eval(err))) {
 		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
-- 
2.43.0


