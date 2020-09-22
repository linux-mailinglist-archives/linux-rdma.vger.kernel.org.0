Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9B4273D43
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIVI1C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgIVI1C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:27:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C23323A1E;
        Tue, 22 Sep 2020 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600763221;
        bh=cliw9lkR6EiorlEi4QbIReG/AZUzzGbzUy2rP5J9tHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aumnV8SBWtglL63F+RGKQgVQFeBoqzkFo3z0HBPZiBgb6I9uuvfC78TfaaQwkhOax
         oRp0y4+V+8r1y+tAg1AXfwtwHCtCc2JQF7GOKu94MnUY6gLj98wbiby9Dh5nfRSZG3
         CVAC4Ylu7LkKDS/YzH4Zr/9EpqIMHMEuITmdesWg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 3/4] RDMA/core: Introduce new GID table query API
Date:   Tue, 22 Sep 2020 11:26:40 +0300
Message-Id: <20200922082641.2149549-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922082641.2149549-1-leon@kernel.org>
References: <20200922082641.2149549-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Introduce rdma_query_gid_table which enables querying all the GID tables
of a given device and copying the attributes of all valid GID entries to
a provided buffer.

This API provides a faster way to query a GID table using single call and
will be used in libibverbs to improve current approach that requires
multiple calls to open, close and read multiple sysfs files for a single
GID table entry.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c         | 75 ++++++++++++++++++++++++-
 include/rdma/ib_cache.h                 |  3 +
 include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index cf49ac0b0aa6..ee6e15d12206 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1247,6 +1247,74 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
 }
 EXPORT_SYMBOL(rdma_get_gid_attr);
 
+/**
+ * rdma_query_gid_table - Reads GID table entries of all the ports of a device up to max_entries.
+ * @device: The device to query.
+ * @entries: Entries where GID entries are returned.
+ * @max_entries: Maximum number of entries that can be returned.
+ * Entries array must be allocated to hold max_entries number of entries.
+ * @num_entries: Updated to the number of entries that were successfully read.
+ *
+ * Returns number of entries on success or appropriate error code.
+ */
+ssize_t rdma_query_gid_table(struct ib_device *device,
+			     struct ib_uverbs_gid_entry *entries,
+			     size_t max_entries)
+{
+	const struct ib_gid_attr *gid_attr;
+	ssize_t num_entries = 0, ret;
+	struct ib_gid_table *table;
+	unsigned int port_num, i;
+	struct net_device *ndev;
+	unsigned long flags;
+
+	rdma_for_each_port(device, port_num) {
+		if (!rdma_ib_or_roce(device, port_num))
+			continue;
+
+		table = rdma_gid_table(device, port_num);
+		read_lock_irqsave(&table->rwlock, flags);
+		for (i = 0; i < table->sz; i++) {
+			if (!is_gid_entry_valid(table->data_vec[i]))
+				continue;
+			if (num_entries >= max_entries) {
+				ret = -EINVAL;
+				goto err;
+			}
+
+			gid_attr = &table->data_vec[i]->attr;
+
+			memcpy(&entries->gid, &gid_attr->gid,
+			       sizeof(gid_attr->gid));
+			entries->gid_index = gid_attr->index;
+			entries->port_num = gid_attr->port_num;
+			entries->gid_type = gid_attr->gid_type;
+			rcu_read_lock();
+			ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
+			if (IS_ERR(ndev)) {
+				if (PTR_ERR(ndev) != -ENODEV) {
+					ret = PTR_ERR(ndev);
+					rcu_read_unlock();
+					goto err;
+				}
+			} else {
+				entries->netdev_ifindex = ndev->ifindex;
+			}
+			rcu_read_unlock();
+
+			num_entries++;
+			entries++;
+		}
+		read_unlock_irqrestore(&table->rwlock, flags);
+	}
+
+	return num_entries;
+err:
+	read_unlock_irqrestore(&table->rwlock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_query_gid_table);
+
 /**
  * rdma_put_gid_attr - Release reference to the GID attribute
  * @attr:		Pointer to the GID attribute whose reference
@@ -1303,7 +1371,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 	struct ib_gid_table_entry *entry =
 			container_of(attr, struct ib_gid_table_entry, attr);
 	struct ib_device *device = entry->attr.device;
-	struct net_device *ndev = ERR_PTR(-ENODEV);
+	struct net_device *ndev = ERR_PTR(-EINVAL);
 	u8 port_num = entry->attr.port_num;
 	struct ib_gid_table *table;
 	unsigned long flags;
@@ -1315,9 +1383,10 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr)
 	valid = is_gid_entry_valid(table->data_vec[attr->index]);
 	if (valid) {
 		ndev = rcu_dereference(attr->ndev);
-		if (!ndev ||
-		    (ndev && ((READ_ONCE(ndev->flags) & IFF_UP) == 0)))
+		if (!ndev)
 			ndev = ERR_PTR(-ENODEV);
+		else if ((READ_ONCE(ndev->flags) & IFF_UP) == 0)
+			ndev = ERR_PTR(-EINVAL);
 	}
 	read_unlock_irqrestore(&table->rwlock, flags);
 	return ndev;
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 66a8f369a2fa..bae29f50adff 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -110,5 +110,8 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 					    u8 port_num, int index);
 void rdma_put_gid_attr(const struct ib_gid_attr *attr);
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr);
+ssize_t rdma_query_gid_table(struct ib_device *device,
+			     struct ib_uverbs_gid_entry *entries,
+			     size_t max_entries);
 
 #endif /* _IB_CACHE_H */
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 5debab45ebcb..d5ac65ae2557 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -250,4 +250,12 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 };
 
+struct ib_uverbs_gid_entry {
+	__aligned_u64 gid[2];
+	__u32 gid_index;
+	__u32 port_num;
+	__u32 gid_type;
+	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
+};
+
 #endif
-- 
2.26.2

