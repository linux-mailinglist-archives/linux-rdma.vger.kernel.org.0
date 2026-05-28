Return-Path: <linux-rdma+bounces-21452-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMOQOwmNGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21452-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:44:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 690765F6A23
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA91130AF0AD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B66423A9D;
	Thu, 28 May 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GeeC//0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1763421F14;
	Thu, 28 May 2026 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993462; cv=fail; b=qybZ+y9BmegwqctS72LonaeoiyGX9m0Owivz5AsqIsauf2GcSQg9Q7+vmRbWb/cALwsx2QDdNwtw7grYzmti+MAojGvJdswTap/0BOjBNk8hNFvzjxYNuiVJR9rX4wy00l2Jb9pdDuRSMLFULh4QMA6G3l9kpJ+ZlEp2TRxnonI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993462; c=relaxed/simple;
	bh=bP9mUjbNfyoRDMwGu+opwgvw9zGBjtsGLafxlU4XnMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaCStKU4sZ9iQwgxmD+J1ZUIny1NSrC86y1P6+WXveWTf7R0tTz8Y9YoS3FrX1KpYPyxOc7f/NojBwerYDpmLimPrlFBHAb5Be6/PWnHZb0iQ9OV+knqQsP5XYr+BxGCSRril58oK5qZbW3mvwf5eiU+Mv+9vWtPgDEVpfqe4AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GeeC//0r; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXMuFFsFRdpRplgzClR4C41UEG9NdO/GiiWPrEk5skIA2bGkA/KwNki4tvsEuWKR73BVie7N1/GXgvuk+VqVKIi2rNrIvnMVo14PN8wyb762QoKBS7zGccq6XsjwXut6Mpd6KGsQhj9PsswX4UH5SBqG8yKodOOea5bNoJcyTcYFGDUAQxmEyBUfADxnYwc2OQkqQKJcEy/6ARo/g24LjkAQ5MAWlY8NON8BZkBVeUJ9ap/9rbEpjUL7WPBdGqfQPZ8ZCDiUxVFGRx4AaLY1fECuCP9Tr+gKBDyFidlWSfRyJp0TlYtyvQLEV5nZvvF2X3bfUtrr4tSzLwer4Ax/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIoFM+OyOLECxtWPJ4oU8CzlPdf3KskHGLt8MQx8B7s=;
 b=kFDxBqNJ5iBmrXAHSM+ECw4xWGzj+yxqBlP+6k1lZ143SdXYU88TxBLQq2OJ/AgW64VTdv1J1lyjTe0S6Df+ThpMWubLmS+DPt9ePN+0xDmLtllRiCgPiNJB1BEni0LMILWBTbYBLQz4sT2dlKSefbbv4h89yaw9fuTAboE+kyFU9zWhZhAUSp5StKsY5Qtxz6rl24KtCjgRY+fFdljafsnMuwoaqm2rUOXFmItdQG2GpM62W4ZIpUhOZaDEWqLCb4mTsc2KduR+gJDae/T8YgKTS71QZLS/zcHNWjpzm6y6BgYCVjCVDSQRTyvk+M2Kx1bz8XOkFYFW0ObnLCoF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIoFM+OyOLECxtWPJ4oU8CzlPdf3KskHGLt8MQx8B7s=;
 b=GeeC//0rkKBkSB4cvFsLV9b7zkvlffKC/SMnwlNeRuhg0EimertNmRgEk5wPtVfFDw38P9ohzkTe7xbwmWzbl+O5g5P6FRmkn/BWNDpyyAL5Mg8tHKUT8kbsZJUSc17s5fUJDgovD/EwxgIo1qrCYGltutJ8UscfDa3WEDe9XKJa71Qq7jFr1WZtHM+9iT10Onf2v40ZDKXbWx74iqngyAszCccvmijgDJ8YQwwSoPObNwMXebsYPatALrafuXNCFURP7O+s2NTKntveJsrPLNsPcfBFnvtR+BJ/xI8/BRY0sz2TKEZpJQArgry7vYHTON7WU4aM5D11dct1Kd8aAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 18:37:20 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:20 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <ynorov@nvidia.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 15/16] thermal: intel: Use sysfs_emit() for powerclamp cpumask
