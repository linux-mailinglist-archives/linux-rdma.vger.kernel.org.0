Return-Path: <linux-rdma+bounces-5360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F37998357
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FE1F21854
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B91BE238;
	Thu, 10 Oct 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgmZ/bed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CC4F60D
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555386; cv=none; b=Qp3ZFS3ZLigzdkDqK/q3HgBpJbIQdAdSxgZO4aD4O0zUCpMw9Er2R5b2P+XuDEFsApbMcchR2eOriPmKuSBa/ZaK9FqUssTTqfpwLXZ1ylG5ZP+eo7eNKqBdz6VtOtDgBW7h5HPxBnlTZK1LwRw2ingqt94rpq1Kj7oD2JoWgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555386; c=relaxed/simple;
	bh=Rbot+L++C2Nsb59xSBDOu65URzv0L2NSEciKOY5PmqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+xJeIQvvOXXQJqikLUH6Gx0S+1N+sjAuoM5/ISZut7gA1KJIkOUr0boC1rUOY56UWmyI1vigEjGHY2xIgEaqrKpcOhL4Ukuqqd9c+BaFf8CCmfUhSEPzrtWLy8pr7mpydRqOBN69xzaTUupjUR9cbG+qgaFzdYR9PCOYVnTXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgmZ/bed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811D3C4CEC5;
	Thu, 10 Oct 2024 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728555386;
	bh=Rbot+L++C2Nsb59xSBDOu65URzv0L2NSEciKOY5PmqU=;
	h=From:To:Cc:Subject:Date:From;
	b=CgmZ/bedk5wLNoEMXsGM+gPN9ueEgqta5hO0dL0xnpXDzJnfz9Sr62wjq6OEC5bvu
	 OHMVvnTYLz+AroO4pXMbco2WYnQrQOfZ0OVQFh+/2FqDIDs9nvpYOZAzlOjNoQKhbL
	 TcSWIzY0MXysGlKR+hT0p6+7DqRAypRI147Lt9r5bIurzhuPcDqu5v5KAdHx1Iy7sC
	 lFYdtpQ/XhFSW+Vg6ivUkp2Tdb08FAD43OS170w+YW7DhS88L6SFijJF88YYJjKc+S
	 asnXJG4l2bKitdCkOMueW6QGUCMSBUWE7OZOtqDVwH06kLqyiUdTrTEjgbFYSrGDDM
	 5bPdKodY9LZ6w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/ipoib: Use the networking stack default for txqueuelen
Date: Thu, 10 Oct 2024 13:16:19 +0300
Message-ID: <cc97764b5a8def4ea879b371549a5867fe75c756.1728555243.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

There is no need for a special txqueuelen value for IPoIB.
This value represents the qdisc size which is not related to the SQ
size, and the default value provided by the stack (DEFAULT_TX_QUEUE_LEN)
is sufficient for typical use cases.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 4e31bb0b6466..3b463db8ce39 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -49,6 +49,7 @@
 #include <linux/jhash.h>
 #include <net/arp.h>
 #include <net/addrconf.h>
+#include <net/pkt_sched.h>
 #include <linux/inetdevice.h>
 #include <rdma/ib_cache.h>
 
@@ -2145,7 +2146,7 @@ void ipoib_setup_common(struct net_device *dev)
 	dev->hard_header_len	 = IPOIB_HARD_LEN;
 	dev->addr_len		 = INFINIBAND_ALEN;
 	dev->type		 = ARPHRD_INFINIBAND;
-	dev->tx_queue_len	 = ipoib_sendq_size * 2;
+	dev->tx_queue_len	 = DEFAULT_TX_QUEUE_LEN;
 	dev->features		 = (NETIF_F_VLAN_CHALLENGED	|
 				    NETIF_F_HIGHDMA);
 	netif_keep_dst(dev);
-- 
2.46.2


