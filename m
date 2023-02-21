Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856DF69E932
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBUU4F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 15:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBUU4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 15:56:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DF3233D8
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 12:55:45 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w7so5712003oik.13
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 12:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/NN8eN0d3QNDkH2Exir7qGeXHhQcj3Oq77A75Cbf/Q=;
        b=ZzG5+F5Zwcjp7q6oh5Q58p969iqCEUU96X9pm6Cll60q4u1iHdql/rrwmwf2Tinxwb
         hx2r13zBBYicJfpO3W7WQ/im31HQy4vIie7aIcglMkLpNZlOEeuAP7h3929PKfTiRLL7
         U3AXowemkueCPEuA9/8XxdLPztqvNT3tWIjn++CSDyo6xe8MLeq8QJOE+wRelT1Wr59u
         RKu8E997M6IUVBV3bG4pHR1nWwklPrGKT2fLScIG6fKHeys++7VehrzsFlmfmVfPVBUc
         cqPEP4SPsZ5fg2WADadCyz6ONfATGY3f/TVPvaxsXCS1/pYl/rBCcVZdANz3udXo3Arc
         DlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/NN8eN0d3QNDkH2Exir7qGeXHhQcj3Oq77A75Cbf/Q=;
        b=w1CMEal+UXBZfK1kLFW7aOpid7RfQnQIoos2YOz3lGFFvqRh7nmJB7cWcY8aw5dEXE
         O5DSJ74tmuHEe/p6ujwKVS/NAqNUZoYHREFcz4Q3MhLEHzlTAzoU8nKF2OfwOiuVblDp
         JCkUb03eMylQKpSsrjMxykRanCajAoFM1N/H49lT9yigvUgL3s2Nqu4VgyjFDUV/++Gn
         0v4J5au4CXyO0MdB5i456Lway4zD+wTkXl/g8YYriolSC96C8Bl+NuCAQ81a5oHq6/HC
         KIo0m9/C7VWl6f+6yOcLqoKlnxtVoT/SghllbmaWiZeVph1z0BAy2XcvSiRj1fZpN333
         dlqw==
X-Gm-Message-State: AO0yUKXaSyZPbmEE7ebdV1WrT9cEI7sHePDQ9vniMcsMLBYOrsnw8R7Z
        ntk+BtaLUbDsSzTB7NUJz9w=
X-Google-Smtp-Source: AK7set8XF0HRR+u3plwYq+ocm2lBZLlU4H2SJnykpBU98OVG8NH+xPtuCyPzvpdq195LBBDRHP5DlA==
X-Received: by 2002:a54:4507:0:b0:37f:9a4e:62cb with SMTP id l7-20020a544507000000b0037f9a4e62cbmr2284944oil.47.1677012944842;
        Tue, 21 Feb 2023 12:55:44 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f6be-30aa-abdb-a2c6.res6.spectrum.com. [2603:8081:140c:1a00:f6be:30aa:abdb:a2c6])
        by smtp.gmail.com with ESMTPSA id bb33-20020a05680816a100b003785c84265dsm1433494oib.32.2023.02.21.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:55:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove extra rxe_get(qp) in rxe_rcv_mcast_pkt
Date:   Tue, 21 Feb 2023 14:54:29 -0600
Message-Id: <20230221205428.5052-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver implements UD multicast support by cloning an incoming
request packet to give one each to the qp's that belong to the multi-
cast group. If there are N qp's in the group N-1 clones are created
and for each one a reference is taken to the ib device and a reference
is taken to the destination qp. This matches the behavior of non
multicast packets. The packet itself which already has a reference
to the ib device and the qp is given to the last qp.

Incorrectly, rxe_rcv_mcast_pkt() takes an additional qp reference
which is not needed and will prevent the qp from being destroyed
without an error timeout. This patch removes that qp reference.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 434a693cd4a5..dd42c347301c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -241,7 +241,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 			rxe_rcv_pkt(cpkt, cskb);
 		} else {
 			pkt->qp = qp;
-			rxe_get(qp);
 			rxe_rcv_pkt(pkt, skb);
 			skb = NULL;	/* mark consumed */
 		}
-- 
2.37.2

