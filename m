Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320AB48D0A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfFQSyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 14:54:52 -0400
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:53838
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfFQSyv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jun 2019 14:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM+GMBlzidzTiImccFWr7br0XTHYFohvbuXPyQKJSzo=;
 b=LqIC+MnpMM+mfsuoOafEBBAHjbFgAUgN6TahqkKCHDH2xq3bi7maL9AeVNTRC9iogOKWqIVHH+33tR2eVEyWRZ+4CtXU9rpfBnGoAyFniZ2efy9u3EV1SU9UJR658V2tsQZVZU6zSFz8pufzS+S1E0r+lkcLVoZ7NGIWx1+fAcU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5774.eurprd05.prod.outlook.com (20.178.122.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 18:54:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 18:54:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Topic: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Thread-Index: AQHVIkl6N2MWbUZhX0CLffNc+akUB6abgk4AgAS1XoA=
Date:   Mon, 17 Jun 2019 18:54:47 +0000
Message-ID: <20190617185443.GC25886@mellanox.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
In-Reply-To: <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2456a5c3-0572-4ab5-aa2d-08d6f3554513
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5774;
x-ms-traffictypediagnostic: VI1PR05MB5774:
x-microsoft-antispam-prvs: <VI1PR05MB5774D20F97368E29791C4A4ECFEB0@VI1PR05MB5774.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(2616005)(476003)(486006)(81156014)(81166006)(25786009)(14444005)(478600001)(8676002)(6916009)(256004)(8936002)(73956011)(66476007)(446003)(3846002)(6116002)(11346002)(4326008)(6512007)(66556008)(64756008)(66066001)(7736002)(1076003)(6246003)(305945005)(5660300002)(53936002)(229853002)(186003)(68736007)(102836004)(6436002)(99286004)(6486002)(14454004)(36756003)(6506007)(76176011)(66946007)(66446008)(86362001)(52116002)(71200400001)(386003)(316002)(2906002)(71190400001)(33656002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5774;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4UbJZUtwfU8HRhHbBUrSyELETX33otWVliNIH/WFERQHIwcGlbu9fxM51G8aPz9f04pYj6N6Pw5UcGunLjdzZmq2nPW5XWJHooWYz4XthKI4ltAMDh2JUYIfyx9sRtFa5tErs5/Ij1GavmPkqYowVdF77IrDOGvW5KTunioJZNFGX9lsxxv9d1CqBLf1qxjhI3djUSroz2iCvtRFoU61Iq7oVvXv7/gMYJtbzoHWOlpa6HIktaArnykxmLQ0XypFScDHmc6DbU7EA1TFjDdaFUXtCocu7fK1V13J3c+7oVjm8TriGNTE1r+Vbm/SG6jnUGxiUI71Qe01IOfPnPFYrSO6cIPCyKPLAxJupjc7Sj0bXeJtZVMsNQ/K+fzfKME8n9A+tEpldIFrSCWri7vAATb/gCE6QRUm8SDrgtFdaq4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3823C4D6F51824DA251FB944A54390E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2456a5c3-0572-4ab5-aa2d-08d6f3554513
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 18:54:47.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5774
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 03:00:32PM -0400, Doug Ledford wrote:
> On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> > +       if (ibdev)
> > +               ret =3D __ib_get_client_nl_info(ibdev, client_name,
> > res);
> > +       else
> > +               ret =3D __ib_get_global_client_nl_info(client_name,
> > res);
> > +#ifdef CONFIG_MODULES
> > +       if (ret =3D=3D -ENOENT) {
> > +               request_module("rdma-client-%s", client_name);
> > +               if (ibdev)
> > +                       ret =3D __ib_get_client_nl_info(ibdev,
> > client_name, res);
> > +               else
> > +                       ret =3D
> > __ib_get_global_client_nl_info(client_name, res);
> > +       }
> > +#endif
>=20
> I was trying to put my finger on something yesterday while reading the
> code, and this change makes it more clear for me.  Do we really want to
> limit the info type based on ibdev?  It seems to me that all global
> info retrieval should work whether you open a specific ibdev or
> not.=20

Each chardev name has a specified query protocol - global chardevs
must not specify a ibdev, and local ones must. Each name can only be
global or ibdev - no mixing. Too confusing.

It is uapi so we should be strict, if the ibdev is not allowed then it
should be checked to be absent in case we do something different
later.

> The other thing I was wondering about was the module loading.  Every
> attempt to load a module is a fork/exec cycle and a context switch over
> to modprobe and back, and we make no attempt here to keep each

It is a common pattern in the kernel, ie we did exactly this code to
load the ib netlink module in the netlink core.

If there is a problem then it should be addressed globally..

> indicate we've attempted to load that module, and on -ENOENT, we check
> the table for a match to our passed in client_name, and only if we have
> a match, and it's load count is 0, do we call request_module() and
> increment the load count.  Thoughts?

I assume it becomes single threaded and batched at some point, so it
is not so bad...

Jason
