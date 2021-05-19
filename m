Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09438997A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhESWvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 18:51:46 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:11809
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229508AbhESWvq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 18:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzEi9zLnWvFongnjsqj10WO5hcjOuP42J9hej9ouQT4mA25zrGJIVvJJnuvh2xHw9M4gMlIsh9uoPzbXGdqYwTHcyFFBQRUgxbSbxcLDcs3YUsufMBQvHakXB8R8wEf1o1BgCwEfTnftcRYXx1TwhDT5OrRwKDYI+wk6ACmWHh157waUpjDeSNrYI5LjpH1seV0Hvr92U+waZ4rBFV0ZsaPSSi3INvEvLJnq3mE36B+KG820QxH8B7EHVYHln451H3yYS4hEQI/yex0MsUGthEIF836zL26VV7XJBvVEmnxngm16NQF17lWjrPZHXRht/ndV7jwHsQwztUFT9R8m1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hz2K3FfzY0I/Y+aBe3jRngw+XSZAEjFinZokqJKW+c=;
 b=ebTBkhm9hWZD/0WsuONC2pO0W55TxK8K0xgcBJbkYOK8c0xlKm9Kn2hJdg0wp2zwJHS/odLqZHydgog515FmlTTBUbdMZXRRCb6k5bf+UAog6xsgvtT+wxmkVVMqGSZ3Ar9TP8jT3VVbChB19s14Opt6bqoMeV8+UsnHsyU0BJRD2G01RUCW3GQ2C3EPts2l00ejaMOUW9ZqLcR3DPRJq3/vM47/L1Yjm2jPOmUrsKr3cWkaPI1212Sl5vY7ILTXLDNh7ZMGtIm/JQDhMUnX9WgYCIPy07ODQycPa6nMUbL3dtgoJ8R12FBuSoe8Eiq7Zi0vYBq7X//DIqmoneF3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hz2K3FfzY0I/Y+aBe3jRngw+XSZAEjFinZokqJKW+c=;
 b=TdEcffx8FBiOIkihF8tmtaG9WcWosi7cqeKMuioUTLW6BjhULl3os+G9PldKw8bCSR5er9vHrgU7RD5h9KW3LJT5GvT30+j7pl7OINefWvhbGeCTf+RXqnG6bpYezvQ2NXeCU7QOkZoCHLH7UoF+zbqj9Zveu4rN3xRBJq2S8uix3RjrsiZpXM7XqjlVAu6A+XJmJqITNaJY4vdtx4NwohkC8ykSH2DRU3vsboYH9Xqib7xCJse3gVqa6xde7Yyuzp+fhj21TNTw4Jz3dbsqlsK70/iROsWYjzzeR0tFvY7DPtLsXgUuS1hIUiZrCUvOG4V/0CS508JeKC9lunDrsQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Wed, 19 May 2021 22:50:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 22:50:24 +0000
