Return-Path: <linux-rdma+bounces-22701-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTJeAvOLRmpIYQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22701-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:04:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D1D6F9DF4
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 18:04:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=AqQQnNbU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22701-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22701-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDED5302844B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92264414DDB;
	Thu,  2 Jul 2026 15:48:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200373D9555;
	Thu,  2 Jul 2026 15:48:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007293; cv=fail; b=SO0ZlCDUATUdF2a/Ng0mfvO8yiTUQNIK+lRFqr5tq14TdJqhrwLMWEiZAG/qEC7SMonvZy0u7jxDQn/BRj7zJKHCajXwCQezP/hHH9EfMiHybQf+TvUxFn+EgkZVr2GLxJ/lEmb7omoLLqPwGinxdPkL5DDwNOlG7n+YxiY1HEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007293; c=relaxed/simple;
	bh=9ahpGRDwtAR+NKXKmZlKtzFRk/YQ5i7v6L0gbTL/T5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8q5JzT30besI6LXmHHKYPUI5uLHjRLe+vlqidqLgVwlW7jN3+msB8pRofF+OOkULyagsKi/e/wuArcl84ufRd52uhlmuaAJbUUw8rE/zuodm2FCmzKbWMh5vmLC2mFHeAkSjs39ODM857N/cNo/GfwQ9eWE/mksGX1uAP7ZWR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AqQQnNbU; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1Kol7Y/FhkI9GVGg/hcIJFKDputHGOwWDhv1NB+Gjjf6x2sXdqUSeDhvBsCRkKJyt9f31j2MYm0FS9dkIReJIMi3F0RjHQVHYkMSwcx+5GIRcJJgX5bNVGciV4fhaZakwsSpoa9JqCwwehTnB6Ld9QXvZ+gd+jSeB40rqqvFCaZwLWT5j2u104dEWpzBlPH8bAwnhQKgMydwbjSi/qKkdFuEx14+TXvJy4M9kemd/OhmdPZJIJwVSv997HMx30wXcIFM/cjEFBrrmU/qye+EukiQs3VDWWQVoMtkj52SaPX3QOj/sNWNM/AgrR0UKawHBsOrMb6qw0rCdjjljDuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yn69/theIkiLLJBGczA9q9xQLsSPjMKLeb2Zm8ojtjI=;
 b=cuhDkX4VeZJWuSx6z7S/qcCX2Vu+Z2mkMD916+l7r5rYPM0i3sF7V0tOQqTlrff2/EofslAlKsCgdqNTq9UJzsKx0T5/fFYg+M+6BUaydhAN67vAB1YNjNWr3XqeHgBU7NXk4jVMkSAGVeIPYKuU07A6JuYuIxZAC9g1qlnCeSMUAHLKHf7tYggYggJSa38AEvvNC013ibVh6YU8oYBjymwEYVoFiCs8BrSouvTk438ar6iLK8DocIm335k0BIc7PwS6H0j0JoUPKqXvc1IHlo9SfPWc1d9DSfpeLkCMO4K98SlC+5bmbFNK4OJtLHZjfHI5AVq393LK+L1C9mdc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn69/theIkiLLJBGczA9q9xQLsSPjMKLeb2Zm8ojtjI=;
 b=AqQQnNbU5RuUD5juZosdbUvH60vc4ak+iF5p4mJo9iQZqsBq4v1Tpx3CLvueMDN8GSOIHPzMVAvAevw6loeY326RN4yH2pHZwCvbrnU57/rwhMLgJGolmUZEGXvA2f5Asli3H2ExFkNrvW8d99TrO+hkOfU0AFXFBGa1D8BHQfqDgqtXrX/WDPpL3bzInHtXd7Fl1kkNkRYaKxsTxd6+z6YMfxV0ImCGJ8TBqsBZJcRliCLRclATdudFFK3WBc63rI71HqQzZyDJ67lOMfzL9BdxMsfJawyXrArfmArL/XpdVVZ8W/23LnqvAYrPRaf18VmfDADRB5qKhu3bLt7vwA==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:56 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:56 +0000
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
Subject: [PATCH v2 06/11] fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
Date: Thu,  2 Jul 2026 11:47:19 -0400
Message-ID: <20260702154725.185376-7-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1a6715-d4c9-474a-eb62-08ded851491c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zWtjPfi7D7aPOYAbF2RUHFWpuZGJdmLNUWAeCyutcdKwPEetXO/latvboP9oWc9nypx8wUFeayNHol/2WLZua7I1Hgc+1RX/T16uq2GdSCP5WgwAA1T8HID1MkQ2t8ij/HHRjJKy9rqIudysMSHio/679jze7XFMV0Sl/K3EuJE7cUyv4gjqINsVyzNjhh/JojrrFRSQvBhaG2iL8DRDAp2jcyYpGFFUnn8xEn+8tzJ4N0LB1vno57A440Oct/yYg2H8jRzoLli+Hc3RMwioh/2PGdkE5hqM8zUtGA4B4xuByGtV39XfHmIW1FtjVTxFuQcOQ5N7OWpfvsiWsl694mvoMXiL0lT/RUKIXkTNc76xj/feBeH1xJ281litBsgIuZ+xjq6x7jzlDf3NCt7nVH8XHRnJLl8l1F0SLoHJNEZckCiCodna5V95iaynWaCtGibQ8205DTIe0sbpNkvtorSiqi5BtaoS1rFxs/psOdUjTwi9uyL8XpLYsJQ2U7WLK080CBPEjlJLxGR4ManA9Q4CQ5g4p281VmapRSQV//cWtwfYd0Z3WMNM5gnCIJz9/WwFF/f/DKvAC9AyQKssbnaZG/sC6D158hD/cLCalTg8V0GaGDMxZo0ktK6AMKxJSPrF6kvVxXc1RyIE2OrlJsi69+Cq0MF6vpV0bGHfPRQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UB5ZK0wqwmDdFXtVAB3W9DxnWOns7bmOJgGfWFua4IKtmHlNOl/LEPuWzyTv?=
 =?us-ascii?Q?7dAd1zwxNDlAAUdRxrXzgsa77Lfe8NCzMyLqLaO39kd5shrTva5n6Byj46w9?=
 =?us-ascii?Q?VR8HTdGqtlJx9DCuk5Ga10eTl/Gi88DLDmYasOV7OaTQkWNlMfsBMmWTccQY?=
 =?us-ascii?Q?EZoSq3vlbrT6XWVBojyiHkjoTb37zznJPm84U0kIN5ZEyPjuAZK3J4DtswA8?=
 =?us-ascii?Q?r9RvRZfqheJCUHcySsPI4pNCcVVKR7VYk9EEI03XTDeZN7D76EH7LimImBG6?=
 =?us-ascii?Q?5iWhqVd5Ker2HE8MyN1QwMznkEGNeGtkkP6NqJNYYX0KmxxfaVzzlTKXENWW?=
 =?us-ascii?Q?9ssP9TB7sTXWGD+6GtkN0uaGV/zp9GZ35j9x5ISEONaFuNyXsh8sPL5zDAlk?=
 =?us-ascii?Q?8d/xtFUn6TAGufwsWbDX3WV2U5h9I67Jlv94lsySBx77IeKrdX0XK6I2oXeD?=
 =?us-ascii?Q?GDh0/uufRop7J00DXbqCIwH5kTLiLcjf5t3R3DFm3ie92J/O+n/SLxg9nY2o?=
 =?us-ascii?Q?uYGyIdp2CuPHTn0rD6TwlFAuFT8Kr/bO6/WdrRY4YwsYI2zWorfdkBo/f87+?=
 =?us-ascii?Q?HDC+NIONTqoWa5azr/LmqnG/kEZ6L0zN/2Mb4+V+T64Tw8Ts639xumUOUvp3?=
 =?us-ascii?Q?5X/imQBOvGRAg2BvynRAEKpypI6addmackyrVLDxO7ASs9D8uldpAepPnT7u?=
 =?us-ascii?Q?jTtAsg9EJcYwXbvI/AqQ6MpvG4haeYJ/8EkwNsJbRNvWWr2i42d3PiwbXNJW?=
 =?us-ascii?Q?8iZEyWk02An+mWKSFvvDmYSEJE7dJGh4hy/IMDXei+JU32Wj4X79TaE8+qbI?=
 =?us-ascii?Q?5Xi4udnk8SEPl1PaUafLAKGxrs2Wg12IabYgvwBoKuRJ3YXwWJqQCir+BtO5?=
 =?us-ascii?Q?/Qtt0bSqQtbYAeH7vHisektmbMDRe2svezE9YRV9wl9Q08QjVBQ7YGCBO1pA?=
 =?us-ascii?Q?3zZK2D+Qx0yrFrzdqxxo0m2wITH27lWE3JVXj4NjxUOgZAN4RgS8Xc4bcGt7?=
 =?us-ascii?Q?HBFtgyl/thryUXhZ0SmFqNTmCuWFD6z9JdOiBPk+AeSYTA5prVJd9QjjLlgM?=
 =?us-ascii?Q?9yb1yrL3sta+qx2iMACSRNU2ITYXKAWBvNuSsJDn3RfOFpT3kJb1+X4hB+CD?=
 =?us-ascii?Q?dpGj/gkLYo616v8umwB6bSxBTwvSfMNCeq65tByaavlwR/DI/YkPop9kzi+j?=
 =?us-ascii?Q?aVMFj0jTez4+dzsbPGDMWFfr9JajsjBbF1KN3WAavTz7W6S0bPFNG2tm8d5a?=
 =?us-ascii?Q?mh32LXqDIU5JVMCNNblafdurTlVh/MhDvOJxK3MSo08h/IOMALDL1SKh/0kU?=
 =?us-ascii?Q?/xzeI0Qd98XQh6sJGvhRZlWCc/Bv8gK2ni5t58W1ERjFRx7tUlYiVX+/Jjah?=
 =?us-ascii?Q?3uy0ss6eSWQrfEgaHZwtbaA+f1uGF1ibe4Dvp6wght0dV145wl/lWrFaaQ16?=
 =?us-ascii?Q?aiEEpKeeqrcAJb7Q9PRViFUeIYojm87fVtPjkV2bhy69VUf+jGWHZ8olZZ80?=
 =?us-ascii?Q?NqK0glIK79j34YWGCQ+SDKCxvycdu7CSHRvHXk0RZxsJvam3rXnVWwMlbegw?=
 =?us-ascii?Q?V4dGfUd2MSuHsviXeVSWFl+CySlqnbMNWnzpEvgRa6BO5nXz8lqI0iATSIsv?=
 =?us-ascii?Q?ZS+Ho7tbOkVlOszOIA6NIm+POAuPpyiNskG8B0BPdGKRJFsNR/Wev6LrvXTT?=
 =?us-ascii?Q?Vnt91pCEubgt562Qb7yaM+k/S1/PVPwkZxWf+36W3dwm1cl0ELI3zM+ZBgf1?=
 =?us-ascii?Q?FNYqmwZD4g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1a6715-d4c9-474a-eb62-08ded851491c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:56.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNa6fHMe5QpPuRk4W12Zp17NAMrYXyRSJlRJdsKXapSf3Io/rHk9zqUGDM7ivcVeK8fJg80FcVMVmO8oEklskA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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
	TAGGED_FROM(0.00)[bounces-22701-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01D1D6F9DF4

cpumask_show() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/fpga/dfl-fme-perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..7aa4983ab67d 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -183,7 +183,7 @@ static ssize_t cpumask_show(struct device *dev,
 
 	priv = to_fme_perf_priv(pmu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(priv->cpu));
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(priv->cpu)));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.53.0


