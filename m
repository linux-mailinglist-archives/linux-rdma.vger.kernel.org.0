Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E157214BE0
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgGEKnf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKne (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:43:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E62C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:43:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so36139380wme.5
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3yQZiHbkQ7MpMtQaZKlRpcknRq/3peMVAfQV2P504A=;
        b=tgdcPh3LUZCuUnSlO8k/idQB/S+q/nV3dEMibt5O7mxAEhF2PPR7svuVGdcZ2EVN6H
         Y6FiDSf6i7CJTExmXtGgjAc4/Ge2BEWNQShxq38VB8BScYnN1rEqzSDzMkk9ij8JQkjv
         BYa+GYQVTJITz4xS/C8gFPn/1tLet7pKX37ZDbOJ9HSgGCu7p2tpaZPqUh8T2ClnHBtM
         0D/36yY6CI8nLtg0MEvVyLJEogEpmmP9gxiFB488Ky3Ywu81rl2sdLruac7G64zbVpp8
         4DVTo156ax3W6wfc7lMDJWGxA1uRI0tTYOhGudnZfvt/yr6MTONiHlEX9vQaM8mfLBJZ
         RkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3yQZiHbkQ7MpMtQaZKlRpcknRq/3peMVAfQV2P504A=;
        b=Rxd83XDJLJhBjF/iY0SHowlr/oidPGZacYzuW+YsHBUUK6QpL6Q6HU7V+nCDR3jHSW
         TTE4MVbAwkp9QUgJm2pdXjhPyJeKiaKLc87zoPYGwNTlXNUCCmhkQ+l88LKMQntMfTwf
         7/Ig7DjrqINEGXn5OKxKIW1o+3NRH1DvzpBYT3ueyp5z8fTOMeRm7J8Pn0HhgZ9aDYm7
         0vMWQyTzR+hIUFVRCuThR6ImsAT3arEGNnArKB+40bTcBLvSOwq7qE1X3v6GbnLGq2hg
         +/jwYQthxSbaVi18hPcO0noFyhIfzN8PjZwFiEf1tjGMvj+3jcZSs49CsccqkxFRqPby
         hFfg==
X-Gm-Message-State: AOAM533X3qr3D9SkmdKxYWhF808BWo9WzSk44k8RHHYRtiNA2fYYYJnr
        MfmxvZhsnjCohWoyoYuxGJlqnviDki4=
X-Google-Smtp-Source: ABdhPJwvS2gwvxg5V1PbWzTlD2m/c9xkrPydMUrGPZ4BjfUPh9H1fmjY/2AlOdV2Ng6MqQ1e0sobGQ==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr18950782wmb.108.1593945812774;
        Sun, 05 Jul 2020 03:43:32 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 51sm14828083wrc.44.2020.07.05.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:43:32 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 4/4] RDMA/rxe: Remove rxe_link_layer()
Date:   Sun,  5 Jul 2020 13:43:13 +0300
Message-Id: <20200705104313.283034-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Instead of returning IB_LINK_LAYER_ETHERNET from rxe_link_layer, return it
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

