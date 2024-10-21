Return-Path: <linux-rdma+bounces-5461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566EC9A6F92
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2031C213E3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EA1DF754;
	Mon, 21 Oct 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTOx7SO+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5F199239
	for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528446; cv=fail; b=TKsxCSkrs5yZAw4cR7gstTZ7LaAooYFsQxiEgmZO5JUENSCqbttyeBMU59w4NI/rzVF9VFRf17BAhoFQLVR32TxV3fwo5JYo2LYaGTKIHRcs6NfZuiXIvBFsfnU5aYPXnjqYtlB/uEjhSk9wKEk2ulcW5d6/xOS2isHKqCz2KcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528446; c=relaxed/simple;
	bh=+LrYijmcv4p1NzD325VNAjg+ZvOGMwsbnkVah967r3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UgfgReP7X4djZBZqjp8ovZHWBVSUIuL16A7v4q9PtIkUOZgjMIMqon53IHTWSTQQUtpX1UCRj/MzPJ+VS5GzwLc3P3hcGuqfLjikmXDSQ5K5gvJCejZiCfEH4jQLGMiKbzuxpxLATSeXNbWPrX6hpS+a2Jv9PxFVb1qjvJNiBHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTOx7SO+; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGIobQ4EZjt6TuuEgTdzzqfWulK87RYmPUd+BjbuZG0ahwAo4Gedoq/jjosNgHn1ZisVIoP870Ua18YYNiq3vm/BrKxA2GSPZnEyE0sjI6jpXhpLM3dG6dCyMbgVAB4TI1CGSLnsBoy3K5xpe015k593KFhXvl5TB2tPEL9g51bYeOX12BgP0MTUSWhEDZ/R8i4yViQVE7oDu8UGhvZFU0M8x9797MKose7JTrnKPu7E8tbZspePf/JCACOOfEcExnRk+JZYNWsNblVroZV4gpoKF9ERWZiBC5g4vB11PKW2smmd68wHJHBplVtrA3H14lyJAq9EUoPb+tLAsdowVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkYPeUSMLv0KptMGl0WJWpWUzljL1hsf8wovnl0+8hA=;
 b=MI2Jg6FCvHf8Dl5XxEZmEohGLuSKJljzffxicJTIiLAQa+4BgLfN0fPzlylrdMewPLFID8e60vI3Gu9ws52lo8gl7ZUpVrKE/JAkwmJGZmsL/D7WTvcFY7J1roB/himu13vdxq4Ol5bj9bJUef/KNsICWY0wUVKlQ9IKBzmjxABJspxocW6P+85lacQJ/X8xpzRmarEKHCFoekIWuHB+LLlYZMuFd9C7gXGSi4dSNyoUIFBCwpf+CwJdb9zM+cLJjUKXGxcTCJCzDzTWiVNUX8+PSsrIV7Uvwp4Kdz899dhoIrFdGImZpU0xpIRDPetSvjjMQPFDQaZQ2OrfhM18MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkYPeUSMLv0KptMGl0WJWpWUzljL1hsf8wovnl0+8hA=;
 b=pTOx7SO+A/Ov9Lb/D7blVhmE+Eu23WiUMbHOHYKxMTh6uT7G61zKZM/9y3vD0JCCuku1U3uFhus97PyJb1KOHMZXev4XauPYbWkSBxXTeiN7w4Ju6m1ZiQRq1SfQsAan828ZLyQvkqBt/k4EMeRxv50kYIAzrbuoJwvnflY4/A6/8f0+FstvZ8rcrYmOS8Xx5RZcVNe76CYyRZYfeCxGs6mqhBi+Sxu73WnD+enlyzYD6LCxjNKmkCT/BkEaJqbzRUtUv4JvVbuH73M7KnY9ZQegd80mQ4pYfBpknh2m6zbgiDzMoSeTeMb5BeS83sZ514M4lMM3+/y6d19r3xjyVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:34:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:34:01 +0000
Date: Mon, 21 Oct 2024 13:34:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Maor Gottlieb <maorg@mellanox.com>, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Round
 max_rd_atomic/max_dest_rd_atomic up instead of down
