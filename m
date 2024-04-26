Return-Path: <linux-rdma+bounces-2086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A128B3368
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB41F2324C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51313D602;
	Fri, 26 Apr 2024 08:56:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65913D535;
	Fri, 26 Apr 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121777; cv=none; b=LFnM+Z8Z3bgl10zXOPmoWehfCEojavxoFNv8DPtWQRE/jCkc5Esl5nGjejYi/IACxoKBOPV5kfPGTeUD4xGRIoZq+1PYctA1GzaLY0+yXdR7i69Z8+cD7JhYzyUCfhWSEO791bVs6h34k2FcA9i0vyiOGqSPJQGSdTX+yv0S/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121777; c=relaxed/simple;
	bh=TN2MDC62aSxpWPO7K27ZKh2RncHZwIxICGturcdor8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8ZjaJbZFMX+8ipw0iw4roE5nSGxJx7rb5MiaP3D+1EbVo9dOuGfED53ZPw75GQZTD4JUbRhcO/Ll/YvkyP0LRdmr0G1OOzL2SFCQMqYLTBysn8LH5ds8GwOzt8uX8GENNcPjfFA+RTxTnof1XqtTZMJcQtQGUqBMATZWWX7KFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57255e89facso444477a12.2;
        Fri, 26 Apr 2024 01:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121774; x=1714726574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdCHvyGtu2IuAGQ1v8z+QGjeZgpYP0HQg7EZfiL9dcs=;
        b=pui+rB1StvhxyMbXBzj9lxSjBvyglg9voKdjpzhwTrlJTb9lj0zLURLXy/Pkn8H+Dl
         P7h1mZorcrE0dLtH6nlhGOWz1HykGEeAClrsqvyntvDgIKLV5+usceQPC5boTcovsjVE
         wTfnA/obMFVovDoQcSBK4NQcK3ir9/4ve5pyoMGDkW/AwNr8+WBd5AUqPlNW505XIyj/
         /KbnqYefyPmh9hImPpHZdgpE0OGtT81FbTzdS/ju9FLLUh8H4RaPuwJ6bZuvKjF/B9EH
         4kr6MVVXWgum20gvMKYx0Sf1OF3rgqym8wLdqsXbypLkOF0CDrUbLBHhVDht1ufQKCWF
         e0tg==
X-Forwarded-Encrypted: i=1; AJvYcCUzs+kIyKEUkT/cs8rBuImZ9HByFUG3R+8T0cnY5VG3U85igXSfGw/gbnXieShUUDWBSHESSk5LUKq3IKcOsKoYt+Tzn56H07AWe1pGwwJF/wfMlS2xCYayUsFvgQuL0bPXqn1wNzmi7A==
X-Gm-Message-State: AOJu0YwbHOH+lfLbm0IKceXnXZjda8fgfSjHBtg/+KLMPUUAaiBHzg5Y
	nFVy97gIdBtq+oRzmyjfx4SjrUKWfH30l/t117VUA0Aj9lxcZSD1
X-Google-Smtp-Source: AGHT+IFG7X1LPkB/SKJQPX2y3CfNvn+oiiS0Wt5AAzrSgx+qgOOlahDHTIYpXM9XhaGqSO7ySNlPNw==
X-Received: by 2002:a50:cc48:0:b0:572:52c4:3658 with SMTP id n8-20020a50cc48000000b0057252c43658mr1389300edi.14.1714121773533;
        Fri, 26 Apr 2024 01:56:13 -0700 (PDT)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402248a00b0056fe7c5475bsm9810246eda.10.2024.04.26.01.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:56:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Date: Fri, 26 Apr 2024 01:56:05 -0700
Message-ID: <20240426085606.1801741-1-leitao@debian.org>
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


