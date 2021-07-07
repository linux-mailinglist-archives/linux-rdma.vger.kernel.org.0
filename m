Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F753BE1BC
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGGEE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhGGEE1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CA6C061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so981136otk.7
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+rzFeqYYu3JhriUi0wzbr6hzymOv2H4O6oPj2SxAVA=;
        b=k1Pfmw79PIE0RTJ0ShHRisLIFQg3b6vTorB3dXrIL1McLOhh+WAhmt4UPKS0I9ZetK
         jsEwPR8RWAwrgA0kILK2S/unbEEJmnFEJw6RkHgt0A1MASeAg7KDjMPIg3zJACXc9B+c
         mcQf0LfJtk6TYtCc3RsCAZ60Dtw005LUjYfWARBqEfBmc2B4n0KYYJ5x7NCWZcP9jRtH
         PTf7OJiEtLYpPpG+wnuUfwkmmbgPlVhWbkmTTZgokC3y6OG5HBqs02kfSTZrH90pbSQ1
         zAW4B8i9syzrZgXWuEstSJ5LSFZGcq13m6QO4zRArKRuvwu1/mw1wKqAmCARpSXFSv8u
         Hyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+rzFeqYYu3JhriUi0wzbr6hzymOv2H4O6oPj2SxAVA=;
        b=AiYbIjCtmO4ui2XwffYMJ5XyZX3nob8iBn6ZN5ZOemRB0HfJr5NaoFjTViaYf51cXr
         dcR17DdKoJE3fc7k7K2Lw79bhW4klAacpj3GJYG2kbLjEK/jh6/t5FZ25Lpi1w1EHjxv
         He7F3fyWklYgvrFsS2uoUJB5RpX2Ijlkza3BhPVkSmH9sQmybCrUkMhkiHJ0AT4RwOqN
         TOeZKfLotvWzHFtUmITYLSV+ClxcfFwshAGZ1J0pc0E2idkrZp2URXet2iCxgO4N7AKO
         UZMRuvRSc6b2tNlJ2II7MeyLZqK2JohyxTz6ovRQ8cwb4fiEZIqhi3tBSZRg9W6wj0Oz
         lZsg==
X-Gm-Message-State: AOAM5327NrdA6LvIF0oxUTTLsXlVMwj07OEtkXuB5TbIsQ/P8bixVBd3
        dP9AFzCytub6XqpM7zhq4tY=
X-Google-Smtp-Source: ABdhPJxrxcAhbJDlQZBQSgo0gZ2spk7tfwzJYtiM+KOeaxJRAelg0EDJvVF7gPIekAyBHJCGVweXHw==
X-Received: by 2002:a9d:7b56:: with SMTP id f22mr17395664oto.71.1625630507246;
        Tue, 06 Jul 2021 21:01:47 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id d18sm3758262otu.71.2021.07.06.21.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:46 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 6/9] RDMA/rxe: Fixup rxe_icrc_hdr
Date:   Tue,  6 Jul 2021 23:00:38 -0500
Message-Id: <20210707040040.15434-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_icrc_hdr() in rxe_icrc.c is no longer shared. This patch makes it
static and changes the parameter list to match the other routines there.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 6 +++---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 00916440f17b..777199517e9a 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -29,7 +29,7 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 }
 
 /* Compute a partial ICRC for all the IB transport headers. */
-u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	unsigned int bth_offset = 0;
 	struct iphdr *ip4h = NULL;
@@ -106,7 +106,7 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	pkt_icrc = be32_to_cpu(*icrcp);
 
-	icrc = rxe_icrc_hdr(pkt, skb);
+	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
 	icrc = (__force u32)cpu_to_be32(~icrc);
@@ -134,7 +134,7 @@ void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	u32 icrc;
 
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	icrc = rxe_icrc_hdr(pkt, skb);
+	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
 	*icrcp = (__force __be32)~icrc;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a832535fa35a..73a2c48a3160 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,7 +193,6 @@ int rxe_requester(void *arg);
 int rxe_responder(void *arg);
 
 /* rxe_icrc.c */
-u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 
-- 
2.30.2

