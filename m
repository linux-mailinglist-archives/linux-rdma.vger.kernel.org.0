Return-Path: <linux-rdma+bounces-992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFE84FCDB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 20:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4251B24360
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Feb 2024 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29A80BF2;
	Fri,  9 Feb 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a54lI9bj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D04364D6;
	Fri,  9 Feb 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507000; cv=fail; b=F3PeIcE8S7ZQikp5ftB8VEs54HxyAJAqR5b2Gn2MofjbBIgbG0bDByUHB9JYcje6w72sj7CgOgm6CTnAzo69Fh0W3v581FyqdPI5L4BpcS4CpGrHd56GwxnI8Tq1PaxBw6UxqMPZrO6Xz+uY8cpcV5lDZsjuaViw4IlCO6tU2ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507000; c=relaxed/simple;
	bh=PDQJjjt/j8a2ym6z8orui0OEoUb91EEc/StkgPeS2YQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=dOPw4+jBT658jQLMxaERrEJbFEMyQwrDdoAtgrZ6nNxA9t6I75/3TIPraccSVeagHjv7VqqK5/xrCK2vfrcFAQ3vXGc33nUsSXNlQ487NJi/F4dxcMStmY4wSVLertdN+cUnTXG7SxRmFkBpa6E6d34L6NKgZxInSlpTvn5xUKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a54lI9bj; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqSDlhfV7hS0EyR5vwkoB/5TbovDoaiukRK4FRZKARGm7DGfbCbeT2bFsbjoW6n7kSIW8YWv/GpK/MoIJuV343h3hMr9pFMb4yKijk68hjyvOmPOuxJMxVZis9/E3tIlWzMNzS+jZtGJe6T8wed91r5EOelCA7g5cixId1XCvY7yHedR1/GwBICvAKTeeqYYjXhsBiX6zsX1TcnXVRCJM+oBEURSigKkOXF4IJCP+iRO9mPKB5qO+BP2GOMPHfjQc1IhKXFh9739+40yN0ydG9BjTIqlXW5iav1WbQMOHYUQ6hhl6p3IaPRxeDdaQHy47kuADH64bBBrUP0vTS2LeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuBW09dO9S9/OsvoJn6ixLadN3DdG0hCvV/g5IeHh6U=;
 b=e2VCePwIGmec9Ik3PkBkWrcOWu1ZIbXA8VsFjvoqr5ow7HB+2Qk14VD1eClbCh8QN7s0xGIm0inV29BhyVSTw93eqaAfJE5/XfvodO5t+C9aJ6uMTrKXJPErH13djQ/a5TyOaTwVTbbCgsnT1U+lZYUPdEC4p8mJY6ZVx7cT3eC4f1UItf0FTyMMhDG7yxiNulYfriiUlCcquw3k4MrP0KGAyedLesDLGDL0FCE3QtdPkia/f7u1tLZoxvqJubvQzK/KtkcTRq5nQeGM1IUbl925j60k8q4jdOBVVs8RYqojuilMP3AruyenIHxCdDWwwXf9XNM3Az+h9YoVxalJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuBW09dO9S9/OsvoJn6ixLadN3DdG0hCvV/g5IeHh6U=;
 b=a54lI9bjwpQdVNaenGYR89kiwQnv1mPv81CEL31MHInibRp93zRvduFmjKaGONjMt218TC/7guyI+3ES+PKoE6v6bwwJP9dvt9R55uhtQVY390CLzGu2mkvOT2g3asIM7oAdcf2gSameK6usVVd/yfOFHs2XOJg0fMqQZ62mFwnsevlqwOsD0GYpwf3wzAUuDXQFYWRGPFYblYrKFO3Pn6OUi4Hik6S8Iq0RXn4GfkSBQJnVg/Jkd4tf2eCK4qkZDPPjzIRIcXlLIFK08wf8HsW8+3EpNFvS11rQ32TlaxIZL8NFtqiShkgciqADIMILdyhdnp6yLeMTTtocf1oB8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 19:29:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Fri, 9 Feb 2024
 19:29:55 +0000
References: <20240208030702.27296-1-jdamato@fastly.com>
 <8c083e6d-5fcd-4557-88dd-0f95acdbc747@gmail.com>
 <871q9mz1a0.fsf@nvidia.com> <20240209192404.GA1430@fastly.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net/mlx5e: link NAPI instances to queues
 and IRQs
