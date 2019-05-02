Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844F411489
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEBHsf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:35 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88CB2089E;
        Thu,  2 May 2019 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783314;
        bh=0CeS/K8Als5NkpVBf3PNMrk2gQk2iovzqsx1ghgoneo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+i2SMQZ7geJ4KsT6ialcGKf83+sTJgsmLuZoS1dJgTZc7lHLVAVhT+bDgg7a6shj
         C/Ix2E5eYoyiE5XzY7ktDawDVeAwktoXNKpYRi9/itdJvCf0xgMT9YObui//I+rs53
         rPMIJABF4tbk+Am1Ffk/nVO0A47aQtsI6YbKURos=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 7/7] RDMA/core: Allow detaching gid attribute netdevice for RoCE
Date:   Thu,  2 May 2019 10:48:07 +0300
Message-Id: <20190502074807.26566-8-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

When there is active traffic through a GID, a QP/AH holds reference
to this GID entry. RoCE GID entry holds reference to its attached
netdevice. Due to this when netdevice is deleted by admin user,
its refcount is not dropped.

Therefore, while deleting RoCE GID, wait for all GID attribute's netdev
users to finish accessing netdev in rcu context.
Once all users done accessing it, release the netdev refcount.

Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cache.c | 73 +++++++++++++++++++++++++++------
 drivers/infiniband/core/sysfs.c | 13 ++++--
 include/rdma/ib_verbs.h         |  2 +-
 3 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index a53c7713d77a..099d922ae7bd 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -78,11 +78,22 @@ enum gid_table_entry_state {
 	GID_TABLE_ENTRY_PENDING_DEL	= 3,
 };
 
+struct roce_gid_ndev_storage {
+	struct rcu_head rcu_head;
+	struct net_device *ndev;
+};
+
 struct ib_gid_table_entry {
 	struct kref			kref;
 	struct work_struct		del_work;
 	struct ib_gid_attr		attr;
 	void				*context;
+	/* Store the ndev pointer to release reference later on in
+	 * call_rcu context because by that time gid_table_entry
+	 * and attr might be already freed. So keep a copy of it.
+	 * ndev_storage is freed by rcu callback.
+	 */
+	struct roce_gid_ndev_storage	*ndev_storage;
 	enum gid_table_entry_state	state;
 };
 
@@ -206,6 +217,20 @@ static void schedule_free_gid(struct kref *kref)
 	queue_work(ib_wq, &entry->del_work);
 }
 
+static void put_gid_ndev(struct rcu_head *head)
+{
+	struct roce_gid_ndev_storage *storage =
+		container_of(head, struct roce_gid_ndev_storage, rcu_head);
+
+	WARN_ON(!storage->ndev);
+	/* At this point its safe to release netdev reference,
+	 * as all callers working on gid_attr->ndev are done
+	 * using this netdev.
+	 */
+	dev_put(storage->ndev);
+	kfree(storage);
+}
+
 static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 {
 	struct ib_device *device = entry->attr.device;
@@ -228,8 +253,8 @@ static void free_gid_entry_locked(struct ib_gid_table_entry *entry)
 	/* Now this index is ready to be allocated */
 	write_unlock_irq(&table->rwlock);
 
-	if (entry->attr.ndev)
-		dev_put(entry->attr.ndev);
+	if (entry->ndev_storage)
+		call_rcu(&entry->ndev_storage->rcu_head, put_gid_ndev);
 	kfree(entry);
 }
 
