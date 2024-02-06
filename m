Return-Path: <linux-rdma+bounces-919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF584ABA9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F381288D17
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9481373;
	Tue,  6 Feb 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjIRBoo6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA11109;
	Tue,  6 Feb 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183360; cv=fail; b=M4+j3aJ/sUciy21wbsUlsfjKz4sM6Fv6xaM0T4nX7OgNSgiEfiMkWhLJ9upFl6chw3kXvNvPows7E/nY7KOznf5RQkXrkIFejvZlwd4MMkEf1+GWwHsL0ZKtIH6NYxvkAH7+iGR9NzQibGqbAI9lE2b7Dkysy72NHOBkQCIiYs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183360; c=relaxed/simple;
	bh=pkHodM9lmzpkbdkkC4UAgp6J1FoiW5Iotynd2FopS+U=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=skqr8x0WnFo32FywYY4KF7WH5yhrGN/K4V29G0n5yXK96o0myo6hfscRFxeY8RCLKvFaTBPPN9ca1nBeK4QRCTQ1Ey11ziiRGG0CQPyfbANmfRxC3fxmaLQlsI1xYI4MNPw/SjEXgvUeFnIe2sjgsiOKpLse7foNcwKIIYFeHWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjIRBoo6; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnnknzTQRWO3fo9p/AMZUqagyWx4yAJ0Y+fi1creTYWgcgKE5nEgoEHeamyy3BHLkUorz1qKChclknGdxzB9Kr7jMRvvl4IdN1tbB1+WICAsNIkeeMc94bvjExQAMtiOcb6HEF+hNC9qYgIPpzhdiSgvt4JiO21Fn9pLL832GCUS/btq5Oodu0BNNw/0IOTAv+bnMKfcDxKvCxMehxXw7pMC+v8nSL+tQuuZ1Dm/s7kloOzf4e8MW1rP5jPpP+X0TOYS7rqSFu3yDZcdWMUoJCQSrIGCCbmuPOmUaBtCS1OnYyRu3o6+XZOAAOn7h0KZeEjw85foKgmDkYn/pVcapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cXwBabEzo9lDMmgPMPu3A9MYLTjTIdoOpgYkHdWarM=;
 b=ALvZVmkuUGr721+G2+O6R4bJ7nH0UQxq6p42tGHMBxob/Kt5eK1sFUp7aw2kCXbCQeqhDufEgWv2YV4Fhos8u9Xz9tXCpJG3aCZGD5UmT60oUwAUsw0PpRkO0Hx/ucW14E5a9+QPhlGcU42Ba3NzFJWcb1jEWUIO3u4pVqVwUnFzFktnfPAHVKvLEpxXMLQjz2GKGM27CjTwUcDOtzralAglQ2iGq0ZlBDpckBK2sqen949NIvDc89tno/u/0aMcpSPaULfr2pHgBK2oYSM2IfoEqjz9kFFd6kMa2MnwYaOdQ2wqh7lurE35ZtWlC7xTZWQ/PGg6OkPnhQiPDNBukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cXwBabEzo9lDMmgPMPu3A9MYLTjTIdoOpgYkHdWarM=;
 b=qjIRBoo6da4hj6jPW5XWnIQa1khYf73e5bha4ISUMiQp1Emh8j93zt5cwK+7z3rBPbn9HJPdOwyrX8iAyc9yZdeCjd/rwGtke+Xo1SCOwC0r6+dOqK2gHPmldoOfgQ6d7TS6OZNNtFBqdrTsrk/My9FrM6IXc3E5Wc7PjtfgG2nT90a+ltKfUUQEKz5OUOha+kVyCVHkLnBiWsga771ou7gVws6CJwBNOpqHcrxtQDmtT50h3HgnTJbKoj4DsWY4xvthKsH4DehociHbXbsUUTjyH3Qj2LLpXoXuSTmfexIgSxgEG1KpqFuSfoKjvWKbpbqQt5uaDX5D3cTMDaP9wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 01:35:55 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 01:35:54 +0000
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com> <20240206013246.GA11217@fastly.com>
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
Date: Mon, 05 Feb 2024 17:33:39 -0800
In-reply-to: <20240206013246.GA11217@fastly.com>
Message-ID: <874jemml1j.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bf21fd-e4c0-4740-6c52-08dc26b3f57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dm4aZ0tzgxg8DSAnKZ9GG0Mxo9bz6hdb4+mxsO2SR8A0VWjqS87df6VCNbHR3kQjPfI9FGcS7TcdtVm5tvSCpg2yrqP+rPaYl0vvRbGOrn7yCiDg4WMM1VaPInBPcPMmILYYkt1wB3mKPeAiHWm0TADwxrtou/nfPntxv5qYcJNLn82xMl7nNLQIfdOdZ459TxHUF8i6/9tUxQ6KOjIFChLrKi1+8iAVaTdzSNvgHyIxoh94V22GPKY1Ug4oWwNfipG/qqhy8gSoR0FM4XE0mGahEHA5FhN77NQ61WvVJAr0ywrqSu6swEQa+cp/+XHN61gCmNiqMOEDfDlv57/Yc0pQpXnz1Oxz6f6RRhZrZi4hutZV+rYUvid4MTwTB7BcftpbMVLgoyZrrsULMih2uJB9npCtwqO5+uZnI5FOCPq55QGJrSRRIjpAOyIb7vt6yo1NDxnTUKKaB0D3uEDmdOhQZl3GInc25r6sbWworcpjI2To/Gja48uou98anr5+zigVm2GwXo4gPuP8M6iHa4WGw0lpOcLHW6QGPYMN/5b+0EMpxuV/xENO6XtP9PtO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(2616005)(6486002)(26005)(6512007)(38100700002)(86362001)(6506007)(83380400001)(41300700001)(5660300002)(54906003)(8936002)(66556008)(8676002)(66946007)(4326008)(66476007)(6916009)(316002)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wm6rEGaxkZLnhbewWV+uxklrR1cQjwgiyCeqeXW9fQENySC2iwukEJpUuCUy?=
 =?us-ascii?Q?uNFdPytiiPJet6Ar7D8oiRoavH88FH9cYu7bJIw1heJbn/2oEupzW7yjVD4K?=
 =?us-ascii?Q?2uaV+Y2ZYweiiKYGbgvkYfp2+xcDXWZa6Wv0l9jWg8Qr88Qq3m7X/B01eLZP?=
 =?us-ascii?Q?upPZA5GbibtvBG8XGPH2fIR2lD1Fu7U8xOn6zEV8FK3S8tnmjfU+ExA7QfMb?=
 =?us-ascii?Q?c3ngEvgd6BGBmKSl6fO1sSCzS0xxdh2nKyy3g0ZLeQZwvezwg7cxm3Mu7qTo?=
 =?us-ascii?Q?wvnhUDLIobYqjm039lYXizMxNvLWtCZ1hMTn2QgEBLemHSIm7a60+WzEtySK?=
 =?us-ascii?Q?aWaVFG7+jPYPx4UhZliunXrCTWONxMCfdxTehlbIdh7R2fil6xaanwLe1ABh?=
 =?us-ascii?Q?uq9G+c1KOuhbJZe8Ht81HgWPmBw7m+VtkpDLA9lcdC52zq7CjCQqApd8ChxX?=
 =?us-ascii?Q?wK5AL9RpoVnoPsfM6VESwdgVjKLdTUq5fpUyYxMNhBntWNnxi6uLjilaLl4C?=
 =?us-ascii?Q?sUdFZiwoWem4F3L39ptLExnQHC+PIEhVfze3sU6saPUG3oh4VORx0H65bKeY?=
 =?us-ascii?Q?q4h5BbrDq5i3XSl9CTJFy0FGzV1tv2YXDvjUlmanSFQbIEEb74J+nqRg/+EJ?=
 =?us-ascii?Q?iHsQ3w+6ScL4JP0ZiWcg2n1xNk+NOFwJ36KoVADTMxA70LrquXH3+j0pramj?=
 =?us-ascii?Q?rCk68j0T2o9OBraKTteL8mr5Zyj2KmFMqTS/AjizDtDEsgbJU+2AgHfFh8Cz?=
 =?us-ascii?Q?Ir++sJVBPZEgqU5VQCU1ioTwQRcLiNBxWlZ53qycW7kobpym9GQsC1PAuLYI?=
 =?us-ascii?Q?wyvaVUlAPC0MLe2ful7mDXMfCBtBv0Jm5dp7AKTsl7ecDr8uT9xznGGnTtW8?=
 =?us-ascii?Q?YGZuXofVnNP6ZVaCMDlyyN0wOL/wjLIS1ZztSKcoMBuMndn6AJWh1uI00Bfj?=
 =?us-ascii?Q?ItYcR833Tfic+Iz4YK+QaoQncMKbnt8EhXeA0SXQO5YOjiAmxH3r2+V26pWR?=
 =?us-ascii?Q?qPTZ1jaTXAHnS1qX+B4BfsZ15W+y+4/kxUGWvfe+o+owOa4ydoIp8dggG1Vh?=
 =?us-ascii?Q?jmmdFhyZgc59aSMTLW2kxUEPB7NVhAixBJJUq6XHB/2ffglE1SShDW8+UM51?=
 =?us-ascii?Q?NcQ8jDq25zAdSl2oPlXox3gdO4x5q3h6uFlhCmIhQZMEpRiY2TlmIVnNnBwx?=
 =?us-ascii?Q?QhgZma9KXcsoPhuehS+XOK8RxiTOhYKy8YQ7aylYxwIKg0vA6JSpz4YJcYkp?=
 =?us-ascii?Q?C5Upt8JhPmHZVbyw4Uy6CedM/ptq2VNIEi4bxmnq8HxCtITbNfVjGZBBHqW/?=
 =?us-ascii?Q?BwWbPJTxQUfTyEEK6POvQ57/7gVapYo3SV8eFwGKW4fdPHt0vNTvky3QIUn0?=
 =?us-ascii?Q?zl79c73wf+44Ify9ysyXN7zujJ1dPMgQg1pWEC0KmgbpgKzJbzEWRYfmH6cf?=
 =?us-ascii?Q?Xws5bPj6PzXCV7IZJUzj06iZ4BS+KvT/EsvWKBQaaOD1qI3IWkXfiJUFrNu5?=
 =?us-ascii?Q?Jopn6OHhuEf6XcK7Yn8DcPL5iPyS3N5DD267iLbM9mQZZQIl3v3CYgnAwxR8?=
 =?us-ascii?Q?RKXsYiMBBPc28rZ2P8eAdn6hIWcdaVl1exmbcJMX1pzuCTzJTcrxyN3dWugr?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bf21fd-e4c0-4740-6c52-08dc26b3f57f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 01:35:54.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16H0g9MZlxY+D88FpEdH/UI6NLjemm8nO6xypQI+q4PxEWNBvosdTKDS7uiBcXo7D0G7czc2DU8Es9oNU12wXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225


