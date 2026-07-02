Return-Path: <linux-rdma+bounces-22695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZfekGcGIRmorYAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:50:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDF06F9ADB
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bpchKJYS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22695-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22695-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51BF930B12A1
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D6334688;
	Thu,  2 Jul 2026 15:47:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90E433E93;
	Thu,  2 Jul 2026 15:47:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007268; cv=fail; b=E4C40LC0QViKcPdmSkZd0xmN/aM2GF5eK5Psq91KN3Ul2kXvQ4RIv2FNeWl9RmqUPgBefaHJF0P+5wuy0hVbOtzZUPaIX1tM5t3bPZxqmNZ+mE7rFHs+okCZ21TNpBDgzsRCwOqlhUrJVOgiR5nzjPgTk5EWc+RzRi6pyagJ34s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007268; c=relaxed/simple;
	bh=s062cu5I1ggN/WMPsbg3niiNHwkRAgEY0B1zPXOHuoY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZbiCREJI2vVKeWa1KniChkliYWQwAI3moXe310s8ZLgR7lmIzzIy0OUMa8wsS7kErQuEnVCUdala/l/jdcNYq/ZE22hVi5Oq14xL8H8YgsBOzM2AQfomkfn3Q6Fm0PtK1a+spAi9tVjEsuEu4K+Up7w2F0kku4eoaLe2vBt10xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bpchKJYS; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/PdDBJthdVOGngUd/gT8li0MDKQFakfbUyKcGv5mHELkEFzhS5crr87tERSXlT3A4sfRvYepjxBWcgjM7wRG3nHcbp9rJ7wGB1KMZBxSxTz1AXnpXVkzkqU4kH3pd7G3oahEPJ+vuQK+1Jd445EJX3CnExfgnwlKbzbYXM+albqbODDMfFm0jA5XKghrxSLUDQBIOofFjG4JbcMDDNgOh+X6ZU/a48/TPozSHbse9VdjTa2WXespymDaoehLhs0AmBDhOCVdCoLb4Ae4fMa5wEIV2jXMTOChHdAD8sgULDn2Rmhg5GL4aeCHqsyTOj7YtKRUX8UgFvPNRDfCXXZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AICvNZ/UItG8ZcW9REzqs1ug4FwXmgITMMXg0yyZDtw=;
 b=qixfb7NczB+LuLcMoiHniE1kjfnYD61HCNVaEoOh1upJGKwtkcnXtIiD17dhUVspRcVtMalSRBPKDfxk9jtKpO0ksVadUYJSxp4rFTyTWzYUpNi7mDz7tOKHIq3wh3QxLztCgBYZLB/3x2CpiaeqkKNn0WZywX7juKaDyHR+ExnnBw0PeB7jGs9/Q3l17mugV80TH0Xtqiu3KjCL5RdxTKs+5W+ErWAZc7AwYS7I43zM/vTgm0Tpn3sKT/v6ArnZW8cVvFeFSv/jDg2fSzNSFJMEUGf6vcA+0ZjT9MhwuuuVWK2fwnPOB8Dgx2W+14/9EihptRVHd6BaVX3wc6mJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AICvNZ/UItG8ZcW9REzqs1ug4FwXmgITMMXg0yyZDtw=;
 b=bpchKJYSRGMSmyYdKLAV/RSCDdDhl5fIIGrylKZGiT6g5aXi1SNIz341KmoYMYfF1eMCskLqH24SecKK5KaXc91ze9c/y99jzLhi/TwVmjaaAwY95TM66HtC7IhgaDpr7w1FwTjp01JfQvQzBEo7WPSC/XeqLOOziZRsVf+LbVL9tteXSPeaKRp+Up7M28voks+bY8UQre9K7M7gk/Lg4Mc8RL+O7tm9n1eBYVnKbdMz6+1lq0rtpTgpLxJM5z/SL9g4Gs9KwbemnqD26+tLiuRCZkO7mJRDX3mcKygMD7+gPC0p9hV3ZQCc4AV+9KiSW/YV5X/GPIwGXhK7t6wsZg==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:29 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:29 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <ynorov@nvidia.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
	"Frank Li" <Frank.Li@nxp.com>,
	"Sascha Hauer" <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>,
	"Fabio Estevam" <festevam@gmail.com>,
	"Madhavan Srinivasan" <maddy@linux.ibm.com>,
	"Michael Ellerman" <mpe@ellerman.id.au>,
	"Nicholas Piggin" <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Arnaldo Carvalho de Melo" <acme@kernel.org>,
	"Namhyung Kim" <namhyung@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Ian Rogers" <irogers@google.com>,
	"Adrian Hunter" <adrian.hunter@intel.com>,
	"James Clark" <james.clark@linaro.org>,
	"Thomas Gleixner" <tglx@kernel.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Chanwoo Choi" <cw00.choi@samsung.com>,
	"MyungJoo Ham" <myungjoo.ham@samsung.com>,
	"Kyungmin Park" <kyungmin.park@samsung.com>,
	"Heiko Stuebner" <heiko@sntech.de>,
	"Xu Yilun" <yilun.xu@intel.com>,
	"Tom Rix" <trix@redhat.com>,
	"Moritz Fischer" <mdf@kernel.org>,
	"Yicong Yang" <yangyicong@hisilicon.com>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	"Leon Romanovsky" <leon@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>,
	"Will Deacon" <will@kernel.org>,
	"Jiucheng Xu" <jiucheng.xu@amlogic.com>,
	"Neil Armstrong" <neil.armstrong@linaro.org>,
	"Kevin Hilman" <khilman@baylibre.com>,
	"Jerome Brunet" <jbrunet@baylibre.com>,
	"Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
	"Robin Murphy" <robin.murphy@arm.com>,
	"Jing Zhang" <renyu.zj@linux.alibaba.com>,
	"Xu Yang" <xu.yang_2@nxp.com>,
	"Linu Cherian" <lcherian@marvell.com>,
	"Gowthami Thiagarajan" <gthiagarajan@marvell.com>,
	"Ji Sheng Teoh" <jisheng.teoh@starfivetech.com>,
	"Khuong Dinh" <khuong@os.amperecomputing.com>,
	"Yury Norov" <yury.norov@gmail.com>,
	"Kees Cook" <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Aboorva Devarajan" <aboorvad@linux.ibm.com>,
	"Ilkka Koskinen" <ilkka@os.amperecomputing.com>,
	"Besar Wicaksono" <bwicaksono@nvidia.com>,
	"Ma Ke" <make24@iscas.ac.cn>,
	"Chengwen Feng" <fengchengwen@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 00/11] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Date: Thu,  2 Jul 2026 11:47:13 -0400
