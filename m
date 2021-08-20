Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0B3F2A3E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhHTKng (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 06:43:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57824 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229847AbhHTKng (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Aug 2021 06:43:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArnD8KqmWfMrP9Jn4QTnd66ryP+DpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,337,1620662400"; 
   d="scan'208";a="113188674"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 Aug 2021 18:42:57 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id F2EC54D0D4BE;
        Fri, 20 Aug 2021 18:42:55 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 18:42:56 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 Aug 2021 18:42:55 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <aglo@umich.edu>, <rpearsonhpe@gmail.com>, <zyjzyj2000@gmail.com>,
        <jgg@nvidia.com>, <leon@kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Date:   Fri, 20 Aug 2021 19:15:09 +0800
Message-ID: <20210820111509.172500-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F2EC54D0D4BE.AB6B6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1) New index member of struct rxe_queue is introduced but not zeroed
   so the initial value of index may be random.
2) Current index is not masked off to index_mask.
In such case, producer_addr() and consumer_addr() will get an invalid
address by the random index and then accessing the invalid address
triggers the following panic:
"BUG: unable to handle page fault for address: ffff9ae2c07a1414"

Fix the issue by using kzalloc() to zero out index member.

Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 85b812586ed4..72d95398e604 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -63,7 +63,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 	if (*num_elem < 0)
 		goto err1;
 
-	q = kmalloc(sizeof(*q), GFP_KERNEL);
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (!q)
 		goto err1;
 
-- 
2.25.1



