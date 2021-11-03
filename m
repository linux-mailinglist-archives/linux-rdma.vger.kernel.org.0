Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0B443C5A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCFGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKCFGT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A90C06120C
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso1976278otv.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYTpsxLJozvSfXsYM6NOP3PsKl5j9c3YAHcwOR977gI=;
        b=mIO4X2fPjE+hzDbIwhDSrV45ePIq8xJ+Xdf0JDrCx0t5h8WBNKYNLzTrnHZsEzl1OM
         ah81cIZvX6rgIangeLPvlsMgeqvebzM94oUO+ySQix5BlCcNbRSwapE4VY+Q0xCA6Vtz
         I2JyVAepr94hQzlX6of8ciuPd5Rnwl7+rZhKmqxcIw2asZ8TuclQblazKKMcSkMn2J0+
         wGmn6dQc6SHajM8B74yL3ldqlyYVTH1ySdl9/rdTdDudGwf5rarlECg+5KUKRiG/2qSo
         1NMPf8E1wUCwMq+RJ395ZDPMIf1N7v19yHYKkbmP84kYEHmbT/Q+8ky6IcCijQUUua0G
         43Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYTpsxLJozvSfXsYM6NOP3PsKl5j9c3YAHcwOR977gI=;
        b=h83reRJwk/4YaL34xCpCk1kfUM57JfsUpI8n2tcy9XWS1mhAGng80P+HP78iKc8tiI
         dHuMk+M9jzhjC9gQZihvHHUpHpT7wrtHkdcuokVgB1UNmyDNwkk75DKcTwJ77QupyvpY
         IaOnM9UB8dW2b/e0lePP58RxmcX+BCRnaqNFYRqnuRp4qR/ZOmIN/ygznQ4PUjo0H21i
         rbqfS2SlSaOzdTFHSNsEV2Va2YOII/xVyayOiIdnAxwuACF9i/9cqbY18B246rOFuKUI
         TxHMG6M277HbxSk2mDjJjF+CeOumXQa1vUAURr1k8L4fwlsrj61gAZom39acnWLFbcTA
         R48A==
X-Gm-Message-State: AOAM531NQRSojtpxdH9Lj9O0GH4IuPQG6vUq/WGkMN6twa9trmFipjhv
        Q/zSQAIDgn+LLyl1wwVRUpQ=
X-Google-Smtp-Source: ABdhPJwfeEZATRWxOAjE5meYyam2eCgvDId9BGUbPKORSg47oe//iLmzBZwV7tpb1XVBG3Uab1pxSA==
X-Received: by 2002:a9d:12c2:: with SMTP id g60mr5093687otg.372.1635915822892;
        Tue, 02 Nov 2021 22:03:42 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 13/13] RDMA/rxe: Protect against race between get_index and drop_ref
Date:   Wed,  3 Nov 2021 00:02:42 -0500
Message-Id: <20211103050241.61293-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use refcount_inc_not_zero instead of kref_get to protect object
pointer returned by rxe_pool_get_index() to prevent chance of a
race between get_index and drop_ref by another thread.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 863fa62da077..688944fa3926 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -272,8 +272,13 @@ void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index)
 	}
 
 	elem = xa_load(&pool->xarray.xa, index);
+
 	if (elem) {
-		kref_get(&elem->ref_cnt);
+		/* protect against a race with someone else dropping
+		 * the last reference to the object
+		 */
+		if (!__rxe_add_ref(elem))
+			return NULL;
 		obj = elem->obj;
 	} else {
 		obj = NULL;
-- 
2.30.2

