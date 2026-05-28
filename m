Return-Path: <linux-rdma+bounces-21437-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2POjJkyLGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21437-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:37:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776C5F6602
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D08C3016B11
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B27405C5F;
	Thu, 28 May 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h922R/VY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C02F8E88;
	Thu, 28 May 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993400; cv=fail; b=jfd731kQDssIKwCW0ZRjTwfoLHKB4VkHIBkTYH/n+6IfE4cJF+iMMMWqzu/f9ZQ+ohtEett7WLtBe/NkIWMcogr0oKPG3y/sifW2J5vL74zyZfG+5Tkqqdzzx9qKGLi0ABXG2ogzQzEMJPH3bKlkJ6LrQUz7d4yy+uXtRZ53muU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993400; c=relaxed/simple;
	bh=kqlqK19rITWjanXFkHDrssZv0f7J9mf9zo7UMBGik2w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N5di27aMyQ37rV+i2XedSTLIOimMiWj93+paPA1RmJ1t7/UH/Ye3X+Rij1AQRHfZnkEAkt4h/uBoyylICXxmz0bpQAJQp7+8tG0xLQxzvhn2yA8cesfPwk7GVmYAWJOef9iiY3fA8r79g+n3V+VAJXRmSmdBG4jkQiFv1o45zVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h922R/VY; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4rc1G8PRNEF63wnNNLGvJE16l8KgrKiwAeEz3bPzrqxfSAQrxkGURK0u6ar9hg6HAPQqDQTXnFE4ACzSIonGYHazhC4B4DleEbmCQWDo82KPtQvfwlPUntMvSVI7t/Ca7Eq2oKUFiVvldfUyOlWhR9rqe86HmpErjt1zqIssEn77WBGbNVigeikAnlwMqTCNOGGZZZens/OTGIyTTi34FMpw2DMQjzAKS5csTIVFf7WS3AKaup8xA4FnpMhnNvu0lrj/KO5SZ32v351BGZaiZ2nXEoyXY/c4C4NMGzz3Buzs/P7Mt+h32hT/1ISNZzwIP9knOt33hexviFKXlbQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm3RxOlUziMIipQdyQHT2pcKu2ESuFD9ZeBKDhFFqu8=;
 b=m5RB8GrzCcx8H0fKPhUE613qwJk7kZSuxiAsh5leLQQoD7xBr4GHWcXAPlHT3dCBvTk7TdKoWIhp7SJAlEvs2r3q7zGvq29smyj/i3mCzx+pKwCcKOfkpkLhTOPAt2QboMXBYbdzTJlvpy1d2agc8ABH47tX3ebWXbofEaTc9pmo6OArI8YzHHeHd+0+IthDzJBW1d7CL1XLRtLp9eB8TgKLJOGurUU/hJ/Wc3gmp1viPBDaUbzNr/bqrdglTeesxFxWE9xKYSgG2jK6MNOHM5ExSh9EkrGUM2Rj5hJgyBSWvy3Fa2ZJv47ixO0ToU/JqHWJOU1X3ZkKmj6KKSC7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm3RxOlUziMIipQdyQHT2pcKu2ESuFD9ZeBKDhFFqu8=;
 b=h922R/VYYBrfQii2qD3ohQUoRXHoYuXC/tMwX4kGaSDBTjuwG6p4kQvU1DmzY4DgEh3wBrYoN1iZNtv+0s+8PFbTjMFhiOnYzxsOR7xnHGfqeCPyb/dI+boOmgU749k2WpC0577xYdTBC0Ojvsc7JHElGTx4XeTL4xjmgovFttijlMr4LvErTumd+o4Iamz0fp8JmAzE+/5qDjqBqynvu6jAGjr8fofKbqhW8dfrboM7/WRDpIZqx5iSjmc2SWVIbCNORItLYhnTi8Ih4jMirKSSk15e60dKQrbb0GJO/5Q+KPnhxDANU4V9xIrF8V8krSq6fM3QxRJ6pVXQrCIeDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:30 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:29 +0000
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
Subject: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Date: Thu, 28 May 2026 14:36:07 -0400
Message-ID: <20260528183625.870813-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 19749e33-0ed2-4e6e-5dfa-08debce80877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vUVY3uUYl2ZVcZRHFt1uUn0nw6d4ieHKXH/HFZHDcNyi+nyEY3JWsme1sfsPs/mo4L5wojaKHKkLm6i9jZd37fgEOchKCZjvVTPXs7H4+XchbPQ7IjHXVLLf0it0Dxzb0uqYwO8oTBxiF6QtifK3qfeyZ5YDTkl6r7LuwIM1ep19fQaUygG+jixUgouokBSdvnZwBCxDZIYRfNtyxosgZxBQxgsdpG92HvzZEA6lYYqB/x8Z+ShgH8f4SE5ozE9tU+ZJlUx+Dw9UvbpXvam6rt7WjJ1x7x2WldP2ijm6fSAmvPAPEBJGcOKGL5ns9f3ofAK2wHejW7hmd9KctxBbrK8nNeo+7f2Zfz+O+/4IX3eEKowaGO6kpkGOFiXvvuvRpOVs1aB7qfUef0Z0CaI74+hVxrZAM8h2mHXiXNUeTgI8fMoWNuU0u2hpNw43P4bC2JBur76cI3EfaSaIsoKxjPIlvmo2mv8qyWV8gMbPATH5ghs2c6E9TNFX4dxEyPu7D01eqevnJAb3J9Kocs6tM1J9jgRYMzJzxyY6ke9ae/6ta/NHHppfwZVQEnc3HVn/45w7/HQjBG2TIKOIkLo/RtN5Dya+P9VWaukhmKFkcHs1S7JBjhEGhLCTaCKOBVeTd0uRIQUS8pkpMaRKgbuT6FYYognFaBxGhIt0Yef9qn5BiUSBcYy2G6HWIuswNBdf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HRz9lewdEfK9kpquRoYwbH1o6nEJdTpOVIrWceCHDdXJw+rIVJYAtbW9fpm?=
 =?us-ascii?Q?pep5r+3N/cL1LNM7IsQeX1u/4M9ga28u25o4PZp9drsrxv0EFABK3/uv9LjJ?=
 =?us-ascii?Q?PDinK5HONprFSfiQeEv0OhA3N3aKjTkeSEhK+F0zdbaDeZtDKS+PFAcHwcXy?=
 =?us-ascii?Q?07fd6FV5IsDS4f65wzKl6LTi/kbLhTHmQC64sIyfnuRP0uMGlhcYPua+QKX+?=
 =?us-ascii?Q?SW1ys5X6fHpRIUqVqwCySqR7l2jFNNaNNgI2n3KRiUwBTxPUYs7p4l677Xx8?=
 =?us-ascii?Q?rZhRoXNmv1vJpMlD3WhpsC3KeG6UTtM8O2xqYXAvYTJ48r68QUD9d7OwnF9G?=
 =?us-ascii?Q?WlcDoI96GtAsXHd8HGfYTx/yuze4W/AUOsevJx+BH14UDB0RL57tDWuqO1UE?=
 =?us-ascii?Q?DNzu0Qelq5XVTaLK82e0DDy5+Cclzo+H4ZPzAPO2kfyk79Qdc/ZJET7MlPs0?=
 =?us-ascii?Q?1qGuzPUfTGfccUFzSm0mCV54GtHvyV23vXJf8uOjgMCmYpwPEQBFxLZbxRd9?=
 =?us-ascii?Q?+T9zKCoAgKGZjz8WP5LUBNtSfizXXN4BmzeTidi6m5YwEE8NBmZhBgJ92EXD?=
 =?us-ascii?Q?GXQE2apDmHJzh5UqoNjFrFymljw7bLiBZVicHdXeFMzpWt8aRje1CFDhumL6?=
 =?us-ascii?Q?QuNWzgjP1dr4V6a9gS+t5V9Z6YSdOtgQ8+pd9PEzduurpzK5vRGhRqrxK05i?=
 =?us-ascii?Q?r9Hnx9blmNX9iSf+XMvy09yM9/M0zB3RpxNjjUWSgnVgP+lka9e8nbW65Wj8?=
 =?us-ascii?Q?WTyBRssTzReZWiHvlt1YYpwv3a4WsVF145fOPIqSR13Zh6ooJRrA5sEdCTbA?=
 =?us-ascii?Q?8xREizGwWocXScjgjSyKoF7nQNtY3qB997G+7NAc76J5puv8TVnIYKIEh+z2?=
 =?us-ascii?Q?zQL2cvAxSDlThv10Lo6/UHsQV7SxKzdi3GNzixhjbWQQmV9tPAymRMPin2vB?=
 =?us-ascii?Q?YVYh2cp6SPuiltlksxK0+pCE9+ZevFKuvsiijEvhxTnc8r874YXIiHTlByhJ?=
 =?us-ascii?Q?qvB430xktTYisRP17Y36mUlta7o5ghDghBnn4v/piKxiW2PhpYuDqBSEpKXC?=
 =?us-ascii?Q?Nl1VyviwA1C+e2s81rpsnkjslzRWYZRyUAK+z75+Wx5dqnLYxM8bVQFvSJ8z?=
 =?us-ascii?Q?iVQtYQH/Kd0JyKSEki0dvMW3LP6aK6OCWzLZFHXQfYZ4MrPxS9oK0gj7w8Vr?=
 =?us-ascii?Q?Ty3Kugvk3qDzf07xgP0MVoW/fUHPpBU0QDk9spsmJX5ZfbMBQol6G7BeGslH?=
 =?us-ascii?Q?IfggJMss6ucFIRDnaRTPVpKPe+05bTDAnxy0mm2ZGhO054tZ7kK/5IfaRlec?=
 =?us-ascii?Q?Js0Umh0Ogbsf2a8Grcxz1jdQsKAYREmWHPqonMnEuAIUF+jBVi5V/BnehoFM?=
 =?us-ascii?Q?jOd2Yw1XPhl2YLMRw+BqANd9ZrGUwLPKpc32TFbROVWlGPYbm9b5pIM2bFR5?=
 =?us-ascii?Q?8AQMmf/RMhTjuDq5co1uWiEBeNGTT4N2dn6VObhphUm/ardD+9wVCWCGHwo1?=
 =?us-ascii?Q?TPtBtot8XTZkFTat8T9ps7FGHPtfs8BkRxgYXZKi7VpPdENosbSIFlA0oJEn?=
 =?us-ascii?Q?RbB0K8vl1tKSfNCxRx0m4z9EnISN1bLVAmwYiA+VlHtQvW3HLxkEXuRmTfDP?=
 =?us-ascii?Q?ATzAYV0Gay2/xzLeX2WROMBt3VBw05qqINQjZsgti55xlz2voB3YYCK+vfxY?=
 =?us-ascii?Q?Ce6JvZj1cstRum7uN9hfUOdwBQbe3FxT1O3dxCGMyr8eNRcwrPp8LjX9mQ10?=
 =?us-ascii?Q?njuLgRKiJWhPPZA59OfRzUBXiqbQZA4MCoHY/0GRQo66nRi+Ic4k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19749e33-0ed2-4e6e-5dfa-08debce80877
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:29.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tc2GFQcS1qEMQ+1rOuwfNOGwp/zyCZQCEGjU4f399Zyt8Q/60ZuB32VMy2PiEPOG/h/szipm3VhUxO9zg2CODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21437-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9776C5F6602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
in printk-like functions. In some cases, it makes people to create
temporary buffers for the printed cpumasks, where it can be avoided.

