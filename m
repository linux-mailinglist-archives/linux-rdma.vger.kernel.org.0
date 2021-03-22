Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410F344C68
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 17:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVQzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 12:55:54 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:15573
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230057AbhCVQzu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 12:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OslkxBHHvceisIb9/y5blY/dzU2T4u7IWkuoViOgErDfdP0w3t3CaWHuPllw1UDAdFhgUFJCYqwtHMrOnQDNJTTm5W0locM2wyMmCHK+uPiZd0DI7TKXdXb2DIz1PgGCr7Ojn6AG8f5h/AAvjkKbc4JQTkTLTQRJjcRK5AkSG/40USQyRXqpJHjHAZkL2QO+BTjUTkGyMkheG2Xxs1BlptPAnHY7z0izr4qpN1irUBJBovuY4OMybUQWCZgderrWqa9MaYpo2YMb4MEU2bWqmgCyvCpwIykknyN25+99DejGHviIe9CmVmmcrG75ThVVx7sEt+HUCV+QkUEN56QYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D1x8PFM5Oqryt92eF7wo0BbzBp30TYdiA5uFubi5kk=;
 b=Jp+lK012mB9BhOacwmCovCr6YdOXDIJZ6N3x6hTZkRwscx+ZXO9ml4Q+5qGV+WBUFVSDDCBi2ULJ3RYptxg+P8irFkgoEk2FbK5uIPmOwZ4D5GDylf7OWfdW7MsH3VJ720zqq9sm74aynvNHnN5kvzzxfegKWEupE+FqHXwxfPA1lzVOVwu0Wh9WCqigEPIrmJvnhgiob0g/8ofSwRcsbNIgXzIGCSSl3jq+icOHyfznGpy+C3OUnjCPmtCpCKmqb8hqo+uZX4UJ8iCLJBVA8RydVGWLim9WXMOSPbmgsgUO0WbYm/e5+AaKHuSowC3UfjMwCQfhnmIg4Qee/ELH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D1x8PFM5Oqryt92eF7wo0BbzBp30TYdiA5uFubi5kk=;
 b=ZDeylOfU8CSlLt9v2j2/NBPzB5DMJWFp6ShPPKUzmn+Iona7rg7Z1tlJEv/d0p0WSjSHYmvgQAojmnTWjwqJn9dVNnzhqJGkqG8RpsXyJmTx5Fd4OjMCivrTjuwdok0TdZKIdKmPpBoDykE932pTdg2rvHkEWc4hpGWWKRP9rj7UNv+GnEJfvxf2nuSqEGH/npBqYbhu62gMuSE/EAqx0MtWyFaacCUPifjAREoxNYjTG1OWA/KOXvimQD8VYkOLJExpKsPPla+KNVxEc/ERePG/r7SOadailb0c3PNjcnQ+Y9ezOeKZoRS25TSFvQr2ulvRImpIpZ74Aj+OE9YaqQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 22 Mar
 2021 16:55:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 16:55:48 +0000
