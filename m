Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9122689C4
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINLNJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINLLn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:11:43 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653A5208DB;
        Mon, 14 Sep 2020 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600081903;
        bh=vEW+Ii6EtfmJ58NbIHsAq+O5hLWNALYf/PEX9OQlBGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+u0zHwU8sStAuPap9qVYOs1OYtRbMVxbq93i5hQlh9qlYHmAuwZrjr4e9j4Dnmwr
         OwGkIRucJ2gSj25KFO6nBuC5tdDH/Jy8CdJxCQN6MAbHa6EZIuumrc8qmudthSzJ6B
         uVZKCSC5C71+SMpyC/oKqxGfUsJZWhbrGIgM4kXg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 3/4] RDMA/core: Introduce new GID table query API
Date:   Mon, 14 Sep 2020 14:11:28 +0300
Message-Id: <20200914111129.343651-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914111129.343651-1-leon@kernel.org>
References: <20200914111129.343651-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
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
 drivers/infiniband/core/cache.c         | 91 +++++++++++++++++++++++++
 include/rdma/ib_cache.h                 |  5 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
 3 files changed, 104 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index cf49ac0b0aa6..d4a83b52a31e 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1247,6 +1247,97 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
 }
 EXPORT_SYMBOL(rdma_get_gid_attr);
 
+/**
+ * rdma_get_ndev_ifindex - Reads ndev ifindex of the given gid attr.
+ * @gid_attr: Pointer to the GID attribute.
+ * @ndev_ifindex: Pointer through which the ndev ifindex is returned.
+ *
+ * Returns 0 on success or appropriate error code. The netdevice must be in UP
+ * state.
+ */
+int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr, u32 *ndev_ifindex)
+{
+	struct net_device *ndev;
+	int ret = 0;
+
+	if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
+		*ndev_ifindex = 0;
+		return 0;
+	}
+
+	rcu_read_lock();
+	ndev = rcu_dereference(gid_attr->ndev);
+	if (!ndev || (READ_ONCE(ndev->flags) & IFF_UP) == 0) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	*ndev_ifindex = ndev->ifindex;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL(rdma_get_ndev_ifindex);
+
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
+			ret = rdma_get_ndev_ifindex(gid_attr,
+						    &entries->netdev_ifindex);
+			if (ret)
+				goto err;
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
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 66a8f369a2fa..0f092ab0d160 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -110,5 +110,10 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 					    u8 port_num, int index);
 void rdma_put_gid_attr(const struct ib_gid_attr *attr);
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr);
+int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr,
+			  u32 *ndev_ifindex);
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

