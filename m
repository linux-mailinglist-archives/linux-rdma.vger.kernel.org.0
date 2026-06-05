Return-Path: <linux-rdma+bounces-21843-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id itn/N7j4Imq9fwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21843-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:26:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA521649C08
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:26:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IxC7U66U;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21843-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21843-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88682301B1F9
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A03E6392;
	Fri,  5 Jun 2026 16:09:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6063CDBC8;
	Fri,  5 Jun 2026 16:09:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675777; cv=fail; b=ot0Y0HT4Zx+0BJozR9irc0/NoDzr4f9L7pJGDj0y2/ezrzUpY+rfQPkMoWzv5augghsZDOYHzyESw09SXvuq2p2LQHJBJQ7AtjJ5/CxJOeOv3kBvhTvWgTWPz1i9hfJb9Py4/iboRWXQrfLGXlzF3yZywiLhImIdWSecUXWoqIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675777; c=relaxed/simple;
	bh=e7lHko1wIumcoRr5oM3Lvm6mZBexbOeJpky/VO20IN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECbksNt3k6mS127AVv6tKwZdm6fepmCKyQUeLuWQ5kFJ5R1k9TXgvAtcHnuO/l/qUWy65556xv0AclNIxVWFTxsIoKb0qxHlqy6NIOnmGXU79lfwz39PeV5fQO+spbneJW9pqtX97LVS8TCVRPIpajQUZ5rP7RVv615uu4W9UiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IxC7U66U; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaFaJmpt5+9jsCCBaEPR3BLYQjYauN9P5yizPH8SFBUIUEfeoSEeuoBUW1zlK1sT6bh8zozJkXDT1yBNAUz058Bk4I4tuAG0mJjeWfCkKWyEU9bRyax1IyNBbDd93wp5ILbju8VpLUusTGjSwvw3kwiao7bKGXrig5R/7tEoXI/f/lcDCE6ODRBQlpUU/4wp0Om33Nbih2qoURLKY7AyqQVuHHTU0mGbaWqAj3s2TeXZGRHrU06C7kCvwO9tSOGECVJFfDALNmXAp5W6L4zieqcaAoABWcLt1qSTX0ClPcQ8uWiSKve/qGLIpFOTjefWab3yZ5jqYcgWDXaKwuBAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDfNLtcylePzNWLUPopOd//+BcXOUazsu21yikvOchk=;
 b=gwsvpsF7yQWr6zdGl5uJrOyj1Phu7fFXEL+QHJY8NGq7cvDEHt6Csl5YO/QdGqrPAG/yExehst/MV0oYQHK1jjbqFaKaFoznXcx6YmEVTSSPHdrV7LATzq1Ccm5v//DBujc3NNeU9R9V7c0PYdmPLDmXTUbPyr/kfLzCl+Ud4CLiWKzcdN90OujM83Ro9RdlT/6x80XtoMwtcLWIXtaDiREJFxNgVSDU6mI/N4d0XfQSNI/XI23ZIb5RfkjNs9GgyqnMuYwWSIJwUxDmO1PBTT07Ss8NWcfGUCdM5lOgGM5IDPyprxNyY8xckn+ii1suDXp3xwCpE59Dssaaeb7qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDfNLtcylePzNWLUPopOd//+BcXOUazsu21yikvOchk=;
 b=IxC7U66USkYRMC7eRyILi+ctojJV/X6MC9tjYstnHOnNHELUlZmHhvwg9FHHwe41mERKJZDN9ElKKp8FEqrNdJOPAIpkF1+xYtICHCndptTwUKZOWYsoW2AfgEDMSZufi4PElm6A22XhgPkWNxjJs32YQ2oCVe6lU1ovqZVSV0a6tvdCshRC9GRyS4otY3LdlQi8whIEuntPgfQ9oZu5z3VOwNLByVnNC1KmV3H5FicV8bD5XNMDKcvyLDMBMSfHJUNCs5LB8JABZpeEjlWQazPkhVDrLMEPeyzWM6Gr1o/zHA2eUNmTndlTNXPvhA7stvDOF75aQ4IgHUC898LTqA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:09:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:09:28 +0000
