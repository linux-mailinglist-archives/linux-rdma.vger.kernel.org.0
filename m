Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C63A14C180
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1UP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 15:15:56 -0500
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:6034
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgA1UP4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Jan 2020 15:15:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzk6gVUOATiDLUJI4uNLqBvzTGRFp3zf3zkr56Os1ovpZjdDCbddT1gkMLmxvpoqVBm8quLcAONtwZIxjSbo7BgptWHe+dlKXYY/wGRD4PkybOtraW9VGEkf1sdDrwTkCZOcf7xcck8d7RPueTQr7E6e+7wtby6OvMJd0v7EfutJEU1Yw0PdH/M1fPJTb3RVkIcV6Hr59WFKOUiaUsITkHhS+JAj69KHVvHAblbwEYWIwFlFJby6FeA9GUgZgoEJqrIFLSHQrRxmlMlx7H478T1NdSzL6HObxwqGDdAOhpGeudOAkfExlOweVNGC9kGRFNHYHF0D1Dw/Vlw/qNF+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66HevOu6DaMDXmkTuvVmrGCPuycWnTp1VZYGmT47SUc=;
 b=GxGguxrpd4yp85KaYTIpBcP8AeeHE4Etvzy/MBtRBg5snrtjzmaTQWlfr+FitLa2528iwlbrGpvBnSrSOqZNqGObT12C4DobujecK9wFwLb4CAYvMfTKssgHP/T3p+umknm1q7LkFfOGvVo5yP/nnH56bHCcbK9zQ+igYX+o+lqA1vJMM4rCN4c/1ucFGYITE3t36r9VXwIEvcELPlzR4Rwon7wjsjxGp9PhNuNtFgCf9hVY6USnDQb8Io/x2Ekxr/fEFBR+g4dLXiVBC33EftowABPHKujehUo/J3SsW4fG2rCAfyDs8WiuUyr1ShdIlZH5qCmZ9H8jYbo0O/bT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66HevOu6DaMDXmkTuvVmrGCPuycWnTp1VZYGmT47SUc=;
 b=RzdWQmgFrgkALnTZMCTUuLg6AZt9dIc+mXYbPKjVeUKxoiEgiJMxPTxnqNpkFgqbBvrn5n++h+AygFIuP/78JPi7kmAPSvkJcFj2AOjFNzX+IVZSKURHYOLSv9vX0632ztRzrrV/g2npX+4yx+DGIZk2/fqc9Eyrg9f/aLzztTo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5200.eurprd05.prod.outlook.com (20.178.12.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 20:15:53 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 20:15:53 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:208:234::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 20:15:53 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iwXH3-0006Gz-0L; Tue, 28 Jan 2020 16:15:49 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context structure
 with pointer
Thread-Topic: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context
 structure with pointer
Thread-Index: AQHV0nqLx+VkrTQJYk+zGSveksMYG6f7rl0AgAJ2kgCAAmWRAA==
Date:   Tue, 28 Jan 2020 20:15:53 +0000
Message-ID: <20200128201548.GO21192@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
 <20200125180252.GD4616@mellanox.com>
 <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
In-Reply-To: <CANjDDBiSLY55v=cA+gMC6QFAqxUxiiFCy3y3_Rw9vF+v40LgDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:208:234::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca813a99-3031-42ba-a9c5-08d7a42ee005
x-ms-traffictypediagnostic: VI1PR05MB5200:
x-microsoft-antispam-prvs: <VI1PR05MB5200735A119730C484148CFDCF0A0@VI1PR05MB5200.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(4326008)(54906003)(5660300002)(2906002)(478600001)(33656002)(86362001)(8676002)(81166006)(52116002)(1076003)(2616005)(71200400001)(8936002)(9786002)(9746002)(81156014)(66556008)(53546011)(66946007)(6666004)(36756003)(186003)(64756008)(6916009)(66476007)(66446008)(316002)(26005)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5200;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+b85o3m/exexMP3qtZP/p+R9dN9oGDZBfXy5oiEuQahY8rWSQW6NcY9e5ZF0ldyOEbnUnuqtCWpE1CnQJQQLS3lNOLB1QINGUgBrYQiY+F/bKUafENt6RyLghuUuwXH13MAvRRH1yybGjXizfM4GTqNhVdGgMS9hfnRyI3wuLu/xbEkc63Y7xwrA62hZrWOe/8hz0yHWk9PGaf/8N5rIvIOoJizcv58i7mWGPYX5K5UeB0x5EwRMcj/yp8zpdNeJObatkLUHOfRCFjDpM+WMsgrppEIYY7tWY6tB50sug+B/B7Rghf/wIKr98dVN4l1r7swJamTrAc/MQjYJm8YeVTdLCx7XLH+B15SP7DNc6WvbYh7uiORgU5LHLLEIR79zQjpIv1NnJU4tO8aRdo4+eVAxKOpixP5v0FLHbPiRkkM3CjG/m5jyFsZ+VX7fAi4Sv5UMWaZRK6f2bSaQHhPjpAJ622pACBojKrlMvBJR/ksVFKPfEIw60SOcnRen7nK
x-ms-exchange-antispam-messagedata: Qs7C46g40hK6GHTwY8TFWBwxySRvzi+oBoEtLlz76bYwYFLP/8ND3V8LseaZssmYmMUDQbHcPK35jtmiAhpefgxOg/09cQglctiZA8pShTwTFbwECwH9RFi2LbLj48Eo/bYzqkUTJBfeANLth2j3EQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3164E0B89EEFDE4F909F17881C71BB49@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca813a99-3031-42ba-a9c5-08d7a42ee005
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 20:15:53.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7zCUi2tnjeVnSAkPPT8l7kanEn+EMY4YZO3+/dUHa0mS7Qym04R9+ADkdbxWsc/cK21tvTvyGCC+smb2Z7ttwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5200
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 27, 2020 at 01:09:46PM +0530, Devesh Sharma wrote:
> On Sat, Jan 25, 2020 at 11:33 PM Jason Gunthorpe <jgg@mellanox.com> wrote=
:
> >
> > On Fri, Jan 24, 2020 at 12:52:40AM -0500, Devesh Sharma wrote:
> > >  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> > >  {
> > > +     struct bnxt_qplib_chip_ctx *chip_ctx;
> > > +
> > > +     if (!rdev->chip_ctx)
> > > +             return;
> > > +     chip_ctx =3D rdev->chip_ctx;
> > > +     rdev->chip_ctx =3D NULL;
> > >       rdev->rcfw.res =3D NULL;
> > >       rdev->qplib_res.cctx =3D NULL;
> > > +     kfree(chip_ctx);
> > >  }
> >
> > Are you sure this kfree is late enough? I couldn't deduce if it was
> > really safe to NULL chip_ctx here.
> With the current design its okay to free this here because
> bnxt_re_destroy_chip_ctx is indeed the last deallocation performed
> before ib_device_dealloc() in any exit path. Further, the call to
> bnxt_re_destroy_chip_ctx is protected by rtnl.
> following is the exit sequence anyewere in the driver control path
> bnxt_re_ib_unreg(rdev); --->> the last deallocation in this func is
> destroy_chip_ctx().
> bnxt_re_remove_one(rdev); -->> this is a single line function just to
> put pci device reference
> bnxt_re_dev_unreg(rdev); -->> the first deallocation in this func is
> ib_device_dealloc().

It makes more sense to me to put all the memory deallocation together
in one place, then there is no concern about ordering.

We now have the dealloc_driver callback for this purpose.

It is not 'last deallocation' that matters, but what all the other
stuff is doing between destroy_chip_ctx() and ib_device_dealloc()

Jason
