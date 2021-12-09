Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1545C46E8E6
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhLINTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 08:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbhLINTz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 08:19:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA1C061746;
        Thu,  9 Dec 2021 05:16:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C3C06CE24D7;
        Thu,  9 Dec 2021 13:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E88C004DD;
        Thu,  9 Dec 2021 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055778;
        bh=wU55ICo+Pqb82iww6DK1SKuU+eZ932CsbqoXkSR0ClQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLutSu9crIT7azrYqENKFi5z8ip8ci6YnG5yrdPbpi2RFNu88XYT3fsCrMkeJ4pO5
         tZJ6o7xMkPBxjwPkgvnZvMA9ayRDuRQIu+2VKLAbY5vlIAgGh+gq5AVbG7ok9970lo
         IteuZ6/F0lOxMfc0aTkMExydCA7UNZoLcFUY0yHGUXBXge5ouRvM65TIdxDJnrP+Fd
         wTknTzgbHSD731819fPCMih56PtTHvUXZHGYsVR7X9rqQi8+xmEr6R3gB5GaFOljW0
         UdBvqKzoqzhMtvRWNc66MXsfhNMrJ6Qc1hUf53157nJ2XRT7TnnGvTPlzz746wXpZP
         g2R+rZebczmrw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 1/3] RDMA/core: Modify rdma_query_gid() to return accurate error codes
Date:   Thu,  9 Dec 2021 15:16:05 +0200
Message-Id: <1f2b65dfb4d995e74b621e3e21e7c7445d187956.1639055490.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639055490.git.leonro@nvidia.com>
References: <cover.1639055490.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Modify rdma_query_gid() to return -ENOENT for empty entries. This will
make error reporting more accurate and will be used in next patches.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cache.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 0c98dd3dee67..edddcca62ece 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -955,7 +955,7 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
 {
 	struct ib_gid_table *table;
 	unsigned long flags;
-	int res = -EINVAL;
+	int res;
 
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
@@ -963,9 +963,15 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
 	table = rdma_gid_table(device, port_num);
 	read_lock_irqsave(&table->rwlock, flags);
 
-	if (index < 0 || index >= table->sz ||
-	    !is_gid_entry_valid(table->data_vec[index]))
+	if (index < 0 || index >= table->sz) {
+		res = -EINVAL
 		goto done;
+	}
+
+	if (!is_gid_entry_valid(table->data_vec[index])) {
+		res = -ENOENT;
+		goto done;
+	}
 
 	memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
 	res = 0;
-- 
2.33.1

