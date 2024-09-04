Return-Path: <linux-rdma+bounces-4753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0996C324
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDB1C229E8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604121DEFE6;
	Wed,  4 Sep 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3AFWjT2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9A1D88BF;
	Wed,  4 Sep 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465309; cv=fail; b=VxgVixrvRdGa4ze4K6ulpTGxbAwA27g80hyOMKW5SFLeiKwSGZuhVeKfwVahSm0GYXNzGujAFFBaVa6dKFw0BPYdnP9lQvd7y9zDt6NxnmPIZZM+SJLSPjLhrbhk02uJSZpXcaWRrzwktkHqdotiSg+3Y2E3qfYhC9novxLrrew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465309; c=relaxed/simple;
	bh=kcq0j2YlHrmHczQZagpZZERbRAR7MEv6m6XuF+OyJb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EBB2YD2wDxbOnuvyHp0JtidUgurihYWfBwD2wzYkzZtZFB9HexYoCv7+7qzdmJccUUtv7AeQdAUhZD8hQKCdpKr0p1YmbHVa5jIP4mZM48NqwIMjHiFFzRWaE20RG9UijP/ZuvoyQIr8ZQVTZ6xVsY5yNKQvx7TxTORZxTwEj/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3AFWjT2; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEU190A0oMNkUOY+Um5trbINWZb/Tp3O0R68wTj1+ry2vbqnxX65j/HVSqxaC8FcM5q5zPFV5zzudxy0miF3bQxTBiQAaAitSx3KseY5Y+IepVEJw9i1Z99XPRISLRwl9UusEOfH2nUG8EpUKc3BH+LJM0wO+xGy7KzwYUxZwS4lAn9JPQcL2q0T0kOP4HsfDGesehXt6MpIG1z9OtN58Wt6Bh8Nchp1YXUQ+B2aCQ4vyvvXK3OZaF8DDNxvMMmiHRtd7pIPxOuZxnHUnbsQIEj/mX1MNZiTzn59BXRaUiUJt77hXkOJ6ceAgKaIAF1q/rej0xStCoQRASgrfLJ0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/2zKZ0Qo/qNruzQQLSGfz629r3hEdjOOpryyApI+OQ=;
 b=Jq3u9T1AHt1IEySGxkXuAs1sCsDPzvsl/xVxRtgCQatCX3rLUmMqW/F7admjrUGHvRGIfjSozUvOGMsAU707EcxIH4U+tuUelWPaU+wSz47G8BF7ffNBulblFFwbmu9Tk4kl7ok8SoSQbGItwsLvNZ7OPTmTKErAHxTRQXQLBC1RgsdJzALMco9S5hckrtkxigkPBTEUhtyFgKSssxVLQ8Vrz6243hbLy9QwVErg+pngrN18BmdWiSZ7skZ19Z3C1+kCXWkUscPN+uFJcwHq22jJOMv56/JQ1uTOMGgzWabEzy4j2uCG58ivb3nHXWDwCLqDTZef9bcTgCJM5jQRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/2zKZ0Qo/qNruzQQLSGfz629r3hEdjOOpryyApI+OQ=;
 b=r3AFWjT2cE3QDgi6bnWKCMw/OgOFsqDm9RS+/T1gCqj1+WR+8NMVLgFSi4p+USOj0Vv2J95SF3C8zD0eDsm50q9pMTFDfln1Ts+DNQjbVoZyEovZZgdYMKOm1ggVLon4/sT/MFwIKaaunVBjBOXyYnOCQ7P5e93pB3Bq2ybiP3mxdJgPqnWCC28Q93lTdQFWJBFAU96yBhwhCmCB80vuNqLHybjj7RylZR087UER1Jq4UIzSlX2XJUn+uniq3uSSf/wBfaKDfIen+9sONr06zGIFjqCAq9wI7IIeBVSbtAuSrGTCw7vMhVHK5use3K0kF/87YwTkTvwIR9nc0H3/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Wed, 4 Sep 2024 15:55:00 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:55:00 +0000
Date: Wed, 4 Sep 2024 12:54:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@gmail.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Message-ID: <20240904155459.GK3915968@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
 <20240901005456.25275-3-michaelgur@nvidia.com>
 <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>
 <20240902075426.GD4026@unreal>
 <8e652f69-78d0-40f0-a712-60ef8733cf29@gmail.com>
 <20240902181252.GG4026@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902181252.GG4026@unreal>
