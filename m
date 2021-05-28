Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6039402A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 11:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1Jjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 05:39:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2394 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhE1Jjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 05:39:32 -0400
Received: from dggeml766-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrzzF2cQ4z65Zp;
        Fri, 28 May 2021 17:34:17 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggeml766-chm.china.huawei.com (10.1.199.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 17:37:56 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 06/12] RDMA/core: Use refcount_t instead of atomic_t on refcount of mcast_group
Date:   Fri, 28 May 2021 17:37:37 +0800
Message-ID: <1622194663-2383-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
regarded as there is a risk about use-after-free. So it should be set to 1
directly during initialization.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/multicast.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index a236532..17abc21 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -103,7 +103,7 @@ struct mcast_group {
 	struct list_head	active_list;
 	struct mcast_member	*last_join;
 	int			members[NUM_JOIN_MEMBERSHIP_TYPES];
-	atomic_t		refcount;
+	refcount_t		refcount;
 	enum mcast_group_state	state;
 	struct ib_sa_query	*query;
 	u16			pkey_index;
@@ -188,7 +188,7 @@ static void release_group(struct mcast_group *group)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (atomic_dec_and_test(&group->refcount)) {
+	if (refcount_dec_and_test(&group->refcount)) {
 		rb_erase(&group->node, &port->table);
 		spin_unlock_irqrestore(&port->lock, flags);
 		kfree(group);
@@ -212,7 +212,7 @@ static void queue_join(struct mcast_member *member)
 	list_add_tail(&member->list, &group->pending_list);
 	if (group->state == MCAST_IDLE) {
 		group->state = MCAST_BUSY;
-		atomic_inc(&group->refcount);
+		refcount_inc(&group->refcount);
 		queue_work(mcast_wq, &group->work);
 	}
 	spin_unlock_irqrestore(&group->lock, flags);
@@ -565,8 +565,11 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
 	if (!is_mgid0) {
 		spin_lock_irqsave(&port->lock, flags);
 		group = mcast_find(port, mgid);
-		if (group)
+		if (group) {
+			refcount_inc(&group->refcount);
 			goto found;
+		}
+
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
@@ -590,8 +593,10 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
 		group = cur_group;
 	} else
 		refcount_inc(&port->refcount);
+
+	refcount_set(&group->refcount, 1);
+
 found:
-	atomic_inc(&group->refcount);
 	spin_unlock_irqrestore(&port->lock, flags);
 	return group;
 }
@@ -780,7 +785,7 @@ static void mcast_groups_event(struct mcast_port *port,
 		group = rb_entry(node, struct mcast_group, node);
 		spin_lock(&group->lock);
 		if (group->state == MCAST_IDLE) {
-			atomic_inc(&group->refcount);
+			refcount_inc(&group->refcount);
 			queue_work(mcast_wq, &group->work);
 		}
 		if (group->state != MCAST_GROUP_ERROR)
-- 
2.7.4

