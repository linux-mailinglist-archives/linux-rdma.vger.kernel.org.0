Return-Path: <linux-rdma+bounces-21941-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uVzrFpdsJmopWQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21941-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 09:17:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF4653728
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 09:17:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=oiKRIav6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21941-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21941-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB81F3001FAC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 07:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A24351C3B;
	Mon,  8 Jun 2026 07:17:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1726AF4
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 07:17:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903056; cv=none; b=FJOhtFQt+pyio8ByfCUhwKjD3hphK1O2mwDEGV4wOvEILS0rmKlh9PxfJ5zVlViCxtamYYsj5CVHWFg5P7x6YP1zWKl09TPcPwEIcYT8Mi8n/LVGOjz3Gm5KiKnv8oOa92bukebHoJSc9CQEr3yod/oEVU4gqZAl0aUnaWsuG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903056; c=relaxed/simple;
	bh=iNNuiajmKxrECMITJH6gBCvTadDnrSsaYS8IbdFeQNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjfzt7lSdjDDvdLjB2YOmvlBlpDX15IRkWnUqRfthvk0pkgRoTt/e/q8gw3tMZsvbjFgQGVJwcoO5qEUOv2xiI/vqexk/tRto2ra+Zc8VgaL2D43EfBy1TkhTdm6Qujpgk9//n9UPixtD7nLbvfZ+lszrAfWmV7CcspflfU47jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oiKRIav6; arc=none smtp.client-ip=52.12.53.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780903054; x=1812439054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2UUNY3Ci5Vho+zizqxl+V+52RyM0rai4+pRjnePIHc=;
  b=oiKRIav6qHTqZastqkzQtrg/rS0ixuOocYLqb8YhREaT8Gt39PtzAX8F
   q0wfhJkxZOWbXQC1nvNtElGIdiFbW7esx8RsA1IFfaUNBuc07Xbw0OQom
   DDFIZzBchekz1XKZ+B3i65T616CBCu5MFZ2fGdVAasm8IvkHwZSaapfiv
   TAyQXwsCZZK/CZcjUnmZEfB2Z3U3CfhPNVnweCNPF8EHCv1NqvN5vzSgN
   uMcQMIKWhZGYyplWyaL8Rmy3vsSWRbNU+b/W6Ooqqxphk2oQqA/CTmzTf
   YPoIM5Sy34pJVW25hk8hv4SKy3kcrgW5s24//gIzEExtBjR58B3mMyfum
   A==;
X-CSE-ConnectionGUID: haG2eoOmQLahW5tjKixdDw==
X-CSE-MsgGUID: nbk9nwGVTLqubbn6tqcnVQ==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="21178235"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:17:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:13799]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id a66870e9-274b-44f2-bc47-b3a006e6c72f; Mon, 8 Jun 2026 07:17:31 +0000 (UTC)
X-Farcaster-Flow-ID: a66870e9-274b-44f2-bc47-b3a006e6c72f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 07:17:31 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 8 Jun 2026
 07:17:29 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next v4 2/2] RDMA/efa: Add AH cache handling on create and destroy AH
Date: Mon, 8 Jun 2026 07:16:20 +0000
Message-ID: <20260608071620.1909543-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260608071620.1909543-1-ynachum@amazon.com>
References: <20260608071620.1909543-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-21941-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,m:firasj@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25EF4653728

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
 drivers/infiniband/hw/efa/efa_ah_cache.c | 122 +++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |   5 +
 drivers/infiniband/hw/efa/efa_com_cmd.c  |  73 ++++++++++----
 drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
 5 files changed, 187 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.c b/drivers/infiniband/hw/efa/efa_ah_cache.c
index ab763b06b9bb..b738261dca35 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.c
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -39,3 +39,125 @@ void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
 	rhashtable_free_and_destroy(&ah_cache->hashtable, efa_ah_cache_entry_free, NULL);
 	mutex_destroy(&ah_cache->lock);
 }
+
+static struct efa_ah_cache_entry *efa_ah_cache_lookup(struct efa_ah_cache *ah_cache, u16 pd,
+						      u8 *gid)
+	__must_hold(&ah_cache->lock)
+{
+	struct efa_ah_cache_key key = {};
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
+	entry = kzalloc_obj(*entry);
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
+		kfree(entry);
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
+	kfree_rcu(entry, rcu_head);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
index 133181b4466d..573fd29bb416 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.h
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -33,5 +33,10 @@ struct efa_ah_cache {
 
 int efa_ah_cache_init(struct efa_ah_cache *ah_cache);
 void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache);
+struct efa_ah_cache_entry *efa_ah_cache_get_or_create(struct efa_ah_cache *ah_cache, u16 pd,
+						      u8 *gid);
+struct efa_ah_cache_entry *efa_ah_cache_put_unless_last(struct efa_ah_cache *ah_cache, u16 pd,
+							u8 *gid);
+void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry);
 
 #endif /* _EFA_AH_CACHE_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 63c7f07806a8..9eafcba5e028 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -313,19 +313,25 @@ int efa_com_dereg_mr(struct efa_com_dev *edev,
 	return 0;
 }
 
