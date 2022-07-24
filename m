Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264557F3D0
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Jul 2022 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiGXHoh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Jul 2022 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiGXHog (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Jul 2022 03:44:36 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1F13F70;
        Sun, 24 Jul 2022 00:44:31 -0700 (PDT)
X-QQ-mid: bizesmtp72t1658648655tmzdjpev
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:44:14 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: R3vftN8GVq/qDXrZgEQi06I7LENlcC8HMBZ/q+Bff9x5LZoGMCKlUqf47rDPl
        B+k3UVjF8GoFjkQJJByjZen5OVhVal+nbBr2Py0ZUTQW5n0sFkvRUw/ZYuheuuHivIVT5OK
        UuGz5HC3Lbqmk3K2BJG0gSZ486Wf62gumwvHGul5sJlEf4ZueG5Qv0hPTU9lW0BbUnGbi2w
        6iNEMjMyxoW0Q63kBT/7IkjBmk+HSIb+BBexYreKqjtbMbYEYeWHYWYcnc87f8JhPV2ug9j
        pBS+09K3FAEInL4ce9kU0O8rAIuL03/LIIMvxwhcnhYhEHvzokl5er69BUSnIOFb9aFiiZE
        GptgHVTrQnS9qk9kXmRV4q27Wu86mhFUvDjjbJUrv5JEPrZwPlFDWwteFdJvQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] hw/qib: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:44:07 +0800
Message-Id: <20220724074407.18552-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index 37b628a162e0..6af57067c32e 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -58,7 +58,7 @@ static void qib_set_ib_7220_lstate(struct qib_pportdata *, u16, u16);
 /*
  * This file contains almost all the chip-specific register information and
  * access functions for the QLogic QLogic_IB 7220 PCI-Express chip, with the
- * exception of SerDes support, which in in qib_sd7220.c.
+ * exception of SerDes support, which in qib_sd7220.c.
  */
 
 /* Below uses machine-generated qib_chipnum_regs.h file */
-- 
2.36.1

