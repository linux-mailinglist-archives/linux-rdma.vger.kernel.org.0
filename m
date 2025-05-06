Return-Path: <linux-rdma+bounces-10100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD968AACC3E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E2A3BC3AC
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C425F98D;
	Tue,  6 May 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNm0f5k+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CFB665;
	Tue,  6 May 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552700; cv=fail; b=AChT+LvdG6mVQ69mKZl0EEnznW5WXh9jUVG6XAJcz23CLei450mlkvl6csxotNI6d/shF0GoJUOruVmwP+IxVrFvgrvmihhYStUP000X+ywDX16+6IcB7icpkVl8panaUC3sQJficzTjDmzC4MpncBLXgyy1ipSmGb28V+eGshs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552700; c=relaxed/simple;
	bh=P8AwXb5jqqIr02CpSxT2UjXTIo1uKdYJqpHtloKV5x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cR6H0OWSf/TX4ZssB4AQgPty5mT+H4uBUzK/kOcPM0LJB7DNsTLIYY9WBiyBeYy0rYv+yG00L+swLM35f1YM7djmMVu3vgNmTHkQovyJebhMhawnetvK3/A206q0WWODBtPaeJC0XoptIv1qveIAS7/8b+vs+6K/QgPw3tOjw14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNm0f5k+; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJHxkStSm/QFzTya9/RA12RI9Krv/G0koaNG6T2GmYNMJawX2KJ0daLS4k8WPqSRwzsHS0I4qV7X6Ei7Nbacs2FGSg+PzYZu/uoLvhheANYnXCmx5/5uNdjFthaSSgoeIwIn8uT76BWtGix7lC6D5T50/VFDPcrHuKGU9gdAeD5pCtwVQeOB4dMkMwIJIfvCfP3g2RlgF2VbD+00kWqEWohICJAQxyzr5CVRRayBpY9JcfWDlhMoGw8DdvodL9xcV8AYJHYpNyZgjMjkHMG7fGebpaZtYAQcii94i0l7RVZRMpFUx43pi0Wqe75uSdk07TKx9Af1bvBS6mF8I0BBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNzHgIavhDNNWilfAu9K7ee/3CvzX5Y4hAqUQ/U/aX8=;
 b=q1kjTD9ckU3i3/qlADY1WMTUfL2W1Qqy0gLrlhDZONuhO3i4uE0oypCCY+IL7yAOc+/D+PhvDGtF663DLa7HBFxWKyhtcpuxa/oQC48BDyMRShhzvUiqWk06cNOfmvbrUueA9TGmhLRWkkRH4pPN64AeVMRdtqbvx89CBrPTarmhLFE9qi0mPyVZtuWP0CJnAM6q/O0fQAKQ4EhSZE1eJDilha8LYjS2KQLR6r++FiD2yUav9eHHKXb0aahd0z+Vb4kDOXWGeZAbsIyz6bSED9YZYX4Jd0xpAmZF/xjMHJY1SWl1paPHIR1sz/2u5vT8lMnUEdLQT2RbBHZe04cE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNzHgIavhDNNWilfAu9K7ee/3CvzX5Y4hAqUQ/U/aX8=;
 b=tNm0f5k+3tqw/eJKfnEgsmLp5z4NsM0LPhUEqNvFMScBxjPUhssYk7Ko1F1yhrinmJCVLQKJo1OaMKuHPm1w41PVZa+TYU9HrDwfrUnDTBfQYlRTlTecEddOM89DJlZ5ge+TQmor47Esgxkg7Sze7ieGMFnD6JxPAnoMUBX+8poC5V2SDI4SeejFj66gnsAtA2AP3mxOwcgXUIA7zCY4zx/+In3YXMhLTCXnOYV5UKu600M4VZ9p1MRrQpa8zUEm2e50kjENGskSfCFwL30adIkqo8OsMqY42nvthLA+hBCh4JbfceVMwUUV72fsmfOZaS41lHwH8fFc0So0xUfJdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:31:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 17:31:31 +0000
