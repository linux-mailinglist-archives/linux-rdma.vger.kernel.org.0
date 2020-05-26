Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088361E24EF
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgEZPHY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 11:07:24 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:25326
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728205AbgEZPHX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 11:07:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXhbpdRqB3h87retRIatdvxmOGU/CjsW1GsxZne8Dsvx11M5Sm9chg5+POzj3sW3nnwbsHuhXn8FORcvjjCZ8kjncZvE4Ys6jg3SDudBZ7nJFQSzWhhtsnHaw9pK3Bnsb0bH5Qil/ku3rYmh4Fk9afiQpnpvT0rhyGUMfDHNysu9bG8RSrO8w8Ev8+u7H77f3oFGd1/qduwQPW+2U6GgGUtYN90b7vqyhusJQaI7D6cMDeF/rZiF0PxZ9xAGrKibUeC++kLJ6a+3B/k3RhyBl20l2IQDyldUSl4DqoEGHPB7694ldhU0tYPTR9UUEvQceJ+6Iz+ypBeg51gSZNAl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+zORxSRms/uX2D0CWFJEIxsRjqcCXzhXAFasPH99Ho=;
 b=TFtlkdrQmPn6kpkR8rNku33hdfA/ecGKmgg4WvrfxvoE0iBaL2AnckytXs6ePKzQEd3iDLyd4Xr8f5VOwtFdmKvCNywYccS5xUl6yBmclA+nuSEeWKQ9djPi5cJf5HuQxnG6wpr1FEhz7iY+P1XjvCKhBjSxTDvvaOMZRgzTD3Nqmhooo7FukHp++oQszwvX3ogClMKDzFSJqSrB5bmQVnaQ31Is+R7jqyMHHrvb+Ogoq7tSBFrnPt+NENmyjilvrb4Dt7EI0vvQFpIWVL2BVdB+V6PujOiZ8/2JO3o4i7QJdrG0nd3mg0rZJjdDl2wtzS1MzFSp+VviFvNP8/vGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+zORxSRms/uX2D0CWFJEIxsRjqcCXzhXAFasPH99Ho=;
 b=GsRjerIoB+SwNIAZ+c3eLWjB5I3WfGLbyFHa6WUHB1KdQONdq79b6BKNGcUsOFeLxtZCMuAFl5QDDldEwxAGCNxjDDZ1zGSoIPLkGBs9LZ3ecIztSPEaG0jTJti2dMEG256auQ2qUf/8mBrIs/7HsbYB9ZRY3xEwIvv/+GUg5kg=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (2603:10a6:802:1d::15)
 by VI1PR05MB6365.eurprd05.prod.outlook.com (2603:10a6:803:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 15:07:18 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414%5]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 15:07:18 +0000
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Support TX port affinity for VF
 drivers in LAG mode
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200526143457.218840-1-leon@kernel.org>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <39e4745c-61a1-09de-1847-3b09d5ed324a@mellanox.com>
Date:   Tue, 26 May 2020 08:07:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200526143457.218840-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.33] (104.156.100.52) by BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27 via Frontend Transport; Tue, 26 May 2020 15:07:17 +0000
X-Originating-IP: [104.156.100.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cffd536b-8874-40a6-886c-08d801867ba2
X-MS-TrafficTypeDiagnostic: VI1PR05MB6365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB63658C032D6578193128843FD2B00@VI1PR05MB6365.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45U1rBK6uUABczVQEllrEGCpytMpazu6/LMY5a/jz2X1ZE+cn2IAz43OCVavdFOQCz1OFz+h97WNuW2+PyyDQaFDWb6Y7s4Dz9mxy/oPv/y0DzBaRI2phdmg90bWhEu5CZzI8GfbTg5+Af0rVrZRIT+Cs9+GHlEUKmftynyoGrZ3nPLlvqZJN9VtS8dUuJSiA4PvmDsVvo0qvbDS0VQ9kM6ByNp2q2d0R4lE0HbthU3Tm9qV/u89ddpgqW5hW8hJonZ5vCYn1RpF99eMIhM3bNWbGmOv2XBLqhZqfassLiX0H30Avzc9PO4oPddz6fmd7wAobLLIdyTVyCeYk75t6sRKBghexuhgdRHul4q4oL9ooF9mDaC8hE9WqLqRBJIo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB3342.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(31686004)(8936002)(53546011)(16526019)(2906002)(498600001)(16576012)(186003)(52116002)(6666004)(86362001)(107886003)(36756003)(26005)(31696002)(4326008)(5660300002)(66946007)(2616005)(66476007)(66556008)(956004)(6486002)(110136005)(54906003)(8676002)(6636002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CzkUrGOGzP6N5QddGk6b67MEUEqaT8zLDhOpm/xB7QNS5LUDqdCO3r3az6bfpAA//re4AE4PB01/82lhJh4Fxmz5gI3zDLYebmhjhZnJfmSKdT+UsQWm11Y/vsD2QwqVvhe9HFgg+ovLQkvANskp8f6FbwOf0EaDzDHbOeWSyf0D2A/kYFoEajTYOiNfFRKo/5NBcBpp4k2r8oMY/J4EJEy6UzAN8daMzfxwjSU+Yedc9IoH68AjM7eOJgt5K8OKLSzOIcrVidvbJLPv/CxllgP7c7/IDJR+IQX7dnV12oM7egfQEtnRUAukzM72obcOQXfHf4o4tI5W6VfWOM/M0auQ4x9liWDLah5vq0sxAOM4dNzVxjdTay6ZvCuGSqkTKzaTPvR4b7m4tz2eJLw/NQznFSPJhBVe783nM7NWmG2LIyF+sHx3kt2DGZzc19G13KMBZplg2LPc2Mq7VOS7E/5PCJuhlHiKg/D53ALBkxB3HBUmTVvzLFdyXS1kX567
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffd536b-8874-40a6-886c-08d801867ba2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 15:07:18.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDXoYxayaEoxzfY9q67vtj0HGp0L8Vi2pc49FH/ueEfl8+gDKZKLa251V/vO2W4UeOMF/EQH6WKdfDRtYvbcMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6365
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/26/2020 07:34, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> The mlx5 VF driver doesn't set QP tx port affinity because it doesn't
> know if the lag is active or not, since the "lag_active" works only for
> PF interfaces. In this case for VF interfaces only one lag is used
> which brings performance issue.
> 
> Add a lag_tx_port_affinity CAP bit; When it is enabled and
> "num_lag_ports > 1", then driver always set QP tx affinity, regardless
> of lag state.
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 7 +++++++
>  drivers/infiniband/hw/mlx5/qp.c      | 3 ++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 570c519ca530..4719da201382 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1984,7 +1984,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
>  	context->lib_caps = req.lib_caps;
>  	print_lib_caps(dev, context->lib_caps);
>  
> -	if (dev->lag_active) {
> +	if (mlx5_ib_lag_should_assign_affinity(dev)) {
>  		u8 port = mlx5_core_native_port_num(dev->mdev) - 1;
>  
>  		atomic_set(&context->tx_port_affinity,
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index b486139b08ce..0f5a713ac2a9 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1553,4 +1553,11 @@ static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
>  
>  int mlx5_ib_enable_driver(struct ib_device *dev);
>  int mlx5_ib_test_wc(struct mlx5_ib_dev *dev);
> +
> +static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
> +{
> +	return dev->lag_active ||
> +		(MLX5_CAP_GEN(dev->mdev, num_lag_ports) &&
> +		 MLX5_CAP_GEN(dev->mdev, lag_tx_port_affinity));

first of all in the commit message you write:
"When it is enabled and > "num_lag_ports > 1""
which isn't the case here as even num_lag_ports == 1 will pass.

In addition, even on a system without lag this cap can be 2 (on a 2 port NIC
where the FW supports lag).

I assume/hope/think that somewhere in the FW there is a check that says:
"If user has set port_affinity but lag isn't active use the native port affinity"
either way I think it needs to be documented in the commit message.

Mark

> +}
>  #endif /* MLX5_IB_H */
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 1988a0375696..9364a7a76ac2 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -3653,7 +3653,8 @@ static unsigned int get_tx_affinity(struct ib_qp *qp,
>  	struct mlx5_ib_qp_base *qp_base;
>  	unsigned int tx_affinity;
>  
> -	if (!(dev->lag_active && qp_supports_affinity(qp)))
> +	if (!(mlx5_ib_lag_should_assign_affinity(dev) &&
> +	      qp_supports_affinity(qp)))
>  		return 0;
>  
>  	if (mqp->flags & MLX5_IB_QP_CREATE_SQPN_QP1)
> 
