Return-Path: <linux-rdma+bounces-21438-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBCTLq6LGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21438-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:38:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0415F66E4
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 518D53042914
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FC409624;
	Thu, 28 May 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EauhGIgl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A54028E9;
	Thu, 28 May 2026 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993408; cv=fail; b=IpGK9IqiTWOS/6FN2RKzv2QAh+LaCPzTbiNVk2pSVbvsLlmzrd2tA8oxOpVQAAUAL4u0SIHoGYA4c9FEa4ppHMkFF5YozQ8jvHEhlwQVKaVFG/rBKukK3f6mn92DJg7oCiou4uBYEHCs4AdY0GFPTabp7mdp1D6x/T8B+g23H0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993408; c=relaxed/simple;
	bh=DgujxR3gShVN1dKjYN3rRbuiiEE0TBcJGlwLVOOjOa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOIEWqDXKJHemKdM6kik1GuPLm2ldFPko47JhG2l64kztX9fMJbmyn8unDGn2rxXRLeLnpu76Rw5DuGP0i9i8HSAzCv8MZKRmjq6esSNGOwB2J3LF+jRG+35rToUf89M6ZLmpOc48Cl5KEwo2z4oOyy4RFJ8JEBYIGR/lLJ80YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EauhGIgl; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOfxfN1ibw9h6u4LEDGPlFX/R28UgHznH6XDjSfdleG1DwkcyFsMlEaGyMdiiZjeogjTyIOI/fCNjnEz2HTC9NHpOgwomLn+Z2p0P3NFfmwRZKX3BhWAdqS2g5CGNtGq4J9YyOHwyWc/YlVzKd2ys7vGINKTBqyzvnMMRELKKii+vyQ4vMEAWGgMGn9i2GP/2Is5xO2fTaagjDGSEZyqxL7hvRV+FVu1ygP/+y7Q2nClEbfAArHEuniIfU4IeiyYWYAXRDtfGBXxdQPCn45ZIqVYNvIsApRy/J6hJDPcORtLqnvnC7b7FEYH0IUYGFzdl3/RKV2a8rsD7zvXcmGiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylgiIxoa3e8e4ig0emG9sOC1BZq6t2kXTmXhSilmt+8=;
 b=u8NF+G0ioG6WpEw7SJ3SYQNZT4syXGSibOPrSHkEhY2EcCNBI9z5aJPcVrXVkL50NhzVBbGLYM5jGlzTKojm/t1BhSLIOpCvav+OP/I2ZDHOMChb7RrgASrObEZ4P4ftmcXjJsoH+WPqSX4XffBCe4roD8U7K+FO91nJcMddNjDvt1YPFVZtS5MQgX+2FxEgczvrKB3eTFtN8ZZo0C/sXyqWRtGZbJNE5JEh+wkFjMwsC93CTMKvQEtxswpAvIJ2NicZiD6QMUyYHjA6hKD3yxUlu4t10IhVdvOqPP+fB0WNtxYc6pfIphaCektbQo6QTa4qVOj3R3X35z62kLeUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylgiIxoa3e8e4ig0emG9sOC1BZq6t2kXTmXhSilmt+8=;
 b=EauhGIgl984TSrWepFekEdzgjMh1bw2D8YbFrR5OSc8nrfjFoSE9nx59nrTzzrLY6R5EvTLLdqPhbs9Pyp2aEb+NrzKwuf7YTcB+G2fVc+NKQzL2R2F/pKLv1JsjDiZfGhxWimuI78d/T79UZrNKGT4baLALMIfykC/sY9hJPHde2gMUflqOMw17np6iYHcO3vreDtqHbFZ0kT1qnplo23P0Ox9fDXZcHKTtg1bfqkttwGhmQe/ivfro3BqBbJCaxwOyZl8nbWEjoSviZki0n/0sWsyC1949cPfiv1hivofDAJyhigYXFKtYa0yq9Fh7hjZkvnNOVntRoIeh1O9Ang==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:34 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:34 +0000
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
Subject: [PATCH 01/16] psci: simplify hotplug_tests()
Date: Thu, 28 May 2026 14:36:08 -0400
Message-ID: <20260528183625.870813-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ea52b1-3d98-4ecd-df73-08debce80b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	gECErUiHdwYoV9qiGjvQsZ7R0Wi/8P436GhjLsDnfBAZMocvDmRYxAFdpEGpGsHaB7g7yaPIldgO7inSd9RmcwXJklrYHdQ/WD60/jpanpLPWELWVHY9CuZ9M1RyiINHlCqv0Quuf3aHn2lrgVGtqpkZ4yfAghBZAdGFU8psOxEurwniCLj7UtpEN6O0+uYtmM1p27nPbL1Bx92jTMTo/mRdo8TKOXfpolClgdFW3HCJ19pkZRhRAjJQ/CieiodC0LT0+D0vgWZZed49Y5JuK/H3bQSS7OfgoKY1JsOiD/Js8yGZVRXv5Tfgnwijbgpep6v5hyoLHF7dTnGLFgPibLwQkQ15Ux2RNCPpOmnuqAg7lUgPby+hCODCIAaojHgxj97XSAYrnuUxOBv+yhpaFh+FqQxdvgOiPlCMXncqMZNr4l2Tbgh6D9cKNgBmsgkbLoedeZcUMg/ECl5wTeGaQkJ31a0cJx1Oxa4PZ8id7XBNP6uBOdPtB6ILJe1AhyxRnmIk5/Kb6GFQnAt26UKf1kWde32AdPL4XL2XjWTffhqsBlYVXezXeQLhDbThlTWcyEyHgqqSoGG/q3gcTpfmjf2clpRNX69zMRTrRfW8awlL2bYEe1j2iHN29BtAAAV4qbUB89XSlWDIYSJGwDcZ4NJt+aE8KWSXLyqHjwSsuzWUAj69Q+6vSGn1UT7AhM3e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASoCUM3zk7XaiWVRdEe2iSI73G6aUIdAnsxsiok+wvWQM2FbjFSkos5k40Ae?=
 =?us-ascii?Q?vKTy0aCevWyRm4359PGCQ89D+cToyKKHbLcMHr07UI+9+Ngxr18AtNviUzJO?=
 =?us-ascii?Q?jL+QpZs4vNNfZgBpltuWZALJpt5qiOzywyRh5V7CkGVckbFAfsJsKpF2f/ni?=
 =?us-ascii?Q?h3YmqJTqLqaghtortsavJPxAoePxc+W/LGikWSX2tPuuJywmEwTBaYipu1fv?=
 =?us-ascii?Q?kPw2SqdKFTOz1CTLuCy4OgQqrA+v4mUX0KIetVva2k3LcaV2EX9gJ059jb6X?=
 =?us-ascii?Q?17pmM1+V8oxo92Qd9qmXtFmbXbpyTYDme7IcblQ5vjjJAUjLwgkuiP7edFgC?=
 =?us-ascii?Q?se7+H6BS3yQYxzbdN7GsqpiRrOQEBsUUb5oq8He2EaSD2gnepM6ONGcQs19T?=
 =?us-ascii?Q?LrMPhvo1AM1oG6EZ1CwH5ab4T2b8BMEOcmHQVib9+81v5ZbIlRl7BJn20LDQ?=
 =?us-ascii?Q?qz6trmSrRqa6/wlSuApMw6Jl7yMvYxKzymq9hEjOZ51m3l0DEOPWFa+3+aPW?=
 =?us-ascii?Q?9geD1pNTBUChsrcuGZmzqgAT+51abwz8zIEIbxwazR5/9MsAQ0I6BLBho2fx?=
 =?us-ascii?Q?mROOgnVN2VPmWRtdElE50AweMxZu/r0bXot/IQ4Hz63LKGvdTIni1vJHONqj?=
 =?us-ascii?Q?+lexjBHB59BT72zUyc3VoI1IjWvUw9RpgXEsmmPnL37JnoKsQ9d54Ovu25eB?=
 =?us-ascii?Q?bIfkcppIvvfdpdQfVUXX5KFlyrg9CJIzFvWuoWu48jmcCCxBmjtJH+mp9jxV?=
 =?us-ascii?Q?2lKkOtUbx1c6CcgkXXvBPxcbpPnakddkuzBkvXayWygSE2QM/7bIAcsQFadR?=
 =?us-ascii?Q?2VFowDqgCmcSl3vmq2k++yT0uo3Vw+2JaT2VonhHhJWqVDQdV/rUfhKti0xp?=
 =?us-ascii?Q?PsVWQqDEYtpqmqVOHufpG2ECpfuSuJkJMYiDYD0yoRVCZzmcb+vfplXjdh3Z?=
 =?us-ascii?Q?NLEfa0ikKvbu7D42t7mW3GF6UfLwjZnAJrjd2/JNjgYukE7vzDEbCEP4WXIU?=
 =?us-ascii?Q?FLXyWrkjOtv8ADG98hDRjRJBomnLUnfFzMjVubV0n7PFjw5VEnwrIkuikB1/?=
 =?us-ascii?Q?+Kxk2PtuFFgNUpW3kJsn8feXvNR1peQjWEp3JZ62V8V8pub5+dLv0t16C5sB?=
 =?us-ascii?Q?N+sYWXNj/34ppurbc4LorcXyhqhTJrF5DhYOjXH00qUkjGkd0Ik7vyWWr27/?=
 =?us-ascii?Q?gO/VzKmTk+c33jG2B1/DNQ72PEQEGgUI1eJniaYzRISk6C1l1WnDVf2+tGJC?=
 =?us-ascii?Q?gwuDGne/sd+7iHthWVMjJfv6Kq1g20x9hiV+0impMCchlCZ2OB2hHd4g3eki?=
 =?us-ascii?Q?vkRgoF64KGL8IWmM9drDfwrMwQJJAgoXwyqmVjtkwHrwWTXauX8uB1U5u/dp?=
 =?us-ascii?Q?3EgziV8X9fOvWfB2hJPmaZDrMoWN/tVcg3jQVCOhQI9kMbY7ho5/lQCgB4V7?=
 =?us-ascii?Q?+kRIkTLhRd0obKM4qYCv05DMgubnrWBjMs/5TZzN8VD9VIrvGFsS8rGZGVhf?=
 =?us-ascii?Q?3uBPY81+Nmbqx09L8EE72RK2Q1zOZX7kdSQIGszbMpCm1PAYlytDxpTAhBX0?=
 =?us-ascii?Q?a0Pe7Ws+ovNXUymbbHzAJ1lrmiqGhJ20tL8IJrSIF8aKBz0BZGOD5Bp1Py16?=
 =?us-ascii?Q?Jyjci5S0PvC3P0kHQCNbXQAh1Oln0c96qxuIc0mWCWj16i03MynvCWwjJozJ?=
 =?us-ascii?Q?YLfGpBNnl78ngFzp/ju8hzySLPgx/+D1DrID3wpTZ7EpfQcdO7oVKmoMGzCZ?=
 =?us-ascii?Q?DtD9PGfIhASDYil/m6GSj4VoT3Qbh6IXdNJp8HlU2TBbEMlbRJdf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ea52b1-3d98-4ecd-df73-08debce80b13
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:33.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuar3oM1QcfwD8kQnGbPL70TBtz9XNIfqitCCbBmjNl/XHy8vi8ZhCNlfFPZGgwtskVQdcd0BYC87oRI3BCfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
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
	TAGGED_FROM(0.00)[bounces-21438-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3B0415F66E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch to pr_info("... %pbl"), and drop the temporary buffer allocation.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/firmware/psci/psci_checker.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index e67ba9891082..ecd745bb90bf 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -186,7 +186,6 @@ static int hotplug_tests(void)
 {
 	int i, nb_cpu_group, err = -ENOMEM;
 	cpumask_var_t offlined_cpus, *cpu_groups;
-	char *page_buf;
 
 	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
 		return err;
@@ -194,10 +193,6 @@ static int hotplug_tests(void)
 	nb_cpu_group = alloc_init_cpu_groups(&cpu_groups);
 	if (nb_cpu_group < 0)
 		goto out_free_cpus;
-	page_buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!page_buf)
-		goto out_free_cpu_groups;
-
 	/*
 	 * Of course the last CPU cannot be powered down and cpu_down() should
 	 * refuse doing that.
@@ -210,16 +205,11 @@ static int hotplug_tests(void)
 	 * off, the cpu group itself should shut down.
 	 */
 	for (i = 0; i < nb_cpu_group; ++i) {
-		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
-						      cpu_groups[i]);
-		/* Remove trailing newline. */
-		page_buf[len - 1] = '\0';
-		pr_info("Trying to turn off and on again group %d (CPUs %s)\n",
-			i, page_buf);
+		pr_info("Trying to turn off and on again group %d (CPUs %*pbl)\n",
+			i, cpumask_pr_args(cpu_groups[i]));
 		err += down_and_up_cpus(cpu_groups[i], offlined_cpus);
 	}
 
-	free_page((unsigned long)page_buf);
 out_free_cpu_groups:
 	free_cpu_groups(nb_cpu_group, &cpu_groups);
 out_free_cpus:
-- 
2.51.0


