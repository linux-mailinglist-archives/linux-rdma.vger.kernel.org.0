Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794837521D
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 12:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhEFKQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 06:16:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55482 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhEFKQI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 06:16:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UXygmBf_1620296106;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UXygmBf_1620296106)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 18:15:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bvanassche@acm.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ib_srpt: Remove redundant assignment to ret
Date:   Thu,  6 May 2021 18:15:05 +0800
Message-Id: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variable 'ret' is set to -ENOMEM but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed

In 'commit b79fafac70fc ("target: make queue_tm_rsp() return void")'
srpt_queue_response() has been changed to return void, so after "goto
out", there is no need to return ret.

Clean up the following clang-analyzer warning:

drivers/infiniband/ulp/srpt/ib_srpt.c:2860:3: warning: Value stored to
'ret' is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index ea44780..3cadf12 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2858,7 +2858,6 @@ static void srpt_queue_response(struct se_cmd *cmd)
 			&ch->sq_wr_avail) < 0)) {
 		pr_warn("%s: IB send queue full (needed %d)\n",
 				__func__, ioctx->n_rdma);
-		ret = -ENOMEM;
 		goto out;
 	}
 
-- 
1.8.3.1

