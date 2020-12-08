Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E342D248F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 08:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLHHgv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 02:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgLHHgv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 02:36:51 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/3] RDMA/uverbs: Fix incorrect variable type
Date:   Tue,  8 Dec 2020 09:35:45 +0200
Message-Id: <20201208073545.9723-4-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201208073545.9723-1-leon@kernel.org>
References: <20201208073545.9723-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Fix incorrect type of max_entries in UVERBS_METHOD_QUERY_GID_TABLE -
max_entries is of type size_t although it can take negative values.

The following static check revealed it:

drivers/infiniband/core/uverbs_std_types_device.c:338
ib_uverbs_handler_UVERBS_METHOD_QUERY_GID_TABLE()
warn: 'max_entries' unsigned <= 0

Fixes: 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query API to user space")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_device.c | 14 +++++---------
 include/rdma/uverbs_ioctl.h                       | 10 ++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index 302f898c5833..9ec6971056fa 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -317,8 +317,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
 	struct ib_device *ib_dev;
 	size_t user_entry_size;
 	ssize_t num_entries;
-	size_t max_entries;
-	size_t num_bytes;
+	int max_entries;
 	u32 flags;
 	int ret;
 
@@ -336,19 +335,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
 		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
 		user_entry_size);
 	if (max_entries <= 0)
-		return -EINVAL;
+		return max_entries ?: -EINVAL;
 
 	ucontext = ib_uverbs_get_ucontext(attrs);
 	if (IS_ERR(ucontext))
 		return PTR_ERR(ucontext);
 	ib_dev = ucontext->device;
 
-	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
-		return -EINVAL;
-
-	entries = uverbs_zalloc(attrs, num_bytes);
-	if (!entries)
-		return -ENOMEM;
+	entries = uverbs_kcalloc(attrs, max_entries, sizeof(*entries));
+	if (IS_ERR(entries))
+		return PTR_ERR(entries);
 
 	num_entries = rdma_query_gid_table(ib_dev, entries, max_entries);
 	if (num_entries < 0)
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index bf167ef6c688..39ef204753ec 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -865,6 +865,16 @@ static inline __malloc void *uverbs_zalloc(struct uverbs_attr_bundle *bundle,
 {
 	return _uverbs_alloc(bundle, size, GFP_KERNEL | __GFP_ZERO);
 }
+
+static inline __malloc void *uverbs_kcalloc(struct uverbs_attr_bundle *bundle,
+					    size_t n, size_t size)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return ERR_PTR(-EOVERFLOW);
+	return uverbs_zalloc(bundle, bytes);
+}
 int _uverbs_get_const(s64 *to, const struct uverbs_attr_bundle *attrs_bundle,
 		      size_t idx, s64 lower_bound, u64 upper_bound,
 		      s64 *def_val);
-- 
2.28.0

