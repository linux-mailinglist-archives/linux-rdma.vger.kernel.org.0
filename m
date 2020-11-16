Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAD2B42E9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 12:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgKPLfM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 06:35:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7910 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKPLfM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 06:35:12 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZRnY0TyPz6wmK;
        Mon, 16 Nov 2020 19:34:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 19:35:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/7] RDMA/hns: Fix missing fields in address vector
Date:   Mon, 16 Nov 2020 19:33:23 +0800
Message-ID: <1605526408-6936-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Traffic class and hop limit in address vector is not assigned from GRH, but
it will be filled into UD SQ WQE. So the hardware will get a wrong value.

Fixes: 82e620d9c3a0 ("RDMA/hns: Modify the data structure of hns_roce_av")
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3be80d4..d65ff6a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -64,18 +64,20 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
 
-	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
-
 	ah->av.port = rdma_ah_get_port_num(ah_attr);
 	ah->av.gid_index = grh->sgid_index;
 
 	if (rdma_ah_get_static_rate(ah_attr))
 		ah->av.stat_rate = IB_RATE_10_GBPS;
 
-	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
-	ah->av.sl = rdma_ah_get_sl(ah_attr);
+	ah->av.hop_limit = grh->hop_limit;
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
+	ah->av.tclass = grh->traffic_class;
+
+	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
+	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
 	/* HIP08 needs to record vlan info in Address Vector */
 	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08) {
-- 
2.8.1

