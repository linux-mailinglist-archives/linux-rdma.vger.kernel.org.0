Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4071C35DAC1
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhDMJLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 05:11:33 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53953 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhDMJLc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 05:11:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVRVm4T_1618305065;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVRVm4T_1618305065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 17:11:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] RDMA/hw/qib/qib_iba7322: remove useless function
Date:   Tue, 13 Apr 2021 17:11:03 +0800
Message-Id: <1618305063-29007-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the following clang warning:

drivers/infiniband/hw/qib/qib_iba7322.c:803:19: warning: unused function
'qib_read_ureg' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/qib/qib_iba7322.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 9fe6ea7..3cb4429 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -791,28 +791,6 @@ static inline u32 qib_read_ureg32(const struct qib_devdata *dd,
 }
 
 /**
- * qib_read_ureg - read virtualized per-context register
- * @dd: device
- * @regno: register number
- * @ctxt: context number
- *
- * Return the contents of a register that is virtualized to be per context.
- * Returns -1 on errors (not distinguishable from valid contents at
- * runtime; we may add a separate error variable at some point).
- */
-static inline u64 qib_read_ureg(const struct qib_devdata *dd,
-				enum qib_ureg regno, int ctxt)
-{
-
-	if (!dd->kregbase || !(dd->flags & QIB_PRESENT))
-		return 0;
-	return readq(regno + (u64 __iomem *)(
-		(dd->ureg_align * ctxt) + (dd->userbase ?
-		 (char __iomem *)dd->userbase :
-		 (char __iomem *)dd->kregbase + dd->uregbase)));
-}
-
-/**
  * qib_write_ureg - write virtualized per-context register
  * @dd: device
  * @regno: register number
-- 
1.8.3.1