-int efa_com_create_ah(struct efa_com_dev *edev,
-		      struct efa_com_create_ah_params *params,
-		      struct efa_com_create_ah_result *result)
+int efa_com_destroy_ah(struct efa_com_dev *edev,
+		       struct efa_com_destroy_ah_params *params)
 {
-	struct efa_admin_create_ah_resp cmd_completion;
+	struct efa_admin_destroy_ah_resp cmd_completion;
+	struct efa_admin_destroy_ah_cmd ah_cmd = {};
 	struct efa_com_admin_queue *aq = &edev->aq;
-	struct efa_admin_create_ah_cmd ah_cmd = {};
+	struct efa_ah_cache_entry *entry;
 	int err;
 
-	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_CREATE_AH;
+	entry = efa_ah_cache_put_unless_last(&edev->ah_cache, params->pdn, params->gid);
+	if (!entry)
+		return 0;
 
-	memcpy(ah_cmd.dest_addr, params->dest_addr, sizeof(ah_cmd.dest_addr));
-	ah_cmd.pd = params->pdn;
+	if (!entry->initialized)
+		goto out;
+
+	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_DESTROY_AH;
+	ah_cmd.ah = entry->ah;
+	ah_cmd.pd = entry->key.pd;
 
 	err = efa_com_cmd_exec(aq,
 			       (struct efa_admin_aq_entry *)&ah_cmd,
@@ -333,27 +339,47 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
+		mutex_unlock(&entry->lock);
 		ibdev_err_ratelimited(edev->efa_dev,
-				      "Failed to create ah for %pI6 [%d]\n",
-				      ah_cmd.dest_addr, err);
+				      "Failed to destroy ah-%d pd-%d [%d]\n",
+				      ah_cmd.ah, ah_cmd.pd, err);
 		return err;
 	}
 
-	result->ah = cmd_completion.ah;
+	entry->initialized = false;
+
+out:
+	mutex_unlock(&entry->lock);
+	efa_ah_cache_put(&edev->ah_cache, entry);
 
 	return 0;
 }
 
-int efa_com_destroy_ah(struct efa_com_dev *edev,
-		       struct efa_com_destroy_ah_params *params)
+int efa_com_create_ah(struct efa_com_dev *edev,
+		      struct efa_com_create_ah_params *params,
+		      struct efa_com_create_ah_result *result)
 {
-	struct efa_admin_destroy_ah_resp cmd_completion;
-	struct efa_admin_destroy_ah_cmd ah_cmd = {};
+	struct efa_com_destroy_ah_params destroy_params = {};
+	struct efa_admin_create_ah_resp cmd_completion;
 	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_admin_create_ah_cmd ah_cmd = {};
+	struct efa_ah_cache_entry *entry;
 	int err;
 
-	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_DESTROY_AH;
-	ah_cmd.ah = params->ah;
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
+	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_CREATE_AH;
+
+	memcpy(ah_cmd.dest_addr, params->dest_addr, sizeof(ah_cmd.dest_addr));
 	ah_cmd.pd = params->pdn;
 
 	err = efa_com_cmd_exec(aq,
@@ -362,12 +388,21 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
+		mutex_unlock(&entry->lock);
+		memcpy(destroy_params.gid, params->dest_addr, sizeof(destroy_params.gid));
+		destroy_params.pdn = params->pdn;
+		efa_com_destroy_ah(edev, &destroy_params);
 		ibdev_err_ratelimited(edev->efa_dev,
-				      "Failed to destroy ah-%d pd-%d [%d]\n",
-				      ah_cmd.ah, ah_cmd.pd, err);
+				      "Failed to create ah for %pI6 [%d]\n",
+				      ah_cmd.dest_addr, err);
 		return err;
 	}
 
+	entry->ah = cmd_completion.ah;
+	entry->initialized = true;
+	result->ah = cmd_completion.ah;
+	mutex_unlock(&entry->lock);
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
index 434d60235945..6742a4037888 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -2032,10 +2032,11 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 
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


