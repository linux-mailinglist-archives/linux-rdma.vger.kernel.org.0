Return-Path: <linux-rdma+bounces-926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB984AC95
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 03:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D1E1C24134
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04B7317C;
	Tue,  6 Feb 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y21gOgqz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E46E2D0;
	Tue,  6 Feb 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188318; cv=fail; b=WNT3iXAPX5FW57Rq7ZAdBqXoSCAo+y7euaZlUk8dIADLeBopS7K+vX/eqgXaZMTDImD6Yr/sR5fdmDfDuAaSqczM7JtQMOR6BFPUj2WQbCajR0++kVLR7b0M1o2D8yyiL8dwzm/ddVOjb6N7hwewmiD7jIRWKOhT6vYOjvxEn0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188318; c=relaxed/simple;
	bh=zym+UZ9HvNw+7bpSide0NsXwc6itk3aewxVhj+kSL4Q=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=sryRRgfyTe9OOLOeDqLfsnwuWUypfIeoGpBaXcserxOmYZV4K/nmPVGM8kTyrkYFbMvS889dz5FFMI91GsQjz8Qa3fEQ6G+XmSSIvgt42vDhhOj5Lf9yXkhi0PK7ilzO2U63i3yHSvbT7p8ngDjKFMHO/IdYwjvCWrJzUkTVz1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y21gOgqz; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaapRGEJA8+wFVkq4nRLBX0szITiGyEwlLb7Z6c6YJl3Z3v3tPMxjle31L6iQ0rq/oXZucQkflWcORcV9bDRu922U0L17PVSHSqMleedFykKeH/vgoOmq+weoUDD3knZGBkGPypnJ0lc8N+sUk0W45d3N344CdkQQzQvMBmn7viICXcw/MSnHTCOPNzwC1xinINzZUbaqvG7gWFNBm5KwU4j9DRgB0IlTFAPRoDL5yNlvyeBVtdOEPl5YAo3JzF4JBzR4MO1+W4Fi6VezML+A4U+7KO4n9QbXJGV4bvE6XUTJqx08C85GEIkNkEdhQO8cccpgjU9VBmD2JE7p8KcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9W48bTm7CaPzZxXhn/mG8OUJdcHLIVWdvEIlJH67tE=;
 b=V7nnuRc5I9xd1M+oR8SkdC4PSCl8H1kMMm/C7ePPZuikajCdHRr71Xplftmf0szr6ecb56RG+cE5MzcpMvqttDyyIAL/HB0jVDinf9NUtsZsGYZhaW5M0qfBr8nu9VV8T8JqPtMceIeAwE+lFmQOk0Gm/c236uK5mmWFn6Hp4qnlN2GKs4ftoP6e7URbllikfMxtAJg5b85Fc1nC3f2qzpsVFJZOKP710leypSXtMyhdWWOkcG5j25nYATI5R271eiRInCkST7Q1Y1Nz+BWtvpq/7KdCLeJ1WCORaM5/gjoqfOXvcS6S3eZ9qpFcN+pBIfHTDaMzV9ngpuipFGOdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9W48bTm7CaPzZxXhn/mG8OUJdcHLIVWdvEIlJH67tE=;
 b=Y21gOgqzHs72+wNgXjNah2kKTmcy77A71LaCRSzv+DKboq0h1+kCOtdbptLI96otOhMZC19Tci1cZ4LEtI76HI05Rabnuh7NVr1gDYsikaQbouCe9LHJUAZ3HyQaiu6tzrUVlhqkChLxqWOorYk7qpdWBXLbit9WCjSQl/D4iWrRmZ/1h0Uo/G5SvJia+YO3XASh99xvNlml+2kRFHM5JuGFdsnJzqZZVKlYsvC9mw1auvgA3h6PB1IggFCvoIpBV5NH+N1JjmEHBhQfq166c46VNZFMHdHqQsUT7dWx668gEXC66pQ9h0hsBHOZPwhgGEkigdpAZuaMmZrGtDtFzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 02:58:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 02:58:32 +0000
References: <20240206024956.226452-1-jdamato@fastly.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2] eth: mlx5: link NAPI instances to queues
 and IRQs
