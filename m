Return-Path: <linux-rdma+bounces-22705-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsgjBDyMRmpsYQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22705-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:05:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA26F9E36
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:05:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QdFO5NMI;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22705-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22705-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 268D6307C8D0
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402648C8A1;
	Thu,  2 Jul 2026 15:48:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFE431E53;
	Thu,  2 Jul 2026 15:48:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007306; cv=fail; b=Keh2geySvdMNvXCKzplNAkTsfr6zvuXcBp8eY9M6NIRZkTOYvRVH0KHq9QEMDaqMmq9Kuoa6O2tbW3nRlxlNxWHhZMp+xQdM99RMU15m0cKLLshLmjIdoy6OhdzmhCywMUVDk732B0Al2/QWTSfFTlRnBjzwoVYyKjCdyiKNSnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007306; c=relaxed/simple;
	bh=QVH0yqqnzEZjeWrIXhsNDAc3n5P+TOwabrSTY1bZ5H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pV+vNA8TSsfJ5vXxbsXry5Y9vM3B46Gl5zTNGKlEKciToaXSvGo2YV1wHRg89Jlu9PSKypy5InHydCLhbOBapammEcpXpLkeUkY8Ak/zkWGDvy0cfKdCsmg7X/OB+9scv6sU7wh8ULJMheHyZIXgMffbt1nP1chfm9DZ9FKbdGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdFO5NMI; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt/6nQt+OsvWqnfNJgVt7aUCVnw5puet6fPkrX5XFCLw9cZXJoPEMBnFCteEAJqD2xy5S1MJnSuGm2bd1OUCgiR17gUPZYcvzMaTbE6kID5f3v5X9+eQYEvw8lL9YjRIfb4JU4THxBMfuQIK806Z0cMne9eADN4jH17A0e417B6d6AdsVY1N1LBDAS+HlcB+SprFeyWRvJNy+Tl0Q+x0sUEIj6HUBlvzfErrVuGz1AkPCpgMKJi7ZxyvkISco4I97MUDpJlFqKzqaPnwEDu2aFreKm3lr372rbevAxEhWqoaFgQWvUfx/q1SwaF5TVjUbQS5Dryq6LrC5rCwoaImQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=679EHulF+k8nvRoVrcQmzNjW69RLCjrR1DjqzhGCTEQ=;
 b=mMYJT4fib2S5zFHFNn/wZM49kp1RInC4phvENCyet31JdtvtupY10LTRrKRBx5LLMsE+3knKp28G+aTUen8D/T+29kFvRIt4s5DLizoZqOuBt4sIyeQxoEY4YO6EwNTlikGe1hiBeN3K04iMsbu7PUkb+2UxxRYpmkxMg8s54z0UUS9HBmvj99jYbjpBr4yEAFk6alkI0a47z6ayziN7ZLFHv7pkcljxPHaDUWlWjym4sdUayPq50NcSXL+Fuwj19lsxwzzYEf+1iCgL3dDkM6dOplkHTx8dsWHd4HMG9mPanJe1ZpG63SH+0V9JSc5CpNvDNeJaxVst/Gt5PX5J0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=679EHulF+k8nvRoVrcQmzNjW69RLCjrR1DjqzhGCTEQ=;
 b=QdFO5NMI8RaZKNRqZ0rGolPp2CfVFVwjALxGFApIZ8qBy3dMKFTCkL1TwH4ZLO5r0m/ei7xGwGtX6B+3VfZB4CTeLsmlHOoI4L0Gn181WHM+ESIWGNa365dBF93t98Tcd6iLN4jDFzV9sgT3Bk4DVfspxY8ekI9EwH4u8rtq2g+0umWJrdEIDtKwFAbTM6So0vGurpjIKbziI3VNgFFvc8RM+z34hxOdxRA+BpWoVyn6cqQKpLKd4f5Hla/nRawLdLM5Gsih4xc3sCY0LZBWdRElQ5s0KUS7V5MphVJ7aRYEXUOKfFF1WuAS0HR3CBTPELd2yM36CXvFFiTF2t1YOQ==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB9471.namprd12.prod.outlook.com (2603:10b6:806:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:48:09 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:48:08 +0000
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
Subject: [PATCH v2 10/11] perf: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:23 -0400
Message-ID: <20260702154725.185376-11-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b00bce1-73b5-4498-6e79-08ded8515069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Obl09vUKNoqURlxaM5oEfnhwQQwLdXw/PHFNdNnMD2DQ+cHCprft2zBX0XVoT+EMLSgN7Y3eLNfxujVMe5yQKfa0K5S7+lh7LJaWjX/cscnJoUsPmn2hZU+rLcjAlgXoDOHiiwBQEe92ELRYtPiLG49kd4veI3PQB1HbcvT2x7s13DcBM56pdOx0DFjQY1HmCSdqcy148gEVw3ouaZbAsRAVlUyfphfL+DZXpcHI9HuBLHLKdJy3MAYDbtUjXD8kT/PB5LdB2VO2EpptI1NbXfQ2LEgpRNR4teJL/YaELl/f5nsVNn3+6npHRHfBoNqM1A2YRUAfN0anelFzEr9AHkGB6e8dzEgVdBrmWj/P196U3b6tIEvLw2pTBtQpWowYsmBbnOhjI9pXzyzJdC7QU/jqoWwRBHv2JaS+4FUAh4sGYTOgLs/W6y9aFPh6clN7rDnaMX/IsZVC1+fUMw8HYT47yePnozwF1AIhcN8y6IE3mDRungtObrcrgnStKBOz8/u+mqE74GJUHQJDDvXDWVv7MTSTX+CzNwZOZ5u1XdN865NTuI3rJet4ofMXiZZDChNLJ6/e8X9WD6D0XO4l1liz1qp4eMGHlvbFZrp3mg4opLxn8VAW/SsR4fqYXVA6Mpfhc0ncijmVPlaW8nW898TE+l48jXPbVrozBpIwEfE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCOTA1KIk9JrLOGTJ6PBMRmap6RwZRXTxewffdWsZ58yfwQtlEiYFbpUcNRx?=
 =?us-ascii?Q?4cD6+bI6uyZoKjUm9u0MPsNEDC+bxdHH7/d+LrqZE0bwTjCM9q6pOaEkepf4?=
 =?us-ascii?Q?rn3LIOHA0UbfY0y5SkZ+J0bk6ecdziavCnyu2y2RpvHgGyRHAx2MdDY1L3aq?=
 =?us-ascii?Q?8r1KYY6sLOFu/ba1va8JNL9OuHsmPQ5/qPe6WxiozeFwGUVO9HcMmklSAr6b?=
 =?us-ascii?Q?7lxLHMAQLENeAsFERpXLDmXmJ6R6om7hDOYZ8c1JDnSeuVudgsYL0PU/ifph?=
 =?us-ascii?Q?SnoPmtHOuTfdrUL83t50N8RDxNPKPMW65XnbPa2OOrX/MOP7T7VIRq9HyPpx?=
 =?us-ascii?Q?J87NbIdETTw7TCuLvlOPo7TVtKI26xVVc3vAVQdAus5UgzK487jjbSGo3Lzt?=
 =?us-ascii?Q?hHkEZKs/KK+D0F0S4mgJVL6kA1JuuJeTOupp5eLEX3iKk+uyDKqUKUG4ds/A?=
 =?us-ascii?Q?hanrHLMHm3f09DG15VsaKgbM89Yhhhu1HQcOBdUM8oebVNc9iNiI7obUi5ee?=
 =?us-ascii?Q?4XrxF4atdQd8yTFpoolxeb+klpAqcZODF7tKpZY7WX1uksezw9B5zPkNtPwN?=
 =?us-ascii?Q?Y2OcwQ32wDV21lRszSbH0XE8GXX3P0qtSFth1UzgE2ppcvvFhngvzM/4cIkf?=
 =?us-ascii?Q?PVoS5rslmuKYNEoSfoeaQ7+4JeJab5qybkXU0PJ0bT+k98K/pkEKYhmTKLcx?=
 =?us-ascii?Q?bTxz5V/OeoRXnBRi2cCi7TDjGVX36hxwSWmJDmWudRwaTgNIu34BMOkEMhar?=
 =?us-ascii?Q?5OwKp0BNVL9trguZQMskQQJeC48NG2vPqN53jiJvRgDPxUgaZ4uFp5PAn53z?=
 =?us-ascii?Q?rcI4ow936qXwZwFzA3frMmXNzUpTZsx5QQUCH5fuAI6BWPSVBi0sc7S+NYis?=
 =?us-ascii?Q?WX4SV1nJ91EhEODG0/HgEy0jliS00FlriHEe8MPvEcJ04UmZmcxAvK3hkLug?=
 =?us-ascii?Q?+sdBw1JsR7pmj8EIsocY1DxQcIahtxN2s9IXKDItPRw+989mSfhMTTfovQoP?=
 =?us-ascii?Q?RDmMM/bVKXUFEqGE230Xb2a1qAoeDoaBlbI5NEGhW+fXwN5VRQuJ0b5hoO/0?=
 =?us-ascii?Q?PeSzukqz20qwZozYXo4d7ESaxD2fE+pM+Jl5fGI/T/bdD8OTTkTAZnyujFpv?=
 =?us-ascii?Q?tDSEu+cwzltd2K6qAFTlDsWifa85IwmWev/cQIo32Jf1huT4g6/EVXkJ0PIt?=
 =?us-ascii?Q?aTCtWpZA7TM0zfcIR9b15BsciBWNxwmiJaXvUX9b+6Kc8jaIRPAoiq4wyr1n?=
 =?us-ascii?Q?gg0tKPr7AN/2raP75ohE8OuFIXnE5v0afc1R/NNKPo2mKmZEhZTPrqnPrrsu?=
 =?us-ascii?Q?kRH00OqibQklnc4OkQcHOfT56ZUNlvEn92Wb0E418v9BJre1lJB5OdwP7s9t?=
 =?us-ascii?Q?CwnQKKi7lKDzqnJdpPIp+vcHGj+4Oen5AK2eP53ehOABI4X5zRSxbSlfbb76?=
 =?us-ascii?Q?BWWTRjyLznTuIIhHIzCAUYJN0qwvubposRLy73wHYD8kzWP252ZoOlibEx7C?=
 =?us-ascii?Q?6saN349WW9+GAu6DpCn6TISgoeHepJ+J99KcaEv5/wE95nhNkl2bi6pjW6fp?=
 =?us-ascii?Q?eQCR6F7hZ5zeOMUoM9ZQ2SHu9L7+kj7JdYslomy9Bv2nIYErh9LdWr7Gn4XQ?=
 =?us-ascii?Q?H9r6JXOfvLxIGrFPxaTDZJPFvmA6dhVejcjS/0xZEHvywD3yEGNLLcagyOT3?=
 =?us-ascii?Q?Z3+ozexDRS9pAbOgmGNdgEdOnz8xMWVztQ857I3nO//YnsigXLiFAIaJUfYY?=
 =?us-ascii?Q?VfdRkYaJlg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b00bce1-73b5-4498-6e79-08ded8515069
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:48:08.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yy91a29ypib72Fo+ddy3XWF/GbqS7Jf9tyUI5e80rzzrTzCf2biJniD5Bpf7UMoP/QWTn2BrSiaamTCOes/REA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22705-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[81];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AEA26F9E36

These callbacks are sysfs show paths. Use sysfs_emit() and
cpumask_pr_args() to emit the masks.

This prepares for removing cpumap_print_to_pagebuf().

Link: https://lore.kernel.org/all/akANJ-AT7nHpRMq-@yury/
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
index 6e5cc4086a9e..ff8bbf07c94e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1327,7 +1327,7 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
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
index 954c36e28101..d2539cdb9212 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12694,7 +12694,7 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
 
 	if (mask)
-		return cpumap_print_to_pagebuf(true, buf, mask);
+		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(mask));
 	return 0;
 }
 
-- 
2.53.0