Date: Fri, 5 Jun 2026 13:09:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev, Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix typing issues in the umem code
Message-ID: <20260605160926.GC2728758@nvidia.com>
References: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0703.namprd03.prod.outlook.com
 (2603:10b6:408:ef::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cee133-0d8b-49a4-2fed-08dec31cd1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	1a906idieTtH2xKU4MdBEzzc57vBfQpyvri5kNxMoICNs0ijkWQsIkcaonv/FjS5Ea26pEscAE2G+pn1hX6Yr54Bsbekmy/XYfF+arwid1mWasgb5G1IMT8xp1xQ+pGT3nVOkrk8CvKRFQuQDUFs/hsSu2MT1mH2cKcUObhS8jOMr4sNTtl6T6nOL/HHEB8b2eLPgqNJE5wcyjx8qlkHsWf271VkMWLkGOW28mphOsrHClCdRL/qNohSnn+0WhnKUxfLqs4/ybDXNCnHeUaFg64OYTLuRWMFMkmIm77bEESod4GgZblmZ23VF7JcSB3OYd1ybZFlAqUmPnVbOOSgRgM/7dLry+folv9q8hoem6hnL4j4HwHhUk1nKZNxgL2Aj24WoYQY5W+RXOV5qRjAqg8FNiuymJE5czDx5q1bDomKS6PX/bMVHDLGNVG5iHj7qDqlvI11Psz6Oh+aZTAuc5LlS0QNWLeiT+hN7Tlc31r83Tp5Mj2p2v427fL4sPafw1eVW36e2QVBd9uZLeMkNaVMS3iC9ykiDZvj3oXFf5zrgOiybPwLm49+wZplslk1v1gMF2dEMvBySXFxwu58Z+ohzvmrbc6ZUlgZMXhfjzWYsMhOsN/Bg4eF+Dg1NpK1xH26IszCQiHbduMbmkUpwwrRczfoPvAOUjrRgdICwnK9SiH2ARgOBU2iszSrY/EF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSFO3qlOqGHD1HMuhbUVn2xwfNIuPN1ZJKe2KEWRssi4WEpLQuW0jVU2yFnf?=
 =?us-ascii?Q?oIwCDm0/BAMKB4MKahzKTVNfB23dq6qhe47zYXf7H5atY62RwIXpnJxRUdFO?=
 =?us-ascii?Q?I0xOuKrmxXS+ccCTeoFEd9j8aqarmd7IBH1zMGY72IiUdHC4qi6V0+FNElMV?=
 =?us-ascii?Q?2gILl34T/9Ejz1u08+OVUT2n/RiBkZUhmEv4Ysa9AofAErF1krqR9Yy2jOwK?=
 =?us-ascii?Q?V5lZyU47vdjJT29/5ICR6klebzGejUB+YyHiFVkWUf35AKhYoSqfvWUZiWhY?=
 =?us-ascii?Q?JOBzcQP9st+8tXBfBHhBhdxqeFqlb3AMpj+PZ1h6xyBO7LHTdTEMP0EWduQ9?=
 =?us-ascii?Q?9R8d9CrYrtgEz7ddhjv8V5n3B/TO9L7FROvgJqRU6+maCy3c+cXeabXtrY1U?=
 =?us-ascii?Q?zibQIq8yIhKe9hBzLMsH95ShRJFPJnt4JGpLkM5o/vr3qt2F9/TbVWl5SNNE?=
 =?us-ascii?Q?ostskKITaRIKX7yBzBYGWrIQZIXZBYEsh70+xaMUDcWwuDh2d2vrOBOZnghb?=
 =?us-ascii?Q?Q9eMAidqU/bQ1Yf7x76wcKwcET4c/KFvXqUYDAnRZaUVr1JLKtpxsXefIfDw?=
 =?us-ascii?Q?kMHrKP2foFccEiSWcIO4Iv0Re+28sZ87WI/b6if8riqtX+iUpHWZJfxXEAHs?=
 =?us-ascii?Q?OTobjweTbFtL2kvTiasrx6uY2jZzUpo32l7z9eRvAu22Cw0BH2Uda2iJ0GSy?=
 =?us-ascii?Q?EzaLICx9NMA5c278hNtdYgQgIvYCLzUAAp7hANmA2iEL1WynS4plnQAOm1ro?=
 =?us-ascii?Q?J24ayOObmEtH+qhfv1TUgEBZzHwLxcRH1T4tcKZdtiuRKiCZv9S8Y+AfeQeF?=
 =?us-ascii?Q?p5HqWqBmmRPhBLQ00MbAsyRe1tTV8Y+qFXRw79WKjIZrQsNjQ73D9+eJTlQ/?=
 =?us-ascii?Q?9ssIuNfKf/bOEr1NHhg0oahW7R2tkIbIjvfsUeeIHiO0fziJmKjSm4BMAsav?=
 =?us-ascii?Q?otuFIig8Lg8ENTsPolyHXCx26tMuNbPpEft8/1dB9MfnHjQcAfAIJmjaW4Oa?=
 =?us-ascii?Q?mLjJt0OJolIUEsju41XNASsI2aDPwFzI7nv38CpTrvciHHw5UTY7W8TspArC?=
 =?us-ascii?Q?pf4hPFX7jvP871rykAX8ffkrWj34pHExISxexBobC3YCVlfSnMqrtwb3VvY3?=
 =?us-ascii?Q?G9uI8p0i9lFyLA+wIfsNKK+JyszRMfeQEKICS6m7IxmhGviHPxHgV0F6gk3Q?=
 =?us-ascii?Q?tJqezuvL/BhHl1UD62gLO1b51DcPTJOprLvVAPmJj7DhrSjCq8adFUQTV+cB?=
 =?us-ascii?Q?Zl9lmBWtMxln+RqYB4BeeeK1EW8jXV/2+mWyo+PuzsLAzAEmQYZ+yWFrefvI?=
 =?us-ascii?Q?k5i8zc2PtLDvlkpZfxeMBvPd0dDs/zJ1lZhAW4P3sSnwyYLooHSsVjt1FyNw?=
 =?us-ascii?Q?uN1s3jgQONSgRmiQ5VavVqBpiLZfdxwpKWdEIXWXmp9XmbfbuiGuh9uMqVBD?=
 =?us-ascii?Q?Co67/IVpKlJ5d5AScR1AvnV+y6ZJCKnl0KNTjrfxcOE16nzWTwmJU+Q2f1gy?=
 =?us-ascii?Q?JxJ9L2Gz6KppkgvfruFUH18h9T6uw2CFck7Sp4asNWiCizkow0QiqvAaLHwD?=
 =?us-ascii?Q?OKW+BqAQmM/Ct4OhwW0t1glAyfFL3XIV5HG6ka/O2GZRGBxvIPe0QUClbEPg?=
 =?us-ascii?Q?s1bE9vyGBRr3OLGtz0oFiOF7mjEXZZto5vo0V+skRooeYjLD6PA6bLEw+gP6?=
 =?us-ascii?Q?d/mMPtwMjhP6hcn/HfX0BuS9yTICsrZ3J6nnL1R1X1SN4Gnz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cee133-0d8b-49a4-2fed-08dec31cd1c0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:09:28.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDkn9xHjNdBJ6u7BHHrAd1jYRHBKEbwD51lIWi/JhOWB9ICNzNeo0+tJRH1vDdYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21843-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:patches@lists.linux.dev,m:shiraz.saleem@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA521649C08

On Mon, Jun 01, 2026 at 01:52:30PM -0300, Jason Gunthorpe wrote:
> The types are tricky here as we have a mixture of u64, dma_addr_t and
> unsigned long used purposefully for different things:
>  - The on-the-wire IOVA address of the MR is u64
>  - The dma address is dma_addr_t which can be u32 or u64
>  - unsigned long is used for pgsize, mostly because a bunch of bit math
>    helper functions are used and they are obnoxious to use u64
> 
> Fix various silent truncations, issues on 32 bit compiles and
> understandability.
> 
> Jason Gunthorpe (3):
>   RDMA/umem: Be careful about boundary conditions in
>     ib_umem_find_best_pgsz()
>   RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit

Applied

Thanks,
Jason

