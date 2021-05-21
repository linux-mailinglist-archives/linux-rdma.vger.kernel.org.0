Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77E438C413
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhEUJ5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5650 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhEUJzS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:18 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmhgt647Hz16Q39;
        Fri, 21 May 2021 17:51:06 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:54 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:54 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 04/17] RDMA/core: Use refcount_t instead of atomic_t on refcount of mcast_member
Date:   Fri, 21 May 2021 17:53:32 +0800
Message-ID: <1621590825-60693-5-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/core/multicast.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index a5dd4b7..de134a4 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -117,7 +117,7 @@ struct mcast_member {
 	struct mcast_group	*group;
 	struct list_head	list;
 	enum mcast_state	state;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	comp;
 };
 
@@ -199,7 +199,7 @@ static void release_group(struct mcast_group *group)
 
 static void deref_member(struct mcast_member *member)
 {
-	if (atomic_dec_and_test(&member->refcount))
+	if (refcount_dec_and_test(&member->refcount))
 		complete(&member->comp);
 }
 
@@ -401,7 +401,7 @@ static void process_group_error(struct mcast_group *group)
 	while (!list_empty(&group->active_list)) {
 		member = list_entry(group->active_list.next,
 				    struct mcast_member, list);
-		atomic_inc(&member->refcount);
+		refcount_inc(&member->refcount);
 		list_del_init(&member->list);
 		adjust_membership(group, member->multicast.rec.join_state, -1);
 		member->state = MCAST_ERROR;
@@ -445,7 +445,7 @@ static void mcast_work_handler(struct work_struct *work)
 				    struct mcast_member, list);
 		multicast = &member->multicast;
 		join_state = multicast->rec.join_state;
-		atomic_inc(&member->refcount);
+		refcount_inc(&member->refcount);
 
 		if (join_state == (group->rec.join_state & join_state)) {
 			status = cmp_rec(&group->rec, &multicast->rec,
@@ -497,7 +497,7 @@ static void process_join_error(struct mcast_group *group, int status)
 	member = list_entry(group->pending_list.next,
 			    struct mcast_member, list);
 	if (group->last_join == member) {
-		atomic_inc(&member->refcount);
+		refcount_inc(&member->refcount);
 		list_del_init(&member->list);
 		spin_unlock_irq(&group->lock);
 		ret = member->multicast.callback(status, &member->multicast);
@@ -632,7 +632,7 @@ ib_sa_join_multicast(struct ib_sa_client *client,
 	member->multicast.callback = callback;
 	member->multicast.context = context;
 	init_completion(&member->comp);
-	atomic_set(&member->refcount, 1);
+	refcount_set(&member->refcount, 1);
 	member->state = MCAST_JOINING;
 
 	member->group = acquire_group(&dev->port[port_num - dev->start_port],
-- 
2.7.4

