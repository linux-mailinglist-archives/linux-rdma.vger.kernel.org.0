Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D371FCDF8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 14:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgFQM7T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 08:59:19 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:2113
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725967AbgFQM7S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 08:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+tutyQxd8V0JhmT7sOcm37WvEH81ZvCtrtzmAmHC+JoYB/FKBx28EOqVJIlsaqmrWOtHm0oLpV/V7i702WHlzMUIY6IoRx0pBYiAlF9+/lDLtnrf2DlQA0SwxOeMXauPnGCJDVolIQDcXB41I8IcOb39IvUKeBrkwNaCjzu7QBEF3uNN3M4p0Ix3ErYBlvRbMI5dJisgLGcloxW3qiT5fX5b6z1e8CnMwp2oPNr9KQhHuap6wbmpbNGUaStKLcheVnVhaoDgOc7gwvmKtbZN8Xd7g0Lotvi+h8fBAD7fy+TO9T+5C4BU/80VBTC552Kfbrms3npVUOD1AnbNqGEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rezfPdVW4z6Zw06bkOdYAV5qtvvzIsjhasI4hpcvOmQ=;
 b=LPJJMLmW6KV3ikxqtS3ssES/oP/V2Uj/6OT8yA21S/DXdnKbjWP4MoR5joRsBetrafjO0L9y78dAVarolIYTfKb5eLTSc8CjfBrGRzpKSFwqC05g88J2p6QnQRU73N+xybNTEBeVnTa446G07GWZ64N42Bq4o4BjxcxQ07FE08zU0iX483N4uUb6zH9QKhWIPSzGlGcxnFqfDXA+pEUSr3ob2akNwACPtbwel/ECqbWAVct4MTuWq6SpHdqCfHuDOWTm7eCKLSRi3tZqWwMdIyTQ6ZQiHv58LrGE2EIJfrpLmjPu5HLLLkQcSXi8CoSjzjO8ofVwaRG7scyaKbyeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rezfPdVW4z6Zw06bkOdYAV5qtvvzIsjhasI4hpcvOmQ=;
 b=moCz83+YLBZC5F+/on8Iz5AOIevyeLlm21C8euo5P8t8L9qH1B2orRLOB9nRtBYutqwLHMy91/PKWFfUnplctq4SdGaymLATzVf4nY7lGlMMlSRhdYLqLVb5E2VqRcCxzFb+QBnrRAWGJdQBclahUAd4BPF8NkvzXkuXojctXio=
Authentication-Results: dev.mellanox.co.il; dkim=none (message not signed)
 header.d=none;dev.mellanox.co.il; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4573.eurprd05.prod.outlook.com (2603:10a6:802:5e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Wed, 17 Jun
 2020 12:59:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 12:59:14 +0000
Date:   Wed, 17 Jun 2020 09:59:10 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] Introduce KABIs to query UCONTEXT, PD and
 MR properties
Message-ID: <20200617125910.GP65026@mellanox.com>
References: <20200616105531.2428010-1-leon@kernel.org>
 <20200617082916.GA13188@infradead.org>
 <20200617083138.GI2383158@unreal>
 <20200617083450.GA25700@infradead.org>
 <73708880-55d0-0f39-9195-9627d0da2d60@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73708880-55d0-0f39-9195-9627d0da2d60@dev.mellanox.co.il>
X-ClientProxiedBy: BL0PR0102CA0066.prod.exchangelabs.com
 (2603:10b6:208:25::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0066.prod.exchangelabs.com (2603:10b6:208:25::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 12:59:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jlXeo-009ZI5-HH; Wed, 17 Jun 2020 09:59:10 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 053b22a5-daba-42af-9078-08d812be3c53
X-MS-TrafficTypeDiagnostic: VI1PR05MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB457389D9BC8C9B8D37A8F354CF9A0@VI1PR05MB4573.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNzVUCu2fMdZcF6Q7dwac1Uvv6XaRUCSGbzydYeXnw7mAiMbA1wcYXv4uwIbGMfQWC8yRS3GagP1CJOKbaqpZV+2dv3NndjzLN8fwnI23fjVltoP9WUUYcepDB6cnf8cx4j/7NcZMXJRq6yS3GnLJaVhQXZVVDgtYyU9pmdF5nh2PNl7u4YgmhUCKsFBMgf+4tfrcJT0lwV5PWegpfJ+T07vEHn4Ny8H094+qtJU6p0TO9fj7ongcd99+0ab7WMAYc3zrASlh2P0WKwRlExB3Ys3BRBMiZ6nyMK4PuzFIU6MPwpv95i4GdZjZirgXw0VPOYlTgGSGn0+PDXNgdgODg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(1076003)(186003)(4744005)(54906003)(478600001)(5660300002)(426003)(2616005)(26005)(316002)(36756003)(53546011)(8676002)(8936002)(33656002)(9746002)(9786002)(86362001)(66556008)(4326008)(107886003)(2906002)(6862004)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZBrH1NRX7nIWXpsW4co+8Z2TFxRpUc+A++RQBdbLrHNFr7gPf4Oc9ZBu2UHe0wstd7mk1aJKeQlLSy0hnNnYKILeToLFZlI19uyROR1nFEveKLXj2gIJD0wTh8uVAWyQz+JTgn7uaEc0Fr8PcGEuI270p/P8bCrKemdAJYM+ZSSx0SulDNwdlSHxGaIDkJN5n+Gtf/aSJ7BS7Mz61q3SHat1yBYQ9KbMbm8+Jy684UnjiREWWOhRy04y9xNcSAA3Vlfh8VSSXUjiB9X3hDRYTEE+NH7mubSao/KX5k1JSckCYD4TKECnQDV7hS1rq9OW0MyuLZwjo3qgu0Dxe446u5siJX2h+qiezbf8lX7QjFvT1ETw4Em/C2nnxZzcUgGS2/ITcvrqbbc4NphcVyxbu9ZmD5AAWw9AlWcnkowICCw3tylFlQ2mS1Bu8JSmRTOuZsEQsq3Ee1Zxs8SIqelTAj4/ubZZRTX6tbIUagNj/V0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053b22a5-daba-42af-9078-08d812be3c53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 12:59:13.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmvZzIt94WgL6eaIigjI9umsg6UI8RZXtiaOHFUN2bf8r1yYUjW6WzGmxsfNhFCauIzeqOUuCNq43zRVuR1fSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4573
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 12:20:53PM +0300, Yishai Hadas wrote:
> On 6/17/2020 11:34 AM, Christoph Hellwig wrote:
> > On Wed, Jun 17, 2020 at 11:31:38AM +0300, Leon Romanovsky wrote:
> > > On Wed, Jun 17, 2020 at 01:29:16AM -0700, Christoph Hellwig wrote:
> > > > I think you are talking about UABIs (which in linux we actually call
> > > > uapis).
> > > 
> > > Yes, I used Yishai's cover letter as is.
> > 
> 
> We used in the past the "kABI" notation in the rdma sub system when we
> referred to the ioctl interface that kernel exposes to user space.

It is true, somewhere along the way it got to be called the "ioctl
kabi" which is confusing and wrong, we should move away from that
language.

Jason
