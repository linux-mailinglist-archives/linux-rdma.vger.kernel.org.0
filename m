Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CD356652
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 10:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhDGISw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 04:18:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16372 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbhDGISu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 04:18:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFcgS4NT0zjYZw;
        Wed,  7 Apr 2021 16:16:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 16:18:29 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 6/7] RDMA/core: Correct format of block comments
Date:   Wed, 7 Apr 2021 16:15:52 +0800
Message-ID: <1617783353-48249-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
References: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

Block comments should not use a trailing */ on a separate line and every
line of a block comment should start with an '*'.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cm.c       | 3 ++-
 drivers/infiniband/core/iwpm_msg.c | 3 ++-
 drivers/infiniband/core/mad.c      | 3 ++-
 drivers/infiniband/core/verbs.c    | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ed7b70b..c3d1103 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -255,7 +255,8 @@ struct cm_id_private {
 	struct completion comp;
 	refcount_t refcount;
 	/* Number of clients sharing this ib_cm_id. Only valid for listeners.
-	 * Protected by the cm.lock spinlock. */
+	 * Protected by the cm.lock spinlock.
+	 */
 	int listen_sharecount;
 	struct rcu_head rcu;
 
diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 30a0ff7..932b26f 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -528,7 +528,8 @@ int iwpm_add_mapping_cb(struct sk_buff *skb, struct netlink_callback *cb)
 }
 
 /* netlink attribute policy for the response to add and query mapping request
- * and response with remote address info */
+ * and response with remote address info
+ */
 static const struct nla_policy resp_query_policy[IWPM_NLA_RQUERY_MAPPING_MAX] = {
 	[IWPM_NLA_RQUERY_MAPPING_SEQ]     = { .type = NLA_U32 },
 	[IWPM_NLA_RQUERY_LOCAL_ADDR]      = {
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 3aabe90..202ac8a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1829,7 +1829,8 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 				deref_mad_agent(mad_agent_priv);
 			} else {
 				/* not user rmpp, revert to normal behavior and
-				 * drop the mad */
+				 * drop the mad
+				 */
 				ib_free_recv_mad(mad_recv_wc);
 				deref_mad_agent(mad_agent_priv);
 				return;
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index c576e2b..b7373a5 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -342,7 +342,8 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 	}
 
 	/* uverbs manipulates usecnt with proper locking, while the kabi
-	   requires the caller to guarantee we can't race here. */
+	 * requires the caller to guarantee we can't race here.
+	 */
 	WARN_ON(atomic_read(&pd->usecnt));
 
 	ret = pd->device->ops.dealloc_pd(pd, udata);
-- 
2.8.1

