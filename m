Return-Path: <linux-rdma+bounces-21453-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMq9CYyNGGpqlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21453-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:46:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC95F6B21
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FEE6314A1E0
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26A43E49A;
	Thu, 28 May 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeqoXeL8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67215423A7C;
	Thu, 28 May 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993463; cv=fail; b=gI/TZMJJB/CAYCBXsvos6hRZzCR0p8TD9fI5HLzG7Zo7aGZAauHO4+f18YbJpw4mzWqkZBNwqXsWrRd9zlfOnDBj64Irh6zgq1SrJY2Hj4ZSznhvv8TAlTfsRlS9R6tPBfqf8UpaIdcEMqAlKs3pAgzI+kw+5hcUJo+awfeobtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993463; c=relaxed/simple;
	bh=pF5s743zBvTo2xvtFS9DzQr0KbP2TfPwVfUvWFW6+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEoWUEzs17BNi7qbuUfKPqgDUvKIv8FHQeZZxvVWWkNfE29KxU16Yt1r7cavwsu1W8nxNcq3431HunvK9jHouW2YkZy9QMRuVZSWxDNqAd9YUXXoWpCLiKYzjliTiNzpS5xN5rCpspjlE74HHKq98XzrgfEFw6t4IRnCRFsoirA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeqoXeL8; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKHXnmUR2W7VPGTNcEgCjGds49ybDyh5E+020713oo5xe4Rmka1Q2B192CaTpdtmIFl4CA5djhrgSCzQu2AoMy6P3HhaqcSED1mcLBNMlDgE/+soSBGkZ+3hWlG45KpPAlwy/VZmz+OsdhqFLijJZqBoHnuONpEhBqMVOpM3jiN7ykc/rNHXXebNaa4f1jIZn3gOkeH1MvYq/IPlAogCChadr1HgDvlVlq3jb6zyIAIrJ6CLYOins0HPS+2YvUAcS+QMF85saqbUCWKh3YCBAj0tcak/ZP/17QWuTjU0m9A05U8xuAPM9usLeD8EcfC/b8QMmQmIcFbKq4zc/jJ+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN/bgsrICrWpLaMM60zlFci3WLACSKTW0IfzHL6qfrg=;
 b=XBfjuSnBwasJER5le8TqUDa4aOlsEqjVNMl68UNHI7Y9s8KU8IfV0n2cgiX71wzzdHuecox11itzvZ56IWO4tyxxFhpE09qa4TPRNzZ0kz121N5JqsloayboLPz6cYXb0OKNKStw/aYYjQZVn8D+hK2UvnRNKYTO2rYy81xw2Aqj/QV91YXsfiriNNbGZDqVBI60nnILy1K5zOEujs+Q9wMNbepGr8zN2lGzn4tPtFG4VyH2i4h/u/i/mBmXqgUvZuFWWAT6vpdEP/wtuPCGiFfN9iDL/DH2Qgy8b+x7v6g49IOqrj6g4RXkdnChUZAB05pH4bc9qizP5AqFKNr7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN/bgsrICrWpLaMM60zlFci3WLACSKTW0IfzHL6qfrg=;
 b=OeqoXeL8w+T+BnhZAQr41IyeJJLIgTkGnYJDi949v6xtH4mX7QlkJ8vnV5+47+Si8oWZZGM6QPkysDU7Jlnie4TPrDe64GjvkqS+iD/uwZCUNjYm7d8yVT6Myb1Tv7JcukR6KbfK5ND4S2YRPgwnthU17xeXzLSmyWIkg7dQG/89yM1EuU+ADlQc0d0/po+Fm1m0L/5MpwZb9Qv7//1ZGBBwaOshZQhweEtYrbTN/1tt1F0O0xzBS8p8EBiodcoV5735WKGptGeyc2ogaxqI+axawFHvUSDwNxss7tgrjudWb5E9uHzxtrpw4WK06v1V9Mya0A8ApbVLSEd2Aeht2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 18:37:23 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:23 +0000
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
Subject: [PATCH 16/16] lib/bitmap-str: get rid of cpumap_print_to_pagebuf()
Date: Thu, 28 May 2026 14:36:23 -0400
Message-ID: <20260528183625.870813-17-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0a7e4b-8d0a-4da0-4b18-08debce8286c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|18002099003|56012099006|6133799003|3023799007|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	0yxUcvigTQAQf4cq96z0WS7J+a/gS3Xn6CCYSPP/aTLuJUlxK/kk8rIKg5DEn19Oj8V7K96HhcIs+ZDPHhKzVmnKKF3rojnQX5dv3OC6SHFPUpzkDk5+TSa5zdeOk9Mkh9v418BdbBKcePfIj12dU2Z70a6tYMnWyko2XdnkINaE6u5vN/B3TLYbS0CJJ2E1DAHoX4UYiSNlzdbBXTfTQGWObeEGB+7WYX5KrvtLI/a/9aJYvbwexfWbRPyZofQwtRSCxeLOc7emJn1WljikAsnsAHWKTWU4c/0yrcUY12ZJor8m14zn5HY7G4kbHVpOj9jQpS+0mmHlhVxDzyHDIlLbMhNPI6r1x7ju0uKTxjhBO8LkAsXsXxSd2w7HNSynzjcyBDmZsd59/Ic85Y3BVpTuGD1yh5jCQ3bVDEr6QgSsloL8xPB0R3HF2zqZL+Hu+ZF0O9aGIei2Gai9mVw7UqHvCJ+ut60wc+DPz5350iHmCdBPhvO4hmmFVuQ8u/ZTwF4Cv9Mp2BLQk8v0ZXpHmKNgbfzshnXXhptSCHRR5GPkHcKqqkxTBSrdmcer/mkOcoS2bCm7JDUdOEzmn3WLA/StL+Vf/pFAvnvEbQbFsXCpg92znkcsPfQtSyzEc6+pWDoHmF+rMFgsDA86wyrWFwvVAgZINTbY5QeFfSYvOrEOC6mulnxF0zOu+UhKVm0P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(18002099003)(56012099006)(6133799003)(3023799007)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccvgfHoBnQLLSR/J1pS0U6yvx6BD6QA0SVTzFT/utOs5jHviWzrqFy8r3nMI?=
 =?us-ascii?Q?CVJgZEwfHK1TF14cCdETc9bF8apW1mXDDGh2GlrRldVAkp31pgSPx7NUbT7F?=
 =?us-ascii?Q?OvtyFxppCb0vrUvQ3fe5tcYjNtDzcvoi6rMAA6aRhDiZvWXJ6KO8X/sFuCd7?=
 =?us-ascii?Q?XubRUfXsxHEV47gcMGk6hDFpiU//XTFGSF2hUKRPPg3Yu2VvKUVn5KYbGR9X?=
 =?us-ascii?Q?e4//2WPsrohAGVxEzwIxP8j9yYDtcIytBYVZNgyDWI9c9HMEkjMpDKR8cORb?=
 =?us-ascii?Q?ChRbLgD5CUDWEDl/gpP/0ezpb98him98rhMPMSXhE1Qdm3D2a0OqVTK+86mF?=
 =?us-ascii?Q?TULXxKfQeoPrMXlmKFz5w7VrqMPjNRigmPLtBCtsqDv5n5URybT/q3Bl/Lku?=
 =?us-ascii?Q?8fCNT1YkhM9JEPtgNogPzjFPz3/Vol5lDb3tQ7uFkVH48e9WB/uP7Vcp34Sr?=
 =?us-ascii?Q?f8S6T8WghgeBdP9LkVChRBxMjBbQxBXWmjNrdUriTDDeFJR/QxZ8ccVoe8Zn?=
 =?us-ascii?Q?yv1S+g4sInobQoydFw6aGVZm+VjozXkvZoxMT+g7bdRElZmOX8nMxmIQE2W5?=
 =?us-ascii?Q?9ChtL8CRADFuTg6bIf5CsPrSfYLg/4AxJ+e4ahFF9QrDipGCi2xzpnP8yfge?=
 =?us-ascii?Q?eLEulVJJ1WZ7tTajZ18X4kM8mqNYoTCS4eIvx4kpU1ss3sWE4zE6XFrPZl6u?=
 =?us-ascii?Q?J7wFc8I1CoLDRj9tTWvd8dLEPeOE/aOjtIHshMjGObl/ZXk61vPQNc6xoipu?=
 =?us-ascii?Q?RKnQYpwgv9KchHiQPpMamiSwz82AZJmpfyyep1qCoUgp+xciaEiEhJaj3Ir5?=
 =?us-ascii?Q?LjP82lhAOL+Cp7F9MDyr6rniwzqz0uN8/zD/zk7XvcMivP3kfs4YdRGvf6f/?=
 =?us-ascii?Q?z9WVe95bV+dDYHhQVlp4iwf4BsU6IFDIw9w63+8ZWN0fxqRSA1aRM/VZ5eYW?=
 =?us-ascii?Q?4D3d/s/Ow76sBQHeThd1xCRpKn+52HeD9ginzYzdT7ayCoCHAjKCyg+A8hjm?=
 =?us-ascii?Q?8VO9KaODkIXuldWjXGljhQ1A9tPx0ZE4C7L4me3Av5979M/DMsiWT4FzPNpe?=
 =?us-ascii?Q?v8bk50J2id9Uo+OVanAyPSp1sgrXf5e9QYeGHBs9tNyV2lMmuPTQPK31YUyB?=
 =?us-ascii?Q?jTq/7j9szKuDrRzZ4yWDLRi7tFP6uETXyA2PH2oTL7rDh/9FdSfilIlkVsct?=
 =?us-ascii?Q?cO/cia4wJpUC1vfQz9nSJppIcCp315hkMDv77K5PWuqNlZEyaRxKedsQKDDc?=
 =?us-ascii?Q?56EY6zkOjDYsjFbd19WtDiaFxsVWHeZBvUoUIefwBD8abPV/FIbL37uzovbY?=
 =?us-ascii?Q?j1TG/YbJRKV4PlVeSqYVxSgL8si9lFxJ9EuCgUqHMDFqHR/DKefpWxSbhiRf?=
 =?us-ascii?Q?UivrGptF5KJlRvXlx44otVz3wzub6QwmstYWsrUtERuAdWE/L/XPhrffw2ak?=
 =?us-ascii?Q?QZz7nHcO1B++vxTnO9WljfN3Ps87t/hZ4LNnB71Xxr+SC3tpMmebyTOO9iXT?=
 =?us-ascii?Q?LuV2hGmQHLmBRs/YwmJtG3Lb/HrP61CyvRUGZvqT6kTYY3sEl33MOeP/2jMD?=
 =?us-ascii?Q?mGO7e+NS+hRQbsU4HMrEHyVp1e3aUPD2j7+sHFTTQYibi1udocC7KLghT2u8?=
 =?us-ascii?Q?PtkFYGQ0uRkS+2AwoKYBozEGPhjaHv2sefosB4/r8uzp6JfSeBGhh1AGVx3f?=
 =?us-ascii?Q?mQRdVvO7UWhtt9/MAZgl5n+TfCpYm85PTAuaL5FnOS7ASuGH4QOrBztJtG++?=
 =?us-ascii?Q?PSubPxTGCY/1WIAg4JK1/PmiejLVNbjkX8tvFthe0KVCyXj7hQYN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0a7e4b-8d0a-4da0-4b18-08debce8286c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:23.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIGgcj+twIC1Rv9I++JAGp60jRaiM+8zrwaHSQ68Y3xJphvCxe/jOB960xdg1Ymc4u1icfQ/9Cd5yUkn3YN8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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
	TAGGED_FROM(0.00)[bounces-21453-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: C8FC95F6B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all users of the function are switched to the alternatives,
drop the function.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/cpumask.h | 19 -------------------
 lib/bitmap-str.c        |  9 ++++-----
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d3cda0544954..4c8bb6953107 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -13,7 +13,6 @@
 #include <linux/cpumask_types.h>
 #include <linux/gfp_types.h>
 #include <linux/numa.h>
-#include <linux/sprintf.h>
 #include <linux/threads.h>
 #include <linux/types.h>
 #include <vdso/page.h>
@@ -1315,24 +1314,6 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 }
 #endif /* NR_CPUS > BITS_PER_LONG */
 
