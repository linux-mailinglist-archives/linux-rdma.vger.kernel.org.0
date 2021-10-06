Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F368A4235A5
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhJFCAS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbhJFCAS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCACDC061753
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w206so1894560oiw.4
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=lZ7BIm/HaWfMSmBZRtKPQDn6e2J43PHrSPtaiqnwFrhGOuRzZcYnDu+UnXVoKi2wcT
         TLZSx2ebkyYx3Q+JeK2yQytCck1RnXYws/tkd3CsVCGM1MT1ktFFwm477J21ijMbCFFo
         nVLOYCGn9nmuc0nuP1Mb/PsS4r72n56ksxIjG2W6Eav9AcnRjnIB09O9142h47uEFhz7
         F7bD/cUT27dTqgYklzbSTrncDV0Ym3Fi1zgi6YNaTQy+kGMAYrTJLINgeqEoufJG8EJv
         KBJzZtYwz3oqyfupZEuntlVXnCZyhCsrrNvXSvUsPLYyvh6D1HfkiRPNoIVxWTdPO1CZ
         yz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=TufovchYGe7LUNKU6oJaR+1+sqKMIvpY2uj/gwbXVnoqCOjnmoOJMktrfA4b2OlLe1
         RaH3ACyd0AzktQ34TFU8X6f8RCwqLnYwByYofL0lIvmVkAIReRdkSe8L3P6HMRzoMDWK
         MfRt84QfSg88YyRvVQFBM+O2NBTk44dwz6I6KIreQpxvrrXOurlYI+LGmyx8f5NyqUTC
         WESyUheoGxJjzA+t1oKNZlgxF1+SSWU0ObDyxdUGRQLyClSXNriRi7clx049PErGC+0t
         JVJz/H6n316pKyTDVPfPoFG06L1ToMBEoY41HBrBu+aKXk2MzPhP2zJd2qlQE65NdpTw
         Q7GA==
X-Gm-Message-State: AOAM533xxRL8qNXnWOBU/Uu4riQahL0MDQ4Hgq63f1NY2gzsD+otEiRb
        6U6gtyZc3cHc1HfQVEAmsHZeqh0yLtqCAQ==
X-Google-Smtp-Source: ABdhPJyYthypV8SjEZAP574Z9fSWoJH66y06hI5yVuL5BBb+G1MTtQRT9mfqpJqG00AX02dqGpTD1g==
X-Received: by 2002:aca:c6c9:: with SMTP id w192mr575945oif.116.1633485506275;
        Tue, 05 Oct 2021 18:58:26 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 6/6] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Tue,  5 Oct 2021 20:58:15 -0500
Message-Id: <20211006015815.28350-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify ib_post_send for kernel UD sends to put the AH index into the
WQE instead of the address vector.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 8854ace63acd..b808777e2221 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -537,8 +537,11 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI) {
+		struct ib_ah *ibah = ud_wr(ibwr)->ah;
+
 		wr->wr.ud.remote_qpn = ud_wr(ibwr)->remote_qpn;
 		wr->wr.ud.remote_qkey = ud_wr(ibwr)->remote_qkey;
+		wr->wr.ud.ah_num = to_rah(ibah)->ah_num;
 		if (qp_type(qp) == IB_QPT_GSI)
 			wr->wr.ud.pkey_index = ud_wr(ibwr)->pkey_index;
 		if (wr->opcode == IB_WR_SEND_WITH_IMM)
@@ -610,12 +613,6 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
-		       sizeof(struct rxe_av));
-
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
-- 
2.30.2

