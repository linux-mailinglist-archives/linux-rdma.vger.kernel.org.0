Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4DE5EBA24
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiI0FyO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiI0FyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:09 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853F97514;
        Mon, 26 Sep 2022 22:54:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="90729127"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="90729127"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:06 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F68BD624F;
        Tue, 27 Sep 2022 14:54:05 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E5D41CFBAB;
        Tue, 27 Sep 2022 14:54:04 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id BE25411416F0;
        Tue, 27 Sep 2022 14:54:03 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 07/11] RDMA/rxe: Implement RC RDMA FLUSH service in requester side
Date:   Tue, 27 Sep 2022 13:53:33 +0800
Message-Id: <20220927055337.22630-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--10.252600-10.000000
X-TMASE-MatchedRID: HCSAtt429UxlJTodqNqEzqoXHZz/dXlxTfK5j0EZbyuOGDxcvp6O0NRO
        61VnsdOoe+eZU8eiw0YoSJ1XMXiioS/7QU2czuUNA9lly13c/gH5UnqVnIHSz3d17Y6gGqDC6e5
        QS/V7c1m06G7pnRwyhvAdrFuuWv7hGAdnzrnkM48URSScn+QSXhhJCIHRlO51+gtHj7OwNO38o7
        Ys1NK4Y7AUkesqPgu4dP+I5zc2ru56+ogKT/gI0KCBz8wyafCL
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement FLUSH request operation in the requester.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: Remove flush union for legecy API, add WR_FLUSH_MASK
V3: Fix sparse: incorrect type in assignment; Reported-by: kernel test robot <lkp@intel.com>
V2: extend flush to include length field.
---
 drivers/infiniband/sw/rxe/rxe_req.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..5996b0e3177a 100644
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

