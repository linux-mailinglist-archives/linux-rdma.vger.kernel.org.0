Return-Path: <linux-rdma+bounces-15055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB2CC9809
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 21:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6109D300957D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3FF309EE4;
	Wed, 17 Dec 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ke+RmEYV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26DF261B9C;
	Wed, 17 Dec 2025 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003814; cv=fail; b=EzXy5zHovGpaXKm1B1BrvJj/lYGBzSAqzicCaKEvB8bUwa7cSKI4uRSj2znNcsegeRj1dyqg3xEwUCDxP62n+CgDeaQR6Ysy+K7+NbzwUABwRBaZ6qUJHfAoLwdrRugZ6Xc/w9rXihdG0xylKePn4VlMvVT/67d2l3N1iqNy+4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003814; c=relaxed/simple;
	bh=fF5R+jjfw1a0S76pP3s+AExkbRgtUGbQBNLwjpYasH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s1MUxn6ze8o1cuZjFt1B8cJ+g5y+4kUru7FyDEQMk+cCBBHNjOgXYZ829zJStUDPcS9x4H6MELMlU8U96Omv7UMhHTzjD99TlGh8ZrpcKBkCh2rE/vT3HJyDX8d3wa9U6tkJoasakoF1n2n5IbHt1TXjrHdqRcQAQnPyaZrlM2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ke+RmEYV; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgcOntRH/0z20rFRTSaX2Tl1sJG3KzXFi0Mry9hwt7Y0jRplVPjIkSBLFXrGaBx8mZf36JXWCKenHJF7dY1atQrDMOcC5Q979eUXw68b9GVZErYqYt3HNaeBTGit3l8XQR8e3zlNw+3gwS6Rou0cb4rFVuM+eppVDuTlN0FGmg3sgtsLPPLTHRdbSlYQzj2WKQFkMhYF+zVywunuCyb/usz6GNcnhKjmRnb+rMXyF5aqPJQpG0vL3Pkk8DVUSnk2eE3i0If8nNcqas/vpFiVw96uEJhZ6XwF8quTJ2jJSdiZ0N+DiCvuGpgmfr5uV//hxlMTwKCiL2GagsSpAh4NGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEx40MIkEUGushvxbP5SF5WbEvi1LhGSMA3zl6AZ/Vo=;
 b=P7h+6XZfRkmDqO5LbTd2V0yi9TB14rSKeM1ppjqVi6Jyai+kRtDp677drEfi9qRLcIp81iKrNFFXOZKN3RDsjwDRkeJkUWY3kM/6UWdaJDOj/zoygtHIboeMBe7DXABB3cUuHc5YY0pRZYcNbuFRiUQjkcIAGjO1EkVyuWEZiMzUUzUfgp66SdN7wK+xB6+j1HefiGBm+nzYbsnr0E6hbbtManrnm7SfthXztpRII21SVuQsPgZ/X4bTZTH950WUUaX3G7A/UrkcAqkinTIbwJYuZYyhndrCtqyFZnsRLmLVmz63VftiT5dlOPRXCMsIVA9RH+LijOtusqrvG+kagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEx40MIkEUGushvxbP5SF5WbEvi1LhGSMA3zl6AZ/Vo=;
 b=Ke+RmEYVCsVtS0hSV1f5oUZPyo1lPqoTibCIwesyCzl6Uep/CO+BbYJXJ6dd08MTD17wRM330k8Jd2JkHkvQ46BnnoIbG1bEb1DUJE4EaA+aAHB26ky0FCwdnXWdqcroExMYJEEqRP4b969kwI4GB9qgb8cVP5+nVJicNdKl6kKILxHjdt9o5PgyjKjnPx/YnyyM0nzijRuLK+IS2p5Lg9x3IAT8WuQzPic74TS+sQWnbgWrqpxsp6JPKEj7hMjQgy7PRzIOmDP8Ea6va7jB9usLm2T3P7t5SVEpXhgs/e5xnigOn9Uaf6BYUlSrZCWIxDczJYKkyMJHc7lZ3PA3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:03:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:03:34 +0000
