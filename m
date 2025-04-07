Return-Path: <linux-rdma+bounces-9185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D4A7E03A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4330B164151
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AD19D060;
	Mon,  7 Apr 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIGK9Nu1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491B186E2E
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034053; cv=fail; b=iNo1KoPxHgJb2Hnek2CNLHqWP9VIEggP8vN326jmSNLq5fQcEOTrgkbAcO77uMzKz11BV6c/TkgRbsUtRWfvqawCM2Vsmm3i4SMaaaQWpnSwif6GWjjWqpEXeem6AJxfY58BSWxay+vPJCXcIKz315O0o3yXvGjQ29KL3y9zsiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034053; c=relaxed/simple;
	bh=HVSKI4fM9N08NBRR9gC4JrfQoCRASDEPOcCtVrNEtJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DseShBOVicPTDcigS8iePtgUXfxWGKzqz3mUhLndcFk/631wh7fVbk/J4tExdLz0kPe6FYuDTaYM5ixU3/2A6v8/PbMPFLXLhphirEsR8nR/N2LwuYN58XlphnbOsA2Ld8kUG4+HpKMiu9EvMo7yl08qeCFx9NJhP1fqGU4NfVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIGK9Nu1; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlOoQwvvuxEW8TQiOCQ0Btyvjh2YAieCDj5Il6LyCNeQSRriiGDdG2F5Rtd3MjtpSCEFyTXlowlDXvMg8wOomp2WpYES+bpJIeX4K48B4kdLVFocjiPWVwWI9zadS05ovLGkZ9ProdwMfiCJ3IcqfqeowFwvryRULNMKmJK0BTj7NxI8FIPqIrZHSRgB2wFlwU6awMlzGnv3iS94EZVsWV/LpL9l05x8NYMUhIuxrlIZJugcoIlsY5sEOQhWCrnEFyqBerPnmIUE95ziOMOblIw/eDr2x9FUOW95O2KeDjcuueff0oPmXxjAGz0uMkumj3l8FOXtkUpM0Cc+rk8D4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIfSAbWEYR/NIaFGGo1b2p4klQ+Y7jNXHJQ3EwSOMts=;
 b=nJDhHsqxUO+hw06gnlYAPMyr8Mx7aVkvsqfPAwnmhhZ9n55WGrb2sLwpW/BYSf2di2bSK7gHlwUuP2z/2lKj2ViuZK5n2Nvt8CncYg5w1X29yreax6o/aH2ZaEFyS57oFIu/QmRbHU/HhTxBqRpnBhzN2s6cMpCcWmW0Ud9ndw0ro3+NoIHEU8+4j9vFEp+MPGKDfRoLFF8AcoPHZgxjjI7La9Abjxr5JnKa9T57sjonPgiwEZiW4h+IqytmLPe70lJAvtvm9ZwzXmvDTNKS6hPANqs3RQdxIA/uv5WWiDm5Z4aSgP1G90BaZars1Lgy2E42X4lMwum5QNUZTaR70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIfSAbWEYR/NIaFGGo1b2p4klQ+Y7jNXHJQ3EwSOMts=;
 b=DIGK9Nu1EiILZmBXuwH/vy87+AVXLfNRRWH8PHO7N4ASjB+fsjJRIxFtreo4EbHU8HKjjhyLl5bR2jkBBxWXNdAVcolmmJhB5iy6c0IyCKtPGm7A0w4qzgrzVYrrKJ+SmxaOwX3tEadDBv+GPQqDF17X+D9dh6yOElZFLK/xd2RSHIOawaTN/291fU8m1Nm37Z3m72FOnURKJIFZIGBCSnsX6FndJ7qHzc4reBqDNxk1V32pgOZHsXqSjr/5GPRPMnMl9NT0UzN0cjmGL/crByRibxSVVk12+3eGECOWEZqlQN2vueO9T7dDp/hPR2pVQzCD2YlcHZ1PpVa/hjDR+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Mon, 7 Apr
 2025 13:54:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 13:54:07 +0000
Date: Mon, 7 Apr 2025 10:54:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Fix wrong maximum DMA segment size
Message-ID: <20250407135406.GA1557073@nvidia.com>
References: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
 <20250327114724.3454268-3-huangjunxian6@hisilicon.com>
 <20250401163926.GA325474@nvidia.com>
 <bd0c0fa5-7579-8767-8c18-73fd5459de10@hisilicon.com>
 <20250404132757.GA1336818@nvidia.com>
 <a7a68e5d-7648-d342-8b0f-2f1c55e9ea73@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a68e5d-7648-d342-8b0f-2f1c55e9ea73@hisilicon.com>
