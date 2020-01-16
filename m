Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7113DB16
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgAPNFf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 08:05:35 -0500
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:13699
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbgAPNFf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jan 2020 08:05:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXbRukHf4eZN5yBNqWGsFrmE/+BVJt7nl3IZdsd1M2+3HLQhc7fFy4zaQuzUTMLHz8yyrxL+atZqSWE2mrgkmtKKhcaM2kaFK3UN2SmO2Y4PGwQs48pxbPkHxt2sSdDQK8JwbjEPNz8nK3S3fMMz3R77ThfXsSa+SHwOrdwA7mH+5jqyVrndP9ySPwCyvWKO4NzxJMRwILZOZZMESDUMvMgg0UBgVwW5Lts3FxFAuWvXAF6rVAM7kJD1058WGKmYo6X+9Z8rWrr71ybWffmXeV3GuMtHcAB0L/2Y+TO+s9GTJAYHQ3rHb4hl/tGYqP7N99pLrr0WE17Cf9ErK4/bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OQA59j2EPWddLjUFs97ujEQ7H1lmV6eIc3C2dOmHDw=;
 b=CNQqLZBfPiBZHIXd/uUhZUTeOiILdZF5cGT538xmxK1oEaAcFHyDCSbYOQDIHc4CT3kk+464PeiQGEs0Ou4vAG/Bboxk/kPNFtbgl+EpX1pJ7WiFm7eL5VKs7USZ48mD4qnG0hIqNWcIXpCEaQK5cmSr9IscwFKUzz/kmlQAYh4qqm4y2N746vvd49F67BKgAFJt0yYXDaVBFGrz4uhfUQ9ihGkrjtRQiY2PuLpnAZn4DSxp0/wUcMgu3Ei1ABWU26aW0XtbsDT/qo1ET+Itnvuf4oronkOo5CYPidawjwOj6p7nP9raYtI9KPYkZRfytyiKXo5FlBlh5mGM5iVhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OQA59j2EPWddLjUFs97ujEQ7H1lmV6eIc3C2dOmHDw=;
 b=OXqcMDvcgKTjs2DBLbDYNQZIGv9Dkgo4djSm8wwXXZD0qRVoHhEFCCyDj+LLHwcXyja+zAtr0Thl6ue4Gew5eyssB800FEWDAMVv6NbNvdbWJ9BpuQ1ENZfinSsryNOtDe50+lNp8GDMH9WLYZBH5AYqF29hPIsfETS4Xg4M7Gk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3182.eurprd05.prod.outlook.com (10.175.244.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Thu, 16 Jan 2020 13:05:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 13:05:30 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:207:3c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 13:05:30 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1is4pz-0002g6-69; Thu, 16 Jan 2020 09:05:27 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: Re: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is a
 fence
Thread-Topic: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is
 a fence
Thread-Index: AQHVy+FEjDSjACX4D0WvK+XBwBxvV6fs/KEAgABG2oA=
Date:   Thu, 16 Jan 2020 13:05:30 +0000
Message-ID: <20200116130527.GD20978@mellanox.com>
References: <20200115202041.GA17199@ziepe.ca>
 <558b9eac-ce28-a0b7-9830-5416d0a0f7ca@amazon.com>
In-Reply-To: <558b9eac-ce28-a0b7-9830-5416d0a0f7ca@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:207:3c::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a30dcf84-491e-4c32-13a1-08d79a84c37c
x-ms-traffictypediagnostic: VI1PR05MB3182:
x-microsoft-antispam-prvs: <VI1PR05MB31822400FD4D0954867B12D7CF360@VI1PR05MB3182.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(4744005)(8676002)(81166006)(36756003)(316002)(54906003)(9746002)(8936002)(66946007)(9786002)(81156014)(64756008)(26005)(478600001)(53546011)(33656002)(66446008)(71200400001)(2616005)(66476007)(86362001)(4326008)(5660300002)(6666004)(2906002)(186003)(52116002)(1076003)(6916009)(66556008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3182;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FwW3v+PPKQo7P2s/LyHUQ8usJMxHkZ95sNJBqt2bwDYHCSkyvjfDFdqB80kjSNwj7hj6IuVtknFpbI+kR/mMQdiHhzZLwRClQHrzkkZdRy0jHZB5CfNW0qVqPAMrDRPHAbIHpW6oDxzhZjJaz1CF4gzcRH7iZE66mW9Um/TA0A4U+1BdLpJUlaq9Lhap9kHY3EIlRr/Th9ru9oJOD4m4/A3PtoM8tCfdl0KUS/254EqwZ91ZV7GqiNekxB6EN41Th20SYkcNfpXB4WddZAPhTF2+bYEMAaZ3AQKEdWks7qVauoxm8DfJEOjnQRP5aPZ4VIMX01InVtR5AOWqrxbUY1EGgAGOVH9C8A1bXNhc1Z4BMz7YykOEsbkiImUeOLz4qn/QupVO53GDNZRV41n9rP90zZHHediFadVQn9sfoKvcVLTvHI45xTtPHggU9rznpb5sMER9ObzfxRimeudES2lDDxROrx/wsmQZrRAe3gU29pMOK9GLpKhLg9p4L9nw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C107E506D01376469308FDC542686E32@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30dcf84-491e-4c32-13a1-08d79a84c37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 13:05:30.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fhvk7Fa983dUw8TWHK9dpcJOQ10YOLsre+S7eBwRC3ieLw6LhSMzjiVCSjE9+qbBfR40IwPTJCIJKv/fijFBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3182
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 10:51:52AM +0200, Gal Pressman wrote:
> On 15/01/2020 22:20, Jason Gunthorpe wrote:
> > The set of entry->driver_removed is missing locking, protect it with
> > xa_lock() which is held by the only reader.
> >=20
> > Otherwise readers may continue to see driver_removed =3D false after
> > rdma_user_mmap_entry_remove() returns and may continue to try and
> > establish new mmaps.
>=20
> That's kind of an inherent race regardless, isn't it?

How do you mean? Once rdma_user_mmap_entry_remove() returns no new
mmaps can be established, existing mmaps remain. The driver can rely
on this, by, for instance, calling free_page

Jason
