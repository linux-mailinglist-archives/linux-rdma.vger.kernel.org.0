Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFC3B10E3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFWAFP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 20:05:15 -0400
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:27744
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229718AbhFWAFP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 20:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2ftMiEbMEcXRk8gAuJmc6amd1FX+OHMDffFvteoATQvw5b0m+8DGQYR1uNt8MAoBhJokXrmsIiVH2KgMd7rJ1TSZWyrriyXeNDxXUYbfcrjhEU2jq47ExHGIPMTLoDY0Iy+AxP2GI8xNZ4PIK3qjWYhj+dWB7yky89QBItuop/yyMoyk9mWhCuzRDLHNKGkeM0lbjycEnwy3GPYl58xx5VdroKqDaIuQNxPPuD7h4Qfc05++u2WmrB+L4Qlf5/o1K7qdnDDuGbT3Z/DfUziH7gRIbLJAlRMEnCyVg4EneTtLwUckt2dhRTeJVVcQ2s2M/0YcT6oj2By/0FcgU9iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0MlQJ0npydLfNc0+8hGNVnYVGbDzNEOwTAi+JueMhw=;
 b=IGHkXRvk/P4bojRV24foKVeoWCz7VUXKSFdt4rfiuUjKaqTxby6PydfIKt2wcie+JZ7WhLTXHVmWupCA4Od8820UMRtVi3oGERnY2typpjx5tekMVdg7PsYuk2Ff3nt9kRJzNxl/3G1puJULmfY4GFEiL7mCaiZskhRvvgnPV/rkUJ97ZztwpqETyGegPtt/tZyMRDTIO/T9OBn2EFy6mrIkO0vlSVaqY5/8AnjIuD23X+rAacZnFtXV9r+eVWuEp2bFDMV/NGEuAjg6ITLcX6SWq7Cb54sguHBLKNSTsfUW1f6QocRR+pipryyhvfHbq2enRhcZaqgVjU+mX0wi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0MlQJ0npydLfNc0+8hGNVnYVGbDzNEOwTAi+JueMhw=;
 b=aCcioQyD6fWLPfDahtlUA1CVqZi7eoXKuXFDO4Y1M8hTu6jHqB3A6gtHle5JLs9MWShL2+mFs2HE4t3s3r0cm1g0epBm/gu9yiczoFEyPV9rEzSF1pKZv5wT0JGTyAZVW3b4r72mQNqnnAc7E6QuWQEsBCgfDx85sYrP3oX9bKIM9ECDo4Od3xOyYCIytIqdVhi4+D4qXZTPrx7UvfaG5rfT0BLb3GraUbFHBZd0BtUBWikgdzl0vpMYdW5kGDvPgckwJIIFgNCRK2kclBRtWbCGPMHwBZNTuAgri5FtE/R5gAzVkH0hSSq0MlCxvRIroPGuBcWHf9yUblGFxMVzMg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 00:02:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 00:02:57 +0000
