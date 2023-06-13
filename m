Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88372DC1F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjFMIQG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjFMIQF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 04:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFAFE4E
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 01:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 611EC61A98
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 08:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399CC433D2;
        Tue, 13 Jun 2023 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644163;
        bh=F18KLr/68N0slSwT2wYW4Odyj32cVrk7lPolbLhMGRk=;
        h=From:To:Cc:Subject:Date:From;
        b=MbBiwwQQ+OnBkYPhts5AZqqs2faCTAJkwhYEhd2qrav8zlzyw7E43i37NGgDsyDju
         xx6g2TSwoKLmcbWcwL2/hSAIQnUSOxKC4urj2hn/vPwEnIivxhqw4qPF+yKchOAD6E
         9lD05NXkLVmhcDBj68+Vs26oBSqYFc28291JTsOSpZaqImaMON/ribSxFxhXCEZJPb
         1z2DSBAAEh62U+jt2Abrr+SqqytVJ0zsiDa2KcG7/NPGcx7pT8G/lafdFwC6mcsOHh
         nlJjv50vm0EqongQsA5q4OANPxk1HGb/8GFx5/j/mBXrIJvvKEK0ALPxJxVTgGvttk
         hqUG/jP9UnyKg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/bnxt_re: Initialize opcode while sending message
Date:   Tue, 13 Jun 2023 11:15:57 +0300
Message-Id: <6ad1e44be2b560986da6fdc6b68da606413e9026.1686644105.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.40.1
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

From: Leon Romanovsky <leonro@nvidia.com>

Fix compilation warning:

drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:325:18:
  error: variable 'opcode' is uninitialized when used here [-Werror,-Wuninitialized]
        crsqe->opcode = opcode;
                        ^~~~~~
drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:291:11:
  note: initialize the variable 'opcode' to silence this warning
        u8 opcode;
                 ^
                  = '\0'

Fixes: bcfee4ce3e01 ("RDMA/bnxt_re: remove redundant cmdq_bitmap")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index bb5aebafe162..92b3a4fbd0b2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -274,7 +274,7 @@ static void __send_message_no_waiter(struct bnxt_qplib_rcfw *rcfw,
 }
 
 static int __send_message(struct bnxt_qplib_rcfw *rcfw,
-			  struct bnxt_qplib_cmdqmsg *msg)
+			  struct bnxt_qplib_cmdqmsg *msg, u8 opcode)
 {
 	u32 bsize, free_slots, required_slots;
 	struct bnxt_qplib_cmdq_ctx *cmdq;
@@ -285,7 +285,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u16 cookie;
-	u8 opcode;
 	u8 *preq;
 
 	cmdq = &rcfw->cmdq;
@@ -490,7 +489,7 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	if (rc)
 		return rc == -ENXIO ? bnxt_qplib_map_rc(opcode) : rc;
 
-	rc = __send_message(rcfw, msg);
+	rc = __send_message(rcfw, msg, opcode);
 	if (rc)
 		return rc;
 
-- 
2.40.1

