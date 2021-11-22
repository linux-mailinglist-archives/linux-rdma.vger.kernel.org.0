Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D588458DE5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbhKVL5X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239464AbhKVL5V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:57:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E75B8604DC;
        Mon, 22 Nov 2021 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582054;
        bh=C+5JXSX+mCZ9QQp05BfiQhX1KSncWvCy3NwuPdtr3bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBnNZQU/sft1ok9YNp+0Vl1dLEosAmKb1nAVp5At5dFtRe4gZc4YCuubyFNMYPIV2
         k7vCXuxBxBRclOQRCEJlVFMeZmdU89+0hfplb/WXo3JRHVcZ1eQA5vBV2U3DA7Ricr
         jhl1iI4vQTgnjv206bJ+Q7441iWO9QKVLy1VZ2M1owC3WGAg9B1QpXOfOdfjbXORpH
         82R9/2WlIV5+oLZM47/AeOGCuk/6ZJm0NNmQBX+wBWUhmSi82ai85RHv+C/hpHEbBT
         TAxReKFoFkmoAsWX2eKYMb9e4BRc1iQge3ktMMy9xQzSEozkNntTpqe4f7mCim8OWV
         59rS0l8J0FLTw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 1/3] RDMA/core: Modify rdma_query_gid() to return accurate error codes
Date:   Mon, 22 Nov 2021 13:53:56 +0200
Message-Id: <43f8d94766597cc2fa7f1c2e3f81a1b558f59128.1637581778.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637581778.git.leonro@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
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
 drivers/infiniband/core/cache.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 0c98dd3dee67..dd66f1a6e792 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -963,9 +963,13 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
 	table = rdma_gid_table(device, port_num);
 	read_lock_irqsave(&table->rwlock, flags);
 
-	if (index < 0 || index >= table->sz ||
-	    !is_gid_entry_valid(table->data_vec[index]))
+	if (index < 0 || index >= table->sz)
+		goto done;
+
+	if (!is_gid_entry_valid(table->data_vec[index])) {
+		res = -ENOENT;
 		goto done;
+	}
 
 	memcpy(gid, &table->data_vec[index]->attr.gid, sizeof(*gid));
 	res = 0;
-- 
2.33.1