Date:   Tue, 22 Jun 2021 21:02:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Use the queried port attributes
Message-ID: <20210623000256.GA2685993@nvidia.com>
References: <20210620201503.67055-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620201503.67055-1-kamalheib1@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 00:02:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvqM4-00BGla-1S; Tue, 22 Jun 2021 21:02:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf12e4e8-18c7-46d8-d719-08d935da4196
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52062CA713FD146C17015C76C2089@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S2OFhx9LusHgtazlVZP2hgGA6/9nkzpb4LmxjDfaWiRHbwUXm5fNI/wEMXdj7vyQB4yPEg//t+aE12FsiUMEw13jn1cNUzXH6GW56w8cRHJSFs6u7b8yBtno3oISijPkW42BmyXotIkkuwQrR311IkjuarnpXLDy2xJRULEY26F0E+foCk6eAlkFGReO/Dl8v07QKgy94v054W6N0Elew39PwtmDBTeUKnT31QDYWz3fWWD1n0GUyKU7lZ5l8V1kTOgpPIatQfFOzKN3AiQ9Zk1tlDCsQJNuYjXumSVuDQOFsT9O4lpFh6BQD4rP59UWjVUuSf61p1g+GfEiWQxnrqM3ROdZNJGDiRwdpKYZqTInZvQYLE5U8Tdxd/gMTOjk+fZWj+Zl84aVGkKmHcpKdEPDdxDiOF05lEhPnhf4Kj+imA4ikHhJQWsBvQC5zeozskxnjc4sNAWoLJhuZhuziXUr0+hwvt+pjbliYJSpyTk2scUsAZPR4+/HpTKmoi9tJgg2rH+WiQHqHbVe4rqZsHoR0teV+zPI1rE6j/hbFi9uZFcZjharsSw+JP/403WlC1XSZy51eWSibtpPwA/WLvKgMZnhbJiF5/xsY1o/p/fjid/obIoikMxwkvr7Qon8yYyF5LNAUSWH55hzNONhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(6916009)(8676002)(36756003)(8936002)(86362001)(9786002)(9746002)(478600001)(316002)(38100700002)(2616005)(83380400001)(426003)(2906002)(4744005)(66946007)(1076003)(66556008)(66476007)(54906003)(5660300002)(26005)(33656002)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jaIIe49Y95l8ZkaTG9Ly/Vyd8OMgMqatTaVbjH9ZUxxbZhg0YURgyfR4PaMV?=
 =?us-ascii?Q?xOZl7Mz4oD8uQV7+I2AFB0veDPSlW3CribDDaqbPkQFmSIud6ncmUDadPMbp?=
 =?us-ascii?Q?0vpl+zbV/dCNtYo5rBZqpZX8hd3BV6AOgGEpxCZ0h5Hk07tdJcF+kR92VEPO?=
 =?us-ascii?Q?6w1jNj6mCpEwgpSFsXVXyF6VJPRQAioZf32DaqbojhsES4LjuA7SRwyiFOEO?=
 =?us-ascii?Q?3a8LR/o0s7Z3SyPJaDVPDssq46lgZhDv0GeDUlI+PjvX3PtXJH2+bCkdTne2?=
 =?us-ascii?Q?D97j1bj4QDnCRgU5FLncAX9I6IktVmax37tU7gowcxf6GirNR4Xbxxtp56C0?=
 =?us-ascii?Q?bv2lq3V8+3b1VH8mUkvBKnvjdv/9Xxtxp2JwAW6q0A9jlG8NIJdt9zV5cnaA?=
 =?us-ascii?Q?OAg5lHZ1uxqBiUbQVc/8N9/1ly7QyKJZo0D6N8y9y+Om8Nd9w/Xw8cGm1hZ5?=
 =?us-ascii?Q?4kUIhwXNPF85UeldT4lmomPzoVa5Ft44EO4wqFDFBrBu8kq21LSxQjC037Z+?=
 =?us-ascii?Q?CPFlrhXdETy7aSyDCB6UxxdnDPYmlrEjWy6hiSIC85/+9EOh9/H/TSmwOH/B?=
 =?us-ascii?Q?0YnZwe3lhW+CX/mNgcg1ilihkxmfVEvuN9PqT1eAernWL3OyzhaZQwt0BxcB?=
 =?us-ascii?Q?uEyNAIAeIykAMeV7FTWhWNDQEL7ULqVJMuKpHCjVIWO1ZJPn5UkmXgjvgzV7?=
 =?us-ascii?Q?KSHwRdOwbqJay+FxD1K39rA6lxmtZQLy9wNeafjPwYoBSWbL3L6IFhHfrYIv?=
 =?us-ascii?Q?jwaJs8k0IHPKlq2/bD1aoRbwoibIf4KAnlR7q8ppwrRoU04ABQq7H4CaAfJQ?=
 =?us-ascii?Q?JVQqJuP/zgeuM4V3OChMDxSVn1qXzzP3tkBE1b9TOiM0OMoZwK9k+ePRUFVj?=
 =?us-ascii?Q?EZbEzyJ/EulkN84naZ6w99iVwPma9g1hjx2d1WAkt2/lwpXgS93rvtvZ30wM?=
 =?us-ascii?Q?VtfNEQYRtdxzJXu4oohME+ufty1dZFHtRRLd3jymnfV6KPFkk/GdAZFbdAm+?=
 =?us-ascii?Q?wG/OSD/NaXOtXQ67hMYkVgJYR6d4K1nheec+pBx+wtM0kPZZj7SJstz6k1e9?=
 =?us-ascii?Q?mTshaMQr0Wv8ZlVKdHXvj/xXF1kKi8T1cV3A4oD14ZbzXoQdTsuciGZwbqLU?=
 =?us-ascii?Q?xHsVpq81IBSSqaMOl54IDJOlUut8M3vI4/iGqc68AZ4EHM+2x6pq1fOWnFF2?=
 =?us-ascii?Q?fpoXDcSj3dLjlV40+FiK/tv2nTsINJFO9c8QvPs9TcjxxamZWbOSEMe/qOIJ?=
 =?us-ascii?Q?zLpt5NlH6v/0+ZOuoPjHk7B9OPx0pwJOrXCvCNqpxFx5/ccFcTPeV5eElkOl?=
 =?us-ascii?Q?mkvtd8CsTO3JgXksbkfuUt5b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf12e4e8-18c7-46d8-d719-08d935da4196
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 00:02:57.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ3GOmwjop+pysVXCNDJ3am0g7otA77Om1/BfzvirbXjH6cL9Cwx8q1D8Le6+uof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 20, 2021 at 11:15:03PM +0300, Kamal Heib wrote:
> Instead of hard code the gid_table_len value, use the value from the
> ib_query_port() attributes.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
