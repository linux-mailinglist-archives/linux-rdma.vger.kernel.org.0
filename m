Return-Path: <linux-rdma+bounces-20299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB0qHEtCAGqcFQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:31:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2B5031B6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC1A300A10F
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47809312832;
	Sun, 10 May 2026 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bqIppK9R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA1367F39
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401865; cv=none; b=stLghdPN48hbC0SAD9VV/WCBEm35vI2/Jle6cpp+MIWKrSmvmtM5N0nyEnhsbwkzgOjEZH31JCVw6vuMM+VR7iVCU2Lnc0U+SZ4v4+u915K6pVEhmb0U4BtnQh7b/RPds6NORGKGscqLUOvxGRoBLH5V5ubG/5mXaf8ZqpTRgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401865; c=relaxed/simple;
	bh=LO+bJFoAciHCuqaeosNJh9v53yt+E3eR29hBWepATEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsGLh6sZ0MjqANhiD0VOGpBrnU0KyxptxHGAOEHBQOuO9aQ/niXJpCHav81+oBQc+jsB5SUc2CKlzBo+7ecpQX9F0gQ0sXGklbsjArEcgiOF1bw/E7ZMn2e6PGcA3Tark91SXuAfQ8yyCrtq26pfur3HhjttF78fC1YMP7yACXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bqIppK9R; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778401863; x=1809937863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxNUBrcG/Er93czf5eVZzfo1bmUK0QTvF3H772tCOl4=;
  b=bqIppK9Rb2KXvzTDau48P4T3fgARs69+Etri98EuJKZpy3QOXCdJVZMf
   IvjJwZx7df/pD3kVYEjmxBArnwLdywpeqCswOLdSdtdS/Ie3QCLpaTwok
   5L5XNEQmFz0HEurZn1fcDvnacXfyYQHehLDKxt7qZ9BTiy417vl9azwZk
   MNdTj7na9P4lEvlIbndCN7P6PmO8CpgmE/9J1Id0p4z4hudkwJoDX2FW8
   aq6ek5NSQD5UaN96JHrMDvkLIcJyYimZQFysWhtUeGikGljWz/HbibkUW
   Lg4Sh5JgB7hCcQ8+yLC7aVv6X90INYQMMeTE6b1IGED3HruyzD2STYTA6
   w==;
X-CSE-ConnectionGUID: q1xyRADSSRO11Jpnq8cvQg==
X-CSE-MsgGUID: HJNtiMNyT82l2+S0iIwk1g==
X-IronPort-AV: E=Sophos;i="6.23,227,1770595200"; 
   d="scan'208";a="19295419"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 08:31:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:14858]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.140:2525] with esmtp (Farcaster)
 id c6632545-dab1-48ad-9b90-df4ef1f7f14c; Sun, 10 May 2026 08:31:00 +0000 (UTC)
X-Farcaster-Flow-ID: c6632545-dab1-48ad-9b90-df4ef1f7f14c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 10 May 2026 08:31:00 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 10 May 2026
 08:30:58 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Add AH cache handling on create and destroy AH
Date: Sun, 10 May 2026 08:30:35 +0000
Message-ID: <20260510083035.458081-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260510083035.458081-1-ynachum@amazon.com>
References: <20260510083035.458081-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 2EF2B5031B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20299-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On create AH, first check if the AH cache entry already exists and if
so, returns the already stored AH number. If the entry doesn't exist,
the driver creates it and calls the device to create the AH. A per-entry
mutex serializes concurrent device commands on the same AH cache entry,
ensuring only one thread issues the device create while others wait and
reuse the result. If the device create fails, the entry remains
uninitialized so subsequent threads calls can create the AH.

On destroy AH, the refcount is checked and if it's the last reference,
the driver issues the device destroy command while holding the entry
mutex. The entry remains in the hashtable during destroy to allow
concurrent create threads to find it and wait on the entry mutex,
preventing create-before-destroy races on the device. After the device
destroy completes, the entry is either recycled if new users arrived or
removed and freed.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_ah_cache.c | 124 +++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |   5 +
 drivers/infiniband/hw/efa/efa_com_cmd.c  |  27 +++++
 drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
 5 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.c b/drivers/infiniband/hw/efa/efa_ah_cache.c
