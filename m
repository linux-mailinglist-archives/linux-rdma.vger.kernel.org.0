Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DCD4D9886
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbiCOKOc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347018AbiCOKO2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:28 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF3813D02;
        Tue, 15 Mar 2022 03:13:12 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AQtD3JKA8uUhRZRVW/ybiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAgbqgj8kgzEDyGVKWmjVP/uJMGP0c94kOtmy9RwPvsKAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnskY/EWoeabSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkzDjfAukrR4jORari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72a8MfLzgpcxXEZxxGP0w/CZQikePujX76GxVEr1ecvrhx7HLUyQV?=
 =?us-ascii?q?9wrvsGNvTZtGOA85Smy6wom/B+Uz6DwscOdjZziCKmlqlhubVmiX/cIQMFbG5/?=
 =?us-ascii?q?7hhh1j77mkZDBodVXO9v/i1i0f4UNVaQ2QI/S8GsaE27EG6CNL6WnWQpH+Cow5?=
 =?us-ascii?q?ZWNdKFeA+wB+Cx7CS4AuDAGUACDlbZ7QOsM4wWCxvzFOMlvv3CjF19r6YU3SQ8?=
 =?us-ascii?q?vGTtzzaESoaIkcQZCIcQE0O6rHeTCsb5v7UZo87Vvfr0ZuuQnetqw1mZRMW390?=
 =?us-ascii?q?75fPnHY3nlbwfvw+Rmw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ArdKukq+Udw6NvRCJiUZuk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+sjztCWE8Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648114"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:09 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 934874D16FD8;
        Tue, 15 Mar 2022 18:13:05 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:05 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:13:03 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 6/7] RDMA/rxe: Enable RDMA FLUSH capability for rxe device
Date:   Tue, 15 Mar 2022 18:18:44 +0800
Message-ID: <20220315101845.4166983-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 934874D16FD8.AF0DA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now we are ready to enable RDMA FLUSH capability for RXE.
It can support Global Visibility and Persistence placement types.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: adjust patch's order. move it here from [04/10]
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



