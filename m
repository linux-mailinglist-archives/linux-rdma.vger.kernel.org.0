Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43444ADB8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244542AbhKIMsl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27124 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbhKIMsY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:24 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HpSM94zb2z1DJGc;
        Tue,  9 Nov 2021 20:43:17 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 4/7] libhns: Fix wrong print format for unsigned type
Date:   Tue, 9 Nov 2021 20:41:00 +0800
Message-ID: <20211109124103.54326-5-liangwenpeng@huawei.com>
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

From: Xinhao Liu <liuxinhao5@hisilicon.com>

Change %d printf fortmat to %u for unsigned int variant.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 382d2bd7..c0069b8b 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -73,7 +73,7 @@ int hns_roce_u_query_device(struct ibv_context *context,
 	sub_minor = raw_fw_ver & 0xffff;
 
 	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
-		 "%d.%d.%03d", major, minor, sub_minor);
+		 "%u.%u.%03u", major, minor, sub_minor);
 
 	return 0;
 }
-- 
2.33.0