Message-ID: <20241021163400.GB40622@nvidia.com>
References: <d85515d6ef21a2fa8ef4c8293dce9b58df8a6297.1728550179.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85515d6ef21a2fa8ef4c8293dce9b58df8a6297.1728550179.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: f094a991-af8c-44b5-2f49-08dcf1ee2b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEh7vlEByVJo4XbGLXQV6CUeHjNXh4QNNzweOHBaORIJc01q4T0pniokmwWp?=
 =?us-ascii?Q?4nPuNQRzx8VfP6fACXCYrunNsgLa1bQDr5gbLswxFX392wGKEipfhgf7GuM6?=
 =?us-ascii?Q?Oz4igLFJ8IC73uwVZMGwDLd6p80Gl3gSt0VITo1xiCdLIFB4bwgpMjRbqdcc?=
 =?us-ascii?Q?K2Va4NCno79p/HZz7w0Y6+20EoqbFczykBn/ktUGR6SnmoImGd9kcJXO2I8h?=
 =?us-ascii?Q?bOXPbmvGgTMfiZdnO8pw1jIwcNarFzEe9cZlU6IotQEA/yYGGF5OXATg9Nxh?=
 =?us-ascii?Q?aNsev8M4e0Q0VLu0QT9Wj4LF3oZQ15i6EKG1ggmGBdIMEIH+mmMSkOTksGd8?=
 =?us-ascii?Q?5uKX08w2eRaurTKxMxBOJ5LuIuhAlH/ywegX6zLiyV3/a4aI/RgULJkiTOHp?=
 =?us-ascii?Q?W1pngWemStnqyzTi/3yRioIxb1U7ogv+GUwvQ/MLl2FrT0Pg6lbFdimbJtnO?=
 =?us-ascii?Q?TaXVfXHscRNzrigINMuzOP7wuCEJ0nk9G5z2uOiQ36agHBQF6KpJzVyawdN5?=
 =?us-ascii?Q?BRQF91oKU/uas4DMd36bqmfP04D8YxhvrzHZWNaDG2MwD3Afl78Wesp630QF?=
 =?us-ascii?Q?EEk2wwzSDhRGzgy3CB3uhKG6RviR2cI916hErJAqybr9QL1HIbpXDhrBwO4O?=
 =?us-ascii?Q?sN/2zy8+pDcnBSUUkrXmwBq07E/dhVeXXlIfGv7mS/JbGsMQJDQ2SixZW8zO?=
 =?us-ascii?Q?uue6rzjK0SP1k4gt0aqMwzNYtptU4RJGH4IrOPj3P5q2it52DNlj1sg+e3Nl?=
 =?us-ascii?Q?IyqjXfu0fNVq7dQfQXIDpL7j2dDwMbQvvMpqTyGS/j0KqhBNMe5e54HewChk?=
 =?us-ascii?Q?qYvMDaQEPPIY0n+Y0eScot1pdR/3Q6jbEcjIs99EMgwX9B2gBeXasaHmeSE2?=
 =?us-ascii?Q?mRSn5OIxTr5ZysOnu2Vpajxfo/+6dV0xcxyBMNjr8zLMyxAGJoBjk38xQP/z?=
 =?us-ascii?Q?Co68pXPUT2zyhg0cyxR1UCQPkGEm27wFvJNgRkDAPkTkpa8oZi/3AVjKl/22?=
 =?us-ascii?Q?Kk59dZq5ovIIoCSfqoZi7j+5SQyaT+JKyqfSWY8uYrnfYD7aMulzft2CibGY?=
 =?us-ascii?Q?C0ETdaCmCU8T6z9cLcmJcHfuUp0MuirKWjfPd2KFWzSvk/DkQeRS/ybnd2EK?=
 =?us-ascii?Q?96fjDvaxynbasOVGqJHQJXVX1XO2kPktHIVpJekBc/1Htgnt678I0dp8TBbl?=
 =?us-ascii?Q?0Bm7Eb0aBSFdb0984HsQrB00EvHsmSNcFzSZQw2PwgP6TyU6iRbW4dcRFd8B?=
 =?us-ascii?Q?88T6LD5G0Dhgzr81ZUnKH/geZJG7BOaMvcF+Twq2JJ638NbYYWnM+stAho5A?=
 =?us-ascii?Q?3WPjPH/b+nn6Fvm/ZQ33U8mP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hx9gljhqkeKTNFdsSD6hwiPl0AU/MDzYxFWcYv2yM7+dp1H0juII6kU4uagu?=
 =?us-ascii?Q?q/O5S4Ljxp7lXbu6sSXqK/YRPAFXifZ7mzf3kBy3aAVf2DMVLjXBih2afs2d?=
 =?us-ascii?Q?7CBLoJS9YaYMNFYODsJhy6PboOu3q1jD3GaBFV6DaizXMUGWaQ/8yeRyN6eQ?=
 =?us-ascii?Q?fvYRPykTBMrTOEzUcDV84J/iAE9lebxn0XRSomusfEfAv6Rj1amP1GXO7iAS?=
 =?us-ascii?Q?8ds13kimUtReiMPXaU2FOCdWpJ6SM7Z2uKKv0iSWXNI7LA2b2R3LygmsHTbc?=
 =?us-ascii?Q?FWLaHi9+1qSZH1FaM1Kn2OaVF+VoA8AL4Z9ox8S6JBBxmfKxHfaAJiLm1N43?=
 =?us-ascii?Q?Q80XyInxtsZrawm1SwzSUZLNIQXzH90kzKk8KlaUMJ1/ZczDPKG4+rrWTtTb?=
 =?us-ascii?Q?95rcbM5vbZeIoQSfh4bYbMho6Gsqpd9rlpBLEyBBGAGUMUjCzFvPFqQt8Rpz?=
 =?us-ascii?Q?nztOSb6N7J7b4tbm6MrEb323Se3A3lC7lT6lZCk+21X/KqvEzhdRq+xFhY5C?=
 =?us-ascii?Q?k5+UNwZkaw7gucN2+UMYpWxjBJe4By6+MyfMzmBGu/z0bU4P04gyWHBjAwDS?=
 =?us-ascii?Q?V/YvXhID7NSOoZLB3GSYg+d+7eTPNF9HMAcv65ICOdud+V/TsVHFlbGkVjRp?=
 =?us-ascii?Q?nU00m7KSSF5579jYAhB/ETzq4JA9kXSPJTBWoMgrgwgW62CWx1Xi0F4anUOD?=
 =?us-ascii?Q?ayI5IOx2U3ePfiCSmQWFO1zdQVhifNgmrNdZIIZImYdVBetvpDomjs2iz7I/?=
 =?us-ascii?Q?rY0MQP6RmRmKhvhef/aF+yeHNYqcpaIL8GMjhsGUUAMYBQbSAF0ymix2Gkrb?=
 =?us-ascii?Q?mU2l2OLvWXgvnV7inuZyn4mZ16mRP9xrKTIxeyvv6Va3VGeXIbSDGSNLq8v6?=
 =?us-ascii?Q?MyWiN6Qc4ergSoTiOD10qNAo0cIzXOXvuIyu5er/2COtdvy89mtvJUsFZGxb?=
 =?us-ascii?Q?orRwFJl/tw3I0eDg/+OlPDk3UeZMVkm1bIXkGemKdIaZOizAaP2Vdzh7K+0P?=
 =?us-ascii?Q?5l9FkTDS5ZOhoL05tx2VgrP8jW0rsgHEv9LUYLliKivkXKSvhcOGOpkGJzt/?=
 =?us-ascii?Q?bSQyY9BCXVjFhN/oXy6hccpP2e+vhlRZnBXjV6KS67qwB9kL/cbo9xKMmYQH?=
 =?us-ascii?Q?ETuoecYHyKeVl1M4idFNfcENTrh1LvLFe4uevFW7J9miKVwdaroaJmTJT+BF?=
 =?us-ascii?Q?rFxpvihfVEqDm9PnTlRcIIvbbVwIao78aJfQpw7+BxxVW8XQ8WVB3hwyIesv?=
 =?us-ascii?Q?WvpSHU++JuoNJFzC3ZKP4ndoYkysXwXTeRDsVFg0t/ltHsGyONyno1alXwaK?=
 =?us-ascii?Q?47qcihXKhHEUEo75uMWVnSyHpAqFuSNUiP9pKQtnGo1yODs1yofWPbBNFuBg?=
 =?us-ascii?Q?KCCS549gevD/65nEYRYRn8U2PsVxeX5RJyI2aBOqIKr8R3YeRlCk2coc2d8y?=
 =?us-ascii?Q?hBrVwI/jjyrqQq+3nTWyOXcA03Vkj0TwO9mfHjJsPjspHhi8o9FjF8xqeeRL?=
 =?us-ascii?Q?PWs1eSaEI3NCpdqidBh/yPpCbLr6oHGkATMw5liaPfMa6wfl6hYpYXbICOGV?=
 =?us-ascii?Q?USxYj/uM2XzIyu5s9uxAiLlG2vgKKmtvXXu8Ixk6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f094a991-af8c-44b5-2f49-08dcf1ee2b3f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:34:01.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkfWmkerAEocpCe4kKgTnq3xZPdNWrnmcZ2U1IG9A4HM+5avWzfUI18emLiapjme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

On Thu, Oct 10, 2024 at 11:50:23AM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> After the cited commit below max_dest_rd_atomic and max_rd_atomic values
> are being rounded down to the next power of 2. As opposed to the old
> behavior and mlx4 driver where they used to be rounded up instead.
> 
> In order to stay consistent with older code and other drivers, revert to
> using fls round function which rounds up to the next power of 2.
> 
> Fixes: f18e26af6aba ("RDMA/mlx5: Convert modify QP to use MLX5_SET macros")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason

