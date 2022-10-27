Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD160F6AA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiJ0MB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiJ0MB0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 08:01:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF26F548
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 05:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 576DDCE25DB
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 12:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04569C433C1;
        Thu, 27 Oct 2022 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666872081;
        bh=TAQ1J6jN33IqkpczZJ/Z/2kiOWU1ZUClYLBYLNDyiow=;
        h=From:To:Cc:Subject:Date:From;
        b=d1f6yMnJ9VijpZC9MchVAjnX1vpFjKxqDVMNqpdhbY/V8JkB+al9DQhJqq5zLOAYS
         nIBthJSXc+vGky3AfVyHaL4RM8Z3yAy/3iUtRI13hJUfTgODhAv86LTneatONu0kT0
         fCQkNwiwQH1mPKefSqbMekf7t/zj1fF3+gDlLns3bxaElUSpK6j9U+mR3PQ6MGrzTS
         oSKh7Vwf2Lls8TXRND8/iShqCeoJXMfkmQOIp+0gyoKhMmBWIm5uqTg3upbXhD4+fu
         bJ7GqOt2vz+ApVfW+Y7sqnV06MQLD4+E0C1YlGbn4MlbZjjBu05PgyH5IDLoK2i4hB
         HLqS2NFHI6q4Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Ariel Elior <aelior@marvell.com>, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH rdma-rc] RDMA/qedr: Destroy XArray during release of resources
Date:   Thu, 27 Oct 2022 15:01:16 +0300
Message-Id: <3af204a14d3dadf4102cd55ef50f0d927bb97884.1666871711.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Destroy XArray while releasing qedr resources.

Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
I'm sending it to -rc just because of dependency on
https://lore.kernel.org/linux-rdma/166687129991.306571.17052575958640789335.b4-ty@kernel.org/T/#m0e945baa7f2c87ede9f1711c992889602ede7875
qps is empty and nothing is really leaked here.
---
 drivers/infiniband/hw/qedr/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index ba0c3e4c07d8..9f53afed2bd0 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -308,8 +308,10 @@ static void qedr_free_resources(struct qedr_dev *dev)
 {
 	int i;
 
-	if (IS_IWARP(dev))
+	if (IS_IWARP(dev)) {
 		destroy_workqueue(dev->iwarp_wq);
+		xa_destroy(&dev->qps);
+	}
 
 	for (i = 0; i < dev->num_cnq; i++) {
 		qedr_free_mem_sb(dev, &dev->sb_array[i], dev->sb_start + i);
@@ -407,8 +409,10 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 err2:
 	kfree(dev->sb_array);
 err_destroy_wq:
-	if (IS_IWARP(dev))
+	if (IS_IWARP(dev)) {
 		destroy_workqueue(dev->iwarp_wq);
+		xa_destroy(&dev->qps);
+	}
 err1:
 	kfree(dev->sgid_tbl);
 	return rc;
-- 
2.37.3

