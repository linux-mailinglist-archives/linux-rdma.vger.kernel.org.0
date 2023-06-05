Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62817722399
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 12:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFEKeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 06:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFEKeQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 06:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D31A8
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 03:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD6C6225F
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 10:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FB3C433EF;
        Mon,  5 Jun 2023 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685961242;
        bh=P6qTBjExfs6p45g3tbSPwwNmlQsHzBCSAozQgEWxuh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSzUcOuB/JUN8YY9zZRG6ZBk6/HfF9Hrypfn8rRyAc05/48FrycMYPPvxxOHadjsd
         zMF8PRm/H/Mu9wdsSfPfCXqUR2kiwreJNxB6VKLmSFRNaO3jG6sBQtTlrPfZwBkzci
         wrPXnVyn4kj+YMaK7R/VH11Hz/vORQ+gias4hgBLXOTU5Moc4wTKtEr1OY+Fncfw7J
         9FIBI/15SwvC8HCl5pF04+5JB50xf+XE3UYNVPJoiCk+ndNoJC451CendprxOQ22AB
         V/AbwU6W1lfG+u9708gY22QAlYe/FtnRt7EJPoRJP8zknyz4RV3YSGUV0Mzbhb8HzF
         uqfgQw2P33Yyg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc 09/10] IB/uverbs: Fix to consider event queue closing also upon non-blocking mode
Date:   Mon,  5 Jun 2023 13:33:25 +0300
Message-Id: <97b00116a1e1e13f8dc4ec38a5ea81cf8c030210.1685960567.git.leon@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685960567.git.leon@kernel.org>
References: <cover.1685960567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Fix ib_uverbs_event_read() to consider event queue closing also upon
non-blocking mode.

Once the queue is closed (e.g. hot-plug flow) all the existing events
are cleaned-up as part of ib_uverbs_free_event_queue().

An application that uses the non-blocking FD mode should get -EIO in
that case to let it knows that the device was removed already.

Otherwise, it can loose the indication that the device was removed and
won't recover.

As part of that, refactor the code to have a single flow with regards to
'is_closed' for both blocking and non-blocking modes.

Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index fbace69672ca..7c9c79c13941 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -222,8 +222,12 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 
 	while (list_empty(&ev_queue->event_list)) {
-		spin_unlock_irq(&ev_queue->lock);
+		if (ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
+			return -EIO;
+		}
 
+		spin_unlock_irq(&ev_queue->lock);
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
@@ -233,12 +237,6 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 			return -ERESTARTSYS;
 
 		spin_lock_irq(&ev_queue->lock);
-
-		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
-			spin_unlock_irq(&ev_queue->lock);
-			return -EIO;
-		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
-- 
2.40.1

