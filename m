Return-Path: <linux-rdma+bounces-22849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LRtdGudITWrBxgEAu9opvQ
	(envelope-from <linux-rdma+bounces-22849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 20:43:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE571EB13
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 20:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Hfvhbpny;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22849-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22849-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D46F3037429
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6643F4CA;
	Tue,  7 Jul 2026 18:42:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFD1E492D;
	Tue,  7 Jul 2026 18:42:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449767; cv=fail; b=cNiKMHOWVUy5urnFr2HnIISExOAublPzRAE+0v/UGPw0idLywp/CaolFogcL49ayII3ku8OF2FjAtL8CcONQFX7/Sugvk9Ujs8y/e64onO0nxJzl9vDC75ASMVnq1beELnQ0+cSDhPt69uKUCWlOWaE+0b/NIxFytL77tZtvYbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449767; c=relaxed/simple;
	bh=JmgLcGbYd1opqxH/2KwpP34ePsMKIANWKCZzYFvqmRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fN8dYOhTsT/dBmJrgy6BVV5+RQn+b0uTXzqXBKRJMJhEHWhCFOC7bt5n8PyyIJ/dQrlf/u0zoDGJGOHuUM3czvMXXpHqKcJEZXc8wNyZc2QNDjAQRH6mAQ/Hiu2SSAnsfB5Tv3vkeOk+6/sUGChkLhfLLLfO1FhKzt8XwfhCLEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hfvhbpny; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmTJ31Ct0+CUX97U2ZHkeLIC67kfdPmYljzcXQ24Eq72xGvEkrOtI5yYaSIcjiHbryxlfnUFDud1qPikhfgpVu7Asg8LGw6knYwEEg8Pzom6XlH2ceskkAzSLH5v3jrQgg1s5Bgw9tLFp35yTot6FPpxBIsmAVDepUo5ctsL7Mpjyk6F+GpBBjPrzOXEFL2SEDinpGyeriMRCNOLviJd4eBw68XjXDp66QBz61anrl2L/iRh8/Oczp02fWDutLzbS9XCtt+fJaxqMCAmxj0fvuCs26sgk6TWHspLoc+BfOtL6aQIKtE4MRkL/+VcecqPeXQzlNngHSPngoouWm//VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IIIY9pm8QsmrcsmVwRwM6OzE1/6nUvrPB27JfGzzx8=;
 b=iylyzlrc4c/wmEyxxb8Osn2/wtpafvvsCC4yT1r+wG5zsQPF2wh6HkBkM9OAJhlxz5LPDzMOPMANYrEm5CQOTvDQVIaEno6XoyquLlVFPZQ0sKLMU5bdvXvr5k687h1vgKzr38U8ahF7YdhKA4hch8SCEm9v40FJU7pggxGWvZK2DYop7sNI2X3rIOiiP61cxO08Xr6Hf5rfJS1OEPGA4klO21Ti/wFJPTXP5hCOjlBmxZc2ma+GNnyo5mxFbv1/5UG3Lpd8z94APxmJMd2e97c9CUaE2B15/y5aIw8wwm2H3Y/RCHSG7ucBIUVVdII3cgRRH6pUvQHMZOErMp/1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IIIY9pm8QsmrcsmVwRwM6OzE1/6nUvrPB27JfGzzx8=;
 b=HfvhbpnyNLIK283FnMtZc11O7Q568YHI2HJyZywHF4FZU91KTHyI2dejIn4X+I9JA0QOZ1fyNOXLr8M+FaY+TmLhGnWcHkyhFkwpuW/CyplekBCXy89HNQz5i8E2jFXPBGnH2CL+9yxvK+UZzphQILbyhnWGqJhz25pPkmovuxLYedWY4hGNNS38+MTND4n+SDLSE9jlb1mWPaaW3JRd9rE6Ktgyn1r1VDMA+DbC/cbvH/w5wLRTKe07lZqN+gmMSfyPykUWyrnbNf7xs5O/41MRn7c2owKJQ65zXETneeefJHbqrGoS8cg3ppgxh744YDa2DfvuTqIZpAHOP8QdyQ==
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 18:42:32 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:42:32 +0000
Date: Tue, 7 Jul 2026 14:42:30 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2 00/11] lib/cpumask: get rid of
 cpumap_print_to_pagebuf()
