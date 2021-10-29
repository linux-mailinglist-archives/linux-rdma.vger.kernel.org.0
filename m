Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B14243FA80
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJ2KMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 06:12:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14879 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJ2KM3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Oct 2021 06:12:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HgdTF15tGz90WX;
        Fri, 29 Oct 2021 18:09:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 18:09:58 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 18:09:57 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Modify the value of MAX_LP_MSG_LEN to meet hardware compatibility
Date:   Fri, 29 Oct 2021 18:05:37 +0800
Message-ID: <20211029100537.27299-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The upper limit of MAX_LP_MSG_LEN on HIP08 is 64K, and the upper limit on
HIP09 is 16K. Regardless of whether it is HIP08 or HIP09, only 16K will be
used. In order to ensure compatibility, it is unified to 16K.

Setting MAX_LP_MSG_LEN to 16K will not cause the performance loss of HIP08.

Fixes: fbed9d2be292 ("RDMA/hns: Fix configuration of ack_req_freq in QPC")
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d5f3faa1627a..3453b15cb391 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4399,8 +4399,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	mtu = ib_mtu_enum_to_int(ib_mtu);
 	if (WARN_ON(mtu <= 0))
 		return -EINVAL;
-#define MAX_LP_MSG_LEN 65536
-	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
+#define MAX_LP_MSG_LEN 16384
+	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 16KB */
 	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
 	if (WARN_ON(lp_pktn_ini >= 0xF))
 		return -EINVAL;
--
2.33.0

