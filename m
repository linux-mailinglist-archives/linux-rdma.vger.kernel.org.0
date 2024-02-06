Return-Path: <linux-rdma+bounces-921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6B84ABC7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E580286394
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A056756;
	Tue,  6 Feb 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+NG0H1g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4555E40;
	Tue,  6 Feb 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184318; cv=fail; b=Ni8lnTPj4UQKdTh/PmX6YjmrM6xsaJDfVGQfptNRkh1ctt40SbHIgeftQQDTAlDv142E3ZDXvoyCp8kAqBIEzfZ8b3TOnJVnMzhoAUKaQ6AI1Fvos97hAiOXTFyZKK64NEiNNQxd41GsRifsSuyJpbc47Qy6BRyCRvB9Rj68uJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184318; c=relaxed/simple;
	bh=a07A7g8GwCXhrDbZUNc/ww37SNSBf1a2/fsmBS+hjtU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=pyrjiwvZG3FtH/Zhkf0MVl7nHucyBymzFQhtTWo/eo9+xle3M9+5JDHOzB1WpqbekkEbRhSF0c0t0TWy77Nc1a8XdN9ohwaMPsOWtPxeoZ7LhXcU8VLokEM+uxk2+NRTO1Ny6KzbPLHB5nRtVChaTPbMeTiFPTwQs3orBygPEjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n+NG0H1g; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfLCAH3pRXQvi4PAqH53yw6Yjjzyt04+inuNILaN06sccQxbMnblXn7MeIR/qrF6oJ5ieM0qnjBmCQgQcsFJ2yh9PXKnwJMruvJ/BcHKTjD8slokgyuFCRKCNZehJpzfqLqSJUFvxo3HL23VVM5o+uEvuVkDGbXUK9gNdZ1aECpumfGm7yvzInIKtELqUC4humu49hrk5gb4fd/3mazQk7jvBw+CbN1qqJMNfxB8bwDCUrOnPHNLCHoHjziOf5DHcKean8Ov5CpSPmUGF5AhiofVz99vqdJfJPUCGasyyiLGh3Ts/Y5EwW61VWpsCBd0hOtTYavrORE65nnnGiuedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y6EkTO0NMwixfNH+nnfxz89GkjL7FsDF7RfeZAilwg=;
 b=SmfFFA5YXt1ejwy20NmeenRc9uN3ShWiEYl2mNzVHBqKsrQa/Vqnn3+mn+uUDHsHG8p6KJx4nSV99mG8eGZXBeHs4YvpIL4c0otdHNXcqXFqnbUpFZx7PKbObyEamJ9BqO9UlnQFlZE8Now4EVsG2gEutoUoKYD5Mdm03ArBAAHHZ+7LONC4CUIxPcpIYMwfRt6RMNlaQ27sZyA8FBq74sGz9Zi+KhTkYYTmWWrpW1EMGrGuXKQOhQrJZwoWABsFPEzPS91Ib5YlCx0pfOM+hBxcprMBjUSwaTRYaGY3ZXZZVIBlAfiUQnvSajB0zvwzts9fELM+kxffrmI3ubeHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y6EkTO0NMwixfNH+nnfxz89GkjL7FsDF7RfeZAilwg=;
 b=n+NG0H1gWWz+wRX3WBys3uBpyEVjgrOowQuWWCwDF1rVkbrAXdZ3Rvjbq90+mAex1pRL69Fo9B1keB2NbOHoACcndGqGXR9eBgAV7Hg78U7XErvSdXuKIBinLc43pe9uwBA/ISIosknWGaCFdYuMVZ+oMqRbl1aGWQBqPvI0JiByQTpNRUmAY2Bk2jvDmCG2PGI43R2YGpX8oNvYk+YDEMvPqoinmNO1nL+CLwHpWEp4DMFdnPZaH2J2PtCvUdbnc+AOpqhMFDLsNJiagnYM3P7eA+Z41bcY9J2ubg7aSQh14Qi9wiqAqF/LHmdt9ZP1Z5BuHd548aVtHsMerb6NXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Tue, 6 Feb
 2024 01:51:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 01:51:50 +0000
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com> <20240206013246.GA11217@fastly.com>
 <874jemml1j.fsf@nvidia.com> <20240206014151.GA11233@fastly.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and IRQs
