Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A542BB95
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhJMJdS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 05:33:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28931 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhJMJdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Oct 2021 05:33:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTnGr5S9Dzbn7r;
        Wed, 13 Oct 2021 17:26:44 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:31:08 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 17:31:07 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <markzhang@nvidia.com>, <liangwenpeng@huawei.com>,
        <liweihang@huawei.com>, <haakon.bugge@oracle.com>,
        <rolandd@cisco.com>, <sean.hefty@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] IB/cm: Fix possible use-after-free in ib_cm_cleanup()
Date:   Wed, 13 Oct 2021 17:30:16 +0800
Message-ID: <20211013093016.3869299-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This module's remove path calls cancel_delayed_work(). However, that
function does not wait until the work function finishes. This means
that the callback function may still be running after the driver's
remove function has finished, which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
the work is properly cancelled, no longer running, and unable
to re-schedule itself.

Fixes: 8575329d4f85 ("IB/cm: Fix timewait crash after module unload")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c903b74f46a4..ae0af63f3271 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -4508,7 +4508,7 @@ static void __exit ib_cm_cleanup(void)
 
 	spin_lock_irq(&cm.lock);
 	list_for_each_entry(timewait_info, &cm.timewait_list, list)
-		cancel_delayed_work(&timewait_info->work.work);
+		cancel_delayed_work_sync(&timewait_info->work.work);
 	spin_unlock_irq(&cm.lock);
 
 	ib_unregister_client(&cm_client);
-- 
2.25.1

