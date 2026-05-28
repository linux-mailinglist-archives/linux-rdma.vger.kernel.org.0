Return-Path: <linux-rdma+bounces-21460-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMQsCtSYGGqklQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21460-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:34:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FF5F731A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FC630469BD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A0389106;
	Thu, 28 May 2026 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCUToAOW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BAB31B83B;
	Thu, 28 May 2026 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996529; cv=fail; b=Uu4Lhp/Wrbz4hhn/FqnDA2nj7lXkClaHewRTkaKU4URJcOj4qdkRgxJ7r9IdIC5KVrVXjkIRBn3R5wY/MS73ly/z8SiS022o2LioPyJfg/1Ea6b9FdCVLnSlRhVri/s0ay6Dd58SOvLzMJFfXlCxmJhsaYOqS1434ZzcfqluO/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996529; c=relaxed/simple;
	bh=Aermlfj6IHlUYNv1i4zYE0GaIuq/3I3fWYC56wfZ4ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHiBeNTw7UQj8DKDgG+mozJlGjygSVhW1ZKqDFp/h/6asD+Hzu0lkma+jy7XjlrKCjPPBYJIYwPUiDbPTiCkwdIK/z6Jumc6JSnYQEvPFkaD/hOPSGYvIOXgIDIqVtF/7jOT5/oS8NqihIWu26TyzFVHDilLDF19HwhICRaoGSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCUToAOW; arc=fail smtp.client-ip=52.101.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAmRsTCTrTiwSfg2lzoF2t/j27DoTUY/ruewnRcVBOLK5OcT4cm3n54J7VpPv7Y8pqPlyr95nw2EZlkx4vchLiC+vQN1W7IBqNd5sNZ/+cvH3xE9HD03Saj4d18YsvhOANXkRBwXiH0I2+LD+oJuAa7jobxYcJfwq8gFopnGMMcqJr9uHUsQ+pMikabMuAQNbRbxhMZ2yOprru0kg9jT57NjosuvvCEjVw0XSmGXCjLjUbWVZ3c8/JwdI9Qblb2cHjNNxn9acgFSDgcCLJ3lLdNPb+eVqClSafpmxgrRiv2/KMWICnqlfDYWq6rvfQQmxXa0pIF60J8QVKBV4XcQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnONrL1khUXfJ+PrDi6auGACx8naW9MsiQCrGPgfz9g=;
 b=H8CZ8Hzb6sNKkC28ADxoFEoSPWDgcpYJS9UJgs/DPWN/kia2I21x8C1W1PHXp7XY8W69jnaQV4Zy8vm+CnWp6wBYgMTijHq0rqTMEKWe13GEAtlLhcdbE3Qb5Bns7eE8JNbqHoNBptDFiLay/SMA1ZVGT2gk/9l/wpobs+j9Z9LdVJwgJjuizH1Xhhez6vfcadAyrfal35xNevsai/SEMTSO51erw2SVm5Si5P6SDT/GXsU7TQyB6sz/51I9Lzjj13mKfFlRu4INbawf0+N8IqeNRYCqCuRFhHl4SDG9RASBv0Gy/GJ39L0SA3+c+azfxtjR5dzRJ/hrVeWEeRHjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnONrL1khUXfJ+PrDi6auGACx8naW9MsiQCrGPgfz9g=;
 b=SCUToAOWGVWJCPjbltDD0sfqbDz7f6KidnQO88ZqD637Xtj84C5pgCIs5560PWOIkAGaVJ3+pI82d4i2r2uGHoW9avTQJVTVZJx82goma6czIYaSnRXddykurJ27g0ZrTAxPzvjQ0kixkul2kFutCUFQSqNn9kM3hJF00dNQTkvpHG3NUSxXph+NhWDU6F/ZeyyUOhXtcb0DP6G8HAgtUbx/ecpu17xjoUJoLWzRO8psGtJZNPTblQn+tTtNUdAlgYDVFcPQiHzVvdtQCusoAdbVOUes9ut6RP4I+jph05CSoZ/qpl96W5aoJnydE2q4iLrhF8yemmyJKxPa82p7ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 19:26:32 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:26:32 +0000
