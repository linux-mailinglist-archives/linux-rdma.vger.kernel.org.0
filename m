Return-Path: <linux-rdma+bounces-22698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vOmpAUuJRmpTYAsAu9opvQ
	(envelope-from <linux-rdma+bounces-22698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:52:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FF6F9B56
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 17:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EsBNvcQn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22698-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22698-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E424B30E2906
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154333F5A7;
	Thu,  2 Jul 2026 15:48:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D91199E89;
	Thu,  2 Jul 2026 15:47:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007283; cv=fail; b=jPDmipQdQkz0XmmnkOc1OnoD0ZjINOxHB6szp4y++hoXtpDTluhMQ6WnREwTCLH21v1ddha1wmy0yMGts5zmaccrRrbeu9kG3f7nCG86LLnAVhuapm8c3E/7Oni814lPAIwuSYiKjJtj3IkQKj0GKx9z76VuCBY/VDJo4GgQPsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007283; c=relaxed/simple;
	bh=9CAEP7cPih1ISGFSCaYX1pJ0kfwKTGMqLCV5Fxm+L7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hflrGWk/KygSLP2paZib2cAmrhvfdxRtiRX391Lp48eA1YMU6hOAbRHWLVLdq2mN5enPNgqcRoZACOTyyPablINbe6v9h/jHs3hMkoee5jvMWE/t/murtLEfwSo3lXN4j+2mYmGMW8vuz4zotWNhu6tVKDY7qTa6k+FTlF0a8ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EsBNvcQn; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0JF//SDWMwzVuih4w7m5J+1SBTGUIT+24/U+AI6ovN3MWfaptRVjqguOA17I2LwZa3s8Fb5UgDWNAvnlfbnUYCjN2j6MbD10dvSBttQNpG/yltZbzdb9sYrq2Dx2YSJJzvm9Oy4V4J37m9D3KhpnwX0hj8+1+bvekD0H3jcO6V+nSl3F7kySb0eLwHj5mv3N5fHgqUVkRCAn4LvbX1kHNYJ5xhGA2HxoGKLto2KFA3ukni9L6nFzka3bwtYgvQruseo/tDV4VFKBBVcCDHiw/8ojOPCLa49wqnqg4naukWfDyamceHDS7sE6/C2CawTW7VP53I9KC9bhhDoh69X+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf7fl2HA3W/doZIayzv3GDP1ev1POgesb+QSPxMhalk=;
 b=AppE5+UExqoHfZ+t6WZ/Q8G1aMMeV3qcOW0C7lrsChFhnzjCiEqwDDjFKoR089wlQacSr1SmDJKZUb5uBkPGsqqGID4egvoXjVuyWmS+vCrHIel7Hqb3i987Z6hI0VpYemPyE6E3kcqkHnTaLEs5SMoqT6jwWJQvjKxGNm0jMnVhnWf0HIOLzlRVjOq9yAfGKsJ6i0eBsREUtc8UEtxhh5kmiuyn2RGilmRmhC9M/g0wzbub0lxLsrwNVsTAT6U39eqVt0znc2Ug2kY3EbXtcqC/9a6hvt2x8BJnCgOZ+gVlC6XM8oMTuTqeVwPUYjkaqA58WE4LYGCKZyb4S/cFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf7fl2HA3W/doZIayzv3GDP1ev1POgesb+QSPxMhalk=;
 b=EsBNvcQnLPmEc72brCqOUj81FNq6G99K+q/ymeBFwpR9n4/Miw3mjQ+usa1X+ZR8gvjuthN1yu8OaKHCwnrdxguEuZYIw8JK3HBtuthIHfpsOimOJl1kPsm3IctYpDHI0i9UO/D4fc2nCvqRsF2ifoyg6FKlsgaLTx++2JxIMHnDGCv2xv9InOHQlVFdbBZQ3lRCHx9TURIn8eDOvP5MJmZjIsFzdJvNk17DMQ4ImgUPSpYWHYpKkGF2Qd2xo3jI+Vzu99Cej/OIE2NiK6J0ujUtZG3EzhjMmHyHpD/dQjnyaQnc0uikAM+2xB68VLh25IWhMJeL8APkHoQQBnU+YA==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:47:49 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 15:47:49 +0000
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
Subject: [PATCH v2 04/11] cpu: Use sysfs_emit() for cpumask show callback
Date: Thu,  2 Jul 2026 11:47:17 -0400
Message-ID: <20260702154725.185376-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dd5392-af32-4d51-d264-08ded85144e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/f3sNmZeApZHykSywWAPN1Ot/WsCtcAazRjoL20HeRay5pd91O5J72+twOsOCv2nUYRZQAhEdLlkI8uU+zAMRIYHqG1gh0+C4G4CY7sicxOjgts7CwAyYT7eNX/VwWg6qKyJbbNePQFyifkLRjyiL/SO7sdspeK33Cy7BeZOqoA/B3XfMTOuNiV5C4xScxlV/oeL0soX6CIm1wPD6/5d7pAs1oNZjLD/POAHD/vBgPwhYuL2CzU3fGTpHcJxgRW/d8eBgicgVM7SkHutddQusFegZZIAuOk+vhlDl+P93sd8vVPRf7Eqc7iFk+zkELvlcFMiErBvLZYzPntdjgggOu4HUrjcGP+udT0pW81d1+CYgoHbz3NQlN0p6zDHsHHIinanDDD1dqJ8XzmV87XsIJmpYjH/PyUonJ3OskvRIOdMGRMN+P0WGy8J1iawYg1jaMJN3mfzlD11s5xIGjMM3zJsOaoTcrqRRiVA8kU+IEHh3sywAAsfhACsMRzD6F3w9rDx8P8M5Ge60NeykJm8zFUwyRBC1qXrqfqtVoKnKPwdkbPny7sKQKNCFB8gG5XhbMXk12vj82tIZR3KhbIAlhuuZsLMTf2VuEVzpEAQv7POtqQ/Dz79fIhOpunZtQ5Ti3eulC6TCFJxrhhaGx87K4BH0wP7VIH68Kni4y5AdkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQNqpPC0oTRSNEflHzCgvt428IXONMOthjBJJknYKfEOLBuHJs4sXqyz6UYY?=
 =?us-ascii?Q?r4JfZH9R+Z4GLPDh4yDZN4Wp0fNOjLs/uKJRSGemBK7R0u7r+9YkXBD20Hud?=
 =?us-ascii?Q?rBQ1zfSySqiY0cbbVzYTzH6gRdtoLUS/MNUThNqfgRTk48OjpQ/ydfOyeqp5?=
 =?us-ascii?Q?79PozKgPsGPIo0nLr9Ia9RVZVlpPBM8nq3UOG0AMwdbTnb7GGILwgGfbRLF2?=
 =?us-ascii?Q?TCCoSMMBzb9WOEME814lVj9ibgLfW7N50wzRSQdrqTVoHKOUK/lR5IanQSlH?=
 =?us-ascii?Q?EOv/qfMH+VWS5O4o4lE5yWd9AVT/ICCuD4tEj4M4b8KK5ASpIzw9Dx2Ixj4l?=
 =?us-ascii?Q?Q2dYqTQrXJnibelxV9fTQP47tnszaxnxY8xVeOZUBT1iPWLe2vo3Dcb4Agc+?=
 =?us-ascii?Q?HGIoZyrMyGTIWW4Xm500wj8CwnSJbDq7C5KkPInKYctPcEx+8JSz/HJdAiPJ?=
 =?us-ascii?Q?xdZNyhSo7FJCQVR4yK2dkYGH0Fm/BDLlrjJXeU+4DUs4N6k164+oy6xO6ir7?=
 =?us-ascii?Q?goM1O6kDYry2AisDnjja1MFO+/CGTzHeKAKxoeilxk/7lqaC2lmL2uADydyC?=
 =?us-ascii?Q?SZAungtvlhNN2cM/cxRw3aHv3a/x3tkz2fhBaqvR7s/3iwD00JkJPTGkicEV?=
 =?us-ascii?Q?RlC6gDZvXPXKjsfXNX3Zi3vzfKpecZLpfNa7j7mneemwNIGZTH5oBYQMiSax?=
 =?us-ascii?Q?LfYhRenbPypN38FAUenF+/FdcZPF6A2Wkx0AnM1otrhuEOggFcvBUFkov+jv?=
 =?us-ascii?Q?DC1EuZ1GKnLqcpkE1ybHuPpkf3mPpCzjXuFXnhzd6b2YzQrJVlHwWTHpPlHJ?=
 =?us-ascii?Q?GVMWeRrfilJYuPZdlE1UkK86XG+mqoM3m7SMw8f83feUdVMe/UhwICr/2svp?=
 =?us-ascii?Q?kGeycS46TVs0BGdMrqRNK/ddU+3xJlM/IGOQYNpKvsD9RXQNN3fYjyWSjq5o?=
 =?us-ascii?Q?XRrx4t/LJP2xQQ0zV/eu0Ee8S2tWg+k1QgN24STCB5l/U2HzwDUrLHkf5/v5?=
 =?us-ascii?Q?yxsZEs2CFAwPTXTgeYV7wEYCzeIThp5NxkcC8TyeXv8DNCZHPqilzrIc0/6e?=
 =?us-ascii?Q?2q+rf99rbiNUyT9M87EG3KkrO456GYwNbE96Q/yIxehsEXBzb5NGvvBLAMn3?=
 =?us-ascii?Q?W0ebtyGZUKMIcA8HEun3zBGw9RuBGRomzdJCZOpoTlbxfFRFsQUdFrVev7Ep?=
 =?us-ascii?Q?UPu+cuOrwu9MsSlptvtkiWZVoQJ94gtUoj/tqutAbbQZtLYG45PbOi/6f/ce?=
 =?us-ascii?Q?XQXi8n3X5Ac17IqdZiVOtI36WAziXHk2nTHqgmPRttMq6WDioVeNNAAYK5oi?=
 =?us-ascii?Q?klEyJmfWAdT9rNu1JjuOAoAr1SsMNxL3PIc3FVL9aIQ5iFkc/wKxZHKIpKw+?=
 =?us-ascii?Q?PVBbmWrDW02IAskgyUzPkJKqHAcNneqRnwkSH/GiTfwkRI87+6/Yr8pmWCZn?=
 =?us-ascii?Q?fo5mK5/ny1CdjErMnWcPIoU0zKkDxnCdflyR5ZhGHLUDrSxLqFjn6cel8Qsu?=
 =?us-ascii?Q?64X62y8kBUIxWlOX3s06G4svanLIL3Z3CHuPdK6EBKI8HnrEfbAyvZkai9jy?=
 =?us-ascii?Q?6VSTk5hnRJUSBZa3fLavAXOfPdvo0jrZWGy+w559p+x72nbP4yr4Yy4m7r7n?=
 =?us-ascii?Q?gCPpIuTejAM4yC/tyZ4SwI3/DHiT1A/yJDWdHtU0Qk9uQKprRX7186fB4/0o?=
 =?us-ascii?Q?OEdpmczm41+O65zxAF36CSMjFCZVrljw5YrfwY3v+WHVcQfMe0Us7vnHyi+o?=
 =?us-ascii?Q?7b5p+glCEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd5392-af32-4d51-d264-08ded85144e3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:47:49.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAad0mCJKYWT2MMEPUZ6M9ZZIeY3dZQc35UWchK/Pbv1ZGwr5n1pKd4lXJ5bWGQmothRG/fV/KHotmrTq2Y+5Q==
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
	TAGGED_FROM(0.00)[bounces-22698-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A60FF6F9B56

show_cpus_attr() is a sysfs show callback. Use sysfs_emit() and
cpumask_pr_args() to emit the mask.

This prepares for removing cpumap_print_to_pagebuf().

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 19d288a3c80c..69e52fed4241 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -218,7 +218,7 @@ static ssize_t show_cpus_attr(struct device *dev,
 {
 	struct cpu_attr *ca = container_of(attr, struct cpu_attr, attr);
 
-	return cpumap_print_to_pagebuf(true, buf, ca->map);
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(ca->map));
 }
 
 #define _CPU_ATTR(name, map) \
-- 
2.53.0


