Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A462B4FD
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiKPIUq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiKPIUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:30 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D16DEE;
        Wed, 16 Nov 2022 00:20:25 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="96201646"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="96201646"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:23 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 04CC77C06D;
        Wed, 16 Nov 2022 17:20:23 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D646BF4BE;
        Wed, 16 Nov 2022 17:20:22 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A1C72340D44;
        Wed, 16 Nov 2022 17:20:21 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 06/10] RDMA/rxe: Implement RC RDMA FLUSH service in requester side
Date:   Wed, 16 Nov 2022 16:19:47 +0800
Message-Id: <20221116081951.32750-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--10.252600-10.000000
X-TMASE-MatchedRID: HCSAtt429UxlJTodqNqEzqoXHZz/dXlxTfK5j0EZbyuOGDxcvp6O0NRO
        61VnsdOoe+eZU8eiw0YoSJ1XMXiioS/7QU2czuUNA9lly13c/gH5UnqVnIHSz3d17Y6gGqDC6e5
        QS/V7c1m06G7pnRwyhvAdrFuuWv7hGAdnzrnkM48URSScn+QSXhhJCIHRlO51+gtHj7OwNO2+Ij
        sEEOIzYjL84OLhkMCxZ0euVv0fkqCRvdpWl/qzTr+bH/d4eRAT
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement FLUSH request operation in the requester.

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: Remove flush union for legecy API, add WR_FLUSH_MASK
V3: Fix sparse: incorrect type in assignment; Reported-by: kernel test robot <lkp@intel.com>
V2: extend flush to include length field.
---
 drivers/infiniband/sw/rxe/rxe_req.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 41f1d84f0acb..b4e098298f25 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -241,6 +241,9 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
 				IB_OPCODE_RC_SEND_FIRST;
 
+	case IB_WR_FLUSH:
+		return IB_OPCODE_RC_FLUSH;
+
 	case IB_WR_RDMA_READ:
 		return IB_OPCODE_RC_RDMA_READ_REQUEST;
 
@@ -421,11 +424,18 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init optional headers */
 	if (pkt->mask & RXE_RETH_MASK) {
-		reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
+		if (pkt->mask & RXE_FETH_MASK)
+			reth_set_rkey(pkt, ibwr->wr.flush.rkey);
+		else
+			reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
+	/* Fill Flush Extension Transport Header */
+	if (pkt->mask & RXE_FETH_MASK)
+		feth_init(pkt, ibwr->wr.flush.type, ibwr->wr.flush.level);
+
 	if (pkt->mask & RXE_IMMDT_MASK)
 		immdt_set_imm(pkt, ibwr->ex.imm_data);
 
@@ -484,6 +494,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 
 			memset(pad, 0, bth_pad(pkt));
 		}
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		/* oA19-2: shall have no payload. */
+		wqe->dma.resid = 0;
 	}
 
 	return 0;
-- 
2.31.1

