Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4E651C2F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 09:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiLTIJW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 03:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTIJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 03:09:21 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833BE2650
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 00:09:19 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="101649629"
X-IronPort-AV: E=Sophos;i="5.96,258,1665414000"; 
   d="scan'208";a="101649629"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Dec 2022 17:09:17 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 131BAD6282
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 17:09:16 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F226D35E6
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 17:09:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 35398200B2B0;
        Tue, 20 Dec 2022 17:09:15 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     rpearsonhpe@gmail.com, Rao.Shoaib@oracle.com,
        lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v3 2/2] RDMA/rxe: Prevent faulty rkey generation
Date:   Tue, 20 Dec 2022 17:08:48 +0900
Message-Id: <20221220080848.253785-2-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220080848.253785-1-matsuda-daisuke@fujitsu.com>
References: <20221220080848.253785-1-matsuda-daisuke@fujitsu.com>
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

This commit also increases the value of RXE_MAX_MW that has been limited
unlike other parameters.

Fixes: 0994a1bcd5f7 ("RDMA/rxe: Bump up default maximum values used via uverbs")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
v2->v3:
 Added Reviewed-by and Tested-by tags from Li Zhijian
 Changed 'RXE_MIN_MW_INDEX' to 'RXE_MAX_MR_INDEX + 1'

v1->v2:
 Fixed the value of RXE_MAX_MR as suggested by Li.
 Increased the value of RXE_MAX_MW.

 drivers/infiniband/sw/rxe/rxe_param.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index a754fc902e3d..7b41d79e72b2 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -98,11 +98,11 @@ enum rxe_device_param {
 	RXE_MAX_SRQ			= DEFAULT_MAX_VALUE - RXE_MIN_SRQ_INDEX,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE,
-	RXE_MAX_MR			= DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
-	RXE_MIN_MW_INDEX		= 0x00010001,
-	RXE_MAX_MW_INDEX		= 0x00020000,
-	RXE_MAX_MW			= 0x00001000,
+	RXE_MAX_MR_INDEX		= DEFAULT_MAX_VALUE >> 1,
+	RXE_MAX_MR			= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX,
+	RXE_MIN_MW_INDEX		= RXE_MAX_MR_INDEX + 1,
+	RXE_MAX_MW_INDEX		= DEFAULT_MAX_VALUE,
+	RXE_MAX_MW			= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX,
 
 	RXE_MAX_PKT_PER_ACK		= 64,
 
-- 
2.31.1

