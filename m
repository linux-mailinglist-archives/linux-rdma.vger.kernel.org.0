Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C76F1453
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjD1JnO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345455AbjD1JnN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 05:43:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B649CE
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682674991; x=1714210991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DdmSKGm6B6+clYZNPLLRaZYCIqajttBWqCwvfLXUubk=;
  b=HuH5XvQYHHNkcIAlwpxlWkUdx4XIZgCQ4FxbRmrkHojeOuBDqQCD/07T
   fEgK/mI3pPFAV/rDlsEm2yDxJ9+eJNIW4yO6SGOSg83aHdAOdBEkIF95l
   0oKkvSC6K7XSw2w7o7KTxJN3pKzob7L4Gtbp5UDTpDL4pl9yKjVPBorRk
   13o4R6n99a0s8trG7E8hIIXHOAu91mstUZEI6YwlcC9zQ719KaFqvhv8F
   I2uwUO/ErBMA3GOL+zt2hOr30g+M05g8anRTN1kB5X9HYSO8SYmPiPtse
   g0Tdmf1KFZCMaJzp5ViNj3oh5C3F8yHW5NeswpaVbN5A2paaBIgp0kb/W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328035173"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328035173"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 02:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764220386"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="764220386"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2023 02:43:09 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCHv5 for-rc1 v5 4/8] RDMA/rxe: Implement dellink in rxe
Date:   Fri, 28 Apr 2023 17:39:10 +0800
Message-Id: <20230428093914.2121131-5-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230428093914.2121131-1-yanjun.zhu@intel.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

When running "rdma link del" command, dellink function will be called.
If the sock refcnt is greater than the refcnt needed for udp tunnel,
the sock refcnt will be decreased by 1.

If equal, the last rdma link is removed. The udp tunnel will be
destroyed.

Tested-by: Rain River <rain.1986.08.12@gmail.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.c     | 12 +++++++++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 17 +++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_net.h |  1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 0ce6adb43cfc..ebfabc6d6b76 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -166,10 +166,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 /* called by ifc layer to create new rxe device.
  * The caller should allocate memory for rxe by calling ib_alloc_device.
  */
+static struct rdma_link_ops rxe_link_ops;
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 {
 	rxe_init(rxe);
 	rxe_set_mtu(rxe, mtu);
+	rxe->ib_dev.link_ops = &rxe_link_ops;
 
 	return rxe_register_device(rxe, ibdev_name);
 }
@@ -206,9 +208,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	return err;
 }
 
-struct rdma_link_ops rxe_link_ops = {
+static int rxe_dellink(struct ib_device *dev)
+{
+	rxe_net_del(dev);
+
+	return 0;
+}
+
+static struct rdma_link_ops rxe_link_ops = {
 	.type = "rxe",
 	.newlink = rxe_newlink,
+	.dellink = rxe_dellink,
 };
 
 static int __init rxe_module_init(void)
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 3ca92e062800..4cc7de7b115b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -530,6 +530,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	return 0;
 }
 
+#define SK_REF_FOR_TUNNEL	2
+void rxe_net_del(struct ib_device *dev)
+{
+	if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
+		__sock_put(recv_sockets.sk6->sk);
+	else
+		rxe_release_udp_tunnel(recv_sockets.sk6);
+
+	if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
+		__sock_put(recv_sockets.sk4->sk);
+	else
+		rxe_release_udp_tunnel(recv_sockets.sk4);
+}
+#undef SK_REF_FOR_TUNNEL
+
 static void rxe_port_event(struct rxe_dev *rxe,
 			   enum ib_event_type event)
 {
@@ -689,8 +704,6 @@ int rxe_register_notifier(void)
 
 void rxe_net_exit(void)
 {
-	rxe_release_udp_tunnel(recv_sockets.sk6);
-	rxe_release_udp_tunnel(recv_sockets.sk4);
 	unregister_netdevice_notifier(&rxe_net_notifier);
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index a222c3eeae12..f48f22f3353b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -17,6 +17,7 @@ struct rxe_recv_sockets {
 };
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
+void rxe_net_del(struct ib_device *dev);
 
 int rxe_register_notifier(void);
 int rxe_net_init(void);
-- 
2.27.0

