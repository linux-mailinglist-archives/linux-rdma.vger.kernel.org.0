Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22838FB37
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEYGx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 02:53:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6700 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhEYGx2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 02:53:28 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq4R91lc7zlYJb;
        Tue, 25 May 2021 14:48:21 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:54 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:51:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v3 for-next 01/13] RDMA/core: Use refcount_t instead of atomic_t on refcount of iwcm_id_private
Date:   Tue, 25 May 2021 14:51:32 +0800
Message-ID: <1621925504-33019-2-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/core/iwcm.c | 9 ++++-----
 drivers/infiniband/core/iwcm.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

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
 
-- 
2.7.4

