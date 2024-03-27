Return-Path: <linux-rdma+bounces-1602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB188EA13
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25A71C30D39
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03A130493;
	Wed, 27 Mar 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWzjYTIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCF1304A7
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555070; cv=none; b=VOZVEY+yQWZ8uwdOY8lqJnwTr5n+mVxrqMRi+3zMl5bSFnErhlvYaiWoMMQ2396R2pm9gyI+fvvUhnPx0mCBgz96WX1llX3P2civG0Qg4BHZumaUCUGD2r1xkuVAGCnbrlKfxC5I65zK7p9YCfKbFIIfVPRTghctLvcQk677blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555070; c=relaxed/simple;
	bh=X2q6wbjrbnUuC0airwdkQF2e6eqr3hWQJS/qlRR1dXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCs/c3ajsSc0dzMM1HUDkX25V42wZnaRi6wD5BKl8BqZ2dF+9HlnPGJbkRCFEqTVpyHTgoMkMjNsdmpaWddAN7TpT+CBYolX03zPhcWDPbXNE4yAVBOZzaN8oKWu5UwKqJPnB3P5xcyjyv71ASJD8xNwZ4MMpuh2xEUUvADY8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWzjYTIY; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so3936924a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555068; x=1712159868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWAslbWFX1XOSWwHcgJy6hHbIvWl+oqLgvo/gLbrYpc=;
        b=KWzjYTIYjWssdfG3LmIsHGroLkPaMCOvZqCFvENOBFPgt6h7EfCDyi1fjlPXTr0d+l
         xoYn71xYf9z/ybc1ElJ1iHThfi44vtIBN8MULPB/wS20IuVpQONyfxf/wX0X8Acqw055
         mNA+/GszUIxeJXjs2IW8QWhkJJm8177nMoPTQEnf9qoX4W2EKLaEaYimny7qM2CwVmao
         rp+gI2GjP2GrvwN2h9uQw+0hBkbDcn7DeDGDHZ6+uG3TA3lEp4NAO5ECd/+7pja48xfD
         R7nck/JTnRMtsimCax3pw4i/dFjswCAff0gtHvnJea23UBgSmVqzgeDZg3kMFd32wphs
         GJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555068; x=1712159868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWAslbWFX1XOSWwHcgJy6hHbIvWl+oqLgvo/gLbrYpc=;
        b=o/Ony6hGZPrQBX5FqJTbrIMpBmpbYdxgbODb6JkVeHcEtVI31UW7xxVw0zKeMXkPE6
         7oLRuOD/rXVpVIr5p8uYYtbXGe39xKNng5mf3J/3mzooDyOKSNyG76/7EX4naAhSjrDI
         IPqI2cPP8+kzxo22kK+0ixos46zFA8CnJ2aA12kH+r8xOau73vhnc9wwKcZaX4KoD9GK
         m7BFTQu/iobBCNDKGk3W2nogKN+OUd1x42f/tVMuXlw2cT4Vo2Kd4w9uUsbU4l/TkNPL
         QZ9FvccPXkehzVDxrsljRYkftg22ColV3MnhRfMeVwJMmMFwW7BWzVmsHGis4YbRElt4
         +AOA==
X-Forwarded-Encrypted: i=1; AJvYcCXYGW0XV5bvXoSEgUmo7oxATBiVVrJUAfs9ZXVk9bR7AHsXHgb/RJvGD3+THyEBwAmMb18r8U3aw7zqJQdvnhZpABsefzIMpRkMOQ==
X-Gm-Message-State: AOJu0YzZnD/8igvW4C2jYjl8OrAvBgkYDICkOhGU5v/cFJrEnWiymcWq
	zLnAI2ROJAO1U3s7B6Oo7xrPfQyWVAsEAkytmF9D8hd+kU4HhosX
X-Google-Smtp-Source: AGHT+IGF2rwpWvertbZ+ZhZOEBZCVaiqczD0RbkKX/QyoP/eexq9h5UhMnXGSsOTwXQEUA0PiDk4ug==
X-Received: by 2002:a9d:66da:0:b0:6e4:b891:c9eb with SMTP id t26-20020a9d66da000000b006e4b891c9ebmr189203otm.30.1711555067960;
        Wed, 27 Mar 2024 08:57:47 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:47 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 10/12] RDMA/rxe: Make rxe_loopback match rxe_send behavior
Date: Wed, 27 Mar 2024 10:51:56 -0500
Message-ID: <20240327155157.590886-12-rpearsonhpe@gmail.com>
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

The rxe send path currently counts the number of skbs outstanding
between the rxe driver and the ethernet driver to prevent too many
packets to accumulate waiting to send. This patch makes the local
loopback path behave the same way. The loopback path forwards the
packets to the receive path which will eventually call kfree_skb
on all packets and drop the qp references. This makes the loopback
path more useful for software testing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index d81440038f91..d081409450a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -386,6 +386,12 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
 
+	skb->destructor = rxe_skb_tx_dtor;
+	skb->sk = pkt->qp->sk->sk;
+
+	rxe_get(pkt->qp);
+	atomic_inc(&pkt->qp->skb_out);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
-- 
2.43.0


