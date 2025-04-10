Return-Path: <linux-rdma+bounces-9342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B413A84BFF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 20:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA239A847B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333728CF59;
	Thu, 10 Apr 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y604nNZo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39062204849;
	Thu, 10 Apr 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309240; cv=fail; b=AreQL2fHp2g6ZjD44pHqzgFX4AT7d2ZhAb8l2zof4tL+FEgJSRe8b6zyQWgUjHm+zSGihbE9DePLXVFw03NQnD3LwZvD1639h1BdC+NH4Qoc3TbyQ4UiBROJUwXUBjwfzsx+wu9Nqxf+g8n7K5jEFV4rM9q5WPlQDsNsOEOu7Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309240; c=relaxed/simple;
	bh=Hazf8nNEQF/WgLL2F6VA26dhiQLjREMWzbTwB13bP/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mWX5RUNJOv5zelOqslNA2M0VXUz480n+0Oe3n5+y55zKrnecPiGP3samfRWZtsmPc+X9Qwt8utUsftnkTXsLQF8LtfBYAOMcQxrj6mZB+lg+L9m0MGfsGlCs/HvIc7SktddXNaYHIjB2KomU4Rp66wjUbfj5yUwASScW3EWX28I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y604nNZo; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9UdrUiFPVksuk2EUQTwNAKg+RdzmXcA9buF2T4+Ku+1zlYVsOhSIaO41+rS+YJ60aO8UGWfnD5wYRt6tibplhcQa0AbhPOSp3+58DSMIbAjv82Wr44v7yCfYY1OY9kWDBSL5mwYSUlfpo8p+ovgkFZpFJhAUhaZ5Ff/gObOwFsjqxSlHknGvKOIE2/Pz2Br0wh/gI4XVTyjBJxwQwsKsE5VUtw6WapGxiMyNUs0X3vrGeQC+a2sjgr9FafWB+LvJJ+OkR3WsvUMHzU4Qw1dQqPrkJ7CrUmxeIho7+xE1KnsmDlrj0rrGm2bizQ6YxxLTXSGMVT+ssQQEDEKmslUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWS6PACcuh0N/Sbz4pAwTfLlpO3B90pRnN1Ck4PxjPE=;
 b=G+LZpwTT/Rjj61GyNdCgwX0tIyf7uo5ERB7qPgEVYA1Dp3vYwpyQskRZ7JqJsiW+gOCjMykjyHN+Am+z9CREuNoTM/cYhJkF+TJhJCGXdQYx2DFQFMLkZ2i6smGog1TJOBc36J1qBwo0vQ30F7/U/xbd0arlcstQ5qDqXQYUkJiaRz6NMCFX54oDoATqeX9ikzFdx2rLxb+zIYnzjRPsMqNcGm+lTqFf9cWPgckv4hAoXugI6m9zJDEBaXt8UF30vzo5G7LzXThfXoqINdJlPs6PkLPWMrHXp5P4llOmTRd44PsigvlNCxOegdOHufCIxBZLn6kznaAfr5I05Y+dig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWS6PACcuh0N/Sbz4pAwTfLlpO3B90pRnN1Ck4PxjPE=;
 b=Y604nNZoFZ3vadVty/htBmsSzYAB5K4ZFMyk5wQqbdWpA/kRSd5M+C6BYpajWKuOugA8OQxTkoamK5Uaa/0C3YxPdOKmoiR/1xgQ3tXIOzbluEbtHR1F7uSn+EJAHFgXTuRq9DcpHpRkX6yCNZz+7wD9hECdzIoBkLEi40j+8D8dSITb21iG8WqIRbgw+KX4BAdliSs1CDlWcDPDaLHvF5TRSsVxdbKFlyx8KtTKE5wORXBljNuktzp8QysuRD8ZJG1B5MMzM/v9wEkdYwwHX/nUrgjpOozZy6UP9Y5UUj3BxcgC4HXoKF3v0X/Uxv9SZnVSklDTvmgOLVeZZXa9SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Thu, 10 Apr
 2025 18:20:35 +0000
Received: from BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f]) by BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:20:34 +0000
Date: Thu, 10 Apr 2025 20:20:25 +0200
From: Vlad Dogaru <vdogaru@nvidia.com>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 11/12] net/mlx5: HWS, Free unused action STE
 tables
