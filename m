Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105983B0CFB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFVShW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:37:22 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:48161
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhFVShV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XStxBTLu3392Dri8ardRcCB5yl5JOtEqVL+7evZiDYNWq6KO5zcbf4t0+7MDcbkAGBXc4TsXfSihcTRokjjCV7aOIbmwB3nevfW1pBCuZ/jINY3eWAMZJEEGYaTjU/0oczaFihXXrPyzbWOKQjJFIu4dYrq96hRp021TVwMGmrE8mVaQFL4KU2FPO6EBAqplRCN0OdphgAEQJaoeJzx4ltyaiZQGxAvyrbH5+KvbZoe4CiqbfSZApsFogJ9xQs5NCsM7HJrxIbaeKc2BZwkhBc4Yc5FK79O3+RaXac6d8/CPUd2zg82WfE2hpM9JLwnY6N3E/pJeKnRSSt9y2KosLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbZM4uKDt8+ZfYPfeiRCT25qWcqoOc0ouZ0C4JzRksY=;
 b=gi8kSL5TnPFgFWjsaUB91dC8d1IOwn/91+0KAY3uVk+i0d8/bi5DqxPFPZPZKseZ9l/7dRVy91KmWsni+um5kRCZQZQVqw1UbV8yap2aFa//qUh2pfLDwegqxYq75SZ+wUwXgARGEK3vvXRql6ussYhynzegp96Y/7r51v4hpKf2aO5d9P1MqswYjtO87i0pYS6ac+nprfPydYzr834uAGx61Y5SvpchXXOx9DHPGQB3xGotuwunXspzPtS4y4Jv8iZddzaISy4Ys3gRfj/dvIpAsE7qcZr3w6tF47mLLKgVDsudkP8/yH1aY8PIN5LpHCG7HeCiPK1ktagSHIwDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbZM4uKDt8+ZfYPfeiRCT25qWcqoOc0ouZ0C4JzRksY=;
 b=LOTYgWrfyXOTTxYebIGV9SCHQFxJJpWN3KphsvX82E93OC+NM5E2KTTL0d7JrYyzQFzhT6HDezFQtimz4C2seIuqf3QhCINyAz8CNRrhJZRPVKV6925wi35731rPzTtUJ5KPE3bC/e2eEbIxm2CYcJ/x158OpjaZiO+NH/DFc3R0Tjni8wjg4lI8epsZ2LqgjI+EdudO2hfhLey5KZxh/R1kiRsChTZr5Yj9dimkvfEufWmR/CgHEOfu0f8g+PIHL1Zs785uIxOqTeBJaMJ6L/9wikC6qXQ47IWbd2fADLzoCGBwZ47cKyXCRGVx9aztZ3tlkR2CKDtBd3ILSHi4zQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 18:35:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:35:04 +0000