Get rid of it in a favor of more standard printing API.

Each patch, except for the last one, is independent and may be moved with
the corresponding subsystem. Or I can take it in bitmap-for-next, at
maintainers' discretion.

On top of bitmap-for-next.

(Apologize for the bulky CC list. Feel free to review only relevant
patches.)

Yury Norov (16):
  psci: simplify hotplug_tests()
  arm: Use sysfs_emit() for cpumask show callbacks
  powerpc: Use sysfs_emit() for cpumask show callbacks
  x86/events: Use sysfs_emit() for cpumask show callbacks
  ACPI: pad: Use sysfs_emit() for idlecpus show
  cpu: Use sysfs_emit() for cpumask show callback
  devfreq: Use sysfs_emit() for cpumask show callbacks
  fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
  hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
  RDMA/hfi1: Use sysfs_emit() for cpumask show helper
  nvdimm: Use sysfs_emit() for cpumask show callback
  PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
  perf: Use sysfs_emit() for cpumask show callbacks
  powercap: intel_rapl: Use sysfs_emit() for cpumask show
  thermal: intel: Use sysfs_emit() for powerclamp cpumask
  lib/bitmap-str: get rid of cpumap_print_to_pagebuf()

 arch/arm/mach-imx/mmdc.c                    |  2 +-
 arch/arm/mm/cache-l2x0-pmu.c                |  2 +-
 arch/powerpc/kernel/cacheinfo.c             |  3 ++-
 arch/powerpc/perf/hv-24x7.c                 |  2 +-
 arch/powerpc/perf/hv-gpci.c                 |  2 +-
 arch/powerpc/perf/imc-pmu.c                 |  2 +-
 arch/x86/events/amd/iommu.c                 |  2 +-
 arch/x86/events/amd/power.c                 |  2 +-
 arch/x86/events/amd/uncore.c                |  2 +-
 arch/x86/events/intel/core.c                |  2 +-
 arch/x86/events/intel/uncore.c              |  2 +-
 drivers/acpi/acpi_pad.c                     |  4 ++--
 drivers/base/cpu.c                          |  2 +-
 drivers/devfreq/event/rockchip-dfi.c        |  2 +-
 drivers/devfreq/hisi_uncore_freq.c          |  2 +-
 drivers/firmware/psci/psci_checker.c        | 14 ++------------
 drivers/fpga/dfl-fme-perf.c                 |  2 +-
 drivers/hwtracing/ptt/hisi_ptt.c            |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c           |  3 ++-
 drivers/nvdimm/nd_perf.c                    |  2 +-
 drivers/pci/pci-sysfs.c                     |  7 ++++---
 drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
 drivers/perf/amlogic/meson_ddr_pmu_core.c   |  2 +-
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm-cmn.c                      |  2 +-
 drivers/perf/arm-ni.c                       |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.c          |  2 +-
 drivers/perf/arm_dmc620_pmu.c               |  4 ++--
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/arm_pmu.c                      |  2 +-
 drivers/perf/arm_smmuv3_pmu.c               |  2 +-
 drivers/perf/arm_spe_pmu.c                  |  2 +-
 drivers/perf/cxl_pmu.c                      |  2 +-
 drivers/perf/dwc_pcie_pmu.c                 |  2 +-
 drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
 drivers/perf/fsl_imx9_ddr_perf.c            |  2 +-
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c    |  2 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c        |  2 +-
 drivers/perf/marvell_cn10k_tad_pmu.c        |  2 +-
 drivers/perf/marvell_pem_pmu.c              |  2 +-
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c |  2 +-
 drivers/perf/qcom_l2_pmu.c                  |  2 +-
 drivers/perf/qcom_l3_pmu.c                  |  2 +-
 drivers/perf/starfive_starlink_pmu.c        |  2 +-
 drivers/perf/thunderx2_pmu.c                |  2 +-
 drivers/perf/xgene_pmu.c                    |  2 +-
 drivers/powercap/intel_rapl_common.c        |  2 +-
 drivers/thermal/intel/intel_powerclamp.c    |  2 +-
 include/linux/cpumask.h                     | 19 -------------------
 kernel/events/core.c                        |  2 +-
 lib/bitmap-str.c                            |  9 ++++-----
 55 files changed, 65 insertions(+), 92 deletions(-)

-- 
2.51.0

