Return-Path: <linux-rdma+bounces-2237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E28BAB6E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 13:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324181F22A70
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E10152182;
	Fri,  3 May 2024 11:13:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6414F9D7;
	Fri,  3 May 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734828; cv=none; b=Thk+MN3vOufXr8JV2FdIqymCNAWwBizWI/DRY7gA1682ytSyzs7eKKGc+l3Q7Qyy7iAssO50v1ncNSXUpwypJYu5pwC4PoVvp6eKy5f1h4/r2qNzROamNWZz4aZOcq61xAF9HgoYuQmD7T/i0Vg5JB/KgjUzY8/i6GEZ5iYiJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734828; c=relaxed/simple;
	bh=eP7UrYAm+QXdT7GsbpqZgXK33rijqXS4hxtOIMaJM+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cz11+Zu0d+6mzguD3s/+6LOiftL4wRuZ7jeOHxXsy6aQOBoKN7T+erG3SP4R5Hnnw+Uv1smdgu4ABUX/PsgkrAtOuSlHNvXwyGY+/9uKiYnZz36SeYsa9575j0Ies05SkSOrN6C1/gIzIHaGuhSmfI1isR+qm4ZR4US83M5n5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51a7d4466bso1088818866b.2;
        Fri, 03 May 2024 04:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734825; x=1715339625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjeIuy9dzDTEtIZgB/dBWOi7o2OzXsFxxtGO6ENhPS8=;
        b=vEWqM0QEokyGJAFxAtZNBfDp70qaIpf5jeJOwc4jaDIMLpEkhZHdI0KOUOnC6BcbDn
         p+JKmNhgNvSvmuLKdkPKlCy30IAfmq5mMW7HlwxlmfIVb0PSyUmuEFbXcxidZpgMXnz9
         va6SQIBHxD6FsqCHsvy1wcgsjskz9RRW0d1Mnyu7kVIUus+DydCqI4Oa4kuWxA4seFuf
         6cUhl0+PGyQs9fF64BKqIrgGthstxDwi1pFH5furub4Oooeh1iJBZ/JnkSHySw1V0hg9
         npByLoDBrNIUdYPubdw6k0prxR2IXl2bU9g27ftOYLW1SPxJGkwJXaJBNsNgHXywzVPY
         5DlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiJf7CC4KdbDxhVzvJfAjsbhYBvxo9eKYHEt/WgG7hT/Y3UtYDMfNoj6+dD5aT179/bhod6UGte365Si9Qgq1aCgcPhBi0Dd89GMrEKinQms0BWbmgMxK8T8iOHHEtceV5OZsMjQbzHQ==
X-Gm-Message-State: AOJu0YyVFz52F90oMCfNRqdwXRKno2jpoEJljPKEQ4kEuBUc9vTJhj0d
	ZZuRzzkR6LKaSrt6Evvb82y7bk3VWSW+8G0genWm9n+ZWw6dqqnhBniLig==
X-Google-Smtp-Source: AGHT+IHJxQZVhIx315d2eMT4ER2zN7KMg67+sDv4OXDn7eZIjMXdEpmX9lpfpSRhmextaA64KUwc/Q==
X-Received: by 2002:a17:906:40ca:b0:a55:ac3d:5871 with SMTP id a10-20020a17090640ca00b00a55ac3d5871mr1312923ejk.77.1714734825020;
        Fri, 03 May 2024 04:13:45 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709063e5800b00a58bcb55704sm1561929eji.165.2024.05.03.04.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 04:13:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] IB/hfi1: Do not use custom stat allocator
Date: Fri,  3 May 2024 04:13:31 -0700
Message-ID: <20240503111333.552360-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of in this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the hfi1 driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/infiniband/hw/hfi1/ipoib_main.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 5d814afdf7f3..59c6e55f4119 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -21,36 +21,25 @@ static int hfi1_ipoib_dev_init(struct net_device *dev)
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 	int ret;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	ret = priv->netdev_ops->ndo_init(dev);
 	if (ret)
-		goto out_ret;
+		return ret;
 
 	ret = hfi1_netdev_add_data(priv->dd,
 				   qpn_from_mac(priv->netdev->dev_addr),
 				   dev);
 	if (ret < 0) {
 		priv->netdev_ops->ndo_uninit(dev);
-		goto out_ret;
+		return ret;
 	}
 
 	return 0;
-out_ret:
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
-	return ret;
 }
 
 static void hfi1_ipoib_dev_uninit(struct net_device *dev)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
-
 	hfi1_netdev_remove_data(priv->dd, qpn_from_mac(priv->netdev->dev_addr));
 
 	priv->netdev_ops->ndo_uninit(dev);
@@ -173,9 +162,6 @@ static void hfi1_ipoib_netdev_dtor(struct net_device *dev)
 
 	hfi1_ipoib_txreq_deinit(priv);
 	hfi1_ipoib_rxq_deinit(priv->netdev);
-
-	free_percpu(dev->tstats);
-	dev->tstats = NULL;
 }
 
 static void hfi1_ipoib_set_id(struct net_device *dev, int id)
@@ -234,6 +220,7 @@ static int hfi1_ipoib_setup_rn(struct ib_device *device,
 
 	netdev->priv_destructor = hfi1_ipoib_netdev_dtor;
 	netdev->needs_free_netdev = true;
+	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	return 0;
 }
-- 
2.43.0