Date: Mon, 05 Feb 2024 17:44:27 -0800
In-reply-to: <20240206014151.GA11233@fastly.com>
Message-ID: <87zfwel5qi.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f58ea0-1076-4618-652e-08dc26b62f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O8pLZaIQ3FWoUnyW93siT9XdkTVXUqd/zSOqGcIQt/jdsqJolV07LdEwn24RfmQ8Muh5ocLH3GstRnXXGvV7sEFIbf3w2/eFQYFwNZxWuSwbnghHNfCx+Lx7McrHFCQow3HbIysqOHUluhoXXbeOZF32irC/lDKRIEKMvQr553UB89E48oeQMD+jZi26jvKHjR4WNW88NroVr71degIvQ79QiW3ESl/rKyBm9ZMgWqZstGGOUNp47FQkwOL/FkTsO3hYKUj7WvaWzl3YgVuF1cB/A+NBWx9kA4j7BecfWWoaqvrCm4uPVxAGsH9+rCJE9qCDKZgzjtjQHTPUgMc6hpYERvjsGUaO4BPlCee4BtrPcws/qOL9AfNiPfOHn2NEpL2ClhUbwqTcuTUBdQVrBPyUmShqYPsGBN70H5p2f3BpcjqtnNDfdXs14FprqE2aL8zKZZtO7ILGBjvIBmk5QO4AAj6o7wAxd9Zr9knS78NL4jK24J5o3/uA3Vd/6bNJVTP2FruaYtTw6vTRY5sg2hh2vCQrLEW6hNI0D7mPzDXhxm77aHGdHYeQkJ2kE3QV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2616005)(316002)(8676002)(4326008)(2906002)(86362001)(66476007)(66556008)(5660300002)(8936002)(66946007)(54906003)(6506007)(478600001)(38100700002)(6916009)(36756003)(6512007)(83380400001)(6666004)(6486002)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjLPUrD9a/Ohklkal32wT21fd1zQ5auKfGxmd5M0OrC3uXQ1UChDx3daO2Wx?=
 =?us-ascii?Q?hfM5MeB6eeCpPAp3CCItydE1V5tk0VzTFjIFfrGYR+s4B5gpq1+GONe+BqCs?=
 =?us-ascii?Q?a/O9wEmOsGlTTzFG0TViG1ra7oKKDvRjz8/H4cjq6V30VCQnbxEn/jcDcYAZ?=
 =?us-ascii?Q?URTTF8u8btFH8VTHYVh8F2OAYXL5d3rfLLAGjel577WTnHncZUbYQRLBHppo?=
 =?us-ascii?Q?7h3abxKSsD1H9LKLYMbhNOCDNCqxsIYH8x3rIK0G0jIGtmL8n6moQ/UDKcA7?=
 =?us-ascii?Q?l1dmCokG1xdqM1FIhwvsn2EfSTDaphjFg52mqbBvhwWzDN4Q8fC5zXFSp+WQ?=
 =?us-ascii?Q?5toQrNKo5Bacgvhj2tEi8wilpm+77sa93ByofrkN0odpb2LE5VRNRcmg3t8m?=
 =?us-ascii?Q?yGxIfzJP3GjuWgmYXHxr/fO2YzJDe+M3Un/5PUjXA/jVhMcmxZ+/AaqIoJO0?=
 =?us-ascii?Q?UiZwD6JNgL0CIJi/e5p2+nkV95p42roaAiMzIPwQG9M9yCVNDk0ERqlwwle6?=
 =?us-ascii?Q?SgIqoJs4tQaiUEXg0M83+9+TJ60jdh8/jAFmKCsuV8TQE10zrCxjXdnCs3dn?=
 =?us-ascii?Q?z1gBgtnEaUW3FNyPhmW3MqxJnDM5NmLQbufOiQ27sP29Gyuyrrq6arWn/XAD?=
 =?us-ascii?Q?V3yGrfPriiA60ICU6MXkiGZMnjCo5cw0PCh0zYRTvwfZRTrCPWDplk47TFHC?=
 =?us-ascii?Q?W7gSTxSJjiN2u7l9eZvz0Zz70Zto0DcDNfIiO3ffXfpizoQIWqmRSPlP35tg?=
 =?us-ascii?Q?5IwopBJ7nLzvC4SPU5hgP8blrtVpiL5ffNjLnQ3tLz05jt+VmMj1b/e88Bhu?=
 =?us-ascii?Q?l37laCT013RGd3LEJDntS04+5RXQCV73pJdHRj4QkAbO64/2w9qx6q0d51UI?=
 =?us-ascii?Q?MNdM0KaOHddAva3f+Fmf2fY6NjvHIpw2KXIyI6Q8dzCQ4wSX9ohENfvB6DI0?=
 =?us-ascii?Q?NEwDh/rZN+K8yWuwuEX3uTeEdd1Dg9ujkgHnFC+Mq4w8o0g/tH+hKeYFOfvT?=
 =?us-ascii?Q?sKlBYujQd0Ghcg+GF1Uf3K4IkFC9EEe2YQdM/49OKZ9OhPXypwGOHotORr4U?=
 =?us-ascii?Q?ypq5mjl/fTWkE5cuD8ID/GKtlqZRdgzEcpMxB8HnQHVAvjc+IpQ+Q89mio7t?=
 =?us-ascii?Q?LwlFcg0f6HujjJOVXRYTx8QuB2tt1tdGeB0TwNUrpCTH+fl/dUDLi9VV8+oS?=
 =?us-ascii?Q?H+I9x+mHtIYPgD+Hxvk7F7fCSPV7OnFMKV6x7LMQctbiT8lOID/6XEcj4qbT?=
 =?us-ascii?Q?KRcWFkWB70oWIWRYbuHcwByfLawjLAS4jpcN1oaYxEkSVVMJGnFyBDOWzNyy?=
 =?us-ascii?Q?6HnzVNnLJXMBtyW0xnR5jpdMInNEpQ+21WxjRGwDrpYrETwT9/8C9jxnPijS?=
 =?us-ascii?Q?4KMMKDn7al9SBFz/i/VjpM4s8Xyg9vgYovwNkXi4qgKeqMTZqfkWpac3B6ww?=
 =?us-ascii?Q?h8lfFu5/YqaSlLSci26FACOJB1EmT0D7FsjBscTfrxfa23i5ZYYIzQQjFfoF?=
 =?us-ascii?Q?eMEqpJNdA9SllZ+OWvQYwa1+uCMM/2L7bWGczgcE2sd6OUfahE+XoITTsPZs?=
 =?us-ascii?Q?142DEQUT+TGzNGyuSnT7Btgf5WFbE3p+R8IxW9C4sGbbNJr+aIBM966+fBVk?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f58ea0-1076-4618-652e-08dc26b62f77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 01:51:50.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfeJUcujdYIwSQYvrzKezzvymt81GFrOnFkFFoJYXEX2VO2Odk0p2U4b9dL8R9ogvSr/bpyThRgAs4Fk1L9RlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620


