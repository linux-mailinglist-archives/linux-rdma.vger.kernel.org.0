Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5934F8D6E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiDHDcj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiDHDci (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 23:32:38 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB6D32B713
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 20:30:35 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AxzNSX6IXdN1zcpOkFE+RBZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC63WhxgjxWymoeXm7VbKyCNjf2Ko8gaYSz80oC6pbUzoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToySAmd9hjtdcnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZvEeqeaZeBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiHiuWw6LG2UO9hgoIkNsaDFIEQtVlm0zDVDP9gSpfGK43O5NlFz?=
 =?us-ascii?q?HIqisVHNejRatBfajd1ahnEJRpVNT8q5DgW9AuzriCnNWQG9xTO/uxqi1U/BTd?=
 =?us-ascii?q?ZiNDFWOc5sPTTLSmNonulmw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACHTJdKArjxTRPFflHelG55DYdb4zR+YMi2TC?=
 =?us-ascii?q?1yhKKCC9Ffbo8PxG/c5rsyMc5wxhO03I9eruBEDiewK5yXcW2/hyAV7KZmCP0w?=
 =?us-ascii?q?HEQL2KhrGD/9SPIUPDH5ZmpMJdmrZFeafNJGk/ncDn+xO5Dtpl5NGG9ZqjjeDY?=
 =?us-ascii?q?w2wFd3ATV4hQqxd+Fh2AElB7AC1PBZ8CHpKa4cZd4xW6f3B/VLXBOlA1G/jEu8?=
 =?us-ascii?q?bQlI/rJToPBxsc4gGIij+yrJ7WeiLopysjbw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123409161"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2022 11:30:35 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id ACE9B4D17160;
        Fri,  8 Apr 2022 11:30:33 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 8 Apr 2022 11:30:34 +0800
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 8 Apr 2022 11:30:35 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 8 Apr 2022 11:30:33 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <rpearsonhpe@gmail.com>, <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Generate a completion for unsupported/invalid opcode
Date:   Fri, 8 Apr 2022 11:30:29 +0800
Message-ID: <20220408033029.4789-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ACE9B4D17160.A8930
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current rxe_requester() doesn't generate a completion when processing an
unsupported/invalid opcode. If rxe driver doesn't support a new opcode
(e.g. RDMA Atomic Write) and RDMA library supports it, an application
using the new opcode can reproduce this issue. Fix the issue by calling
"goto err;".

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..8a1cff80a68e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -661,7 +661,7 @@ int rxe_requester(void *arg)
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto exit;
+		goto err;
 	}
 
 	mask = rxe_opcode[opcode].mask;
-- 
2.34.1



