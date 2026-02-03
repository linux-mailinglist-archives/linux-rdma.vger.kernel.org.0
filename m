Return-Path: <linux-rdma+bounces-16483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKGnHVg0gmlTQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:46:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7843DD086
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FEC53150B78
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E505B355041;
	Tue,  3 Feb 2026 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjZRK6xY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E533A9FF
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140446; cv=none; b=XY1H9Xcz4AGSFD25tDLID+YECklG9vLIOHT1uEmfBa/NwAYO2xgAa2R9fZgHOSs+CYoV8cjzDtO3jW7SF5pMmqtsafSBISSgTGGvkgHM5aea9rcHrK4lSdpNi59xWZxZtvAJRIEkgXZT/Qv/P8FrYGm6vLTdBYiaJCVGx7HWoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140446; c=relaxed/simple;
	bh=uLNj6scjWKuUHHTRWcuYRcxN5A9jALITu3FmF0q5Z1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUD2vZDLZM4htQnO1XKLcLYw7av4KxJMJAszyxqiLw5C5gqZ/TiYXsHdZVrzC/LQqgBDcY+1DFJl2uvutt30ZDpQ2Vp//XE0AY+wQ7U2HwdQX86JT165xUa/Km7PNmHUqJPKTWJc+RKmHc13zfsYkIdvEPTRyuzQsoa1JULyJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjZRK6xY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770140444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swufWl6SHGcyC7YD5gze37xCr7gFlNxzAIYlJ+GmO3U=;
	b=HjZRK6xYnGvMm4CuO16ZF6B3zXudPyDHmnlTE5DaNbHH69ISPTq2yZua9UtVX5AAOKnN6X
	FioiWT15/AJYrePS82C1aWNDiQFIn/gYu0PXMibFcKFQrknWrZZ4nUQPGfN1hdROqXcEAv
	SANcUvI0NO2q4F1mX6YcFTpSNNhgMCg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-BNtItwj8P-il7I9leF_O1A-1; Tue,
 03 Feb 2026 12:40:40 -0500
X-MC-Unique: BNtItwj8P-il7I9leF_O1A-1
X-Mimecast-MFC-AGG-ID: BNtItwj8P-il7I9leF_O1A_1770140437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F361956048;
	Tue,  3 Feb 2026 17:40:37 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C47B73001DBA;
	Tue,  3 Feb 2026 17:40:30 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 4/9] dpll: Support dynamic pin index allocation
Date: Tue,  3 Feb 2026 18:39:57 +0100
Message-ID: <20260203174002.705176-5-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-1-ivecera@redhat.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16483-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7843DD086
X-Rspamd-Action: no action

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

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* fixed integer overflow in dpll_pin_idx_free()
---
 drivers/dpll/dpll_core.c | 48 ++++++++++++++++++++++++++++++++++++++--
 include/linux/dpll.h     |  2 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index b05fe2ba46d91..59081cf2c73ae 100644
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
@@ -464,6 +466,36 @@ void dpll_device_unregister(struct dpll_device *dpll,
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
+	pin_idx -= (u32)INT_MAX + 1;
+	ida_free(&dpll_pin_idx_ida, pin_idx);
+}
+
 static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 {
 	kfree(prop->package_label);
@@ -521,9 +553,18 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
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
@@ -551,6 +592,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	dpll_pin_prop_free(&pin->prop);
 err_pin_prop:
 	kfree(pin);
+err_pin_alloc:
+	dpll_pin_idx_free(pin_idx);
 	return ERR_PTR(ret);
 }
 
@@ -654,6 +697,7 @@ void dpll_pin_put(struct dpll_pin *pin)
 		xa_destroy(&pin->ref_sync_pins);
 		dpll_pin_prop_free(&pin->prop);
 		fwnode_handle_put(pin->fwnode);
+		dpll_pin_idx_free(pin->pin_idx);
 		kfree_rcu(pin, rcu);
 	}
 	mutex_unlock(&dpll_lock);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 8ed90dfc65f05..8fff048131f1d 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -240,6 +240,8 @@ int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
 void dpll_device_unregister(struct dpll_device *dpll,
 			    const struct dpll_device_ops *ops, void *priv);
 
+#define DPLL_PIN_IDX_UNSPEC	U32_MAX
+
 struct dpll_pin *
 dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
 	     const struct dpll_pin_properties *prop);
-- 
2.52.0


