Return-Path: <linux-rdma+bounces-5238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6EE9910A1
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 22:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53FEB2CD7B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316771DD52B;
	Fri,  4 Oct 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/hRM0RB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681D1DD55C;
	Fri,  4 Oct 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072788; cv=fail; b=q6nCQgQDSSZyx3XGoGeZ1aN1gbDpv89+cwnXQox7z59m5mp5CICgHSRGRtUzpqtqlGiu/Y7zPp7KT4V13oRzRUEf4GWTBox/ELNfV2KGq2jWSDfJh+OMz525TsggKlZMtd/sXh0HIXtANJ1G+M+V5JXPHbSsWziQkspKGu3zMIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072788; c=relaxed/simple;
	bh=OS2vC9xfLLEvzlyR+gDvcWPexptRHeZM/fEt83dWkW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hTYrP9rbPTCeFkND7cYTm0A1DIj7c0KmIDi+b3sRJUAUJVPVoEgHVnpbCijIox+6dXCtpJG96jeTZ8K+ZnK+s9KqVLD3jlbdWLVnQTzSb/LpzTEuFZ2zV/lxXbxd5ewdy+Ll4LzRrApS0ssrHDasNxoapfJm80fvuEi3tBq6o+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/hRM0RB; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9bH9hqSc/YPch12uj/BGSZImkIO0lhg7qza9YCGkqubYeUD0sEVgAzpCX45T5NVIGzbgYNt+hWCZxtHcpmAVOk7FumJf72E+ATGjNZ+sfzXPldXGsU6PIStiQgamJDKbBsGczJU4fzlfuKrZdhK1LBKOLob3vB7NCtc/VMMQn2OUiebHepjUoiHIBJOqblzpaoDTpFiC1yB2SmaK+Yt2shBbgv1WSg462mv2ozG7Er6iXXMAsHeGMbx0ZLn27DqEvSell9TmOquZqL1z57guJ9IedPGoUXMBwAOiduuWqrsnj2ifvP9418LIffjqDy/+GROxgFHuj7Y9bmma7y3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Sh9YMEMp4hR07QSA4UuMpxhmcqJNcdjWNDgQnUHTBg=;
 b=VBEcW1Fd598BrqQbM4lsTk72xqnj72F79lS1vv01hT91wp3AwtX0RK5PXLflJ6m7paxkkMYRvq3B6mJtOJno3FK0/tTFam1EO37TiFNmUFneAjvzWz9IbtvMCM7dOZwKUgjOI/mlHP/zopCgO8KfAjGvLP4tpKjm22lYqIrgj8wOC6RJg4GzpmJegddsY8H/t4a0kOHbe/NdMeQozHlQ2w8aMlh8Ch5ivA5K3+YyU51+u9WUCpr08Bna3tTjB3pJoDXIQ67g9xcdN5NBYju74NUvCZEp7+PtWiWT8lC4RLuRqlN79d8zDmSxYqpkb2if2GGL/HZjGBtliXRrcmDlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Sh9YMEMp4hR07QSA4UuMpxhmcqJNcdjWNDgQnUHTBg=;
 b=s/hRM0RBMkkkKuWXm2ePJy3OO4txYZmmesPmBB2aLc1KREo894JeHD1ENlhtaQzbb3+O9K3tpZcuUfNjjluPr3K9CS/ZvnDKNWZuNwfHhF46LsnPzh6fAE22p6dRrETv8CEbP/sKF6IuOMwlPgEfxJ3SW0/KYNWq7wMJxHcxquYp/oettwERfz67jhlY13RKbR3vnPJUwGUqri19gBDxS7WanTdDKBZi85NCsVFxVlGEmyQSc7fCKLAIiqYf/qNpbJD68Ohz4PD5mB5+L5dKlNRXYk1QPIh+0xY/1rps3VFZgLuyAEgkahp01AHVikkJTLMbJd4Ufkm9zwsWhNlqEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 20:13:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 20:13:03 +0000
Date: Fri, 4 Oct 2024 17:13:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/nldev: Fix NULL pointer dereferences issue in
 rdma_nl_notify_event
Message-ID: <20241004201302.GA3317055@nvidia.com>
References: <20240926143402.70354-1-qianqiang.liu@163.com>
 <Zva71Yf3F94uxi5A@iZbp1asjb3cy8ks0srf007Z>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zva71Yf3F94uxi5A@iZbp1asjb3cy8ks0srf007Z>
