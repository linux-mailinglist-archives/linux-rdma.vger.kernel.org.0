Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E16443E9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiLFNDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiLFNCW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:22 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15398C76D;
        Tue,  6 Dec 2022 05:02:20 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="98847120"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="98847120"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:20 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8242DC3F84;
        Tue,  6 Dec 2022 22:02:18 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BABD8CFF81;
        Tue,  6 Dec 2022 22:02:17 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 80F7D234090F;
        Tue,  6 Dec 2022 22:02:16 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 08/10] RDMA/rxe: Implement flush completion
Date:   Tue,  6 Dec 2022 21:01:59 +0800
Message-Id: <20221206130201.30986-9-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--1.649800-10.000000
X-TMASE-MatchedRID: 8yo7ot4xteWojsVP+osNyI4V8tCoXo/SwTlc9CcHMZerwqxtE531VNnf
        JrUSEbFD4aYNoJRGTLxC8N9emxXsDYK5uwAQp1EXSHCU59h5KrHQtWdx8wWyB5soi2XrUn/J8m+
        hzBStantdY+ZoWiLImydET58jp62SH/alYRvEEDM0+dgjvPaXm1nLk1UTEsFVcXz+h9kvXn5299
        wSNG4ku6Xtr1NW4OCS/mjdw1s1wcJAdUpMMr0LdXHBIyFC0RNEwGC8e6520fKw0PJt06oJaHpaQ
        l5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Per IBA SPEC, FLUSH will ack in rdma read response with 0 length.

Use IB_WC_FLUSH (aka IB_UVERBS_WC_FLUSH) code to tell userspace a FLUSH
completion.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1c525325e271..20737fec392b 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -105,6 +105,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
 	case IB_WR_ATOMIC_WRITE:		return IB_WC_ATOMIC_WRITE;
+	case IB_WR_FLUSH:			return IB_WC_FLUSH;
 
 	default:
 		return 0xff;
@@ -278,7 +279,8 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
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

