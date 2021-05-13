Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8100D37F695
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhEMLRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 07:17:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2720 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhEMLRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 07:17:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fgpty3SMqz1BM5d;
        Thu, 13 May 2021 19:13:46 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 19:16:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Remove unused CMDQ member
Date:   Thu, 13 May 2021 19:16:18 +0800
Message-ID: <1620904578-29829-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The hcr_mutex was used to serialize mailbox post. Now that mailbox supports
concurrency, this variable is no longer useful.

Fixes: a389d016c030 ("RDMA/hns: Enable all CMDQ context")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 97800d2..90135dd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -555,7 +555,6 @@ struct hns_roce_cmd_context {
 
 struct hns_roce_cmdq {
 	struct dma_pool		*pool;
-	struct mutex		hcr_mutex;
 	struct semaphore	poll_sem;
 	/*
 	 * Event mode: cmd register mutex protection,
-- 
2.7.4

