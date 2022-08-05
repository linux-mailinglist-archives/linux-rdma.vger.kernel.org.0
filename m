Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C339258A743
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiHEHkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiHEHkG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:40:06 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEB74DE8;
        Fri,  5 Aug 2022 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685193; i=@fujitsu.com;
        bh=zWQzyxasTlVBGOYCkg6w45iiHbCTBaThAhUnvGcr8Tg=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=tH8ghDi6ZgsHuKN0FmGDlHsl5985rA4NaMApqAtP3VHptTh6nE7zw3NPiFBTI5qCX
         +v/c/41riHwClx0p6thkb/BYykYAAppKpteu9XGrHnjTStzj6xw0BuSFFlUqoEX0Gw
         a8+rizHVq8yXWxByI0V0n7F3YsNAetQWEk/xcYrfgZa1QjVC1k9Mb0pT0gBloxxY4p
         1fJxeGaTkQr6+ixUbiLwWDNYtjQDxRX7Y2vABSt42h0n8QN7md8HetrmgmSryoTVew
         Fd4Hz8P3reObrni8Mp09zsiFCas4X/IekfqtmglVS/kaDn0OMT8LAuPzvoSMrCs/Dc
         SpWI33fjrmafQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsViZ8ORqOtx8k2
  SweaL5hZzv8tZTJ96gdFi5owTjBZTfi1ltri8aw6bxbNDvSwWH6YeYbb4MnUas8WpX6eYLP5e
  +sdmcf5YP7sDt8fOWXfZPRbvecnksWlVJ5tHb/M7No/LT64wenzeJOex9fNtlgD2KNbMvKT8i
  gTWjPbNc9gK3slXLH1xjr2B8bR0FyMXh5DAFkaJj+faWCCc5UwS8yf9YYRw9jNKzHlxESjDyc
  EmoCFxr+UmWEJEoJNR4lH/MTYQh1ngPJPEtE3/2EGqhAW8JO4+vMAKYrMIqEg8+LGUCcTmFXC
  UmPW5AaxGQkBBYsrD98wgNqeAk8Smb6sYQWwhoJqjLQtZIOoFJU7OfAJmMwtISBx88QKongOo
  V0liZnc8xJgKiVmz2pggbDWJq+c2MU9gFJyFpHsWku4FjEyrGG2TijLTM0pyEzNzdA0NDHQND
  U2BtJGuoamxXmKVbqJeaqluXn5RSYauoV5iebFeanGxXnFlbnJOil5easkmRmCspRSnzdzBuG
  XfL71DjJIcTEqivOeOv0kS4kvKT6nMSCzOiC8qzUktPsQow8GhJMEbdAIoJ1iUmp5akZaZA4x
  7mLQEB4+SCO86kFbe4oLE3OLMdIjUKUZFKXFeI5CEAEgiozQPrg2Wai4xykoJ8zIyMDAI8RSk
  FuVmlqDKv2IU52BUEua9BzKFJzOvBG76K6DFTECLuf6/BllckoiQkmpgypWryX/2dLvM7gKlO
  yrcBR/dXh+rTN2QXCRYX3Z93sKif62SS2737fzbfuFGZdihs5HbfyhsuCfWkH9S8t1kIWGmaO
  1PLRc3ejb2d3avffBfuujP9h8rPtjsatxxKfLB2Yz5Tuf59DWK+pZt5lU+E7rO28WvcN5je5/
  yjNZzTQ9mZEnt3O+RpndlrYbM4ce7nxjmNzNuOj373Q+BN7eEfjy5PLEgbtGzZV07H+/a+7Y2
  4XP388fG0zbMenD12anSFHfTurtvjEK9KgUmhHRXcB0XjXzpdk/pq0/rNp2lnYtWljIHPdlVY
  rZmZn/S0jcFaULGtx+2RCsbbfR9sL/ra27ndHnOR8r+l4rnLd6R76vEUpyRaKjFXFScCAAomn
  RwsAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-6.tower-728.messagelabs.com!1659685192!59229!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6197 invoked from network); 5 Aug 2022 07:39:52 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-6.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:39:52 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 39FB11001A0;
        Fri,  5 Aug 2022 08:39:52 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2C4B510019D;
        Fri,  5 Aug 2022 08:39:52 +0100 (BST)
Received: from 4084fd6ad2a8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:39:46 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 1/6] RDMA: Allow registering MR with flush access flags
Date:   Fri, 5 Aug 2022 07:46:14 +0000
Message-ID: <1659685579-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It makes device/HCA support new FLUSH attributes/capabilities, and it
also makes memory region support new FLUSH access flags.

