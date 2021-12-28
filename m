Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD5480726
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhL1ICT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235464AbhL1ICS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:18 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AdK9/rKwvNA4xbTLWkDh6t+dpxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDor1mMDmGEZWGiPPqyNYGuhKItzat628UwA6JPQm4RnHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmjPjSHOqkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfqeGafiTn4KR/yGWDKRMA2c5GFlk7NJcD/eB3GWx?=
 =?us-ascii?q?m+vkRKTRLZReG78qk0bCpW+s23px7BMbuNYIb/HpnyFnxCfcvR5/cTqPS6NlX9?=
 =?us-ascii?q?Dctj99DHLDVYM9xQT5ucxnBYxRJNX8XFZshkebujX76GxVcpVWTjak6+W7eyEp?=
 =?us-ascii?q?2yreFGNPVc8aNQ8F9mFiZqmPPuW/+B3kyMdabzjGF2nSyh+POlGXwX4d6PLm58?=
 =?us-ascii?q?ON6xV6e3GoeDDUIWlah5/q0kEizX5RYMUN80i4vq7UisVanS9DVQRK1ujiHswQ?=
 =?us-ascii?q?aVt4WFPc1gCmPxaX88QeUHmVCRTcpVTCMnKfaXhRzjhnQwYyvXmcp7dWopbum3?=
 =?us-ascii?q?u/8hVuP1eI9dDRqifc4cDY4?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AI8ttva4u5M/IRmAdTAPXwCzXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHJoB17726MtN9/YhEdcLy7VJVoBEmskKKdgrNhWotKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIWReOktK1vp0AT0ERMrLN5CBB/KTHCReDYqsd6ejC4Ka1nv3f?=
 =?us-ascii?q?0nsoaQlrbptr5wB/Bh3zKDwMeCB2QYo+CIGH5tdK4x6peXEsZMy9AXUfG8fZod?=
 =?us-ascii?q?mjruOdXTc2Qw4g9BKVjS6lrJrzEx2j1B8YVD9VhZcOmFK16zDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657409"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 06CDB4D15A22;
        Tue, 28 Dec 2021 16:01:48 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:46 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:45 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 02/10] RDMA: Allow registering MR with flush access flags
Date:   Tue, 28 Dec 2021 16:07:09 +0800
Message-ID: <20211228080717.10666-3-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 06CDB4D15A22.AF473
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Users can use ibv_reg_mr(3) to register flush access flags.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 include/rdma/ib_verbs.h                 | 6 +++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 822ebb3425dc..f04d66539879 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1444,10 +1444,14 @@ enum ib_access_flags {
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
 	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_FLUSH_GLOBAL_VISIBILITY = IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBLITY,
+	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
 
+	IB_ACCESS_FLUSH = IB_ACCESS_FLUSH_GLOBAL_VISIBILITY |
+			  IB_ACCESS_FLUSH_PERSISTENT,
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
-		((IB_ACCESS_HUGETLB << 1) - 1) | IB_ACCESS_OPTIONAL,
+		((IB_ACCESS_FLUSH_PERSISTENT << 1) - 1) | IB_ACCESS_OPTIONAL,
 };
 
 /*
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 3072e5d6b692..4763d3e3ea16 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -57,6 +57,8 @@ enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_ZERO_BASED = 1 << 5,
 	IB_UVERBS_ACCESS_ON_DEMAND = 1 << 6,
 	IB_UVERBS_ACCESS_HUGETLB = 1 << 7,
+	IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBLITY = 1 << 8,
+	IB_UVERBS_ACCESS_FLUSH_PERSISTENT = 1 << 9,
 
 	IB_UVERBS_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
 	IB_UVERBS_ACCESS_OPTIONAL_RANGE =
-- 
2.31.1



