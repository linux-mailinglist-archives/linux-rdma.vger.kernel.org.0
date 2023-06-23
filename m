Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4D73C2A1
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWVV3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjFWVVO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 17:21:14 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D408359E
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RgN37sI7dQZ+yBNJgvV+FVERbz2KA6A4JGbVoPo1D8=;
  b=ZLSOgmbfYoFK1LfswZnkAko5w1qaeuRTBPVtfsuJhYufYAShfc08lrY5
   GfmwSRRDmk+b4IYZGmpWxgs4LgkYSVKQuaZq7LE+mHoJVN5ZQicrxpb1d
   qwR/n8FqYT1ATKyZe3Ay1Bz27c81Fou59W2Zj2TESMWOmR77CEA5urk0P
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686177"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:13 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/26] RDMA/bnxt_re: use array_size
Date:   Fri, 23 Jun 2023 23:14:50 +0200
Message-Id: <20230623211457.102544-20-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/infiniband/hw/bnxt_re/qplib_res.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 81b0c5e879f9..f049b627e734 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -118,11 +118,11 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	else
 		pages = sginfo->npages;
 	/* page ptr arrays */
-	pbl->pg_arr = vmalloc(pages * sizeof(void *));
+	pbl->pg_arr = vmalloc(array_size(pages, sizeof(void *)));
 	if (!pbl->pg_arr)
 		return -ENOMEM;
 
-	pbl->pg_map_arr = vmalloc(pages * sizeof(dma_addr_t));
+	pbl->pg_map_arr = vmalloc(array_size(pages, sizeof(dma_addr_t)));
 	if (!pbl->pg_map_arr) {
 		vfree(pbl->pg_arr);
 		pbl->pg_arr = NULL;

