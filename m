Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B554514AD3F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgA1Afs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 19:35:48 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:37311
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgA1Afs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jan 2020 19:35:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOIExprgQTp4uS6CTAoM208BSrTvASSY1I2duE/ztjGW2VkRFfuVBn21gEX2sGUQhg4ZA4B2HpxeUeTKNQI5E6ItDSAi7fXmZ244g+FqHjCseYv0Hgms/sMt5eUAokaFPRZ0/cjEopUZFn23VHo0dipzu71T47UDHn1v4egPlzTkp/7SpP7zWibK5FIvW95vVhEujOWYIqP3a0iyTBKzqpBbh9YAJ6Vd/4oaONQHBNqyRg+M2UoI6+tSWrr+LxkuQmx6M4unZk8/vlxCX2/RCrVlKXJ6gFGGA5z0QgU7+VTNWi0zBj9aW1A8yBUr/YklvEiulLRgwXAREcxzDznFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fywcoCj5NU5Vy4jW+gy0ENIYxauSi9/NutZrukZEXF0=;
 b=Q8QK6If1qNlOfgeliKjLW4lvZXnTi+HeGFZmTZxWyCxpbtjImnmL6Pa6j4xXqeY3cK9NmXsUxtuAu+qKGmAijAuCsSSRojDUH5bgDv33cjcw3A4phLyxLIBPLHbYJdKxGapHGeNhNBsdMjBQbb/p/7dXOPidRgYoFA8ibjovfs9CmwZM63liSyqRVcD4GHGs/G/1FGMz4Xa279/1rjEyf9syeaCHGsbtjUnbC4l71kowY2OFmCan2pLrxugYcQcLi3nQwreQim5Iz2ZD8DWES+CkCnmN03xPuUnzC9OoMu4saO169/90iMDd7oQGp/848hrr82bxMpRPKqt76Lg18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fywcoCj5NU5Vy4jW+gy0ENIYxauSi9/NutZrukZEXF0=;
 b=BDcAHftSfjE0vN3kypXY9VWt4XXj/awll8A6TVbdbBYav64i6Qdn8iF8/YyxFuKybVs47NUw50Lff/h3D3SUJbkWCE7gssxkrmowDbmHz3JhAL4QLw9DoRwleW4SH7wtzxCKzG7zdVXWch9AAYuGcRJKoe5F0H030rYWuXFUPGU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5503.eurprd05.prod.outlook.com (20.177.200.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 00:35:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 00:35:41 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR12CA0018.namprd12.prod.outlook.com (2603:10b6:208:a8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 00:35:40 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iwEqv-0007G1-Od; Mon, 27 Jan 2020 20:35:37 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Topic: [PATCH for-next 4/7] RDMA/bnxt_re: Refactor net ring allocation
 function
Thread-Index: AQHV0nqOllcH33mzDEKpmcLxvFc1Iqf9BRIAgAEf+gCAARu2gA==
Date:   Tue, 28 Jan 2020 00:35:41 +0000
Message-ID: <20200128003537.GD21192@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-5-git-send-email-devesh.sharma@broadcom.com>
 <20200126142928.GG2993@unreal>
 <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
In-Reply-To: <CANjDDBhxVC0ps8ee5NTW3QrN9bFNVdEcwxS2=Kfn1uOfDR2v_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:208:a8::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 254e4ee7-357a-4fda-59b9-08d7a38a00bc
x-ms-traffictypediagnostic: VI1PR05MB5503:
x-microsoft-antispam-prvs: <VI1PR05MB5503BCB13B78FB03C6B8F8A7CF0A0@VI1PR05MB5503.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(64756008)(4326008)(66946007)(66556008)(66446008)(66476007)(5660300002)(2616005)(86362001)(81166006)(8676002)(9746002)(9786002)(81156014)(36756003)(4744005)(33656002)(1076003)(8936002)(6916009)(26005)(6666004)(71200400001)(186003)(478600001)(54906003)(52116002)(316002)(2906002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5503;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZ8nQaD8ErIZ0+blkUjzu//B6keDM5rwKtJUAZRJaL+SMdguKpwMgGv85UhbBra4AaWr19YzKjdPdgkvROWbHgkQugnv7QnaZpeYCu1Xfqk+LkrQ84QWhnMUY+M9jtBhA5//hk+gXuV6ijxZGrfW/+LdGoaYptfhKr9iq3LZD4G+Zm0S4t5QHTkvP+qIVLMe464qA16PXpLpEbZxUHe1t+tyYxpp2ul6xWIAh7lzV8nDbjwTK6B/kTVVWo9Fx9L9MqxDUa3Boph4ylknG5aicb/7UhXxV5oDpGnVgbWZCo0d8IOn6/FjYpwyqEs8NDCWHn+LRuTU/L27Kq1fW6thDp+DSrXkpxwljsgNzdBnVM3q67g8Ks0Y1PB6klpTT/LDFi3VYbwIA8zN3nztQgto45OtIa3owzvaALiwpGv1OLaqPukV800Jdtw8CU3m91Y0r2f4vgYN+fMEMeSJtLhF7XLP3WTSZSbEeGSmMhVHa9qH1yVs69T2jDt4/PgyvYUc
x-ms-exchange-antispam-messagedata: V41414l9j6enf0F9/DF99apZAxbb8kdH4jFIzwpKt8t2hPB/glkRYdNhmlRvr7t4eOp5hThhHymJoxNVAzAdXx+wwYPcTMJWwhCzc8nntURBiTm8Mmi1q49xAyA63r2IpgzpRQx6CrDRxokmq8B/cg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <677143799CC8634799B87199A7A929ED@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254e4ee7-357a-4fda-59b9-08d7a38a00bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 00:35:41.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSWMCliBZ/G+BZDh8B+FjT79Rq1a2CQyNTdfu7BwZQbCRBbojoNbk4Pgxkvlt3Y8TvatawHzHZYk1jQcibxxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5503
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 01:10:10PM +0530, Devesh Sharma wrote:
> > >  static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
> > >  {
> > > +     struct bnxt_qplib_ctx *qplib_ctx;
> > > +     struct bnxt_re_ring_attr rattr;
> > >       int num_vec_created =3D 0;
> > > -     dma_addr_t *pg_map;
> > >       int rc =3D 0, i;
> > > -     int pages;
> > >       u8 type;
> > >
> > > +     memset(&rattr, 0, sizeof(rattr));
> >
> > Initialize rattr to zero from the beginning and save call to memset.
> I moved from static initialization to memset due to some sparse/smatch
> warnings, rattr has a "pointer member".

That is why you need to use =3D {} not the weird '=3D {0}' version

0 initializes the first member to zero and default initializes the rest
which doesn't work properly if the first member is not an integral
value.

Jason
