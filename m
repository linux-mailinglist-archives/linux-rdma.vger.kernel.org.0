Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A124194B5
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhI0NBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 09:01:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12854 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhI0NBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 09:01:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJ2g70M79z8yqt;
        Mon, 27 Sep 2021 20:55:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 21:00:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc 1/2] RDMA/hns: Fix the size setting error when copying CQE in clean_cq()
Date:   Mon, 27 Sep 2021 20:55:56 +0800
Message-ID: <20210927125557.15031-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927125557.15031-1-liangwenpeng@huawei.com>
References: <20210927125557.15031-1-liangwenpeng@huawei.com>
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

The size of CQE is different for different versions of hardware, so the
driver needs to specify the size of CQE explicitly.

Fixes: 09a5f210f67e ("RDMA/hns: Add support for CQE in size of 64 Bytes")
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a9c00a2e8ebd..d5f3faa1627a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3299,7 +3299,7 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 			dest = get_cqe_v2(hr_cq, (prod_index + nfreed) &
 					  hr_cq->ib_cq.cqe);
 			owner_bit = hr_reg_read(dest, CQE_OWNER);
-			memcpy(dest, cqe, sizeof(*cqe));
+			memcpy(dest, cqe, hr_cq->cqe_size);
 			hr_reg_write(dest, CQE_OWNER, owner_bit);
 		}
 	}
-- 
2.33.0