On Mon, 05 Feb, 2024 17:41:52 -0800 Joe Damato <jdamato@fastly.com> wrote:
> On Mon, Feb 05, 2024 at 05:33:39PM -0800, Rahul Rameshbabu wrote:
>> 
>> On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
>> > On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
>> >> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
>> >> > Make mlx5 compatible with the newly added netlink queue GET APIs.
>> >> >
>> >> > Signed-off-by: Joe Damato <jdamato@fastly.com>
>> >> > ---
>> >> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
>> >> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
>> >> >  2 files changed, 9 insertions(+)
>> >> >
>> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> >> > index 55c6ace0acd5..3f86ee1831a8 100644
>> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> >> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
>> >> >  	u16                        qos_sqs_size;
>> >> >  	u8                         num_tc;
>> >> >  	u8                         lag_port;
>> >> > +	unsigned int		   irq;
>> >> >  
>> >> >  	/* XDP_REDIRECT */
>> >> >  	struct mlx5e_xdpsq         xdpsq;
>> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> > index c8e8f512803e..e1bfff1fb328 100644
>> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>> >> >  	mlx5e_close_tx_cqs(c);
>> >> >  	mlx5e_close_cq(&c->icosq.cq);
>> >> >  	mlx5e_close_cq(&c->async_icosq.cq);
>> >> > +
>> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
>> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>> >> 
>> >> This should be set to NULL *before* actually closing the rqs, sqs, and
>> >> related cqs right? I would expect these two lines to be the first ones
>> >> called in mlx5e_close_queues. Btw, I think this should be done in
>> >> mlx5e_deactivate_channel where the NAPI is disabled.
>> >> 
>> >> >  }
>> >> >  
>> >> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
>> >> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>> >> >  	c->stats    = &priv->channel_stats[ix]->ch;
>> >> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
>> >> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>> >> > +	c->irq		= irq;
>> >> >  
>> >> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>> >> >  
>> >> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>> >> >  		mlx5e_activate_xsk(c);
>> >> >  	else
>> >> >  		mlx5e_activate_rq(&c->rq);
>> >> > +
>> >> > +	netif_napi_set_irq(&c->napi, c->irq);
>> 
>> One small comment that I missed in my previous iteration. I think the
>> above should be moved to mlx5e_open_channel right after netif_napi_add.
>> This avoids needing to save the irq in struct mlx5e_channel.
>
> I couldn't move it to mlx5e_open_channel because of how safe_switch_params
> and the mechanics around that seem to work (at least as far as I could
> tell).
>
> mlx5 seems to create a new set of channels before closing the previous
> channel. So, moving this logic to open_channels and close_channels means
> you end up with a flow like this:
>
>   - Create new channels (NAPI netlink API is used to set NAPIs)
>   - Old channels are closed (NAPI netlink API sets NULL and overwrites the
>     previous NAPI netlink calls)
>
> Now, the associations are all NULL.
>
> I think moving the calls to active / deactivate fixes that problem, but
> requires that irq is stored, if I am understanding the driver correctly.

I believe moving the changes to activate / deactivate channels resolves
this problem because only one set of channels will be active, so you
will no longer have dangling association conflicts for the queue ->
napi. This is partially why I suggested the change in that iteration.

As for netif_napi_set_irq, that alone can be in mlx5e_open_channel (that
was the intention of my most recent comment. Not that all the other
associations should be moved as well). I agree that the other
association calls should be part of activate / deactivate channels.

>
>> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
>> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>> >> 
>> >> It's weird that netlink queue API is being configured in
>> >> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
>> >> leads to a problem where the napi will be falsely referred to even when
>> >> we deactivate the channels in mlx5e_switch_priv_channels and may not
>> >> necessarily get to closing the channels due to an error.
>> >> 
>> >> Typically, we use the following clean up patterns.
>> >> 
>> >> mlx5e_activate_channel -> mlx5e_deactivate_channel
>> >> mlx5e_open_queues -> mlx5e_close_queues
>> >
>> > OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
>> > That makes sense to me.
>> 
>> Appreciated. Thank you for the patch btw.
>
> Sure, thanks for the review.


