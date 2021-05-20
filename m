Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2171B389C2B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 05:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETD4F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 23:56:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3599 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhETD4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 23:56:04 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Flwl40nkgzQpBN;
        Thu, 20 May 2021 11:51:12 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:54:42 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 20 May 2021 11:54:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 3/3] RDMA/hns: Remove unused CMDQ member
Date:   Thu, 20 May 2021 11:54:36 +0800
Message-ID: <1621482876-35780-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
References: <1621482876-35780-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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

