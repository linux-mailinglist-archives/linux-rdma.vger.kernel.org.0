Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1973010F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbjFNOAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbjFNOAu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 10:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483911B
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 07:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE3563C9D
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jun 2023 14:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDB2C433C8;
        Wed, 14 Jun 2023 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751248;
        bh=lJguwL74pHMBTj150wwXK6RGyrGPW//UR6ztnL09Fas=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RrKyI3/9BsGwiYmI7sKSDPpwnDQDPMHEbCjVXkjrBaZXvrliJ9KZuvZIxpGuxhciB
         5AngzZrHaHE40l0AzV5pTmZvYSQuvG6P7jOuusxLoIGkejfjJaahHe7KwFqFmRxXLU
         y/+65zitWekZORwKN7WZwoAobTlK710ezzxsJs3V97XRK1vQytzenhUHpSnQMG/5/1
         26yWY6bCFWRVzqrVD8k2rivH/t8pB/Z+gYFWJVxizXZ1pOIRGNFcj/VfCek0PbfwZs
         cmd0rgHmmZQ9nXTkdnh9Jpx0WYZeumH0DwqxIdOog+iXzJ9hrPHJckSY2GG+AbxJN4
         EebthM3Q7ol6Q==
Subject: [PATCH v3 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com, BMT@zurich.ibm.com
Date:   Wed, 14 Jun 2023 10:00:47 -0400
Message-ID: <168675124698.2279.15699248221119454150.stgit@manet.1015granger.net>
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


