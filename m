Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4F3F7234
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhHYJrx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 05:47:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14417 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbhHYJrx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 05:47:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GvgyX0WzzzbddR;
        Wed, 25 Aug 2021 17:43:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:47:03 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Bugfix for data type of dip_idx
Date:   Wed, 25 Aug 2021 17:43:10 +0800
Message-ID: <1629884592-23424-2-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
References: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Junxian Huang <huangjunxian4@hisilicon.com>

dip_idx is associated with qp_num whose data type is u32. However, dip_idx
is incorrectly defined as u8 data in the hns_roce_dip struct, which leads
to data truncation during value assignment.

Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")

Signed-off-by: Junxian Huang <huangjunxian4@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 54c1223..0b91a1a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1441,7 +1441,7 @@ struct hns_roce_v2_priv {
 
 struct hns_roce_dip {
 	u8 dgid[GID_LEN_V2];
-	u8 dip_idx;
+	u32 dip_idx;
 	struct list_head node;	/* all dips are on a list */
 };
 
-- 
2.8.1

