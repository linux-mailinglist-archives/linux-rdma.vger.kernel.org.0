Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEA84992
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfHGKb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:31:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39803 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfHGKb7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:31:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so697809wra.6
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rM66R35YJmiSJYAAvI9ET9dGMarw1Nrc/qQCzBSeB0c=;
        b=RgzBZp3zZC2033lDiEk9u91ZEZ5lglW1fbBI1PRVBKADN/+FNBkbQj4VsX2ZONyNSL
         DMR0tVG+gsjKIrZ8Zyv/1QwzphUF5F3G9+BJ18Qv2+g2aGXmZHML7uEWAPPZegUXMohY
         Jdq54jvBplFcDBv1HCWnv1rctLLgrn37xkVwoQhxo71WB8UxsYqZlIy/iSQ46+h1Shdm
         bs/QpTsIO5dN0FPixF8EQL9cn9DplVh9GUlakhWRST4UoEYQSYY3lwhEBFWqknh2E0LG
         H8Vp7s7bnvFQDOzNP8EPuNOrKBO7BpWdQMt17j25ByeIAW6luYmjRLqyJHeIHdpKdOId
         RMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rM66R35YJmiSJYAAvI9ET9dGMarw1Nrc/qQCzBSeB0c=;
        b=CeHPGxOnERnD0N6OFt1OLj+V/+nxtSu90spffBCBAH2AIlS6OiiODMHOKPmGF8gtgs
         G4DmSyYa+6P6T/LcMYLeRwUoDuEmMYcYVVY9XoIpzV48mKdIHcgU2BUJ7n9zqhfyvVIO
         hwtViAY6k7oH9WtAujc48mmraxjQzKPiWsKrAFZ8Yj5lcB8uR4FcKO6XQMJegtypit2U
         byNxaCA8EK3cEnaYmeH77gExi9OzXG1G/VZcojl9kPUnQafFiSd+z/lwpT7XnwnQxC6+
         3SjdLGNMcYNGKt3Z+X7NHk3agOZ5UOgT57Lx3NaK5e90nTj7Iy7msI6+wqRVb3zipqCw
         KHNQ==
X-Gm-Message-State: APjAAAX3TlsEWhwGUBILxNC6Lk9Ms81uFL5TJ+LpoGQ/W/sxcK++Uv7Z
        oq1ckz/ofBrKmMt8EQcn39E+KWW+VIo=
X-Google-Smtp-Source: APXvYqztJHQ/hLUn7BFf8nhbFWK3Kgga9nOcG45oe9FJ3WSVvFFovo1XwCHoNurU/41rq0bA4QEEXw==
X-Received: by 2002:adf:dbcc:: with SMTP id e12mr684989wrj.205.1565173916790;
        Wed, 07 Aug 2019 03:31:56 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id o3sm79713845wrs.59.2019.08.07.03.31.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:31:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V4 4/4] RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
Date:   Wed,  7 Aug 2019 13:31:38 +0300
Message-Id: <20190807103138.17219-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807103138.17219-1-kamalheib1@gmail.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that we have a common iWARP query port function we can remove the
common code from the iWARP drivers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 25 ---------------------
 drivers/infiniband/hw/cxgb4/provider.c      | 24 --------------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 11 ---------
 3 files changed, 60 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 5848e4727b2e..dcf02ec02810 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -991,33 +991,8 @@ static int iwch_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 static int iwch_query_port(struct ib_device *ibdev,
 			   u8 port, struct ib_port_attr *props)
 {
-	struct iwch_dev *dev;
-	struct net_device *netdev;
-	struct in_device *inetdev;
-
 	pr_debug("%s ibdev %p\n", __func__, ibdev);
 
-	dev = to_iwch_dev(ibdev);
-	netdev = dev->rdev.port_info.lldevs[port-1];
-
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
-	if (!netif_carrier_ok(netdev))
-		props->state = IB_PORT_DOWN;
-	else {
-		inetdev = in_dev_get(netdev);
-		if (inetdev) {
-			if (inetdev->ifa_list)
-				props->state = IB_PORT_ACTIVE;
-			else
-				props->state = IB_PORT_INIT;
-			in_dev_put(inetdev);
-		} else
-			props->state = IB_PORT_INIT;
-	}
-
 	props->port_cap_flags =
 	    IB_PORT_CM_SUP |
 	    IB_PORT_SNMP_TUNNEL_SUP |
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 5e59c5708729..d373ac0fe2cb 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -305,32 +305,8 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 			   struct ib_port_attr *props)
 {
-	struct c4iw_dev *dev;
-	struct net_device *netdev;
-	struct in_device *inetdev;
-
 	pr_debug("ibdev %p\n", ibdev);
 
-	dev = to_c4iw_dev(ibdev);
-	netdev = dev->rdev.lldi.ports[port-1];
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
-	if (!netif_carrier_ok(netdev))
-		props->state = IB_PORT_DOWN;
-	else {
-		inetdev = in_dev_get(netdev);
-		if (inetdev) {
-			if (inetdev->ifa_list)
-				props->state = IB_PORT_ACTIVE;
-			else
-				props->state = IB_PORT_INIT;
-			in_dev_put(inetdev);
-		} else
-			props->state = IB_PORT_INIT;
-	}
-
 	props->port_cap_flags =
 	    IB_PORT_CM_SUP |
 	    IB_PORT_SNMP_TUNNEL_SUP |
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index d169a8031375..8056930bbe2c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -97,18 +97,7 @@ static int i40iw_query_port(struct ib_device *ibdev,
 			    u8 port,
 			    struct ib_port_attr *props)
 {
-	struct i40iw_device *iwdev = to_iwdev(ibdev);
-	struct net_device *netdev = iwdev->netdev;
-
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
 	props->lid = 1;
-	if (netif_carrier_ok(iwdev->netdev))
-		props->state = IB_PORT_ACTIVE;
-	else
-		props->state = IB_PORT_DOWN;
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-- 
2.20.1

