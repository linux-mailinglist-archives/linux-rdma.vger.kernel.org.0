Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80F38C42A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhEUJ5s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3465 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbhEUJzj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:39 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmhhH2089zCvSY;
        Fri, 21 May 2021 17:51:27 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 16/17] RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting
Date:   Fri, 21 May 2021 17:53:44 +0800
Message-ID: <1621590825-60693-17-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/ulp/ipoib/ipoib.h      | 4 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 75cd447..44d8d15 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -454,7 +454,7 @@ struct ipoib_neigh {
 	struct list_head    list;
 	struct ipoib_neigh __rcu *hnext;
 	struct rcu_head     rcu;
-	atomic_t	    refcnt;
+	refcount_t	    refcnt;
 	unsigned long       alive;
 };
 
@@ -464,7 +464,7 @@ struct ipoib_neigh {
 void ipoib_neigh_dtor(struct ipoib_neigh *neigh);
 static inline void ipoib_neigh_put(struct ipoib_neigh *neigh)
 {
-	if (atomic_dec_and_test(&neigh->refcnt))
+	if (refcount_dec_and_test(&neigh->refcnt))
 		ipoib_neigh_dtor(neigh);
 }
 struct ipoib_neigh *ipoib_neigh_get(struct net_device *dev, u8 *daddr);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index bbb1808..ac39610 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1287,7 +1287,7 @@ struct ipoib_neigh *ipoib_neigh_get(struct net_device *dev, u8 *daddr)
 	     neigh = rcu_dereference_bh(neigh->hnext)) {
 		if (memcmp(daddr, neigh->daddr, INFINIBAND_ALEN) == 0) {
 			/* found, take one ref on behalf of the caller */
-			if (!atomic_inc_not_zero(&neigh->refcnt)) {
+			if (!refcount_inc_not_zero(&neigh->refcnt)) {
 				/* deleted */
 				neigh = NULL;
 				goto out_unlock;
@@ -1382,7 +1382,7 @@ static struct ipoib_neigh *ipoib_neigh_ctor(u8 *daddr,
 	INIT_LIST_HEAD(&neigh->list);
 	ipoib_cm_set(neigh, NULL);
 	/* one ref on behalf of the caller */
-	atomic_set(&neigh->refcnt, 1);
+	refcount_set(&neigh->refcnt, 1);
 
 	return neigh;
 }
@@ -1414,7 +1414,7 @@ struct ipoib_neigh *ipoib_neigh_alloc(u8 *daddr,
 					       lockdep_is_held(&priv->lock))) {
 		if (memcmp(daddr, neigh->daddr, INFINIBAND_ALEN) == 0) {
 			/* found, take one ref on behalf of the caller */
-			if (!atomic_inc_not_zero(&neigh->refcnt)) {
+			if (!refcount_inc_not_zero(&neigh->refcnt)) {
 				/* deleted */
 				neigh = NULL;
 				break;
@@ -1429,7 +1429,7 @@ struct ipoib_neigh *ipoib_neigh_alloc(u8 *daddr,
 		goto out_unlock;
 
 	/* one ref on behalf of the hash table */
-	atomic_inc(&neigh->refcnt);
+	refcount_inc(&neigh->refcnt);
 	neigh->alive = jiffies;
 	/* put in hash */
 	rcu_assign_pointer(neigh->hnext,
-- 
2.7.4

