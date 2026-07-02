Return-Path: <linux-rdma+bounces-22696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GouuHZGLRmosYQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:02:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85D6F9D9E
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="NM/JJ7Wo";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22696-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22696-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 629FB306A28D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECC37A826;
	Thu,  2 Jul 2026 15:47:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84A33F8BC;
	Thu,  2 Jul 2026 15:47:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007270; cv=fail; b=gwVWu9GXSxvZW7L62HY57v0Bv1QnfwCCdSuAxBOlsDWaG11OHxfLFNo0M6Gl3yb1MAaBaBWDg3GvdATpdPSJyXgpwua24sYjrpOjywbCa1QTSOQ8+TFt0DjHtqnwzmG2Nntd7R6JDdOuBJTex5sy9VXWzP6gDD22RRSSk2qbvEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007270; c=relaxed/simple;
	bh=M5qecf/he+38CqJ5c/yMNu8OBYkNjmSuxoMYR46wrYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4fP8qfiBb734fCkuI+8XUufrne4KYg2KXdN+WEGKAJx01Ku/rCRXA0mUBhUappy+xJZzmMt5uSKpDBlWE2Q/i2XubaHRTLegzlYlUM0Y0Cqrepd3EnoKVzLPJXbc88XcxioGWjKa0GKDg8doiIVFOX6jiaCqfO0u5pa1f9hD4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NM/JJ7Wo; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by4AnE05FPlyLhcSv6UWhtHwAULtF5DiFP28hauEqVPXsj5NgkDT5p2JPH2+RQOLpKivjONPlixC7c+pjkK6eCMBoJuQ+L1tTBMlfz+TG/zNoSsO6HxWYbI+dgF3fyVWTZw1nMOaMjDXzsCCEtp90F0x5zDEBXIQA2rOaNsVXqcOqtv2tNvFET4gfHaWJmxXBV+nIEmoy1uavyAsxXEcWlUT5I2D5lpywlj6WFd57clnk27RThj4rApiOgoz7QBa9YWZvcma7MpkjjFNLjYY/WJ+twR6YaXrO6YwkE0tx7wRnICuNYuzIEzU80CIBEIRw+9wi5PR3wVEVTQDRQyoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn8n+pGYDMhkFlIKVKjJ0v1Iio8ipeHcfND83HTvPzk=;
 b=vBkOlxvSP/h+sjPPoE3nQq99Z6ptZRAYT8U+zYJLd/hE8DjO/QbvlLBLP2Crb/zE/Scwarpts7SknwxHdoKmgu+w3DHprfaxoR/XdgEpjsiTLyFOZdc7DMMFJf7tfbYukTF8ZbZp/1coQpfJ8CHbTLjqqFUBkQIU4Z9EfFtOPJZHrYUkfTI5MtYvAeMKuB616zj/a0PgjgEsnfZiYPd3WDPkHILQk9TP0HDeznT52chGPIKCtHtGOb68dMGaFEjPMCgGNW4Y9IY7HPjs/mmVNCPvhWfhZKrzfi/oeEEkOMkYetjXl+LqkzSX+GtMLSBCboP6Q/VA89tVQ+y1Bd/fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn8n+pGYDMhkFlIKVKjJ0v1Iio8ipeHcfND83HTvPzk=;
 b=NM/JJ7WozeYnOG/J8YSB1iY8amHpllOHnTfrBkXCqXBGek9i+9tFA1heAkcZAE/ThxasUE4eLr+3ywZyCaCSyKagxITX43pdNeh3KxXXAmIUfDN2oqwmzR26L9TLC0wrx+pgS6gZKwQTmTqBSxHDnD/gqc/erQN29RrRinjCahPCyUNmPDiJNl2F9gOvJE0xaQAX8gpcWhCSzcxf4ooNnEIrpZnGp84Gg3qVAFCZGPoPzd31pKR7kz0NnmUKqmcx3EKteh+Me6BCUq8Sd6C9jXV2tJPZYAzfsL8TKJa7lP99OxVlEF/zXgAhtPcx7a5figNrQM+E2ufbRxZM8pxlRA==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:37 +0000
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
Subject: [PATCH v2 02/11] powerpc: Use sysfs_emit() for cpumask show callbacks
Date: Thu,  2 Jul 2026 11:47:15 -0400
Message-ID: <20260702154725.185376-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b9b716-e4db-4bc7-ba75-08ded8513d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	NSavR6WSDJTcrHYsGcIJWNZ/U52Ijy19CaMIwO6qp8rPummn09Gu8gasu1/J8mA+V3bj6F4xU3qXuofgtSqCzUf/VKgekKe0ETSSyiy46E11jOawUmIHJW69taX55AqSAj9So6mu93qRiB5oC4Mfi14dBYaqJ1vKxbLS8nLsJ/HbYQbeqzuLuXpPtF90DdAODNrB1eshNRF+kPvNBCpHVZoeW9L0q89MUia4HrI6M/j3TNTEJNes6KBGripOZYJ71Fqgu60cJ+xkf1cY5BYWuWsr1MiosHp6yQsriTMOTPbmxPdHipE0ODkTTXoeOK0PVeKAjTY6xh2teH954XXGpivIzNvenY2k8ZdJSiDuTwIuszyEHBI6xIw+NGBdpIL4C/Af1kPRP2OrKZ50If4xTjhuKMTYVsvmeZ3E4IAX9dMVAv3FxT1LsR84PIGuoklM39p275PdmsnYl+6LT0NdXtRM0+FeaI62VzDDikg8TlsNUh0H3KtE5+EoHP8kqCaQzL55YGnjpV2DnnSo+iFfwOIfdpEbnJL4Gn4LYRVxb1MlxiXqbKquzxzjahh8Ew3QkH89xJLrKMZHrbT+FXXnx3dtx4iO8JBwDK5iGC5x78HVO3nUjoLOugwXtmKZSrCR00p8awAnPENe5oTnaId7rf9JLDrSSz0DyI5QVvnZ8Cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8aH0FVQqF5ABtyRp/LLTSNEMHtPdinBsdnVPxQAUfyjOnAz3M0LT63LwTuk?=
 =?us-ascii?Q?0lFdUsKIScX32vtu6C0n+VVVsC+47ICXm3/qGiFzC+5ExiqOHb37btAZYkxw?=
 =?us-ascii?Q?YMl/sjdbTzWaIWgCrgdlQS9sDeXvpuFRWmomhPdNCR0JnFhkhHzFYPQt+usd?=
 =?us-ascii?Q?MawBy+witQgLExtL+tuncp1+ikq2YFwjrbReIWSFkkCUz1bvEebASTYqJ18l?=
 =?us-ascii?Q?gqgVZhGpXWTLa3a9mUE4PNDdzBQ+/khTHDyuaMlJt01dH3L8TSZMaSPFr4ZZ?=
 =?us-ascii?Q?6qoQ59m8d81hr+Z7H7btYaihLiIztpJA0xvaRjQrs8tR6iJ898OeQwv3Ji5f?=
 =?us-ascii?Q?4XyhFSA/xtxHSGDh35OyALs7PE4GeFZxI0420yMYSIgtZp0koaREjh6sNgvJ?=
 =?us-ascii?Q?kAtAKN1CwUAIal2Z4MXNlJRP5WBAEGpf5nKLfqDe30fJ1eb3c5jyrkyQ8PlA?=
 =?us-ascii?Q?pSdiHyUAThw/JkgUizSIylqQ9HS0mWKpt5rITeSlLzU1z3hsEpbHv1IkbbA3?=
 =?us-ascii?Q?v534ToTkRoF4XV79INZ6Ys3H4HbO+fjIu6yJkZbQb1DQYM/u+cMuvIYbHsPw?=
 =?us-ascii?Q?Fka5iGaVAQEV1Ze+9J4f87kCYFSG7xk/smZ5o21p4GATDIspW3qSis7spFGW?=
 =?us-ascii?Q?5t9Omzh6NNv6Od6/uq9dejYSCHMKooWZ8zwInAGzS2FNR6KiWT/ps1DOqZP0?=
 =?us-ascii?Q?7QPOQrTCwBKK4/12/AoOQodSh9uiphR8JJCOJCm/49yMAIs3RvGTi/y28FwQ?=
 =?us-ascii?Q?3X55byyKNxW/3sK568B8WFfbeAF5MlLSJNM2sM3MBjN7KXCfXRl0xNXuFSVt?=
 =?us-ascii?Q?z/5EaJx/S3PCibbXE2GnCnS+8lu1VFolfyr5auVo2s+Sc+4XnCa2viIIKtuf?=
 =?us-ascii?Q?wjxE/gxxkfmT4wUaXAk3uI7MUHZgp4Lydh375YJgboDq+Hnx9WHTdWYT3Xrs?=
 =?us-ascii?Q?KGvcgvunngj2zbwrXFC+7c5FvYDPs/elQK/M+jLX2h5OJRZOzGlN8E15kH2M?=
 =?us-ascii?Q?ORqBMEnXQLGxp8eplmb3/2jYhNio0bZnTMNZThOvkANmmlouT5BjkVWa5iy0?=
 =?us-ascii?Q?i8mA6/nQWJqO2iF2I6V6PpPk5uIvEv9RQK4pswI4izWo+RajbX1vDL8v4WKG?=
 =?us-ascii?Q?Qz2pS5Ulm9w4CgDuOmqWUt2q6NTJyOhHSrW2ON9usGm4FhXWyYODx0wbFgCi?=
 =?us-ascii?Q?AXOaH/JlbiD8f0f4gR8wA28ksx1yF08TWToPyWffRSJ1uhnJg+9lZNT2AzPW?=
 =?us-ascii?Q?fIheWB7AgYRK9pixcDdFCS8zCqbZNuGTZxPkP4h3TUSpAcAiAzWPw0fR+sL2?=
 =?us-ascii?Q?5QaW8lNkHN8z2VA66LDBDVnvCJMH7MOxeJOaXZZSfsHaUzS2jOClebL1rlOs?=
 =?us-ascii?Q?F01K7FzjsBFfeWelizUuUlOwuTSZ9yYQMruH7G8jRR00L3nYlE4gj5xyLIUv?=
 =?us-ascii?Q?eAUByvM6sShq33cHf3xEiCBDPHNUk0eFsBh3IEoZt5lbWDqNWhQrqDgLUXuk?=
 =?us-ascii?Q?T5uUWbtPOTH2EeAlwwLgQUO0XjedhNSkjSA41kzI9eXJGmG5O7d3vbRBovJf?=
 =?us-ascii?Q?+g2KDLipCOhHX0+8vxA/VctJqxr61ArBS3gNh+DZFEvrVAOsZPTupv003i6O?=
 =?us-ascii?Q?Q1n1bYi7RrDjdzAtjmh59CvUG+GSw6xCSHmuDFgP50OX34sgO1DWd707hOwe?=
 =?us-ascii?Q?VMWW1dMM0+HLTenrxbNvvPlO8EOo+KtahlR1JSZUmK55O5XI47IB6S4zzzUM?=
 =?us-ascii?Q?UApmRa7KbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b9b716-e4db-4bc7-ba75-08ded8513d82
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:37.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF1lLnJKvJFWAi2q0KG5ZpqaoG24DDhH7CLtMANowEjDkhO/Ou8JGKdwSLYXUeav0Dn+3LDaQERk3/CcKPfvyw==
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
	TAGGED_FROM(0.00)[bounces-22696-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 7A85D6F9D9E

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
index 04e5ea38bdc0..cb0933061006 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -690,7 +690,8 @@ show_shared_cpumap(struct kobject *k, struct kobj_attribute *attr, char *buf, bo
 
 	mask = &cache->shared_cpu_map;
 
-	return cpumap_print_to_pagebuf(list, buf, mask);
+	return sysfs_emit(buf, list ? "%*pbl\n" : "%*pb\n",
+			  cpumask_pr_args(mask));
 }
 
 static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index abb4cfb11fcc..b0eedf185960 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -429,7 +429,7 @@ static char *memdup_to_str(char *maybe_str, int max_len, gfp_t gfp)
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &hv_24x7_cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hv_24x7_cpumask));
 }
 
 static ssize_t sockets_show(struct device *dev,
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 7269273d3aa8..76495744f52a 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -100,7 +100,7 @@ static ssize_t kernel_version_show(struct device *dev,
 static ssize_t cpumask_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	return cpumap_print_to_pagebuf(true, buf, &hv_gpci_cpumask);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&hv_gpci_cpumask));
 }
 
 /* Interface attribute array index to store system information */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index e3822f36c419..0be4e98f7ad1 100644
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
2.53.0


