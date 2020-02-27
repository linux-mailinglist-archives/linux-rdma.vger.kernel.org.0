Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E92171FEB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 15:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgB0Oi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 09:38:56 -0500
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:6976
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731885AbgB0Nzi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fqem78UgqO+Hb/ZVWsnnpd/0EekYj8jYqyICK15SI5+vRjUMOtl+WfepwP/oCcsYN7OWKi5xO0BABwjAPaUA7PQppSgyp/J91Ka6e9h+wfhtGCtgwWg49kkfgNSdr5kw5SSmKfSQlUAU4XfAS3GpzIoI1QFZoMiYT32xF9Gx5AGqqTbehYc8uGLM4otZ2Puj7EreU/0AsjTaA8bWmALLBb8cmhnsshHXkaHkyPek+wandZWMzJ1N4DN+64MK0PKGEJEVdXYs5f7/IHU9b73E5UKN8smMMt/Ad85JI4YLLOIRYkaN4cbhTyAH/qtqdSLzBLZB2Pj1SzrBoSd7W5KkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQao1s2mb3ImzjwT94Ls4sDwIFJz1b34eRjgTfJS/kY=;
 b=ZgA1AIljz55J7EoTE3TGN0raaYCWHsRrT9ZqkwNGHnOxCmifBSjIeEVkzOWaMouzGFVRqJu/LZav5ZW8+xqv2ZC6LWQs/8A7PPjTQz+2s8GxM7MWPn4WbC35f3GxYFt0xAk6tAhFZ3koWuoSzCqd9+/iD5TCUAV5o95iWxGj8WI8KROpezEAOIQS+azYI6NHm2t75fLAM90ckrMERoWGuaAQ2WbBkUgo8IgC3n5afpElb8+pyEL6mTn4pDEK8ZBwZbVLDOKkrbJo4hLlgAKQw5+LcBAT9srnqqm8aErZJqy/uL2kvuiTAD1V4/jhu2sbdw7to0It5LpUVqj8ISLBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQao1s2mb3ImzjwT94Ls4sDwIFJz1b34eRjgTfJS/kY=;
 b=Y7WukRDBN6GdialJc9zVST4dQUktiFE7bjAQ/a+OPGEPEYv5QCFVUgOmuZg+Rk/aZXiI1AWZY5ufNWbDBFlPjUp1i6YAEvcLKZsm6Me8lkAHitv0Y4fjwOe2W229vQBAzFH/NOKZ01TnURU1YxvvaEK+zeVbZwRr/a6KeWHW0Is=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3151.eurprd05.prod.outlook.com (10.170.236.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 13:55:33 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 13:55:33 +0000
Date:   Thu, 27 Feb 2020 09:55:29 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: rdma-core new/old compatability
Message-ID: <20200227135529.GH26318@mellanox.com>
References: <MN2PR18MB3182F6910B11467374900AD9A1EB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182F6910B11467374900AD9A1EB0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 13:55:33 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j7JdR-0003lY-VL; Thu, 27 Feb 2020 09:55:29 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dcfde8a-4b02-4d44-1835-08d7bb8cb6e1
X-MS-TrafficTypeDiagnostic: VI1PR05MB3151:
X-Microsoft-Antispam-PRVS: <VI1PR05MB3151E7581BA6120BD99CBC73CFEB0@VI1PR05MB3151.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(54906003)(9746002)(66476007)(9786002)(8936002)(86362001)(2616005)(2906002)(26005)(33656002)(66556008)(66946007)(316002)(186003)(3480700007)(4326008)(36756003)(6916009)(81156014)(966005)(478600001)(52116002)(1076003)(81166006)(8676002)(5660300002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3151;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egMDjMmFsRLst8EJFFgc0u4rA5G/FBsr1AjMGJbYxpZ0Ls0LCO/mKOOdqPFmIKcAlNeyuvswo8EweI1Lw+5dOQs2IEoOk0NlwUlk92waha32RIyyvAE8gtFejh/C6iJOCvT/WCuXkenEFFnEAjZ4b6mgyDgIsvLd8G1oJuCth+0zS0ta5kuGhfqZsHaN3Q35bdHD9UodDG7TizYQxuvMXVFbkDttR2ceLJNrwdjXMNwMb49jBulcomdogw63v3XsutQ0QJgmJJkfCaK3vL/KTJkTy2ISQ10LQVqTKVJ2FXnMEXmhukj9hkGXGEIUJfKDEso58YxjGVx/9h0j5JxeEl1JrprwomoqiDAL8Lv26bHhigJ2D2Q231rmofIjYrOkeT7GHfEb1J+5p2KHVkriKP2VXuILGVTqh0kOSun/EC8yQYkPdfRUF1vgDNs1sX+QA4ZgiCIl6D9hPczICH6gWvXguOeO8XJZwxUirkZ43AZg3aowaQ1hf37C9q2Jwe5cU3/oO/Z4ouLfDMpD8ImMx1kUAIGraVw221WRUGdlqBHLxK+t0I+R9gsq9ey5x51+
X-MS-Exchange-AntiSpam-MessageData: 3TSjg8jihwFSaVEPKapCP4Ze1cwkVGrQ46d5gjEwhmZqFp6lpWdYDTXkgT7yJPKSm65nXYdkSRm4jL3FEI74zLbN++o0ycik69Njf8sg/Dxfsy0B3TLf0D4KApU4D6gZcfqs4OB8A+KyzvK5wa+JkA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcfde8a-4b02-4d44-1835-08d7bb8cb6e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 13:55:33.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+Tqj+e7fW3/v0t/Oe05tCT/GVlp0mps0wgycXiHP00GWQcQqJdsOtlX5XvFugUholyEg8mDnpfQOEw10VT56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3151
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 01:11:13PM +0000, Michal Kalderon wrote:
> Hi Kamal, Jason, 
> 
> Running a version of ibv_devinfo compiled against an old rdma-core (ibv_devinfo from libibverbs-utils-16.2-3-fc28.x86_64 )
> failed to run with rdma-core release 28.0 for qedr.
> 
> The patch that caused this is commit c2841076
> https://github.com/linux-rdma/rdma-core/commit/c28410765bdfe5cbed3cb2cdb1584eac3941469c#diff-8da8bc8b2790169de557d5dee83a278e
> c28410765bdf 
> 
> libibverbs: Fix incorrect return code ...
> 
> The proper return code is EOPNOTSUPP when an operation is not supported.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> 
> The reason it failed is because qedr doesn't have a query_device_ex
> callback, so vctx->query_device_ex returns EOPNOTSUPP, and old
> libibverbs Compares the return code to ENOSYS

This is surprising and unfortunate

> I think applications compiled against old rdma-core should continue
> to run on new ones as well.  Can this commit be reverted?

I would prefer to only revert the little bit that might be needed for
compatability.

Perhaps we should change the dummy function to implement
query_device_ex for all providers? Zeroing the extended data should be
sufficient I think.

Unfortunately we are changing return codes inadvertantly quite often,
and the providers tend to use different codes.

Jason
