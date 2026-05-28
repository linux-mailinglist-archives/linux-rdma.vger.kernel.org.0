Return-Path: <linux-rdma+bounces-21440-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ7PLOuLGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21440-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:39:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B35F67B0
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F69E308DCE2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF041C2F6;
	Thu, 28 May 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XQiBuqIv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F940B6E5;
	Thu, 28 May 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993414; cv=fail; b=DSZiTwJc0DrpZ04vQLhn/OmezH8ZQFgcbToEKBmbvYOHXBJCOrWfIAVW0JFenc+LEX2Rtt75rsJ92znt9SJA4chpvpP6r0OLKnm1dzXBBeB0SgnFBi5SALJgxhTmB4TcR3V9HOFjc1ydTdz2h7nMo1RwIiK8ioQWatTqaGSwv4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993414; c=relaxed/simple;
	bh=bwg9YssyT468ZmMUebovK1FamI8jK5mPdcGYj0hG1vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mE1AXnPGceFY3WJbTHCosNKe5k72hmcujQtXlhXcSbY1C/EQanoNe6FhMSPj0DDhxGGngfMXxfLIN5j7hIf5Jj65HetHdR4g+naH+GJPdudsS6cv4geQAvqpiZCJBxD+IddQpu9RkwAYOE5HKreLbqYhJepGxKpwzp3CUb48Rmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XQiBuqIv; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQLCjqthzJNcHqQFjd1y5cR8nTYZCHjKZcKTmN5BUoHjIJ2mw7qSF3GTLz+BoYP15ildVu0+XIl6Z8X3WJSnK7EdH4pI/7O6Gb/eJ45EnFg7db3tQRiuxegLt/MFh6GrAFpyfYa7LLQG8OOEGF0U4VV2HS3fUOerDCTnVrO4b4FCDf65hus204vaWjsf/cjI7k3CeR/j4omlNjJmd48UaYCt7mSFJiqKL6zUDSXvM4XPR3uSliuFOwaysp8Ykv88a/5Kl5ayokDVAPG8ARumnJ97RlbHRCjRzXTXgXVR8JOgTvOtLx1XXJhFosaCi4q6lyPlOnFvz7rvMU/KE33M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFYOhf3yrZ5mFQicsem9zKtC9ZQYKIqd+PP4zhekpis=;
 b=cEIsDW0/ItQyz0tqwwfuYI1pnQZn8ivVDC04wJhnpJrAskqLs9vObwELRD7R3I0XVOwREuFpX70lctw7sQ3aE4834ZZ1xmUedqRUKfHm4xrqrqtgbxWwx1YXb4T3O22bmt4olYBdy97pxt+P4iJeDCvveJW88x+FnBl0z115FG5BXo/+g6FjqaS52z6KYbZRQck0RyqRL8dsXY0rnVNbtU+aq+kjXiCwFW0Zh+Tl6G+yYjQRg9xukw3J76Nv4wFAZCmoe8gZjZr5wPOrz//2rGMTlWh4dVaVEWREtbbR5u8R7dvXhSj0HGUPqajqNBJ7xlN7GbtTLN7Fpaz/U30TwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFYOhf3yrZ5mFQicsem9zKtC9ZQYKIqd+PP4zhekpis=;
 b=XQiBuqIvobhhJdEGRPO7Tuh9XuVc1oDeaoYMWq7TIPoSoFt3pC2gdrVxUibe4QlYmSMjCipEYh0121OSBK0Y+LeDnQdbf9Lk0oOxXP5HN/L5BrnpKuBnl9Pqlt0deOAMZMJr7BwIV0MLSrqMOeREBUYkOISxA57ravLBdRLPy2YvpvDzZul4ubIAoe0U/J+yh2CVnjhoP3eOSwhoEGM+QtzWfsBaaezmLzvggtFp+sOo7CzkuO4N48safNRZa/HfVd2qohnsK+Z04Ojkr7kLgNRoKX910YNeuW5AxkWYuWW4FznLB1fnshmIaEhg4FTUNVFo+EFh9cX9NbNEP6PDwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:40 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:40 +0000
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
Subject: [PATCH 03/16] powerpc: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:10 -0400
Message-ID: <20260528183625.870813-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: acc64247-9e24-4a4a-4829-08debce80ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	u2+xeHnY9zYVmVOV3Dy6b4aiUd/W58SlYu1sEnl/LwcnJCv9rxPBa4msus+VH0kYcCJbypj6Guj5uueiwq2NkPVeV+G/QzXvNZG2iz1zvDHm0kisjkANaG4+w+KskeeeQUzCAAe6VgCWw6gOflakcGM85fBojgviSrRMU5I99RB/q5qFUZC8DSCc7cRsvO1TB2HXyNQMxU1hC0hdQIoyKWCUwovIFRV0rC4tdT4Jk8e+lHFWcAk1+9kHwNwkiAy2OQYhL14FMK+plZc3z0fuS9sWCnSo1G3xL5URHufNCruF389/WS7zlgLerCuKyej9mEGhOHAYdywxOO1VspbkIPjdb4HLqyx4+DTzp7F/Fcz37ytUiVeUxWNy7zTisM2ZNueAMvAoTWuEUW0TuYaJd6CTrARUXs94Oz4n9s56JAMvMnl1Kc4pxNRrWI7eBEFM9dhJg+2ycM7ahNb0eVtYjODoyMJQSqM6g76i5IwTEP5fKS1LVxEq5FNsJ9VOKUTTO/qbcDJRh4ZgPATMImtL05IpsUuAXLezacXO1kWFTyJpF2UrW+rZyHLAIE4mu3hviWbaAGYXptGaGLuT6iuRZ6xc6V8DOJdi+JDJ2wnUD7+4jn4ti+hP3kbyC7lO6A6tpIqCK7XAAK9HKVMD6hFA4XWyv3ius/lotswjFBtKtaPB84Ny4h4+kHhKQuyIVI01
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Vy6KRHAYEWhmpazg0FlToutQb5wjVUKOcOH4kqPw0aptuWJMRK2qy+w9fA4?=
 =?us-ascii?Q?ZIg30rt5DCYxBvCwAVpzNPJxBouz1u3Rg19RgtOgSdN9sH86e12+IRbQaE5Q?=
 =?us-ascii?Q?RfWQjxEDM0F5dSWkqU7qYLGQ1nlLGYamCm1xwOeBBNgq2DCU+DismTpEaIJ8?=
 =?us-ascii?Q?Abd5CnOrKioOCoX5FO4Y4Ze9x353YOTvlvzwret0+Bf+UjcVV8mYKfXIdlfh?=
 =?us-ascii?Q?roCWwTNyLrWRIwx3GaoMYW6s6ZljUsTg525/AyXKBAwaKvozeBX2paMq+QrE?=
 =?us-ascii?Q?M6Is+U60/XAuH1d7UfTTQxJvBtGHZ0StWHK0Hlwb9rl2mSjgz1UjD3V+x2nK?=
 =?us-ascii?Q?F8kot2a2hXcM6UZuHgvwLwTUTIEHQyaUQ70X9l43M7srHHVyhFCIqyJV7uXY?=
 =?us-ascii?Q?O2jDxu0UyyYQMKqrDvRVmj/XOpQSVhuErg9sTe3xDvO/rH1LLyJAcrHjSERT?=
 =?us-ascii?Q?bdzCrlKzSp/GncDal8EbQmSmTU1qtVKOub9bO0jkSg3txWDDJF9nlHMZzlU1?=
 =?us-ascii?Q?mhB3kXPCd4hm30y/yj8nMV8dNBfQbOmA5hxRljJHDecYPvTArhu15zcQxazd?=
 =?us-ascii?Q?cY08hFB+xw8C8Oc+JmxDjgwx9kSqWzjI3hFLDAR4zTYnEMYsnOTCoclEP9uU?=
 =?us-ascii?Q?cEdlbD4zUJFqVgXE/gqvCdvnx22JCW3zMAYmN/h6wJwNaqrBf34LWwdRiS1/?=
 =?us-ascii?Q?KWPhHu6cR/MJOM/LX1JNpwzrH2DbS8OUwD+fDyhmiTB7kjOaDGewOyxE7duS?=
 =?us-ascii?Q?xkZM6f6d1jELgd+knQTd92huEoQbDoshgpFsNRdlnwyKT/2JfFx197pWoQib?=
 =?us-ascii?Q?HgGgcoEHVdUXB3REuGcxZ3LVBApxScj5ZdWIsfZ9kUnsyn+LAUmoOvRdYb3p?=
 =?us-ascii?Q?T7ZNOZMSI/JG845mGZFuceXIrQT8xrn/6YH0efdy149noGC2ZzAxjUdeT7ap?=
 =?us-ascii?Q?RExJayz248f4azkG9o+wxz6NU9QT5AUYZXegSUNWpJBx8PFi+OIuS3WfaWKa?=
 =?us-ascii?Q?WfGsV3uj/eZSh3OgZu/I7e9H+VbHBj/px5l0H7Q1sgRd9ynkNZmimA6w+EYm?=
 =?us-ascii?Q?qa/vwHvZ+N9vKku+KixI+bQHHRyVs6jMKSNKCwCEafzzY90uOlrvliG/nAqQ?=
 =?us-ascii?Q?EX+ogQf5QFjw7DDm/hoEBH1ouHzPRKEklNNJXc063++AAp2xwm7nwZFnEIQh?=
 =?us-ascii?Q?chjlqSHKMT2MCwzQaYFWXoBgGysHYlkj+AbcaZw1deM5Gk1jU4QEHjY+veAW?=
 =?us-ascii?Q?u37ACl3KvKmSAyYFMyhCAmkIgn+1hD1cYixJGsMkx23yjbV9cTuwrhHMlU05?=
 =?us-ascii?Q?TDIEwBNpoCzIR5smQAEXPxKZKY2op2tmEEpSWC8MyITfFSSF/jtsrfthrVNb?=
 =?us-ascii?Q?AJ5ZJYStDPocHMw3bq2CgrDvnhFLOfwq6WFPd8aCYBY1/kQ7ffDRZnP7IgDU?=
 =?us-ascii?Q?yY0UIY7HJtsfGkHj4VXqvQquYcBKbN/nGP4VHuVcEV5m2OBtKIytQKGnNH4y?=
 =?us-ascii?Q?9y7naMui68IjSxk4WiPK4VMQZOfTqsMXtCtQpLG14LRddKlCJKUtQPn4r22T?=
 =?us-ascii?Q?kXR4JYJlUX0oQ3nKH0rJJViU93sbrsY8Np4cU2e+8F0/CfF+5yN1ZivPZF9d?=
 =?us-ascii?Q?jKM2mt+zxxDALH85uQgXi2cl7JAuLgyZMwn0Tu1HBAg9lXMZBZDD4TQCnwFl?=
 =?us-ascii?Q?MUql61CKF/S+OU0D23dH7eX9sTFwU0fgOtBQfdKHGXMX5Tz+bgvqDbQotDrU?=
 =?us-ascii?Q?Am986vlELF9ysQ9wk2EF+0sKXe41HvC+RBIYHROYAALZAXULPN4+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc64247-9e24-4a4a-4829-08debce80ee8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:40.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD5SbnFyqTym8GlzKo+axptgWbc5wBlZ3+wiKOEjWErlwFxgFDQw8zORll/7FAMycJMFDfjx6EjPRsqoWN+tRw==
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
	TAGGED_FROM(0.00)[bounces-21440-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 667B35F67B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These callbacks are sysfs show paths.

Use sysfs_emit() and cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/powerpc/kernel/cacheinfo.c | 3 ++-
 arch/powerpc/perf/hv-24x7.c     | 2 +-
 arch/powerpc/perf/hv-gpci.c     | 2 +-
 arch/powerpc/perf/imc-pmu.c     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 90d51d9b3ed2..be415d2bb697 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -689,7 +689,8 @@ show_shared_cpumap(struct kobject *k, struct kobj_attribute *attr, char *buf, bo
 
 	mask = &cache->shared_cpu_map;
 
-	return cpumap_print_to_pagebuf(list, buf, mask);
+	return sysfs_emit(buf, list ? "%*pbl\n" : "%*pb\n",
+			  cpumask_pr_args(mask));
 }
 
 static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 243c0a1c8cda..d661fc972c92 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -428,7 +428,7 @@ static char *memdup_to_str(char *maybe_str, int max_len, gfp_t gfp)
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &hv_24x7_cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hv_24x7_cpumask));
 }
 
 static ssize_t sockets_show(struct device *dev,
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 10c82cf8f5b3..655b9553ca54 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -99,7 +99,7 @@ static ssize_t kernel_version_show(struct device *dev,
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &hv_gpci_cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hv_gpci_cpumask));
 }
 
 /* Interface attribute array index to store system information */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index c1563b4eaa94..7cb909c47889 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -117,7 +117,7 @@ static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
 		return 0;
 	}
 
-	return cpumap_print_to_pagebuf(true, buf, active_mask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(active_mask));
 }
 
 static DEVICE_ATTR(cpumask, S_IRUGO, imc_pmu_cpumask_get_attr, NULL);
-- 
2.51.0

