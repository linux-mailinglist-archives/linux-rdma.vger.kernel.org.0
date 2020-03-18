Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E503D189672
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 09:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRIDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 04:03:35 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:47329
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbgCRIDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 04:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeAlq3VBkNkaX3Z5mhF6ndEobKq7QMtbtWLguSFua/Zxi1P854Y9RGiN4i67eIqpoMUMkphE4i02sxBirWsVm8o9lp9sYSI+k1lPCRg5BxlqZ8OOB5lGKbSQBBxB25O13FmVF5Fvz7QcMK04qBnlF6WuaqEX3BOZPVdpuaF0d25iY1MNBWFEQ+poBouM0/lSs44YEZvjizBmHwgCBYUc5e8L2oi5M43XCisNGNd7eFq75wIIAkjYHQxqvdjYdcUcaikmZYqhMul2js240g5WWDRKTZQ1vhz9Z3sawiLu98MShjx5EfvY9OYAywWgiFNm4EJyGs0waSR/K9Fx/3sdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+M9m+qSmOllrOXWh3O0HJssy2DCkW+1ZnSp+Y0nr64=;
 b=M0ht7N4EEx5kqahBwlocIDO1LWp46zoN27HIiwgplP/aPoEuURDY8/Ss/Rpn5kZaduSjbqgWLVELyR9TbOke4YNrK2gxDocc/hTjqwad0UDlgfhjKsXgcl7J9UoHtTgoEH4sSF/cU9v5ZdeJ6OLGHWpLDVg3MqBX5zqgkb3qYkx6XADr/fDHXScPsvSc/opl7EEXoDqqSrENh1Su7v3Pr8THOfkb4Xeiv3HcKMF5kalnw1N5e03mbakMdgSNcBUYTYynqY7IC/jKRMKqsp8GDrEzLeuGHFBVXSDPb2YHFfmT8fwIJ7JyWlMeNU0s7ptPVPcvvArKDT0NUq/mdDo3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+M9m+qSmOllrOXWh3O0HJssy2DCkW+1ZnSp+Y0nr64=;
 b=aAO0B8zvC/I/7BlYJBNusbrN2R7olF2mCU5utGd6zgjk307LRsh3AvnRevRLNpeoIupq8LjGwmussm6pZUv+EW6+YSSj6EDowwqGl9aKnjL33+C++vcLN760NpIB6sUKKbWXmTPW3m58nuiSL2JaDJKO7/fsUPAIjLgJaD6B6pU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5490.eurprd05.prod.outlook.com (20.177.117.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Wed, 18 Mar 2020 08:03:29 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 08:03:29 +0000
Date:   Wed, 18 Mar 2020 10:03:26 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: Lockless behavior for CQs in userspace
Message-ID: <20200318080326.GR3351@unreal>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
 <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
X-ClientProxiedBy: AM4PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::32) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM4PR0902CA0022.eurprd09.prod.outlook.com (2603:10a6:200:9b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Wed, 18 Mar 2020 08:03:28 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2191a2c1-63cf-402c-ba55-08d7cb12d7e8
X-MS-TrafficTypeDiagnostic: AM6PR05MB5490:|AM6PR05MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB549098E7DC14A3772F6E908EB0F70@AM6PR05MB5490.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(66946007)(66476007)(66556008)(6486002)(33656002)(52116002)(2906002)(8936002)(53546011)(6496006)(966005)(9686003)(16526019)(54906003)(86362001)(186003)(478600001)(316002)(6862004)(4326008)(107886003)(33716001)(8676002)(1076003)(81166006)(81156014)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5490;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7hHR+1XZpV/oOAAr2VNMzX5m9DupP0FHsCEd2k6UitpWAJaU73uvKxuxu5sgCYNz9MmDPv0W+e1Mf7SQ2phBzdNKyLl5N00ls/5/iNH3Lz3K/yf3upvs5YTdSk/C3AOEEmOiDU2EaE3Js5VLcaOyXMF0eTF6SytwYow87L8u02Ewa7fWdLvNu9g96NK4cIngIbbxleGackDQ5W0HPC4Z4QsMwf+X0BBQrdWbifETKsXWq/O/3K1tY6Um0B6qlckQYBtVp9AFzv7hnkVkzRCDXzK8wnAVp9rSstQf2fZqHCCwsNupNLvGoH0ydTa62RJJLsq2GmEXGeKS75JhWVNYpfXPIXRaKuK+X7DfKjxZoCDFabrGaSh0Rlt5HiK5m15zDYszWHsNhX0SBy95X6KxC5j/sqLxX1IAiekbfcYjhAqo8QsA2VbL+VcsUtd5gqN1EJ6fcQiWVyIr5F8qI+v9zQg0AI7/imx8cOIOEy9jfQN22Gi2gF+IqD9k4cVFJoT2V1AqOGNn4p1xFhjKpG6zw==
X-MS-Exchange-AntiSpam-MessageData: Ckr+tIOjAjwM/abKYpWra2tsxj+5w4GLcm1k00GTCkNBcMYBEijXyR4LLNUKCQVd9PXxlF1u8s0kZAMDJlGO3gbQ5+x+RuNWmNd5dVDyH7RKwkzOPIJt5saXDuyqCN9Vxy6nrs5N4s5Oj7NGsNRRPavxIxwjjOIgRM2ApRwRbXM=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2191a2c1-63cf-402c-ba55-08d7cb12d7e8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 08:03:29.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12s1759+m6HqUwmBXckfCKAoRmwGtPh0dWWBPPJ+y9rUXVhKOPpZDN/15qPxnJs31UmGhEEE2TFAv3uCxuUmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5490
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 09:52:27AM +0200, Yishai Hadas wrote:
> On 3/17/2020 9:51 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 17, 2020 at 11:10:15AM -0400, Andrew Boyer wrote:
> > >
> > > > On Mar 17, 2020, at 11:00 AM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > > >
> > > > On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
> > > > > Hello Leon,
> > > > > I understand that we are not to create new providers that use environment variables to control locking behavior. The ‘new’ way to do it is to use thread domains and parent domains.
> > > > >
> > > > > However, even mlx5 still uses the env var exclusively to control lockless behavior for CQs. Do you have anything in mind for how to extend thread_domains or some other part of the API to cover the CQ case?
> > > >
> > > > Which parameter did you have in mind?
> > > > I would say that all those parameters are coming from pre-rdma-core era.
> > > >
> > > > Doesn't this commit do what you are asking?
> > > > https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae93eaf8e7b9405
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thank you,
> > > > > Andrew
> > > > >
> > >
> > > You are right - I got thrown off by this:
> > >
> > > > 	if (mlx5_spinlock_init(&cq->lock, !mlx5_single_threaded))
> > > >                  goto err;
> > >
> > > If IBV_CREATE_CQ_ATTR_SINGLE_THREADED is set, it passes an argument
> > > to the polling function to skip the lock calls entirely. So it
> > > doesn’t matter that they are still enabled internally.
> >
> > Hmm, a thread domain should probably force
> > IBV_CREATE_CQ_ATTR_SINGLE_THREADED during greation with the new API..
> >
> > Yishai?
> >
>
> We can really consider extending the functionality of a parent domain that
> was just added for CQ in case it holds a thread domain for this purpose.
> However, current code enforces creating a dedicated BF as part of thread
> domain unless we extend ibv_alloc_td() to ask only for marking the single
> thread functionality.
> The existing alternative is or to use the legacy ENV that mentioned above or
> to use the ibv_cq_ex functionality which upon its creation gets an explicit
> flag for single threaded one (i.e. IBV_CREATE_CQ_ATTR_SINGLE_THREADED).

"dedicated BF", isn't this Mellanox internal implementation?

Thanks

>
> Yishai
>
>
