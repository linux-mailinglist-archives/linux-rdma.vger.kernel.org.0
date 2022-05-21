Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33E52FB70
	for <lists+linux-rdma@lfdr.de>; Sat, 21 May 2022 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiEULPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 May 2022 07:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355024AbiEULOF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 May 2022 07:14:05 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154E13129D;
        Sat, 21 May 2022 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IH3/VnVrLuGMaaxoHOH/EHWbIQ/9NHXAPtai+38Nr0E=;
  b=uOPBbfzv71iW7ljzl3a/j23mxWXbumwYiNsbIzhlXIa8L78OEqAvxsZc
   +8vruhssScJXUyFhWhFEtr3JUN5GTZNs4+0NRlhn7nyyn7+ylS4RzLIpN
   oZ35F8ljfwrMZWNw46NQvOMl9pvGThScvGoYu5NUaii3wThP+SxrZEW5H
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727994"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:07 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: fix typo in comment
Date:   Sat, 21 May 2022 13:11:36 +0200
Message-Id: <20220521111145.81697-86-Julia.Lawall@inria.fr>
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
 include/rdma/ib_verbs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b0bc9de5e9a8..9c6317cf80d5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -578,7 +578,7 @@ struct rdma_stat_desc {
 /**
  * struct rdma_hw_stats
  * @lock - Mutex to protect parallel write access to lifespan and values
- *    of counters, which are 64bits and not guaranteeed to be written
+ *    of counters, which are 64bits and not guaranteed to be written
  *    atomicaly on 32bits systems.
  * @timestamp - Used by the core code to track when the last update was
  * @lifespan - Used by the core code to determine how old the counters

