Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888E414BB8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfEFOXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 10:23:22 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:31566
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEFOXW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 10:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJVk0kEM0fkEvqrxhINTSdDUoQTva3YLt1VhzkrSsNE=;
 b=kovJva3Pnkcvxu6KkwlIjKj8RsZc35l1N09S0QD1TLXOeZcsWBo7cpuZ0oXQeLwY4VMNZu1r0iknUvbrjkzLGZUxrjIl/l0vHEo4Ar/lcu/kLHK8ElgRhHTfxMEsd5ulK7aA5lDBs6qJfYryG/sn7xb0plOy0GQiQGywBJfh+00=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4222.eurprd05.prod.outlook.com (52.133.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 14:23:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 14:23:17 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
Thread-Topic: [PATCH rdma-next] RDMA/ipoib: Allow user space differentiate
 between valid dev_port
Thread-Index: AQHVA/Vxm8gbxhcUoUWVmDoqNjBGEKZd5tOAgAAEHwCAADEYAIAABbwAgAAEwAA=
Date:   Mon, 6 May 2019 14:23:17 +0000
Message-ID: <20190506142306.GE6186@mellanox.com>
References: <20190506102107.14817-1-leon@kernel.org>
 <4c4c560a-d3ec-4b32-203f-178bddde478d@amazon.com>
 <20190506104952.GL6938@mtr-leonro.mtl.com>
 <3410a5ca-ab69-8c35-9754-356500d1b9c9@amazon.com>
 <20190506140606.GM6938@mtr-leonro.mtl.com>
In-Reply-To: <20190506140606.GM6938@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88209a10-f7c0-4c40-3e8f-08d6d22e6212
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4222;
x-ms-traffictypediagnostic: VI1PR05MB4222:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB42221EC5BDF98D50E67937B7CF300@VI1PR05MB4222.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(71200400001)(6306002)(305945005)(66476007)(6486002)(73956011)(66946007)(33656002)(66556008)(229853002)(316002)(64756008)(7736002)(66446008)(6436002)(99286004)(2906002)(186003)(6246003)(26005)(1076003)(66066001)(102836004)(4326008)(52116002)(54906003)(386003)(6506007)(53546011)(76176011)(8936002)(36756003)(71190400001)(68736007)(81166006)(81156014)(8676002)(6512007)(86362001)(53936002)(5660300002)(3846002)(486006)(14444005)(446003)(6116002)(256004)(11346002)(966005)(2616005)(478600001)(476003)(25786009)(14454004)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4222;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BQM8peI7HTsxrql4qlj4NGXhTdd4AWPBcorwnOZ+kvnGqSooBLprppN64aQz5kM5MwvzDCbtDZ3iuu/NalNE/mTW0uUiwJz4a/y6v0YIQb3igLFtDd3tg/il3o1uA/z/+V3Wdi+S/SjFfzCpC2iW83xXfzhBJKFd0m9d4M0Qak/Q9oz8NW68NC0VdpX+Z0QWOoUQW4It5LYOIsRcnV/S0Oxq3xn3Q1jSzaTkPj/lbBgU7S6yOW5zTxP/lXApqiXG3r4GtqeXp8YT6d+K2BTHK5DzkgmP7FUTnMGicfgykrHjbrp1PBOjY6gh48kW7UUS3R/auDee08YNDTQ23z/sktoFHbob4gRl50WH9M+pYnKPwyrb2XV+Q8Slx6C8dkLaFMA1F93CgTmMECu7A1RPlBYLVavQxaJc/QfaBf3hEYQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9915C20095CFC441BDBC1E47C017B642@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88209a10-f7c0-4c40-3e8f-08d6d22e6212
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 14:23:17.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 05:06:06PM +0300, Leon Romanovsky wrote:
> On Mon, May 06, 2019 at 04:45:34PM +0300, Gal Pressman wrote:
> > On 06-May-19 13:49, Leon Romanovsky wrote:
> > > On Mon, May 06, 2019 at 01:35:07PM +0300, Gal Pressman wrote:
> > >> On 06-May-19 13:21, Leon Romanovsky wrote:
> > >>> From: Leon Romanovsky <leonro@mellanox.com>
> > >>>
> > >>> Systemd triggers the following warning during IPoIB device load:
> > >>>
> > >>>  mlx5_core 0000:00:0c.0 ib0: "systemd-udevd" wants to know my dev_i=
d.
> > >>>         Should it look at dev_port instead?
> > >>>         See Documentation/ABI/testing/sysfs-class-net for more info=
.
> > >>>
> > >>> This is caused due to user space attempt to differentiate old syste=
ms
> > >>> without dev_port and new systems with dev_port. In case dev_port wi=
ll
> > >>> be zero, the systemd will try to read dev_id instead.
> > >>>
> > >>> There is no need to print a warning in such case, because it is val=
id
> > >>> situation and it is needed to ensure systemd compatibility with old
> > >>> kernels.
> > >>>
> > >>> Link: https://github.com/systemd/systemd/blob/master/src/udev/udev-=
builtin-net_id.c#L358
> > >>> Cc: <stable@vger.kernel.org> # 4.19
> > >>> Fixes: f6350da41dc7 ("IB/ipoib: Log sysfs 'dev_id' accesses from us=
erspace")
> > >>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >>>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 12 +++++++++++-
> > >>>  1 file changed, 11 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/in=
finiband/ulp/ipoib/ipoib_main.c
> > >>> index 48eda16db1a7..34e6495aa8c5 100644
> > >>> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> > >>> @@ -2402,7 +2402,17 @@ static ssize_t dev_id_show(struct device *de=
v,
> > >>>  {
> > >>>  	struct net_device *ndev =3D to_net_dev(dev);
> > >>>
> > >>> -	if (ndev->dev_id =3D=3D ndev->dev_port)
> > >>> +	/*
> > >>> +	 * ndev->dev_port will be equal to 0 in old kernel prior to commi=
t
> > >>> +	 * 9b8b2a323008 ("IB/ipoib: Use dev_port to expose network interf=
ace port numbers")
> > >>> +	 * Zero was chosen as special case for user space applications to=
 fallback
> > >>> +	 * and query dev_id to check if it has different value or not.
> > >>> +	 *
> > >>> +	 * Don't pring warning in such scenario.
> > >>
> > >> "pring" -> "print".
> > >
> > > Are you ok with other changes and I can add your ROB tag?
> >
> > To my understanding, the test should be for just:
> > if (ndev->dev_port)
> >
> > As if dev_port is set then there's no reason to use dev_id, regardless =
of its value.
> > But I'm not really familiar with this flow..
>=20
> It makes sense, but I'm not certain either.

The dev_id =3D=3D dev_port thing makes no sense to me since the driver
always sets them equal on startup - is there some way for these values
to change outside the driver's control?

Jason
