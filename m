Return-Path: <linux-rdma+bounces-917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B622B84AB82
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4021F251D0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFBBEDF;
	Tue,  6 Feb 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ne+iUHiZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D71367;
	Tue,  6 Feb 2024 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182567; cv=fail; b=JyrnjQKTeanxbGaS37MvzbmS+Ze2bNbXbop1iX+8b/Aacd4m/Q4jDQMtl8TvONZTh0HhhcuiNTsNyFyfLzs3DN61XY5vD7Hl80M/MHXRPfKLWQjnw83I9i9fk5GdYa+szw/jQP3F00SzJ8/Y4XHWFztvFR0AKuZ+ceiaq8AtOY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182567; c=relaxed/simple;
	bh=KPxH932D5aarZagsSvsU+T6kmmt2NqApFbHRPTg8eWA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=CLin55E6rdE+wXOpFOQfL0+imNnkNzKavwV3EOWggzCp+/4nLJizP24IdGNsk+Top0oOPldv0TUoqezdQg7MMCgaSBDiS0/qt7DV9rdKrSJlKPp3CW3Z1RGmyPg3/lZL0d2nED4gG3nyQ+0CrBIu0THecVPmuTYhbZxPYDH6JoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ne+iUHiZ; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YE8JB/Sdi/xZTwLSAHQApVzJlg6Q3GJldXaz24fhLWL6zlanJ/9ueNhumqHGrDtLN3p0YG6MojnTaqrXgZKRgvWsoIaC2kJdKvjY1ItCBMs2ZFwKHv9idqzMKkelI4DVYhKpm2N2etdlyTKWdR2TkivxOlPCzlL7Kw48QiCbZStu12aVmLV+o4gJaz0Ct5w/wgJneZ1Vj7e4bAnGqyoeYTYLXxIdrEWJ66tLLUFuXv0Z4l5GwswaMbmZKIiym1OLIRKu0ABQCVRkj4bA9qNr+rb/CBb7mCI5AFvXMSNvIgIQ+CUjiyNJBFHcx+g8AaJDv6jYWjOEzqsYImyARiLRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvB/IEHbVFkI3qckMxqWc4Lu08MrfPu+XDhHl0ORfB4=;
 b=Qw+UlaPm9RE43hFuGOKDHXXD+7r4M6de4Xr5MLrAHWA3QZHGlfUr/z8Uydp1kfSWN+9Z0oGjJyb20jyMuZ4iViKSrHX+kncq7lVPj4nZpCPSa9QqO4khXxk1jVkWmeCDXDUP82eqBuCRHgSeHu5TvtaiLT8gdbB2XkahDKIzHKuO08gr4+4WpjPT1C3FugFkL09XtE87UobqclQE/tC2LfEyzFnzDvt1YRTb6ZS96IlAWr5lO+xRQsde8vU/ct/7xtfaqaMlU8ens80UuUzrGjTaLqPDA3P/H13lYYfcM+o4qJRJsTu/yAQFfVNUXHYaXeDqspOWK5QU00XKWlWr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvB/IEHbVFkI3qckMxqWc4Lu08MrfPu+XDhHl0ORfB4=;
 b=ne+iUHiZX7vHbOK7MzVW6Gx+fOSieg+DXHbXH8JYlrFBLPljnqQhGdjJBYE3kjTs2wI4evgFxt1TWwKYZHNEX8dAJWtIj9cOHzXWaIfChJp1YozLTpBWTxaWxd/rV1gWhCQuCdB+gFiCm2S2npm8ElwAazDTVyOeaeune7KkUoVsk5YsfmjcbHYDHZDQUmGl18RKZqCAvxgmkEYhLO+Atk+ZF9yMaC91jAd+pNeWXaoDFL0xEFX9nJXAbtCXBkwAW7Cc73MUWLprO7Uk/ExRP31kfnkcPk6Td/bQGRHqRyxAAiEgFStBO25oBSnRwKSbVUcmnOZDm9IbbJGK0eAbaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 01:22:42 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 01:22:40 +0000
