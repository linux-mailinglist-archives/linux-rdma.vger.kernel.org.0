Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CF2258E53
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIAMkz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 08:40:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbgIAMk2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 08:40:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F06B3C8AB6544DE0B30;
        Tue,  1 Sep 2020 20:40:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 20:39:57 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/core: Fix unsafe linked list traversal after failing to allocate CQ
Date:   Tue, 1 Sep 2020 20:38:55 +0800
Message-ID: <1598963935-32335-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

It's not safe to access the next CQ in list_for_each_entry() after invoking
ib_free_cq(), because the CQ has already been freed in current iteration.
It should be replaced by list_for_each_entry_safe().

Fixes: c7ff819aefea ("RDMA/core: Introduce shared CQ pool API")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/core/cq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 513825e..a92fc3f 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -379,7 +379,7 @@ static int ib_alloc_cqs(struct ib_device *dev, unsigned int nr_cqes,
 {
 	LIST_HEAD(tmp_list);
 	unsigned int nr_cqs, i;
-	struct ib_cq *cq;
+	struct ib_cq *cq, *n;
 	int ret;
 
 	if (poll_ctx > IB_POLL_LAST_POOL_TYPE) {
@@ -412,7 +412,7 @@ static int ib_alloc_cqs(struct ib_device *dev, unsigned int nr_cqes,
 	return 0;
 
 out_free_cqs:
-	list_for_each_entry(cq, &tmp_list, pool_entry) {
+	list_for_each_entry_safe(cq, n, &tmp_list, pool_entry) {
 		cq->shared = false;
 		ib_free_cq(cq);
 	}
-- 
2.8.1