@@ -266,14 +291,25 @@ static struct ib_gid_table_entry *
 alloc_gid_entry(const struct ib_gid_attr *attr)
 {
 	struct ib_gid_table_entry *entry;
+	struct net_device *ndev;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return NULL;
+
+	ndev = rcu_dereference_protected(attr->ndev, 1);
+	if (ndev) {
+		entry->ndev_storage = kzalloc(sizeof(*entry->ndev_storage),
+					      GFP_KERNEL);
+		if (!entry->ndev_storage) {
+			kfree(entry);
+			return NULL;
+		}
+		dev_hold(ndev);
+		entry->ndev_storage->ndev = ndev;
+	}
 	kref_init(&entry->kref);
 	memcpy(&entry->attr, attr, sizeof(*attr));
-	if (entry->attr.ndev)
-		dev_hold(entry->attr.ndev);
 	INIT_WORK(&entry->del_work, free_gid_work);
 	entry->state = GID_TABLE_ENTRY_INVALID;
 	return entry;
@@ -343,6 +379,7 @@ static int add_roce_gid(struct ib_gid_table_entry *entry)
 static void del_gid(struct ib_device *ib_dev, u8 port,
 		    struct ib_gid_table *table, int ix)
 {
+	struct roce_gid_ndev_storage *ndev_storage;
 	struct ib_gid_table_entry *entry;
 
 	lockdep_assert_held(&table->lock);
@@ -360,6 +397,13 @@ static void del_gid(struct ib_device *ib_dev, u8 port,
 		table->data_vec[ix] = NULL;
 	write_unlock_irq(&table->rwlock);
 
+	ndev_storage = entry->ndev_storage;
+	if (ndev_storage) {
+		entry->ndev_storage = NULL;
+		rcu_assign_pointer(entry->attr.ndev, NULL);
+		call_rcu(&ndev_storage->rcu_head, put_gid_ndev);
+	}
+
 	if (rdma_cap_roce_gid_table(ib_dev, port))
 		ib_dev->ops.del_gid(&entry->attr, &entry->context);
 
@@ -1244,8 +1288,12 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 
 	read_lock_irqsave(&table->rwlock, flags);
 	valid = is_gid_entry_valid(table->data_vec[attr->index]);
-	if (valid && attr->ndev && (READ_ONCE(attr->ndev->flags) & IFF_UP))
-		ndev = attr->ndev;
+	if (valid) {
+		ndev = rcu_dereference(attr->ndev);
+		if (!ndev ||
+		    (ndev && ((READ_ONCE(ndev->flags) & IFF_UP) == 0)))
+			ndev = ERR_PTR(-ENODEV);
+	}
 	read_unlock_irqrestore(&table->rwlock, flags);
 	return ndev;
 }
@@ -1281,10 +1329,12 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 {
 	struct net_device *ndev;
 
-	ndev = attr->ndev;
-	if (!ndev)
-		return -EINVAL;
-
+	rcu_read_lock();
+	ndev = rcu_dereference(attr->ndev);
+	if (!ndev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
 	if (smac)
 		ether_addr_copy(smac, ndev->dev_addr);
 	if (vlan_id) {
@@ -1296,12 +1346,11 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 			 * device is vlan device, consider vlan id of the
 			 * the lower vlan device for this gid entry.
 			 */
-			rcu_read_lock();
 			netdev_walk_all_lower_dev_rcu(attr->ndev,
 					get_lower_dev_vlan, vlan_id);
-			rcu_read_unlock();
 		}
 	}
+	rcu_read_unlock();
 	return 0;
 }
 EXPORT_SYMBOL(rdma_read_gid_l2_fields);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 8d1cf1bbb5f5..1d264db61988 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -350,10 +350,15 @@ static struct attribute *port_default_attrs[] = {
 
 static size_t print_ndev(const struct ib_gid_attr *gid_attr, char *buf)
 {
-	if (!gid_attr->ndev)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n", gid_attr->ndev->name);
+	struct net_device *ndev;
+	size_t ret = -EINVAL;
+
+	rcu_read_lock();
+	ndev = rcu_dereference(gid_attr->ndev);
+	if (ndev)
+		ret = sprintf(buf, "%s\n", ndev->name);
+	rcu_read_unlock();
+	return ret;
 }
 
 static size_t print_gid_type(const struct ib_gid_attr *gid_attr, char *buf)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d12770f63e4e..8014dec3bd07 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -95,7 +95,7 @@ enum ib_gid_type {
 
 #define ROCE_V2_UDP_DPORT      4791
 struct ib_gid_attr {
-	struct net_device	*ndev;
+	struct net_device __rcu	*ndev;
 	struct ib_device	*device;
 	union ib_gid		gid;
 	enum ib_gid_type	gid_type;
-- 
2.20.1

