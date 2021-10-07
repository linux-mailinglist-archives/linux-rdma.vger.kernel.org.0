Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76609425DBE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhJGUna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC42C061760
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so9124851otj.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=iDrdrnhdQM9PLEKBJQUGjc67pUr5MnTaC1lR87D8wAlk9KhXe7ZfHb60HpF7kkAi4H
         uKYLGUcDbTI7xr47MKWOjtBGFHG5xTEOhdXv+Rnf5bkI73Fl53HHqFWXO/tkjskqKPqt
         bilfTwBIjeEsamhBU3l27ooTH2znaq4VFOaTZaJnv6iRyt8dWUA7qBzp1IlU0sojnVYp
         ElWlYFvhO1SE6+5oPU/AWoF9jfkmeIA82zHA6bDsZM5p6+U/i36/8knxxUkxrX6X6AAy
         jrExvYoiqIIIPcuT6fglQRVtOWLEGdpK1+owYiY7LQB7K7Al8NVRzE6Tz2A90pQNeuG8
         RLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=EfOMCqflXgGe2GnzFIttEUQCCV886S4vhEuJztqcQ0HLdypkYqRRInNgDmvEV5M0Sn
         IRfWKCSLd3+kVUGOGdcRh12APtVej+CmJPpicTeTYcpo19jq+noexEplN5IkSt+/+xww
         zSIgCW8OmI+7bl/zqMy2nhbh042fVQlA8j+nR1JWO17s9bPB5gevphzyi/frtRkboR5R
         jIXpViKLx2QxK351UAbJXQqA15/kP60y3hE5BZdfe8okWUvARfx278A67p/nLbSU6OmZ
         l5/hRAn/RIiD221FFmnD+uQ+ZG5XobDprCvR2jmuVlUvHTVDQcJAPX7ABBY85YdRWoY+
         o5Xw==
X-Gm-Message-State: AOAM530j8nYmpH9hN5VbBy1xSIQ4BfBCuS6YtJPlfbDK3TRbkX7ddobP
        +xDssAAdrJhsqDUG7xdUuweTTrUnOro=
X-Google-Smtp-Source: ABdhPJz3XVQDEmiP4GWWyJWvRGAyBxQOylnXGbZuGJYsmFC0PK34FfX2b55LCRQVTlCOS3HFWBZN+g==
X-Received: by 2002:a05:6830:438a:: with SMTP id s10mr5504644otv.173.1633639295033;
        Thu, 07 Oct 2021 13:41:35 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 6/6] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Thu,  7 Oct 2021 15:40:52 -0500
Message-Id: <20211007204051.10086-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
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

