Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA9756740
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGQPMo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGQPMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 11:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF4170A
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 08:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C1261128
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 15:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEFFC433C8;
        Mon, 17 Jul 2023 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689606754;
        bh=b1xQe7gleMwBAdcCBnvil0pAV/6vAdiizVxa5NbIVkM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cRx3P09U81xLYz97NrkKsIZBpP6eBfLjWMABR1674r3d4S4yxUp/FOylVXHTG3xOM
         +rXPHd6h7aHTL4IYvMXwZFwj3nHW/VKdo7rEoZJn2fE0intk7KtvEdTQImTfjLHZ88
         WTf++G0Nx6S/9t/zdiaIRYASjG4tMJ+PIfr0fa4c2fvvs75LB1Y5c/irLNjP8bDh0K
         hDkxNyIXbZNSJ3SPoBu7sNELMWZjIRk/CbJhvRjokj2KuCmDITvdcjZfBuE4rn6i8M
         Wz5i+yu7RqunCUjyVAJTbapD5SttbKIJkLZy2sWxy3PPa1sJpJlyITDXm1Vn2BQK4B
         Zs3Ngx5ESh5YA==
Subject: [PATCH v6 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
From:   Chuck Lever <cel@kernel.org>
To:     leon@kernel.org, jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, BMT@zurich.ibm.com,
        tom@talpey.com, linux-rdma@vger.kernel.org
Date:   Mon, 17 Jul 2023 11:12:32 -0400
Message-ID: <168960675257.3007.4737911174148394395.stgit@manet.1015granger.net>
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

We would like to enable the use of siw on top of a VPN that is
constructed and managed via a tun device. That hasn't worked up
until now because ARPHRD_NONE devices (such as tun devices) have
no GID for the RDMA/core to look up.

But it turns out that the egress device has already been picked for
us -- no GID is necessary. addr_handler() just has to do the right
thing with it.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index da54167723d6..8bd6cb867381 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -700,6 +700,27 @@ cma_validate_port(struct ib_device *device, u32 port,
 	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
 		goto out;
 
+	/*
+	 * For drivers that do not associate more than one net device with
+	 * their gid tables, such as iWARP drivers, it is sufficient to
+	 * return the first table entry.
+	 *
+	 * Other driver classes might be included in the future.
+	 */
+	if (rdma_protocol_iwarp(device, port)) {
+		sgid_attr = rdma_get_gid_attr(device, port, 0);
+		if (IS_ERR(sgid_attr))
+			goto out;
+
+		rcu_read_lock();
+		ndev = rcu_dereference(sgid_attr->ndev);
+		if (!net_eq(dev_net(ndev), dev_addr->net) ||
+		    ndev->ifindex != bound_if_index)
+			sgid_attr = ERR_PTR(-ENODEV);
+		rcu_read_unlock();
+		goto out;
+	}
+
 	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
 		if (!ndev)


