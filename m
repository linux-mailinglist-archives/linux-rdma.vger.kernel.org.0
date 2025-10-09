Return-Path: <linux-rdma+bounces-13809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A6BCA847
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Oct 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E12A3AC330
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Oct 2025 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877A24BD03;
	Thu,  9 Oct 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQ3CwU9X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C024C076
	for <linux-rdma@vger.kernel.org>; Thu,  9 Oct 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032978; cv=fail; b=TsmAk3/jAnvYVh3dbJMfbzTdY5wXwz3yWvl1paibhLdubhS69cZxW87rbh+0C8OeEDFHZFUfXhtZuoSxkv8Ob/8r3ysWFEQUhaJCrbg870ueWSC/cOzEN5BIXMq0gRR+xOzgrxiTe36mqlKIYFhwDDrzMHpxEdJ8RqXGRw7eXMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032978; c=relaxed/simple;
	bh=DvnkYYT6qa8sVqy82WSqfqVz1SdeIJ6cNHZgTYBbUPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbcUhjvzHJYwUJv9uOfTyiHf8E82LigmAO3D1ry+W9dw7fds5NG4CU7I4kOyEawnXp34nWna12FT50poRjWPlftPsQSl7+zHk6bO++kkke0Lav77iO+dM3xaPUP8cy9UjF/l02mOAuzQ8toehtClWyouaXaVPOq5g9TxsRPGV6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQ3CwU9X; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxQLbgZumgjnNT0msgRwNt6lDw8z0qCC9B2xCy6j5RBR3Bkag+FwrS/+vE6FT+tWM3bP69BMOAi2n8sS5ocguK2rBc3W04qNOTNEKF4dQGaKOh9W/eWqfy2MKDKRfBAsGLVHAKFmyqrFcPWvgJ7OHEgn42Z7eq7X9MJ4uk0snycYCSkQ7vYwRhgngjr6j7jXqZDtx6AdGaxjcbkvfs081uUMheCkxeuDErSQRK3yrDgTna5lbXuOzzmaPlrkkgdqQNZTwkhG1q/a5WZ+QvJtLi+xa8gcpu3t97XQbOX/wxop3DMiPdvfAIdTnouanFnJZ2Aflr7AyV1BUTC7EBZurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwNvdV8LP8Ob30Y+yCPxuIi+M5EZB4H5alg5RStfchg=;
 b=aHNEW7e7IFvXZRmz2+qBzzTH1LVUr0/u1/KBRzGoiQDTnAWDcKXOb58akFZ69Hd9HzGwn3AIYyfSMllg9nJDt75g93OCgXPSGCjhwWHSf1t1qBCujgqmISTpuq/7gbS5FQnEUsDMSrRZjYvcefe1EkkL9uLLlZ0eXSVmUXKLJK2ca4zVLNsgMRDheSE6/LqHOs7EPkhqJDks1Z8M4L+ljIm1dxIAlKQugyLFSrr1rmqc916g3oM7knLdBUVh+2/7EHGQ0frt9vMx2DP/FkyvTpyZ/zkB1sRv2+ZLGYEvDNG1Er/NI0VbdGmK/HMJIp7RpsYj/3VPHMDCyK0kCGuCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwNvdV8LP8Ob30Y+yCPxuIi+M5EZB4H5alg5RStfchg=;
 b=tQ3CwU9XWkUZBt33u9HtIWCc09Y+wN4P8vJs2R5Ozx/sC639GQDuC/KWKqRTlajjFfmdDVKpi9ttcvEEcp/tgeBPURuokQA65dykhAs7b97xHXKy0XTsVbs8Y6CbeTiqRCuSnVkF1nv4MaqeKQC8ipGyk9CjDA0YXt4UCBvrLZqr0FUY0ld/ZM1tP7hCSoQD7u3mn/aJQA60z52toMZ5/t8IEGUo900KoM3cBRlJk83OxHQD9AiXQ0ywqihCl/zAIEl16D0rSSAv4d065NczgVgL+18q0O1RRzIb7i9InIwUiU9py/fxbhfD8nAp+rxFufBvH5qd2QECli12udqlpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 18:02:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 18:02:46 +0000
Date: Thu, 9 Oct 2025 15:02:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jian Wen <wenjianhn@gmail.com>
Cc: leonro@nvidia.com, Jian Wen <wenjian1@xiaomi.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise
 Link Down
