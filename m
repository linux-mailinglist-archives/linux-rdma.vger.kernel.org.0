Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762B454341
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Nov 2021 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKQJGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Nov 2021 04:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhKQJGg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Nov 2021 04:06:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F14C061570
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 01:03:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so7797869edc.6
        for <linux-rdma@vger.kernel.org>; Wed, 17 Nov 2021 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGBMcVQ4K0bPAtAlX8anlmt8sHV641kBY3oArzJfD28=;
        b=YEie81TPRDe+ahvbRt45YdrjphmHHXnvo7Oep3Y6Tylaa/xjLbEDKilzInycyrCPl6
         k4G30hQ+iVgOHdtAqFpZJoRF9DvCae0DQYXG8vNkW6zuhLi3SH5A/p43AnB9MXCe4tRs
         KdgHkM9Qsq9Qdn1dPTjhZlOBfXHddSSXgEmkhbWacEqiXxpiAJu7qweNw0XetxgXfHms
         1WC8DW+h/2kYGsgLh11f8yEuin9a/grAUzDvKIM82//DL4rnNP5EMaBBHBYLwj0I2khi
         Cb7CuywE3HWHwDUE1T/mMJDW8Bn6Is5Voceke6CLexBW6GyPer9qYtt2BNEC1uDijV4K
         bCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGBMcVQ4K0bPAtAlX8anlmt8sHV641kBY3oArzJfD28=;
        b=jrD9LeTtGnVkr52+XpgcGQo6qET1ZvrSj+FY9LRnPgSzQUy+Jsh9FrMZpB2iKiTYN4
         xjY146bWsbIvsBGWtdE1wrbmxfKUgP50FMK8ukI0zgW2am3OfK1F6qDjTx2SbAJugr0P
         fj/Gf61el6YTDLm20kutdhFNGDKgOCkL2UpE+qkNwxPXRYE0Fheqpj/VQOcmsJjfFYoD
         WPYmGuF9kJA5uGDTn4yxt4aYoanY7cM9Zc8hn6ogopfuZ6JINWuhbAKNJ5USF9z6kpPX
         9Qz+500C9MbaLlgqT+mMXwJhPJvrVjrwskWQgTTbhF9+Z9/XT/d2qaq7/0nDFnFaxCT4
         bqKA==
X-Gm-Message-State: AOAM533XYbxPFPAUy/4qMNMKVTTVJ16K5h1jWjikGgPVgpE/Egqj5arm
        Gr21mAJo6CQh/fiO/lSvoC10KurxpH4BlA==
X-Google-Smtp-Source: ABdhPJzbURZD8rx/6Tb/hUi+fmJj2i2pmzRQxM/E0lji8sOhBYzCWtvMdii5Ju2782kImXQKm+IXDA==
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr17310979edc.197.1637139816682;
        Wed, 17 Nov 2021 01:03:36 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id d3sm5468326edx.79.2021.11.17.01.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:03:36 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/ocrdma: Use helper function to set GUIDs
Date:   Wed, 17 Nov 2021 11:02:05 +0200
Message-Id: <20211117090205.96523-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use addrconf_addr_eui48() helper function to set the GUIDs and remove the
driver specific version.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 17 ++---------------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c |  4 +++-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h |  1 -
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_main.c b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
index 7abf6cf1e937..5d4b3bc16493 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_main.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_main.c
@@ -62,20 +62,6 @@ MODULE_DESCRIPTION(OCRDMA_ROCE_DRV_DESC " " OCRDMA_ROCE_DRV_VERSION);
 MODULE_AUTHOR("Emulex Corporation");
 MODULE_LICENSE("Dual BSD/GPL");
 
-void ocrdma_get_guid(struct ocrdma_dev *dev, u8 *guid)
-{
-	u8 mac_addr[6];
-
-	memcpy(&mac_addr[0], &dev->nic_info.mac_addr[0], ETH_ALEN);
-	guid[0] = mac_addr[0] ^ 2;
-	guid[1] = mac_addr[1];
-	guid[2] = mac_addr[2];
-	guid[3] = 0xff;
-	guid[4] = 0xfe;
-	guid[5] = mac_addr[3];
-	guid[6] = mac_addr[4];
-	guid[7] = mac_addr[5];
-}
 static enum rdma_link_layer ocrdma_link_layer(struct ib_device *device,
 					      u32 port_num)
 {
@@ -203,7 +189,8 @@ static int ocrdma_register_device(struct ocrdma_dev *dev)
 {
 	int ret;
 
-	ocrdma_get_guid(dev, (u8 *)&dev->ibdev.node_guid);
+	addrconf_addr_eui48((u8 *)&dev->ibdev.node_guid,
+			    dev->nic_info.mac_addr);
 	BUILD_BUG_ON(sizeof(OCRDMA_NODE_DESC) > IB_DEVICE_NODE_DESC_MAX);
 	memcpy(dev->ibdev.node_desc, OCRDMA_NODE_DESC,
 	       sizeof(OCRDMA_NODE_DESC));
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 735123d0e9ec..72629e706191 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -41,6 +41,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <net/addrconf.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/iw_cm.h>
@@ -74,7 +75,8 @@ int ocrdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	memset(attr, 0, sizeof *attr);
 	memcpy(&attr->fw_ver, &dev->attr.fw_ver[0],
 	       min(sizeof(dev->attr.fw_ver), sizeof(attr->fw_ver)));
-	ocrdma_get_guid(dev, (u8 *)&attr->sys_image_guid);
+	addrconf_addr_eui48((u8 *)&attr->sys_image_guid,
+			    dev->nic_info.mac_addr);
 	attr->max_mr_size = dev->attr.max_mr_size;
 	attr->page_size_cap = 0xffff000;
 	attr->vendor_id = dev->nic_info.pdev->vendor;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
index b73d742a520c..f860b7fcef33 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
@@ -59,7 +59,6 @@ int ocrdma_query_port(struct ib_device *ibdev, u32 port,
 enum rdma_protocol_type
 ocrdma_query_protocol(struct ib_device *device, u32 port_num);
 
-void ocrdma_get_guid(struct ocrdma_dev *, u8 *guid);
 int ocrdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index, u16 *pkey);
 
 int ocrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata);
-- 
2.31.1

