Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D19306756
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhA0W4h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhA0W4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 17:56:10 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F8C061797
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 14:43:11 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 36so3377491otp.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 14:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHjIsFpC35w9rbYFfrGlGTOUv4ZEsyg539dRts1qhio=;
        b=bJf3kjFnHLmF2PsOBTfYWYf5CiyngKImLn1AuSEKtU7zez7aMAgLn0EzPdXZAdugd+
         pKHAiqQonzATzjrTOoln6Oc1m2jsEEIT6SwDrZjgPxdnOOtoFRPfLQNVDgAQ8Y5yAZRx
         GIag4IUhk1h8gZiIdoKkK/QDiDknLm0aQjSG+5GWhvfB1PtsOJ8lBoCTIoIXzwQ/1paD
         rvL+1a3wbMDaxIPuM+MINCP4EK5PZUNZceWlICoydoSTlEUiVXZxz+Vh9cQeivILAJGP
         RNgSIlPfDirONHbgEwU/S74eDravvP6znAEnZGRL5RNjGMtZojX8Fd7jAVzFzON5d64/
         LD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHjIsFpC35w9rbYFfrGlGTOUv4ZEsyg539dRts1qhio=;
        b=m2QDdeFbiF94wviRkxYYO1iZAZ0sANkcymZfrwlENNn0w3RySfcHoMB/e5uFpcbjLX
         Jh3kPn3CEAt1fP4vjB5n3TbenUys5cU1ivnI7/mOq7Yw8Y+QmKG7TktJ3SWcSCm/myI9
         KSrI14A8BkjgWlSwAzTUbJv84TdMgAEyzXgWbLE/6bck40ZgIp2Utllk6bItCbe3DNX5
         bjgH6qSaGGhWWLvGUonmHVyahbdz7WjJzUe4KOc1w1qtaKLvQL4xnFXx3Ygeh0S52i5k
         0MdcXArcQr58qUdpjj+BEusC/Mu87cmrhCvVjXSejH4ixOMKFC7HK9eWHX5hcLYOtC2j
         KEQw==
X-Gm-Message-State: AOAM530nuG0IgoQoW3qUY1NabEaAhCXbQCmXggHcLRathFMNZ5+lKjRR
        GWfUfhWkK9ibruoxSPIsObk=
X-Google-Smtp-Source: ABdhPJybBFBpgdIzR05J/Wojn2vt3lqU/PWNH0VKiB3FYVSERUNuQ8R0V73nP37SFjZXpQlcxIvX3w==
X-Received: by 2002:a9d:2065:: with SMTP id n92mr9299986ota.150.1611787389134;
        Wed, 27 Jan 2021 14:43:09 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3da3-be79-360b-232f.res6.spectrum.com. [2603:8081:140c:1a00:3da3:be79:360b:232f])
        by smtp.gmail.com with ESMTPSA id s10sm714646ool.35.2021.01.27.14.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 14:43:08 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Remove useless code in rxe_recv.c
Date:   Wed, 27 Jan 2021 16:42:04 -0600
Message-Id: <20210127224203.2812-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In check_keys() in rxe_recv.c

	if ((...) && pkt->mask) {
		...
	}

always has pkt->mask non zero since in rxe_udp_encap_recv()
pkt->mask is always set to RXE_GRH_MASK (!= 0).  There is no obvious
reason for this additional test and the original intent is
lost. This patch simplifies the expression.

Fixes: 8b7b59d030cc0 ("IB/rxe: remove redudant qpn check")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index c9984a28eecc..83a5c4f6654e 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -85,8 +85,7 @@ static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		goto err1;
 	}
 
-	if ((qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) &&
-	    pkt->mask) {
+	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) {
 		u32 qkey = (qpn == 1) ? GSI_QKEY : qp->attr.qkey;
 
 		if (unlikely(deth_qkey(pkt) != qkey)) {
-- 
2.27.0

