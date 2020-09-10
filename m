Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E326529E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIJVVU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgIJOYc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:24:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32ACE21D81;
        Thu, 10 Sep 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599747743;
        bh=Ma8tFkJnwwKpSb80i0zKFhoRPfTwdBSmbd+Igv8cEV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZTmV5sK47IUF6OfOtJYtkxULDz0S7ga2Bet8W3l6ZQJVv/hrW4lrLTWKJ8/j1zZv
         PPy1aZ8X7Op7GpRQKp32688xZEY8Fl2PWrTDNRILAySQWSMkilGwSNncfQmkpTWlSZ
         9JcCUagh39Krn6upCPHkGtA4fjjuPc42uVRbXkUY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/4] RDMA/core: Introduce new GID table query API
Date:   Thu, 10 Sep 2020 17:22:03 +0300
Message-Id: <20200910142204.1309061-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910142204.1309061-1-leon@kernel.org>
References: <20200910142204.1309061-1-leon@kernel.org>
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
 drivers/infiniband/core/cache.c         | 93 +++++++++++++++++++++++++
 include/rdma/ib_cache.h                 |  5 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h |  8 +++
 3 files changed, 106 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index cf49ac0b0aa6..175e229eccd3 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1247,6 +1247,99 @@ rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
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
+ * Returns 0 on success or appropriate error code.
+ */
+int rdma_query_gid_table(struct ib_device *device,
+			 struct ib_uverbs_gid_entry *entries,
+			 size_t max_entries, size_t *num_entries)
+{
+	const struct ib_gid_attr *gid_attr;
+	struct ib_gid_table *table;
+	unsigned int port_num;
+	unsigned long flags;
+	int ret;
+	int i;
+
+	*num_entries = 0;
+	rdma_for_each_port(device, port_num) {
+		if (!rdma_ib_or_roce(device, port_num))
+			continue;
+
+		table = rdma_gid_table(device, port_num);
+		read_lock_irqsave(&table->rwlock, flags);
+		for (i = 0; i < table->sz; i++) {
+			if (!is_gid_entry_valid(table->data_vec[i]))
+				continue;
+			if (*num_entries >= max_entries) {
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
+			(*num_entries)++;
+			entries++;
+		}
+		read_unlock_irqrestore(&table->rwlock, flags);
+	}
+
+	return 0;
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
index 66a8f369a2fa..94e4f729f8e4 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -110,5 +110,10 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 					    u8 port_num, int index);
 void rdma_put_gid_attr(const struct ib_gid_attr *attr);
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr);
+int rdma_get_ndev_ifindex(const struct ib_gid_attr *gid_attr,
+			  u32 *ndev_ifindex);
+int rdma_query_gid_table(struct ib_device *device,
+			 struct ib_uverbs_gid_entry *entries,
+			 size_t max_entries, size_t *num_entries);
 
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

