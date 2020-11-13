Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB52B15E6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 07:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgKMGlU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 01:41:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8080 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKMGlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 01:41:18 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXTPp0Ps6zLxvd;
        Fri, 13 Nov 2020 14:41:02 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 13 Nov 2020 14:41:13 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <mike.marciniszyn@cornelisnetworks.com>,
        <dennis.dalessandro@cornelisnetworks.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>, <sadanand.warrier@intel.com>,
        <grzegorz.andrejczuk@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] IB/hfi1: fix error return code in hfi1_init_dd()
Date:   Fri, 13 Nov 2020 14:42:27 +0800
Message-ID: <1605249747-17942-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 4730f4a6c6b2 ("IB/hfi1: Activate the dummy netdev")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 7eaf9953..c87b94e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -15245,7 +15245,8 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 		    & CCE_REVISION_SW_MASK);
 
 	/* alloc netdev data */
-	if (hfi1_netdev_alloc(dd))
+	ret = hfi1_netdev_alloc(dd);
+	if (ret)
 		goto bail_cleanup;
 
 	ret = set_up_context_variables(dd);
-- 
2.9.5

