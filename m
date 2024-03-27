Return-Path: <linux-rdma+bounces-1601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4288EA12
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD461C30753
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07A1304A2;
	Wed, 27 Mar 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3gWMwa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074C12FF93
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555069; cv=none; b=LIsIkyabD+e2Xe5axs7hX+chEReeZGIwJc9y6/vuxMJXi1J07i8vb4i2N6fcvac9uOMz79DleG3pPhHrDeK1dWppQwUywjysbgBM2Vw/5KEhk7BEhqLdtOmBA1XRjnAoDZXewX4/BCxfavesE8fwBBrVqYjnBjtuG546oswa4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555069; c=relaxed/simple;
	bh=0Pa2bP02dZ3ETe2IeoQTHbmUTpw9EjmdiMWm3SVmSbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDeA3ZPaWrv5umEhBr3RU+fnrNPy4rDxKsXy3nl8NuQ5MvMT2fSIaHI8LkIvA3StC4SQWr1/J6a+fD+gDJvoYwyga8QxBPA+xlKI/wHsjMxn56PPIOdXpR9coUGxzByGet8BqQjhH5JY6sjLgzx+dvzE4uEHL8n2cdzjgnDcoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX3gWMwa; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e6a00de24aso3249389a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555067; x=1712159867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbUgPeO40G8+rE2YU4GHNiFgO5GLJpSIYCgoppaAmmA=;
        b=FX3gWMwa6R7UVCrqRdEqiBf29uTnDKCYp4A/+pdnFkcrS0Tj8UUrmBKgf7OWrKtDnL
         UNP1fXqXU/CB3gX38omntDM+npB8xypIGcv6wE/IUHWVNJ8aorlzHOHFG0EmYfyfhnNy
         hcVMfyEg+0/uWV1uk+bgnMaRyRb3pPXbbSiyZf1leub60FqkTz2xXCQrwzHfHaNI6G3T
         FTSwVljUbMbXzH/SmXK5jKp3lWsHHzCo+EhkotEnxXlG+/OJaeov0B94vO5teDtaSpVR
         3iD0VJkNs+W3d24u3TQ+8/V/NhSwQFr2g8xXGukd1wUa0lTiwaEtBC7U0Dz1Ny77vCvc
         0N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555067; x=1712159867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbUgPeO40G8+rE2YU4GHNiFgO5GLJpSIYCgoppaAmmA=;
        b=YiTeWJYMn3semsjjOfOYjkWmclBVkl6/r/C79xic3wcJB+dEO+/tySuJy9AlIdgB0J
         pwyyk2tlfBWajT1fAW8sayRm/yM/sBmuGqHlybY1jz59qsW/ugWJtLpW+NtT6euyJ+K7
         Kxhz3vqiKZ7chCnm/TpvEmB2xti9EkL8EkgxGV+53tQ9jW1opJCOE4t4uMQpkVeeqN/c
         lcP6Cppqzfw9PvsLGjF0UW5hhmwowWLbEzoykjiAa4au2yKYA3f78qFrHqnhl+F8KR4Y
         0guPqLI8hjJzhFe5jD5KlHWtzbuBS3r28MIx1f1oFnspKP/8uOlnonYiCTYdP+0nCrK4
         Pyrg==
X-Forwarded-Encrypted: i=1; AJvYcCWqBeuMGq152MxG37Jgx7PiKZ7fcBwNKHwkvKCLbnL/Z7lHH6mLjM0yxN1yeZGWgel3pOm9fAAb5qF+3V1pws8wQgO4Zds+To8Xgg==
X-Gm-Message-State: AOJu0YykUPBVGEafBKw7yHLZopwfv0V6cQMI/SjpMHFXca3VHSDxQqlO
	+AJEwu06+vsi8iaOC2PItrOtOhY8kmJpmhfpZkchKnM9c47kavVG
X-Google-Smtp-Source: AGHT+IFOqEvffug+hMzTDBz5+yGruw81TmR6Syco5Nnh0tj8s1ApTBeso/L76T3S0gWH42GQL5u1bA==
X-Received: by 2002:a9d:6b03:0:b0:6e5:210c:5e53 with SMTP id g3-20020a9d6b03000000b006e5210c5e53mr353343otp.33.1711555066810;
        Wed, 27 Mar 2024 08:57:46 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:46 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/12] RDMA/rxe: Fix incorrect rxe_put in error path
Date: Wed, 27 Mar 2024 10:51:55 -0500
Message-ID: <20240327155157.590886-11-rpearsonhpe@gmail.com>
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
index a2fc118e7ec1..d81440038f91 100644
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


