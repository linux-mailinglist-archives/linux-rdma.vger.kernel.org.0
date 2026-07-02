Return-Path: <linux-rdma+bounces-22700-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7diVLpmJRmp9YAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22700-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:54:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A236F9BCC
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:54:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=DlRg+3x5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22700-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22700-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CFB030FC8B8
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F33D9556;
	Thu,  2 Jul 2026 15:48:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E56381E8B;
	Thu,  2 Jul 2026 15:48:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007290; cv=fail; b=uh1Y6+tPPGUg+evYDCKmkQCeGGRo1sV7bkfsFptIhTGdoVPYjoG95o7xvGowY5XzmX0hM94ZtYApT0IsBBTcT4pQPPy4IwcZqi4LcgYZImSUjNow1Tlh7gOUDldMdwqwcBaDlccFE3Hb3an/y+xKomKPcRmz+27j1c/SwtIhEgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007290; c=relaxed/simple;
	bh=2vXbYQAngOR2InNC8I7LrVve13XtWYjRroO54swzmkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgadalQDz6709V5C0JW/IdG4XKVk8gpiyZeAEWivIy/0AZ1980l7WFbm3m9Mgbaq2/0XUppwFpxG0JuHn3wNK+BVq+YrigC9mSbXk1g6NJ+3VCVVkw4c3yn48tO5+jrWH9p6d9sXJ+v99IgHm/WXh9FIHTzQq1UTDMCx48cZwpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlRg+3x5; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMbjE2gFjpv7IUrv8NNrYxqZVCEqW7YHec3m+aAyWtLCkkontQm0R1NF0xRQD+uImbOM5WE0tnZ3ZBtvoW5TkipjB2cN8JM9uaGtIDPAu0nRXA4TeuCjk+jL0N0oDhUZXaPlIIIUZE+wy+vOljjroAEvAZaOPfO+leFMm4ffOvmoqzOK7axa8WPj+oajTzGW0XkyinMoFc5QFCXvO2ypiUD48Kn6k6rActpHs/f37Oj3GcNrGhb57+00vwsREqD2F7tNEa116bpKP67p5CFXBoJ7AD0Ygc/ifx8Fd8Q6Zg0U5OBLYSuu0vVDzSZax6TdXXhbtnOvaZHkUk2w3ica6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilf18bRPLPB9Q6Wh+4qPt8tOIqUKouy9ag/2PhTSRe8=;
 b=uEUaqLK5P4LTpDBPEKoLwCyoAqtt7FN+WcocCYe29SV894yvMv/ZXOVW7/Q8J6LMcyEC6x0j8cxWTOFrXsCXpcpp8SRspssWDnrPffntWH6mkvyJoMHw9uzp7w211idoetPzjKby0ZP0vDIB4BsfC6ocI92/GWM2jqGeZozG6jsnQr8CbX5xWMWy8uTIazkGK5vip3Ox5oGh/Gm3bqhUmaYv+Fnn5M3ZFgGlu6fF7S1NnTzUS+CcZJuucgx1GEKW1iOdPI5sQb/rDyHGpHCN5VTCdIISjjp0rXHLhX/xK1J57d9Bm+i78N9yjsmJsPUQOYGtbVSeumQsj02wcRCG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilf18bRPLPB9Q6Wh+4qPt8tOIqUKouy9ag/2PhTSRe8=;
 b=DlRg+3x52Xh5bRlTODohLhta04VZ5MlvhKIzDK6pRaC389VDa4tQ2jHodQXayili5xR9T6mfxLMrxMN6gjYOvUzv1Th5OxVrwsULFqc7MfJU195GEfsiOpDQhsglPwzeq5HYREO0B2IL4bpQt55eA/h+AUv/R3qnD15nYgpNJGeMthtHxQ3Rd6ih28Pe7Jsix958ifMt9qUi1e+NvUG6QuoIzk2ysMDkXNpTUbOp8nIiQUTcPGEn2nJgSi3VUN1GZmlKEUur/n8dQXYPtjb8c9MR2dluCpQG8jAVj+prL+vqPBMruJHOT2La+z2YQn0YGReaxMag/nuB7hiRa3FnTQ==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:48:00 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:48:00 +0000
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
Subject: [PATCH v2 07/11] hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
Date: Thu,  2 Jul 2026 11:47:20 -0400
Message-ID: <20260702154725.185376-8-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 68391e43-62cc-4880-4133-08ded8514ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lpJFul/5tS/0ZIv6qzSsNOSRXYpwyj2Z7q+NTBJ9jp34oXiLxukegqkSa2q5GJaDZo+Qmr0G7HYNQyMrd9ayVzJXryF+qTfjOjkl7hBxHCvjm5RM9f8XSn2/RRunJbmiNYuUtB2oYTEhtRx3l2bhk3EfKzTSWm4Gi/TcqRxM20hn947XRNPpYRDJP1OQTHT5k269VnwnCHVoKpPOXMBiMuxSlqfgrcGFQt+LoBB1sBiWYNm44s++CwI3Rz5njH89U0PrqKsB+RpPQwV7Ymvb6xHRXMUZzKmGpGPf4ce9VUf8NdD0AtNonaYVmX1oxp/vJUvmseidHQCETnUuzNRTmOTxOlqWwdtFc8URZhCHOzm2wprDCUE+syEW2sh23KZxNqqfuEduGheJ86xx7Gl5/ukkxh6UksrR88LhIxeTXbdKVzoyAToWOz4mbUggx+Rq4DKxdbYcd8EMdUTweW7zQbeplRglJCIvyC/Sl/IxuniVwwgetJpgcoImYquk9Hi9X/2Cwat1xbDsRuFgXSkBiHoV5uVzuSca3glWQGNhWGaPfc+bKmZ6LngHOJ14AxiDoqRHndewd+tCXCAjgEeKzF5A7a8ti1ZTcD9tsd0KxyZFC9h0zKozInyH2G9FuPlaCygfl+xERDyhYbBUpt8h18sLdMqT3VydoUQd+EQPiaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgocPSuT2hI5MgS4870DG/hs8yCJ68Gwv7eyHZ1StyOI+bf3ZAR5GSyccMDJ?=
 =?us-ascii?Q?qy+f/6ov0vkNNQfRzlBG2BKEhpV438CWdkOSGwYiVs7dzmJCHq+ATpz6dlHu?=
 =?us-ascii?Q?ROZuO6vw8oRRbCP7vt8h0kKdUBpMMbY/PXmDWPHP6Qh6wtQlImK5vBqdYrGQ?=
 =?us-ascii?Q?JFSpJgdSj19XztjC47g5/gb7qGs+/0A2q85Q+4oro31K7pM34HOi1C2Kd0cN?=
 =?us-ascii?Q?B6TArhHnFF2yKH8M8R8g+gKVe+OUJmw2rDFo2a8BUMFFBu72PjiCsRLhbBgl?=
 =?us-ascii?Q?Ncnn3J0Mr+xFQueDOx3nRu7+QJHdtfrJ7Tz1uRC5d1imXivM0pLfi5mY5uOV?=
 =?us-ascii?Q?lhRP7gVBtPfCsrvq0nVt/6tuOtIVzCl4L6D7RF7c/M2nnhYZe/q24oYrMy7c?=
 =?us-ascii?Q?QGhnpdosmvSW2/S8vro9Xb1iFsYrKX1b8m+M53Dt3Z9UupfYbfHaitW7QnNX?=
 =?us-ascii?Q?W1TntBldaJcnpf+jXMIU/0CxpTb6FQvDDRsKxBtzq3s3/Kmkj0yZ1emCrNlB?=
 =?us-ascii?Q?g575XS97Bv0SkxmllLRZCokxFQOLbj+m+BKoFcHWBYAwbObH83fkXkCSSKU2?=
 =?us-ascii?Q?4OnWvIpkIY0I4ou3Ch1KcTjo4lT/hzAYJKQV0QNVgLexgRkecixPoA3MvcWV?=
 =?us-ascii?Q?/AJ8VtkAoZ7Ew+s1SNS2qKM/6G4xpyDk5ry56hgDxgvns5EmEV7b/yTzhzLj?=
 =?us-ascii?Q?RZ2CypKk8vXIevccm/8fUqv9HuAhm9FbyMiNBa+iXDxkvdAZz0+Ia4CAD/75?=
 =?us-ascii?Q?Y0rtJgWc17sZwEnH7M6YYAz1wYxxfbdJxF33124x6ZlAT3LV7yw9iWFQHm4r?=
 =?us-ascii?Q?ixWC2dTfL968UbtVeoraw1CECxK0AaBA+I4AnsKnL3YA9jAqeeTJy/WIsSuK?=
 =?us-ascii?Q?JpKLYrQxAriF3vD79jCEDxVLpFUpKCua1UtcMxNnbMOPX0ixDsEX3ftlrXsf?=
 =?us-ascii?Q?dPXwM3IRXC5ifMgBql6ieUmFXhbUs/Y2kdJcVFGHCQzCMClXy2qd12KGvtqb?=
 =?us-ascii?Q?MLYeq5xaCwdBh9XmWJvfmhJ5xPlAtwACCoJziPgwQWNBGEBlpiUK/1H9C1fS?=
 =?us-ascii?Q?7kuuNVNQ/4qsaah9Y3/cAoRAKT/gllcZPZ1To7aR+l8qV8S31yJGci6R73zQ?=
 =?us-ascii?Q?kUBsSjwsteyVuf2yfvnhMWYtljzbFyVBE0zXbMwhTTfN8RoKJfZAFWncwaOj?=
 =?us-ascii?Q?k+NVrqooORZKzuRwKAAZ7Hmng4ZyjMfVZspW/tYH6nkcfvmkhmExjZKTP6eL?=
 =?us-ascii?Q?yRzmPkGBjRwLejvauhWkXeuBJEB4t8Isb++9D8sC82Ly/dTPhjrPLEPTfKwF?=
 =?us-ascii?Q?MGQQZjZiwpFVkNtWeZVYzawKD+6c+vcK4SdP/DkVjPFqmGY0e1pZ2vVtCzGB?=
 =?us-ascii?Q?wW0dr7uNiFE4I3Pj8C98WQ6PdYK3Gzkgjt8k9BAyVOKErqeIcLyTJC0GN4nf?=
 =?us-ascii?Q?oujxuxVTRBAu761H3jjf2Ax3XeSyQUdIo2Q50rd7oN66ifh87WSv5zJ0BzQO?=
 =?us-ascii?Q?HMEcIBBNVMorgr98Q6xGkwhnk9tsRLrJRM6CIchCtDqpxElGnTc1ieK6LuIk?=
 =?us-ascii?Q?fjnxl84uh3rzzmSgb89oLviE51S2nSTBPW2bCXkQRafahS0fxkITEfmY7X2j?=
 =?us-ascii?Q?0dAk4oXm5uo5oleERiLs3q7eXs/eXWis0rNC8PjySWnzYyqndP+xaZPENiyL?=
 =?us-ascii?Q?4dpSHXI2u2nbUEPjmU4BjK7B3HirWSd+rR1UM7tn06f57FzAUXEU0pf07xfB?=
 =?us-ascii?Q?iOcZfT1jQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68391e43-62cc-4880-4133-08ded8514ae8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:59.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BXxPmV2KBJFTleQ39V+SwZp83OsSvYwtBNPiNrXUaaeF+GBsKepZI+0z4BOjb/TdQiBMm9iUJYtlrv4V6f05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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
	TAGGED_FROM(0.00)[bounces-22700-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 74A236F9BCC

cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 94c371c49135..233c4c32513c 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -780,7 +780,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
 	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.53.0


