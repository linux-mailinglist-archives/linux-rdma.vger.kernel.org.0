Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1BD7D8E3C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJ0FmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 01:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0FmS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 01:42:18 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810171A7;
        Thu, 26 Oct 2023 22:42:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="117100430"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; 
   d="scan'208";a="117100430"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:42:10 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E15D1D5026;
        Fri, 27 Oct 2023 14:42:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 290E9DA222;
        Fri, 27 Oct 2023 14:42:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B236370B0B;
        Fri, 27 Oct 2023 14:42:07 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 2475A1A0073;
        Fri, 27 Oct 2023 13:42:07 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC 2/2] RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
Date:   Fri, 27 Oct 2023 13:41:54 +0800
Message-ID: <20231027054154.2935054-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027054154.2935054-1-lizhijian@fujitsu.com>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.005
X-TMASE-Result: 10--5.753700-10.000000
X-TMASE-MatchedRID: S8AxUE03d7BTorztX3wKRAmyVrMCuJ9SwTlc9CcHMZerwqxtE531VCzy
        bVqWyY2ND+LZhHM9RwrRpRbL7Yjxh7QIlEvYJcRNfa4B0jQGGeoogaQhRNNEvpsoi2XrUn/J8m+
        hzBStanvIM9mETCO70yAHAopEd76vN6erXqkXaWNUTRnbdqHqdCXwULxDsmJEWzsYPewyFk5QGf
        k+LPMB6g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RXE_PAGE_SIZE_CAP means the MR page size supported by RXE. However
in current RXE implementation, only PAGE_SIZE MR works well.
So change it to PAGE_SIZE only.

ULPs such as SRP calculating the page size according to this attribute get
worked again with this change.

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

