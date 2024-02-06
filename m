Return-Path: <linux-rdma+bounces-923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D284AC49
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 03:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D43C1F22373
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 02:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA046DCED;
	Tue,  6 Feb 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTqgnV+b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1C6D1CA;
	Tue,  6 Feb 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187262; cv=fail; b=curkqP9G/g4ATYUAmAjABc+Bh2p9LIBkoDUTwaJD26Q67ukfdttZCjgR9jCP2IOyvKssG8MFUN17lJT/xszZBES+/hDBcFbT0EXo+lL3Ija8iVfgkhbys0NSVeiGhG1mcxgaYkKhmeTMgnAgjV0PaBUJv/2qAo4vMu6S/T6yhbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187262; c=relaxed/simple;
	bh=vNn/QlFpq3ggmyNs3bfO5OPqgDk9saRN0GJlwOPPyfE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=o1UCthAKMGbFH2N/bSFyHGhKzrFP3I+CvKOmkwo40KDtEffMLodbOVC7CduXG+pUSZOe+29o+FfTaFowesqZvewPHH5pzo2xT4/hui5sXyplelnu4/ZRjDzY7skobT44bwQvoKb08YePUPUaFBme94nBxN7TMipgFXezXxq+l04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTqgnV+b; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDSTbfUoI4Q04vRUOFFR9zRKnZfUrWjpHVZjjBkO+cEysYh95StA6xcr85gcy+Rn2uV2IzkuDWGtibyIhBxUm9f0WISNi5eEfl25A74pzg3Ddnkl73fDaTKTmZqa2jqzO6ZFYdkfp6ukQRSH0QkAPXxuHhM1kGZiI2HVz+5h3iOzr/Iva7amXZcPe3+7bhW42IXvo5HytrV6qjCzptO0rpMx6ZeF592e5cxNWYiFPqRGDcYqL5lWx7zG679drBQ289WpLhwOqdQhq9agMiKdHb88UOfHUxX22LKm/TBz8c58Zl/CIpL2jTCGmhFpzWPj+50sg9q5ix+4Ew4SfbHwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nott87pMpqPJR41yq3setuRCQLYbuGkaVpsyNyAbexo=;
 b=Q/OvCnstYC4QQ+6MS9TEI1iSUGGxJZ9ubpKcq/8K2RLgmXOVSl46TDcekBGYLq/5GjKeV127r4ZhRGj7oOcwiPBhM7TZvh7/Gff4AwIL/29uqnANF3D+yrI0NxY2+5Ic3N9+lVd2Dp06iXbBLTANRVlmR0QoMpg/lXxwHmCyhy0gCJR2S0coCyTPNAfwXTN2spVjDTB0ovh5x1H7bYQJb/zGPZbilfyLmgEqZCSsVTkWryJAIn6L5nnamQ+4W9hesPNtGQrrezo5DU5thCeJ1U03gFE1ORxJxnbkvKyKKRuMYuoDBdPXs4S2XYxDo6tAI63Wn4YJBiHF5ktiyphlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nott87pMpqPJR41yq3setuRCQLYbuGkaVpsyNyAbexo=;
 b=MTqgnV+baLn4X6A3hPLSwyv8lDDcpEgR4VdYvbUGXuGvmvmW58d9fn+dPAczJL44T/RNB/iLVJ3S20pDTg0I7J6fnyhDYr9n7BXLhAhJ/IM2ijsPc8g/+uNlQIZ2MpzHzeoRwB/UQgi8HZTDIcZxO63//8OgnhKU1g8CYsUmXPY4l6ztRX0PrNh7Qc6f1e7SRQ0jdwrfwAV9elTYMBw9p3sEkh3Zjm6o+oyuBcuKPEFmJde/1lURg+mlydXkwf0mA7k+wlVhZoZZ7Z5+LRl9jIWCjsI0RPmvN/gzSmxrXg6LuIJ/MNCiM8xYcc1cw3wHS1PE2sK26YzEhAe/MMMCAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 02:40:57 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 02:40:56 +0000
