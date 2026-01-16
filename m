Return-Path: <linux-rdma+bounces-15639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC53D384B7
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72F0E3022CB7
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBE39E178;
	Fri, 16 Jan 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6PKgsaN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AB34D4E9
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589273; cv=none; b=OnITTaa4g2BgauowvB9o+1+tA5OZnK11dlaTYcOgpKpbcQPGnqSu0p+Ko/zEKQxpVhg6j3pg2i4DhZxDXTwCgFEaccNmAZp2YqWIkwB3A+8MdYLo8sn36kJDR46jKFQ13BkH6F/YpELWSShmUZYzxU5Zx52IGW8UGKbQ7cyCz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589273; c=relaxed/simple;
	bh=n2N17BK4FkKn1uAt4yepvtQg7TjKotwGb+F2Shm2Ilg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJEDtSJmHGH/CPzS51eDGpMU7zixc9TWpssBKvEsQLQxy90AsjXgGdO5LIHfWmM4rnH2HHa+6vzViMsRtAHJuKQye5Qa5LikubuTDzl4YToRJiJ5PyOiNfU64mgLXy52gzd0J2c6vOFkkABweeLnKfdIQcPt5kfdDV+aNbd60dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6PKgsaN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768589269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCo8D0ZlwZ5yR9Hf4MxNToNzgDeD/XFUJOHiUanMBqM=;
	b=J6PKgsaNn+frVfeTkivYp+g2j3XW+74+4vqtVzlxTSoFAZO7Uh4ZqapyOMSW4T//z40ejf
	5Jg60TqtUcz+79R0B4eT88713UQyMaPz8cp6HeC0JFL7RlutRBlhLYLpXzil+p3D/9hpQU
	fRsPBTZlnxA4Ji3+Nj3l5fU9qdYeW40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-Lc8c-JRmO9iYDyfoiLVfcg-1; Fri,
 16 Jan 2026 13:47:45 -0500
X-MC-Unique: Lc8c-JRmO9iYDyfoiLVfcg-1
X-Mimecast-MFC-AGG-ID: Lc8c-JRmO9iYDyfoiLVfcg_1768589262
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3555B19560A3;
	Fri, 16 Jan 2026 18:47:42 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.34.71])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C4321955F6E;
	Fri, 16 Jan 2026 18:47:34 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
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
Subject: [PATCH net-next v2 10/12] dpll: Add reference count tracking support
Date: Fri, 16 Jan 2026 19:46:08 +0100
Message-ID: <20260116184610.147591-11-ivecera@redhat.com>
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

Add support for the REF_TRACKER infrastructure to the DPLL subsystem.

When enabled, this allows developers to track and debug reference counting
leaks or imbalances for dpll_device and dpll_pin objects. It records stack
traces for every get/put operation and exposes this information via
debugfs at:
  /sys/kernel/debug/ref_tracker/dpll_device_*
  /sys/kernel/debug/ref_tracker/dpll_pin_*

The following API changes are made to support this:
1. dpll_device_get() / dpll_device_put() now accept a 'dpll_tracker *'
   (which is a typedef to 'struct ref_tracker *' when enabled, or an empty
   struct otherwise).
2. dpll_pin_get() / dpll_pin_put() and fwnode_dpll_pin_find() similarly
   accept the tracker argument.
3. Internal registration structures now hold a tracker to associate the
   reference held by the registration with the specific owner.

All existing in-tree drivers (ice, mlx5, ptp_ocp, zl3073x) are updated
to pass NULL for the new tracker argument, maintaining current behavior
while enabling future debugging capabilities.

Co-developed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/Kconfig                          | 15 +++
 drivers/dpll/dpll_core.c                      | 98 ++++++++++++++-----
 drivers/dpll/dpll_core.h                      |  5 +
 drivers/dpll/zl3073x/dpll.c                   | 12 +--
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 14 +--
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 13 +--
 drivers/ptp/ptp_ocp.c                         | 15 +--
 include/linux/dpll.h                          | 19 +++-
 8 files changed, 138 insertions(+), 53 deletions(-)

diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index ade872c915ac6..df5640f526c6c 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -8,6 +8,21 @@ menu "DPLL device support"
 config DPLL
 	bool
 
