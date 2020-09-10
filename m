Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D339C2652EF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgIJV03 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbgIJOXG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4306520C09;
        Thu, 10 Sep 2020 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599747733;
        bh=7cSBis6ieClEk+sEqsxJSISWCI6GmvYwiBg/oxz8Jws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCGf0saAAeeCkEmSYZET82P7NxVDy1hswdS8SfqmPYAIK5uDQitNg860oOl+AWqRr
         M1+7GUHWVHzeXI+CXL6z5wg6eetKw/xfT0ifC0RFqGrbNuNCdv9Kty1dcCuUNVzClD
         bNklfJgJJ8/rg5RBHsGPjZSUDK7LVhzJ1oyIOKyc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/4] RDMA/core: Change rdma_get_gid_attr returned error code
Date:   Thu, 10 Sep 2020 17:22:01 +0300
Message-Id: <20200910142204.1309061-2-leon@kernel.org>
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

Change the error code returned from rdma_get_gid_attr when the GID entry
is invalid but the GID index is in the gid table size range to -ENODATA
instead of -EINVAL.

This change is done in order to provide a more accurate error reporting
to be used by the new GID query API in user space. Nevertheless, -EINVAL
is still returned from sysfs in the aforementioned case to maintain
compatibility with user space that expects -EINVAL.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 2 +-
 drivers/infiniband/core/sysfs.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index ffad73bb40ff..6079f1f7e678 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1220,7 +1220,7 @@ EXPORT_SYMBOL(ib_get_cached_port_state);
 const struct ib_gid_attr *
 rdma_get_gid_attr(struct ib_device *device, u8 port_num, int index)
 {
-	const struct ib_gid_attr *attr = ERR_PTR(-EINVAL);
+	const struct ib_gid_attr *attr = ERR_PTR(-ENODATA);
 	struct ib_gid_table *table;
 	unsigned long flags;
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 01d85da00187..1a5507b79437 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -391,7 +391,8 @@ static ssize_t _show_port_gid_attr(
 
 	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
 	if (IS_ERR(gid_attr))
-		return PTR_ERR(gid_attr);
+		/* -EINVAL is returned for user space compatibility reasons. */
+		return -EINVAL;
 
 	ret = print(gid_attr, buf);
 	rdma_put_gid_attr(gid_attr);
-- 
2.26.2

