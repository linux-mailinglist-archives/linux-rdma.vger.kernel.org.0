Return-Path: <linux-rdma+bounces-7894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F3DA3DBC3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C8E178D8F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F11F9AB6;
	Thu, 20 Feb 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpN7db7+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6041F6679
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059639; cv=fail; b=fgfIgGafyaIq1okBbK3I9lhVLZ1L57dA3iKFaxFdPdrutnonHB/RTt/OGp2/wAhsTA90Pw1GPnXdDTcbYaLi5axjzr66j7ysm6oZlGONA8Ussyuns6W4TSEBUfcdrG7MMbJaIqcX2f4cD+8hJlMreJDqXWJGCy3b9RX3Fvq+hWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059639; c=relaxed/simple;
	bh=Xl1IFR8QNAQrYJqs/X6RMqE/RtrTR3S/yq4+CIuFDCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YgYWImrFgmHQr2Rn/4cwzXTooUUnnQt8s68XEz5RL/IWuUVsIi3w/CLHLv7o/CCwcmlQXm/vDTc3Az3S/25gcuohW2BvRpTEZJcm3tAvqTJOgMb2hc+HqDNaqPlfWQaOvYXpjHZtATBD3qEZ2422wHFMSpnX2J58nRNW9iFuQOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpN7db7+; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdvm09UWjwcjUShqYCgXlAAb5IZ5F+hZGzBT9GUYMzR1NvXCef3a6MdWbVYPzz1W0JGge4GrMFinK2ixeZ78HXUWsWU4MlU/mlhNHf/Wi+1+nfkOAgJzR9rX55wIZpV+pdGBB/sWF15Kjq28AWXQuRLpPXnXAFEU3Qk7JHPzDxTvemOybl7fBDzm9OqKUxZssgzYeeIry0/dyRXpdmRCmjchsAZ6AV+UtHDkMuh25vqGfOZoHePHkDoKaCngGEZJ339Bn1ara5avtnoYKJUqZMzv8td83MY1ckv6tUKfljUJ2wvCeBUSsKtgsldqGUgyp0gn7V6dzOW5SUCB0y/HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKhCCJeSTG4x/B4bYYuqgqCWTyAC3x5XkyZCyhkejpM=;
 b=INDOVurjxumm+7YgRo0XR7zkFpoyEj+xVZxWQLL9wFcI//tRrn28aLW4G1uZOFt/UD0zTcYlCJWAavqga38TNLx0nxwN5Jg2Bdy67ApudJIM+4cqEdCciJtNBUu5kZWfX4AneJEPWmP3t5+pNAZUuj2BMlnkO1+JVxYiLNLZu5x6ec4XM6bLpRJKNuCuOqYaSzGqQ71tJ9JTawDI1nGUUyN3UrH9QE1zfsyOZ5TXd4/rg3Enq3lkiGe35u9BGewPtnz85gq3QqFspYy9is22xUJYW15p6ETUdBhRBJu7cGjVWMldDBkKcIu5Y9UOIuopbgD96+KslQ1LS9/0tzH2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKhCCJeSTG4x/B4bYYuqgqCWTyAC3x5XkyZCyhkejpM=;
 b=mpN7db7+PBUHX/0pdhrcY+B2haDRHfYJQ3otB9rMKrTi5YmbIuPV5xuafPewXFoSI4wTQPGHYiBYGfmav4koGLDDFgR3WGpMvVzlqeG9qbLp5qBCJqJ93eavDkySmOpXo7ec7HCVoUB6o5Pi2HEg4rIwp63TQq65HuT5Tq10+ItpOxRQFMCLTUbMX/lJCdS9+qfsZlSec5KWlRzLFwxjBCdU9CtvpocXaxMPWervtfB72a6Q8xHk9bHjv2pq/FwbgZ7owyEOZW+RdEYPBEt8Ffs6/WeslaAloczrKkGSPprGDb0XUrRihI8So+bu52i4a2MF4EcXvahN1PU89B0O4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 13:53:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 13:53:54 +0000
Date: Thu, 20 Feb 2025 09:53:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250220135352.GA50639@nvidia.com>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com>
 <20250219155647.GI53094@unreal>
 <20250219175335.GA28076@nvidia.com>
 <20250220065938.GJ53094@unreal>
 <20250220090652.GN53094@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220090652.GN53094@unreal>
