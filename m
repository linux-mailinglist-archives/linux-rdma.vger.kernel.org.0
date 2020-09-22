Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB596273D40
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVI0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgIVI0u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:26:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 576BF23A1B;
        Tue, 22 Sep 2020 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600763210;
        bh=YmNJEf8K85A3l2x8+q9PpTrvnVANTDIJiYiMMN//+gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPvpsUQJHVGMztlaydmkZd7luujgJvogwMwP1gChdV7fiy8+k7aUSspcsLNHkPcFc
         7uFT6KiYTMnK116x89if7GlX36ekfFk2B+8UZOhH7WIpoxmJvBC5+FeTDDDW3tk65s
         jLhZyvB5yyt+EkTThfty5RaP54ui7svoHTl8uLWk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 1/4] RDMA/core: Change rdma_get_gid_attr returned error code
Date:   Tue, 22 Sep 2020 11:26:38 +0300
Message-Id: <20200922082641.2149549-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922082641.2149549-1-leon@kernel.org>
References: <20200922082641.2149549-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c11e50510e49..409675d48614 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -387,7 +387,8 @@ static ssize_t _show_port_gid_attr(
 
 	gid_attr = rdma_get_gid_attr(p->ibdev, p->port_num, tab_attr->index);
 	if (IS_ERR(gid_attr))
-		return PTR_ERR(gid_attr);
+		/* -EINVAL is returned for user space compatibility reasons. */
+		return -EINVAL;
 
 	ret = print(gid_attr, buf);
 	rdma_put_gid_attr(gid_attr);
-- 
2.26.2

