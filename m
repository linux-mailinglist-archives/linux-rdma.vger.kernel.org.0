Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D73732B0E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjFPJHv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343975AbjFPJHf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 05:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A454C05;
        Fri, 16 Jun 2023 02:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF6763088;
        Fri, 16 Jun 2023 09:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FAFC433C8;
        Fri, 16 Jun 2023 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906351;
        bh=k/trZ96PiS/GWyCEHrmskygB7J0jtwXePPp4HjHDZMs=;
        h=From:To:Cc:Subject:Date:From;
        b=eyCArWvMCg3UlfRODXgh7mn1uAFFpqGklxVjDsJ3NtFTmFrnqgp4gFdsQtrLMjbJV
         LWmhz8d6m3mXtdAmx1e1UnYoXAmw9QMBSckNIN4bCOAtUKfTvfJb9hVcLBmj/dWWAf
         EsURUjUEvbMS0n2C+H/HczxpdGTnEW8nDZ4xlphguV62YaHfaQGeKCGcdlyn3IytfY
         W9VvWOAhcnWTyYky1PWcHfTYPjE189FHLbFcuvnuM2E6cLEceJI1NLeQZ/X6R9ZH94
         pi1ZZBy3JAyVmi9T0br3X+GgqCG4bOPChEVt55xrB0mtlHNK6FeUnF2Wf3WvXEUkk0
         ruk/1sAfTIbFA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [BUGREPORT] RDMA/bnxt_re: avoid unintialized variable use
Date:   Fri, 16 Jun 2023 11:05:40 +0200
Message-Id: <20230616090546.2555077-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added opcode variable is not initialized anywhere:

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:322:18: error: variable 'opcode' is uninitialized when used here [-Werror,-Wuninitialized]
        crsqe->opcode = opcode;

Not sure what the intention was here, but this is clearly pointless, so
instead use 0 in place of the variable.

Fixes: bcfee4ce3e013 ("RDMA/bnxt_re: remove redundant cmdq_bitmap")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is likely not the correct fix, so treat this as a bug report,
the patch is what I applied as a temporary workaround in my randconfig
tree.
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index bb5aebafe1622..8d349d6a633fa 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -285,7 +285,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u16 cookie;
-	u8 opcode;
 	u8 *preq;
 
 	cmdq = &rcfw->cmdq;
@@ -319,7 +318,7 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	crsqe->is_internal_cmd = false;
 	crsqe->is_waiter_alive = true;
 	crsqe->is_in_used = true;
-	crsqe->opcode = opcode;
+	crsqe->opcode = 0;
 
 	crsqe->req_size = __get_cmdq_base_cmd_size(msg->req, msg->req_sz);
 	if (__get_cmdq_base_resp_size(msg->req, msg->req_sz) && msg->sb) {
-- 
2.39.2

