Return-Path: <linux-rdma+bounces-9203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA65A7E96F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE51892AE2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96D21ABAF;
	Mon,  7 Apr 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jl3gUzha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26B217F35;
	Mon,  7 Apr 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049230; cv=fail; b=gRsE5iJyvuZRSqozmPMalb/HBtnGFi/wFihemUNbiU5CupNr0aGzyNyYqCq/gVsGppIPjb6XMg9ZPeSyeFvgofT0cs8Mvby/xsimn3b3z2mWITDA5zca/PWRBWOZ+87F/Aj2KGHxH4W0zcNjsKqfUC6KCf1qmkFy3LYh8LoQt+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049230; c=relaxed/simple;
	bh=bprUFkHI2dp952SUiI62EnJHkwbPJRxW7dksNy+pL2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CkT+aC2alCfRDyhzgsXw7cUOmaMEB5SerDcWwzGBMm2bhYi3zdrB0G36DKuqvynxGK0uzN/loWVZ119GpxiLdtrZczb7o1uHQM8TN0R0zhXgh1GLIzi4oRmxor2N3JF/npmmzwe1mpK+CqUkVj9hx0kzCZXYwWWTS9EzvC1h6Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jl3gUzha; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knJErmEzqk/8mKFMfzXl1hkVJffn82rE1NPYA8ZuNuRz1EsM0IAMnSE1hzz9JHaFkpeRFuLM1J0H5uOksJ7ledx0K0q3sZbO0gpzhJNJhbSZkFOQu4lXshdzJUbCJLPhOu0O9IHw3ANTyVCaORHxx0++EhQOjHhAth8pud59bH6tvo2nVoUVl2YUFC5ucBP+s6AojJVzQLTZxUlwj0RwKLL6a7rf/P3ddqgyPDq1e2VaDtgXddriGUBkdDo7I5xlWX1W1GTvcCz5Lg+pEHXrVPFGA+G1Xk1m7RcSkXOTkrujRa2sH6rHN7NB84+ikNugQjzr/IOqs8USHPHnmOqF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsthNGI+gjP/YDN2UcRuIjZQHy2ayCIAEhzKQkTIj1E=;
 b=uWcCu5ubyU8mw5nnIba8jStvJSJcgXf618UGMMa2jyntHNhrbSnqpQ+k2p8kcQsDh4aIkC360I80FM2q+coUrB2kybHF/AipLYMpGou4VuOVGKiJjJM01PjjsYpe9iH+N4LlIB9o5H9WrtuhylcAkox7RJSlJgEO0Jc+fzxqYBfmO4MJk3HYv3sYeZ//fwtVcIQIsDy7MEERiRmtS/vXkItKS+HGUGmnHB/g4lZemOrOXfOcJaDRKzTbnxV+bLGw/+AV1FoybTfuvZ6dBETXa3Ida4HYCAD9VDhUayQoaCTZ7VoblzmF6AyKguVn9QMQ6YonL6ewlCbbvEuHY0JNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsthNGI+gjP/YDN2UcRuIjZQHy2ayCIAEhzKQkTIj1E=;
 b=Jl3gUzha2Grxil7MtxBdbz2P4TjubnWsrpGtVmjVSq0v4fVyN3xjb9rVDuRmtU4V5YzoYD9HD5kIzRfalBP6FJLS9mXdKzugxsTeLrmwfCswMmJXkqVKVEpVHSIj7QM51wjEd4MO2m63GHT92PINg2myEnG588trO6SckL5oEG3AUs3jXK8rNVKLbygr9HfK1jrwzWyRUsksZ1PVK2VH24i+83SDCV0dHRkI+/pcmAqEE9lb8Ra06J82YT25dmLOjMgOhXirAv3DjhUYkigG7TQaOZg1/ZKn5IXXc+7gHU1u3zr+EbmUqtwSSEUIXZTaDZHrpMjvzg3yEoT1iiBtAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:07:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:07:05 +0000
Date: Mon, 7 Apr 2025 15:07:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: ye.xingchen@zte.com.cn
Cc: leon@kernel.org, yishaih@nvidia.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: Replace =?utf-8?Q?msecs?=
 =?utf-8?Q?=5Fto=5Fjiffies_with_secs=5Fto=5Fjiffies_for=C2=A0timeout?=
