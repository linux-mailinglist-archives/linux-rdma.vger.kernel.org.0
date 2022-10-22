Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF6B6084CB
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Oct 2022 07:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJVFxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Oct 2022 01:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVFxY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Oct 2022 01:53:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238762B3AE8;
        Fri, 21 Oct 2022 22:53:21 -0700 (PDT)
X-QQ-mid: bizesmtp80t1666417985tjvg6z3n
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:53:04 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: hJ5650VbgwC7J77blxpVd/JATB4c/kIfYW4f2vdGNSqa7KR7MRH2RZ4r7TteQ
        IMMUIXOwK/2GcSzF4YGOeg7D8ExiFucvasHeXjSf+s1s/hHuJvHXJNuRSioG1GaPunJzYGy
        jkARupyVNPeOdfbz6NllbAo1gAnbzDSk2dlbGXAqclOs2KGL6cSqMvfqDvgbA0HvfrZXwVw
        hWUmyWnYcTKYuUKUC2FFVwZX9JBGOz/4kbIDkA0AoxWSu9QuFN1PW0yLY372+ObfADmltNr
        h5nffw68OK4MkVYihqCQ70dQbkSEHdCYXhbgDLOo0/FCNkrR9oCvQ/vnSHnxhHcHZ5A3vAl
        0/VhOy1cKG2KcsQ85zTYBv7e5GSU+uvMThDkwNb76BzL5JXxGxfllFAAfTsVw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mkalderon@marvell.com, aelior@marvell.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] infiniband/hw: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:52:57 +0800
Message-Id: <20221022055257.42905-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/qedr/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5152f10d2e6d..5e7069b76d46 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -472,7 +472,7 @@ static irqreturn_t qedr_irq_handler(int irq, void *handle)
 		/* The CQ's CNQ notification counter is checked before
 		 * destroying the CQ in a busy-wait loop that waits for all of
 		 * the CQ's CNQ interrupts to be processed. It is increased
-		 * here, only after the completion handler, to ensure that the
+		 * here, only after the completion handler, to ensure that
 		 * the handler is not running when the CQ is destroyed.
 		 */
 		cq->cnq_notif++;
-- 
2.36.1


