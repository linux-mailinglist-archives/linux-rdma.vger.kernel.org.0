Return-Path: <linux-rdma+bounces-7857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C838A3C26E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336E7188AD02
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49417591;
	Wed, 19 Feb 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QqI5j9jD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E318A959
	for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976381; cv=fail; b=mSCIwBfFH+Ymi9T7tVrC7XSrBsNgZ9MAwKEsnEhwh/JxLSQhYlkFQUtMHWh2zCkhgHrIlAPt+wCUE0cyVvUV22TVj0mThQV3Wjhfp8WenhBl6p1UWqDLEza4yDpFlEWbA4Hr5U+r2gkWWpvCrJEODlbb7hj3DL2ZyFK79OHjzFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976381; c=relaxed/simple;
	bh=XbWZhnm88KSQeJKSgUJLoRfXdH0WAHINgto2deyNRXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WX2RY4qJDy3D3hyNON7snXDC02nb50N07nDG7TVcKHOGde/GuoRVfexQ7ymbrHEn93mZgUViM8PDidiJpjIAsa2cvtw/PpgNhkU3sstA4olxlDC3W04NBux28evdpmumG4srvxezj2nEhQEsyzdKEYrNPZo0biirJTIWV6vNr7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QqI5j9jD; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFheSRmq/xever9OiYdabaGmoXbH6w7bxsa8G69YUKnBq0pBWY1EwQLUF6N7nu4TPQLIin3kdKMTjuW2QSh0bX8UQN62R5B/atghA/1/zF4c/jSH94w+Dq+qWFKspaBUdLJiuw1Wp+L9jHgUKKnVifDSKfk8pRFBXe/+/nX5rTYS38eAqQnzp67dDx3jNj0xx1HH5kSSZQ8dRrFTnEO6/RKkv3jQGdj1Kx060LYTePSjH9XkSywSfdKcrtqWfsYBEZWbfOmzjLuDQGpl1gs5WevdiOIREOxBzNuZNR6G119HL6XdlC/Yz59XfvHtE03Evctl+ypc15LKm9CZhEq3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNGgIRdIoYGrPY+x+2ZDyHXwQumDfeNbtCcGjtiQlIQ=;
 b=CalVDgsxMY7IqkU28RIqkh7o/2cFJet93qF4SaFJJBnKa0dJyOqAv1IUXx6dkzBuxYwpVE4gjaUlxKjUdCGtavP8/KMCkOFv6e4Dij8275BOlCW8J9saZ0NL0/BQYRRGmo3ono37DJt0dTUJVhi/M3oymUT/ZHHbqwGONYEgE4GmFcVZBqIpXG9lV5IjoeqFVVvYZQBR4zoqbAvz7QHMB+U9J/4rbU7Zxi53N5+HTSFYly2Env/heuaaZV8GltCDRBBWRtNL7OnzzKnJLijN06E5+xEH6MOrh6U3YUi24bZGprtv/6aOwrWgub1bRLTNFtwLc1uUYnN3mUWAZxAgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNGgIRdIoYGrPY+x+2ZDyHXwQumDfeNbtCcGjtiQlIQ=;
 b=QqI5j9jDD5LIzTBq13VwCXNc6t/cefYj8+puw9pEdYtw3gD3JgruuiCYqPGO1yANe8L3KS55NTGTJqGPF4v7oQOD5WC5QoOvz0a2Xy3+SmvFGXObdHv0b96C6Csm/R8FowZb0l37inhHTe8/S730Wcc2+d0sYEoOUsob3HqYg7b+qnyXVf0s3kQs0TXM3muUg7hnlRUcH1eFnK5rWI6Yn4JY/M/2+aMDHUwUyn8eTf/QMNwVI6A+uByfTQKqcBqa8eVyMgmVHpdi+nEN/lcRzxMmgYKFO8vCiV6gRvMPNmlopqerCfyUkidmkN7FHVGN5TOSNU/WTipXNBI1GtS1pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:46:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 14:46:17 +0000
