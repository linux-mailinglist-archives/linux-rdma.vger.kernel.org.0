Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BAD75D5FF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjGUUvS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGUUvR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A435AC
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9af1826b6so1958036a34.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972674; x=1690577474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGzb7HB3gzwMWGLewlnlIN14EkqKNso8cg2HkdT4ARY=;
        b=Tn38PM8ExM/ggHuf5stlX9txx/Wwjf34aeZws8nSnOIFIAi/HK4sNsGZWR+75Oce8n
         9GYDE//o24Fi6OAo2x8344b2kiuGASp4AI71fH6t/JQNem8RqtLDewmzsVyClV2eryzs
         upfum2JtIzBJH6uTuuYcP/56QvgqdiM4hlfpz+vchMmRn3oP9UepnzkRsik9gBMChjTi
         tbafLDGhEDtatbd5Uwi5DXAZT58cgxrf9hVeg7HObylXFcId4HB0C4VyMFW2Cs0KAduB
         OmqTvvjxVhH4GMrllj6yyJHD+Xf8/jXcbqPpdwNjNHHvh5AtBxMPp5k2AolfJOk+OgJa
         koQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972674; x=1690577474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGzb7HB3gzwMWGLewlnlIN14EkqKNso8cg2HkdT4ARY=;
        b=dR06U9f0S56nJZokKPfbfsXhMbZ+LHgAo5/fJGJhoNUQRJXF2+e4jV3vzbblftg4R7
         ARsBl6XA7pW26qSV0RdvezN/HSTC6bHoyFgXczmmwytrmgipmD1XLswLh1AEel9uT23H
         RjFuvTBoGiWHdcxgXVtxpgCUjKEGZA4OZkBYZ0wsN7OJGfgLYvLJKWUaAp9bx1g7tIGh
         e+9nyQcUco7vQlE6BPauAeeDXtfc5QZ0H2L1uXVperHm7906H4leAgJL8VrqLLf7C7tE
         pRAp/ptvsV+ZM3dyvhif/BUfW+SU8FXwhJFiVnyIVaAgw7+On4P2fkyQL2GKhfLd5wW/
         I7Cg==
X-Gm-Message-State: ABy/qLbKb4AKzdQRyW//NxNksgXt1X6ejsFS6O6bYx8b9Ons8JMdheE5
        meRZiP+JLRPhAE30moVmhqc=
X-Google-Smtp-Source: APBJJlEg+OgNgCwAuvvLlRL8lzAgXxHh+ZdnMsJxqMiYufsijdziZykJIB4oH5bHYtYdH6sIWd244A==
X-Received: by 2002:a05:6808:10c2:b0:398:5d57:3d08 with SMTP id s2-20020a05680810c200b003985d573d08mr4503358ois.37.1689972674264;
        Fri, 21 Jul 2023 13:51:14 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Date:   Fri, 21 Jul 2023 15:50:22 -0500
Message-Id: <20230721205021.5394-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Network interruptions may cause long delays in the processing of
send packets during which time the rxe driver may be unloaded.
This will cause seg faults when the packet is ultimately freed as
it calls the destructor function in the rxe driver. This has been
observed in cable pull fail over fail back testing.

This patch takes a reference on the driver to protect the packet
from this happening.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c     | 26 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe.h     |  3 +++
 drivers/infiniband/sw/rxe/rxe_net.c |  7 +++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..6b55c595f8f8 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -208,10 +208,33 @@ static struct rdma_link_ops rxe_link_ops = {
 	.newlink = rxe_newlink,
 };
 
+static struct rxe_module {
+	struct kref		ref_cnt;
+	struct completion	complete;
+} rxe_module;
+
+static void rxe_module_release(struct kref *kref)
+{
+	complete(&rxe_module.complete);
+}
+
+int rxe_module_get(void)
+{
+	return kref_get_unless_zero(&rxe_module.ref_cnt);
+}
+
+int rxe_module_put(void)
+{
+	return kref_put(&rxe_module.ref_cnt, rxe_module_release);
+}
+
 static int __init rxe_module_init(void)
 {
 	int err;
 
+	kref_init(&rxe_module.ref_cnt);
+	init_completion(&rxe_module.complete);
+
 	err = rxe_alloc_wq();
 	if (err)
 		return err;
@@ -229,6 +252,9 @@ static int __init rxe_module_init(void)
 
 static void __exit rxe_module_exit(void)
 {
+	rxe_module_put();
+	wait_for_completion(&rxe_module.complete);
+
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d33dd6cf83d3..077e3ad8f39a 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -158,4 +158,7 @@ void rxe_port_up(struct rxe_dev *rxe);
 void rxe_port_down(struct rxe_dev *rxe);
 void rxe_set_port_state(struct rxe_dev *rxe);
 
+int rxe_module_get(void);
+int rxe_module_put(void);
+
 #endif /* RXE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c1b2eaf82334..0e447420a441 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -384,6 +384,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 out_put_ibdev:
 	ib_device_put(&rxe->ib_dev);
 out:
+	rxe_module_put();
 	return;
 }
 
@@ -400,6 +401,12 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	sock_hold(sk);
 	skb->sk = sk;
 
+	/* the module may be potentially removed while this packet
+	 * is waiting on the tx queue causing seg faults. So need
+	 * to protect the module.
+	 */
+	rxe_module_get();
+
 	atomic_inc(&pkt->qp->skb_out);
 
 	sk->sk_user_data = (void *)(long)qp->elem.index;
-- 
2.39.2

