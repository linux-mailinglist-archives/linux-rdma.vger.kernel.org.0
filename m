Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF1232F80
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG3Jam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 05:30:42 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com ([40.107.21.61]:7444
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgG3Jal (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 05:30:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0I2rbzkEObWVkEXPODQeZa5xyGNjFwFpv1WDEXll9rjtyphKiiK+CwkByFmLO0MXJKWe5zMrS8zWD63P0gR7//UV+T6fN+RYW5UV08Afn1TtGvI7zn4H6MboHs5T0ddYi2uBwzJtoIq6RO4CNhGmTTH+M6ETKoKHcoXIU6j4UoKMFuzP7zA0lqzRMLP/ke/9gROWeLBQQUSplO8PisOX63+O6fsQv/njwZ4Xt78yiLz4+PrBNt52hYvDz3ZvDVLBL5GpNzaZU/2D/U7UYMbOPO7SeiaAVDbY3uah5qFK/7YXMESy0FFtkmB5ppYGVLTNQebeAg76GBuDFvp40mrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIU4hjrJfPusBewPkWcMKvoKsN/xBtpk7hSbaRgRnfE=;
 b=i4nmS7YrdCMv0pvDIcd3JPVh20PYOrOAdvjLwMo8uY1ht8ZnOiR0fjmwr6Q91zWu6u8iRl/45r2hkaCfR1ccSRRxSxUZ6jA9D5QFPvTC5M3Kp9il5L0iinqNdZdEXsQvgc0MMZqLz60kLQa89uwKqcU5ljEekAillf+Ls5JK4/HV+pCXE8lQ4CvJR9YBPhfB62eKDKrLmS8Fw98ZY4xaeWWUk5cn2JhxzQGCzOfMc1GjKt370g2lETdmGMC4LqpFcBh64gQofus6ozu3u1nUu18pkvTyPKRHGWnI8/rrrN7dbapYtJPmQwtEfWHXThQhsL5r4vARGEmpHrzqchkH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIU4hjrJfPusBewPkWcMKvoKsN/xBtpk7hSbaRgRnfE=;
 b=JnBANOl1QiXLkK5f9JjnnnwB1p30FjqgrZQaR9O7lxiQB7T1PjdhoEO/tX0MBrgUURZj/nWNUlZBmeq31hnC/5NeHIALV2DheM9B/hKK/yKQVik3Frg8mTy3OLFeIJuutznsSg6CGb2ZpymiJcGZb1pJi588z01l8ZV0uSS32ag=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR0502MB3825.eurprd05.prod.outlook.com (2603:10a6:208:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 30 Jul
 2020 09:30:36 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::4065:87d7:1f28:26c3]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::4065:87d7:1f28:26c3%6]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 09:30:36 +0000
Subject: Re: [PATCH rdma-rc 3/3] RDMA/core: Free DIM memory in error unwind
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
References: <20200730082719.1582397-1-leon@kernel.org>
 <20200730082719.1582397-4-leon@kernel.org>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <331a2b75-87e7-b53b-191c-63cbb0617a29@mellanox.com>
Date:   Thu, 30 Jul 2020 12:30:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200730082719.1582397-4-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.10] (93.172.65.141) by FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Thu, 30 Jul 2020 09:30:35 +0000
X-Originating-IP: [93.172.65.141]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 850f88cf-9997-4850-6cd0-08d8346b3704
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3825:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR0502MB38258DAF9480CFA0000613CCB6710@AM0PR0502MB3825.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ocsn34r1roqIJThzbMqrfH80V1rwjsFrEHXlVmvGnCig1ypOFLwsTa9F18C0ojse+UcXlcb6vKyHPHYFAEdcdxvf6LgmwNV9fUg42OTaO+ZSdu/gZSE38i6YBxB6Hk0htG+hbGppEXehfMJZCRIOJagD5zX6PtOTNuCmA3Lbg/6gAebKb0BZgdzc4Havqx3CYpY+HsSBgNYIOkHN/lrZWMM9UIfS7DQMXlTfuuQEGy3lZRuTtZQoafgLf4uvfU/hoKn15x2eNK87TWliIbHmpXIAaZRhKSnB+i+XQApeBNF12axn93ZvQmyldTPwkd+Or5Nx9qOwDEH9kk2JO496sbLeG7xtx7ZmCoOEP8ts8ZVVTn4yEMBnC8ClVY7BBx+d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(52116002)(2616005)(36756003)(5660300002)(4326008)(956004)(6666004)(186003)(26005)(31686004)(16526019)(478600001)(6486002)(53546011)(66556008)(16576012)(4744005)(107886003)(2906002)(8936002)(6636002)(316002)(86362001)(31696002)(66476007)(66946007)(54906003)(110136005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GS5LbASegLhHuJcKvHRotMOB+H06cCM7ibWkMUWD9TzEgwPE/IcP7E4/EfmSsMdy/Pm3a0itU9kJF3ArEaaduE5YdJx17SuAeKoayvqsYgrOZavkVPyGaOc7WayXYhlpTjsJunyxHlGRRKGuhJWHxWKhkQrlPt8k5+XyXH6Z8WCzMpR7TAZor1puDsja76CdXTfc1NDiTQo1Bet/oC/wG9E6YOxW9+vK0mEvKR2cP1bpFbFIeBbzApKkF2GRzN+2IDkagbit84Ovs1GkK3fyIW3fKKo8cBR9Rnr2BQMm7kkMPFXKdX79YhapngWuYiQD1Aske0LtIIJfnk9w0uM1svJWcuipJKXNSUmgQfg9EHnTFrTtO7Z3XClH1LvG1/qEf5ct75nQgneQUCK2xi0E1NiLnWnx7IAjiE3/eu3tDHtztYbLR4bApYGg9JzMTWngF1l9eTfjOSKF40qtGLvsFl+ycwEV6j4IBEj9MoY0N+v7z3bGoyhaBHvadlZxuIZ1
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850f88cf-9997-4850-6cd0-08d8346b3704
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 09:30:36.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDpX9u6SeA2u5BdTTI8+o2GDN8LmUaPM4WbPkYbFdOEZ8+pHAW+RkhnygYXbQNKyflWT7OLJkv3uLFdZEjFD7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3825
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/30/2020 11:27 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> The memory allocated for the DIM wasn't freed in in error unwind path,
> fix it by calling to rdma_dim_destroy().
>
> Fixes: da6629793aa6 ("RDMA/core: Provide RDMA DIM support for ULPs")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/core/cq.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 33759b39c3d3..513825e424bf 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -275,6 +275,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>   	return cq;
>   
>   out_destroy_cq:
> +	rdma_dim_destroy(cq);
>   	rdma_restrack_del(&cq->res);
>   	cq->device->ops.destroy_cq(cq, udata);
>   out_free_wc:

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com <mailto:maxg@mellanox.com>>

