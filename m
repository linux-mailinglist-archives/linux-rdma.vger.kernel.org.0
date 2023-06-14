Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B12730110
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbjFNOA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbjFNOA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 10:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649D11B
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 07:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE5563F79
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC7DC433C0;
        Wed, 14 Jun 2023 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751254;
        bh=QYfiTehHwNsyhrFEAAsXvpslipmwSWUHlNZkYctCvIc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VZznJmM91AaqDHi3YzW0rMCRxMpBO67AyNm8ycdQgizEtdlyOzAqXhmqjjPLSTtFH
         SoeG+hmMu1H0jnBm2Ku1RWdAgneaMqJY0EQ2cSpAEie8t4navN6UKxHLZ63OPiGANK
         yPxLgcrerZYlmi7DSTpaWD+uL1Y6NV4KM2ptHJkt43X+yv3iFMmyQrkfXHZKHrWCSV
         bwL1rxd61lizDXVa8RUIsA0wZUH2eFAROW7CSA/e4+2kPaafu3qDZfiUYb8KFquwnG
         Zn4WdvAgBnsj6n8il4bi6uWf8eco4UFAaPGmiK9fqoBTUfSnvud5ULbmsSQQqSkooV
         BlpuNozF1zbvg==
Subject: [PATCH v3 3/4] RDMA/cma: Deduplicate error flow in
 cma_validate_port()
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com, BMT@zurich.ibm.com
Date:   Wed, 14 Jun 2023 10:00:53 -0400
Message-ID: <168675125344.2279.13016950228751332493.stgit@manet.1015granger.net>
In-Reply-To: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
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
 


