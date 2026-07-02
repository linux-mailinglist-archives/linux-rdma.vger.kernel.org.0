Return-Path: <linux-rdma+bounces-22694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oa1zIV6LRmoOYQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:01:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC06F9D74
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Enwybw+u;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22694-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22694-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C6903064E31
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7B33F597;
	Thu,  2 Jul 2026 15:47:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F533E367;
	Thu,  2 Jul 2026 15:47:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007262; cv=fail; b=kqI7RACDabH99ttfX92qCwwC+TGITDGHpEYtAs5shCnvo3x5G+YJ7DWousyK4d5MHVRCx7QzB7SmpbOjsEBP/IEytCtJEgBLwL2xPg6FPDw7HJwg+WcNw+9tbr19arcLhaiW/jVYlY4mCUPSuOVXVBJ17uoXARy7JsTGQ0o3FEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007262; c=relaxed/simple;
	bh=rfODPSJZFgGoHlUK7S7Oo29ydIVJvboXQcciv8VmeIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBHDRl+tsLVoRH5gYRPwhxbOHVhiieRB30720HVueo61WnFLWSGpiCOpjjmAWnVWwuz3TqmFBVadcVKU0b1CQ+VuTb/elnrLkg/EmBac+XLGYI4PueeGYIxxfLQ4uy1SqGn4o9Eq1PaMDOXUkwesPG6W3DpZtoZrlU2elWI/1eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Enwybw+u; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmJOn3JmeRQsC8HF1xNByrVSOpBUilYRMaG/YwkuJMnKPIvA+2hb/3P8u4poCgIgJhyU7GPS+fzky0HEcr9j/gXcv+Ql+Ar/VH2Fqx0DvVlkKqOWtZ5OYABX00Sv7bWNi5d9+JrX4HKAa4SMrHa3fjSogcNF4I/SznjS8P3PoHuhqK7GdFyi7l2J0jtx2kXzHXH8pcxhalkvWF2PlYVfAqMpeIRC0M3bHh4k+vEiUPpcGirjPSAkEMZWq7BQuOecaukV0YBCe2FJfkg6dXKIDbugPkE8Uu2XnYSYRMCXrTidLuPMyE3Vgvsk/K5h51hs68AsuHLyVk614rczUv8ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yav8utETY6FCguycHYwbLXHTThtCgsZ4dGDEa+HsUy8=;
 b=lRxgKwrCuzqW/gXUP1A2Cs6wt5AP7zM9qSJEZ1QWEN0Es1b7X/qQhSXu/JkyLBx5NcCMUigXD8GS684frVi/eaZKDlbcAUcY8Yf9YbkO1EALKWQJs5gJo6pD30jT+jhZGStieBlXOoQZwpv1Lyh9qe9k6Y35Eq72g//pJtt/tfYQ0gMLzeS/3h52zl+l5kz4p6Gxx6N6vqByJkgK8U6smYQI7RObS2PnF59DlzGkZ7xWt8eyID088+s5uDJplVTj6OkYnrwPL6ClFVpyxp42FDVWFxU+mZICd7rUNfJtmo6L/KFa3yVZyruP0YMpwe3k2c7XmMqW4Tea7pUalLcYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yav8utETY6FCguycHYwbLXHTThtCgsZ4dGDEa+HsUy8=;
 b=Enwybw+ukrZW2qqCkf1pT9+VICe25xMtyogS1V/QBvyxKfla4Xc5qhwZIeWlxAA1WJ1Hx3a2GdF/kWzQJ/aWz88RBCwjaKnhvzZJ9h9UEVBFoq9G0ZjaW3LTNtflqSQIMYeomisdZmrZ6eSptjt5/6lO9GXHhBrLNCV+tvWw0MLFexsldfqUUe7ky8KrrKjmTwUb4ZsdkrjD+Zn8JgEYcpxicXzN3olJ306PMPCd9NvOp9BVzM9Zy0ECs++QjRyzwuI1HwRKXMZvs1AehR7qgn5vPWNT6q88zWr4Z87k8OkWyc3l4I5zYsd9wQyiEtmUeqnZVI3yyepveY35luZHig==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:33 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:32 +0000
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
Subject: [PATCH v2 01/11] arm: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:14 -0400
Message-ID: <20260702154725.185376-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 440f6ad7-f5c5-46e3-988c-08ded8513ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	VmEUz1Sd9M7XuTvK9fJBWw4q/kt1h+pfSABZ5ksrR2QSqa8vuGfkpIO8qqAAcSDpOukKCc/rL2Y7xA6bJqeF//6OtZWn/NYZJ5hgsZzuiZGc2elpBiIu/PpEwrtgSHVROCbIaHw0IwqlAgFOnQKXcBvW8UQ6zBJ4MIjqW4/bMKeSiMHYeqK2EhgXpka/m/i9lfCxolU/aSc3gqZjUgjb4Vzo9mm9mhthBxUJAO4fUvTSJuOkgT+Vms7eJLC14BF+T8jf0EbeCI9hPaJMKNRZLZ1iXYEsjeEys75OdEP8NXCvaPf8At74r8H6irntCbLwkpcgSOztptwJPeNo6Owbqm1YQMmn9vTdulKW4k02eVGNs9n3T1/DP8t4myiF9NnVLxCSQcCMiL2OfHh5AhKhJi74jwL4LwDVcqDO3P0hJ97c4aek5VxZqinVS74as9Vh73DhyYWmqhOgBGDQNtCphyU/B4gZ3nmMvLs+4rHEQguZnr/D6+aNiEI/hSLRM+StMt64syVsJ8wnMmuXaiqNvDjuiTITXgsj0rQKVicFHqVTsyFYngRSQY0GSDFCdpf3GvFCxCnneJ1FnvtEgPUQf1SL5+hawA+1Evi6SRTWPoaHmhY078mctz3QC14h/O6D+CCyLHFYkK4gi4vMkOyY8NOuSdgygqtcnR34AU9uPes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q9ssySRqt3T0m20/GJbiQV97dHwFge9ZZk9XSBw29YQWueXvRtwhDRkk7uU/?=
 =?us-ascii?Q?OQpSDBOPLBZuoxig/1c6ioWQCKIPehXjVguMROT6O7b5j1ALAGGNec7QTq57?=
 =?us-ascii?Q?nHOiye5taj1CK+zGGSoTJTdtWmUUrS6/oZrR3indGKqCVl8qbDP3BaOZsjhr?=
 =?us-ascii?Q?HSgRP1jQ4N4NeGC1ls8zPQsYt5Og6vQ56QO2d4s3D/r2w0ELVyK8C5JHasRJ?=
 =?us-ascii?Q?oWc7yC9EVK4VXlysgzIPxYoxkbDvF2PCDTD+Jj39HpJAzR89RJzdWi+0cE1P?=
 =?us-ascii?Q?mgX1pOVe5PrLR8td/1cyTICwuMMQI4EqA1PQ9c7v5Gmh2iMeVNiz/MI9ynKA?=
 =?us-ascii?Q?fDUNkKj+s+Ot/SIl2OXo0vZOPK5rq1XnRxcLnQ9xeCOI3lIHgqhPDB8i0CHA?=
 =?us-ascii?Q?qE5ZqIFFouXhZ1qA6V8Wl516zV32rLJJsu6Js12sfidakY9nRp6Po3DG5MGa?=
 =?us-ascii?Q?z0LkkpmZn/A06f/xzlBfN87wkDmPuOG+/FJ4U4j1niojulHE7TY8et52y9/j?=
 =?us-ascii?Q?f7xXI8JpbUn9R7QhXMQwqlTtLVZmApbR13xIaJmfi8kaR9fFu5DvGn+Y4yS5?=
 =?us-ascii?Q?2gtEfW8CCVDecm/72w6+IIxmuzfFjPcJoUxAETlzkvB+ak+gnSGz/VjKM90Q?=
 =?us-ascii?Q?cUHO9ZBjCUre3C8mDArS1cdgOzqbO+gJWzL1snV04LMLzYMez5tloyOWjO1p?=
 =?us-ascii?Q?qbtN64zvZP96qGO4zPFBZXR9MSUr1pre8sHIuIzCl5CpDCEjP9kFI+PkcMtv?=
 =?us-ascii?Q?wnr+m2wlyITuh3fi3mzHhcvEPa4n58GOXMddCGHlhoL28gtA9lN91G15Ehwf?=
 =?us-ascii?Q?3gpXOFFDdeNOnb6d6enB/8NNlXdLuOCZERjyQSYvXvd3rnEiYiVpcUBL1doo?=
 =?us-ascii?Q?ivVJ/n+ebdf3ukmddtOtnroprUSkpklZWdiKrsacx0ncwABuNVOBeYuC1yhc?=
 =?us-ascii?Q?EGcx3KgOqtPefW8tm+SsVB7sbL1MbTWCVp5fvxx3e0HQ4m6QsdhiEwDhVBnH?=
 =?us-ascii?Q?5UqCoTdR8tKnRPsI7EsT9LaaWeo+dt66C8XVc2KZq1mBVXZlDmlWXFylDxy1?=
 =?us-ascii?Q?Dw+CNWLhkzeHWEQg0y7wroODiPiR1QSb7Yoej5oh84IM/IUHHjxCDGuTNlGR?=
 =?us-ascii?Q?59oy5HVPIGqc0r9OCk7YXTetptcqTjZ4q+RM6HpX5ciw48qSgSZWWNSry1Z8?=
 =?us-ascii?Q?B6bV2FoBK/dbIxpytgWv1lR68sjTCt6T7Ek+27dVQtJ0JyqtVP0VxBMjEAHX?=
 =?us-ascii?Q?sk7tAvKih57pOSXLQ3jZZNRoi/P5hH3dAVp7R/bLzVor0JxnPwAPknItaQEu?=
 =?us-ascii?Q?9W5ocz8TkV9c72VBgb1Vcgi+8wfBHnfHZMoghxctqE6ZfIDPn+sGr1Ltvj76?=
 =?us-ascii?Q?hkptFI78c1nN4ftAy5JOOFAxNnZ1VK9VL6kuz+l8TEtclliHqvMbuOIrHxR1?=
 =?us-ascii?Q?1bkbs04pqn37U2+HUh53Bjm3p6UqV1Hy1p5KKVz//LzLm/kOwrhjAkB6I/tr?=
 =?us-ascii?Q?NcNamYv0jp2DvAuz7Kl2+AtYjO8PQQhfCO2tvdeom2gUPOux1z9eNeeP/e4A?=
 =?us-ascii?Q?8Kh4PdMEBNHOVJVt9NIbEEi4HcY0ydwvGhgf5c8hXzUdblJWxgIPn1Zv9f8+?=
 =?us-ascii?Q?d7C+RSU0i5ZPI1JDW7peE0bOmBkpWmEFSVmZ8C++JC1h00uuHbPdbJhituTY?=
 =?us-ascii?Q?RdfRK2p8ic8o4d3vr4JFi5UIMN/BbGC8Cy4vYWveqAJ7jiw9kjIL9GrE2Y+s?=
 =?us-ascii?Q?0xDHsIt/IA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f6ad7-f5c5-46e3-988c-08ded8513ae9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:32.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqfVf0hEYzxYMyvMm4/CmIayjA5KfL6epsC3dlKmoatU2vh1t2ceOprYSI+HYVZ3elTQYQMAOh1uCv9cfDFP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22694-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux@rasmusvillemoes.dk,m:ynorov@nvidia.com,m:linux@armlinux.org.uk,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:rafael@kernel.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:cw00.choi@samsung.com,m:myungjoo.ham@samsung.com,m:kyungmin.park@samsung.com,m:heiko@sntech.de,m:yilun.xu@intel.com,m:trix@redhat.com,m:mdf@kernel.org,m:yangyicong@hisilicon.com,m:jic23@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:bhelgaas@google.com,m:xueshuai@linux.alibaba.c
 om,m:will@kernel.org,m:jiucheng.xu@amlogic.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:robin.murphy@arm.com,m:renyu.zj@linux.alibaba.com,m:xu.yang_2@nxp.com,m:lcherian@marvell.com,m:gthiagarajan@marvell.com,m:jisheng.teoh@starfivetech.com,m:khuong@os.amperecomputing.com,m:yury.norov@gmail.com,m:kees@kernel.org,m:thomas.weissschuh@linutronix.de,m:aboorvad@linux.ibm.com,m:ilkka@os.amperecomputing.com,m:bwicaksono@nvidia.com,m:make24@iscas.ac.cn,m:fengchengwen@huawei.com,m:ritesh.list@gmail.com,m:wangyushan12@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-perf-users@vger.kernel.org,m:x86@kernel.org,m:driver-core@lists.linux.dev,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-fpga@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-c
 xl@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[81];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AFC06F9D74

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/arm/mach-imx/mmdc.c     | 2 +-
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b71467c48b87..f6d993b9b1d4 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -127,7 +127,7 @@ static ssize_t mmdc_pmu_cpumask_show(struct device *dev,
 {
 	struct mmdc_pmu *pmu_mmdc = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_mmdc->cpu));
 }
 
 static struct device_attribute mmdc_pmu_cpumask_attr =
diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 3d9caf7464bf..478227078837 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -390,7 +390,7 @@ static struct attribute_group l2x0_pmu_event_attrs_group = {
 static ssize_t l2x0_pmu_cpumask_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &pmu_cpu);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_cpu));
 }
 
 static struct device_attribute l2x0_pmu_cpumask_attr =
-- 
2.53.0


