Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA90B742943
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjF2PQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjF2PQl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 11:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976401BD3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 08:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4126156E
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 15:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F66C433C9;
        Thu, 29 Jun 2023 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688051799;
        bh=tDBsqL5NlQ8X0YV7ODIeH9tuaa9S3XC9sn5ZSeG6NTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gqCf/3v4y62eI0ui0xUYSSqPN+oEy7h3R527bJ1vJ3norp5NcsAckvn8RnN29nFf2
         jHjNV6JeUROmjP7MAjVz4hE3hqk/0MvO1WwP84D+TQg4PTJaLMpoXRcu7UPvVr48+D
         jJWjXTmGS1INwFImBrMZcR9kr3vKkJKmKErVk5iseaqS3Kp+bL9RUNkIilp1G6jke5
         +N1ZczwNUfJC/3hGvFlIpFQqwmd+Vz/vrs8oeQOL0AQtzLEQEoEygQeUBB1gAYYr+Y
         PRP+MGUz5dIN6HC4/SbtDovL4Gvps3FZIIBxTxwK4iiaaI4iH2h3RjnhuM+i7k5O4t
         BCUTJW6ksZ+Hw==
Subject: [PATCH v5 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        tom@talpey.com, BMT@zurich.ibm.com, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Date:   Thu, 29 Jun 2023 11:16:38 -0400
Message-ID: <168805179821.164730.12205925143704039946.stgit@manet.1015granger.net>
In-Reply-To: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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


