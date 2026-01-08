Return-Path: <linux-rdma+bounces-15373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754BD057D3
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260DC305E859
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D713128CC;
	Thu,  8 Jan 2026 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEeKY1Wi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CB312837
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896635; cv=none; b=lEK2mKZfyuBBlJR9IPF5AdjfI+z2M0KH8qcbx44HXZQqCD+EdpswZF7ocl2AUf6/1Epl2QT85w+MRquKQ5EnjmAB4HTdbiYCSKpo7Wa9cDcUAId8nbZjWltu6CZVwkV1QUafh6f3GujORZmYCH5/oIRTS3oUfSmPKCdEgMPio/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896635; c=relaxed/simple;
	bh=jvKQr4XB//KA4BZM0P9xI2zFZ2Bjct/9MvMIKC8dHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG78/0FH9IMCc3cexQXspWTIBjfJXLzpMWRSEHuyiG1pXyWSxe3NPAOT1dCsj6KLWAhwBhrA23GiOT33CH1zdK5khdoY7q2VEKKKIOkzwxZh8MP9pPsJ1Vg+NjZtn9qZxlgGTuubXV74H4aU//77goX4GsgTOHx/Q7F+ayPWTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEeKY1Wi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cKmgCgQ97+bqCTNzH940VlC5nRASPCo9/gmTU3Ocr0=;
	b=NEeKY1WiEvMrtdouz2qgAsXhNk+oEOMJ4RXGI+JHwTbzjTMWfLT/28NBc8i3iwjKnazNJQ
	OXNcn1n9X54k4U1SkdNIkdS9IU5tQQ65/wBOW7wf1wONSigp8sA4cJ4MZo4kubpaXDw04i
	GLwo5zM1VxYMaJtmrHB1/HOZ4svDIEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-nB7B78XTP7qoIZrVd_VFZg-1; Thu,
 08 Jan 2026 13:23:47 -0500
X-MC-Unique: nB7B78XTP7qoIZrVd_VFZg-1
X-Mimecast-MFC-AGG-ID: nB7B78XTP7qoIZrVd_VFZg_1767896624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF4CF1956050;
	Thu,  8 Jan 2026 18:23:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB2671800980;
	Thu,  8 Jan 2026 18:23:36 +0000 (UTC)
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
Subject: [PATCH net-next 02/12] dpll: Allow associating dpll pin with a firmware node
Date: Thu,  8 Jan 2026 19:23:08 +0100
Message-ID: <20260108182318.20935-3-ivecera@redhat.com>
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

Extend the DPLL core to support associating a DPLL pin with a firmware
node. This association is required to allow other subsystems (such as
network drivers) to locate and request specific DPLL pins defined in
the Device Tree or ACPI.

* Add a .fwnode field to the struct dpll_pin
* Introduce dpll_pin_fwnode_set() helper to allow the provider driver
  to associate a pin with a fwnode after the pin has been allocated
* Introduce fwnode_dpll_pin_find() helper to allow consumers to search
  for a registered DPLL pin using its associated fwnode handle
* Ensure the fwnode reference is properly released in dpll_pin_put()

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
RFC v2:
- dpll_pin_fwnode_set() helper to set firmware node without touching
  dpll_pin_get()
---
 drivers/dpll/dpll_core.c | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h |  2 ++
 include/linux/dpll.h     | 11 +++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a461095efd8ac..fb68b5e19b480 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -599,12 +600,60 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->parent_refs);
 		xa_destroy(&pin->ref_sync_pins);
 		dpll_pin_prop_free(&pin->prop);
+		fwnode_handle_put(pin->fwnode);
 		kfree_rcu(pin, rcu);
 	}
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_put);
 
+/**
+ * dpll_pin_fwnode_set - set dpll pin firmware node reference
+ * @pin: pointer to a dpll pin
+ * @fwnode: firmware node handle
+ *
+ * Set firmware node handle for the given dpll pin.
+ */
+void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode)
+{
+	mutex_lock(&dpll_lock);
+	fwnode_handle_put(pin->fwnode); /* Drop fwnode previously set */
+	pin->fwnode = fwnode_handle_get(fwnode);
+	mutex_unlock(&dpll_lock);
+}
+EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
+
+/**
+ * fwnode_dpll_pin_find - find dpll pin by firmware node reference
+ * @fwnode: reference to firmware node
+ *
+ * Get existing object of a pin that is associated with given firmware node
+ * reference.
+ *
+ * Context: Acquires a lock (dpll_lock)
+ * Return:
+ * * valid dpll_pin struct pointer if succeeded
+ * * ERR_PTR(X) - error
+ */
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
+{
+	struct dpll_pin *pin, *ret = NULL;
+	unsigned long index;
+
+	mutex_lock(&dpll_lock);
+	xa_for_each(&dpll_pin_xa, index, pin) {
+		if (pin->fwnode == fwnode) {
+			ret = pin;
+			refcount_inc(&ret->refcount);
+			break;
+		}
+	}
+	mutex_unlock(&dpll_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
+
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 8ce969bbeb64e..d3e17ff0ecef0 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -42,6 +42,7 @@ struct dpll_device {
  * @pin_idx:		index of a pin given by dev driver
  * @clock_id:		clock_id of creator
  * @module:		module of creator
+ * @fwnode:		optional reference to firmware node
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
  * @ref_sync_pins:	hold references to pins for Reference SYNC feature
@@ -54,6 +55,7 @@ struct dpll_pin {
 	u32 pin_idx;
 	u64 clock_id;
 	struct module *module;
+	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
 	struct xarray ref_sync_pins;
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 562f520b23c27..f0c31a111c304 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -16,6 +16,7 @@
 struct dpll_device;
 struct dpll_pin;
 struct dpll_pin_esync;
+struct fwnode_handle;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -173,6 +174,8 @@ void dpll_netdev_pin_clear(struct net_device *dev);
 size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
+
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
 #else
 static inline void
 dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
@@ -188,6 +191,12 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
 {
 	return 0;
 }
+
+static inline struct dpll_pin *
+fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
+{
+	return NULL;
+}
 #endif
 
 struct dpll_device *
@@ -213,6 +222,8 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 
 void dpll_pin_put(struct dpll_pin *pin);
 
+void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode);
+
 int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			     const struct dpll_pin_ops *ops, void *priv);
 
-- 
2.52.0


