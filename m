Return-Path: <linux-rdma+bounces-3456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F10D7915A02
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B1D1C2210A
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9D1A2576;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RaU8uSGX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21F1A254F;
	Mon, 24 Jun 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269265; cv=fail; b=nfEwdsWUugJ0iOoYBusdZ7ULOUT+rwZSQ1v/R9LBP8ydThscOoagxFNtZ+ofS/Epv3yk/jVYGf/AzcZBOIUy3/vUn6ZlcngCSNTTU/BDld99SAxArkq8pCRceBPPqlFqewLv/oa83AReduTUgTTbfTfWeQyMCFHChW1OgI2oKaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269265; c=relaxed/simple;
	bh=INwHB+8zHtT8++2o5KHq8P3RBx2L3oZmu6Ceo7xBjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbdMbqiWSNEFjhcowYw84jm6GCRR3R9nbCusWQCINMYCdSYfXmat6pSivJdeKGaKpDgjFa87nJ67f4LOMxbkJ+2qzvC3g8b+4CcjE6h7itKcJBwG3/NjBxb5REBiGedFFP8CatKoNBcleRxQAbb8TUxZUngmydEmj/IjV4upXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RaU8uSGX; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ+axd7F04x+a4nylIFBes30JLsvkqU+2Crv0POhZrw36WLb1lUrqcMRW7fPUyuSZeChF90xMMnRqVougJkCODUuMxnlPntotU/BB2mLmsN79EBvpcK9884nLNqvqB3u0RUUM6Lu9FBGBqwlZSiIg51Dd8BGa7xN4xyZf/TsmjTxWK5CnGHbshESqEm9xuDQI/5GC2pV/Oi0nZPEhftXFi+aG4KgGJ4zLwCWZbgPg1tqm/tjROKeA7FZIeztQE5HiUu69eG5cvSV+Bsfys9t5t+ThoMGi/BiisPuO8+7RLyTRAX4I871H1itoVbU9xkQ3Iyn8dTS9MKc/rL9xi5qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EJ40bburIyBhpGzbZEasBszAf0xIC7aH42lNUBqrJE=;
 b=cGkZPsA7K1FIL+EYEffdv8iMC09vRUohBCCqkc72hQFRxsnMZLpMOEpfzL494Qnpqvgutao+IgfdVK4hUR4EMcwvPL0wFvHNpCo+/cmc/hzFtq3RM4e+m0Dpq6AFP1DlT17xNRN+tfDfxBWNdxlmh7aFRC/dABN3+TJ7EnBC4b8Jca/4hA3nQnJx/6v/3DBUKmHHftegGzw3cp7H347PjoFm0USGK9fw9U++6RQMpXkqBti3WDoR6N+lRKYIPkMVD0Labs3GNsxSIYdlfHVzqq/wtuHxcZiQe2fVoGcAVkhV8SHuwf21MQgs1c1iEFYP4dFX8PlinN0n5Ez+d1NBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EJ40bburIyBhpGzbZEasBszAf0xIC7aH42lNUBqrJE=;
 b=RaU8uSGXvrCsUgnUkZtS3P4WmemA7LqxWl9nnYbUj/b8dqWNCnfnNMG/q/DhaMY9QOKn3x2l81cwCO2Q8nQh+Z1iKkSqXjvfq/fTgRV+S9KJkeyRNyPQ2z5fBFplFr44aclNuI/N9fwi8dwKMx8Aycjc/TPYfsGaICAdDe8ctooIsRKH7yNIhIt/KsM6uH6vYnTynxCOC2FO7g+zHdFIE1HsIgBwJUW4kMY75AmDHt+dkyJ5iECZiTAeVtH3jNj4zxSJpOdx22r5QQYkHpFbZKnKiPZ3E33YR+sVe71E1M6HyH7i9mCYkQgQSFGUBqlLX4mP0H0+vAzCnwjKK7hjhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 22:47:40 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v2 4/8] taint: Add TAINT_FWCTL
