Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B87E007B
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347580AbjKCJ4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347605AbjKCJ4P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:56:15 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE40D70;
        Fri,  3 Nov 2023 02:56:02 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="138469456"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="138469456"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:01 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 762B7D3EAC;
        Fri,  3 Nov 2023 18:55:58 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A9C5AC4A16;
        Fri,  3 Nov 2023 18:55:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 348F9E36BA;
        Fri,  3 Nov 2023 18:55:57 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 9ABBE1A006F;
        Fri,  3 Nov 2023 17:55:56 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 2/6] RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
Date:   Fri,  3 Nov 2023 17:55:45 +0800
Message-ID: <20231103095549.490744-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103095549.490744-1-lizhijian@fujitsu.com>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--5.753700-10.000000
X-TMASE-MatchedRID: S8AxUE03d7BTorztX3wKRAmyVrMCuJ9SwTlc9CcHMZerwqxtE531VCzy
        bVqWyY2ND+LZhHM9RwrRpRbL7Yjxh7QIlEvYJcRNfa4B0jQGGeoogaQhRNNEvpsoi2XrUn/J8m+
        hzBStanvIM9mETCO70yAHAopEd76veDyIM8J5kE2z4CsjXTAQJnU5kupDVrVP2Pzvl4G8qgDM1X
        RxVNdnKQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RXE_PAGE_SIZE_CAP means the MR page size supported by RXE. However
in current RXE implementation, only PAGE_SIZE MR works well.
So change it to PAGE_SIZE only.

ULPs such as SRP calculating the page size according to this attribute
get worked again with this change.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index d2f57ead78ad..b1cf1e1c0ce1 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -38,7 +38,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
 /* default/initial rxe device parameter settings */
 enum rxe_device_param {
 	RXE_MAX_MR_SIZE			= -1ull,
-	RXE_PAGE_SIZE_CAP		= 0xfffff000,
+	RXE_PAGE_SIZE_CAP		= PAGE_SIZE,
 	RXE_MAX_QP_WR			= DEFAULT_MAX_VALUE,
 	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
 					| IB_DEVICE_BAD_QKEY_CNTR
-- 
2.41.0