On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
> On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
>> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
>> > Make mlx5 compatible with the newly added netlink queue GET APIs.
>> >
>> > Signed-off-by: Joe Damato <jdamato@fastly.com>
>> > ---
>> >  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
>> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
>> >  2 files changed, 9 insertions(+)
>> >
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> > index 55c6ace0acd5..3f86ee1831a8 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> > @@ -768,6 +768,7 @@ struct mlx5e_channel {
>> >  	u16                        qos_sqs_size;
>> >  	u8                         num_tc;
>> >  	u8                         lag_port;
>> > +	unsigned int		   irq;
>> >  
>> >  	/* XDP_REDIRECT */
>> >  	struct mlx5e_xdpsq         xdpsq;
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> > index c8e8f512803e..e1bfff1fb328 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>> >  	mlx5e_close_tx_cqs(c);
>> >  	mlx5e_close_cq(&c->icosq.cq);
>> >  	mlx5e_close_cq(&c->async_icosq.cq);
>> > +
>> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
>> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>> 
>> This should be set to NULL *before* actually closing the rqs, sqs, and
>> related cqs right? I would expect these two lines to be the first ones
>> called in mlx5e_close_queues. Btw, I think this should be done in
>> mlx5e_deactivate_channel where the NAPI is disabled.
>> 
>> >  }
>> >  
>> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
>> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>> >  	c->stats    = &priv->channel_stats[ix]->ch;
>> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
>> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>> > +	c->irq		= irq;
>> >  
>> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>> >  
>> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>> >  		mlx5e_activate_xsk(c);
>> >  	else
>> >  		mlx5e_activate_rq(&c->rq);
>> > +
>> > +	netif_napi_set_irq(&c->napi, c->irq);

One small comment that I missed in my previous iteration. I think the
above should be moved to mlx5e_open_channel right after netif_napi_add.
This avoids needing to save the irq in struct mlx5e_channel.

>> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, &c->napi);
>> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, &c->napi);
>> 
>> It's weird that netlink queue API is being configured in
>> mlx5e_activate_channel and deconfigured in mlx5e_close_queues. This
>> leads to a problem where the napi will be falsely referred to even when
>> we deactivate the channels in mlx5e_switch_priv_channels and may not
>> necessarily get to closing the channels due to an error.
>> 
>> Typically, we use the following clean up patterns.
>> 
>> mlx5e_activate_channel -> mlx5e_deactivate_channel
>> mlx5e_open_queues -> mlx5e_close_queues
>
> OK, I'll move it to mlx5e_deactivate_channel before the NAPI is disabled.
> That makes sense to me.

Appreciated. Thank you for the patch btw.

--
Rahul Rameshbabu

