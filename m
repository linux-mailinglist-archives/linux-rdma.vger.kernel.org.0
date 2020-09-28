Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FAF27B642
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Sep 2020 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1U2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Sep 2020 16:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1U2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Sep 2020 16:28:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A86C061755
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 13:28:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so2708930wrl.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Sep 2020 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4p8RRU6ikAuXg6EcMvdRPQ2kH9OjBK30Wa5tGlZd/40=;
        b=BnczdhdnITvFgiToi3/uCz7u5/FuYHq77lsC4fvRbYrUNH3euwqR8pGCLIETC11WFB
         1PIpixPB5tAD1XimDyQ6nw17TlOrGSv4cYsijUB6lccn9pnGeWu1uJIxXitpFCTlsI9+
         Nht5BJr3ytuwYnve5sexCoproX1ZSJ8zLAnt5Q7jRw7G2i5xKcDWlJ/vu1R4CCBuHJEu
         Ya0is1jr2rvCcNK/FvLu9TUYF4iZs78z0c/snDTmzxCwTA2BUAdBk5v8DKpow5dQ0uL8
         ANHg8MeiS2zIaT9BxjPWZ5sLGC9QZC/V+RbsZZeaGRcapP+XAVNZufnCqyp9cRrmd00E
         kzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4p8RRU6ikAuXg6EcMvdRPQ2kH9OjBK30Wa5tGlZd/40=;
        b=SZmqyhjLkkcxbECVFqm20ztpnWBwN6rT9FNfSV3cbVhEk94jUroBm1u9Af+wJpegHK
         VQ4ukhQD4UHNiTgp/n5AUiIc8QJTwrp1Tji46tac2q/io+XAfuP9Ii8AbVJIqm21esqR
         q7JS8+7HaoP2dXAgZGnwDBPHXUARPypqWQseiB4NoSvN1AZuTWIzAk+yu+AK8aJ/HfX6
         Gte3Oln2xjVc8gxBwFXcUtUU0NeJU6GZYsL5/B0Q5Otatle+DMFrmSTu24tqs0nIaa4O
         5JpfnhE2WsB9RhRCvMj0iSpoY2HkQMM0v33OasO2NJKSvwDj1fncl47pQ8u8Dm4ZIspi
         8Q1g==
X-Gm-Message-State: AOAM530hvmCz3AgMJJjJy1+gOGed6ze2NZZrkyu6uNNgDASRE2UZp6rp
        wJFRtomIur7ZMK3Ol1x4t+jNGsgDbes=
X-Google-Smtp-Source: ABdhPJyPPrKZgf28Uij17tl5ASOblm3qKrd+vxjiyK8t3Vgdh9OAnQesygJ/ZRZVig98ymH9zydD5g==
X-Received: by 2002:a5d:55c8:: with SMTP id i8mr212802wrw.331.1601324911328;
        Mon, 28 Sep 2020 13:28:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f:5cc2:9fa6:fc6d:771d])
        by smtp.gmail.com with ESMTPSA id j10sm2890248wrn.2.2020.09.28.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 13:28:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
Date:   Mon, 28 Sep 2020 23:26:31 +0300
Message-Id: <20200928202631.52020-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before this patch, the rtnl_link_ops are set only for ipoib network
devices that are created via the rtnl_link_ops->newlink() callback, this
patch fixes that by setting the rtnl_link_ops for all ipoib network
devices. Also, implement the dellink() callback to block users from
trying to remove the base ipoib network device while allowing it only
for child interfaces.

Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
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