+config DPLL_REFCNT_TRACKER
+	bool "DPLL reference count tracking"
+	depends on DPLL
+	select REF_TRACKER
+	help
+	  Enable reference count tracking for DPLL devices and pins.
+	  This helps debugging reference leaks and use-after-free bugs
+	  by recording stack traces for each get/put operation.
+
+	  The tracking information is exposed via debugfs at:
+	    /sys/kernel/debug/ref_tracker/dpll_device_*
+	    /sys/kernel/debug/ref_tracker/dpll_pin_*
+
+	  If unsure, say N.
+
 source "drivers/dpll/zl3073x/Kconfig"
 
 endmenu
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8616d6285c646..c9848b5f2b89b 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -42,6 +42,7 @@ struct dpll_device_registration {
 	struct list_head list;
 	const struct dpll_device_ops *ops;
 	void *priv;
+	dpll_tracker tracker;
 };
 
 struct dpll_pin_registration {
@@ -49,6 +50,7 @@ struct dpll_pin_registration {
 	const struct dpll_pin_ops *ops;
 	void *priv;
 	void *cookie;
+	dpll_tracker tracker;
 };
 
 static int call_dpll_notifiers(unsigned long action, void *info)
@@ -84,33 +86,68 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 	call_dpll_notifiers(action, &info);
 }
 
-static void __dpll_device_hold(struct dpll_device *dpll)
+static void dpll_device_tracker_alloc(struct dpll_device *dpll,
+				      dpll_tracker *tracker)
 {
+#ifdef CONFIG_DPLL_REFCNT_TRACKER
+	ref_tracker_alloc(&dpll->refcnt_tracker, tracker, GFP_KERNEL);
+#endif
+}
+
+static void dpll_device_tracker_free(struct dpll_device *dpll,
+				     dpll_tracker *tracker)
+{
+#ifdef CONFIG_DPLL_REFCNT_TRACKER
+	ref_tracker_free(&dpll->refcnt_tracker, tracker);
+#endif
+}
+
+static void __dpll_device_hold(struct dpll_device *dpll, dpll_tracker *tracker)
+{
+	dpll_device_tracker_alloc(dpll, tracker);
 	refcount_inc(&dpll->refcount);
 }
 
-static void __dpll_device_put(struct dpll_device *dpll)
+static void __dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 {
+	dpll_device_tracker_free(dpll, tracker);
 	if (refcount_dec_and_test(&dpll->refcount)) {
 		ASSERT_DPLL_NOT_REGISTERED(dpll);
 		WARN_ON_ONCE(!xa_empty(&dpll->pin_refs));
 		xa_destroy(&dpll->pin_refs);
 		xa_erase(&dpll_device_xa, dpll->id);
 		WARN_ON(!list_empty(&dpll->registration_list));
+		ref_tracker_dir_exit(&dpll->refcnt_tracker);
 		kfree(dpll);
 	}
 }
 
-static void __dpll_pin_hold(struct dpll_pin *pin)
+static void dpll_pin_tracker_alloc(struct dpll_pin *pin, dpll_tracker *tracker)
 {
+#ifdef CONFIG_DPLL_REFCNT_TRACKER
+	ref_tracker_alloc(&pin->refcnt_tracker, tracker, GFP_KERNEL);
+#endif
+}
+
+static void dpll_pin_tracker_free(struct dpll_pin *pin, dpll_tracker *tracker)
+{
+#ifdef CONFIG_DPLL_REFCNT_TRACKER
+	ref_tracker_free(&pin->refcnt_tracker, tracker);
+#endif
+}
+
+static void __dpll_pin_hold(struct dpll_pin *pin, dpll_tracker *tracker)
+{
+	dpll_pin_tracker_alloc(pin, tracker);
 	refcount_inc(&pin->refcount);
 }
 
 static void dpll_pin_idx_free(u32 pin_idx);
 static void dpll_pin_prop_free(struct dpll_pin_properties *prop);
 
-static void __dpll_pin_put(struct dpll_pin *pin)
+static void __dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 {
+	dpll_pin_tracker_free(pin, tracker);
 	if (refcount_dec_and_test(&pin->refcount)) {
 		xa_erase(&dpll_pin_xa, pin->id);
 		xa_destroy(&pin->dpll_refs);
@@ -119,6 +156,7 @@ static void __dpll_pin_put(struct dpll_pin *pin)
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
+		ref_tracker_dir_exit(&pin->refcnt_tracker);
 		kfree_rcu(pin, rcu);
 	}
 }
