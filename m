Return-Path: <linux-rdma+bounces-9040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AFA76CA5
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 19:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9808188C02E
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72692157A5A;
	Mon, 31 Mar 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouNJ+DHI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8815747D
	for <linux-rdma@vger.kernel.org>; Mon, 31 Mar 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743443131; cv=fail; b=O035kLwuV5jxEWTy00b8XDLtKtFpNbWPeTJguihpE8UCsowkbIl8zVjrJgA+cjkTs5NT9lT1Kn0yso0StQWHxDS+FTKgSxjCVFbuIXCqPwdvT5Uj0gj+cQR839F0U2FQUbotD1F5//ihSjsrxxLDA0ZhxhIhztuQWCEoFYhKvzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743443131; c=relaxed/simple;
	bh=CAHeT41+KpC0AMEzPwf5SV7OJx8IT20/OtBRyoxuiiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+20Vb80LkOP9FILwDmUzPH+Y/2339F9WyfIbQATnUoryeC3oWtneE4tKiQN4wfTJOR2O6kJlxvXaDx1iXBfrc4JbKwSIwpw6PEA4iXl2WBTy4pcXXsFI9N9nNCPRdT2kE7FzjOiPELPUp6sSPt3j8UgWARDkE/nN1n25jZiT+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouNJ+DHI; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P534TH5D5l3KY1zqMsqDOdgU+Fg3At1X1pDrqy4W/R6rr8apzMk3LsGlb/uspQ6CuSmiC5zzynHqlvAAEGCd9doSZtNe/2Qo11HDQSjkFivVblXbW3w7lRV7fo1oYjkoD94l+U+tYjqJ7L25E4jpZgezr/NhRh9OWvXWrAEY/YES1/GdgpV60ScZPSwRI+65muel3DTTiU9F7kWSGQmYHM2VCFhDwkv2To1luOtf5eHDNk9jDz3G9gb6y3X7zrkvP8VT3bfc8j4NHm4GaMkojwGwxggGcgtJ4Xsm2HTLf6kXunIcjxSF1nPdo5vWUdPjKaNYRMrbJm8c6lBlGIy1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qHLOqMZD+vLIubegLK3j2EgtNaqwC8GamAzYeINtuc=;
 b=PUkvY4yZS2fD1OeP9tnToLQevzGFlKzECnjkevSN+npwi378BOIxdOfooyyNssOiUntCp6owcxITSS46VBmkhpHwn9yZC/Ch3Kd40WCOEh3+jPdplp/3M7Bb1obUaQT2HfDqVjpKn0MTxaufyu0anX1PiwMysjrs2+WMxe+zlefIun4DpA/pmhI+7ZpGMU3nFX+G5PEVk/yKuV33+DW0uQFLUWaN5zRe+UMc0iagC3ezRNMn/lR2exGX4Mm59XY6D6IMeaIIFXCQC3EcTKSZXNyD2v8Hxx/lNlIK0a8NiPOmlfbhg4p4qU7mmNJwjvXbAQfo/cOEvAnK9zThemdSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qHLOqMZD+vLIubegLK3j2EgtNaqwC8GamAzYeINtuc=;
 b=ouNJ+DHI/4hSyGpJfWRhD2w9Hsj1QCvk7O/nks2G3sLWXxC8BZcT4ObaBuBVCOU4RRDch+GV7cJnXHoZJ6JVSgIevbDK2Rgf0RXgP/A1p2ACMiakMbfUqCor3LT6rZL/hQbLJsVnvblCrXjec2YMl25KrsNnFifzcGR25n3rb7I0SOJg9UEiE6RH7vd1f0mJQQsBeKmgnfOPkeRhZuE1XKLRRwBPRVYHqobBCT20Vc1g0wWnniO6slbp1jf7K/nefkcde/I45KWRiINsW78iItqbBHs1D+0W7TLGhtDmFCufed5z4Bi6IOCIzpSRZ+s4vrAUvhtVCmu7ak2NB506Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 17:45:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 17:45:25 +0000
Date: Mon, 31 Mar 2025 14:45:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Message-ID: <20250331174524.GA291154@nvidia.com>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
 <20250319172349.GM9311@nvidia.com>
 <20250326105854.GB4558@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326105854.GB4558@unreal>
X-ClientProxiedBy: BL1PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8c7b30-5f9c-471f-82d1-08dd707bd127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUtlT5Kxh28/c7hNHhMw1ll9P+dk3+Tya8lQpe83sRR7mkGQksxb7OM4rgyc?=
 =?us-ascii?Q?FCtQ8aUfe1cIYaupd854gsrywyfx9V/8VPbGjAKOe2eGjKMS+dtzI70sQhyd?=
 =?us-ascii?Q?kZjyGrcWrG8s2PqxZj3sVezDMg+vDHniVgQ0kp9TffleEdMCuWBaeHA+Kqwt?=
 =?us-ascii?Q?ld/95y5KFhkSIj4nyDf7su1I+Odl9/Ab7UNeCMJwdGXnqS0rGfbG73rD6mt2?=
 =?us-ascii?Q?IBX586L8lT4pN9eAx/eYc8+dcTII8173UqwLyhGYIKQoVngid3hlfCXoGsez?=
 =?us-ascii?Q?qKaPkhGQODNYgVxpr4ZmHPEgMrZ5SO+CJ8xxuxJb8+T7pDhB/DGEogV1S+q7?=
 =?us-ascii?Q?rCi7YCNFYPjNwy0xoM6mB0TUWJvvXV85IQ/yZHe0P8ptN585WdZk9t1SW/mG?=
 =?us-ascii?Q?kCbvWx+RTkFebbZ/jfdDFOr7jatSYz0O8tFQGrSQo1ArH4Quomc0UYdSVX18?=
 =?us-ascii?Q?T8T83m9ACer7s807Zh9fDd2xESOJ3EK4H99cnY0xkYRVt3e8jbyRxGCBzZ8X?=
 =?us-ascii?Q?qwcandvzgehjjmMWL/9t4y5ObiYoa/e9LtdHJaQ3eXgXKmhWm9KOZiTYBEtM?=
 =?us-ascii?Q?CgFCYP0TE5GacUWJVa3GZNkvxOLtPt2oY6mnnwBcZIol+d3S6QvVPL9VkdYs?=
 =?us-ascii?Q?BI06g2ZZDiEHcyecyuQNnvaQgJa3S/exB5JPmbKIoDq+vyC1AyCalSEtaZf8?=
 =?us-ascii?Q?D6o8X4ioge/JhgDFiXZjpCAZuvy3ElLPVhXYEHPPa4lczHqYIQUO/Iio09/0?=
 =?us-ascii?Q?yPnIQTP2Hqc32n1HcME9eYNcK1Wm0MQrX10GY0IoNRtxAXfUP2VzUD58+YOR?=
 =?us-ascii?Q?rLI6auFhkcF1G5V7CmnkeKpLz63IM/XzfC4yCp/RYalHb4u65/iZMc42I64N?=
 =?us-ascii?Q?SmjNjxrvN6z0Sf74GmUA14HaZVy+0bzsLPG/aMMC5VqSaXcTl9MTH7CdaxnX?=
 =?us-ascii?Q?/JkiVCYUSeF+esTChKsIf5gJ0jdpVgt6GZgAPeq/mk8CT5PwqSASs+ON9mVI?=
 =?us-ascii?Q?mgTcIHbkRqIBdGcAuNOK52TqDeOkAlN/ZTmi/GENf5f/p+NfaB12RUuqyoo5?=
 =?us-ascii?Q?i213Ad8Sig23UjDn9MtUSXA+jCnC0AIRLOk9zzU/X9WaM1zUGTJnU+v+6/n8?=
 =?us-ascii?Q?0jJ6OTPPtLOXcy1hzaqcfUyZ4bECgTdr9TnTvoWCr7wfjYOy4vwVjjaq0UzB?=
 =?us-ascii?Q?6vbqJcps3RX1tyJaXmxqJfJR358iagTyD4HV+TCCsea5JqvOSM2Kpd6G64NS?=
 =?us-ascii?Q?2/vMicy/cDQiJpLxkLoMcmYwEBOLe00qxsFa2W604yX+54/PmgDJ+lts/q2x?=
 =?us-ascii?Q?lE50zrNGKIs0HVSVXoKur5pFZAsGCZSXtmbIvAaDsqKbtmmXpph27ssSUi7j?=
 =?us-ascii?Q?ZIKsGeF/QvuzCKco2z74xX3h+Ksy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwpcCwHpQKHyM/9s6qINx8ECzkUgOKNqBa9VUmQe5yjQ5YOwy4WETkzkMLAx?=
 =?us-ascii?Q?//tZS4WX+GDjrf+RXjY3PwbeqW2JcXoDyBEW+v0iM9hLU7d19wBD2b73Z8s2?=
 =?us-ascii?Q?D6sFe5Bgls6R+UiMkjL/1Nb950rL3PX4kARqWmqUD2D28dalP9toFEzLfHTi?=
 =?us-ascii?Q?Envp+lEhAHZiQmuxg8n60yb2OcNWSk0OoP351E6sV20ywQKP2BRDzn0MGzJH?=
 =?us-ascii?Q?7jz9zKAt8wAaYWvngjnEXUbXI+wRpkVParx4Db5icZbSYTF0lBYYBvLaolty?=
 =?us-ascii?Q?kOGmv5uayKhPrv1qIiADv3/z2PoVRqBGzk1DUCep8zKXgDll5VMB6a+Xcgdn?=
 =?us-ascii?Q?TuuWI6rsdTzY+HSUfzniAUMc+eWOtbbQeIcT+dQOb4qS2r5A7TQ0MbdhqB9B?=
 =?us-ascii?Q?BWj0aXEzhR1Zc6ULbmd/RnUKmRmv9XQsKZuxKDdDZhDSKwOmmasM1P8D3KH2?=
 =?us-ascii?Q?THKrrQRV5fiIAipQlnRL1giTEQLHYOdG5jdz2TtKu9kVjOf5T4rwkbCr1Xqg?=
 =?us-ascii?Q?+ld+pLPHWKT7A1G57Wv2ewo9RtiywAsvflvH0wI51ZV9TezyV2FwugvGTY/v?=
 =?us-ascii?Q?/YJPWy0OIpVdicDy2cVGHyR2SRf87zNcbeh7NO2oq1E7ET7nmfm3jompyTOf?=
 =?us-ascii?Q?jkHs62v531QcQF7NckGhHEcTMNLAgkfItWdYZ2HC7gIF73vu/kx1uJlwIjf1?=
 =?us-ascii?Q?22WYQF+5j1wmazCSCnJZK0PlAnqu4wnemF2a7KuPouZqwZDXQqzqpSVkKHgy?=
 =?us-ascii?Q?f6qzDGCK2JhkShS1Vn+XAOFP5wzYcywsYjtysC07AlXxMgAiJp1wEktmNeuP?=
 =?us-ascii?Q?yigx5Z9can/j5o7WW20CdK2477UPbJ/Fx2Ml5wYtZdKVpBgyzgmOVez/5w2u?=
 =?us-ascii?Q?UR3zGF+M+DpOqrZLAOJxompMDVphFg7DJ477Z4N8UtARVINEraHe0FPiHQgA?=
 =?us-ascii?Q?KZNx39hnPHDr+WTEvfwlTvouKDAZ8enzfi0MEYhNrJKeDuL+pdHJlo7xSViC?=
 =?us-ascii?Q?WMaQYeP0WjLq0GcIpwVDm7zGZVz+sZKEHg0Wkw8VnrkuH1+1Bz6by5UFATDe?=
 =?us-ascii?Q?RGZqKKX/tIlpeo6H4ektP2acKPMNJMgS8KhC2YrIMnSXxM/3NzI7FGkxDDkS?=
 =?us-ascii?Q?KGVX1OoJVe+Quymw8f4+nrYIG9wqIC+en27RADnT6BCIxBwTqQXAmqzdS3vN?=
 =?us-ascii?Q?WyXWZTNvNzzvUUNzPJe6ND6Uy2WiFOreOF54dWbPhluVRXoCo4LjLehOf/rq?=
 =?us-ascii?Q?fCrDB3m47mipQlcHgRZhm4BvlAT+RjfEes6D1+xtpu9bZUvvKu8nRyYgJ/jt?=
 =?us-ascii?Q?yzRlZS22XOW5so40Qtopo2K6Z83Gc/nTE14/fJMx2uWOp7tI4iGuBLkSRYzA?=
 =?us-ascii?Q?s0NUJjo8uPE8eM68nRlwPxs1NFlYBlxdzbrVW4vVaSShgiPHhmdGwyY/j9gW?=
 =?us-ascii?Q?JPhKDZ402JKW/JYOpifQgumVFec9ftQeBTHAkPndiRYSd+j7fbCPeeESNV5V?=
 =?us-ascii?Q?bql0c02mqsQe2/ccOkF+XPDcCJgQevsXJDcQh8B0CofX9B2K1EAW+1gtnX9b?=
 =?us-ascii?Q?MDBtdc2Ga42pb+9k8GgTQxgcssb162McpKu4aYyn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8c7b30-5f9c-471f-82d1-08dd707bd127
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 17:45:25.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIYfpKo7i0mzBKB8FUfQLMG2fZsz5Uz7hzgOYYRdI+W0MiPd9ewBnMl1sGe7XunB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

On Wed, Mar 26, 2025 at 12:58:54PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 19, 2025 at 02:23:49PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
> > > From: Shay Drory <shayd@nvidia.com>
> > > 
> > > syzkaller triggered an oversized kvmalloc() warning.
> > > Silence it by adding __GFP_NOWARN.
> > 
> > I don't think GFP_NOWARN is the right thing..
> > 
> > We've hit this before and I think we ended up adding a size limit
> > check prior to the kvmalloc to prevent the overflow triggered warning.
> 
> The size check was needed before this commit was merged:
> 0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls")
> 
> From that point, the correct solution is simply provide __GFP_NOWARN flag.

I'm not sure, NOWARN removes all warnings, even normal OOM warnings
from regually sized allocations which we don't want to remove.

Jason