References: <20240206010311.149103-1-jdamato@fastly.com>
 <878r3ymlnk.fsf@nvidia.com> <20240206013246.GA11217@fastly.com>
 <874jemml1j.fsf@nvidia.com> <20240206014151.GA11233@fastly.com>
 <87zfwel5qi.fsf@nvidia.com> <20240206015657.GA11257@fastly.com>
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
Date: Mon, 05 Feb 2024 18:38:41 -0800
In-reply-to: <20240206015657.GA11257@fastly.com>
Message-ID: <87sf26l3go.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 933c9777-bc41-4e65-33b6-08dc26bd0b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EAtRNz2sqFrwUXepGuQVSN6AZlSywX2+nboXZdDB96XhZ6VQPPE03HhqgtyC2Kjx6AodKbhJuWViddA/9SIWEJa77zSQak+48utaJgKbmI8KnZuDcgalgQERfgHPxuk1KcKyfU389j+jfNAoTE52FklQl5G0pijLzg4my5AqiOk9g+s9NNXNmCXj87m4Hq21iE7vuy2056tzboR060SnsHo2KTX7ptyZoiB1RFHdD7YSLYfvBTQam9xun2OQXkuPm/AHGHa46XqciAKBIkocKqRlcl/0bPJWdefPy9jTtm+YUk4si3CSZb2lZPAp2K//YMRp7iW7WivXFldKgTzDZHbPnnci/Ff0ub6+012veLOGi+1pJ0CGFwk1GpcYKNnYKl3cvZUZgY6ri+oDj8cIDyD29UhRhnqU1dM3CrEWLG2z4vKreOmoCHpcD9jTPJxvJwqCuzSX1fTY4cAYJAInKgXKcwlSxmnDdUNMlDWTYcbiT7/qyZIX/qJvR9Hnyfdyt0X1heovIydI05q9FfE1UdMDwKkHWdUF5z8VQ/quaXnEirGS5IRYxnIUi8Dc7v53
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(66556008)(478600001)(4326008)(8936002)(66946007)(6486002)(8676002)(6916009)(316002)(36756003)(2906002)(5660300002)(86362001)(38100700002)(2616005)(6512007)(6506007)(54906003)(6666004)(26005)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPglla8n7Ur3UEa1KpVVCWVjLtZdOx2JP6bw8jMo9ax1ta5lnMkNvYoZuTnn?=
 =?us-ascii?Q?afo1kA4PIUf7PKdMo1Ng76VF+i2NdosaKs3vy1CQ+8ctrXbQa1dLUIU5e4I6?=
 =?us-ascii?Q?Z7wDULCPfD75Q2hk6ZYFYKf7bW7llwpr6w5h125E98Q/PKHqe/q0x6y4tajs?=
 =?us-ascii?Q?P87i5C8TjyT33ga1Dn6KL5fChPZdHXkZeyVXdEJVozW52Rk1E6Vt7Xc3mBIr?=
 =?us-ascii?Q?X7QMF9Bkb7hinXkwvp8fdiLiQOYaNRqNc+9ItS9K/JlpKAh8Wr8rWHTjLKxQ?=
 =?us-ascii?Q?LtLssBvCfbb0Y6lV3dWK+suiLwkOmV6VOC2VPBD0uGvhQGIINOYNvyiwvUa0?=
 =?us-ascii?Q?WpD6oCiI9xGqRj6huGcWmdD5MKIc2MdV6qM0lmfMVtDi/HTIPLDCTGcH5y0k?=
 =?us-ascii?Q?bogS9WCaydD+o7BRJiwE1oIamU/lf7bN4WC34Wq5dP3uX7whcnXCDJ/CKo1g?=
 =?us-ascii?Q?fp3p6flC5QilX1+pfOU66Zcv5X459SSCoSJCAdPmv9wyChMr/K5gV4RnaD36?=
 =?us-ascii?Q?JQlrleUGW5jKNo/U/VyPXY1CLwCrMALmTgfYKBXeMBKxxedom09ZSPM61Cjs?=
 =?us-ascii?Q?9X7k6moXak5bqdkprtdSHaJlghwTY2QoBIxuJgYoq5fJMwlPtz2J0J44QcCn?=
 =?us-ascii?Q?5SVYFJ+YMUpxyogQ3nNaZ4rUsbJ29nPZzWAOcDD1WHsXmSXKuANaCw83Aj0f?=
 =?us-ascii?Q?DbBChyJpAYBqu4EVrxHEtDRxhj5Fyv2N9vseYjf8vzzZsu5gIePrDzSYf4d7?=
 =?us-ascii?Q?NWxm0jgPTRvq3j50S5F9Y37YMymx7CCzSzGvq9QxX1Rf6UF9p0M/L0ZE/Kx5?=
 =?us-ascii?Q?8iuv205YdfTAEEQ/x14oniaGOrwuSUWT/UoGkE90Y7lStA/XJ587+ejLjiW9?=
 =?us-ascii?Q?HT/4IJOTAxq5eMftDP7EYgjsTnEWy42jJfDSpQVjcbZK57b89Ibzr+0a7/tQ?=
 =?us-ascii?Q?G4hvSY7GXblW9GD86TLAXSatMU13gUezQux2gGy3MQBRmbmmY2K1GOAYBRrx?=
 =?us-ascii?Q?P50y55S0UQJVwz93PzN7kQk74TAw2tkVH5t3mbNWRASXL+8nz7mpS06xec1X?=
 =?us-ascii?Q?GseS9q8TKuepVB1twQ57ltA0hxlO08toHdnEnFI60KtjfRI39x0ynPFr0rdZ?=
 =?us-ascii?Q?R6UGZpqyAv1E31BtCXvi+oFabW/VK2xP9VbZy3GqpO5BbRP09nc5S6J54Qg2?=
 =?us-ascii?Q?X+h/x0kc8p3RjX5xQWPVBj3e6KDLfif0/zXPmp/7G4ify8dLInoDAhn8e7N+?=
 =?us-ascii?Q?84eBVpOE2pWQt8WaMgxPORBSpmtjDsJjK/urZhoM1kwrqO9PoP8SjhxQ7lVf?=
 =?us-ascii?Q?nUK/KUcbJEqEOfqm4gG8JnKCOKr/u8ceNQbq/yrZLurYmHOod/AORUc4LYEK?=
 =?us-ascii?Q?P2AoRufTPzbJ6VGD14f5uW/6NlgVGZudBMPMuZACSYy18en74BhkTu26cYQ3?=
 =?us-ascii?Q?vi4oln7reE96ldnXzyGqqlajfjB9nI0QIMPtVAPDfl61gnemEvRx7/X4Ehff?=
 =?us-ascii?Q?QEAfaQZIuLKgtkQ/Ivbc4Xs/kFBmNnQ3NZHXbXmaJJzn2NGNirAhJnPhyyMm?=
 =?us-ascii?Q?eS3SWb5KO9qsla6Cr0LOelXAxRARXSZ4wlgeTDGx0QArgYSXzyWKxb4dNj/5?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933c9777-bc41-4e65-33b6-08dc26bd0b88
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:40:56.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia1GSg4kEAEtjGMXqr8qOIZ9BqBeqpwT1At5eei5ok0aVQ+aFwVoJfbbS4K9gWHlI9ay8XMmuO5i/SEe7D7LCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

