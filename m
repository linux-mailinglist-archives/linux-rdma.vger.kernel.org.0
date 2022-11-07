Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C661ED77
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiKGIwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 03:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiKGIwC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 03:52:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5815836
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 00:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FB81B80E6C
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D7C433D6;
        Mon,  7 Nov 2022 08:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667811119;
        bh=rHmPeVtQFPp7uhcxjmAeCoNnsYRLg54ieY6W5IXzmBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R36Ak/fCKheNpTTxAU9qA6A1l227UOq1FtenShbB4DRyQFY3HfzhLLzumm+RyAKob
         Ls9yUWSaIo2nEObE10j+JBecwwHfdwv5rBxxtlCVC6jXAZJNMMWmpbiDg8o26b9n7c
         5wreBFOhMozSHpxMZvJGlu215nw9b0GM14gabdmlkJSvUfRA4v6tyOsXOekafAABMU
         3o+7J8Kz0bH3z25YUJ9NviMNDYmoWIpAVr2OX1AER9y1nCQRk/Ea4S8C1JTV3x5/X0
         jT+RVs14bkYwr0SR2wXhR54OcMV+7vUxDeHjMj3B19cs8OGOuuQX96uf8Sn17fQvV0
         75PAX663kiaxg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 4/4] RDMA/nldev: Return "-EAGAIN" if the cm_id isn't from expected port
Date:   Mon,  7 Nov 2022 10:51:36 +0200
Message-Id: <a08e898cdac5e28428eb749a99d9d981571b8ea7.1667810736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667810736.git.leonro@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
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

When filling a cm_id entry, return "-EAGAIN" instead of 0 if the cm_id
doesn'the have the same port as requested, otherwise an incomplete entry
may be returned, which causes "rdam res show cm_id" to return an error.

For example on a machine with two rdma devices with "rping -C 1 -v -s"
running background, the "rdma" command fails:
  $ rdma -V
  rdma utility, iproute2-5.19.0
  $ rdma res show cm_id
  link mlx5_0/- cm-idn 0 state LISTEN ps TCP pid 28056 comm rping src-addr 0.0.0.0:7174
  error: Protocol not available

While with this fix it succeeds:
  $ rdma res show cm_id
  link mlx5_0/- cm-idn 0 state LISTEN ps TCP pid 26395 comm rping src-addr 0.0.0.0:7174
  link mlx5_1/- cm-idn 0 state LISTEN ps TCP pid 26395 comm rping src-addr 0.0.0.0:7174

Fixes: 00313983cda6 ("RDMA/nldev: provide detailed CM_ID information")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 213be4e6fd28..cfe569fefbc4 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -552,7 +552,7 @@ static int fill_res_cm_id_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	struct rdma_cm_id *cm_id = &id_priv->id;
 
 	if (port && port != cm_id->port_num)
-		return 0;
+		return -EAGAIN;
 
 	if (cm_id->port_num &&
 	    nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, cm_id->port_num))
-- 
2.38.1

