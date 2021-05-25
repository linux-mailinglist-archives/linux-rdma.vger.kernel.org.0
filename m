Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108D138FB3E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhEYGxb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:53:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3937 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhEYGxa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:53:30 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fq4S35f7szBvgG;
        Tue, 25 May 2021 14:49:07 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:59 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next 12/13] RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting
Date:   Tue, 25 May 2021 14:51:43 +0800
Message-ID: <1621925504-33019-13-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

