Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBF3E2644
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbhHFIkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbhHFIkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 04:40:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B8C061798;
        Fri,  6 Aug 2021 01:40:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so16512101pjb.2;
        Fri, 06 Aug 2021 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcgJ7BmG19e9J+Fyykd+TleMZbFOkt7nwgegyNBll7w=;
        b=mmswa3LN0RRthiDbkdiDMlPcbdSKAlitTYRNFn6ZlHfoOT5H6ZfFYn0c5IHazV+j37
         6z7myf3WXPWYdRk+8y2GwRSX6ZAMGFgtlJKblATKmU2k34FCPUrn1l9APL5PNx5qMnw1
         7wMPOgWcRiow2EqpwuXomhyu+NflWuMY4+di+h8m8QAwlyCSUv740p1a/WJHJKqsokcA
         FbTV8PBWtWPJ4g2XPElkwSsbK3nWZpaZ//BWXQZa1z3gwudwUTs1UjA8MdWC4T5bO4Hh
         iDK/Qr4LUb+spcChyVK1vOBn6oPYIwXzlpInfNvA22Ez6yeldKsZiosIzAlU6Gi45xk7
         FMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcgJ7BmG19e9J+Fyykd+TleMZbFOkt7nwgegyNBll7w=;
        b=ZbyQfLN1K6HtZTSuA2iMsc6EaQtIyEgiDajfKDSS66Fu/A2jdQ6fdwfZeYO+7DV3ae
         AtS915BRT5jZJYY+ihaI7LOrNaiRyYp1Vy+D4soDJNUe1sFoxjfUz4oalFW1bKTIYDsF
         rzxhQKKdQQ1i4neHASgnvgA1TE5yZ3l7LcsgdDShMNl1lS7t1HAslmUeV1CpTtTbhT8O
         Uo+4qS4OWgH0EwF75huUJmUmG3vi1JUiAASgNbuxH/RevrUMwqvMjBq7A+u8FYo8ADdl
         h3/oy7iug3TxgmcYY9jFK0LNbwFrMJU5NsVuMH540UCluUOG8rQuPjqxfNotuDOft4az
         kj6w==
X-Gm-Message-State: AOAM533xueOs3EYsoNQRfhWNvxyEmLIE+dd6jin3aZfdToNFB/i02Mhg
        bYb4trcxpqOgJwGcNhbI5AQ=
X-Google-Smtp-Source: ABdhPJxHtGGK501guljuBWNDEh3QZdOYFiVQW+aYtHxXbcJfHJ9tTgOlq+j7QV7/+XT9GXMvS3o5yg==
X-Received: by 2002:a17:902:ab45:b029:12c:17e1:f817 with SMTP id ij5-20020a170902ab45b029012c17e1f817mr4553799plb.60.1628239230845;
        Fri, 06 Aug 2021 01:40:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.87])
        by smtp.gmail.com with ESMTPSA id x14sm9362220pfa.127.2021.08.06.01.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:40:30 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v2] IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_descs()
Date:   Fri,  6 Aug 2021 01:39:53 -0700
Message-Id: <20210806083953.193278-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kmalloc_array() is called to allocate memory for tx->descp. If it fails,
the function __sdma_txclean() is called:
  __sdma_txclean(dd, tx);

However, in the function __sdma_txclean(), tx-descp is dereferenced if
tx->num_desc is not zero:
  sdma_unmap_desc(dd, &tx->descp[0]);

To fix this possible null-pointer dereference, assign the return value of
kmalloc_array() to a local variable descp, and then assign it to tx->descp
if it is not NULL. Otherwise, go to enomem.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v2:
* Assign the return value of kmalloc_array() to a local variable and then
check it instead of assigning 0 to tx->num_desc when memory allocation
fails.
  Thank Mike Marciniszyn for helpful advice.
---
 drivers/infiniband/hw/hfi1/sdma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index eb15c310d63d..6ca8d065f44e 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3055,6 +3055,7 @@ static void __sdma_process_event(struct sdma_engine *sde,
 static int _extend_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int i;
+	struct sdma_desc *descp;
 
 	/* Handle last descriptor */
 	if (unlikely((tx->num_desc == (MAX_DESC - 1)))) {
@@ -3075,12 +3076,12 @@ static int _extend_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 	if (unlikely(tx->num_desc == MAX_DESC))
 		goto enomem;
 
-	tx->descp = kmalloc_array(
-			MAX_DESC,
-			sizeof(struct sdma_desc),
-			GFP_ATOMIC);
-	if (!tx->descp)
+	descp = kmalloc_array(MAX_DESC,
+					sizeof(struct sdma_desc),
+					GFP_ATOMIC);
+	if (!descp)
 		goto enomem;
+	tx->descp = descp;
 
 	/* reserve last descriptor for coalescing */
 	tx->desc_limit = MAX_DESC - 1;
-- 
2.25.1

