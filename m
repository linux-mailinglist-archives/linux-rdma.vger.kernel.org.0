Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30187BF0B
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfGaLPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 07:15:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfGaLPe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 07:15:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so69204568wre.12
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXWhmCPImLcIeD1MD1tDqsnxPDathHoCivPw/kx+LN0=;
        b=AVYK+CyvRjiyB+5+uZ5mZY3JoM75r2GlXNBRNFikUVAmdYLFSYv1gIBYtozBQFiq3j
         j5znK8q0atxnVPc11Y6BvMMrkQykRcitF97apUbCuLxJHsXt3+NweFJ9NH7VODRjodIt
         NAfl4g82mF/A90FmxbauGP57W55ktqUO6SnzyrzhLawilJzeSIbPxO+51WMw057TjMXU
         F5rvDJUcBzQ6BsK+kETqAgRY1HHhE3TyhQlvtObT7z0LquL9fzfdgAx1IDhy697F9YCO
         47DOAmQn+uuU5wwMAdcDD9NltXtgwVruE3FINN1mvO9TwSlwscCap2ZYpbjYnQ9IQO9h
         SuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXWhmCPImLcIeD1MD1tDqsnxPDathHoCivPw/kx+LN0=;
        b=cuJC7smk461VDhB74KGFXvGnSk7W12rZUCUlbsja709HlH7vFa56ICsxME/P5+kwDn
         h6JZ+xmaD9BBRoL4+czHlADoGkHGTJdFQ7RypErL+G0Xx4E964yJNrjci008lEw+js6M
         nt0gN/tB5hYuNPHuG1NCPXFplHKyxbcNJPM7VS8+traRCQB2qyW/xeiiK5Dey1w7DuQm
         h7gWClV84Z85xdQl08fojFowVswdE84o1R9o8sJyEdTKDeELhuxh40YSUBR0w6AgNKvr
         Sa2AHDwmSUiAdSUGb5zp4Ypx6GejGRcqLFENBi5Lp/Njc1jgW6WQuqVe7xe9nYht4Ziz
         Dkbg==
X-Gm-Message-State: APjAAAW1naMz8O6OwJqRSRXGA90viiJEwekARL+QF+jTXP7+DahxxDdi
        CgZF/UhbYx07a+fvtN/Hp3nxtWYe
X-Google-Smtp-Source: APXvYqyxrFWPcPMs2yiZw9R0qBL2ScbpHNagJ8hXF6+fdogLNEtW+Pe34G2CC7/UGfCnkmPBW91V+Q==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr58169020wrp.102.1564571731986;
        Wed, 31 Jul 2019 04:15:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id h133sm73133732wme.28.2019.07.31.04.15.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 04:15:31 -0700 (PDT)
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
Subject: [PATCH for-next 3/4] RDMA/core: Add common iWARP query port
Date:   Wed, 31 Jul 2019 14:15:02 +0300
Message-Id: <20190731111503.8872-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731111503.8872-1-kamalheib1@gmail.com>
References: <20190731111503.8872-1-kamalheib1@gmail.com>
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
 drivers/infiniband/core/device.c | 85 ++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9773145dee09..8db632a35a30 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1940,6 +1940,72 @@ void ib_dispatch_event(struct ib_event *event)
 }
 EXPORT_SYMBOL(ib_dispatch_event);
 
+static int __iw_query_port(struct ib_device *device,
+			   u8 port_num,
+			   struct ib_port_attr *port_attr)
+{
+	struct in_device *inetdev;
+	struct net_device *netdev;
+	int err;
+
+	memset(port_attr, 0, sizeof(*port_attr));
+
+	netdev = ib_device_get_netdev(device, port_num);
+	if (!netdev)
+		return -ENODEV;
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
+	union ib_gid gid;
+	int err;
+
+	memset(port_attr, 0, sizeof(*port_attr));
+
+	err = device->ops.query_port(device, port_num, port_attr);
+	if (err || port_attr->subnet_prefix)
+		return err;
+
+	if (rdma_port_get_link_layer(device, port_num) !=
+	    IB_LINK_LAYER_INFINIBAND)
+		return 0;
+
+	err = device->ops.query_gid(device, port_num, 0, &gid);
+	if (err)
+		return err;
+
+	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
+	return 0;
+}
+
 /**
  * ib_query_port - Query IB port attributes
  * @device:Device to query
@@ -1953,26 +2019,17 @@ int ib_query_port(struct ib_device *device,
 		  u8 port_num,
 		  struct ib_port_attr *port_attr)
 {
-	union ib_gid gid;
 	int err;
 
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
-	memset(port_attr, 0, sizeof(*port_attr));
-	err = device->ops.query_port(device, port_num, port_attr);
-	if (err || port_attr->subnet_prefix)
-		return err;
-
-	if (rdma_port_get_link_layer(device, port_num) != IB_LINK_LAYER_INFINIBAND)
-		return 0;
-
-	err = device->ops.query_gid(device, port_num, 0, &gid);
-	if (err)
-		return err;
+	if (rdma_node_get_transport(device->node_type) == RDMA_TRANSPORT_IWARP)
+		err = __iw_query_port(device, port_num, port_attr);
+	else
+		err = __ib_query_port(device, port_num, port_attr);
 
-	port_attr->subnet_prefix = be64_to_cpu(gid.global.subnet_prefix);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(ib_query_port);
 
-- 
2.20.1