Date: Tue, 6 May 2025 14:31:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux@treblig.org
Cc: dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Remove unused sc_drop and sdma_all_idle
Message-ID: <20250506173129.GA83499@nvidia.com>
References: <20250505205419.88131-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505205419.88131-1-linux@treblig.org>
X-ClientProxiedBy: BN9PR03CA0669.namprd03.prod.outlook.com
 (2603:10b6:408:10e::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f35a17-7d40-4226-0b74-08dd8cc3d6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RmMloGsUvaRdDFM2l21zttGY21TPdj8utCMfNiaTVzGnkIXpcSF76TYtjE8?=
 =?us-ascii?Q?qC5LkPGOuYemaAlWTMG+9Xmp25ue7s5e+G5yz356BAqtlDlkTZ0EmFN6K3Nr?=
 =?us-ascii?Q?PvPqh5l79Sd0Gp8qZFqAgiSFlJHakRpX2d3gGJyU746S6IcTkc9s08nQ8VX2?=
 =?us-ascii?Q?mSrTTcejp5f3aBFU+RDlV/KYtNrjvVKKKNDfjJgDqdzRR1NzwHmYL6RfKXRw?=
 =?us-ascii?Q?pK0ZE6Jz9S70URY+qaVOHsv9xQA08q9yrV/2vQQfCviuXREXK5Mo9hpB0ztJ?=
 =?us-ascii?Q?wQM2qz7n4qwd8xw+nMm7dG30vM7WmZWvtt66OK3HEKlzMzIFN52NjgUGedp4?=
 =?us-ascii?Q?oFkJidEXfSB7RzA5WkvUGqDy/9YCKDvm76shrnypWx3fw+dWR6xPPLaj/1tg?=
 =?us-ascii?Q?j4OOvA7lH2UBmZsu0s9fTONckMImqLphbFgQkLSWSJyWBz5wEWAAcY+cZOVR?=
 =?us-ascii?Q?PB1nqi3oukPft5mzv2opWQRH7W/qJpo3XXffHD8Z1kiXWYEZBazjBlfp/fsb?=
 =?us-ascii?Q?9MRJ8YztlWmDul4vsaaeGepaXuQGPB7Hc15Bk2EniO/rHa0l30V2wuD6sFGM?=
 =?us-ascii?Q?s1WSI/D4h9Kzcm/N31yF2KFq5sJrQKdGiuTKWa6IcAYHsjY3FcBD4hsKwFIF?=
 =?us-ascii?Q?G6uwEWihYJMU/hbDsHYLeDiy7bg72mop99GnX1UF3Jwykgk5u5GDLjQMgcbE?=
 =?us-ascii?Q?k9OPGj0HLtVjekZPD002NRkA6d+V10oTmhmwQJQdiBwaZEWTtT77k6QreBjk?=
 =?us-ascii?Q?P9KMijicfwF5SEOuRXxZR3KxLQH8fpDIueEpyrZ5NoEFBR6v+DkMGlFI7/QF?=
 =?us-ascii?Q?HtQl9RJiLrniQ2rzJOBjv/h5MRjwaaWdmFNF8hr6C9qKl1XXXmf03sSuVYgq?=
 =?us-ascii?Q?w13bPNgSAQqzPNFn/PVQUQibUbKxNOYY8EHjaH0aM6mp+H5r0vNSvjmnnXHW?=
 =?us-ascii?Q?3H6ctXf990KTBn1iqSdYLWhDZtPjEvTCUBoXyfYf+fU2/wP1uRIGyGFxA/qd?=
 =?us-ascii?Q?91Pc5YI1RPSFglPJj0CQJw7kX53l3knIloYP5l0UZiiEmka8nvz/0kZ72gVu?=
 =?us-ascii?Q?uf1bO91bN+NsbLQmL9h8X6SKpQDU6as4Cwfy2Jb6Jp8nqoWv4LyC+AdQ/+gC?=
 =?us-ascii?Q?LcZgqeQQvZ8cGQryMS1KarhLMZp2jULi6q/y/W8+XQ8lHDa96ixLplHmkJXV?=
 =?us-ascii?Q?QdaEGMC6+dZJryVmRlpk735IsPBjJiaSju5OJW2TV0h3qnTddDNMDmSGzNOQ?=
 =?us-ascii?Q?K+4DyLqgTUyuotvZOFG8T3UHwd2qf9nEgX9kxoxRZXt5cXs1+x62e0ZJexUG?=
 =?us-ascii?Q?0PrBhF4Wuv6ZqhNeXYmhlUUt+4DUsnnutPGvumVJisBCb5CbeAXHX8/ac2T7?=
 =?us-ascii?Q?XDpPg+HjHcreVAft0t5mLAdWQUpPtvpmUW207KkMNrhyXNm1k85iecX97xrX?=
 =?us-ascii?Q?DQGf//O1fSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrXi0kmCRr7sJdlrTfXy91kDk6CsmojpY6DHx8iViIKnWBasUkruSoPzfvC0?=
 =?us-ascii?Q?+i8+xr/HHZ/MDzglvzwDb7RLMSH8ZqHzeTX6gDVX42e5oqJoZi3BIrUhfu6t?=
 =?us-ascii?Q?7RhPw5d6oMIwASRBojeH6C+nmhVztuk3Nv2LPq5xaugovg2ZkrmVON2Oiqan?=
 =?us-ascii?Q?bnwNqMqE15Wq127L72paht3qxbFkA9qyvlERx+Pf0I9+3DsigSZ28N4Ofxji?=
 =?us-ascii?Q?ybnwti/p05jHgxfKK3M53FPAKoeCpgJX9xMUdjp23Z4Qb6jFYGgpItJLLQWo?=
 =?us-ascii?Q?DconYm5t5spoUEZ79uSHCRemU/yZ9N3rHlc6yKAFsjuy574BJTz3bnstRuUk?=
 =?us-ascii?Q?a+ZlFCEM0U+/7mYe1gPjBsn+Y/9xXea0FA3wmQeq/85ajcNqe43sTCYqOSML?=
 =?us-ascii?Q?CxHmgs8B/skdhG/2diYbRIQgknFy2B27rpRTaPufpPkCR7WS1DME3ZgzC36B?=
 =?us-ascii?Q?B/7I/A236u3GorFBpzyIlCZBkSVjHagXqPq6vAocQfX3U1BWz22k/LpVEbIW?=
 =?us-ascii?Q?q8pPQ+fcaPSX+2seFOJSTcoga2iZy+ebG36cUOKPyphA6fbWxOgZieRWyKaz?=
 =?us-ascii?Q?184LOYISXCXEQwUwf3S+35XPxAgmiilAqUu1EOztaugmwDjRDjYpVxVCRgF+?=
 =?us-ascii?Q?BHe3w0xwndoCCPZvlyWTiiPKYNvdAMy3Vpab2F3JZNZwMUyfk7vvBs3VcTso?=
 =?us-ascii?Q?r9X6FZIwuIj7xPsCr1j43AGGKL2U3IJJxN1VJFaa82VKIjb1zbyLxcqhsy58?=
 =?us-ascii?Q?GcB6nJ+x75gWt4ImT0ENgt370W+miazXs9Cl7OMHTsh2cjii8XcfRKtCuC/h?=
 =?us-ascii?Q?wH6XhOck5ShRO4dozvNen9wyOEO2J4pKdtVbONyqnmZYgz+KnHBG7RaVF/gA?=
 =?us-ascii?Q?JMsP7X8QfCGTySnIxrZEMl/L0RmNggkV0t0wPznEpBDFQOtjb3NLNFHhu/OD?=
 =?us-ascii?Q?23Lo/v5IRBuENKCYds1r1g/gh2e9USBldGKAwL6cnf3XFgohG6hfbK2lp/Ca?=
 =?us-ascii?Q?TijA/J4hfP/vAgvK2X95iNJoPcRsBCZDzMkFp1UdyROjAbeUdfgacQ8vJLRd?=
 =?us-ascii?Q?6gY509J8eNDvK74ykKHqqQAj8ugK1ckNntMiv/1boNK2OjT4nk0mxJPcZYRI?=
 =?us-ascii?Q?FZj09VjuYXwAD+Lgue6JDUokX1d1QLXXWRR/YHEdT7bTbDydThwN8zWc9LvN?=
 =?us-ascii?Q?I8w/vHuZKmjzOZpt+KpOHwW1gGHw95Cv72SQnGlRHskQpF8U4J+hzG+f5zTM?=
 =?us-ascii?Q?8++9tSbQCHReo6HNtdMs3n5Y5SnmguEN0aGTDkO0gfnYSwWbdAwuR2KEXw2B?=
 =?us-ascii?Q?PbPbPC6AeO6LKquj4E45htYYzHOc+FcZf1GrCNPmqOMYQV+RAt5ZLGdcGHfA?=
 =?us-ascii?Q?d1lr/ULUde6dXVziqgh5IBX1NuS7MzVMCsaaXmi8J4qTMROw3HPgNvjyEJk+?=
 =?us-ascii?Q?ySTuZdQ5DG3KYMUKAnuNUtaTqbKgLOfmnVUaPSk1bHr9foPqiWbZRQVDoUla?=
 =?us-ascii?Q?7JTJKKdbTfOhdMEdTTujPOQYsceqATSoavQA2qw6+TVaKxqLYBDFs5HhYc1n?=
 =?us-ascii?Q?gBr+ynf6QjQk0Nt0TLlLbkL/y/lq5XmQ3hewyUqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f35a17-7d40-4226-0b74-08dd8cc3d6e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:31:31.0982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MNkW46TmRPYGXD4y+s4SCOSK7XpYSD8nOkOH9ZMzoVtp8lQuzoc09N9Mm3yTYWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

On Mon, May 05, 2025 at 09:54:19PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sc_drop() and sdma_all_idle() were both added in 2015's
> commit 7724105686e7 ("IB/hfi1: add driver files")
> 
> but have remained unused.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/infiniband/hw/hfi1/pio.c  | 10 ----------
>  drivers/infiniband/hw/hfi1/pio.h  |  1 -
>  drivers/infiniband/hw/hfi1/sdma.c | 18 ------------------
>  drivers/infiniband/hw/hfi1/sdma.h |  1 -
>  4 files changed, 30 deletions(-)

Applied to for-next, thanks

Jason

