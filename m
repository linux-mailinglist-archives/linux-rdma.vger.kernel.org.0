Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F087675
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfHIJp2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfHIJp2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB39030FE410BB3BE2B9;
        Fri,  9 Aug 2019 17:45:26 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:19 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/9] RDMA/hns: Logic optimization of wc_flags
Date:   Fri, 9 Aug 2019 17:40:58 +0800
Message-ID: <1565343666-73193-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

We should set IB_WC_WITH_VLAN only when VLAN is enabled.
In addition, move setting of IB_WC_WITH_SMAC below
setting of wc->smac.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 87a1574..7a14f0b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2860,15 +2860,16 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		wc->smac[5] = roce_get_field(cqe->byte_28,
 					     V2_CQE_BYTE_28_SMAC_5_M,
 					     V2_CQE_BYTE_28_SMAC_5_S);
+		wc->wc_flags |= IB_WC_WITH_SMAC;
 		if (roce_get_bit(cqe->byte_28, V2_CQE_BYTE_28_VID_VLD_S)) {
 			wc->vlan_id = (u16)roce_get_field(cqe->byte_28,
 							  V2_CQE_BYTE_28_VID_M,
 							  V2_CQE_BYTE_28_VID_S);
+			wc->wc_flags |= IB_WC_WITH_VLAN;
 		} else {
 			wc->vlan_id = 0xffff;
 		}
 
-		wc->wc_flags |= (IB_WC_WITH_VLAN | IB_WC_WITH_SMAC);
 		wc->network_hdr_type = roce_get_field(cqe->byte_28,
 						    V2_CQE_BYTE_28_PORT_TYPE_M,
 						    V2_CQE_BYTE_28_PORT_TYPE_S);
-- 
1.9.1

