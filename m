Return-Path: <linux-rdma+bounces-15008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FE2CBFC5A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C491300184D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3563128C0;
	Mon, 15 Dec 2025 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0l9R369"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F692321F3E
	for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830690; cv=none; b=oeCq5z5eNf41DY/ByhwaJbQBUYkLrNFM/XD5vfIwjwMJjJjB+zM2qLyMaB9PJVE2djmSjxpohM5kpf6f2x6ZqMHmlZhLIparD5TegCEm4v7B1BOg3vTVrrpAcbMv4+jdHAJTNq5aqGY7mkVZHx8hR/PISE1Wu5mtJE40YwJJ0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830690; c=relaxed/simple;
	bh=4s83a0SU/low4CwSUHsqlIMaLxegaeEK52/o9Or1H5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAiHjz1ybG4Jwf09/KHtDOB1D8R9aZsZKDBzfGxteXCMqQBhAqo12oeg7ycL8C1vO+XjjWOqndJOcr3QzZFGBFeJwxxydrKMwBFwYCuHemte8sF6zFQwFJjGxUCzp4KBOHG9Z7r8ByeYgTqYzIoX6Pji7Za0VBIzNWjgDWQuKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0l9R369; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765830686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC4mCgkPFY3HeqtRjRPBAr1+nSCr5owbgZaduK5jqJ4=;
	b=X0l9R369pZZbBh6CGSoAl81znysvXJAT+2zzxYHf5a8wxnyjKGrx21nwBZSPcZ0EY8mFf9
	feGiRpN0Bgb5SreQFkIcXSTSPpyuF+JgJ7aXzdInXhUd4/U+zRSpJvSGinTPJLh5LioJOJ
	czJ7Lc34kwRas2TbBAKeOogV3e7wAEE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-BNLXrZRjPIev3sZdgun3UQ-1; Mon,
 15 Dec 2025 15:31:24 -0500
X-MC-Unique: BNLXrZRjPIev3sZdgun3UQ-1
X-Mimecast-MFC-AGG-ID: BNLXrZRjPIev3sZdgun3UQ_1765830680
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A66B1956080;
	Mon, 15 Dec 2025 20:31:20 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.214])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF3E330001A2;
	Mon, 15 Dec 2025 20:31:10 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next v2 03/12] net: eth: Add helpers to find DPLL pin firmware node
Date: Mon, 15 Dec 2025 21:30:28 +0100
Message-ID: <20251215203037.1324945-4-ivecera@redhat.com>
In-Reply-To: <20251215203037.1324945-1-ivecera@redhat.com>
References: <20251215203037.1324945-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add helper functions to retrieve a DPLL pin's firmware node handle
based on the "dpll-pins" and "dpll-pin-names" device tree properties.

* fwnode_get_dpll_pin_node(): matches the given name against the
  "dpll-pin-names" property to find the correct index, then retrieves
  the reference from "dpll-pins".
* device_get_dpll_pin_node(): a wrapper around the fwnode helper for
  convenience when using a `struct device`.

These helpers simplify the process for Ethernet drivers to look up
their associated DPLL pins defined in the Device Tree, which can then
be passed to the DPLL subsystem to acquire the pin object.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/etherdevice.h |  4 ++++
 net/ethernet/eth.c          | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 9a1eacf35d370..e342e522ea0e8 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -35,6 +35,10 @@ int nvmem_get_mac_address(struct device *dev, void *addrbuf);
 int device_get_mac_address(struct device *dev, char *addr);
 int device_get_ethdev_address(struct device *dev, struct net_device *netdev);
 int fwnode_get_mac_address(struct fwnode_handle *fwnode, char *addr);
+struct fwnode_handle *fwnode_get_dpll_pin_node(struct fwnode_handle *fwnode,
+					       const char *name);
+struct fwnode_handle *device_get_dpll_pin_node(struct device *dev,
+					       const char *name);
 
 u32 eth_get_headlen(const struct net_device *dev, const void *data, u32 len);
 __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 13a63b48b7eeb..9081dc02ba91e 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -639,3 +639,23 @@ int device_get_ethdev_address(struct device *dev, struct net_device *netdev)
 	return ret;
 }
 EXPORT_SYMBOL(device_get_ethdev_address);
+
+struct fwnode_handle *fwnode_get_dpll_pin_node(struct fwnode_handle *fwnode,
+					       const char *name)
+{
+	int index = 0;
+
+	if (name)
+		index = fwnode_property_match_string(fwnode, "dpll-pin-names",
+						     name);
+
+	return fwnode_find_reference(fwnode, "dpll-pins", index);
+}
+EXPORT_SYMBOL(fwnode_get_dpll_pin_node);
+
+struct fwnode_handle *device_get_dpll_pin_node(struct device *dev,
+					       const char *name)
+{
+	return fwnode_get_dpll_pin_node(dev_fwnode(dev), name);
+}
+EXPORT_SYMBOL(device_get_dpll_pin_node);
-- 
2.51.2