index d31871eb9748..28c91a2fd6a0 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.c
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -3,6 +3,8 @@
  * Copyright 2026 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
+#include <linux/slab.h>
+
 #include "efa_ah_cache.h"
 
 static const struct rhashtable_params ah_cache_params = {
@@ -28,3 +30,125 @@ void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
 	rhashtable_destroy(&ah_cache->hashtable);
 	mutex_destroy(&ah_cache->lock);
 }
+
+static struct efa_ah_cache_entry *efa_ah_cache_lookup(struct efa_ah_cache *ah_cache, u16 pd,
+						      u8 *gid)
+	__must_hold(&ah_cache->lock)
+{
+	struct efa_ah_cache_key key;
+
+	memcpy(key.gid, gid, sizeof(key.gid));
+	key.pd = pd;
+
+	return rhashtable_lookup_fast(&ah_cache->hashtable, &key, ah_cache_params);
+}
+
+/**
+ * efa_ah_cache_get_or_create - Get or create an AH cache entry
+ * @ah_cache: AH cache
+ * @pd: Protection domain number
+ * @gid: GID address
+ *
+ * Look up an AH cache entry by PD and GID. If found, increment the refcount and
+ * return it. If not found, allocate a new entry and insert it into the
+ * hashtable. The entry is returned unlocked.
+ *
+ * Return: Pointer to the entry on success, ERR_PTR on failure.
+ */
+struct efa_ah_cache_entry *efa_ah_cache_get_or_create(struct efa_ah_cache *ah_cache, u16 pd,
+						      u8 *gid)
+{
+	struct efa_ah_cache_entry *entry;
+	int err;
+
+	mutex_lock(&ah_cache->lock);
+
+	entry = efa_ah_cache_lookup(ah_cache, pd, gid);
+	if (entry) {
+		refcount_inc(&entry->refcount);
+		mutex_unlock(&ah_cache->lock);
+		return entry;
+	}
+
+	entry = kvzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		mutex_unlock(&ah_cache->lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	memcpy(entry->key.gid, gid, sizeof(entry->key.gid));
+	entry->key.pd = pd;
+	refcount_set(&entry->refcount, 1);
+	mutex_init(&entry->lock);
+
+	err = rhashtable_insert_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
+	if (err) {
+		mutex_destroy(&entry->lock);
+		kvfree(entry);
+		mutex_unlock(&ah_cache->lock);
+		return ERR_PTR(err);
+	}
+
+	mutex_unlock(&ah_cache->lock);
+	return entry;
+}
+
+/**
+ * efa_ah_cache_put_unless_last - Release a reference to an AH cache entry
+ * @ah_cache: AH cache
+ * @pd: Protection domain number
+ * @gid: GID address
+ *
+ * If this is not the last reference, decrement the refcount and return NULL.
+ * If this is the last reference, return the entry with its mutex locked
+ * without decrementing.
+ *
+ * Return: Pointer to the locked entry if last reference, NULL otherwise.
+ */
+struct efa_ah_cache_entry *efa_ah_cache_put_unless_last(struct efa_ah_cache *ah_cache, u16 pd,
+							u8 *gid)
+{
+	struct efa_ah_cache_entry *entry;
+
+	mutex_lock(&ah_cache->lock);
+	entry = efa_ah_cache_lookup(ah_cache, pd, gid);
+	if (!entry) {
+		mutex_unlock(&ah_cache->lock);
+		return NULL;
+	}
+
+	if (refcount_dec_not_one(&entry->refcount)) {
+		mutex_unlock(&ah_cache->lock);
+		return NULL;
+	}
+
+	mutex_lock(&entry->lock);
+	mutex_unlock(&ah_cache->lock);
+	return entry;
+}
+
+/**
+ * efa_ah_cache_put - Release the final reference to an AH cache entry
+ * @ah_cache: AH cache
+ * @entry: AH cache entry
+ *
+ * Decrement the refcount. If it reaches zero, the entry is removed from the
+ * hashtable and freed. Otherwise, the entry is kept for reuse.
+ *
+ * Called after the device destroy completes or on a failed create to release
+ * the caller's reference.
+ */
+void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
+{
+	mutex_lock(&ah_cache->lock);
+	if (!refcount_dec_and_test(&entry->refcount)) {
+		mutex_unlock(&ah_cache->lock);
+		return;
+	}
+
+	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
+	mutex_unlock(&ah_cache->lock);
+
+	mutex_destroy(&entry->lock);
+	kvfree(entry);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
index 25288fdf778a..9ddd9fedcf76 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.h
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -32,5 +32,10 @@ struct efa_ah_cache {
 
 int efa_ah_cache_init(struct efa_ah_cache *ah_cache);
 void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache);
+struct efa_ah_cache_entry *efa_ah_cache_get_or_create(struct efa_ah_cache *ah_cache, u16 pd,
+						      u8 *gid);
+struct efa_ah_cache_entry *efa_ah_cache_put_unless_last(struct efa_ah_cache *ah_cache, u16 pd,
+							u8 *gid);
+void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry);
 
 #endif /* _EFA_AH_CACHE_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 63c7f07806a8..34a130fa92b5 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -320,8 +320,20 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 	struct efa_admin_create_ah_resp cmd_completion;
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_admin_create_ah_cmd ah_cmd = {};
+	struct efa_ah_cache_entry *entry;
 	int err;
 
+	entry = efa_ah_cache_get_or_create(&edev->ah_cache, params->pdn, params->dest_addr);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	mutex_lock(&entry->lock);
+	if (entry->initialized) {
+		result->ah = entry->ah;
+		mutex_unlock(&entry->lock);
+		return 0;
+	}
+
 	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_CREATE_AH;
 
 	memcpy(ah_cmd.dest_addr, params->dest_addr, sizeof(ah_cmd.dest_addr));
@@ -333,13 +345,18 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
+		mutex_unlock(&entry->lock);
+		efa_ah_cache_put(&edev->ah_cache, entry);
 		ibdev_err_ratelimited(edev->efa_dev,
 				      "Failed to create ah for %pI6 [%d]\n",
 				      ah_cmd.dest_addr, err);
 		return err;
 	}
 
