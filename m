Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEE189C81
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCRNFW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:05:22 -0400
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:62254
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCRNFW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 09:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzdo1Ao4SC4TqIlpY7B6OOzTePH1eJnjbw2NLVzjQWuK6bHki+darz+H1+5IsBB1sr9oYWEKDUQ2w3RJOLBE4AFg/avYtFGmGUM4JqZplKjoF5+iwULCb4qgh6h7KsR1ylxXj7vxl00e4643bN1dboX/05+SHHwgvCnSe3vyj6NtYpRgLllbyoNaDu9eWUUfJS9zYLxwDiry6GOzi7nRUm5ReQyQ24DHAnFhANzWfbixSxSk5fpx1Q1um+j1H242Zan8TMs1zjw9NMVPD6BsmUBk3SVjnQXanQGbQwalnbE2r2ruoaZmwbVqeQ+bdUUc1m1nuW4aqtibtMORPXxV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJwKVYwf6Wz2V8Fy1FnrbB2D7VZ7OIdrRpDmaUATdx8=;
 b=W2B2I8wFRu7dx0AGFhDcz0AfjIwYCy68bW9pjPHXfAYr/GLqooUgwX+0eJMlFys6eByWxgTbTBADZ97mPUiQ5SZWEeX7E9Un6dvjFHxXXg6XnismkWhp+fcnV+vw/xYvrhEhn0FygROBJS/4DJhVObJ8sLYMcueYCJ6kus/4PdBaBB+1t1UnCxpVK5s3uKatw/Ljdq57wVii8OhXcdtuz7OVgDpk/OSzADaeeZGeYWxhliUXN92q7y5gMh+D8Y9g/qYo+etk8Arrngq156acASL1bibz9bPALN5t9fdO3dCNj1rC4M/Zz4WSyJEQczWhpNm4Cu2S6CMuk8dLDKpGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJwKVYwf6Wz2V8Fy1FnrbB2D7VZ7OIdrRpDmaUATdx8=;
 b=osNMti/MEIayIQ5lYq5vNMoC0b48I5WcVqKEmC4mZijRh/GxLqFRe9y8qxfuqUKABq/fpETdYPv4z6YzrCT4NX54eVfwskiT8En80mtt1TXx/l5cVjyEtfyzm5gles1clqjKks1/sAE7WIuG5EeaRrCy6fF1YacHT7ngfbRyhz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5790.eurprd05.prod.outlook.com (20.178.120.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 18 Mar 2020 13:05:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Wed, 18 Mar 2020
 13:05:18 +0000
Date:   Wed, 18 Mar 2020 10:05:14 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH rdma-next 3/4] IB/mlx5: Extend QP creation to get uar
 page index from user space
Message-ID: <20200318130514.GJ13183@mellanox.com>
References: <20200318124329.52111-1-leon@kernel.org>
 <20200318124329.52111-4-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318124329.52111-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Wed, 18 Mar 2020 13:05:18 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEYNm-0004iy-Ki; Wed, 18 Mar 2020 10:05:14 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 532a4a74-d933-4e44-1b09-08d7cb3d0204
X-MS-TrafficTypeDiagnostic: VI1PR05MB5790:|VI1PR05MB5790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB57903EAC27FABBBC094BA2D8CFF70@VI1PR05MB5790.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(199004)(2616005)(186003)(26005)(52116002)(5660300002)(4326008)(107886003)(316002)(54906003)(81156014)(66946007)(66556008)(8676002)(81166006)(66476007)(478600001)(33656002)(9746002)(1076003)(8936002)(9786002)(2906002)(86362001)(36756003)(6916009)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5790;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by8DcMhPISl4EipmJINM3yvi7QWww2keOCcvynOXnYdWdAY1fzpOBbn6bUzo1elRiBrJ6Qj66x0VfVOC4YyVmKzI06KMx0Sey/57xAO4BjGwxHKLlrCV+Dk0G5jdMFZM0LvIP4FX+XrmBj1gkt8DE/cs4eVfika6aar4v59JvSmNqpH6scIFUD3Q8KNH9104ZwqKr6VmghgpXBuwhB9x5eVu6AT0GzSP2LGd3wvqWSbEdSbAH4egtETsPS6JxxIcWmSGqCd47uqopyBYb+OCeOf042NLa1gHrXRXP5KmrTwRYbuPsBnkfnZycvbVaC4xG5t+o6gXjVDt2FMb8m2IGD8u47XIxltB7PhnqgVMMowEe9dljnzUCUkH/g3PkM6IZkCAiIQ2zDppM5T4yM6krLiLknaztZyMBuIWwSH1yQJ2/Tzaes/0UNbprVP7UaZLPhcMde2Bf8s3blPKdwfQapfCEloN3heaihDOMTHtq0EduB9kCspTIWo+oTToEJq/
X-MS-Exchange-AntiSpam-MessageData: qdOO2m45Ap7STLHM7QoYDBPNZEcR2uHDrRjakF9ueTJneZjGoMsvpWEc4Woc+6idPsgP8iyucvdBH8c1pGoG6qLd+RzlxVjohagfHK+tVzWrhIObAt0FBB26zmYzaI5cJN5pPd+t+tn8i9iCWRc9vw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a4a74-d933-4e44-1b09-08d7cb3d0204
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 13:05:18.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IucrWmmfECb8whED4lON11dfjt3wYCyqFm3L9Oe6MCBtvnM5fCmiQMzGhJ/IwM71xn23MGrZq9OsFN+buWCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5790
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 02:43:28PM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Extend QP creation to get uar page index from user space, this mode can
> be used with the UAR dynamic mode APIs to allocate/destroy a UAR object.
> 
> As part of enabling this option blocked the weird/un-supported cross
> channel option which uses index 0 hard-coded.
> 
> This QP flag wasn't exposed to user space as part of any formal upstream
> release, the dynamic option can allow having valid UAR page index
> instead.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/qp.c | 27 +++++++++++++++++----------
>  include/uapi/rdma/mlx5-abi.h    |  1 +
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 88db580f7272..380ba3321851 100644
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -919,6 +919,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
>  	void *qpc;
>  	int err;
>  	u16 uid;
> +	u32 uar_flags;
>  
>  	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
>  	if (err) {
> @@ -928,24 +929,29 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
>  
>  	context = rdma_udata_to_drv_context(udata, struct mlx5_ib_ucontext,
>  					    ibucontext);
> -	if (ucmd.flags & MLX5_QP_FLAG_BFREG_INDEX) {
> +	uar_flags = ucmd.flags & (MLX5_QP_FLAG_UAR_PAGE_INDEX |
> +				  MLX5_QP_FLAG_BFREG_INDEX);
> +	switch (uar_flags) {

Do we really need this temporary uar_flags?

Jason
