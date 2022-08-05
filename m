Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4135958A765
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbiHEHsv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiHEHsu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:48:50 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B5DA1;
        Fri,  5 Aug 2022 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685725; i=@fujitsu.com;
        bh=TCpF577v1pVIMuLfmc3qaPkxMJJHrE4qQTpf21EjPRs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Kq+MI8lgyKFPPGXn9mT3JdAKG++MYaO65q2bvAkKz296ydqcXXtRSWC0VfMoG/F88
         wi+VrPUxhvvS7YFP4qLVM3w91RCxlDxJ17hvXJ99KC5OW5am4uTOwukZXOlYA7lvE7
         uD1wTYK5TwW8dGtALyOwewcSDYZE2Ua/SdwaUub/ppy8zto1Wr0uH+JHz1hq4S5W87
         cSkZByf+OfCsvjNthFx2QnFp0YbUnCm0tFzgoKiWkNFeOsWuD2h2PZIYnTy2FtsTrb
         3wOJ3LXFHAyGkpfsTka0uwNrqp9Q7hGziUTsw5Hpbcx4IyxrrYIaDryma0VqfcwCVe
         fOGSnuZr+oplg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRWlGSWpSXmKPExsViZ8ORpBt7+k2
  SwYdtAhbTp15gtJg54wSjxZRfS5ktLu+aw2bx7FAvi8WHqUeYLb5MncZscerXKSaLv5f+sVmc
  P9bP7sDlsXPWXXaPxXteMnlsWtXJ5tHb/I7N4/KTK4wenzfJeWz9fJslgD2KNTMvKb8igTXjz
  r317AXfBCp+93YwNjCe5eti5OIQEtjIKHHi721mCGcxk0TPxnVsEM5+Rok3e5+xdzFycrAJaE
  jca7nJCJIQEehklHjUfwysillgNZNEX89rFpAqYQEbidWrFoF1sAioSHT/ucwGYvMKOEp8ub2
  HEcSWEFCQmPLwPTOIzSngJLHp2yqwuBBQzdGWhSwQ9YISJ2c+AbOZBSQkDr54AVTPAdSrJDGz
  Ox5iTIXErFltTBC2msTVc5uYJzAKzkLSPQtJ9wJGplWMtklFmekZJbmJmTm6hgYGuoaGpkDaW
  NfI0EwvsUo3US+1VDcvv6gkQ9dQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMMZSitNv7GDcte+X3i
  FGSQ4mJVHec8ffJAnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4A06AZQTLEpNT61Iy8wBxjtMWoK
  DR0mE9/RJoDRvcUFibnFmOkTqFKMux9TZ//YzC7Hk5eelSonzlpwCKhIAKcoozYMbAUs9lxhl
  pYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ81qBTOHJzCuB2/QK6AgmoCO4/r8GOaIkESEl1cBkm
  6lgkPW3+nDlPNZ//6wcT0zpcfhlcN3lefF2ZQc+WW3r47u9eZfmbJK4unGhw8+vfXrdJcLtm+
  /91LyX8On3i3t/PC+cNtjPuF929c1LeemxT+T2fS9skGF5fH9RhIzg/rnctrdMzSJfTPKw9Nr
  bd2PlTGcj5quC/E8vvP5ty3ig8f+ytsRPISeW8vjP/hjIe3xqvHzSRas7ov+nSZXIzq1b1uYt
  vcv10HQFBxarnmrrD0uf7zrMWe3p4NfyuHZz454HQWYVZnPmai388aS2dt7E5/OW3b25YM0Dt
  9xN5y9GftRxXbAkemVc/93AlSfuh1V8EetfN5012CL07dYMdVFj/Xe8URziH6ZE9XnbKbEUZy
  QaajEXFScCAOCA7AS4AwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-3.tower-732.messagelabs.com!1659685724!304718!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10325 invoked from network); 5 Aug 2022 07:48:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:48:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 95FF81AC;
        Fri,  5 Aug 2022 08:48:44 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 8A8237C;
        Fri,  5 Aug 2022 08:48:44 +0100 (BST)
Received: from 4527b00272f8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:48:39 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 5/6] RDMA/rxe: Implement flush completion
Date:   Fri, 5 Aug 2022 07:55:32 +0000
Message-ID: <1659686133-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
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

Introduce a new IB_UVERBS_WC_FLUSH code to tell userspace a FLUSH
completion.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 +++-
 include/rdma/ib_verbs.h              | 1 +
 include/uapi/rdma/ib_user_verbs.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index fb0c008af78c..137ef9945da5 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_RDMA_FLUSH:			return IB_WC_RDMA_FLUSH;
 
 	default:
 		return 0xff;
@@ -263,7 +264,8 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		 */
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
 		if (wqe->wr.opcode != IB_WR_RDMA_READ &&
-		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV) {
+		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV &&
+		    wqe->wr.opcode != IB_WR_RDMA_FLUSH) {
 			wqe->status = IB_WC_FATAL_ERR;
 			return COMPST_ERROR;
 		}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 16db9eb3467a..832ea8113221 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -980,6 +980,7 @@ const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
 enum ib_wc_opcode {
 	IB_WC_SEND = IB_UVERBS_WC_SEND,
 	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
+	IB_WC_RDMA_FLUSH = IB_UVERBS_WC_FLUSH,
 	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
 	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
 	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 4efa3d76d71d..d426609ad453 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -476,6 +476,7 @@ enum ib_uverbs_wc_opcode {
 	IB_UVERBS_WC_BIND_MW = 5,
 	IB_UVERBS_WC_LOCAL_INV = 6,
 	IB_UVERBS_WC_TSO = 7,
+	IB_UVERBS_WC_FLUSH = 8,
 };
 
 struct ib_uverbs_wc {
-- 
2.31.1