Users can use ibv_reg_mr(3) to register flush access flags. Only the
access flags also supported by device's capabilities can be registered
successfully.

Once registered successfully, it means the MR is flushable. Similarly,
A flushable MR should also have one or both of GLOBAL_VISIBILITY and
PERSISTENT attributes/capabilities like device/HCA.

CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: set is_pmem more simply
V2: new scheme check is_pmem # Dan
---
 include/rdma/ib_verbs.h                 | 17 ++++++++++++++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |  2 ++
 include/uapi/rdma/ib_user_verbs.h       |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7c2f76f34f6f..aa174cdcdf5a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -270,6 +270,10 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING =
 		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	/* Placement type attributes */
+	IB_DEVICE_PLT_GLOBAL_VISIBILITY =
+		IB_UVERBS_DEVICE_PLT_GLOBAL_VISIBILITY,
+	IB_DEVICE_PLT_PERSISTENT = IB_UVERBS_DEVICE_PLT_PERSISTENT,
 };
 
 enum ib_kernel_cap_flags {
@@ -1458,10 +1462,14 @@ enum ib_access_flags {
 	IB_ACCESS_ON_DEMAND = IB_UVERBS_ACCESS_ON_DEMAND,
 	IB_ACCESS_HUGETLB = IB_UVERBS_ACCESS_HUGETLB,
 	IB_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_RELAXED_ORDERING,
+	IB_ACCESS_FLUSH_GLOBAL_VISIBILITY = IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBILITY,
+	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
+	IB_ACCESS_FLUSHABLE = IB_ACCESS_FLUSH_GLOBAL_VISIBILITY |
+			      IB_ACCESS_FLUSH_PERSISTENT,
 
 	IB_ACCESS_OPTIONAL = IB_UVERBS_ACCESS_OPTIONAL_RANGE,
 	IB_ACCESS_SUPPORTED =
-		((IB_ACCESS_HUGETLB << 1) - 1) | IB_ACCESS_OPTIONAL,
+		((IB_ACCESS_FLUSH_PERSISTENT << 1) - 1) | IB_ACCESS_OPTIONAL,
 };
 
 /*
@@ -4310,6 +4318,7 @@ int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata);
 static inline int ib_check_mr_access(struct ib_device *ib_dev,
 				     unsigned int flags)
 {
+	u64 device_cap = ib_dev->attrs.device_cap_flags;
 	/*
 	 * Local write permission is required if remote write or
 	 * remote atomic permission is also requested.
@@ -4324,6 +4333,12 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
 	if (flags & IB_ACCESS_ON_DEMAND &&
 	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
 		return -EINVAL;
+
+	if ((flags & IB_ACCESS_FLUSH_GLOBAL_VISIBILITY &&
+	    !(device_cap & IB_DEVICE_PLT_GLOBAL_VISIBILITY)) ||
+	    (flags & IB_ACCESS_FLUSH_PERSISTENT &&
+	    !(device_cap & IB_DEVICE_PLT_PERSISTENT)))
+		return -EINVAL;
 	return 0;
 }
 
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 7dd56210226f..32d44ca328b9 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -57,6 +57,8 @@ enum ib_uverbs_access_flags {
 	IB_UVERBS_ACCESS_ZERO_BASED = 1 << 5,
 	IB_UVERBS_ACCESS_ON_DEMAND = 1 << 6,
 	IB_UVERBS_ACCESS_HUGETLB = 1 << 7,
+	IB_UVERBS_ACCESS_FLUSH_GLOBAL_VISIBILITY = 1 << 8,
+	IB_UVERBS_ACCESS_FLUSH_PERSISTENT = 1 << 9,
 
 	IB_UVERBS_ACCESS_RELAXED_ORDERING = IB_UVERBS_ACCESS_OPTIONAL_FIRST,
 	IB_UVERBS_ACCESS_OPTIONAL_RANGE =
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7dd903d932e5..a58df0ebcb79 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1331,6 +1331,8 @@ enum ib_uverbs_device_cap_flags {
 	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
 	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
 	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
+	IB_UVERBS_DEVICE_PLT_GLOBAL_VISIBILITY = 1ULL << 38,
+	IB_UVERBS_DEVICE_PLT_PERSISTENT = 1ULL << 39,
 };
 
 enum ib_uverbs_raw_packet_caps {
-- 
2.31.1

