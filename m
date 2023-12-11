Return-Path: <linux-rdma+bounces-349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39580CA74
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 14:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B6B1F217F6
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCB23D3BD;
	Mon, 11 Dec 2023 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwcMbPib"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2FDBC
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702299876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=giFVLOTqkebo2x+oA3YA6G6HzBfr3m1iYomgrY5Darc=;
	b=CwcMbPibcoZbSyX7HdA/YBISK9AEt+waEIF0cwYMOoCbi6XvHDJ9bBvGb40vT6RfbJXch/
	oxeflk7U0f64SL2/Xb2ld19k5MSIcyuofTADj+lO6vda+td4C1yfccVjciZ+TF5Ig5wwnP
	c7XV09s9Cn2/c9TL9ywt93IyxvIPzfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-X5XFshiTM9O69vzQtEUuRQ-1; Mon, 11 Dec 2023 08:04:35 -0500
X-MC-Unique: X5XFshiTM9O69vzQtEUuRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D514D830F32;
	Mon, 11 Dec 2023 13:04:34 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 804F51C060B1;
	Mon, 11 Dec 2023 13:04:33 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>
Subject: [PATCH 2/2] IB/ipoib: Clean up redundant netif_addr_lock
Date: Mon, 11 Dec 2023 14:04:25 +0100
Message-ID: <20231211130426.1500427-3-neelx@redhat.com>
In-Reply-To: <20231211130426.1500427-1-neelx@redhat.com>
References: <20231211130426.1500427-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

A single memory load does not need to be protected by any lock.
The same priv->flags are fetched 15 lines ago without locking anyways.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 8e4f2c8839be..f54e0d212630 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -572,13 +572,9 @@ void ipoib_mcast_join_task(struct work_struct *work)
 		return;
 	}
 	priv->local_lid = port_attr.lid;
-	netif_addr_lock_bh(dev);
 
-	if (!test_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags)) {
-		netif_addr_unlock_bh(dev);
+	if (!test_bit(IPOIB_FLAG_DEV_ADDR_SET, &priv->flags))
 		return;
-	}
-	netif_addr_unlock_bh(dev);
 
 	mutex_lock(&priv->mcast_mutex);
 	spin_lock_irq(&priv->lock);
-- 
2.43.0


