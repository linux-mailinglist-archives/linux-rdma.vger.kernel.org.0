Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCB7585AC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 21:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGRTio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGRTim (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 15:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1987B198D;
        Tue, 18 Jul 2023 12:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8780260B37;
        Tue, 18 Jul 2023 19:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E107C433C9;
        Tue, 18 Jul 2023 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709121;
        bh=kzd2rPYeONsTGcisNSQCTbZ1KZDmI2Fzfp5ybHEHHhk=;
        h=From:To:Cc:Subject:Date:From;
        b=qbUdNt0Tdh4z7wEi0XAxrHcU0cwijNx2zRehOst1OpRlf4ROlwg2p/VgAiadfEY+W
         vWE/pI3stzSzKPXks+O9NYMPOVczKS+AUtHkvSb7q/jE39i5KtByD45wXB87L8+Gpp
         WpA21WK8Zk7sRtwYdma7R3x9aDxpMnDNPeanLccREdUAfNcdhqCvQpnhL7i1D64gMO
         MmnWUtquZE5NoBwF/rzQbWH7qXGaxZ4wJEl1Kf+A2z/TTN8Mk0pzue4N7I1TVRyyWH
         mJLvguxdor0J3t45oZ04luq0TTOsc+TuqCTQ3/lWFlnQoOhxpr9nvUMfCOmXkSGlM0
         XJHUmhkboxCjA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sindhu Devale <sindhu.devale@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/irdma: fix building without IPv6
Date:   Tue, 18 Jul 2023 21:38:09 +0200
Message-Id: <20230718193835.3546684-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new irdma_iw_get_vlan_prio() function requires IPv6 support to build:

x86_64-linux-ld: drivers/infiniband/hw/irdma/cm.o: in function `irdma_iw_get_vlan_prio':
cm.c:(.text+0x2832): undefined reference to `ipv6_chk_addr'

Add a compile-time check in the same way as elsewhere in this file to avoid
this by conditionally leaving out the ipv6 specific bits.

Fixes: f877f22ac1e9b ("RDMA/irdma: Implement egress VLAN priority")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/irdma/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 6b71b67ce9ff0..8ea55c6a3fba5 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1562,7 +1562,7 @@ static u8 irdma_iw_get_vlan_prio(u32 *loc_addr, u8 prio, bool ipv4)
 	rcu_read_lock();
 	if (ipv4) {
 		ndev = ip_dev_find(&init_net, htonl(loc_addr[0]));
-	} else {
+	} else if (IS_ENABLED(CONFIG_IPV6)) {
 		struct net_device *ip_dev;
 		struct in6_addr laddr6;
 
-- 
2.39.2

