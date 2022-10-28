Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504C8610AD7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJ1G7G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 02:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1G7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 02:59:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE218197D
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 23:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1CBDB82899
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 06:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED35BC433C1;
        Fri, 28 Oct 2022 06:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666940342;
        bh=VrxVR6IX/9QSLVD8TyxaCLq9h8cREFmo27SwIfNQ8aw=;
        h=From:To:Cc:Subject:Date:From;
        b=EcMYCQt+w6iK/dam9aexa2WWt8YEP1tH9jZiWS+vChG75F6nyYrD4xd+cN3yOzQiM
         WPSoLYqoRGN09owgxUgKi91616hz1t2bKhRP5kjgu7zecMIyzYWHK0Mdo+gJSs9evJ
         uDTseKykufhlgDgSd3SAOCn6m8/Ay8gWGj1ojrWlZ7aSH3uds7pz3mUYABYiSAIign
         em72uAdIcx9KR8h7CjHSiEAeFDvlTKynrQpQH2tGJIYnm1gy6s11LcYGj4uXSlq3Pj
         AtjhbQrE8P/s5w4/RMddU+unuJuUmlJcEUVe2YtygGhSqTbH58Bhq0JJTnIc+M4xWK
         ml85K1aXqaVSQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for nldev
Date:   Fri, 28 Oct 2022 09:58:56 +0300
Message-Id: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
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

ppc64_defconfig) produced this warning:

WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)

Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
and as such doesn't require any special notations for entry/exit functions.

Fixes: 6c80b41abe22 ("RDMA/netlink: Add nldev initialization flows")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/core/nldev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b92358f606d0..4b6815dcd261 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2532,12 +2532,12 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 };
 
-void __init nldev_init(void)
+void nldev_init(void)
 {
 	rdma_nl_register(RDMA_NL_NLDEV, nldev_cb_table);
 }
 
-void __exit nldev_exit(void)
+void nldev_exit(void)
 {
 	rdma_nl_unregister(RDMA_NL_NLDEV);
 }
-- 
2.37.3

