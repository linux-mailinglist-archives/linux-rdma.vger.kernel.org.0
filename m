Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8BF3AC2B0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhFRFCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhFRFCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61403C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t140so9255765oih.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADvuAn3NIofhjjOp5lFsWXSlVvEoS3sGNqks4pM/Ag4=;
        b=Lk122pBFN1AZyqBZ7RtYX4TKFvscimj1/Q3rWZEQujx3yDOsLxK5IGoDRMWI/vPGhM
         q3Bhkvc2WnPEjv6iycY8NCNaXgPGMag1eksHEvxQFVsL6N3QyG3+ONQD9rZ8xL0qqzQr
         0relmfQRqmMQd1J1IK9xmaFcWMGdlsnr+cZV9327S9g2jeNT008BbvtYNPFImQZz3WXs
         M+/l7o+wFKP4Fo/thypFzKEW8NThsdQDnyzV3e/VSXcSJmyJrMiiHeIM7msx8oOguYVA
         DDO4uG3wRhYPFVF5aIgqhZZmmBoSspOuZsgFxFgIpheQwLTWiR5ZZgFdgYHbpN7HXxY9
         o60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADvuAn3NIofhjjOp5lFsWXSlVvEoS3sGNqks4pM/Ag4=;
        b=fe9PF2dQ3n4DqPxWtIpswxiidc0W7I1WGkykn/lAdkbYw+e1VwKjnAF9PkB6MMzipN
         T+BvORgknyPlvHP3pSBBBecylahFjz1k0pT/uXiwb0fN9SQRHuuo07ywN++78UQoXmf2
         sVemw0Uteli6WG+kJj4CjoNcFNTEivLTbX1ZGDunfGeFx+eirDCv9aS7pD1p9V1ev42C
         d2PACaInI8YBNiLRrsGrGfi6WPDRfnitW4vvR1zqEVSPMK3GuhhaqQvOWKDzeIJjKM/E
         FfdOumkp/gJo6qUju6Q1QwCL/FuVIDGms6TUDCLtCuJ7PDGQz6vVGNcGFmf9O5QnS5OW
         9m8g==
X-Gm-Message-State: AOAM531W+5HCGOtCWuGUKvDAfobM5jT9R65Uw1/gYinF69cqSQ3OcYpZ
        r1oWbw4bFbP6MBEAVKSmMno=
X-Google-Smtp-Source: ABdhPJzKMphzmulypNrGASu9nJoSUwlDQOBbPfObhoJQRzrg8WgpJDG6xwM4dczVe5WLU0xAgC9rUg==
X-Received: by 2002:aca:4d46:: with SMTP id a67mr5675627oib.52.1623992425826;
        Thu, 17 Jun 2021 22:00:25 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id j3sm1566751oii.46.2021.06.17.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 1/6] RDMA/rxe: Fix useless copy in send_atomic_ack
Date:   Thu, 17 Jun 2021 23:57:38 -0500
Message-Id: <20210618045742.204195-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bob Pearson <rpearson@hpe.com>

In send_atomic_ack() in rxe_resp.c there is code copying ack_pkt
into the skb->cb[]. This doesn't do anything useful because the
cb[] is not used in the transmit path by the rxe driver.

Remove this code.

Fixes: 4c93496f18ce ("IB/rxe: do not copy extra stack memory to skb")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index f8a7ccd4d8b7..5565d88e0261 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1023,10 +1023,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	free_rd_atomic_resource(qp, res);
 	rxe_advance_resp_resource(qp);
 
-	memcpy(SKB_TO_PKT(skb), &ack_pkt, sizeof(ack_pkt));
-	memset((unsigned char *)SKB_TO_PKT(skb) + sizeof(ack_pkt), 0,
-	       sizeof(skb->cb) - sizeof(ack_pkt));
-
 	skb_get(skb);
 	res->type = RXE_ATOMIC_MASK;
 	res->atomic.skb = skb;
-- 
2.30.2