@@ -192,7 +230,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
-	__dpll_pin_hold(pin);
+	__dpll_pin_hold(pin, &reg->tracker);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -215,7 +253,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		if (WARN_ON(!reg))
 			return -EINVAL;
 		list_del(&reg->list);
-		__dpll_pin_put(pin);
+		__dpll_pin_put(pin, &reg->tracker);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_pins, i);
@@ -273,7 +311,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
-	__dpll_device_hold(dpll);
+	__dpll_device_hold(dpll, &reg->tracker);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -296,7 +334,7 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		if (WARN_ON(!reg))
 			return;
 		list_del(&reg->list);
-		__dpll_device_put(dpll);
+		__dpll_device_put(dpll, &reg->tracker);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_dplls, i);
@@ -338,6 +376,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 		return ERR_PTR(ret);
 	}
 	xa_init_flags(&dpll->pin_refs, XA_FLAGS_ALLOC);
+	ref_tracker_dir_init(&dpll->refcnt_tracker, 128, "dpll_device");
 
 	return dpll;
 }
@@ -347,6 +386,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
  * @clock_id: clock_id of creator
  * @device_idx: idx given by device driver
  * @module: reference to registering module
+ * @tracker: tracking object for the acquired reference
  *
  * Get existing object of a dpll device, unique for given arguments.
  * Create new if doesn't exist yet.
@@ -357,7 +397,8 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
  * * ERR_PTR(X) - error
  */
 struct dpll_device *
-dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
+dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
+		dpll_tracker *tracker)
 {
 	struct dpll_device *dpll, *ret = NULL;
 	unsigned long index;
@@ -367,13 +408,17 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
 		if (dpll->clock_id == clock_id &&
 		    dpll->device_idx == device_idx &&
 		    dpll->module == module) {
-			__dpll_device_hold(dpll);
+			__dpll_device_hold(dpll, tracker);
 			ret = dpll;
 			break;
 		}
 	}
-	if (!ret)
+	if (!ret) {
 		ret = dpll_device_alloc(clock_id, device_idx, module);
+		if (!IS_ERR(ret))
+			dpll_device_tracker_alloc(ret, tracker);
+	}
+
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -383,15 +428,16 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
 /**
  * dpll_device_put - decrease the refcount and free memory if possible
  * @dpll: dpll_device struct pointer
+ * @tracker: tracking object for the acquired reference
  *
  * Context: Acquires a lock (dpll_lock)
  * Drop reference for a dpll device, if all references are gone, delete
  * dpll device object.
  */
-void dpll_device_put(struct dpll_device *dpll)
+void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker)
 {
 	mutex_lock(&dpll_lock);
-	__dpll_device_put(dpll);
+	__dpll_device_put(dpll, tracker);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_device_put);
@@ -453,7 +499,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	reg->ops = ops;
 	reg->priv = priv;
 	dpll->type = type;
-	__dpll_device_hold(dpll);
+	__dpll_device_hold(dpll, &reg->tracker);
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
@@ -493,7 +539,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 		return;
 	}
 	list_del(&reg->list);
-	__dpll_device_put(dpll);
+	__dpll_device_put(dpll, &reg->tracker);
 	kfree(reg);
 
 	if (!list_empty(&dpll->registration_list)) {
@@ -623,6 +669,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 			      &dpll_pin_xa_id, GFP_KERNEL);
 	if (ret < 0)
 		goto err_xa_alloc;
+	ref_tracker_dir_init(&pin->refcnt_tracker, 128, "dpll_pin");
 	return pin;
 err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
@@ -684,6 +731,7 @@ EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
  * @pin_idx: idx given by dev driver
  * @module: reference to registering module
  * @prop: dpll pin properties
+ * @tracker: tracking object for the acquired reference
  *
  * Get existing object of a pin (unique for given arguments) or create new
  * if doesn't exist yet.
@@ -695,7 +743,7 @@ EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
  */
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
-	     const struct dpll_pin_properties *prop)
+	     const struct dpll_pin_properties *prop, dpll_tracker *tracker)
 {
 	struct dpll_pin *pos, *ret = NULL;
 	unsigned long i;
@@ -705,13 +753,16 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 		if (pos->clock_id == clock_id &&
 		    pos->pin_idx == pin_idx &&
 		    pos->module == module) {
-			__dpll_pin_hold(pos);
+			__dpll_pin_hold(pos, tracker);
 			ret = pos;
 			break;
 		}
 	}
-	if (!ret)
+	if (!ret) {
 		ret = dpll_pin_alloc(clock_id, pin_idx, module, prop);
+		if (!IS_ERR(ret))
+			dpll_pin_tracker_alloc(ret, tracker);
+	}
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -721,15 +772,16 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
 /**
  * dpll_pin_put - decrease the refcount and free memory if possible
  * @pin: pointer to a pin to be put
+ * @tracker: tracking object for the acquired reference
  *
  * Drop reference for a pin, if all references are gone, delete pin object.
  *
  * Context: Acquires a lock (dpll_lock)
  */
-void dpll_pin_put(struct dpll_pin *pin)
+void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker)
 {
 	mutex_lock(&dpll_lock);
-	__dpll_pin_put(pin);
+	__dpll_pin_put(pin, tracker);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_put);
@@ -753,6 +805,7 @@ EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
 /**
  * fwnode_dpll_pin_find - find dpll pin by firmware node reference
  * @fwnode: reference to firmware node
+ * @tracker: tracking object for the acquired reference
  *
  * Get existing object of a pin that is associated with given firmware node
  * reference.
@@ -762,7 +815,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_fwnode_set);
  * * valid dpll_pin struct pointer if succeeded
  * * ERR_PTR(X) - error
  */
-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
+				      dpll_tracker *tracker)
 {
 	struct dpll_pin *pin, *ret = NULL;
 	unsigned long index;
@@ -770,7 +824,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
 	mutex_lock(&dpll_lock);
 	xa_for_each(&dpll_pin_xa, index, pin) {
 		if (pin->fwnode == fwnode) {
-			__dpll_pin_hold(pin);
+			__dpll_pin_hold(pin, tracker);
 			ret = pin;
 			break;
 		}
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index b7b4bb251f739..71ac88ef20172 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -10,6 +10,7 @@
 #include <linux/dpll.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
+#include <linux/ref_tracker.h>
 #include "dpll_nl.h"
 
 #define DPLL_REGISTERED		XA_MARK_1
@@ -23,6 +24,7 @@
  * @type:		type of a dpll
  * @pin_refs:		stores pins registered within a dpll
  * @refcount:		refcount
+ * @refcnt_tracker:	ref_tracker directory for debugging reference leaks
  * @registration_list:	list of registered ops and priv data of dpll owners
  **/
 struct dpll_device {
@@ -33,6 +35,7 @@ struct dpll_device {
 	enum dpll_type type;
 	struct xarray pin_refs;
 	refcount_t refcount;
+	struct ref_tracker_dir refcnt_tracker;
 	struct list_head registration_list;
 };
 
@@ -48,6 +51,7 @@ struct dpll_device {
  * @ref_sync_pins:	hold references to pins for Reference SYNC feature
  * @prop:		pin properties copied from the registerer
  * @refcount:		refcount
+ * @refcnt_tracker:	ref_tracker directory for debugging reference leaks
  * @rcu:		rcu_head for kfree_rcu()
  **/
 struct dpll_pin {
@@ -61,6 +65,7 @@ struct dpll_pin {
 	struct xarray ref_sync_pins;
 	struct dpll_pin_properties prop;
 	refcount_t refcount;
+	struct ref_tracker_dir refcnt_tracker;
 	struct rcu_head rcu;
 };
 
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index d43e2cea24a67..5b2f9fd960fac 100644
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
@@ -1391,7 +1391,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 	return 0;
 
 err_register:
-	dpll_pin_put(pin->dpll_pin);
+	dpll_pin_put(pin->dpll_pin, NULL);
 err_prio_get:
 	pin->dpll_pin = NULL;
 err_pin_get:
@@ -1422,7 +1422,7 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *pin)
 	/* Unregister the pin */
 	dpll_pin_unregister(zldpll->dpll_dev, pin->dpll_pin, ops, pin);
 
-	dpll_pin_put(pin->dpll_pin);
+	dpll_pin_put(pin->dpll_pin, NULL);
 	pin->dpll_pin = NULL;
 }
 
@@ -1596,7 +1596,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 				       dpll_mode_refsel);
 
 	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
-					   THIS_MODULE);
+					   THIS_MODULE, NULL);
 	if (IS_ERR(zldpll->dpll_dev)) {
 		rc = PTR_ERR(zldpll->dpll_dev);
 		zldpll->dpll_dev = NULL;
@@ -1608,7 +1608,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
 				  &zl3073x_dpll_device_ops, zldpll);
 	if (rc) {
-		dpll_device_put(zldpll->dpll_dev);
+		dpll_device_put(zldpll->dpll_dev, NULL);
 		zldpll->dpll_dev = NULL;
 	}
 
@@ -1631,7 +1631,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 
 	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
 			       zldpll);
-	dpll_device_put(zldpll->dpll_dev);
+	dpll_device_put(zldpll->dpll_dev, NULL);
 	zldpll->dpll_dev = NULL;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 53b54e395a2ed..64b7b045ecd58 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2814,7 +2814,7 @@ static void ice_dpll_release_pins(struct ice_dpll_pin *pins, int count)
 	int i;
 
 	for (i = 0; i < count; i++)
-		dpll_pin_put(pins[i].pin);
+		dpll_pin_put(pins[i].pin, NULL);
 }
 
 /**
@@ -2840,7 +2840,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 	for (i = 0; i < count; i++) {
 		pins[i].pin = dpll_pin_get(clock_id, i + start_idx, THIS_MODULE,
-					   &pins[i].prop);
+					   &pins[i].prop, NULL);
 		if (IS_ERR(pins[i].pin)) {
 			ret = PTR_ERR(pins[i].pin);
 			goto release_pins;
@@ -2851,7 +2851,7 @@ ice_dpll_get_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 
 release_pins:
 	while (--i >= 0)
-		dpll_pin_put(pins[i].pin);
+		dpll_pin_put(pins[i].pin, NULL);
 	return ret;
 }
 
@@ -3037,7 +3037,7 @@ static void ice_dpll_deinit_rclk_pin(struct ice_pf *pf)
 	if (WARN_ON_ONCE(!vsi || !vsi->netdev))
 		return;
 	dpll_netdev_pin_clear(vsi->netdev);
-	dpll_pin_put(rclk->pin);
+	dpll_pin_put(rclk->pin, NULL);
 }
 
 /**
@@ -3247,7 +3247,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
 {
 	if (cgu)
 		dpll_device_unregister(d->dpll, d->ops, d);
-	dpll_device_put(d->dpll);
+	dpll_device_put(d->dpll, NULL);
 }
 
 /**
@@ -3271,7 +3271,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 	u64 clock_id = pf->dplls.clock_id;
 	int ret;
 
-	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE);
+	d->dpll = dpll_device_get(clock_id, d->dpll_idx, THIS_MODULE, NULL);
 	if (IS_ERR(d->dpll)) {
 		ret = PTR_ERR(d->dpll);
 		dev_err(ice_pf_to_dev(pf),
@@ -3287,7 +3287,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
 		ice_dpll_update_state(pf, d, true);
 		ret = dpll_device_register(d->dpll, type, ops, d);
 		if (ret) {
-			dpll_device_put(d->dpll);
+			dpll_device_put(d->dpll, NULL);
 			return ret;
 		}
 		d->ops = ops;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index 1e5522a194839..7c6789c478fee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -438,7 +438,7 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, mdpll);
 
 	/* Multiple mdev instances might share one DPLL device. */
-	mdpll->dpll = dpll_device_get(clock_id, 0, THIS_MODULE);
+	mdpll->dpll = dpll_device_get(clock_id, 0, THIS_MODULE, NULL);
 	if (IS_ERR(mdpll->dpll)) {
 		err = PTR_ERR(mdpll->dpll);
 		goto err_free_mdpll;
@@ -451,7 +451,8 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 
 	/* Multiple mdev instances might share one DPLL pin. */
 	mdpll->dpll_pin = dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
-				       THIS_MODULE, &mlx5_dpll_pin_properties);
+				       THIS_MODULE, &mlx5_dpll_pin_properties,
+				       NULL);
 	if (IS_ERR(mdpll->dpll_pin)) {
 		err = PTR_ERR(mdpll->dpll_pin);
 		goto err_unregister_dpll_device;
@@ -479,11 +480,11 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
 			    &mlx5_dpll_pins_ops, mdpll);
 err_put_dpll_pin:
