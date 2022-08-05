Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A3758A744
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiHEHkM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiHEHkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:40:07 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B874E26;
        Fri,  5 Aug 2022 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685198; i=@fujitsu.com;
        bh=q+vZkm8yJ9zFKnWMnygIT/3sauEaYG/Tmtem+Zmc1j0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UtcNs0XZ9FtiYTTdTGnw3IuaLa9bQNail6fhbWBAV4WJboj7trmM3bqJDFx4rV+y2
         tvw5RS815ASqi80pz6/VO4Lo3OmMxqZIszSWwqSLnOBrCN/82DJYFUrOqUlMXQwOkZ
         JduBZrcIkV+XqDH+JjCuxAq55XYZn9q+lFDvRqKChicRE3POpQsFyavouEEdkwyVaH
         R0+YrKo5o0ftl8jrFv+KypVhU+Q0UAclQyNRDC8FG6d5uZeZDAQtW5Km9xMo0m1a6f
         oB2Nib1HKWPWZ5Fvi3OFj5sUEOotIEU2SaGb9AdhLwSnRO40GRkMXGNEuUYiLa2b/z
         nnI2QF7Fhi7mg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRWlGSWpSXmKPExsViZ8OxWdfv5Js
  kg6f97BZzv8tZTJ96gdFi5owTjBZTfi1ltri8aw6bxbNDvSwWH6YeYbb4MnUas8WpX6eYLP5e
  +sdmcf5YP7sDt8fOWXfZPRbvecnksWlVJ5tHb/M7No/LT64wenzeJOex9fNtlgD2KNbMvKT8i
  gTWjA0/5QuOC1Tc//WbsYHxNm8XIxeHkMBGRonTP98wQziLmSSmvnrN2sXICeTsZ5S4ONUExG
  YT0JC413KTEaRIRKCTUeJR/zE2EIdZ4DyTxLRN/9hBqoQFQiQ2PN3PCGKzCKhIfG6aDRbnFXC
  U2LZhPhuILSGgIDHl4XtmEJtTwEli07dVjBDbHCWOtixkgagXlDg58wmYzSwgIXHwxQugeg6g
  XiWJmd3xEGMqJGbNamOCsNUkrp7bxDyBUXAWku5ZSLoXMDKtYrRNKspMzyjJTczM0TU0MNA1N
  DQF0ka6hqbGeolVuol6qaW6eflFJRm6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIFxllKcNnMH45
  Z9v/QOMUpyMCmJ8p47/iZJiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRv0AmgnGBRanpqRVpmDjD
  mYdISHDxKIrzrQFp5iwsSc4sz0yFSpxh1Oc7v3L+XWYglLz8vVUqc1wikSACkKKM0D24ELP1c
  YpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMew9kCk9mXgncpldARzABHcH1/zXIESWJCCmpB
  qYaCYv4El9ZS8mVV6IF7xdPF3+7oWJtsc7y3t471im8Z5fv+v6+reBsc8Iat70vHnkpFrPx1C
  S/uvb65c32Y+lxyyTcrbJu1Las7FI899r/419FpT8xQkqHbvGa/Ayav/ZYv/+M45VfBNp00gX
  c4rY/vXnFf5q+vD5nC2dtPefMps1N+6JnHvt7eM+EVVl8k4+5Cj84nv844FqGa81RlcjMTRkn
  1ZVFtAJ4v62RvdYdyCW5pepA390DRkolVfaiD5i702fOvs7HteTOu6Yb/omqbV2HjtWmbXu9N
  O0AZz/HEd6+RXIeV/133BDfnbV3k3W177vV/p6O2RoCOxt2vl6z7EZF7NH/8Qvn7Epl/aPEUp
  yRaKjFXFScCACmjgKuugMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-2.tower-745.messagelabs.com!1659685197!148381!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10002 invoked from network); 5 Aug 2022 07:39:58 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-2.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:39:58 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 7035E153;
        Fri,  5 Aug 2022 08:39:57 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 627DF75;
        Fri,  5 Aug 2022 08:39:57 +0100 (BST)
Received: from 4084fd6ad2a8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:39:52 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 2/6] RDMA/rxe: Allow registering persistent flag for pmem MR only
Date:   Fri, 5 Aug 2022 07:46:15 +0000
Message-ID: <1659685579-2-3-git-send-email-lizhijian@fujitsu.com>
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

Memory region could at most support 2 access flags:
IB_ACCESS_FLUSH_PERSISTENT and IB_ACCESS_FLUSH_GLOBAL_VISIBILITY

But we only allow user to register persistent flush flags to the pmem MR
that supports the ability of persisting data across power cycles.

So register a persistent access flag to a non-pmem MR will be rejected
by kernel.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
v2: update commit message, get rid of confusing ib_check_flush_access_flags() # Tom
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 9e3e1a18f2dd..24ca014cdecd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -113,6 +113,13 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->type = IB_MR_TYPE_DMA;
 }
 
+static bool vaddr_in_pmem(char *vaddr)
+{
+	return REGION_INTERSECTS ==
+	       region_intersects(virt_to_phys(vaddr), 1, IORESOURCE_MEM,
+				 IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
@@ -123,6 +130,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	int			num_buf;
 	void			*vaddr;
 	int err;
+	bool first = true, is_pmem = false;
 	int i;
 
 	umem = ib_umem_get(pd->ibpd.device, start, length, access);
@@ -167,6 +175,11 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 				goto err_cleanup_map;
 			}
 
+			if (first) {
+				first = false;
+				is_pmem = vaddr_in_pmem(vaddr);
+			}
+
 			buf->addr = (uintptr_t)vaddr;
 			buf->size = PAGE_SIZE;
 			num_buf++;
@@ -175,6 +188,12 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		}
 	}
 
+	if (!is_pmem && access & IB_ACCESS_FLUSH_PERSISTENT) {
+		pr_warn("Cannot register IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
+		err = -EINVAL;
+		goto err_release_umem;
+	}
+
 	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
-- 
2.31.1

