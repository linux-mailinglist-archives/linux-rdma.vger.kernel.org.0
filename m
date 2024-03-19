Return-Path: <linux-rdma+bounces-1482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCC87FA67
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5562822B1
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9B7C0B2;
	Tue, 19 Mar 2024 09:09:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9717C090;
	Tue, 19 Mar 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839393; cv=none; b=lnrzWZ64ZZy/wUQp1xbJo250mQsucfBlMGTO7oTjdSiSXipeN1czsAHR+dhEiQAJ0Q8Fov3mq/vCSCRqrQaDJGBU3Dpah3stdYxhqr+wHxkoD8VbZ5zOszLqujJ7YqC8CDqBM+8Yq8hvlxUwug98N+F8jLiUCbJ7LaxwDJ+Gdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839393; c=relaxed/simple;
	bh=EtRYh4nV23koP1b34l5lWPqF+hq36pBImX3IxMAQF2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMP9akXTpnSwBYpzB0X/UWxIWXgOTPwZCiuTLkG5O8RpfGtZUu1uNuxE+/UfwUCnlqHeHd4N2/KcN+iaVcakY6zhpxGSpI6PX1njaK1TWPJzEyCTLROvHgaPQ/3U8ZAg5TZBi40SYBDuSd7PVBEDzxUn3ui7Nzc8JfyFDMZwFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6665555a12.1;
        Tue, 19 Mar 2024 02:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710839390; x=1711444190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWbPYIc2yreZZU4F6NEHsTtZafoo5/fHquHKdIa0meg=;
        b=a8NHquA82k4IPFrcAtVJHWyAE5UnHcTNVlNfax6HtTWwS5KqeIvyOMqyzrtJrWaNy5
         Cw6u1Frx3IfeLt4HuZ0OrZFBpDzHp/K718Bj0KesV6PcNb6vDmUiO4c7YhtE4lBaouBZ
         WO8dyBeYF7f9Q95AAZFlTBVmZKStkos/Lw1TrNB2YXUwAP6OiIDrwxyIb6YyxHZ7ap+L
         ibbazkaKBr4JG4xVM6f7bBBmBbRhCmcEWvOdHE8rCJil4KRTaOpAH9YCqi/cneLHfnOR
         fa5GjeB5WNuTpZwAzW+p2HJMWU4jjy8RPFFXpHYbvXExxsNpi2h4tjBoYERwF7ZJbOzP
         D63A==
X-Forwarded-Encrypted: i=1; AJvYcCWpubn5Zhp5nHCTBvW8yMZ4mf3p4R6ZyglUakG2OIhR7GYETU0FFjprKDZdJGDUVE/EJgqb/gnO6ab7n7LfPbywwuSM0MjsQXe87dD5juy0yvDmkPcIeJ2SE6WRnsygyswU5UE7DJn69A==
X-Gm-Message-State: AOJu0YxGqM+MmCu5LSqvdZ65pX54FTu1qPYK1GlzWetpmhftXsXqUrfz
	e94TWMBY6BIx3sISeovj6JR5J2uWFGEOpO8vLDRdSJxk0i/ChXKW
X-Google-Smtp-Source: AGHT+IFxZOCf+I3ipaGM55sXiVF5KsEpokvnA+T6qrwCWyl9Ob3DhQFUnTKhKs12GIPDUiJos3ZazA==
X-Received: by 2002:a17:907:724f:b0:a46:70d1:dda6 with SMTP id ds15-20020a170907724f00b00a4670d1dda6mr10642514ejc.28.1710839389806;
        Tue, 19 Mar 2024 02:09:49 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b00a46c39e6a47sm1846660ejj.148.2024.03.19.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:09:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org,
	keescook@chromium.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
Date: Tue, 19 Mar 2024 02:09:43 -0700
Message-ID: <20240319090944.2021309-1-leitao@debian.org>
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

---
Changelog

v2:
	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
	* Pass zero as the private size for alloc_netdev().
	* Remove wrong reference for iwl in the comments

v3:
	* Re-worded the comment, by removing the first paragraph.

v4:
	* Fix the changelog format
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


