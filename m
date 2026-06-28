Return-Path: <linux-rdma+bounces-22542-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +llJDAEjQWpAlQkAu9opvQ
	(envelope-from <linux-rdma+bounces-22542-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:34:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBC6D3E80
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=ha9Qlb9U;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22542-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22542-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 326F9300D61D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE53A7F79;
	Sun, 28 Jun 2026 13:34:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBD361DBC
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2026 13:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653691; cv=none; b=aMwRrlGlWhZYdcF+psf1eSm3f2siguvTlMlzAOBj1ur+qCa/pOmLIsTCHa9utRTe5L3r0zk3v+Wz90I5Rol00P1x8dT9ixY7Pi4DIfq7oifMsSiliGcJNOSKDJfzk/+HJjeqzi4RFVK1dkCz/4/VkTan8mM+1bBJHvWlLOMxEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653691; c=relaxed/simple;
	bh=tr9Iw5wSKCvfNRZreOMGo7CNBW6DVFTEnuR0slPGJRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xcn1FPvxRTrYLy7ZsuChQozvikZnh5nwGgeHjI9cPjO7FWdYxL8ncIJ7+H6Z92XO+AEI52zkG4CaLIOjeNelmE6IcsLOcgAlsCVH6nVe6jY6KkSB/TTIshq+nnDhcLB9PEcmRfeeo7qNnimnl9rkEwTb2fNfm3x3S5uyUqGwSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ha9Qlb9U; arc=none smtp.client-ip=35.162.73.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782653690; x=1814189690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3pkoVTNxgncxEPWjwLdhsv3v/HB1wIUHGyAWIEEYnE=;
  b=ha9Qlb9UKuVZJIBymNPuDnlV9zp9VX20natG9rIcVKkKc0oQK3F7MrCV
   RwgGuMOj/I3QbKe8E/jGdatey5iK2Z7e9M+A+weB+CqOi7qRZnUTkfoPd
   Ost+HBMFxwrCqOLMiTWKljkak7P5SRAuP9wcejMFCrVBo3JWu4b/eB1cA
   RomLm+ERJBw5l3mYNu5fz2FsVl3XptBjxWZavoxQ3wOMvnhEYvmho8OER
   r6YPutYDL4Y0Fd+E8Y52/htLHBadvNoxDnbU0mjJ5x9KR1Wtf8yhr199A
   6eaIseKnaVDOBJlnhQOSLMci/1cozCi+k7f6iTW7n7sofCa8FtBKnSZHs
   A==;
X-CSE-ConnectionGUID: S+5ceSNQRqOFjCZb9JFVpA==
X-CSE-MsgGUID: ktsI1aZiTxOQHzNnK7Kxuw==
X-IronPort-AV: E=Sophos;i="6.24,230,1774310400"; 
   d="scan'208";a="22440926"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 13:34:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:6413]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.142:2525] with esmtp (Farcaster)
 id cab7a91f-d657-4fe4-bb6d-9188b0fb6153; Sun, 28 Jun 2026 13:34:47 +0000 (UTC)
X-Farcaster-Flow-ID: cab7a91f-d657-4fe4-bb6d-9188b0fb6153
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 28 Jun 2026 13:34:47 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 28 Jun 2026
 13:34:45 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next v5 2/2] RDMA/efa: Add AH cache handling on create and destroy AH
Date: Sun, 28 Jun 2026 13:34:22 +0000
Message-ID: <20260628133422.523230-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260628133422.523230-1-ynachum@amazon.com>
References: <20260628133422.523230-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,m:firasj@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22542-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96EBC6D3E80

On create AH, first check if the AH cache entry already exists and if
so, returns the already stored AH number. If the entry doesn't exist,
the driver creates it and calls the device to create the AH. A per-entry
mutex serializes concurrent device commands on the same AH cache entry,
ensuring only one thread issues the device create while others wait and
reuse the result. If the device create fails, the entry's user count
remains zero so subsequent threads will retry the device create.

On destroy AH, the user count is decremented under the entry mutex. If
it reaches zero, the driver issues the device destroy command. After
the device destroy completes, it removes the entry from the hashtable
and frees it if no other references exist.  If new users arrived during
the destroy, the entry remains in the hashtable for reuse.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_ah_cache.c | 94 ++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |  3 +
 drivers/infiniband/hw/efa/efa_com_cmd.c  | 41 ++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.h  |  1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |  9 ++-
 5 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.c b/drivers/infiniband/hw/efa/efa_ah_cache.c
index 73e810678767..ede967c063b2 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.c
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -40,3 +40,97 @@ void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
 	rhashtable_free_and_destroy(&ah_cache->hashtable, efa_ah_cache_entry_free, NULL);
 	mutex_destroy(&ah_cache->lock);
 }
