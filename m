Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786FC399D51
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCJDY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCJDX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 05:03:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7FC06174A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Jun 2021 02:01:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so5043451wrw.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jun 2021 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf2OLjxkYz4xCWwr5Yh70N6WxUTsJK1z0UQKTXY3oKE=;
        b=CMig2YUqLVvfIdRCJUKO4UAKrThlKCCheyrVTqz2seNNUcAU3ebtTZaF2yk/yKBO+8
         KWUuGe8HlNsgWe4ha5CYYTLbHTkn//PhFG7p2SQEVM9yogwGw1dxKyoZH/aSCUqFk+la
         63jWAi8+meeajuvncVOtbxURQbMKemWMp81tmk+CslhEoH2wtoL7LK2qzZ+U2CP7c4MB
         qLsHdEbd4Pymh6VT7kHls5BDlAPXRnN6s0nJl/Ezx0oxtG0HpnUaDgUiXopDMFDH9rU0
         6b4BzkZlx66S/2uRyqVrpx+KneVfus9Pqmo+bh1aJCm3TJ+VqlIxBhNtLeROj+weDIAn
         CQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wf2OLjxkYz4xCWwr5Yh70N6WxUTsJK1z0UQKTXY3oKE=;
        b=MyHvt3vY/EGKx8fPH+1d5I0MRF9D6KhYDKb8nnV04pN84RvCBkhPRlbHJViUOied1H
         Jt7ZGUNJP0ZuGYREfcAndG6T9On9xq5AoeKENjqgDyyRGqQ9GrP0WcELyTQDBPL9yuE5
         66v0vcyV50NrflBJr1M3qmApZNYv1ZVcVhS29Hcv7u8uewFz/gvRApjl89DLPIMnY++Q
         9KovA8aoHuYGRuoSA3YdUUL+Qs3j7q4jd6W8iMppJaxrm1X7GxbHcBFTh7b7yMD8NYuZ
         +hnelClGmQExHSbPhZjul/d7PEV0ArGlVbfQs9LSX4/TRLvj/2R2jYooYtxcNUjEDz/D
         BsOQ==
X-Gm-Message-State: AOAM530FHhCIbnwI3SmZPGKW4qcA/hSQdbyoNG3vcKcoxkn/GPCuFXAt
        ljiOWN/Q7vo9p+aImqD3ISXirYMUluRiOw==
X-Google-Smtp-Source: ABdhPJzML5oOSs9D5NwM0UfiKKNx7ysIoB0WcDI3cpLF2E7NhSWKv1CRiXyDYIxxLQaRc3+WpKlyGw==
X-Received: by 2002:adf:f748:: with SMTP id z8mr26615482wrp.115.1622710883681;
        Thu, 03 Jun 2021 02:01:23 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([2a00:a040:19b:e02f::1005])
        by smtp.gmail.com with ESMTPSA id o22sm4979167wmc.17.2021.06.03.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:01:23 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc v1] RDMA/rxe: Fix failure during driver load
Date:   Thu,  3 Jun 2021 12:01:12 +0300
Message-Id: <20210603090112.36341-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid the following failure when trying to load the rdma_rxe module
while IPv6 is disabled, add a check for EAFNOSUPPORT to ignore the
failure, also delete the needless debug print from rxe_setup_udp_tunnel().

$ modprobe rdma_rxe
modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted

Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..6cb4446a0bdb 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -207,10 +207,8 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
 
 	/* Create UDP socket */
 	err = udp_sock_create(net, &udp_cfg, &sock);
-	if (err < 0) {
-		pr_err("failed to create udp socket. err = %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
 
 	tnl_cfg.encap_type = 1;
 	tnl_cfg.encap_rcv = rxe_udp_encap_recv;
@@ -619,6 +617,12 @@ static int rxe_net_ipv6_init(void)
 
 	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
 						htons(ROCE_V2_UDP_DPORT), true);
+	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
+		recv_sockets.sk6 = NULL;
+		pr_warn("IPv6 is not supported can not create UDP socket\n");
+		return 0;
+	}
+
 	if (IS_ERR(recv_sockets.sk6)) {
 		recv_sockets.sk6 = NULL;
 		pr_err("Failed to create IPv6 UDP tunnel\n");
-- 
2.26.3

