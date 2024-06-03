Return-Path: <linux-rdma+bounces-2790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17C8D8691
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C291C21912
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704441369A8;
	Mon,  3 Jun 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEgVS2Ue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC9131BAF;
	Mon,  3 Jun 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430019; cv=fail; b=Z+yQZnSJtpm1DDZNxGVD+evaU+0eR4OZ7y0b6TfB1XA8q56H7RfQKYG/BOqQgvAa9aa/rpwdeAGtsoeMSVwPIzKkMqM4tKjfuSQ5mJnwcE4zuATCJwd6Oc2cV6oXSrokyIoQkK3jRUqL8AULGCJRpGsV/ZLjXfDGwomjDBQGCf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430019; c=relaxed/simple;
	bh=INwHB+8zHtT8++2o5KHq8P3RBx2L3oZmu6Ceo7xBjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqkwsW7eznDvrxGw1qXwzd6tsQjIdrbEI3qPrcMLYMiQ+0jJiaydknHvAXLX3bZo/PebtD8uahEU21xcgzozoxkP/yRIsLHJ6bpKkA+rMo+4FYH35sSITJR2SHui+UrtcJIrYhcHY8SWw8/X9C4LSLa3NyakgUkVTRemr+IKkzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEgVS2Ue; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjLrbIYj5cJoxOYDJdE9t/57W55AZTEmepa5qtsYnffy7nthTFVbGYrGpCVQI4yOe3gIcxHwwflECzasgP/5PcIhKqBypX8DbzJQSt7Lh5V684Io0bFztfOZPIp8nQhif0O1tHoIkJpbAs/AiBSgQYvorRTKxWw2MGhE6EF6QNQIy9QhFNMBPrvNgBpE9R/uguWSs+X8coWgkrBMcDB7wSdvFfZZt4ZfnC/AEMUwxmcUowBoOr9MuQLVeymQhFc/MKQt99LZJGWL+ivu5MoG2XZAo8KSl2LUuFBEhSIahLjeQKtcAoOXHL6MQJRt6M5FbWizK79J9/ZxYYW93HtPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EJ40bburIyBhpGzbZEasBszAf0xIC7aH42lNUBqrJE=;
 b=GEMh+DoZPliQW9Sfc6rELGDgT/kare6XBBKjEW4Ckz8WiYPVz52Fg+ZCfT/rcXEjMsvIe8z+9jCrdMnLuc5wCZRu5VgYn4pLgKT3oJu9E9yjCdJqeu2qi3Hj8SU4cusGUnKupWomgcYWw5/dmpQ+Gx9o4Hre2XpL57fSYEbHXn1ZUOFZAjQi7pBlJY31+B60oM2U5HbT3/0Ws1gTqlCyJhwu02iEtEth9UGCc1ioMzJqYS40pBtxq+qdC7WEpx1WiLLUpigIrZA9GqpxlxVyjV36QE3WepkI/VUI9uC0PR27oIA1fdIEqLNBIXZhg7Rvy6F1dnc/MoY94SHw/88V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EJ40bburIyBhpGzbZEasBszAf0xIC7aH42lNUBqrJE=;
 b=OEgVS2UesqcgArnipCUJCqggEKffB7QL6SyBdk0lyx6v5bGbeshajOxJMZBVgVO13Mg64lK99v1oWGo3mFBRK9KmMgpmxmvCndMSFZAQABPFpd3NfSyzMBvg1i6jWe+g5/CuGaXH3VcYkgLPWRFu6Phb2vLYipQQfvuAHvziBJYNqymWrW9oGL7UiyuuJ6CWK4Do5SUUZtJXgZLlnSSWTSH1yqOE2FITZbIOB1mgMAXs720BAMEQs1EcFGdxfD/S8SMolrurzMRuhBCE7Rg6U2d+QgZ5Fm5XOaBBehp8+ZE1hjJAu3YxFS8QiW7L2a0Tnwz0g1pCh7yzLvJc802i4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:29 +0000
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
Subject: [PATCH 4/8] taint: Add TAINT_FWCTL
Date: Mon,  3 Jun 2024 12:53:20 -0300
Message-ID: <4-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: e48047c0-2b96-4ebe-2755-08dc83e54ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WkeBJvTRcPsjKLKZb4KmWOezEFfy6+fiuA6jSzY1mZ2uHF6gBlJ4yQ8RfYm?=
 =?us-ascii?Q?b8gsOFRetPpNSS1xN/xuuw7FuwQIQ86m1NBDhrvtzZyCNasxvZoafZlZjiCU?=
 =?us-ascii?Q?eZLyeAEq6tWktvmwmdw2siiUQ62OdYmvNb5Be9oqelsejU/Zsixv7ZGLXlzo?=
 =?us-ascii?Q?DD5weoh8xSyWyEVJsMVJCWqNYUxGw5h7yavL+m/+PN1WYMyS/D8qikN1sL0A?=
 =?us-ascii?Q?xGcGC0kCklVvhFKNG6z7LUkMICiA91/U1YdrjB1cJLci8z0varZiaLtEhW8+?=
 =?us-ascii?Q?mlPOkFtZX6T7ZW+dZP9MScIe1OfrG/sMsQUV6+Ny1gKVvUPLwksBpWAK1Fma?=
 =?us-ascii?Q?NEoXXoBE2YjYHVG+zBJNwOV12hyHVJkehcfiHUngHK3TJsxAVlbdYWSpsYdZ?=
 =?us-ascii?Q?b0IaCc9p3P942mgDNdjGdqu51wBjRRMYqyAmZ0DWLmd+Q+JNoSGr05RFIV2e?=
 =?us-ascii?Q?rFvkniZvAT5fOQjosYpM/7XuIlKwnzhvvg4qCpCOs3c/8PTvMu0zpJS/UaBt?=
 =?us-ascii?Q?9BgIjqRDvGAHgDfgKdmpJdpk3GzRSDhRpXc4KfSB5zDxOc98CUP11tOk3/wm?=
 =?us-ascii?Q?HQbfKbOOwWwQh3Ou8FCHWaaSMcz/3DiQ/0nCJ9t0kpKKv88ok8HAZNRuHzz3?=
 =?us-ascii?Q?t0MzbiA+H6U1tnJPqzXoJKHHrZ0oImydxXfKTfxjOWdx+NeASoNezAebTxpI?=
 =?us-ascii?Q?wYrk2kAtW0ArR6PgOIMTTDASWHpOsmi9FX+5Z/3nFfqkPxzZKpUX9LOEZF4q?=
 =?us-ascii?Q?2VlcnDBFj8DaqJBkIdxYXLzXm5Ls/I++7Mbm3LSeFPlqgtGVFaRd7aE6VT1D?=
 =?us-ascii?Q?Kc6Lrc8zjVDUf1yD2TayYyie6yf+1FdSTBQ5bWXgIgMWeGWAik+uhgNZSVkX?=
 =?us-ascii?Q?rR+DWqQAhJMr2d2/OJAqezxUdUYLkY5x0ies7u4dnBBZM2ohFrC4LEqRqV3g?=
 =?us-ascii?Q?27Kz1VUGpvzDPgb663xEiP0tfIbU/oH8Fby3Up7ZBgJc/9znmZbvyMGa68p9?=
 =?us-ascii?Q?KKS/RASMq6SaSFf6wFwflIGJ5VEnFqBhEICtyXCfgdVYGQKv6a5MU6nFWpyQ?=
 =?us-ascii?Q?7bvAxuVPRl9lHRHt5RECgFmwK7ICxgVf3ZAeAG8onvnSmJPBZzDCr6Gpao5h?=
 =?us-ascii?Q?MIZ0rXRc95sH62z0cBIQY70luE8TW1jU+eKlgYU0kOivbd+B/ygk4vbvUEjs?=
 =?us-ascii?Q?fpfP7X23d4o4KIB5Gm2TpEl6fVfMJUUMmTqRL4q3EHCrFqlSymJtm2isGuj1?=
 =?us-ascii?Q?YpltkysMOwEcmrwUUwQuoFQkhe2dXAH7TsSUdg9Bob46nRadb1GeeDMu0CeL?=
 =?us-ascii?Q?QXAClUOPeSmT1Wm6CDnr06h/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UnAKC9FYC7lySKirO5V2kpk5abKZ8NYrxbplDQrbuQMXXwRa4F9v30Mk5sOZ?=
 =?us-ascii?Q?xWTmpcycTAYIgruYAZTMPGe2X39UMot6qYb3kC2pfvTlNKwHHwoiAeuzTwfo?=
 =?us-ascii?Q?4mZxke45P0Ngj+3DP570LyoQzYOID+q8LVUIfBHX+GaTB5M+9XYwxyAwDGQh?=
 =?us-ascii?Q?krnqRJKlCQDCb0BT4MoZ1f5LImZksC6D4HbrPHsOURFfEQ+DBUnMXdF90neZ?=
 =?us-ascii?Q?3iaCAHc68DvHWe9ggHJlJxM+8OUn72Y8UMF/l1ul6N0ij5e/UBzg68sJsLTK?=
 =?us-ascii?Q?tlTuZOUWlunUiTTHikZlrx68MQSwP/VyIqalQePzycZS5uK3D2hWcXnnZJQH?=
 =?us-ascii?Q?bZj016eLhj/eC8goZzykGAY5uC/mYe9WWR7gZHX5k4uZUJj7gLZKhcFhcLTs?=
 =?us-ascii?Q?7xatmfmO6/4WK5uY8wqPxPY1PJ9wfMkORIlbSqO44QdO8NpDKMKstAb8hvUw?=
 =?us-ascii?Q?aSxFylslsZyscY9jheai0DXjldYrLbZxAqrr/o+6IM8RKKpowtS/NN6xuRu+?=
 =?us-ascii?Q?WB/s6A7yBYQ9ra8k18XLyC6Q7/qbtO1nn136owixWY0RaXV8cCv0WFr5F9p1?=
 =?us-ascii?Q?m5oR9jIbuH3EzpV1A8YfBXvvCUV7jvTMKAOUxgSyojS+v7Bb09sz8cnV/YrO?=
 =?us-ascii?Q?f395CuHPU98kuKcSSap513cxjTJUUkE4B7iHsNGxDD9q/+2/KIbM+KhtBlsd?=
 =?us-ascii?Q?AZPwfMmz1PXYmR18vCfG+fhBLGjLzRSbt7Lgn2/r6JD/8KG+6onRxFhUn112?=
 =?us-ascii?Q?tIynN5wU1M67X/ErNbj0B+/GRDM9ydw1XKt09gpghBwqkjU0JwBwkFbBnDs1?=
 =?us-ascii?Q?4oSxmPxfof5gpLjjOvtGIvM98GdWzyJGFut5u0eYu2Rhx0dIJ19o4tqeJzJX?=
 =?us-ascii?Q?On8KQ9UrYtD03IxGJzm2UK7IbDch9a1LUp49YLZeqa3QpN0kYPVKQOUNCVka?=
 =?us-ascii?Q?JKRhkv93OXzruvc/Wv45MwOVJgek4AgKm2Qv8XSgpacpXLw5Dyujw8zsp25J?=
 =?us-ascii?Q?rLfzJwYukeqTrFsrkgCe8dCE4Ia9sD/De7Gye53ngdxHAl151/pSQaPR+p+p?=
 =?us-ascii?Q?uyZaUR8iee5AiU6oNY0+mCZnmPW8KWuJu4VZr67y6o+hwM6ytJzPoUO6nO70?=
 =?us-ascii?Q?uAGjIC7xuAVdnZGqoKrIg/aTvwsu0eSL7bHMAs/mNJQgY4m9O9tBPYI+JT8U?=
 =?us-ascii?Q?OcugJbUTGroLET5EtJloipRI2TJlTNbQ9JdlBmvH8NLzLxbPY4Ac44Q5rtC3?=
 =?us-ascii?Q?4Vw1RUMtTCre0RIc0SUc3Rsi4FLYj5sc7iNYrEFYFu2aeEy0pYy61s8dOjw+?=
 =?us-ascii?Q?hyRWJ+/Wk2q8xtJ6RG5UDKLkUwa3LGWT5i4O9Vshpofr5OWhcIkl2aXQmKJV?=
 =?us-ascii?Q?9GthFlmrNVUSPL/fQNNs7XanP5eO0GozH2iqJkuX2XIfjTnFlWGjdwYruhlR?=
 =?us-ascii?Q?Hrw4wlx9NVZzfhQJJOTf+9K1GOZWj5gLL3dYNnIVZfnLHHy3ZNweyufFpYSn?=
 =?us-ascii?Q?EmZoVGnWu9nq0AZPeToa7jRkiuwF5YOx7nsiCUWsM4zQEcbJcA2veICqe9CW?=
 =?us-ascii?Q?t/Y9t5/UnBjtLBTm07Zh/o0IB4LTk1G1NzcCNPJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48047c0-2b96-4ebe-2755-08dc83e54ef1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:27.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elta4oGpNdB+Kys8ELO8uaXv4qJge07gHmJlZp8fiwr2GdVauTFVL4l+g1uMmrw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

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


