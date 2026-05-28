Return-Path: <linux-rdma+bounces-21451-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B6tMMCMGGohlAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21451-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8865F694C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCD43307650F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938B43DA20;
	Thu, 28 May 2026 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4O0Ut/G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4A42189F;
	Thu, 28 May 2026 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993451; cv=fail; b=tc4mK1ZFBIeE+rmJWQCoBxaEfgwAFeAXxCtvrRd2YueyqendQSfLDK7PTbwK+8n36V/2kAKs9exrRbuG/1wD5dBTX6gEjB40r/A7bzNncZAiqFneK4eHcM72fJDFUGzDoxTzi9T4+HX/6YYE7QBRxvuTta1pnGoQOBcpH2/ecGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993451; c=relaxed/simple;
	bh=haKOZTUTsBw7S6aU0Ug3jg2jEEnXzz1WlS/sxqxDqjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6mWs65lbBENwoR9HhwGfBfa3IF/6P7p40fS9HTkE1Zx6L5/w+s3+oNY2BrzC846YZ6EwOmBnJELAPbh6edIQEvmYiehcHKV1Ma76XG1tVlSZNCVeJAr9O6p8C+RkD4OYGCZsQNPO7qANvmwTieC0EV3QEmiSgneGfhBvbKZsA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4O0Ut/G; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G12U4cToqMKwl4bILf3yW8fme1fbgTuyrtMc4EDGRKa1B1qvDWH21GuHSFxkY10PXNlJRagGLP8YPCOJ1OUqAgoYBRCgIMUqxaP6VsDkqImMO2STRX+rcFwwxKRov8mPG9stZjbhJlQa26HW7+5UODPGeuYST4jg7PfZ4oLqs0uAVLZPV1tVRVtqbFX5jRK/FWRBMLNx62nLZ7zE+E3RDqa6+Do9GvzGFs8xZUL5y9bkqnDXwLSwk4Rqc8LrhYhhKZJOm09jPLROKJH5ZbPEv7kw2kHu6aisHC4d8TM7FXFreO13qa15W+lF34DwTcOQCT0IBvhQVU7i8VkA79lK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsvVyf9BXeN5i9s0Ek/ePTVtLYmCwCukts291jfSOMw=;
 b=Bya3+WECxTenCjn5xyj/wI3tMGHwH9UC3XfjeIX+W5n9j+qixFiF41ZqaYEilS3cvpqW4SfNrz2RLtMP2EmCsSThbfCBZS6aASQ0x+gBj6xc5p53k0ej/qJk2ib+JEyQJbIYYmKbWg7MhiV362iz06wa0jP663Lze4yfgWtaHn8kzwLeCS6IZgSePCllkM4zFZDUf+hjS9PljPNccbbsVhzLN00ROr46zkStuA1mM4yK41UTMtSjEXkg+d4VJGZuiPeljUeFOkRD5Y2UFPWr/3Zr7Mtm2UwlpQBDQAlQTASYZYux1QQ9yAjYAztOJrWvq6a9wO6IRAoxIg3HV8f0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsvVyf9BXeN5i9s0Ek/ePTVtLYmCwCukts291jfSOMw=;
 b=L4O0Ut/GXvqavrNUaga2spI7zdZtKRIyXIHQLUPyHiQ8jw8u1oXsrEBWKB7QDvSvKyZxrviAOPvTF7Ofz1FFLg0vU8Fg0kWy4qZkxUciHR/ptmdi/woB1wLtYHU1xI1OgPszeiLl1xZ5rcidAS0RgHtSshnutueri/E2+kRBri92SKrVPt/rg8t8TUaNZfTkluOfvrnBipqUIntHJkT42Q0VJZiX1pVrArfLzhZkYuGEkvKtiLm3dv6HdIfuTln3o5P1XvH4+BRQU0W7yLoliSep2urMfhW7WlPkAIgkauTYr1jM6NSuoqjKH0WmjfSLJEK8iITfYyjJB2IrAkwcEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 18:37:17 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:37:17 +0000
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
Subject: [PATCH 14/16] powercap: intel_rapl: Use sysfs_emit() for cpumask show
Date: Thu, 28 May 2026 14:36:21 -0400
Message-ID: <20260528183625.870813-15-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528183625.870813-1-ynorov@nvidia.com>
References: <20260528183625.870813-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 073171aa-cd75-494a-dced-08debce824f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XcpHPErZ6KTIxAuDYzYQ28QiEYbz6RIySXmiLOIsIAqGt49BShllZNYRHwVg7UVRfrn0vWcwX6xQBIPe2IUztFB+TLFsZfm+84rGe77mQpsOUX7GIrL2qc3o78fn5qJ6Q8y0y7ARts9gL86+ywTUnOZem1To+ldmtNota4g3/fe/FLNrUOOiYQcm3Z/0N0bo5FbsxNjE6Nb8yOHRJFtaVBptToTrUJ6Pr1V9PHaLGCTDbrdQPR+qNbl7o3WMY3nxRalLYIvHEIY9gZK5vzDzuZxulrWVXBUBZpy0Gp5p6RFyvRJYlW7GXSSpx+b+B0QuZJocDAO3ivyu47sR5jTv9qu1vCPySlIB1kV5n7StcqTQOHTPUFYJFZvo6y+bi/14u5nvf/sIjUDmbcOGSHxR1CCQv6JQ02ZrJpRoyPni30S4f8S7g+2pYNK71/ArKasq/If9OoQSvbnQjoTslqe6L7Qz4pBh2As9Su0P63cZZRFe88hjZnpbpnc449S/MWFGVRhzvT0jLR0H2P5nPbFep9rmSAY8QLY+dE9I61Ngp/9uqwqR+PkggEQaWeFUUsrYMPrD/poAAaFrZxzQ9FafFMnDgNw7ew2uTre7crzAwp0nCtL446Ffci47iNd6Px9kzeebnfWxpn/vPHdhgJFbcuFvE4psz5bA3lVfE+JTGgryu/KC8taFCRvd7scHJzAF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7BYarsFdYcqSdyh+OZ1c/EDnXvRcSwqnBVp1tVM9D0MM1BToSLMbhYeLpKw?=
 =?us-ascii?Q?snSDhRG8qqgkXVeWGHaEai8q+76vMo5AtN8pbx6wuohnVYqVvyrlyLu1g+dk?=
 =?us-ascii?Q?2VDJTwI6itRDSCOPIYihh6Icj0qP6BjuW2CY0HRr2oz94BIUd2BrN69R3XxS?=
 =?us-ascii?Q?ey+utT6ssYbkoGZzeJQ4hkIX8ElDYKJvq9gnisXnWbsAIHf8biCrSBvd0t3F?=
 =?us-ascii?Q?eDhwpNObKZ2YQII+5r5WN257t3+BVJ2I4Rhk3UqkX7JynLV6jMogTnJlaDEj?=
 =?us-ascii?Q?Im3dJ6UIT2dBNKmy4eA7WNIRXXruieGcR/mZTTPva8iJHncHjtRaxfrrGNm6?=
 =?us-ascii?Q?bWzjGWJRuQszhRvzVxAn/SjvmoroN/DTetdlO53DkC3wDKaSWDw4o+gUNouL?=
 =?us-ascii?Q?vSGH9f7HOArsz3dPVR8Epq6YyPrxjgxJLr+XmALWyQGVxfIODafP9F8Ig/Y6?=
 =?us-ascii?Q?lmJZR3SLrKTEKyfO3QSUemtWT9jmHyjqCAG5xj/0pNv5kKrnS/gVqBUx+LGa?=
 =?us-ascii?Q?uqq8ISgglnXCits1imwnWKsYzs9RKtZPQE2Xjl3JBnui5qabZ4DPD4MUZkav?=
 =?us-ascii?Q?npMY9yrrBL80YxcvNiT+QqtN3m0M+xrVN7JS6IOkdXbz7uhZWoC/UHy8knHc?=
 =?us-ascii?Q?haNcclJ4yoB7s/VQMwFQsV0SM1sRHpu7xEnbhVr6f/S+uLWTYRBekdaoWKtg?=
 =?us-ascii?Q?fCWhNtuKZiBrU3vBUzc0qRffO2M3GayIILYqsN2YoBBP9vnX5hN6bXSNdSmh?=
 =?us-ascii?Q?W/XNoL2mw2CAT/D4WgmL1cHPme0HwMHqIQecjWU8+381NlDhMdCibYGKgSvX?=
 =?us-ascii?Q?6kdKDwlnsS6cPirA1FqDY1qAxTW/xqaf/BvVQdMyE4hcOCOAZVDoqPIKHqzm?=
 =?us-ascii?Q?VaP/qKnWeDAZOwSC1kCrMQNdnSzdse4gq50ypGQ1F2lW3C32Ir2lfbmPFEAx?=
 =?us-ascii?Q?j8NGpGH5o3obR8uTChT5d89UGZFZJDF4w3aDG9mRSjCLEiXlRU1pJc9yXpcQ?=
 =?us-ascii?Q?XWKiPOuXk3veQtQhx52EVMADv54pXaJvcCOesAWIUD0OYb3OVuTO4HbIA98b?=
 =?us-ascii?Q?2CdrJSQ5epeMPB5iePg/iNNnc4XIk0vdnkerGz0Sxeg8dAV7lLKjenGGNkJf?=
 =?us-ascii?Q?AmDTV4U29egDx96SRGottnsBiiOYd0y5WVIXijdTFjFQNnUc8F6gpJY2klkT?=
 =?us-ascii?Q?eYynwL+UBw8tKFKX53j1KQsTerhKp1AdtzJYyW9JaJzslnQtNwPIPShC9F4G?=
 =?us-ascii?Q?8IvTKWGBhyQuk41SgaEJRzw1gPpyVv2hlQKYLuF9RlMBs90/lmotpxu2M9Wv?=
 =?us-ascii?Q?ZKkVZouz/voM3IrBl31wqEflPF2c1Z++GP/1E4KkdgqZiACRn6Bs4Cq2ceje?=
 =?us-ascii?Q?++4geb9aCkXqF0LEd3I6RhNO/W3ZnZnI9dKl1IC9JiLa+gFmj4sOmlP7Yi/S?=
 =?us-ascii?Q?WQXMn2XkMJwrN93F9QT9yX5ZR/o1GfqAx6/8aTxphQ/t3olGoLFjbjmz0Bta?=
 =?us-ascii?Q?CpAWqEdO6dTb390CU/l8S8IpLwltnMI75R/TO/YgHHyfd/0Ehh/askHbP347?=
 =?us-ascii?Q?aCQfZQKD6VPxjg3EzRZ7kp62lzInUgtqqRZoq2TcrjHpcJqgGGR34VqYBX6G?=
 =?us-ascii?Q?dL0IG+gj5GkkPb3L0gn91YxuiLPNInGtdEeQserFTu7Pb/ZackdXDLGkwhZ4?=
 =?us-ascii?Q?0cZ7O1o3uBZ5oP/T15shrYAz2SjcTo3s8Eg6h4RldfOZneHWGInX9bot3555?=
 =?us-ascii?Q?KZ9I7ZiuQ3ffwdwfz+BSAsJ+7ciD7ObsVORXUFoUMOY4Ec+6kQIQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073171aa-cd75-494a-dced-08debce824f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:37:17.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRL09sWLAmcj6VOcDwq0/DqNmwA2f0jZM2RI4pNG1rQpD6GTOb6DlB6//Lao38sET7ImTecZyGAXhlHbtZGbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21451-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F8865F694C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a8dd02dff0a0..b38d4a7799a8 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1441,7 +1441,7 @@ static ssize_t cpumask_show(struct device *dev,
 	}
 	cpus_read_unlock();
 
-	ret = cpumap_print_to_pagebuf(true, buf, cpu_mask);
+	ret = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_mask));
 
 	free_cpumask_var(cpu_mask);
 
-- 
2.51.0


