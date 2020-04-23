Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15E91B6411
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgDWSxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 14:53:23 -0400
Received: from mail-eopbgr140054.outbound.protection.outlook.com ([40.107.14.54]:47182
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgDWSxX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 14:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBR3xPQcCJhRqncstLIWzmQaZswKRHrpd0i49k/hyZBvWlBasgeRhN3TyiLjnjda0EPeuM05Il1ZYdWtLyHsZMYxeqPc8SANNbQrBAUhCXUW08tb1gAifSvX8tw1Pq+teRBuvANQd3JfPSW8EtVoUHBSfB9jGhY2NKNzDS/egvFylExhfN1v2OHjFLRn5opC2zCff245O5ATEY1F6OmB+H8jnZHlCyisKcAQK7G14I5/8E4sCNujdrFbj4zzedXJsWWGPYIbm28jMznng3ymtGaA+j4cUWW/LdCEfwhhIDPg9sNft8gJHlzOjhvy0/GGxqfG2gF0+O8dJ8n+ni48ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hi5OniPbVsUsXZc5ZuF6ZUfSiD+5Kt3S+ywlX+zwgs=;
 b=Ceh56VU8JiPbn3QLBSVrfHu2a7cSO4qseo5wXOYUggdQiWXVSA2YIoL+w6p+bggZ28wIfOFAHPVcvYfiw2Kv+nRbYfzWoqVq4Egf9rwld2MTsEY8R7KtwmPvH+8YZ7yoPdrXGG2tlh6nyg9i+Xc07ujF5xlewc6mQZTfDgJOJOHnEx4w4WHf+7KnaVpUUy2qMrgtDTEFtqpyytVIZ64K56mphoazf0SnbDuMkeqCDGjrjeEQglLaV6VNuSGsJ0kU3jJv4u/4prVNRYQ5AwUCNYNuZV1DH0XaeEcgzLrHi8VeWfvSygj7jhJYlF8eDKEyezZtdLeO0xTTN2sU72XENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hi5OniPbVsUsXZc5ZuF6ZUfSiD+5Kt3S+ywlX+zwgs=;
 b=fBt70o0x2UYseRGAWuUxNPYtWtBhxvpt06ZsxwUKAdzwLyObReJHfVQzQopNOs1jOyyfu21EAcc9W33vzqh4OcG2eDuz+On3Y4OLUlZTPk6NNraXm1oXRkbHq6AH3/gudezJlJK4cpotMEe5Djaexl1tri+POCQHTLZSgFM0pIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM0PR05MB6401.eurprd05.prod.outlook.com (2603:10a6:208:13e::17)
 by AM0PR05MB4417.eurprd05.prod.outlook.com (2603:10a6:208:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 18:53:19 +0000
Received: from AM0PR05MB6401.eurprd05.prod.outlook.com
 ([fe80::f980:8d53:a8e2:d7dd]) by AM0PR05MB6401.eurprd05.prod.outlook.com
 ([fe80::f980:8d53:a8e2:d7dd%6]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 18:53:19 +0000
Date:   Thu, 23 Apr 2020 21:53:16 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 14/18] RDMA/mlx5: Process create QP flags in
 one place
Message-ID: <20200423185316.GB3148@unreal>
References: <20200420151105.282848-1-leon@kernel.org>
 <20200420151105.282848-15-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420151105.282848-15-leon@kernel.org>
X-ClientProxiedBy: AM3PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:207:5::23) To AM0PR05MB6401.eurprd05.prod.outlook.com
 (2603:10a6:208:13e::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM3PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:207:5::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 18:53:19 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06ecd489-6d28-4bc2-4911-08d7e7b79705
X-MS-TrafficTypeDiagnostic: AM0PR05MB4417:|AM0PR05MB4417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4417CDCC91E40F7E1C7699DBB0D30@AM0PR05MB4417.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB6401.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(316002)(16526019)(9686003)(186003)(6636002)(107886003)(86362001)(6486002)(2906002)(6666004)(478600001)(33656002)(4326008)(6496006)(66556008)(66946007)(8676002)(66476007)(1076003)(81156014)(110136005)(33716001)(52116002)(8936002)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKqyfnqBUdNB2XO2k1YtbA6wJ3z9UUPwdVJnp/1zHJWRJXsCW+aiBSWKOYEG0vfrDkhp1c2A4pzho1tc/MQlsRllEefTX1qepfT0eolPdfpMGXzA7zWi60z/Fa2+BHcvcQP8EJM4Ry3P9owr6QFPY9j30/5Fpe9xgtHwlbXCs2fPgzvMvchWGadkWIr3Ob0RDkgsCfKMrVULS3oGoqV+/E2eBQ7aIk9viFiv0LS0hkCSxLi++InzqQSa92lyTjoufXILGVMunrcgA+NOY2FcGhysXoi5kEVVMufBVsfBMqHSYPzCzffEl4so2/YsWpOVmGNjD75gn+MkAVYwkK/oUR8vMMXMdGACUbbkW5e3imy8J+RPd7X5LdunZlI8kHDvPrHouNQrQeQccPovhJYHU7S2McVO6vWNTfIWmavU8Iwj991tjpRsQv+3qLnaoZJU
X-MS-Exchange-AntiSpam-MessageData: 0jqk8DOPt3e2VPR3l4sligAyLbZsJx7ssMeQPXf1CaFd/siibA3a2wSk9NvEC/NO66GExb11+RDaL4HbTYlG0F+7HFYURFCx655MfksPDn7NdzIbj/akyh9Fp2wVK+cm9hxE1hUdfKrCjNMkDBpjhZOOpDgie3M/2DpTetLCw+2/LeCfPuVQsgnj7mSF0w73hmjtgYhq87v9A8db9MQXZHGwA2voZwB598F/LjMr6wKXCnYCCy4YWxD/+EdzJ4P6TS4/EDElLwwa8lAbeCjpupHXjXeHfyNoB2CxEfuPeYyBA/x6dFxZGO9DtPMj0PEJXx919UHXAMcOU82HUDVhEDa95dIQqMGCvXeGFtCyazZvxifeJDncqGVqmHhc6jzSgbJa1PyjhWnpbO57Z7ovVdaI3+v417wrKX68t0TqhuSBPMQ79rxddrk0mxqL6XDzkYneeetXb2hggJHpMOE6YKHweow9NuOhBEx6p+X+QMiOSmexHtPzGgIknuv7ZFJ2fPMBpplxc3vn9CGUGIiqGXMB1NJ9yix3YCLsonpPBdWtBhxDEc+2rN3LCZjA8PAOEEVSgEgNHaJ186AKmQJKqu3JFm4GYff0mspw1NfgiusY16C+NvOs2AOl71sSblWN50SDuqvRkDy1VrFpQgvjN40nWtCSrfPSgXsHJs+dZFNbhw6LaA17v/Bd95ph6nG09Jz+Bpn8P+x0XXU8PRSN8WUKCcINPqPcdtNCDcZaLyfZNMCjJzy2GHLJET/Ghy+CDDuzgrbdaGRC1FEqoVcz3MMJc1ocXsPVP/j6yK6qi9N1C8O8klFDDBsrJBNf+6+7
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ecd489-6d28-4bc2-4911-08d7e7b79705
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 18:53:19.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Rvx43KuM5tYLbVZXzZ9Y/fbkuShmUDRJ+plS00KUklYkU7sDid5iREYNxuqtl2NBIhhSwrLoH1aOhAJ8zC8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4417
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:01PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> create_flags is checked in too many places and scattered across all
> the code, consolidate all the checks inside one function, so we will
> be easily see the flow. As part of such change, delete unreachable code,
> because IB/core is responsible sanitize the input.
>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 200 ++++++++++++++++----------------
>  1 file changed, 101 insertions(+), 99 deletions(-)

<...>

> +static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
> +				struct ib_qp_init_attr *attr)
> +{
> +	enum ib_qp_type qp_type = attr->qp_type;
> +	struct mlx5_core_dev *mdev = dev->mdev;
> +	int create_flags = attr->create_flags;
> +	bool cond;
> +
> +	if (qp->qp_sub_type == MLX5_IB_QPT_DCT)
> +		return (create_flags) ? -EINVAL : 0;
> +
> +	if (qp_type == IB_QPT_RAW_PACKET)
> +		return (attr->rwq_ind_tbl && create_flags) ? -EINVAL : 0;

This line is needed to be:
+       if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
+               return (create_flags) ? -EINVAL : 0;

Thanks
