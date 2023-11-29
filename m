Return-Path: <linux-rdma+bounces-133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DC7FD327
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 10:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A6B1C21006
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8F418E23;
	Wed, 29 Nov 2023 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150219BA;
	Wed, 29 Nov 2023 01:48:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SgDy46qc4zWhsd;
	Wed, 29 Nov 2023 17:47:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:08 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 4/6] RDMA/hns: Remove unnecessary checks for NULL in mtr_alloc_bufs()
Date: Wed, 29 Nov 2023 17:44:32 +0800
Message-ID: <20231129094434.134528-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected

From: Chengchang Tang <tangchengchang@huawei.com>

ib_umem_get() never return NULL.

Fixes: 3c873161a0d7 ("RDMA/hns: Add support for addressing when hopnum is 0")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 14376490ac22..e71988a6c277 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -674,7 +674,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->kmem = NULL;
 		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
-		if (IS_ERR_OR_NULL(mtr->umem)) {
+		if (IS_ERR(mtr->umem)) {
 			ibdev_err(ibdev, "failed to get umem, ret = %ld.\n",
 				  PTR_ERR(mtr->umem));
 			return -ENOMEM;
-- 
2.30.0