Date: Mon, 05 Feb 2024 18:52:45 -0800
In-reply-to: <20240206024956.226452-1-jdamato@fastly.com>
Message-ID: <87o7cul2nf.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a56818-36f5-452d-e7ee-08dc26bf80b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJle3s+kVBifsKYHvydKwxfzboLiE3rFL0rBH8JMS8qcXQOgi1UM45EMXMZKZQ+k/XGXJ9Ew5jS87VuCi4w477g7hxe09a5f0u0WSYdRZg4KknmSQueteHYAHbx1FWo+yoe1G5NF6b/CV9jhywc86munM+P/yLE4UYWE3jhpHQOJVg+ZxpCQhK0HXBm9XsORq30HZy4FRaobV4XDaxnsZD/RHiuSDdFfNYG57O20dNWl9VOEGd8QZzsguj9TjF4l7AgJLMN5CGmRqXU82vspYKJosYwJGaSJjOC+cmLTryEwd+nAmNunf2z5z4s63iDN8tnVuCPkfVrHSSYk6E8C0VollivJw+UJOR3LZYfxQRmCHqcXLHgaCMGr2XnhvuIm3TeeVu8CNEHcge0B7cTKuBRQAceQwU54XHnnxnd51dEzKxomkBDYJv+48OZuVWqbSSQVJi6Lahz//bPADDCWCrvIz2n0NB77jF+pO+98M/sLiuc60s0ZYFV9zNc8UkHOEE1RbtaD7kRU1OLWiIkpVD9TlBr1IZ8/bdW8b3hACGlmqG/k25NWrgR8g6jefqhEgyw7WtlH3taKuBdHaCg9kJPt5/DLfF5Hv5Yfthq1uTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2616005)(26005)(6486002)(41300700001)(36756003)(38100700002)(966005)(54906003)(6666004)(6506007)(478600001)(6512007)(66946007)(83380400001)(316002)(8676002)(5660300002)(2906002)(86362001)(66476007)(6916009)(8936002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6schq388WSemHouyHwoOVJeKXZngJ6tbL1rYW1fVNxaboLxBKWP/4C1QP69t?=
 =?us-ascii?Q?JhGIM4yfDEw9DASKtEIJoNrHOc+mT0veRpJj3mbjVAbDx6LWne/jS+3ujgd/?=
 =?us-ascii?Q?xqO/7cREqP0GGYiM6VcOZVvs9O1eiWiT3PNbiRdc0TPqLcdwou5t0mUhtP2g?=
 =?us-ascii?Q?b8cDeb3FyRfoHxmmDLZznj13GR2iaiDXKCLveF2q1+0Tk0oJeETTuyKAz2z6?=
 =?us-ascii?Q?2Zx8tCLJUsI4Lrd/8IjkCepuaUoaThojbsU0k37PLmLUcI9P6rryliRRO62K?=
 =?us-ascii?Q?1vJ7HY3QfOMIOfwnrd0eQDYqatOmxaN7YJvyvCnO2edTMTpDA2iuhQkwTh7N?=
 =?us-ascii?Q?X/7kj81eFrk2UT5AeEhMsvT5gYtD+wspZ0Hk6WHyIi5D0dbDmu0jlifsCPZm?=
 =?us-ascii?Q?tIh2droNjXwyCmOQTBp1VREXQu0uHaz3BcFZXGASvXEj3UGhTWKqaQ0c6NYu?=
 =?us-ascii?Q?cgtUOS07oFymlhoN4HlBsTaoUokb2KfaufgWzVEaclB+6GPqr9QUFClTBtJG?=
 =?us-ascii?Q?1UgfoVnNlOVjAOD5BGyAgtsxzlvVYo6ECFiT1AGYmUsUITg+yaXM/F9SiuKv?=
 =?us-ascii?Q?sx7NAUpVY0SW+uJIMlzN2f/IOnHasWE1nkdPQynLJuo1d1tErsKbLZMoMrGS?=
 =?us-ascii?Q?ok+sZ+kD0LQNEENOgLf88sXSPPTpgZLi32JP1xXIkn+pjLOlN6+Nnf3WBuLi?=
 =?us-ascii?Q?lf1gtV1wr7m0Xw8/TnQHPv9zNTZfba5X4n6IrD8RzBjTJ9SIzrKf626JdLAe?=
 =?us-ascii?Q?EuNFRuuYdl+CQtd7RIHFr9prWEuqMnpknDAp03BC/okxFnZyUPRfxbHk+qVl?=
 =?us-ascii?Q?fgfW/4BxjuPUWt2x9PwSDiz4VHKscQ1Jpj3JnzAjIrmUWEp/D9glVL5TCKMw?=
 =?us-ascii?Q?t8PWbtVdOScxGrEfwN3FuV2k0hgXSPXEL3NVSaV2XzwY8MrKGhL4sINSbzha?=
 =?us-ascii?Q?SP+ljCdAAjWLOJtB0AUtOh3IBYa2//Z3FwmKyjDHoJl3t14a7yMmGzoL6BBW?=
 =?us-ascii?Q?nWVeZ4Z1Vlp05Glu5ZESLetmCO4Ln+xfZc9sibS4CI36Wog7s/OXoaCReBef?=
 =?us-ascii?Q?P63ExrE9WFtrT+mMt6iQxek285KlRf3d8+jSIc6IZMWwMyWAf7ZGrJ2LI4V9?=
 =?us-ascii?Q?/tOraDkM4SAOPnfuuVUCcDj4vY+74JuCM/ayBtL3JQmDQuFt0aqcNYY0HuIa?=
 =?us-ascii?Q?Ynu+fK9niKtBHFgFQh/7XGDlbmnabAMJI1Npvy70O07BTz7GAUYEsrjH0cb8?=
 =?us-ascii?Q?lbWFEtlesExN8Tyj8LtylVlePBld0DTxbyWpM6JP/SiwugGFWOwq1013jPbY?=
 =?us-ascii?Q?+U1p6AbEzJOwvedR4cOOeit+HATlFuwzDuVG3eXfQoAvzd70YhDGcgzWKJfq?=
 =?us-ascii?Q?9Xlp/R/faYqN8G7gRNxO9oEudlhPM3r2YvSwTY0cYDWaOhTpwVldXst97TZV?=
 =?us-ascii?Q?HDjv53Hw9EUkPyfb0ZKFQ/FTRBOq0YDuJgTBzdp5kFDsUoBl5mJwY/+/Se9a?=
 =?us-ascii?Q?q4cwTC5J0k8ksJliO0GtQFG8S3tXrF82ufy/8kg9fShbJr29PmkgjgYgRx8o?=
 =?us-ascii?Q?Tu8KK6sham2HvDFD0PiZ+Ds+/6SRp5JnPU4k9KJ/M7n5ysXmbZM82m16YDkH?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a56818-36f5-452d-e7ee-08dc26bf80b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:58:32.1000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYYYDo+tDuEOJlM/qLR8bu/ksrUkBB7ad9VnAj0MFxobCXU+ulWiHGSRsB7jc2UVaXzpBHHbJjFotqFEN5gkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

