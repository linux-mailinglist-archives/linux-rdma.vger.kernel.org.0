Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF73A742946
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjF2PQv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjF2PQs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 11:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A801E58
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 08:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45A36156C
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 15:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F6C433C0;
        Thu, 29 Jun 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688051806;
        bh=9fMviFvWZceSsBt94QW3FS2ZCAc4TJ8cIBwarSUP6rE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sNoKZgRa7TWDFBXDwrrz/D1JAFcuKq+cRdvWb52+QQW6nqzJ/cI8Hq7T0q+8MyZ39
         2QBOR0DZw0ia0HtoOLXKAReS2Ob1Y9RM5pLqnNeGpZ+zZSOObwEgDmswJ/WsO2LsdO
         Q9HLfVbVxPiAE7cm262lPf/M8AqZL/5Rv73225UIhTruxh7TtvSpKWhSk60mVA8GbV
         cb5xF4ft2aRf4yqkWSiHGOhd+GhHhXHjFlowsvaFcwAmTYTqTlExLH42mBeCwqBzV6
         I4H3xQmfQybM/hcOpvTNcfBt7YQ560gi9pns7m/WeuAZzqa1OihPystdBbAQPWZQAj
         waVLPwXbKAY4w==
Subject: [PATCH v5 3/4] RDMA/cma: Deduplicate error flow in
 cma_validate_port()
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        BMT@zurich.ibm.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Date:   Thu, 29 Jun 2023 11:16:44 -0400
Message-ID: <168805180479.164730.3680697581731936765.stgit@manet.1015granger.net>
In-Reply-To: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up to prepare for the addition of new logic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6b3f4384e46a..889b3e4ea980 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -686,30 +686,31 @@ cma_validate_port(struct ib_device *device, u32 port,
 		  struct rdma_id_private *id_priv)
 {
 	struct rdma_dev_addr *dev_addr = &id_priv->id.route.addr.dev_addr;
+	const struct ib_gid_attr *sgid_attr = ERR_PTR(-ENODEV);
 	int bound_if_index = dev_addr->bound_dev_if;
-	const struct ib_gid_attr *sgid_attr;
 	int dev_type = dev_addr->dev_type;
 	struct net_device *ndev = NULL;
 
 	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
-		return ERR_PTR(-ENODEV);
+		goto out;
 
 	if ((dev_type == ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port))
-		return ERR_PTR(-ENODEV);
+		goto out;
 
 	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
-		return ERR_PTR(-ENODEV);
+		goto out;
 
 	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
 		if (!ndev)
-			return ERR_PTR(-ENODEV);
+			goto out;
 	} else {
 		gid_type = IB_GID_TYPE_IB;
 	}
 
 	sgid_attr = rdma_find_gid_by_port(device, gid, gid_type, port, ndev);
 	dev_put(ndev);
+out:
 	return sgid_attr;
 }
 


