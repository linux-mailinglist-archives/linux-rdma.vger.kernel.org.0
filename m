Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE534AD4E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 18:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZR1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 13:27:18 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:54200
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230242AbhCZR0w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 13:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvXMcnIaoSspqMQf0frTnHkcM2pGsz9y0yNl8YIGUbsfEWnKjWvq2cyWtXRvtQXrNZJN0pVQkMas+90bUOcZThAR1tfUR51457RYVliS9Xx02Ik4t6ZHfi9NqhcsvhO/3tjK332yUKE7YOAeepXNsXKoIU+FRaSXoTbTAh0uRbRvYjCPSxftXpKwOsIxdtATbt6yJdQPQbowqdm8ZmArhD/WpkUayPxq8uR5pJG/ySXtWD23kLRijIJ2lsuaOxoAbu7Zo3UPniY1iCik1WgqQ4XsV3WedTa6wcxlbpoEcktL9wN1b5SrNKUdTX7KVz61TGM81W7348ThkSa+FpmqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWTe6L+7lqyrRsQ3L+9x6GYP4pw+xZNyHx60gsQVtEA=;
 b=UbjfaQ4jEkj+F31d+d6g4Znt91Hqt9oTz6qR1kCrUDq/MgHW8JPEY7Q2qM+eDMG6YwHMGgTog9xwpNpOmeTn1qNdGRHwNkh+o6x4p8kEokPuRRri9/Mu+/rgPi5Wiuw9Jo6qd0Z4z6CylMcA+XWEf5GFEBSY30v9xjyRe6fq7hxzJ0kBXcZtYZ/OCywFmYx7ioiDQAN1akTUKgjoPlZdwwZsdYQ2ZNmcC6R/OSyceMZ5RPvO/yElbsMq9khNCMdAV5t5pxT6zXrZ3zub8cuWfNN/lL/u5awYypjXLoQKMPZW6JKWsZUEhLvV109+YQuGd0aCsLQunYFibd3C+0vwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWTe6L+7lqyrRsQ3L+9x6GYP4pw+xZNyHx60gsQVtEA=;
 b=QlOmb4zaDKbvPBRYhMEw811S1mpy/anBJlM+Tdx3Y6PyvEKxjp1hm35+1sFQVWZVkXPuUaT2NT0EPa9ncgZlmv7j8NaTboCSlTHKK0Skfww3LJ1lEHklJ3m1W/IdxidV1QsueRdvgBWdqa52bLZl4EzS2pD0N/lUs8956nrID79WOvP0LMn9SoTN0Ol3MT3ykXFsqz5KEg5GjKEV8S1LeLvi4yYXQ+Sx7oXxybnNQUHw2fJsbfWRpgYjDXdOJdO05Q6ZTa/Wgwl3zTJlhy6/EYB0qpnUQi0ADMz8Px4/fVSxgVNilrxQ9/dUJVWGmC26NPWzl1o93ApkQ0Q+YVrp/A==
Authentication-Results: mail.ustc.edu.cn; dkim=none (message not signed)
 header.d=none;mail.ustc.edu.cn; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 17:26:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 17:26:46 +0000
Date:   Fri, 26 Mar 2021 14:26:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     sagi@grimberg.me, dledford@redhat.com, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] infiniband: Fix a use after free in
 isert_connect_request