Message-ID: <20260702154725.185376-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d99e3c-819b-44cc-a1ba-08ded85138b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	UkLVaXFIyWDDxFZqLLpjoohmKtQ+dXPL/UUWMk4YTimY/K3nRUFOoEBpmdsaRuwddKCcNDcV3y0tysCetfxa/CHHJHTaoZXXUUicKrN2V2pEKZgW5QK2GAXhEdzuNAsubDcqEk8ff2/moYbmhAmZixVCYFMPVJ6zBJkdMqBr3wG+RsukCKEr7MNEUGeBZRBHAPxEzE5rtsbR003LZEwx7+CPK0mtPMrsjEXSr421p8oia1qKFH27h8pd4A3l8dB7zev6K14s1ikvk8REte7AqbvbbiKajq5+POOcfUDwfupkJlHoMMgSHcCqMg8NQBMynjGJdG8blQ+/xU2DmNjTqsQhHkqbksW9K8M86RybSzpdGcl/3AZEgMKt9RaXAIC/oXD5MggM0rahBJgeURmqAWJ1QrHvgewn8xubnko4QcoyrGFqIaEAokBnrS8/NP+/tVzya/1+pirm/9MIGXRuJAW0fNn1IyruWF1JqzNSaIaGGm7XQGqQcHe9lt2SCrnLod40p07a6zznYElbq+hcWefOvBCOgRxBVCYTGRPcb44btG4Rs1zE0MEZ5Jvc7WApBX4foAuZjGZowWuztQllNszZQtB6bVJufLCkJOiByZzHxUjSc19LVf7KG6atg1H8lDdvSpwLghiIQIp3YvNkHKbTMyXqxkpf2DlzG+2bq/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfgfxSqlHa5jrOiaHggTE864sB3n20VIyYet/OaZuROuSkeTCvQWkFt4a/Bp?=
 =?us-ascii?Q?MovKPH2wknzTWnIQhL2ZQVWKy0pN6ETZD8PAAuQltE51ov1s/aH9Io6uKYJg?=
 =?us-ascii?Q?fY9wirVX0IfIlAE4fpVRKqu5AgSkmzRfhguyS6jZJLIa7hAVOsYK2lAZFuI6?=
 =?us-ascii?Q?TZfJGtq9utWs56vH/KI4voEI+LPY7yv2BBuHeZ8x33/SQ/54xiAAvFDyTXBR?=
 =?us-ascii?Q?SdVLB2I85c20gIQxQZsnsy1PTyb7Y0tmuzNwf1bvB86aFtgPIlVKxtB1Ovpc?=
 =?us-ascii?Q?jTgtXN+U3lzl7XOzL5g5f8y01X6By3q5iWqitD49lE7MlQbJiGKKp9y98vcj?=
 =?us-ascii?Q?mMsA1soOZYUO/lRNx2l41/iXR+lH0QWBqrJtwIVodCS6IAkTsnmGIT7PS68x?=
 =?us-ascii?Q?deSAALAwJxZtW3zGo6zWwlWOKfqUqF8A2TsvN3oB9+fszydg71C31rfuFYCg?=
 =?us-ascii?Q?XpNahPnn2m5X1b75VUDbwHy3vuOktzeQTt3FipnLPTY7/HRhF1455LRBNKdM?=
 =?us-ascii?Q?ExSkrTbUyx4u5ymZEAa1z+FEDe6RqtWPdmcqg/w23TF10l162UhyHOsbJ6tV?=
 =?us-ascii?Q?D0/9suvBfx13qTrTsoxGvmyeMyNQ5teDvgsyZaz0GMg2UJmVS8F/Vgmc1k1S?=
 =?us-ascii?Q?twAnKZZBVtIvZ7dZMlN1+2GGuC9IsDSBB8G5nnVQC5bvRRXDY8QF6qij3Mik?=
 =?us-ascii?Q?JSIvgARuoiXY3z/8xO74EqgPNA17w6UcfgFwI9SE/p+0DJfPaHVGW8HzXyU/?=
 =?us-ascii?Q?ZYziUW8Twn++JxPwZ9z0tdFSjFs5nsDyhh+W9h6ZgCA98PDfD1Ca49+VPYYL?=
 =?us-ascii?Q?RMV0g1HqmaKbcc1LQnWMh4cQiWcpE4kBFM+VSi+dzpNP3SrooKPhJFqTpFbg?=
 =?us-ascii?Q?S2b2AS9cWJ9ecNL/6yNoRGBZ2yYqHUuG3f/NgW979DiroN2KtDH7VLD20oST?=
 =?us-ascii?Q?X4l4GpN8sG4OLVR433gpqCsEfIzeVQxNxc8KTb/PAsK+4Ugt+mqEsreyqmUV?=
 =?us-ascii?Q?0fhNS5WEFnBSvx4h8GDEazBCqBrW1HfFE0JgopGPvi+EpCSiPcQTmOIA29ZU?=
 =?us-ascii?Q?1nQWdAJYrlyn4uk9VZSiBgBpq1ToK1F6W6EO8YkYi/ys+BoHgXVigsCsTs0C?=
 =?us-ascii?Q?ap7VEYy4U500blm7hv07e8YSBbIsLbxSq6WTm57f4WlYOHkhOziHja5Cx/dy?=
 =?us-ascii?Q?AMMyXzpYxIkivV1847YPB9i/GCTLNiEukBqajPg7UAgz8hz86nn515n9y+Uf?=
 =?us-ascii?Q?ABbjWTNbPPktfLWKQceRRO9IMGc9rlN6IQBa/FvAfKRgsjKGmyc1h96JsMSq?=
 =?us-ascii?Q?G9nxYjG/iO8PK1f97g8nuZ0TyJAXUJjX/lcMeHVhYMeSoWOEuxDvkLWGs6EX?=
 =?us-ascii?Q?UE6shyabNyHNcYSY05zihVtSbm5epsC3Q48CjxEBF7ojRdsgWTkI4nrihLHR?=
 =?us-ascii?Q?Q7Zf9i+C++TviiYROWkNnVJ587Dmlq3nDzCkfCEE8yVC6pQCq71f7eD/Ydi6?=
 =?us-ascii?Q?Kx8rIH1pZMK8+zx1A4ugxYG+9+QsGPrhTDOUJt+xyBlTI2pZkClBpEWmLO9Z?=
 =?us-ascii?Q?eEd4c1PIEPo8ZD6LLssOilju6Wz2gNSnN3K5b2QOagyPvYmByj2PaUQM4flC?=
 =?us-ascii?Q?ztdsmfsu/5PKb+ZFF0n7zZV1sVjBzFkr9ycPIQZ17BuFWQMXIiNfojEGZ7zX?=
 =?us-ascii?Q?SA3q6Z29bgG1RZLvxN28JrL8mCREWu2JVTC0zd2TITXVjeOEb+Ha8w2xzl1E?=
 =?us-ascii?Q?GnE/gJjeKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d99e3c-819b-44cc-a1ba-08ded85138b4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:29.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I2kRT6m09Fl/vYzMOlAuaAr103xjjoO034L6S5EcyBCjB+b7WJn0eziXgrTMlyxgHjEdm8fJnvk7L1Ue5WPyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22695-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux@rasmusvillemoes.dk,m:ynorov@nvidia.com,m:linux@armlinux.org.uk,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:rafael@kernel.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:cw00.choi@samsung.com,m:myungjoo.ham@samsung.com,m:kyungmin.park@samsung.com,m:heiko@sntech.de,m:yilun.xu@intel.com,m:trix@redhat.com,m:mdf@kernel.org,m:yangyicong@hisilicon.com,m:jic23@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:bhelgaas@google.com,m:xueshuai@linux.alibaba.c
 om,m:will@kernel.org,m:jiucheng.xu@amlogic.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:robin.murphy@arm.com,m:renyu.zj@linux.alibaba.com,m:xu.yang_2@nxp.com,m:lcherian@marvell.com,m:gthiagarajan@marvell.com,m:jisheng.teoh@starfivetech.com,m:khuong@os.amperecomputing.com,m:yury.norov@gmail.com,m:kees@kernel.org,m:thomas.weissschuh@linutronix.de,m:aboorvad@linux.ibm.com,m:ilkka@os.amperecomputing.com,m:bwicaksono@nvidia.com,m:make24@iscas.ac.cn,m:fengchengwen@huawei.com,m:ritesh.list@gmail.com,m:wangyushan12@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-perf-users@vger.kernel.org,m:x86@kernel.org,m:driver-core@lists.linux.dev,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-fpga@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-c
 xl@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[81];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEDF06F9ADB

cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
in printk-like functions. In some cases, it makes people to create
temporary buffers for the printed cpumasks, where it can be avoided.

Get rid of it in a favor of more standard printing API.

Each patch, except for the last one, is independent and may be moved with
the corresponding subsystem. Or I can take it in bitmap-for-next, at
maintainers' discretion.

On top of -next.

This is the resend of:

https://lore.kernel.org/all/20260528183625.870813-1-ynorov@nvidia.com/

Except the patches merged in 7.1 cycle. I'm going to apply the material
in 7.2 unless explicit NAKs received.

Yury Norov (11):
  arm: Use sysfs_emit() for cpumask show callbacks
  powerpc: Use sysfs_emit() for cpumask show callbacks
  x86/events: Use sysfs_emit() for cpumask show callbacks
  cpu: Use sysfs_emit() for cpumask show callback
  devfreq: Use sysfs_emit() for cpumask show callbacks
  fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
  hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
  RDMA/hfi1: Use sysfs_emit() for cpumask show helper
  PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
  perf: Use sysfs_emit() for cpumask show callbacks
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
 drivers/base/cpu.c                          |  2 +-
 drivers/devfreq/event/rockchip-dfi.c        |  2 +-
 drivers/devfreq/hisi_uncore_freq.c          |  2 +-
 drivers/fpga/dfl-fme-perf.c                 |  2 +-
 drivers/hwtracing/ptt/hisi_ptt.c            |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c           |  3 ++-
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
 include/linux/cpumask.h                     | 19 -------------------
 kernel/events/core.c                        |  2 +-
 lib/bitmap-str.c                            |  9 ++++-----
 50 files changed, 58 insertions(+), 75 deletions(-)

-- 
2.53.0


