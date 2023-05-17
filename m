Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27B706F3D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjEQRWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQRWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 13:22:01 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD1559E
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:21:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ab028260f8so768997a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344115; x=1686936115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68+FZHa2kfP88QDk3gQYklB66g2SOh7oCvj5DG7O4s8=;
        b=qAm0i/C/51cPAYCvyGz0xogtCoec9GEYRtwsGleZ7z4U7LyMHMV4yqxDQcExnSCQ3G
         9un9BIH1+61uPuIZxxvJYlIAaf4LhjALZSGgoGcmd/mbJNKukTrX20+on/HoBRzPZOqq
         +2+lFD2dQfxqie7iQ5GReO1mXxt6C9OGxyZT7DEXAW+XPp7HLR8m2wGSP1y9/QgBwzhq
         8PwzvPUbwBBM5ON0h7H98/mV+Pre1LIopnXPdrwhaNZe1MeY6ljeTCgCpKilx0m85D6U
         //I6cjGEOcY2oHk72sFyeagG/tuTNDv2pZpBHmtHJed2nPg7fPBfeWNdznSJZMx8zqzA
         rTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344115; x=1686936115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68+FZHa2kfP88QDk3gQYklB66g2SOh7oCvj5DG7O4s8=;
        b=bbKkKKcbSU8wjYhoRpa6wr4k27BXeyYVtjNsaeKZkS/2rjYwYTb933WN9ywhUd5lBc
         22z7/uWiG9aUxXhec9gB0ta/XkAzd39Jh0DxHxjTHdUuvSLEi/ssFa8A395sKGOdYaC1
         OmW69kHqOC3ZtdMkGsbJFomIa2AoHzsOx8A4C28TmcV0iWtbz19T49+eQTTpikJd6xNM
         nd91W+G/jkboOFu8AEhxlCeReXltAuLKnjXD9YljhA5nSlB7j5vn1RGTEliys69B6z27
         /XqKtS71C4sSGipIxI/7L5Qaza37VQ0MQn9tWLFRDSa7rN2yk1b0JVSy9AQgQ1lL10yx
         Epfw==
X-Gm-Message-State: AC+VfDyKoVm9+iDak6Ot6aFvYnCQhr0N1yNigSjk+bD5Vf2x6+3acLjf
        qviGkkSYb8lqrziEuZS7yb0=
X-Google-Smtp-Source: ACHHUZ7WnVwXtCOxkWi5//5AEs4fgDuTJHWYZN+T4iJQHGPYARqeHReQZIHADIpAZQw4mLZt+OGmVg==
X-Received: by 2002:a9d:6b17:0:b0:6a3:4e22:2bd with SMTP id g23-20020a9d6b17000000b006a34e2202bdmr16081963otp.5.1684344114960;
        Wed, 17 May 2023 10:21:54 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e2d1-92d9-dfd0-d039.res6.spectrum.com. [2603:8081:140c:1a00:e2d1:92d9:dfd0:d039])
        by smtp.gmail.com with ESMTPSA id t6-20020a05683022e600b006aca3e710desm5111383otc.2.2023.05.17.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:21:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix packet length checks
Date:   Wed, 17 May 2023 12:20:38 -0500
Message-Id: <20230517172037.1806288-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
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

In rxe_net.c a received packet, from udp or loopback, is passed
to rxe_rcv() in rxe_recv.c as a udp packet. I.e. skb->data is
pointing at the udp header. But rxe_rcv() makes length checks
to verify the packet is long enough to hold the roce headers as
if it were a roce packet. I.e. skb->data pointing at the bth
header. A runt packet would appear to have 8 more bytes than it
actually does which may lead to incorrect behavior.

This patch calls skb_pull() to adjust the skb to point at the
bth header before calling rxe_rcv() which fixes this error.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2bc7361152ea..26b90b8607ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -159,6 +159,9 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	pkt->mask = RXE_GRH_MASK;
 	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
 
+	/* remove udp header */
+	skb_pull(skb, sizeof(struct udphdr));
+
 	rxe_rcv(skb);
 
 	return 0;
@@ -401,6 +404,9 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 		return -EIO;
 	}
 
+	/* remove udp header */
+	skb_pull(skb, sizeof(struct udphdr));
+
 	rxe_rcv(skb);
 
 	return 0;
-- 
2.37.2