+
+static struct efa_ah_cache_entry *efa_ah_cache_lookup_locked(struct efa_ah_cache *ah_cache, u16 pd,
+							     u8 *gid)
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
+struct efa_ah_cache_entry *efa_ah_cache_lookup(struct efa_ah_cache *ah_cache, u16 pd, u8 *gid)
+{
+	struct efa_ah_cache_entry *entry;
+
+	mutex_lock(&ah_cache->lock);
+	entry = efa_ah_cache_lookup_locked(ah_cache, pd, gid);
+	mutex_unlock(&ah_cache->lock);
+
+	return entry;
+}
+
+/**
+ * efa_ah_cache_get - Get or create an AH cache entry
+ * @ah_cache: AH cache
+ * @pd: Protection domain number
+ * @gid: GID address
+ *
+ * Look up an AH cache entry by PD and GID. If found, take a reference and
+ * return it. If not found, allocate a new entry and insert it. The caller must lock
+ * the entry mutex and check usecnt to determine whether a device create
+ * command is needed.
+ *
+ * Return: Pointer to the entry on success, ERR_PTR on failure.
+ */
+struct efa_ah_cache_entry *efa_ah_cache_get(struct efa_ah_cache *ah_cache, u16 pd, u8 *gid)
+{
+	struct efa_ah_cache_entry *entry;
+	int err;
+
+	mutex_lock(&ah_cache->lock);
+
+	entry = efa_ah_cache_lookup_locked(ah_cache, pd, gid);
+	if (entry) {
+		refcount_inc(&entry->refcount);
+		mutex_unlock(&ah_cache->lock);
+		return entry;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
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
+ * efa_ah_cache_put - Put a refcount of an AH cache entry
+ * @ah_cache: AH cache
+ * @entry: AH cache entry
+ *
+ * Drop the refcount. If it reaches zero, remove the entry from the hashtable
+ * and free it.
+ */
+void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
+{
+	if (!refcount_dec_and_mutex_lock(&entry->refcount, &ah_cache->lock))
+		return;
+
+	/* AH cache lock is held here */
+	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
+	mutex_unlock(&ah_cache->lock);
+
+	mutex_destroy(&entry->lock);
+	kfree_rcu(entry, rcu_head);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
index 42ba17a482c3..4315bba1f880 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.h
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -33,5 +33,8 @@ struct efa_ah_cache {
 
 int efa_ah_cache_init(struct efa_ah_cache *ah_cache);
 void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache);
+struct efa_ah_cache_entry *efa_ah_cache_get(struct efa_ah_cache *ah_cache, u16 pd, u8 *gid);
+struct efa_ah_cache_entry *efa_ah_cache_lookup(struct efa_ah_cache *ah_cache, u16 pd, u8 *gid);
+void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry);
 
 #endif /* _EFA_AH_CACHE_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 5db4f5805b59..0b96862c2787 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -322,8 +322,21 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 	struct efa_admin_create_ah_resp cmd_completion;
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_admin_create_ah_cmd ah_cmd = {};
+	struct efa_ah_cache_entry *entry;
 	int err;
 
+	entry = efa_ah_cache_get(&edev->ah_cache, params->pdn, params->dest_addr);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	mutex_lock(&entry->lock);
+	if (entry->usecnt) {
+		result->ah = entry->ah;
+		entry->usecnt++;
+		mutex_unlock(&entry->lock);
+		return 0;
+	}
+
 	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_CREATE_AH;
 
 	memcpy(ah_cmd.dest_addr, params->dest_addr, sizeof(ah_cmd.dest_addr));
@@ -335,13 +348,18 @@ int efa_com_create_ah(struct efa_com_dev *edev,
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
 	result->ah = cmd_completion.ah;
+	entry->usecnt++;
+	mutex_unlock(&entry->lock);
 
 	return 0;
 }
@@ -352,11 +370,20 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 	struct efa_admin_destroy_ah_resp cmd_completion;
 	struct efa_admin_destroy_ah_cmd ah_cmd = {};
 	struct efa_com_admin_queue *aq = &edev->aq;
-	int err;
+	struct efa_ah_cache_entry *entry;
+	int err = 0;
+
+	entry = efa_ah_cache_lookup(&edev->ah_cache, params->pdn, params->gid);
+	if (!entry)
+		return -EINVAL;
+
+	mutex_lock(&entry->lock);
+	if (entry->usecnt > 1)
+		goto out_put;
 
 	ah_cmd.aq_common_desc.opcode = EFA_ADMIN_DESTROY_AH;
-	ah_cmd.ah = params->ah;
-	ah_cmd.pd = params->pdn;
+	ah_cmd.ah = entry->ah;
+	ah_cmd.pd = entry->key.pd;
 
 	err = efa_com_cmd_exec(aq,
 			       (struct efa_admin_aq_entry *)&ah_cmd,
@@ -364,13 +391,19 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
+		mutex_unlock(&entry->lock);
 		ibdev_err_ratelimited(edev->efa_dev,
 				      "Failed to destroy ah-%d pd-%d [%d]\n",
 				      ah_cmd.ah, ah_cmd.pd, err);
 		return err;
 	}
 
-	return 0;
+out_put:
+	entry->usecnt--;
+	mutex_unlock(&entry->lock);
+	efa_ah_cache_put(&edev->ah_cache, entry);
+
+	return err;
 }
 
 bool
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
index 5bb00cb85775..eb10aeedd31b 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -2045,10 +2045,11 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 
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


