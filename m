Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8794358200
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhDHLen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 07:34:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16837 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhDHLen (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 07:34:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJyV1bC9z7tyD;
        Thu,  8 Apr 2021 19:32:18 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:34:19 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <bvanassche@acm.org>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] RDMA/srpt: Fix error return code in srpt_cm_req_recv()
Date:   Thu, 8 Apr 2021 11:31:32 +0000
Message-ID: <20210408113132.87250-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: db7683d7deb2 ("IB/srpt: Fix login-related race conditions")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 98a393d..ea44780 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2382,6 +2382,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
 			dev_name(&sdev->device->dev), port_num);
 		mutex_unlock(&sport->mutex);
+		ret = -EINVAL;
 		goto reject;
 	}
 
-- 
2.9.4

