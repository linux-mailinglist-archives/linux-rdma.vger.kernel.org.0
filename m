Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D607CE38
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 22:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfGaUZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 16:25:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfGaUZU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 16:25:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so67845799wrm.8
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9BPmTE+kOCXIh8/c7E+/PPwTMY3AF0O7t/3VOscjHQ=;
        b=t8/r4JEAd3hg784MP0U36/9Hcuzi4C0dw6uSnhkxTeqfCDjePS1idn2OrNVlFs1nYD
         7FSV2Q112Y+Qel5z8caEP0Hv1b2M+9HRwGcOjRiVFUYbjDu8byOEHaxMH9XESYk2FuyO
         6dYRfyG1XYR/RrEJkAR/P4NF1imgNTxDWcXFtsh95iwSd4LsSj+ap8yEYato0Q8MQjoi
         NJ10xFfiizi5TxMSbGwAv8FNy1VblDA55WcepngTf8ZppKOI2KRE4MczsJyZ5btMaLWi
         SrCRipPEeubHDX+WHXCQFquBWjqKsZyLHD4juhuWqyssrCnw8/N60OXoirjIMomkOBvk
         PY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9BPmTE+kOCXIh8/c7E+/PPwTMY3AF0O7t/3VOscjHQ=;
        b=H3u8UcExiq9R90sTTlAVY6q1PdLqk/Jxe8qNmwHcWroVfIqaOPh8+TUrYJI8EoGl1c
         upIaeiasbLEr/Yhm/wrtQV9sGHLw/72v+pxF2o5Y96BwtxJv7tYpNMqnw0i31yk1OIjv
         ZTHCbWXRtIij+zfbF8GJ1wYQRp76/DmZ+ziaH+6FXSINzGV8GQCHZY4c84lGkJO4zRmO
         sCorZ6C0u8jALPPt16eAqfiqyW81rgHxeobdSXUN8nfoDHGcgi9rbh9T9XFOSrtmUJ25
         yyd56gAvcw7pbH+pvs3WjaJNfmT/bxEw6dwifvai9DlPzyTS6FoSFWw32plINYhSg23s
         dFMQ==
X-Gm-Message-State: APjAAAVZrIgBPWdEYjoV9W4c5WimJaZ/sPOgAd6KGMzJZUTiM9Uy9/rz
        r3Yw8L00NZcUO5GY5tDEPYXes/rB
X-Google-Smtp-Source: APXvYqz7ANIL00UkOCo8cAjGD7qKdCAW9QeNh3GRkAe6mv15SMEROKLlIfbB87guaEOTw6AnG5k9OQ==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr14843848wrv.299.1564604717673;
        Wed, 31 Jul 2019 13:25:17 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id c4sm54496930wrt.86.2019.07.31.13.25.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:25:17 -0700 (PDT)
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
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V2 4/4] RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
Date:   Wed, 31 Jul 2019 23:24:59 +0300
Message-Id: <20190731202459.19570-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731202459.19570-1-kamalheib1@gmail.com>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that we have a common iWARP query port function we can remove the
common code from the iWARP drivers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
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