Date: Fri, 09 Feb 2024 11:26:33 -0800
In-reply-to: <20240209192404.GA1430@fastly.com>
Message-ID: <87jzndpham.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: abe2a20c-ebea-4890-d766-08dc29a57e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IsJrqjPEEWtmgW8OCxmqHqL0tEhi8lJ6pfkC7sL5YWOYKd+6iVfCKSCDBkMR5lq3zufWIfplL/TM/qlDxK8iPGuzwjplwhtUDBTjF8r9FJSoz+557ivxgc1j3ozKoB4FoHu+f9Q26O7klZG79ff9eD+/2GT/Cv/3pszmg78JAdsr23vK+bwfjhfkIYwfJ+wnDN/kCMEZqg25SpJiO3xUeZMTUUotU0U+MShc0wH767blm1e0jzzNkQKSZlnsZtxNZrJFzi0qOjIuornI4Tz0RLfpLJvptA5QZ1dklZC1dVgU+RB678ANsgZI9aHqEUs9gxQEoy5l+QYfU0jgFVh/6rFOATZsAlxQMcRssqF528cKbgww71CPU9zgjZXOyhHfOCudf4MVjap67DwU0Q3CF5DfRzDRjCa19teyyVXU/N3vN8tBKVIAnp52HoCCJqrLSSL2O2je+o28drxQhTv0cReDivCKRzBCA8XIIlcn1fXqbrInENQuga/QaFl1l22EiOmS7OoJXz3Cgm6R/VWwowRDFexRc5Kv1zOTI/9ETDCsakt7jYGuPmRmuunpvqEPUkHakJ5afgdh7UxwT1tQrIVRhawUFKsidRE87FqppCw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(53546011)(6486002)(6506007)(478600001)(966005)(83380400001)(6512007)(6666004)(26005)(2616005)(7416002)(2906002)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(5660300002)(8676002)(8936002)(38100700002)(4326008)(36756003)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9H6qvRpRA8S3RUCHObNKawYYZZr6WltqmnEucPv8ztuXH37BX3StGYuQpkx?=
 =?us-ascii?Q?N8vcMz/RUmkYfyrf2sui+YS/dnTeZ8q+LH3RYXFfkw15WiVaXq5aOtQSwSNc?=
 =?us-ascii?Q?NQoXPjv6RwnvmUY0klTnaqicH2ImPANQFn48GcynRsB+5f4urFkvxpbRzxRf?=
 =?us-ascii?Q?6DgdwlkQjuYR6N5ktlT7n44xjfEXzJRinjkbZhsgnWbJpRecPD1XU+BG3Zrg?=
 =?us-ascii?Q?PEMK5Dmyr1cesj0fdFfZK7zg5GQg4FsIWMAal1vBtR4/Cm7qD3wOY/HlOqLi?=
 =?us-ascii?Q?KbHdzcszqUSno9fiisoZuMYKYsee4T2KebAKNbxfipGzaBrJlqA7H8BrBY4a?=
 =?us-ascii?Q?62fF1WLZRYUGY3GLE5ro1WJKZRNA0nxLSwfTVO7GAI4f7OPmpjRPkFG557hA?=
 =?us-ascii?Q?BGRR0wG1IxcVC6jzbS81mJRA5yQ/feawShyOENFKzlQmkVT5EbYvFFqa/ous?=
 =?us-ascii?Q?4v8loNHiIlk4x7bEymS/k+SSug7afBPKv+2mKh/2qgdGbeLL97fzjQrI8CIS?=
 =?us-ascii?Q?23NfbZuRW6BJ/nWIcdb/nUz0++v0A8SHuuZ9U5538gS+j0U3Qa0x8GYjgBtc?=
 =?us-ascii?Q?dFdQsIF73mg5UKxitenqhkHZ87efzyqvra9BDr7a8IbUMBgkqVsSG7NN1Wqu?=
 =?us-ascii?Q?QZ/dujoJoPJy8bMxI7SWGDSzKYacoW0UXFoYm0US5o42SvVWbXjc2sRgTVJz?=
 =?us-ascii?Q?A0csuoroYT/aNzwhZ6G8zpGUThr/BUcZMj6JUf9dDiEoG2LBA+OK17KSztcW?=
 =?us-ascii?Q?NHn4fgyzFwaLhJaykWgrE0hGL97MNUFO/v7oTVycb4ErL9jOloAeairVOX94?=
 =?us-ascii?Q?TROAgcGOs2VDKsvye3KiPMbGpkix5NYwP9wHsQPo0xELQbOeOyc5lOg96aRT?=
 =?us-ascii?Q?+n6P6BesKB/AuGPY+reYH/ukRrXewQii1IFnQW2mecgW7clg/Gz5K6NW0YEn?=
 =?us-ascii?Q?JbFPoFg93O7er9BIxSEy/NOdNv3XrBcUz7hw2RQutWn5PvLy1sVQMR0/4mwV?=
 =?us-ascii?Q?20Qgj+7b8yRfzHCX28zFhLJI/2OdbJcgjGnvQK5Dcb6c0vlpaSNfbP41pR6K?=
 =?us-ascii?Q?byTSpN9epGtKDQZZZjp1+8YIovb//lsSnPronktsyxNa075SCdh/AvGf/juR?=
 =?us-ascii?Q?/WF4bJ0+bMgu2gc7reX7uhk6cSkGhWwmCrdMLPwBwUmBEG5h9+ETFdW+MkvG?=
 =?us-ascii?Q?X8/OeUQ2KVXJQZwJkItKw/3Djd2IhwffPqKryp0y6oKZUx7TlM3HpuiIbp4X?=
 =?us-ascii?Q?cTuKDL/cuRsA0WfCu/hCZtOCH4SQFQNREmU6zgAzFTrbxE/nceky/bgFIdYB?=
 =?us-ascii?Q?XirU9h/i4yqL9+YUlNNx9LGN62bykUf6TqN/UwF+Es2P2hAfn3zq63JtSFUq?=
 =?us-ascii?Q?cKjwHrlGL+90lqn8tVY+1Pu0ord6SzOgCcatCRcdlPvEbQyWofjOoYduNWXH?=
 =?us-ascii?Q?E7kpCiCJvunXZqMsI5wgKVn2mWjfQO8PrWyR1fh4lHE3dRvVsRW6QU6We3Fq?=
 =?us-ascii?Q?C1UsoNtysyOK0YyVawYAB8pdmat3oQ+AYqFdrqTFPRmSKICvg73GROjCg7uf?=
 =?us-ascii?Q?nynb4a9lgDuHiGI3T4J4M9ExgW9W0mbjVHDnl5BjcUihjEm9UTW2zXrbwYho?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe2a20c-ebea-4890-d766-08dc29a57e7f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:29:54.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkWQM8yj3MweenonbZgbTFe3Es+HdZJVXi//e3rpCpBjXHF+buLMlF4zvUMl6Ahk+zPxGJe7n8acoAGpeV9K8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

