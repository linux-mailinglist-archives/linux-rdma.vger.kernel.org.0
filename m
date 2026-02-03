Return-Path: <linux-rdma+bounces-16482-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JM0HS40gmlTQgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16482-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:45:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D22DD05E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E7F30773C8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34D361650;
	Tue,  3 Feb 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aubl7g1W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A334AAF9
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140440; cv=none; b=I3orqb6D08LsmC7xZm5JPfekZIHImJ9F1AwFwMTCFMzle1fDZ9FgVXR2u8CTWBKxT5kT7oFBjz4t+ptiIuL9AsQbOHE4a8XyEmwVnZDOIsfcjARtdwH9ZrImlNrTQGzJFDLTgr6dKOuxcXPPhaRr9us8PEriNaS9617yh2VzIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140440; c=relaxed/simple;
	bh=Wu4TFjJn7wdJkKWvlWIf/Y9H66rs7imfLQoxr2ebYhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKNC1PIhqv1cSE08sDz4O0M8d5PTVhlkRulfwvD8oNstPt2jMlsYY0haAjZfhNP8kF0SPnW1HSjuuuiDMuYMwsdFOdgiMU686Y4jFMem6No/07DuKuijEpHRT91Jo9qUBHZ/Cj1fdLFoy0orOBGVZ5Aio0zZktH3id87JZdKsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aubl7g1W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770140436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QV89xPUnCNJIH6v1OPSMlUsAUmfkwSqBeHfnsysjb1c=;
	b=Aubl7g1WuoYmW/Nkat/0s5xDZh2dl7RLcAiKsNHmUJCDWDNWfMeU2jgtzKQpwKvrpRv+ZR
	sXvWtNtcVlT0ma7wBq24fqx3rrdHTp04uS8W+e+kZlG1Lpa3A5SD3UPmbKl2l0zt6MkKP2
	/yNPZGfHe/F8EGutZbVltBdZBw4jPxo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-PoA89Cl-O22aPNebNTLJpA-1; Tue,
 03 Feb 2026 12:40:33 -0500
X-MC-Unique: PoA89Cl-O22aPNebNTLJpA-1
X-Mimecast-MFC-AGG-ID: PoA89Cl-O22aPNebNTLJpA_1770140430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE4818003FD;
	Tue,  3 Feb 2026 17:40:30 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76B2230001A7;
	Tue,  3 Feb 2026 17:40:24 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 3/9] dpll: Add notifier chain for dpll events
Date: Tue,  3 Feb 2026 18:39:56 +0100
Message-ID: <20260203174002.705176-4-ivecera@redhat.com>
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
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,microchip.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16482-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1D22DD05E
X-Rspamd-Action: no action

From: Petr Oros <poros@redhat.com>

Currently, the DPLL subsystem reports events (creation, deletion, changes)
to userspace via Netlink. However, there is no mechanism for other kernel
components to be notified of these events directly.

Add a raw notifier chain to the DPLL core protected by dpll_lock. This
allows other kernel subsystems or drivers to register callbacks and
receive notifications when DPLL devices or pins are created, deleted,
or modified.

Define the following:
- Registration helpers: {,un}register_dpll_notifier()
- Event types: DPLL_DEVICE_CREATED, DPLL_PIN_CREATED, etc.
- Context structures: dpll_{device,pin}_notifier_info  to pass relevant
  data to the listeners.

The notification chain is invoked alongside the existing Netlink event
generation to ensure in-kernel listeners are kept in sync with the
subsystem state.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Co-developed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_core.c    | 57 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h    |  4 +++
 drivers/dpll/dpll_netlink.c |  6 ++++
 include/linux/dpll.h        | 29 +++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index f04ed7195cadd..b05fe2ba46d91 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -23,6 +23,8 @@ DEFINE_MUTEX(dpll_lock);
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
 
+static RAW_NOTIFIER_HEAD(dpll_notifier_chain);
+
 static u32 dpll_device_xa_id;
 static u32 dpll_pin_xa_id;
 
@@ -46,6 +48,39 @@ struct dpll_pin_registration {
 	void *cookie;
 };
 
