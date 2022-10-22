Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0884F6084D3
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Oct 2022 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJVF7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Oct 2022 01:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJVF7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Oct 2022 01:59:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E7B7EE;
        Fri, 21 Oct 2022 22:59:27 -0700 (PDT)
X-QQ-mid: bizesmtp69t1666418352t5wmmn0u
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:59:11 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 8h/R1PcYcfgiE1H4ztnsaQPWVO9zlXO4DkC+uGg6VZsgLmWXeXadOs/CI6u5p
        npvrjGUuMu5X0ph5ug7/U2ZbQKolgT6VlG94USMw3qbGUv5KmiMPTtHHNYkXnYMLgGmdHai
        Cz0chZXsu4lVm9/Y7pq+n6A+3u2mBeIvGw/CR+P9UMg6zTKbLgiRT5D6fgV6NzTe9LIbHjx
        ggWfFUUMJuRD9eSljuX2vNN+i4LoiQeB3DY9STSETuLRSDvDrvcZ40rpHu7p86fQQ1pkwen
        gvjEhUdZT3jR7nsKP6DvC0gmyE0gMzUBKNBEP6rKnzpkCPYbLPS+QTwRqVMJGPHJVklyCQQ
        6L4JrLFE497rw5lxcUGvmR/hfl1DJJREImxtiihFVEbodcgcrhKP+pLKIFRUQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] hw/qib: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:59:05 +0800
Message-Id: <20221022055905.49176-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index bf2f30d67949..9fe03d6ffac1 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -851,7 +851,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		/*
-		 * This assignment is a bit strange.  it's because the
+		 * This assignment is a bit strange.  it's because
 		 * the pbc counts the number of 32 bit words in the full
 		 * packet _except_ the first word of the pbc itself...
 		 */
-- 
2.36.1