Date:   Wed, 19 May 2021 19:50:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Avihai Horon <avihaih@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix a NULL vs IS_ERR() bug
Message-ID: <20210519225022.GA2607549@nvidia.com>
References: <YJ6Got+U7lz+3n9a@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ6Got+U7lz+3n9a@mwanda>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:208:32d::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0057.namprd03.prod.outlook.com (2603:10b6:208:32d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 22:50:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljV1C-00AwMD-Ib; Wed, 19 May 2021 19:50:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94be941e-a02c-4c7a-c5ac-08d91b187d18
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548EB2953171AEE4AF81683C22B9@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfTx6ufb75ewdaQDNrEd7qTzipP7jFwRtkMoLx7ZbB8RZbH7GuE3J9s/tmNUyq3Y+qw4c3bKPuYyi1ETqAxTjSfeuIvy9NCFuwpON03hScWeMuJhMbvAauFNipyX2WJrxsUPOgJeJC8sRceb7Bp3sl02xnmKnqB+afuRAWzRYIALRQHt9d4Dj03Hs1Mhw7ety9u3PkPUk0TBkjM5G5ZxZ4A6Ss/KnE7yGSCvJ1M4M+Q2U/HnJYVoI6wsdphyYqPNPWh53rNQ4AKezhDM7xgkn9Q1bGrn2C95mSIceGRxUsWULiLL9GNE1bmZeg5LKEL7EOSl1HbBzvhM4Yd1v6EneUJSg6sSXmSFbcSpIHY9TlwKnWmWVOPVhAVcqGhpGEgVwUn/JYqp4G8sFG6nqflHMUqBVMQpclv8jJwQZs+UuGQvdUFZVEtdXINra6R2Lc/eAMutBmC8PRihB3eYakxuq9VgeGSl+QqAhaI8nF7xi26veRZas2ZEapA4e5PZQZP0JN2kQ73SrX3IvUC/T/qeJUCtYvArUCUgGiXo1sOA6qgEjWlA0rU0TTwLoFcfFs5tP6WQHtHxA1NsRfohOcFVBLrmrVoesLk0y8q5KKIZZ+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(86362001)(1076003)(4744005)(36756003)(4326008)(66556008)(8936002)(6916009)(66946007)(2616005)(66476007)(8676002)(38100700002)(426003)(54906003)(33656002)(83380400001)(316002)(2906002)(186003)(5660300002)(9786002)(9746002)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rPlkaDOQzZFS3Uqqa7dCnQI9DJgs/gre+DrSyBcsk2rm2z+PQu1JYx1z3zLK?=
 =?us-ascii?Q?AzYsQKu57Zo2lYCNP++EzDrpiziXn8YI/9pYj5Q/R3j/+36aABTw8XgQOWkg?=
 =?us-ascii?Q?waN8pxbhLXfAGhJzdLBzXHq5u3fdIW3BS46W1hh/fcpF7VsiquEZP5xOt+9H?=
 =?us-ascii?Q?CqW6DJdFxctEhMII/W+02r3+ERbEtXMWwk0g3tLME3tWDtflffWAZLVNpefG?=
 =?us-ascii?Q?Ds85w+EMnSqHHNtjtOGtUdAtDKQDfVZ3UMc/g1yPsJ24kkOwLsBkz8zo5JnO?=
 =?us-ascii?Q?J5oeH15EA7vYHGDUT/u0XbjsLzd5Q4h+3ndfCj60YAzhbjFRUbLysvqfqiUx?=
 =?us-ascii?Q?rjvLNkvHWQNF9ealANljb2QtArFX0K0mwUbN39JE0FYkoLE+FoPYruqSdbdu?=
 =?us-ascii?Q?XApoHcbj7/RIK9AnYXO2EymJfcoTrmqMUlRF2GbBjEa33HI26Ni30p2ScI7H?=
 =?us-ascii?Q?Y/Q75CHCnz3tkHqCJ+Ku8+BExicOoeqBXpgRcnwnjuOFC2YnJSpRy7EZsBHH?=
 =?us-ascii?Q?/ODyROcaFn7wU56reKK6C4T5L9fQhJz3codXfzybcVgyvs+2TvE3Sld4ObRD?=
 =?us-ascii?Q?xcMXe8dajOqrD0pBU/xcW16fq8dni2mkkHAS2eng/FXLZLgLgHFhyKV5kwfK?=
 =?us-ascii?Q?LSWdsYLmpHJthz0DYP1tnwHfp6MsN9wqQ1PaeBBvPxoenza52cvuvnEA/u2V?=
 =?us-ascii?Q?VOXy+yBQZcjTjQnsyISbDCXoFkjrk6xU56iz3CetgM8xf8pQvMWLXgYe88RP?=
 =?us-ascii?Q?2NU6xwOtg0GNJNs7rKBx7rI6eDwAteq/b9QwGcWegM40m4su/62C6o8TWjOb?=
 =?us-ascii?Q?74YqXBZLiZOb8fZKCNYz1FLSWhPBhTIuIm6lom2qTnJL3ZMsmvBOHEZJy5gT?=
 =?us-ascii?Q?6G+81uPfOXqj7+AbI+na8HOJppes7hxSGR5gVPPiFpFGF4EDxezkCqaNAn6/?=
 =?us-ascii?Q?6HgLpPwjV3N91o8YdboZ/Bt+Yqt5Xki+cAAN24HvXeHhEMHIHfqzwwdMvyV3?=
 =?us-ascii?Q?5vlgTET4Unj/NjQiB1u63Z+Pwq63I9OI2zGOFmUQ0OCQ3CLQUywhbi+nVmge?=
 =?us-ascii?Q?n8dZ4WA3fzOV8ccAQz6pYEVKQ3tRHS1pRz8DUBhERWJZN/1Cv6tDKY6nS22L?=
 =?us-ascii?Q?3r/mGd1HGzt+qUA3uLuAPGR8FvJ7cD3xzG6VRIsGwfw250klo8LJ6NNLSaDC?=
 =?us-ascii?Q?ZTXHMjwPlQJ0t2i+b/qRXiLsQoMpcSjoOKTib9GIN7sSelTCpTZpE7elh/zG?=
 =?us-ascii?Q?3SWMemj3NRNORLqRxlIAi/Yvm18WsYEKLpIxFGlKiofbsc71JdK/eiTMA/BA?=
 =?us-ascii?Q?90rTx2NSQ4rkwE+QqSdx8vRO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94be941e-a02c-4c7a-c5ac-08d91b187d18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 22:50:24.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkA0n0MxLt4H6XergRf3NsiGdoYfb17ix9ZHAVcbw8vDEJ6tvyEqTpaFDCxp7KOu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 05:18:10PM +0300, Dan Carpenter wrote:
> The uapi_get_object() function returns error pointers, it never returns
> NULL.
> 
> Fixes: 149d3845f4a5 ("RDMA/uverbs: Add a method to introspect handles in a context")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
