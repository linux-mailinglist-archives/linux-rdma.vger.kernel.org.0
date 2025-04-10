Return-Path: <linux-rdma+bounces-9323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A689A83F0D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43C6179915
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFE25E81E;
	Thu, 10 Apr 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XC0xl2oq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE61CCB4B;
	Thu, 10 Apr 2025 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277970; cv=fail; b=tgW62FVsphDeuTSHMx2VNnjqNw6GzYhl21MIZ2IMS+8DKyQIUHS16HCV6SnNeeqwS9Pntyg+RP2PWLTty5cY7hA/YEm0yr1DnBQWazjbnj9w/hJ6DrYZfwOL8/jUWLhZFNSIJw2KKqDylA1WFjFJWp21CicJPxwUor2FueB5yTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277970; c=relaxed/simple;
	bh=JY4gyH+kT9Qobd/g3CtjiIaEMOm42so/0K4joIpV9Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uTTj4/COEU4p+Z7p6ELr0cQbL+9C9LscAT1EV1Pq/4EHFdozbShyUyS1CfJWpExk8ZV3vzDbpRh8PYX3cIMiEESMtpphic4xcYsL79XBuz4YupcM5scOflk27xrs6P0riGEYz/DLqDwjcSeaedo5zdukhC4JQ+SKo9EK1VcBaO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XC0xl2oq; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROIlBBoyFd+eWYZJo0XsQt98SHFP/mW6zcIJQXljNJnwQ+2A3HnN0z6pYWGQr5NyNj0H3Pj07qVTq3pZPGADJKUk2U7xHIPiISOLyUj7gGZXCYEdgcVQXE5Mcki3dciXmm4XUCCsbjPLO9unxFF+mJpmj/y1aG9rCeDaMc/udSLLv2d1YnJ1FdBg1lhMyM6h/JhrcNzYyx/qzXk5W0VzqNeQsUvFeyXHI9Hwp9sI/XPaATKRynUuLIONgFHxRWN9UOplHAjkhwhNTUsDgLfmv/Wb4ND02SulLih/Lq10r0mB//6j/dQqt8ik3RfB4/fLD+98NujUB9Rt2ISFMbz42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgq8AncbMG4pw6OMiu8GmnnnGD+KOzLM8PW4rG0nrM4=;
 b=anXBUYbVrd2aRuwzmLvyBZ3k1g3iSCZEOFSN1S/Jjrvoy0HfwkwaP5qhA0U+5RtozH8TrmvY/bL836Y/lVwC9rKNbY7spqNwjcunRRz1DQEfE5kB56aMxrP3gxjNKYEggy1f6v6Ty8Sp5kt9JTewhPb+G5kgrH8mIqgAIP+XeTdUqUXPQ12ggUCU/cPHdZVmfrx7769QZKf5z6jpMV7vAICi2ZFwuVvv7aeOli+CXkNVDabVS+372F4pq7CyaLtEsielLmvRa7L71XwybvXMuNrKeNCd3lhl0qloZgX34P+5Ofq4ddK+LybzDkbE1gXJo2X5UpMVUGh8uH/CvTXBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgq8AncbMG4pw6OMiu8GmnnnGD+KOzLM8PW4rG0nrM4=;
 b=XC0xl2oqM4D0Lnz9OFSCNA6krsFQJjUVX0sAv1q32Lux1SUFOuIuDn+AMfO0n3yoqEyG1pg7FqCXljpqbxEkFqcaedPBIoPT/67yuGTWsHb5yAIqRK3Ml8ZxsmI0BoHG6Gae4waoOx6lbWIO3Xs4fDi65Vvc1pIqXhy5dY1GLSTHu2DPweoEgMB82U0Yk/4axTgy0bJO238uepsq36LpZ4bcIPkZUiqrbunVSOj6bi36b7dYpkw7uxycERm2nVFCbWgoZu053ji3Q2dCVEeB92pauL9DP0b+/TgJJLu6PvsuNvNH97zdvsNNnfqCupfR+/Ae0fqpr7oZuLeYIa4T6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 09:39:26 +0000
