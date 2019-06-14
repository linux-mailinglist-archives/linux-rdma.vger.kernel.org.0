Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584BA450C8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNAiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:38:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37366 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfFNAiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:38:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so626987qkl.4
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOtXNgbngoxIuX+TYoNRbjtRkVCB5+dvW0PZprX/sS4=;
        b=YkNcALoFc20XVSDaJ0tyCe+HIZEyHerXjV56xYAzkfOIsHeZhNX+AMh/JDV+kJmRNT
         kS0KIT6PZbMM9V1+v48ONlEZfUDanL/QW1YlxzPv+D6zGyRpWglxIab6RUDuSzHWuBGo
         tfyBBgRs2c9MKJ9xeDydzV9fYi4qs3bbWA59UR/9724F+ZLZbV873kTvCLUA/mEokwn+
         sruSwHFIgxdTuh5sGBvg7jHLlOVon8TPw/r/Hj9bxuCD90Hl7JJ63Xbpki1tyNAc8stt
         1gHxYExlgqUPL1F3n71MIhQIR+HpOC40+jKxNB0rnMFdlxi+t4HFqOzL5yTtBztX+RE4
         VgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOtXNgbngoxIuX+TYoNRbjtRkVCB5+dvW0PZprX/sS4=;
        b=YjKh3Rx0gKy1Kk1FpYaGnzPGJpwq2rVBAsYKcV3e9+O69eqtXpwWlUiDxGe1tzmDrE
         k/oF+MQsNkCywYOCbKKj6twwDZwbaeCBYvW/Gk5UGzswlfG03qwDDjXTvp5CsIKtez3a
         t7RmwUcRW3TRdSqThA60gtYvZ0mFt+U98EapRaJfob/U9qxEMadzUaguu8htz6ssbrdH
         00bGBMBLDBMNpR/EMjg7/NmgUf90rR8p7qgsxk8msFn1vHb/wRhBr1ct/Ua5dGS4MfMx
         6w/hGAVOKKAkPL5RD3LAQlfHMO6JV8tihBUaM6YAcLZB4f7/z3s5e/De8c+7BJBi2umu
         dwrg==
X-Gm-Message-State: APjAAAU/Ujz25szY01F0utQfW6XdEVg4kbPGgK8ZM8wFMbgFYNIiFmBj
        qkwkoW8BCkYyDNVLmvpfA2hJmwl8ZZASwQ==
X-Google-Smtp-Source: APXvYqybaoE7b1al3VL/6aTN4S+sV2IaVcKEcC1IiBj2skiJof5m+y9E8RCJ62MlWa7DAb716AH/CA==
X-Received: by 2002:a37:b044:: with SMTP id z65mr72902473qke.294.1560472702140;
        Thu, 13 Jun 2019 17:38:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y129sm612554qkc.63.2019.06.13.17.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:38:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaEX-0005E0-1V; Thu, 13 Jun 2019 21:38:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 1/3] RDMA: Move rdma_node_type to uapi/
Date:   Thu, 13 Jun 2019 21:38:17 -0300
Message-Id: <20190614003819.19974-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614003819.19974-1-jgg@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
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
index 585e100706aa8a..588f1d195fd254 100644
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
index f357e03a85a6bc..973514ea17a79b 100644
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

