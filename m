Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224334FDF6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhCaKVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbhCaKUt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 06:20:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC79C061574
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 03:20:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so874351wmj.2
        for <linux-rdma@vger.kernel.org>; Wed, 31 Mar 2021 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pp9VrO7pCwe3y99hUI2u77vn3T9zmwLCNUsm+L9TeiU=;
        b=CU56CFfr8BnkPXiQKs+KaWKA7OgD34RZ1CBFHOKVmrTzQMie6nqiQNehYVvPe6BYof
         gxLnl+t9RXYQAqOMK/hYlDVYIaXjricf+SjPmpGz5EhhR4khTLgicM0ucfLqrCV65weA
         kp1J7uCqWbQMA+Sh2MvFHUboJVCjIBYpeOadyC6+0QseYSDXa+/3xANgZTJPsx76FOv5
         L5wS1IACf6DJRVyJvYoodgRMsQPez1ztrUnFV0j2TlEl2f1avV7uqVTThgKKbZOp4qdF
         /b/+BDTYbvuIV3yKL2jrtAB6ee611ZpU4X2DxNwANH6zJT/DSbygTPdkfcuNKB9WAhfw
         cXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pp9VrO7pCwe3y99hUI2u77vn3T9zmwLCNUsm+L9TeiU=;
        b=oYpGHfoSQeM9+rJebMp7AI2J5t8TIlZSArPGannk5vQ7ZyfWih55XIpAU+LN/rcQR+
         BSlWujLVItzQ0MB0ZmHt+BaDwVzrZ9AFp6TwLd0H5Ws3r85AuKb6JImPS/QpNfVtYl3z
         mhPQ4MBlPDmC357Gt5M1NG9LT5B1qiUQrPNXIp2SReNw3SG8GR3w5uB6eQW51bp+37pr
         FSWwAub4sgFBpkwn/tlwWDFOkSNjre08NSRSHM96UESusmYqRteH0VmEWXWNuEp+vW/D
         v6WGJCHtx7qxqt95i3q5mQoNXGXHMfCcm4j7TDYi997M9rNYnsnm4J936zhUxNH3Tolo
         rS5A==
X-Gm-Message-State: AOAM533gNxC6XZHOe90EG9EU/MmBtS4o6hxzPU5gryNJwQj9mWuRm3gM
        plAbd6q7yAlkBdDGjmDmpbETciMbO2uHNw==
X-Google-Smtp-Source: ABdhPJzhYgNV4fCeRM7FKBKGx5L1Cquykexod1aQll6AkMbTzPFrU1Y4YAoHweFuzUYKJqdIPsQVzA==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr2512843wmk.31.1617186047970;
        Wed, 31 Mar 2021 03:20:47 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([5.29.19.173])
        by smtp.gmail.com with ESMTPSA id j30sm4048033wrj.62.2021.03.31.03.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:20:47 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove rxe_dma_device declaration
Date:   Wed, 31 Mar 2021 13:20:43 +0300
Message-Id: <20210331102043.691950-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The function isn't implemented - delete the declaration.

Fixes: a9d2e9ae953f ("RDMA/siw,rxe: Make emulated devices virtual in the device tree")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0d758760b9ae..8adcef54e4b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -116,7 +116,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-struct device *rxe_dma_device(struct rxe_dev *rxe);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
-- 
2.26.3

