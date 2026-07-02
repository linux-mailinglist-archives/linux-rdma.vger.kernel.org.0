Return-Path: <linux-rdma+bounces-22702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bo/UMtOJRmqSYAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:54:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFD6F9C0F
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:54:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aXQz5UnF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22702-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22702-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E3923098967
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4257E417347;
	Thu,  2 Jul 2026 15:48:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEF414DC5;
	Thu,  2 Jul 2026 15:48:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007295; cv=fail; b=LuTcs0X9+wfEq1ang7Mwuihw0qfq+O2MjfUNRjOe8Ha5YrmcpgSz8qcw3x7BaJXUlSkiI0eyxhHvd6bP/wyRIeVL4SZZoTSswuiYz56jHIFJC5tNZ/U1VcWnSlg1HQL/wcaed+edrhKAG4FdleLt8lbwf9wXleR8wqLAbeJK5fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007295; c=relaxed/simple;
	bh=+pBgtBCICc0CCA46tNoLavwbiGsLUsFlWL0HMW0LDBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAr/fC+xLLsH/eS38ZjzDdNYRZPmY6rmGhqZFcNu2WOfxgs4C7IRC2hQ9lwBjXE9jz1pxI6moVBtX5K9tUF1pjSnoJ3QPJPk6oi1Hy7eQ8tBwSCAOfTnQ9lij/KCt12R0vA7tCaVjXHboGHhbbbp0ZvR98ajTO7kKsa2Oo2hCi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXQz5UnF; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKb3xSJTLpH/bfZuZ3oYrEynUeDuzg3xjFP2FX/NFcuAA8CgSI4r3Z5gP2j5aKqONDPu4EDv/b/rSz9Z5GlkaE/DV43P1S+9+MVgKUi1Pp//cGbKkl58pcqWtVbIkiwBzYz6qQq+h7gf/QcFSN4FBGsTrugzN82e3WaxmFD/+iuVL5+6ECAqZviwwTw5KIdqbMADFiq21PctjOE9XTBXqG3h3RomwFme3L/V5emGs9rOckSzVTguhz+MEH9TXEeloH2CMBfHShZ9ANUl1Vp9iEKok1p8vdOIaCLa/ByuSGWiWXH+krDkyuEL6Mwn2mDPtDX5xtgbB+VysW5Qpqxpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkWOYoNDXUKT9/dwlA3SRdGXjDO/1ApEoYxQcZI+x0U=;
 b=e8z2eP/R5roSpEjimKayolnoNYIfIWSf6HczRTDrHTNLlvpF5y3Uj4StRBXOMq0yAkJTGOvxOccXOjuhUX+kdUhsjyR924V+2oGFc0OgoOEsezbJbv3sBms0RwBV1NytxvfR3LXUMZ2FtGRQz/IFjeVcRaw8kxRdSrZ+aSgs0ehII6HUDOJGOLC71bjSJVATbJ3MuEYzxIFvND4k8j6m0jYiyv7h6rqNQcJATgbcVnFEN4uScy2LwWnY21PRQaVULPJ/fWlE8gdt8mx0CsbZdzYK5ao/LucNAq7CzgNFlsxCFTMq21Jsvv83K5XHFkba5DCUAZ6/GhcGAgh7J2/RDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkWOYoNDXUKT9/dwlA3SRdGXjDO/1ApEoYxQcZI+x0U=;
 b=aXQz5UnF/M/6yM9+UrnUZAPZcfgKGaz0EEMI/ztjEkjASwHc+ClXAVDR9X+R9jhIW0f5J6vRzFIqKUV71DgN+Mg3YAtXK/EOF9wh7E3BmQMket6rkUaGTVzIRaHpmFfv0NlymQstK6tDuFkyKC+XEMdpVslgKTtZPslhLqk2wVAen1j2aZbPONgWWUnDoc8yEL51GBkDjxOnkry86a0gitj1XRL4OxuqjqPx3F6EZ73UArX7VVBwE3zgreIMJl/xwyoxd9LSJzkbLrSUp2CBxH82CJYQSYQio4MjxziuEUfDg7NEiZAC4t92F/pJIIcB7qdyvaPrKjd+Sa0GmFAvFg==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:48:05 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:48:05 +0000
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
Subject: [PATCH v2 09/11] PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:22 -0400
Message-ID: <20260702154725.185376-10-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: ec35f984-63e9-4bf7-d3bb-08ded8514e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Dw5vaMBO/8iRt8eANDeNIEdMD1a7mcSJdCkoddf1aP2KEl06seU9WR9rVWe1NJWNyNXL4YSIkfWHLCCzCSQNSIbwfTyXaIHCbua+S+mkEbZTmqRY6kAOeTS22pcjohhO2pir1Ssy3eqb9VfuT5SSxBlw/ypq/RkCk3FuLC1b4KsSTJDvlW8a58bI4nRuo2eMD6/JNhjEbB3EuuNSRk82zOq4ehmmIVMeRrTaDycjfI8EexgQDI9xfhveYiS3T5SUKff4eyaeXU5/xPauOrP9kZa8zX4dG7ZThWO7HE2vfVizpky96yjG5myrOrIf6uGhsmPkfdx11g9697p1LI7Yc3zCEF4J9gF9zbSpFREC6ZacsaktaJvNzkgsPvDaG8vS7vyD/KBN1jhXnjQ2hryWCWVn4SXB0on/Zvq3quleOcknO/6S736wpRPD0zi+68nFaaaFCL3hceP2tGOe5pHlnzJzDngyJ59JSssZjfjmw2ICM5bFAwp3aaVwc2s+FSM2WIL5/zp/pVLsbplEFPk+aPSd4KkW+HiOlXdO7/MW4wqkB+mcuNkKqVjXPqOzmT0+CDjDXtyYRA4C6HhuKXyMG+lGFMFw4w6nIVAdpYHK1suIhSoatYl2EMfPy/QWMlcrsZ3tHmiQFaTR4zwFjWF/o5VLo/80LNXBSJTrLFux9SY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7xKixeSjy+iKINMrC1PdhiRBQaOIzlC2+dMS3wzYtY45Ut5xKppkA1YcvJMa?=
 =?us-ascii?Q?vSDm/b6CQoiOke6zvDhP9rBXgY2xRZILkjp17wboYNLTzKjwPm8i1xAWPUon?=
 =?us-ascii?Q?+sE6nyzFGImBXihNFXCxs4KiQCa7Mrn4JmkyxA1JBUAoyatXS0sJXhuIoz8r?=
 =?us-ascii?Q?MSTIdwz8zXlKYZu279yl93oUeM1HKusq9qEx7V/bJhqEjlz99UmAJr3Fm31n?=
 =?us-ascii?Q?NDG+t+Y2i/AR2FKT8k7XVjZCPuIrHiBQtGDyneidSYuV37Gge5nKRTyqHSe5?=
 =?us-ascii?Q?1Xher2J4HQ4V624EGUPHWMt4fIhCslqewfvsipkFezlQXjIHUjJ+7yI9Pa/Z?=
 =?us-ascii?Q?X5xYZRVnceuKUvyJiwVmT310BVIWo8+Y6Xb7NxWHm0cjzcDQnnfrcRPyLhio?=
 =?us-ascii?Q?ZOlk5zTUoRXGV3KdPMFeL7blgfBGWeT0Ip6I5feUMVtY3GvZVZsH3r3jragd?=
 =?us-ascii?Q?vUia/KAJNaZEy0nzwxJvhGaNbzKboFbNkD/GpieCYHGu2EYF0CENks0yBhPM?=
 =?us-ascii?Q?Xh8Z+5DGwRPn+oizo5UY5D1u+9I6xhjyv9igUwpervMAltZpDqb76fFwedSi?=
 =?us-ascii?Q?oqdUv5wc7IXgbNqducme7NqCnU4TPGIW4/v7KYkfZ/In3Z/3+UEnMPH+6X7/?=
 =?us-ascii?Q?FNjoIXLoze3SSwl6RKlO6ZB0pzzS3M2QobEBxUXqZModvcjJz3lGEi1o5qZe?=
 =?us-ascii?Q?G199PtHiPDN8YHBENSHLaJrY1KciUbY3mmHhgYmdx+Ol4jA3LIo3hnwCu1yE?=
 =?us-ascii?Q?4qwW1GcdIhi3m+FCpWUEeCEc/LBlWifwI+e1hs4EUwz/lhd/dMUxIKf1dkp/?=
 =?us-ascii?Q?qp8eNTEZES0z8UyFbapDcRI+lZ04sCzAopuum2ZsPUR9+AV2clOALFN1EOji?=
 =?us-ascii?Q?WPH5mIH53jpt6t698oIcVwmsBxh+hQyYlbVrO5h4INuIBhokpZK+Z47V4Scf?=
 =?us-ascii?Q?cRwleNdNbT2CQoTwfctsaWLB8zPbhO/T9QPONhmv6ezgWZ9UFtdiwRRZ994N?=
 =?us-ascii?Q?+rrJ+2Mfy1zaO+VxvqpsugYhyGRVMNiFvYiVdYWmFsD4s20OYxU9CrhwTRC7?=
 =?us-ascii?Q?t6vy0tJ+kwi+0O7zaQO3hTzZArsl5TVcDb+80OakmNpFVFALhJnHzbHk43gS?=
 =?us-ascii?Q?9wLFs5yArmJOKh5YK56sDERQXi0VBPLHD3j1RDqKslpY/j1AlgzhjQTZIWVS?=
 =?us-ascii?Q?5Gvq1N4IJihWNrjdhBOXDk+0tQ8XFXJxim68z42zdXxC+RWTIq393v+89RSc?=
 =?us-ascii?Q?okBVzntY6RDVEa8RW42oktRYuHQG/FqZlkNH09CI8XuLGA7oCYGz2JnRTVId?=
 =?us-ascii?Q?9KVZ3qWOsCjoqxlnks8nqdcptbvSSfY/Ir6V/Vwo+HzpR0EaZNo6T8E/H+uy?=
 =?us-ascii?Q?64LOYp5CcNQyF/Km49V3+fRe/qe25Tg+gJiVd3I8KkQLH60Uj1z8YCpO548E?=
 =?us-ascii?Q?Wt/5ZwmOzOxxGzha4UMQagXI9d4yXeWfrzsSDOdAtZ949Z0BPuMWGdBXzqF/?=
 =?us-ascii?Q?8fHe1NRdDF9xHbBjMSmUB3/eo4UY+m5+cduDF4IYmpzb+Md6MG9LNXiuOUJx?=
 =?us-ascii?Q?gLUewLNiFZZo/yUTfupjloJvXivLQmgmnAY0Gsa4t1DiCgWIj+dggLqu+uf+?=
 =?us-ascii?Q?v8gMTztu3x8oH3FUnCIC85f/c7sBxUfjzOVDudV2E8aK33V8gJk0++OkznsA?=
 =?us-ascii?Q?WGo6zdx835731GrZhdrd7opIskUqKUs2+3xqeoUo2t4VZoXjolPb6J5bk01F?=
 =?us-ascii?Q?DkfFpvP7/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec35f984-63e9-4bf7-d3bb-08ded8514e8c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:48:05.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6s2nfUcH6hD542sY86PA9NOIxxJKgcjCifSAUtUV7DoAMAU3S+Q0yy+V8SWs8anS2VEXbU3fIAcK0dVQl+Qcw==
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
	TAGGED_FROM(0.00)[bounces-22702-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ABFD6F9C0F

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/pci/pci-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..d6083552b287 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -112,7 +112,8 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 #else
 	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
 #endif
-	return cpumap_print_to_pagebuf(list, buf, mask);
+	return sysfs_emit(buf, list ? "%*pbl\n" : "%*pb\n",
+			  cpumask_pr_args(mask));
 }
 
 static ssize_t local_cpus_show(struct device *dev,
@@ -137,7 +138,7 @@ static ssize_t cpuaffinity_show(struct device *dev,
 {
 	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
 
-	return cpumap_print_to_pagebuf(false, buf, cpumask);
+	return sysfs_emit(buf, "%*pb\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpuaffinity);
 
@@ -146,7 +147,7 @@ static ssize_t cpulistaffinity_show(struct device *dev,
 {
 	const struct cpumask *cpumask = cpumask_of_pcibus(to_pci_bus(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpulistaffinity);
 
-- 
2.53.0


