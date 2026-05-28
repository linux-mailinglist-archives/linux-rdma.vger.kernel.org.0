Return-Path: <linux-rdma+bounces-21448-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHNDDOmMGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21448-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04825F69D8
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 408BF3136C2C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AEC43901B;
	Thu, 28 May 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Njut1YvQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EC40F8D0;
	Thu, 28 May 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993440; cv=fail; b=G0KhY3cr9XbI1br+HzCluIr+LxyAPkyYrp/0BRiAO3bGgRx9M6NMR7zg2esrqfUwCNlMh6htvXnWLLjYA9jWvLOEwes4ZSXbx3r8JVhFuP6F+8yO3MOxUpC/7EFQuUrrqVX3ZKGrFJi7Cp3wc259LdHi7zitfa2BlRbB+C+jMOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993440; c=relaxed/simple;
	bh=WCREvjXHMIUyZ8K24mU1Lrb70nXQxKIE5OwuFjhsGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8f1oki8o+SiAsrTw4jLTNhRNYiDlgIT1014xJHYmCFmcyJElHLOPjxD5kzy2aV3Bvlww/XOwkeBKRobFjVEq6MX0mDwMq0zt8Hkk0AJ516xX1JsPY/bsekEfyhMNosvYN97J2wlrKFNoccAvs9QX7YOBvhRBNOYZ5/90cTa7xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Njut1YvQ; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1xGx89Ca5cSLIwCDuRTMbXnzMf5LXTbYY8vKffU7TtR1P57zvANRO3XsBbDnsd0dRwXgTGCcBAO97wVf/RXKG54Xe6N01z2jqFcYRwEbrdzhJJ0GS9WF4KVwFRMaiczuJ7HFDzHxQp8qeJIIA6jNTozdRWvQjlh4ZVbF8ToaQ8py3gMaEU9cpjMc4b0nqYI6VNFkH36RNian6ors2sdljDAbplBwtb2JZMtnHDnfn0yLGL1Gth59rJd5t0bX1qBzuue0nx03wsweFtMsOTdX9iob66KNK0Kr+7ix1Y4KQN53XbQeB9zlOG/0VRmSLVWCAHGN631ruDthy7iRmkGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=citt2Z3DhlBsx17DucnrDxqmdrSnVCAY+gbQXan6CfI=;
 b=VeMhAy3pnEa/SrkPQs4OI+j/rhi1AFn2LrSUBTnpdXtl8eizsnZ/9CizSKTA9hRilWJ/6y4u5FA+dUSTjcQKSt5FLKRjvVSUVrR9zx4OhJAmzqybspxdt00TJChx6rz8yIUki46GJOB8JzeMJAWTMpv6CQkzgb7d0yA8iK4wMhQhacW4T+UC+53+wJcCSNstsCgTePkl74EA3vaQH2XqudlO2H31qyCaLOS+3Rq5sVNHwKAbuvstJeK9f2HD3rVj1/bl/Z+Puti52ba6LJ/izxKok0na5G7WakEa/eCcG+xY+GR+kcQCH2FOJ52XT/6YIzX3LFmdyEH2VAZ2Nh+XUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=citt2Z3DhlBsx17DucnrDxqmdrSnVCAY+gbQXan6CfI=;
 b=Njut1YvQ6r5zZ+wGEZ7848mtGuMQFpEVsJeQprBN4lwpGv97FkEF7qcqqbDEhggZz4pg0G6+gsU7E/vU6nZpcjafsuKPE5PAnJ8RKBbBN03HpOOz5VG1j1KmqCkGQf8VhWc7mPQeF1tqTlTb44kVCDXXq0uTuvrMplRg/3NmOxP3nDkSRKdFxAGleW9KxCZaGQHJxf75m0RcPW1crKN54hOpCPKmnLhDuEUFBb/Tnuyima9iJzYLNvwTwhqBy9SgqOWcNuiDOWOOcMrsIOOXP3xbWpAIi/mCUVmiBvGmC8kxquiRGvuFjE/2JuiyAOs0e05mfnnz9EGGwLtIc4GWnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:37:08 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:08 +0000
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
Subject: [PATCH 11/16] nvdimm: Use sysfs_emit() for cpumask show callback
Date: Thu, 28 May 2026 14:36:18 -0400
Message-ID: <20260528183625.870813-12-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: ba912bdd-a0a5-46c2-9095-08debce81f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	BilefxjIA0cB0MP3JqXF7M7wK5bPJcWILpy48zLGMn8iLff/EB/9db4M17oCiPGuh3YW4stOzn4q+Oipou01FIuGD4ZNQS6JqBpMCLhTakCb0yNhdVEGzbGooLVGYr3M5dRQW9vWo8iw778oay+/R/xE0nzT2HUXC02seHgyTBR8kuuxdCpYjwNd36wBkHiC238XlB0K0WP0uSvT/wW0vOggOygTSec/fEwycnP51wLErXJLI8yzI4Qm5aMZ/oG+vo57AUuzY9y34Lo3/ZGI3pnSj1yFhcLSaZRJqb8fR1y6j4AKZDTsbHixFpfBBTwtVE+KlwE0lTTj1plwGGS5XfQWlghVK532i5w6oBnns6Y91FGXojjZi9QLYSx3VIaRYnJ+BNw71nDDvaVNKp8S15LC7VhUlYYN346zS9Xy6M0l5LwjYA3me1m/XNNrIQuQrxPqM6HFCSg7qyFtqHlAYDW3HL5+Lfvc/drwrnG9OeCsxo9FpD4O2Z7bIjsLDhtLVFrQU6UV0tWLCGLLXb8tS8ZZJNIhPiZgza2AeC7pmYVhlRT1NQnwMAgqkVoXVAfhSW7Ba/4TZlAs6Z5CEJ9ZCXqahwNVahtEEsXhj8i1HM/dYjCrw0vUAlpEbRO/h/NL2S0+gZylKHGH8Nx7C/N7SJafgqj0vH4buMI+XHi5FgswetEK98Kc1e98FnvwwwQe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAafLn80fd/cnfHG+sbSsG6SnuGtl70e48VKdQQ2+zpjfyStDYseldVFaB6F?=
 =?us-ascii?Q?8HAenEv2RqG7/HJ0PiQmRsuoMMWb6E50vY4bqqF2rlMpYa97okO9ACTTvMFN?=
 =?us-ascii?Q?dpXDN2oAY4nUYLvjf9h2+yUrzOsoyxf8uAQxM0fovjX1y1zwRN+eAfMidfmy?=
 =?us-ascii?Q?qWBYSu/q6WAHhI1uH9nPxu7/Yd5XSZC8Q2P+0ieSi7xej3wrzuV5G1A12lbV?=
 =?us-ascii?Q?tdyOIKupLt44/COjUfJtZ59trntCZBBgkuKqztncsam6vfNb/5/orLvbGtV5?=
 =?us-ascii?Q?kVarrsglhCvwao+jlLacBhhueNuCvNWOwCS9SMHGQuomlF0c/Y+WDEvWx8Rw?=
 =?us-ascii?Q?Y89C9sitjJQh7ny1tXKNZ2lrYXoB0lJwhcL0zcUVrpuAAUJPQ4Lzl+k1oZN8?=
 =?us-ascii?Q?VTS36SGMQag0Fy4yyJRhZ9gXkdooUpeTvPFfG2SqUOrAtBqrtCTX6dXwWNF9?=
 =?us-ascii?Q?BkePnyP+f3bmX6DraPuJDqv4kKMil7sFKSxoGdwzk56720hXOsyJTITUTRuG?=
 =?us-ascii?Q?wq4oXpJPA7Ur41vZ4uLQdXfVJlUbl3xxBL8+qP2IPYEzjVOqrANebW9mHJtl?=
 =?us-ascii?Q?+S3PHbyxWXIGFmgL6Cd/QBVLRZCA6i6Ah1YthqzhM06AlyEJxGYlY61neDsK?=
 =?us-ascii?Q?fXumf+MQgb5hB8lY6Pr9QqEU6GWMA4AFmrxWMQ2PbVkApqvunOVtCiQGi056?=
 =?us-ascii?Q?a2tOueAk4G4sME4HvWreLgM0OR2mjE5tMkUBDq3xlX30q48J/N1cPL9NhOnt?=
 =?us-ascii?Q?8oK6ge/niKi35WAtZVpLPabfcFk5Pba2IBnlykr4mUzWpa8d6BMgOKuxEIud?=
 =?us-ascii?Q?CeSJ7Nkocx27shSY0ncwpQguVFysUp/wwR2MwVP4LZJkOrF6Patq9JO3GqW8?=
 =?us-ascii?Q?rJzgyZKlUG5Z1tYAdnpoVqc7MMIa8dAI7WN9493lTqjdtYE3hs7uyBNw8GwX?=
 =?us-ascii?Q?XcSrbdGrKrAuy8FBb5GUDy4QZ/DjsedUTEF3soa2YVVyNpTYVgGnnpUOM3+3?=
 =?us-ascii?Q?09D4lp3jqt7CzqUoBCGPPhpoft84qrVnJIP/EYIec0giGSrwLIZKmQAAHPrC?=
 =?us-ascii?Q?Pt19Vy2bUHHgTN1+cUOgTJ7jIuRMTkIyQDA1N66o+JYCSF2roU8hSKqlx42N?=
 =?us-ascii?Q?I+4Vm5Nzj7qf7KbJ5lF5qE3UcvmOtWn3pgUEK3Ov3RFgs4FEpITp2jhP4EMx?=
 =?us-ascii?Q?aM3IOGxIAx8ghM4iai/TgaaJyGSxL+RQ2FQuaQYxJgiXgY/UiaAaHi1GzGYp?=
 =?us-ascii?Q?FAK7loXiB34GSGYDFOpF25NDwgWNbEjNfxFlaJdhoM18tEhHbLS2d1oqq1hb?=
 =?us-ascii?Q?eELTJeH2oqb9B+pObo/Xzp+CVWK63vcsFZFoVlIaaG8v0NR9haMTBbQySBMf?=
 =?us-ascii?Q?sPM93iyCOBpxVtwopbRibgMjV5TaBATYZ/etfACPe7vonB069j4c9f3CHS1N?=
 =?us-ascii?Q?DQNrPWp3bqa1SiLTFJNBCaJbiUDEJIwnfI4bfRyaoolAgx4N9pXbH3s19mK7?=
 =?us-ascii?Q?XArqV+u66cZ8crBODVpCBijyea2ML8Ot4/t0aSyoiV28eNno2nYKcxNmVk94?=
 =?us-ascii?Q?6PXe6IjSoGhP11fj1Vs60eBOvwI4qGJGKgoBvVVciH4tRPF4U6i2ZI7gCOGS?=
 =?us-ascii?Q?yL5vyuQESHXXik+94/xwUFq3t+WLqTurTYPaCxKeUukx2jfREq63VzwOKZ7I?=
 =?us-ascii?Q?SKgLLV7sdKeqs3+gTfFPh6T4hMfCv0eoIn08K2ja5Ehc37BDuUlBf3iMYNyA?=
 =?us-ascii?Q?q/7bO7HP4Dd6QigXV4Vfa3jfpAlm2hRgW1nlCTARMxB15K7G5RxU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba912bdd-a0a5-46c2-9095-08debce81f64
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:07.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weQGPCyYtmi7XveytLN1VLeT8m53ZCN9GNoFmX+MnNICBxrVYhkFRihooooMM8RfgORpRiae6bZDo+GiC7CSnQ==
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
	TAGGED_FROM(0.00)[bounces-21448-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: A04825F69D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nvdimm_pmu_cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/nvdimm/nd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
index e0b51438dc9b..9e497cae65b3 100644
--- a/drivers/nvdimm/nd_perf.c
+++ b/drivers/nvdimm/nd_perf.c
@@ -123,7 +123,7 @@ static ssize_t nvdimm_pmu_cpumask_show(struct device *dev,
 
 	nd_pmu = container_of(pmu, struct nvdimm_pmu, pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(nd_pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(nd_pmu->cpu)));
 }
 
 static int nvdimm_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
-- 
2.51.0


