Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF714BF35
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgA1SJe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 13:09:34 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:1602
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgA1SJe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jan 2020 13:09:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh/iLywgqlGd0PCkHKwXFn63n0KhkT62rDHdM/wywt4QH2kzeVasQZ9pzZiqBR5C4PsXRAhD+Q5Tu7MbSNVijofBeUqdE6Q0hKlrFMqTlXLwHpin2hBzZUxQjmICgNY9Y10DT972FHkNWsJFHYb2VvJu5lOwjzEm9aes5BHfkgPzyZ3gsby0zS/esxWfwZWGClm+Q59dBdps+99GSLtLk1YdvFQ7mG3qFeY1h3sySxkLrJDAEVmvh5/ZiiYOvqCiZGF4lDa2T+shP5S2GKE7e2suHKMu6wRERbuD9QodwbT3DoALu4oc6S2ETkJVlBOrDINE/TvG8forKCkfDytg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsyiNuhURSQFlZS94+bqBsx5RbUPWai6kPLcb8nIqLc=;
 b=WM0UTPnunD9/yZpTdf48kXU9xRgwyEGJt38FCTiLgCNWjj9QCZ8pFmlFj9U5Mt3vH0+evCKDl+emCoHzjPjmEC65Ggurzmaz8kTE7CX1VPIUVlCPtpJMgdRrRWZ7NbbiaCKPy+a4OyJDDircWHNDht0zhMSEkZPa3ka/ZPf5Q8pJHkwtTF6NCj1yp93m3Kz5dE1gmrCO7egKvj93YValu54/A4YVThNxLIIdNN50cBu6j4zUm7OCg3i2WFhPCsyEaxvPL4wb5xafzlrRQSWDhH9vQc1r+pIjKr6m1iRJy7CT9ti0OWW5fCi3r6FhI9SwYc63rqg1qn/qGZehrQ+iag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsyiNuhURSQFlZS94+bqBsx5RbUPWai6kPLcb8nIqLc=;
 b=T23aDJJum6CHPoHnDXr5eWbBI/pS2FdNkzMwNA0+JupMK7/uOcFr4n+zFaCACZWFJFV1mSNGe2m0WiCnOMet43+JW1GiieTdm7w67Xne7lLWEl8ChQGpckw8K5BAM77LRu5L0YaGjti4j3cthuikqhpDATCAtr23UDqi6RPUfl8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6334.eurprd05.prod.outlook.com (20.179.27.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 18:09:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 18:09:31 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24 via Frontend Transport; Tue, 28 Jan 2020 18:09:31 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iwVIl-0006B5-J5; Tue, 28 Jan 2020 14:09:27 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Topic: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Index: AQHV0nqOllcH33mzDEKpmcLxvFc1Iqf9BRIAgAEf+gCAARu2gIAAI7yAgAECtIA=
Date:   Tue, 28 Jan 2020 18:09:31 +0000
Message-ID: <20200128180927.GM21192@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal>
 <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
 <20200128003537.GD21192@mellanox.com>
 <CANjDDBiKijeKZHr7uRO0gO9B+MPOwFBx6F+EDBdGF1QEXc+seQ@mail.gmail.com>
In-Reply-To: <CANjDDBiKijeKZHr7uRO0gO9B+MPOwFBx6F+EDBdGF1QEXc+seQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:20::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4d3ac6d-36b4-4679-6010-08d7a41d38d6
x-ms-traffictypediagnostic: VI1PR05MB6334:
x-microsoft-antispam-prvs: <VI1PR05MB63344834940E75227F5E1389CF0A0@VI1PR05MB6334.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(2616005)(26005)(316002)(36756003)(66946007)(64756008)(66556008)(66476007)(71200400001)(66446008)(478600001)(6916009)(6666004)(9746002)(9786002)(52116002)(1076003)(186003)(8936002)(86362001)(8676002)(54906003)(2906002)(5660300002)(53546011)(33656002)(4326008)(81156014)(81166006)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6334;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2ET1Kbsyb5vQjfDqyY1ofCu9e54wXsrtUOEWQzomszSWwncc3OQpUQ/y0jrZmM0qLFSvdS9O+Vm4kfmg3lgO70FvQmhkjZxn7FuPu2bsA/SK2qFv8ID23lqr6Y6a/gn4mCoMJ1LkjpBMPc3Irj88bJY3erMYgVhvwHTHwK4mHIQBxjHdRBMptudpz/2jyKy0zhUI0L8NdOYd3mx1Hqvr9OBEbr7DPvqtdTDogVzISW9T5Xszsx0Rtnb19GcRPIaPqkwIb1m7auDqMi5u/Q7w8EcsMwUKuR7I4wQ6Jv10WL6eqtNWPXS0fHHtQOJT75BxsB51mXk0bhy8CARZlue0ly1U2tlchmDL+QrZmQ8P+yVcWFCXWBUOHsD0Ucp8OpyDOPZWrl/Lmm7bB0IWHnjbicjqzVGceUtAgXtIe8zD8NEhbQ1ocx/6cSP2taDJGPcBCzjgl1WWXaMPC9QrrvbsuUa0v97NhOOXVb8F9mTyH5HVPPT7qe8hHjEIKad0lzL
x-ms-exchange-antispam-messagedata: ezFx81vOxKa2OUW+Rz4jLNA2zz+DppSCW/nGhVuj05fbJnYx94/znzPYb6y4eLOOB/YRPs7r2S9C2OEdg0FziG50wQNuTPk+Y/gstYdZuHO7j/5WTU3TM22DLuvrDq5NZJWEaQO3hN/54OZJMimZgQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C39E2EF6610D1D4EAE808890BE368128@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d3ac6d-36b4-4679-6010-08d7a41d38d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 18:09:31.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uqfg+H63myxXDX1p3OWNOjT9Yz3HMwmtD7Y2wrhBrXnn07ggVRmWjvOGNMr0vuSVx1ZuqOvadVlmOKwI3n7zTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 28, 2020 at 08:13:31AM +0530, Devesh Sharma wrote:
> On Tue, Jan 28, 2020 at 6:05 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 01:10:10PM +0530, Devesh Sharma wrote:
> > > > >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> > > > >  {
> > > > > +     struct bnxt_qplib_ctx *qplib_ctx;
> > > > > +     struct bnxt_re_ring_attr rattr;
> > > > >       int num_vec_created =3D 0;
> > > > > -     dma_addr_t *pg_map;
> > > > >       int rc =3D 0, i;
> > > > > -     int pages;
> > > > >       u8 type;
> > > > >
> > > > > +     memset(&rattr, 0, sizeof(rattr));
> > > >
> > > > Initialize rattr to zero from the beginning and save call to memset=
.
> > > I moved from static initialization to memset due to some sparse/smatc=
h
> > > warnings, rattr has a "pointer member".
> >
> > That is why you need to use =3D {} not the weird '=3D {0}' version
> >
> > 0 initializes the first member to zero and default initializes the rest
> > which doesn't work properly if the first member is not an integral
> > value.

> So should I remove memset(s) in v2?

I would

Jason
