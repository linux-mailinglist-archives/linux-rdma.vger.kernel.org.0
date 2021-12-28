Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090B548072B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhL1ICX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235494AbhL1ICV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Auzrgya4WU07Bpw2qGEIyHwxRtGbGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1zMAyTAXUDiGMvaJNjb1c4h3YYW19xwEvsPTzoRjTVY5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvRH+CmWLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/h1ycdNtJ6xQ?=
 =?us-ascii?q?AEBMLDOmfgGTl9TFCQW0ahuoeaWfyXg7ZXOp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6KCqSPt9hJ57dJHDM4YWu3UmxjbcZd4iQJnFTLrH48dV2?=
 =?us-ascii?q?jgYht1HAvvfIcEebFJHaBXfbhxPM1EYIJIjlfilhz/0dDgwgFaYoqwf4GXJygF?=
 =?us-ascii?q?1lr/3P7L9c9yDX8JTmm6euGPK/m2/CRYfXPSawz6C+XKEgPHOkSLyHokVEdWQ8?=
 =?us-ascii?q?v9snU3WxWEJDhASfUW0rOP/iUOkXd9bbUsO9UIGqak06VzuVNX4VjWmr3Oe+B0?=
 =?us-ascii?q?RQdxdF6s98g7l4qjb7C6LB2UcQ3hKYbQbWGUeLdAx/gbR2Yq3Wno06/vIIU9xP?=
 =?us-ascii?q?4y89VuaURX550dbNUfolTc43uQ=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJ6kF2aOdY4ip78BcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfUzSL3/qynOpoVj6faaslYssR0b9exofZPwJE80lqQFhrX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKgQeQfxEWndQ96U4PScdD4aXLfDpHZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657415"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A464E4D15A24;
        Tue, 28 Dec 2021 16:01:49 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:49 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:47 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 04/10] RDMA/rxe: Enable IB_DEVICE_RDMA_FLUSH for rxe device
Date:   Tue, 28 Dec 2021 16:07:11 +0800
Message-ID: <20211228080717.10666-5-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A464E4D15A24.AF05D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We will enable the RDMA FLUSH on rxe device later.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 918270e34a35..5c140f311aa2 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -53,7 +53,8 @@ enum rxe_device_param {
 					| IB_DEVICE_ALLOW_USER_UNREG
 					| IB_DEVICE_MEM_WINDOW
 					| IB_DEVICE_MEM_WINDOW_TYPE_2A
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_RDMA_FLUSH,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.31.1



