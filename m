Return-Path: <linux-rdma+bounces-135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502647FD329
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EDA282F7B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1418E2E;
	Wed, 29 Nov 2023 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4811819B6;
	Wed, 29 Nov 2023 01:48:10 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SgDyJ70R0zvR9X;
	Wed, 29 Nov 2023 17:47:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:08 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 3/6] RDMA/hns: Add a max length of gid table
Date: Wed, 29 Nov 2023 17:44:31 +0800
Message-ID: <20231129094434.134528-4-huangjunxian6@hisilicon.com>
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

IB-core and rdma-core restrict the sgid_index specified by users,
which is uint8_t/u8 data type, to only be within the range of 0-255,
so it's meaningless to support excessively large gid_table_len.

On the other hand, ib-core creates as many sysfs gid files as
gid_table_len, most of which are not only useless because of the
reason above, but also greatly increase the traversal time of
the sysfs gid files for applications.

This patch limits the maximum length of gid table to 256.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 1ceeedfa225f..8126922b4e21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2055,6 +2055,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 /* Apply all loaded caps before setting to hardware */
 static void apply_func_caps(struct hns_roce_dev *hr_dev)
 {
+#define MAX_GID_TBL_LEN 256
 	struct hns_roce_caps *caps = &hr_dev->caps;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
@@ -2090,8 +2091,14 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
 
 		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gid_table_len[0] = caps->gmv_bt_num *
-					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
+
+		/* It's meaningless to support excessively large gid_table_len,
+		 * as the type of sgid_index in kernel struct ib_global_route
+		 * and userspace struct ibv_global_route are u8/uint8_t (0-255).
+		 */
+		caps->gid_table_len[0] = min_t(u32, MAX_GID_TBL_LEN,
+					 caps->gmv_bt_num *
+					 (HNS_HW_PAGE_SIZE / caps->gmv_entry_sz));
 
 		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
 							  caps->gmv_entry_sz);
-- 
2.30.0


