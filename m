Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736D34F654
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 03:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCaBoA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 21:44:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14647 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCaBno (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 21:43:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F98Cz16rnzmbkG;
        Wed, 31 Mar 2021 09:41:03 +0800 (CST)
Received: from ubuntu180.huawei.com (10.175.100.227) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 09:43:27 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <tangyizhou@huawei.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] RDMA/iw_cxgb4: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 31 Mar 2021 10:01:05 +0800
Message-ID: <20210331020105.4858-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.100.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 81903749d241..c97e84d5db74 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -145,7 +145,7 @@ static void connect_reply_upcall(struct c4iw_ep *ep, int status);
 static int sched(struct c4iw_dev *dev, struct sk_buff *skb);
 
 static LIST_HEAD(timeout_list);
-static spinlock_t timeout_lock;
+static DEFINE_SPINLOCK(timeout_lock);
 
 static void deref_cm_id(struct c4iw_ep_common *epc)
 {
@@ -4451,7 +4451,6 @@ c4iw_handler_func c4iw_handlers[NUM_CPL_CMDS] = {
 
 int __init c4iw_cm_init(void)
 {
-	spin_lock_init(&timeout_lock);
 	skb_queue_head_init(&rxq);
 
 	workq = alloc_ordered_workqueue("iw_cxgb4", WQ_MEM_RECLAIM);

