Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D59379791
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 21:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhEJTXX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 15:23:23 -0400
Received: from mail-mw2nam08on2061.outbound.protection.outlook.com ([40.107.101.61]:21729
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbhEJTXV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 15:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So2HpBDtgcNeSw6EOigfMTvdLeCaGAyZF6Uct+f9w/7yigjhyiR2k+3wKm547rhlp38u2nDDmzWrTbBvJ+9HtNOCloMVTtyHlX7Rlw+476kkabA9Uc82rVk++IYRh0PBF0ex7NxoujBlRZyPtkzD11nD1UyxWl2AmFuKCzCamd9Xz21Ft6j2S0GE6nuo3nCjz8c1wmUveXt2tofg1MseZ4AoEdskW4SAYA4HcfG2GuFyKGOdC5fWrBRpoQIPi1C+yekyjJ8u2ga3l3ZcXJ9rz/EJqeuHELr9vkbZ5F+E6gND3BtZVj+QTpimRx2LS1CTpar5z/psG8MvGLuwleiyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9tNfkgmNMECU8SqB6hjSZo1uEU0IZoSd7jG5JdLUX8=;
 b=JCZU1IF7U3Zee2zAZeBtAlGIIa+buj3QPBUJHmRKoxbp3sArzWkjoxKPA4UwhlPrrejn5aEQRyDmS5j4tMNmfKruTOQJ9IRyzjk9oIFsc75Wfr4hlBgrAW2Gn1h9Jc4eXOhn+69jDt0f3d+bBqQStieSnlGG7qIB7QcVeTGKaDYLUqXmeDW3gonqnZF0BbSx5oQ4LaTiHzbSv7Ubu2oHVVTCXBv2jJKtmLgYotkmFkGI8DGK/y20iNeIxD/lhx/LDjroAjTzWkN5vL2QE5FBiHjSORwSQEUTD3x2AyqCXMnwhxYSjUIx6KgTD90L0LJfiGlYrQPvqTjcERHQ+xWNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9tNfkgmNMECU8SqB6hjSZo1uEU0IZoSd7jG5JdLUX8=;
 b=pHOCJ91lUl0juQ7vTfCh7jXc85EdFKl2LyOyHT5e2rGy1rr1xKHCUwRAEQoV0ssgNQAmGVcnnd4DlqFKsE7bk8jLCCWGGDFOgWmzuh80elC8qbdY4/KwvQqHt2/aF5LE6kosK4qrOR8fSaZpw2QUmtW6LCUN1mq4h9qmTjG6NV6vN9I0TUmtkQvfnbEndiJ5pv4udTrr/eE9dOuT00tfEWrBRaMKpCkg6WJBnG6fhfaM7nnNtsVxMogj8C/+Gyj+e1PjaUoX/153VXYBntSyxCE9bna3W6TcinnsoUs/ID0U3GxVJem4JHHJD8rIqI9nMi3sD4w+NxPXdIRzS/fyoA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 19:22:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:22:15 +0000
Date:   Mon, 10 May 2021 16:22:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/siw: Release xarray entry
Message-ID: <20210510192214.GB1121391@nvidia.com>
References: <f070b59d5a1114d5a4e830346755c2b3f141cde5.1620560472.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f070b59d5a1114d5a4e830346755c2b3f141cde5.1620560472.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Mon, 10 May 2021 19:22:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgBTq-004hqI-I9; Mon, 10 May 2021 16:22:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa8c8ff-c79b-43db-8764-08d913e8eba2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44993003B32B36F4E3E6E745C2549@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abyftlUx63XBV6Z2T29IM8KTVqytPTY6PZiEAJgZDSR13uHbcMAw35bKwao3Y+eKxN79kAS0RWADCdBk4uoUsoy99iLArDOoBU8dAV09/vwlHNyJZUQCPHgvLxQ4uYhSGHAfQcKPTggd/V51flcMFwXrQqXpczfPy8jEdOAjptUAlVhIFMUysqwVVVVukTE4RJuPeHP8pqWScVKXbguOU/c6/NNJ8GiU6oe/WnJhVE6IiOjUactMe3syAtXyrzJew/AGi4WFq6C9XA+Cv5CwcIKppg/7XaGv33bkTtfgjt5/dVXmfO7rcFffQi1VRvB5iGP0chTsydEI2fg7uawJTM1y84fK6aZZ7NcvE1fbsXQSF1Pfoq0tSXz7Hg2UHXGQWPnnsRvd6XfHyVmj61QPnAYN5EVKP6ijWuPzL6D/1fa6Ih4m6iFTmgu5HpIFFdciQpinYGjkqsbKzn1WQAVDkYmzda3LKDN6rCISg2vA9IGgSVAqGZNknB64h0J+hfLWdhedmqinNHe2bIzFzq4zZD8K/9s/Tj326nwF3qZP+nKOjNUUQ7NnRoKr/oKM/m+l5vYFi8+JRiRUYfUTH0g6SfNHFKxKkbS4SGjDz+hLuWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(6916009)(83380400001)(478600001)(9746002)(2616005)(4744005)(8936002)(66476007)(38100700002)(86362001)(66556008)(8676002)(2906002)(1076003)(33656002)(186003)(5660300002)(26005)(36756003)(426003)(66946007)(4326008)(316002)(9786002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ToQ0fkisTheQgGDzorVru6FI1drqO1ZL/9bTYk5dQWUz22sWAx264ZX7K3d2?=
 =?us-ascii?Q?DogyrG6wrrc7wgxZU37pZpPDadc8fU3/yeQEW8HSCXVI34LkVAcXGTrEW6NU?=
 =?us-ascii?Q?YPGnISrJgHvVvlvXMFBewqYNkFlPiOndm81X8VjvAY9GQgg5a4Q8pzpIS+7y?=
 =?us-ascii?Q?CFR6wKnZWyeJNfi/LUkIruVsTGEMn596uoe/b/E/kH3/i5yRqSazH9lUx43X?=
 =?us-ascii?Q?PudcSGRlVRIHWwrG1rZW0J3KkYWzvYLzSSgiEH3SJ5jIOiEK2+Ch8JklxzOQ?=
 =?us-ascii?Q?BVFkrv4Q0+t5uH/54RdcWENX5v4gWwoypq+0P623kLKgtRGT2xX6C2OG1qSF?=
 =?us-ascii?Q?nXjQqXj3eICB4jJn/l5dRw/TsCzJmgt0VxMeVgBfNSHCnc11lmLhzuO+8vaj?=
 =?us-ascii?Q?pwK/Ko9Wj5F8KPwx9I3L/cp/zta/keLXIU2BX839fx+/m88dnxcy+BnxhHom?=
 =?us-ascii?Q?C62A1zQgnvhF2pESW1sx0cSbpbbQqFG+a09IbT5RItrpZwKEdJEQsvcIOjtB?=
 =?us-ascii?Q?/0zP3DGuYmxuNWT6D5REWpITWC/8yO8U7cJ7tMEQgq93xO7cznSRq2W9ktDu?=
 =?us-ascii?Q?CtB3RzGzxc2NBZlo2tqtcNfUPkTLUzUrKQfTuyjZVBzzRStDsLOuGEpps/JZ?=
 =?us-ascii?Q?6ee//Uya52oj2VL+rkE4qKTefzT791bCc8gsDcOjVlgr1AmQaKris5Xw83Oi?=
 =?us-ascii?Q?7ztXfnAYh4ZtqwOe802ds0uiPaCZlYrBh9avYB7Hia/ECJDaDVBIy/X7knZX?=
 =?us-ascii?Q?cExGXfxqwz0Dg2L8QMDtxpJmLRp3Un1xnqhQ/FefP4nRxKVU7TU0M4uQPyp4?=
 =?us-ascii?Q?7wHzHhdj+xc+oYclu2SVW0F66h2lV4IWxHtFqaK0D6MtwmG7qhnG+4pWWny3?=
 =?us-ascii?Q?hOJzU00DHlzrdIidIgxTtR5NCF2kU+GVtfQef0FhlaFo17ELfH/WJ5QWy2jl?=
 =?us-ascii?Q?NYfYlNtm9dPx99+WzmEHnuudGTxzzK2BhzwXJcrb8/4905hU5i7MwoSWFEUk?=
 =?us-ascii?Q?0jY59FLu8YN6whAqr1cMvrp1K7s6frMYnSKpNbZYGFtTcgRnHphobT82larI?=
 =?us-ascii?Q?RVCkCsWwoNHWXPCxphWKoNC6XQmRtGSV8hirdk1EZ6MTzISWEfL6umfKuXa0?=
 =?us-ascii?Q?ITw7y3co86zJgQd8MQKx39OJPLKyjPFG5/1bkwZELsCxLUk8oBe5pzMA8/o8?=
 =?us-ascii?Q?y283RTHQsrY/NXmWmnnWTH++2aknuej8pVbR5sgdY39Wo4Bw2F8j6gelaMW7?=
 =?us-ascii?Q?gRzIuJEOYclYNPNm50bQjwPsqZWPDxqMMdwUhY4FP0NV6dNxW9lVN74JEd0M?=
 =?us-ascii?Q?cIXF5X9hYAuOnEmPxVVXJ78d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa8c8ff-c79b-43db-8764-08d913e8eba2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 19:22:15.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeKwwxHBZflUa7LYSWkM9NBnw6fS7h/MFgQOVKvbyJEqSSSkbP6EecVAk2pgrhQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 02:41:38PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The xarray entry is allocated in siw_qp_add(), but release was
> missed in case zero-sized SQ was discovered.
> 
> Fixes: 661f385961f0 ("RDMA/siw: Fix handling of zero-sized Read and Receive Queues.")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
