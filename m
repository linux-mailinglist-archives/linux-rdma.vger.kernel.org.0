Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA457524EA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGMORP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jul 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjGMORF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jul 2023 10:17:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8C5273C;
        Thu, 13 Jul 2023 07:17:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4B9A92215C;
        Thu, 13 Jul 2023 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689257823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0F3IVRfOzkZV04oqAbKVuLpJxEE0JQCptBRjfSogYEU=;
        b=k4Iv4+i8i2pPGKsG6+WpXS4qYs5OaDShVpDg/2SC1skE75pAPVb9lttsOqC53wfpeVhzTa
        E2gJDAoKff5l0MhE/tvjWXJmJnLEUtJbhgBCDx3j6hEFBkYw7d/DnLo73T+DFb6dAXOz20
        rbpkaZvAg7MuHO7VfHjGfChaL6GCxas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689257823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0F3IVRfOzkZV04oqAbKVuLpJxEE0JQCptBRjfSogYEU=;
        b=tJXDZNVs+MB1qj2V4LeR4c80hcvRGxpL+bg47FPaMfNqP2MLCrwHh4oeIFHXbhQ3HvAXnB
        GBJDxm1BXCmw2sBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2EAF62C142;
        Thu, 13 Jul 2023 14:17:03 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mthca: Fix crash when polling CQ for shared QPs
Date:   Thu, 13 Jul 2023 16:16:58 +0200
Message-Id: <20230713141658.9426-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 21c2fe94abb2 ("RDMA/mthca: Combine special QP struct with mthca QP")
introduced a new struct mthca_sqp which doesn't contain struct mthca_qp
any longer. Placing a pointer of this new struct into qptable leads
to crashes, because mthca_poll_one() expects a qp pointer. Fix this
by putting the correct pointer into qptable.

Fixes: 21c2fe94abb2 ("RDMA/mthca: Combine special QP struct with mthca QP")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/infiniband/hw/mthca/mthca_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
index 69bba0ef4a5d..53f43649f7d0 100644
--- a/drivers/infiniband/hw/mthca/mthca_qp.c
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c
@@ -1393,7 +1393,7 @@ int mthca_alloc_sqp(struct mthca_dev *dev,
 	if (mthca_array_get(&dev->qp_table.qp, mqpn))
 		err = -EBUSY;
 	else
-		mthca_array_set(&dev->qp_table.qp, mqpn, qp->sqp);
+		mthca_array_set(&dev->qp_table.qp, mqpn, qp);
 	spin_unlock_irq(&dev->qp_table.lock);
 
 	if (err)
-- 
2.35.3

