Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4485777D471
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbjHOUk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 16:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbjHOUkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 16:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD92680;
        Tue, 15 Aug 2023 13:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD43D66198;
        Tue, 15 Aug 2023 20:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68349C433C7;
        Tue, 15 Aug 2023 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692131932;
        bh=nzA4p2In00F8WGqv2J+xq1zlDnCIJQPQMghB0lPPiwE=;
        h=Date:From:To:Cc:Subject:From;
        b=nBc+VsxSWlJRhY8XMqEEgzmxYDWgeyO34ygkLKmUG1f7tUvuLqVGWelqX58v3K09r
         nzPvQBKE4q07GRweF62bfu9+ma80XtDw1Ti6hiJT82GXGqGCi+WCLZqsJ8ZcMqGnaI
         Gan5J9n8JxAkbPlP8TzL+NHVk/BFrqcGcAeBZvtFpE+9JsXh5uJgpycldKKbE5gwzl
         0wXKHGLJAkuXJ0QMWBpKZcUltd9NdEctehvDfVCgYZgo1tr9/1AzgwQ6GpkcePjhMk
         1x9NTYWIiXnOKzhNMbVzp0VzLpDURGSC3VVxJrrzMweSVo+R2XHNYXANBaNLoVONCe
         nTsxhpPeLztrQ==
Date:   Tue, 15 Aug 2023 14:39:53 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/mlx4: Copy union directly
Message-ID: <ZNvimeRAPkJ24zRG@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Copy union directly instead of using memcpy().

Note that in this case, a direct assignment is more readable and
consistent with the subsequent assignments.

This addresses the following -Wstringop-overflow warning seen in s390
with defconfig:
drivers/infiniband/hw/mlx4/main.c:296:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
  296 |                                 memcpy(&port_gid_table->gids[free].gid,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  297 |                                        &attr->gid, sizeof(attr->gid));
      |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/308
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/mlx4/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 216aacd72e4f..2d2cd17e02e6 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -293,8 +293,7 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 				ret = -ENOMEM;
 			} else {
 				*context = port_gid_table->gids[free].ctx;
-				memcpy(&port_gid_table->gids[free].gid,
-				       &attr->gid, sizeof(attr->gid));
+				port_gid_table->gids[free].gid = attr->gid;
 				port_gid_table->gids[free].gid_type = attr->gid_type;
 				port_gid_table->gids[free].vlan_id = vlan_id;
 				port_gid_table->gids[free].ctx->real_index = free;
-- 
2.34.1

