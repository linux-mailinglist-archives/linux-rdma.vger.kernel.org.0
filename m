Return-Path: <linux-rdma+bounces-14603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D013C6B50D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 19:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A41B4E78E2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E322DE6E9;
	Tue, 18 Nov 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKQStHqt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4132DC323;
	Tue, 18 Nov 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492317; cv=fail; b=YvFCDrhXAxIU+8ncg/E8OMSNDLdDMlJLN+sRgR+6Jm6RDjRWdK/A6so0yF7S79qTWZ+cgHt2fI/BZc9ZJwulzB1wQsuY9LSgfqc76p109qwYnhpd+H6HffhBjb3w59LFYqo7ICH8AD8l0VBWlrJyNt30r0iKyD3KTxjV2TXUpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492317; c=relaxed/simple;
	bh=3+Gby0wSIFTU3QEGimrXmNKB4Wu2/1MQyBK9JL7UIMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V8pzFsxCzi27P6AnPLfCMg3SXWbnL9nCJkRQP4YO/RWYuU2JgwVg/HMHqJDcIH3fWkbBXXqNasSqISlH0LEN3g0kiPLbefJn2qEquPyANJdtyCRZli8/VgsSboVXBfryILBtXw61FIwa/651sbsvotFTAsS4keA5EqMeeci3U3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKQStHqt; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV2grb4p/a2LMbJkOBiOKS4tVhp+dpcLPCxWj/g5Dq9sKuwPY/nT8ux7Ww7KL0AD9eWHxNNoiwFFZ0JxgDgTwaHvmOYbh+iHksYHrC+O1BqOf4C93vwAcLAxclqCete1eQ2gsav7vwGv1TdOWmBZ7BaJ+wVAvcyWbFjTmOIAiGiv5ZDL51aiFnw+Y6AhnHgVzExGfTkln2LlCHYNT9P8+9p3M/3lFx+uNBIMp70ko9JJy+RedyK/z4TjHPQiG4yHkgEB4m4yUknuF9k+12S53Yf5tCaSdUQiZ82KTsiLQgfOjRyvT4roinQTqWlpRVJjIs9NJ9fFY7K9oezwT89Zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnvTyipbFZjB/FYngVeYVBdkf+aFBS21OLD9RDVUhyg=;
 b=mgacMGWf5Jt0iB2bcGm2/BiPla/5vDFkUIDEj7SH1zxE07aVVi5hATcdgdNJ/6USmF4xfmx+6jbkxSE1/PG8g8ZX4CdMM8fkJzAsjWWdqTZVhyx4qYxQutlOX8Ywy7nMo7srsA6YPOTCvI/Q7PZ/On5z3SI6OzPJInjUOa3d0ww+EliMQ/1eegaIVQXPgTxG11r8zYqEkjezAGP9pE/J2rof3zff36dSVZciRNMEpV8fz9ynIgWe7trQvsxuE6LNOLobGqnoIoYoOOqD0XLtjA0GlUQLGvTiS1WfM5ENA0LaTovRwX2m12SN4dSWG3lU0LoJFhPYBH95YB40a/uZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvTyipbFZjB/FYngVeYVBdkf+aFBS21OLD9RDVUhyg=;
 b=mKQStHqtvnR1i32k564PZQXLuHK3EupPJcmF67AK/8ScNVzZlAoyQhDn6MmEkcmzgvRCdnuvlFMz23WA8P2XF1JrBcaFx/rWtCqrhHjL2WlBKx7mjikFcYo5x4e6/+H/3mxF6ZGKL4jZc9zg4rYxUUATb2nAXQVv0B+7n9EvcXtzWE6vFXIoeUL3UVCxxoM/R/FyZKMvkMSY8cNSWyHj98aMub8FftQw49HI1Hq7ifur4jrKGAuqZ/IQGYFNFN/T3EB/pK1FwQmiAEe62HN0Fxu6ZROB4AeX8sJzcOHVXIxd3qhW9t3oHoCDFKV/c3ke8HCJur4VZXS++Pr1gmjA6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:58:33 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 18:58:33 +0000
