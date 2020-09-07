Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFB25FA2D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgIGMLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 08:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbgIGMLX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 08:11:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725B921775;
        Mon,  7 Sep 2020 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599480594;
        bh=v00z8LkjsW6YOVvvonOV0ebXRkp/2+uVpcdymZxbEEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lspQcpyxgb8dySCIMBL+HzbYbaLeKRsoBDeN5dnHXT6xxBVjiitEqZGxad9tzGVZt
         xi/VnvcFAUTuEgALud6eRWcqUQtcPrf4E8ychktffAco91PlMXIZtiDY+8PbL4LmWh
         CEgNo0zYqPsVfHg9TYiUdJQBIWNdU2EDkOH21ngk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 9/9] RDMA: Make counters destroy symmetrical
Date:   Mon,  7 Sep 2020 15:09:21 +0300
Message-Id: <20200907120921.476363-10-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
References: <20200907120921.476363-1-leon@kernel.org>
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
index 0f628ac3cc92..ad2f8dfa2e66 100644
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