On Tue, 06 Feb, 2024 02:49:56 +0000 Joe Damato <jdamato@fastly.com> wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
>
> v1 -> v2:
>   - Move netlink NULL code to mlx5e_deactivate_channel
>   - Move netif_napi_set_irq to mlx5e_open_channel and avoid storing the
>     irq, after netif_napi_add which itself sets the IRQ to -1.
>   - Fix white space where IRQ is stored in mlx5e_open_channel
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c8e8f512803e..3e74c7de6050 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2560,6 +2560,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>  
>  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
> +	netif_napi_set_irq(&c->napi, irq);
>  
>  	err = mlx5e_open_queues(c, params, cparam);
>  	if (unlikely(err))
> @@ -2602,6 +2603,9 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>  		mlx5e_activate_xsk(c);
>  	else
>  		mlx5e_activate_rq(&c->rq);
> +
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>  }
>  
>  static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
> @@ -2619,6 +2623,9 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
>  		mlx5e_deactivate_txqsq(&c->sq[tc]);
>  	mlx5e_qos_deactivate_queues(c);
>  
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
> +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
> +

I think it would be better to clean the associations before actually
deactivating the queues. Your teardown becomes LIFO/flipped order of
what is done in mlx5_activate_channel.

>  	napi_disable(&c->napi);
>  }

In general, the netdev community maintains a rule for not reposting new
versions of patches in 24hr periods to avoid these types of situations.

Lets add the feedback of updating the commit message feedback in the v1
thread into v3.

       https://lore.kernel.org/netdev/20240206025153.GA11388@fastly.com/T/#mcbf987c817c0d06c29364410ba8ab10b144c753d

Lets send out that v3 a day from now if that's alright. This way we can
pick up feedback from others if needed, but I think we are converging
here.

--
Thanks,

Rahul Rameshbabu