Received: from BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f]) by BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:39:25 +0000
Date: Thu, 10 Apr 2025 11:39:17 +0200
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
Subject: Re: [PATCH net-next 05/12] net/mlx5: HWS, Cleanup after pool
 refactoring
Message-ID: <Z_eRxfatxaGZ53YQ@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-6-git-send-email-tariqt@nvidia.com>
 <Z/blOLHROwFdhv20@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/blOLHROwFdhv20@localhost.localdomain>
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To BY5PR12MB3953.namprd12.prod.outlook.com
 (2603:10b6:a03:194::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: f610ab41-64bc-4b86-e619-08dd781394b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYTy99VuBEvmiXrbu6CgmdoiGtkFIL0YFKX3BJP4szPfq43MXPHQTiaO8lbh?=
 =?us-ascii?Q?7Ie9NBTI9gUEp2tO23ZgB+GZ7gaMqDrMEZwOJDnS2/apJZ0Q/TAymc2FFsAN?=
 =?us-ascii?Q?RB3WBQmL6wXt48d2TzyHxOOo3Nb9MdKBlry4EnAZNGHRyhrjmyntHEK7KmSV?=
 =?us-ascii?Q?hh5gOt0K/VOQ5vO161w4xsDOcCDR2XRHBniIdXvRsDzlkZP4qEBxmh/rRQ09?=
 =?us-ascii?Q?K1R8mTZwr+2xqHtUrWs8+Ay/2nQtCz+ccTcWxtIYb2ZnJWAJyM+ZfcypHdwZ?=
 =?us-ascii?Q?emE3/AOHsS7+y8XOnEIquVefHQM6sz2RUsY7lExTfaNh59k7d5dajlceG1d2?=
 =?us-ascii?Q?fyJq0sXBbV5XlkNrcdtMBR61bAUrgZEjhFGlIqRoEpOMfheK/7PD+yTATuol?=
 =?us-ascii?Q?zbz8vQczZGIlHaVMhl6Ru+rEgis2n1xXaogkrCoau+PcanDvUsYUzzhPmiTI?=
 =?us-ascii?Q?XJQBbIOo/uti/dJuUlCroW1lA3TOAJnGJHwrxk0q+7+AylB+HEXfWETWf9fD?=
 =?us-ascii?Q?3saDkh711geKTqfcz8/ZRCvlTVkegxSliNuuDMAZvAKW1IB48iXWBvWnXkvD?=
 =?us-ascii?Q?YImTq3PR4epxJOktz7xUxrP6fdLV5azC/9OLlMjE9h7nRS4kggRqKDy6JDPh?=
 =?us-ascii?Q?zXSdfZ2KefehcTqFE0Zahu/1KcYBxt1NjwSjChvxg7TSrpNL1mOxyna52yF4?=
 =?us-ascii?Q?66f5kRmOxFyeG/eCgBBKMlPR9Nyouan5FVkr+N4hUFChh9AZcRdeqssRvQAy?=
 =?us-ascii?Q?buG1EoIlPKeIctXAEKfKoO1rQZAd/coyBRDomzBD7/ptYZL/LL9+RtwqaVwZ?=
 =?us-ascii?Q?f00VXdLQQTWzDd+FzN8wBwXziEF2rzrGwtoEE0dTp9LcRklnXIy6MO5RZVQ/?=
 =?us-ascii?Q?fGhSwMHyMr4nnC87sUHYG/mIXxgdfHwC7nv3S2gqG9uGF031vPWqkJ5pDvUm?=
 =?us-ascii?Q?MojVNo/X87/yS1dzlle+UcKZzT2idrblYgBl24ptcQAeCiZuvBJDdZp6pS3r?=
 =?us-ascii?Q?THLdEGYkmUiNbbkQfovzfYi+P4QhKSS1jKlrcfyedkWj9d7yVVLOYQIhqFDk?=
 =?us-ascii?Q?liAAAuXrq5Amx14/lteHXS3LDaNit4FaSY5kZmmnSmhQtLGCWDi3FON3p8fw?=
 =?us-ascii?Q?qZmcDvHXCOOVU8JD8gshH+wljXxU604Zyy/nZa6oGos3oRK1+KTZsS1jRDxq?=
 =?us-ascii?Q?KP0M7u8s7TYFLffv3sAXEFGB8gub5B1+KEiw2TfFK3gBcY6u+5notV+6tOfv?=
 =?us-ascii?Q?2iH7Bbf2rderDTfvmGgddRN4UvlThb2nyo7QvALbikCs24xq8roOaySwcw3R?=
 =?us-ascii?Q?xdh7glUkmUVRKpSQOmWbrPKYZG1oJs3oCDE4/cLhwg8NcdeBJrzI0fJJ0afL?=
 =?us-ascii?Q?i4inBUlgUrP8jtqXpJp+bRlDr8tw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4+TQTC4LeX2M5E1tbjtmJ4JmhOL079uzqCLdywEOiJJMaFEzG+JKUkd7xKN?=
 =?us-ascii?Q?CT3yVbe+a2nHkHIPEr79GWbyPuniAgY4aDBnEqelR2dpduO2xw/AR4ywxRtQ?=
 =?us-ascii?Q?5jLRvxfRiY0oBO/51RGqtBTY+QfNJyeWmQwhiNNvLPCbdF4IIfScunPxAMAX?=
 =?us-ascii?Q?ApoEtHmYQY2EWWjruEpMhv6JB9sx0qI+G4qtc3/US2W6ifVfVgpj5cC4xXH/?=
 =?us-ascii?Q?A7ucStZH2/ZszpCtRe8j+dBcT98dgvPsLMz4+q6aIRC7RiUw57bH9+cPa9M2?=
 =?us-ascii?Q?FQnObMMwWHRnWP1mCpKC/BXu3wLwXAES3QwDawUOHSJ5ounKfKTFkbttsW+3?=
 =?us-ascii?Q?Qlq+VDz6yZP9kKyAJpA1WMGZfXHo3lsAOnZ/AVuvEaH4kJMfzQQlJoIVI8lE?=
 =?us-ascii?Q?P626gNDGOUR+5bTvZrlEAvkXenhHgb2vW5tWz1+ZSNw/r/l8/kg0PQrdC12u?=
 =?us-ascii?Q?ka6dWR1DTATizzrpiqGNewG1tOWOFECW2FTvfcvzvyI2VcbubgAnOyI4SZLO?=
 =?us-ascii?Q?NSXJFFr1fSMdd8bpK150cLg3J6QUWGnNttZwGfnaa58Nw5kmEG+g3MskVqEq?=
 =?us-ascii?Q?5Y4vJzId4MOrSu/qnV8lVPwlyR7K/rM6H3kGk0XARsix32Ty2MnnIFDnbyUa?=
 =?us-ascii?Q?OtIqO3C6EJLUoiAFBXW3uccA448kdFOqSx1zrrBcJlfsgQRu84GbPdCyTsWp?=
 =?us-ascii?Q?zNRtQe2yH8fJZAf40ga8yOfCa4jO1cuSOLSoXneS1vTNuToZQpvdvMk0YZex?=
 =?us-ascii?Q?ddeinDncTW40Yo9zBLhu/f4qO0dcToH1SXryrLbMzm1a1CPG9SYQtKyrLyE3?=
 =?us-ascii?Q?Nd+q3IIO2h6OKVNTCidijNZUusw1i8Gepidd/MogKWSzc5sYJ01QDNwfEYwq?=
 =?us-ascii?Q?lAd+6/ogNMydYLd4ocnI3KBTAvRF65F+bTvaZinDQs8ZWs5Ee83sHJ/+JD+U?=
 =?us-ascii?Q?V3ARpGSqhPoX6yyqS5HZ2O8BdNU/3vcE6IRkL4x7YIt3mjrYb2v/+0QEnMYR?=
 =?us-ascii?Q?c+NGDJ22X7033hAxAllKweZkEq0NV5+5lrYnO01JOR759Wd24AGaja3zim5c?=
 =?us-ascii?Q?RQh9SkI+kGLHE8wOzpPU8O6VuK0M4vlYssDnAb4CzncTwJDY4Ob454kMbxk/?=
 =?us-ascii?Q?Pj4p1efIugGecmJR1cYju1uNTLgT5y9S9Egwy7u4pFdn3EfGjj6Uvd5TvBIH?=
 =?us-ascii?Q?bgAA4x7V0A4+bmd7gAQfdg3H5OVvMlVBsXwud80NMTFI/kcL7AvBja8IZ3Uz?=
 =?us-ascii?Q?G8Hv28NDWLmlratSfv9UVqWGn+j4Vju7sakmN8KwBcmUjjNiqn0/B+IgP9ZX?=
 =?us-ascii?Q?7Hdx+GPzJQjXEue6149JGPUgdBP/nMPzdX38RtbJF6Hdkaz89+ixja99Z00X?=
 =?us-ascii?Q?LYHfP3hsMSn0Tms2NotCFFagFRdNqOaF4HK2CNIDtwiSEWM2YMZLS3qeF8hF?=
 =?us-ascii?Q?ymOh9Hh43K9yenZZXADGZgNTxm9klmUIRC77y+/aqNh454UbVRR+2xHMOSKu?=
 =?us-ascii?Q?4fJp4G0S8KEHXpm7U8M46d2J1WmHI2hgpl+fDvewpe2Cvr2z4rbGhpTR+/Tj?=
 =?us-ascii?Q?AdF2/bfIrgusnV6MfMeftyNeOxFmWeHAT6tkBCZp1A4R37jUBL0DC3/fRMEZ?=
 =?us-ascii?Q?U8jBS8UtUTRLiDjglBvMyVdkwvl9x0rCAUkwF12K2NBX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f610ab41-64bc-4b86-e619-08dd781394b9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:39:25.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OnLPXW/jCXw4ZsQN8gWxFG9laaa3V+nxLH1hfjxeUxJI3s+dUEx9sbeM866c/FrIFkcZo0NJbmWPZkKZwmzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

On Wed, Apr 09, 2025 at 11:23:04PM +0200, Michal Kubiak wrote:
> On Tue, Apr 08, 2025 at 05:00:49PM +0300, Tariq Toukan wrote:
> > From: Vlad Dogaru <vdogaru@nvidia.com>
> > 
> > Remove members which are now no longer used. In fact, many of the
> > `struct mlx5hws_pool_chunk` were not even written to beyond being
> > initialized, but they were used in various internals.
> > 
> > Also cleanup some local variables which made more sense when the API was
> > thicker.
> > 
> > Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../mellanox/mlx5/core/steering/hws/action.c  |  6 +--
> >  .../mellanox/mlx5/core/steering/hws/matcher.c | 48 ++++++-------------
> >  .../mellanox/mlx5/core/steering/hws/matcher.h |  2 -
> >  3 files changed, 16 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> > index 39904b337b81..44b4640b47db 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> > @@ -1583,7 +1583,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
> >  	struct mlx5hws_matcher_action_ste *table_ste;
> >  	struct mlx5hws_pool_attr pool_attr = {0};
> >  	struct mlx5hws_pool *ste_pool, *stc_pool;
> > -	struct mlx5hws_pool_chunk *ste;
> >  	u32 *rtc_0_id, *rtc_1_id;
> >  	u32 obj_id;
> >  	int ret;
> > @@ -1613,8 +1612,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
> >  	rtc_0_id = &table_ste->rtc_0_id;
> >  	rtc_1_id = &table_ste->rtc_1_id;
> >  	ste_pool = table_ste->pool;
> > -	ste = &table_ste->ste;
> > -	ste->order = 1;
> >  
> >  	rtc_attr.log_size = 0;
> >  	rtc_attr.log_depth = 0;
> > @@ -1630,7 +1627,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
> >  
> >  	rtc_attr.pd = ctx->pd_num;
> >  	rtc_attr.ste_base = obj_id;
> > -	rtc_attr.ste_offset = ste->offset;
> > +	rtc_attr.ste_offset = 0;
> 
> Is the `rtc_attr.ste_offset` member still needed? Can it be removed from
> the "cmd.h" header? It's always zero right now, isn't it?

That's right, nice catch. Will fix up in v2.

Thanks,
Vlad

