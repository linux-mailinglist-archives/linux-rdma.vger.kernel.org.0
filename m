Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595536A6AD
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 12:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhDYKcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 06:32:25 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35432 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhDYKcY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 06:32:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UWgfLgy_1619346697;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWgfLgy_1619346697)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:31:43 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] IB/hfi1: Remove redundant variable rcd
Date:   Sun, 25 Apr 2021 18:31:36 +0800
Message-Id: <1619346696-46300-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variable rcd is being assigned a value from a calculation
however the variable is never read, so this redundant variable
can be removed.

Cleans up the following clang-analyzer warning:

drivers/infiniband/hw/hfi1/affinity.c:986:3: warning: Value stored to
'rcd' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 04b1e8f..ae9a335 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -983,7 +983,6 @@ void hfi1_put_irq_affinity(struct hfi1_devdata *dd,
 			set = &entry->rcv_intr;
 		break;
 	case IRQ_NETDEVCTXT:
-		rcd = (struct hfi1_ctxtdata *)msix->arg;
 		set = &entry->def_intr;
 		break;
 	default:
-- 
1.8.3.1

