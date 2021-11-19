Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC04B457041
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhKSOJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:44 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14958 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhKSOJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:44 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hwdgy6Bc5zZd74;
        Fri, 19 Nov 2021 22:04:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 7/9] RDMA/hns: Add void conversion for function whose return value is not used
Date:   Fri, 19 Nov 2021 22:02:06 +0800
Message-ID: <20211119140208.40416-8-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

If the return value of the function is not used, then void should be added.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d8788819b827..978913fc7587 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1509,7 +1509,7 @@ static void hns_roce_free_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 	hr_reg_write(req_a, FUNC_RES_A_VF_ID, vf_id);
-	hns_roce_cmq_send(hr_dev, desc, 2);
+	(void)hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
 static void hns_roce_function_clear(struct hns_roce_dev *hr_dev)
-- 
2.33.0

