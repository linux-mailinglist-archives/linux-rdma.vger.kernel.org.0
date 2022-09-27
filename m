Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2275EBA27
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiI0FyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiI0FyM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:12 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE79875D;
        Mon, 26 Sep 2022 22:54:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="78051765"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="78051765"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:08 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E03FDAFD3;
        Tue, 27 Sep 2022 14:54:07 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 97059CFBA0;
        Tue, 27 Sep 2022 14:54:06 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6184E11416F0;
        Tue, 27 Sep 2022 14:54:05 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 09/11] RDMA/rxe: Implement flush completion
Date:   Tue, 27 Sep 2022 13:53:35 +0800
Message-Id: <20220927055337.22630-10-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--2.732800-10.000000
X-TMASE-MatchedRID: pif/TqAgu++ojsVP+osNyI4V8tCoXo/SwTlc9CcHMZerwqxtE531VNnf
        JrUSEbFDd5/rOwjY0ImeLHNUN8SOI5cLewwAa76fzr16YOzjZ119LQinZ4QefCP/VFuTOXUTae6
        hIZpj4MuOhzOa6g8KrXfKRqKbAgK48rdj9xzzZbvOGSIquzXm+ylvQrIP5c7Z6RcPK5XUP8wsIO
        1Lf7K72dySj4SWdA0m7hd/53vJMo1xp3rD8nnW8BXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
        0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Per IBA SPEC, FLUSH will ack in rdma read response with 0 length.

Use IB_WC_FLUSH (aka IB_UVERBS_WC_FLUSH) code to tell userspace a FLUSH
completion.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index fb0c008af78c..2dea786e20ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_FLUSH:			return IB_WC_FLUSH;
 
 	default:
 		return 0xff;
@@ -263,7 +264,8 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		 */
 	case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
 		if (wqe->wr.opcode != IB_WR_RDMA_READ &&
-		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV) {
+		    wqe->wr.opcode != IB_WR_RDMA_READ_WITH_INV &&
+		    wqe->wr.opcode != IB_WR_FLUSH) {
 			wqe->status = IB_WC_FATAL_ERR;
 			return COMPST_ERROR;
 		}
-- 
2.31.1

