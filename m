Return-Path: <linux-rdma+bounces-21450-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLWoDDaNGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21450-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:45:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36495F6A78
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFB3030759F9
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43743D4EC;
	Thu, 28 May 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyZ1Qy40"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8641C2E1;
	Thu, 28 May 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993449; cv=fail; b=RBx+Cf6j7VUUi+c/2Byd4ur5HL5SwVGtD7+lIVY6G+nlLcwjn7e1Bqr+8hEII+6L/5WsPtmjamYXVenfRE1m/WNN2BmoryLKCJb9IG93nU4nbIxodagT4JIG9SFzIA67C2gLzi6/UjXKUmFHW8IJly6Vsx5UxVwsC434GRTPl7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993449; c=relaxed/simple;
	bh=jMzYKTYx5mThSvW7fgLF5BqiwTGWxhTHq01IO7JWxZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8i1nQX9kQfHePy4l0a3aMd1gaGirpXl0RuC2/6/UtwsrviurRyUjAzN/xIyWlfXDQzObMZhdPPssnGG9jSBT+a0GfdqIE7S3AveAUntvmsDhHYZP86kBPK5DQvHRnQMAmvuVn7DVJFbz1cRf4nAKaVjwVnLaAQW2IZEgo67CBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WyZ1Qy40; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9VbW9kFyaGs/NTKNnnEqXJUWCXJSlrq5NMakpODPg9kq7H6Mepiww4pr6XqE9EX7+GwijNx5Rdu01K8M5LvKfDriOQvlNfvYBWFE6OirGadaduNUfcvpLa4rW+66pdieaKt3iuJDj3BE2ECt1DEdB/2Yl589aC1duZS+tImfaVJ+pzBGowu8eiiav7BEKkFHe8gvsxK6P+FClRYy55iUTrjdU4zkIbecwneX1y6UVuBbh/b1clApf7OZIYh9F469YSVqCuLsQbqOTNycM0LSd1YjsEKWGg1gXLvPER/ygMAV7LtpjE0bqdEYHheYohoIIwQ+btdRcs4O2s/3jO3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkDJI63elFZNwCTpiJH2hZo9e6EzPU2HpmeVM2Wrk/g=;
 b=NFQdTtoSZc7N52bu4rHuNzyD5EPcDdo+2d5P9zcqbZvxfT6ypUQY0IfULeLgLDGNa/XPYhfgJVyvpjnR2WpxyE1RtUr9isRta7Mr17qPfOGmqQutNHSNhvNw8zrKcipcYsbIQyODDL8keJLavCpxaG0zHHiZWya3xThOL93HbOLeEmmOzZLDrSdAGv+3PKIdUNvm6POBDHNJ1tErgPJ4aiG7L/NbbznRh0dYNtQhSwk5lHg1OQvwX5d75pjg+Sij8xSbnrhk7SZSe9oeHpqU0NSlSYVtOVVK97H6MIvFp1AATO9dXx9jdIoOyqZZJys1Cfj8/SCgiilO/JsXQuuduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkDJI63elFZNwCTpiJH2hZo9e6EzPU2HpmeVM2Wrk/g=;
 b=WyZ1Qy40wWenrydbffosxdGAQn5z1hyWAPIQssHqE7xVoYUw7GJzuzEUVlTTIrRKONzhioGB2tUg8TZFu3D3eiv+bd/jof4vM8UszGZPWMHcwaO0JukY65DWp8ZwLLXOX/tU7KE92lRaos8GgdCNqZtPU2QnoZHHNaHjyCFBJcj2xlE6LNCAFPiY4I771Y+MgSPDbcQlxNxl69jiPfZPuVlSdmh9HNney0cCU8XiguRNXIepUOJ7+sk1kQL1LXcKjQoPTHdpJ2CmAD3zs800NG5hxnwOclxDgbWUReHLVnJW2RagzihfxfV15ykK/HCyvGTW020lNqm4GHnmbmWzFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 18:37:14 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:14 +0000
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
Subject: [PATCH 13/16] perf: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:20 -0400
Message-ID: <20260528183625.870813-14-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f1790b-2245-4539-a945-08debce822fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KBUHHfgeyqR6T3SeD+r6/8QwfZOMEkmgA76wiKC1tHotVF51jSE6/HQb2vsFTXKR/H7b0Oc2Ysjb566EeMUfq5GQM4D+uHy/ebTx4ukQKdkADCDYU45QktOIgzDlFxuk2MWb0pc0chlS14ieNz6udGHOtcbbuhfG27KilRVLvb5sMdUMGRqAzIkRAfNBcvw3gmnbPFS3ta+BKAWUEK6Iiy2xVqhzkmtXIYd0BvHSBHy8eDayH/4aRyZpGJKd1PtWUrrzRYJ9j8GteQV9Nl7gAKliy1CZUoF8mFc0ftt7sarnMJx00twS4/xcB4raZswTYnRvi3zqkP6svB7MJb5gP8eGzlAHLrn2PPNLoipor+FcqB+erpAuSe/6A2p82m0mz70GgblsFdnV+E8hM+2OzpPkCyTvFbh3elxcfssIxiEOJdgY0t70Sx8xgF+0ZY/kFeTnr8sXvE/Dvxh9LQ3M8jvwMe9yeT8aYqCwI5b7FQ/bebYkStmEgII/usON/3UDm0XizfywRMbbzyWRqkF8WRcp7ZI6u3IO8mqsFatEHyR8l2YFnQHjqbUjRbFQkxtoD2uCSqDQdpOWVh0FUoS19E3ZvL2rFpVT+p4czeoneCNpGUD4MesCN4BKqTviquAfa7wad7Xfy0j1HMqlVvvfB+cB+SOcxeVgqr+5LQR72dSwlxIwioJCH3DLD3DTgOUl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ydq9v2ssynv7Yt6zAp1M1k4euREn6otEqWLwX96LoahGDeea3WOY+oTnvIyd?=
 =?us-ascii?Q?qy6ErbCQdqATcsVEIb2SvpYd5L6O69Cg1yHmvv53LtuBDr5IX8LkfMAw/FeG?=
 =?us-ascii?Q?N2euaUF2U8+wMfS5o/yW6tu2DDi16QzJ3CPbNo79GQngeOGe1H2IPccmCS5e?=
 =?us-ascii?Q?Dv9RQcONIMZCZK3jXrjwof+kYdZ9pM/oijlihQaMKcgLdPRbj3l0JYwtBBkj?=
 =?us-ascii?Q?bnW8VoeK0M9NFZfwQajZxd3+OqEAAgqbaFr+7v3sWN9Lb3eMYF/aDAxT0OB1?=
 =?us-ascii?Q?DRNgU1HVSB9BnYnGuNWovBbCyCM2ToIMaC7TIVEsKNdPkwLhHD04QERVBPkw?=
 =?us-ascii?Q?CfTIqJyxoEaq0b+s3aa7VE920NHRRHUCFLcD1V5rGsDUyCD5WBNzuGz15/uB?=
 =?us-ascii?Q?WNQKuPAn6tBrbWo99U6OZTxJqraqMM0aM9eLxfn+RvUOkYT/qTXfIhKggYgt?=
 =?us-ascii?Q?1zE8pwDA8u1KdE92t8/mBNXGtjrpiP3lOWtveLB/5pLoLl8GyVXKU9ljdoa0?=
 =?us-ascii?Q?3PimIZNx7lFWs7gBn0+cGq6D4DY6yOhBJmcFnsnkrEPKrO9oOP0o1S9zQk2d?=
 =?us-ascii?Q?gh3NS87ZkZtzYAkCljqLO8ixLO6yYJ/cBpcHlqLOHCZ+IEJ4vPNppyGwL5Vt?=
 =?us-ascii?Q?v7cvtOocVPuVp9fJsvNeTEm2asotB5qa5TU+AByDiIBJhxQcPCQkBFsik4n+?=
 =?us-ascii?Q?jnWeLa0qlwUZVoGoxUz0T1BWAUjoWBf2l+QBg0ziFWBD6Nva4ugQlsUJqqu0?=
 =?us-ascii?Q?APhpuCtQXNzKWvHbBC0osjVVsHLdvppP8PGfeoe/8RzYirMmRRB5zlqjgKqe?=
 =?us-ascii?Q?WRFez0WL0DPVHxpUy++B0Suz2ut1tEejcL5bYrHSgyXgyS/+U4B88EcuJf18?=
 =?us-ascii?Q?ovKhYui447Det5zSJZW8ZlatL+pbo+e3KHihJw9oloeKCxUcAtY83S2fU1+3?=
 =?us-ascii?Q?dCbwRbMhxRQBUoz4J7DCkyUP13QDA4f5s0MRft6/zVkaNUhjxvIcDcwSoE6e?=
 =?us-ascii?Q?zaOQR7jj72HF5MQsrK3f/2q5RePLrQ4LO+jJ8SWhLN64VUbYjhn1zHFY9T2z?=
 =?us-ascii?Q?wO1TXcF6suYBZmAMkMtvwwvZ840tmrBxSMPMgMmiA+t62zTkd+6Wh1B13HpY?=
 =?us-ascii?Q?oJVpgwrl9DACsBR2ss3pNbU1Qs0gGOZOO6zaoqsMfO3LOiqAaGlJQghLVa1I?=
 =?us-ascii?Q?kOB8PQ0k9+Xb1D4LZZfBavKG3WijXsVgCn5OXiWafH+RuYfbSKo/u7+10OZL?=
 =?us-ascii?Q?nItAN/uDb5DlVuvdXG727joAolwKUxr4SMDMvFH98Ct/F3HwTsZzAhK/wIHu?=
 =?us-ascii?Q?11TCGpZd+h9KXp6O6NjQ7ACKg0CHJ8ZK6d7jVXWT5Wf5KZxr1BgJvoBlYd33?=
 =?us-ascii?Q?hPUWMy6tZe2qYbxu7IqHxNEkWXhy9nOTB1B5g+DUtQl19bxwh4jbFmNzT1mQ?=
 =?us-ascii?Q?MQTOKgQk91VRPgd2gr2IC9aqxnO3ux3X3f/Goadn5fhS41vO6+sBDqEge4Yo?=
 =?us-ascii?Q?b72aaizqu/ci4SddcQc2Mr2XRJ436uWpBQZgCDmv9vSewmM+wmEy15CV/bHc?=
 =?us-ascii?Q?VPq/wRWkE3zS8X+291lxaL2Gv1F2kWycIoWJTO3mpQKZfkN2pab8BkT/GmR9?=
 =?us-ascii?Q?WhqK/sEfocpvs36f14AWrz4iOg9Moh0A8iHWza2ququzYjSd4PGYJpoQWRJd?=
 =?us-ascii?Q?EzITUZla+pY5WsjHRgO27NGJei9AcOpJbIU4vyXbJDUcgBCQXVSVNh1dlc05?=
 =?us-ascii?Q?jRHBmPuzHcPWGG/D0a5Li816CY2yaXTvXSQTWVMtQtbFs1ivNYKA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f1790b-2245-4539-a945-08debce822fe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:14.1718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot+YDpC1DloOA6aQ0PGDF1PCvYQeAad3x401DjtFK4SeqjtseHUq6VqZxKRUJzsw+wbrRGMFUURN6GF9U5qr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
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
	TAGGED_FROM(0.00)[bounces-21450-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: D36495F6A78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c       | 2 +-
 drivers/perf/amlogic/meson_ddr_pmu_core.c   | 2 +-
 drivers/perf/arm-cci.c                      | 2 +-
 drivers/perf/arm-ccn.c                      | 2 +-
 drivers/perf/arm-cmn.c                      | 2 +-
 drivers/perf/arm-ni.c                       | 2 +-
 drivers/perf/arm_cspmu/arm_cspmu.c          | 2 +-
 drivers/perf/arm_dmc620_pmu.c               | 4 ++--
 drivers/perf/arm_dsu_pmu.c                  | 2 +-
 drivers/perf/arm_pmu.c                      | 2 +-
 drivers/perf/arm_smmuv3_pmu.c               | 2 +-
 drivers/perf/arm_spe_pmu.c                  | 2 +-
 drivers/perf/cxl_pmu.c                      | 2 +-
 drivers/perf/dwc_pcie_pmu.c                 | 2 +-
 drivers/perf/fsl_imx8_ddr_perf.c            | 2 +-
 drivers/perf/fsl_imx9_ddr_perf.c            | 2 +-
 drivers/perf/fujitsu_uncore_pmu.c           | 2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      | 2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c    | 2 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c        | 2 +-
 drivers/perf/marvell_cn10k_tad_pmu.c        | 2 +-
 drivers/perf/marvell_pem_pmu.c              | 2 +-
 drivers/perf/nvidia_t410_c2c_pmu.c          | 2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 2 +-
 drivers/perf/qcom_l2_pmu.c                  | 2 +-
 drivers/perf/qcom_l3_pmu.c                  | 2 +-
 drivers/perf/starfive_starlink_pmu.c        | 2 +-
 drivers/perf/thunderx2_pmu.c                | 2 +-
 drivers/perf/xgene_pmu.c                    | 2 +-
 kernel/events/core.c                        | 2 +-
 30 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index ac49d3b2dad6..74786a5dd6a2 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -221,7 +221,7 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
 {
 	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(drw_pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(drw_pmu->cpu)));
 }
 
 static struct device_attribute ali_drw_pmu_cpumask_attr =
diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index c1e755c356a3..f614aa3434a5 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -191,7 +191,7 @@ static ssize_t meson_ddr_perf_cpumask_show(struct device *dev,
 {
 	struct ddr_pmu *pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
 }
 
 static struct device_attribute meson_ddr_perf_cpumask_attr =
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1cc3214d6b6d..f0ef0a679e74 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1351,7 +1351,7 @@ static ssize_t pmu_cpumask_attr_show(struct device *dev,
 	struct pmu *pmu = dev_get_drvdata(dev);
 	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cci_pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cci_pmu->cpu)));
 }
 
 static struct device_attribute pmu_cpumask_attr =
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 8af3563fdf60..d5dcb4280434 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -538,7 +538,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
 {
 	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ccn->dt.cpu)));
 }
 
 static struct device_attribute arm_ccn_pmu_cpumask_attr =
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..2187ba763b72 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1326,7 +1326,7 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 {
 	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cmn->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
 }
 
 static struct device_attribute arm_cmn_cpumask_attr =
diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 66858c65215d..03a1c6bf9223 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -239,7 +239,7 @@ static ssize_t arm_ni_cpumask_show(struct device *dev,
 {
 	struct arm_ni *ni = cd_to_ni(pmu_to_cd(dev_get_drvdata(dev)));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ni->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(ni->cpu)));
 }
 
 static struct device_attribute arm_ni_cpumask_attr =
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 80fb314d5135..e6292021f653 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -305,7 +305,7 @@ static ssize_t arm_cspmu_cpumask_show(struct device *dev,
 	default:
 		return 0;
 	}
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 
 static struct attribute *arm_cspmu_cpumask_attrs[] = {
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 4f6b196160f8..467147a05eec 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -237,8 +237,8 @@ static ssize_t dmc620_pmu_cpumask_show(struct device *dev,
 {
 	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf,
-				       cpumask_of(dmc620_pmu->irq->cpu));
+	return sysfs_emit(buf, "%*pbl\n",
+			  cpumask_pr_args(cpumask_of(dmc620_pmu->irq->cpu)));
 }
 
 static struct device_attribute dmc620_pmu_cpumask_attr =
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 32b0dd7c693b..bcbd19e075a5 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -157,7 +157,7 @@ static ssize_t dsu_pmu_cpumask_show(struct device *dev,
 	default:
 		return 0;
 	}
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 
 static struct attribute *dsu_pmu_format_attrs[] = {
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 939bcbd433aa..51ab6cc52ca0 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -570,7 +570,7 @@ static ssize_t cpus_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(dev_get_drvdata(dev));
-	return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&armpmu->supported_cpus));
 }
 
 static DEVICE_ATTR_RO(cpus);
diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 621f02a7f43b..8ce34e6bb82b 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -537,7 +537,7 @@ static ssize_t smmu_pmu_cpumask_show(struct device *dev,
 {
 	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(smmu_pmu->on_cpu)));
 }
 
 static struct device_attribute smmu_pmu_cpumask_attr =
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index dbd0da111639..9f786fd48cdd 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -343,7 +343,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, &spe_pmu->supported_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&spe_pmu->supported_cpus));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..0735eb33f5f3 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -493,7 +493,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_pmu_info *info = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(info->on_cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf..291e776d6f6a 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -117,7 +117,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index bcdf5575d71c..3760ebe02674 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -237,7 +237,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
 {
 	struct ddr_pmu *pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
 }
 
 static struct device_attribute ddr_perf_cpumask_attr =
diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 7050b48c0467..6fee5eb5087a 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -159,7 +159,7 @@ static ssize_t ddr_perf_cpumask_show(struct device *dev,
 {
 	struct ddr_pmu *pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
 }
 
 static struct device_attribute ddr_perf_cpumask_attr =
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
index c3c6f56474ad..a07877632d53 100644
--- a/drivers/perf/fujitsu_uncore_pmu.c
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -374,7 +374,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct uncore_pmu *uncorepmu = to_uncore_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(uncorepmu->cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index c5394d007b61..0f55d871c67e 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -121,7 +121,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, c
 {
 	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->on_cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pcie_pmu->on_cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index de71dcf11653..0ff2fdf4b3e2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -56,7 +56,7 @@ static ssize_t hisi_associated_cpus_sysfs_show(struct device *dev,
 {
 	struct hisi_pmu *hisi_pmu = to_hisi_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->associated_cpus);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hisi_pmu->associated_cpus));
 }
 static DEVICE_ATTR(associated_cpus, 0444, hisi_associated_cpus_sysfs_show, NULL);
 
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index 72ac17efd846..8681e8715cb3 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -364,7 +364,7 @@ static ssize_t cn10k_ddr_perf_cpumask_show(struct device *dev,
 {
 	struct cn10k_ddr_pmu *pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
 }
 
 static struct device_attribute cn10k_ddr_perf_cpumask_attr =
diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 51ccb0befa05..54909d0031b7 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -258,7 +258,7 @@ static ssize_t tad_pmu_cpumask_show(struct device *dev,
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tad_pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tad_pmu->cpu)));
 }
 
 static DEVICE_ATTR(cpumask, 0444, tad_pmu_cpumask_show, NULL);
diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
index 29fbcd1848e4..cf1d8cdb1318 100644
--- a/drivers/perf/marvell_pem_pmu.c
+++ b/drivers/perf/marvell_pem_pmu.c
@@ -164,7 +164,7 @@ static ssize_t pem_perf_cpumask_show(struct device *dev,
 {
 	struct pem_pmu *pmu = dev_get_drvdata(dev);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
 }
 
 static struct device_attribute pem_perf_cpumask_attr =
diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
index 411987153ff3..bff875f4f625 100644
--- a/drivers/perf/nvidia_t410_c2c_pmu.c
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -658,7 +658,7 @@ static ssize_t nv_c2c_pmu_cpumask_show(struct device *dev,
 	default:
 		return 0;
 	}
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 
 #define NV_C2C_PMU_CPUMASK_ATTR(_name, _config)			\
diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
index acb8f5571522..6c8e41598ec1 100644
--- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -501,7 +501,7 @@ static ssize_t cmem_lat_pmu_cpumask_show(struct device *dev,
 	default:
 		return 0;
 	}
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 
 #define NV_PMU_CPUMASK_ATTR(_name, _config)			\
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index ea8c85729937..c0c522b10b72 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -638,7 +638,7 @@ static ssize_t l2_cache_pmu_cpumask_show(struct device *dev,
 {
 	struct l2cache_pmu *l2cache_pmu = to_l2cache_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &l2cache_pmu->cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l2cache_pmu->cpumask));
 }
 
 static struct device_attribute l2_cache_pmu_cpumask_attr =
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 66e6cabd6fff..c8d259dd1f80 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -663,7 +663,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct l3cache_pmu *l3pmu = to_l3cache_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &l3pmu->cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&l3pmu->cpumask));
 }
 
 static DEVICE_ATTR_RO(cpumask);
diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index 964897c2baa9..222a0a34e211 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -131,7 +131,7 @@ cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct starlink_pmu *starlink_pmu = to_starlink_pmu(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &starlink_pmu->cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&starlink_pmu->cpumask));
 }
 
 static DEVICE_ATTR_RO(cpumask);
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 6ed4707bd6bb..a69c02d2d874 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -254,7 +254,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	struct tx2_uncore_pmu *tx2_pmu;
 
 	tx2_pmu = pmu_to_tx2_pmu(dev_get_drvdata(dev));
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(tx2_pmu->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(tx2_pmu->cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 33b5497bdc06..e9e4871db08d 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -595,7 +595,7 @@ static ssize_t cpumask_show(struct device *dev,
 {
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &pmu_dev->parent->cpu);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_dev->parent->cpu));
 }
 
 static DEVICE_ATTR_RO(cpumask);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944..61689d348abd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12657,7 +12657,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
 
 	if (mask)
-		return cpumap_print_to_pagebuf(true, buf, mask);
+		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
 	return 0;
 }
 
-- 
2.51.0

