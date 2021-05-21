Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39B38C421
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbhEUJ5M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5651 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhEUJzU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:20 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmhgw2GzXz16QWx;
        Fri, 21 May 2021 17:51:08 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 13/17] RDMA/i40iw: Use refcount_t instead of atomic_t on refcount of i40iw_cm_listener
Date:   Fri, 21 May 2021 17:53:41 +0800
Message-ID: <1621590825-60693-14-git-send-email-liweihang@huawei.com>
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

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 10 +++++-----
 drivers/infiniband/hw/i40iw/i40iw_cm.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 2450b7d..c1becb9 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -1491,7 +1491,7 @@ static struct i40iw_cm_listener *i40iw_find_listener(
 		     !memcmp(listen_addr, ip_zero, sizeof(listen_addr))) &&
 		     (listen_port == dst_port) &&
 		     (listener_state & listen_node->listener_state)) {
-			atomic_inc(&listen_node->ref_count);
+			refcount_inc(&listen_node->ref_count);
 			spin_unlock_irqrestore(&cm_core->listen_list_lock, flags);
 			return listen_node;
 		}
@@ -1910,7 +1910,7 @@ static int i40iw_dec_refcnt_listen(struct i40iw_cm_core *cm_core,
 		}
 	}
 
-	if (!atomic_dec_return(&listener->ref_count)) {
+	if (refcount_dec_and_test(&listener->ref_count)) {
 		spin_lock_irqsave(&cm_core->listen_list_lock, flags);
 		list_del(&listener->list);
 		spin_unlock_irqrestore(&cm_core->listen_list_lock, flags);
@@ -2870,7 +2870,7 @@ static struct i40iw_cm_listener *i40iw_make_listen_node(
 				       I40IW_CM_LISTENER_EITHER_STATE);
 	if (listener &&
 	    (listener->listener_state == I40IW_CM_LISTENER_ACTIVE_STATE)) {
-		atomic_dec(&listener->ref_count);
+		refcount_dec(&listener->ref_count);
 		i40iw_debug(cm_core->dev,
 			    I40IW_DEBUG_CM,
 			    "Not creating listener since it already exists\n");
@@ -2888,7 +2888,7 @@ static struct i40iw_cm_listener *i40iw_make_listen_node(
 
 		INIT_LIST_HEAD(&listener->child_listen_list);
 
-		atomic_set(&listener->ref_count, 1);
+		refcount_set(&listener->ref_count, 1);
 	} else {
 		listener->reused_node = 1;
 	}
@@ -3213,7 +3213,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
 				    I40IW_DEBUG_CM,
 				    "%s allocate node failed\n",
 				    __func__);
-			atomic_dec(&listener->ref_count);
+			refcount_dec(&listener->ref_count);
 			return;
 		}
 		if (!tcph->rst && !tcph->fin) {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.h b/drivers/infiniband/hw/i40iw/i40iw_cm.h
index 6e43e4d..839966a 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.h
@@ -291,7 +291,7 @@ struct i40iw_cm_listener {
 	u32 loc_addr[4];
 	u16 loc_port;
 	struct iw_cm_id *cm_id;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	struct i40iw_device *iwdev;
 	atomic_t pend_accepts_cnt;
 	int backlog;
-- 
2.7.4

