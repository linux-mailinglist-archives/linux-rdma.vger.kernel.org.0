Return-Path: <linux-rdma+bounces-22806-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A22aFh7iS2odcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22806-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 19:13:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6ED713B8D
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 19:13:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=ixlQOZSJ;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22806-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22806-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CBB330BB6D1
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884D430D401;
	Mon,  6 Jul 2026 17:00:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A382EEE65
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 17:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357238; cv=none; b=HEylalOL6/lSKqgI4AqnxEtrnB6zciOlf4sSaDZYDMNv+TcdlhrtftYI/gtyOIL1AGYygnJ393hMBX/C6LjNhWEqZ/oLNSNIamwDGYLGQeMDtlCANrwtIxwkvU82glZbiSMedanWuvQkZCR0+kJECBAbxjvdKi0PXvyc1U+tD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357238; c=relaxed/simple;
	bh=lSlTcwSmM9XrImst5spyg/X+qTRqoXYlUXoXcHxtfUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCYkzpcPf4VIfBGzNx6Cu84wLOFAoWQ/uIsE5KEsP60TmO/RgKF6sLq9kqmoo4aJmP8ACR0Lgp3wobUBevUpLtjsxZ5nEg1O6p6ABem7k8V4bhJTXsH4ugwoa3BQeQ+zYowrJRyq8+gplvtOtSMj31slHxcLDIFayOGFaNdoX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ixlQOZSJ; arc=none smtp.client-ip=52.34.181.151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783357236; x=1814893236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibHtKAX29Fl/lGl6LEMYEC2PKXc4//I4el3Ir1+Y+lI=;
  b=ixlQOZSJjWpwz4FRa1DzkKY5QHSa6RHHhUVZO7stMMI/JRgdQbpwmJiG
   vajV5d033ayD1QVJ/rLQhcUHrzg+6pjyBsX89FYx0CLp5KGq4/SJeZuEZ
   J5+e5znP45zXcYJlt2O8bDWbtE0JQQpkSL+Ee9Z+JfMaW5FqMqPbjTdCU
   Bgs+WqRhzEdUycUxZa36XABQ1tOccXsoMzLtYEUOQ9K7cLn70wx/XVq9m
   QxW7uWrE/sUfU1YXeikh+zmQQJs8Swf0jXL12nDdBq+Jhdr9lGAVTFho+
   Cz3Y1GQ6+taiVFi/f91rAdHyo8jpUdsbzfg8+lRHAW+Q3yZdMw7Vit/uL
   A==;
X-CSE-ConnectionGUID: F8X89xeUT2qI+RPnEmZmjw==
X-CSE-MsgGUID: Iv4FJ2VtQ8Kx/8QZsNAJ2g==
X-IronPort-AV: E=Sophos;i="6.25,151,1779148800"; 
   d="scan'208";a="23145718"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 17:00:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:28638]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.93:2525] with esmtp (Farcaster)
 id 0a270519-c867-43e1-b212-be9f1900bd01; Mon, 6 Jul 2026 17:00:33 +0000 (UTC)
X-Farcaster-Flow-ID: 0a270519-c867-43e1-b212-be9f1900bd01
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 6 Jul 2026 17:00:33 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 6 Jul 2026
 17:00:31 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, Firas Jahjah
	<firasj@amazon.com>
Subject: [PATCH for-next v6 2/2] RDMA/efa: Add AH cache handling on create and destroy AH
Date: Mon, 6 Jul 2026 17:00:08 +0000
Message-ID: <20260706170008.1039417-3-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260706170008.1039417-1-ynachum@amazon.com>
References: <20260706170008.1039417-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
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
	TAGGED_FROM(0.00)[bounces-22806-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: BF6ED713B8D

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
index 39d0d2e97589..6219529fa889 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.c
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.c
@@ -39,3 +39,97 @@ void efa_ah_cache_destroy(struct efa_ah_cache *ah_cache)
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
+	kfree(entry);
+}
diff --git a/drivers/infiniband/hw/efa/efa_ah_cache.h b/drivers/infiniband/hw/efa/efa_ah_cache.h
index 1d1fadb591cf..e7cdcbb64070 100644
--- a/drivers/infiniband/hw/efa/efa_ah_cache.h
+++ b/drivers/infiniband/hw/efa/efa_ah_cache.h
@@ -32,5 +32,8 @@ struct efa_ah_cache {
 
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
index 06d3365aeb56..ec124fbda637 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -2054,10 +2054,11 @@ int efa_mmap(struct ib_ucontext *ibucontext,
 
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


