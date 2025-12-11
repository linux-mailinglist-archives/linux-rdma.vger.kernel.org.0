Return-Path: <linux-rdma+bounces-14963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C46CB70AC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28FBF3015D20
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C131AA84;
	Thu, 11 Dec 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI9MMtnY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB99283FC5
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482515; cv=none; b=Q6SnEPcZveOcEfbDE8UU7CAAz7eA4CvYBTqta7qtB7/XLJuTUyhx/BH4x/L1MZ9vAdzUwVjiUlb0V+N8Xv1DCtN4OoYHrNkkug6v9TVRdFK5xFXpR4rzRHW9UMwhMNjCish1Z1gT5ls8Hg53GeaVDcodO6AtQcFNSoT4TSmH6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482515; c=relaxed/simple;
	bh=QqsedJb1nJZBr/bJzTLNK0wsEDxgK+arrL3NNio1ve8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwcMfRofq6xzZ/eJgMSY/wGJ06UntFjenZK8UKq+fXPuyHZQJAnB/m7/ZRoQ5mnYRH9Tp2KYwQ5+iDrJoauhKxRybqus5YdDyIBFDuSB1ucBDELlCUqyEsE8K77fv1FGmEbqGMUXuEniTJFqmWFm1kHD6AsYVONqrOFwpm93o3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI9MMtnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37aL1XPpycBEXt+/fyj1YlwoyzFP+U1GM0nui/fCmKY=;
	b=cI9MMtnYlZ9MzNFXjMJFF8dJNFasf2gX+94zWLejpLoDNngAEoXrxPjFyTnjsbCCIZNCzn
	Ar7FomCyaYHMAI0o7jd1h4RGAFIntIGFuC83eKKw+v7fPrwDpzVWoaaCDM1tI1ylsK3Wqo
	/amx5X7Q8I/a5L4brAVezW79jBHUnxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-tNVydpQ2Nti34qf4egmqeg-1; Thu,
 11 Dec 2025 14:48:29 -0500
X-MC-Unique: tNVydpQ2Nti34qf4egmqeg-1
X-Mimecast-MFC-AGG-ID: tNVydpQ2Nti34qf4egmqeg_1765482506
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6170E180034C;
	Thu, 11 Dec 2025 19:48:25 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B0941956056;
	Thu, 11 Dec 2025 19:48:16 +0000 (UTC)
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
Subject: [PATCH RFC net-next 02/13] dpll: Allow registering pin with firmware node
Date: Thu, 11 Dec 2025 20:47:45 +0100
Message-ID: <20251211194756.234043-3-ivecera@redhat.com>
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

Extend the DPLL core to support associating a DPLL pin with a firmware
node (fwnode). This association is required to allow other subsystems
(such as network drivers) to locate and request specific DPLL pins
defined in the Device Tree or ACPI.

Modify dpll_pin_get() to accept an optional fwnode_handle parameter.
If provided, the fwnode is stored in the dpll_pin structure, and its
reference count is incremented. The reference is released in dpll_pin_put().

Add fwnode_dpll_pin_find() as an exported symbol. This helper allows
drivers to search for a registered DPLL pin using its associated fwnode
handle. The caller should use dpll_pin_put() to release dpll pin
returned by fwnode_dpll_pin_find().

Update all existing callers of dpll_pin_get() in the ice, mlx5, ptp_ocp,
and zl3073x drivers to pass NULL for the new argument, preserving existing
behavior.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c                      | 46 +++++++++++++++++--
 drivers/dpll/dpll_core.h                      |  2 +
 drivers/dpll/zl3073x/dpll.c                   |  2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  3 +-
 drivers/ptp/ptp_ocp.c                         |  3 +-
 include/linux/dpll.h                          | 12 ++++-
 7 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index a461095efd8ac..773783fd14f71 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -484,7 +485,8 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 
 static struct dpll_pin *
 dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
-	       const struct dpll_pin_properties *prop)
+	       const struct dpll_pin_properties *prop,
+	       struct fwnode_handle *fwnode)
 {
 	struct dpll_pin *pin;
 	int ret;
@@ -511,6 +513,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 			      &dpll_pin_xa_id, GFP_KERNEL);
 	if (ret < 0)
 		goto err_xa_alloc;
+	pin->fwnode = fwnode_handle_get(fwnode);
 	return pin;
 err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
@@ -548,6 +551,7 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
  * @pin_idx: idx given by dev driver
  * @module: reference to registering module
  * @prop: dpll pin properties
+ * @fwnode: optional reference to firmware node
  *
  * Get existing object of a pin (unique for given arguments) or create new
  * if doesn't exist yet.
@@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
  */
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
-	     const struct dpll_pin_properties *prop)
+	     const struct dpll_pin_properties *prop,
+	     struct fwnode_handle *fwnode)
 {
 	struct dpll_pin *pos, *ret = NULL;
 	unsigned long i;
@@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_for_each(&dpll_pin_xa, i, pos) {
 		if (pos->clock_id == clock_id &&
 		    pos->pin_idx == pin_idx &&
-		    pos->module == module) {
+		    pos->module == module &&
+		    pos->fwnode == fwnode) {
 			ret = pos;
 			refcount_inc(&ret->refcount);
 			break;
 		}
 	}
 	if (!ret)
-		ret = dpll_pin_alloc(clock_id, pin_idx, module, prop);
+		ret = dpll_pin_alloc(clock_id, pin_idx, module, prop, fwnode);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -599,12 +605,44 @@ void dpll_pin_put(struct dpll_pin *pin)
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
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 9879d85d29af0..cf2ad3031e5d7 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1368,7 +1368,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 	/* Create or get existing DPLL pin */
 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
-				     &props->dpll_props);
+				     &props->dpll_props, NULL);
 	if (IS_ERR(pin->dpll_pin)) {
 		rc = PTR_ERR(pin->dpll_pin);
 		goto err_pin_get;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 53b54e395a2ed..1c28af5a2d5e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2840,7 +2840,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 	for (i = 0; i < count; i++) {
 		pins[i].pin = dpll_pin_get(clock_id, i + start_idx, THIS_MODULE,
-					   &pins[i].prop);
+					   &pins[i].prop, NULL);
 		if (IS_ERR(pins[i].pin)) {
 			ret = PTR_ERR(pins[i].pin);
 			goto release_pins;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a194839..9e71164f463df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -451,7 +451,8 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 
 	/* Multiple mdev instances might share one DPLL pin. */
 	mdpll->dpll_pin = dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
-				       THIS_MODULE, &mlx5_dpll_pin_properties);
+				       THIS_MODULE, &mlx5_dpll_pin_properties,
+				       NULL);
 	if (IS_ERR(mdpll->dpll_pin)) {
 		err = PTR_ERR(mdpll->dpll_pin);
 		goto err_unregister_dpll_device;
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 65fe05cac8c42..fd7d1132afdf0 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4800,7 +4800,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out;
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
-		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
+		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
+						   &bp->sma[i].dpll_prop, NULL);
 		if (IS_ERR(bp->sma[i].dpll_pin)) {
 			err = PTR_ERR(bp->sma[i].dpll_pin);
 			goto out_dpll;
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 562f520b23c27..315245dbdfb96 100644
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
@@ -203,7 +212,8 @@ void dpll_device_unregister(struct dpll_device *dpll,
 
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
-	     const struct dpll_pin_properties *prop);
+	     const struct dpll_pin_properties *prop,
+	     struct fwnode_handle *fwnode);
 
 int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv);
-- 
2.51.2


