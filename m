Return-Path: <linux-rdma+bounces-2177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727808B7CB9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D36C285471
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18011179206;
	Tue, 30 Apr 2024 16:22:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A3176FA3;
	Tue, 30 Apr 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494143; cv=none; b=Sqv4RdiXo9hPKKXEaiuXSCmF4spxUxkGoFSjl8Kl5fv7qRnCWs5tbuCvM6zVduedjbm38MEfgzjdkX3tmy8zj90pdMdCvMPuA8IJvh1cLA4cT/DBI8aOrlTWanWhShevTcUiggxoOZf7g3P+kq/aHX6JwMHlzIt1ZAlXP+5Djbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494143; c=relaxed/simple;
	bh=wiE/AfqPKSDqNOLKJVGUPtAoneW/rv2xJoU+GmBvSLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3M46+wGLg/3CwvIo9t+vOMi8wCB70YszFOin56NHfVOgfRta+wkALJRO9aOKvPCWtPZx0Z4B3fUGKIsH+LGRZ0B2dlqnZxEJYHu+yxC7F7exhzpR3g2zZYNfRBrVBLeNnJmMpH41ypyeJZuHySjpSa2rGDdp4cOkQ6njcvwtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5724e69780bso6533403a12.0;
        Tue, 30 Apr 2024 09:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494140; x=1715098940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh3w3tJZLJoXAn1kpTmfu5KyLCxkf392Ej+D7gM9us8=;
        b=XClVRDdNolgbdLcF7c15kwnF++CEMbciAJLfScAbmoqBm0WnZq3G+64qofC/Zg5v0T
         tq7rhEJbsdQRU6vWBSEiJBgs3mgfvjevq1IXbjKs2ai9Ma6l1WAbAfWaNWNsAHzf+AZP
         TdQMOI+eyf8PPwJCT2Gjs++yR9v59QIQE3oqfexZoMB9OCEXf60ihiWbKr7J3NyiE2w4
         t0bk8DiGWIhTxTMJZct9Y2ZBsgbWLXiRPEvuYQKa0/1EZJEyNQI0wp2s/xZ/bbGy/3jK
         aChoHOuo3eav1azTkdYWss/uFPfSpAOWISlfJy9xuLu8FUwyDDwLXxUo/fgO26ZBzSbq
         in6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFCJ3L5dD/iZ/023Xkbv4Mt3x3+QIONOUXbjItbH6garanwCh6bGGA9fHYcykJAlcmZnkSwTyqoQQupdCQeYqIP3/YCD5+0K8YXpVTcJebz9WM1SeRF5kgWvBCveugqYsEghxkOxdE8A==
X-Gm-Message-State: AOJu0YyWcNraTvlqtPZ8UHHz1JHNhovnO2L2D/Gz8m17HOZi7cok7UYn
	2sh4MrA3do9NXVdUK6q/pTGhKPxJLciZvfom4nJlXv4xDYedPckz
X-Google-Smtp-Source: AGHT+IFUOUw/i/8VyDpVeOGSU8MsKta1qqf16mfYxCoE53AjnN9F0KQ1rEcPwZZa7f5+T5F+5cjAgQ==
X-Received: by 2002:a17:906:471a:b0:a58:8d65:65cf with SMTP id y26-20020a170906471a00b00a588d6565cfmr110416ejq.19.1714494140065;
        Tue, 30 Apr 2024 09:22:20 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906434d00b00a51e5813f4fsm15489969ejm.19.2024.04.30.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:22:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RESEND net-next v5] IB/hfi1: allocate dummy net_device dynamically
Date: Tue, 30 Apr 2024 09:22:11 -0700
Message-ID: <20240430162213.746492-1-leitao@debian.org>
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

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog

v5:
       	* Basically replaced the old alloc_netdev() by the new helper
          alloc_netdev_dummy().
v4:
       	* Fix the changelog format
v3:
       	* Re-worded the comment, by removing the first paragraph.
v2:
       	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
       	* Pass zero as the private size for alloc_netdev().
       	* Remove wrong reference for iwl in the comments
---
 drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index 720d4c85c9c9..8608044203bb 100644
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
@@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
 	if (!rx)
 		return -ENOMEM;
 	rx->dd = dd;
-	init_dummy_netdev(&rx->rx_napi);
+	rx->rx_napi = alloc_netdev_dummy(0);
+	if (!rx->rx_napi) {
+		kfree(rx);
+		return -ENOMEM;
+	}
 
 	xa_init(&rx->dev_tbl);
 	atomic_set(&rx->enabled, 0);
@@ -374,6 +378,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
 {
 	if (dd->netdev_rx) {
 		dd_dev_info(dd, "hfi1 rx freed\n");
+		free_netdev(dd->netdev_rx->rx_napi);
 		kfree(dd->netdev_rx);
 		dd->netdev_rx = NULL;
 	}
-- 
2.43.0


