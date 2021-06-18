Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963853AC87A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhFRKNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:13:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7368 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhFRKNA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:13:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5vj41Hznz6yk9;
        Fri, 18 Jun 2021 18:06:48 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:10:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 06/10] RDMA/hns: Clean definitions of EQC structure
Date:   Fri, 18 Jun 2021 18:10:16 +0800
Message-ID: <1624011020-16992-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Remove unused members in EQ context structure.

Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd361c0..8eb392b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1729,21 +1729,6 @@ struct hns_roce_v2_priv {
 	struct hns_roce_link_table ext_llm;
 };
 
-struct hns_roce_eq_context {
-	__le32	byte_4;
-	__le32	byte_8;
-	__le32	byte_12;
-	__le32	eqe_report_timer;
-	__le32	eqe_ba0;
-	__le32	eqe_ba1;
-	__le32	byte_28;
-	__le32	byte_32;
-	__le32	byte_36;
-	__le32	byte_40;
-	__le32	byte_44;
-	__le32	rsv[5];
-};
-
 struct hns_roce_dip {
 	u8 dgid[GID_LEN_V2];
 	u8 dip_idx;
@@ -1805,6 +1790,10 @@ struct hns_roce_dip {
 #define HNS_ROCE_V2_VF_ABN_INT_CFG_M GENMASK(2, 0)
 #define HNS_ROCE_V2_VF_EVENT_INT_EN_M GENMASK(0, 0)
 
+struct hns_roce_eq_context {
+	__le32	data[16];
+};
+
 #define EQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_eq_context, h, l)
 
 #define EQC_EQ_ST EQC_FIELD_LOC(1, 0)
-- 
2.7.4

