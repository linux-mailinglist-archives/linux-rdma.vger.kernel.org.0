Return-Path: <linux-rdma+bounces-21441-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK93FBCMGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21441-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24B5F67F5
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E07930C0C2F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899B4219FC;
	Thu, 28 May 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aCpYXHhj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E53F6C2C;
	Thu, 28 May 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993416; cv=fail; b=ewCdelPRWsl68eRByJuzJQUMJDHm9LhUav4xYxljzlZfN1BgGYAb7a7zG/JasIfqDXtsYumHNDsICJ/uGNIg68xx+HZ6Pxj2/kn4Yw/j7us+zizOqKrftwZARRMQmBPOwsXoDhIfc+dNpMp+Vw9raBpyhKBl0fITU+1XgpCi8Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993416; c=relaxed/simple;
	bh=bMRe90d11kPWZ4t00WXqP36X4LqxnEUNTRosweyIeX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2O6iPojhO29mElVIoqCFaHywYIo0SnBj677Aq6ZnB4YXM6IqP6sBGQcxpwXEi/ScbdVraPMkCGi9PaPlRMlKNzbkSdQUnAC+EP++k/bH7b866PSW+5ZmPFmMi+k2R8yzX6kgByn74pkRxVB5+Omq6e2DOQizp1J4t9NwDaLOno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aCpYXHhj; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0UhZ1EDwL4d7Mo9ZZlZEVX49KN9KnROxwtg0PDpyyLCqv/KwHIFHSJWoL6Wua+QcuJvvjf8oaMM1aUuwUmkCvBa0QD7m9VNlvhbNu8kZBKhkoY6vS+0pWBFr4aSGA/JqeNOwVtBSY0gds9SJpqcWoBp97IuUcZ2uRyxj+bEdwZb3FfcCyW7MgOTkefZiqf/C3V1LKHzLjCon90fj93hhqT0w5qNxNKS21kDDBq7cE2fmzsgHr9K0VsduySD7kOWtd3pROBg+2woMHiKqFRB6o+qRJVFK2e5ut3IBt/xjKQ1I6ClqDHn4An1Kcy3hvuGPSXUFF3KEA+kPbtgwduEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4PThCApWlGRAc9p0JG18Fzn71NtyAZyXhVGvfC9KzU=;
 b=GjzCUn6WhXn1RjNrVc9xUfsD4Ir7YXMwZZqBIf8ZaSEqlLr+jWQj9ydI8TEg42+C9TyJdJxG78ljqClF+vvIfVIixYNKIlkdd8IriLZMBGrYfNygYjCbGPrf07cdoC5zW5gRbV1DRufhvXv6iipbh8gMgETbADEKFDvcCo8hy2lcZCfGqG/xCKGeBsDnY4UXsKyoi7Ozd1jSyn1pmUjwCtc6Nt6brDhtFTXdZgvViE4IufNdb40u030E7znYMulvrtNobazKhtxCDEn9JKsyE02P5Igy3s+oj2uzEQJB2FVCj48AULWnk6YoA1wXQ26H751VvYYo0Z+1mW7Od+7Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4PThCApWlGRAc9p0JG18Fzn71NtyAZyXhVGvfC9KzU=;
 b=aCpYXHhjDYQq2T25h1204Mi5UI5QZlp3IkCyG3Wt8VhZ1saAu+39eOdcuDwYJPHErI7XeIXNWizsXLMLPAhyq+YwdJJZyLDa2ua2YgyT9qq0mlwoue6//KyYXBvSQf13/sNv+6MybrDT4N+JN+YNxiBWDTFep7b6qxvssQT8LSpmaDyFi8NYDHZdXz3tAcP4Mnmm6V95cdx7LOln1vyZBCIH7H8njH7rng2pR/QF9FVfZrRq5ZWtUPAzEs5l4XtnkoI3b7d9ilvG0wl9H5VkY3ZS+kL+fVwL5eGwtyq+afQHWgt4J3IZn8lqD5nbZJuFnqQo4xQH3krzEp4cyNcflQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:43 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:43 +0000
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
Subject: [PATCH 04/16] x86/events: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:11 -0400
Message-ID: <20260528183625.870813-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: c47e824f-2d33-4259-6b1e-08debce8108c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	duf7c2xyjFoCSMe3KjLB1yPKbsuZwc6Vn9O0GiOJR9sFG9KAsJFYh1JhaYF1xWnv6XA4aXUBTBwoJZ2NcauWmCS47skiBgzGX52uqMv4WNVsgDHFMvIxo//Ik+vj0/WJRePO/J5YQF671glQzzs10JpYAjVzSZ4gnfaawXLOGri/8SjuSPJcUq6LNkYJncTCQ29396mykPOXgG0VzSyU69LdkP3yYjcvR21KcvZZA0exdTHsdWjDBOvI0ruc/YCl2tyrnAVSW+3c2BbklPqgQsbTYlyc+WtESQrAvJayPrtqqZ1Q1BARMn+lMHSKvUELhrMJdEVzKkXxKuMSeRCCtuCs4c+oPO3VwtDDnO5cTFBUztBtn2qukGgPzAhfV75Kfcp4U9IH0EIoPvlmmw/xXWy6G5Fgd/vf3GU/t5ZXYFU10+vttzIHTR04P2F7lzl0WmebqZCJFEfkIWh8l+ei3nQJZDElaVQ0UqNo0t7LDIWNMtKu2Wgl5YTBZu1/Jp+za54+tdKDnQ2C/eaW8J0otYKmTu4RATWMwHvuxaZcEOSSoqYbZUkbISV6cttMZ4B0ePg/1uloxOLuoiY0fr8ysbYUhO/su0sBBxTTGdHe79TXz0yxOaanV6yA8psLpyqET/aoQYsAPXqT7nSfGRAvqWX7TfsbK5WVXBffflTlXuXio+vEVmF50eKL5AyyfDeF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FM6hcIktJ0DeJG2jkAhK4f2k/748Dj9E1U2YL3QO9MmIivgBeLwtpuY6EdWJ?=
 =?us-ascii?Q?xrPCt1L5JQ1LZJmhlLUs8MYboNCcp2HekTgqxLwqhu8M5GVf5GUh3IRDlYKY?=
 =?us-ascii?Q?T+mA7XsyQ3Pa7juscThrAwlRJLytu+I4VQU/IOnoeM/QR9ZWqKNQVWup/0he?=
 =?us-ascii?Q?O+Dq8dtNyyuqNSXAtuD5ptQPhrFN+zgaJthHnErviTs4sn9O9LAE7KRlKM3B?=
 =?us-ascii?Q?PwujN0cnqwFM963QVUdaPcN28nsv0DmUag5J7/xMsWS7KZAPwfFQq0ngZSqS?=
 =?us-ascii?Q?fQf2FNfZqGlr9hn6IbUEYy2wLYVP+7DdhAwgnjlp0YqIWwIW/CcK906kJ5KB?=
 =?us-ascii?Q?wCXjuVbAKeddlXRdJFkg9K3khrAaBxo1nZo6CgXm+0SxxbpDc7VcCh5sjeDP?=
 =?us-ascii?Q?5Wub0HZVF2h5oE6h/wsboMR4bWnGabAMd5YJVI+O4CvHzaV+sCO9Stou/o/G?=
 =?us-ascii?Q?yVyFzHqgdh5O52OryF1BUu8VFBvqC0I2J+p9teF5+EzEwXeP50dpl2PPwO7B?=
 =?us-ascii?Q?xZiKeJjzmTre411LzQAT3rcA0Qi9ZfuYY6UXOqNKYLXnlOppnfelYlL6G9y9?=
 =?us-ascii?Q?H2vfSqf4xY1DQ4HMKxhyRMySOLMFLV7gzF2du/RCSr+nXVFGY0T4zcvspGcD?=
 =?us-ascii?Q?SY3TbyHI+daztgb12V0588KRCQtY9j7YQLHZ4yTNg6gRm0f8cxfyk+cSUHBs?=
 =?us-ascii?Q?yikx9rQbzj4k36sZ1KNFV4lWpAxYDcvPaQ5OzZ+0PwWL4i/dkZ0zwP0a7hN8?=
 =?us-ascii?Q?Vgk+bH/MIV9XEiScOt2etcRfPdLCLoz9hAf8W7xNSZ8K4s1xsMLbu4BD3SFF?=
 =?us-ascii?Q?Km5/auhfJyDRSqoD2FxEDFiFgFZLtjl1+64dt71RWK08eVZ4de8GOvWwa+bc?=
 =?us-ascii?Q?mkMwi8ci5fJNzpOenRyKM/fR31qencIU7xdZojDDg9FFq5Yg2EHQzpbmBcUl?=
 =?us-ascii?Q?sHoKTQtRmsXWuYhwn/Y2ThWaDsKbWkJNqMUKrH3/1SAND6RAINNyLPDZEfUC?=
 =?us-ascii?Q?lpzfGF2tTcsFUTRIV1GEiHYJRYyU/NyomreKdY1zFaJeCCg1aDbboRtEhC6g?=
 =?us-ascii?Q?aSJZImDfiGie/yvguYACgz1dcfJigQfJoyK2xeRCEJ7Y+sBbW3CnZvtr1kK9?=
 =?us-ascii?Q?+ih1h4WjZ/36kvOEXtAE09lIXpi0Aw2SwjNYgaOn2a5t2qtqzlKoO8MPHBPK?=
 =?us-ascii?Q?jd/4X7n3IWKbzUSX/UOzbJ2e1XcWFHHNAJRphIeyW1ENPnjuKFzRQTRrTvoj?=
 =?us-ascii?Q?WaMMR1UMGSjZMjJpl3TDhOjJbAOjjHwS+eRfaIH56lguvd6QXm75/u/H+ZrZ?=
 =?us-ascii?Q?PE+XRPBtFdIq5Zr4GOX4Svx4TE+2ooQKCp2FBVRBPWYdJLfCwpb+FzFScfr8?=
 =?us-ascii?Q?vw7OCsMQ2lvOyh3BKMXInFJgRodyvWJNrMnBRVfqpt8scgCeN3CPBc26/Y8w?=
 =?us-ascii?Q?xfsr776mNNECNBoG4efMT63jQJafOkHppqCt3VZvUhXZdZnmdQbva+iM4dzU?=
 =?us-ascii?Q?k7IkoCY86vuTAUtd8W/hNZRTg9Lyahue12jiXWsaWngvgNve3VF2+/AeJ20+?=
 =?us-ascii?Q?r1lBKflIl2iCMfqtMa2WO9k71JgI7OIOZ6z3H5ry4YdK7GbkEYN8Ie4QQ/FN?=
 =?us-ascii?Q?P0+ViuR0O+1P87r51cgN+2Z2dSEOgsn8rOnhwAH4fqRymsIe4gZXPcB9Rp2v?=
 =?us-ascii?Q?3sSwDZ3kiHaUs2guv0Y3RfglyV8zNYQi3Ew9MEBjqv772rhE9hGEnbETCE15?=
 =?us-ascii?Q?z6D7BBNNDVFfJOOXK+aoTXM36DjS8lNxCP8mK9YWMvndc4mXmfcV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47e824f-2d33-4259-6b1e-08debce8108c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:43.1094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmJkTAlihcDGmbV7ROwnXfyZX1PUvU9u/IiA255rgZyRZFsJOcPssrn1orugI43hlGCI38b1fphOG5cRXRQo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21441-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE24B5F67F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/x86/events/amd/iommu.c    | 2 +-
 arch/x86/events/amd/power.c    | 2 +-
 arch/x86/events/amd/uncore.c   | 2 +-
 arch/x86/events/intel/core.c   | 2 +-
 arch/x86/events/intel/uncore.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 07b110e8418a..f332c7089bd5 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -137,7 +137,7 @@ static ssize_t _iommu_cpumask_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &iommu_cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&iommu_cpumask));
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
 
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index dad42790cf7d..890609961a6f 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -147,7 +147,7 @@ static void pmu_event_read(struct perf_event *event)
 static ssize_t
 get_attr_cpumask(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&cpu_mask));
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, get_attr_cpumask, NULL);
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dd956cfcadef..797dcce8bd89 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -321,7 +321,7 @@ static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 	struct pmu *ptr = dev_get_drvdata(dev);
 	struct amd_uncore_pmu *pmu = container_of(ptr, struct amd_uncore_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->active_mask));
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, amd_uncore_attr_show_cpumask, NULL);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dd1e3aa75ee9..5e9b65b2d1c1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7311,7 +7311,7 @@ static ssize_t intel_hybrid_get_attr_cpus(struct device *dev,
 	struct x86_hybrid_pmu *pmu =
 		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->supported_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->supported_cpus));
 }
 
 static DEVICE_ATTR(cpus, S_IRUGO, intel_hybrid_get_attr_cpus, NULL);
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e9cc1ba921c5..746d0d526f1d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -842,7 +842,7 @@ static ssize_t uncore_get_attr_cpumask(struct device *dev,
 {
 	struct intel_uncore_pmu *pmu = container_of(dev_get_drvdata(dev), struct intel_uncore_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->cpu_mask));
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
-- 
2.51.0

