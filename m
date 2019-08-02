Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1D7F478
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfHBJcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 05:32:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390383AbfHBJcb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 05:32:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so76535136wrs.3
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2019 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkDRW0Y2mF3tUegdEfXM0wasdXG02NuMhIfOqm1Au98=;
        b=nH0rqfC2YtIIsELe5irFjSuOL+juXHtctplB1+y924icPJX35vUc7ip89X4nDKzC1n
         f2XuRQl8IfJ88YPvsrpGRX1x6cgXu4oyyrYOjgCgMgd7GTot1pM47RxEu6TF4j8S22Wf
         NJG4z4aHzovY76+0cbkIHRLP0hrN30a3GRTvpDnHA1RibEef7gK+7HP1Qu+kRNzuXMHS
         vtvX2NRMOBzJGga9BZ8GAZm7vTlA1bmu/gY1x2kYLu/jTS9ezgEEqJEElRcezdOkfWCl
         pvA5k1gBKu4/nrpqqigfHqfAsgL2Hh4DZyNRxwgiFmqGyD3NyeKMmZauausG7DbeoY6o
         q5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkDRW0Y2mF3tUegdEfXM0wasdXG02NuMhIfOqm1Au98=;
        b=UvWPNUI5DxcBfdzcviJl2rqyXUXG+G9rQZUVNXaZ96jYdXCJnfYzGMxyff1vT5Uv4b
         cCs11FnluP8X0xjT7iP9Dy3/oEtEVcJG834qDfcsbO3QLbrHS/eYviRlcJQ4vy9ccEAz
         fE5eMPuDfRBDzyGThILyMb3rOuPALFWX0D43290UFwkEgMuHCljV8m/XWK1LAzcG/aNa
         ZZJcidY7ImD41vt4XyPFLBFrf2cV1nUF/4jnfmI8azSekspkJPMLShIwPP4y8QMXmkh0
         hFkDIhC1T5vuekvE+0SB8gsbnQYedZipUeDSQnDKRY46atwAM0Kj3aFgwZhDhGnRvUyi
         5OfQ==
X-Gm-Message-State: APjAAAUe+ePlZl3h+BCxKFIvoMe/tFManah5SEMh3O9HwoUqLV3FGOOI
        BnypulYdLCaNmq7XuhgoBKad5PF3
X-Google-Smtp-Source: APXvYqxrpepY9MyfH9xOHqknDx8tRBTTjqmztXCV2UsqTzjRlc7puqpD7LQ+8aTockbdeF1Ve2Zmkg==
X-Received: by 2002:adf:b60c:: with SMTP id f12mr111875509wre.231.1564738349042;
        Fri, 02 Aug 2019 02:32:29 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id w23sm80651404wmi.45.2019.08.02.02.32.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:32:28 -0700 (PDT)
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
Subject: [PATCH for-next V3 3/4] RDMA/core: Add common iWARP query port
Date:   Fri,  2 Aug 2019 12:32:09 +0300
Message-Id: <20190802093210.5705-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802093210.5705-1-kamalheib1@gmail.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for a common iWARP query port function, the new function
includes a common code that is used by the iWARP devices to update the
port attributes like max_mtu, active_mtu, state, and phys_state, the
function also includes a call for the driver-specific query_port callback
to query the device-specific port attributes.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 87 ++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c3576c7d2e8f..8892862fb759 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1939,31 +1939,64 @@ void ib_dispatch_event(struct ib_event *event)
 }
 EXPORT_SYMBOL(ib_dispatch_event);
 
-/**
- * ib_query_port - Query IB port attributes
- * @device:Device to query
- * @port_num:Port number to query
- * @port_attr:Port attributes
- *
- * ib_query_port() returns the attributes of a port through the
- * @port_attr pointer.
- */
-int ib_query_port(struct ib_device *device,
-		  u8 port_num,
-		  struct ib_port_attr *port_attr)
+static int iw_query_port(struct ib_device *device,
+			   u8 port_num,
+			   struct ib_port_attr *port_attr)
 {
-	union ib_gid gid;
+	struct in_device *inetdev;
+	struct net_device *netdev;
 	int err;
 
-	if (!rdma_is_port_valid(device, port_num))
-		return -EINVAL;
+	memset(port_attr, 0, sizeof(*port_attr));
+
+	netdev = ib_device_get_netdev(device, port_num);
+	if (!netdev)
+		return -ENODEV;
+
+	dev_put(netdev);
+
+	port_attr->max_mtu = IB_MTU_4096;
+	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
+
+	if (!netif_carrier_ok(netdev)) {
+		port_attr->state = IB_PORT_DOWN;
+		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
+	} else {
+		inetdev = in_dev_get(netdev);
+
+		if (inetdev && inetdev->ifa_list) {
+			port_attr->state = IB_PORT_ACTIVE;
+			port_attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
+			in_dev_put(inetdev);
+		} else {
+			port_attr->state = IB_PORT_INIT;
+			port_attr->phys_state =
+				IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
+		}
+	}
+
+	err = device->ops.query_port(device, port_num, port_attr);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int __ib_query_port(struct ib_device *device,
+			   u8 port_num,
+			   struct ib_port_attr *port_attr)
+{
+	union ib_gid gid = {};
+	int err;
 
 	memset(port_attr, 0, sizeof(*port_attr));
+
 	err = device->ops.query_port(device, port_num, port_attr);
 	if (err || port_attr->subnet_prefix)
 		return err;
 
-	if (rdma_port_get_link_layer(device, port_num) != IB_LINK_LAYER_INFINIBAND)
+	if (rdma_port_get_link_layer(device, port_num) !=
+	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
 	err = device->ops.query_gid(device, port_num, 0, &gid);
@@ -1973,6 +2006,28 @@ int ib_query_port(struct ib_device *device,
 	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
 	return 0;
 }
+
+/**
+ * ib_query_port - Query IB port attributes
+ * @device:Device to query
+ * @port_num:Port number to query
+ * @port_attr:Port attributes
+ *
+ * ib_query_port() returns the attributes of a port through the
+ * @port_attr pointer.
+ */
+int ib_query_port(struct ib_device *device,
+		  u8 port_num,
+		  struct ib_port_attr *port_attr)
+{
+	if (!rdma_is_port_valid(device, port_num))
+		return -EINVAL;
+
+	if (rdma_protocol_iwarp(device, port_num))
+		return iw_query_port(device, port_num, port_attr);
+	else
+		return __ib_query_port(device, port_num, port_attr);
+}
 EXPORT_SYMBOL(ib_query_port);
 
 static void add_ndev_hash(struct ib_port_data *pdata)
-- 
2.20.1

