Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC273C76B
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFXHk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 03:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjFXHkx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 03:40:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B22735
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687592452; x=1719128452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EmOB/sEta56GvgMyru1ov3wqtZzdY0u3w1d54u0ioq8=;
  b=EJjKufa4OJrOfTk3OsFk4SBvUmTcrtNnRiI1r2a/TvzluQVW25vUySaF
   poAlg0h24carh9kr8H/eRG9JTqkzodgaQfc1mBvzXdRaJJGotGb+a1c0W
   v0zrJmWyed1QcD/YOUP0jClMzTQE73cWBBIcuCC7z98GTMxsmZU38Fl0O
   /183dabULgViFJ+nWM1Au3U/kVi6xtys2LjSF6PYV8F0I5HlqEk5yfOT8
   K/lbVkLL4Gpzv2/Zf87Wp3uSdSq9PrUooFO0Gk4FLNe9fsKwVp29i3vxe
   aVq1OS1jc8cyz94D2vgOF9FLWhXQ85qp5AMysTi2j06QTozgnUZaph0Uo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340517888"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="340517888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 00:40:18 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="750240707"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="750240707"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2023 00:40:16 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v7 4/8] RDMA/rxe: Implement dellink in rxe
Date:   Sat, 24 Jun 2023 15:39:23 +0800
Message-Id: <20230624073927.707915-5-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230624073927.707915-1-yanjun.zhu@intel.com>
References: <20230624073927.707915-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index c15d3c5d7a6f..ac7e7b0a9dc9 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -168,10 +168,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
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
@@ -208,9 +210,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
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
index 8bdf1b24a3ac..632c0a5fcadb 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -540,6 +540,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
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
@@ -699,8 +714,6 @@ int rxe_register_notifier(void)
 
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

