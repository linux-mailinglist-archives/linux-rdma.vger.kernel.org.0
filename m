Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2947527F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 07:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhLOGGd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 01:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbhLOGGa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 01:06:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F70C06173E;
        Tue, 14 Dec 2021 22:06:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 8so20781429qtx.5;
        Tue, 14 Dec 2021 22:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3SJP+TvCDV9K/FbuQKb3Qb3kGk8SJPwlvAtX3bT6UM=;
        b=eUqT5UWZxn1CyAUaopM2aCtcDsTmPpIStt/sj5D9ITZIQXCw5XA8no8Im3J7msxfMn
         a3fk+QAld0rSqdBQwhgSaID4FMUyXviHB/3YkgXI4QlI7lHAia0ibBYDtzi2ZjWxoAgh
         ER1X7lYg6X803hq9xUpCNHSb5E3Iut3fWu7QCGeOOel0q7SSkZY2A53/MtdO74sdriEe
         8N93/8jse7X9uSvmtr/jfVDDi8D0wjxfs3ecSUSQQgsZkjQ+r3bwKlyqqNc7/Bgorbbe
         6As7VZhcLMHAWFPOcRJBjQLmEaKhjZuMV1tSDC+eZwhQUD/kZlT+/m1aNOlKtSaMgdwk
         HuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z3SJP+TvCDV9K/FbuQKb3Qb3kGk8SJPwlvAtX3bT6UM=;
        b=1SsEaxQfZ+1zE15m7k5cAQiNUzzNhUSAT0ixDMglXYnH6ADqRqpcqAeMvT6tDEDKSH
         UYhCkgNrAU5ewJsgw4ITE9XZzbzWE4A0+txpA+bbarf/aYv7X12jMMRKZztk5UE2WfzX
         0kenFd+Ql6z7bvyuK049/r+nxyhmDHFKvDPaMmUrlgi+xp9HfVFESQQ6yyMxgS9v27qg
         0OlGLSwNRhXuhaKO9g6/q8+3GzwiCRU2mEyU0ppvNShI5HCuAJQ3f4juOYY+ZBVlhS89
         OuUwuKzC2QcCRSKFP3v84itH8QR7AlUTFR8QXBgJwynerhtj3uJ78rsXvnTDpuTtzqdt
         PHFA==
X-Gm-Message-State: AOAM531raA5eLBgRvqtqGMByMHk7e71gC223TZ15QFwHSGmERSSOmzhR
        4TJWQZyHiXDvY5sX9lTxjOY=
X-Google-Smtp-Source: ABdhPJwfZs5yfSJrItauFullNANZwNQrUXHyFcsItsUue2LCqp5udSNugR7weRK2DPXKKXiMunseVQ==
X-Received: by 2002:ac8:5713:: with SMTP id 19mr10514371qtw.642.1639548389615;
        Tue, 14 Dec 2021 22:06:29 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bp38sm585771qkb.66.2021.12.14.22.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 22:06:29 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     zyjzyj2000@gmail.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH infiniband-next] drivers/infiniband: remove redundant err variable
Date:   Wed, 15 Dec 2021 06:06:25 +0000
Message-Id: <20211215060625.442082-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2cb810cb890a..f557150bd59a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -22,24 +22,20 @@ static struct rxe_recv_sockets recv_sockets;
 
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
 	unsigned char ll_addr[ETH_ALEN];
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_add(rxe->ndev, ll_addr);
 
-	return err;
+	return dev_mc_add(rxe->ndev, ll_addr);
 }
 
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
 	unsigned char ll_addr[ETH_ALEN];
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_del(rxe->ndev, ll_addr);
 
-	return err;
+	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
-- 
2.25.1

