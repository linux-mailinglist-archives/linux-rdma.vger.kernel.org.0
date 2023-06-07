Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9472726A03
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 21:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFGToH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 15:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFGToH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 15:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A41FE0
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 12:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 866976133F
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 19:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE21C433EF;
        Wed,  7 Jun 2023 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686167044;
        bh=vYlZC5Usyu2o2bKgO3rENUKpU8J8ZWO+yGaya5nunNo=;
        h=Subject:From:To:Cc:Date:From;
        b=GLP3AWh8AIJ9EyFeHWP9sskwrNcGJ/+tYALAtO2uysj7iiKKdOeoTcYGWaYaWrjqd
         +RDA4I1xoMWHCGPEQOJss+39R5zRSMkjpRLHAztJHo6RtJTwJQjXMDt1any7WVnrKL
         2YgSx7pmFDiUFWR7n2pdB0j1Ot8FZvQisgYuqO7PjSZ+JPSxN08PCMsOLqQTpCnZDa
         X1j4H+gDrf1XCbmYhZwU/94YStVB7UjPh1h0KHHGyjXFXwion5EWdgy57jc6zsr77x
         cFjCQk3zJZxmH6mpvGWVPc4f+YT3U0w3kqZAG/5msJUF4x4Ljsrn/Pd7y/4J3gGm3V
         eX/ISC5F6BAsQ==
Subject: [PATCH v1] RDMA/core: Handle ARPHRD_NONE devices for iWARP
From:   Chuck Lever <cel@kernel.org>
To:     jgg@nvidia.com, BMT@zurich.ibm.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com,
        linux-rdma@vger.kernel.org
Date:   Wed, 07 Jun 2023 15:43:53 -0400
Message-ID: <168616682205.2099.4473975057644323224.stgit@oracle-102.nfsv4bat.org>
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

We would like to enable the use of siw on top of a VPN that is
constructed and managed via a tun device. That hasn't worked up
until now because ARPHRD_NONE devices (such as tun devices) have
no GID for the RDMA/core to look up.

But it turns out that the egress device has already been picked for
us. addr_handler() just has to do the right thing with it.

Tested with siw and qedr, both initiator and target.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cma.c |    3 +++
 1 file changed, 3 insertions(+)

This of course needs broader testing, but it seems to work, and it's
a little nicer than "if (dev_type == ARPHRD_NONE)".

One thing I discovered is that the NFS/RDMA server implementation
does not deal at all with more than one RDMA device on the system.
I will address that with an ib_client; SunRPC patches forthcoming.

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 56e568fcd32b..c9a2bdb49e3c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -694,6 +694,9 @@ cma_validate_port(struct ib_device *device, u32 port,
 	if (!rdma_dev_access_netns(device, id_priv->id.route.addr.dev_addr.net))
 		return ERR_PTR(-ENODEV);
 
+	if (rdma_protocol_iwarp(device, port))
+		return rdma_get_gid_attr(device, port, 0);
+
 	if ((dev_type == ARPHRD_INFINIBAND) && !rdma_protocol_ib(device, port))
 		return ERR_PTR(-ENODEV);
 


