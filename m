Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28647150F15
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBCSEP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:04:15 -0500
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:7078
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728130AbgBCSEO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 13:04:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb06whqB3v/RUs1O372xMAZosfpm+QXOogf0ZVYvuuPCpowiTZWDzTzcenlamsDszre6fn3NMiwKWiXltBpdgIDOeesoF+zOTHiWlb34TZfUTH1V+8C2NVgfb2pIS9pHtOwtIv8NfXusqOGzM+MfvIdVy16+kCsG3Jf/EIf4h1jmhWYFKJk/FHaVOVZOgCWMIWGHvYhrx1DEzO+/XAAIY9hVSzDHBy04jJXbiPa0Vp+UXz/S4/cRK5+lSwe8QFztSQWGSgbvR2SiTNpqHDaFJiqGZacFBaLxa2gLv2AJlMvYKo/2j2T1hZbfICdKlMm/PisVDbMpQx3UhUiIunTLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrQix9V/kCqMQbFUuHhhji7WflJPvFpQ3VTr2fN6KhY=;
 b=g3NBmgjdZibkz7Em7TqLl5dL5wLTUrBDLMGytyHuPyuaY4A4orijRMrcEj2ZaxQDzaeWGqFZsbk01RQMdv+RMukG7HllDgBQvfDBentDegOU1BCXyQlGORtF3GF6BdwmORRw5nIqkrVqvAmyBg1JLTHWU5KZcZewo9p0jA870vIYIFs+KnXnjIT6wd0JsWbxoBeFll4EE6OYtJfy+ZSS4mxywaAfVkeJb/HTPLsdDNsVpw/eSLW44wWeFm1D2D5PvCUciDacYwOzYjd70c/DbZq2w+v1jUGswWrqZKSVpD6mVwWca/FNWMIcaUy+G1VCVekW2gsXudht1no51V0Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrQix9V/kCqMQbFUuHhhji7WflJPvFpQ3VTr2fN6KhY=;
 b=QZPGaVoCDCxD98au34Dr/KPY+NYzoOlTfQeu9BPs4TnbBgUHGfEtUJ+xArozxjftcALZ+lTzrrLlNqsF8gxglDzDARepQ5afhT7obOQqbE+nV9Gp70R2N6/m1ixzjYZO6HbUBtbIROuIhe3CswchqQdDHyXWdQoUXdaZi20PGKs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6990.eurprd05.prod.outlook.com (20.181.33.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 18:04:10 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:04:10 +0000
Date:   Mon, 3 Feb 2020 14:04:06 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Parav Pandit <parav@mellanox.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200203180405.GR23346@mellanox.com>
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com>
 <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 18:04:10 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iyg4s-0000GL-0f; Mon, 03 Feb 2020 14:04:06 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aad72e9e-b49a-440e-01f9-08d7a8d377fe
X-MS-TrafficTypeDiagnostic: VI1PR05MB6990:|VI1PR05MB6990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6990FAC5CB0F9329B628D25CCF000@VI1PR05MB6990.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(53546011)(316002)(6636002)(110136005)(54906003)(5660300002)(186003)(478600001)(52116002)(2906002)(66946007)(2616005)(33656002)(9746002)(9786002)(66556008)(66476007)(8676002)(81166006)(81156014)(26005)(8936002)(1076003)(86362001)(36756003)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6990;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynQ6UmkxPJzqodL4NrjcldkSS4cxDvCAjH9/s6ogn/trK6lKrIgaA1kpY5bDe8bN5WZCZvjJ9yp8EB5RGWzx//gfItR40ub9Ohuan7TGQvg4rT8SI7okpRfn6vsULidOznTXkCHNLtx5ABPwBNzjNVq93M1U6E2SOejmCq0GrjLRx44TaflryeXF1XkcbB+rzvCZ/teMChJqSjydiWSGSacg46wAHcqBcHldzLB1v4Mmltj4IZUqUunUfg9XHub6Xi2m322vK2rY+372GZRxOboMaA6wIIvvPdXyzkjOLwXYLYcF47n3C3f21cnK6N42Z05fJUHYXhSreAEArvsrHMnaitJeLaf3EfdWuof0NJZvTAH+cp88Z+Ex5qJeSg/8nteF5zDj6r8ryiB+UIJ3+GNaiZEU0O3fRZ9uMFD8Aauncv7zidfI3qDTeXxum0I9g+iYJD6EPmPJyY+pZHvy0xfa4OqKDNE2wVlBeHU5ftGL61zdW/wPY2ykHpLQH4TS
X-MS-Exchange-AntiSpam-MessageData: IigigjBG3KerIIhXduHmvzej0VB+k4mkpmfA6G0rs+/d/tVuZ3tH4q5U3MnfwKwOJ67MlIZx6TJUmaDPprSOpym2loyBV1Azrq+p2VhWeOLQF58BmDvr7ZfAtjoyF8/SZ3NSt6neiLAOSGdDQkFUSg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad72e9e-b49a-440e-01f9-08d7a8d377fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:04:10.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYio9+FHjRlPgYhixibfjZz+A8CY5r3M3Nmemx0e7huDrWhCU1Hkx2M6C6JWfGdGM0porcWXLFCXeo3UBOEQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6990
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > It becomes difficult to make out from the output of ibv_devinfo
> > > if a particular gid index is RoCE v2 or not.
> > >
> > > Adding a string to the output of ibv_devinfo -v to display the
> > > gid type at the end of gid.
> > >
> > > The output would look something like below:
> > > $ ibv_devinfo -v -d bnxt_re2
> > > hca_id: bnxt_re2
> > >  transport:             InfiniBand (0)
> > >  fw_ver:                216.0.220.0
> > >  node_guid:             b226:28ff:fed3:b0f0
> > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > >   .
> > >   .
> > >   .
> > >   .
> > >        phys_state:      LINK_UP (5)
> > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> >
> > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> So, V1 gids would fall back to old style of display and there will be
> one more check for gid-type inside the loop...

Yes

Parav should we show both the v6 and classic format for a v2 GID? ie

        GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE v2
                                ::ffff:192.170.1.101

Lets also supress the 'IB/RoCE v1' string on !roce device. IB only has
one GID type, there is no reason to print anything

Jason