References: <20240206010311.149103-1-jdamato@fastly.com>
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
Date: Mon, 05 Feb 2024 17:09:09 -0800
In-reply-to: <20240206010311.149103-1-jdamato@fastly.com>
Message-ID: <878r3ymlnk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 0987e9a8-e730-4ff7-eb9e-08dc26b21c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4DUujeejiqkoH6DKoKHw/1Y0aUFgdTy+/5mpD27/XY1bnTMtRlHW2CJ2MS8W2/W1Qi8kinPOEVz4vxavGj3Ssun9aeHFmFr4fYh1BVKpnBwOvUGR8IATFjx0LXJtNKuAOK4bD4r6cIey6+QHc/yzH+OiM8iqzg8umtj0lKOtqO+aLkHQi7wwzFiZNNg7b3rYlc/Vxp5wRBnPBI7zrDFz/5JiAskY+xu7GMeEZswRV6CipW30YBaO2rq3gUGX+qCwhbWjnC0bR1qVazch04XgWG0xI85UwrxUYii1Q7fWNIGmHp8cmxNcfKuAxjr1yG3d8jwOw4Kr6C1YMvfn/QfNtUbyqHJnWTXSIoGMQJc5hPrQSK6KU5hDN6RuR4ZZbRy0UyrDp5pwDSkcUPUxwgR6/BvKS9iDXjXpsjsSoKLVp34IASd68vhhkehQlY9lfuUI65ABHV0Cxc6jyuW7Tewv7DQIXQ8Rl0PIp0wzFMT030LnXZfseJQ5949NuOCuQOuXGg59G9xKKGqljDGmhOD9LcbcuI8GStNOhrY3EZ2tHjRmR1wMXnWnag9m5wsuG/Om
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(6506007)(6512007)(26005)(38100700002)(86362001)(83380400001)(41300700001)(2616005)(6486002)(478600001)(4326008)(8676002)(8936002)(6666004)(2906002)(66946007)(6916009)(316002)(66476007)(66556008)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Fhp2xbuTfPnDg6lZdx+HF/zWsbML2wlxLd1i7NvtL8CBSZBHYkisYeHC4iU?=
 =?us-ascii?Q?3qbYA5q5B3D2wQYTNkco9Jf3mt7+i2eSVPcR/8eyFKxWoGzuWKsoJyvrgG39?=
 =?us-ascii?Q?yhQApMBjxLh4lqHCsMcvDy2+Fm4ZETJz7ECz97x5MN8XAQdlGOuyWyZVRsHn?=
 =?us-ascii?Q?19SjJZVL1Ij7FnLtEQKEf7lM9PfBAZrw+X94zc3Xul9sPdzdzRBxTwimsFiV?=
 =?us-ascii?Q?tmnCitaESeko4tNjzmTrZY/WQ/cndv5uncL7WEhwo+vIFPV8UIoZPEXUSGeI?=
 =?us-ascii?Q?/UncGb0dWfVBeRKZLM+oftqRb9RjjaWjNFpD40HXHfVTQ06qFANd9MmXeXA4?=
 =?us-ascii?Q?MUcjzt/03S2ufFCpJq0cM2HCUawmA4n8Z+QhW677XTPaY2V3tuNM+mLUVrrZ?=
 =?us-ascii?Q?AxrYHn6RMmhd8QWGGPoz67TP2zjOnkBDDOKmdM5V4cdIYM6zmPb55/srT/Ag?=
 =?us-ascii?Q?5pg65nYT9PY//Ro+mNn4749xk9BlXcT/bm8cm3C84Ual8vT111pSxridOvMg?=
 =?us-ascii?Q?Sb4S5W+TWZiN2oRaPzIVP5cBrxwKWKClfwT/s+Klx5DaQZMGT2Xr1oEp8E/q?=
 =?us-ascii?Q?DeRyzNMxb4MiyrXUZXBfRsjr48CBCsZkzA6ChOANM5e64+6kuqE0KMHM1SCY?=
 =?us-ascii?Q?HiqTyNJITpPZjgzBr0MFqNOc+KjhPUCDaXx7BuMLJRpDWQXIQ8SOwzDCjrik?=
 =?us-ascii?Q?c7WFN7mV4SFomytksbEF1rjfeyJRHLYxnyp1oZaBzzjwcMWggcd5sEsUZ/L+?=
 =?us-ascii?Q?4VOZBh4tzT49o8Rlt1QGhM0sZq9XI8nc2wVlefEkrjocBRr7iO7STPgg64zv?=
 =?us-ascii?Q?7ElsY2jckF0fZfZAVpe4K6t5Z3C9/lVkEWQQzFFWGf9NUOlVVwYV6yZRwAXM?=
 =?us-ascii?Q?JV1rpkVd6WxCd8SqeMO0U9S8mgqgNx1uEC9i2yOQxSZHtJzr8CG5rb5Lfvj2?=
 =?us-ascii?Q?q31LofXhP+nJDWAP9DXXDFJ+Rr8qm3qE4Ep5oiJy9Zt0IFMLIPmsx84ITcl6?=
 =?us-ascii?Q?fWb+q8RDw9H/qKS2cKNlmJOaFBUoeCBk48Tgv72n1sWFCXZ2+xIZwECNtjXV?=
 =?us-ascii?Q?XJXXrckXaKjQ26ZQeRweTLav7bERySQknzlYgNz41bQ8ToaENbr/kMFWvTYs?=
 =?us-ascii?Q?E4/ncQjSM5KLePnGoBE+9rf0NXhSQsz36nr4zc+06nmURBsfVi6I26Db+IqP?=
 =?us-ascii?Q?snlNb7+qp2AmzRWirCAHjIV3NQkxg2pcDgmNoa6+c6wnZkt3tSase6j/Ti2J?=
 =?us-ascii?Q?RXSvKvZKfUAml9nyeu3X4HeT/6Z3zmSYTsw7Qhoo17JkR82ooPdCegWKFG0i?=
 =?us-ascii?Q?zWySuLYJE2zV+8e0QiNDIy7HJ5vyE9myTs8Gxpaz968zuzQ33SKZ5WPsgNTM?=
 =?us-ascii?Q?FCty6EUgUIet3WB3T32eU2EX5ajYRrEM2cLMCjxCYlNidDgjLvH9xqZ9RZh8?=
 =?us-ascii?Q?uDEYwQ7LUHv4+KEpGOi8cRocu35fkT7hSbPYNediNSen+AvRCmiFumkJm2P5?=
 =?us-ascii?Q?qZci3zuQTLkX0QIIsScaClea7WAIHm1CL5ZFiiaffldLj7NLechqn2id25gh?=
 =?us-ascii?Q?Gs8cDZAf8XMjX9WGXdi/KntECEQHABCTBGfvHk1T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0987e9a8-e730-4ff7-eb9e-08dc26b21c56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 01:22:40.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDNw44zH2N3wBIbk143MpCN0RUogN9QoKJ+Y194NaVUag8T2FzG5yRZsYBe9QQB0AROopJQXb10LLD8kvJRmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 55c6ace0acd5..3f86ee1831a8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -768,6 +768,7 @@ struct mlx5e_channel {
>  	u16                        qos_sqs_size;
>  	u8                         num_tc;
>  	u8                         lag_port;
> +	unsigned int		   irq;
>  
>  	/* XDP_REDIRECT */
>  	struct mlx5e_xdpsq         xdpsq;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c8e8f512803e..e1bfff1fb328 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>  	mlx5e_close_tx_cqs(c);
>  	mlx5e_close_cq(&c->icosq.cq);
>  	mlx5e_close_cq(&c->async_icosq.cq);
> +
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);

This should be set to NULL *before* actually closing the rqs, sqs, and
related cqs right? I would expect these two lines to be the first ones
called in mlx5e_close_queues. Btw, I think this should be done in
mlx5e_deactivate_channel where the NAPI is disabled.

>  }
>  
>  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
> @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>  	c->stats    = &priv->channel_stats[ix]->ch;
>  	c->aff_mask = irq_get_effective_affinity_mask(irq);
>  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
> +	c->irq		= irq;
>  
>  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>  
> @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>  		mlx5e_activate_xsk(c);
>  	else
>  		mlx5e_activate_rq(&c->rq);
> +
> +	netif_napi_set_irq(&c->napi, c->irq);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);

It's weird that netlink queue API is being configured in
mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
leads to a problem where the napi will be falsely referred to even when
we deactivate the channels in mlx5e_switch_priv_channels and may not
necessarily get to closing the channels due to an error.

Typically, we use the following clean up patterns.

mlx5e_activate_channel -> mlx5e_deactivate_channel
mlx5e_open_queues -> mlx5e_close_queues


>  }
>  
>  static void mlx5e_deactivate_channel(struct mlx5e_channel *c)

--
Thanks,

Rahul Rameshbabu

