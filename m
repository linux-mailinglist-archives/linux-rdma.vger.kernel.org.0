Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493461CFF13
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 22:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgELUNL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 16:13:11 -0400
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:23299
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgELUNK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 16:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXGaA9ZG85ZO5lzjQj510Xx2swGUaVoQUsxoP8i2QebSIKSwvnjgEX2wVPdlRk9E7NS2Ol9iISnuht4n47AYkrmNSu3WH0aQiQIc88egvTxePc/QK/N/+jcB7hCS4QeDTWOj9tXrVckl8ZL6eVyez5qPuJUiaIBC5LaYRigpA8fEbRss5H9rNEWTOyFRN5Ldn9WmU4MuU94NPnn5LFJhdW1dcFCkdITg1URC/2ZITfoQf/C9jEXomdWLCamB95adDc9jOTHF2GjSx49aVtZRoutnYjQ69XwLvwAgTQZm8hIHBXB9MiQ2mbYgDqh4VRg6UCCSlgA9Da1WiIPQFYyXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f4senoJYgec6xtoFUOCiQM9LMj07N41trMYnQP06nc=;
 b=H3dKhZTnu/ML1ZTobT9y4oKz///HTboo7Fun/cvInOpJMRg5wfl+RwBGqCxpvN2vE4UsPEjyuZTJ5dL9IxM/BlQdaEkaFBlNE8M7RyWF+RiNErvqws+J2uErOzhpIhyH2r2hkzwHtX30fn1lutInJChxemZ1nWdV/Jnxqpd9Z7RjKojUywFcZVfcExZwyvYapvn+WVVdZMKT5ChuTEK591BWoC20iVOvJCTU8rzflYzh7v0xHEwrlSP/VJsx5fOXPWmSwSFWAKfaEViX+5OgmCQMFMvILlVFc4wA6NM3WdHpMb5L8nqGr2l2nVD4efMfuR7cH3uhFWa97Lv+n2WHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f4senoJYgec6xtoFUOCiQM9LMj07N41trMYnQP06nc=;
 b=K3Kl0PdqM1tlAoudHFa5mk59o1A+DSojkjLASeOi1g8+eM6jsNcTd3qextLIvJmzydwOlQrSrZRXSut8norN3vG35dK3HeIRofk9koNZKUw1XHPdYmwcqHlfI+qPvN/4rssD0592VyVQOUudRn+qZuwP4vkvRKkgLgkKBg6xuLQ=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB3373.eurprd05.prod.outlook.com (2603:10a6:802:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Tue, 12 May
 2020 20:13:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 20:13:07 +0000
Date:   Tue, 12 May 2020 17:13:03 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
Message-ID: <20200512201303.GA19158@mellanox.com>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal>
 <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:207:3c::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:207:3c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 20:13:07 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jYbGx-0004Bd-LU; Tue, 12 May 2020 17:13:03 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4bd1de6-3fb8-4115-169e-08d7f6b0e275
X-MS-TrafficTypeDiagnostic: VI1PR05MB3373:|VI1PR05MB3373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB3373956C9825F699E0F1671ACFBE0@VI1PR05MB3373.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m27J6bBv50OjRzVppgZwnL5dsugSNna37jI3Ivc06iDApXzcSsEnuuN6VZOzu3rKmb0L/ad2CGifLSxUYdVQiEVfp5hCGsrqmGhwA8Pu99dhYcFwACuC0KQtx9ZhDpsIxQbGk2bXPCV8rlloIRvh9V7y9zGDRhG9PayQBc6irAzH4BYev+PlZPwehsY4dYUnjYznQBwvdgtJcbOoIgl/8gGhvG6nM3xjrGBLkvRxHgtXraAKRrJM3h2LTVOHaMoDQYQnJwkOl/G5XzzTnOCF2TYIQj68gNghtcGCMwi+Qf93ZMuPj7kwAjYpL7qhqC4c/L7VDcTtYJPwKjB7C3ebRFiPAR0ash68lW2+mDTbMZYlAvRUigbYS4i/DJtN6uiSW1WOV518xaM9/SwD0Un4hp/edM+GnHl/anLgh5zW60xA0pMsYPcfzRlTQwCcOq3BKCDjfA6dhPAEhsknYwLkE7YugrqihhOW6BIKADMxckCbE6FwaymiyqYged7YoFEcDYx7F+gSFcKRyjCPo9oS9569X+wMMbATiAvFagp64BRPC5GiUEdOQ911XGVeWP4n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(33430700001)(33440700001)(66946007)(4326008)(2616005)(66476007)(86362001)(5660300002)(33656002)(66556008)(316002)(36756003)(53546011)(2906002)(54906003)(52116002)(26005)(186003)(8936002)(9746002)(9786002)(8676002)(1076003)(6916009)(478600001)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aCAcJB9rNigf5YcjqmDiDzdoO3h4Acz6Ef/iKp+tc8NJwUhH7vVlgGNII6WfntfHmXykwZOAFYtpPNAZE/o9NbHDJzW+eq+GacEP7ZhNBa/WupXhChPFFJUoqpF5HPtIZhBAUbnjrnT4jR1T/4Af3syVSjTLG1sKkJ/F2K6Xz4KrzvV/FtONLtBmXeMKivvvLNM+6wjV/US/FLMr7JdB5K1za7bJgiZXAHXoj6vTRWH0IrCvutHSDAS4S/2nQuLRM0445cPslXKatC3hn1JXKWAzMwyIZj2Vz/sLmPFap6sb5Dm5+BNI0xObDvG/d9DlIWEuxY7p3gt/2T7YyPSxjhJfuCCXE07/7NGYboIBlYOf7Xcy/3Yxe2J/1Dm6tT8OFb3pJmDizQP5/lmJ7Ch78mfu9J9nOOv/BXgOnPo3ZLi6LTS8iejgSUbXtEnaa5AFR6BH8OEYOCL3twviV/X0YYFbzrre6P/umYkPWF9oq5fEDXKFl7h8JtA0GssixlYD
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bd1de6-3fb8-4115-169e-08d7f6b0e275
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 20:13:07.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWgFj3eFTnS7vzu8aTDY5aTcGUJfqT7SXRyid8b9wPA0UfZjGwxVZt/WtBlIiYqzqQ36V2o8EqwHc+80tsI+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3373
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 01:09:02PM -0700, Bart Van Assche wrote:
> On 2020-05-12 10:16, Leon Romanovsky wrote:
> > On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
> >> FMR is not supported on most recent RDMA devices (that use fast memory
> >> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> >> ULP.
> >>
> >> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> >> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> >>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
> >>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
> >>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
> >>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
> >>  4 files changed, 40 insertions(+), 372 deletions(-)
> > 
> > Can we do an extra step and remove FMR from srp too?
> 
> Which HCA's will be affected by removing FMR support? Or in other words,
> when did (Mellanox) HCA's start supporting fast memory registration? I'm
> asking this because there is a tradition in the Linux kernel not to
> remove support for old hardware unless it is pretty sure that nobody is
> using that hardware anymore.

We haven't entirely been following that in RDMA.. More like when
people can't test any more it can go.

For FMR the support was dropped in newer HW so AFAIK, nobody tests
this and it just stands in the way of making FRWR work properly.

Do the ULPs stop working or do they just run slower with some regular
MR flow?

Jason
