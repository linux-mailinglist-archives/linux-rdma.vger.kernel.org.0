Return-Path: <linux-rdma+bounces-21439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAdoHcuLGGrCkwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:39:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3C5F675B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2D9306048E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FD409106;
	Thu, 28 May 2026 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bNQCT1z6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4916409602;
	Thu, 28 May 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993411; cv=fail; b=SW4ETyHOJVOJ4c9SLBUAPJOlgZpiPlL+uxJzMpHtWbXFwBYIGe59GrGRl8pSfXd943tB7KAcic/f/WjaG0i0HKAuoQ2F/QPOEw3FmnoK6oa6/Q6qnf0YBuYYng7tZ4Ap3jytV5C7AYx6yCqniwZr6mGbkVpxmNWus02f5iSX9rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993411; c=relaxed/simple;
	bh=2rb8oruoYxvD5DS+PkoBfy7nOpNv5xDyNrGbjvuj5v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jnarZ2R8CfQIMEK3lSqF86Z9PksQZBoljPrkauRkkFUqYzt7BuyJesfBhf7/VTnY++h1+TWOqs22X1Go1lA3tpCKmExETnoyiJZBwzBv4Seh5wBb19X0sKAFUH4PtaymYUiEuXSZGu5T8WUI6NJ5VShw+7X5Jfa3nV6hsMqa31A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bNQCT1z6; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrjb/UfY9NilZt30lhDjOtcfuVWN/V34fhGa5P9ViVOcZePa4vf6r4m3Dh6NYdDl61b5dcQaxknzGoO41wvFh7HzOjZtWDDl3d6tqaGqoRqNlS6HFYPnkb/CjsNnWq5vebkzYn95PNnmMwFmkv3aLqNaV3EJeazcJdddlmitQsU0h4T/CSPlrX3y3mkWz9M4cBvoRA1I4i+7l80OLULDTnW1rhwrqtUwWGPKtFKUpdcoufhjcSz+Npv/XV9oBVqLdCMPNEsg51eIRZLxBueWXVPSWwKqRpspDtaz4wcDqTSE3rPZPhfzQ/XMJzx52FsyWNv/t0xq4FYTf8SuW86V5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIV9mt5QeoNEed6jKNEkItLfwz5XIecd2J6yAs45GOQ=;
 b=tKSGt9ht4smoQTWh0o97i28c+HYJsp6XAtv2HKRhC1cR7UENKD1vLXs3T+JOC9BIKtCTUCOljCpBAvxfJ35wypFweFmCZwRs+TRIUMFo9RI9cnOYH/qa9xFvUiK3p33/x6pBmA3wfZo2CrDpd4bXKCaZrRp7jPZNhMhBT5VvspEwY05uMApAxfWKkEZ2iIwpOh1GZYquYwn7rfMzeFE6KZ1LmBcWLtneuFCDs3dm6OoHreV3gGkuzMKYxoNU90L9J41MlkFYB0MTc9fLpx8DlT6LVkmOTA47E2R936RXLL7pwzXW/fkyjfqGbWa1C4L5wK874Vxu+/mwwFSc+v6dww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIV9mt5QeoNEed6jKNEkItLfwz5XIecd2J6yAs45GOQ=;
 b=bNQCT1z6GQtGXjoCfL/3sBpD6cG00HllUoNib/o5G9xAWxWRfNs7L6UAQyS9DwSjypn/JbgESeFU4u4iL0/p1YixwrZTRAuhJJiVQLMtZ91/TRiiJLasPm4egwTRI+mLyBKFRmHexA8uhgrCykWtRAVt17Ft44Hc95t1XguYbtEw3yCwhT4NSNVfQhDph/kNnmRttIqJP23kGJK2V/9gskPDMgJ5d1qjehN0E+LKgcK5S+mSH589Lz9B/8xKWCPh4+RQydmhGnQFu9Vb85+PvRKjXITvZNUKNiou5vm9mS+WBFVMLJkNh7N/HVLyqWTdDXmeGGSCKuMBqO1HCXichg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:36:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:36:37 +0000
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
Subject: [PATCH 02/16] arm: Use sysfs_emit() for cpumask show callbacks
Date: Thu, 28 May 2026 14:36:09 -0400
Message-ID: <20260528183625.870813-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 197e82c5-51a1-4440-3d89-08debce80cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	8cv7zY+YBvpjhMKDuJRlwfuskpzAk6OAe46Tdll03OT6SEnJJ9/6h2c+opsQeB/AUKNzrHZ7d/3vmFJZ5/So7FpGyylA1bUx/HSxbwudl8Krv3EvWBQ2zaHVrrRP67OkQBylViE7kJswlW9STkeoSigEqDdYDfAtjMwyIh8EhRFO8OvBkbJ0m1kDOlA7zTpkLmt5A/WZUx7h7UU8wxHZLGVnN031tZZQmhVqOx9yKoIyWCNalACH2KKppAfvg7Wqm2QZilElcYEakYfr7/r8UhZUb7kGDzAtonJKh9Sdk/BF3Nj9j2jOjfiiZLQaNS4xnPevKrjC4lKzv1cnsU/nDfyo3J0Uo6Nv9O7nKO8i9aVlVJSTcUaSsD3++JdK7JGmHLksR9J40tdGIZA6C71lsmfCeu/9lFs3yKBbbgDSWVwFzmRhUTgPbNFZIpBAMev1SlRaG2IMj6MAafKyvfM/0AQWqI4glEXJ55rAUc6zZ13JlZ6fxqjq+FyWF2S3ZLH78MbaRgp+D6VrEpbeAQs5TK0G8QaXoC4HZzz9+8sM+8CFSCLnFKowa0/XZXyqtpP4d16cTMobpSlJxP4fYp0W0LCnGuUNqAaU5Grj+dAYDVog+/jqUo6RE4EgV2To5MCZqHQQiLDVZ73dd/mFb5L3egivwElcVLU/OBamLaMVDY6XQiimaVYPwTHgmoMbl1Xc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5oVS4A1+tJTxkK0qom1zjvl94w0NoQp3xU9KVp9YQVw7Vgwkg1pe7HBqQBd8?=
 =?us-ascii?Q?+XFzpJ4fkEgMuyWtNuNXI4ADA/Eq1Ugj2CDA5BuoQvY42BoETY236honna5L?=
 =?us-ascii?Q?HhpqyuDA8CCjctsBNlcdp/R7f8pLV+be8PAyUsYbCwKeaZdtwSohVjmjoso3?=
 =?us-ascii?Q?+U6jEa7rtB8IGnT6QTA5U3wo2bHQvMfLuuneMyaISqX61HtEWutYU+CRlhD/?=
 =?us-ascii?Q?sXXZF3yxOIP56n59homfZlp5H/bPkv0dsCgnGVvbaJPwi4jWgUSZxpO+O3qu?=
 =?us-ascii?Q?b237zx2QxXLUg5wRDfXTK0l48t2UegDBjM5Xubfaj1U4HIga5m+asUNpixl7?=
 =?us-ascii?Q?zC1LwANi+p4VayuRnxLgE70PlIaqtVGvLbOSjGqPhUVx4Z/rDOV/fo22L3Px?=
 =?us-ascii?Q?5HlQAqzVNUg2izwZTvzFUOEGkcdd28U3/beDLJorva3CvPc6SKux1TgSdSsi?=
 =?us-ascii?Q?5NdPRw3Rei1bvSzRY2Tb26tZrgIPOsLe9uqHx7Kk+Q+7/ybK+UtmY0h1gkM/?=
 =?us-ascii?Q?sEcteCSpL5IMozXDfAAyAO45QNurfhYApztq1ok6jdjDNG1nzSn5W0JbfJXq?=
 =?us-ascii?Q?CpnW1RdCu0/sRGfElDFQaeB6Nc0HJfsTW6nRVqdoWcKmyHNGln1345asSIUG?=
 =?us-ascii?Q?srAp819uFevH8VWzZQzl1Rn7wupZGcYdruqjS8oUMckhXI0qX69v55UCHr1q?=
 =?us-ascii?Q?/3dG8UsD0AuOnXGcjxxF1WP9RZ5QKSg1i4syWSE0bB6iasehwHnbom0baAIO?=
 =?us-ascii?Q?6OKPvhXDRL7ehsCzSHlB0MO+qTEmJ8FYmNntCZUNl0LL+QYPJeoxrwanzxzI?=
 =?us-ascii?Q?d99ZAiM6wZX6l0tZv4aD38oT23lx6uMNBKRIB1Ok8v4lLH3XB1NpZ5d2m0yg?=
 =?us-ascii?Q?rxjKXjmjihCLFNsmt9812Y1Qv5u0NMO2TLHw7+BKzmm3Z2S+sOV8ZAwNbkzI?=
 =?us-ascii?Q?71kERnzUoA+akH23MvKyZ3gRRftkIBlpQKrDrhdMQLDm7BWgZIE05kyDdPJi?=
 =?us-ascii?Q?vLZ/319x9NGewX9nXwQ0NwQKrqPBCOcP06j9lgXL0F8to3nib4mVFhaYjH66?=
 =?us-ascii?Q?bzXWBj3e/NXUHovNO2CCHtkv9t+5Om0oy+ObPXLJXs5yOr1ueaV72UAVS4bN?=
 =?us-ascii?Q?LPAzYCQHkTaxS3BJ4pg/vYwOy9vg8GJQBoBZRhvG1w2fLrnthjBBHL6J3XVv?=
 =?us-ascii?Q?R8vcSzxWjgAp9vRH9BFoPrcS2Zz3yBTdYB1D0r8Lo/Wx9siRcUUuaMqsNfHm?=
 =?us-ascii?Q?RSh0Q2UpUhChKtLGt249l+3xeoaCB4Nb/Aq/KO0cdsYfpmG2TIjd8HS5mYPr?=
 =?us-ascii?Q?npwo5Jzz5tMB70J4Uvy7q+E8um2kT2GXsKbhvEik2c9qXzg/Tv5O6sE8J/2W?=
 =?us-ascii?Q?O5JkRlw3f8YpG+pz8kHnVFaHqpe9j75NNqAbyGp7E5RgClrR9CpRPbTszJfh?=
 =?us-ascii?Q?8my5tY5v/E1B9DLcW0GPf8Qe7qNyCGZE7quYzd9j9721iaIWThuccKG7ErDv?=
 =?us-ascii?Q?zdyxjFhOtHbNqQmv02HzJdbPIYmXV7qcvScMXNs/l+bSv4IfgalPYQ/mLERA?=
 =?us-ascii?Q?yTnnGC5O+iWP62w2rvGLl3h/9BgzWOPh1FqA4Q5nv8p7WCjuy7kbDZMoZCdL?=
 =?us-ascii?Q?I0whqjCkw04wr2uUhPxK+rmYD7RGHHtJvpxu9ePVJSXCCYVS+uN5R0P7ns6Z?=
 =?us-ascii?Q?2LNNPEoN7w5DvUk2FFoSsq8EWSqDPrAxFTFlT9NS0nEocAL5lF8leqY1gX7c?=
 =?us-ascii?Q?mr/t2F2u3RfuwZICKQ3xsZwS2MTf1S8pW7G4FU6ehKSscp7z/leY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197e82c5-51a1-4440-3d89-08debce80cfc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:36:37.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEhpzkTOkMZgRnDrttkAv/O6x6jmWKYLh72wjMt5irKfvro69L7q+90G4scvpFc4KiLsjqMYZwddwyGzaWOU/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21439-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E7E3C5F675B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.51.0

