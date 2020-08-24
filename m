Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0305224FBD1
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHXKpL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 06:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgHXKpI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 06:45:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C94A2071E;
        Mon, 24 Aug 2020 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598265907;
        bh=megZ8voHTUNTEko6W9gl8FxkgvJwPPS0YrlcNZ8aYv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kwjst7+U63E3yK60G9hPOXeW2B1mVvxXpUqN8ZT38euIORSKTVXQ6hdlCXNuHSZo/
         mH0cS9IJu1Vo9uW5SuEQAzuR06uHsBDTNUz119hWd88A5L0ceb5q1jpWgeLJLUhhP4
         mtPh5HjZi7Hf0PeQ05ZI3neE5Z+95x3uCKFTNnBY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 14/14] RDMA/restrack: Drop valid restrack field as source of ambiguity
Date:   Mon, 24 Aug 2020 13:44:15 +0300
Message-Id: <20200824104415.1090901-15-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824104415.1090901-1-leon@kernel.org>
References: <20200824104415.1090901-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The valid field was needed to distinguish between supported/not
supported QPs, after the create_qp was changed to support all types,
that field can be dropped and the code simplified a little bit.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
 include/rdma/restrack.h            |  9 ---------
 2 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 4caaa6312105..fb5345c8bd89 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -143,7 +143,7 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 		return container_of(res, struct rdma_counter, res)->device;
 	default:
 		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 }
 
@@ -223,7 +223,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
 	struct rdma_restrack_root *rt;
 	int ret = 0;
 
-	if (!dev)
+	if (IS_ERR_OR_NULL(dev))
 		return -ENODEV;
 
 	if (res->no_track)
@@ -261,10 +261,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
 	}
 
 out:
-	if (ret)
-		return ret;
-	res->valid = true;
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 
@@ -323,25 +320,16 @@ EXPORT_SYMBOL(rdma_restrack_put);
  */
 void rdma_restrack_del(struct rdma_restrack_entry *res)
 {
+	struct ib_device *dev = res_to_dev(res);
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
-	struct ib_device *dev;
 
-	if (!res->valid) {
-		if (res->task) {
-			put_task_struct(res->task);
-			res->task = NULL;
-		}
-		return;
-	}
-
-	if (res->no_track)
+	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
+		  "IB device should be set for restrack type %s",
+		  type2str(res->type));
+	if (res->no_track || IS_ERR_OR_NULL(dev))
 		goto out;
 
-	dev = res_to_dev(res);
-	if (WARN_ON(!dev))
-		return;
-
 	rt = &dev->res[res->type];
 
 	old = xa_erase(&rt->xa, res->id);
@@ -351,7 +339,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 	WARN_ON(old != res);
 
 out:
-	res->valid = false;
 	rdma_restrack_put(res);
 	wait_for_completion(&res->comp);
 }
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index d52f7ad6641f..c85db3d6a81e 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -59,15 +59,6 @@ enum rdma_restrack_type {
  * struct rdma_restrack_entry - metadata per-entry
  */
 struct rdma_restrack_entry {
-	/**
-	 * @valid: validity indicator
-	 *
-	 * The entries are filled during rdma_restrack_add,
-	 * can be attempted to be free during rdma_restrack_del.
-	 *
-	 * As an example for that, see mlx5 QPs with type MLX5_IB_QPT_HW_GSI
-	 */
-	bool			valid;
 	/**
 	 * @no_track: don't add this entry to restrack DB
 	 *
-- 
2.26.2

