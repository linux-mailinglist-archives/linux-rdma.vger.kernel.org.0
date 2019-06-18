Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C828549696
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 03:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfFRBLe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 21:11:34 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:3030
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbfFRBLe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 21:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31ZEhXpxpeWVlVV/O50QnR94RL1UL1AIOe6z2xF8uik=;
 b=Ta9ZpXi80HZAxenBpIjHpM77GrnrLoAKOAP1rMFdtynmThwc+6wmk/ui/z63Ft8ccdZGvhEUIoLUeP9y2XXM++mC+yC83tG3QJcMLl+CGSNSt3+IkA8dYl0xZo3SrtqYT9kkSpbEU9xEAg6hIbB4dy3HQvH6x6aDfK6t4adEbz0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4830.eurprd05.prod.outlook.com (20.177.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 01:11:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 01:11:30 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Topic: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Index: AQHVIkl6N2MWbUZhX0CLffNc+akUB6abgk4AgAS1XoCAAAkgAIAAYB8A
Date:   Tue, 18 Jun 2019 01:11:29 +0000
Message-ID: <20190618011124.GE30778@mellanox.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
 <20190617185443.GC25886@mellanox.com>
 <1c871dfaa2f5ddd9f07ab5f16e0a0e4f6c64917c.camel@redhat.com>
In-Reply-To: <1c871dfaa2f5ddd9f07ab5f16e0a0e4f6c64917c.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8792256-41ba-459e-0e29-08d6f389e472
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4830;
x-ms-traffictypediagnostic: VI1PR05MB4830:
x-microsoft-antispam-prvs: <VI1PR05MB4830435F5CB8BF0544FFFC64CFEA0@VI1PR05MB4830.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(386003)(26005)(76176011)(478600001)(36756003)(6486002)(73956011)(186003)(53936002)(86362001)(81156014)(8676002)(81166006)(476003)(2616005)(2906002)(6116002)(33656002)(8936002)(6246003)(3846002)(6916009)(25786009)(446003)(316002)(486006)(11346002)(4326008)(229853002)(7736002)(14444005)(256004)(99286004)(52116002)(68736007)(71190400001)(66066001)(71200400001)(6436002)(6512007)(5660300002)(64756008)(66446008)(66556008)(305945005)(14454004)(66476007)(1076003)(102836004)(66946007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4830;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rOEHk5OGjgXtcyG2ESdkin7X/XQ/k2eYvO+x0he4A0yBBvuBiOEJtSDTzDddb6+RM3PvrU+WyuTGBZ7AtCeYATQooBv1RjrPc1Z1vr6j/kFERnD40pV5NWhtFC3bBV7McLR1OHG7tlwm9JvtCyDyzGqBWpLH7cBcWnDXYqz9HrTHDvumSpEQ90Uxxg2ke6NqAdAUM7sx9vYf8l6zDR2TSK/wK+RzWB+/17GxGJrbrOMz9mxgpAtxgl7Vdh0xZazlNdSeWPPvB5USDOQ1+wX8bKV02x05Jt1X94tk6K8/KoAkPFIYqOWN3c5Xs932vYbZ+HzOzwFBcErEPEOvyyRU/MUqW8udluprPAeMcmERSxDKrpYquG9qol4GyMOJFLaybKul8IQ8x5aYJGMFAiS7aBUx8KTMnNjbcpIo5+Q0Pas=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BCEF49D9DFB1C4D9839307AFDA53934@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8792256-41ba-459e-0e29-08d6f389e472
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 01:11:30.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4830
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 17, 2019 at 03:27:22PM -0400, Doug Ledford wrote:
> On Mon, 2019-06-17 at 18:54 +0000, Jason Gunthorpe wrote:
> > On Fri, Jun 14, 2019 at 03:00:32PM -0400, Doug Ledford wrote:
> > > On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> > > > +       if (ibdev)
> > > > +               ret =3D __ib_get_client_nl_info(ibdev, client_name,
> > > > res);
> > > > +       else
> > > > +               ret =3D __ib_get_global_client_nl_info(client_name,
> > > > res);
> > > > +#ifdef CONFIG_MODULES
> > > > +       if (ret =3D=3D -ENOENT) {
> > > > +               request_module("rdma-client-%s", client_name);
> > > > +               if (ibdev)
> > > > +                       ret =3D __ib_get_client_nl_info(ibdev,
> > > > client_name, res);
> > > > +               else
> > > > +                       ret =3D
> > > > __ib_get_global_client_nl_info(client_name, res);
> > > > +       }
> > > > +#endif
> > >=20
> > > I was trying to put my finger on something yesterday while reading
> > > the
> > > code, and this change makes it more clear for me.  Do we really
> > > want to
> > > limit the info type based on ibdev?  It seems to me that all global
> > > info retrieval should work whether you open a specific ibdev or
> > > not.=20
> >=20
> > Each chardev name has a specified query protocol - global chardevs
> > must not specify a ibdev, and local ones must. Each name can only be
> > global or ibdev - no mixing. Too confusing.
>=20
> I can see where that's the uapi as envisioned, my point though is would
> it be better to allow opening of an ibdev, retrieval of device specific
> data, and also retrieval of the available global data?  It just
> prevents having to open two files to get information that isn't device
> specific.  But, it's not a big deal either.

This runs on netlink, there is no 'opening the ibdev' or a 2nd
file. It is just the ibdev interface index # at this point on the same
netlink socket.

Thanks,
Jason
