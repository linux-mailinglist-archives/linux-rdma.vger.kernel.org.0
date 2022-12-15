Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D593D64D95F
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 11:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLOKPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 05:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiLOKPM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 05:15:12 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F127935
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 02:15:11 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="100148575"
X-IronPort-AV: E=Sophos;i="5.96,247,1665414000"; 
   d="scan'208";a="100148575"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 15 Dec 2022 19:15:10 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A8F06D6476
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 19:15:08 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E4996D94B6
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 19:15:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3002.s.css.fujitsu.com (Postfix) with ESMTP id A0C02200B315;
        Thu, 15 Dec 2022 19:15:07 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     rpearsonhpe@gmail.com, Rao.Shoaib@oracle.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Prevent faulty rkey generation
Date:   Thu, 15 Dec 2022 19:14:39 +0900
Message-Id: <20221215101439.3644683-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221215101439.3644683-1-matsuda-daisuke@fujitsu.com>
References: <20221215101439.3644683-1-matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If you create MRs more than 0x10000 times after loading the module,
responder starts to reply NAKs for RDMA/Atomic operations because of rkey
violation detected in check_rkey(). The root cause is that rkeys are
incremented each time a new MR is created and the value overflows into the
range reserved for MWs.

Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index a754fc902e3d..a3d31bd45895 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -98,10 +98,10 @@ enum rxe_device_param {
 	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE - RXE_MIN_SRQ_INDEX,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE,
-	RXE_MAX_MR			= DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
-	RXE_MIN_MW_INDEX		= 0x00010001,
-	RXE_MAX_MW_INDEX		= 0x00020000,
+	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE >> 1,
+	RXE_MAX_MR			= 0x00001000,
+	RXE_MIN_MW_INDEX		= (DEFAULT_MAX_VALUE >> 1) + 1,
+	RXE_MAX_MW_INDEX		= DEFAULT_MAX_VALUE,
 	RXE_MAX_MW			= 0x00001000,
 
 	RXE_MAX_PKT_PER_ACK		= 64,
-- 
2.31.1

