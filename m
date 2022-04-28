Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3787513B1A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Apr 2022 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbiD1Rwa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Apr 2022 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiD1Rw3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Apr 2022 13:52:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D33BAB8C
        for <linux-rdma@vger.kernel.org>; Thu, 28 Apr 2022 10:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6B6662161
        for <linux-rdma@vger.kernel.org>; Thu, 28 Apr 2022 17:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BF9C385A9;
        Thu, 28 Apr 2022 17:49:13 +0000 (UTC)
Subject: [PATCH] RDMA/siw: Enable siw on tunnel devices
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 28 Apr 2022 13:49:11 -0400
Message-ID: <165116808349.4900.17936331350338401564.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bernard Metzler <bmt@zurich.ibm.com>

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


Hi Bernard!

How come this change isn't in the upstream siw driver yet?


diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index e5c586913d0b..dacc174604bf 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -119,6 +119,7 @@ static int siw_dev_qualified(struct net_device *netdev)
 	 * <linux/if_arp.h> for type identifiers.
 	 */
 	if (netdev->type == ARPHRD_ETHER || netdev->type == ARPHRD_IEEE802 ||
+	    netdev->type == ARPHRD_NONE ||
 	    (netdev->type == ARPHRD_LOOPBACK && loopback_enabled))
 		return 1;
 
@@ -315,12 +316,12 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 
 	sdev->netdev = netdev;
 
-	if (netdev->type != ARPHRD_LOOPBACK) {
+	if (netdev->type != ARPHRD_LOOPBACK && netdev->type != ARPHRD_NONE) {
 		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
 				    netdev->dev_addr);
 	} else {
 		/*
-		 * The loopback device does not have a HW address,
+		 * This device does not have a HW address,
 		 * but connection mangagement lib expects gid != 0
 		 */
 		size_t len = min_t(size_t, strlen(base_dev->name), 6);


