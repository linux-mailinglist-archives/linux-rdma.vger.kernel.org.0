Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427384A1D2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfFRNOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:14:40 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:32270
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfFRNOk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9BmupvuZFLBOPa47CMoakwE0gFWws2uS72CivgQ0WA=;
 b=fWqZt5zBagjLxVAythzUSFn0E04WMiax0Tto7IdgiFG43d0BMa0Tjrs8lgW03dhFztMOASb93OuyjGt5v80juyzdrJREiUHw1DWxtJMd1Ccr2YocQZI5g1Kgec81koa5pC/U1gbtmOFsNyDG80/82qJWVkOdC4EeCDDqGtofngE=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3428.eurprd05.prod.outlook.com (10.171.186.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Tue, 18 Jun 2019 13:14:37 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::bc5a:ba8b:1a69:91b6%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 13:14:37 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Topic: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Thread-Index: AQHVJdAFMtAvUj1NsEaredjo/1T89qahYFwAgAAAqICAAAGVgIAAAVOA
Date:   Tue, 18 Jun 2019 13:14:37 +0000
Message-ID: <20190618131434.GN4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-4-jgg@ziepe.ca>
 <20190618121900.GL4690@mtr-leonro.mtl.com> <20190618130150.GB6961@ziepe.ca>
 <20190618130411.GM4690@mtr-leonro.mtl.com> <20190618130951.GD6961@ziepe.ca>
In-Reply-To: <20190618130951.GD6961@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0075.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::16) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcdd56b0-f527-47b2-d090-08d6f3eee9d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3428;
x-ms-traffictypediagnostic: AM4PR05MB3428:
x-microsoft-antispam-prvs: <AM4PR05MB34282E136130376B4E52B09FB0EA0@AM4PR05MB3428.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(256004)(68736007)(486006)(476003)(2906002)(6512007)(102836004)(6506007)(76176011)(26005)(386003)(305945005)(5660300002)(86362001)(1076003)(52116002)(11346002)(9686003)(478600001)(14454004)(186003)(316002)(99286004)(6246003)(71190400001)(33656002)(6916009)(66066001)(53936002)(8936002)(446003)(7736002)(64756008)(81156014)(66476007)(229853002)(66556008)(6116002)(73956011)(3846002)(6436002)(6486002)(4326008)(8676002)(66446008)(81166006)(66946007)(71200400001)(25786009)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3428;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jh77qSoNbyuv9qXze/bJ4hyIdOX6LnAQtSpovBC7Lr8epErHEoDO4556eWcWOSr5luSR8o+S0UYkqSftQJw1dhrDOz6BuEkWwGuuOiUYgkvelD8FlW5owUNNu5W9fRBiluAiEzoIZG7Jh9Yh+DXcjDa/IK03L/Od+eVSWXZmCRJXehfbeCUiSq/nr3mlsjLNx33258pugUvBh6wGTQyK3NrVZpyigdajndjTa6UBHCc8XXuEUhq2zniOx8Qr+Oeuin4OKnIng/ogpuXzWcop4HX2JELpzhzyULSuPukr7RWiogwmp64adcbs10EONhGj4fLoC1HRrShl0HR4QRvRT5tRSzT59w5bF2s4iHG4tWFMVIJTdOwtXxiMLzme/LjD88qV1k+qxsfDMpMVfRXJbdMTUwcxyZPDeFf8swcHxoE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E74C9FFA3FE60047A4CB40CF0351777A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdd56b0-f527-47b2-d090-08d6f3eee9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 13:14:37.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3428
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 10:09:51AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 01:04:14PM +0000, Leon Romanovsky wrote:
> > On Tue, Jun 18, 2019 at 10:01:50AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 18, 2019 at 12:19:04PM +0000, Leon Romanovsky wrote:
> > > > > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma=
/rdma_netlink.h
> > > > > index 9903db21a42c58..b27c02185dcc19 100644
> > > > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > > > @@ -504,6 +504,7 @@ enum rdma_nldev_attr {
> > > > >  	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > > > >  	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > > > >  	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> > > > > +	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */
> > > >
> > > > This should be inside nla_policy too.
> > >
> > > It is an output, not an input. policy only checks inputs.
> >
> > We are putting in policy everything to ensure that it won't be forgotte=
n
> > once output field will be used as an input.
>
> Adding dead never tested code is more likely to just get it wrong..

What are you talking? It is addition of extra line in the table, which
will be enforced during first attempt to use it as an input.

Less chances to be broken after.

Thanks

>
> Jason