Message-ID: <20251009180244.GC3899236@nvidia.com>
References: <20251009142326.3794769-1-wenjian1@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009142326.3794769-1-wenjian1@xiaomi.com>
X-ClientProxiedBy: BLAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:32b::8) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 8292df7c-6c89-4572-d19e-08de075e0ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdHSlSMtpLptp3ZbTOgCgbKwV+xGWx2yoBQ5BnOYmyy4FhqnCYFdvY3hhXV3?=
 =?us-ascii?Q?Hqn0YsCCQ8Fu0uPnR2guZzI2nt08A4TcGzd40EwuE4OFUZCfQiHKqirBW+Fi?=
 =?us-ascii?Q?9JgKwhxsurffGBnGDi0g8AVvliA6F+EpjMGpwc/UGkNlald0l446S/mpdXEL?=
 =?us-ascii?Q?55K/itW7GJTHLFraLqi7YH8CQ145mXr63OKBOdbUC+5jpIw/iWixBgqDM6+X?=
 =?us-ascii?Q?wnZsL0sjCxXIWh0w7XZrqjs1/zpLvfZr9YUk/HHeb33QxmGH30r9nyJBtoaC?=
 =?us-ascii?Q?qeOfssemTHhTwWkU5VsJ3+lRG7+rO1wbb1qNA/0JNmFvhMCDNAdExxRJkH/m?=
 =?us-ascii?Q?JpFzlPnOhEWascEqSvw4CR8+UTCZp8yioBRGspWWJcLUHF7EtWBAwRyIpyzO?=
 =?us-ascii?Q?tSwudTRd3y3nXGgzqj2Vf+tj1SZBnDi0lBCnvEJp5GiDVKFcOph1ja45Auwl?=
 =?us-ascii?Q?hOW2cbhM1oyXR7Zf0YKA95sV2zIBUz7PRm9LFkitTefYpB98YorAmxyjWFOb?=
 =?us-ascii?Q?g5JiRUxZlYm+77UEfAQEkPGGunfVKXB5Lql2/t2SavVgKr79O070yvzAOPuk?=
 =?us-ascii?Q?d5wET4HDGD3qbo6gvffN2/3sLXWSZTOg2XQEjhtNouXNUJ7iBV+snlfnPYIC?=
 =?us-ascii?Q?C1vX0DPTeT5Owk5vbSoZrt72q5UjBo98feMrcFRkoiMT2JeUsVVaO37xFNzU?=
 =?us-ascii?Q?+L4lKn3TlkWkGRHApNum4YJfe+CPQjXpn9EMsZnWOz+lvw0V0/rsTO4Dtk2A?=
 =?us-ascii?Q?NCPyQvIWqg/sDix0q+7dK5mVXpuEcMd6u9rI3NR6PW8cTdw0o0qfL1el0V+S?=
 =?us-ascii?Q?Jczm+xbVLLNUcYnFR3O5nTL01wJ9o9FXZA+98kgUEKYVSLzixcC/wdfrp2V9?=
 =?us-ascii?Q?+U/wcZaRhloW2AVeTK7mPs7keBUtA9v5QM52/V592FmdQvWvLOAKs8/YDdnY?=
 =?us-ascii?Q?oiidJWQpR18NatV5nNsN9VPW0qattoW3zPk9JQI5UF4EJ03tkPKP2RvA3dcQ?=
 =?us-ascii?Q?OjRmiqXJnaPUT9MYcORqh4kinJ91RdeXlg9M22iSvFZ74g7fvvByhjbxIgrt?=
 =?us-ascii?Q?x6k4gZrEOlHn2H0751F/mR6Zkob11THtj03SLWb32jm818ytpqP2j38G9RVg?=
 =?us-ascii?Q?t79K/qDCDg6ZWPh00qeQKP/3Oz7oeO2UXvKMu1c3TwSlu8qDIIJfCNVzhsD0?=
 =?us-ascii?Q?tBTlMmL59pGg2jewQdWZlWel+vlWt4RTgAHWO5QpWPFmjVKtaEnSnkleXWWh?=
 =?us-ascii?Q?tLC13O/Fi17hQF96mOa3d1rRg8bpnWm9isBlbWCTLzADrRAkTKIXihIMQ62w?=
 =?us-ascii?Q?zPIwoBTdE2JrJJQ6CcbT9le0MRJCIQKgbLp6lWIOvdFx0TCpPlDdLDnU/bcW?=
 =?us-ascii?Q?SGWtYu4egeHTqLaEZNr/0ybLHLew5ZOe5xfkMc92MwMb8oapRlg52VheIY7r?=
 =?us-ascii?Q?PxF0ejxDa4ItEg7k6kk6m+/bCmMgP67Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqVYdr8BexlGFSZD2RNFZp0+JJzLlRyLahJFaLlgI5YYT+915UJvtyxf0aIz?=
 =?us-ascii?Q?gP2re1E4jLFQfbNjaMSo+HsYWIe1uRFSczzGluWe4KdneyS/uL0Ip/sYYTVz?=
 =?us-ascii?Q?AIV3SOI6W4hQd3/iLbOrw2jFFOLv1YljA4SUQVj3Gh0HQRY4objJa+WRBwbW?=
 =?us-ascii?Q?hUwY4rsE+eey0HJki0iTo9m27mqwcMGF4U/k30CDKNVCGx8tmUY3wzr20D7d?=
 =?us-ascii?Q?RRBrtopy0gwy4TWeDwYF7Co3aX1hRT9XRkS8ioqUMfJMUdavsTwdtAEdEMoO?=
 =?us-ascii?Q?Dh8MiuY0kz1ERsJZBUbkcz+9siIG246ErpUDhV3Hj3Pwz7ey1x8XLYQ/qr1o?=
 =?us-ascii?Q?VeM+LhkYEiNhIMgc1aXB5k86+2mb9BygtruKlB4nTflYraflsqlyJ6Z8Cr7W?=
 =?us-ascii?Q?Xz3yBrWISnYK0ofGltGdNbpH+Temb0cbz8Lci33rjJ7I1bq3pk1/4G44hgq6?=
 =?us-ascii?Q?ZGvRpQ3zvAWlmRH9ydC1cVqAmWdUN/9OY8uZ5dAABA0c+5nh7rjXiWhfsMc1?=
 =?us-ascii?Q?x2P2Gc7oAeR2IbHIiVGhxN63Ygd2AEWRyt9z3OccvzFX+H+Ytsb16PbLFNyJ?=
 =?us-ascii?Q?T6nkqOwyfa6v2YH3KpqJhTRgu44fomEaTUKvAevp4gJQWirOeLUdTF3fdW+d?=
 =?us-ascii?Q?LTGPPrdoCiaJktzWLPX9S3Y6RY2SEYV/LtXyfj0YF6IufhrnWP2vw9C+lrOW?=
 =?us-ascii?Q?rL4LnzKvc77lMWjd61uYnrq3PeFc7kF74jz5g4SKxMo59iLZQ4B/p87MUxCe?=
 =?us-ascii?Q?38J+riYuNq+van7fR8DeFlJ6GlUP3LoosyVV+vVyjFqXvYwQrSRCf/a4DEYM?=
 =?us-ascii?Q?WPM5elNFxSZ/knAhuDs4dhD6nsEVsK9qw9G1lJldw1Dxgslli3o5SBsj9/oc?=
 =?us-ascii?Q?nui0aEGp23qLpZrKsG1x8X96Wf/DhES55BAKv4TccdzJg91Z3LqANc01So18?=
 =?us-ascii?Q?SZl0BmBjWCR9l9UicP76VLhN99GcSFuJzZxKUYf2wTEPdhwXwqNvgA7gp92C?=
 =?us-ascii?Q?p9wo6lc/BwDJ/Fx636zYpv0x8jiYn/6gKy61IYVzfhpZl3gT0jach3ioc3Kr?=
 =?us-ascii?Q?wHTyLQqOObacSG7yRBhK7Jti/MsBEyqeoD4aRRZ4N/fbPldtxqaTM2SNSBek?=
 =?us-ascii?Q?4h6S02hjOSHpnUQZks+ZUFCcnqc6g32A/aYzep0WGnTlQZ+cmy2i0IDUUPC3?=
 =?us-ascii?Q?fHXYA6PS6j1fmwKSSdyA38cI+SoZPwJLKaY47rXsmfqRWqGrDndbfygOLhfq?=
 =?us-ascii?Q?cwSWdp8VB3jaTEx7lv9Pf6S2obm7dS9IncTaOY7GWuUVU/yEwJNQyEvEbvux?=
 =?us-ascii?Q?CY6rhNM8TOWRGE54t6WXcDOlC+53dHAR8WxVv9mycJH5Pyxe4SIKZq4k8wWx?=
 =?us-ascii?Q?kbqoKL+VdUUonoT6AoJu2h/Nq33opP/iV7ggQD+wVghHulkVbTp/SZy/zbxO?=
 =?us-ascii?Q?rZaCtHxmq89PjaegAL+KkC5/MWq0Tdqyu2Y/Bv6UCA8gxb194/7J1fmFfgp2?=
 =?us-ascii?Q?jjkTn8s/nvUNmrfR6xQ0iYfcZ6Z6Dfv5iV2p7mwZwMgxKPPHA3+y5l+5sEq9?=
 =?us-ascii?Q?3wuSfrKuu57gVNqO+ADCS722h7so9o7nuvKkyEF+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8292df7c-6c89-4572-d19e-08de075e0ce9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:02:45.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNo5uFZ77pfL6lLUgYQaUo4veh8Cgc2eRIellXBr9Y/UKfhzxuS+yGD9xljNG5CH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

On Thu, Oct 09, 2025 at 10:23:20PM +0800, Jian Wen wrote:
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -254,7 +254,7 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
>  	unsigned int idx;
>  	int size, err;
>  
> -	if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
> +	if (unlikely(mlx5_cmd_is_down(mdev)))
>  		return -EIO;

I feel like this is just changing the race around..

The removal flow for the device is different if the HW is working than
if it isn't.

If it isn't working then the removal should disable and cancel all the
UMRs, using the umrc->lock. Otherwise there will be dead threads
floating around. It should also be setting
MLX5_DEVICE_STATE_INTERNAL_ERROR way at the start of removal.

So IDK, maybe check mlx5_cmd_is_down() and trigger the flow to
activate INTERNAL_ERROR befor doing anything else?

Jason

