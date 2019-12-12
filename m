Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5F11CA82
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfLLKWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:22:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35233 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfLLKWi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 05:22:38 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so847918pjd.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2019 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gjOBPBoVA8jXFjx0NubAsN/dE6rAvNC8QQcE+hqylM=;
        b=bjiufQJzhVsLTxpz400v2KMlZg2O/XERpjyuR8+7ph+SZiScgmsnl612WAb/PXiblj
         VUORFveAld9v3HTuy9pVlZ1NNspd0xPP8WRn7yEl/tbscBVP6M/qHsmVkCMuutu/lD2k
         fhGhtrkL8I7/zpqqsiJ+uBEaFKqPLD/LX7MY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gjOBPBoVA8jXFjx0NubAsN/dE6rAvNC8QQcE+hqylM=;
        b=rWPoeMYRnE4Fmdimehj37e9JNu68WUWcGdo6jIimILTL4U4MIjxiVLrIurSoLwbsPz
         97mJDZ2fJC4XtXFUAdSwkJhUaBVrCbjIOteVRJxm3zIQNbW3t1Q6tMZFj7+pxy1GuU9S
         bFyodi/dI0zqrGdpiA1T/2Z5uezLaKRyoak8LYPrTL/z8LJPkexFYolUnnALYOEkfuXO
         MtcoPOsXqQid0oMOnTNQaUOS72bw/dHV41UkCOzaWeFzgCQDRupKD0m++s08rsQWeYMP
         Xs8RHyneh4g1eoU2a9ZlGOGVDC2v7QGtqkh9+gV1roiL1RwMUfzMFUMyPLcgh1Rtjxs9
         yHLw==
X-Gm-Message-State: APjAAAVMwRbgeMXpgvaNcbcyCMys6+WdweeAKZY0RdcAyqEj7PtAoXOX
        rBMDvm2vl7pyAelqkIGuuBNxKg==
X-Google-Smtp-Source: APXvYqzyAhI38Fsh0oQ8vTXNTNI+3wzDGz8BU6cWxI5hLRmSGAPCe9N/RrWM3NWhNABomPKDsl+EqA==
X-Received: by 2002:a17:90a:cb0d:: with SMTP id z13mr8849925pjt.111.1576146157407;
        Thu, 12 Dec 2019 02:22:37 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m12sm6119290pgr.87.2019.12.12.02.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:22:36 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH for-next 1/2] IB/core: Add option to retrieve driver gid context from ib_gid_attr