On Fri, 09 Feb, 2024 11:24:04 -0800 Joe Damato <jdamato@fastly.com> wrote:
> On Thu, Feb 08, 2024 at 08:43:57PM -0800, Rahul Rameshbabu wrote:
>> On Thu, 08 Feb, 2024 21:13:25 +0200 Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>> > On 08/02/2024 5:07, Joe Damato wrote:
>> >> Make mlx5 compatible with the newly added netlink queue GET APIs.
>> >> Signed-off-by: Joe Damato <jdamato@fastly.com>
>> >> ---
>> 
>> Just came back from testing this code. Let me make one cosmetic point
>> here. I noticed this patch has a line that is past 90 characters. Would
>> be nice to get it wrapped in the next version. We use 90 instead of 80
>> characters for the line wrap in the mlx5 driver because of firmware
>> command interface related code would lead to very hard to read lines if
>> wrapped at 80.
>> 
>>   https://patchwork.kernel.org/project/netdevbpf/patch/20240208030702.27296-1-jdamato@fastly.com/
>
> OK, I had wrapped them in the next version I was going to send to 80, but
> I'll adjust that to 90.
>
>> >> v2 -> v3:
>> >>    - Fix commit message subject
>> >>    - call netif_queue_set_napi in mlx5e_ptp_activate_channel and
>> >>      mlx5e_ptp_deactivate_channel to enable/disable NETDEV_QUEUE_TYPE_RX for
>> >>      the PTP channel.
>> >>    - Modify mlx5e_activate_txqsq and mlx5e_deactivate_txqsq to set
>> >>      NETDEV_QUEUE_TYPE_TX which should take care of all TX queues including
>> >>      QoS/HTB and PTP.
>> >>    - Rearrange mlx5e_activate_channel and mlx5e_deactivate_channel for
>> >>      better ordering when setting and unsetting NETDEV_QUEUE_TYPE_RX NAPI
>> >>      structs
>> >> v1 -> v2:
>> >>    - Move netlink NULL code to mlx5e_deactivate_channel
>> >>    - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>> >>      irq, after netif_napi_add which itself sets the IRQ to -1
>> >>   drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c  | 3 +++
>> >>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
>> >>   2 files changed, 10 insertions(+)
>> >> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> >> b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> >> index 078f56a3cbb2..fbbc287d924d 100644
>> >> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> >> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
>> >> @@ -927,6 +927,8 @@ void mlx5e_ptp_activate_channel(struct mlx5e_ptp *c)
>> >>   	int tc;
>> >>     	napi_enable(&c->napi);
>> >> +	netif_queue_set_napi(c->netdev, c->rq.ix, NETDEV_QUEUE_TYPE_RX,
>> >> +			     &c->napi);
>> 
>> This should only be set if MLX5E_PTP_STATE_RX is set. Otherwise, the rq
>> is not initialized. The following callgraph should help illustrate this.
>> 
>>    mlx5e_ptp_open
>>     |_ mlx5e_ptp_open_queues
>>        |_ mlx5e_ptp_open_rq
>>           |_ mlx5e_open_rq
>
> I had made the change that Tariq had suggested in the previous message of
> using sq->netdev and sq->cq.napi, but I can also tie that into
> MLX5E_PTP_STATE_RX.

Right, Tariq's comments are needed for the TX queue associations and are
needed as well. We also need to make sure we do not create an RX queue
association for an RX queue that may not exist for this special PTP
channel.

>
> I'll add this change as well, test locally again and resend shortly.
>

--
Thanks,

Rahul Rameshbabu

