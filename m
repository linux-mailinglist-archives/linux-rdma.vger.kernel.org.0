Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8918B6C1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgCSN3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 09:29:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729732AbgCSN3H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 09:29:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C2074CB23DD5504A70F;
        Thu, 19 Mar 2020 21:28:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 21:28:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 07/11] RDMA/hns: Remove definition of cq doorbell structure
Date:   Thu, 19 Mar 2020 21:24:54 +0800
Message-ID: <1584624298-23841-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The struct hns_roce_v2_cq_db is unused, it should be removed.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 83e94df..7c99953 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1056,11 +1056,6 @@ struct hns_roce_v2_mpt_entry {
 #define V2_DB_PARAMETER_SL_S 16
 #define V2_DB_PARAMETER_SL_M GENMASK(18, 16)
 
-struct hns_roce_v2_cq_db {
-	__le32	byte_4;
-	__le32	parameter;
-};
-
 #define	V2_CQ_DB_BYTE_4_TAG_S 0
 #define V2_CQ_DB_BYTE_4_TAG_M GENMASK(23, 0)
 
-- 
2.8.1

