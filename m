Return-Path: <linux-rdma+bounces-525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B38226B8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AEF1C21C9A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1C110D;
	Wed,  3 Jan 2024 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GZlNilYL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396C1869
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso3477751a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jan 2024 18:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704247300; x=1704852100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9J+xmhh3o2qb5UA/Lzz6b6u4mxmFjot2u0XPV7yids=;
        b=GZlNilYLnI1HKXYwNa2nl/Kow5L9hzkpRgA156s/d/e7eJgCpnXNnXDZ0Kwb6O2yK/
         fonOzsr6naC9/tRbV0snMeKWMXTlKYVG3Y/Yk5dQbkQYXHZNe/AvfLWi/GhDRmV00mrl
         k3bigFhLIBzruHFTJZ/hOHlSRl2gb9igndfS12KnbBE7gCAymm9O/T8gllE6ZyFWdvol
         kg/bRJImsZx8dhk3JexM86KEyh+RLnKzZJ7vGGLP4+BohIPC4pyimHVsuP2aN8JMIRwr
         GkbL5nNpgGrE73h5GyQpE9zqDz90/HxBEoaj2p/7nNSB2JBuMcSUluPyiLv9Lyu7n5On
         Hs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704247300; x=1704852100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9J+xmhh3o2qb5UA/Lzz6b6u4mxmFjot2u0XPV7yids=;
        b=OYeCw3upr5GeIBuN1sOU6iBU7TesdUIMFU1E5aihmus2c4te3YCFka0wV+Kz4A+lZC
         8Ub/0jmyzokh4KyZ3ljqlWV5tacgpzA8FejRjfFdaZ+n54w2IWbpknX7+Ry8Az5SGBBj
         u3egTVc6dmfOU1wPn/Jilnm/k+xE5imgHLRgqnfNdRhTRxbTszOfKO+FsBJsXKxn8ibU
         q6PtsIcE/5hHJwdO0hJ264EITquFzCBNp2v+8OrmFeEbLybKoWz5REVRWMgbYjKWXFjG
         te+T0sR8QbrHzUyQVsPGYA4+q7kpvYIpU1zZEtbna4Y4e3jI7bdoxBoVNQNofBRZQAO7
         Sm/g==
X-Gm-Message-State: AOJu0YyaTya6YDO5m1Tjd4FgQLHryGPmMfLcN/DHzMm7gONC+xBq8/lA
	cKenPe/aYwVLFo4i+3cbTWNaxExxHAqGGw==
X-Google-Smtp-Source: AGHT+IHYpc+u+PvWzhve1HA+xKDyqO8uARaCzWUFjOrIj83E8kxxjAfz4KrjUgcfRNs/xYIN5DYvdA==
X-Received: by 2002:a05:6a00:3243:b0:6da:2ee0:50bd with SMTP id bn3-20020a056a00324300b006da2ee050bdmr3230918pfb.53.1704247299704;
        Tue, 02 Jan 2024 18:01:39 -0800 (PST)
Received: from always-x1.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm14219784pfu.175.2024.01.02.18.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:01:39 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] RDMA/rxe: Fix port state on associating netdev successfully
Date: Wed,  3 Jan 2024 10:01:33 +0800
Message-Id: <20240103020133.664928-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, after adding a RXE device successfully, the RXE device
gets ready, it still reports 'PORT_DOWN' state. Set the state to
*IB_PORT_ACTIVE* once it becomes ready to access.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cd59666158b1..eafcb2351a7b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -524,6 +524,7 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 {
 	int err;
 	struct rxe_dev *rxe = NULL;
+	struct rxe_port *port;
 
 	rxe = ib_alloc_device(rxe_dev, ib_dev);
 	if (!rxe)
@@ -537,6 +538,11 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 		return err;
 	}
 
+	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
+		port = &rxe->port;
+		port->attr.state = IB_PORT_ACTIVE;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


