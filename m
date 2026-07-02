Return-Path: <linux-rdma+bounces-22699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eKxmKmuJRmphYAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:53:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DE6F9B84
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=L5U50gYr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22699-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22699-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F893081EAE
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F83D9523;
	Thu,  2 Jul 2026 15:48:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A7331EB0;
	Thu,  2 Jul 2026 15:48:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007286; cv=fail; b=mf/9bqgYFiNRKJUkAHapCQRIZ/DAQBXQgF/dNm/4m6snC35roojuHDCFwJal0j7LnJpQEnxZAmoliVtfGKAsfUyHyCpA8jO6G60bW3X8tTVT0qHbHNkhFO3F23Hq6MAonCc7XmzhNWRaKKlimL7TsY4Rqn7mQc5KhqbKO965xw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007286; c=relaxed/simple;
	bh=lRQdId8QMo0qXY93KpHbVlAzzU4FBNMABR/vcb/bB9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNQ4NpRsCPIkywdhA/whgXEmj9LTB7IrnoVEBZ70eIoTGcxhmbOEvi/J/2Wiu4sSYN4aaZnb0Q0c2OgdyujBj/Tnc0D4vB4KStFtvNvYNNo1LHCULJueLnd/yHCSgqt+W40vqCO4I9mEl8fhEbB6IMeWqKiPv4yAF6OQewlcanw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L5U50gYr; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNiJwTV3rtVOgPWW+4CPitVCgNnNKvqROI6UNVViHO/2Q7egP5DiYDFZNkEM3e8MXBfyEqqROxEeT00EByZmZyUbZAK1V9pwQcByHJnyiEOd3AiZ/fWJAxjywydb+Q2hvCEUJDqkMtw8X6brmcd8/dRyB9JdSwGerMYkts2Xb7LSdB4zmAB0SpM59+Ed8sB6MMzJyTT+fWxj5qT8sYU8IT0n0mpl3AyU7qOiA9eTNQjSbUlx77srVo+jyQdoKpAqeVVdLPFiNN5tsMJPbb/gkKUEbIp5reZGv/2rmg/cIWkZJmim2JvA5rT9wWS/wWMpuH+04SJzZjcjDt1hRM+G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRoHq1JGkcojBccwrGS67eoDbUVnQBc6EEu1M6R6+e0=;
 b=nyocynwJxO+4TsXF4TLyNiP01wl9KZxA0fdG6wQq2FJIgVaLGsZ9eioqy2RQn4zS2c2UWkZdWfxjGQrus9I9NENZQRTAAxFBtAkbDtjKqd9p0uZOPT3FK48hq6/pEto5djH8C+pNkuXcXEvcqTefgREalB1lFP/4XMeCHiGLt9J1l+67+QaL7c0V5DekYN8TKa99VFRr8O5QoMcQ3eXgWVyMefPDfzoyBq8dDj7LuxFR/+NYvDrk+bTL7kIth4ieY7jgY0vcpm675qpWepM/sSWTjoq825Kuo006ZRKxHF3ULTO0dxKhlRfgquN4W6BxqtkqSOwF2U5ukpCZ2gH8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRoHq1JGkcojBccwrGS67eoDbUVnQBc6EEu1M6R6+e0=;
 b=L5U50gYr6i1OgEK7SfFgW1c8oRtRIrmUwBCbitPlJc7Ng8ZqRp8fqe9nPYCmV+SZcj/1chYJWvCZdkOSy7vVIgSoyRTkcwG5ACev+Kg8DcOKapBCfebU063A8nImhXDUsBXqXWKqpfcu9JskKfNXUBIEAIG9Yo/Bglqxb99fSf4MWN4Gdp+EQbOCis90lcLRG2faGJqL7yYlI0R+ugTDj06o39qh7uicsUq0xeFdRnIFYba13OphVSuR2prr8W4+7PThSb770nIJ4F/TtkRBOMp3yItZvpGGDtwQ+7OS1hHNZyAkgyrgzQwi5HMe1ZbZVy08aEuVYc62u4v6e1zpHQ==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:52 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:52 +0000
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
Subject: [PATCH v2 05/11] devfreq: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:18 -0400
Message-ID: <20260702154725.185376-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 97aa5f61-ecd6-43fe-a55c-08ded85146cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BgScWIYrAN7vIhYt0iLh7jY8VHUyWgHHzLRGmFC8v5e/b7zJ98DDXFxFtdCXM0vv+cTs8wVd5OfshGxRShH8r/1xP9+jQlVmYeVF3BjyAQv2M4MkzoLIuIBav72cCRcLb6UZa3IeJ5pRL/WbnunLfpIhmBYo0I0Lyz9u8qTVhsD6MJ2FX6NYnvbIrXZTjScMWAU+aOaXhmlY+xiscuRiVCyAcH+GthY3hEH9GWAR8IkYvqiHAAGEtFu8qA5f4uqYOo4jbyr8dFN8zoBd6anIR50rXP/YdILDCkQ0MblvBsDZGlYpNIeRpAmcl27z11uvGHgEa0iBTdD6lNUW6EZvq1MEcn2A3+J3B9tfdMFG6VGFXosy6SiPuv0tnj3QuWaYloN1Pwpv/9U5HCRQIvk7x0TrXqXb0lcthDbBJR8IYPaL++WAkMfcCkOMuMN7oHRVzkh1e++Rhj9vJjkW1EQTZ3+Yrj2uZgiEX2B9DiSEAS/rX0ud0PnMUlCXg39WE1hmv71+LuQ/+0hTS9pe60UVEOXENQMk0nXyAeOims0iLT3CBir+zJPjWN1aviHUSA441Qc3j5ZaFsgK3zkMo3s4Yu9hZ4GHTj2lWcGpzw4kQEqKq6W5CgbWeiedUiGLSqtcoXDl5eMkUXMaKm9vBkmgFXqjiOKt4STwMGwLghKBcGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5753H4w9g+hk2nwfKELjxO3pE2ePJgP1E6Ygt6kYmtOd7Q61tptOQDisV4E?=
 =?us-ascii?Q?laJVgvjpIkoFWg0jSQaPXLm7ZwNdDVJJiRxQGDJ35A38iLraQoMFokmiwuNa?=
 =?us-ascii?Q?2JNzvPiaOc6wezbEPdniYn32rsKxx7Llb4Uy9HgrqhEc9slV/0cP0YySQ7Vt?=
 =?us-ascii?Q?M/hAaHHyTzx1Rk3PzLIYB1PMTegspTSJpEmvC3IrZ+HCWoWVgTGB7M8QSt4H?=
 =?us-ascii?Q?T6EcFinv4391zo+O+RJ6Y+UfdH44CXmSAKymzsA8HAIAPcMeJAXC1Ug9f1nh?=
 =?us-ascii?Q?NqOkiJ1roZOWYw+oiH5ok5Ic0AcVvKF0Mm16QmEhhuzz7AtEDcJ2GYHbS6vn?=
 =?us-ascii?Q?B+dWAUuPT6e1bT3thZHDJAHYFTGx9uEUMInmDv2qf5t0AOggyWQpsIOuVXqI?=
 =?us-ascii?Q?bMXdeXZ27dfcx+JvLfXvae294pWudPQKwnGK7WsHzIxeL+uYipAVM7fj7+yS?=
 =?us-ascii?Q?qZhn2/OfsWYVRI1PCHeVWcDpm+CO5rB71KAjubak39yEYCbggx0QKeVrQoz0?=
 =?us-ascii?Q?hW/+JfF+4+M/0pAGS0Inp/oXwThY8M3s151iHqdSUxLcgxqXHgMy0OJsTAPS?=
 =?us-ascii?Q?PIQ89VcFMhKfPcTtlNpjapwORZBr2fEPGhMmRaT4OfbeYvO4gK/tUopSgcZZ?=
 =?us-ascii?Q?Ja+ORH3TkSTeOMLrw0zPYoOY6t6GoYUC7McyIsW0iTy+Jp+Dze2vToCsKgYi?=
 =?us-ascii?Q?9ptl5zHUEJk0M3igj1cenxAeuKyQSMV8F29ie9+AFjb/cPPk4ZKqAutPidPc?=
 =?us-ascii?Q?CJQmvbL0zRQXjdtdGnJyYX/io3fJIsFbpnHNSneWz0TC4riN3LPT1epQRvnp?=
 =?us-ascii?Q?X9xjwu0Yb+X34N8DctNrWTvI9fvgu1NfXCfMiWO/xzPqnwoAR4AcS3caXiRp?=
 =?us-ascii?Q?ThxAJnYztcJ3ZS7CqhHzncg4mo99bx551PfUXZWgHi7c70YXCHzZ8GQpN330?=
 =?us-ascii?Q?6mEY5B9Q6azor1uKrSxbFSMww1zRz+6CAMKXg/G8CTI37yTxSmzxHl833Oly?=
 =?us-ascii?Q?94EEU54eSjMgyidKOTIYj5LxR32iuJmpvCtvBJvqLSEFAe+PuKbNvv3JdhQz?=
 =?us-ascii?Q?nmQYnfh6DMBzWLwXUxsD+j80FDrdOmW4yuD52MwtOU8j75JPOH5f5+9+IoK0?=
 =?us-ascii?Q?ZnMzogvaI52iqmoeCmNggoTN8wBMexnDktYjSHCoZwLGro86op1ICT8CihXA?=
 =?us-ascii?Q?gNdSGmUE5n4BrZvkD97GszK8ogXZh6iXhEdHVZbHH9yrweCNDp3DAoV4avRa?=
 =?us-ascii?Q?b2khjkqwmbliTgg/PqM+ZdX2dYTSeJP0nUVVzAgFHiOdX237YZhC7Xzt7cEp?=
 =?us-ascii?Q?5s+J/KJB1tEwC7xUl05SGe1B3TNaV+o/nPN3CW+mABmjwwOdAdvz3KRDeE0Z?=
 =?us-ascii?Q?kq1WaX2sPDnCChNC4n/5UPzL8NzWM28xuO1zcFx/gwGQbDoEoMHXRtJbuZZk?=
 =?us-ascii?Q?maxz92Eueympx7/GLXV6b0fiU42VABoKA+meQsmFQyX2E3iyc/r+lQ2OeQvj?=
 =?us-ascii?Q?aiXdnRlgFVpy4qg2mF80W/1g3tnZPrlvhgjMsV6kKK3F5X5a6ino8gQ6rAC8?=
 =?us-ascii?Q?fPxAcfUwJyNut+oeGNGZhXFGIuAl2QAFJaqSw/bKq/bSKYfIqJl7ADZBASDr?=
 =?us-ascii?Q?KLryYis2hVC2dXSo363Nodx4ek9JGb58wVtVsvofJIotImPqxLExonufnUde?=
 =?us-ascii?Q?R8qyetQ6plqqH3d5HyP5r2MbyiBzOznbgq+iXvDcfQB/MRS+RSby2wEzUsNk?=
 =?us-ascii?Q?EXUvO7s73Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa5f61-ecd6-43fe-a55c-08ded85146cb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:52.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E48H2nfvwqWLAS06KTzTS9dw5xzl4+HRlDPp1ezpgT+bIQmW+Q/gBKOAYS5kKY4SQsCoX44NWf/d389YFuWsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
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
	TAGGED_FROM(0.00)[bounces-22699-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 159DE6F9B84

These callbacks are sysfs show paths. Use sysfs_emit() and
cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 drivers/devfreq/hisi_uncore_freq.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5e6e7e900bda..255aee1bdd91 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -354,7 +354,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct rockchip_dfi *dfi = container_of(pmu, struct rockchip_dfi, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(dfi->cpu)));
 }
 
 static struct device_attribute ddr_perf_cpumask_attr =
diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 4d00d813c8ac..23b262d23a66 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -541,7 +541,7 @@ static ssize_t related_cpus_show(struct device *dev,
 {
 	struct hisi_uncore_freq *uncore = dev_get_drvdata(dev->parent);
 
-	return cpumap_print_to_pagebuf(true, buf, &uncore->related_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&uncore->related_cpus));
 }
 
 static DEVICE_ATTR_RO(related_cpus);
-- 
2.53.0


