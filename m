Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26804A185
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfFRNES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:04:18 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:40773
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfFRNES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 09:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2DRK8xVa8ANC5JDgcqTjbTM8RkBo4QKZ5YX24ni07M=;
 b=LfgTKbG1vB5SyRay8Io3TwYqwSB6Zm/rjx5RqRzxp4zNzXxqDfJmMZey9d2U3Ks1IGcj6REFAUopaB5wy8eHA4scseTZSD0lPeN01mzqjxstqN26ijrMWRdmyfe8Od325T0gdHzfaNZ9HSw1GhDbI4InynnigVqGnUuEXuUf+24=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3283.eurprd05.prod.outlook.com (10.170.125.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 13:04:14 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 13:04:14 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Topic: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Index: AQHVJdAFMtAvUj1NsEaredjo/1T89qahYFwAgAAAqIA=
Date:   Tue, 18 Jun 2019 13:04:14 +0000
Message-ID: <20190618130411.GM4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-4-jgg@ziepe.ca>
 <20190618121900.GL4690@mtr-leonro.mtl.com> <20190618130150.GB6961@ziepe.ca>
In-Reply-To: <20190618130150.GB6961@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0033.eurprd02.prod.outlook.com
 (2603:10a6:209:15::46) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7c30e3e-c1dc-4489-f803-08d6f3ed7688
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3283;
x-ms-traffictypediagnostic: AM4PR05MB3283:
x-microsoft-antispam-prvs: <AM4PR05MB328327A9CA8EB0FE829DD68AB0EA0@AM4PR05MB3283.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(14454004)(66946007)(66446008)(53936002)(66556008)(64756008)(66476007)(11346002)(6246003)(9686003)(4744005)(81156014)(8936002)(8676002)(71190400001)(26005)(1076003)(81166006)(386003)(102836004)(6506007)(71200400001)(6916009)(5660300002)(25786009)(86362001)(99286004)(4326008)(76176011)(2906002)(229853002)(68736007)(316002)(52116002)(73956011)(6116002)(3846002)(256004)(446003)(6512007)(186003)(7736002)(305945005)(66066001)(6486002)(33656002)(486006)(476003)(478600001)(6436002)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3283;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jYf/YV5J2bDlvucqMKGsrZIcNfkpSIs/G4+jE275SGL9XVTx43VZUNigcnI9kK0W1PtIJgx7ytpV8KIqP23ZsHNUXwpMa1xg8MFtV0YoW6cJUMgPca4arvQtY7gvnEqf53oTu6ZjuLBjjomEKEs1O6SrLfKiWIwnLyTLqt7dsygbw957pN7lP5AVA+KJKRCXL6KjGW4L/KMWyw1ura9rs1l9wp2B3VG4FmJnSZHne7Xs+wqPF5Fpxs2v/z5EQoM785tOfc9kdf+EDYw77Hsd+AYtYLYCp1kY5jYlx+Ng8+6m72PHnkBJQ+DqrF5oKLAKy7JwpPvC5L6KS47IqQjU6thj23ryJiiKcUAoo3Q/giHVTTO22hz/TzAAdoDaXFTFsjjCwDpHZHrf++QIe06Cbk0IC7sjMidxCGJmnzX6TYI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B55F07A4FA75AA4ABB5F4F131D822A28@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c30e3e-c1dc-4489-f803-08d6f3ed7688
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 13:04:14.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3283
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 10:01:50AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 12:19:04PM +0000, Leon Romanovsky wrote:
> > > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdm=
a_netlink.h
> > > index 9903db21a42c58..b27c02185dcc19 100644
> > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > @@ -504,6 +504,7 @@ enum rdma_nldev_attr {
> > >  	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > >  	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > >  	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> > > +	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */
> >
> > This should be inside nla_policy too.
>
> It is an output, not an input. policy only checks inputs.

We are putting in policy everything to ensure that it won't be forgotten
once output field will be used as an input.

Thanks

>
> Jason
