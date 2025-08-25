Return-Path: <linux-rdma+bounces-12911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E8B349AC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 20:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7921B246FE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2960301008;
	Mon, 25 Aug 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjV26qnx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D282FCBFF
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145073; cv=fail; b=iA2LLLb4pYKW6rCuiYXaBzNml/mW9immKlSYjmpq+D2mSgvHhxcXhMSI9xjGaSemPSC9Vefxo9Fev9yFeauM1zdzYVw/8+Sb308EYWgcdt9cXtiuyKLrWYoJL/XYYyiCzwYQyuTTide49RUqFygwKGTZIGWMjiyfzIgn/7d4Gl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145073; c=relaxed/simple;
	bh=gIBRoxU7I4aOBPq2SEIpo0iT5sz9/7qc6sjXPXkmX6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D00+Y64r49B1G2FllFU57pKQUdbtlqBHcAPSWWCM2grYUV1gd13Kmyz8BZxBy3VZ60rjGzFjVD7uRZ512owSJsOpP7IRs26x/smetzrLOo+IWX2J3ac7D0ylTE21U7M4g7Ko+kzqBdnPatBPxT2QlSyGSp9ODExXKwE+kXO9OHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjV26qnx; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdTK0VfnRprIkmvDWaXdv55NWrHm+iMa0xfGTF5MPBFRKj8XX3Nc4y5C0QqddCAH60z34C506CMxjIOCqCc+9UC7XjypgLXyRXRAx//c3Upw6O0QKyZTJjbbxYOidmCU+DqrMaf5QoY60Z0txcNELVqgPBYz1foRLwIo350zX9CkFKViJ6O414vNMnxio997FbhbHRSLwdjaS1UcbrmAjGtSuT31xVATrwj9oj2fSwe2Ez0Rp88vQ0A/RLLJXMu+sM1BQ8zuKyU78e3+p2UEduEFGUTj1XZ5VWKM0zkAToYntpY2SrMLC/j1nazlMZ9amDebFl5h3fHXqijCh1LgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohxmpioo+nnzwIVKFXsdygLWjhh+4H//A5objwsR3xo=;
 b=OxeDVUHe3e0SZpNB6PuOdOHuIu7rIZ7k+duOM6iQwJoZOR6qTbjxUZQVHx90cDVl71E9dBTlVe35+y3YLhVjLC9m+/XTdo1MPLNsmQ3k0WVqLsrO5tnLQ3x6mXoRgv2T2GBmiysGO5cpFWSZ6/yLREO7tLPkqzOvmzeG80/ZqxIBYqRRHxyALEqnzjRl/jPoV4mueh78Jv1SD24yhexLR6ukxPKLfZbG56tn+LJtdVpzC0vhjjzcfxGVBdn7bF/Qlqt+B2jL3dqh2TRUi5ONnOJ/EO7zBD3czhtBf3PghY7ASP9/eo7xyIpY/jbh1dzS4toqNh3jvJdGmC5WsdaZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohxmpioo+nnzwIVKFXsdygLWjhh+4H//A5objwsR3xo=;
 b=WjV26qnxuUs7aRLIoHtuVOH1+b2pylgbTJyVHcmwIexZj4UJ8Br9lraGWw9QmI+s0oezCzB0vzXfqcVQTtdW5CT/Ju8u/46aaQj8VK4Q7amfjNGewvGodVLaMNu0j1jIb3Pn1NJJ6mSLehWlYz9fzN0/KiXlYLcULgqFyKENh+ApIWnNmzxDLjU2vslo0Gcx1HZviamDfCrnpbpAr+yGzA9VwNhwktsXctg9bj4qMPUfB/oqchccbUxi7rKQRjnAjPcN/dLzgdPEqTX00uUedC9ycC7bpGhs5Q7zRReFOZAF7ZPw4GSvjpBypQLZqHDilc6MbFgX/2Xk+XiT6/VUvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:04:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 18:04:29 +0000
Date: Mon, 25 Aug 2025 15:04:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix vport loopback forcing for MPV
 device
