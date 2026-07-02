Return-Path: <linux-rdma+bounces-22707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qYadHxyPRmpFYgsAu9opvQ
	(envelope-from <linux-rdma+bounces-22707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:17:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C806FA0DF
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:17:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=A8YZnDcY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22707-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22707-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E4E309238F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F133C518;
	Thu,  2 Jul 2026 16:06:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012032.outbound.protection.outlook.com [40.107.200.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0563161A4;
	Thu,  2 Jul 2026 16:05:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008361; cv=fail; b=M+R38tHUCB1tHhv9aBkivojGp3fdIm2gIUar6D41K7RDGbbDJ6hR5ITDKxyTSI6jjJGva8H7o3thOjaxRHtBGciwZLArM5EUfAgElieHwUI/6gJHPGYVM0/vz+LfHEYf9YU3qjS4pAM6gK/sOGFMfry7zD/0g55lc5XAGobpdeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008361; c=relaxed/simple;
	bh=J2+7E4nAtLBdGmR2XnhEnshIy9e2iTvE9iNmIcPuENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RE/xvHgtd61eW6pTWYWH2gJr+Ip4eMLeTmMr1VCm+UNrK9Y8+2tu1VDyzbCLmoDvgB74ZcTVyoY5sFMnmIHROvKk6fm1S9LQjdACqfyK/v9qosTOWK3V0D+8LIW3VMXQdSXDbYyXwxFJUeYaL8ZOfRIp1xzcXfbFQGH5NoamT/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A8YZnDcY; arc=fail smtp.client-ip=40.107.200.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfGfXRt/s7NY3+iLF3g42aZDC2ZApDBAJtj9rCdvzqu8KM/RhmlGmR+XVpvRGRjAWC3A/kSeXNnn1c3sLgIh+s17ZAHbTARTY3LK9I9fGDfaSmwWcEUFUWS7K19HR9XSqr0HXeqDrxK9Bq9p0Tw6ky/iudSchZifIBa6i8mBdc7aff5h/Zr6ohUQyQ1oTVlfd0v6KNOW4zq1/5WxtgGF4OdGxO4mPy9Gh0zZwiHC9J1Rk3ts0+mphTsS8gLtjUTE9oe2Tv94XMWxi7QvxAFD41CZoXaUpGAo25VLleCKWYgONbZnQaH1zetVhMLjQ2DVOXojlmvdy4rpAkRBtJtVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb5/w1j+O7NmmHE/vQJFbC8aSTx7oM31onkPhnOCb3o=;
 b=fd03WInRcyefPoZuxXETcvYzp2hMoG0cAwJoSAremaeYQ+YlT6u5OVjXY0QwVYVDzAGSk56GIzJ23HW3+K38uu+bp2Rhg8vTMdRuCDYWbIxyeSaE/hpjsE19k+LwEorHGVxtwwG4aA+W2dDcvVUMbHkxDksDwJYny4kk7ZNzjxzkrRwAY2h+f6iyvXF+CPjhFgy6zXieG0OdnjqnS6iuxjYvA2kekiZOyqiCS2fTz+noxouudAc55zO0Qwc0oupYCjaLSGwY6PSJGWzdzUBvQEXSahePVyRiIBESld90/gSDU8wNuQFhCnFo6dGgasnV1rPhD5PDId5SY2KvHfg/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb5/w1j+O7NmmHE/vQJFbC8aSTx7oM31onkPhnOCb3o=;
 b=A8YZnDcYZHrVqcDSi3GIbP2/zki+F6MZ23eb261H0DBbL/17fInTkQIlOxfyDTYWiOgXkuQkAC3hpiiw4b26zMtKnIEhpYvrmJ3kq/cbRyt1DIK2qhk9IU8JAfaQgfYAOEoRndQvoxBvkHYC1aF12GqYF+3N7nrRRnQiuLYdSILjrOF30zIeELxjNuynfJX1+VWQQEYfd9cyf8v9mZXABxOoGXXenyCy8gXzi/64EFubMi+guGNellsWEfCQkghoaiA9Vux9pfySQdiXygs6yrpLh5VdRNcITq/8R4BdD/AlrtxLcfRVHPWkKxuH/YqTlnPud/l5zkMOt4TcxgaIhQ==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 16:05:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 16:05:39 +0000
Date: Thu, 2 Jul 2026 12:05:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
	Danilo Krummrich <dakr@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] arm: Use sysfs_emit() for cpumask show callbacks
Message-ID: <akaMUHFG4yYciZSJ@yury>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-2-ynorov@nvidia.com>
 <2026070244-flier-large-17d1@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070244-flier-large-17d1@gregkh>
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c362a0-4d46-4dae-f7b7-08ded853c26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|4143699003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	t4hzXNkNSTqXLzpLpeuFtAoluuCHk0YVxC5cBGPlDe7FrU1E1WX2CgNzPFyiiTbNxSN5FRco6X29R4PryBXs1rbUn2Ae/n4Y79buSunQ4NbBMIwi7c+eI2ZDbAbYjBxcCtEmPu+AnzhYPgCJohxx+pp0vHJRp7ZMluIpJ30KdXXGgmIFpXADkOuIPM1Q5OdKI7g1+O/Nv82j4g0ZjZy8JaBeXB/CO9nnqgfthxq324FW214ueUN0yd6WQHF1LEKbOHhdzoEi0fO2xY5wKL3AVLAkVvqtwZ+6XIwZtkDPPmj4ivuiblRT7ll/4238s9kECFViObPTCGEpfBemR62RtIkGGKSwEyvBSSnAyb0DK+GxKh4XpzHHbzo8fcfANxjbyQlNioYrGl8y4nVePXDHTf6lr4oJiPKG+zvCtc5TqOl6Sgk037jFhumLmNa1wRwSr6W968C3A/Zsqr5PQ/g+TGXb9nuGJ46/hJm9yHbYPyI66WrDXdcp54mUnPLc1F67wrQVxAPELKsQHb5cuwCbjvmxonNeviTElNpTKCb1lTTHv0A1lq5zoWoccXOms68TTmlPIbDSO1IeHOQ92It92URErC9Ak89EmMhXSRgHfDhRbUbPQ9uXmUpMTFb7N+Yjgy7nwwMa0hzb/QCLeI0crm1w4P4bvhhv91Hddi5yXF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipiqxxVQQv+tpWu4Q8AibhsWk5CjBCqpLpi74aYnC4Rqzz2c01ijb8epOv0b?=
 =?us-ascii?Q?AePBGzTZ175wIHPLeaEOcB/3WZzuq3u2qNG3PhxuXG/zcPeQXYbmnf2fdGoJ?=
 =?us-ascii?Q?2Q9TjSwyPLhQEG06mkiD5TCVeLpkZDTX2OYHgQ0Toa/f61gyYSUjlyu7jWcP?=
 =?us-ascii?Q?XVmNsx7WdkxFjIFcpvRX3lG0PLCNxY+JKrStgmgZNaXixO+1G2XwPImN9+3M?=
 =?us-ascii?Q?vBIOYxaYvwYpbqVE9uq092LxkLurB7BJNfXrLWAafiUeLgaKWLdCTmogkQqm?=
 =?us-ascii?Q?3bpDiHuMSx9KfK0M97kQgMIk7sOzDkzglnKDlBDLhXDmnmQlbofsl2gh9um0?=
 =?us-ascii?Q?1bat2nELU6qFZ5v3GJwYlNjbgW/QMyGTf6SCDWwqCUxyBxwEsWbGBajbeS31?=
 =?us-ascii?Q?y1T3P+I5XlAGH4TsSppPmKPau81JSboX1XTgXQIsvH57bNv9dwpeRnY8SiPA?=
 =?us-ascii?Q?ETyf6qsEZ4T6hUe9KxyCd+rOPNA7u6jxfBuNgiiWHaXCmPjKsMy4sp4qy+M4?=
 =?us-ascii?Q?OneAQt+DJ3qa66xCImeIYxX57RoX4zMdjBx4Auv2hYTgfNwc1W/xCk1pfqCy?=
 =?us-ascii?Q?PbdtfUed3P/POQQfkC2KfVRf3wdThW7apzbbbuNqT4ZmlR/52YNj940MXYvv?=
 =?us-ascii?Q?x5HFxp4HBFMz/HlQNJEgUKMyKyuJS77fT142SxkUEbXfcAu5yfMpbgZg/pBy?=
 =?us-ascii?Q?QVe98T6FyMABYE/4DhvAFyiSga0KCPOtEswVZLybnMu/pbbRE6/fX+/daIXT?=
 =?us-ascii?Q?Qp3/5pLGXIBW32egegcH294+3CrzotgsfxvN9uh9G4FRq/XkVdsZIMhUb6WF?=
 =?us-ascii?Q?POYjlhJ2zJyKFxeDMa8yQJdTFLpZZE7u8Yy1r/HStJd+QyEvyFXqoeFJNvaJ?=
 =?us-ascii?Q?8aLKwYHZLk23pIqHeI0sggyQdCLkWg1xUtv9Z0iAJHsD9RCKswoXyQANs2Lj?=
 =?us-ascii?Q?Ow9mmk0PEjC1sMaKUL+eIe6YfiBLkLm21/WMWSi7evglXgIvKqsV/9APAat3?=
 =?us-ascii?Q?rSK+nrY9honl93jun0euS6sXGhVOjDZ+43/PT5+f+tn4MiTiJm2GOSl5XQmw?=
 =?us-ascii?Q?/QOAnxR/L/K4i9Xo5MC3qmrNZgcMEq7Wbx7mgzobZpXZWUDIhhtHz74s+FF7?=
 =?us-ascii?Q?qB/DsFLzloG8ZAY7PNJXYJ/WPoOzwc6qDf1jjLTSZX4Q/QQ9Z0w+45gySdvG?=
 =?us-ascii?Q?NJ/lmoEYSEaWpwdGYNlrvRPYshq+s50kzMT6OlaQjRe+87nCINZtwH5HLPlq?=
 =?us-ascii?Q?eLmxpxgIDBkqJL6GGdxno2IKZvzhb4Do4lMuFyVXq5rliCwa9SK7yzg18CZq?=
 =?us-ascii?Q?asy+vFbT9uZLjisrCyf8bUs92mVDnRmgbE41JW1KGBaGLCsQ/PlTs360IYZ+?=
 =?us-ascii?Q?VOULoPLgVdjxt7KsRSbP2IjNvGlwlP4ijvz7aCJmE7NTZH4lX1u5kkLyjgsL?=
 =?us-ascii?Q?BQdSFGFVpS8lPCSSibaS4gCoi3V/Wv99GEvVkxgPVj4bIBNQKYdwmQqmOnfZ?=
 =?us-ascii?Q?J4pLmwuKN3/b5BlgoQjMHOYCeky8MtYk8BTXbZQqCmHRjCain38HjuXszBSx?=
 =?us-ascii?Q?FpP35cdWVCX51Na0HswpjlfcvwlUlwoup6IzvwuylZWd89XUnxd4VALVMwzu?=
 =?us-ascii?Q?nghs/e+58MaosedmzjSmjUeUmeesB69YKRKB6wrfXL/v3s4BVFNmootJoz+Q?=
 =?us-ascii?Q?WZFPV85gGnao+Au7ac8fBIh/7SCSprhFKlAPgKiajnXFiyfx73k5MSyC/lVP?=
 =?us-ascii?Q?rRxyBVv2iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c362a0-4d46-4dae-f7b7-08ded853c26b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 16:05:38.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlmgdzxtUMvJNkF4GRxsJUcWLslzHnt7ztCOFPDBh4uQqp/WFK9Tnf8MmKSwFswDadDS44iE9UD+qjy9VCLAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22707-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:akpm@linux-foundation.org,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:rafael@kernel.org,m:dakr@kernel.org,m:cw00.choi@samsung.com,m:myungjoo.ham@samsung.com,m:kyungmin.park@samsung.com,m:heiko@sntech.de,m:yilun.xu@intel.com,m:trix@redhat.com,m:mdf@kernel.org,m:yangyicong@hisilicon.com,m:jic23@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:bhelgaas@google.com,m:xueshuai@linux.alibaba.com,m:will@kernel.org
 ,m:jiucheng.xu@amlogic.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:robin.murphy@arm.com,m:renyu.zj@linux.alibaba.com,m:xu.yang_2@nxp.com,m:lcherian@marvell.com,m:gthiagarajan@marvell.com,m:jisheng.teoh@starfivetech.com,m:khuong@os.amperecomputing.com,m:yury.norov@gmail.com,m:kees@kernel.org,m:thomas.weissschuh@linutronix.de,m:aboorvad@linux.ibm.com,m:ilkka@os.amperecomputing.com,m:bwicaksono@nvidia.com,m:make24@iscas.ac.cn,m:fengchengwen@huawei.com,m:ritesh.list@gmail.com,m:wangyushan12@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-perf-users@vger.kernel.org,m:x86@kernel.org,m:driver-core@lists.linux.dev,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-fpga@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-cxl@vger.kernel.org,m
 :linux-arm-msm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,rasmusvillemoes.dk,armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[80];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35C806FA0DF

On Thu, Jul 02, 2026 at 05:58:11PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 02, 2026 at 11:47:14AM -0400, Yury Norov wrote:
> > These callbacks are sysfs show paths.
> > 
> > Use sysfs_emit() and cpumask_pr_args() to emit the masks.
> > 
> > This prepares for removing cpumap_print_to_pagebuf().
> > 
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  arch/arm/mach-imx/mmdc.c     | 2 +-
> >  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> > index b71467c48b87..f6d993b9b1d4 100644
> > --- a/arch/arm/mach-imx/mmdc.c
> > +++ b/arch/arm/mach-imx/mmdc.c
> > @@ -127,7 +127,7 @@ static ssize_t mmdc_pmu_cpumask_show(struct device *dev,
> >  {
> >  	struct mmdc_pmu *pmu_mmdc = dev_get_drvdata(dev);
> >  
> > -	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&pmu_mmdc->cpu));
> 
> Really?  Looks like the original is much simpler to understand, why must
> this function go away?

Because it's a duplicate of printk("*pbl"), and nothing is simpler in
practice.

Because the 'true' vs 'false' parameter in cpumap_print_to_pagebuf() is much
harder to remember, comparing to "*pbl" vs "*pb" in the standard printk-like
API. And because the 'print_to_pagebuf' has a record of misuse.

For more details, see:

https://lore.kernel.org/all/akANJ-AT7nHpRMq-@yury/

Thanks,
Yury

