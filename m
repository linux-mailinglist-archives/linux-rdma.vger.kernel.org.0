Return-Path: <linux-rdma+bounces-7498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98853A2B70E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362753A8399
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A816913632B;
	Fri,  7 Feb 2025 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2Ksi/PY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BD46426;
	Fri,  7 Feb 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887233; cv=fail; b=sL4z9MeHDzEegONUD9hpCjfbAga3BknHVAB3VUTTHJw1Liavdq9KewuaUGm+eqE4CDpciQz26+//PUCZrHW+PBAUHABk68eVWmDRtrK8K6ehb3CpJJ0RgOBarjPJJVhCtdZU83ZS8fSllqseAgMsMGWdrqTbjxZOA1BcD7+sa0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887233; c=relaxed/simple;
	bh=ybY/aq1866W5z3pTgBNqlk3JGhhK5HAmnnBNWzSDsaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8lRzLCRfFmTxR63ufZquF63jFpESDUHV42OOH77TFGKQFvXIwtiO3w86G1qnODvFeObZHTlSPOq3IrYEn4XQTKp5IKUSAEHYEJWG5HKXClZqj3DPIJFh1H+xvVFcB+p5HgvLtwzgNxD+kSDCeIO+WoU7K6KWwFeVEKzHuJ5bxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2Ksi/PY; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGH5DNG6pskMkHmQpcrP/0IL/uzaLIjYCrIxq/c76Fyxbb9xmJMUEXR1LssdtXxxn2P8rUs432iVkGCPePPsxYiMtrpBvkFqIzmiG/LAK8Pev7/DrnAyji2Z9j8dttcRbiL0me28canEG6IoUtOwll4vjchlEC6nG6/nnhLck+1g24maX9YiZkMYFSiFD7r0tMZx2qBTaAAHzEDRNZWz3/30MWT6qZfoo9x/v3ICxOmEm5/bTW6yMs5qgS0ckhszDo9VvRzBVoF6xTRahaVFWYyiQgGQ/Ubg/DYMJFB5VG+GxCwe0yLZm8N3SqHIr1hqYolr7oT/Y2vkIzeuvCgAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXgAlChIbQTGn376GAy4wuZspUnyomkjSWivbx7PrzI=;
 b=j1UIKpUwjOIKR75GVXA1eqdnkic5iTZnr0r+hY+7GSG+NRU/4nNilHkdnAdFyIMo/RJtkk9ICtbGfO8UGWNSW9ruBUQSO5TM9BTMdQ+SPHph33cTCVu16GbMLr1UaGrnpaqT5eK/Xec06Apk4ypotGnJ9MWAE3BWx2ejSrNlu6RSvLnWHLBQZFU8DiiKiWAn4b5ivvTNZ5FFq9+XA+RspRvRThuK8rECuK1RpXEy+1Yhu1usJaaUgOdWlZh6dHsnl66JNYhL/3SFKaTYPE5J+T4oRIpgDAJNgFDY2fbIHBYP/ZYSCmV1Kujoza9wJNLQfNeDOh2OLtdu1575wOQR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXgAlChIbQTGn376GAy4wuZspUnyomkjSWivbx7PrzI=;
 b=s2Ksi/PYkdNC0Lxy66LxzoN4vqT5+fuwvRZmh/yi/hIUG3PkvSq8AGl+zCw+wK4e4UBm2X7fAn9dM6z4LvZOD+vu7m++aVnTF3FxKuWbWCfGNEGITZeaszI007KDMafM+PLgUZlo/Lh+JwzY/zPlXBUr06o35pkxbInxlIGIOHG1A/H3HxRsWqLBXUOxE+49XHCNUNxwXHq1sKF1CzHOvJjefV0saVvv+yW190VQGvUXE11rByT1O+PvO+ivToxlxIyghV+U6APdEvoExV1TZSvBoxcTEBdn0Or6eZNnpDxhfDmq09gtZaFSIkL5dV83zjvdVOhkJQ3FV/12TiWNTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 04/10] taint: Add TAINT_FWCTL
