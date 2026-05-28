Return-Path: <linux-rdma+bounces-21445-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K29GCKMGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21445-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1405F6812
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A97F73050D22
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF842B74D;
	Thu, 28 May 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/SyPTVy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2B40B6D1;
	Thu, 28 May 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993427; cv=fail; b=hie0CS9b13iaDKX3EKafz4vTI63VsbRyFMK8TOOvzCXBK/ACQPq19RH/gRcbClpv73DvOwMIovBOyHZ+0Hf19gN9YZ7zccxjPAXqabj/4xnvswy0MwCTs+BcrO8tC1Mm3LJn8kMtWHaFmtReKJSktee1Dytn50EcxLtTG0NnO10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993427; c=relaxed/simple;
	bh=uPeUz8myxLDM5VmYkLtabTWAOR71G47JYhL3FcneXDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtpbLk8XiNjnkT8n1vwjwLZ/1o+v3NCJfyyWBSZvHSQcopC2UUqatys6ywe0OcpyCpgjsBGranRwXuBnFty/yGkhl9GpSV59cDTSzWkgdf+W3jOWTDniVdYfglvxcAKMEV2+AIEjINcFXhLzrC/wncePhbrKlBugaEraNH8QVb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/SyPTVy; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ5aOvcRAbp11oWLEPpPC9NEhASVawR5Armt0aa+zRi1kB1nYVFNkD0oD8tYBbmtx2GddLHc9QeqgMCDSs6SwqtVof3OgQtligQp9wrCPi/BvF4mnN+UfzqsrdwkOFE29fskGeR4pZnv0+lA4O3usVuzjJrjscNs78hpqwbELQwMU8oxQ4zlAZ6DbDsTrKEhdDODf6z6f7Hjs+QJ4dnv5T90dsGg1YQ/GzEtlxR6MNQ1MAGW5i3RV+3oHg3tWqZ9SUCevBaQJomIYBoHFElYEg795tYvyJ0WQfKwiyug0+ZiUzORekTIJIVYT8CPTlvnXFAnVItIeI/u1HjxV7DKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mV2sJyQVabKckh+PwJjOjeEtRVeKMlxkIsaCpbbGSM=;
 b=ox2FOLnjXUoRn/HSIfdv7zzE9VtstH3GHmIaAGWorgNb4SzZrg4WBFG39obombHIu09C2jrkfMwx9bapWygHDNpp1y+UKwktqeWJyjIqSLmi3oRWZbxwNKG8/hek3V87XFjGPMIGD2nN06N9r47a8Bp2A2sb5rAJlvJwTsDGBj93E/RlU2D95BFm/9WJYFeRVrHTlvTxv8SFeKsh/wekABgdTCHY0DjxoLbUMfrQHntpLMXj2yd912m9SvDgZLLsZGSqkh3/botOYTwPsDVvoh3o41reK5xFYuT0eA5rNK35PBZ15vxT+J7lUNGjywAmpTjyP7cHEqFdbhliOgpeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mV2sJyQVabKckh+PwJjOjeEtRVeKMlxkIsaCpbbGSM=;
 b=t/SyPTVyo9SzMRtnMUmGklbBSzDMkoW2QExtrg2LmvUd2z7MFDAMQ9FGVk7qj4wbTwG4etqcpbm2dprFWOpwWQpSFIkjaJ9hatIpDzs7ynEa0qCgNAD2ntvkCozOh78WHsCum83RKFSSrz9SFl5t9mG0XarW/tW4E4JeXOK3cLYYzeIM6xINQm0Kax7yMteztJI+sHKlDqDwWj79+xniBIBfk0MKG4M/YonoyAtbufQoLduhBabIKHM/fb9GEETw9GXjcVeQAXRn6uxtRvKDg1ICivyBVOcVfpgiBAA7nT3Rltw1uMmiHkaRpLBD/0Q5+9fN6CKWiiWGjaHgxiVorQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:57 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:57 +0000
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
Subject: [PATCH 08/16] fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
Date: Thu, 28 May 2026 14:36:15 -0400
Message-ID: <20260528183625.870813-9-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5fb65a-954c-48ba-b428-08debce818f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	3x2Q8SE3SgcJ5OCcwZ+teeXXXDUoHaDLiVMgBWrtz2Xh49QWYJlfHK2dR7E7KfyqPR1gH/O+kaYOl8GBdsGwNiJRijRG7Z7iX/lg90MX0c4G5a9dg4BGjJV/mnW6iwbljN8Qq5cKIU9zFKHDDGh3WKoq5Ddwun/FlnLdAp+wuOdo2z2XfE83qlBL6GdEJ9WZ8HvNw1qzWPFkKkgJBu8DtJYtNW8Unvs3in6/SOpQXIdHKlmASlJA9H38dnh0C6fanse9G+sRH+jcp5l4I6RB4Gz7m7mebHFwCfm5OgDyTX9Ip2Q+MBns/zsxxP74z1NEG/3L6aD7xbfkXXbALwXpGAHCome0ErTWT48EPqnG+kjGgO0HntVjJn3K1xBLIQkO+JuGz5mLqp3pwL1AgsbZ+hI9At8eV6Py/ktFJxkp6mYXAPCkJPsoWxqg/JfvBRNGssmucP3OslTRsWTZPRkvCtS/9cm6TG461aa7KCpH9nBgy5JrPVqdK3fNecSBGfinrxSz+Z9djQaZel89qzX6aPifNsSI2xgSBKEggimRB9WXTRy0cASrX/f32DaHvB37hxJVBp1uOQ4QCMW1tXKqdLv89h529/cPlaHZTbkNy6mUx9PwzFVX5gllttAkMxxrWCOCVx2fs2UN5EYt9Sq8ZOs8mHgpaQK2XQSv8cAQ5TfKI1Lo06Dr6VFBTlBl9NZY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T+yMqP/dA5lXL7uV+t9q3oPBDzyX2p+bybL5zuf2Tr60SwvMl4YPq21fJKyN?=
 =?us-ascii?Q?AD/6IqR7UB5JO81fZeNvQsoAV0nZ2Zz4h/zASMK7w1gADWomb6NbwL2dv8yu?=
 =?us-ascii?Q?c6kH1e7Q7amhBcm5cT/v2plKWbnI7ecFfSE/1nDN2hDbuE0z8bepZWwiyOlf?=
 =?us-ascii?Q?XSQH/UY1h5MZCX8o4IJ5lfHHC/FldGmRTPCp5stqp1H4sTmFlaCOnUAsrgAC?=
 =?us-ascii?Q?fpC1VvDG7HsAsuF5Arrsuwey1ZUx5p8Xp6Pe3BNOjLW76T3WPQrWqOEXNAIZ?=
 =?us-ascii?Q?Xqi1dxiDSC8A7bIYijfQZM7/xHDUVQfo0gaLbwLPQF0wVN0YBWDVupp1Jcyu?=
 =?us-ascii?Q?gQokj5gQhOyTULktJPGhzGp28P3HTHmOLIS0ZM24/U5t8Dmaz591BLK3o8fN?=
 =?us-ascii?Q?Ajca+zxNTnr+T5nAVD4YSNZJfjGAd7lJq5g83wXZONPKeGcZkFt6Vm71woZT?=
 =?us-ascii?Q?CEJqylQCZtw9RBJGjszKCfUP89AqSy9PY28Q/Krejujqps2BifivEui22llV?=
 =?us-ascii?Q?W+xWYRfpjBuAf11y4qqQ321wp5/xMaRap+8d0abFMufQLGyVsjr544A1aNST?=
 =?us-ascii?Q?FPC3BPqQOYDmtI57qg2hBGrFnsu/trUhfZzg6HZT6Fg8uTwP80XmmbQiEC3v?=
 =?us-ascii?Q?SjKa81kdSx60wg9zHoC/MsQTHvc/q2x7xbrIDjy6TWsCPXtv7HZ7+kIIjW/k?=
 =?us-ascii?Q?EPjI9z4Yn0LC73JrXiYM6nDgmRokROeZe7IgaoLWxWeuB7pv1VY603TYch0A?=
 =?us-ascii?Q?+SdHzB6ntrUIf1/n7cP01a1udkpZKOxG2MroQEIHld+kW5dGf4yzMibNsGju?=
 =?us-ascii?Q?ohIAdkMO7rXIK1v+Mc+qcQHICIPXFfNc1tPJZvrcPv8UqtW5GvFsVShyBFK7?=
 =?us-ascii?Q?4BFB9E0sA3n9gthFN0q8jMjocxwyOGO7dZCbq7XVbj2jtaxr2WrE7b3wkWWC?=
 =?us-ascii?Q?id5xB7GslSdeWjP6Dw5gjFsvbjMMdDZ5SaWPI9B6jaaPii9djaT9QXKsGT/f?=
 =?us-ascii?Q?MKIjftx7TYDLpV9SopqkqJvWsNozOc8ToX4EJsHQgIRZRJtR8zzzlhYifYkv?=
 =?us-ascii?Q?8S0XSQreOFttDmbdysY8ONHVtwto0JjhS5bbjAimswPBtokBvMV1XpncvdZJ?=
 =?us-ascii?Q?DMd6pE6+c5RQPOGn4lH85vNRfbPYsEhbC06f0KYAFd8vTq6U56W+fj2JNUqQ?=
 =?us-ascii?Q?2ON6lb0oHbzCCOF6yanUXInxOOtTA/UA83uBf8LD7tQdl6ItJ0SS35eaYtjU?=
 =?us-ascii?Q?TyiMrafoGErnNwqXaRG20Mxq91Pr1am2BnPE3SdnxbJaPtMCji6NphCfv3ej?=
 =?us-ascii?Q?fSsbFQwEm8as9pDKE4mv1RRMbgNLbHt+TKRdJ25z/esQu2iq2ZdDJ0pLCGmr?=
 =?us-ascii?Q?mUWKJxkG4f95Ns8GXQX6xT6T8j/gnO2BQ2ZRFHZtEPsVNxcwN0C9NAkhhvle?=
 =?us-ascii?Q?DusKlJpXFMcXon1XFYE91OwaXbacYVbiqg4r5FGWzuHtljvW9qKcxBmsofjI?=
 =?us-ascii?Q?7e5lJU2zSIuhX8GXGwrYHakFLJsPb5kXW/q6hcM/eknJSYNcGtvM+BAIqsnZ?=
 =?us-ascii?Q?3YbkJbcv4PjBOjKBLRu9mSr+PyYbwvcYwQoI32KARMGwNBGrfuLNgD+un1tI?=
 =?us-ascii?Q?MUUkhOnQh/ONe3a5UnD5TAzqPiaXWA+wl/gCk6jzBFH+/8StciRqZHZ8JKFb?=
 =?us-ascii?Q?hUBHB6SaGU9AlXYaVXI7wZZPjBrN2dZWabSQ0zWMKutjjLTV9UaTN/HzBDGB?=
 =?us-ascii?Q?hdrwqAVlEn4zPOg3Fm5cQUnba4meRgQljX5yGKvLNhGD+MA6MzPp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5fb65a-954c-48ba-b428-08debce818f6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:57.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS/XmuMt8zv1TSDs/LZRLZD3uGjsROcibtPNcNqT7zG2HmLUoLlIBBGx3O2JglP596rvNeUybzfOazF4y73J+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21445-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3C1405F6812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/fpga/dfl-fme-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..7aa4983ab67d 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -183,7 +183,7 @@ static ssize_t cpumask_show(struct device *dev,
 
 	priv = to_fme_perf_priv(pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(priv->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(priv->cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.51.0