Message-ID: <Z_gL6fvuYUmD4oPS@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-12-git-send-email-tariqt@nvidia.com>
 <Z/f/ss3KqE+D0G9l@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/f/ss3KqE+D0G9l@localhost.localdomain>
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To BY5PR12MB3953.namprd12.prod.outlook.com
 (2603:10b6:a03:194::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: e3968865-1ce7-42e9-eab4-08dd785c6285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z65VxD6E89YGzsMYo8GAjJzE/23pwjsqWEH4RIWJDgMx4zEDxBl3hTiFauFl?=
 =?us-ascii?Q?IBY/W4rboj80+ewy5FjukyjeOOUSGoY40UQPyQmQIU7lUEGrNyt7hfgdL5fi?=
 =?us-ascii?Q?lAF4KGEYwsGZecFKr92+8oYlAilr6rsFAFcUCCtKJXs8oli2COdmrFsMy22y?=
 =?us-ascii?Q?gOMlFmEIKgLPpoTlLj7rAffX4R0pDsb21JmjVRs72CJ4DYcCVjvk/+0NpGs2?=
 =?us-ascii?Q?xAMYeaHqlEXG7Axz9xr3+UYlPwT9ML2yGcI1kXrCBsOjZXBZYrX+r5s9P9gm?=
 =?us-ascii?Q?ZeMpByt94VdoMmyOkww/2Ewoc/pyvPL17uLK3USZVwc6WaoGnb3jieKW1dFM?=
 =?us-ascii?Q?k8zxBqdYv8X8r2arfw1EMGXzUBjxhJN073TxYyaoWsS+jkJEe3rScYW/kiEo?=
 =?us-ascii?Q?b1uQSmPNJ1ErUMlPhIEUGHkfDWlCDBIhsTHPjGy0R6LmRORkkk+/lNcGv1bO?=
 =?us-ascii?Q?pJtPkTJPvd8/EaPB6Q+0rwAd5Dv2fk3r5Zw6M4GFLRSjaBUDoaThGx4R7fjx?=
 =?us-ascii?Q?0mp4LG7XxRmia3PBEVF/59tb8k2T7LBIjSjaL1LhWz90plFAFp7PAE+gSJga?=
 =?us-ascii?Q?81zApIpn7+6eoJvKtgdBCkB71Nz5YPBEde7PUT45n+jltGWrXEy81V+SI9eM?=
 =?us-ascii?Q?OFBJpmj7ONqTJ+81VkO4zqgPieskbtnsKhPjy01xOIa2g8eq5D8mmkbQLYKp?=
 =?us-ascii?Q?uXx9S49bLMF4OoBp44wxZhxe0iLG/5bo8OlbynkD6/EcLRlv54mCBoahWfFX?=
 =?us-ascii?Q?IHrl/xB2x3iqIqtgSstkv1zphBrBSN76E6cPf8yw+OAJS9fvWsPBRE7gqqDX?=
 =?us-ascii?Q?ThPvse+kEX/kEgFKhNGs1hHHZwTGwMhoYe4TPuTk2qGezF+swE4OF6bkYf1E?=
 =?us-ascii?Q?EnPeaWRPiJBRPeMmxeLK/r2k3Ech0kQlet1ZOp5CERKYiOi/U6m8wR5tohkp?=
 =?us-ascii?Q?leF0op11gdrRdx/L8e/KAK3j9nMh7LqJpXSDrVV9nOSTodcTXfFmfzlAxyu/?=
 =?us-ascii?Q?sgBFH4P4pt8QJQv+KitAXX94E1SqJOpnF7kie6FP0mqotpPD2z0m9stTYqZT?=
 =?us-ascii?Q?ibQJv+PzUFaHSORIIgjSXCwmSY497JQEhC5jtPW8qNqb8YkrLoVZSdbcJWGE?=
 =?us-ascii?Q?ocrzIU3wmKwuXFywlZUNn5nlXbJWQQtRASemBZO8k/wcp3sYlpIqF4CCXuYt?=
 =?us-ascii?Q?RlmraPXnqiKHdDSflxHp+f1uVcbuTDBiVsTgYPm26ivbyUpIFnFXBKz34nI4?=
 =?us-ascii?Q?dhepsajFO4JYr35/hcS8QeJihdXO5BJrgK5DGAaDwq8i59qT1osuOMB+kCgw?=
 =?us-ascii?Q?6lXsiI+8b0IRg0u0IylvrSl1pI45KvEU0hUz8bmXCrVLZHcmNI1RsSU2edpe?=
 =?us-ascii?Q?ZJvBfc2Dgd9YDBRV6jrDnkomSNFqSZODn26MUsVgMkxm4cs2G1Ivq2f+1lSV?=
 =?us-ascii?Q?AwugbototlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9metUb/O1/5XPOzxA5MFF2sUPiMFLBqGE7cd5vwbet/vjM53R5iWEDhftOO?=
 =?us-ascii?Q?SBIZgEVb8fjcX85xe3Dq/vDDFF2a/R0RfsvhiXVYA1uRpz+BVzBmJVcxtKfM?=
 =?us-ascii?Q?hrlfk7qEDyt+5z9zu9OKLC4A7/JVoq1i0Nhnrw8ZY/Z8XVUymMYwbDpfLUmB?=
 =?us-ascii?Q?ObpsceDg/ErSmyzolhbWLpwxzneNL9PM93r9dYcmk+sjR+C87utJJAlpN4ez?=
 =?us-ascii?Q?4XeMSksTZvidkuQnc/huWMtIo75nYLlyNzt3ZUhuBVxp+SKuMkTjQtcouhk6?=
 =?us-ascii?Q?jxvwgSoTsfV/mfOgqJcN9/PUUFNi+EaF1EnvVFE2jP3Pl+ioyI5Megsu8Fsl?=
 =?us-ascii?Q?cHjQVN9WFFjo3rZozH/qoqkqEf4naJbiTYxedRxB+3RdTfkI2/NHtur7zPQ1?=
 =?us-ascii?Q?hQ5f6QLUjiWDpNTVbnMZ7zQQXU2TVnLRDd14BvzlQN98wTd38tToEGFwttuA?=
 =?us-ascii?Q?xeVDotzvnxzry0wFrwAB6SPKfu4SQjcot+rnGP2UXtHTkHh4Dt9TELCX95X9?=
 =?us-ascii?Q?goBwHmW9+kNeKztEmK5SzviKEX6Ns2DNONuiH1ERDMaOdhciaRcQ71Lbw5Y0?=
 =?us-ascii?Q?G3U0Oce4yHc+73eaec8mSZgnSOCpoe/9smZuYS0iAk9Me5nVUMsstyuUd4Rw?=
 =?us-ascii?Q?KNKgdD3j2NFiOD23vVsZXdHEsZOLYGBV0xQakS3uM6lYmdsu/9WfeoyVlygH?=
 =?us-ascii?Q?Qp7U563/J3tDvbWhGq8Bj/G/eU5JQAZtJEUfs/37htsWjC5D4W3YDfMJ4zp9?=
 =?us-ascii?Q?JZJWXwDAAg5BMTKPPY8+yz2OifSs8p6aGzzjKfqrsLQjRS6zMbWiKe2ougUZ?=
 =?us-ascii?Q?nCdATJM0mWdRRl8GDRbucIK7r7ER/CZVkB6waWwjlVcKZAXCqU07rYumdarl?=
 =?us-ascii?Q?fKtreAsE7PDoqaQr7pJsIClfhAM7MvSPW+aLp8gh+zWWVu9BK8nSJ0to9QHJ?=
 =?us-ascii?Q?st5iZs9PJ953cmI+E0kk/GbyNElMegu4G6+R3WuFlC90bQGRM3MWKyisPikp?=
 =?us-ascii?Q?+0juFqdU/8nmb7cFgTtKn8Ivq0NSQQIaYqBfG/iRNPxyHmILgLJNQhbcN66i?=
 =?us-ascii?Q?r7LTMvQQ/+fF4Dhgvp9hxsvdrzwOmJH1BR3I2wBOejsHGoyeml087mM75kGo?=
 =?us-ascii?Q?ldJv+2qmAG7TvrlbF1BFF0/aEzkxmfJR3J8Z1ytcrP6wvQepBUtjVFy+Ll4s?=
 =?us-ascii?Q?NH7i04Opcj2pVcRR2cNSL+dM3dOsMzdhC393Rom9x+J96Uk+U7l3wqPj6+J0?=
 =?us-ascii?Q?BPXUZH2gHG1fZZMg+0q/R5dErc5nqaRS28y38WfRMnC5vTpoX6C+ewQGQJwJ?=
 =?us-ascii?Q?sVW+fBNEycYkjY04UZilcDZJhshTpzcJFNnltMitJe65HaRWuCAsvi8ZrhhF?=
 =?us-ascii?Q?JNW4HMs07kDtsp1ns6+HcpQOm3dh2bHNmMggsu8gylV8BI5LYCFkoXdQ1L2c?=
 =?us-ascii?Q?08Gr5tWbCNDHSv/qDeb6KrbEV3V+AStupTFmqaZ7ortfOc7ITe5ONgRivvSG?=
 =?us-ascii?Q?bEouLHiEuJTLnOiqteYyB614yQO0zZndrg0AZwE1tgIuUeAKT+TaRoLYnv2Y?=
 =?us-ascii?Q?Cl7TWf/wxQcCcQHNIEcQ2IwnmWMNZmet0Gl4gyfgYV4y/4C7m7xytRQwBmHE?=
 =?us-ascii?Q?0pWztyM51IcAwylKs0o24hKkRr6YDVoHmZBcLUFh9Xnz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3968865-1ce7-42e9-eab4-08dd785c6285
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:20:34.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHnBSlZEL1Ncbncz6AVwxQOaczRnC187iy6aXAFSJHwcYg4J5eSOq9NpuatiNUHn+/rwIDweiAA5vieDWzRlKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

On Thu, Apr 10, 2025 at 07:28:18PM +0200, Michal Kubiak wrote:
> On Tue, Apr 08, 2025 at 05:00:55PM +0300, Tariq Toukan wrote:
> > From: Vlad Dogaru <vdogaru@nvidia.com>
> > 
> > Periodically check for unused action STE tables and free their
> > associated resources. In order to do this safely, add a per-queue lock
> > to synchronize the garbage collect work with regular operations on
> > steering rules.
> > 
> > Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../mlx5/core/steering/hws/action_ste_pool.c  | 88 ++++++++++++++++++-
> >  .../mlx5/core/steering/hws/action_ste_pool.h  | 11 +++
> >  .../mellanox/mlx5/core/steering/hws/context.h |  1 +
> >  3 files changed, 96 insertions(+), 4 deletions(-)
> 
> [...]
> 
> > +
> > +static void hws_action_ste_pool_cleanup(struct work_struct *work)
> > +{
> > +	enum mlx5hws_pool_optimize opt;
> > +	struct mlx5hws_context *ctx;
> > +	LIST_HEAD(cleanup);
> > +	int i;
> > +
> > +	ctx = container_of(work, struct mlx5hws_context,
> > +			   action_ste_cleanup.work);
> > +
> > +	for (i = 0; i < ctx->queues; i++) {
> > +		struct mlx5hws_action_ste_pool *p = &ctx->action_ste_pool[i];
> > +
> > +		mutex_lock(&p->lock);
> > +		for (opt = MLX5HWS_POOL_OPTIMIZE_NONE;
> > +		     opt < MLX5HWS_POOL_OPTIMIZE_MAX; opt++)
> > +			hws_action_ste_pool_element_collect_stale(
> > +				&p->elems[opt], &cleanup);
> > +		mutex_unlock(&p->lock);
> > +	}
> 
> As I understand, in the loop above all unused items are being collected
> to remove them at the end of the function, using `hws_action_ste_table_cleanup_list()`.
> 
> I noticed that only the collecting of elements is protected with the mutex.
> So I have a question: is it possible that in a very short period of time
> (between `mutex_unlock()` and `hws_action_ste_table_cleanup_list()` calls),
> the cleanup list can somehow be invalidated (by changing the STE state
> in another thread)?

An action_ste_table is either:
(a) in an action_ste_pool (indirectly, via a pool element); or
(b) in a cleanup list.

In situation (a), both the table's last_used timestamp and its offsets
are protected by the parent pool's mutex. The table can only be accessed
through its parent pool.

In situation (b), the table can only be accessed by its parent list, and
the only thing we do with it is free it.

There is only one transition, from state (a) to state (b), never the
other way around. This transition is done under the parent pool's mutex.

We only move tables to the cleanup list when all of their elements are
available, so there is no risk of a `chunk_free` call accessing a table
that's on a cleanup list: there are no chunks left to free.

I think this is airtight, but I'm happy to explore possible scenarios if
you have any in mind.

Thank you for the detailed review,
Vlad

