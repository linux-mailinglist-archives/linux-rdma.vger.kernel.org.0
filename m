Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90DA213CA5
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGCPfA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPe7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 11:34:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F8C061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 08:34:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so25089709wrs.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 08:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKlDWVh3bHr1994ByvjYs9iMM9C95SGF1qWy8EKhunc=;
        b=f7UroghhWjuTGQm6ronExmQGG3zWEYWIrse4V2fwyYXbxxjTmtPjEK+IAEi50Z6hCR
         WNJc9iaPnAA/5QrbkqLAs60GP7+FQmtTzxCFuSnKs/MH0G4IGeySJl43jzqSswv/6m1X
         VCu7nmzJs7rssDMHPyLptWeXKf+Fw+EOBn20AXzUfWpYoAyMeYgJrIvjDbISlVDEkRGY
         wsC0VF6Ia+qsJ2d+mzBLri5fnZCr0WazqSWN4nEiG0N8/JtLuovw0zYTrKRX2EkcJIl3
         Uev/skaXk5xMISoih4NMAZNAapF6QhIrv/8MHZRP7+T5qZUaX4FCuU4F453hygZu/aZP
         9omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKlDWVh3bHr1994ByvjYs9iMM9C95SGF1qWy8EKhunc=;
        b=npOZrvBFkGIHGMwbnYj6oyWiZ6+5zVFCJrzYqvqgkkXP/GQ4CS2U7TV9Jz4QIRMfei
         iQgW9M8F9gFthv2pmTad/Z+7pemrxPn+2e3Sg3mpRFGUfuX6D7f2EWlPIQg2dsWtZZo+
         YtMygfx6QHew4dBR/Y3tw5stRpveY8koe7aYVITMw+cSU1Dyzc74l0YbT3Q5gUr03PgL
         vqohGa4SoU82B64c5weTfOxyTeJ1mBHK0ksolRfi24j98OdrWaUea7nYzp7JGQoDYj4K
         TGSq9rjQEH+tMrIHJzf2MKt7oGNe1l1vEHZIuHt5XfPQqu+vXSbuU1zAH615D/O573AE
         6M+A==
X-Gm-Message-State: AOAM532OJUWhkOTDIX4tMbqYsVaiUy01l3KExh2Uo95R6a+id3E1JACe
        KrJuMolcIYR2dSJvXSViUhWSFmatPmE=
X-Google-Smtp-Source: ABdhPJyj7DxLmSpoi8w0W9Csi6AWdCAlN2TXXLW2T2eSAsk9fJFTcCi6NO0JsfpPtm5dzzzT1sKp8A==
X-Received: by 2002:adf:e948:: with SMTP id m8mr38352476wrn.398.1593790498023;
        Fri, 03 Jul 2020 08:34:58 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm14083225wrt.73.2020.07.03.08.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:34:57 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 4/4] RDMA/rxe: Remove rxe_link_layer()
Date:   Fri,  3 Jul 2020 18:34:28 +0300
Message-Id: <20200703153428.173758-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703153428.173758-1-kamalheib1@gmail.com>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of return IB_LINK_LAYER_ETHERNET from rxe_link_layer return it
directly from get_link_layer callback and remove rxe_link_layer().

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   | 1 -
 drivers/infiniband/sw/rxe/rxe_net.c   | 5 -----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 4 +---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0688928cf2b1..39dc3bfa5d5d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -142,7 +142,6 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
-enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 struct device *rxe_dma_device(struct rxe_dev *rxe);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 312c2fc961c0..0c3808611f95 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -520,11 +520,6 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
 	return rxe->ndev->name;
 }
 
-enum rdma_link_layer rxe_link_layer(struct rxe_dev *rxe, unsigned int port_num)
-{
-	return IB_LINK_LAYER_ETHERNET;
-}
-
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index ee80b8862db8..a3cf9bbe818d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -141,9 +141,7 @@ static int rxe_modify_port(struct ib_device *dev,
 static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
 					       u8 port_num)
 {
-	struct rxe_dev *rxe = to_rdev(dev);
-
-	return rxe_link_layer(rxe, port_num);
+	return IB_LINK_LAYER_ETHERNET;
 }
 
 static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
-- 
2.25.4

