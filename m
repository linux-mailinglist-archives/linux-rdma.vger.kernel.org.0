Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8D5EBA22
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiI0FyO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiI0FyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:10 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266ED97533;
        Mon, 26 Sep 2022 22:54:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="68849860"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="68849860"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:03 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5B455D6252;
        Tue, 27 Sep 2022 14:54:03 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F829142C2;
        Tue, 27 Sep 2022 14:54:02 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 21B3A11403D7;
        Tue, 27 Sep 2022 14:54:01 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 04/11] RDMA/rxe: Extend rxe user ABI to support flush
Date:   Tue, 27 Sep 2022 13:53:30 +0800
Message-Id: <20220927055337.22630-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220927055337.22630-1-lizhijian@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--3.211900-10.000000
X-TMASE-MatchedRID: e0bKGi4Iljo3i8FXueJ7nioiRKlBVkYI4Tk+Ydnj9RtFms6YEs23D8s0
        A8Och09BxTsa1zsKwGAzoUNAtFjsci/7QU2czuUNA9lly13c/gGrHFhHKqXuS+0NA4pWf9v6o8W
        MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbvqwGfCk7KUs8Cx+5zdsNXieV+GVTO9r576L9
        Rdzx8Ia3BpfZuY721qzZC7kciz4mL6AFbccivBztjvnSWxNHzqwdIQhbYFrscbOi487b5zISHJp
        2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This commit extends the rxe user ABI to support the flush
operation defined in IBA A19.4.1. These changes are
backwards compatible with the existing rxe user ABI.

The user API request a flush by filling this structure.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: new patch split scheme, suggested by Bob
---
 include/uapi/rdma/rdma_user_rxe.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 73f679dfd2df..e2b93df94590 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -82,6 +82,13 @@ struct rxe_send_wr {
 		__u32		invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 remote_addr;
+			__u32	length;
+			__u32	rkey;
+			__u8	type;
+			__u8	level;
+		} flush;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
-- 
2.31.1

