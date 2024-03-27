Return-Path: <linux-rdma+bounces-1604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38E88EA15
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAF21C30D74
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5A130A54;
	Wed, 27 Mar 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFP4taEQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31B1304BF
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555072; cv=none; b=NT8h5etsKFFyo6P4WDIa5JHeA6MkxjsMu/4SJNb4q5qb5vAYn/Z/S3m9YmtMMPm9FpsNmk2pe7M/4SslvJGhFTjfAdISTbXaRQLCp6lKy+R6qH91eloBYhLgK90FHa4Y0h0diz4pnEYBz3g2+uoZtR5bqdFfc+riYIFBpZGyEw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555072; c=relaxed/simple;
	bh=AilatBEBLSlh107RF2GtLCHpfjH+1ao7MSzuIpuO8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDAbkwr7F5PC1W4qlvX6/Hvme/issT3GSgyeWpVa0UMHlX9i30xUMlGZgDpBho3bixirQHeRg0jsGQLavODgh/XDIhe3Y6yE7OqxDQx2E6hOFyK+ntKGWhXM3zGuiPCAlviQTh4ZCCW+qPJsAyjxCS1WFwa800dyM8s4Zt+T2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFP4taEQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4f7975121so1624121a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555070; x=1712159870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSjXTA0jQyt41K1i3R8cdCOpeg1vn6KbYe9akb1dy5Y=;
        b=PFP4taEQYIJdHJmBZeDrU5JNbqCmLG9mklZp+MiXnUv0Ss0EemlncwLGs0jpg5uD80
         jO23h+A8gH4XS4kbBqJJLmO67k0318QO3X4kftRfddonuJ1O5LVpjL5EbpC234PvZfWN
         vVkv4U0Id4XmetXo1Bm+rWIhvltWT0iFtGuzvdm3tmDcckET7O+jEVAEPw738vBBdBg+
         7h7yU2dMZtKnqhNLQ/jugyPXF+dAKO6zCaVkkJWNaCqiw43UKmKypPZm6bqEUcve6OuL
         xh6h+GQyt25TUvZHB+vvFEBNWubCiGOseOmfZW0OQ4E/Q4B6Ow5n6gslygW/K53/XoAz
         E0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555070; x=1712159870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSjXTA0jQyt41K1i3R8cdCOpeg1vn6KbYe9akb1dy5Y=;
        b=HTH3AvIsZ8CKk6+wh3CPSTVb+D93H/nPtKxY8BeGajaZUAC1zuONRVMA8MlNAXn3nK
         eRtxCSZhLoDORi8H4mtYmE7q7AkPK5wWSFmBDDHTpUrWjJDwPvII6ltHGAG0RdGTyRtg
         PfjqZR2bSY3rKUl/GrO3jGhI+9jg9YpjUooZzOKv8D7FQ6jHpr+K9g2wTySmBpinfvqJ
         VbEQiKiEMkAkjkENZvBafWFVBIKWgymq6MU9gSpdRZFIG081H00WLltcCTVThmMI6mjM
         KJg87/Sc9m3qnjDQyCioUpND+g73jDWvoeTh20PSUSjcTkop39eTe1kR+i08/U9yx9sq
         VbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhJTcEEj8/bejuLmQSzK64RGBYwrvSYt6NT92c+OzKqQEbSlJ6yQ82Ad+yT2DldDuiE7sUpIImd7bnL4Wj+Av85ZPC4t5wViXKGQ==
X-Gm-Message-State: AOJu0Yyjd0ad1DqoQ5VbQghhK3OGPlRc3obA7MhYZwbsLRk8GrQQiSki
	vhAPAOuG6/EmZOU72jIr4MKlCkL/g3KiYyKuKI8qGUmeKIFL6C2I
X-Google-Smtp-Source: AGHT+IHkHF+TBF0CPf7bLj7iIcWhZ0waduptM9XuoJALZW51EWAlshMCajnfYZTMrakz7NOggg4qBQ==
X-Received: by 2002:a9d:6a97:0:b0:6e6:715d:a63f with SMTP id l23-20020a9d6a97000000b006e6715da63fmr389091otq.30.1711555069987;
        Wed, 27 Mar 2024 08:57:49 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:49 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 12/12] RDMA/rxe: Let destroy qp succeed with stuck packet
Date: Wed, 27 Mar 2024 10:51:58 -0500
Message-ID: <20240327155157.590886-14-rpearsonhpe@gmail.com>
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

In some situations a sent packet may get queued in the NIC longer
than the timeout of a ULP. Currently if this happens the ULP may
try to reset the link by destroying the qp and setting up an
alternate connection but will fail because the rxe driver is
waiting for the packet to finish getting sent and be returned to
the skb destructor function where the qp reference holding things
up will be dropped. This patch modifies the way that the qp is
passed to the destructor to pass the qp index and not a qp pointer.
Then the destructor will attempt to lookup the qp from its index
and if it fails exit early. This requires taking a reference on
the struct sock rather than the qp allowing the qp to be destroyed
while the sk is still around waiting for the packet to finish.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 42 +++++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_qp.c  |  2 +-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index b58eab75df97..dc22f3922a59 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,25 +345,44 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
-	struct sock *sk = skb->sk;
-	struct rxe_qp *qp = sk->sk_user_data;
-	int skb_out = atomic_dec_return(&qp->skb_out);
+	struct net_device *ndev = skb->dev;
+	struct rxe_dev *rxe;
+	unsigned int qp_index;
+	struct rxe_qp *qp;
+	int skb_out;
+
+	rxe = rxe_get_dev_from_net(ndev);
+	if (!rxe && is_vlan_dev(ndev))
+		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
+	if (WARN_ON(!rxe))
+		return;
 
-	if (unlikely(qp->need_req_skb &&
-		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
+	qp_index = (int)(uintptr_t)skb->sk->sk_user_data;
+	if (!qp_index)
+		return;
+
+	qp = rxe_pool_get_index(&rxe->qp_pool, qp_index);
+	if (!qp)
+		goto put_dev;
+
+	skb_out = atomic_dec_return(&qp->skb_out);
+	if (qp->need_req_skb && skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)
 		rxe_sched_task(&qp->send_task);
 
 	rxe_put(qp);
+put_dev:
+	ib_device_put(&rxe->ib_dev);
+	sock_put(skb->sk);
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	int err;
+	struct sock *sk = pkt->qp->sk->sk;
 
+	sock_hold(sk);
+	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
-	skb->sk = pkt->qp->sk->sk;
-
-	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -379,12 +398,13 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
+	struct sock *sk = pkt->qp->sk->sk;
+
 	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
 
+	sock_hold(sk);
+	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
-	skb->sk = pkt->qp->sk->sk;
-
-	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c7d99063594b..d2f7b5195c19 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -244,7 +244,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
-	qp->sk->sk->sk_user_data = qp;
+	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
 
 	/* pick a source UDP port number for this QP based on
 	 * the source QPN. this spreads traffic for different QPs
-- 
2.43.0


