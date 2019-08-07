Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4884990
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfHGKb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:31:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfHGKb4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:31:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so81250893wme.4
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkDRW0Y2mF3tUegdEfXM0wasdXG02NuMhIfOqm1Au98=;
        b=L2qLJ4dITDD9rBa1nqF/tfayQhB/aEmOY5oMXss4ixJ0xNcoTv+xJPWZ5XGzRj2zJ4
         hGiXFIQXG5/GMlCNGHkRsO003lBw8qmW1cbJAKthM1VT8Q4jQOhqpR0LtLM7Kr+iDk3p
         og52XmjhYG2754lHY9pBuHngAwPUm6C7QDxQtw2lr6yIYYiBgutJXiBKafqqKVTzPY1q
         pK8we79HzB7HFU7FlJj6u9R9Q/KYZSMJYTd1MRTUEaZ672tMaOz3Ahx20Hh52osqLnuZ
         EskGgH6YiWvuvkXA8V9+PwkpaBx4bc8MxqBDlrf1A+zin2JHYOI0YK6IrSu9FfEdIsiz
         x1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkDRW0Y2mF3tUegdEfXM0wasdXG02NuMhIfOqm1Au98=;
        b=pBpJ+OmsvuEttzrHSmaoYQprlDiqysBGjNEMgE9tLCk/nCh5ep8LxMr0mGscmJwu6V
         U75WOnx/oY1zyzGP49RHOlnYLMfMLZW0fZd350N7qOKU1QcKBCVi6kHxVf1JDZlippUT
         3egSu/gLJdjo+cul1w9EsAd1es4efzpbhzC5v2P7bxIG79YSLFBkRvCFxf1j4lqmnQtF
         kD7TWEKhouTss10tTA2he/dlB51hlMiTDjiOLUySGWM53TCN7f/uOA7QMDF71VfjFD02
         CEs9rH0wSqAN44uWSuk+udpEesTsfTgHITAzLrK9CJ23BX1fURIIG4YMyquNazZD0kui
         TgCA==
X-Gm-Message-State: APjAAAWRiJimMYS21KBOHhQaDO2XWP+8Jgd3hu1iidDsjpb7eSL7DLjI
        YaEidTUqMk2At5Rr3UUqHW4yXOflgNs=
X-Google-Smtp-Source: APXvYqysLSl0BETbYYZVPOWnjP6BdzHe1djYvmQNhrMDicIJX1SzoZD898zrZi8BYgipWna8Maw1gA==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr10585425wmg.28.1565173914316;
        Wed, 07 Aug 2019 03:31:54 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id o3sm79713845wrs.59.2019.08.07.03.31.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:31:53 -0700 (PDT)
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
Subject: [PATCH for-next V4 3/4] RDMA/core: Add common iWARP query port
Date:   Wed,  7 Aug 2019 13:31:37 +0300
Message-Id: <20190807103138.17219-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807103138.17219-1-kamalheib1@gmail.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
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

