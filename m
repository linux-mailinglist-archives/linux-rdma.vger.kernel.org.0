Return-Path: <linux-rdma+bounces-15632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C9D384BD
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 19:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9488030A4242
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EC33C536;
	Fri, 16 Jan 2026 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FROnHGFz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93932FA2A
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589216; cv=none; b=IzHzU53rYpq1ajdb1anslb9P8vmFNHuiJou4LZYiyBm19gznQToJXZRAz7g5eN/IEVHIk+yTVJBKzk/6PfTjMHwMibb4lkwaYQq0Kg+J+oTC0nU6sSH3rxR66FAgQrpr7IM7oNZWOfXhJrogWsRrEae4w+qk177Uik0ZwGPI85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589216; c=relaxed/simple;
	bh=KyyDHCkBVL3f10Id6p0Q1p1KyYtvTjyjnDj79VZzoY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXBcg41g1cPNrvFkdnaE6PW024nq6WS7/2zUvCG49D4lGWWoMI8uParFxKbUNZaW9ejgE3DmRfDS/f945yZh9lSuIjb802K1HYZRT9omHfHQJZLd9pFpm3xjgRty5q9W39BSE8fs9eC7iN9wjql2EjnXGXBc7ouML9zFGtVyW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FROnHGFz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0OhRLbKcl0fGc1eqpeFTWeu8BcihMm1H0wXcAahyII=;
	b=FROnHGFzAuTiR8GklJgsH+U2vBjhsrpzC6BUEEHoWgDY/WK/jyw2+YrsADfBJng5pyAodi
	RfIouZZFq9R3lM94GXxwZ3I98f/HTWBrj/P8OWc9ntDvfyRA+6rxQX4QxNQq6WmEDQqwPZ
	5bJSkNG9GDpbGKHXpfSCgz25ZiRbgvQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-gqLFMPjxPKqAT8GckunHQQ-1; Fri,
 16 Jan 2026 13:46:49 -0500
X-MC-Unique: gqLFMPjxPKqAT8GckunHQQ-1
X-Mimecast-MFC-AGG-ID: gqLFMPjxPKqAT8GckunHQQ_1768589206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3D211956095;
	Fri, 16 Jan 2026 18:46:45 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 040F819560A7;
	Fri, 16 Jan 2026 18:46:37 +0000 (UTC)
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
	Saravana Kannan <saravanak@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	devicetree@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 03/12] dpll: Add helpers to find DPLL pin fwnode
Date: Fri, 16 Jan 2026 19:46:01 +0100
Message-ID: <20260116184610.147591-4-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-1-ivecera@redhat.com>
References: <20260116184610.147591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

dpll: core: add helpers to find DPLL pin fwnode

Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
node handle based on the 'dpll-pins' and 'dpll-pin-names' properties.

Unlike simple phandle arrays, 'dpll-pins' entries typically contain
a pin specifier (index and direction) as defined by '#dpll-pin-cells'.
The new helper fwnode_dpll_pin_node_get() parses these specifiers
using fwnode_property_get_reference_args(). It resolves the target
pin by:
1. Identifying the DPLL device node from the phandle.
2. Selecting the correct sub-node ('input-pins' or 'output-pins') based
   on the direction argument.
3. Matching the pin index argument against the 'reg' property of
   the child nodes.

Additionally, register 'dpll-pins' in drivers/of/property.c to enable
proper parsing of the supplier bindings by the OF core.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* added check for fwnode_property_match_string() return value
* reworked searching for the pin using dpll device phandle and
  pin specifier
* added dpll-pins into OF core supplier_bindings
---
 drivers/dpll/dpll_core.c | 74 ++++++++++++++++++++++++++++++++++++++++
 drivers/of/property.c    |  2 ++
 include/linux/dpll.h     | 15 ++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index fb68b5e19b480..b0083b5c10aa4 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -13,6 +13,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <dt-bindings/dpll/dpll.h>
 
 #include "dpll_core.h"
 #include "dpll_netlink.h"
@@ -654,6 +655,79 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
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
+	struct fwnode_handle *parent_node, *pin_node;
+	struct fwnode_reference_args args;
+	const char *parent_name;
+	int ret, index = 0;
+
+	if (name) {
+		index = fwnode_property_match_string(fwnode, "dpll-pin-names",
+						     name);
+		if (index < 0)
+			return ERR_PTR(-ENOENT);
+	}
+
+	ret = fwnode_property_get_reference_args(fwnode, "dpll-pins",
+						 "#dpll-pin-cells", 2, index,
+						 &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* We support only 2 cell DPLL bindings in the kernel currently. */
+	if (args.nargs != 2) {
+		fwnode_handle_put(args.fwnode);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* Resolve parent node name according pin direction type */
+	switch (args.args[1]) {
+	case DPLL_PIN_INPUT:
+		parent_name = "input-pins";
+		break;
+	case DPLL_PIN_OUTPUT:
+		parent_name = "output-pins";
+		break;
+	default:
+		fwnode_handle_put(args.fwnode);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Get pin's parent sub-node */
+	parent_node = fwnode_get_named_child_node(args.fwnode, parent_name);
+	if (!parent_node) {
+		fwnode_handle_put(args.fwnode);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* Enumerate child pin nodes and find the requested one */
+	fwnode_for_each_child_node(parent_node, pin_node) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))
+			continue;
+
+		if (reg == args.args[0])
+			break;
+	}
+
+	/* Release pin's parent and dpll device node */
+	fwnode_handle_put(parent_node);
+	fwnode_handle_put(args.fwnode);
+
+	return pin_node ? pin_node : ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL_GPL(fwnode_dpll_pin_node_get);
+
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 4e3524227720a..8571c8bb71ade 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
 DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-controller-cells")
 DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
 DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
+DEFINE_SIMPLE_PROP(dpll_pins, "dpll-pins", "#dpll-pin-cells")
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1568,6 +1569,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 		.parse_prop = parse_post_init_providers,
 		.fwlink_flags = FWLINK_FLAG_IGNORE,
 	},
+	{ .parse_prop = parse_dpll_pins, },
 	{}
 };
 
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


