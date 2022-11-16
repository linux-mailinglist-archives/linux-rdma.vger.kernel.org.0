Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA062B4FA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiKPIUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKPIUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:30 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FFA64D8;
        Wed, 16 Nov 2022 00:20:26 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="95718119"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="95718119"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:26 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A84F7E8523;
        Wed, 16 Nov 2022 17:20:24 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DF219F687;
        Wed, 16 Nov 2022 17:20:23 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id AF3DF2340D44;
        Wed, 16 Nov 2022 17:20:22 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 08/10] RDMA/rxe: Implement flush completion
Date:   Wed, 16 Nov 2022 16:19:49 +0800
Message-Id: <20221116081951.32750-9-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--2.732800-10.000000
X-TMASE-MatchedRID: pif/TqAgu++ojsVP+osNyI4V8tCoXo/SwTlc9CcHMZerwqxtE531VNnf
        JrUSEbFDd5/rOwjY0ImeLHNUN8SOI5cLewwAa76fzr16YOzjZ119LQinZ4QefCP/VFuTOXUTae6
        hIZpj4MuOhzOa6g8KrYhqyxShGnRGx798Plu9yxIE26s1WQHjCSXbKa0srDJrpBEF2/vs3ZUY9z
        x6kKakIEBcpLkb91UbHI/mIDtwBKhK6rUsKZM+ehXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
        0j7vLVUewMSBDreIdk=
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
index 66f392810c86..12252ac6b5c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_FLUSH:			return IB_WC_FLUSH;
 
 	default:
 		return 0xff;
@@ -274,7 +275,8 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
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

