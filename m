Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9B60F121
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJ0H3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiJ0H3R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 03:29:17 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91242AA341
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666855755; i=@fujitsu.com;
        bh=7UUBHIBMYcbmlh03eyGT1q24ItYtePstiBZfEM/uUeo=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=gFlleUFOwVZEF5JpiVzFbNfaSskEOpoXImweqx9KxQrK2EVM6OpQARAZjFrBliq2f
         AHezlrxTMJkpe9xJT+VUqJLztRt86VD+ClzLSE/D7jaMM7DHiZCNd1a2OYI+t43888
         DQIxklqPpYmeTWb8St54YThMYRrnmW1B9NTdkOUA/bhWvObqgHcuygWcLzaTnYgmEv
         yg80nJXGTB19IpISj0MjP/SnO7yvc4ThAAhjUz1dGFXmXYOS7K0cisuGXYH5OHe9/w
         1ygIWZbvppQ+LX92zAx9sqVENOM9XdFt2awEqSfC8DdLG2k/NN8eV4bPI7jmHRlHDw
         Plq4k6bB6CjOQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRWlGSWpSXmKPExsViZ8ORqOtlHJV
  ssPOVosXMGScYLab8Wsps8exQL4sDs8emVZ1sHp83yXls/XybJYA5ijUzLym/IoE14/CcrYwF
  B0UrfixrY2tg/CXYxcjFISSwhVHi2qI3jBDOciaJDd8+sXQxcgI5+xklbj0QBrHZBNQkdk5/C
  RYXEVCQ+HdyLzOIzSzgLjH9znpWEFtYwFti4pF1YDUsAqoSvbfb2EFsXgEniYfTO8FsCaDeKQ
  /fM0PEBSVOznzCAjFHQuLgixfMEDWKEm1L/kHVV0jMmtXGBGGrSVw9t4l5AiP/LCTts5C0L2B
  kWsVoVpxaVJZapGtkoJdUlJmeUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOi
  l5dasokRGLIpxYxTdjD2LPujd4hRkoNJSZQ3kSkqWYgvKT+lMiOxOCO+qDQntfgQowwHh5IE7
  x4DoJxgUWp6akVaZg4wfmDSEhw8SiK8+spAad7igsTc4sx0iNQpRkUpcd5YQ6CEAEgiozQPrg
  0Ws5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNWg0zhycwrgZv+CmgxE9DiNXPDQBaXJCK
  kpBqYfAPrOO5efz3ryMYLE9Z/U99qlz4/su1arsj0ibaT5PsXltv4hcXOPmE0f6ethPPE0h9z
  T7NuTk/PVOR86BDaxjnn5p6cpDDPJ5wrTxzmv2QV8kuyaNnLFWriyUsO+tj9vq1ceXXtzlet7
  KL7J73on/tEcz2rv4X+zCZ5zuviASfna+6X9Eh99V7l7Mc3WzwKGmL2/rtUtY1HeUdlcWFncV
  be+2fNbw9vzTxaENbJeOp4qo5ybdeG7kfZPIdndH68F8/+YIl2Z8Lsg79tRH/MiUx2+LljgeP
  VD7/T1FbLOcw8tSyew2fGb9FD7hc5Orf+2WRU8VRFr6gsYOVC5tshR+zDv7QcPrFi39alz5nF
  NimxFGckGmoxFxUnAgA/0peFVAMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-21.tower-587.messagelabs.com!1666855754!499093!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13674 invoked from network); 27 Oct 2022 07:29:14 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-21.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2022 07:29:14 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 2DE59100187;
        Thu, 27 Oct 2022 08:29:14 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 21F09100043;
        Thu, 27 Oct 2022 08:29:14 +0100 (BST)
Received: from 24cc950b386d.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 27 Oct 2022 08:29:11 +0100
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH RESEND] RDMA/rxe: Remove the member 'type' of struct rxe_mr
Date:   Thu, 27 Oct 2022 07:29:04 +0000
Message-ID: <1666855744-105-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The member 'type' is included in both struct rxe_mr and struct ib_mr
so remove the duplicate one of struct rxe_mr.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 502e9ada99b3..d4f10c2d1aa7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -26,7 +26,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
 
 
-	switch (mr->type) {
+	switch (mr->ibmr.type) {
 	case IB_MR_TYPE_DMA:
 		return 0;
 
@@ -39,7 +39,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	default:
 		pr_warn("%s: mr type (%d) not supported\n",
-			__func__, mr->type);
+			__func__, mr->ibmr.type);
 		return -EFAULT;
 	}
 }
@@ -109,7 +109,7 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
 
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = IB_MR_TYPE_DMA;
+	mr->ibmr.type = IB_MR_TYPE_DMA;
 }
 
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
@@ -178,7 +178,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	mr->access = access;
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = IB_MR_TYPE_USER;
+	mr->ibmr.type = IB_MR_TYPE_USER;
 
 	return 0;
 
@@ -205,7 +205,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
-	mr->type = IB_MR_TYPE_MEM_REG;
+	mr->ibmr.type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
 
@@ -304,7 +304,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
-	if (mr->type == IB_MR_TYPE_DMA) {
+	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
@@ -547,8 +547,8 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
 		goto err_drop_ref;
 	}
 
-	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+	if (unlikely(mr->ibmr.type != IB_MR_TYPE_MEM_REG)) {
+		pr_warn("%s: mr type (%d) is wrong\n", __func__, mr->ibmr.type);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 5f5cbfcb3569..22a299b0a9f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -304,7 +304,6 @@ struct rxe_mr {
 	u32			lkey;
 	u32			rkey;
 	enum rxe_mr_state	state;
-	enum ib_mr_type		type;
 	u32			offset;
 	int			access;
 
-- 
2.34.1