Date:   Tue, 22 Jun 2021 15:35:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Rao Shoaib <Rao.Shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 2/3] RDMA/rxe: Increase value of RXE_MAX_SRQ
Message-ID: <20210622183502.GA2591169@nvidia.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-2-Rao.Shoaib@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617182511.1257629-2-Rao.Shoaib@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 18:35:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvlEk-00As6m-OU; Tue, 22 Jun 2021 15:35:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d83c7cf-1bbf-4050-9e55-08d935ac73a0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5159279B9D2B6E85AA782C54C2099@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23rgAFdRhvQWsMtJUnyHNt2nijgLvzYvxArQ79AwtqCaNGclFUeUu15i2CFSp4Cinjbyfb0H72/PmtOO7XF4c4liAt9jkfGFEoeGmhcZK+EKt1NrG6JE+dwWVfhuTBUc+0sVBZvRI2I/l1V7nPJ7OUSZJHt1+m7TUOrd4o83IkTJvgCrrKzSCQ+9H9OMepmryynRLJbEVSSBgMAxRdFq1KWvIvxu1r1Mz/kQeqWjPaBkBqlzddepStOkzPd3KF1KMzBBNtPUfkxVjsr+h1La7QWGWcTnS4szdZdQCK/D7IoztxGFRQinV94r4vR+cuL+MHsU9C76fsLCg07RffgwiRvzBpZW9Y8PSN3aI1Z+I7dQCZ41iZI2KwPDUFwBvePJbvtSIpXwbvXzqmfj+BZgxwa9aJqPx2wOajp/41giRVB1XMX/k8CPQlay6JFh1Zzs9R5gIEqU8ZB3EqeyvwViwn6G8pJ3U6IZdWEJn8WVJ1sm7mzP7UOH1zl57kccmOXqHsLPkJZrK9r+BFFrz/48Zg2YLu2DZLnW4JS8yQBrBnBQ2siG3BTWVmwHdbcyfiXxS4zBz6Rw4mDHQNQDPOdvfRhkB6WNtwoEhepuycCY9A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(26005)(426003)(2616005)(38100700002)(8936002)(66946007)(36756003)(66476007)(86362001)(66556008)(186003)(8676002)(316002)(478600001)(1076003)(4326008)(83380400001)(6916009)(33656002)(5660300002)(2906002)(4744005)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKyxdqb+umDan7QkIuKmIcrKPg/RSDmzWezBV/HS9df8rNqjyqolnaiuDUmR?=
 =?us-ascii?Q?hh3KXbM/wIabWdQpQ0QmaMEM0y97ZEYO1KzqQ7Veyxz0gP6aLrJh0XYHJwEU?=
 =?us-ascii?Q?SuZwqjyfco2y/UCV6Ug7fr4H6Bv7gwy3jIFVr8GiRETMYbjvbwNbRlbRum7E?=
 =?us-ascii?Q?SnTsHnCOyTi3k/RGLw0dJV4x6Yy9ys0U0EO5H9odNjeqBuWuRUGjyli/3RsS?=
 =?us-ascii?Q?nSrzkk4LfQjvVJHwpqKsW0uMZ4yUqYvcMHT0SD+/YHPMqJZ6PV82ujkclbFj?=
 =?us-ascii?Q?7qj01fafaXKmdny9bWmnvKWQeVBF+klJ1huXibHcu63B7oGJb4C46izDaz5v?=
 =?us-ascii?Q?6qpKusY8RHOS3hi10cDZjwinI5gfCkzDiVx9axeBAvXtEv07CgwY1i3tHuuJ?=
 =?us-ascii?Q?VufTTlyhsEiKlImnR+WdXcvv7aviq/Q4hxsQyNbX/Zqq3cTk9IL4etfjehJG?=
 =?us-ascii?Q?ZH7Fnn9D+fiDNA0pbL0uRqztqHc8G/81qgPEVuAw63nHz/7TyGR/KIJEAs/S?=
 =?us-ascii?Q?aEsQ/mBqYZ6OxX3T4wBYjbnuijeoe119fQNThduuD3vGmzdBJPiEl/4rqCEZ?=
 =?us-ascii?Q?6zWWAzVbxzh3Eh0eyI9+E++M+LsaBfLhEtPrCEpoFeMZeaIB1ZfJZWczccO8?=
 =?us-ascii?Q?l72w+6C17LktS+5DtiAbgSctIcV8rRr3GycSXTe0kqtuB/WRk7gGRNg+DMTJ?=
 =?us-ascii?Q?KO/Y6n2r3kBhI2max17rbaeph4u5/WWXNxOvewI8hd2V85wvyAmL0wUpPtzw?=
 =?us-ascii?Q?eREZIN6X3bXpkZvPYx420o9wwvU6OAfTHu7BFgxQWKeQoOMjZb7W1nZCJAFG?=
 =?us-ascii?Q?NVuRPpvq5qFGTxDs1wNS+aq6OMX1AKrWHlDZgcdR4G3EOuomMaI48c8bFT7n?=
 =?us-ascii?Q?qRmGT+foztLH9oTmn3/s+0n+hg6H3cYdUi+ArPn5xX4/Kt2VUE1M0Ge28Myo?=
 =?us-ascii?Q?id4MArJtyPvylp+YpY2b2YZcmsPT6GgyGpkiYTwGLSuVSRrQ6K2MaxRx6ZEZ?=
 =?us-ascii?Q?1FbL/h45UNkJDCSkZMutbVxfE3FZNtF13aBWE0dA8YWnXphuxCX+s3VZJVPL?=
 =?us-ascii?Q?18czcnbAjJOE7hflcM16er3W2TqfB5aroKtcD7iOPrHDVU2VxjCOj85kNzsU?=
 =?us-ascii?Q?8q4sW9wuZtzPRnZE/UAnxSk+g4pxxrHBy8ooUV1QP4cRWqHMCJVRU5rTP1pY?=
 =?us-ascii?Q?TIZOqBw0B6kL8vC9L+H2zXQLOlMyy0PETurWNgEuPoF9jRtb9fNXHrltT42z?=
 =?us-ascii?Q?h3mPhj8mGN20ebaZtDJMoNLTnIOl/PHUgxUna55doCiMNxnS9LwxWsKuviwt?=
 =?us-ascii?Q?41bZOaToLr2fxf4HGIT+QmqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d83c7cf-1bbf-4050-9e55-08d935ac73a0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:35:04.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apF/YG4loqZsstlDsrpY4wis6eZJH/SJp2sXd5OjEEApzO65hf0Xl8J1N9E/reIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 11:25:10AM -0700, Rao Shoaib wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> 
> In our internal testing we have found that the
> current limit is too small, this patch bumps it
> up to a higher value required for our tests, which
> are indicative of our customer usage.
> 
> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Well, this doesn't apply anymore so please resend the series. I'd
prefer you try to get rid of any hard limits that are not exposed in
uverbs someplace - like ucontext.

Jason
