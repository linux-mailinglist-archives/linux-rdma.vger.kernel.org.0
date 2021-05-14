Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242CA3801CC
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhENCNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 22:13:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2728 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhENCNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 22:13:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhBm76BXnz1BMBS;
        Fri, 14 May 2021 10:09:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 10:11:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of atomic_t for reference counting
Date:   Fri, 14 May 2021 10:11:34 +0800
Message-ID: <1620958299-4869-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
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
 drivers/infiniband/core/iwcm.c        |  9 ++++-----
 drivers/infiniband/core/iwcm.h        |  2 +-
 drivers/infiniband/core/iwpm_util.c   | 12 ++++++++----
 drivers/infiniband/core/iwpm_util.h   |  2 +-
 drivers/infiniband/core/mad_priv.h    |  2 +-
 drivers/infiniband/core/multicast.c   | 30 +++++++++++++++---------------
 drivers/infiniband/core/uverbs.h      |  2 +-
 drivers/infiniband/core/uverbs_main.c | 12 ++++++------
 8 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index da8adad..4226115 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -211,8 +211,7 @@ static void free_cm_id(struct iwcm_id_private *cm_id_priv)
  */
 static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
-	BUG_ON(atomic_read(&cm_id_priv->refcount)==0);
-	if (atomic_dec_and_test(&cm_id_priv->refcount)) {
+	if (refcount_dec_and_test(&cm_id_priv->refcount)) {
 		BUG_ON(!list_empty(&cm_id_priv->work_list));
 		free_cm_id(cm_id_priv);
 		return 1;
@@ -225,7 +224,7 @@ static void add_ref(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 }
 
 static void rem_ref(struct iw_cm_id *cm_id)
@@ -257,7 +256,7 @@ struct iw_cm_id *iw_create_cm_id(struct ib_device *device,
 	cm_id_priv->id.add_ref = add_ref;
 	cm_id_priv->id.rem_ref = rem_ref;
 	spin_lock_init(&cm_id_priv->lock);
-	atomic_set(&cm_id_priv->refcount, 1);
+	refcount_set(&cm_id_priv->refcount, 1);
 	init_waitqueue_head(&cm_id_priv->connect_wait);
 	init_completion(&cm_id_priv->destroy_comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
@@ -1094,7 +1093,7 @@ static int cm_event_handler(struct iw_cm_id *cm_id,
 		}
 	}
 
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 	if (list_empty(&cm_id_priv->work_list)) {
 		list_add_tail(&work->list, &cm_id_priv->work_list);
 		queue_work(iwcm_wq, &work->work);
diff --git a/drivers/infiniband/core/iwcm.h b/drivers/infiniband/core/iwcm.h
index 82c2cd1..bf74639 100644
--- a/drivers/infiniband/core/iwcm.h
+++ b/drivers/infiniband/core/iwcm.h
@@ -52,7 +52,7 @@ struct iwcm_id_private {
 	wait_queue_head_t connect_wait;
 	struct list_head work_list;
 	spinlock_t lock;
-	atomic_t refcount;
+	refcount_t refcount;
 	struct list_head work_free_list;
 };
 
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index f80e555..b8f40e6 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -61,7 +61,7 @@ int iwpm_init(u8 nl_client)
 {
 	int ret = 0;
 	mutex_lock(&iwpm_admin_lock);
-	if (atomic_read(&iwpm_admin.refcount) == 0) {
+	if (!refcount_read(&iwpm_admin.refcount)) {
 		iwpm_hash_bucket = kcalloc(IWPM_MAPINFO_HASH_SIZE,
 					   sizeof(struct hlist_head),
 					   GFP_KERNEL);
@@ -77,8 +77,12 @@ int iwpm_init(u8 nl_client)
 			ret = -ENOMEM;
 			goto init_exit;
 		}
+
+		refcount_set(&iwpm_admin.refcount, 1);
+	} else {
+		refcount_inc(&iwpm_admin.refcount);
 	}
-	atomic_inc(&iwpm_admin.refcount);
+
 init_exit:
 	mutex_unlock(&iwpm_admin_lock);
 	if (!ret) {
@@ -105,12 +109,12 @@ int iwpm_exit(u8 nl_client)
 	if (!iwpm_valid_client(nl_client))
 		return -EINVAL;
 	mutex_lock(&iwpm_admin_lock);
-	if (atomic_read(&iwpm_admin.refcount) == 0) {
+	if (!refcount_read(&iwpm_admin.refcount)) {
 		mutex_unlock(&iwpm_admin_lock);
 		pr_err("%s Incorrect usage - negative refcount\n", __func__);
 		return -EINVAL;
 	}
-	if (atomic_dec_and_test(&iwpm_admin.refcount)) {
+	if (refcount_dec_and_test(&iwpm_admin.refcount)) {
 		free_hash_bucket();
 		free_reminfo_bucket();
 		pr_debug("%s: Resources are destroyed\n", __func__);
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index eeb8e60..5002ac6 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -90,7 +90,7 @@ struct iwpm_remote_info {
 };
 
 struct iwpm_admin_data {
-	atomic_t refcount;
+	refcount_t refcount;
 	atomic_t nlmsg_seq;
 	int      client_list[RDMA_NL_NUM_CLIENTS];
 	u32      reg_list[RDMA_NL_NUM_CLIENTS];
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 4aa16b3..25e573d 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -115,7 +115,7 @@ struct ib_mad_snoop_private {
 	struct ib_mad_qp_info *qp_info;
 	int snoop_index;
 	int mad_snoop_flags;
-	atomic_t refcount;
+	refcount_t refcount;
 	struct completion comp;
 };
 
diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index a5dd4b7..54bbe65 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -61,7 +61,7 @@ struct mcast_port {
 	struct mcast_device	*dev;
 	spinlock_t		lock;
 	struct rb_root		table;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	comp;
 	u32			port_num;
 };
@@ -103,7 +103,7 @@ struct mcast_group {
 	struct list_head	active_list;
 	struct mcast_member	*last_join;
 	int			members[NUM_JOIN_MEMBERSHIP_TYPES];
-	atomic_t		refcount;
+	refcount_t		refcount;
 	enum mcast_group_state	state;
 	struct ib_sa_query	*query;
 	u16			pkey_index;
@@ -117,7 +117,7 @@ struct mcast_member {
 	struct mcast_group	*group;
 	struct list_head	list;
 	enum mcast_state	state;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	struct completion	comp;
 };
 
@@ -178,7 +178,7 @@ static struct mcast_group *mcast_insert(struct mcast_port *port,
 
 static void deref_port(struct mcast_port *port)
 {
-	if (atomic_dec_and_test(&port->refcount))
+	if (refcount_dec_and_test(&port->refcount))
 		complete(&port->comp);
 }
 
@@ -188,7 +188,7 @@ static void release_group(struct mcast_group *group)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (atomic_dec_and_test(&group->refcount)) {
+	if (refcount_dec_and_test(&group->refcount)) {
 		rb_erase(&group->node, &port->table);
 		spin_unlock_irqrestore(&port->lock, flags);
 		kfree(group);
@@ -199,7 +199,7 @@ static void release_group(struct mcast_group *group)
 
 static void deref_member(struct mcast_member *member)
 {
-	if (atomic_dec_and_test(&member->refcount))
+	if (refcount_dec_and_test(&member->refcount))
 		complete(&member->comp);
 }
 
@@ -212,7 +212,7 @@ static void queue_join(struct mcast_member *member)
 	list_add_tail(&member->list, &group->pending_list);
 	if (group->state == MCAST_IDLE) {
 		group->state = MCAST_BUSY;
-		atomic_inc(&group->refcount);
+		refcount_inc(&group->refcount);
 		queue_work(mcast_wq, &group->work);
 	}
 	spin_unlock_irqrestore(&group->lock, flags);
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
@@ -589,9 +589,9 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
 		kfree(group);
 		group = cur_group;
 	} else
-		atomic_inc(&port->refcount);
+		refcount_inc(&port->refcount);
 found:
-	atomic_inc(&group->refcount);
+	refcount_inc(&group->refcount);
 	spin_unlock_irqrestore(&port->lock, flags);
 	return group;
 }
@@ -632,7 +632,7 @@ ib_sa_join_multicast(struct ib_sa_client *client,
 	member->multicast.callback = callback;
 	member->multicast.context = context;
 	init_completion(&member->comp);
-	atomic_set(&member->refcount, 1);
+	refcount_set(&member->refcount, 1);
 	member->state = MCAST_JOINING;
 
 	member->group = acquire_group(&dev->port[port_num - dev->start_port],
@@ -780,7 +780,7 @@ static void mcast_groups_event(struct mcast_port *port,
 		group = rb_entry(node, struct mcast_group, node);
 		spin_lock(&group->lock);
 		if (group->state == MCAST_IDLE) {
-			atomic_inc(&group->refcount);
+			refcount_inc(&group->refcount);
 			queue_work(mcast_wq, &group->work);
 		}
 		if (group->state != MCAST_GROUP_ERROR)
@@ -840,7 +840,7 @@ static int mcast_add_one(struct ib_device *device)
 		spin_lock_init(&port->lock);
 		port->table = RB_ROOT;
 		init_completion(&port->comp);
-		atomic_set(&port->refcount, 1);
+		refcount_set(&port->refcount, 1);
 		++count;
 	}
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 53a1047..821d93c 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -97,7 +97,7 @@ ib_uverbs_init_udata_buf_or_null(struct ib_udata *udata,
  */
 
 struct ib_uverbs_device {
-	atomic_t				refcount;
+	refcount_t				refcount;
 	u32					num_comp_vectors;
 	struct completion			comp;
 	struct device				dev;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index f173ecd..d544340 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -197,7 +197,7 @@ void ib_uverbs_release_file(struct kref *ref)
 		module_put(ib_dev->ops.owner);
 	srcu_read_unlock(&file->device->disassociate_srcu, srcu_key);
 
-	if (atomic_dec_and_test(&file->device->refcount))
+	if (refcount_dec_and_test(&file->device->refcount))
 		ib_uverbs_comp_dev(file->device);
 
 	if (file->default_async_file)
@@ -891,7 +891,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 	int srcu_key;
 
 	dev = container_of(inode->i_cdev, struct ib_uverbs_device, cdev);
-	if (!atomic_inc_not_zero(&dev->refcount))
+	if (!refcount_inc_not_zero(&dev->refcount))
 		return -ENXIO;
 
 	get_device(&dev->dev);
@@ -955,7 +955,7 @@ static int ib_uverbs_open(struct inode *inode, struct file *filp)
 err:
 	mutex_unlock(&dev->lists_mutex);
 	srcu_read_unlock(&dev->disassociate_srcu, srcu_key);
-	if (atomic_dec_and_test(&dev->refcount))
+	if (refcount_dec_and_test(&dev->refcount))
 		ib_uverbs_comp_dev(dev);
 
 	put_device(&dev->dev);
@@ -1124,7 +1124,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
 	uverbs_dev->dev.release = ib_uverbs_release_dev;
 	uverbs_dev->groups[0] = &dev_attr_group;
 	uverbs_dev->dev.groups = uverbs_dev->groups;
-	atomic_set(&uverbs_dev->refcount, 1);
+	refcount_set(&uverbs_dev->refcount, 1);
 	init_completion(&uverbs_dev->comp);
 	uverbs_dev->xrcd_tree = RB_ROOT;
 	mutex_init(&uverbs_dev->xrcd_tree_mutex);
@@ -1166,7 +1166,7 @@ static int ib_uverbs_add_one(struct ib_device *device)
 err_uapi:
 	ida_free(&uverbs_ida, devnum);
 err:
-	if (atomic_dec_and_test(&uverbs_dev->refcount))
+	if (refcount_dec_and_test(&uverbs_dev->refcount))
 		ib_uverbs_comp_dev(uverbs_dev);
 	wait_for_completion(&uverbs_dev->comp);
 	put_device(&uverbs_dev->dev);
@@ -1229,7 +1229,7 @@ static void ib_uverbs_remove_one(struct ib_device *device, void *client_data)
 		wait_clients = 0;
 	}
 
-	if (atomic_dec_and_test(&uverbs_dev->refcount))
+	if (refcount_dec_and_test(&uverbs_dev->refcount))
 		ib_uverbs_comp_dev(uverbs_dev);
 	if (wait_clients)
 		wait_for_completion(&uverbs_dev->comp);
-- 
2.7.4