-/**
- * cpumap_print_to_pagebuf  - copies the cpumask into the buffer either
- *	as comma-separated list of cpus or hex values of cpumask
- * @list: indicates whether the cpumap must be list
- * @mask: the cpumask to copy
- * @buf: the buffer to copy into
- *
- * Return: the length of the (null-terminated) @buf string, zero if
- * nothing is copied.
- */
-static __always_inline ssize_t
-cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
-{
-	/* Opencode offset_in_page(buf) to not include linux/mm.h */
-	return scnprintf(buf, PAGE_SIZE - ((unsigned long)buf & ~PAGE_MASK),
-			 list ? "%*pbl\n" : "%*pb\n", cpumask_pr_args(mask));
-}
-
 /**
  * cpumap_print_bitmask_to_buf  - copies the cpumask into the buffer as
  *	hex values of cpumask
diff --git a/lib/bitmap-str.c b/lib/bitmap-str.c
index 26d36c938c6a..dd9aa0635fa5 100644
--- a/lib/bitmap-str.c
+++ b/lib/bitmap-str.c
@@ -75,8 +75,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * @off: in the string from which we are copying, We copy to @buf
  * @count: the maximum number of bytes to print
  *
- * The sprintf("%*pb[l]") is used indirectly via its cpumap wrapper
- * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
+ * The sprintf("%*pb[l]") format is used by drivers to export hexadecimal
  * bitmask and decimal list to userspace by sysfs ABI.
  * Drivers might be using a normal attribute for this kind of ABIs. A
  * normal attribute typically has show entry as below::
@@ -115,9 +114,9 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
  * parameters such as off, count from bin_attribute show entry to this API.
  *
  * The role of cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf()
- * is similar with cpumap_print_to_pagebuf(),  the difference is that
- * scnprintf("%*pb[l]") mainly serves sysfs attribute with the assumption
- * the destination buffer is exactly one page and won't be more than one page.
+ * is similar to direct sysfs_emit("%*pb[l]") formatting, but the latter
+ * assumes the destination buffer is exactly one page and won't be more than
+ * one page.
  * cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf(), on the other
  * hand, mainly serves bin_attribute which doesn't work with exact one page,
  * and it can break the size limit of converted decimal list and hexadecimal
-- 
2.51.0


