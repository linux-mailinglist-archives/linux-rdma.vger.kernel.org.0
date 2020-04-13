Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA3C1A6324
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgDMGk5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgDMGk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Apr 2020 02:40:57 -0400
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5DC008673
        for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2020 23:40:55 -0700 (PDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5A70B7E314612ED15DA5;
        Mon, 13 Apr 2020 14:40:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 14:40:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/6] RDMA/hns: Optimize hns_roce_v2_set_mac()
Date:   Mon, 13 Apr 2020 14:40:38 +0800
Message-ID: <1586760042-40516-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
References: <1586760042-40516-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Removes the unnecessary memset opertaion and adjust style of some lines in
hns_roce_v2_set_mac().

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a580de9..6816278 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2427,12 +2427,9 @@ static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
 	reg_smac_l = *(u32 *)(&addr[0]);
 	reg_smac_h = *(u16 *)(&addr[4]);
 
-	memset(smac_tb, 0, sizeof(*smac_tb));
-	roce_set_field(smac_tb->tb_idx_rsv,
-		       CFG_SMAC_TB_IDX_M,
+	roce_set_field(smac_tb->tb_idx_rsv, CFG_SMAC_TB_IDX_M,
 		       CFG_SMAC_TB_IDX_S, phy_port);
-	roce_set_field(smac_tb->vf_smac_h_rsv,
-		       CFG_SMAC_TB_VF_SMAC_H_M,
+	roce_set_field(smac_tb->vf_smac_h_rsv, CFG_SMAC_TB_VF_SMAC_H_M,
 		       CFG_SMAC_TB_VF_SMAC_H_S, reg_smac_h);
 	smac_tb->vf_smac_l = cpu_to_le32(reg_smac_l);
 
-- 
2.8.1