+static int call_dpll_notifiers(unsigned long action, void *info)
+{
+	lockdep_assert_held(&dpll_lock);
+	return raw_notifier_call_chain(&dpll_notifier_chain, action, info);
+}
+
+void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
+{
+	struct dpll_device_notifier_info info = {
+		.dpll = dpll,
+		.id = dpll->id,
+		.idx = dpll->device_idx,
+		.clock_id = dpll->clock_id,
+		.type = dpll->type,
+	};
+
+	call_dpll_notifiers(action, &info);
+}
+
+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
+{
+	struct dpll_pin_notifier_info info = {
+		.pin = pin,
+		.id = pin->id,
+		.idx = pin->pin_idx,
+		.clock_id = pin->clock_id,
+		.fwnode = pin->fwnode,
+		.prop = &pin->prop,
+	};
+
+	call_dpll_notifiers(action, &info);
+}
+
 struct dpll_device *dpll_device_get_by_id(int id)
 {
 	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
@@ -539,6 +574,28 @@ void dpll_netdev_pin_clear(struct net_device *dev)
 }
 EXPORT_SYMBOL(dpll_netdev_pin_clear);
 
+int register_dpll_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&dpll_lock);
+	ret = raw_notifier_chain_register(&dpll_notifier_chain, nb);
+	mutex_unlock(&dpll_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_dpll_notifier);
+
+int unregister_dpll_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&dpll_lock);
+	ret = raw_notifier_chain_unregister(&dpll_notifier_chain, nb);
+	mutex_unlock(&dpll_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(unregister_dpll_notifier);
+
 /**
  * dpll_pin_get - find existing or create new dpll pin
  * @clock_id: clock_id of creator
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index d3e17ff0ecef0..b7b4bb251f739 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -91,4 +91,8 @@ struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
 extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
+
+void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
+void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
+
 #endif
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 904199ddd1781..83cbd64abf5a4 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -761,17 +761,20 @@ dpll_device_event_send(enum dpll_cmd event, struct dpll_device *dpll)
 
 int dpll_device_create_ntf(struct dpll_device *dpll)
 {
+	dpll_device_notify(dpll, DPLL_DEVICE_CREATED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CREATE_NTF, dpll);
 }
 
 int dpll_device_delete_ntf(struct dpll_device *dpll)
 {
+	dpll_device_notify(dpll, DPLL_DEVICE_DELETED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
 }
 
 static int
 __dpll_device_change_ntf(struct dpll_device *dpll)
 {
+	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
 
@@ -829,16 +832,19 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 
 int dpll_pin_create_ntf(struct dpll_pin *pin)
 {
+	dpll_pin_notify(pin, DPLL_PIN_CREATED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
 }
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin)
 {
+	dpll_pin_notify(pin, DPLL_PIN_DELETED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
+	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index f2e8660e90cdf..8ed90dfc65f05 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/netlink.h>
 #include <linux/netdevice.h>
+#include <linux/notifier.h>
 #include <linux/rtnetlink.h>
 
 struct dpll_device;
@@ -172,6 +173,30 @@ struct dpll_pin_properties {
 	u32 phase_gran;
 };
 
+#define DPLL_DEVICE_CREATED	1
+#define DPLL_DEVICE_DELETED	2
+#define DPLL_DEVICE_CHANGED	3
+#define DPLL_PIN_CREATED	4
+#define DPLL_PIN_DELETED	5
+#define DPLL_PIN_CHANGED	6
+
+struct dpll_device_notifier_info {
+	struct dpll_device *dpll;
+	u32 id;
+	u32 idx;
+	u64 clock_id;
+	enum dpll_type type;
+};
+
+struct dpll_pin_notifier_info {
+	struct dpll_pin *pin;
+	u32 id;
+	u32 idx;
+	u64 clock_id;
+	const struct fwnode_handle *fwnode;
+	const struct dpll_pin_properties *prop;
+};
+
 #if IS_ENABLED(CONFIG_DPLL)
 void dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin);
 void dpll_netdev_pin_clear(struct net_device *dev);
@@ -242,4 +267,8 @@ int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
+int register_dpll_notifier(struct notifier_block *nb);
+
+int unregister_dpll_notifier(struct notifier_block *nb);
+
 #endif
-- 
2.52.0


