Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DA34033CE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbhIHFav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 01:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbhIHFaq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 01:30:46 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB8C061796
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 22:29:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id q26-20020a4adc5a000000b002918a69c8eeso389185oov.13
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IfYMPJpGuyTJPl37XggKkTRsOxDAvBdRXK0FPdpZL8=;
        b=k/97KdxnUTinbEiQT2Hywv6Q8EP9tdjwY/bVz1yBpyadQL0SWWlkJFCVZuzpgr0D/n
         OfpDgIvC2LWTpcbXl9PIQ3C77TIXY9zPDiwNGWaaTVWEAkEyLnPiVA1Qodeq/e6lcC1V
         cadq6sNAsObeYu3FjmzoDErVFXvfFWDx3tFJrBAocAfK9mCB73R1UQnWES3VaKEK0Ykp
         j+Q+Vg7OcJx/YToPvINtho7y2bitsF9SQ1D/FIgWjJbJS0gx/o1JcP6C/XtAilu9zGuX
         UVdEz97uaURjkbYdI+2Gr3fNbBxF3YfNKV3of2JTIzHtCJhqVt5zss1mf/jAoMI08+ws
         0TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IfYMPJpGuyTJPl37XggKkTRsOxDAvBdRXK0FPdpZL8=;
        b=sioPkv+iqnzTh2bsYpit6WWOznbFbJN+fNWDc37TXpzd/nL/IMg6ojJwVIcQN49b/I
         73wNh4iZmL1xZ1hEyE+zt0ewouiazR/vquRmJbWZVIXi1+3x0LyYXwytbph7x8JwTM2o
         S9rdNIM8gJMQVWqU550mSHgZ0KbJ4ZarW/tuazHnjV90cWB/cnBOk8Iyr2TsT98gk5in
         2kk1i/2a3DzGQqTpB7aDMN1e3jEHW07NrkihhR03NGJs30ZnzUWdWFqRjxVCqxyU1AO+
         KK+mLuL51s9E2NSOAbCWceu/TGFUTdoAr8i/UcEcFRv+Ks6gBKqR7GRAZmxrTJy/ib8r
         1Ekg==
X-Gm-Message-State: AOAM530MGkj9bpuWhbmhjID3VpeceaTLlVOE/BzTeOwmZLxRLSVg0ZLP
        eYzFnyTc4S2wp/MG/D2WCP0WvjypJorJLQ==
X-Google-Smtp-Source: ABdhPJwPVgWkCH64pqIMqy2x3hUsqsns6gfjkr1zAUvyDoNR48tRFksqVllZlbp7DJZs5lMYhBcFmQ==
X-Received: by 2002:a05:6820:555:: with SMTP id n21mr1505780ooj.56.1631078978914;
        Tue, 07 Sep 2021 22:29:38 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-4049-a9c6-d3dc-35fa.res6.spectrum.com. [2603:8081:140c:1a00:4049:a9c6:d3dc:35fa])
        by smtp.gmail.com with ESMTPSA id bf6sm281183oib.0.2021.09.07.22.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 22:29:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH for-next v2 2/5] RDMA/rxe: Fix memory allocation while locked
Date:   Wed,  8 Sep 2021 00:29:25 -0500
Message-Id: <20210908052928.17375-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908052928.17375-1-rpearsonhpe@gmail.com>
References: <20210908052928.17375-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_mcast_add_grp_elem() in rxe_mcast.c calls rxe_alloc() while holding
spinlocks which in turn calls kzalloc(size, GFP_KERNEL) which is
incorrect.  This patch replaces rxe_alloc() by rxe_alloc_locked() which
uses GFP_ATOMIC. This bug was caused by the below mentioned commit and
failing to handle the need for the atomic allocate.

Fixes: 4276fd0dddc9 ("Remove RXE_POOL_ATOMIC")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  rebase on version 5.14

 drivers/infiniband/sw/rxe/rxe_mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 0ea9a5aa4ec0..1c1d1b53312d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -85,7 +85,7 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc(&rxe->mc_elem_pool);
+	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
 	if (!elem) {
 		err = -ENOMEM;
 		goto out;
-- 
2.30.2

