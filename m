Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C18447612
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Nov 2021 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhKGVZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Nov 2021 16:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhKGVZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Nov 2021 16:25:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440AC061570
        for <linux-rdma@vger.kernel.org>; Sun,  7 Nov 2021 13:23:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so13660216wmj.5
        for <linux-rdma@vger.kernel.org>; Sun, 07 Nov 2021 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z0SrrZATGiWo8n6NO3cgh9aYdGnQVL/NWhVaDjv62o=;
        b=DDudDxY/Nk9COGcz3JrVeFydreUMy0EI/kNVLC7hA6plhmQ+f3vBgQuVjVk8I4kvUD
         6m/rp5x2kszz0epgoX81KS1aktXRA8V/Xngk2iQGmdGpdgFFPCWC7Y62oS6tsR1Emb/D
         Pa65h9N+AvWB0ItKH8fuxdQM7bZ+r1Sww2ILEziIhj4GgcSY7CT/KtGb9h2wKgBYA9o5
         W41H0213EpjbP9DCyV1LquOGtAyuqcDkdG3zOaXMsO3LuinIZHxou7ATNOYk5XHinFzU
         70gBAorAeK6gR4IO7d6RRi+oB/lLjoiIxCgiMx2eSIX9rBAgZ4QKQuM59s5yt3k3UbzR
         I0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z0SrrZATGiWo8n6NO3cgh9aYdGnQVL/NWhVaDjv62o=;
        b=HF8k6aWaMBr3LDyDwCZjyZx/gDvDtq/lRTn3WndGIPcbT5TfVGSohD6zo8Lw0z/U0l
         CtlVoL8ngd/qcBqSbv+EMhtq9LdaeZPkLqSsn4PQVUifmnV/Yb7PAACJVYOES6nUwU3K
         c0Rgz4EAi0p52b6Q4OGQSnsL3f0Nyq/DyZ3kOIRJDtgvhkaqTZeGXETCUYgrJNZ0oogG
         cj26VZEGY1Nw4Kb7Oh8Mi9dpjKg+6eGbPCzoBJ//da9gm+ysX7d/rNer+kzbMVQV15As
         JfUFoHZtMFNpvmmF3jp5PutrkpBv5sFjLCBgoat7QA8o54vKl1hrOTCVFAjwpmUNMKNk
         CqZA==
X-Gm-Message-State: AOAM533hXg4Ilv9XNYexY/x5BrGvYfVtH77nXxy42uzju8joWIjyELNN
        op/e/rns7odvUPiN6CbdeufdwI9p6O72nw==
X-Google-Smtp-Source: ABdhPJxfTcIMaOXz9tvKg6GJr4jgX6dF0A15+bkR74+649aISSxMQ1tVJuNWZDab0kQPsHN3axlPYg==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr49785801wmc.3.1636320184022;
        Sun, 07 Nov 2021 13:23:04 -0800 (PST)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1007])
        by smtp.gmail.com with ESMTPSA id r15sm15292799wru.9.2021.11.07.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 13:23:03 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/irdma: Use helper function to set GUIDs
Date:   Sun,  7 Nov 2021 23:22:27 +0200
Message-Id: <20211107212227.44610-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the addrconf_addr_eui48() helper function to set the GUIDs for both
RoCE and iWARP modes, Also make sure the GUIDs are valid EUI-64
identifiers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 0f66e809d418..c3b8ba6036ff 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -21,7 +21,8 @@ static int irdma_query_device(struct ib_device *ibdev,
 		return -EINVAL;
 
 	memset(props, 0, sizeof(*props));
-	ether_addr_copy((u8 *)&props->sys_image_guid, iwdev->netdev->dev_addr);
+	addrconf_addr_eui48((u8 *)&props->sys_image_guid,
+			    iwdev->netdev->dev_addr);
 	props->fw_ver = (u64)irdma_fw_major_ver(&rf->sc_dev) << 32 |
 			irdma_fw_minor_ver(&rf->sc_dev);
 	props->device_cap_flags = iwdev->device_cap_flags;
@@ -4308,24 +4309,6 @@ static enum rdma_link_layer irdma_get_link_layer(struct ib_device *ibdev,
 	return IB_LINK_LAYER_ETHERNET;
 }
 
-static __be64 irdma_mac_to_guid(struct net_device *ndev)
-{
-	const unsigned char *mac = ndev->dev_addr;
-	__be64 guid;
-	unsigned char *dst = (unsigned char *)&guid;
-
-	dst[0] = mac[0] ^ 2;
-	dst[1] = mac[1];
-	dst[2] = mac[2];
-	dst[3] = 0xff;
-	dst[4] = 0xfe;
-	dst[5] = mac[3];
-	dst[6] = mac[4];
-	dst[7] = mac[5];
-
-	return guid;
-}
-
 static const struct ib_device_ops irdma_roce_dev_ops = {
 	.attach_mcast = irdma_attach_mcast,
 	.create_ah = irdma_create_ah,
@@ -4395,7 +4378,8 @@ static const struct ib_device_ops irdma_dev_ops = {
 static void irdma_init_roce_device(struct irdma_device *iwdev)
 {
 	iwdev->ibdev.node_type = RDMA_NODE_IB_CA;
-	iwdev->ibdev.node_guid = irdma_mac_to_guid(iwdev->netdev);
+	addrconf_addr_eui48((u8 *)&iwdev->ibdev.node_guid,
+			    iwdev->netdev->dev_addr);
 	ib_set_device_ops(&iwdev->ibdev, &irdma_roce_dev_ops);
 }
 
@@ -4408,7 +4392,8 @@ static int irdma_init_iw_device(struct irdma_device *iwdev)
 	struct net_device *netdev = iwdev->netdev;
 
 	iwdev->ibdev.node_type = RDMA_NODE_RNIC;
-	ether_addr_copy((u8 *)&iwdev->ibdev.node_guid, netdev->dev_addr);
+	addrconf_addr_eui48((u8 *)&iwdev->ibdev.node_guid,
+			    netdev->dev_addr);
 	iwdev->ibdev.ops.iw_add_ref = irdma_qp_add_ref;
 	iwdev->ibdev.ops.iw_rem_ref = irdma_qp_rem_ref;
 	iwdev->ibdev.ops.iw_get_qp = irdma_get_qp;
-- 
2.31.1

