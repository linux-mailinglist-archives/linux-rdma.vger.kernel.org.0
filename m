Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979D67D7B7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfHAId3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbfHAId3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2702EA8B9D4FCCF376F9;
        Thu,  1 Aug 2019 16:33:23 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 1 Aug 2019 16:33:15 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 13/13] RDMA/hns: Disable alw_lcl_lpbk of SSU
Date:   Thu, 1 Aug 2019 16:29:14 +0800
Message-ID: <1564648154-123172-14-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
References: <1564648154-123172-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

If we enabled alw_lcl_lpbk in promiscuous mode, packet whose source
and destination mac address is equal will be handled in both inner
loopback and outer loopback. This will halve performance of roce in
promiscuous mode.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5cc64da..683765e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1308,7 +1308,7 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
 	desc.flag &= cpu_to_le16(~HNS_ROCE_CMD_FLAG_WR);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LPBK_S, 1);
-	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LCL_LPBK_S, 1);
+	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_LCL_LPBK_S, 0);
 	roce_set_bit(swt->cfg, VF_SWITCH_DATA_CFG_ALW_DST_OVRD_S, 1);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
-- 
1.9.1