X-ClientProxiedBy: MN2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:208:e8::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: e5db0407-cab7-4cbd-da49-08dd75dbaa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nzVW9K13rQfN6t+agoPGwdV0wLAYIjJqzg5SxLXz9L4h4PHnBTyDTBEhhco4?=
 =?us-ascii?Q?z601Rl/Qsz8bMGnyd0WB+u0g5VxFJGmQOwljNbo5JPNTulMBH8Xj4Q3T7B8N?=
 =?us-ascii?Q?M7S0pFEdBYKP0n3dCpvFw8mQPAJqghXAodt+VAwh+t22pe7UIrBsnuhcc3Bj?=
 =?us-ascii?Q?sfaKazH6J0vFxsbyuZRkImJ4mfiL+gR8ONA1JfeywMJi4Rs+uRDJ86XcQUdH?=
 =?us-ascii?Q?Ta0OYL1ogpbhYQI/+n6flp38AVzqTHgaDEvy7ahMSCTB1aidV4xFF4x4TfMm?=
 =?us-ascii?Q?VeoI4ul7XAFk4FNhj0i9BkkZQqXo+qMCWvvykgzR38rDvtXiPJ/0C4mIEk2E?=
 =?us-ascii?Q?dm91U+PdXdwvvdj3+J3/MywIrCzJwV+ZnywSwXzg0YjXGM6fFebb+kuwFzcX?=
 =?us-ascii?Q?Pds7Gst7gS6luL6pBna7VOaJkCcNQQ0009tsJI0Cy4XScIncymSmjh0ng6BO?=
 =?us-ascii?Q?YRPYtQMjR6VyoH5Pubdr3e0RJPsaS0Tg4SK6HZoe4qOr4Nperv9VHdhywlTr?=
 =?us-ascii?Q?M3qxRq80cUOrJDH2dr4p1ha8TTxLYjHvUryluaMOI8N9w43UGZ8Rse838us1?=
 =?us-ascii?Q?e/cwsrYKErGfYUUf7slz9j20BL0ZIS7ui5nrmyoQj/O884okmCqTxmyoVhes?=
 =?us-ascii?Q?eXZhA0ySslZf2QkZdOP0TCh6hns0UDuoLAPdmHkuv5aovxKrUoLrWHUAZNLp?=
 =?us-ascii?Q?8KMjPzFv05QpsHPf351e2AKUGmMgiL5oZ6KUt/F7/j96FF/lyzRWG54zkN45?=
 =?us-ascii?Q?G/4WfZl/jdIrRyQLhV72ZqtYUFsWst6fY6POESiFR+rRMNxIDXF86CMnyGwE?=
 =?us-ascii?Q?qtdpcQT0Ao1wUdE7zKrl0l+7eEyWx0vBXPtLrgwEWz4B3jyVy7hy2EQlhWHK?=
 =?us-ascii?Q?RJIknsJ8k2yIrynEXVllic7YLx+2W833yG86UBdoUt2wXE0F4MawpsvjC2Zh?=
 =?us-ascii?Q?Cq7byVEEwOzlbhAGxIIDxvnz8A0JCFR+w0LVVlpPB//W6wkqN8pKkw8EtYh/?=
 =?us-ascii?Q?CJlubNetq8nSU8Thm37torRjtskGVnNcmBYr49bZtI7pZjOBKpyvIa34mGUz?=
 =?us-ascii?Q?O3kDlHznSu8YiGtfLrmnu6guJOrszJOlTN4LRredPuRjsfx7k3njLGXtnCQO?=
 =?us-ascii?Q?GM3ljjaOb/gRNSUoCxiXR1lfwksJNjJ8TaQa+QIYIKr5e1XznavMT5geajZq?=
 =?us-ascii?Q?g35lb4l2m4Z38AzGOZeJnZDtOqzaxjBNiS/0z6oY07swqiu5VoPH53XOQui3?=
 =?us-ascii?Q?iXczcA5PsCW11O3LZCMKI/LNkmzMzlBmFtjygUfOtW9NHqk+dXTOEZx8KduZ?=
 =?us-ascii?Q?R0D9icFK94rEy4/eO6l769ta+z190MpTk5fNsH/rk3I/bJoBSR+z/C2ory/w?=
 =?us-ascii?Q?uE90k6Ob0w9CtrZNFL2z2lqVUcAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wo157jgjP66BS5HH+Rf/3X98W6ZjKYtCAXQVRsMmuA0cUUFHL7Kd+RK/yL/0?=
 =?us-ascii?Q?z94kn9yWa4BElLXbL4VAYbFrNwxjFYBrAsaMI5lAJ88vRAClBO3MiqtHTP4C?=
 =?us-ascii?Q?G35qDAsWvSD6CCHvDn5dXy9lRobhtltWRh5W/qIKEDzCCDyUL61tV0ZbdXaP?=
 =?us-ascii?Q?PNHGqDjFR+EgJNXyTTGTHjvSbM9lIuDjuB8ljUt0nrzrrJogAo266CItKndt?=
 =?us-ascii?Q?op0SxDWDz0EySvktEdo5BxXqRh3jnf2VaqF1mk+aSgKqIfKDpReElc54phCT?=
 =?us-ascii?Q?BvmBmT5WfotRaVhDZxBG4WpcYlEReWRt4oGPpP4yXDp4BaCfYdqLCTFLPykn?=
 =?us-ascii?Q?u/9lJ3TOX+GwG+zoaxgSkIjzntxmEPJBGIKk4cq0SvEPCTeF3vBoBrxtkIe0?=
 =?us-ascii?Q?2b9ZUuZG5kpe4BnuzJEgbZihhFVOvzLpReznjYEZlc7bGwy4lEog4h5hZBg9?=
 =?us-ascii?Q?SQDAEEXaUaJ0dBdcLEmacUf3xeAa2jXEOE4mhLotSsmMBWAJfE0LNDEaZpix?=
 =?us-ascii?Q?SaqdV4wxi+JmCRa3PWx10tn7Fl08oGZX/E/nEiX0V7cn7pED2kef5cuQZoDd?=
 =?us-ascii?Q?EVtHevLA7J1SrIWdQY6CeY0liIWE6TaGyrBQChTnQyASjOcLv7Kr5AnFYQ2X?=
 =?us-ascii?Q?CwYhaaf1AZQk0MbC2FmsaBRWieC2SPhbU+e8DNdk0VK0Uk23VEbTj8Di4zxo?=
 =?us-ascii?Q?SND3ZFOmMujT5H5CFrJTZyjhfLV/X/3meNBY2o78FxR8p1G/+dzdE/cgjAWV?=
 =?us-ascii?Q?86GZ4dnEva7WpMSGG8PuKR8TMjZWUMf9oMGajJAnDgJ44woX+TrhWtLGLjnP?=
 =?us-ascii?Q?XV+HZx4MYQneVgcbadtT34h86mcQ1hwfYuImSyhQ1hcxtMnDgdpR8Io0Twqt?=
 =?us-ascii?Q?ev/AlnIu6zYUz1cJIaaCmMgBMIk4Zo6yjyHo4xaYEulNrHKgABmNNmsLrFUK?=
 =?us-ascii?Q?kUf/1o29xhF5HcH/lXFBB45BWNu7py5dPSNSOzZQ8G4egrKT9F9fP7e7WPBP?=
 =?us-ascii?Q?7NYHD52owhOzZePK7DouqPjUDxZKHOzgzWnySlw7qhjXtzabuRwznJ453EWk?=
 =?us-ascii?Q?LR2jgeGDUhe3bqf9DnSBeVszijfyctL0jknF8oiumHr3V67hPtv0AjHPrr+h?=
 =?us-ascii?Q?56cXwwn6mJNcLW+nj1cxHEFoaFM5Rjg1XmIGdPrddfwxHLg0YT+fsKC/S1Iz?=
 =?us-ascii?Q?DhQHsn9XEj697JBZZ/4Fh7T2wIDjrgvYPo79ac3Rhvik0o+vibJVLOZxC8VR?=
 =?us-ascii?Q?eo2f7je6II1CiGupqz65HnenR67U4U1Kj+m+vnXGtFLh0v7RvSHmmQW4TpMD?=
 =?us-ascii?Q?Z0EOfAXmla+usZlpEvZB9lKwLUNmUr+Oc6pe6moFdScUhLw/IeGRQS9i2hXz?=
 =?us-ascii?Q?YeCRrMI2jbDwSmp1y9ozmD6lw1r1/9OFdR2g2dVCS6k52ynVYhUI8orwdU1o?=
 =?us-ascii?Q?sshGmiuZNbkUXLXVS6ZhJboJ2Vl4dgb5UjBl/ysh1yTwTql2xMquEg3+8qSv?=
 =?us-ascii?Q?7kGcvkX9pHVIaaUMSJoLT5v4hRbUrQ6XQCV0JDhd+rYU4LndmdyFz6vxCrzn?=
 =?us-ascii?Q?8l4ecS2bkIKvLsgAoSc1BydSNplfNAklryQRPyY6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db0407-cab7-4cbd-da49-08dd75dbaa68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:54:07.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lenodFZdHTjyZkYCSQBLyEGkurOGCkPMFyH4yBiCxdESJ9qFl5ZHOzdtPc5JDAbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On Mon, Apr 07, 2025 at 09:51:37PM +0800, Junxian Huang wrote:
> 
> 
> On 2025/4/4 21:27, Jason Gunthorpe wrote:
> > On Wed, Apr 02, 2025 at 12:05:36PM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2025/4/2 0:39, Jason Gunthorpe wrote:
> >>> On Thu, Mar 27, 2025 at 07:47:24PM +0800, Junxian Huang wrote:
> >>>> @@ -763,7 +763,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
> >>>>  		if (ret)
> >>>>  			return ret;
> >>>>  	}
> >>>> -	dma_set_max_seg_size(dev, UINT_MAX);
> >>>> +	dma_set_max_seg_size(dev, SZ_2G);
> >>>
> >>> Are you sure? What do you think this does in the RDMA stack?
> >>>
> >>
> >> This is the maximum DMA segment size when mapping ULP's scatter/gather
> >> list to DMA address, right?
> > 
> > Yes, but only for ib_sge
> > 
> > But I think there are other possible problems if your HW cannot
> > implement the full ib_sge :\
> 
> Why? According to IB spec, the maximum RDMA messgae size is 2GB,
> so IMHO supporting ib_sge with DMA size larger than 2GB doesn't
> seem to have much practical meaning.

I'm not sure we comprehensively check that everywhere..

Jason

