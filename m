Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6D455898
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbhKRKJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 05:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245551AbhKRKIP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Nov 2021 05:08:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F258C061570
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 02:05:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so4330563wmb.5
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaPzenlbXAudQgnZxKKCmm5uDK/bBMV+Is4sKzBcKGs=;
        b=Q8EbmqFKKSbZx68xKpQB6jm6ATh6yiodt2AJob/pC8Osd2EqrmUxIyGEd/yeCf6UwP
         i0hhO4+GXkTeuD9E+MPePhKqBNx2LvdMkMv5qSnhJo4PwEuGS2f2i0PaHlBJQ3pId6l2
         DgKygusUb7DIqA7LJA27lpbLIMBJAhufD+hnzK6f6xyhPEW7Lvs4IPXi7O9Bm52T/Fz7
         gkogCkF3NtFK/4NXkG2Agsk1OagkM/gocXKeIDHDvMVng6WR90vPYN8PFdm24aMnLD0S
         KKLZf5E2oTVVs+rbfelvzurpJLDViyHEnPNP44MHr5BDl6mVjT3OEePMMU4LffkrhOIX
         H5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaPzenlbXAudQgnZxKKCmm5uDK/bBMV+Is4sKzBcKGs=;
        b=c/oEy50bcZePvmTIboZZpSuvHsniavOaLlnzPYealiCDWHmpgYFiFQRG2o189UlErJ
         nccuDOqocmRJcd7uHz9LmwJe15AedrbUeEwl6RExvZFGSGgoE1WoitZyxsrV67qBsD5Z
         nlI9eWfPLeZcGb3ZwePTNJBuRuMAVoYBJykiXmHiWMlGkheNxb8kU0SM+tA0q0X0Pl8X
         pRiKtEKAmPwwcu6r+zOJyiedA68OjAQFFRV+kyJzHh0B1L32l9T1ATp1haV8aP7sijK9
         xezEwNyXXVVuFaqj/2EehGg1z1MGAqvcYSYxrXSv0H3/0W46JhMNTEvwI1HhqR3fbMOQ
         xdzg==
X-Gm-Message-State: AOAM530Arpaxd5qUDZNmyP/SEU4Fc9ntNPfI4Vg6N3sSSjRXWP+r8I+9
        unU8iJ80oPOwmSBdPpg+yaSHY2lvCdFXeQ==
X-Google-Smtp-Source: ABdhPJx4qcojaQ9AABAItedTFpLBzRRxxJZOH/KKSMtsS9+Z089H6BLEGUeI7eIozEG2v0faVa8x9Q==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr8781559wme.186.1637229906494;
        Thu, 18 Nov 2021 02:05:06 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1007])
        by smtp.gmail.com with ESMTPSA id 4sm3509943wrz.90.2021.11.18.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:05:06 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/cxgb4: Use helper function to set GUIDs
Date:   Thu, 18 Nov 2021 12:04:56 +0200
Message-Id: <20211118100456.45423-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the addrconf_addr_eui48() helper function to set the GUIDs, Also
make sure the GUIDs are valid EUI-64 identifiers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 0c8fd5a85fcb..89f36a3a9af0 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -41,6 +41,7 @@
 #include <linux/ethtool.h>
 #include <linux/rtnetlink.h>
 #include <linux/inetdevice.h>
+#include <net/addrconf.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -264,7 +265,8 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 		return -EINVAL;
 
 	dev = to_c4iw_dev(ibdev);
-	memcpy(&props->sys_image_guid, dev->rdev.lldi.ports[0]->dev_addr, 6);
+	addrconf_addr_eui48((u8 *)&props->sys_image_guid,
+			    dev->rdev.lldi.ports[0]->dev_addr);
 	props->hw_ver = CHELSIO_CHIP_RELEASE(dev->rdev.lldi.adapter_type);
 	props->fw_ver = dev->rdev.lldi.fw_vers;
 	props->device_cap_flags = dev->device_cap_flags;
@@ -525,8 +527,8 @@ void c4iw_register_device(struct work_struct *work)
 	struct c4iw_dev *dev = ctx->dev;
 
 	pr_debug("c4iw_dev %p\n", dev);
-	memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
-	memcpy(&dev->ibdev.node_guid, dev->rdev.lldi.ports[0]->dev_addr, 6);
+	addrconf_addr_eui48((u8 *)&dev->ibdev.node_guid,
+			    dev->rdev.lldi.ports[0]->dev_addr);
 	dev->device_cap_flags = IB_DEVICE_LOCAL_DMA_LKEY | IB_DEVICE_MEM_WINDOW;
 	if (fastreg_support)
 		dev->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
-- 
2.31.1