Date:   Thu, 12 Dec 2019 02:22:22 -0800
Message-Id: <1576146143-28264-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
References: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Provide an option to retrieve the driver gid context from ib_gid_attr
structure. Introduce ib_gid_attr_info structure which include both
gid_attr and the GID's HW context. Replace the attr and context
members of ib_gid_table_entry with the new ib_gid_attr_info
structure. Vendor drivers can refer to its own HW gid context
using the container_of macro.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/core/cache.c | 79 +++++++++++++++++++++++------------------
 include/rdma/ib_verbs.h         |  5 +++
 2 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index d535995..54ed25d 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -86,8 +86,7 @@ struct roce_gid_ndev_storage {
 struct ib_gid_table_entry {
 	struct kref			kref;
 	struct work_struct		del_work;
-	struct ib_gid_attr		attr;
-	void				*context;
+	struct ib_gid_attr_info		attr_info;
 	/* Store the ndev pointer to release reference later on in
 	 * call_rcu context because by that time gid_table_entry
 	 * and attr might be already freed. So keep a copy of it.
@@ -233,12 +232,13 @@ static void put_gid_ndev(struct rcu_head *head)
 
 static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 {
-	struct ib_device *device = entry->attr.device;
-	u8 port_num = entry->attr.port_num;
+	struct ib_device *device = entry->attr_info.attr.device;
+	u8 port_num = entry->attr_info.attr.port_num;
 	struct ib_gid_table *table = rdma_gid_table(device, port_num);
 
 	dev_dbg(&device->dev, "%s port=%d index=%d gid %pI6\n", __func__,
-		port_num, entry->attr.index, entry->attr.gid.raw);
+		port_num, entry->attr_info.attr.index,
+		entry->attr_info.attr.gid.raw);
 
 	write_lock_irq(&table->rwlock);
 
@@ -248,8 +248,8 @@ static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 	 * If new entry in table is added by the time we free here,
 	 * don't overwrite the table entry.
 	 */
-	if (entry == table->data_vec[entry->attr.index])
-		table->data_vec[entry->attr.index] = NULL;
+	if (entry == table->data_vec[entry->attr_info.attr.index])
+		table->data_vec[entry->attr_info.attr.index] = NULL;
 	/* Now this index is ready to be allocated */
 	write_unlock_irq(&table->rwlock);
 
@@ -278,8 +278,8 @@ static void free_gid_work(struct work_struct *work)
 {
 	struct ib_gid_table_entry *entry =
 		container_of(work, struct ib_gid_table_entry, del_work);
-	struct ib_device *device = entry->attr.device;
-	u8 port_num = entry->attr.port_num;
+	struct ib_device *device = entry->attr_info.attr.device;
+	u8 port_num = entry->attr_info.attr.port_num;
 	struct ib_gid_table *table = rdma_gid_table(device, port_num);
 
 	mutex_lock(&table->lock);
@@ -309,7 +309,7 @@ alloc_gid_entry(const struct ib_gid_attr *attr)
 		entry->ndev_storage->ndev = ndev;
 	}
 	kref_init(&entry->kref);
-	memcpy(&entry->attr, attr, sizeof(*attr));
+	memcpy(&entry->attr_info.attr, attr, sizeof(*attr));
 	INIT_WORK(&entry->del_work, free_gid_work);
 	entry->state = GID_TABLE_ENTRY_INVALID;
 	return entry;
@@ -320,13 +320,15 @@ static void store_gid_entry(struct ib_gid_table *table,
 {
 	entry->state = GID_TABLE_ENTRY_VALID;
 
-	dev_dbg(&entry->attr.device->dev, "%s port=%d index=%d gid %pI6\n",
-		__func__, entry->attr.port_num, entry->attr.index,
-		entry->attr.gid.raw);
+	dev_dbg(&entry->attr_info.attr.device->dev,
+		"%s port=%d index=%d gid %pI6\n",
+		__func__, entry->attr_info.attr.port_num,
+		entry->attr_info.attr.index,
+		entry->attr_info.attr.gid.raw);
 
 	lockdep_assert_held(&table->lock);
 	write_lock_irq(&table->rwlock);
-	table->data_vec[entry->attr.index] = entry;
+	table->data_vec[entry->attr_info.attr.index] = entry;
 	write_unlock_irq(&table->rwlock);
 }
 
@@ -347,7 +349,7 @@ static void put_gid_entry_locked(struct ib_gid_table_entry *entry)
 
 static int add_roce_gid(struct ib_gid_table_entry *entry)
 {
-	const struct ib_gid_attr *attr = &entry->attr;
+	const struct ib_gid_attr *attr = &entry->attr_info.attr;
 	int ret;
 
 	if (!attr->ndev) {
@@ -356,7 +358,8 @@ static int add_roce_gid(struct ib_gid_table_entry *entry)
 		return -EINVAL;
 	}
 	if (rdma_cap_roce_gid_table(attr->device, attr->port_num)) {
-		ret = attr->device->ops.add_gid(attr, &entry->context);
+		ret = attr->device->ops.add_gid(attr,
+						&entry->attr_info.context);
 		if (ret) {
 			dev_err(&attr->device->dev,
 				"%s GID add failed port=%d index=%d\n",
@@ -385,7 +388,7 @@ static void del_gid(struct ib_device *ib_dev, u8 port,
 	lockdep_assert_held(&table->lock);
 
 	dev_dbg(&ib_dev->dev, "%s port=%d index=%d gid %pI6\n", __func__, port,
-		ix, table->data_vec[ix]->attr.gid.raw);
+		ix, table->data_vec[ix]->attr_info.attr.gid.raw);
 
 	write_lock_irq(&table->rwlock);
 	entry = table->data_vec[ix];
@@ -400,12 +403,13 @@ static void del_gid(struct ib_device *ib_dev, u8 port,
 	ndev_storage = entry->ndev_storage;
 	if (ndev_storage) {
 		entry->ndev_storage = NULL;
-		rcu_assign_pointer(entry->attr.ndev, NULL);
+		rcu_assign_pointer(entry->attr_info.attr.ndev, NULL);
 		call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
 	}
 
 	if (rdma_cap_roce_gid_table(ib_dev, port))
-		ib_dev->ops.del_gid(&entry->attr, &entry->context);
+		ib_dev->ops.del_gid(&entry->attr_info.attr,
+				    &entry->attr_info.context);
 
 	put_gid_entry_locked(entry);
 }
@@ -508,13 +512,13 @@ static int find_gid(struct ib_gid_table *table, const union ib_gid *gid,
 		if (found >= 0)
 			continue;
 
-		attr = &data->attr;
+		attr = &data->attr_info.attr;
 		if (mask & GID_ATTR_FIND_MASK_GID_TYPE &&
 		    attr->gid_type != val->gid_type)
 			continue;
 
 		if (mask & GID_ATTR_FIND_MASK_GID &&
-		    memcmp(gid, &data->attr.gid, sizeof(*gid)))
+		    memcmp(gid, &data->attr_info.attr.gid, sizeof(*gid)))
 			continue;
 
 		if (mask & GID_ATTR_FIND_MASK_NETDEV &&
@@ -648,7 +652,7 @@ int ib_cache_gid_del_all_netdev_gids(struct ib_device *ib_dev, u8 port,
 
 	for (ix = 0; ix < table->sz; ix++) {
 		if (is_gid_entry_valid(table->data_vec[ix]) &&
-		    table->data_vec[ix]->attr.ndev == ndev) {
+		    table->data_vec[ix]->attr_info.attr.ndev == ndev) {
 			del_gid(ib_dev, port, table, ix);
 			deleted = true;
 		}
@@ -703,7 +707,7 @@ rdma_find_gid_by_port(struct ib_device *ib_dev,
 	local_index = find_gid(table, gid, &val, false, mask, NULL);
 	if (local_index >= 0) {
 		get_gid_entry(table->data_vec[local_index]);
-		attr = &table->data_vec[local_index]->attr;
+		attr = &table->data_vec[local_index]->attr_info.attr;
 		read_unlock_irqrestore(&table->rwlock, flags);
 		return attr;
 	}
@@ -753,12 +757,12 @@ const struct ib_gid_attr *rdma_find_gid_by_filter(
 		if (!is_gid_entry_valid(entry))
 			continue;
 
-		if (memcmp(gid, &entry->attr.gid, sizeof(*gid)))
+		if (memcmp(gid, &entry->attr_info.attr.gid, sizeof(*gid)))
 			continue;
 
-		if (filter(gid, &entry->attr, context)) {
+		if (filter(gid, &entry->attr_info.attr, context)) {
 			get_gid_entry(entry);
-			res = &entry->attr;
+			res = &entry->attr_info.attr;
 			break;
 		}
 	}
@@ -964,7 +968,7 @@ int rdma_query_gid(struct ib_device *device, u8 port_num,
 	    !is_gid_entry_valid(table->data_vec[index]))
 		goto done;
 
-	memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
+	memcpy(gid, &table->data_vec[index]->attr_info.attr.gid, sizeof(*gid));
 	res = 0;
 
 done:
@@ -1011,7 +1015,7 @@ const struct ib_gid_attr *rdma_find_gid(struct ib_device *device,
 			const struct ib_gid_attr *attr;
 
 			get_gid_entry(table->data_vec[index]);
-			attr = &table->data_vec[index]->attr;
+			attr = &table->data_vec[index]->attr_info.attr;
 			read_unlock_irqrestore(&table->rwlock, flags);
 			return attr;
 		}
@@ -1210,7 +1214,7 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
 		goto done;
 
 	get_gid_entry(table->data_vec[index]);
-	attr = &table->data_vec[index]->attr;
+	attr = &table->data_vec[index]->attr_info.attr;
 done:
 	read_unlock_irqrestore(&table->rwlock, flags);
 	return attr;
@@ -1230,8 +1234,10 @@ EXPORT_SYMBOL(rdma_get_gid_attr);
  */
 void rdma_put_gid_attr(const struct ib_gid_attr *attr)
 {
+	struct ib_gid_attr_info *info =
+		container_of(attr, struct ib_gid_attr_info, attr);
 	struct ib_gid_table_entry *entry =
-		container_of(attr, struct ib_gid_table_entry, attr);
+		container_of(info, struct ib_gid_table_entry, attr_info);
 
 	put_gid_entry(entry);
 }
@@ -1249,8 +1255,10 @@ EXPORT_SYMBOL(rdma_put_gid_attr);
  */
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr)
 {
+	struct ib_gid_attr_info *info =
+		container_of(attr, struct ib_gid_attr_info, attr);
 	struct ib_gid_table_entry *entry =
-		container_of(attr, struct ib_gid_table_entry, attr);
+		container_of(info, struct ib_gid_table_entry, attr_info);
 
 	get_gid_entry(entry);
 }
@@ -1270,11 +1278,14 @@ EXPORT_SYMBOL(rdma_hold_gid_attr);
  */
 struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 {
+	struct ib_gid_attr_info *info =
+		container_of(attr, struct ib_gid_attr_info, attr);
 	struct ib_gid_table_entry *entry =
-			container_of(attr, struct ib_gid_table_entry, attr);
-	struct ib_device *device = entry->attr.device;
+			container_of(info, struct ib_gid_table_entry,
+				     attr_info);
+	struct ib_device *device = entry->attr_info.attr.device;
 	struct net_device *ndev = ERR_PTR(-ENODEV);
-	u8 port_num = entry->attr.port_num;
+	u8 port_num = entry->attr_info.attr.port_num;
 	struct ib_gid_table *table;
 	unsigned long flags;
 	bool valid;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9d8d7fd..272b8f8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -174,6 +174,11 @@ struct ib_gid_attr {
 	u8			port_num;
 };
 
+struct ib_gid_attr_info {
+	struct ib_gid_attr		attr;
+	void				*context;
+};
+
 enum {
 	/* set the local administered indication */
 	IB_SA_WELL_KNOWN_GUID	= BIT_ULL(57) | 2,
-- 
2.5.5

