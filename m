Return-Path: <linux-rdma+bounces-15374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2A0D057DF
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A924130407D1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96123128AE;
	Thu,  8 Jan 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFQjpAl2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7543126A3
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896644; cv=none; b=jcCMbbuNdGCRqb6SFKz49AQo09uviR1LclKdppwf19OMXGEHbVgjQZA5VNq6FVCoCEMIcrlJABuDxwx50SGD/LU6ip/K7ijn6Nayd6oPonHuLxVplP3nXjwzvdeTbgBE7QpriIaJI2e6isyqPZuODCXtYOeTo7QlwkGF0df0hyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896644; c=relaxed/simple;
	bh=cBXbBt7rAp+O28SxxCtNyupDcXA/6alarH+tSIwOj18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C79BUK3wJ698N8khCB9TJqxeaKYiPaOernJ8rCZpcTITVS/3wyuajqTNnxC6bDbf5KLfw5tB+tlQdIHOdwz90hbLXlL96PnjXuTrnDTdfraVO3QQajwTfJQZUtyme5BQ345P6esduzxtOG43pbt141vs+LrnK8nHI1JwPwgJ7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFQjpAl2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fjnh3sw7EA2ytiRCBrNn8oycRpIfYmZ8yq78Z8T1zEk=;
	b=KFQjpAl2NNvIA+HE3zAm2dEwXwNJjZkIjc7AMWFizAPuRxjjWmQKEpTNbl12xEFEXYe5QF
	2hV6R8h7e3Qm3E+x1BSZ9iFzoAlrBFhdClQ6ccyz4oJfJz+RO4Lz72RYNBKX/GHGXEyy3h
	9Bo3Z9xUzscHzHf/KF3Z60eNu76uTzs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-RZTwi0dTOTiE_d4K2pGnWg-1; Thu,
 08 Jan 2026 13:23:55 -0500
X-MC-Unique: RZTwi0dTOTiE_d4K2pGnWg-1
X-Mimecast-MFC-AGG-ID: RZTwi0dTOTiE_d4K2pGnWg_1767896632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4A5B1956088;
	Thu,  8 Jan 2026 18:23:51 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63B5F180009E;
	Thu,  8 Jan 2026 18:23:44 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next 03/12] dpll: Add helpers to find DPLL pin fwnode
Date: Thu,  8 Jan 2026 19:23:09 +0100
Message-ID: <20260108182318.20935-4-ivecera@redhat.com>
In-Reply-To: <20260108182318.20935-1-ivecera@redhat.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
node handle based on the "dpll-pins" and "dpll-pin-names" properties.

* `fwnode_dpll_pin_node_get()`: matches the given name against the
  "dpll-pin-names" property to find the correct index, then retrieves
  the reference from "dpll-pins".
* `device_dpll_pin_node_get()`: a wrapper around the fwnode helper for
  convenience when using a `struct device`.

These helpers simplify the process for consumer drivers (such as Ethernet
controllers or PHYs) to look up their associated DPLL pins defined in
the DT or ACPI, which can then be passed to the DPLL subsystem to acquire
the pin object.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 20 ++++++++++++++++++++
 include/linux/dpll.h     | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index fb68b5e19b480..23d04a9d022d7 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -654,6 +654,26 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
 
+/**
+ * fwnode_dpll_pin_node_get - get dpll pin node from given fw node and pin name
+ * @fwnode: firmware node that uses the dpll pin
+ * @name: dpll pin name from dpll-pin-names property
+ *
+ * Return: ERR_PTR() on error or a valid firmware node handle on success.
+ */
+struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle *fwnode,
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
+EXPORT_SYMBOL_GPL(fwnode_dpll_pin_node_get);
+
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index f0c31a111c304..755c36d1ef45a 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/netlink.h>
 #include <linux/netdevice.h>
+#include <linux/property.h>
 #include <linux/rtnetlink.h>
 
 struct dpll_device;
@@ -176,6 +177,8 @@ int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
 
 struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle *fwnode,
+					       const char *name);
 #else
 static inline void
 dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
@@ -197,8 +200,20 @@ fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
+
+static inline struct fwnode_handle *
+fwnode_dpll_pin_node_get(struct fwnode_handle *fwnode, const char *name)
+{
+	return NULL;
+}
 #endif
 
+static inline struct fwnode_handle *
+device_dpll_pin_node_get(struct device *dev, const char *name)
+{
+	return fwnode_dpll_pin_node_get(dev_fwnode(dev), name);
+}
+
 struct dpll_device *
 dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
 
-- 
2.52.0


