Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716BB73A4A7
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFVPUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFVPUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 11:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DD41713
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 08:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B355617B0
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 15:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDD9C433C0;
        Thu, 22 Jun 2023 15:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687447238;
        bh=QYfiTehHwNsyhrFEAAsXvpslipmwSWUHlNZkYctCvIc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IFP4X5LiaRw/HLuN/m+adFEWADWu4OuiMlbjY4KSBqwm+5W1J5BxfUDVEmMS0tm+y
         QLBYx4nuDz7EpRGtOVmZ+YCh0MBcWWQmXwnPhHz0GxjM/Isu9ePQX28OR7notKt0te
         +UlecnAbS8H+R7rofTYs1JDYfdJc89gR0bNOBb6i94Vq5twm0LtBITYdYfibSk7d8/
         +IsPbrRFwaytRy5F0WyVT3IElyOlppZnyicRJJrobcW9dyjiFsloxGSyQemQikwCr8
         sueDlaA0NakrlaYN70kE4KoRLmTNE7rEUcStJ7pMASNttnSoCpLrkYcQQoHmgfeAhG
         urupnwZYmjLbQ==
Subject: [PATCH v4 3/4] RDMA/cma: Deduplicate error flow in
 cma_validate_port()
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        linux-rdma@vger.kernel.org, BMT@zurich.ibm.com,
        yanjun.zhu@linux.dev
Date:   Thu, 22 Jun 2023 11:20:37 -0400
Message-ID: <168744723736.136340.13859959715311898671.stgit@manet.1015granger.net>
In-Reply-To: <168744710872.136340.12090873711939747309.stgit@manet.1015granger.net>
References: <168744710872.136340.12090873711939747309.stgit@manet.1015granger.net>
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
index 93a1c48d0c32..a1756ed1faa1 100644
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
 