X-ClientProxiedBy: BN9PR03CA0967.namprd03.prod.outlook.com
 (2603:10b6:408:109::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1143f5-fd06-426a-5d41-08dd51b60355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sa0I9k9D/yghPLZh9g+/xVH7CBKQyKcpD2NqYOU9mhjU8N6HEMnxTSHRby8E?=
 =?us-ascii?Q?SNNSoYWSLs67ocYWv8Ro8vxe7jKKBzekcovHMT7wTioWreAshP56tk6YGfAs?=
 =?us-ascii?Q?4862zYzIdZuh5SzpsuBu4Yfc6/sFjd4j/Gf/0mmgQoJuOTAyqfbd+JyGb0EG?=
 =?us-ascii?Q?Gr7Xf5YCXKVADXqW0El6yyZ5DExj6hWVYpO5CdUd0pc9wtYLjfTYDXju723R?=
 =?us-ascii?Q?ylUr2oqFbzP2LbcqRgpvHSAozo7QTszVMMzLExpvQ4RLv9Ne0wfDYRsIf3I9?=
 =?us-ascii?Q?ul7YjAWCvfhFgUlKNMJ92QvdIDfCMOtrvTbLDTaYo7nElyGa8C5MJlu+tzAg?=
 =?us-ascii?Q?FJ6BTwb3QzEzirM5LXGZJqkpbKxpswGwkyCh4U2HySaKwok9Ab03W6mNabA3?=
 =?us-ascii?Q?xKAs7BdYMj12iUxR3ohaklxu3Hsd2Guei36nee9+gMG7TWSzugbCT86BQDTi?=
 =?us-ascii?Q?jB712pT61WjpoSuTISZXcusuJxBIOFpRcTGzY8ty87hoLCstaATUmg4Mqp3G?=
 =?us-ascii?Q?OfAvXpWTLVKym3yh49S2i5PaTztzyBKWnjnRWXkA79XVTQ/RQ5LWsI7otxg+?=
 =?us-ascii?Q?B6Wp+JTp/5ICJ4xRwsBU4vd2HfXzxIoXnzoER6VCtm11mox4nuk1DfLn6BhI?=
 =?us-ascii?Q?dZ0Br7/+NWAxPvnNYo0mdFHua0ybiW3X7QdlxVsrhQdElItgo3H/ICvuVltY?=
 =?us-ascii?Q?7u2xZztYQdSFpyA6GqVTEJNLQcADB6+UPXx1bpsoQF/p9lROh/WMqFEoCWpa?=
 =?us-ascii?Q?vMCqpjGOhCdcn9QlKWuww5Np6Pax6oDFQKoUJi+1RjmuNo2UrGCZW/RxMvoC?=
 =?us-ascii?Q?Hfsnd8RZpZ1lg1VzGw69kUF7TISPfpuAMOCJ+AaZpIRn5+2GATeXVv08VH35?=
 =?us-ascii?Q?6bkcG5z/59n+L4l45CXbs0CxbE4TIz5E4rub3KT+Hn/V9rOg4fXK8vrXsnCP?=
 =?us-ascii?Q?x2SzEKlb69EM6qCUAZp7AZIDfttnaoSrbwBm2Dcja9KNtoe3GdUjoxiEZ46g?=
 =?us-ascii?Q?9/xx8zorot4yQhfxM0pOsVX7SmPVoOnAn7RHBR/ewHLsTUvAXfM7FevmeWyH?=
 =?us-ascii?Q?hHQjitaw1Jo1WEPHRL/odyOT3N0RHtJHh9zQBR+q7Q76XXwOPicacLEh+Inu?=
 =?us-ascii?Q?Vh2qFSrPue5tZgzP4qMcx7ZYXMCpwOtuwCXSN+jEYMearqiofboGuj6G5Qzm?=
 =?us-ascii?Q?7tKBazSYpFKFKX0RJPx9ttXKlRrERhb8ylvCWJ7jK/xpGqpIgXig8fg0w4MI?=
 =?us-ascii?Q?Res1mi/RbRvHD8WPnC+VF8BkIGCFrOBWK5lC1SLugv+QTLsModovd9gb7uWY?=
 =?us-ascii?Q?VYk5gIL5/P0UJs3gkGwjcRpxJvm0CCnNpDdUtHeCw6A7n0g9goERWAT2Tdov?=
 =?us-ascii?Q?jHjqSl6uWOcvwbcLAn0rlgHn3uRU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+XueyDehGXtG5h/aL3JfcuvKxNwATwsKJh80Hp9FFmw55Ih55WYWxOcV7kJ?=
 =?us-ascii?Q?ZRasf3HVLY89F13ILNj8LrApoYLeYo0kdNU+ZXB0TfPb49j7k1gfVv2Hxsel?=
 =?us-ascii?Q?luQ03HxDouyKDeb5j+0g7PCsdvkOkcQLfyqn0o7+w4TpwzEWPWkUm/VMWsUI?=
 =?us-ascii?Q?sZRFroKsx0435UOpA5WcUFPMCo8Z+efQ7jk8dpcwk0XPO8RSmNC2qLJUqush?=
 =?us-ascii?Q?2B78niuf/DDwY9iKYSaZMCIwgXI/4NGccw9keRomhv+VoXGbaj21vyldDfN1?=
 =?us-ascii?Q?uNyZlHoHott1ryd67rOQMybTXjrGlPSzS6eV2P5DHvoef6nvO6MJ33R1XyrS?=
 =?us-ascii?Q?sb0Ye1My1wb/FWJhpYsnqyY1aY6bFuVk3kcZN2Ur2lC/jUa6nc3RcfvojcYH?=
 =?us-ascii?Q?26iIZLiHemF8QT3cPjfALppAQ16CbZKT3ne9ACTQi6j9VqSHm8nlZLMiGFU+?=
 =?us-ascii?Q?UdYBOfn1F0nNZAf1ZFuRZLWJdmUxnWgoaoPqLLoiO1siJwFKU7GQ8Ln9VHhX?=
 =?us-ascii?Q?unNSRZEeYD/8bGDPQOCvYivhu7KBsnmNPoM+m7MyRZiETyBtd8oG5pFrUfBi?=
 =?us-ascii?Q?YxZbjpzkOw2Us54q4koVECySOdxi48UhaJEbDjmbXEWUhEAff+ALaL2Ilz0v?=
 =?us-ascii?Q?u2pjiL6TzleAxppc+/NOT0OIQfUt0L7Z8GNgpJa7UC6hKo+zOhulLbObisqa?=
 =?us-ascii?Q?/peNlQ8vaikNH50VmsMaBM+by8/RhXiWKpMgIyS2asgmkSliSoyRcm/SkWVf?=
 =?us-ascii?Q?qQLvRnnAxFA6XRlk9g3K4FrsKIA6IszRFFEXSAWjYL2bFnFD4Ka1xXzeomGQ?=
 =?us-ascii?Q?v7ggGvU9BWIxRln9661t2FMDc1oMPm1SPPWbLWHOnihudMZJW1X6L//PjjhZ?=
 =?us-ascii?Q?Dx3S0euTRLxcSGYZTYYRtMsemvm48iaJ2vtfqotMP6Gj4reIPsF57ywV+AiK?=
 =?us-ascii?Q?z5veBaO38wKNn1WrR2SzIuq5ncr9LNGxEVHW7AA8ubs7C98CauPrNpgT/m4W?=
 =?us-ascii?Q?FxKM7SJ4fegFuxTaFBITOkqncEVFDwWPn0CTRmHZ2yqw1ZdxMhCQgZH0mW6m?=
 =?us-ascii?Q?W52/R4YtgSpNoPFuZdsFO7tNmxymxkZoceviZGGADAbOlP0ogbekFjblBdSg?=
 =?us-ascii?Q?IKW9dBcZXkQAIQB7KH0HA5EPv8UW/PFCAcY6+cMJBYeKrrp3lSY0bMqi2csY?=
 =?us-ascii?Q?qjV/o9raDbOqGj8SSC9uLZGmb6m/dZWGDtv0ZdXOKq8KdNQUXhpEbVBPO7J/?=
 =?us-ascii?Q?u+ieZd161wx8iitCRTOGC1S6+y1vu90WXZfburALGPhu/NZnui9+V89QzvT4?=
 =?us-ascii?Q?K2WQpPUVYaMrt8B/UKhp6rAPRgaTgLnw5M30M2uh+P9w4U1vHMD8o8w9jF3G?=
 =?us-ascii?Q?psALsvPvwQZE6x7Jn3ZSdEtUErcbjVetO/uQyXhSpPt2E0+ogiVTgLZaPN+9?=
 =?us-ascii?Q?ie48tRT+WLjI3gRK0ntyyiKH+rr06pwjE3HZ5xjMm1+MOt+HpWwZtcf7+dTs?=
 =?us-ascii?Q?49RnMROrwjHor1cG+5yVRcDHr9VOAQaumR8JnO4afWs1omJglrOTBhA8mBQ5?=
 =?us-ascii?Q?rxNMfHNnugdKv7CHtgY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1143f5-fd06-426a-5d41-08dd51b60355
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:53:54.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qwNQesdXD+NlAVXgHOLKgJxldaNi9dXTCu8X2jCgS6m/lG7I9i1J3/HvYkKFrVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

On Thu, Feb 20, 2025 at 11:06:52AM +0200, Leon Romanovsky wrote:
> > Mainly -EBUSY from FW command interface, so users can safely call again
> > to modify QP.
> 
> Forget about this comment, I was distracted, and it is -EBUSY from
> uverbs_try_lock_object() and not from FW command interface.

Userspace is doing something really wrong if it is triggering that..

Jason

