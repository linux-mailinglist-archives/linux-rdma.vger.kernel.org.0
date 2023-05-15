Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD93703E49
	for <lists+linux-rdma@lfdr.de>; Mon, 15 May 2023 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbjEOUMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 May 2023 16:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbjEOUMd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 May 2023 16:12:33 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1211B59
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 13:11:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-54fba751417so2662627eaf.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 May 2023 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684181515; x=1686773515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+O3rfHfywOmWfn+MzgLCbb+ukG6u2W6ZTaDd6ccfPY=;
        b=ihBPWEk6ZVL9mDR88otSVDX3ymNn++YbYaw8W52UdQNNaeX5nnDMChEpMi4xQLoXrH
         EXNbyfjCKb3EwcsoefGFyOeMvBKt7MCuZi9YjGw6WQiGUZ9+vf5Oec/jGzlQtDLuLEf2
         J1QavFYazpO7GiE5GXOeO/dX6Z5qJxcXPC119nO4mWENNr7aQGbJrvmtSBMdxXIV92Zw
         KTQi7tRdthiWWE5KAB1LkXxTATEBfieXFhGT3c/u/XsLpHgaFn1HhPL+rWMrzMG7mmUQ
         LvXsSYqsWXTRIIXt6ucmpffYi00fWOMYkbNWxGrclXT3/+vb5FRJ/wSmBzFYEEconzf0
         6F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181515; x=1686773515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+O3rfHfywOmWfn+MzgLCbb+ukG6u2W6ZTaDd6ccfPY=;
        b=AP3jOc8PnkwUXedg5SzkLd0jD/cupSgWCMp28BXd6RcV0LFQ/cvpOmdDOME91cOSzn
         25BaswlzU2zdzAaCmxv6W9VGwQYKFH012jAGfeyKyCxzbNT5oRW2AFpsa7r1omoV0TVc
         xJWpfZJmwq46xuRFeUF0gjm8cEA7RSiFyvYc8dcWLIIIVTfe51Yfn5UD0WJMRfHCHDTa
         HCay8q/4G5K1nC4ULRargaJ2RNndYF8A0lulGaLjYaZIQF172K2EZsnjuYQVfkKyfHON
         i4ekL+q0Udhx8OJdnLSbdSSRaDT7+BXnxc9sEx2srO0dDeU8yba9PoqXjw6e7i/2ce8N
         cWPw==
X-Gm-Message-State: AC+VfDzoMx31369b8HCgpOCO2rl8Tp0nSrIklAB5S78rMaT2HlezTcNC
        oCREcen+cemjJJuB/dB5GDHZLOYZXRMoYQ==
X-Google-Smtp-Source: ACHHUZ6x8+rCntX+PjpwtVav4Va1uGXoc4kuyA94eQzbogyLAm9Koi6YEYSttAlOz4jg0G6Rs94fHA==
X-Received: by 2002:a4a:a5ce:0:b0:552:3abe:f179 with SMTP id k14-20020a4aa5ce000000b005523abef179mr5957436oom.6.1684181515028;
        Mon, 15 May 2023 13:11:55 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-0ce2-a301-d348-5f68.res6.spectrum.com. [2603:8081:140c:1a00:ce2:a301:d348:5f68])
        by smtp.gmail.com with ESMTPSA id f2-20020a4abb02000000b0054f5b9290ffsm8897672oop.34.2023.05.15.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:11:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     dan.carpenter@linaro.org, leon@kernel.org, guoqing.jiang@linux.dev,
        jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix double free in rxe_qp.c
Date:   Mon, 15 May 2023 15:10:57 -0500
Message-Id: <20230515201056.1591140-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A recent patch can cause a double spin_unlock_bh() in rxe_qp_to_attr()
at line 715 in rxe_qp.c. This patch corrects that behavior.

A newer patch from Guoqing Jiang recommends replacing all spin_lock
calls for qp->state_lock to spin_(un)lock_irqsave(restore)() since
apparently the blktests test suite can call the kernel verbs APIs
while in hard interrupt state. This patch needs to be applied first
and Guoqing's patch modified to accommodate this small change.

Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-rdma/27773078-40ce-414f-8b97-781954da9f25@kili.mountain/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c5451a4488ca..245dd36638c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -712,8 +712,9 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	if (qp->attr.sq_draining) {
 		spin_unlock_bh(&qp->state_lock);
 		cond_resched();
+	} else {
+		spin_unlock_bh(&qp->state_lock);
 	}
-	spin_unlock_bh(&qp->state_lock);
 
 	return 0;
 }
-- 
2.37.2

