Return-Path: <linux-rdma+bounces-1578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E467B88CB33
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F4CB24FD0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFE64E1A8;
	Tue, 26 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7omdsts"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3E1D54D
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475084; cv=none; b=AcsIv+OFj3Su0bx+YTuCmDO8as3Z4anBiu59EmCgDBvbBoa8Lp6o+jzRxJgfPVe+mZrAFv91D4/y7WAssh2Bq6IluNGjfYaWuPkKOs1r0+aDMTvbsEwZZgIhySZVMf3DINZUgYyu3SehF+QvqTUvpiKhWWwYfTPbA85QMPkAHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475084; c=relaxed/simple;
	bh=DTnf6HEfg54WcZlJbM0UnOUOfT1SyJb8ehxXzVRsjls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9JOHpgJqZqa3COQ02YoGASqD8dkIUHDl0AxHnExQpSF+XkMDGPTewNnXkeiJYPB3s1tBhuJ4IbchvIqbIR3W3/jpQ2n/pcOR/nwnOS2auZkHRWlB0fI05hrxpICmBUAY50PgdWClgsKuEZyCilevDYEGi213Xcd8NAW6Wy0SBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7omdsts; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e696ee8fa3so19085a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475082; x=1712079882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0Gn+52B+bX6FQ71fiFjhV1CrL3vIObKr40YlCDrQRk=;
        b=f7omdstsEGr2NOD09EyGlZyVcCbjDU479kI0GK/xPJxk0zVLT+WU4shk+2tZLsgV2R
         b3olzJn3/naP3tp5WMf/FD/3rTtWNB7dUuOUCiGYW90Bj5HegxTD0Sem8y6pJMwMUV0F
         /AEKVKjeBSGxMgyPRR70+PtMDFB/q1AP+eN6ZRVkLQip1MUSb4QFhgwgrhK2OCAAdUfA
         7PPiGycSQudAfxQ6U74nbnH+/IKC1Q5mlel4ENCxip4N+yXEfhzI+vVO+LU90rDecaGB
         VWfmeOjFWpDw97FATJnH4VnJwSRVqVUsJy79qt6E7N5XYTMgvzFcQZfWmUWj8YzBLVXH
         zTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475082; x=1712079882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0Gn+52B+bX6FQ71fiFjhV1CrL3vIObKr40YlCDrQRk=;
        b=hIodgiIZxWt357zu8sf6XYfiehyusdZCxKGCEZ3Np4e/7XxvYmGRdA90TlK9CcGM6N
         c/T+MEsmQXudnvMpopMJbNc1giKIpcSd2qNAMTf2TPCnSilGwMv6O62eXW9BewUZjXaA
         WEYNMYJC4QrCHMjZPpsHDl1MwM2jb3CUjuYp550skzvChnbTpE3oOQ3DjxGnhxWtWXqj
         pneCvoMXubmH99j5upkVstMWl1/2g+zIca0y/6F8Y4MCv1GK43Xld9pskT1fwKSMJZzb
         CrWb9EwdeeWJ/nTWBX3KPf4tlhks01VJQxclpn/AhU1sOWlNgSTfVhom3b2BY1aBCO0Y
         f6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeC3mQKbRAT5bNJWfg/9ndiK/mept4PDWS5uPrb83pPwd0MaiAP7l4s+7Gcff8Koo6fAQp8F7lzQGlfbZWNgCp3JMYRNDKO3Ff0g==
X-Gm-Message-State: AOJu0YxrDPawPOgCt6F8h9/3lJBJh8TfyxhJWL/Rxu3Hw7FQaHAoTWn5
	nfqSbAhBY1N84MC2JNs4q6E8WO+NkUBKQImD3zXY3LQLb14wrH+r
X-Google-Smtp-Source: AGHT+IEyUIIZitmjkrtCgwdI37NynphbtszWDZlV6Ns7hcCgLrGfsgDBMWp7e/tVErkU4wXc0/g9pA==
X-Received: by 2002:a9d:7743:0:b0:6e6:8d2f:4013 with SMTP id t3-20020a9d7743000000b006e68d2f4013mr926119otl.8.1711475082087;
        Tue, 26 Mar 2024 10:44:42 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:41 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/11] RDMA/rxe: Make rxe_loopback match rxe_send behavior
Date: Tue, 26 Mar 2024 12:43:25 -0500
Message-ID: <20240326174325.300849-12-rpearsonhpe@gmail.com>
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
index d1dd440b1e4f..5b88ae29b509 100644
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


