Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A76958CF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 07:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjBNGIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 01:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBNGI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 01:08:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2889CA26
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676354901; x=1707890901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/onztKzmNUrwn0GZ5MtEx/OaV2N7nM7h6I+5k8EvDXM=;
  b=P6VF9Pq7JxK8hHcrtjzoQFT+1YqBHWLNHlAsj2wxfsmbN1+6MPFzh11v
   Xzf4GhwljNS1IIcJFJo3p01jKTWkt14TZz4hlnkVpJnj68SRi0DJFIW8Q
   9FLi40BtVv+6GKIBkPfUV55LXBJA28SJkJPlM21m/rh0ZTBZCd5PrWFfN
   oNimj0vPDy0wUG7qPbuSaTVIu6+ybUyIRk3FmsbYyDRxbPJcFcWXFrqPh
   yZ5fDH/6pUVl8/Lr3isJ4uMIUaYWvDv7stTaHvQNIlpETY/W/Q/4DdwAl
   eb2MvR0RUTYpk9BcAGr40N1+msJz5Ierg1edXSJKcQZptNlYrpGKCPAym
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332400579"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332400579"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618924819"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618924819"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 22:08:07 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com, yanjun.zhu@intel.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 4/8] RDMA/rxe: Implement dellink in rxe
Date:   Tue, 14 Feb 2023 14:06:30 +0800
Message-Id: <20230214060634.427162-5-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230214060634.427162-1-yanjun.zhu@intel.com>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
2.34.1

