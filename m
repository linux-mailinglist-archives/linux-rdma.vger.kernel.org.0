Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2928D3E0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgJMSo1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgJMSo1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 14:44:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF3FC0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 11:44:27 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so1031413otb.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M72y4iaxXxCmok+mi0fM8eCK0l9E0ggim4bo2F/kTcY=;
        b=upKJRRTITnHsntTq0MQm7IwYVO0gcz6q0llrKdeB3ThHxyQvMHtuuL1q/qO/5u78kx
         xspHgs7puEb6sABw8/5JOCA7hONRQAE/94x9+pZJCTqzxFAoxndC3ohqPHEW8t/C3LlV
         w7qBuy3/3f0/YvpcI3Af7ZerWlIAaO8qamrxFtjnp+JbYCoQpsUmHKnAXpSyD9vH91sm
         bXmgYQ8ZK5n/ACoVe/B4h6dKIL4sSXbOytiUNaFLCjO1Ag09o9ph0XY414cL/W33UTAK
         ik0sqScC5mCYch+CgfCuXe/cw/auvyqPLolWxRiNVLVbQ7/yoEI+xSIXCrJaAUchbv1r
         k84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M72y4iaxXxCmok+mi0fM8eCK0l9E0ggim4bo2F/kTcY=;
        b=nr7CAJD/Br75zjXaPUh5DChm6V/O/o6P46+RUk6/qbua1PAVlBIe1xq7oTQtcRlRmH
         3aaWXI8bFYL+4ZsMa1Vw0u/nC96Zh+5KaQz8f2q0+CQBmR8O1fuM3BKWogDdloyzHu3Z
         0YSrkxZ6pYCztBauiE+mSvP2WQeaEB7wnkyRnrcc6sxEzWqW8bwm0ZB6vqMWifttokUB
         DLBPe/KAMeesZ4qxAjFfI6CImnVPKV9zmlYM3FAkJkVgxQRCQOEuNhlFMBXNMzMLtxFd
         7vmR4zy0hwiBgjLo7+sc+RZvLISf1mjYqPEe+HxsPeMfVyjtt8JaqkPofFT+LJ2W2p16
         FScQ==
X-Gm-Message-State: AOAM532uxBZRaZr+YeZ3aa9fk4rPsc+enPo++aSbinJ5GMXy9MyfnMWM
        38nnb4Bm6MfxTam/ssuYrLo=
X-Google-Smtp-Source: ABdhPJzOqblRy9uLgvkUOHu9DXyzHfLwSzJxS8zreyhZzeOAs8q3Ewh7FxNJ55QEky3rPIolO007gQ==
X-Received: by 2002:a9d:8d4:: with SMTP id 78mr778650otf.65.1602614666961;
        Tue, 13 Oct 2020 11:44:26 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-5ee5-86ef-4523-14d5.res6.spectrum.com. [2603:8081:140c:1a00:5ee5:86ef:4523:14d5])
        by smtp.gmail.com with ESMTPSA id x15sm278443oor.33.2020.10.13.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 11:44:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, colin.king@canonical.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe - Respond to skb_clone failure in rxe_recv.c
Date:   Tue, 13 Oct 2020 13:42:37 -0500
Message-Id: <20201013184236.5231-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If skb_clone is unable to allocate memory for a new
sk_buff this is not detected by the current code.

Check for a NULL return and continue. This is similar to
other errors in this loop over QPs attached to the multicast address
and consistent with the unreliable UD transport.

Fixes: e7ec96fc7932f ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 11f3daf20768..c9984a28eecc 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -271,6 +271,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		else
 			per_qp_skb = skb;
 
+		if (unlikely(!per_qp_skb))
+			continue;
+
 		per_qp_pkt = SKB_TO_PKT(per_qp_skb);
 		per_qp_pkt->qp = qp;
 		rxe_add_ref(qp);
-- 
2.25.1