Message-ID: <20210326172644.GB874948@nvidia.com>
References: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0349.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0349.namprd13.prod.outlook.com (2603:10b6:208:2c6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Fri, 26 Mar 2021 17:26:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPqEO-003fdo-4q; Fri, 26 Mar 2021 14:26:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d839dc13-be25-4c77-e8e9-08d8f07c546b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43408BF5AAA2411C06BBC49EC2619@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKEbRHAzlvYi6lWJvY2RGcK/IuPXraj3aO/aRffAMoFWyaEckUUFnucYpnr9xSsMpzpXE0YJx4z7rHsN0qdbaKaxTm1KcbVTRaBph6Q0oxY49YZ4Koqcqubj9+fdPrTyftrSJ4KQjrtq2libSlKXd7Kes7gZR0jDJiICW6rUfgW0iUZ4KPpSP+6onRiUX5dQXRUSvSD/4gOe6fGv0woaTYcbvUXMv+/NRjDFsGlts+q5pmZP4U4u4VotEKg2Vzwduu+JYYr/SjYao0Q5JY+sc/c3Gy+uwPVzgnkQ9LY74jdVobCQpNHYWVmdwR5PBfnoODGVV3YxI/2U9lo/gWx59PLSgbShUO944v0gwISNR2ii7Kooe4Z+T9oPXwNhtf63e8GCyUuZ6VJIkSq6ygDyVtzTEj2dmgaeE4BLy6H06R0e2FokY721EAsewSnQQTLzZYwZ6iQz5ceP+XJsExSaMz01WI8pFujtTsi9Rytie09YkxXtuUgIBDnB661uLJWnNXAudW7jLCKyQwU26DgWTmGiec4VFrJlSvTUt7tB0Hf1CzOA5fzKo0Verqle2mH6ni3pd9+HcwliB8WTaIQgw6wzTZ/LXhu2sgneCxuJt23x6jZUCJKQje2Q0Y9lxmdGKxtvXX7121AtLA86m2opyXaXNn04lKRwC6gUAT3FHsHvcoxkjFWD1pIu3417HzqX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(83380400001)(38100700001)(9786002)(9746002)(8676002)(8936002)(316002)(2906002)(86362001)(66556008)(66476007)(1076003)(6916009)(26005)(186003)(426003)(478600001)(5660300002)(66946007)(2616005)(4326008)(4744005)(36756003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bXEi2upI0lHFu0EyrjrCBV8nVlXYr8EQtrwYTAnKD5Q6sqXC37q/GcPWwsPH?=
 =?us-ascii?Q?esL0tNs2+y+i/d5+QPNx1IK/f53b5BkyYhU1g8PGyTRypaMRO/bcJyAx8g95?=
 =?us-ascii?Q?9J8yH4srhqI3GbIl+JZ4UVwkfMB0zUGjLbjhJVaso4FTXaX/Ubg/eV/KzKtD?=
 =?us-ascii?Q?ZNPJOuBsECXdRwyAWmp2h4YijpbqAu/jOE8haugaBxv5SvS9E49utvg3bgQk?=
 =?us-ascii?Q?BFqbDWSqwnQdHm1UNBE6INWmSZDHsJvKkFyCEsHZp1WJBbo7dfDhYSECb2qT?=
 =?us-ascii?Q?w5vTh+meRAO2kEIj4a7QizUsKsPO6BX90KlOwg+uj5Ur7moPbA/c2Mo+pknc?=
 =?us-ascii?Q?kaqQXHAJSqFH2rQWnF6l9bSph1dOmdCZtBgSKKcFsWgPIfAyfBpFvwWi4aI7?=
 =?us-ascii?Q?lfT404fbf07hHzaO3w0Go7zWzH676GByosfmiLAeb9dzbWAP3ByrgbJglCxO?=
 =?us-ascii?Q?x1LiEuDqCv03s6cX0zGkI8BJB4RVM1CirQ2t/GTCtElJoZQz+WFp1FjRyx3g?=
 =?us-ascii?Q?DNvlJg5ixcM+rNqqRx9m2QUyyKGJpHdRBeTXCWA69QM/Ko8BYnbx9yL3jQNO?=
 =?us-ascii?Q?z3H4f8XKjgI5kd4HMsE6lb/B6l3Vyv8j4pfnEazd/QwaqrnxMQ0o/jVbN5WU?=
 =?us-ascii?Q?lQBR9OEZb0uLlT0SmRa7bpP4bR9yPevMyR3kwwBi/EetpVEt/qzVcKbo/CVT?=
 =?us-ascii?Q?H4rxXGzZU8Ch5mjlt7cdNPRs79Lbl/Dx4S7NLUab5tKS9beq7AvlBt7s2QQh?=
 =?us-ascii?Q?0dXpgdTtId1PTuXF9rUbxRcJ5zErTNLZhPFVMWlwWm1/mk9BUSD1XXTUk9Tv?=
 =?us-ascii?Q?zlCxNPi1HET9tuBdUbRapx8MgshiLN3x1cGLzgKLd7Bk9Cu0xQgOQsZtD0W5?=
 =?us-ascii?Q?xZ+uBLQVR2sn6Gr0AB9HkjMx4rFvEjcQvBX9SaWgCggtoU0+cw4RLVUZB18j?=
 =?us-ascii?Q?s2MuNdPhN1lzODLI667hCGvadrxHinAmLV7FJX/DGIPEK7injd49MIL4QG4A?=
 =?us-ascii?Q?syaCZ3dwcwI4p5mTUXqb4bGKd/g9uK9dv25FMNjastuCUZv6b6qi/vWLvIk5?=
 =?us-ascii?Q?ovJtkQ382lKyUrgOtbZIRn1+SkHeZ/ZIDQPfvY2e87c1ELgR2uC1jhyZQDCN?=
 =?us-ascii?Q?+5va1M2k5f2RHo6Jz31NOXYt6HV3/k/sOsr74foyK5h7vIljwUgd7LHgVjcq?=
 =?us-ascii?Q?l5wQY673h9cCpVwpbcX34r8Hrn+3shGnmZ+aLkX4SUqLY5TNuWAVq1LN/OWm?=
 =?us-ascii?Q?1c/L8HXSIuf4huWnanhp82klRZJm18foI8AZ99qs0xy9yxJKjzeLY3B4EYy3?=
 =?us-ascii?Q?hfNSbTq99wWrrWEvzvgtkdrAbGqL/mYVXi1099oxKAP1fQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d839dc13-be25-4c77-e8e9-08d8f07c546b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 17:26:45.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cqrBy1BcMRPKWBDLZDadzwd1b6yH6H5vRJTiOSUwyzknzMSLA4ofBCJeDdF3jrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 09:13:25AM -0700, Lv Yunlong wrote:
> The device is got by isert_device_get() with refcount is 1,
> and is assigned to isert_conn by isert_conn->device = device.
> When isert_create_qp() failed, device will be freed with
> isert_device_put().
> 
> Later, the device is used in isert_free_login_buf(isert_conn)
> by the isert_conn->device->ib_device statement. This patch
> free the device in the correct order.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>  drivers/infiniband/ulp/isert/ib_isert.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, I added

    Fixes: ae9ea9ed38c9 ("iser-target: Split some logic in isert_connect_request to routines")

Please ensure you add fixes lines when you send bug fixes.

Thanks,
Jason
