Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0F6FA1B3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjEHH6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjEHH6E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 03:58:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF719D6D
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 00:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683532676; x=1715068676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DSfAzSMf/l2Xaeaq4nN9qSmuEXyLXgaiESrEmDgD0Po=;
  b=J0adXh+NVR3fDWf4ZX9BKVIJStlNGuRiI2lYyqFNBJ4wd/rVoRMHemZM
   TboOGeAWk1Rp39Vnukx6rxkp3Fz8vmT9r81jzckRgBcVCU5ykxYjP1Ddp
   lWioX+zozxSs9o6xAAwmxv34VTjuKFs4z6933ibcG/3OtnD1/vw020nAH
   AZDywpzZzxuZaOCOFQbFBQzvrCe2tJoMR0/GTStIu6tiUxvoGRagzFpmD
   oFtQaSo5WlMUO6ZPKhWD0H0dVJrlmG+yCd/SXsfblz6RYjf6UkxZnesVp
   Ngs6OXbn1y9SeMhl3dkaaRRvRxxNAY75klR2fPxdeJSdIKcFPqrvDWWAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="415143108"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="415143108"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="763297478"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="763297478"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2023 00:57:54 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: [PATCH v6.4-rc1 v5 4/8] RDMA/rxe: Implement dellink in rxe
Date:   Mon,  8 May 2023 15:56:32 +0800
Message-Id: <20230508075636.352138-5-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230508075636.352138-1-yanjun.zhu@intel.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
index 1b98efa2cf66..6071533d67c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -533,6 +533,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
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
@@ -692,8 +707,6 @@ int rxe_register_notifier(void)
 
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

