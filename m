Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0C73A4A5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFVPUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjFVPUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 11:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7DE4B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 08:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B502B617DB
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jun 2023 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FCBC433C8;
        Thu, 22 Jun 2023 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687447232;
        bh=lJguwL74pHMBTj150wwXK6RGyrGPW//UR6ztnL09Fas=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Td2nCDfsyD+Xao34kZ+CzDoIbLslA7UJajnHJ2hVDZ3ObZEez6Q3G4wt+PE8/bcHa
         uvOFppOy7dRPkTZi8MR68cFMLQnN7/c8p+PfMq19XZdC78Pe/VI/148bijd6BYXxwE
         7BLhNUSHcIELDpEkyRL3aJfsWKnOIpr7RlgQ6ZUVfvXMhAS/bRU1ta6D/YLhT+xA8f
         bq72stg1JPJ/er7G+HJ5POx3cu5G1Aowiq6U3hlsrIN/IEEQ1sjpqDO30vgpnyoKap
         vnmG1RLesyzI+kJ6j49D3VYUiPjiD+49EGjSfmXtrWi/fXTSSVosc0F7hX0V14M/Uq
         eFSG/JJs8iEBQ==
Subject: [PATCH v4 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        linux-rdma@vger.kernel.org, BMT@zurich.ibm.com,
        yanjun.zhu@linux.dev
Date:   Thu, 22 Jun 2023 11:20:30 -0400
Message-ID: <168744723080.136340.15471993685775481944.stgit@manet.1015granger.net>
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

Have the iwarp side properly set the ndev in the device's sgid_attrs
so that address resolution can treat it more like a RoCE device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cache.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2e91d8879326..717524fe8a39 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1439,6 +1439,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 {
 	struct ib_gid_attr gid_attr = {};
 	struct ib_gid_table *table;
+	struct net_device *ndev;
 	int ret = 0;
 	int i;
 
@@ -1457,10 +1458,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 				 i);
 			goto err;
 		}
+
+		ndev = NULL;
+		if (rdma_protocol_iwarp(device, port)) {
+			ndev = ib_device_get_netdev(device, port);
+			if (!ndev)
+				continue;
+			RCU_INIT_POINTER(gid_attr.ndev, ndev);
+		}
+
 		gid_attr.index = i;
 		tprops->subnet_prefix =
 			be64_to_cpu(gid_attr.gid.global.subnet_prefix);
 		add_modify_gid(table, &gid_attr);
+
+		dev_put(ndev);
 	}
 err:
 	mutex_unlock(&table->lock);