Date: Thu, 28 May 2026 15:26:28 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
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
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
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
	Xu Yang <xu.yang_2@nxp.com>, Linu Cherian <lcherian@marvell.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
Message-ID: <ahiW5LKLiPMC6il_@yury>
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e40fbf-887b-44d2-18c8-08debcef05da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/gqY4U3piosgBLu3wH9e43UfAhhzVJG+ch0usFKXj6xayVeP5OLEr1q/951yDgsv1pMAXGCqCBVFMXsx9wnXEBJ77rOyUXYlP455XjvXrx2aN/GzZ6Svhf0FPiSRLzsn31vNoL+ILXpi1PfFhLga2x2khROOJO9ehxV7Yw06lVN2I1NfirAXUpUG/9nFSYodovnxtFG6K11MRW4ym1mkG1yq1RFkKQNRBoGreRZ6BTxKkM9Vn3mOs5cMWyFrVYr94YVBI36G9TpNxlFL2KEpDMHt+41LgJfjDPQQUl/OvIxIM3+epQ449sVOJzQOLSubrXyUDsHCH8eseTR6+geO/SlEy2IVMIL6ZwyOZ59qurfFZ83LJsy8sU3lwyf6glWEHrE5UMNz4E3tr+nj8dp4Vr2OaOAl0nGy/qpXBjURTwyUos4jOznJTopZO6uLa3Upw0FeaVxglWV4xMpMJXWYjwPY6//XEtu9AOxvs6ubEouR2fD0isiwCHxX4vL5G3dE7AEAbT94SN6b06y79+R4hZaKy4l82LElrBuIVMshFa2L8mzC2rWrQ5kJVh9DU4B/Kj5K5W6EYRzvIa5wGMXoTdXdAMil7PfhxM3ftWWov9Ldh0q5MRnW8XIVgGYB+pbOuph29EBqDSOErVJRToL/HbXx/bcV0nXK1GXT77k/8PD5Uj6WBB0gtgr7oDBpevHC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?srvNb6xmt56jPnmJr1YE8/F7zkUSoV2/6PVJIro7v2Ur0CO8qy1N/oQIi6rm?=
 =?us-ascii?Q?nO399a1zDtK7V/CK3rrn++cCnvQfbj4dy4st6vQg37khgOk6Y1JORHWnMuga?=
 =?us-ascii?Q?Q0mI72M2xl+KW+F/UFQxj3ew6Guj3Tee+DK3m/tam+xgRgFL6nlxhsxhR1OF?=
 =?us-ascii?Q?a8YrgBdwtS2Ot6NTpYlV4GZ9z+/79ATf2sp7XNqHyWuc/lw6GQdBnqInwt8/?=
 =?us-ascii?Q?/KKY5NsisVp6KOafMuNeU9dSOf5FNg1RNF7f1NxqonaxmAH7KeUNfUqk3Y6j?=
 =?us-ascii?Q?qXIGo0Tcp+27cWDq9K4WmigAvC40YCEbcIOuStKzVhakVymfFUoeCcESYDOJ?=
 =?us-ascii?Q?jnNBywSd+DSKLEH7ArrI8WH1rkeiVsvDM+8iTj0RaIqrlq7I1lRXVArxQLwS?=
 =?us-ascii?Q?i74hzo6hTfvS87dy6V4J43kCMYWcJ9LVPajlDcG8PKhufSXTtzEJaktjeung?=
 =?us-ascii?Q?Ix7U/jKuQnUn8cFSYMsDvSpSj3kcrVXGfvu4YJZ9LvGXN/CTusYFfM7hYnJT?=
 =?us-ascii?Q?adTNFhp5OUapbWM0927jLYYoWMOzDJk8ii5qAGRYOYGoXtqqOXGrq7a+JA3y?=
 =?us-ascii?Q?aPyHPZKwXzgv2uvh797HHt1BmWJ1QwPxzDy7UqsMYdl7Pe6m7fH/eLtWe2g4?=
 =?us-ascii?Q?LWsqRrJHXIPd0H7U6s/UT9waP+bNXPhU2HFG8rZn4T81UihDP94t9b+ixbLt?=
 =?us-ascii?Q?JhL3vWDFn1GQyhGHHYUR7qw/igl2po0mwlEj7zoGpu6x7tT5dj/7niKwPrTU?=
 =?us-ascii?Q?OnDQ0c8vAuMOl8rY+8DyU3EL+bZ3baZ1EJVLCAF3P/zRp0KMzYE1q6RDajYk?=
 =?us-ascii?Q?X6PRIQpFNc4VxPhGqsq3geM9yKW/FiDEm+TPu8SZQ9XLCvhMjpRMeUHJirbg?=
 =?us-ascii?Q?D3p1t1A9bfUr63hwnw0O0DOxz37t2obl3E1Il25WaxTH1rZqcXTtAcSqwxi8?=
 =?us-ascii?Q?5mJK3kj39Y8s+BPl/6N6yuXv2cThO5MSAmfBad++X19vU1S707DVrgQVPfFd?=
 =?us-ascii?Q?r9Ftoz+X2bYAq8Mjl/E+H6W0PtsZ/EwfHMnXzoXka5XYvnNk1Rwgc+oDWqun?=
 =?us-ascii?Q?supJNPl5xNE+RpF8emilFHuLx/cgZYyuVM+mEwvwSBD624k6gpJOdWMKOzck?=
 =?us-ascii?Q?3X0/MFCvwgu7+lNCMkf8uceOSUTBHgDowB/0rHowp9baDU22q4jM7t8ggVp9?=
 =?us-ascii?Q?9WNIgT1sdZUkjnVBQV4JfjnQHkY5p5xulDURrtoVvnhciVAJqcFhbvkcfNlx?=
 =?us-ascii?Q?sgxWauiFceLt0QM3mc6/lllcobA6U16BCSu5D6I62n8liwdmkto5MVRrtyoR?=
 =?us-ascii?Q?xt21uJIkDftytI/xIUeOr73qFWoyL4HfI8x61sht0MxgvuVjeyMA0FY35vCy?=
 =?us-ascii?Q?OnhLEPe6bEBQvvpNcBzwtoNxFbUMvLAXM4XEzbTB5LhDZTasDxJExpXiB+o5?=
 =?us-ascii?Q?VnWaKcHqrRLU/WYnuf8e8Om51MnYX0euYq5jfecsOTtA5s3B1kDUdfz9QiXa?=
 =?us-ascii?Q?XoavFxsLqgoe/HAJXm/SPwLUSTVJgy0qTkLE4SB/MSQ5U6LoXpVCf1cpRGcX?=
 =?us-ascii?Q?Edv3uo/EB1dOwtF2L1/gRus8c1c7j4Njh16KgF6xC2Rp2gKRWAnUxV6WZLpF?=
 =?us-ascii?Q?XpSYj1WL78Swi9LZUdnlALHk4cOgSchDmsClSbSQqHGFrd85XAGDXs7nSK7T?=
 =?us-ascii?Q?59Yym4lqdjHfm71KobF0fY9PuaHz+UBUst3GxYG68uLe5XUwt6wMa6aYBl48?=
 =?us-ascii?Q?XqxMq1vYuWzUjX6qMP+Ok4b7JBheXBFFe4+v9SbF5aXUD3DmL1uu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e40fbf-887b-44d2-18c8-08debcef05da
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:26:31.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGKGQHRLMFGHSMI6CnsIn4+8GFUTHeB+EoDyL+Ahey6ddm++/cvyowoBJJBKDSIyKELoAUjz7qheTnuUH4wPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21460-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[89];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 915FF5F731A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:18:06PM -0700, Andrew Morton wrote:
> On Thu, 28 May 2026 14:36:07 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> 
> > cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
> > in printk-like functions. In some cases, it makes people to create
> > temporary buffers for the printed cpumasks, where it can be avoided.
> > 
> > Get rid of it in a favor of more standard printing API.
> > 
> > Each patch, except for the last one, is independent and may be moved with
> > the corresponding subsystem. Or I can take it in bitmap-for-next, at
> > maintainers' discretion.
> > 
> > On top of bitmap-for-next.
> 
> Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this series.
> 	https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvidia.com

OK... What should I do about that?

