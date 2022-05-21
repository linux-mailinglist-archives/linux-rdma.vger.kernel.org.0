Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610252FAD0
	for <lists+linux-rdma@lfdr.de>; Sat, 21 May 2022 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiEULMB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 May 2022 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiEULL7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 May 2022 07:11:59 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28229811;
        Sat, 21 May 2022 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J1A0HT4A9+XSBl1+bJCGAWkhJ4mLksjBOsLJ1lWapH8=;
  b=E900oxFFw5U5KgtQAPIqWydJb+bYQDEmKkV50GhoyfSLPckysek5Z1k2
   ZUq0yR3BOKnRpA/8/g/FH8XSqVct6wSjraWkRHK91CWGNdg2yeAOjsGh0
   9LlZVqF+L9yaBwhxnZcR3JwrusOPsYv2w40Ctq61bsO23RLhe6B5iLP/P
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727891"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:52 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     kernel-janitors@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/iser: fix typo in comment
Date:   Sat, 21 May 2022 13:10:14 +0200
Message-Id: <20220521111145.81697-4-Julia.Lawall@inria.fr>
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
 drivers/infiniband/ulp/iser/iscsi_iser.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 7e4faf9c5e9e..dee8c97ff056 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -363,7 +363,7 @@ struct iser_fr_pool {
  * @cq:                  Connection completion queue
  * @cq_size:             The number of max outstanding completions
  * @device:              reference to iser device
- * @fr_pool:             connection fast registration poool
+ * @fr_pool:             connection fast registration pool
  * @pi_support:          Indicate device T10-PI support
  * @reg_cqe:             completion handler
  */