Date: Thu,  6 Feb 2025 20:13:26 -0400
Message-ID: <4-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:408:e4::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dc3e50-20ee-468d-5f68-08dd470c4768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9djukpYMVacqMgzR7VWm51sD4WqpFAv+6ILm1P1VM8rmuHQlrGpGnZ4NUakd?=
 =?us-ascii?Q?dYoSSf1RAYGQt6EZ0fIDsJU4KGmZSlqQqoCe0PGHoqtOYKiaoGOYrJmqMnxR?=
 =?us-ascii?Q?z3WuAG3ETHpEEpa3I3Sm4v2BiOLoXNFGNf6ZovqaAtWrPqMtfGBOisJRIPDm?=
 =?us-ascii?Q?TbewM6tLphr6J4aAzMGgBNQBN+7Nl0oZGfTAWa5vSldR9wfnw8tNmRNJPHz/?=
 =?us-ascii?Q?yt9TN3aUfXn6kskbV/om5GIP1Bn/yvGiXr4T3dxaNESjLZd0HKvsvSF7p4Wj?=
 =?us-ascii?Q?S9vfAC4M5qS77RG9CtMeXzNA/DcfLfFoKJWoFrDffU2oPnV8L3MgtG6jj0IR?=
 =?us-ascii?Q?g0mUZbbk8xgec8yHTP5O0fox13cW7GGqKC3ZPj/f3IYfuxpbWI9py0Lzaqar?=
 =?us-ascii?Q?TXIOaFGxQSBn9FL8MeIoe11eAO8q9WbYs0hKSQ+B3L1u5NE0CdA4SgTTPZ6V?=
 =?us-ascii?Q?V+HfcHRDpWpSCh4oqUDammFI4VH3wWHVt7Y+EzO+XfJrQYLGmn8tAo2V5Yva?=
 =?us-ascii?Q?A78ILigC4+uIJIubkU9tJkxIOkvGzILNidzrOwucojGe7ExEe61YgqOa9xVA?=
 =?us-ascii?Q?nuO97Txwu/9BOA3S/8MmtjT93Cpw9qwN7+94K7adkX+mQPv3R5vJRiyPRvik?=
 =?us-ascii?Q?HjHw5NhSRcKhw6XHQPme9PWfuPZ9wsPDOzff0I9G9lyYCt/wvT7Tg4sSKXhi?=
 =?us-ascii?Q?f9T2Nlp/qW9/qpN4OHsqIyFxY3rmBttf3Mu/RDGW9quRmgo711E3fZ/Bg6O3?=
 =?us-ascii?Q?eJpCFvGGsDhR0AjJhV8aVi1BqFQSOEAid9e6iHpNNe1jt9NHfmQ19Wie+hJn?=
 =?us-ascii?Q?tqMtRCw4H7TWX6wbVisb9LtJ4apMxz/FHDXpyLtdz/P0oH7HkBR0Grw9//gU?=
 =?us-ascii?Q?Z/odtMmmcC1r1eJISNmWdzwP2oXUwImiECaZDcXrxZctre6gE7b7TcH1DnEW?=
 =?us-ascii?Q?LgzGlIFbhOlthSJ51jfKa81gyw1GNbhVcYqE7UqN/F491mNMPf4+r/TYMkRV?=
 =?us-ascii?Q?nBjPKlQL9kaSHN+owmg1WgC3WB6xoGahI9qB8j0L5YfS2eAKzFxOOS3frE+n?=
 =?us-ascii?Q?gHWn7nd5pEIRoX1JYDe9vvGFiPyBwwN1KARHRaRTGzQUXN2GzJQlRLKwjkQn?=
 =?us-ascii?Q?SMnAKg76B/OaKWiDHdMKxAbFpApRxt7uoanMfTcE3LiVu/JzJYRvjp7UF7Zo?=
 =?us-ascii?Q?4HgMd7fWGEIxkZ90CHsJXLkBUBeddVTJ+ejU0/UELl2uobRzgD55LsxxdrvU?=
 =?us-ascii?Q?Afp7fuNMPoWbE+FG4Si+IsaVt/EzZTdjkaa59JWWpqH2RQqUaAvhOPMM0vcC?=
 =?us-ascii?Q?aLA5j2QJG/kry8cpCGWqQfcz0UEhOefH7r46853/jFEMrHTyoi9/KSkD3JKL?=
 =?us-ascii?Q?A/vWikL8mrUauqfGOKFE8+exlfE9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kuUpK6JX1Z+yk+6B8KT74XvVV4viHwVLtprgyP/3gyJ0EybiUEoVBqqE74o?=
 =?us-ascii?Q?cpSZAHsFZeeHoV6OVay0pVicxeuS0drQGEMo9ryEHqFUbTuGWBNPlmG2UJYc?=
 =?us-ascii?Q?m+mOGWHTqNKc2u0h5KNBqClXCQTlwF4JGdc48GLd8gQ5d5ltwshX1jNLt1/J?=
 =?us-ascii?Q?YcKeYY6Y40i5WgCI9ojqxvNV9PVbGsS7eB+1+io/q3ZhuMXIotk0QHiI3JNf?=
 =?us-ascii?Q?AgRIIrNUbpG5PrsEGEn4eoYVaYav4+F+Xp7P8FGELfkL+OMjwo8V2+l7MZWF?=
 =?us-ascii?Q?gAWvGPLNXOG7J1unXv6cuizuNeWplyRH8U1VTY/gvUDrDjNSruDQ+jiZwTiF?=
 =?us-ascii?Q?gzUt98x6CP85R5jdgk9K3t4HDGwcVTvmKVjH63HqOj/Nekby40vLX9imqYsy?=
 =?us-ascii?Q?PnDx+joPRn2iitvsPq3CF+IX5PUOLpJiI21W2gu+00T3MkKXm/7LnJmnLU/t?=
 =?us-ascii?Q?hKyz0FDTtf/YM2up+K+BzLLPd9v0sJMwh7awIhTYiK1IsRojH66J9Lc9EEMR?=
 =?us-ascii?Q?CXuAD/Kxy6w4d9jJAAeppbMwRNcB1oowSDPPS6JDNlpmGYBOPq3a17/6q9+J?=
 =?us-ascii?Q?RtmZs1FCrh4hnjHLHqtOG719ny71zcdDjDQZw97QFs6jDGAS4LDT+1cdHdJx?=
 =?us-ascii?Q?bakw+wEiwLNq2tedhZ0AR5yvZ97rmLlwL6pSvk6uuUAxS02lZIZLhzq36esu?=
 =?us-ascii?Q?KJMN3kdSy+m1T0ZPVMRnkFyylRREk0UFH75nF93rV5TNpTm5of6mt0haUV3e?=
 =?us-ascii?Q?TGV1ixJtdSuGHI5Kfo7SS17YKMJx0Kavh8PKJB+LQS2jpxjgxucXY1wjO52P?=
 =?us-ascii?Q?HFUTpBnq1T9e6e/DROfbgQvI025qt+U3Oeg8GkdlpT5Ubns+zMDTuiIGnP2T?=
 =?us-ascii?Q?QG/WpHUh1otqw7TysaMteFQr1MJ0Ykoxw8//hOXeXgDUHsP2JUEzabYB0VCs?=
 =?us-ascii?Q?b/Q+sjGWArgzTRI9j9HZRt26rGnQ39d85L50TyjKhF9wEpFpjDjuMgriTc8z?=
 =?us-ascii?Q?F/AM29z/g5PcSPv+M9D1TZMTi/EtxiwaXgfILcHhE16UKjwXmHrAcC1xKplu?=
 =?us-ascii?Q?jIDgHnMy8Hf6ieUZFPXGuKPoU1OJK2zZV33RdfmG6pLzGdFqF3uMMoHZ2StH?=
 =?us-ascii?Q?EXKkkXf9vvorS84KciPnexbiKQwg3ISAbBPcUM8sMq7uZLP00lQ01A/uTEa2?=
 =?us-ascii?Q?RSSAmSzsrQmSS0UauomuPkM7708dMXIWBCfqFbAEnj+q0c65OFdv5nYOksmD?=
 =?us-ascii?Q?VwmhiYRvf/w7aBIyjYIE2BRkqwWdrQZjDbf+1f8blFVyGrAgD4PIrDHaQFp+?=
 =?us-ascii?Q?HXT8o+rZbKVJxhVr8qu/1QJh2y7/s+u9UNqdEgoxWZ16Grh8ZsU2Fl2kgvrm?=
 =?us-ascii?Q?i1bRBvsPhnO9jyimeU7G0u5J4Q+q/6PK2VAUPvsh88Uz7N4AJvT6JuK++f4F?=
 =?us-ascii?Q?bfJDDxuLQ/tPJASqfT9QXJ7LR4+SaHh88BNuOmcWv4FY3lkdsIG+Szfuy8br?=
 =?us-ascii?Q?+vTV0h54GVdLuOL9z7rQTUY/gmUVkJ2fZacoibpsvvg9azMfg5M31On4WTi4?=
 =?us-ascii?Q?V4WnfweJna+ALCSsiP8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dc3e50-20ee-468d-5f68-08dd470c4768
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:42.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjyDeG7Gxz3mSwvK7hmghGdzidk6juNghULA4OMyvQOc47rE8olkNj3rfJUr9B0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

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
 tools/debugging/kernel-chktaint               | 8 ++++++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 700aa72eecb169..a0cc017e44246f 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
  18  _/N  262144  an in-kernel test has been run
+ 19  _/J  524288  userspace used a mutating debug operation in fwctl
 ===  ===  ======  ========================================================
 
 Note: The character ``_`` is representing a blank in this table to make reading
@@ -184,3 +185,7 @@ More detailed explanation for tainting
      build time.
 
  18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
+
+ 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
+     to use the devices debugging features. Device debugging features could
+     cause the device to malfunction in undefined ways.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 54d90b6c5f47bd..2494d51707ef42 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
 #define TAINT_TEST			18
-#define TAINT_FLAGS_COUNT		19
+#define TAINT_FWCTL			19
+#define TAINT_FLAGS_COUNT		20
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb250..0c55eec9e8744a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -511,6 +511,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(AUX,				'X', ' ', true),
 	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
 	TAINT_FLAG(TEST,			'N', ' ', true),
+	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
 #undef TAINT_FLAG
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 279be06332be99..e7da0909d09707 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -204,6 +204,14 @@ else
 	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "J"
+	echo " * fwctl's mutating debug interface was used (#19)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-- 
2.43.0


