Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671DF46612D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhLBKLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 05:11:34 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50105 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhLBKLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 05:11:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UzAdH2e_1638439685;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UzAdH2e_1638439685)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 18:08:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bmt@zurich.ibm.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] RDMA/siw: Use max() instead of doing it manually
Date:   Thu,  2 Dec 2021 18:07:59 +0800
Message-Id: <1638439679-114250-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix following coccicheck warning:

./drivers/infiniband/sw/siw/siw_verbs.c:665:28-29: WARNING opportunity
for max().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index d15a1f9..a3dd2cb 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -662,7 +662,7 @@ static int siw_copy_inline_sgl(const struct ib_send_wr *core_wr,
 		kbuf += core_sge->length;
 		core_sge++;
 	}
-	sqe->sge[0].length = bytes > 0 ? bytes : 0;
+	sqe->sge[0].length = max(bytes, 0);
 	sqe->num_sge = bytes > 0 ? 1 : 0;
 
 	return bytes;
-- 
1.8.3.1

