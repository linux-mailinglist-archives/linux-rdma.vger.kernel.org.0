Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CD56739F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiGEP5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiGEP5R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 11:57:17 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B79A4D6D
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 08:57:14 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AS64gFq3qjkhWMHU4SPbD5TNzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0W9z1DwPzGtODWHXMvnfZWqmL9B1PI+wpB8DusfXnNI2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2YltZ+2JNPpLS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/IcqOOffijXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irlfO00qO5ELE03uwsKcDqOMUUvXQI5TXUCvAOQp3ZRajOo9hC0?=
 =?us-ascii?q?18YgsFIAOabfcYcYBJxYxnaJR5CIFEaDNQ5hujArnvwfBVKqV+NqOw86gDuIKZ?=
 =?us-ascii?q?ZuFT2GIONPIXUGoMOxQDFzl8qNl/RWnkyXOFzAxLfmp50utLyoA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AAXH8TaiDEJi+r8XyLaAf6vZooHBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127284078"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jul 2022 23:57:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 082414D1716E;
        Tue,  5 Jul 2022 23:57:09 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 5 Jul 2022 23:57:09 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 5 Jul 2022 23:57:10 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>, <rpearsonhpe@gmail.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Use correct ATOMIC Acknowledge opcode in BTH
Date:   Tue, 5 Jul 2022 23:57:05 +0800
Message-ID: <20220705155705.21094-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 082414D1716E.A4915
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

When responder processed an Atomic requeset and got a NAK,
the opcode field in BTH should be ATOMIC Acknowledge instead
of Acknowledge.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 265e46fe050f..592d73c37d48 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1080,10 +1080,10 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 	if (qp_type(qp) != IB_QPT_RC)
 		return RESPST_CLEANUP;
 
-	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
+	if (pkt->mask & RXE_ATOMIC_MASK)
+		send_atomic_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
+	else if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, qp->resp.aeth_syndrome, pkt->psn);
-	else if (pkt->mask & RXE_ATOMIC_MASK)
-		send_atomic_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 	else if (bth_ack(pkt))
 		send_ack(qp, AETH_ACK_UNLIMITED, pkt->psn);
 
-- 
2.34.1



