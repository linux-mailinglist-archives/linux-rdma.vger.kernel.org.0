Return-Path: <linux-rdma+bounces-11408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF92ADDAD4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21E6403EF8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC202ECEB2;
	Tue, 17 Jun 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R5yr3vu5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC482ECEA3
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182089; cv=fail; b=FRPvL++e1xJ+GtoDIiY+AcZjg0AapIkVkubrdwuezi9QJ2gvuUPXuNZlBFXELK6DtG0okPnZvHHChW1/yD1C3uxQwIkk5AsPNv8ay3bF0Sj8qUN9YcpATYDFFphnN9cpYSYE0aNvQwo51cqmCCFfTHKLiIym/Bqv1PakYPPPznE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182089; c=relaxed/simple;
	bh=35ZBcepIKGhOc8IOtEfoK/1VGXXQS1Cc0NzlHI7ntJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s9K47dphbIWUdM6QIOv30mCIQz/1MixDzuk8Ugvtxk5sJQgSTyLkrYxuWmlm6kKNYFGJ5e7EKLUWBZQjYHFAhjYf3wWOUaRVSjArCThIAJ5Zb/WRIFcwlgGtcmHxygZ9mfTg2j1vXope57USA0lEF0ZSNW6sfvG5qnyQqGfhvng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R5yr3vu5; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftj5QNvxWUcoywW5C00F9dYvVE7Xu+uvw5KITtzK/PcCWGvUJUL0ondhI+YZKNzGs3HczLHsWu69eWkYhksdlN6WI7cMNFBi1WrzbIxM0yWiWhNrC+2phS4jVP2J+g+GGuoaM/nicgne5L87DAP4G+zlqFj+tvt6/FXBJZAIW9q3SeOPzA6NlaFFvcV6aLqGqIaDcEVBjznyzhNGdE9PjGMuHOBgyc+F8wEZjpg12S+PMu1iN3Zsg0HIpiPz8HtyQtYHTbTOSwfiCOqaNq3Ep5MpXAd/nEE7Rxwkn1pcIwr+GQUQEN4/UQvqxtdgBx7gygxb1dE1yusbYWQd5W90Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4h6wGSBnfoIiTgBytYmsMXy3dLusLzE1xmvNBKviEY=;
 b=KyV+Y4WsLpj47q/Oes7Vvo8pp9wgTXlJObrMbosO60gOme8zYhZyjptbUydtMWKJGKjvITp/2mks8r0Z1OdoNRBwLVTyBMh/OV8qj30ZuARiNdoAi/D0IcN/NLqoJ4DT9lzsYHm4+CazNag5RiSLUK73OvJGKgSxlbXJux2w+6g2ZvnwP5m1Ua3YnVG2BmjwTn8ALzIuNCNGAMGIOimR8LVLPzJGrPZpaS7dkmvutZxXXlO5tsooyz8adDQZSDdAytILco6pZLp3e83ohWoeyLr8b9DNpUfSuFr4CZPjtlrCNxBoAKxszY4a4gmJaPBJUCAIhQtc6qczMhM2FqWHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4h6wGSBnfoIiTgBytYmsMXy3dLusLzE1xmvNBKviEY=;
 b=R5yr3vu5Iy2uQod9aSI713V7ETz0RXgS0MxvQQQuncOAAVM7T8r2M2558pa7cnYwE5hd4fmzZhEnJDArw7LCcD9Co989FvuddNbVgoC88IO21c4HMDkVcS8njb8UsIUT628GMGfrF6t0vj1iONR59HC/n7ZNvFdGO9kPMTXkLSiGHMWjkR8NfUT0z8ev0B3cw7UBzp2JTze44PUGYC76pSUz5siUklH9AtkY5/7vYN0I66I5Plk/grHOkfVgjGin/LcQ8IBG0IC1miH8ios14+eMDY3dEUKcv5d7Q7VEW3MtbVaYKbyird/VgV8c9Tk8bMbJt9rdMs4AV3SuzQFhxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 17:41:25 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 17:41:25 +0000
Date: Tue, 17 Jun 2025 14:41:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Initialize obj_event->obj_sub_list
 before xa_insert