+	entry->ah = cmd_completion.ah;
+	entry->initialized = true;
 	result->ah = cmd_completion.ah;
+	mutex_unlock(&entry->lock);
 
 	return 0;
 }
@@ -350,8 +367,13 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 	struct efa_admin_destroy_ah_resp cmd_completion;
 	struct efa_admin_destroy_ah_cmd ah_cmd = {};
 	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_ah_cache_entry *entry;
 	int err;
 
+	entry = efa_ah_cache_put_unless_last(&edev->ah_cache, params->pdn, params->gid);
+	if (!entry)
+		return 0;
+
 	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_DESTROY_AH;
 	ah_cmd.ah = params->ah;
 	ah_cmd.pd = params->pdn;
@@ -362,12 +384,17 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
+		mutex_unlock(&entry->lock);
 		ibdev_err_ratelimited(edev->efa_dev,
 				      "Failed to destroy ah-%d pd-%d [%d]\n",
 				      ah_cmd.ah, ah_cmd.pd, err);
 		return err;
 	}
 
+	entry->initialized = false;
+	mutex_unlock(&entry->lock);
+	efa_ah_cache_put(&edev->ah_cache, entry);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index ef15b3c38429..39bd4e06684a 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -106,6 +106,7 @@ struct efa_com_create_ah_result {
 
 struct efa_com_destroy_ah_params {
 	u16 ah;
+	u8 gid[EFA_GID_SIZE];
 	u16 pdn;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 7bd0838ebc99..cc777392a112 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -2055,10 +2055,11 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 
 static int efa_ah_destroy(struct efa_dev *dev, struct efa_ah *ah)
 {
-	struct efa_com_destroy_ah_params params = {
-		.ah = ah->ah,
-		.pdn = to_epd(ah->ibah.pd)->pdn,
-	};
+	struct efa_com_destroy_ah_params params = {};
+
+	params.ah = ah->ah;
+	memcpy(params.gid, ah->id, sizeof(params.gid));
+	params.pdn = to_epd(ah->ibah.pd)->pdn;
 
 	return efa_com_destroy_ah(&dev->edev, &params);
 }
-- 
2.50.1


