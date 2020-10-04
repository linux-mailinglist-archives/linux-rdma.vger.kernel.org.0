Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169CF282AF6
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgJDNaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJDNaC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Oct 2020 09:30:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535D6C0613CE
        for <linux-rdma@vger.kernel.org>; Sun,  4 Oct 2020 06:30:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so6676253wrv.1
        for <linux-rdma@vger.kernel.org>; Sun, 04 Oct 2020 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3ZvK3IhwtC1uwer5yQxVeXET/TveUYEN4MY0qOkLcA=;
        b=tEwtCyO+fIJH898MOxxzNHtjLo2WL5mzpUC2aIFwFxT8Q7oigrqt4bu7W+zCOXLQhu
         znAs20aiin9gHwJzuIBq5Sjxnht+t4COJDyLuYjgLZvU8m76nYUU1GqlIj0waqKcvFiu
         zaaO+n71cB54M+TntYTku7um+BPHiyMu1S6S1WX+Ocx9sZaLj2llSP6V37x29tDH1EJl
         yk+ZQy/eJ6gRhQ6ywyEGlWDBGqsMXBzJlvhXjlLDF3MLOaf6svIbYqMS8QLOQ6EDxh18
         +fsST4kXxewr0kYXEnS2wPIAIAoIdf0JNEdUoib2F+i3YzhtbG2whaB9uNVUJu6efYPA
         2NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3ZvK3IhwtC1uwer5yQxVeXET/TveUYEN4MY0qOkLcA=;
        b=Odnmv8erdjn+Ze6b82PQ61SE6jXQCzfQky8ADY/EA0kKiFmaKTLmGrSHWvT7VmgKgw
         tp7xml4rSm5QzZbP4R4qevz6cHUNtXYOK+pWtBE1NjYYRCTGWyq0YjfJp/HdAcHofrre
         aniFTk7A3KSJWTptEkWd0g4IFhetP78gE0v7ojBojZoRPJvb/gRuDCuhPNOyth+aOgFR
         s9uu7FRuS40qE6PKQaMBtW0hxq9R5Na9wO5Vp479n0Ol43p5J4gWyhFFSLt85Qn5bxge
         zVnwuNhp60QInLCgZq6ffTJZhad3dvivM/LySV1jpefTG2H/qcAC6zn867x3Uu+d1RnI
         aWqw==
X-Gm-Message-State: AOAM531Mh7kHP5pFcAA0LLez6qx9Z79S6lxqRH+BlsVMqRS3vwpT+54q
        3IMdTFBc7+F4CtxhAjS334/B+0cUuU0=
X-Google-Smtp-Source: ABdhPJwv0NgA6K2Zv6OLpDwFfdbfH0wjY00JLNNQBgl79xEmwob+YEaBXF0FwuHv9YodOfMJ8a6mSw==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr6469265wrv.51.1601818198670;
        Sun, 04 Oct 2020 06:29:58 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id c16sm9456068wrx.31.2020.10.04.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 06:29:58 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc v3] RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces
Date:   Sun,  4 Oct 2020 16:29:48 +0300
Message-Id: <20201004132948.26669-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid inconsistent user experience for PKey interfaces that are
created via netlink VS PKey interfaces that are created via sysfs and
parent interfaces, make sure to set the rtnl_link_ops for all ipoib
network devices (PKeys and parent interfaces), so the ipoib attributes
will be reported/modified via iproute2 for all ipoib interfaces
regardless of how they are created.

Also, after setting the rtnl_link_ops for the parent interface, implement
the dellink() callback to block users from trying to remove it.

Fixes: 9baa0b036410 ("IB/ipoib: Add rtnl_link_ops support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
v3: Move the setting of rtnl_link_ops to ipoib_vlan_add() and update
    the commit message.
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
index 30865605e098..4c50a87ed7cc 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -195,6 +195,8 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 	}
 	priv = ipoib_priv(ndev);
 
+	ndev->rtnl_link_ops = ipoib_get_link_ops();
+
 	result = __ipoib_vlan_add(ppriv, priv, pkey, IPOIB_LEGACY_CHILD);
 
 	if (result && ndev->reg_state == NETREG_UNINITIALIZED)
-- 
2.26.2