Message-ID: <ak1IltLSvhw2xj2H@yury>
References: <20260702154725.185376-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702154725.185376-1-ynorov@nvidia.com>
X-ClientProxiedBy: CH0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:610:b3::12) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fe8075-5163-4391-bea2-08dedc578130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	NxpmzHpLRHbkpQwIcSIbqnmUt1oSohXxde2OGgxei0cGQUG0PntrEJZuhETYGiDkfQkSrhL90K9iaUdXgb7Lmvk0FpHYsDiYegAwjmh2PYkgS0paPwYWxovWF3etkfsvgC575c2uC1+AbSZpPyGFkKmHBp+8heQlQk+XM0m8V/Q4U0R/3OJt7VTQOFdWp9d7ZJe0EBl6gk6QsSA9C2TMr0mzQtt7Ct6iOa15KPkm1Y0/ZqfWFdmqyokl4lUlN2Fk6oODKPoNdEE4lvVcTRkb0GrkPs/TgpabINay7QUgayipdxmKGlRlA9m5FAxHlC1sJi04lllmjuBKXH5wU2Qyhi1rhUWcMYHj03k1IAFTkf+HmnbfatkjtlJ3EjjOApqrTtFDB77Ooj+AZwuVgQiSWM7xnri+o50Qgk4F8z/U2ph2aKq5avzKyscbhLgQOZVTYlmBjD0eC5EuMoSWXycvW02femTwdL/v3wOTei+1H+kd44iQGMmrm4nM/vjs9Nzs1WDDMsKgnl0x+gonK8YTnZ+BXD4Bo5ugM8PSFWQYWvd97C/o/ZTyHhYg+WlMUQW5J+IkC7GufPiM7MTS1v9rbnH7Cb0c0iKYBTDQQnvZJi/PWnUGIWIAZuMzaC8jdKZvjM79sihzbWiN9syqiR7IFhfSyz0F0uFXoKUMrRPYM6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SiQzI8ohKs62x9Az4vlIly7jtkeb1zq7fA+N8Y4QXsU61R7rOL2lPYxQZrJV?=
 =?us-ascii?Q?jP7N+OUGHezZWOqNG/LoH5SUHQzpeU3DN2iv01A5qCWtqxiGFrUdkP/WVTYY?=
 =?us-ascii?Q?ag86fU/SBiF26PIDjxOXkIVIkOJYXWeSE/+U8dUBQHXI38pTnU3cLgtR5k3a?=
 =?us-ascii?Q?TMDzZ5ajUwGstujZN4hJi+nGZlMJEfmPUHGHl4Ug8FNXlkisEhdIO2IqDJLl?=
 =?us-ascii?Q?WAU8x41BDPDuwLYkSn3tKoWz94Rq7eBA/+kx3cMg8AQXhvIaxDpq+BbbEyLD?=
 =?us-ascii?Q?WyXKA0Bg1L/ob8eaQiAp07uaxAzOaEKWPXHEb4y93BXynfLoR4lV4maDG0RT?=
 =?us-ascii?Q?FMCiiZrmoJr5seo0du/jwMovnBkeer4TV8WCj4xcMKR9YkgOP/t2NN97u7x9?=
 =?us-ascii?Q?wtKEIKN3Exs79ezHOg8haKhW7f5JcCmi+Jr60sYIbJCeRaF4TKnQi2NZgrcQ?=
 =?us-ascii?Q?mbU86xNacK2UJ4u5QriD33CiMjlgwbd9/ZqSgdg0Xfz6wK6r8mlhYx2mdEYQ?=
 =?us-ascii?Q?e8NV3+VcqyPrqTzlOKpHONruyACX5W6UNaBUNCnGfpj4RVETdhU4FwKq/l7E?=
 =?us-ascii?Q?HizgZWA87T+4saJQ1OHCw0zy7xo9QAoprQUxOkZj/x8zlYsa8olqBooTThug?=
 =?us-ascii?Q?XtXTolV/G6yN0dhX9idQ/qb9pJVV4+YYcUhXldKPUNZxo6sR6PAenoS4UkMR?=
 =?us-ascii?Q?qvGypU0jO1wGKVOkQI75LusZ6WvOrQqrGJjxbzktl7Bzcb3+UCq7W4YMI8Tn?=
 =?us-ascii?Q?+0SCpqUjGVWeQJH5a/0jTuxeG1TGJzJAcnC5Dl0TU4BIB7Njy/A3BX8YXH/R?=
 =?us-ascii?Q?WcusWrkSKkU4CxJICvLYbUrCEOwfyLG5gMMBsz75Wa7vKmWMRoJ/HajiSwDt?=
 =?us-ascii?Q?sLWXsO20+oAFm3BQg7ewE5Ugc8OAGL00DBfH3Nw0JefnNNwCW3PThWs/Wwer?=
 =?us-ascii?Q?eWEo3cnHdPCm0KVOxcjfk3ICWg7aRFT1ULay1y4c4L5vZyxr2ltI8d/hp1lW?=
 =?us-ascii?Q?HIoa65wmbpVUmFT6DggUgCq6iuyks3jl7nJ0xkRRIrsZ3sDVLSdf/I4tXemx?=
 =?us-ascii?Q?SLwRekoK0bn9gx6cQFVQ6XZV0xuMDVSdZYfaMwjAbp2KtxjJMGenE/hi6T2D?=
 =?us-ascii?Q?Dp3wF5Rm01fFzulYcl0r8IvrQm2ip7ZazotHt/zQ4UZ2JVgJZYmK4IHgBVh/?=
 =?us-ascii?Q?BBUeK+5nJrCyfYxUsF35C8Itc7M4cH4QiICtKk9lNVxIc2Q4JqODoKdMdtDB?=
 =?us-ascii?Q?hpfmREYiRPwHE1T+2dmMWX7WCGcfXNCKvFLv2tMRWiVPIINgd4b66QYUPQUY?=
 =?us-ascii?Q?dWXcDUfKkC5TyFXUdYLt2vX/72zJS6qJP/ZfuVxMn9MJHYtHrNID0W2fVu9S?=
 =?us-ascii?Q?gALekxfX/Y6MVNjd0sdzCajc7HIFptn3zGIUeB4Qh4JIB8q2o5lwBLu/a1yc?=
 =?us-ascii?Q?7KGU+O8XVRe0gMr5V1lctB/X9rDPIaRlKdYjyP/+stqcqdnWHE4diBFIgR7D?=
 =?us-ascii?Q?TevUlbhUhTGr1Dk4bAUoWJB91OS+m9yM5lE3sIjZ9d3eRlkjsPdomyWKViYr?=
 =?us-ascii?Q?gjjLcSVlh6It5NIVUojhSIgRw7rKXIfUpDN1R7WYShiCww6NVRlD+h63FQlO?=
 =?us-ascii?Q?7BPZLNOTGSDFbZ4G6/lgY2dIqJnIX85aJwFrns6W8Bq2TEISe+AOc0Ge38Tz?=
 =?us-ascii?Q?GTq5lrSUyvCAF+HoUWUAk2uh8pytRVQ5bMGCvLEP4IDtgX5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fe8075-5163-4391-bea2-08dedc578130
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:42:32.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ94FGIl5fGyIsMqJde9xM/7YwLuqHPmfqSuXko5YdDmTTaQuMcbWQZX6PT8XmAvMMaaqUt/VzshdNwEyjxqQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22849-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:rafael@kernel.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:cw00.choi@samsung.com,m:myungjoo.ham@samsung.com,m:kyungmin.park@samsung.com,m:heiko@sntech.de,m:yilun.xu@intel.com,m:trix@redhat.com,m:mdf@kernel.org,m:yangyicong@hisilicon.com,m:jic23@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:bhelgaas@google.com,m:xueshuai@linux.alibaba.com,m:will@kernel.org
 ,m:jiucheng.xu@amlogic.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:robin.murphy@arm.com,m:renyu.zj@linux.alibaba.com,m:xu.yang_2@nxp.com,m:lcherian@marvell.com,m:gthiagarajan@marvell.com,m:jisheng.teoh@starfivetech.com,m:khuong@os.amperecomputing.com,m:yury.norov@gmail.com,m:kees@kernel.org,m:thomas.weissschuh@linutronix.de,m:aboorvad@linux.ibm.com,m:ilkka@os.amperecomputing.com,m:bwicaksono@nvidia.com,m:make24@iscas.ac.cn,m:fengchengwen@huawei.com,m:ritesh.list@gmail.com,m:wangyushan12@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:imx@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-perf-users@vger.kernel.org,m:x86@kernel.org,m:driver-core@lists.linux.dev,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-fpga@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-cxl@vger.kernel.org,m
 :linux-arm-msm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ynorov@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[armlinux.org.uk,nxp.com,pengutronix.de,gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,infradead.org,redhat.com,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,linuxfoundation.org,samsung.com,sntech.de,hisilicon.com,cornelisnetworks.com,ziepe.ca,linux.alibaba.com,amlogic.com,baylibre.com,googlemail.com,marvell.com,starfivetech.com,os.amperecomputing.com,linutronix.de,nvidia.com,iscas.ac.cn,huawei.com,lists.infradead.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,yury:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9CE571EB13

Added in bitmap-for-next. Thanks.

On Thu, Jul 02, 2026 at 11:47:13AM -0400, Yury Norov wrote:
> cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" notation
> in printk-like functions. In some cases, it makes people to create
> temporary buffers for the printed cpumasks, where it can be avoided.
> 
> Get rid of it in a favor of more standard printing API.
> 
> Each patch, except for the last one, is independent and may be moved with
> the corresponding subsystem. Or I can take it in bitmap-for-next, at
> maintainers' discretion.
> 
> On top of -next.
> 
> This is the resend of:
> 
> https://lore.kernel.org/all/20260528183625.870813-1-ynorov@nvidia.com/
> 
> Except the patches merged in 7.1 cycle. I'm going to apply the material
> in 7.2 unless explicit NAKs received.
> 
> Yury Norov (11):
>   arm: Use sysfs_emit() for cpumask show callbacks
>   powerpc: Use sysfs_emit() for cpumask show callbacks
>   x86/events: Use sysfs_emit() for cpumask show callbacks
>   cpu: Use sysfs_emit() for cpumask show callback
>   devfreq: Use sysfs_emit() for cpumask show callbacks
>   fpga: dfl-fme-perf: Use sysfs_emit() for cpumask show
>   hwtracing: hisi_ptt: Use sysfs_emit() for cpumask show
>   RDMA/hfi1: Use sysfs_emit() for cpumask show helper
>   PCI/sysfs: Use sysfs_emit() for cpumask show callbacks
>   perf: Use sysfs_emit() for cpumask show callbacks
>   lib/bitmap-str: get rid of cpumap_print_to_pagebuf()
> 
>  arch/arm/mach-imx/mmdc.c                    |  2 +-
>  arch/arm/mm/cache-l2x0-pmu.c                |  2 +-
>  arch/powerpc/kernel/cacheinfo.c             |  3 ++-
>  arch/powerpc/perf/hv-24x7.c                 |  2 +-
>  arch/powerpc/perf/hv-gpci.c                 |  2 +-
>  arch/powerpc/perf/imc-pmu.c                 |  2 +-
>  arch/x86/events/amd/iommu.c                 |  2 +-
>  arch/x86/events/amd/power.c                 |  2 +-
>  arch/x86/events/amd/uncore.c                |  2 +-
>  arch/x86/events/intel/core.c                |  2 +-
>  arch/x86/events/intel/uncore.c              |  2 +-
>  drivers/base/cpu.c                          |  2 +-
>  drivers/devfreq/event/rockchip-dfi.c        |  2 +-
>  drivers/devfreq/hisi_uncore_freq.c          |  2 +-
>  drivers/fpga/dfl-fme-perf.c                 |  2 +-
>  drivers/hwtracing/ptt/hisi_ptt.c            |  2 +-
>  drivers/infiniband/hw/hfi1/sdma.c           |  3 ++-
>  drivers/pci/pci-sysfs.c                     |  7 ++++---
>  drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
>  drivers/perf/amlogic/meson_ddr_pmu_core.c   |  2 +-
>  drivers/perf/arm-cci.c                      |  2 +-
>  drivers/perf/arm-ccn.c                      |  2 +-
>  drivers/perf/arm-cmn.c                      |  2 +-
>  drivers/perf/arm-ni.c                       |  2 +-
>  drivers/perf/arm_cspmu/arm_cspmu.c          |  2 +-
>  drivers/perf/arm_dmc620_pmu.c               |  4 ++--
>  drivers/perf/arm_dsu_pmu.c                  |  2 +-
>  drivers/perf/arm_pmu.c                      |  2 +-
>  drivers/perf/arm_smmuv3_pmu.c               |  2 +-
>  drivers/perf/arm_spe_pmu.c                  |  2 +-
>  drivers/perf/cxl_pmu.c                      |  2 +-
>  drivers/perf/dwc_pcie_pmu.c                 |  2 +-
>  drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
>  drivers/perf/fsl_imx9_ddr_perf.c            |  2 +-
>  drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
>  drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.c    |  2 +-
>  drivers/perf/marvell_cn10k_ddr_pmu.c        |  2 +-
>  drivers/perf/marvell_cn10k_tad_pmu.c        |  2 +-
>  drivers/perf/marvell_pem_pmu.c              |  2 +-
>  drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
>  drivers/perf/nvidia_t410_cmem_latency_pmu.c |  2 +-
>  drivers/perf/qcom_l2_pmu.c                  |  2 +-
>  drivers/perf/qcom_l3_pmu.c                  |  2 +-
>  drivers/perf/starfive_starlink_pmu.c        |  2 +-
>  drivers/perf/thunderx2_pmu.c                |  2 +-
>  drivers/perf/xgene_pmu.c                    |  2 +-
>  include/linux/cpumask.h                     | 19 -------------------
>  kernel/events/core.c                        |  2 +-
>  lib/bitmap-str.c                            |  9 ++++-----
>  50 files changed, 58 insertions(+), 75 deletions(-)
> 
> -- 
> 2.53.0

