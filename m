Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5C3066BC
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 22:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhA0Vt5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhA0VsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 16:48:03 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD7C061756
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 13:47:23 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d7so3228595otf.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqmsYFt0HKnD9CI4LThLQ88mr/7oylX1HlIpZ7mnopM=;
        b=d9I9g4EMc8bo3WFV3L2aOEIfeH0DtvCcf9eqv+rHboeLGET2onpnQooS+wqWJ2bOWX
         z540FLh5OosbR8viTTaZLDZh7R6aetjpRYfDqp6dzNdwU6l33OXHEgUhZ1+p8rx70mgH
         zY/2eaWTl9uLIS5Sd1C8xuettxa0lBtMbY2wbrpn1P0Rrd7X+ja4KtXhkxUbjT21OkAe
         T2RRY7SdrcqHHNtQOoeWQxB1KBvuBC1GjaJPkMcynuB2hY8/smFiwho7yO54SFSM4+5G
         rCTStSiBilflTOJqo5Wi1B6iCVscKaFusUZvGCXH5p5GXMamNqrQElgAV8+zptatLBb3
         V8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqmsYFt0HKnD9CI4LThLQ88mr/7oylX1HlIpZ7mnopM=;
        b=LRUx4sdGHIas5b6rcBJo+7BrRTz0yN+w6UIIeI6PoesRs8zJrO028oe3+YpMw8b1YV
         buQqdiFOLjIJgisvN9vFiRFE7YFAtNrt1qUY1FjIIS6ZEP2pyAxa6lqxvyZZDxocbNPS
         shXABjnLbzIgvL+W+fkWkhLJCNUnS115j3Xyww0kW6YbORLX6TEwPcse+0JNT0ja3/VX
         7ILow5URoPyz38ljSsobgpheX0fIoau1M+dqX8xse/rPSykcfzKNMiHS2tDaOszbxMBX
         Wfk4vlhfKfXkEKaVtXqbHbpebFisoA0ry3xwru7npL9AhMzp86iPbbjNUKonX5CXlowB
         CCcw==
X-Gm-Message-State: AOAM531DR5YHUjx/oVz8/zOYsKaFN7v5dRytKblzNxBJCbfiUrL87Blb
        uuBThnVLsT5ZEZsatbwwZH8=
X-Google-Smtp-Source: ABdhPJx4MLx9Ltyn/M9Ym+9EkXbzQUzYsyfk9kLrrgeKD+UNMwNEbJHfQveng51WxidePLvLV0i4ew==
X-Received: by 2002:a9d:1e7:: with SMTP id e94mr9348668ote.219.1611784042555;
        Wed, 27 Jan 2021 13:47:22 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-c6c9-5eb3-064f-43eb.res6.spectrum.com. [2603:8081:140c:1a00:c6c9:5eb3:64f:43eb])
        by smtp.gmail.com with ESMTPSA id j11sm630235otl.18.2021.01.27.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 13:47:21 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_recv.c
Date:   Wed, 27 Jan 2021 15:45:01 -0600
Message-Id: <20210127214500.3707-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

check_type_state() in rxe_recv.c is written as if the type bits in
the packet opcode were a bit mask which is not correct. This patch
corrects this code to compare all 3 type bits to the required type.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index c9984a28eecc..0c9b857194fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -9,21 +9,26 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* check that QP matches packet opcode type and is in a valid state */
 static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 			    struct rxe_qp *qp)
 {
+	int pkt_type;
+
 	if (unlikely(!qp->valid))
 		goto err1;
 
+	pkt_type = pkt->opcode & 0xe0;
+
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (unlikely((pkt->opcode & IB_OPCODE_RC) != 0)) {
+		if (unlikely(pkt_type != IB_OPCODE_RC)) {
 			pr_warn_ratelimited("bad qp type\n");
 			goto err1;
 		}
 		break;
 	case IB_QPT_UC:
-		if (unlikely(!(pkt->opcode & IB_OPCODE_UC))) {
+		if (unlikely(pkt_type != IB_OPCODE_UC)) {
 			pr_warn_ratelimited("bad qp type\n");
 			goto err1;
 		}
@@ -31,7 +36,7 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	case IB_QPT_UD:
 	case IB_QPT_SMI:
 	case IB_QPT_GSI:
-		if (unlikely(!(pkt->opcode & IB_OPCODE_UD))) {
+		if (unlikely(pkt_type != IB_OPCODE_UD)) {
 			pr_warn_ratelimited("bad qp type\n");
 			goto err1;
 		}
-- 
2.27.0