Message-ID: <20250617174123.GC1569186@nvidia.com>
References: <3ce7f20e0d1a03dc7de6e57494ec4b8eaf1f05c2.1750147949.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce7f20e0d1a03dc7de6e57494ec4b8eaf1f05c2.1750147949.git.leon@kernel.org>
X-ClientProxiedBy: BL6PEPF0001641C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c463a2-dddf-40bb-efcd-08ddadc62e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RChlGDSCg7oHfe9UWWzKbWNmW+l/FqIkUA6v/A0/BTmV9jJ7nbRZC6GewQ9f?=
 =?us-ascii?Q?RzwfglqCmXI/jdt/wepQ1f8V0jxQCzrJfmSwl/FaC5lo3Y8Kg33455RaicnL?=
 =?us-ascii?Q?af8FzHDDbxMXg9bZ8Yb0UI3WAQw623Ncihypab6Jw1OWbmowmyS3Lk1BDLeR?=
 =?us-ascii?Q?jLktK2XsokAaqgXLCbIRnzAzom8k0EDU6WGoiNdfNg/eM88blKV//3pWkxFq?=
 =?us-ascii?Q?6fj2ymHtc++WwoA/63fCF8xwK4sbMIOtClKHlGeH0AmMh4sSBoXaexKu6CO7?=
 =?us-ascii?Q?XqobGBIpvwP55XeOqjgeyeT/lw1BZ+pilZEDqjQhLITiNaQM91bONk+PMaH/?=
 =?us-ascii?Q?40edBFz/EobeDzcMHYFXEZF5oSrXFBMGp4QBoN1Lz93Tjo5B7YEe6LGkPHJk?=
 =?us-ascii?Q?capaLKz8lUpwC5qU/NX8S8+EfPlUNCEf/WJQiBTTKoC7pLiIKyo5Lu/xFx/J?=
 =?us-ascii?Q?hHg+bqM0sutF60YonDRlwVEhRGGTGuI4bkIRFuQ7YiLeWsWZHf0Efs30oNQ1?=
 =?us-ascii?Q?I6OoAy65gA7/JD+IQROB8yp953BIMlr6+i2Dunh9Yye7fA1UKkQDIMdju9g8?=
 =?us-ascii?Q?JpdRk6Y57ZM6kRrLRR7Oc8A5DGOrf5YybLkNJUP8XJAaSsrM0cG0aG+x0OPO?=
 =?us-ascii?Q?0sfNqyO+mWz7lceqrf2udM8ttOO27TbIydQpYO0eo/0RxV73QeBW5d3fcT9b?=
 =?us-ascii?Q?Ad+IR07E7bQ1tgiSx28Qk8bROy/zociVqivWUqrCc7LXGWpi9w0zhvlFGkOL?=
 =?us-ascii?Q?lYEB/fz4O2aYi9fOSK0NKl3No3SlLUOD0HPCRxme6+4M/Ds2/vpClIU/obM9?=
 =?us-ascii?Q?jcplvlZbBpqK0p1VQyy+uh5+Frd/Oo8q2oOOvutJpyTDWFsYinOX/iNLaQBS?=
 =?us-ascii?Q?jzW30hDcsLDoSntXE3/NA+iCFt/2hk1k0jDX8jUveOMUDrAiiBaIzY1alBjp?=
 =?us-ascii?Q?PIL3cRcGmU+Sc0Vgp4N1lGPk/6zqa6ptzATw4mTdQicYqPzx2ah7aFvhrGAH?=
 =?us-ascii?Q?FALXKlOQ/vymamLU+qo8EffdBLhdMb7UA1K/iChkvNsjoLFGvDVfNsID7KLy?=
 =?us-ascii?Q?2hPiHs9lnMo4hj6K1iciQ+8DtD0sPyVbcrWXXKAml30wrGcHOWDH9xhm+2Ij?=
 =?us-ascii?Q?K1ezn45psnpghgaTLjffla+ZGp2PIiIk4ii/VGAG4aTu8NaRjLo5iLhFfxsv?=
 =?us-ascii?Q?Fsk77hNF/a9IGe96pAeCF2SLbcddni+FRLP064qPbVuckIA3yC7sYOUBvNNM?=
 =?us-ascii?Q?FHVL4k8kKWdmp1EHmUgXKoyk0t1jfrfnUXHnBfIKlfDMQ9Otbw12pPcV+Y5b?=
 =?us-ascii?Q?raYUwxZ0ZY52aCkjDaD1x36bZrYau+GZUkn9McEC2jz/EG5O07IbzHHUAyHF?=
 =?us-ascii?Q?+Y/l/d/W9TBrsq1mxdqMITgECDYylegk2Hfu/92orphca7kZT7jWEn2LDQPS?=
 =?us-ascii?Q?OIa5nOabo/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIMlqKvEynIKg8aj4LdjpYSOqLnjw0lsSm4mJQmVASRjlueYbGrA3A4TlQII?=
 =?us-ascii?Q?65CPnfque+i6GSXImHsfBww3jmeWsaK1MvW79dQU43Az9BGlI7Frngl4mka2?=
 =?us-ascii?Q?ArUZOgL7lMtE0649cOtkqWr+Xf8m9kMJqBjicISJg287IHqHj1np+1qnnZ21?=
 =?us-ascii?Q?L6ZRivOiHvH1+USbgjjFzqYJpb7nZS8znmb2An+Y3LsZGfj3vGH+XEvRrSES?=
 =?us-ascii?Q?62si/HoaWoemkcy0NiIvLcytoU2rmy/LQsf1uRgbIwfqeKAXp2hEPpAnrxjD?=
 =?us-ascii?Q?w1LVND+SyHLXyjbIXmhBegQiQZ663zw/UCDYGTywXAYVDQsS+c6RZ4SiTb2P?=
 =?us-ascii?Q?58o+gNqwI3bKl/ViQ5G6gD3v8KxgKbmjtOUFaOcJJfM0Kpoj4R39PuKfHKUm?=
 =?us-ascii?Q?piB+pR7kKPsF/zFd44/4nUvaUs9oJTQNF6FidvkMptFESUiA6y3cRdrFoOXA?=
 =?us-ascii?Q?HFkTjnkVTPQX0HV2Mj0sbDHwGNLquL9Z5cbbb45Gt/gPlwo4U5WXZ1DiJsAJ?=
 =?us-ascii?Q?JCUjQVYVNyy85/66rRMOYWMMeRNpfAu7vFuD8CTYUXCBfxWyUGLeKGKTXwb7?=
 =?us-ascii?Q?HC2BGrfzN5sojxZwqTvOSSK1mHZluOxpEkJkhHZhuOy1wlUPRvxY/t2A+wv5?=
 =?us-ascii?Q?pbKZ5gEluv4a+6k56Ji5iiykOXKAS3QeBkRD/pwJOyerop8oHUbuHoOhwH5V?=
 =?us-ascii?Q?EfYrRmwOipMDsDDYryoJF12vLjsaMXL9uPtf87l+FPpBYOiSYIck1Oan03Gr?=
 =?us-ascii?Q?QqYiKWX2imJZP5b2asippVzR8Mkhf8XJ//5QFK0t0AhrmM97DYZYgq7guIOv?=
 =?us-ascii?Q?xzrSFk+2Fw2Fyk2dslL/DquwWvrVdWUxzJPQtRpSB5/1D5RfSZvxpzNejiqV?=
 =?us-ascii?Q?Stt7Bzq1HSFMKWITGi9skJmgA21tCWEZuM0NbOs1JGg8JvjGf8/lo1Slv9qY?=
 =?us-ascii?Q?yilgIBHHfzTQTaM6Kp/ehCF+1XmISiiHMsQRwbMJ4qhrqJc3bYSu6qC2PWey?=
 =?us-ascii?Q?VYsq2KPtZg/ndEuywAkGwtAE/sliQlO9doIVMSvliSpWkhW9BxTG5jR3MMS6?=
 =?us-ascii?Q?IzDD7e9km/GtusKW+SRzaqXpMNq8Sofo7G0ZawmcvlwMEqr9vdKus0yAsZnn?=
 =?us-ascii?Q?WkCFZZl0vJIL5nxoCZ26n+p7oo25MVDaTFzYU3sC6qFd3vwKru9Oc/LZZCAf?=
 =?us-ascii?Q?epXjeimWfXp9w8T5GGMTI7SxhCYN0raM/TsrLM5AfgsmpLQZ2sZg9UBqunGq?=
 =?us-ascii?Q?r7xOKJkPCS8G6dNeDnRoKrFlK8Fs8h5yrMoTbqgLRSCnviUdoAMNzssXU9nk?=
 =?us-ascii?Q?GTMqTr6g02ctW1Dv3ePGv5P5jwR9/y9tfpa/ObuUm3iP2IAiGPd996CKfSiO?=
 =?us-ascii?Q?L6pAnT3VroXvjNz0WoKIgOQYZjJp5j2JfV2a29ePpn3A+1weVTEEjlgRkO39?=
 =?us-ascii?Q?GjEvHtLYIDUoo0QMKevFMaANgWQKvGuZR5JB3yrtINZ7BHzV+pJcWEkVu7Tb?=
 =?us-ascii?Q?kVpntp+0XdnhxrNb/CfH8IC6rBwFhhcoEBNXpHsxTtk8YCRqbaj7EEGCLQV6?=
 =?us-ascii?Q?K4YpB9pFAOlu3nHw1SvbMYnwaR4yXzhzJqRrRLll?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c463a2-dddf-40bb-efcd-08ddadc62e40
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:41:25.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDrU/aeF2pURSgRhFli0VPfuVjJah/s5+ixaM9BXSgxh23WK5ZROns4LncWRaK/X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Tue, Jun 17, 2025 at 11:13:55AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> The obj_event may be loaded immediately after inserted, then if the
> list_head is not initialized then we may get a poisonous pointer.
> This fixes the crash below:

> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc thanks

Jason

