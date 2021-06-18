Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0973AC864
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhFRKJA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 06:09:00 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhFRKIn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 06:08:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5vdN05C6zZgD6;
        Fri, 18 Jun 2021 18:03:36 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 18:06:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v4 for-next 2/8] RDMA/hns: Add a check to ensure integer mtu is positive
Date:   Fri, 18 Jun 2021 18:05:59 +0800
Message-ID: <1624010765-1029-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

GCC may reports an running time assert error when a value calculated from
ib_mtu_enum_to_int() is using as 'val' in FIELD_PREDP:

include/linux/compiler_types.h:328:38: error: call to
'__compiletime_assert_1524' declared with attribute error: FIELD_PREP:
value too large for the field

So a check is added about whether integer mtu from ib_mtu_enum_to_int() is
negative to avoid this warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6452ccc..0938e00 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4412,12 +4412,13 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t trrl_ba;
 	dma_addr_t irrl_ba;
-	enum ib_mtu mtu;
+	enum ib_mtu ib_mtu;
 	u8 lp_pktn_ini;
 	u64 *mtts;
 	u8 *dmac;
 	u8 *smac;
 	u32 port;
+	int mtu;
 	int ret;
 
 	ret = config_qp_rq_buf(hr_dev, hr_qp, context, qpc_mask);
@@ -4501,19 +4502,23 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, 0);
 
-	mtu = get_mtu(ibqp, attr);
-	hr_qp->path_mtu = mtu;
+	ib_mtu = get_mtu(ibqp, attr);
+	hr_qp->path_mtu = ib_mtu;
+
+	mtu = ib_mtu_enum_to_int(ib_mtu);
+	if (WARN_ON(mtu < 0))
+		return -EINVAL;
 
 	if (attr_mask & IB_QP_PATH_MTU) {
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-			       V2_QPC_BYTE_24_MTU_S, mtu);
+			       V2_QPC_BYTE_24_MTU_S, ib_mtu);
 		roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
 			       V2_QPC_BYTE_24_MTU_S, 0);
 	}
 
 #define MAX_LP_MSG_LEN 65536
 	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
-	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / ib_mtu_enum_to_int(mtu));
+	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
 
 	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
 		       V2_QPC_BYTE_56_LP_PKTN_INI_S, lp_pktn_ini);
-- 
2.7.4

