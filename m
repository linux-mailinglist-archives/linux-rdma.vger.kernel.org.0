Return-Path: <linux-rdma+bounces-16363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIwuGcrdgGleCAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:24:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA6CF908
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFEE1305A95D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C5A387379;
	Mon,  2 Feb 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBkeuE9I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7D387345
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052624; cv=none; b=hAzvkKVKQwcugEad6kltp72kNjMR5izwqf6sMHeuLyGm0rnnpzuB0DH5dkh308U/a4Wk5mw7Nq1lat1rQ1b2VkZ3USM01pd5MZxTN9A2vI5OnfoMRY+iZhlyetuycNtUov4O0oWmT02QlqC2PxnMoCcsWdSQuDSlrDEe0N4jwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052624; c=relaxed/simple;
	bh=7MdL99wkkvJKCcspFZ7dHx/o5TRD0QM+Phv7EkFdsGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlBhnqxLd9PkiMU9KwjcEEl9m7TPo0Pwe/Y07g9p9zubn2H18jXV2dUZrCtarwbTFYkTsPwXB2012ON3c4Ai0pKs2hYjdlIZJuzOg1DsSeO+oMdHipIJodHFdCMiYB01GDIfNNJS69cgBvxZiEOV7xUOlYrJxNE2GMx549XjwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBkeuE9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770052622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ieWU+M1MjJPFA1lViUGn95ZPJD7pQx03GN9yV+TnYA8=;
	b=bBkeuE9IQ/vbEbZjC8beXTBD+8t/NwsCM7IdarFUmLmLBZ2XpMMcm5gWZ2kLsLlxj6qxZP
	T4IfYLbw5ivLIpFmw6ZXHmKclYaSoMt0pMa8ON7u1gEdr/aH+fmJpgeosoO1ssi3wg7aus
	X7owtNJ9sOdnrxWP4YzVK5znRRSJNjQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-HlHu_F3eMXCOysbxfmgXNQ-1; Mon,
 02 Feb 2026 12:16:57 -0500
X-MC-Unique: HlHu_F3eMXCOysbxfmgXNQ-1
X-Mimecast-MFC-AGG-ID: HlHu_F3eMXCOysbxfmgXNQ_1770052613
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC2F3195606D;
	Mon,  2 Feb 2026 17:16:52 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADE8D19560B4;
	Mon,  2 Feb 2026 17:16:46 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
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
Subject: [PATCH net-next v4 1/9] dpll: Allow associating dpll pin with a firmware node
Date: Mon,  2 Feb 2026 18:16:30 +0100
Message-ID: <20260202171638.17427-2-ivecera@redhat.com>
In-Reply-To: <20260202171638.17427-1-ivecera@redhat.com>
References: <20260202171638.17427-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16363-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 19CA6CF908
X-Rspamd-Action: no action

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

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v4:
* fixed fwnode_dpll_pin_find() return value description
---
 drivers/dpll/dpll_core.c | 49 ++++++++++++++++++++++++++++++++++++++++
 drivers/dpll/dpll_core.h |  2 ++
 include/linux/dpll.h     | 11 +++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 8879a72351561..f04ed7195cadd 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -595,12 +596,60 @@ void dpll_pin_put(struct dpll_pin *pin)
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
+ * * valid dpll_pin pointer on success
+ * * NULL when no such pin exists
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
index c6d0248fa5273..f2e8660e90cdf 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -16,6 +16,7 @@
 struct dpll_device;
 struct dpll_pin;
 struct dpll_pin_esync;
+struct fwnode_handle;
 
 struct dpll_device_ops {
 	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
@@ -178,6 +179,8 @@ void dpll_netdev_pin_clear(struct net_device *dev);
 size_t dpll_netdev_pin_handle_size(const struct net_device *dev);
 int dpll_netdev_add_pin_handle(struct sk_buff *msg,
 			       const struct net_device *dev);
+
+struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
 #else
 static inline void
 dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) { }
@@ -193,6 +196,12 @@ dpll_netdev_add_pin_handle(struct sk_buff *msg, const struct net_device *dev)
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
@@ -218,6 +227,8 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 
 void dpll_pin_put(struct dpll_pin *pin);
 
+void dpll_pin_fwnode_set(struct dpll_pin *pin, struct fwnode_handle *fwnode);
+
 int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			     const struct dpll_pin_ops *ops, void *priv);
 
-- 
2.52.0


