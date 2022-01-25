Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601749AEE5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452979AbiAYI4Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:56:16 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36081 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452893AbiAYIvG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:51:06 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AlMS+laNFpauTd1jvrR2qlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQC51mh20D1SmGtJWjjTMvjcYGOkct1xatm08x9TvZ/cm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yElj/zQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkZf0dqeSYfBBTtuTWlSUqaUDE2e1jBVstOosY4utfDmR?=
 =?us-ascii?q?H9PheIzcIBjiRluCk0bDhErE0rssmJcjveogYvxlIyTDQC/k5TJbbTqPFzd9F1?=
 =?us-ascii?q?Sg9h4ZFGvO2T8YQb3xtKgvBZxlOM1IMIJM4gOqswHL4dlVwtFWQrLElpWfJywl?=
 =?us-ascii?q?43KruMfLUfMCHQYNemUPwjmbL+GLRARwAMtGbjz2f/RqEj+/GhyT9XKoUCry09?=
 =?us-ascii?q?/csi1qWrkQWAhkRXluTp+e4hk+3HdlYLiQ85i0rhbQ78FSmX5/2WBjQiHqFuAM?=
 =?us-ascii?q?MHtldCes37CmTxafOpQWUHG4JSnhGctNOnMs3QyE6k0WFmtrBGzNiqvuWRGib+?=
 =?us-ascii?q?7PSqim9UQAXImAqdy4JVQZD6NCLnW2ZpnojVf46SOjs0IKzQmq2nli3QOEFr+1?=
 =?us-ascii?q?7paY2O2+TpDgrWw6Rm6U=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACDEwF67iLoDlwIlBJAPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839375"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:35 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0D84B4D146E6;
        Tue, 25 Jan 2022 16:44:33 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:33 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:30 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH v2 8/9] RDMA/rxe: Enable RDMA FLUSH capability for rxe device
Date:   Tue, 25 Jan 2022 16:50:40 +0800
Message-ID: <20220125085041.49175-9-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
References: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 0D84B4D146E6.ACB2E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A19.4.3.1 HCA RESOURCES
This Annex introduces the following new HCA attributes:
• Ability to support Memory Placement Extensions
a) Ability to support FLUSH
 i) Ability to support FLUSH with PLT Global Visibility
 ii) Ability to support FLUSH with PLT Persistence

Now we are ready to enable RDMA FLUSH capability for RXE.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V2: adjust patch's order. move it here from [04/10]
    update comments, add referring to SPEC
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 918270e34a35..281e1977b147 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -53,7 +53,9 @@ enum rxe_device_param {
 					| IB_DEVICE_ALLOW_USER_UNREG
 					| IB_DEVICE_MEM_WINDOW
 					| IB_DEVICE_MEM_WINDOW_TYPE_2A
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_PLT_GLOBAL_VISIBILITY
+					| IB_DEVICE_PLT_PERSISTENT,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.31.1



