Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337084E920B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Mar 2022 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiC1J4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiC1J4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 05:56:24 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE1D54BFD
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 02:54:42 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A15PaXqD5FmhtVhVW/8Xhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fUVK70mtw0zdTm2pMWmyHO/2JM2f3eot+bdzloEkAsZ6Ax9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSXomZ/0ep++vzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglfxmFhf+whqC7V8Foh8I+PI/nMZ13knNvwhnfE/cqQJmFSKLPjfdc0?=
 =?us-ascii?q?TA2nMdmG+jfa8sQLzFoaXzoZxxJJ0dSEp47lc+2iXTlNT5VslSYoeww+We78eD?=
 =?us-ascii?q?b+NABK/KMIprTG5oTxR3e+wr7E63CKklyHLSiJfCtqxpAXtPyoB4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9DtrWKy+BZchizrlhJJ0KrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123028078"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Mar 2022 17:54:42 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 46A204D169FF;
        Mon, 28 Mar 2022 17:54:38 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 28 Mar 2022 17:54:36 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 28 Mar 2022 17:54:39 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leonro@nvidia.com>, <jgg@nvidia.com>, <rpearsonhpe@gmail.com>,
        <yanjun.zhu@linux.dev>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Generate a completion on error after getting a wqe
Date:   Mon, 28 Mar 2022 17:54:36 +0800
Message-ID: <20220328095436.304063-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 46A204D169FF.A93FE
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

Current rxe_requester() doesn't generate a completion on error after
getting a wqe. Fix the issue by calling "goto err;" instead.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..6f8dd2b3b817 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -648,26 +648,26 @@ int rxe_requester(void *arg)
 		psn_compare(qp->req.psn, (qp->comp.psn +
 				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
-		goto exit;
+		goto err;
 	}
 
 	/* Limit the number of inflight SKBs per QP */
 	if (unlikely(atomic_read(&qp->skb_out) >
 		     RXE_INFLIGHT_SKBS_PER_QP_HIGH)) {
 		qp->need_req_skb = 1;
-		goto exit;
+		goto err;
 	}
 
 	opcode = next_opcode(qp, wqe, wqe->wr.opcode);
 	if (unlikely(opcode < 0)) {
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto exit;
+		goto err;
 	}
 
 	mask = rxe_opcode[opcode].mask;
 	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
 		if (check_init_depth(qp, wqe))
-			goto exit;
+			goto err;
 	}
 
 	mtu = get_mtu(qp);
-- 
2.23.0



