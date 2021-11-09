Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1FD44ADBB
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbhKIMsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 07:48:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15812 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbhKIMsZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 07:48:25 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HpSPS366Fz90xV;
        Tue,  9 Nov 2021 20:45:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 9 Nov 2021 20:45:30 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 6/7] libhns: The content of the header file should be protected with #define
Date:   Tue, 9 Nov 2021 20:41:02 +0800
Message-ID: <20211109124103.54326-7-liangwenpeng@huawei.com>
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

Header files should be protected with #define to prevent repeated
inclusion.

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u_db.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/providers/hns/hns_roce_u_db.h b/providers/hns/hns_roce_u_db.h
index b44e64d4..c3dd583a 100644
--- a/providers/hns/hns_roce_u_db.h
+++ b/providers/hns/hns_roce_u_db.h
@@ -30,13 +30,13 @@
  * SOFTWARE.
  */
 
+#ifndef _HNS_ROCE_U_DB_H
+#define _HNS_ROCE_U_DB_H
+
 #include <linux/types.h>
 
 #include "hns_roce_u.h"
 
-#ifndef _HNS_ROCE_U_DB_H
-#define _HNS_ROCE_U_DB_H
-
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define HNS_ROCE_PAIR_TO_64(val) ((uint64_t) val[1] << 32 | val[0])
 #elif __BYTE_ORDER == __BIG_ENDIAN
-- 
2.33.0

