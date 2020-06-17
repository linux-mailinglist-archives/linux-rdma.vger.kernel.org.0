Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A21FCF3A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQOP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 10:15:26 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:60469
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbgFQOPZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 10:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEmal/4m5Z+M2Is2HfNwfYvBHoy1sNw8bnbImt/ahdpDRiv4Y7RhV/Ja1g1I4QOn0n+rhzCEj0kEasHi0f03Kevi/xYAt+nvV/eHHCRqON9fZmqn2l0zuddYC7D+VFzkAzafFV3rxB834e8xKc6ezI26ce5jBlK3SMXUK9GQ0vV0jtpy5lVTaZUboY4QOu9UxJOFgnq/F8Dw2pcEcS07gp6pNatEB5aOjeYk4ZXNRxb1nWUxzw8jUFf8wzQQXmqh0+3zYLSb9kXe/K7CKZhrpYnyT6//vmBd8e08OhtlEYKNw4pI+o3DnEWNveV3r+ie5myoOuhs8oJpfOsUk9KJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IwNIe25D4JG+hdkfguAp3DwI57IaM0mAArJ4lI7D6s=;
 b=TmDsC72V2amx776MtW7jUwjf95ncHQkCyhXtt/Uya5ds160lBu9M3LMW88l8dylG5I7gGjA97C6hfcPa/OGpLVpDpgnHmjaBd3YfTd/b2TZiTk7PUaG+DMoCpG3xCHKQawFGDCMy4nEYVFAfE8+kePM9VBOimOiz1VFqI4M+wnJu9wh7EnMkrYcNcIUAAdumDiUZHLh2ci3ZYwJgo0RlTkNIffQil6vqMkySAQlVSnabcNYN9fDxY1xHKLLIs5FsCdrl8/dPKUtqUd+gyF4/qDtv3TkFCGQLqByqOL+yLaNg3T9Dfitcrb7p+mp7zOJyJygvv+WUAjQHW7H4tHaKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IwNIe25D4JG+hdkfguAp3DwI57IaM0mAArJ4lI7D6s=;
 b=LfbBAMs6ubhMJk4c3jGsszqu3ikylK+cM/TzgjelHPK5qeoKkwACPtmXuln5uwsAV4ev9+VlhCsD4sTd9EggAU+4aLvn31Idqqu2NbRYHfkAMDORYMHIM40RZX0TEk4abOEblWQwgxbwDiA6kA8gBjzBempeWwo58n3mS5Nld2g=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4612.eurprd05.prod.outlook.com (2603:10a6:208:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 17 Jun
 2020 14:15:21 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 14:15:21 +0000
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix integrity enabled QP creation
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>
References: <20200617130230.2846915-1-leon@kernel.org>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f9bc344e-1dd0-d36a-78fc-7ccfe7f45044@mellanox.com>
Date:   Wed, 17 Jun 2020 17:15:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200617130230.2846915-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0066.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::19) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM0PR10CA0066.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 14:15:20 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c821d36-feaa-44bd-e2e1-08d812c8de86
X-MS-TrafficTypeDiagnostic: AM0PR05MB4612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4612141E699159133DA7A211B69A0@AM0PR05MB4612.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tO40BeOcgPBdaB0R7SMeuNLwayY+NHHFfOuWuSZkDpana4vAD925dXGnItFBlSbbclflOmL+j14QkFhUAf0vmLrx1/DbyvAdISXXVPdqpQiQ//UO86f/wVzXMBXm5H3PAkdZEWPXFIDjVeDs4zlzCO7Gviq5wW677ZQAxH8J+sN/WR4Z7dQMZ9bCAANLG42HpfTYiALTzIzkdm0vM30UqAsTHG81s6es7bEbSw0fjjCmTbuI8fr+yJs5Xpr8Tv0rOIKpn0zW9iYrLgX/NO4vHWd/zy0V7eP6bqUparlm+9oMz+9L8w+BZpQ0xWlhZr2SeHXo4fM6Hd76ssjdQYG5gmGieCcEFqLxNpPTePJ/65JQLilgIO/4jsUIQMzOVMaX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(54906003)(110136005)(478600001)(8936002)(6486002)(16576012)(8676002)(66556008)(5660300002)(6636002)(316002)(4326008)(66476007)(2906002)(31686004)(53546011)(66946007)(36756003)(31696002)(26005)(6666004)(83380400001)(956004)(2616005)(52116002)(186003)(16526019)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GBrohvk0mMUD41Hjf7M2tecf8BA19u8k/WYx7VQRwsK5J4NJfIx15lFj0WdoN/pA5ezVWK3jY0KGvU8EazY9mKbVUCDLqxGpfhnZrbM+0GvsWJQr4dGJkewJbLqajUihoBimQ/fMthCCnacGSCrEew4QuOSrn5H3s3AdKFqEGOjnKgi8F5C673UgDrQxVfHkGV2tpyrB3nMtHwZDF0/bjCCB3w4orqq+7oOlcaIMyHVL053+gDkeHmPDvSl13LtJ+/zjVdDNJLQHPCfoJPGVWSX1/V3SCiiQF4q0tsQh5kB5X+lTwbpG+6Mvg3EwtBkjkMnQEeSSqzoQwuYoSb6AZphgFa0iPOqwLQJEyTPdcvOyUyAvg5bFyS20lnrw1Z9g/TOO0yQJ8xE5hD8ibir4UxPlqyVJ9prb00o+koV25VVa9XGyv7+Rx5ifk7gCOsTgQS3x7znRx3SHo0ekk1wYxM/DfbZvGl9oQEL9fBYKTKgcDr67cT6lwp5n761Capi6
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c821d36-feaa-44bd-e2e1-08d812c8de86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 14:15:21.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYVjj4WVkEX+EX+kXmYtGHTzFxfbMzc5LIu442hSenQdviiYEOEHsiNg0bkX+XZwi1eXnOf1EG0lQ6whY/swFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4612
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+ adding the NVMe mailing list in case someone find issues with 
NVMe/RDMA on 5.8-rc1

On 6/17/2020 4:02 PM, Leon Romanovsky wrote:
> From: Max Gurtovoy <maxg@mellanox.com>
>
> create_flags checks was refactored and broke the creation on integrity
> enabled QPs and actually broke the NVMe/RDMA and iSER ULP's when using
> mlx5 driven devices.
>
> Fixes: 2978975ce7f1 ("RDMA/mlx5: Process create QP flags in one place")
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>   drivers/infiniband/hw/mlx5/qp.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index aff412b513ae..fe6af6bed02d 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -2668,6 +2668,9 @@ static int process_create_flags(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
>   	if (qp_type == IB_QPT_RAW_PACKET && attr->rwq_ind_tbl)
>   		return (create_flags) ? -EINVAL : 0;
>
> +	process_create_flag(dev, &create_flags,
> +			    IB_QP_CREATE_INTEGRITY_EN,
> +			    MLX5_CAP_GEN(mdev, sho), qp);
>   	process_create_flag(dev, &create_flags,
>   			    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
>   			    MLX5_CAP_GEN(mdev, block_lb_mc), qp);
> --
> 2.26.2
>