Date: Mon, 24 Jun 2024 19:47:28 -0300
Message-ID: <4-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:208:236::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5046168f-17e6-461b-0daf-08dc949fa412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|7416011|366013|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/7ELUV5AUv3RRj7b3ObmLKncdoPRkHEihmZgF4cfiZRscJAI95RKJC2HCGl?=
 =?us-ascii?Q?0y7LbU7NorRgqZquQzoVAWVoib6kYdZj1tGxTWwCm5RAMI+a4w/4wJJEKWPB?=
 =?us-ascii?Q?o636vCPxWgonAqNzUJXg9pcmCJI3xOE0S/eoVyvbmrAUeYijbOinlN6Xnst0?=
 =?us-ascii?Q?tPeHVmRDzECnuXZTG15ywcEAQkZc0qkKglf+cCZFYqWkt9UmxD+03mLWoXyc?=
 =?us-ascii?Q?4XjqzVpTtfoiVzhxR25WxYLmS69E4BndsrR7goaciTfNYyRl4BSMrhc4AaWa?=
 =?us-ascii?Q?RMN6c6zzR5Sw6sOyrnR7CYbfVtAlimS11lpKivtMd0sdE2Y4DV44JsT7OYO8?=
 =?us-ascii?Q?gv9tDLeOHMDdpPnrk0oLZIYWGBKDICrsOLuidrvvN2X54J/LapKMNRiCxx++?=
 =?us-ascii?Q?j5njfneRMnjDX35FhurtmW//Iivp5tjw1E7oZzvHQCLg9hkJF6SrpvsQsweV?=
 =?us-ascii?Q?W6L4QAXWS5q5yEAz4WRvSGp7r5+tU6cmkgFZFmakkUIBzE9hdlCydJoMHim+?=
 =?us-ascii?Q?1NUEmPk3XMIcddW3UYW4cWGcDIFW1GA2xlaHZmpwIxFV5FLcqVZse8GaLi/N?=
 =?us-ascii?Q?W1PSH2eud1EjODptY1cSjo3NKKtKJWRSMiFQHK0n/klyx6F8NEvblj+j0RLX?=
 =?us-ascii?Q?FYStlr87aQ0BpKoHGCtGM5IwL6+//CBAIhVZRSZbQv1oQJlne1nUKCo1FLoa?=
 =?us-ascii?Q?HZFUxbUAI1OrYHXwB9qNM9eHsb3+jYnY0tgFR+dY2RiS7OvFNDpFbtbbjBvE?=
 =?us-ascii?Q?49YAWP68oUAdBSp9lhrRxPNQdi4qKENHgbuhqhhv3/eanQqTSbpo51L8a1/Q?=
 =?us-ascii?Q?haVket2Z/hA+56C8Re+7WWH+6DdyawzVSfJD/HcHi+S7mpzIAlK0AhGtE58O?=
 =?us-ascii?Q?VZcyd2wKvmEMQkB+yHTkIpuHr5kr4DLl+M1dNA+MK9A++5vZL6dKKr1Jx/ne?=
 =?us-ascii?Q?VpawK9jcDB75OMYyOCSUhvLv+aOfiX+rsvSso0DoERSuyPPZkOXua/AERJgC?=
 =?us-ascii?Q?Vwabcc1HWHBsLFMVSjV5nwq0tGS9HPhzbobAOD5xQS2nqjNLHPDtxf6Qu931?=
 =?us-ascii?Q?moYmCEUu21g5C8IFqhlBACdrD2FETKF4gwFD0RfqwPXfEpIm+QvfNYk3KyJ3?=
 =?us-ascii?Q?EEHd8PXlOWa16K/DT/H+KaAOKyec6p2J74zM92JtNfbViXACfI4mT8lLpiDY?=
 =?us-ascii?Q?zQK/meg1bZdwqM0ptbO9Jpk4ZfsLuFcoRooQLvPa10+z2/uvdkk4L7+Owxfc?=
 =?us-ascii?Q?RpEmWV9yc5foacNHTJi6Ie3bck2dxJzOAAusnsSZ0abNXtgBWYIIhvEyQXXP?=
 =?us-ascii?Q?ZXAm1QP42nklpLB56Xv/QISbr/Fi0932F/GGkbV/xhZhUDZxsabhS73i+fJo?=
 =?us-ascii?Q?ojCmjbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tk9XbElGYVJXiFFCkNXc4rNDgPyhbegIOVR9/XzoZDUTitoA8+OSrquG7sS?=
 =?us-ascii?Q?BRs4AahpCs7nYh86pfFCQLA1B8UD2VlWKg9oA1bucrsyT1L8CscZMghzdHk6?=
 =?us-ascii?Q?UEMGRwbVf0kSZaMjy/dP8BMkq8gtGsUqgl6F/3lKd8IxlnEA+fe8C/un/Jcd?=
 =?us-ascii?Q?zIO+N2FIp+WLp8VRVObtGmDkA4v7GihMJ8T/6bPMzAloVPq41mZbVJZFVCkm?=
 =?us-ascii?Q?NNn/1KHvQAu/WPbOe/hfBJqPVtRuBl1kOzmmccE/izRNsDLPLKJ0c4PwC0RN?=
 =?us-ascii?Q?VTjYn6TpYbBi3AA80F0ZlxjPagz6TXufJWQrsHmaa623grbsLBfk2A4Riui6?=
 =?us-ascii?Q?YbMMEtvMmV1gwnpvAaW4WMJ8fcrogPLEiFaVeuWiSi2ScHDPwj881GNtQaGX?=
 =?us-ascii?Q?tTzCXENRIYoUJb8ntDvTiY9KPSkPqjjAp7rj0OgfWhxIsqv3MGfyS/FYZzJ2?=
 =?us-ascii?Q?Sa1yHnK/Xwm3MDij5YzHoGfLTHymE7122/wYdad4JWxin21WuQX+XXkzLiMY?=
 =?us-ascii?Q?BNt0aecWrhDYIuoZwtaMjwOIKQahX+HirmgjD1AT/ClrTxzT0svxqh3gWgPC?=
 =?us-ascii?Q?CJ+uIZGcu64GHE9T+2PjZs7dG+FaTMEGWtpU7IbD/ELfSNAYxSIMhblMhAjR?=
 =?us-ascii?Q?8DmZ9fTPeINyUx5Of9GwY9+qEzbjQW7hTs4JEF4dSv5iKgUFHjeIvwSY2mbH?=
 =?us-ascii?Q?LVYbqJ3ftQ5g90I3d6JtZddf34Wq71KCIpmjEqqvBBKJG78U92jZ7WE+MftJ?=
 =?us-ascii?Q?JFzTJPnOYuhYbHg8FJ5EYX/iUF3zF4HH9uihosGQ01gHbbj6o7gflCEtlR63?=
 =?us-ascii?Q?/kNy6OOIy7Lrivkfbt43CNmQBVlnQ4qhiN84aO89laFBPZnMGNsdTl78pSJw?=
 =?us-ascii?Q?ZLGiSTdXZzq8HLr5EkkQK71SWUxfVuxD9Ur60G05757ZhTrrhy1y97uxJMwe?=
 =?us-ascii?Q?bwO5StL9z6CvUB/ehq+g80knhK07C8MY5SBnf4hi80T8fxwUzW0mAcKbEiDu?=
 =?us-ascii?Q?/P+5sLh1Sj56nMr2axrF7vrTBLw7l3XnPbxkPp6uwa89hnm7P1ayFZ8Lp3mT?=
 =?us-ascii?Q?GEXN/VgTyQqK4VblwUP7uYIEzxa+cU/XDcw5Y0pzo/ZKyBtaNmgQVSOBWxK6?=
 =?us-ascii?Q?zmN8v/p9gv2m4wHv67LMU9P1x0IwmI584JTTLGpyYyPxUv48sLUw6sQdjkmx?=
 =?us-ascii?Q?12ApYLEsot/Q473D3qiIpvTtp+qO4w58JsRPV//85L2+l4c1o2eC//V9+Twh?=
 =?us-ascii?Q?V6R/Sxpxg5i8EQ4TFLIeJjN02rYLe1tErx/JgYjykqsayu1OEgyG0c7+LFHA?=
 =?us-ascii?Q?Qp78RF7IoV3PCUnUFcZ3F24m8KLHL5o+N21ERj/wfEi+Lrwjf0yQOBIYaUAY?=
 =?us-ascii?Q?inUz48Js4yO4udcL1sRKi4LpKUvoLGt2yS6plGYMLedHs8hGvR3fd3PIm/8i?=
 =?us-ascii?Q?Qy19zwewx7nM5PuU8p27bcrvEeBzUMIq+e90NWjSCxJ7PNIcSn1aLSplZWpc?=
 =?us-ascii?Q?MqTNvsm8P5B08GCM95Y1F6INZeXetVoZfMu0ngFDG8qbqUvoyMbkMluGRmtH?=
 =?us-ascii?Q?o/ukmhNw/Rcx/SzKE3lSoscp58g+7SsZmiODlM9Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5046168f-17e6-461b-0daf-08dc949fa412
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:35.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoPo291rP/g9YpGQD0F2y3dcUPeCXdpq+RAL/5Y7O0oVnKJD29+WqXn6GURAYnqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Requesting a fwctl scope of access that includes mutating device debug
data will cause the kernel to be tainted. Changing the device operation
through things in the debug scope may cause the device to malfunction in
undefined ways. This should be reflected in the TAINT flags to help any
debuggers understand that something has been done.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/tainted-kernels.rst | 5 +++++
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index f92551539e8a66..f91a54966a9719 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  userspace used a mutating debug operation in fwctl
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -182,3 +183,7 @@ More detailed explanation for tainting
      produce extremely unusual kernel structure layouts (even performance
      pathological ones), which is important to know when debugging. Set at
      build time.
+
+ 18) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
+     to use the devices debugging features. Device debugging features could
+     cause the device to malfunction in undefined ways.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e798c38..5dfd5295effd40 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -73,7 +73,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FWCTL			19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index 8bff183d6180e7..b71f573ec7c5fc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -494,6 +494,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
 	[ TAINT_TEST ]			= { 'N', ' ', true },
+	[ TAINT_FWCTL ]			= { 'J', ' ', true },
 };
 
 /**
-- 
2.45.2