X-ClientProxiedBy: BN0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:408:e6::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 099e2679-b191-4e2e-edc1-08dcccf9eedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RW2O5uf4bFkPupEbP7QuhTrnXsQIpV34VMzaVmVswNqwb5tsJIWhWXRSp2WP?=
 =?us-ascii?Q?3rKW3mYTGeFFhnBdKqKzaBONRGxWt/lDWhVf1JWimMkQhuT41kNk9U+tntiO?=
 =?us-ascii?Q?5AvSaWpMF4j3QF8zcYZN5V96+oYoaSBL92r/AnmnIYekvgaGHrku8UMXhCUM?=
 =?us-ascii?Q?0/4vrWHynb7gZd8ouF5zP9oBfBhRBMGhbj7uOVwB+/uf6h0+a0qLu0H0SUlE?=
 =?us-ascii?Q?tlD76M81Lbt7k/DtuNv9TBlSfg2iFgrw1IkPoqn1nnuMRxPkXq2DKbqlOf2s?=
 =?us-ascii?Q?q+wpyj5B2IHj8n2QnPUXXU8tyyjkuOK4nOmM7zuNg2Hgs5V4gkvh4Fn+Un7d?=
 =?us-ascii?Q?cCJszmY+73RI/YaCk3vixfTwmjYdGIKo4RlIiOrLP+h37tqDTJxCHhDm3eBk?=
 =?us-ascii?Q?qhZ8y1qyrHxcwki0D/4dmXX8CvcepsqnLcnWmt7+4yVEWVvAoDrAvH9GF2Hc?=
 =?us-ascii?Q?cpDAOM3Baq85Y2W6Yqc+le+xZiOgWDcYxYJESOwMoKJYwdAgs6KDtZDWwo7N?=
 =?us-ascii?Q?twYb0fgrg/OT+1XEcpo9EqxwnGa25XoewFQdSwfuaVLuBEchCuM24kWCxVF+?=
 =?us-ascii?Q?qls1b5tLFsGr0G9MGg0HTID3lsUAM/uLQalcGEqkTgkL+s2u4MjpTIyCYSO9?=
 =?us-ascii?Q?O9putRbyZHV2yft0uDWQjZf5RwVlfYj+MO9ZKUplSDCDiJDNHFRflV0LcxIC?=
 =?us-ascii?Q?tH/QeCH72Vrr4xE9hJDbDwDVgmdCd/RLPxAxtgjneY56cj9t7sF+Jj6ikBjZ?=
 =?us-ascii?Q?utJ8hRNeUzUGtqNU6ml7xcc1BwFly/JMdruI7xbyqiCma4c7rgj4jLImop+T?=
 =?us-ascii?Q?Vtq1myiC78gVWab0//jdiNjHs2cW0xUK/dho+2asltKGVjb/x2chHdml16jS?=
 =?us-ascii?Q?w5Eiz8RV4rcQ1dQLmw4EG+ogO+SNEZ0kRO0yp01ZHKJSK6JtNp6/bnYh8c0T?=
 =?us-ascii?Q?jOtjQ0b0dhQ3H9oWMBinrKZbxa6aq3dzrnMm2NuLk7vV//SeQuymZYKsnIGa?=
 =?us-ascii?Q?EZcF5+jMdk+0IqxsCfxteE9ef89PpIEHwu59+lUaS0IimdWB1DBtY3wBx8i2?=
 =?us-ascii?Q?dAZ4wrhcXVJ0alZVXVnsRR2Jj7wd+POz/rkybY2kXqmov2LYXCauK1d2gbm0?=
 =?us-ascii?Q?QyHu2dO1aLVRXfbtE16myotoZPXyXzH3T3hVfCRBSGR5tiQGOjLqelyQYWvD?=
 =?us-ascii?Q?m9dzZCZ7WeKrrNKVuifuiRAsQwsSNf+E81urnrSa7Akb37wIbiDulhBjfWsF?=
 =?us-ascii?Q?T3mLGGlwWgtzyYiIfUpo2Eo9VREFrSjXbOgBgs64D82cqHRijU1Q35w3h/ia?=
 =?us-ascii?Q?7Mdek+Nt2xFMI3mo70cLFbfaIsu5OpMAroMlfB0vGw/J2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aW8cOlMdCTo4lgYLrt/fxaGMpVluCaGfRB+hbVPDwfBEEf88Lyt+QihMuRbN?=
 =?us-ascii?Q?zY48uTISJe7jZDLckutfrFV9kGDgqDRrF3SGxIwQLWGQgyPSMjF+DmiENV4J?=
 =?us-ascii?Q?aJVRSR1VSgfsYP/gdZD77uSvZrgpZkOIwf75HNtaiRgEGpBszcikWLnkb6gc?=
 =?us-ascii?Q?hpFhBjPbitceNYJoVlSiQrxiuRF9CUQo3LUrMT/PsgxK4MJkCxC+Nx3IJNeM?=
 =?us-ascii?Q?5pGOGbOAQP7Q6IXX3kKBA6aMT9U5tI9+SfS468R/cLi1+oJjZA0taaKyenat?=
 =?us-ascii?Q?s9vDvz69p3KDS18lyUkT3VGVhE/3Fm60QSFUaruFy8LHwOEtz7I1KCLSA7N3?=
 =?us-ascii?Q?YMTpWJidG3YlR8oaBvXcS8gs4Dl5zcCR00KgjMzF8SPOTFF8GWCZWvGTcIOk?=
 =?us-ascii?Q?4TYPKqBMgu2YgGpTP0NLspoZjyiDjxeFp8u9T6sC3zjWm8j8w4Kxr1kc6kza?=
 =?us-ascii?Q?5ay8me0dJ53SPZmY6VyTI/mB/dE8DKjBFy6DjD/Ny7qq2dHc9ckedz2V7G27?=
 =?us-ascii?Q?HYJz3Pc4Q7rPNPh1bkh6LS2sLo1w3l8jUGlsdkvs9Su1lMuH2jyQKYAHX+tV?=
 =?us-ascii?Q?jX9c9rA0ho3lUO1h/rBoVfkkS5PRT6vluPp6GaeWX41shMxvGxN0W6Z/Zt3x?=
 =?us-ascii?Q?SLrT7D5rYwpvyftWioNYzuOKEXWMOGBYphJfcM+6hTVxUJ5+u2gS0Gv191KO?=
 =?us-ascii?Q?HQcVBLwbUE22QEni5V70DdHrkjAe68NIJ9P+Bj5XuzNhIleHF91WGpT+mh1A?=
 =?us-ascii?Q?Sz/KmN9xGI+p1NvAPj5OAiOTFjs/+cIRpatU11abkOx9A0OcE2TIFF+lD6Ag?=
 =?us-ascii?Q?rFzbOBGP4FnodpW2Ej4YtlXHmIIoMGnYGX/sXp8gRztSqRzZS/gN5ApO7sFM?=
 =?us-ascii?Q?aPRyOzevof1bEl6D16oD+T5qUYV7FXPpVAtJDQKB1WcCJFv+6nXtNHtBCO/S?=
 =?us-ascii?Q?4EjKmoRt7RM7NheeFXJzg86WPQsPKk8gxYD+DXZbY/LAI/M3FJanaRfxsovx?=
 =?us-ascii?Q?g5U43UeJ7L9wKt2EMdCkDyJaDK+0bI6yLllAdP0pwA9SMHNCoWjaUPiZMVUt?=
 =?us-ascii?Q?5kEMLlmPguU4RitqvSHCLM6FkpKOML0I1Pyc766f/tjtRj5OwqiC9D/gilM/?=
 =?us-ascii?Q?2wI5JpMKpuOOJy85vSeDkeFqn26/kagL6rA1EbzksbUHaP6rGAaa0g1cEV/p?=
 =?us-ascii?Q?rKTaK6DiKUfSgYHto22kJ5VbvZS5F2OTCMnoyR3NwKCAteGSYpSbGtoVGkhC?=
 =?us-ascii?Q?EqiX/E2OkaNOkXK+3flOlmhHh2tX8ljYAIOib+pnzFYwuGstoS7YqVqqriFI?=
 =?us-ascii?Q?pE3+X7Lx+qKED5Ar0A2MOj5TIN5TI0R+KLLwelD93qylWouhjBynDQ80ji/k?=
 =?us-ascii?Q?3uNBHbgot6QdYV65YlE4Sh38p6x3syQa59LQpP5K3fFjCcLkeLLDxn9PS5G+?=
 =?us-ascii?Q?g3V4YgBcGym27k2t2wh+PH691sXqLJybEEkR4BSzo1HkeBBoHxJBITHYjlRr?=
 =?us-ascii?Q?GPlh+BoY7L4SnQXn7Jlm7cC8ZMbPLFup7mzngdMLx/poteesXGUklndf/HNW?=
 =?us-ascii?Q?ohZMucvDDD1TXlqL8I7sRoUN6tdTIAPNW8czo3fE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099e2679-b191-4e2e-edc1-08dcccf9eedb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:55:00.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bo4EnT75nQAKiPvJ3DAzOJND8BbQ/lhKbLu5PNkL94sX2Or1COS031hQnuLAiCJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206

On Mon, Sep 02, 2024 at 09:12:52PM +0300, Leon Romanovsky wrote:

> > That's a big assumption.
> > 
> > It is trivial to convert indices to names, so this can be readable for both.
> 
> We had an internal discussion about this earlier today and came to same
> conclusion that we will convert indexes to names in the rdmatool without
> need to change the kernel API.

I think you need both, no automation should be using the names since
they can be renamed in racey way, everything must use only indexes.

We've had issues here in the past with tools racing against systemd
renaming the interface at hotplug time.

Jason

