Return-Path: <linux-rdma+bounces-14971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D2CB7160
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 20:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D89843016B82
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FED320CB6;
	Thu, 11 Dec 2025 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9qq6gTc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE3320A22
	for <linux-rdma@vger.kernel.org>; Thu, 11 Dec 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482588; cv=none; b=hbH/OMuFHmTKg2FeL6K++cofvklqL731i6dJROdOKValrf/GjfakUw9M/1I7uiaqA/uDj7uDGbOGrv9S8dBNWQFejee7yng4cqSxGqW5hY2gk7UiOHFWMd6NiL//ZpC4OeFW1raV5JihGcLszrM0Isvnvw1quqRC/Mnk0nLjw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482588; c=relaxed/simple;
	bh=CuUolZYFgBGUrVHBHjzxcBr2HFEuvc4Bx20czTwstAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqUIyxGaiurStxmCXP6wITKbkPh1iMZQTkM9Vi1fMOalufCP7Zplmf3lUWGIg6E2VbMqWYdTM2rJDO0+NWpRRJYSssHpi2qteXWKJNGAFx1irO+NQnjIjZXmBl+rqwTxQP4T/XYw2QpXb4+b+YIyUUG3lxHky581r0xouIe3S5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9qq6gTc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765482584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmdGnu3IICvqQA7mfUylgPCo9eXyG8heihdFQpAo0UI=;
	b=e9qq6gTcsgA3msL+2SY+s4mvkJ2HXAGgqp9+NIQGLSUWO+cju7+ODJZVwXISb70WzX+fIm
	Smgh8Pq7EYhUap2MB3XG6josPIproTUQYxZuUg51yFgVBtTbLsnHF3S/wn9sZKMKKdHwPe
	oVFthpthy9Di3JzUi+VNpvZHcpaih00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-J872iJh6NQyGhvXXY36oyw-1; Thu,
 11 Dec 2025 14:49:41 -0500
X-MC-Unique: J872iJh6NQyGhvXXY36oyw-1
X-Mimecast-MFC-AGG-ID: J872iJh6NQyGhvXXY36oyw_1765482576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 883FE1956046;
	Thu, 11 Dec 2025 19:49:36 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E5401956056;
	Thu, 11 Dec 2025 19:49:27 +0000 (UTC)
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
Subject: [PATCH RFC net-next 10/13] dpll: Add reference count tracking support
Date: Thu, 11 Dec 2025 20:47:53 +0100
Message-ID: <20251211194756.234043-11-ivecera@redhat.com>
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
 drivers/dpll/dpll_core.c                      | 93 ++++++++++++++-----
 drivers/dpll/dpll_core.h                      |  5 +
 drivers/dpll/zl3073x/dpll.c                   | 12 +--
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 14 +--
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 12 +--
 drivers/ptp/ptp_ocp.c                         | 15 +--
 include/linux/dpll.h                          | 19 +++-
 8 files changed, 132 insertions(+), 53 deletions(-)

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
index f9b60be8962a5..b569a16d0fe8f 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -41,6 +41,7 @@ struct dpll_device_registration {
 	struct list_head list;
 	const struct dpll_device_ops *ops;
 	void *priv;
+	dpll_tracker tracker;
 };
 
 struct dpll_pin_registration {
@@ -48,6 +49,7 @@ struct dpll_pin_registration {
 	const struct dpll_pin_ops *ops;
 	void *priv;
 	void *cookie;
+	dpll_tracker tracker;
 };
 
 static int call_dpll_notifiers(unsigned long action, void *info)
@@ -83,33 +85,68 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
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
@@ -118,6 +155,7 @@ static void __dpll_pin_put(struct dpll_pin *pin)
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
 		dpll_pin_idx_free(pin->pin_idx);
+		ref_tracker_dir_exit(&pin->refcnt_tracker);
 		kfree_rcu(pin, rcu);
 	}
 }
@@ -191,7 +229,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
-	__dpll_pin_hold(pin);
+	__dpll_pin_hold(pin, &reg->tracker);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -214,7 +252,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		if (WARN_ON(!reg))
 			return -EINVAL;
 		list_del(&reg->list);
-		__dpll_pin_put(pin);
+		__dpll_pin_put(pin, &reg->tracker);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_pins, i);
@@ -272,7 +310,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	reg->ops = ops;
 	reg->priv = priv;
 	reg->cookie = cookie;
-	__dpll_device_hold(dpll);
+	__dpll_device_hold(dpll, &reg->tracker);
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -295,7 +333,7 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		if (WARN_ON(!reg))
 			return;
 		list_del(&reg->list);
-		__dpll_device_put(dpll);
+		__dpll_device_put(dpll, &reg->tracker);
 		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
 			xa_erase(xa_dplls, i);
@@ -337,6 +375,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 		return ERR_PTR(ret);
 	}
 	xa_init_flags(&dpll->pin_refs, XA_FLAGS_ALLOC);
+	ref_tracker_dir_init(&dpll->refcnt_tracker, 128, "dpll_device");
 
 	return dpll;
 }
@@ -356,7 +395,8 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
  * * ERR_PTR(X) - error
  */
 struct dpll_device *
-dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
+dpll_device_get(u64 clock_id, u32 device_idx, struct module *module,
+		dpll_tracker *tracker)
 {
 	struct dpll_device *dpll, *ret = NULL;
 	unsigned long index;
@@ -366,13 +406,17 @@ dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
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
@@ -387,10 +431,10 @@ EXPORT_SYMBOL_GPL(dpll_device_get);
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
@@ -452,7 +496,7 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 	reg->ops = ops;
 	reg->priv = priv;
 	dpll->type = type;
-	__dpll_device_hold(dpll);
+	__dpll_device_hold(dpll, &reg->tracker);
 	first_registration = list_empty(&dpll->registration_list);
 	list_add_tail(&reg->list, &dpll->registration_list);
 	if (!first_registration) {
@@ -492,7 +536,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 		return;
 	}
 	list_del(&reg->list);
-	__dpll_device_put(dpll);
+	__dpll_device_put(dpll, &reg->tracker);
 	kfree(reg);
 
 	if (!list_empty(&dpll->registration_list)) {
@@ -624,6 +668,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (ret < 0)
 		goto err_xa_alloc;
 	pin->fwnode = fwnode_handle_get(fwnode);
+	ref_tracker_dir_init(&pin->refcnt_tracker, 128, "dpll_pin");
 	return pin;
 err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
@@ -698,7 +743,7 @@ EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 	     const struct dpll_pin_properties *prop,
-	     struct fwnode_handle *fwnode)
+	     struct fwnode_handle *fwnode, dpll_tracker *tracker)
 {
 	struct dpll_pin *pos, *ret = NULL;
 	unsigned long i;
@@ -709,13 +754,16 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
 		    pos->pin_idx == pin_idx &&
 		    pos->module == module &&
 		    pos->fwnode == fwnode) {
-			__dpll_pin_hold(pos);
+			__dpll_pin_hold(pos, tracker);
 			ret = pos;
 			break;
 		}
 	}
-	if (!ret)
+	if (!ret) {
 		ret = dpll_pin_alloc(clock_id, pin_idx, module, prop, fwnode);
+		if (!IS_ERR(ret))
+			dpll_pin_tracker_alloc(ret, tracker);
+	}
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -730,10 +778,10 @@ EXPORT_SYMBOL_GPL(dpll_pin_get);
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
@@ -750,7 +798,8 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
  * * valid dpll_pin struct pointer if succeeded
  * * ERR_PTR(X) - error
  */
-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
+				      dpll_tracker *tracker)
 {
 	struct dpll_pin *pin, *ret = NULL;
 	unsigned long index;
@@ -758,7 +807,7 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
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
index 198cc2b703e96..4135c621ec1aa 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1369,7 +1369,7 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 
 	/* Create or get existing DPLL pin */
 	pin->dpll_pin = dpll_pin_get(zldpll->dev->clock_id, index, THIS_MODULE,
-				     &props->dpll_props, props->fwnode);
+				     &props->dpll_props, props->fwnode, NULL);
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
index 1c28af5a2d5e0..39cf26987b35c 100644
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
-					   &pins[i].prop, NULL);
+					   &pins[i].prop, NULL, NULL);
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
index 9e71164f463df..9de520c4501d7 100644
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
@@ -452,7 +452,7 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
 	/* Multiple mdev instances might share one DPLL pin. */
 	mdpll->dpll_pin = dpll_pin_get(clock_id, mlx5_get_dev_index(mdev),
 				       THIS_MODULE, &mlx5_dpll_pin_properties,
-				       NULL);
+				       NULL, NULL);
 	if (IS_ERR(mdpll->dpll_pin)) {
 		err = PTR_ERR(mdpll->dpll_pin);
 		goto err_unregister_dpll_device;
@@ -480,11 +480,11 @@ static int mlx5_dpll_probe(struct auxiliary_device *adev,
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
@@ -500,9 +500,9 @@ static void mlx5_dpll_remove(struct auxiliary_device *adev)
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
index fd7d1132afdf0..65b743a53e63d 100644
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
@@ -4801,7 +4801,8 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
-						   &bp->sma[i].dpll_prop, NULL);
+						   &bp->sma[i].dpll_prop, NULL,
+						   NULL);
 		if (IS_ERR(bp->sma[i].dpll_pin)) {
 			err = PTR_ERR(bp->sma[i].dpll_pin);
 			goto out_dpll;
@@ -4810,7 +4811,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		err = dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops,
 					&bp->sma[i]);
 		if (err) {
-			dpll_pin_put(bp->sma[i].dpll_pin);
+			dpll_pin_put(bp->sma[i].dpll_pin, NULL);
 			goto out_dpll;
 		}
 	}
@@ -4820,9 +4821,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -4843,11 +4844,11 @@ ptp_ocp_remove(struct pci_dev *pdev)
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
index 8aa1df38ce563..05b4141e17dbf 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -18,6 +18,7 @@ struct dpll_device;
 struct dpll_pin;
 struct dpll_pin_esync;
 struct fwnode_handle;
+struct ref_tracker;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -168,6 +169,12 @@ struct dpll_pin_properties {
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
@@ -200,7 +207,8 @@ size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
 
-struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode,
+				      dpll_tracker *tracker);
 #else
 static inline void
 dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
@@ -225,9 +233,10 @@ fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
 #endif
 
 struct dpll_device *
-dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
+dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module,
+		dpll_tracker *tracker);
 
-void dpll_device_put(struct dpll_device *dpll);
+void dpll_device_put(struct dpll_device *dpll, dpll_tracker *tracker);
 
 int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 			 const struct dpll_device_ops *ops, void *priv);
@@ -240,7 +249,7 @@ void dpll_device_unregister(struct dpll_device *dpll,
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
 	     const struct dpll_pin_properties *prop,
-	     struct fwnode_handle *fwnode);
+	     struct fwnode_handle *fwnode, dpll_tracker *tracker);
 
 int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      const struct dpll_pin_ops *ops, void *priv);
@@ -248,7 +257,7 @@ int dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 			 const struct dpll_pin_ops *ops, void *priv);
 
-void dpll_pin_put(struct dpll_pin *pin);
+void dpll_pin_put(struct dpll_pin *pin, dpll_tracker *tracker);
 
 int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			     const struct dpll_pin_ops *ops, void *priv);
-- 
2.51.2


