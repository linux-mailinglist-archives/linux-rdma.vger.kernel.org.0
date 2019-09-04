Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9FA792F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfIDDSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbfIDDSK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Sep 2019 23:18:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 84212735003A7BA7CA15;
        Wed,  4 Sep 2019 11:18:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Sep 2019 11:17:59 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/5] RDMA/hns: remove a redundant le16_to_cpu
Date:   Wed, 4 Sep 2019 11:14:41 +0800
Message-ID: <1567566885-23088-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
References: <1567566885-23088-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Type of ah->av.vlan is u16, there will be a problem using le16_to_cpu
on it.

Fixes: 82e620d9c3a0 ("RDMA/hns: Modify the data structure of hns_roce_av")

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..c5ab8ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -389,7 +389,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_36,
 				       V2_UD_SEND_WQE_BYTE_36_VLAN_M,
 				       V2_UD_SEND_WQE_BYTE_36_VLAN_S,
-				       le16_to_cpu(ah->av.vlan));
+				       ah->av.vlan);
 			roce_set_field(ud_sq_wqe->byte_36,
 				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
 				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S,
-- 
2.8.1