Date: Tue, 18 Nov 2025 14:58:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Message-ID: <20251118185831.GQ10864@nvidia.com>
References: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
 <BN9PR11MB5276EFE7D236FF918A79263C8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EFE7D236FF918A79263C8CC9A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0724.namprd03.prod.outlook.com
 (2603:10b6:408:110::9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 432b2126-8a58-42ad-f2e7-08de26d4785a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BjuVriZopgjCyOPesFuhwAFrHBYjfCZBpx4NSYqAcd/Vqbtpqk95BHsQU9L?=
 =?us-ascii?Q?2wsSYaPnZq10GOcXkC7PRKre+86ZFFKc1gIV+cNwfe6o5I1jp4log4qnDN0R?=
 =?us-ascii?Q?3Q+HsFjNgwLsDiJjxElAC8bMYRX4C4SYezFWPddyovP58DzRGcr56B80EUtR?=
 =?us-ascii?Q?hbTIL/snMl5Y8Xgesd0cTyI64EBUWurAEWj8HGozMUQpJ7zCEWnIpokN/Q/L?=
 =?us-ascii?Q?NDw6nU8d3TgxWfs/rCCIn1GSohYmDWSCOvKHnlzbSaumdoWD/iXbiZlwQDsJ?=
 =?us-ascii?Q?0vjdTspbzMRwm6Ti6oe1G1mBBcBhbf9pajgJC6QLMVFNUN2KPPSML1OrZ5M6?=
 =?us-ascii?Q?f9aemq1wVIZR2DRZrAMc10OuRxyUSC7RjLrbXFNpmQzOeUIqLqQF0BPyQ0Qo?=
 =?us-ascii?Q?yXt9OBm32b8SEPrl5/ODh+NUFGVgk++9eMbeRTqMEvAykX6pdWCi8MUhaFVR?=
 =?us-ascii?Q?4ca73t/ZLTxlw2YoC2K66+r+mr1t3fnzK9/YAel8VO8bTFmDuzXI96WDaY6Q?=
 =?us-ascii?Q?9NDdayCFNM38LM1EYhjdsvWONa0o1eBwQKFv4Ae6ouBpyKwdfts+C9n6hxW9?=
 =?us-ascii?Q?y8kDMFXXmANViEWxaVXdIz1qtbOB4+K0mp3TWrxpF429RH7GuKHlI1xUvGpb?=
 =?us-ascii?Q?Dsmpny0EMmiYez+uHi8SWxoAGekv9JGhYMUuySw4hdEwD3KzCOeklmkZq8wg?=
 =?us-ascii?Q?aBfhI84BKzunotXXYq2YH+sJ2wzT/zAbj0BGkzHMu6SUXSBlibcmNDIHWvB7?=
 =?us-ascii?Q?C6hIUpa1khXMezDg8AFP/UOGtPGeesTYaVH6Tpdkdx5K9mJu4kKZSnsPm8XJ?=
 =?us-ascii?Q?svfQtvFydKraRSMh0cPtC//jJoiQMSTf0FU3WFwhzHK18WKdTbI8PSSas+wO?=
 =?us-ascii?Q?HHH1cQfqzJsMIGG5tij4iwGC9AAVkP5BMMus66Ul/oNK08q0Fg2URK1bbFPY?=
 =?us-ascii?Q?bO8/9PgBxuyn0JhK2TxNOs0o4UQsSgtvk40e9YtP7wAL5UZX1UjttwnsZzDD?=
 =?us-ascii?Q?SHvkZofTmYgAlCaef12svgGTZ4DnSYMlQkZ3kMYf09Ipwy4k1K44yTgyIKMP?=
 =?us-ascii?Q?LKGbK1uWWVWCfPAX41e9QydSB9fwydskCQxlBxTWGBmZPwO4rQF0vjP8HOfT?=
 =?us-ascii?Q?A0WXh1CTRXaWZ9ghwcLUmGaa3YVmBdU93FG1QtrnM6dePiRCPDAv/KA58+Cg?=
 =?us-ascii?Q?tAsX+kVgznfXnBrfVvq6y33o3bf7S20UO8W2/tmpNIJPtknFBGxreZn4ZDfS?=
 =?us-ascii?Q?EdIDC72J9m36ivjn0kT7sfoP75uNLmPZXw/kitBrTdjKZa3ZUfQS3N56+App?=
 =?us-ascii?Q?cFRyLam8X7QYJfi0fxoHuXf6D36EBjwEmh1W6tRNp5EYkea2xcWQnuIicrY3?=
 =?us-ascii?Q?ih7aOBzCEIpCes16/b6UCqQl32yXa9jqsUT1tJyUb+K4hYsFAS9XZmcYAb5T?=
 =?us-ascii?Q?AjFvY/SJyjeCveUlRkTP385mdYFr0pjj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vuaRDbV2nKb9yVwCFSYjPMsi6ixeF2f5itZzyQgIIueETvaXWawIXv7qyFa7?=
 =?us-ascii?Q?fAX/FHUnoAN5/CUkj+W9eZHkVeMrrkoorV55JM8QuOE4jUzn3RWEdCtfiigt?=
 =?us-ascii?Q?eMjnmPYCHqFNR5PhV7YbCiwgY1nA6veQ8paBqvHJ+rxc1OAVZ7GmgpKHcVbL?=
 =?us-ascii?Q?yhknzLDdP3IWtm2LWaDbB0kwiEsNRGR993mbENYSwWli2443kh8mY9SQYd8L?=
 =?us-ascii?Q?iE9fhYNkBCjhcW/nRZZ13S0SRpGwSEwm6l/xUh1/MBQRqL0XLT2FB0AUdw5Y?=
 =?us-ascii?Q?065rYUlta2pQwehSy9eV+fGUCHFMGDXZs8WBATNPQYbmt90N3+yANMyOxK6d?=
 =?us-ascii?Q?SR1DTjpaG8QlmWkPXZ/TeVtkj5oy2QFuwrb6NONS1WmzLP8AzHWQfcVsQaIv?=
 =?us-ascii?Q?jW1Pwok/d0DPJHCn9WFR+f68oNs66RDzh46r9043BU40dasOJ9UasIh9Fy0Q?=
 =?us-ascii?Q?p2cemob6/J4Oqsd99SYAWcaZS24BnVEuDFKgGlhfWdyPfgaRztzJpPNSK1S8?=
 =?us-ascii?Q?XPp5EnQjoTJW0quQEsw9vSA8ikd3jHyPlMceMifGO10YdE5gvJdgD23aeeHv?=
 =?us-ascii?Q?RNXHnRIPf0wBxX3tuXR7ukDU7Cbk/TYLG8hb6rKTV39of+6bwPNTvVmlLPXU?=
 =?us-ascii?Q?DWulrmB2oWF5wNPm5T3G7PcGa5WiyEasw2D669wFpfUt2ZfD+oFIrj8MvgSB?=
 =?us-ascii?Q?ktGqyBX1lPDybGYA/mcbER0vAGF+FClwfhw8Ktzp8uwDRM3G21e59xYApZnk?=
 =?us-ascii?Q?jqJVf9ZuVYeih5Z5tUFuQHGV9+TfM4Jxn0i9w0uzMCmrNOdjNx6Hu0N5l32/?=
 =?us-ascii?Q?hViTTiOTHv0/v6pQRq7s2SvpOj5raAZHO1UhBmLIej0pHEjVHpG791bQ3EyG?=
 =?us-ascii?Q?RxpGQsEeWEJW9FE2dJl9uDJLpV5kLpXgiPfBlH38k/oZicwBzA3ZcnjGF27O?=
 =?us-ascii?Q?08z1kGllm9ozccOFHC4BIVndEkpl6G+CPsOddOT9O8v6dCbUu4SboXFtTsSd?=
 =?us-ascii?Q?xW+8YSUSlL76mbgaJ0Y0VbAI63+yTFgGJltF3cigsejoYYqKqa/JuzCZIFql?=
 =?us-ascii?Q?bEnuInuNO/D926/CWklbCdjxD78VcCI/pBAxKM+5cOhqzTVM4fUc3OhYGbe0?=
 =?us-ascii?Q?t0ZH2y0nqgvBkg3ZuaiIX/CBfBss6psvB4LtByh8AQrZJMdLGDEZXXpXexOC?=
 =?us-ascii?Q?fU+/COYhT1w8tG1nESA8HHbj/L/B7lLYcitDTcYLwCxC019kHeAgmiIqW3Bx?=
 =?us-ascii?Q?hQcIycesuLt72RO+UxKIjjqHd04adIfJhLSg5oTaMhB3mHtyYA4ocZ1e2zGf?=
 =?us-ascii?Q?olPCmU1GCfT0+YL0s/ah7sXBqW9IFAkOOCcZbzWbaT94JaJ5H+hH9Zb+05wH?=
 =?us-ascii?Q?VXvllOqft6M+ABpYAP7DdawUV/4aWhgiIdqJ+rWo3GNT30GhkfumM2he5Und?=
 =?us-ascii?Q?UQVh/lrEP6e+QwfkaQcs4NYzQfJxz0TMyCVisaCKhbaaO8ukMhXTiABKcEF/?=
 =?us-ascii?Q?dHp6Dhk2xnuiBL6nkOTqtPW48efMmtLFUQI/d4lF7wAskJ8mFFeNr/AeCSq5?=
 =?us-ascii?Q?ozz9rzM6uW+PKp8BjoM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432b2126-8a58-42ad-f2e7-08de26d4785a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:58:32.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhR4SwgX72Y18hvJTwkgMQZSEKO4rPrqJcCF/+yysxfPumzJ86Mr4d9RDO2YDFRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931

On Mon, Nov 17, 2025 at 06:38:51AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, November 7, 2025 4:35 AM
> > 
> > This old style API is only used by drivers/gpu/drm/msm,
> > drivers/remoteproc/omap_remoteproc.c, and
> > drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.
> > 
> > Remove the dead code to discourage new users.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 2e1865daa1cee8..d4d9a5dbfa6333 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -854,13 +854,6 @@ static void amd_iommu_report_page_fault(struct
> > amd_iommu *iommu,
> >  						   PCI_FUNC(devid),
> > domain_id);
> >  				goto out;
> >  			}
> > -
> > -			if (!report_iommu_fault(&dev_data->domain-
> > >domain,
> > -						&pdev->dev, address,
> > -						IS_WRITE_REQUEST(flags) ?
> > -
> > 	IOMMU_FAULT_WRITE :
> > -
> > 	IOMMU_FAULT_READ))
> > -				goto out;
> >  		}
> > 
> >  		if (__ratelimit(&dev_data->rs)) {
> 
> Remove amd_iommu_report_page_fault() too?

I don't understand this remark?

amd_iommu_report_page_fault() generates the dmesg logging on iommu
faults?

Jason

