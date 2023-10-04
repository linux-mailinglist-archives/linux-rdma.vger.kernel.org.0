Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C57B88A0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbjJDSSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjJDSSB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:18:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26249E
        for <linux-rdma@vger.kernel.org>; Wed,  4 Oct 2023 11:17:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE5CC433C8;
        Wed,  4 Oct 2023 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696443477;
        bh=64hMlnvbrxFbyV5sdhAPpNxvfxCdQJ2MnbMECV2ISC0=;
        h=From:To:Cc:Subject:Date:From;
        b=rhtyDlrhzpvCt7yQCZQJmL7pU4QtH+KJGFR1BgK9LSiQ+fNviap6AzfIbn8NHOxom
         y3g7OCaQJbDgVO415rMixfz/po5i6wWTXOrcFRc1oWqy017OFaLoCc+kFiRpF8AAq7
         taD5BbdjpEhOSlojVuGwNoqlSrnoQk1A/uXfDzQq7v+IhbqbCkXCOp0Utz9CL73fNk
         yx6oCIynDvlqiBKDpcW1xHgBN8LKVyUQZoclV2DnOQLPV5/N/l+1YxlgvHjvRv0YHX
         vCoRdcu6FN2CuBPCc0wm9LJ6p/4X5E2IiT4vgkNAWlx6T7tvpu7Ih82nOnLjNe9FSE
         BC8VQsaUbMKcg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/core: Require admin capabilities to set system parameters
Date:   Wed,  4 Oct 2023 21:17:49 +0300
Message-ID: <75d329fdd7381b52cbdf87910bef16c9965abb1f.1696443438.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Like any other set command, require admin permissions to do it.

Cc: stable@vger.kernel.org
Fixes: 2b34c5580226 ("RDMA/core: Add command to set ib_core device net namspace sharing mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 5c805fa6187f..87b8cd657fb3 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2595,6 +2595,7 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 	[RDMA_NLDEV_CMD_SYS_SET] = {
 		.doit = nldev_set_sys_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
 	},
 	[RDMA_NLDEV_CMD_STAT_SET] = {
 		.doit = nldev_stat_set_doit,
-- 
2.41.0