-	dpll_pin_put(mdpll->dpll_pin);
+	dpll_pin_put(mdpll->dpll_pin, NULL);
 err_unregister_dpll_device:
 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
 err_put_dpll_device:
-	dpll_device_put(mdpll->dpll);
+	dpll_device_put(mdpll->dpll, NULL);
 err_free_mdpll:
 	kfree(mdpll);
 	return err;
@@ -499,9 +500,9 @@ static void mlx5_dpll_remove(struct auxiliary_device *adev)
 	destroy_workqueue(mdpll->wq);
 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
 			    &mlx5_dpll_pins_ops, mdpll);
-	dpll_pin_put(mdpll->dpll_pin);
+	dpll_pin_put(mdpll->dpll_pin, NULL);
 	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
-	dpll_device_put(mdpll->dpll);
+	dpll_device_put(mdpll->dpll, NULL);
 	kfree(mdpll);
 
 	mlx5_dpll_synce_status_set(mdev,
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 65fe05cac8c42..f39b3966b3e8c 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4788,7 +4788,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	devlink_register(devlink);
 
 	clkid = pci_get_dsn(pdev);
-	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
+	bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE, NULL);
 	if (IS_ERR(bp->dpll)) {
 		err = PTR_ERR(bp->dpll);
 		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
@@ -4800,7 +4800,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out;
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
-		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
+		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
+						   &bp->sma[i].dpll_prop, NULL);
 		if (IS_ERR(bp->sma[i].dpll_pin)) {
 			err = PTR_ERR(bp->sma[i].dpll_pin);
 			goto out_dpll;
@@ -4809,7 +4810,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops,
 					&bp->sma[i]);
 		if (err) {
-			dpll_pin_put(bp->sma[i].dpll_pin);
+			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
 			goto out_dpll;
 		}
 	}
@@ -4819,9 +4820,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dpll:
 	while (i--) {
 		dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-		dpll_pin_put(bp->sma[i].dpll_pin);
+		dpll_pin_put(bp->sma[i].dpll_pin, NULL);
 	}
-	dpll_device_put(bp->dpll);
+	dpll_device_put(bp->dpll, NULL);
 out:
 	ptp_ocp_detach(bp);
 out_disable:
@@ -4842,11 +4843,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		if (bp->sma[i].dpll_pin) {
 			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-			dpll_pin_put(bp->sma[i].dpll_pin);
+			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
 		}
 	}
 	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
-	dpll_device_put(bp->dpll);
+	dpll_device_put(bp->dpll, NULL);
 	devlink_unregister(devlink);
 	ptp_ocp_detach(bp);
 	pci_disable_device(pdev);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 65e86c687a6c4..d7773d134a5ed 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -19,6 +19,7 @@ struct dpll_device;
 struct dpll_pin;
 struct dpll_pin_esync;
 struct fwnode_handle;
+struct ref_tracker;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -169,6 +170,12 @@ struct dpll_pin_properties {
 	u32 phase_gran;
 };
 
+#ifdef CONFIG_DPLL_REFCNT_TRACKER
+typedef struct ref_tracker *dpll_tracker;
+#else
+typedef struct {} dpll_tracker;
+#endif
+
 #define DPLL_DEVICE_CREATED	1
 #define DPLL_DEVICE_DELETED	2
 #define DPLL_DEVICE_CHANGED	3
@@ -201,7 +208,8 @@ size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
 
-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
+				      dpll_tracker *tracker);
 struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle *fwnode,
 					       const char *name);
 #else
@@ -240,9 +248,10 @@ device_dpll_pin_node_get(struct device *dev, const char *name)
 }
 
 struct dpll_device *
-dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
+dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module,
+		dpll_tracker *tracker);
 
-void dpll_device_put(struct dpll_device *dpll);
+void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker);
 
 int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 			 const struct dpll_device_ops *ops, void *priv);
@@ -254,7 +263,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
-	     const struct dpll_pin_properties *prop);
+	     const struct dpll_pin_properties *prop, dpll_tracker *tracker);
 
 int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv);
@@ -262,7 +271,7 @@ int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 			 const struct dpll_pin_ops *ops, void *priv);
 
-void dpll_pin_put(struct dpll_pin *pin);
+void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker);
 
 void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode);
 
-- 
2.52.0


