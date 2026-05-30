Return-Path: <linux-rdma+bounces-21535-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WILwJf0rGmoj2AgAu9opvQ
	(envelope-from <linux-rdma+bounces-21535-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 02:14:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B760A0C7
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BCF3054C2A
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C561FFE;
	Sat, 30 May 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2r4K0dX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5317555
	for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100088; cv=none; b=Ilcamx5ND+JaYq4Q2ucYlzaP9+3jd1mfxaHWBjgzIG972ns295GiJBvR5Ie1NFJom/qKW2C7ELReFa5vjspo1/NyYo3tSavDjPz6xwxpFugdfAGFaqRQLnL8a8w7JKgXQnO9d9EoXuUh7o3EGQj6ouE3ndz+qQ8Ff3egi3pDxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100088; c=relaxed/simple;
	bh=uNKQJ6I+65vk9eSMhn800ZAbT1bZnwnHgdAp9iA9rWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcsEy0FkCMAZ3fcvEf19DMiJyOng4e/fMGTa8wXV99XGWRS92TKtIs/Oxk7YGmuTzfuZtVKTWOcoCBm/3o9fPVnpF7Feo9o97xorW9WfZ556JiOVBrCEJpxZ/0/lj8S+5nh9A25I0OF2epX8OdNBatZJt0k9Ig64X7IQa7v4H3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2r4K0dX; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-485fb0b20b2so328663b6e.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780100086; x=1780704886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgPte3THu4lgDNo+Mz00fPQ8ki83JRI+Ap5FBqVI8rs=;
        b=Z2r4K0dXRen0JVYtu73n1WEIaq/l3xdi91eBpPMDBaofs5LarIZA7za2hCxV/98cm8
         QeTz3qylb+WDKY4+xBHJMgITbLF8xa0j4a4QgsojcvQZBPsTJFzsrORWW19GYk4YYzkg
         8+S3bvXU9ZCoRddS8kcT3DAwNVu3qY5eSqX3dRMG8V3h3OZc1EroxkY07Qi8uBLhATgO
         n0U0eZrzt2sF9DQnEv6osKaaZf47JmZ0DWN9vlxdz/aTBqTywvQbyC3WBbIGFWeHWsrN
         GeXa/lPcmdW9YXwdLj8z4/wekwYWVet5i8RMgqdsCL35EURiOtYRZw4XVrSBXANrBwVk
         gbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100086; x=1780704886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgPte3THu4lgDNo+Mz00fPQ8ki83JRI+Ap5FBqVI8rs=;
        b=Ds3RS5wux0Bwn9/SbODCyxqeZtyXlYhnkQSl8Q1MXnxAUJiGiOeBaL6FQ9USey6iGA
         yOmF8NX9idxGDCOl+9IFfAkzBExA3+AE2jgKnpfHmvh1xRZ79LJU6XOelavriSAzig/W
         Me0Z9CT9KehsjYnYOs64vT0QW5ZP4+zDGHZWbnA2UIl8xNNbTnuDLwLCt7f1qQWYRPr6
         WbGs7IeNwCql0wyvUTKBhjQZqE3kq7wALLZG4qX1g0ewTNC5AjErexdHuO1qN3l5NytA
         4Yrk0Erud8NrNTnPvr5x6N4kD8LOuqEjc0VZPRbLOKcICwEJCNGWRVFA1NtF8nrbpgvi
         1r1w==
X-Forwarded-Encrypted: i=1; AFNElJ92LPJcWU8q+BtDtkPdBNvT+Yp456V2vF5HRPWZ/jBf7zwcmKolfABBBjbzmoAx0d6SFE/mqZBzuNm4@vger.kernel.org
X-Gm-Message-State: AOJu0YznJSOpb9rcWz/v8H0uAjyZvsMtOcD7tNkt0hRcizmqvtAH4v1T
	zYbrUe2XdA9tOcUEE0H5xfwDCrmvNIByTVBHJ5xcWIVc8cRrL90lcnud
X-Gm-Gg: Acq92OHGcZlC2m8cobGZp1IZyr8jjcKdx2tZZrzXzvdFdIV5bd+ZR1tpUboMM/I/P9K
	+pcM5+XgY4lFdQsdbQy13Lm10Gb1IV9rsg+2G/cze2IYHbIoK7dC9hr/BNGiKcwCjXS109uNY+9
	WtboAiNKvbdbe/33CuEeA0GcJ+xmc2NTbHGL8JwkPrXGpXLFmqat8Z4IkxA1RJZyQT+dGyufewa
	CYs8/Dg9atIVX8BV+DPIr1TbgjYQDMP1+GIs4WUYBR+gpJtDBNztfLEV58/P9ehOvXeajggEYnM
	Dp8CEC/Y3ZDhwHdKcxdOF+9efp1Z/YzYy9McZ0u8O73QRDLQ9vQuMw62TID7W0svqHYEfOmhsYn
	eKywRZmb8awqyQomaK7PPh2gZIfLvCNX1ImICZ4Ubi6UeozvpgHSMEB/ZkcabF625aAbg7TuNy4
	KBAi5T0qjzQ+GThGvUhrdIH8IZkwN8efa/OPvsGbsXba9XutncoxAHCpPUUTfhhE09GYO72WWhe
	Ko0FK91AoqfAtsCkh7JYGyUrh1pshRCpTqRGBGat1tnrzzWhqWgB7mCKkd78eY5dGrfPQBApFPQ
	JYlQGy+ug4M=
X-Received: by 2002:a05:6808:2516:b0:467:2f84:b0c6 with SMTP id 5614622812f47-485fb24e48cmr1018243b6e.8.1780100086346;
        Fri, 29 May 2026 17:14:46 -0700 (PDT)
Received: from instance-20260526-181250.us-central1-a.c.kernel-lab-497518.internal (28.92.116.136.bc.googleusercontent.com. [136.116.92.28])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43c93a22caasm2564178fac.2.2026.05.29.17.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:14:46 -0700 (PDT)
From: Purushothaman Ramalingam <purush.ramalingam@gmail.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purushothaman Ramalingam <purush.ramalingam@gmail.com>
Subject: [PATCH] RDMA/rxe: fix UDP tunnel socket leak on rxe_newlink failure
Date: Sat, 30 May 2026 00:12:51 +0000
Message-ID: <20260530001251.11136-1-purush.ramalingam@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21535-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[purushramalingam@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EF7B760A0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rxe_newlink() calls rxe_net_init() to set up the per-net-namespace UDP
tunnel sockets before calling rxe_net_add() to create and register the
rxe device. rxe_net_init() takes a reference on the IPv4 and IPv6 tunnel
sockets, creating them if they do not already exist.

If rxe_net_add() subsequently fails, rxe_newlink() returns the error
without releasing those socket references. The normal teardown path,
rxe_net_del(), is never reached because rxe_net_add() has already
deallocated the rxe device on failure. As a result the tunnel socket
references are leaked and the per-net sockets bound to UDP port 4791 can
never be released.

Release the references on the error path by adding rxe_net_uninit(),
which performs the same socket teardown as rxe_net_del(). The shared
release logic is factored into a helper to avoid duplication.

Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
Signed-off-by: Purushothaman Ramalingam <purush.ramalingam@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c | 32 ++++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_net.h |  1 +
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index af39209d0fcf..bcc72b96ee00 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -243,6 +243,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		rxe_err("failed to add %s\n", ndev->name);
+		rxe_net_uninit(ndev);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..b98f66099dea 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -642,18 +642,10 @@ static void rxe_sock_put(struct sock *sk,
 	}
 }
 
-void rxe_net_del(struct ib_device *dev)
+/* release the per-net-namespace tunnel socket references held for @net */
+static void rxe_release_sockets(struct net *net)
 {
-	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
-	struct net_device *ndev;
 	struct sock *sk;
-	struct net *net;
-
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
-
-	net = dev_net(ndev);
 
 	sk = rxe_ns_pernet_sk4(net);
 	if (sk)
@@ -662,6 +654,26 @@ void rxe_net_del(struct ib_device *dev)
 	sk = rxe_ns_pernet_sk6(net);
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+}
+
+/* release the socket references taken by a successful rxe_net_init() when a
+ * later step of device creation fails and rxe_net_del() will not be called
+ */
+void rxe_net_uninit(struct net_device *ndev)
+{
+	rxe_release_sockets(dev_net(ndev));
+}
+
+void rxe_net_del(struct ib_device *dev)
+{
+	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
+	struct net_device *ndev;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
+
+	rxe_release_sockets(dev_net(ndev));
 
 	dev_put(ndev);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 56249677d692..d55aacce2905 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -16,6 +16,7 @@ void rxe_net_del(struct ib_device *dev);
 
 int rxe_register_notifier(void);
 int rxe_net_init(struct net_device *ndev);
+void rxe_net_uninit(struct net_device *ndev);
 void rxe_net_exit(void);
 
 #endif /* RXE_NET_H */
-- 
2.53.0


