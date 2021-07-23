Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1873D3B9E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jul 2021 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhGWN2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jul 2021 09:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235349AbhGWN2c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Jul 2021 09:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC0F608FE;
        Fri, 23 Jul 2021 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627049346;
        bh=1SE9z8tw+fs+3jTSXADkCQu8cHFPE+X1USwTvTucJ8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ML9AkpuI5zQ+pq1q8RxcXAbA41gZFoshbFPLFeSBsTFAHUeCr/o04BmXUXM+7EcKq
         c+bG2N2a8gsxH2d+7MQmLPo7nZRcv2Jf8erWb0zZxwnSDa3aW5r9sSmYdmEf271ape
         c3kMNxuTLtjwNKOzxy883Xf9t+GgXuVzyHRNONj99qQLVFJhCN95av7PslC23DeVqU
         EJNig8Z7PZpWAFz0PEqvNWVEMwHY/LDpO8rCy3nUa8D9/zHkcLtj0c4ygk9mgbjOyW
         ziFAzP/JDvNNXyGOKSGlEL9ZsBFohUYe8QAiXSJ1pjew29utmjIOCwpq6090fiOrRT
         s92cR0uVvs8cg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Tatyana E. Nikolova" <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 2/3] RDMA/iwpm: Remove not-needed reference counting
Date:   Fri, 23 Jul 2021 17:08:56 +0300
Message-Id: <1778ded873ba58c9fadc5bb25038de1cec843bec.1627048781.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627048781.git.leonro@nvidia.com>
References: <cover.1627048781.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

iwpm_init() and iwpm_exit() are called only once during iw_cm module
load. This makes whole reference count implementation not needed at all.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/iwpm_util.c | 62 ++++++++---------------------
 drivers/infiniband/core/iwpm_util.h |  1 -
 2 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 3f8c019c7260..45e9aa503a44 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -48,7 +48,6 @@ static DEFINE_SPINLOCK(iwpm_mapinfo_lock);
 static struct hlist_head *iwpm_reminfo_bucket;
 static DEFINE_SPINLOCK(iwpm_reminfo_lock);
 
-static DEFINE_MUTEX(iwpm_admin_lock);
 static struct iwpm_admin_data iwpm_admin;
 
 /**
@@ -59,39 +58,22 @@ static struct iwpm_admin_data iwpm_admin;
  */
 int iwpm_init(u8 nl_client)
 {
-	int ret = 0;
-	mutex_lock(&iwpm_admin_lock);
-	if (!refcount_read(&iwpm_admin.refcount)) {
-		iwpm_hash_bucket = kcalloc(IWPM_MAPINFO_HASH_SIZE,
-					   sizeof(struct hlist_head),
-					   GFP_KERNEL);
-		if (!iwpm_hash_bucket) {
-			ret = -ENOMEM;
-			goto init_exit;
-		}
-		iwpm_reminfo_bucket = kcalloc(IWPM_REMINFO_HASH_SIZE,
-					      sizeof(struct hlist_head),
-					      GFP_KERNEL);
-		if (!iwpm_reminfo_bucket) {
-			kfree(iwpm_hash_bucket);
-			ret = -ENOMEM;
-			goto init_exit;
-		}
+	iwpm_hash_bucket = kcalloc(IWPM_MAPINFO_HASH_SIZE,
+				   sizeof(struct hlist_head), GFP_KERNEL);
+	if (!iwpm_hash_bucket)
+		return -ENOMEM;
 
-		refcount_set(&iwpm_admin.refcount, 1);
-	} else {
-		refcount_inc(&iwpm_admin.refcount);
+	iwpm_reminfo_bucket = kcalloc(IWPM_REMINFO_HASH_SIZE,
+				      sizeof(struct hlist_head), GFP_KERNEL);
+	if (!iwpm_reminfo_bucket) {
+		kfree(iwpm_hash_bucket);
+		return -ENOMEM;
 	}
 
-init_exit:
-	mutex_unlock(&iwpm_admin_lock);
-	if (!ret) {
-		iwpm_set_valid(nl_client, 1);
-		iwpm_set_registration(nl_client, IWPM_REG_UNDEF);
-		pr_debug("%s: Mapinfo and reminfo tables are created\n",
-				__func__);
-	}
-	return ret;
+	iwpm_set_valid(nl_client, 1);
+	iwpm_set_registration(nl_client, IWPM_REG_UNDEF);
+	pr_debug("%s: Mapinfo and reminfo tables are created\n", __func__);
+	return 0;
 }
 
 static void free_hash_bucket(void);
@@ -105,21 +87,9 @@ static void free_reminfo_bucket(void);
  */
 int iwpm_exit(u8 nl_client)
 {
-
-	if (!iwpm_valid_client(nl_client))
-		return -EINVAL;
-	mutex_lock(&iwpm_admin_lock);
-	if (!refcount_read(&iwpm_admin.refcount)) {
-		mutex_unlock(&iwpm_admin_lock);
-		pr_err("%s Incorrect usage - negative refcount\n", __func__);
-		return -EINVAL;
-	}
-	if (refcount_dec_and_test(&iwpm_admin.refcount)) {
-		free_hash_bucket();
-		free_reminfo_bucket();
-		pr_debug("%s: Resources are destroyed\n", __func__);
-	}
-	mutex_unlock(&iwpm_admin_lock);
+	free_hash_bucket();
+	free_reminfo_bucket();
+	pr_debug("%s: Resources are destroyed\n", __func__);
 	iwpm_set_valid(nl_client, 0);
 	iwpm_set_registration(nl_client, IWPM_REG_UNDEF);
 	return 0;
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index e201835de733..e2eacc017078 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -90,7 +90,6 @@ struct iwpm_remote_info {
 };
 
 struct iwpm_admin_data {
-	refcount_t refcount;
 	atomic_t nlmsg_seq;
 	int      client_list[RDMA_NL_NUM_CLIENTS];
 	u32      reg_list[RDMA_NL_NUM_CLIENTS];
-- 
2.31.1

