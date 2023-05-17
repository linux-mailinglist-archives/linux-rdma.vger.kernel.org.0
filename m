Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6723706F3E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjEQRWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 May 2023 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEQRWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 May 2023 13:22:46 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D11265AA
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:22:45 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-54fd177fbd4so468196eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 17 May 2023 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684344164; x=1686936164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68+FZHa2kfP88QDk3gQYklB66g2SOh7oCvj5DG7O4s8=;
        b=pUrQEYAE/NXimsq8U/jcTw4t1B1e02jYpdjvci1FaRrbiyntGgAUCvWCH6iyfV0A4E
         C4baHNje68psfM1QpuYSxZ4al2asvs0nYo/d8nTlLCRAD/a04tfFWj/GnPhyRUrcyQcV
         la6zptGc49uZMQ9i0KEn73ZUp8grLo8XqlxufrEnt08vInja3lu5YtHQl08aTP2De6Nu
         dAe0+NubBdxyrxL19wQ3hh09uV4PESD7j8TQvOZyrPrPTIruedG0e9qCxj5Ns+tFoNWx
         cqRmtYioM1PjQL7IH+qiXwkpHTLt8kF1VVr0TxB3ArwzNb8Ho4pbGBFdQZsAvfdCT2wL
         C1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344164; x=1686936164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68+FZHa2kfP88QDk3gQYklB66g2SOh7oCvj5DG7O4s8=;
        b=Z9/C9ND1WFIPZt2RhVW30UE7mz3pyzagKA3lS6syhoaczPmf9GssRXRnf5iBMDZaJR
         HGFq41to0NWC3JlE1tDO5NoBoZZsd5J0tm1l9dc505rY22RnvPHxtjrirQ70dYY/DgCg
         eeXtRQM7fFNklv0SVx171B9LwnprqqCjdMgHVbH54hIUKfKNpOnyS0tNJaCc90UyJVA4
         eaPhcTHYaAJ97hRbo509AAmgMBRKSUu0arIxyyLRiuD5fXQ/MXwljG64gVCxHqgGHOOs
         TJrowhbNCXiel2Jb8zjltDT9rxfZUN/REeioLN6dNrTJ0EiGWHCMQsOnjZ65kM3VutW5
         odkQ==
X-Gm-Message-State: AC+VfDwooXdVAefLSWNZkvWUiOQyxknbWGIs4TJOiARjl+KLfyk7l5Pa
        f6gnkY1ExLa8BJ6IOoLyjle+O0TIYMHYTQ==
X-Google-Smtp-Source: ACHHUZ6sa/N4n4QG5Zlb/4WczVb0wP04trVaPZyr414u2ku/uRr5YYZ4dLmMO0OadOte8tg6zFY1aw==
X-Received: by 2002:aca:1908:0:b0:394:a7b:5974 with SMTP id l8-20020aca1908000000b003940a7b5974mr13236000oii.10.1684344164665;
        Wed, 17 May 2023 10:22:44 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e2d1-92d9-dfd0-d039.res6.spectrum.com. [2603:8081:140c:1a00:e2d1:92d9:dfd0:d039])
        by smtp.gmail.com with ESMTPSA id z19-20020a4a6553000000b0054fa7ac8dabsm10273801oog.24.2023.05.17.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:22:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix packet length checks
Date:   Wed, 17 May 2023 12:22:42 -0500
Message-Id: <20230517172242.1806340-1-rpearsonhpe@gmail.com>
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

