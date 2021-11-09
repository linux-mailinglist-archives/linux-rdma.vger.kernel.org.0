Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537B344ADB6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbhKIMsj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27190 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbhKIMsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:23 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HpSMt5Zc3z8v11;
        Tue,  9 Nov 2021 20:43:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 3/7] libhns: Remove redundant variable initialization
Date:   Tue, 9 Nov 2021 20:40:59 +0800
Message-ID: <20211109124103.54326-4-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109124103.54326-1-liangwenpeng@huawei.com>
References: <20211109124103.54326-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The variable of owner_bit has been assigned before the reference, so there
is no need to initialize.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 1e8df6ef..31a0681d 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -1375,9 +1375,9 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *cq, uint32_t qpn,
 {
 	int nfreed = 0;
 	bool is_recv_cqe;
+	uint8_t owner_bit;
 	uint16_t wqe_index;
 	uint32_t prod_index;
-	uint8_t owner_bit = 0;
 	struct hns_roce_v2_cqe *cqe, *dest;
 	struct hns_roce_context *ctx = to_hr_ctx(cq->ibv_cq.context);
 
-- 
2.33.0