Date: Wed, 19 Feb 2025 10:46:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-ID: <20250219144616.GO4183890@nvidia.com>
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
X-ClientProxiedBy: BN0PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:408:142::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 851fa4aa-5164-4cec-1ed7-08dd50f42a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4eBWCxWOCqASmt3t35OomsADuhjmrcO7RFE2T899i92mEntrspN0ZeaUO0qJ?=
 =?us-ascii?Q?ANF6ud/ZYJgbdGYt2Y7GYkmzZnfMeUDNK+wFuiTF4Scfru8HucdqBOwk2pgj?=
 =?us-ascii?Q?37wG33hqCRlxZ2f0fJlw1qbs6+lmSnaqGKq1jJcyFXC37gfNnc0VOT9iDkBL?=
 =?us-ascii?Q?RixIB+g96ge/HuGN6kLXzZdAu/ofPQ7q1r8viRwmnMmi3Xeo8xWjtLndM35t?=
 =?us-ascii?Q?fmxfgIYHAAOFAn618mVIbjGMU9o0z9VdCJad4jlDS4qNDObkN3XI7NVeU/JJ?=
 =?us-ascii?Q?QoyJ5m9PMguzRE1YAgRKKrxXOjA4pIpQA5SHvPTk7r4y7bjliaGxVjyUoMYD?=
 =?us-ascii?Q?1MGh8Fpdetvu9iz+pb650JBXynCyvhJ/kNZd7Lc1HV/6DyDonhjaWjTOyQkZ?=
 =?us-ascii?Q?fatd8bhQrhe3xX7dTUbLe5TW2/PHQOcDaxdpkeQZdEltGFsrqjG71z2+FRXu?=
 =?us-ascii?Q?Vrp3FmjhpZEEzfDok2xwKwg5ldNloQLRfiKpWdkb7gx9gL+75JkaHH7Gj2Pn?=
 =?us-ascii?Q?t240SZGt6jb/RgiGvfRJmPew6N56TjaNz5IETcRdHP9NJ5Hyrss9fbBjT7wz?=
 =?us-ascii?Q?YohJhWqTVarmx5Dwkb5yDcAnZdCm80W6slSudpotYSdjA9Ix9WMR7RqzLjbP?=
 =?us-ascii?Q?puR3SRqFnm0REO8UOK1eG9HJZR8VqGiGKqSVywm18RQ5x/xoNwqNQabZTvw7?=
 =?us-ascii?Q?0LHp1G1L8Mbp49b0wwjPrZlBE2SonRrkkzCLe2pwo1QAFzgUpVpySfrVSmr0?=
 =?us-ascii?Q?gseH1pNgvUYA2odw37qNj5G41dSAHQu75WsgRaSsOAGnPzIMcXeliRRfyrbS?=
 =?us-ascii?Q?Ix9dSEmDWrbs7rdg+oV+yIKTX4qaUm2g3t4LyXXIF9lWbvHt+scw1l0iu7Ku?=
 =?us-ascii?Q?zYucw/SugGN0WiBV5c50j7e7fXkq/Vtvckrhy2xTT2tmvIPX7Hzbax/yyuLS?=
 =?us-ascii?Q?JPFCjpcvUCkB5VoQZnEkCW2aUVYoGM+YkC6v02enzq6bqoeUKJuYJPPBQabg?=
 =?us-ascii?Q?VzAfMIF8wcfmcApfgU2PJF0oOI+2fna8lWWKJ7u5r7tfnN5jkTnuT/Z/fke+?=
 =?us-ascii?Q?BS4Wcmr7B2YMTZzZHChEEhYyTj8+qyuH5jtbN09UQu2ObWpfttYDqtmyHeVj?=
 =?us-ascii?Q?fRLZLYiDdu1AHL9hYnYsVQAVEKzwZFB5YcTnjIQXrxrROMuFHliuUYoOkzye?=
 =?us-ascii?Q?oibKPx0/0/nqpEvsSYP5efVYiiVcVYzCJazPTh0eZMfk4RJpV9AoC0BrD5dc?=
 =?us-ascii?Q?zI/bwaz1DaNaDlC1aZL+3tJQR/b6+YQ4tMFT/uuKqrVT3qZ0HcrTYh4p8/45?=
 =?us-ascii?Q?s9WGpvfcidHFzdyIHvrzEqyyAvN8K9cJIElL6Ii/TqNTQjxx023JUBQ58lIO?=
 =?us-ascii?Q?xK3zE9WIpMokf4ks90LhS7U2V/wf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?thJILG+oM4R4jKh68rkZw6hyR/gld7u3qLFI1v8TdeyErl1PQvgEERv+MtUL?=
 =?us-ascii?Q?PlEdNI8DSukwLtizqleUJ1SiCbTHssG3cEL+yCYolm7cRvaKkVhlumxhHNBw?=
 =?us-ascii?Q?5TjGF+8X87H6C37PqNaAJt3H0CB2PzzlR3XOCulW1XdqaHdrzM/IknaNtAJv?=
 =?us-ascii?Q?bcqO1GxCDPkxMCZMMnpigavYKEsXW6HRwCs5CeGmjhr6uSDxWMnIU2Q5XJvb?=
 =?us-ascii?Q?5qBqaRO03la87QABnPUsnoABtYlCl/hxPL4f6oPgxCDhoU/2RpZhlLhF0nWp?=
 =?us-ascii?Q?KarLcEIaus1M6CBy7YmiTJl5iPPvfcT11f/ejdwu0vllzfRLo6AlJ2TH3gLv?=
 =?us-ascii?Q?bXYk8h5RkHoYVSRXZfvbZJmmlXAvDWzCNeyYP98bBHbn1rLWtyE1oBJGg1yg?=
 =?us-ascii?Q?SyTNGFigBaJ/yoqBjKRE97Wpa036+CDKihXJDaK2qjTQDJR7keIdfXrmI5Jm?=
 =?us-ascii?Q?yYZ5wQdfl6ZPXU4lRKYW3sn1FCwsPX0070NwVQgjaPUq1amXhHTldKXKLs7q?=
 =?us-ascii?Q?nhHBJSgp2K7DcPqGZLFPDexgu7PmbETUCn6QI7AgJEEB+audGXikOVogQG5W?=
 =?us-ascii?Q?mp7LTG4Z9KPz4C79YqAgR6vqN74tuZ9Z5yuO5OS/c2Z/sfBy9s+2av9Jvjw0?=
 =?us-ascii?Q?mS6hu6w/C8pV0mSqr2BoDeF7X6HsoU4cGXnnjxnlz2s6ZuQ0TxUJ6xQ5+4QH?=
 =?us-ascii?Q?g39VLzCHeCdiPTMb6/Dr89xaMSzm6MiEMp76oCHi+XfCYN5134+zHN6oPDal?=
 =?us-ascii?Q?CJcuV2zJJxcds2ehxogRTRGZTB+YjpRQblNZBBpEqruEMK1lyLbIYIbPFCQC?=
 =?us-ascii?Q?TfI+DQDNnE6bcKd98A860/SI9+T74hi4tamI1jL4OksYKmy93+eNBfPqzOFI?=
 =?us-ascii?Q?t3fdueBLi9Skbq4XQ6HfjFf/AYweRQYBszppwW9Iv7rM0FnDvFkKxDksUxSo?=
 =?us-ascii?Q?uRJwL0+PstsMQRjb3jQYKcUoFOnRcnwnFmcRtXXMZ5QAKBNYK/p3j5/gUzg1?=
 =?us-ascii?Q?qeeVHnr3Q/mVczjDgGzHAsDM6RJe8PkikcXBCMWqEDFmAfFc+lpSSB1/U/4v?=
 =?us-ascii?Q?g0U+UR8O4g6ybIZU9HayhH0mL/MRsDZ5FvqsPvVaz4p5tpmiMwb1rE07PdyW?=
 =?us-ascii?Q?a66/VR5FI8zv/9Xm/cyAPSwztBjZzqDFJBowoBxeWthhEZ/2xlulKzQILLQg?=
 =?us-ascii?Q?NArqpUW/ZOnXIwxUKxKZqA5uh731MFKa1hJEQFnaVBEyTG9H9dS4HNgifxz8?=
 =?us-ascii?Q?YJPEWy6TvdSwpSh9cNSM3rOMmI9eDzG/AybySINwgwMHLYBH96+IvQsjxEk/?=
 =?us-ascii?Q?OztLb7aFyjVTf+DqQCbjwIIAbKMVehOjE7XGacMA6t2GadEdN+iBBUJqxR8N?=
 =?us-ascii?Q?fhNAd0J2hjjyeVKYd/bMIs6LFRmGT7OWxGSVxnxdz3oRUJQ4HJZ1s8xYZ/R+?=
 =?us-ascii?Q?/Wnx7kxj1nfJr2F2MQ0zz1E7sl6T2n4g/cpS8CRAhPBPXbNyCLwPDa3RO+0I?=
 =?us-ascii?Q?B/jF4GLbsbdWhK4RzOiOrpfpiWYKDd/0H7pSGbxKf4Wu1BipI36l3lncee8u?=
 =?us-ascii?Q?i/OFVSymLh3KuFWRR44=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851fa4aa-5164-4cec-1ed7-08dd50f42a9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:46:17.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwkB+aNI0Z1K6TLElT1kOPd2lkN1JXuWsWLbeHBKb/GRn/nghTRAordxjU6S0wJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

On Wed, Feb 19, 2025 at 03:52:05PM +0200, Leon Romanovsky wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> error code from rdma_lookup_get_uobject(). The IB uverbs API then
> translates this NULL to -EINVAL, masking the actual error and
> complicating debugging.

This may have been deliberate as this old stuff is not supposed to be
returning weird error codes.

What error code are you missing here?

Jason