Date: Wed, 17 Dec 2025 14:03:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: check cqe length for kernel CQs
Message-ID: <20251217180333.GA211693@nvidia.com>
References: <1761213780-5457-1-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761213780-5457-1-git-send-email-kotaranov@linux.microsoft.com>
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d08811-b6cd-4036-3b95-08de3d9697f4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Z1HcsLaFCDe3cu2o/YRuTVkEDZ3WijOAzYVNW/XWxrq8s6rLlLyr9WWNDa7I?=
 =?us-ascii?Q?tgeyEcnraIDX22f+eIf2cwZae2NVn+C4qfqOwum03FVdcgt4oPNdr2O4bVse?=
 =?us-ascii?Q?EXPYpuwjiqPuhNTAFSQ+USOSaIJG23mD27+3A9ZB0qgcEhAJwrvoEM3cT44b?=
 =?us-ascii?Q?mWcOLwXfghtKAfgK820OUGJNFXIdIzkx3xkMnqZX5nLGQiu59Ev8qK7Bc0gZ?=
 =?us-ascii?Q?sU+xuQ470MihKaOK5MdKnVCY69b1nL6xjzbYb96I2rHEB9Cz7uITiviHMVS2?=
 =?us-ascii?Q?w1VAAVbX7X8gVIZUoQxqLsvqFc4Jn7m3QydRu1PMF5Xgc5yTeAzyO34tYonl?=
 =?us-ascii?Q?4VxiFuBflVOY0bXO52ZkM61+XiE1IGlDM75nGZEVvMwFNW0cjPq//nM1vV3E?=
 =?us-ascii?Q?Pc2HKoPgfcvPrv66G1TKopbOSagCcQPhsohCJmLL5WMSts012fIiTwUbULCD?=
 =?us-ascii?Q?vjRzXiJSlDN2RtxFWe5faCdmtgJsxaxVTD54xNo+Jiens3nWa3PNv1bwZdkm?=
 =?us-ascii?Q?1vLlYgZyjLnfslPjoA6oysVB2gIPd16swtGLc8hnMlK+BH49ByXYK9B/7ci6?=
 =?us-ascii?Q?tIPX4s/n6vco5DoLd3xf37/wrTEMVgFXLFUmo+hB5UR+GY9llsNj9hSquRS9?=
 =?us-ascii?Q?ZovmqScGlsxuiskO3BO9nIkQeeZTizm8PUN7I6quWo++hANIKSuWu/8hMI43?=
 =?us-ascii?Q?Scn4S9VP3X3v3l5MztZO6adkZDBSlPAXaCgahILflML80SfAEONDLPj9rNLp?=
 =?us-ascii?Q?+3fv/lGBOtM2BOvWhNKaGUE795p0LF9vb3/AdLYLZ5yPGFSkMdpLoimlvIHO?=
 =?us-ascii?Q?fSmur7fwUfevMpu+Af6fJZ6xF+RUDTVc4bl3+dso2Z1DQvmf8OIgWRWRUf/k?=
 =?us-ascii?Q?ZcPLdFLbvGrMFoFiLgZoOU0gn05myDDm7IvjwDMK0+hGqissU7i6DABITJMN?=
 =?us-ascii?Q?OYuIWRR/IwJVpfan/CImEXQRKY7fc6kfr6Cw13aogCK1Sh+WqLot3XgW+3oI?=
 =?us-ascii?Q?Fwk0ilf9awSYGfaLIiUkuOyISsSa0tcFCQr9DpCJGY0zooIkg6CZn4E0kFno?=
 =?us-ascii?Q?sXNk/mDj4awX57McNuSsdx7vjkm34dqTx46PaHWTFAaXB+j/plr4aoQIxvSE?=
 =?us-ascii?Q?chajE943XNFs1dsxsKXEJXIAd3iUooedZ9FIjc0kSYCecH7myzJd8Npxbtgi?=
 =?us-ascii?Q?yYnHGJX0ncQ9/BKEUB9PFfnKaaC71XW1iPhEsg6EHMw6E8NMu9kzqFvl1f7Q?=
 =?us-ascii?Q?ViNXfMJy+74vmMrx0wNUHK8txnw8VHBl7ywmEmoPXbM8bDI/iKlFPy0d1NuO?=
 =?us-ascii?Q?louDaTWdJ2KLuLHEZgCoK+XkbhWE7KWq2XLByLJShQr736/mIUbWEL6AWfOg?=
 =?us-ascii?Q?xxcln2g8Qahf54Dx4ib4rnJTKeU3ziZ+xPSp2Fw+8f0MuDIYQtIxqZt97Fkl?=
 =?us-ascii?Q?SqQZVTXaZ8pKXQjvfPCRBv6MhUpk3r/P?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qEub6KYV2cD1pvsuBmujXKgK5bflZUAZRW/dpuapgZ0zHSZeFkNgMDUKLvre?=
 =?us-ascii?Q?8xoKlVfSgpPxHqG0gWlgpsEdkA99ckEFywA1PNaEYT4fSnfZ962QJCyx+gO4?=
 =?us-ascii?Q?jnINoBoYpCtqesPj0Io0Mi++tizr5/e4bAKBiktuSuthXXrDsi7bIdUEIMdF?=
 =?us-ascii?Q?Hrh2qcCjdPRt6h6U3fhhTQaiP04WsCzMbpQNyf6DiYTJeHIuTa3KrRtpFjqF?=
 =?us-ascii?Q?nQHVutUZDeYxTf0XVbvU1ax+hvF4se1/WtDkNnthV4Zfo+tF9akVyzrL1NIf?=
 =?us-ascii?Q?ei99KAftKLR7Ti+zsBjQUOhvwK3ccym6t4ftORx5oX69pHmK7jap9cbO40xO?=
 =?us-ascii?Q?h7pi7zopZWUMKB8nRAJZxGuZu6JIX8vMPyIodmNL0pcSX1gyJRvQezlWnUDu?=
 =?us-ascii?Q?+RzTIgpMpqoUDD0msfltiWb2F7rq4AuXhjQvQdwGLiw+1kgLe++7up5MH6Ga?=
 =?us-ascii?Q?PKfq7WlTpRNI4lOuhudRSP4l6YtEvKJh38cVRXlZFI2FCLcLj5o987h27GmG?=
 =?us-ascii?Q?vp0S0ew4fFoQRVQ/eUHN0ZS5RK0aoTMNljISlrLbUYZrANVDisZvi/ZwTIsF?=
 =?us-ascii?Q?g5MIMaDuOAuuSnolA7lveQ+DkFTT/b12ztZDjb9aQp8XCgaAFReUwuFoD+7w?=
 =?us-ascii?Q?S/ywBxOMsUcw1xJqcdvZY5TG/eYiZGyfeapyZu2MSBhg7tmwmaeAKrQm5i4Z?=
 =?us-ascii?Q?znZ/7v1IdQI4xfouPBJZjDDqt31PTUWJOt+j9HFh3MuLNq3Iuyh9KXOopweC?=
 =?us-ascii?Q?b10aaXyhu4c53jyq78Hhi+pX2jGfw3aP50nbZdhubHdkIbOVI/zyw6TigoS8?=
 =?us-ascii?Q?5ZBpw2c4bLTyPDTYQ13EhnrCKqL9Re8RSwT058Je4nx1SQjQGiaWV1JFIXmn?=
 =?us-ascii?Q?AqaQw1rfYA2CQ7gszTvEFxDono6R+JXUiqLiFDNAyVyY3wUbkgzHPZQkW/q+?=
 =?us-ascii?Q?6ifRjT+R0dafmhF8BX/Z0S7aiktdYVj7OM63s/lXRluXfmkRK4UCga/2Ah9x?=
 =?us-ascii?Q?G1eunFfpFrdBf/hf//KWtS0oNahyRNFd7IBOOPIbSlXV44Pj7mBctIwwEodx?=
 =?us-ascii?Q?CH8ggj7cU1QYq9hVfYRoxXGMMMGb3TUNOSE1T2/RVRtuACAeKMcTFh+vQNx6?=
 =?us-ascii?Q?ok08JCdPY3ko/M/9V1WVqwxJgNNEcrPHTM4fMR3Z9swHBM9f6Am0QABJUFij?=
 =?us-ascii?Q?opkMNRaAOV/ZfQBqOzDLyCuUFcVYUMzFCJXabGD0g+ij0TFqeyTUHtU0VtGE?=
 =?us-ascii?Q?htbPF47c9zQBjcyS+6aW2HqdH9ELBQjnnVWP4/nlXHx99inLLKbBnygL8T05?=
 =?us-ascii?Q?r1V7mrOxKKjtkr5A99iFCtEQJ3RHxfZ1pVhD5YIwCFherW1c77nzwf8sYfBC?=
 =?us-ascii?Q?cyBmR1cG6j+uaMzOy6Qm/Eq12FDx+cocQJQ7nzUshqCz6MSDE97lNI4TCaBx?=
 =?us-ascii?Q?3ZjI/mT3YnmGb9OjHRyumJeEpnLtZEJJJB4i6WDVxkJN6xe1SmA4MUgE0L26?=
 =?us-ascii?Q?i1+eewupwksXBAuIydCojVflw0Mrddo/JTyoVKLf0ww4EAiosHunVBJta3+d?=
 =?us-ascii?Q?lQ3h8HcKMXk1AHw09Pc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d08811-b6cd-4036-3b95-08de3d9697f4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:03:34.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ino15w3r+DaxvRyKD/q/nrpJL65DGOKJwwdYPTwCuHvNmy7WVWrB4gw8G9wYXn2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

On Thu, Oct 23, 2025 at 03:03:00AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Check queue size during kernel CQ creation to prevent overflow of u32.
> 
> Fixes: bec127e45d9f ("RDMA/mana_ib: create kernel-level CQs")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-rc, thanks

Jason