Date: Thu, 28 May 2026 14:36:22 -0400
Message-ID: <20260528183625.870813-16-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba9cd3d-6cfd-4a8f-a184-08debce826aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	x+AbHb3Ta+9VSzGAj5hSfXt+9NXON8jX1Rt6nuQl6IyFYDDVjd3+thvKyuOTI21d0D/ooJPILTs13hNQ0yNR9ufpeR/Xqxo717VuMvU7Yd6ku1gWGUBKnS/KAJg838Kfp/9IAYYaSHcWcctz74CVIHzbP0PGvCZKQOlHdyN9SYFcdvJZsnPq7/rwkFWC27lDy/OzS6q3EzOBhClqKQ9DwsqcI37KnkDXJ6EA4esZtxzp7kvJNwxRqeCoBD6EgPzp1NjMqBPnkZxvzONPsN0HLW4H3+FV3g7LABj6QMpnpbMX24RC887yhyWLpEGBe8vjKxmr6wX+pS4XWY4ohSx24yJ05yUCLgyfwZP61oQOHBhvCkMsx8XqZrcdOLbXyUbtCx3OQCWPajNESTKImW8T/7SVDgqjNYUSgqL+cbdNRzkU1JKbi2+bBUh1KK97juxfahECCposBJizZTiTewjSQZuvtGF92v1qxyitRdW3vPuRhgTztQbmUB9QOdr2n4lRMjWJfD3gV3t7Qehj6+oqtj3HK6XXxw9Oem1UMr1AFkyavwLoK0Ow8Uoq8FRE6ejb7EPiYO5ksNMNbEhjrloYhvXCJ5ISmOX0TcKMyTREKGxGARcoW6vxe7GfR5OKVPREe8zc128ZAvE3JENG6zfRXFOjsTcSj4WTgC1mxyPdnAYiTn0HrlR+38cIoalr8uGX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLkXRtjVx56PyGXzv0qAppOCKb0fB0DtefE7e0IBvlTypFNPJquMVC4AvHIK?=
 =?us-ascii?Q?+vSh1bCVIkePZgEKJnkwTLqBN8JYuJKIdaE5eUD1KqxSWHowt+6p3UZcHBMd?=
 =?us-ascii?Q?k0noupxl2N6sSNuBo5SgnVNYaQ5Rhxl/L10fw0u0f+99GVtm9ptVH5MCtVog?=
 =?us-ascii?Q?jI/snt5tVUCYpYbz4jmACuGktaY6RMPgRpOtWgq8Xcv/mfFY5cfNN3jHO9rH?=
 =?us-ascii?Q?mji82WtXZPwnl7G11M7HpRz0neE+D8I9NBYb09TJcTsJlaK+GnY5TAb9t6Eg?=
 =?us-ascii?Q?3XvxSD5FwsLZrmtl6M5iWvPy/H++tF5Hhb9W4tiP3OIDNaQWmROg48t+EuSV?=
 =?us-ascii?Q?mMCxZRbJtOIcDxEA8m/7Lc0nbAkBS8l0kPgI9BmZkV7mnZGjIdMXXoz54kuK?=
 =?us-ascii?Q?o5sIJFcqB6AptWyYYplWjGIzdvIRdb5mpnyKUbz2Z3Nftg7F3k0Xhm/Xjcl/?=
 =?us-ascii?Q?j/tYD18oh9fjsSZDp9lYbbI4hCelZ1qONwtnm/QtzZVz658mzNzPHUiilwUI?=
 =?us-ascii?Q?/aJbIxAXacIw0Klw/DKgklCTYnaIZMaG+GHl0l1uYOlo8Vk8xOdCo2X8ZaIF?=
 =?us-ascii?Q?CkpPzkWM72xMuIvZSfKRd/B3PTTkIoDOBDfnKSGdan7WVr30Uv3Lv2MNL++6?=
 =?us-ascii?Q?Kw0uY2YS07Ofphov7wD0Jg9Mbp1pVxmxOZVSAGpzG6lDbSCWckQN+yPoIDOv?=
 =?us-ascii?Q?MponrIXk8zb6jL0IZ4+CPBdWoslXFDasVP4P2dmtiWxqKJc7PtOftvHIj28o?=
 =?us-ascii?Q?ztd3jA0hEofvKtmY9TiOxJbxpPtMFE3hMEjzZfmq+GTtb3BYU/fh9YY+YMFu?=
 =?us-ascii?Q?asZR0ZdnmPyOSulFLUito646n/oRjuc7ztrmu+WlnsOQzrN+s6Tid06aGlY1?=
 =?us-ascii?Q?Ckydv1bmJb1Ib+Vb2Hmm62PyR3u9g5lzZU9/43Ew5TwCF+5GFbhz+b7v1cM3?=
 =?us-ascii?Q?ykXoWD9cllrKfOb7BYld1CsTiIbGZzMXJY/obmvBX96CBWrcbaPZvXw/IoQ7?=
 =?us-ascii?Q?f7hDsFpNz/+YPd4252j2oMB8TqgXEo9bIBv7+cf2jAnI1TPA9skdid5oFuu1?=
 =?us-ascii?Q?GIoJKl1xl2FcvlD86f0LR3sQWl+OAiZsBYzvTCPwpR4p2Sj6RZOxgHGDOaWh?=
 =?us-ascii?Q?dKAmTwv2qlOnH1KcdmVPyPboOKfLbf9ccJhEpyZPjkSmoB2lyHNv4jk0X7Ds?=
 =?us-ascii?Q?xzoSsW/z5siU1rxymFA9wh1MnJ3jlBD6F9LAVPxDYrM4uchDQ99NebyU77ng?=
 =?us-ascii?Q?OFxn/pt2UoDyc/pkDXwmqF4jBzDMBjDaGsEzYSj15heXmMZ9OUE3sPJTLjSl?=
 =?us-ascii?Q?8gGVN72rrGsdEF3dLMRSDVmhw/3RK0D5qnOGxyhCZStcrRYIK6Zxo1MK5L/f?=
 =?us-ascii?Q?Kct5S7g+PpbNFGBjiVV7lrOoU7663KtsVXVeJMSycR6SAtovIIMxRZ5uet2A?=
 =?us-ascii?Q?NIumwvbNF5DW31000wW/Ye7d9qps/4ETafpmKePB9MPGBYezs9jLLX/zvJfL?=
 =?us-ascii?Q?Z3dGpJ0/qL2nmIvyF6RInLVNe0pNiP3hJdTRg/j5gci1hRgXOZzYM9wSkwV1?=
 =?us-ascii?Q?uObeqBJUeEcV5EuHSfCq1umCDNswRwPO7UnZuNuP8pu94M+70Xv0FccRn7mu?=
 =?us-ascii?Q?9N+gY/Ax/tngNV82KEWlKXPnDV+H6G21XQj/7YJmpm57XFIaJyI6rGMxscb7?=
 =?us-ascii?Q?iG6WLWzF7uqwWGcL1i+CjWkHgLI49Aj7xYL/Ytbq5Z12W2+i+QbDLzixXrNW?=
 =?us-ascii?Q?kCPA1blYyiAQ7/Kpf1NqCX2DwhLNXH9Xq4OTHIJ/bVhFzxtf91Qz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba9cd3d-6cfd-4a8f-a184-08debce826aa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:20.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiICBKvKxEVXExv7p9hNmiEiIRVi0OhY7MubGR9YJeGyGhCb0HtPaoOGOb7b3/5/4H0Gh6aWUH4bKErUZbh+gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21452-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[90];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 690765F6A23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpumask_get() is used as a sysfs getter for the cpumask module
parameter. Use sysfs_emit() and cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index ccf380da12f2..bd7fd98dc310 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -200,7 +200,7 @@ static int cpumask_get(char *buf, const struct kernel_param *kp)
 	if (!cpumask_available(idle_injection_cpu_mask))
 		return -ENODEV;
 
-	return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mask);
+	return sysfs_emit(buf, "%*pb\n", cpumask_pr_args(idle_injection_cpu_mask));
 }
 
 static const struct kernel_param_ops cpumask_ops = {
-- 
2.51.0

