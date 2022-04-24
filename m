Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E581350D063
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Apr 2022 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiDXIEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Apr 2022 04:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiDXIEI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Apr 2022 04:04:08 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E165D35
        for <linux-rdma@vger.kernel.org>; Sun, 24 Apr 2022 01:01:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VB.xF3A_1650787264;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VB.xF3A_1650787264)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 16:01:04 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org, BMT@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com
Subject: [PATCH] RDMA/siw: Fix a condition race issue in MPA request processing
Date:   Sun, 24 Apr 2022 16:01:03 +0800
Message-Id: <d528d83466c44687f3872eadcb8c184528b2e2d4.1650526554.git.chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The calling of siw_cm_upcall and detaching new_cep with its
listen_cep should be atomistic semantics. Otherwise siw_reject
may be called in a temporary state, e,g, siw_cm_upcall is called
but the new_cep->listen_cep has not being cleared.

This will generate a WARN in dmesg, which reported in:
https://lore.kernel.org/all/Yliu2ROIh0nLk5l0@bombadil.infradead.org/

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7acdd3c3a599..17f34d584cd9 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -968,14 +968,15 @@ static void siw_accept_newconn(struct siw_cep *cep)
 
 		siw_cep_set_inuse(new_cep);
 		rv = siw_proc_mpareq(new_cep);
-		siw_cep_set_free(new_cep);
-
 		if (rv != -EAGAIN) {
 			siw_cep_put(cep);
 			new_cep->listen_cep = NULL;
-			if (rv)
+			if (rv) {
+				siw_cep_set_free(new_cep);
 				goto error;
+			}
 		}
+		siw_cep_set_free(new_cep);
 	}
 	return;
 
-- 
2.32.0 (Apple Git-132)

