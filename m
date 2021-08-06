Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9D3E2B65
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHFNb2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHFNb1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 09:31:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB342C061798;
        Fri,  6 Aug 2021 06:31:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so7060592plh.7;
        Fri, 06 Aug 2021 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAztCBArtZC7HRKhC7762eisKH/x8j781ZnsXWVLa00=;
        b=aQoU9ha/sqeKILrBMF1n75POJb4TtHrBPhPtSalXxDmceP2K+ZD02SX/Ov38fqCiWF
         mkJoJX0h5PO/8Kvscb3kCME3ZRPQ6ovBirX8LKBUKqm+GUE0dGuft5/vXGANQFZ/vNZQ
         7yZXRa7wXtD5K7e0V51D959yNV1uOEbWgoX3nLJmQEgqOX6AWTTuTFhYjIULyA0EpBqu
         rBmzpkWJSagzdNGH9VK+oQQzqsnlMlDRWWBuhSYn50bQN11WLjzSH9dvqXU9ESLUM9Lp
         ubfY80HfvOM4jJbUltdAZSGQf95ZR/EqOWJzTYpCIah9oca9bUjeNSMzZUFG8DQQjo7x
         k6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAztCBArtZC7HRKhC7762eisKH/x8j781ZnsXWVLa00=;
        b=TQCxkBOlO0U5gqyJRKB804+tLY+HBnlXkpVRFbemrAwJWTWYWCqX1kYjfTzf3g8M+a
         Vq9C1xa1JpX+QgAFIjesmlVQubhjgxAHARDa9u3YpVgPkZDGlTVM4Eeun5y6IpbyI7PD
         r4Bzjb7Qm3Hfqj42LehmLQMyJm1Tvlgd+mGCIzM4NIE9wRkYmZc3GgUs4CD2GCWUWKXT
         7RJTCrJTFYZJeTlu7FLQjBPomtrWiOuRvjQwWCIGYgNoUxFRWyhHZsl0OMNbRJxdqyPe
         J6bZPAGbpKVcusOghGL+nfCzQVj9Hi4+eVigDGAtP+sz8wW0oQQn5IoIBtjy00LRuw+A
         haKg==
X-Gm-Message-State: AOAM531ejPAcAkWHcozbtQeBldzcaVnSakBXXvnc2/2rNsmvXYdgXycJ
        yPKsHcqaCEM5jyI7P/AWi8k=
X-Google-Smtp-Source: ABdhPJxen66KJ8USlvrVknakga7eaRL+dQuLBI2B6TcLIka2a0XfcpPcAkmAgBAfi++Iu2bN9pDODQ==
X-Received: by 2002:a17:90a:98b:: with SMTP id 11mr10585748pjo.144.1628256671475;
        Fri, 06 Aug 2021 06:31:11 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.81])
        by smtp.gmail.com with ESMTPSA id o127sm10949491pfb.48.2021.08.06.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 06:31:11 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v3] IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_descs()
Date:   Fri,  6 Aug 2021 06:30:29 -0700
Message-Id: <20210806133029.194964-1-islituo@gmail.com>
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

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
v3:
* Add fixes line.
  Thank Jason Gunthorpe for helpful advice.
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

