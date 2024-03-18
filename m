Return-Path: <linux-rdma+bounces-1477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1487E6DF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EB71F2231F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7D32DF9D;
	Mon, 18 Mar 2024 10:09:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CB2E62B;
	Mon, 18 Mar 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756549; cv=none; b=MgLq8FykALx2I0ew5pSG/pR+LSiLuAqtZvMX+MmB+tMbexDLuNov1ba64k9kC+UoHmFtGXHvegS75QzkN5+op9L1tKSUnfMCNDpd1qzjsBxnQrRxMfK7iolAGOJoP0Shy5ER1O/K/ASY7RD5vEyDIPYKs3CdfIwB2pR7YJM2VfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756549; c=relaxed/simple;
	bh=rWv0xQOrfw2zXF5/DS+hqr6aAayY6jeKTTspmHv0tZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=davn3PJ7SSVTfA5NWZ+D0ghdYOOVdqNkDfP96sPizqAJC4PSK8/+7II6hIux2m6hrN9i/v6LvIfQobpt54NE0uK46K3nvfwi7TkSzLsnhKxOOfmFkKKdfW8tSwIHhEYiYwUV+Qiybz2pvylQqkrNiJrts9dyl48T7VUla54tqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-568a9c331a3so3718871a12.0;
        Mon, 18 Mar 2024 03:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756546; x=1711361346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfrwM0z5dA/0if/lpb+f0heKeFjOBQb2hMQ2vWmWw4c=;
        b=EEcycR3MXPc6njIw3SOmX6Su1GyZhxVtqRaxZN5/xdZLZN6vr9yt4TdrB+FE6ZRMDt
         NjIRf0BQsdo08Hhc9Mu16CK25sZo6kn53Qv7SLWjtTiY2dnDA0daYRZ6GGanY/Q1QTUc
         dRse/97dhAKjVddgeOzM+731FKVLNneLD2RkqwzUr0Rd3lNdR2jSiIYmT/Rw7WiADjCM
         ZYD/88M9+We+5mq8+WycDEpXg8E0LqRz8rgANSmttj5ooHspm+JlrWRMWJPnYCX13ZwD
         pMSfaW2SvYFEjd+JWZJdjip2veFEsW8b1q8p/rzg400azQLoxy3GGWI2ou9r6k7ZBJg3
         sB9w==
X-Forwarded-Encrypted: i=1; AJvYcCX+zeW13Jfht3Zkk13LplQHAyyGo7Re/WiatBieB4fgYjaNaaEsdqqzBTth+kT2wRZtx3dogyJ28Cq0Mmj3ukslBkG4V5fc4/8TXio0itjeXbpceObt4WpzNZBlyQKxx+uogMBcCuRr/g==
X-Gm-Message-State: AOJu0YzM1WXZ8AMoBTR5Hh1fLi7CI5Oif3qXZj56LeQQZrvApxhvwWkq
	Qn/M0aV2sGrNgP0sgxn3mo/PxHcpbIx5GA3RuUzhc9lGPKgxGIefml9Ga2Me
X-Google-Smtp-Source: AGHT+IFcEjGO3MtFbLjYzh/N7Oza1ekaXnPr5iQVNUwdQ5IWy+JcuV05pFBHI2MwJCutaTGYeDsPzg==
X-Received: by 2002:a17:906:7304:b0:a46:c8e2:40f6 with SMTP id di4-20020a170906730400b00a46c8e240f6mr1055102ejc.1.1710756546019;
        Mon, 18 Mar 2024 03:09:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id jt12-20020a170906dfcc00b00a465f570dcesm4736531ejc.144.2024.03.18.03.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:09:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] IB/hfi1: allocate dummy net_device dynamically
Date: Mon, 18 Mar 2024 03:08:57 -0700
Message-ID: <20240318100858.3696961-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_device from struct hfi1_netdev_rx by converting it
into a pointer. Then use the leverage alloc_netdev() to allocate the
net_device object at hfi1_alloc_rx().

[1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

v2:
	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
	* Pass zero as the private size for alloc_netdev().
	* Remove wrong reference for iwl in the comments

v3:
	* Re-worded the comment, by removing the first paragraph.
---
 drivers/infiniband/hw/hfi1/netdev.h    |  2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 8aa074670a9c..07c8f77c9181 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
  *		When 0 receive queues will be freed.
  */
 struct hfi1_netdev_rx {
-	struct net_device rx_napi;
+	struct net_device *rx_napi;
 	struct hfi1_devdata *dd;
 	struct hfi1_netdev_rxq *rxq;
 	int num_rx_q;
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 720d4c85c9c9..cd6e78e257ef 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
 	int i;
 	int rc;
 	struct hfi1_devdata *dd = rx->dd;
-	struct net_device *dev = &rx->rx_napi;
+	struct net_device *dev = rx->rx_napi;
 
 	rx->num_rx_q = dd->num_netdev_contexts;
 	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
@@ -360,7 +360,12 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
 	if (!rx)
 		return -ENOMEM;
 	rx->dd = dd;
-	init_dummy_netdev(&rx->rx_napi);
+	rx->rx_napi = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
+				   init_dummy_netdev);
+	if (!rx->rx_napi) {
+		kfree(rx);
+		return -ENOMEM;
+	}
 
 	xa_init(&rx->dev_tbl);
 	atomic_set(&rx->enabled, 0);
@@ -374,6 +379,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
 {
 	if (dd->netdev_rx) {
 		dd_dev_info(dd, "hfi1 rx freed\n");
+		free_netdev(dd->netdev_rx->rx_napi);
 		kfree(dd->netdev_rx);
 		dd->netdev_rx = NULL;
 	}
-- 
2.43.0


