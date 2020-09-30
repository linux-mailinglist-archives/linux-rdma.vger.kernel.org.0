Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E210227E55E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgI3Jkd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgI3Jkd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 05:40:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D6C061755
        for <linux-rdma@vger.kernel.org>; Wed, 30 Sep 2020 02:40:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so1001309wrp.8
        for <linux-rdma@vger.kernel.org>; Wed, 30 Sep 2020 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAck5fNizBFkwMsJGRdtouJ4+xg9FV+7gBUA/fA5lnE=;
        b=X4Akf8WinHq7+eU7Av4yjYR0d3I8n42gkNFewzYX1qBn22Rr2DL+Odr1o/UquKfKV5
         WK5L2BZVB4mzyXRLdQFGFItpPr5mKG2FTZn3qShSVPLh1/AglpQbBy/eXQd9zbQ+pzBq
         VuIoYg8kWBUzu1P8/cnhEO0Caou6hrd/QoqHCuNnfHNFYUXgwEQuEjSCp7qKCojmzy+E
         h4s8evMD9xN3xdMsT8bO/flMBuq5nz+Ep4j/el95IWd4paWB28f9jU3m5HqlA+WKETwB
         zL3Di1Ro3ujDHmv1hILZjw2hKuZgaApo3TrgZFXfHov+KhnuE+dHSsa5elgfZFzCdh+E
         F41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAck5fNizBFkwMsJGRdtouJ4+xg9FV+7gBUA/fA5lnE=;
        b=hTpE+sG9JWsZ2LQEV5KNDin675d1/iMEjEt6EP3Zrv1+FbGXaHDDW1fXVFnBQxUaAU
         qUvLNFWLj3qWC/3vS9Az72j83elTYnIN5Sp4Lia4B/wkda6xsqF3ul4LNYV4fAEg6/kF
         yChSZKcQVGwDU8/L2QTJgkVCjQiLjDmf+6squi6AXtQmG4faxxlyBD4inYp00re7BksY
         XbmuayJQaZxbSJnLv+k6/LB3IC2FpW7+eBUaMWm6k7KYYBVr+6B+gyPNGcBVIus6lse2
         iIwMK/TYNWPsvEUUrw1H1orpokIM8AA6cDS0NO4h/tTvrbDBVuQK9WoSXcwPdl803NYx
         IbrQ==
X-Gm-Message-State: AOAM532TqtY4ZQaHGRdqwWyjuLksoBSS/X6HylNOgabBsjWB+bnpdH7w
        bb588KScS28+ZNVfL/8ixcb/jUv/G4g=
X-Google-Smtp-Source: ABdhPJwaNRE+8FYyBsLjdz19V/sUCLpo+O1J9C1IqlA9rtDl+bVxNtwMIRrtHSug7z8pI7Mz9WQxXw==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr2118781wrc.258.1601458831005;
        Wed, 30 Sep 2020 02:40:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f:5cc2:9fa6:fc6d:771d])
        by smtp.gmail.com with ESMTPSA id n21sm1732787wmi.21.2020.09.30.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 02:40:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc v2] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
Date:   Wed, 30 Sep 2020 12:40:13 +0300
Message-Id: <20200930094013.156839-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid inconsistent user experience for PKey interfaces that are
created via netlink vs PKey interfaces that are created via sysfs and the
base interface, make sure to set the rtnl_link_ops for all ipoib network
devices, so the ipoib attributes will be reported/modified via iproute2
for all ipoib interfaces regardless of how they are created.

Also, after setting the rtnl_link_ops for the base interface, implement
the dellink() callback to block users from trying to remove it.

Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
v2: Update commit message.
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c    |  2 ++
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c | 11 +++++++++++
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index ab75b7f745d4..96b6be5d507d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2477,6 +2477,8 @@ static struct net_device *ipoib_add_port(const char *format,
 	/* call event handler to ensure pkey in sync */
 	queue_work(ipoib_workqueue, &priv->flush_heavy);
 
+	ndev->rtnl_link_ops = ipoib_get_link_ops();
+
 	result = register_netdev(ndev);
 	if (result) {
 		pr_warn("%s: couldn't register ipoib port %d; error %d\n",
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 38c984d16996..d5a90a66b45c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -144,6 +144,16 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
 	return 0;
 }
 
+static void ipoib_del_child_link(struct net_device *dev, struct list_head *head)
+{
+	struct ipoib_dev_priv *priv = ipoib_priv(dev);
+
+	if (!priv->parent)
+		return;
+
+	unregister_netdevice_queue(dev, head);
+}
+
 static size_t ipoib_get_size(const struct net_device *dev)
 {
 	return nla_total_size(2) +	/* IFLA_IPOIB_PKEY   */
@@ -158,6 +168,7 @@ static struct rtnl_link_ops ipoib_link_ops __read_mostly = {
 	.priv_size	= sizeof(struct ipoib_dev_priv),
 	.setup		= ipoib_setup_common,
 	.newlink	= ipoib_new_child_link,
+	.dellink	= ipoib_del_child_link,
 	.changelink	= ipoib_changelink,
 	.get_size	= ipoib_get_size,
 	.fill_info	= ipoib_fill_info,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 30865605e098..c60db9f3f5ac 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -129,6 +129,8 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 		goto out_early;
 	}
 
+	ndev->rtnl_link_ops = ipoib_get_link_ops();
+
 	result = register_netdevice(ndev);
 	if (result) {
 		ipoib_warn(priv, "failed to initialize; error %i", result);
-- 
2.26.2

