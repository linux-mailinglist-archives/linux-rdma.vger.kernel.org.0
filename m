Return-Path: <linux-rdma+bounces-15377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B457ED0582A
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 421B43094D5E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DA312825;
	Thu,  8 Jan 2026 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ihy8t1Eq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9D3128CA
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896667; cv=none; b=qipPV0EHRBgBy4mFyGDqtbssYLtt9XPaVy5L8klZM0L5FznFcjI2MU6a8zVNgrLYDmg/N9V4qo0bA+ZMvZio/v0YuWE+VIxd5MnsXCvYpGZGTNOqT6ds+9hUxFc+5rkUE7U3GHeyN7fvaKiJn7uuYhKRjUuxSHlilrJ6f5eTLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896667; c=relaxed/simple;
	bh=qIBQYdV05Z0CQ0T/nPe4ixeSCilCJP0A6qSXSZIPvL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adn/qkdsKLZFcDNEmXyYXk55g9d6dEcmjSSavQpGJdAcIvxBbPicB6pLMp/Ma/mRudUTtwgSVT8hbVWMAPsEStMSgGGys+pd8qcpL7wMDQ0Aj/7RbyAZsutxo4Lk8ao7NpRXVghMu027Z+Cpk1iKODSGnP/lBIXvkk9snt7koSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ihy8t1Eq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767896663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oVJFOeZr/WQ+/2TA0TccN9meLF2HKhhvpxPOk8+Rhg=;
	b=Ihy8t1EqzzoBk4XPIyZmbcfSH+2wo6msezYdcWW/0e97UXbhjrOGOD3FwcBbJjxHwrvrNr
	NSPieRnwhc3O/ak40YhcwLKwlPrQHdUF6bT5NutaMAC7qgoi5frtQAHZeiUR8TnghGuMpx
	kgmXohzs98sMHjL6Q/th4GuI5zigKgE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-dVwptfFwPJqb9GOiQBwyIQ-1; Thu,
 08 Jan 2026 13:24:18 -0500
X-MC-Unique: dVwptfFwPJqb9GOiQBwyIQ-1
X-Mimecast-MFC-AGG-ID: dVwptfFwPJqb9GOiQBwyIQ_1767896655
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAA271954B14;
	Thu,  8 Jan 2026 18:24:14 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 677741800285;
	Thu,  8 Jan 2026 18:24:07 +0000 (UTC)
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
Subject: [PATCH net-next 06/12] dpll: Support dynamic pin index allocation
Date: Thu,  8 Jan 2026 19:23:12 +0100
Message-ID: <20260108182318.20935-7-ivecera@redhat.com>
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

Allow drivers to register DPLL pins without manually specifying a pin
index.

Currently, drivers must provide a unique pin index when calling
dpll_pin_get(). This works well for hardware-mapped pins but creates
friction for drivers handling virtual pins or those without a strict
hardware indexing scheme.

Introduce DPLL_PIN_IDX_UNSPEC (U32_MAX). When a driver passes this
value as the pin index:
1. The core allocates a unique index using an IDA
2. The allocated index is mapped to a range starting above `INT_MAX`

This separation ensures that dynamically allocated indices never collide
with standard driver-provided hardware indices, which are assumed to be
within the `0` to `INT_MAX` range. The index is automatically freed when
the pin is released in dpll_pin_put().

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c | 48 ++++++++++++++++++++++++++++++++++++++--
 include/linux/dpll.h     |  2 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 4efa7fbd8f21f..0c24f60b3025f 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/idr.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -24,6 +25,7 @@ DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
 
 static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
+static DEFINE_IDA(dpll_pin_idx_ida);
 
 static u32 dpll_device_xa_id;
 static u32 dpll_pin_xa_id;
@@ -468,6 +470,36 @@ void dpll_device_unregister(struct dpll_device *dpll,
 }
 EXPORT_SYMBOL_GPL(dpll_device_unregister);
 
+static int dpll_pin_idx_alloc(u32 *pin_idx)
+{
+	int ret;
+
+	if (!pin_idx)
+		return -EINVAL;
+
+	/* Alloc unique number from IDA. Number belongs to <0, INT_MAX> range */
+	ret = ida_alloc(&dpll_pin_idx_ida, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	/* Map the value to dynamic pin index range <INT_MAX+1, U32_MAX> */
+	*pin_idx = (u32)ret + INT_MAX + 1;
+
+	return 0;
+}
+
+static void dpll_pin_idx_free(u32 pin_idx)
+{
+	if (pin_idx <= INT_MAX)
+		return; /* Not a dynamic pin index */
+
+	/* Map the index value from dynamic pin index range to IDA range and
+	 * free it.
+	 */
+	pin_idx -= INT_MAX + 1;
+	ida_free(&dpll_pin_idx_ida, pin_idx);
+}
+
 static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 {
 	kfree(prop->package_label);
@@ -525,9 +557,18 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	struct dpll_pin *pin;
 	int ret;
 
+	if (pin_idx == DPLL_PIN_IDX_UNSPEC) {
+		ret = dpll_pin_idx_alloc(&pin_idx);
+		if (ret)
+			return ERR_PTR(ret);
+	} else if (pin_idx > INT_MAX) {
+		return ERR_PTR(-EINVAL);
+	}
 	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
-	if (!pin)
-		return ERR_PTR(-ENOMEM);
+	if (!pin) {
+		ret = -ENOMEM;
+		goto err_pin_alloc;
+	}
 	pin->pin_idx = pin_idx;
 	pin->clock_id = clock_id;
 	pin->module = module;
@@ -555,6 +596,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
+err_pin_alloc:
+	dpll_pin_idx_free(pin_idx);
 	return ERR_PTR(ret);
 }
 
@@ -658,6 +701,7 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->ref_sync_pins);
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
+		dpll_pin_idx_free(pin->pin_idx);
 		kfree_rcu(pin, rcu);
 	}
 	mutex_unlock(&dpll_lock);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 092abf400552b..65e86c687a6c4 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -250,6 +250,8 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv);
 
+#define DPLL_PIN_IDX_UNSPEC	U32_MAX
+
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
 	     const struct dpll_pin_properties *prop);
-- 
2.52.0