Date:   Mon, 22 Mar 2021 13:55:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
Message-ID: <20210322165546.GX2356281@nvidia.com>
References: <20210316132416.83578-1-galpress@amazon.com>
 <20210322130131.GC247894@nvidia.com>
 <fd35f82a-abd8-ff53-d8d2-0e401ec92ea0@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd35f82a-abd8-ff53-d8d2-0e401ec92ea0@amazon.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 16:55:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lONqE-0018Fn-2M; Mon, 22 Mar 2021 13:55:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0863fdeb-e2ab-44a1-9830-08d8ed535799
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486273AE6F632AEED2BAB21C2659@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3kGLX17Pzr1MzIXqy2NGWCn+UE0o0UiWL1grVa6m9zLf7eOvuhopE7jaeI8ypV/hQSPxuPi3exK13EzMSzk2V8fxsaFeL24Q1RB8cDVcnyGy2kFezE1E26YXacy0f6Ql/UfJgVW48l1/nLmIa+cQu0zkh5D6zwQ6KzHGHg0YNIjoIIRP6mdz8Cox8XAmtYplz2lQ6hjz4XCchzfmki0AeHtPD5cC1LEEbdOTxT6oXacvxma00mUMRRJ5acyESGQ4SENiJ2xKpEEQcnMchZBUdF6GLI7H95gglZ4fBbfh5bXk5821uzb04wSFK6vTYsvDk72Gbe8A/KBxipVV5EYEjghWTF5DZASu2hlpYqDpqPUlob6SkPDWS1SKshmW3SHIf3CM7huWPYlfHQkUl7nIBon7AZdtQSaI7pVt4K04uYL+e4WrVaFnfBTAAVNZ4491L9uEkMGzRSgBsdVEjGtG42jJTfzaTS39HHgAlCX+H1FNz7k8jA61txmgp7WOmSDCzKkMbkkLMuUEAkPco6/zyzjSlu7KIlz1f31Y2oTmJto7BfCjMKrsj4hcYsLVAYhVok3pqYoAHwFBIu4m0641ZkxujnpLBgeiLhbiGTKli9zBCQwlP4E0ESutDTDlke/gyJozc02JBPIAmY3br9QwxfVDAF3Q93EdaZGTtwppNhfTKy+/aXxVBHYs8qkg0hT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(38100700001)(4326008)(83380400001)(6916009)(66476007)(2906002)(66946007)(36756003)(478600001)(1076003)(8936002)(86362001)(4744005)(966005)(2616005)(9746002)(26005)(9786002)(5660300002)(8676002)(186003)(33656002)(53546011)(316002)(54906003)(426003)(66556008)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NfhQ1GH4st+irsmtTWiWrT1MS+XG9qQOihkmvctWSMoMzbu+fEhbHAibapYS?=
 =?us-ascii?Q?KLAxlkd4WibPfjRGNB9qhfDOKHqevrtLz+1XmJv+zhpvW/U4D/ypnmTPhgLa?=
 =?us-ascii?Q?duQRtUAdN6NUjzyW96CIB4fEDH+FlIyRWHjfRtd7i8Khs5lJUCluScAtkeNR?=
 =?us-ascii?Q?1+8smfl641RFou1ip2uO3HzPR+WBevdpH4F0rICb8IAp9nZVBX2ItT9LTQqe?=
 =?us-ascii?Q?JUFa3J6CthL4XnoQRbbV62H9nABGLodvQUDelQmezditCJi7IzrusjJY4b4E?=
 =?us-ascii?Q?CYd85ZgqE9MvnWk8vtqe4yqyvZX2wMTy8iGsnmdcXXYwjpbpMDYqslIG+vbl?=
 =?us-ascii?Q?uJlCaLEfBVXu5U7+rsQgEfsBVqAIOWtTMT7vY0mBj9MLpSxph2UoDWYZeHyQ?=
 =?us-ascii?Q?gc7Lb8swJUuUuNFTw/ntx9jhor0CaRMJRHmSNneQE6bWMWNKs/wdSjpUwbPK?=
 =?us-ascii?Q?HCF5/l4VbEPji8qcxZ0/V2cHiNqBI8vxHewr4Gv3aS4qSLI6SJBa3xIe+LPQ?=
 =?us-ascii?Q?0Da6Y1x/qL8jS1xHgdZwfkDhGslqH93nodU+Qe7+4yDMgvxM74E57ahZNzQQ?=
 =?us-ascii?Q?2UWyRP01nB8ojubei7fHLemy+fG1/GB/APkkR6uG/P49VBBTfbO6UM82N2+8?=
 =?us-ascii?Q?F75iYyRGEtQfhC//Cjz34feELc1LzGOan7gfqG5daKZbUaZheDNe5n7CSL+9?=
 =?us-ascii?Q?HWUGLNh0F75vAT4Lj/0N9EH3tCOG/eXAbBmxchuH9CSvFg+MGvOcudt+dpdH?=
 =?us-ascii?Q?lXA6SGEhJxtVwWSra7HL2zKBulgTmcMM2d5wMH079sDeADFfuTR41fi4uDvU?=
 =?us-ascii?Q?Wkl1TzY0yTgv4/MTvEHoxNiuX7/ZlJGdcc8Kup67MTG0WlofoUoue4Ika4E5?=
 =?us-ascii?Q?yie3n+oJGnv9F2jTTGcf5tSTwZGdrDyKlICNHkcTtgx0PhgX9ZlY6PK7iw+/?=
 =?us-ascii?Q?wuasYu4rN6w22s9pDYBWoTxiBu0vopGYcY+NbPqeNWAgHSxsIWXrcuB6KqpO?=
 =?us-ascii?Q?evQZVjMt2g5zHm3yxSQXbjwrXkUIamkjl9fmGmpQlwbdyjrj/9tPRp09//Tw?=
 =?us-ascii?Q?BJnauL2N0+j55OLAU8VmGzO2c3XnWZc22aWa4Nry/bW4iIKy3Bh6d7qkYAX+?=
 =?us-ascii?Q?6pqlFupKiluLr0mH3463dU7fWTDSnJO1PRwj9Pix2YuD0k7t7PnjY7bRDzcb?=
 =?us-ascii?Q?8fPkxBjObapReyaydeKiLc0Gw8Rw/U9XYUM16JBCu5pB9Pn4o/UaUiPkcsWr?=
 =?us-ascii?Q?liy757zOJutCAUk6b8OsBSnjhk6NbmgWvvgDw/MV/xWZLaG7YmMeBiFaPe8N?=
 =?us-ascii?Q?0aWhB8Z/SfeTDniQxEjHpiZD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863fdeb-e2ab-44a1-9830-08d8ed535799
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 16:55:48.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KthYedKs6Z3rrg0qWZvfW5o2KjAUs7wkCEnO1P81ajtOwlgycl0jeLB4SCh/20kg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 03:11:33PM +0200, Gal Pressman wrote:
> 
> On 22/03/2021 15:01, Jason Gunthorpe wrote:
> > On Tue, Mar 16, 2021 at 03:24:16PM +0200, Gal Pressman wrote:
> >> The strlcpy function doesn't limit the source length, use the preferred
> >> strscpy function instead.
> > 
> > Why do we need to limit the source length here? Either this is a bug
> > because the source string is no NULL terminated or it is OK as is?
> 
> It's not a bug as is, but it addresses checkpatch's warning:
> WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Okay.. but why is it so weird:

        strscpy(hinf->kernel_ver_str, utsname()->version,
                min(sizeof(hinf->kernel_ver_str), sizeof(utsname()->version)));
 
?

utsname()->version is null terminated, yes? Why does it need to be
min'd?

Jason
