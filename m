Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127C9188E54
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQTwE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:52:04 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:6016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgCQTwD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 15:52:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRmgkGy9+Q9pda9nkVyZZnAmgBy3IbNQURVCPg+SMdZlAO0Cv+anxEJWVRLvxubpKWXHG00ccJ4dEscaCIIsoRRwGMHd0FlZN5pwpE/dFWjED/CoUFmq3CZ2O/bIzRNfyZTkCs0Ij0r5b5V+n83zx1GE/hRpugj5nB6oecsekShi6V98og+iADTpbFMC9Xb442sq1IJWUBBpgd+eQbqF71nl8/iaDwKF2xwWoFRP1ZYPFDVgGwfAAxCYFVS6Mab5qo37ZxVHckcBf7MX6CtItgrTluv6ZbD9hx9+m9MkQdkb9sP68pOkiaCzNDv/jBUItElQ6NupIn96QIIPKaDpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+kL9e4d356WJo7RLyePl9naTXz/AwxpcBA/x4Ecq9w=;
 b=FZX04rgoDc4zGrbdREBL39Xw07hFWhF1HNWnljGsMrUAKaGLqnWuv7gTchH78rjaBsjrzQalKm0RBIfQ87Gm+6VevOy7EP+2pEkVqY/98wRAeiqCx86GKqMOFpoLa1aasSaHT4EkefeZDAkZcpUY/auKE6pNMVqe7xY1EmOpYjgRxYEQMfP8j42XgnGvDB9Y+K/ZZedrkMi6Emu3Ht9OwSQC0F+ENJ/9jIzFCp7idNZVc6Wh2RvvRliO0FH1cceXzbRIGh+5q8wTE8vDNkDsT7xOGQIVovCFRZDZ/83sudA5TtiZI6gDqijrjaN4di0+uGsU4OWCAbGACt1fdVCY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+kL9e4d356WJo7RLyePl9naTXz/AwxpcBA/x4Ecq9w=;
 b=jpnjyuN9QeJqlYA2E0RFgDhw7qIMo2xB0jEd/CZHRBt+BO4x+OA81ojWtxnphMiDxEYnIt+l+ZoaKnhS2Ln1A+28celTozFnmVBHLy3QjpuGsM8Z1SQVeNW9uPI4d6Xrdro/qMPpMGRqul5BkfBL9CFvwtw+t2rPgqlgFn3aoOw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6990.eurprd05.prod.outlook.com (20.181.33.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 19:51:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 19:51:57 +0000
Date:   Tue, 17 Mar 2020 16:51:53 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: Lockless behavior for CQs in userspace
Message-ID: <20200317195153.GX20941@ziepe.ca>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:208:1b4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 19:51:56 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEIFl-0002BG-2D; Tue, 17 Mar 2020 16:51:53 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6504d581-3b02-48f7-d49f-08d7caaca641
X-MS-TrafficTypeDiagnostic: VI1PR05MB6990:|VI1PR05MB6990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB69906FD75C0EBDAD0DE64E31CFF60@VI1PR05MB6990.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(8676002)(186003)(53546011)(33656002)(81166006)(81156014)(9746002)(52116002)(5660300002)(110136005)(9786002)(26005)(316002)(6636002)(966005)(4326008)(9686003)(36756003)(478600001)(66476007)(66556008)(86362001)(66946007)(2906002)(1076003)(8936002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6990;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hr+u3zWqIRhmbi0mQHIpnt9hxQEzAXhTd4DqNzFJXq/859jfGs8718iqP8/iufuyCiI4YY3aHYg8RomNBC4v5cuCvv4ETKUwKT1ddJCojpmS6WM8ffoG20cJrd8skGJlsd1xNnDVCU/uHa+ygBRTtqJOisL2YrhI4+aokztTwBWNzq/YOToPsiw/MHaqLyePSbppQGAcivvygNM+z/gLBA36xqd/1HMg/KZ9rJL5nmPs3JhYDUJP+VPtzU5t5HUPikCgKGLe3+F8BNhha2VfuGSIc1lWR8JwDD8K/GBCr5ER+9q6C7kkpDj7anrCkfylV5LdDYboXj59YjwQG+/RVL/Ig3Vk5P2d/gEWfCHqjYwiTdWkthKpKYLcDqmRPXs6u4g18T0CmVZutTBTehBr3AIVfh4o9SC5TN3UgKwThckUZhm1GkNyxS6WmZv8tJ8vaJLSqH8H68s2okh3a49v6NXqt3DK8AX/hv9WuG/L14TlDS27XzPFDk9O1DaoDaboB3eWlQ55Fgx1SHHXbIulat4JFcJuR0tXZkSlowG7sBK//acAKafO40GiCA1FJJz4+yMupG5jtwvRDXBdtyzpAw==
X-MS-Exchange-AntiSpam-MessageData: u2ak9U8Wtkr61VHN/FdtHRQDQVQ3LKq4I6IsDCeVytjSk/HwkGCeLQt3D/RAPYgrDvRl3A00LVwn0leqikGtW53nQw6MZnzwC2+rSQMu5XF59Q8Y7vg6YmGr9Mt7XhQKY1S1wBFfkNm9x6fN9orpPA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504d581-3b02-48f7-d49f-08d7caaca641
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:51:57.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCAC2sb123A3J7xhhPYGgc7RYikN9R16iNIz73b9/Z5kD1a01f0iEWa+qkoM7i2Q8iQOP1GyRYR45AoC8VLJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6990
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 11:10:15AM -0400, Andrew Boyer wrote:
> 
> > On Mar 17, 2020, at 11:00 AM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > 
> > On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
> >> Hello Leon,
> >> I understand that we are not to create new providers that use environment variables to control locking behavior. The ‘new’ way to do it is to use thread domains and parent domains.
> >> 
> >> However, even mlx5 still uses the env var exclusively to control lockless behavior for CQs. Do you have anything in mind for how to extend thread_domains or some other part of the API to cover the CQ case?
> > 
> > Which parameter did you have in mind?
> > I would say that all those parameters are coming from pre-rdma-core era.
> > 
> > Doesn't this commit do what you are asking?
> > https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae93eaf8e7b9405
> > 
> > Thanks
> > 
> >> 
> >> Thank you,
> >> Andrew
> >> 
> 
> You are right - I got thrown off by this:
> 
> > 	if (mlx5_spinlock_init(&cq->lock, !mlx5_single_threaded))
> >                 goto err;
> 
> If IBV_CREATE_CQ_ATTR_SINGLE_THREADED is set, it passes an argument
> to the polling function to skip the lock calls entirely. So it
> doesn’t matter that they are still enabled internally.

Hmm, a thread domain should probably force
IBV_CREATE_CQ_ATTR_SINGLE_THREADED during greation with the new API..

Yishai?

Jason
