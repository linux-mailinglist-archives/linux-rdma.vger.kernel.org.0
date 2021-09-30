Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3641D266
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbhI3E3B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347937AbhI3E27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94607C06176A
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so5707641otv.4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=qLClRVegKJJOpqtO0PJ3KHIya6GOv0HA3uaEcOO8il507mNKvkzReF6SOmdpDRItpL
         4OhFANN/5XT2DWQFGGLWrog9uW4gl6w7mlFEoOXQjGoY3y70eI9DYtmAQoO5W73A15SV
         uKf5Jd/FPKJhWrHtLv42zZpu0Lz58buHk/ZvbMkcYgIIqTTQ2SF/PhbeXTBeAcSPzRtW
         RFKVTs6Wo19TsgMtKFI4LBSBgn0zkdZ7mUTxRiBKks0wk+ry31X0Ugukt2KE9/d+Rd+s
         LwZasa2+lzOhOuNhXUmpptJ2PZjItP0ZzXshfjjgDp4sF0iDds26SO8XjyZdBBBRBisk
         TUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fo+XA5ZhNhrA0pZdOhXylGStZB1nDPPpygrSUz+ZKz8=;
        b=QsWpkDkWsklJ1wL7KlIC862EaFyNY5FxePr2qxT1R6d8C5IllGO27B7LfBzsU8AGG9
         X+0IMwV0xAZTRzXz/BIY0rLJad1PmJ2PSYUm8bky7OJnE5Xk/SgtpH9ALkzbITlb9anx
         nZYTqF1U0zTeuvTRlhmlfK9+d7+yEUq2Tqcre+xQOPWJg70HpNRTWdGcWoWnBSAWAANj
         sLy372dlTkvFLmGZT547GZs/3dSdAbIRIDWoj5dbAJerMWrbO6rJyyQ7/AJj1eWi+/Qe
         ws/YJs751nEgroOHGWw8AoRaID3E7SXTkOcF5+AuE/VAnMHLggxH2UpQQYdLzIncRBcJ
         fcEQ==
X-Gm-Message-State: AOAM532Apm5BEWfV7cxMEQMptJvYqxzOf1a14w6Uo4TGsGYLg3JUmRm+
        hprGxwUBQ7YuU4BNq45Stg0=
X-Google-Smtp-Source: ABdhPJwMFHLTVcA/mhoQ9ePpwao4bKju4UhGKh2fqKhBeCMl/7E9SyU++6dg5jfytPnlDWuhI6KzyQ==
X-Received: by 2002:a9d:f04:: with SMTP id 4mr3164432ott.307.1632976037009;
        Wed, 29 Sep 2021 21:27:17 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 6/6] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Wed, 29 Sep 2021 23:26:04 -0500
Message-Id: <20210930042603.4318-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
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