On Mon, 05 Feb, 2024 17:56:58 -0800 Joe Damato <jdamato@fastly.com> wrote:
> On Mon, Feb 05, 2024 at 05:44:27PM -0800, Rahul Rameshbabu wrote:
>> 
>> On Mon, 05 Feb, 2024 17:41:52 -0800 Joe Damato <jdamato@fastly.com> wrote:
>> > On Mon, Feb 05, 2024 at 05:33:39PM -0800, Rahul Rameshbabu wrote:
>> >> 
>> >> On Mon, 05 Feb, 2024 17:32:47 -0800 Joe Damato <jdamato@fastly.com> wrote:
>> >> > On Mon, Feb 05, 2024 at 05:09:09PM -0800, Rahul Rameshbabu wrote:
>> >> >> On Tue, 06 Feb, 2024 01:03:11 +0000 Joe Damato <jdamato@fastly.com> wrote:
>> >> >> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> >> > index c8e8f512803e..e1bfff1fb328 100644
>> >> >> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> >> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> >> >> > @@ -2473,6 +2473,9 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
>> >> >> >  	mlx5e_close_tx_cqs(c);
>> >> >> >  	mlx5e_close_cq(&c->icosq.cq);
>> >> >> >  	mlx5e_close_cq(&c->async_icosq.cq);
>> >> >> > +
>> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_TX, NULL);
>> >> >> > +	netif_queue_set_napi(c->netdev, c->ix, NETDEV_QUEUE_TYPE_RX, NULL);
>> >> >> 
>> >> >> This should be set to NULL *before* actually closing the rqs, sqs, and
>> >> >> related cqs right? I would expect these two lines to be the first ones
>> >> >> called in mlx5e_close_queues. Btw, I think this should be done in
>> >> >> mlx5e_deactivate_channel where the NAPI is disabled.
>> >> >> 
>> >> >> >  }
>> >> >> >  
>> >> >> >  static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
>> >> >> > @@ -2558,6 +2561,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>> >> >> >  	c->stats    = &priv->channel_stats[ix]->ch;
>> >> >> >  	c->aff_mask = irq_get_effective_affinity_mask(irq);
>> >> >> >  	c->lag_port = mlx5e_enumerate_lag_port(priv->mdev, ix);
>> >> >> > +	c->irq		= irq;
>> >> >> >  
>> >> >> >  	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
>> >> >> >  
>> >> >> > @@ -2602,6 +2606,10 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
>> >> >> >  		mlx5e_activate_xsk(c);
>> >> >> >  	else
>> >> >> >  		mlx5e_activate_rq(&c->rq);
>> >> >> > +
>> >> >> > +	netif_napi_set_irq(&c->napi, c->irq);
>> >> 
>> >> One small comment that I missed in my previous iteration. I think the
>> >> above should be moved to mlx5e_open_channel right after netif_napi_add.
>> >> This avoids needing to save the irq in struct mlx5e_channel.
>> >
>> > I couldn't move it to mlx5e_open_channel because of how safe_switch_params
>> > and the mechanics around that seem to work (at least as far as I could
>> > tell).
>> >
>> > mlx5 seems to create a new set of channels before closing the previous
>> > channel. So, moving this logic to open_channels and close_channels means
>> > you end up with a flow like this:
>> >
>> >   - Create new channels (NAPI netlink API is used to set NAPIs)
>> >   - Old channels are closed (NAPI netlink API sets NULL and overwrites the
>> >     previous NAPI netlink calls)
>> >
>> > Now, the associations are all NULL.
>> >
>> > I think moving the calls to active / deactivate fixes that problem, but
>> > requires that irq is stored, if I am understanding the driver correctly.
>> 
>> I believe moving the changes to activate / deactivate channels resolves
>> this problem because only one set of channels will be active, so you
>> will no longer have dangling association conflicts for the queue ->
>> napi. This is partially why I suggested the change in that iteration.
>
> As far as I can tell, it does.
>  
>> As for netif_napi_set_irq, that alone can be in mlx5e_open_channel (that
>> was the intention of my most recent comment. Not that all the other
>> associations should be moved as well). I agree that the other
>> association calls should be part of activate / deactivate channels.
>
> OK, sure that makes sense. I make that change, too.
>

Also for your v2, it would be great if you can use the commit message
subject 'net/mlx5e: link NAPI instances to queues and IRQs' rather than
'eth: mlx5: link NAPI instances to queues and IRQs'.

--
Thanks,

Rahul Rameshbabu

