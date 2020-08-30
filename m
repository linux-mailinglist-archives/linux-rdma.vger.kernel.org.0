Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BEB256CE7
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Aug 2020 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgH3IlA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Aug 2020 04:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3Ikz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 04:40:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247F020720;
        Sun, 30 Aug 2020 08:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598776854;
        bh=7Xw8cJCCTYHqeTpw9M6U4BdSZ6sJ1qa70zXMKLAwWKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQn/1iDfUSfN/+hXmQLeyoNTUZ6fQVzo0TpJ5MKJNKfsU+3OoB/8bI31Fiim+kbmg
         uTinaumtIJKBjgdHlyHQeNhlWZImQQWl3gfzUBsQ2lvX4wW/MN5LJY6clcPvXe74h0
         W1yTacDI51Ro7VHbTAWzSNLU4FI8zJ9dS/wW4lFw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 10/10] RDMA: Make counters destroy symmetrical
Date:   Sun, 30 Aug 2020 11:40:10 +0300
Message-Id: <20200830084010.102381-11-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200830084010.102381-1-leon@kernel.org>
References: <20200830084010.102381-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Change counters to return failure like any other verbs
destroy, however this flow shouldn't return error at all.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_std_types_counters.c | 4 +++-
 drivers/infiniband/hw/mlx5/counters.c               | 3 ++-
 include/rdma/ib_verbs.h                             | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index c7e7438752bc..b3c6c066b601 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -46,7 +46,9 @@ static int uverbs_free_counters(struct ib_uobject *uobject,
 	if (ret)
 		return ret;
 
-	counters->device->ops.destroy_counters(counters);
+	ret = counters->device->ops.destroy_counters(counters);
+	if (ret)
+		return ret;
 	kfree(counters);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 145f3cb40ccb..8d77fea0eb48 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -117,7 +117,7 @@ static int mlx5_ib_read_counters(struct ib_counters *counters,
 	return ret;
 }
 
-static void mlx5_ib_destroy_counters(struct ib_counters *counters)
+static int mlx5_ib_destroy_counters(struct ib_counters *counters)
 {
 	struct mlx5_ib_mcounters *mcounters = to_mcounters(counters);
 
@@ -125,6 +125,7 @@ static void mlx5_ib_destroy_counters(struct ib_counters *counters)
 	if (mcounters->hw_cntrs_hndl)
 		mlx5_fc_destroy(to_mdev(counters->device)->mdev,
 				mcounters->hw_cntrs_hndl);
+	return 0;
 }
 
 static int mlx5_ib_create_counters(struct ib_counters *counters,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 58fdaaf4f67b..25c5180f5a79 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2504,7 +2504,7 @@ struct ib_device_ops {
 				   struct uverbs_attr_bundle *attrs);
 	int (*create_counters)(struct ib_counters *counters,
 			       struct uverbs_attr_bundle *attrs);
-	void (*destroy_counters)(struct ib_counters *counters);
+	int (*destroy_counters)(struct ib_counters *counters);
 	int (*read_counters)(struct ib_counters *counters,
 			     struct ib_counters_read_attr *counters_read_attr,
 			     struct uverbs_attr_bundle *attrs);
-- 
2.26.2

