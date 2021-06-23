Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97DF3B1637
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFWIxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 04:53:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWIxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Jun 2021 04:53:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G8xg30XL1zXkDT;
        Wed, 23 Jun 2021 16:45:35 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 16:50:31 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 23 Jun 2021 16:50:31 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Fix incorrect vlan enable bit in QPC
Date:   Wed, 23 Jun 2021 16:50:01 +0800
Message-ID: <1624438201-11915-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The QPC_RQ/SQ_VLAN_EN bit in QPC should be enabled, not the QPC mask.

Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3c35ae4..fc985d6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4676,9 +4676,9 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	/* Only HIP08 needs to set the vlan_en bits in QPC */
 	if (vlan_id < VLAN_N_VID &&
 	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
-		hr_reg_enable(qpc_mask, QPC_RQ_VLAN_EN);
+		hr_reg_enable(context, QPC_RQ_VLAN_EN);
 		hr_reg_clear(qpc_mask, QPC_RQ_VLAN_EN);
-		hr_reg_enable(qpc_mask, QPC_SQ_VLAN_EN);
+		hr_reg_enable(context, QPC_SQ_VLAN_EN);
 		hr_reg_clear(qpc_mask, QPC_SQ_VLAN_EN);
 	}
 
-- 
2.7.4

