Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883A651C2D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Dec 2022 09:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiLTIJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Dec 2022 03:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTIJS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Dec 2022 03:09:18 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75489263F
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 00:09:17 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="88948260"
X-IronPort-AV: E=Sophos;i="5.96,258,1665414000"; 
   d="scan'208";a="88948260"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Dec 2022 17:09:14 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BEA0BD647A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 17:09:13 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id EA824D9480
        for <linux-rdma@vger.kernel.org>; Tue, 20 Dec 2022 17:09:12 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id AD2A82020A64;
        Tue, 20 Dec 2022 17:09:12 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     rpearsonhpe@gmail.com, Rao.Shoaib@oracle.com,
        lizhijian@fujitsu.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH v3 1/2] RDMA/rxe: Fix inaccurate constants in rxe_type_info
Date:   Tue, 20 Dec 2022 17:08:47 +0900
Message-Id: <20221220080848.253785-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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

ibv_query_device() has reported incorrect device attributes, which are
actually not used by the device. Make the constants correspond with the
attributes shown to users.

Fixes: 3ccffe8abf2f ("RDMA/rxe: Move max_elem into rxe_type_info")
Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
v2->v3
  Added Reviewed-by tag from Li Zhijian.

 drivers/infiniband/sw/rxe/rxe_pool.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f50620f5a0a1..1151c0b5ccea 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -23,16 +23,16 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
 		.min_index	= 1,
-		.max_index	= UINT_MAX,
-		.max_elem	= UINT_MAX,
+		.max_index	= RXE_MAX_UCONTEXT,
+		.max_elem	= RXE_MAX_UCONTEXT,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
 		.min_index	= 1,
-		.max_index	= UINT_MAX,
-		.max_elem	= UINT_MAX,
+		.max_index	= RXE_MAX_PD,
+		.max_elem	= RXE_MAX_PD,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "ah",
@@ -40,7 +40,7 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_ah, elem),
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
-		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
+		.max_elem	= RXE_MAX_AH,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "srq",
@@ -49,7 +49,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_srq_cleanup,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
-		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
+		.max_elem	= RXE_MAX_SRQ,
 	},
 	[RXE_TYPE_QP] = {
 		.name		= "qp",
@@ -58,7 +58,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_qp_cleanup,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
-		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
+		.max_elem	= RXE_MAX_QP,
 	},
 	[RXE_TYPE_CQ] = {
 		.name		= "cq",
@@ -66,8 +66,8 @@ static const struct rxe_type_info {
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
 		.min_index	= 1,
-		.max_index	= UINT_MAX,
-		.max_elem	= UINT_MAX,
+		.max_index	= RXE_MAX_CQ,
+		.max_elem	= RXE_MAX_CQ,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "mr",
@@ -76,7 +76,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_mr_cleanup,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
-		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
+		.max_elem	= RXE_MAX_MR,
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "mw",
@@ -85,7 +85,7 @@ static const struct rxe_type_info {
 		.cleanup	= rxe_mw_cleanup,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
-		.max_elem	= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX + 1,
+		.max_elem	= RXE_MAX_MW,
 	},
 };
 
-- 
2.31.1

