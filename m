Return-Path: <linux-rdma+bounces-15612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920AD2C775
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 07:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAFFE303C62A
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 06:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5870134DB54;
	Fri, 16 Jan 2026 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aEPHJpuW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA232D450
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544470; cv=none; b=C57FaJrZrMycfQeyePsbFCejPiTQ2oB9+iWN6A5zgK+boFcc3VGZxJR7slGwcnOIQWue3hNKnNE7rLmFazD5ksuaKgSvnowFPn7OecEVm2TjNTJNyroPoIVoo2p66xO7DWzhHn/yEkcx6l4fN/6MXWZRZBuq1NhgG9WYPx2fRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544470; c=relaxed/simple;
	bh=n/Cjiz4enSqA28KJSyzX1xZU0qLNvqt0othrhYOgbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIKd2MZ1rNzaZ5hoegIouw5/J48YpeVrUXkhqTIBfkO613w0lsl9wU6SIZaODIOWv3jSghK0/5FIXeLsSq5mpvC2G2PmIErKWOjMK3Qxr1lVU15StDk1qatJhN+8EVPKqwL53djX38dca4UwuEKljuMAKZQNDs05kUsCUvQCozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aEPHJpuW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768544466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j4j5zWZbjDJTpAgq5afXR42uW4v94hZCLbOAgpx00es=;
	b=aEPHJpuWxo6pmMicnk0zgpU41mDGQ12xvQSGgUDjSHgiKri/kLLTI7UsCq6RTd0fVQsrLI
	XwLrslp4v8b6F+WxDzN6DqL8mrqKNC7QEtJV/OpoJwtXAg7Un/OZg4aWvFEaVJuq8Wf1sL
	u0bD2kBy834DyG5+bvDOhDB207idMPk=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 1/2] net: remove legacy way to get/set HW timestamp config
Date: Fri, 16 Jan 2026 06:21:20 +0000
Message-ID: <20260116062121.1230184-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With all drivers converted to use ndo_hwstamp callbacks the legacy way
can be removed, marking ioctl interface as deprecated.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:
* added cleanup in Infiniband
* adjusted documentation to remove mentions of legacy way
---
 Documentation/networking/timestamping.rst |  7 ++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c |  6 +--
 net/core/dev_ioctl.c                      | 60 ++++++-----------------
 3 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 7aabead90648..2162c4f2b28a 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -627,10 +627,9 @@ ioctl(SIOCSHWTSTAMP). However, this has not been implemented in all drivers.
 --------------------------------------------------------
 
 A driver which supports hardware time stamping must support the
-ndo_hwtstamp_set NDO or the legacy SIOCSHWTSTAMP ioctl and update the
-supplied struct hwtstamp_config with the actual values as described in
-the section on SIOCSHWTSTAMP. It should also support ndo_hwtstamp_get or
-the legacy SIOCGHWTSTAMP.
+ndo_hwtstamp_set NDO and update the supplied struct hwtstamp_config with
+the actual values as described in the section on SIOCSHWTSTAMP. It
+should also support ndo_hwtstamp_get NDO to retrieve configuration.
 
 Time stamps for received packets must be stored in the skb. To get a pointer
 to the shared time stamp structure of the skb call skb_hwtstamps(). Then
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 300afc27c561..4a504b7c4293 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1831,8 +1831,7 @@ static int ipoib_hwtstamp_get(struct net_device *dev,
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	if (!priv->rn_ops->ndo_hwtstamp_get)
-		/* legacy */
-		return dev_eth_ioctl(dev, config->ifr, SIOCGHWTSTAMP);
+		return -EOPNOTSUPP;
 
 	return priv->rn_ops->ndo_hwtstamp_get(dev, config);
 }
@@ -1844,8 +1843,7 @@ static int ipoib_hwtstamp_set(struct net_device *dev,
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 
 	if (!priv->rn_ops->ndo_hwtstamp_set)
-		/* legacy */
-		return dev_eth_ioctl(dev, config->ifr, SIOCSHWTSTAMP);
+		return -EOPNOTSUPP;
 
 	return priv->rn_ops->ndo_hwtstamp_set(dev, config, extack);
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 53a53357cfef..7a8966544c9d 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -287,7 +287,7 @@ static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	int err;
 
 	if (!ops->ndo_hwtstamp_get)
-		return dev_eth_ioctl(dev, ifr, SIOCGHWTSTAMP); /* legacy */
+		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -414,7 +414,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	}
 
 	if (!ops->ndo_hwtstamp_set)
-		return dev_eth_ioctl(dev, ifr, SIOCSHWTSTAMP); /* legacy */
+		return -EOPNOTSUPP;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
@@ -438,48 +438,23 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	return 0;
 }
 
-static int generic_hwtstamp_ioctl_lower(struct net_device *dev, int cmd,
-					struct kernel_hwtstamp_config *kernel_cfg)
-{
-	struct ifreq ifrr;
-	int err;
-
-	if (!kernel_cfg->ifr)
-		return -EINVAL;
-
-	strscpy_pad(ifrr.ifr_name, dev->name, IFNAMSIZ);
-	ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;
-
-	err = dev_eth_ioctl(dev, &ifrr, cmd);
-	if (err)
-		return err;
-
-	kernel_cfg->ifr->ifr_ifru = ifrr.ifr_ifru;
-	kernel_cfg->copied_to_user = true;
-
-	return 0;
-}
-
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_get) {
-		int err;
-
-		netdev_lock_ops(dev);
-		err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
-		netdev_unlock_ops(dev);
+	if (!ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
 
-		return err;
-	}
+	netdev_lock_ops(dev);
+	err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
+	netdev_unlock_ops(dev);
 
-	/* Legacy path: unconverted lower driver */
-	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
+	return err;
 }
 EXPORT_SYMBOL(generic_hwtstamp_get_lower);
 
@@ -488,22 +463,19 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct netlink_ext_ack *extack)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_set) {
-		int err;
-
-		netdev_lock_ops(dev);
-		err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
-		netdev_unlock_ops(dev);
+	if (!ops->ndo_hwtstamp_set)
+		return -EOPNOTSUPP;
 
-		return err;
-	}
+	netdev_lock_ops(dev);
+	err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+	netdev_unlock_ops(dev);
 
-	/* Legacy path: unconverted lower driver */
-	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
+	return err;
 }
 EXPORT_SYMBOL(generic_hwtstamp_set_lower);
 
-- 
2.47.3


