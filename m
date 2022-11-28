Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3672E63A76A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 12:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiK1LxD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 06:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiK1LxC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 06:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746A130
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 03:53:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 514B460F99
        for <linux-rdma@vger.kernel.org>; Mon, 28 Nov 2022 11:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E35AC433C1;
        Mon, 28 Nov 2022 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669636379;
        bh=ZKE9VaB9DzcuOatq9UNPTRg8ItOqSvZLDrU7JYR9aqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GpJAPsYHQwKcTTNjn4H5T/Y6dIJxxU4tqtTKb0x/igAz+Oeg9RZupyBWoDk7vBysq
         9FWhsBw5gE9nTtzqAjFGdZ79+9LVogJpqxDhIP9VH3jfX0DOTFtSNmOJmrvHz9xy0A
         1Th4sFlW5EdIK1lLnVmVR3F+YTYGGDDF5z1eOZgX1v4pR51jsJbv+6xCXQbEn/CZib
         qNpJy7xsOxALa1gnrZ7eaX150F3OarZDAlU/x/X997wtIGzbSrnUofoZmNQTCUg+bX
         yhwNvVT9hkLAUC1GIOb7PreAoeri+nDzvmAEcGGefgoS9x5l56FKBrYC4OTG5Pk7Cf
         JyoCF3qSGgBCw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/nldev: Fix failure to send large messages
Date:   Mon, 28 Nov 2022 13:52:46 +0200
Message-Id: <b5e9c62f6b8369acab5648b661bf539cbceeffdc.1669636336.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <bd924da89d5b4f5291a4a01d9b5ae47c0a9b6a3f.1669636336.git.leonro@nvidia.com>
References: <bd924da89d5b4f5291a4a01d9b5ae47c0a9b6a3f.1669636336.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Return "-EMSGSIZE" instead of "-EINVAL" when filling a QP entry, so that
new SKBs will be allocated if there's not enough room in current SKB.

Fixes: 65959522f806 ("RDMA: Add support to dump resource tracker in RAW format")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 1c5f4452e8db..afd8d65f749d 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -513,7 +513,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
 
 	/* In create_qp() port is not set yet */
 	if (qp->port && nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, qp->port))
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, qp->qp_num);
 	if (ret)
-- 
2.38.1

