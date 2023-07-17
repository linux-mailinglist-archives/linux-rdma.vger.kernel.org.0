Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08575673D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGQPM0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjGQPMX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 11:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1B10E
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 08:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57A4860FCA
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 15:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562F1C433C8;
        Mon, 17 Jul 2023 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689606740;
        bh=tDBsqL5NlQ8X0YV7ODIeH9tuaa9S3XC9sn5ZSeG6NTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m7NqKVogr6EV0RZc1FTRIFHe3jGldFxfxJEsM0qZuN1oPkv3Co8XwU27dh4Wa6/GU
         Fc1KLnLxU9as80Q5OkX8wZYvimzi+aIpWtnF+Y0K0hnIudny8NGmEiQtcqAGrXPudT
         +w8V8rVv82kbvWaj1bFKbm0KqPSPG5PUDb744TK9f+yrROGxSY4ZuQRjyM9BId0iaL
         Lp5+fci4bfeMmmWBDS8pip63cPw5W9/8FKk5ARKOFrH/TFY+4cZfFFvO0+O31J6e18
         Uq6evzW8VLx+EVReY592lxNepPuVIyBIYy7SOJmuLCixnuBun/MtcVSCkPDQEOv7u/
         mDPksJY7SXy9g==
Subject: [PATCH v6 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
From:   Chuck Lever <cel@kernel.org>
To:     leon@kernel.org, jgg@nvidia.com
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        BMT@zurich.ibm.com, tom@talpey.com, linux-rdma@vger.kernel.org
Date:   Mon, 17 Jul 2023 11:12:19 -0400
Message-ID: <168960673933.3007.8043081822081877578.stgit@manet.1015granger.net>
In-Reply-To: <168960662017.3007.17697555924773191374.stgit@manet.1015granger.net>
References: <168960662017.3007.17697555924773191374.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Have the iwarp side properly set the ndev in the device's sgid_attrs
so that address resolution can treat it more like a RoCE device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cache.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 2e91d8879326..33f9d02f9b60 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1457,6 +1457,17 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 				 i);
 			goto err;
 		}
+
+		if (rdma_protocol_iwarp(device, port)) {
+			struct net_device *ndev;
+
+			ndev = ib_device_get_netdev(device, port);
+			if (!ndev)
+				continue;
+			RCU_INIT_POINTER(gid_attr.ndev, ndev);
+			dev_put(ndev);
+		}
+
 		gid_attr.index = i;
 		tprops->subnet_prefix =
 			be64_to_cpu(gid_attr.gid.global.subnet_prefix);


