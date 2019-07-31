Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69BE7CE37
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 22:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfGaUZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 16:25:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfGaUZT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 16:25:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so71034386wru.13
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7b3G8Y6WOFM4zhy7Si5KbngIYnRPAMHQHBQAU8QRr4Y=;
        b=O5y8+bmz3Bg2JgtaQEJVOGO67OD4DLGo/XBecS0b029mp8zbk+znfN4Dq+G6Phk0iB
         gKSZbw2tZ89uq3CTo3M6l9L0HaVpbf0wYy1oVDCshkErh7mrc71ctn0jEOFXf2VTPO8o
         dtKktgdp0LwblWtT6L4cqFtsTaBQd1SAv+zeh9DziO7wWbNAwBazU6CWpnh+bLTnk+AF
         wu9atwxek3vb2Iyk+tSgB8/w2hpuzz0KvsD1XpGUwYr4QhptbKXkHuetV50fC6imAEaA
         1JG+XwZL3LtKv5jqtAhLWUl+eNt6srT6+SCZK1+VuqVqaaUFE3+JoUmC5H8sSlrha8Az
         ISbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7b3G8Y6WOFM4zhy7Si5KbngIYnRPAMHQHBQAU8QRr4Y=;
        b=D8S4xoQ2hp+85q3j65ELCJU3sM44R76c6JSu86ih6ajkGfQn8/35+ve4w3aIHVCTBM
         jvyw1u3Irtoorms+wyjxCg6qNH7Ek4xz0uvmNop0kkPB9HoVL7KD8u1eJrs/Gurqrf/d
         op5jw+kYKW2vHbEUA85U324Efgvn2cAGuWnhSP4I3csb5+kMidj6M5khytWRGCmtMgNb
         weSUKPwgI1Orh6HnUngi3Hs+crA1kGM3eK5SQZ0vM+N1exwc5p4BlvaWumvDRA0L7w0j
         fdvxMThYseomnhDZd+u99HYrL7/cCIGdSZPH3MwAFAUUumGaOUQ0gt9klqrvh3N5wsWf
         3Yhg==
X-Gm-Message-State: APjAAAU12kIdiTNSOTdo3KE0Vh4gw83sDhWh1GmRBnglT14oD0P6LH+9
        MmuvJyOCvwwKtlIe0m2FaX0ZMo6N
X-Google-Smtp-Source: APXvYqweIOQVB5a0XX1CxXyJ0Ppsh6rf9TUec2k34K877+GpntWFElxLsAvFJHse4mSbppxuR8CtoQ==
X-Received: by 2002:adf:b612:: with SMTP id f18mr126770297wre.97.1564604715841;
        Wed, 31 Jul 2019 13:25:15 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id c4sm54496930wrt.86.2019.07.31.13.25.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 13:25:15 -0700 (PDT)
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
Subject: [PATCH for-next V2 3/4] RDMA/core: Add common iWARP query port
Date:   Wed, 31 Jul 2019 23:24:58 +0300
Message-Id: <20190731202459.19570-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731202459.19570-1-kamalheib1@gmail.com>
References: <20190731202459.19570-1-kamalheib1@gmail.com>
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
index 9773145dee09..860c08ca49e7 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1940,31 +1940,64 @@ void ib_dispatch_event(struct ib_event *event)
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
@@ -1974,6 +2007,28 @@ int ib_query_port(struct ib_device *device,
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
+	if (rdma_node_get_transport(device->node_type) == RDMA_TRANSPORT_IWARP)
+		return iw_query_port(device, port_num, port_attr);
+	else
+		return __ib_query_port(device, port_num, port_attr);
+}
 EXPORT_SYMBOL(ib_query_port);
 
 static void add_ndev_hash(struct ib_port_data *pdata)
-- 
2.20.1

