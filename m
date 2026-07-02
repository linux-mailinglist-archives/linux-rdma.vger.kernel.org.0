Return-Path: <linux-rdma+bounces-22697-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0j0FqyLRmoyYQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22697-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:02:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B74E6F9DAC
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gxUfT1m3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22697-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22697-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB87301D50B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD056381EA6;
	Thu,  2 Jul 2026 15:47:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13D353A9E;
	Thu,  2 Jul 2026 15:47:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007272; cv=fail; b=WQ/PJkygAWvcs5IEvfmN9sabii/Tx7mBjsvhliHIRP3KqLcfovCfLk2o4EpMCmhDAwDqSYlQjpek9psxx5x4HbHxLd6KaWs9ePy/cMbFa15uPL5LZcVbOSWkRzQJCsPI5YsZV4264QOTYhU/mHdEazzqfVK/dFQEf6OhWQhhU/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007272; c=relaxed/simple;
	bh=aZ48tbcIKIOCS2gu3DGGZbJzk76aTr2BtZ1ZV+jWiHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bc2XbkGF+gskA/r1t7dC45ZToCatNLaKZQM18b3bwtvpdLB+6JARZvXqLm76XAIL/MYK4KfjIlws8sA6Q8QF+gV46JfeZ0auNtbbJ7gnBTuYtJ8utZJHu1PQySLUA8lDJMluwlUE+RtaMhbPE5ZauLeoyBRuevjlHsdpM6HtnAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gxUfT1m3; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOSloXvStqg5EJBBui9uocMFmvnSSdOYlOzaF2tSHRSkfyfc4HUx8k/55LE0eTPHrKwZVa/Z3SLVe9v9gQBHiE7ihZUAXN7+8LvsbQxESMxN8oaTZ+CGlmz3a3mtpO5OiUX2C6PI6FMQ3OMd8J8zqL139yKTC/rc7X1zPNNDkqThl0lmArIqQGDDObq6ib/nLA4szvD6i0w+YlhljlgQm2LH2KewTmjjMyGwKurriuTkvvvxuMSFVEwhGMkrBCgTx9eMeMwui7MWbdHQTYrFyABH54qdKCCDHYAg8c3yUdpYy+LXp4wqZZDyu2N+G56Z3ssiAbD7I/rz8S1a5ZyJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM+h2ItoWjZJY9SoNCx8N4sfAkkCzjo+zjgCpzEvSj0=;
 b=hRci8rUZBUfUUK6XBlR2HF/Wfip+3Bd86fAOlYgp9LwrEPvOSH+qTMfd3+/2oZng+ZzrQuY7COHrBxTnPChqZPY3yPcnUaidNEqoa4Og+XRjZLQOdhmkWfGq4QD/4H6f5tZruGFboqGcvn8uHdeDD/dZwLq706lT3ps+zxSkzwk9dfOCE7ppd5w5zk/7w1FULZ/z4eus7EL8Vb1b6mD+Oo0ZqQn+swoY8tZN41eTa4Giu76RYawvLR5Enzy27sfrHywNe/RWSu4zl95ThB/omoeP0/NZ767mTOU4TSAxkyGa6ehK2BF3JZ7sK6RPwFrZPk/FAeHYgyOtAD3kBsUfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM+h2ItoWjZJY9SoNCx8N4sfAkkCzjo+zjgCpzEvSj0=;
 b=gxUfT1m3u3h4zObbVGYLRXVPVNa51dAezZ3taG25LiZ5gUu7kHH80E0UnyqxolLXfS4cK/TV1mLRjI+PCZRRVoYu0kPLQedVLAtVnGBKycCu+NMETd3kbWn42FXgaLcLqPtMmIWrSNOf6zjQtKovdgHnBmMuF9HpUbJUKfEB1GCDpIuloWOkHc+PoumHIVucmkp6rQ1qlbi9VYnKf7+0XJ1UGrCvPlL/OH9GjCsEp8uvnAuLdgXd0iyEqDv5/BfUy1kteNOp2Ca/RcWOi5DjnQKt++KWpbofs2jrVoU3wGjwvPYhmUwYy5bRCouVfbMG00mfIHBWOLvadTTXNRue8Q==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:41 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:40 +0000
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
Subject: [PATCH v2 03/11] x86/events: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:16 -0400
Message-ID: <20260702154725.185376-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: a512e7f8-685f-4ac4-9196-08ded8513fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tm2VpgxZdRNRKyxOab6Vg4uYLeKhs5uysHMVqsZ//C94RQZdACoVPcsNuVQ4mvkSgI89UXJdm+fyXqJIycNeh1U8dBEICNhr+c7n1QT+N6rriPjsL8WoVnbassnq0mXjM1ZC0lBPuqNyGfYH147nkrsL1NLgfaH26OiqrRoYNe76HAwD43tJ7GoX5qgJ6RvEcQJn1VyEi8QWGZIAbl5EvpLTKQQSUWUa7F+wzc7AZpaoBIIb3g9ZNrWrD0dcIit0aGqpzrHbvdyslJsUJWb4kuPsE/RtP755Ocrd5+eS+GWKlPcAOTKFf7gORP5fd76hvcrCIOgNAoPF9o96W9/xBaXl1yoGboZDujm4k2nMJE3bwfkNltwPXsXjzDb7eGVBFYIlgIfPqwUvaAUzxnEq3ZrddARUjcz2BKhp9BFgmZ31mOGTaqKkTO0YLqcwjG2XxhJXxe++ZlF1AoevTKxSoypIWca2K1G9c9+SzVkCu7MVqGMeZueBXFs4AK8NryHZC8NWvkWNKiwATExVyWp4WLvg3q7yVFALyE6CFjzKoZJAF8zKAIR2Y21nmyqpcCXD05i3nkqgbM/+vCZGSJgAIATqSimCagn19TcHiq+SOHQ4itouyRMtKb8ww0AdOFABpejdsLJuWpX2mn7OWWsmb24pk95PRLBD64rk7vE3fOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LH3fcRFvTcGlS/WgIrFPES4/My9b+1b+yUV+JhiLtqxYLxYIDhvUfOXm4mqQ?=
 =?us-ascii?Q?vg/BEaRJwo97PGrGcg0Yf8s2wS0quS0sGIYkeYwWLmSN9SMrgHC6hjOmwgUq?=
 =?us-ascii?Q?Q/CQwYFE2rIc0J6bHi3vw1ROPtt05s70dYw36t5COdEXRdVrviRS/fO/+2xQ?=
 =?us-ascii?Q?GOoZ+d05FuUfvWssCBRkj5jXh0zBMShcnWY72T84aJCt7hUTjnEylp8KRb6e?=
 =?us-ascii?Q?aKlyidDVOU+d829T9Rs7K2oxwKLXEuCDswOsaiBpANbo5eh/j+v2MwjUhggo?=
 =?us-ascii?Q?GBl7VIUZtx+wzBY1wu7wf3dsEPoB+mbA2X0+o0HzA0yPATeOPoSeKrt5vMf1?=
 =?us-ascii?Q?/0LhugTR4UauFfdQKJ5iM9H1UNBq6v0k/hoiYq6EiVWUjgiPhhR+EtyPqObd?=
 =?us-ascii?Q?zFXdyUcJeeEYWvPmBSyzYDiz4ocUVFb1Gl9sM4YynRsQVTXS66uqvFW6j6Ze?=
 =?us-ascii?Q?qVZa/3IziITWs1Gesr1hW6FpKAkyJ2a6gLa8Z/TL3nCihW97ynhN+U9KA3/J?=
 =?us-ascii?Q?6bvWA7S+p48aag1LDw9qT3mThGa3mGw5IteXCvOpGdpcPpvOq1Tz3JtpoUih?=
 =?us-ascii?Q?zYsoT41wS2EYJeBbozBJmymx2w2tjvIOukfhFBhCbiYF4g6tDbauvBDNAxbC?=
 =?us-ascii?Q?Cb5oDShcck71JGHCLYaAmIHmq+YSOVFMT2kPTPRy4R929/BXsY0gQGPSv5MS?=
 =?us-ascii?Q?A/RhPiW+3v8+SyVab2UoWkgBvSBBFhm53Cft6WWY7vO8CJFid+Qavtg6jE50?=
 =?us-ascii?Q?vt8nZucfi5o/QcWhRZxgyKLGJkXGb0Qx2VC+3zE/WFvuYnoSOnO6lY4LZGHO?=
 =?us-ascii?Q?uMmC7tXdoKLv3TvlwVyJrmE30rpkMFslo/vqGpSevxPsxkD04JJmjLiXjD51?=
 =?us-ascii?Q?Hxd2730j50EqykcfzZuNtuVXe/pfZKbR6y0ipI35+uIrhbDDF3SRsrceUgdt?=
 =?us-ascii?Q?MVn03rKr3o8lAjja0E3GADQ29Jk/EN0JC6mb6ycv/IKhZxBeVWY2J+A0t/yM?=
 =?us-ascii?Q?GwJH+8RRiKymuSqqIG1Vip8JVYcfPbyL4vM34drVg8yRAaNaKU0M8QvTvJ/6?=
 =?us-ascii?Q?BkvbIoy0+j3gynQS4l7si2WTa01lddkkxhYRfQkbkPEeWk9TOcp/QFt2677K?=
 =?us-ascii?Q?JJGYg0iQ7FR68WwTOi+7ESC2+7IHX1Ksjhly/oQd0wTd5C8TjqqRgn9XjoXo?=
 =?us-ascii?Q?cUB+R1SIaIWteFj1sj+nm0l4N21NF8hxLzeAlw6anS+Evbi57nLhH4VrKP15?=
 =?us-ascii?Q?U787Ltypre6CX1cWSw7e06nu2H5qUMEMHWaR/Kpk2QMsfLdAhQftzJ2+RXpI?=
 =?us-ascii?Q?pN0J4rP1dFToeloOOx+sBJ0GKuJS2WujHaG1qEBEM75pnnlkd4XZlPEpSvFq?=
 =?us-ascii?Q?QS15PinrDkMsbL/XTlJlqICWn9ZtMOMb7R263q+r5vs5ElIrncVB+67pJGZh?=
 =?us-ascii?Q?TCzzoWu1BnGvswzn4kr4vMqVkY4s5i0ABEtdtBm5VQqlzUez6hUXQ9fFK/c0?=
 =?us-ascii?Q?7jFqyAlqxA+m+bdcuGiwZK/fslYSOWu64o9Qp8w9QPTiV+vKZVGLqLH8yzg3?=
 =?us-ascii?Q?l42VTjFCLtC2dlD9jvuyVQF1DnVZruw3TwRfuenBlbw51wwsfT0KJqkuOGnf?=
 =?us-ascii?Q?hiZpIyXhaccvVWbhq02LZ3fgGRjxoTmHYJBXfyVQMHF9jus9pJ76k3ziKzUd?=
 =?us-ascii?Q?iNXgHQR/hAEDQXntP+IlSFmdRYu30ERPP7qn/ssXe07u2w6OKH+59lC0KEva?=
 =?us-ascii?Q?F92C/1JZFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a512e7f8-685f-4ac4-9196-08ded8513fa1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:40.6305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huYKJAwEUFdqnxs5Rws/YL2TyTTK5/V5XX7ItMumevaE4IxGyHM7Wui+tGzzRLDL9hji4JSvWWzqbpSEX35iOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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
	TAGGED_FROM(0.00)[bounces-22697-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B74E6F9DAC

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
index 744dffa42dee..66197214b010 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -150,7 +150,7 @@ static void pmu_event_read(struct perf_event *event)
 static ssize_t
 get_attr_cpumask(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &cpu_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&cpu_mask));
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, get_attr_cpumask, NULL);
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd69e..10c7a4b5f1a8 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -322,7 +322,7 @@ static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
 	struct pmu *ptr = dev_get_drvdata(dev);
 	struct amd_uncore_pmu *pmu = container_of(ptr, struct amd_uncore_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->active_mask));
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, amd_uncore_attr_show_cpumask, NULL);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b35483e2b70..00ecfaa9df3a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7564,7 +7564,7 @@ static ssize_t intel_hybrid_get_attr_cpus(struct device *dev,
 	struct x86_hybrid_pmu *pmu =
 		container_of(dev_get_drvdata(dev), struct x86_hybrid_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->supported_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->supported_cpus));
 }
 
 static DEVICE_ATTR(cpus, S_IRUGO, intel_hybrid_get_attr_cpus, NULL);
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7857959c6e82..c5f076d20aa2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -861,7 +861,7 @@ static ssize_t uncore_get_attr_cpumask(struct device *dev,
 {
 	struct intel_uncore_pmu *pmu = container_of(dev_get_drvdata(dev), struct intel_uncore_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu->cpu_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu->cpu_mask));
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, uncore_get_attr_cpumask, NULL);
-- 
2.53.0


