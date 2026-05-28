Return-Path: <linux-rdma+bounces-21442-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJp5NjOMGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21442-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD95F6848
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0866430E251D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1328423160;
	Thu, 28 May 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFENiK0s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018344218AD;
	Thu, 28 May 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993418; cv=fail; b=IdIlhJkhtdAbtFDlF8aB8I20yR9jnS+ZZ4bjOh0cHzq1LT+bgv+gaAUj/btCZy8/uf8wOOYhRzzI3Ktka7m0t0CG7tzNkOYMc8n7L6IdO8a+YM7nll+S8S1+pJzB/SMyKsBYeGnb/7HZzOglqj1Q5Mwq58sARlvUUFsFJPgHzMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993418; c=relaxed/simple;
	bh=lSL/fjCtq3j29wCGyFWOHB3T4dl/dLxijJW49lpsJUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MY5I6wnkEiMT1xOWuJlfe+2cJ2ovEHrXhqd5rB+Abj/x0fpTnFLOQ+FGXH5eb40hBDrhnbXFtlK4w0l/0XQH2boG2r4Gef4ddBF7KTfKihfXwoxW3Gc93g5mGkYo4TSB4ap5S+N6meBUtkrML6/fNjlqPWPu5/IZyJ2V0GGAqR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DFENiK0s; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw+MISQneVrZo3+5Ug8UygAR39Ma++U7zUJ2c4loPK1BcO30s849hdLJoNFUCKsJpNxY6UplZGDlXw1CO+BanrmOYRw9k3e4HFzcC9YUAMup737exWGYClmJ47/nesjvg56Vrq45hYvggjGBvH7R4JMGBHi9f2QeoOiDX9IU9pid8tN5nbdy50SlnJ/2nPi3NqdIz2UzJ4qVrtP70HH1NG+vDfAG8QPaPpoZoljlillzGOr74bch02ibtyjTV31ijl9S+LPLPd+no83xvlxEwF0hkjn6GtY6KKNkpevbjsSMTg5SG5lWY3YnaMemSxTUkd/Cd4G97wGIv3yZwo4iOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKr/gMejEjCWixK7IKofAiK8+jSXdP7R6KEl5HaygXU=;
 b=j06srglBULQGd9MCUJVnuC7/P7PS24gR0V+VGCrVeFQEKwFwMEj5TEAoMxdriUpr7rIQvgPXSNA+6IhFNC98KPfvYBDbhuC848hNQcbzrD0XtM0f0zjo9rTgHehAd+Lo1pP/9kfZvESXPK0qm5LJgFurP47ZauRqULDQLb9upvKZ2B0SpsqktnxdGr7W/tUdL5DVIkR76aT3MM3F8DKb+eim4/NVn+PEwthGy+H0O53qqRHLnYjNbivP0jk+PJrQecObBgsjF17Z89ZFtT/ZibLnQ5cMSPgQzhMoC+dARrROntmeeL68ZeIaBiv39EqXG/k/0iCmSQ/WmBvEKx0AVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKr/gMejEjCWixK7IKofAiK8+jSXdP7R6KEl5HaygXU=;
 b=DFENiK0sLOj12S8DA6OEe8xj1rfsrpP7d5OIDz36Rs1b3SNMTYO7BV+/KODh5OMHedDTQp9uPLzIlvW1a3hxkwv3J6yMCkC3cf8BiG16sdZFIQV2Gpl9pr6lwqrp7qcwJooDX4wBLXAHZqweJoLf/xjGacJql5XMZqyNse5UVtJ9AGvz1Ev9jIWJUPUfEyoOp90Gvoh1w3YZIQzN01YwraWx73FscQ1tAv4GITK1X8Y+mzBfEIKr0ZwQi1PymBEK8LkEGFPpoTTavPYQxsWN7jkQQ4d+vH+N37UNEsftuZIJl5EIIDjcVzXchpeMZmezYhQYDlcky1oON/C9qegBvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:46 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:46 +0000
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
Subject: [PATCH 05/16] ACPI: pad: Use sysfs_emit() for idlecpus show
Date: Thu, 28 May 2026 14:36:12 -0400
Message-ID: <20260528183625.870813-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 99815e87-a543-4376-40ff-08debce8124c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	fub6qfSD6m8uusAKQ7adogWK63EN1//fd27aJjbwr4W0B7RZYbo2AsaP5Xekve9omDpsrvn3+t17unXqp22hgmzLXXSYytgLQCGDE5beSkbL/1ioi8n7KbLpnmG8dbl2wsqjuMDCM2E1mTczkNyXURq86YOyu8tJGSSCnGwUG35dn6pcVNggN0E3GkLLF/dmF3OvlX+ID8bd9hojjzkJ5X4hqKSqoRZpYXSX0zv95AIRkYlC2eVeAbDNgTTId6nPQkOXHVuw49QQQ9nLvMVQEWzFy/0RSS0yQckX84SzSHbZck357cQJVAp39YDnCXPqTor2He9/N3nrBgMrdduULEuqbkEiCvIS6iuhgzj6XgmB67WBTAR8SX2Q1QonHg5Wg7LAupLQbSMLfxCavbqo1l0vYaYPWplqdTMmGEPjyKN9ghLD05upG27ylnDYSntom3bZsBDfUud26+mYRb693Dwqb3qG1wfG0oGa7BWFezQ0EXNsJuIsk8dSHRDu4qCzpwHk2+iWs+d1fXgwmHUh1sPjaPJKWLgHN6P2hloQJWKa+PExAbEA1A9SZSmdFhC4W/ndL2abWthSAeBGLnBJqoShkNqM+V2tGGSNxkw7mRBSODWpix4CqeFr/QuLGZo6ECaIUy8M+aJPTUjrwzx7XMjtOcTNMmkx1heeE7UDE/9fyqkGgChF6vooKqrs3v7F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X8rKkcFU5du0Iso0ncbiZUZnNlcxYNzGIK3ngPUHBxmTtDPy1zU1uV7neT3e?=
 =?us-ascii?Q?AgThWC0a2smsSaNC9vDFcyl6UFAU6qn+lYob372jUQPnEH0AhkY+HBm2H2uI?=
 =?us-ascii?Q?x6IJx+/12HLWWrcaoLZEqldtzi4A4wkSngPuRefQw1HiRxUy/mzVuHLluQP4?=
 =?us-ascii?Q?2l7s/s1OSwQndgPlYyLp9jR0irz1S0CFOA3b8ZJvr7fGEPESnlzqzXt97jdz?=
 =?us-ascii?Q?4Be0kVt1irEHuLOntJac6mnZm4v3wTTC5XBUCnoBnf4QTZME/X7S3nxj+oJS?=
 =?us-ascii?Q?lfS/aDL5jTkQsaFfRi8KIE70Jr1ncMz8jUMnv4qckoNt48B+/nCbh+z2me8S?=
 =?us-ascii?Q?mb+/VshvED696QJne9QksXGEgQq+OOF8SYlJXaGOiLUrAq2y9ws2JoWp5xLB?=
 =?us-ascii?Q?me/h1qb0LUSselqyXQjM3YgGAgyQsiCkOUO4QpZh1p0U45cnXgCCZcoGvDNO?=
 =?us-ascii?Q?GRPaZ+Qv3BnXgiInuhRjISeRVKw+WfhjXY9s1GElc5cBWGKY/ZEsticPBLIk?=
 =?us-ascii?Q?vYbS3qwC+de7HiXSc5uy3+iTJ4IKcihDq/MpZebdhchckwGriTp7nE4KZnT4?=
 =?us-ascii?Q?0TlpUcgrI0VInRxoqW70OcY5vLtyrK3xyEA+mBqA/Y8AGIxiFdfeEwEWXXZ1?=
 =?us-ascii?Q?6tQIYgBHq2YKDM+BJVYQQaVBsuEujOArb2z4xJ5yVq0iHCeXbYJpmxAS7by8?=
 =?us-ascii?Q?K+jswb0m3/uL38NOlOM9jx+qhFI/GTZyCIVqVG5hm3rBPyCpcdLossXjHtjn?=
 =?us-ascii?Q?HsJJwJLIip76Qjyfay2s0HD7zUUpgN08CoFVqayrqOhncJJa1WXUSjuJP0Er?=
 =?us-ascii?Q?My9Xy4u/w0uLPAS0VjLayGEAeNsGxSuDmLk3YL5hX1yodCLxZaQFusuJTLT8?=
 =?us-ascii?Q?q6RcdV3Ng8YEPk/Hix8UIMGSAQ8+LJfyJwMR8nD+gPQuCyxsAyJLGvP2wehW?=
 =?us-ascii?Q?89kTMamnAya0bKE0rTAf0i4J+81BGAZE4xGeBDLmS5Xlo+cRmBWwD68+4bRH?=
 =?us-ascii?Q?xlKFXj4E/I4Dt2vMuLrU0Ra+4Qzc0prutIYN0aGUR7izNfcdmiQ7FKq6jahk?=
 =?us-ascii?Q?0nI3iW5vJcaed0Vx5t/7i9TrvgHlsy9wmKe0Zs6fvKbw+GwYALD7S1nOxFZ3?=
 =?us-ascii?Q?0GU1xEP887MgXT2wqkF4AjzUOGQ4USUvyi4pjtoHPFVf+IAXVN0ZYGbtjS+k?=
 =?us-ascii?Q?Dd+JsHDIRB6Y5t3wvtp4Lozz2Ua7CSfIxY3sipIta01xdYGpFIM4SEg7rUS2?=
 =?us-ascii?Q?tY3XLh3yCBIGSaM2GaLNkDFP9udtvM1s7ouqx4WV4zsTTlBDWjHt6D77MS+v?=
 =?us-ascii?Q?gGnLWnIOzbLfUgcFUvAMjjNptCJocZm7md3/6XsHMXp+wz90uH+eQMdLtmJ1?=
 =?us-ascii?Q?MYCADh3imsAkbm/LNYBkP8qoPc7y854AP63JwWQFA/EMDgap/F0vUAnKmz0S?=
 =?us-ascii?Q?YmSF7lpd3qMYZQeh8W+jmEhZvhuQ5LWH2eCa7SyeTyk9SwmVg/Pu2fphskGP?=
 =?us-ascii?Q?5sXuaa524tj7KX0PokUtWiHTxwk6RQvQ6344Z8tSbLJhwHG7KGf9mxBLhaTQ?=
 =?us-ascii?Q?5P6pSfg3nvLzoG58t9vUDHQGkNTTUQUVmh5k/DfoJfelWZZ7CHiV+fqqkVbC?=
 =?us-ascii?Q?V6QRvpaoG2/9piqf/BR8icCEBod2TKNswR1gWPtwc49xgkEZPk7igcUqBN1z?=
 =?us-ascii?Q?a92KV26DU0jjfVrDthXgnwFo4XNfz18473Cyb11phYR7u2zuCsmnoW2l6yh7?=
 =?us-ascii?Q?9T9d8NyMJa5I++mDJxLNnv4Ej/FDqNQIO5dxD1uJiyhHQ4N4iVRP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99815e87-a543-4376-40ff-08debce8124c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:45.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL++3yqO1H8nnWwtCBwPdPD55K2M7Mj0VvwOAPyEkx2tJAd9LAchA4x+IZJuN6pRAlvq5JW7Lj6Df/4BMilHJQ==
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
	TAGGED_FROM(0.00)[bounces-21442-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 58CD95F6848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

idlecpus_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/acpi/acpi_pad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index ec94b09bb747..04d61a6cc95f 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -334,8 +334,8 @@ static ssize_t idlecpus_store(struct device *dev,
 static ssize_t idlecpus_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(false, buf,
-				       to_cpumask(pad_busy_cpus_bits));
+	return sysfs_emit(buf, "%*pb\n",
+			  cpumask_pr_args(to_cpumask(pad_busy_cpus_bits)));
 }
 
 static DEVICE_ATTR_RW(idlecpus);
-- 
2.51.0


