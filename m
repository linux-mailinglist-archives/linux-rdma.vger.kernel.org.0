Return-Path: <linux-rdma+bounces-309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C088086F4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A91F20FD8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FB39AC7;
	Thu,  7 Dec 2023 11:46:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0AAD54;
	Thu,  7 Dec 2023 03:46:11 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmC6L6rCvzShxH;
	Thu,  7 Dec 2023 19:41:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 19:46:08 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 3/5] RDMA/hns: Add a max length of gid table
Date: Thu, 7 Dec 2023 19:42:29 +0800
Message-ID: <20231207114231.2872104-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
References: <20231207114231.2872104-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
index 4258b6daaded..93a71db527d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2060,6 +2060,7 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 /* Apply all loaded caps before setting to hardware */
 static void apply_func_caps(struct hns_roce_dev *hr_dev)
 {
+#define MAX_GID_TBL_LEN 256
 	struct hns_roce_caps *caps = &hr_dev->caps;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
@@ -2095,8 +2096,14 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
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