Message-ID: <20250407180704.GB1759834@nvidia.com>
References: <20250326221955611qu6Ix3Pt5WgKvhL6sTySX@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326221955611qu6Ix3Pt5WgKvhL6sTySX@zte.com.cn>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 500847aa-317c-468b-faae-08dd75ff011a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2hekbK8MKkAH3GlA09oBnMLhk5MZe/1a1RV03PE9cwTbxEYGX9+LMzRcVH9Y?=
 =?us-ascii?Q?6lvdAB0lYSjzYT3c6MVX+cN9U8q5bBd89PAu4wLlvKdl4wK6m+fJTXMKW47f?=
 =?us-ascii?Q?FeeImq/7OzwCfiTWH4H94X2S4DFmdw3RPVP/RfJp7YyMGdev7qDKRmK3st9z?=
 =?us-ascii?Q?K4gxumbHJOEHLSEQ1EdAhSSIEcIWEZR7h2qHlaSW7av4rEtKtLLtcImihM/q?=
 =?us-ascii?Q?bnuvuQJnwGa15FdSGLXu1EvsA8a8TvsrKCIVBKoLbCTSpcLXmKm+diqry9k7?=
 =?us-ascii?Q?eBbzRdWwEUDgTPRPUkWNJBBn7arqLpl9juZVVwF8mdsDdh6ig5Nwy/MvdSTC?=
 =?us-ascii?Q?ePBODKgAdK+kT78hJJyBePcFybqAqAWHQ77nkSns+yZhs1ZgPTH+rgqpBknQ?=
 =?us-ascii?Q?ygi4d5328CUx8CuuEjNIG//4aDt8UBhXMRVbCPJlzFpEsko8IU7Xiepp32Mo?=
 =?us-ascii?Q?gcxHT/PlMOVizx7w6YmyROqrtdwcxG/A7FjsXrGdFOxDKAMhTPEXWQcWoPfg?=
 =?us-ascii?Q?iFDg1WSmB9SsNynqx2we7kSGB465CME26p9adfyyHG4pdO7UV4QtArOm/Ssu?=
 =?us-ascii?Q?86jZOX/H6LR/lcDvYyY05PrL6BeMrC4WeZlWWj/d8PwZ8sD87jSwc7B2UEbb?=
 =?us-ascii?Q?Xy7XQsp2j0GtIe/+QVtTDvbsGvVxDr8Y6ca9+Ok+UEfgbk07sQMFhYk2Z6Cc?=
 =?us-ascii?Q?xoAfNnBPyVa7sjnBCZ/LdamJYpI1EVRsqkiemM2SKB2ojK3AYeOWKaf55rOK?=
 =?us-ascii?Q?kL2AohgIbHDrS1AqD+0uKS0TcQohqTvDmz8QD0TiXtsrdrhWcxW8X4IBQ3fZ?=
 =?us-ascii?Q?N+L2nxFvipRS7+c3zSpErogwgYhDVVXgP96SuI1Xq7anFfDI3gS2t+gzBrZ+?=
 =?us-ascii?Q?li0Ov/UwgDU55K1Sq1urhzvAxPLfZite4EEYn8prPvBFXQmF7y0Yp3HgpXyg?=
 =?us-ascii?Q?3d9q7RWfeRxfVkR/qJyb+dirykh8zJvY45DArsDzOAT0A90ddcjIxzGb90kh?=
 =?us-ascii?Q?PLMONYwp97B/U5XmJCjVckXSK4wV1+HpG7PcbaT7JCGfkVidqG4j2wvQYmHY?=
 =?us-ascii?Q?c5NO4ejGN5S6h/oaOSZoNVzItPxaZ33/KlHmJywGWpmgJcRkdqwNmFFVAEok?=
 =?us-ascii?Q?Khf8MJ45g7aR0VMeZ1d1SQAlyVlqnNBsumtf+DqLgeeT2PzUlRSjzI9NCQcO?=
 =?us-ascii?Q?PfVog2hTIz1oHgmpQf10boUAh6+xKRY343YjD0eeqJkN0fDxja1n9VymnnaU?=
 =?us-ascii?Q?QdY5tyouSD31R0T+867kW73i2ALT90c5afvtxwLgTxA/yNXVB4ZUHu/FaGsg?=
 =?us-ascii?Q?JlOn87RsCohGkznjyboPcDBpjQA7bEJWoaonEPNyKc1IUGj3pXwpyS0IUhLS?=
 =?us-ascii?Q?HCH8NYFkQSpfSC7IJt91dyStZyck?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOrIBsGyPW5C6QHIcn4aH54nYSKKjenaUUj2gxovA3UJyNSkmubc21PWFlz1?=
 =?us-ascii?Q?5cTEoRlcpPxjkH/3o8rtn1xHxgb2cjVutQSMKWnmH4LPubc8BUrqIP9i4yai?=
 =?us-ascii?Q?eAVmKYnzi67p/IVLBmvks1XQr0sH42KvCPpjtXfWd3+AWMvskfQwGLB4ZLo+?=
 =?us-ascii?Q?DnhYe2gudQYgvsf6HCzY14AgjJXG0A3cOPTr/B1m+vbLBBUVN5uiTzU7RNHO?=
 =?us-ascii?Q?TnhCgVfNgU0gzZ/97GcFIRqa3101UYJR41MNc/ZQXC/2J/OKxMH2tmhzqYgQ?=
 =?us-ascii?Q?s8sGSqt6VjbhTz32/5SWJw3eWZzCBAQIiwpZlWgHCOg3Jy32sq8+mr+cMu2i?=
 =?us-ascii?Q?LvXPUGUxvZrxjo1bHIe7wUK9rWv+ktCg7WbLnbMnvsZRTjLiiy2dQDif7nYQ?=
 =?us-ascii?Q?OGgaY7p0bsYI/yQyDGtqRdnoC3nE39GWuWeWebTmjqdyIH/IR2uhYJukysWw?=
 =?us-ascii?Q?4TtxNu0guZ9A0EQmzTp6OINO9cT0TzA0o0qrp6melJ07de0K8iqlagBGVTW0?=
 =?us-ascii?Q?lDsJj/Lg3RWhatHhuGbp/bY4+Wa3eFZUIsIbedkJNJ5q5FYrV9EjhGLX0fWM?=
 =?us-ascii?Q?mB0ePKAD3lUIDf4FHbO1FRpbYCgW7Zo89VoGQbJhBT1Dde9rMO8tL4nW3MnR?=
 =?us-ascii?Q?69RXsrR2KTQUY83GXz5FSqSRu1Ik+T6wzASOStddNTWz+InClGAKMa0rCffN?=
 =?us-ascii?Q?CKmx9Qz0mtk/0TCM0lD8FMUJ3gk3fZhyNECM3syoonSEkaev90xMiRY4lji4?=
 =?us-ascii?Q?2t8bjPETNIWBuCpQsgCu50ForEQFKlPzHHdts7zKp+bJrtPBRj4HBcy7W5is?=
 =?us-ascii?Q?FIGR3EbvtCwLFoO+ep89QSx3wiLlYsok7rVGzvhARe3zL4ExhtfhfR/dn9vJ?=
 =?us-ascii?Q?Q9zU1s0pWWek3sQfI6hArvA1lpggIgj41W3cclMS/qnYliGaDKCVemtDulYi?=
 =?us-ascii?Q?vLplxO6q5Ee21oW/07qEuT9rfhi6WwKwvMgRb4fW3qAEDHBllYJ228JZnreX?=
 =?us-ascii?Q?1ODFg4YlFI44uqt52i5XzJtf/FVo1oy2TJpeyACmkdbCQcnxbHX1tSnOPrt4?=
 =?us-ascii?Q?ImGRe0GhYN3IdGU2/PTxn4EwMb2Fc6zNtFxIqCA1Bc6el/B6e5vQLk+9ymY4?=
 =?us-ascii?Q?KLy7ARY9prB+HdLriVEO9yQBCIXcVZB6c/7tq9f0ouYJjuubdy03K35jvFeO?=
 =?us-ascii?Q?QUPXjMYP/08a5o7OS1kZzu+cyDlZKJcBqgJbxuiNwJgGxbx3nAWgniOiE5aG?=
 =?us-ascii?Q?iv9tqfOCFxzE/R6k9AgBNPyhNQrC3uhGN0m+bR7lDx2/gpMOTj4z84UnyMzq?=
 =?us-ascii?Q?u5kFxvy7JGI94Xg5ahp1eZngyEtEluyi+Ps0MmrODGxT9U0NKxP26RDU/N6i?=
 =?us-ascii?Q?YRJf0WdrWKFifPRpIWFx/bfQNfSZm+VUmAgAs2VZW4+6f3nSHmUNAbi9ET+a?=
 =?us-ascii?Q?NmMwIQ4uKP9sE2qqVnWiKh7Gq0Sx7OtdctC400G1Bhe/sVheAUgspEojgHPw?=
 =?us-ascii?Q?SYxwmFfeBQNz26IlRVjVapT1qNw8s66mvdJDD2f9pn8W3uW37wfHEyqtmTcf?=
 =?us-ascii?Q?7UarB/DEzJNcDU+I4nx+zkFZhMGzntQUBQ2PrsBq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500847aa-317c-468b-faae-08dd75ff011a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:07:05.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2li1+Kh2NwL2FgXKR0p/OuQF9nnPLGQvn+LJbGx9KVJLRGa0f2taPFCpmTxfBN/o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Wed, Mar 26, 2025 at 10:19:55PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> In drivers/infiniband/hw/mlx4/mcg.c and drivers/infiniband/hw/mlx5/mr.c,
> `msecs_to_jiffies` is used to convert milliseconds to jiffies.
> For constant milliseconds, using `msecs_to_jiffies` introduces additional
> computational overhead. For example, it is unnecessary to check
> if m > jiffies_to_msecs(MAX_JIFFY_OFFSET) or (int)m < 0 for constants,
> while using `secs_to_jiffies` can avoid these extra calculations.
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/infiniband/hw/mlx4/mcg.c | 8 ++++----
>  drivers/infiniband/hw/mlx5/mr.c  | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

Applied without the mlx5 portion, Easwar got there first, thanks

Jason

