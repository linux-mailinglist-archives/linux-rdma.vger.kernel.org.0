Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A429480583
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 02:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhL1Bja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Dec 2021 20:39:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32305 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232933AbhL1Bja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Dec 2021 20:39:30 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A+67MA6MQyhPLZznvrR05lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVO+3Toh3zwOmzNLW2nSaKyMNzHwLYslb43io04G7ZfXm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79CAmj/HQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gnbPMcpuSXfhBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlI3DjfD+sgB4LDXo3O5NlFz?=
 =?us-ascii?q?HE8i94mNfTRaOIfdztjbR2GaBpKUn8TCZQjjKKri2P5fjlwtl2Yv+w07nLVwQg?=
 =?us-ascii?q?316LiWPLRe9qXVYBPkkORjnzJ8n6/ARwAMtGbjz2f/RqEhODAtTH6VZofUraxn?=
 =?us-ascii?q?sOGKnX7Knc7UUVQDAXk56LizBPWZj6WEGRMkgJGkET43BXDogHBYiCF?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArUOV6K+sPtGT5ha5jXVuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119626387"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 09:39:28 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id ACCD34D11981;
        Tue, 28 Dec 2021 09:39:25 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 09:39:23 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 09:39:23 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2] RDMA/rxe: Prevent from double freeing rxe_map_set
Date:   Tue, 28 Dec 2021 09:44:06 +0800
Message-ID: <20211228014406.1033444-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ACCD34D11981.AD0F5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

a same rxe_map_set could be freed twice:
rxe_reg_user_mr()
  -> rxe_mr_init_user()
    -> rxe_mr_free_map_set() # 1st
  -> rxe_drop_ref()
   ...
    -> rxe_mr_cleanup()
      -> rxe_mr_free_map_set() # 2nd

By convention, we should cleanup/free resources in the error path in the
same function where the resources are alloted in. So rxe_mr_init_user()
doesn't need to free the map_set directly.

In addition, we have to reset map_set to NULL inside rxe_mr_alloc() if needed
to prevent from map_set being double freed in rxe_mr_cleanup().

CC: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: Fix it by a simpler way by following suggestion from Bob,
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 25c78aade822..7c4cd19a9db2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -141,6 +141,7 @@ static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf, int both)
 		ret = rxe_mr_alloc_map_set(num_map, &mr->next_map_set);
 		if (ret) {
 			rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+			mr->cur_map_set = NULL;
 			goto err_out;
 		}
 	}
@@ -214,7 +215,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 				pr_warn("%s: Unable to get virtual address\n",
 						__func__);
 				err = -ENOMEM;
-				goto err_cleanup_map;
+				goto err_release_umem;
 			}
 
 			buf->addr = (uintptr_t)vaddr;
@@ -237,8 +238,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	return 0;
 
-err_cleanup_map:
-	rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
-- 
2.31.1



