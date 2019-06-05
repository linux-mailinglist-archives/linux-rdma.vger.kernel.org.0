Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F063635E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFESdA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 14:33:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44955 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfFESc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 14:32:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so5764527qkb.11
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqCTOifvtcvxDBbgEi2xfzupUTlNPAtSpyUbitXWnTw=;
        b=TEySW2Qj5ZmitqxfAJvXKDC+69/G9RxHtKhxbTYic1CQE8+swuv+LoqjZ5Ea06w/XV
         vu9DKJNecPEA9bYzJkBAjr4GDhlZAxFvdfpveUVRZO+hZlKSkrcKu8hTwq4AQf0EGrs4
         +hhMPmJLoI7fOeT+o/8MvdligVhGxwu9nl3Xq4pfMya3jR4f52TVVxY2vXBtHVr4hSpO
         JGvMzYPYw1MLn9baKwAm1/z0dN6nsc2TctQStZgEHOeDx8+tTjXz8UreMLD4Og6t7mON
         HGW2swM7QERMxoczaKQb4MFp3VPJjcstioQd+oP1rLOWB+8YZqifC73RTn5sq4oWwciA
         u/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqCTOifvtcvxDBbgEi2xfzupUTlNPAtSpyUbitXWnTw=;
        b=Jzx3BLAfqUL1DhplRJhZvobFhe6O77SilnLD2D7drxR5vfEEaaJ4asfH1CMm/B85q1
         bKAevg79hU95fqI7bLamcziIczgJK83ciFOnS90/gf7Ne83QjqzocTyOTQS//uoVPTLq
         So6w3/rHNR5Tjsxz62BAjECD9sfNS/hMncXcyCFRPTq1Hs7jQBtmo74lZl/VvpiXkGSh
         dzGE7lpWf+b5wvAk+5vaA5ij+2ZokRlLrZuzp5mj2n2U9jWyw2Cr9657tP+ZYLPIkxGK
         rxrN/vp8zZUpGp7bNX/L4CNukVKEFAHeLSUUhYet/Ufxr3Ac5N4ynvZ0KXgx6g4/AHcc
         8XYw==
X-Gm-Message-State: APjAAAW7Q5Jn5YBorQitV0ZQ4NgO7P00LLbGbie2uEqRu3dGa6RQoBeQ
        AMVaWp5lJXa+DSy4mPoHAJ9GXk6fVYgOtQ==
X-Google-Smtp-Source: APXvYqzH27AWExluOoAJ/SyWHmEPBx2FgWocJujQjiMbTgzNQCUGogk/WQz5LW6c7OLl5jMqpZ2S7g==
X-Received: by 2002:a37:4781:: with SMTP id u123mr34669330qka.284.1559759578741;
        Wed, 05 Jun 2019 11:32:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l11sm10129832qkk.65.2019.06.05.11.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 11:32:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYaiX-0001q7-AO; Wed, 05 Jun 2019 15:32:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Date:   Wed,  5 Jun 2019 15:32:50 -0300
Message-Id: <20190605183252.6687-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605183252.6687-1-jgg@ziepe.ca>
References: <20190605183252.6687-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This enum is exposed over the sysfs file 'node_type' and over netlink via
RDMA_NLDEV_ATTR_DEV_NODE_TYPE, so declare it in the uapi headers.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/verbs.c  |  2 +-
 include/rdma/ib_verbs.h          | 13 +------------
 include/uapi/rdma/rdma_netlink.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e666a1f7608d86..56af18456ba776 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -209,7 +209,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
 EXPORT_SYMBOL(ib_rate_to_mbps);
 
 __attribute_const__ enum rdma_transport_type
-rdma_node_get_transport(enum rdma_node_type node_type)
+rdma_node_get_transport(unsigned int node_type)
 {
 
 	if (node_type == RDMA_NODE_USNIC)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index cdfeeda1db7f31..d5dd3cb7fcf702 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -132,17 +132,6 @@ struct ib_gid_attr {
 	u8			port_num;
 };
 
-enum rdma_node_type {
-	/* IB values map to NodeInfo:NodeType. */
-	RDMA_NODE_IB_CA 	= 1,
-	RDMA_NODE_IB_SWITCH,
-	RDMA_NODE_IB_ROUTER,
-	RDMA_NODE_RNIC,
-	RDMA_NODE_USNIC,
-	RDMA_NODE_USNIC_UDP,
-	RDMA_NODE_UNSPECIFIED,
-};
-
 enum {
 	/* set the local administered indication */
 	IB_SA_WELL_KNOWN_GUID	= BIT_ULL(57) | 2,
@@ -164,7 +153,7 @@ enum rdma_protocol_type {
 };
 
 __attribute_const__ enum rdma_transport_type
-rdma_node_get_transport(enum rdma_node_type node_type);
+rdma_node_get_transport(unsigned int node_type);
 
 enum rdma_network_type {
 	RDMA_NETWORK_IB,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 41db51367efafb..f588e8551c6cea 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -147,6 +147,18 @@ enum {
 	IWPM_NLA_HELLO_MAX
 };
 
+/* For RDMA_NLDEV_ATTR_DEV_NODE_TYPE */
+enum {
+	/* IB values map to NodeInfo:NodeType. */
+	RDMA_NODE_IB_CA = 1,
+	RDMA_NODE_IB_SWITCH,
+	RDMA_NODE_IB_ROUTER,
+	RDMA_NODE_RNIC,
+	RDMA_NODE_USNIC,
+	RDMA_NODE_USNIC_UDP,
+	RDMA_NODE_UNSPECIFIED,
+};
+
 /*
  * Local service operations:
  *   RESOLVE - The client requests the local service to resolve a path.
-- 
2.21.0