X-ClientProxiedBy: BN0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:408:e7::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd22423-6787-441d-7582-08dce4b0f3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iqfvWaa1HOg7WqLbMtSvpv/coMt2LzJ5c73+VJrWyDTYwzc4jRT1AfE5s7Ed?=
 =?us-ascii?Q?gWyOIh1WcKdEZpewM8W8t+OEjRxDgq+2GjPJhsUgdFWwEioesHbrEMJr4TYE?=
 =?us-ascii?Q?dhA4/X8shoodYvB4JNF/FGIeYTTPb90YNxg0OpL3DzwDU44jvsg4zm/xfuKL?=
 =?us-ascii?Q?cm5C89RrFe4SZf6kDkVheguf/3EEdtrcV1aDTAFJGT0Yk/jegI6LxuMMED/t?=
 =?us-ascii?Q?5tGnCHq9shAN/aJ9dYhGrhAf1Sc3rfJWazx8qUmVkCmLKswBvrfPcPEeLRR0?=
 =?us-ascii?Q?NbIB77EzJa69GNjwBWUuVQs2McBGdYtNJHmwXlK1Npz9Ak5CINlZFDb96IAx?=
 =?us-ascii?Q?UabqI4D5ie+smILIEH2f1cy8ua220PBJoFfctUC9YiWwiqj2H8D+gbOTGxbY?=
 =?us-ascii?Q?76fiCDKAkdi495sDJXkMccQ6M2lhqlMypxx40gy/9AWTWMUevfuabwKw6KjA?=
 =?us-ascii?Q?ftetuAqGbM8HVxqsa1qbDNapTpizuD2fHu/K778gi+U+gDIKinBiHQODncB4?=
 =?us-ascii?Q?sNjLNPYhPkvNZ+aqtlIgX3GLRgSQ09WZm8SWamAYwyfU9aNrVU+z4sP5j23/?=
 =?us-ascii?Q?wbVPD5xswmge4EsMQ4kJDZAWBq5vp2HqwuvqOQcYdZbp1augpxSz6SIPQ5YS?=
 =?us-ascii?Q?6wIsUdh7uoDrXYsXcAVblSQDnagSfbnLERbkvEajuXhgqz7FTOd0kvpYnR3R?=
 =?us-ascii?Q?EKsRXyJX9yQK+gab6CYVAVJzFk0KufOWZGg+HA4zveCO7pJZyoTw45Z95UuY?=
 =?us-ascii?Q?RYont1UMCWJfk7LXY6QtPDxQUyX3Pk0Rh+7gMkoepwX8BaCP7uwbc7tSL7aL?=
 =?us-ascii?Q?WwcoAq6e0razWAbyqL3AkhO/L/D623nBDRASOk+FuXVi4T+jVb//aDWC6/k+?=
 =?us-ascii?Q?5k5ucbs9AEuM7GzLOmHbE0PMFEAbs/wniDM1xthTEZqCRmVCbZg/VP6Bug4N?=
 =?us-ascii?Q?vLPfpJUyGxkvnKh0UuY0w7rshuFVgz+krsmwXpEBkJkL6MI6NOzpydiejhlZ?=
 =?us-ascii?Q?ywTPICdp+ucN+xJ61O5l6UygOFJQGdmoa+F1TrlE6Yo/BLG9I8yp5NpLGN7a?=
 =?us-ascii?Q?oF7b++pVS2v8Xx7XKyNE0WYeHTdRNKw2SlLxE1Uvpp70MJXcIdM8ij30t+uZ?=
 =?us-ascii?Q?jmlgEewiW7gwhiDgpwgG2m+r72f1C2sr04jMuPJDbvfKc4g5zsBcKz7NDCWg?=
 =?us-ascii?Q?v6Ty9yI14TqOkXnUXZLkEmJtiYNkVwWDpuwTAV9BQnmZYV7ZgcCkD/C2vKOu?=
 =?us-ascii?Q?Q7E9hY6uMRfJkuEy1A/S8gCGMb6/lAqjxjg8IrVGmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1bCHJsYs82X7TH0s8tGuhbir6oobScBv/1L0uTxGUqWMN2SPN5mVgphBCTj?=
 =?us-ascii?Q?Ps/HDpnlgIzcjNxjbFhKN6nO+0zY8JtNy88/lagKUTQmG2JTLJ2Svcbis36Q?=
 =?us-ascii?Q?n9adQ4dJExV3WtGo0EaZNPi1cqyyqMsJUxreGGxkQWMH8pgfLt7rbhG9xZCp?=
 =?us-ascii?Q?/m/i3McCGJ1AuAbO5a+JwaO6hxw3ezw2D6Lj/EUyhPP8xJIYM4F+fzi8wE6F?=
 =?us-ascii?Q?qEF+wmrEjGOpBHnFQOjhMzqe94auzKk9RQFtwNh9YRlrrOP12WDR5R5fu5aR?=
 =?us-ascii?Q?BDRmYNNtpPE+1MkZISxFsKu50fcWh4ReXj1SqPrnoKLXxD+uvTUGb/gtFdNM?=
 =?us-ascii?Q?G4AyG+OtSzOjMBFoflHZXNQrShEzMaxD1IDLyk0Fps6mleIINQYV8vF7lLZ6?=
 =?us-ascii?Q?O1Db+b0UNZ6CpA0emDIfIcxBPaUKFsZUu+EoyUUYRPfWxHj/KsDZ/eDONLAM?=
 =?us-ascii?Q?rzX6KDbc/1igEDHTYOVONOMRK/ixdScEdxPzkM1VcKb8cptvJ7ghWia4divM?=
 =?us-ascii?Q?ie6XOyO6P5vza3fQxkv2Pg7SPkR8iPE32gd/TFnPm3I3MfzWo1MqDmVWyzBl?=
 =?us-ascii?Q?MLe/RnjZOGsAoYjiJnGkJ7THEStwJFcOZ7ABF143C84/w82Mo/eYRxU1a/W9?=
 =?us-ascii?Q?3wWmlstyd7+XOKq241RxSWOtl9GeIpwYGS7cVufUX408bZ50J0LnI8kJrFBq?=
 =?us-ascii?Q?XVTxuhMEOUFMEDibZdRCX+uwqKnuTLZkVioQL24HtS8FsKrq44JsIW0i65TC?=
 =?us-ascii?Q?kDgWMOXEpotHo56DEtcFc4rWxdjXerWkDNm5+aD6ew+chyxo6RNcBh8gyv8A?=
 =?us-ascii?Q?8QJRklIWFRh1Rp4AoHRdoPF9ATpafhOkbYMnTvUAVu1/8U4T4J7i7ygHOXFD?=
 =?us-ascii?Q?tg55juvdh5C9VU10O0JK4hYsFABHy/lTPnZw+w6l5qxuT0vm2QwE/v3xVC16?=
 =?us-ascii?Q?vKM1ct56+T7UFNce98O8oE5CZLI88hfVMdb8kJSBBAZK74byCAXKj67aJiXP?=
 =?us-ascii?Q?xrta3tHeEDkP8UhqISiqnFliIJobuSmtrBQD4vkjDMOaO4xgE1PfYy/Phjyt?=
 =?us-ascii?Q?HyxLqGNEqL8ZxeuYui9l+r7BvoVfmpxd8l9esxJUgTumMbw0FKYryQdPiYKX?=
 =?us-ascii?Q?NGI5Y3ug9ei+0fQHGsO/w7zxca+3RqKVntdomjk0Y0Hts75RKrWJKsxMS7MI?=
 =?us-ascii?Q?dbfFDBf1u6rrNTy0YZDfiixTji1WUhkGek7g9SbzBg0+kM0sXFmvdahsHb6e?=
 =?us-ascii?Q?wRmVLVUHxfPFCTAqfRGdD6pp0KA0x12LsFXHceE4sTDe4szXHgcR9ZlEarQ+?=
 =?us-ascii?Q?P2nYINebs9mCdV4YShst9/DOECaJG3OKVw1mJC3VgRrhdb3DvsXJ/T/TERgl?=
 =?us-ascii?Q?kcp6Dt15Hrn2qAw0FVX2H4xY0ILmrOdXq4hZRoHYfJyLMmYtnQD/d5IEjdHG?=
 =?us-ascii?Q?2t2WT8OBJM3xVBuXLs33fA3Wk+/zJgBIEYibu1abxTID762naKTsuEJG9c1g?=
 =?us-ascii?Q?3jeUkLqxuMZTXW2xfDAHERPLRnsysxZxkLuofK4+nrqvPndJboxJAq6kp28S?=
 =?us-ascii?Q?Kz98xF3MS02lKtc5J0I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd22423-6787-441d-7582-08dce4b0f3de
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:13:03.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYl/pZPGTNZ6zbp8J3Zh4G5Zw903V7OJpe8kAfSL6Q13U2gZllbPinDF2bUYpXMt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

On Fri, Sep 27, 2024 at 10:06:13PM +0800, Qianqiang Liu wrote:
> nlmsg_put() may return a NULL pointer assigned to nlh, which will later
> be dereferenced in nlmsg_end().
> 
> Fixes: 9cbed5aab5ae ("RDMA/nldev: Add support for RDMA monitoring")
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>  Changes since v1:
>  - Add Fixes tag
> ---
>  drivers/infiniband/core/nldev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 39f89a4b86498..7dc8e2ec62cc8 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -2816,6 +2816,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
>  	nlh = nlmsg_put(skb, 0, 0,
>  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
>  			0, 0);
> +	if (!nlh)
> +		goto err_free;

It doesn't look to me like nlmsg_put can fail in this usage, but we
should probbaly put the if to avoid getting static checkers warning on
it.

Applied to for-rc, thanks

Jason

