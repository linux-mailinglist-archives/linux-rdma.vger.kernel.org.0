Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A876FC2AB4
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfI3XR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44091 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfI3XRZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so6472393pfn.11
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gb3+EeVbu+Tx4lpzyZCMvzRZ5k8a3eMcXGGIPrVaBOw=;
        b=boyJ1QXpsw+oaOmDGGOoKb4dh5vPsqFrMkKIlrh26T88+svTnRYz+oialc/WXk7pcr
         qQtCH9JsSyD1eansWBY7TYhNTMimFu49NSP7KP6qdN82TaK2JuHk45zppE7Fqg2oLzEY
         TbgGB+poa8fN5pd2igQhYhlLN8S/ihi44/f9tu4mhOUx6VJTfgC6kCiYiH+cPOHl0/zY
         XB1T0PUQoRbal4CP5zI8v5m8I2/O/nGpbOzje0vkHP7PXE6fblnPg8+xxaJA8EEfpVnV
         oD/pWgdDZsCmj0wcjRb55UHZYU2Vr5HMEJeajoUH/Xly90r2lSqZdfMyOMchxNcuSWfs
         vz/w==
X-Gm-Message-State: APjAAAVsJF9VL1WdNS4n3JmzbnZtpmglnVpTDduXenYdqTaUC9wFyZES
        FrGVr1sMrcmYG24T14ztB0o=
X-Google-Smtp-Source: APXvYqxFCF4RbLa7npVllL5F1qD8k60AkulDBhQaZ8EtjHsgAtN/VeI0zAJ9proDb1WsW7oWxEHkNw==
X-Received: by 2002:a63:3e8a:: with SMTP id l132mr23892pga.301.1569885445149;
        Mon, 30 Sep 2019 16:17:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 05/15] RDMA/siw: Make node GUIDs valid EUI-64 identifiers
Date:   Mon, 30 Sep 2019 16:16:57 -0700
Message-Id: <20190930231707.48259-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From the IBTA: "GUID (Global Unique Identifier): A globally unique EUI-64
compliant identifier." Make sure that siw GUIDs are valid EUI-64 identifiers.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/siw/siw_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 05a92f997f60..d1a1b7aa7d83 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 
+#include <net/addrconf.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/rdma_netlink.h>
@@ -350,15 +351,19 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	sdev->netdev = netdev;
 
 	if (netdev->type != ARPHRD_LOOPBACK) {
-		memcpy(&base_dev->node_guid, netdev->dev_addr, 6);
+		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
+				    netdev->dev_addr);
 	} else {
 		/*
 		 * The loopback device does not have a HW address,
 		 * but connection mangagement lib expects gid != 0
 		 */
-		size_t gidlen = min_t(size_t, strlen(base_dev->name), 6);
+		size_t len = min_t(size_t, strlen(base_dev->name), 6);
+		char addr[6] = { };
 
-		memcpy(&base_dev->node_guid, base_dev->name, gidlen);
+		memcpy(addr, base_dev->name, len);
+		addrconf_addr_eui48((unsigned char *)&base_dev->node_guid,
+				    addr);
 	}
 	base_dev->uverbs_cmd_mask =
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
-- 
2.23.0.444.g18eeb5a265-goog

