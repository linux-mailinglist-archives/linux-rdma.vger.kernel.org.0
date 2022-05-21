Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA57252FB46
	for <lists+linux-rdma@lfdr.de>; Sat, 21 May 2022 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354848AbiEULND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 May 2022 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353684AbiEULMp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 May 2022 07:12:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF25433BF;
        Sat, 21 May 2022 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9N8nahZzj4rybQN600ynTl9UgYSyEthZzxftYL78JTQ=;
  b=vbPegpRuYWqUVz6DLiOySqUmbhOy5oH6xAYOCH65yxLOHR/D4BQBjysK
   OS0HGXnIFWv5iiHq+al8nte0Vfhl30Ss5MZJOwS8WqSUQnroa/uaYSfYC
   dW3LV151uyoZA31v5D36A6vRVGOjcgkKfDgebZH8zGWFbe9OnYpYylGPZ
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727959"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:02 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: fix typo in comment
Date:   Sat, 21 May 2022 13:11:06 +0200
Message-Id: <20220521111145.81697-56-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/infiniband/hw/qib/qib.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index a8e1c30c370f..b37b1c6d35c6 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -678,7 +678,7 @@ struct qib_pportdata {
 /* Observers. Not to be taken lightly, possibly not to ship. */
 /*
  * If a diag read or write is to (bottom <= offset <= top),
- * the "hoook" is called, allowing, e.g. shadows to be
+ * the "hook" is called, allowing, e.g. shadows to be
  * updated in sync with the driver. struct diag_observer
  * is the "visible" part.
  */

