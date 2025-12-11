Return-Path: <linux-rdma+bounces-14964-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ABECB70B1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4509D3002171
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171B316905;
	Thu, 11 Dec 2025 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ML1W7kxV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05309257848
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482523; cv=none; b=HWj+sy72/01znwaE/vYSvn4X/mJoRy4rJtzuM2PThocoE/U16d190/3tUElccIeVY/9fPaS05Xc8UfVlm4/KTh+MhcZPs5EeqY3ARRuZb711E9QMudzg6SdPlXKeZ9YTpRZacfcZR2HIuBTAE/jFEDO6VHCQ31DcpEPqhQGZRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482523; c=relaxed/simple;
	bh=4s83a0SU/low4CwSUHsqlIMaLxegaeEK52/o9Or1H5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLdIg95j4FDJtjEMsshCtoSmSM9cu6O9ZWwes3E4b47Dek5ERYkAykJ7wTQDLN0EZlvpGAZsGz6IUUSVKP3e51kKryifMEWhmJW520HuzB8VnqqhbARgAr70VVLuW++aDa5SqpSztsifs/AQ2AW/Ex18x1O45dJ+4amjtVl2GCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ML1W7kxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC4mCgkPFY3HeqtRjRPBAr1+nSCr5owbgZaduK5jqJ4=;
	b=ML1W7kxVaYPsNHVStcrq9BuwmTBxxhEo7FBXUERBkDs8rpP/bosvXLQpg1sOsLxj+RkXRE
	O903MizrRGCNDd5AnPujfboPxH8e0sR0fZ6+oQPUhyFEDNCC9sGJHV6/c0w6nUOeL8RqMD
	AhxvmkHcZfHyEBtTTIhy7KRNM8u+zQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-x6iNrVO8PDKA5KU51MnQEw-1; Thu,
 11 Dec 2025 14:48:38 -0500
X-MC-Unique: x6iNrVO8PDKA5KU51MnQEw-1
X-Mimecast-MFC-AGG-ID: x6iNrVO8PDKA5KU51MnQEw_1765482514
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64635195606D;
	Thu, 11 Dec 2025 19:48:34 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE5161953984;
	Thu, 11 Dec 2025 19:48:25 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH RFC net-next 03/13] net: eth: Add helpers to find DPLL pin firmware node
Date: Thu, 11 Dec 2025 20:47:46 +0100
Message-ID: <20251211194756.234043-4-ivecera@redhat.com>
In-Reply-To: <20251211194756.234043-1-ivecera@redhat.com>
References: <20251211194756.234043-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