Message-ID: <20250825180428.GC2083903@nvidia.com>
References: <cfc6b1f0f99f8100b087483cc14da6025317f901.1755088808.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc6b1f0f99f8100b087483cc14da6025317f901.1755088808.git.leon@kernel.org>
X-ClientProxiedBy: YTBP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 99922944-17c9-46e6-a0f1-08dde401d61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FnFedKDMwIZtaoKmk2ACg/jxLuqcs2W2L92pSSHp+35Pj5hP+zBH6/G3VEhq?=
 =?us-ascii?Q?HdPcCiVR1W8J35ECrM6h6jheeUGnRNi3Fjx0P5QRGFohvY6A5HGHZ1lxacP0?=
 =?us-ascii?Q?CeqIaV+3quqSPnN0Ya2QuQv6+hMT6PpGWNyx8rC4JCt3Ch+0mg5bUsPef3EA?=
 =?us-ascii?Q?9qvTM1Ixq/ICauLD6FRdosHVbFkOcCGe4KhM1ZnFc0NVuGT4UPDO27aoucmg?=
 =?us-ascii?Q?KfyHO9Lt0HRqaXGFfq97QmUWQd+oC6ejFNmPbYqeqB4CYEw9Mmi86UQnXLhc?=
 =?us-ascii?Q?Gl8BfiZuBq9WvgCOmPC3mT1tk81xTLxt7hq6YPe1zPqSmWDSpDdX6esIBozg?=
 =?us-ascii?Q?Wwjz5MW/geaREohp9Ckre3PMfo7gvGYaky4Z9K57T6ryuJ+kMarhEtH9FzVm?=
 =?us-ascii?Q?frXb/tbyBslNm799VumQ7+40u/BALCDwlJahPdYZ52QSRbrRcL2dEqeGM4AP?=
 =?us-ascii?Q?IU1C+JW1qT8LIT42CBngNCuwU7WBWVWN0UCCNylXpY2VtwJXbVn1XyfuapCG?=
 =?us-ascii?Q?aAVTkN5MXkxNt80sNlhHWSZYE5+p5GhzecWLE6Vq4yQkhYDYAeV9s2R0cwOC?=
 =?us-ascii?Q?FVJHnKLK2Ih9R0NhLGe4ttkqX/m4z0Z8EEPP8TXGW/vVzBfy2f2GV+Sg3IoM?=
 =?us-ascii?Q?X911rvmDyna7EVAxae0sie0J5Qf1DG5a2k7rUqCt5qZauxRts9AqUsSgvUue?=
 =?us-ascii?Q?XdZ6Rr2x4Hlf9MQf826KnkjelzdjtYz5XXF+CwroRt3x2lvWHKq0012b4XLG?=
 =?us-ascii?Q?yXaZWTKF+/e8wC5zRtHIXWTxjd9ldIUjZ/iGD5ZFC2yu/Vf9oDkVHlOd0Drm?=
 =?us-ascii?Q?g/4NH8ooC2kRIhcOJjwDFSxyPzbc1/F1MPy1aNMSbNMOd3f+146c+LKmaqAF?=
 =?us-ascii?Q?mwKj8zytqNSJWu6X2pL3We9o8v7Ltb1AcZn+Og2XSKIRIO8kF9HJJCrLtz9d?=
 =?us-ascii?Q?JRnTGUcHl1i70AGcktDtR+p/hac3Rl3tmCU/XdBRHTzH5Bi5nJMKhp/VoElH?=
 =?us-ascii?Q?+i6zKzPGZcQfZ/LPkNZX4aCx3MO0yRvBIZNWHWRWz9VPCHM2bgNU1Poz35Bw?=
 =?us-ascii?Q?xkTyqDZk5mY4PL4lxf/TtvLKVMKkhIHkQO1abT/hKtkd36wmKU6KG42p1HWT?=
 =?us-ascii?Q?OxedTBu1rptSh9aV6cXOHHnbIOfD7tXR5pEkrZck9/fSBL9Z6L5hSNHH40zu?=
 =?us-ascii?Q?7nxy9XSgh6lgag5ABBRbIuoYUQxpxuDnxKhnkRoYTgWRpS3c6PxngdLWQBPh?=
 =?us-ascii?Q?TBqnnpeCi044Mv3MPj6ji4H15Uh89TltGVDCgMRkJmhgAxbkh2dBhgCNWcca?=
 =?us-ascii?Q?phbGgQHEhR0eE7g49+0TyrV1pdk2prRijxoh1rwDEVcTW/YCNnrPHeUNQ5TT?=
 =?us-ascii?Q?L4xqV4yEWyEXBIz9035lT3whovQBc3ZPZUkYnDLx7jLlfk7t1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8zl5CuFuAAmv/Q46OoP9RRrj5JWtJDgAtRlibz/dgtEbkcIQ98FH0AJkdQQ?=
 =?us-ascii?Q?DI/htobsXKubrwgYQz7RlGqy389bgrZuqVcgeSBA9faM+Ud3Q6Ff2k4qLu+E?=
 =?us-ascii?Q?h+WcobzquQS07WC0Jj1Npt6czPQCCSPjZWboIrg4zfFEgrttCDeMoE8XlDC4?=
 =?us-ascii?Q?92yNGlPSsYjBP31Vk0HfuxrjffEmju/ObJIM+//mafOVqbG2xdtuRIojTW7C?=
 =?us-ascii?Q?8fIF6+yge/cK6ITIDJQSrsG0qOnAaCPsR7QofxIHPmLjfNkOgrIqlaLtc1NU?=
 =?us-ascii?Q?UyzaJlW08vWKWYtPHwAVNe14y74NoHdu/aaeMSd0eVHiKt5kYDjD6wqdz5U8?=
 =?us-ascii?Q?1XKrFdO38xJ8TzCABSiVUm6N2Scy8R3ag0qnpwwIoCXGWjO4lBzFpqC0DzWW?=
 =?us-ascii?Q?eGE9iFbjQ+hxhDYikm3wn8McV3Gbo64tgQlvwwWwVrAvnW9RESAmx1aFersC?=
 =?us-ascii?Q?x/VkVBHiagn83PPTJkWyYxO8iL/N0Wq4y1JSD4KC2a5SSVr/krYwMSWaaqku?=
 =?us-ascii?Q?gCaa3WuH/POWVHpHZAo2/zJFDRMkuDFOm/VoNx2rKd0y6UmFsj0Uw4NW1yT2?=
 =?us-ascii?Q?i0L9XZhjxaSmT/8ADxcrZcjj4XwnLbWprqV++0Q3JU6zySUEvT8Ymod13CLG?=
 =?us-ascii?Q?e4ExMkFx1mDwOO1gVY+2h8IgQK1kABXNP0kmZTFS+xDce0zsGuJvVL5wRFru?=
 =?us-ascii?Q?ztHeV9i+vTsouNV1cnKrB6AY1VIAVOXDLClSfJ8+hi0g5wu/Nm04QE5P7R1Q?=
 =?us-ascii?Q?9n07VYnjNHzha81JvU750GmM2M69HL9HJJk4LX12vvIIW/GEDVCMMhskya5c?=
 =?us-ascii?Q?ODCwzVFWSDX5buexsfOcWlg0hubqryaw/l2DgPXu8Dku+yoao/nc668u4vhO?=
 =?us-ascii?Q?D+p4/orINwEC+hoZ/6VJHJwOqv/gKjuP++6qcZexKOQeKhcXY5X48D1Q5kmf?=
 =?us-ascii?Q?PiIWxvm9w8iHVp0vABobIwEfNWoc2McMnGug7y9oRA9Xz32gjlhTUNUhdWP5?=
 =?us-ascii?Q?OrRmdHf9r5zfRTaCEqtXYy8y6BDc14jaLyCavkY8uc1tVhBlXaei+8T5Dh9Z?=
 =?us-ascii?Q?2bDs4paDkBQ56L6om/XJq42bjAeLJaqf3du3xDVovGZSBAQKqUdYjWhT34mM?=
 =?us-ascii?Q?g2Sykqzz2DxWv7NoKlc1dSd67FEWd2Cvjh5DuLDQXe2IUuZEY0ofcAm0CdYe?=
 =?us-ascii?Q?Vf4LUHHHx1o1e4kJ5DH7Br0x7JDz6Nwpkeh70uPxpm0gQp5G28uGQeAKwtuJ?=
 =?us-ascii?Q?RGt+1LFuEftzek7qcwmjoh0FhTwyVLtM0lgcnJZIx6l78j0R1Ft+Os/NYuOT?=
 =?us-ascii?Q?/rsBoQaznPHwInObopEGiIh6zGM5yy5P5eyzwec6VMpQVDesVQA/hS2TfpFT?=
 =?us-ascii?Q?QYQ6yxdeSoGMAcZaSsrleoDpmCbz0xuVa8mArZKnQ9BqOlZcXdVj/NU54sMA?=
 =?us-ascii?Q?aPxv8i4N9hAymkRuLpOHtYUHB8RjJHiFfW7wrhfuCkX9+ivGckJNDeB/ghP0?=
 =?us-ascii?Q?in2CtAfV2baLUPgynkHwcrY4Aj42FEzIR/Z3T3krWOpL63gruFdliOFBfd6D?=
 =?us-ascii?Q?cGqbDcBOPVmLKtMJ9P0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99922944-17c9-46e6-a0f1-08dde401d61e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:04:29.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq1sbpGTEX5sdptgA/vAmn4Kbr2JFfyhLhtP/iN1sN2PU1nqCahtdrD1W4z5G2JA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766

On Wed, Aug 13, 2025 at 03:41:19PM +0300, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Previously loopback for MPV was supposed to be permanently enabled,
> however other driver flows were able to over-ride that configuration
> and disable it.
> 
> Add force_lb parameter that indicates that loopback should always be
> enabled which prevents all other driver flows from disabling it.
> 
> Fixes: a9a9e68954f2 ("RDMA/mlx5: Fix vport loopback for MPV device")
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 19 +++++++++++++++----
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason

