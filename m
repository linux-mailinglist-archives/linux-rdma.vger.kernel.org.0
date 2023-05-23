Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C898270DB5C
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEWLTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjEWLTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 07:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0B138;
        Tue, 23 May 2023 04:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F0160E0B;
        Tue, 23 May 2023 11:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CD6C433D2;
        Tue, 23 May 2023 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684840745;
        bh=YI10/CtrKx2ZguyfY3i1SmrBWD/XN19a6GcJNpCbL7A=;
        h=From:To:Cc:Subject:Date:From;
        b=rv4d3d9+maRrNM243LxwQx9hlrYw6nVqdPMyvlrxgPCffNfKjakgCHOH67jZ6F/3O
         xKmNFBi31m/pEOkj89KSIyYRV66olDFonY7reVhbslZ7t6vb/zviCan5KSivJrDRkL
         r/h5/BFan2qvA4FxCSo0tf+cobA4nL5JZpCV5FeAbqTY80AxYSfL382gubrEQnGkCF
         7R3PCVdhtOEBdSjodGgbODPgtWEhXaJmrQ3E4OYfYKT90FWA/DdfyZ7L1RFKqQZwU3
         fzdNQtfuGe3X5c2uKwo1cIlK2Oem6CGXVRSjlJVU/hN17TNcN7pMSgULQiGRreuqC9
         CmnqtzzqXWiUQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sindhu-Devale <sindhu.devale@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes
Date:   Tue, 23 May 2023 13:18:45 +0200
Message-Id: <20230523111859.2197825-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") triggers
a warning for fortified memset():

In function 'fortify_memset_chk',
    inlined from 'irdma_clr_wqes' at drivers/infiniband/hw/irdma/uk.c:103:4:
include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  493 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here isthat the inner array only has four 8-byte elements,
so clearing 4096 bytes overflows that. As this structure is part of an
outer array, change the code to pass a pointer to the irdma_qp_quanta
instead, and change the size argument for readability, matching the
comment above it.

Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/irdma/uk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 16183e894da7..dd428d915c17 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -93,16 +93,18 @@ static int irdma_nop_1(struct irdma_qp_uk *qp)
  */
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
 {
-	__le64 *wqe;
+	struct irdma_qp_quanta *sq;
 	u32 wqe_idx;
 
 	if (!(qp_wqe_idx & 0x7F)) {
 		wqe_idx = (qp_wqe_idx + 128) % qp->sq_ring.size;
-		wqe = qp->sq_base[wqe_idx].elem;
+		sq = qp->sq_base + wqe_idx;
 		if (wqe_idx)
-			memset(wqe, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0 : 0xFF,
+			       128 * sizeof(*sq));
 		else
-			memset(wqe, qp->swqe_polarity ? 0xFF : 0, 0x1000);
+			memset(sq, qp->swqe_polarity ? 0xFF : 0,
+			       128 * sizeof(*sq));
 	}
 }
 
-- 
2.39.2

