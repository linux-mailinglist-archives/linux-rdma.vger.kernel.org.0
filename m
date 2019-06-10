Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97A3B7B0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389811AbfFJOpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 10:45:45 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:40964
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388373AbfFJOpp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 10:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mKVAuLwrvur9jXWo+VL68AyBI0rnTwcw5LSa3vazXY=;
 b=czBNG7tsnp0ErP/ISaWB/k9vFJxQ7O0Tq/VZpTvtogWbp5Urjygp8HNUB3ScAXS2+yvm7IlEJLr+VdJIQyDVMK2xigjCH1WLpyvHi3icToSvbanVw2onG35H5ZJ//FWHlEehFLe7Wp2/jLR73ZR64afAUCYcNosk6RLgAgIcoCI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3181.eurprd05.prod.outlook.com (10.170.237.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Mon, 10 Jun 2019 14:45:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 14:45:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Thread-Topic: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Thread-Index: AQHVG80bEnjAGA3hg0GJbZcYacaaJqaU9cYAgAAI8oA=
Date:   Mon, 10 Jun 2019 14:45:40 +0000
Message-ID: <20190610144535.GD18446@mellanox.com>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-2-jgg@ziepe.ca>
 <20190610141334.GB6369@mtr-leonro.mtl.com>
In-Reply-To: <20190610141334.GB6369@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0010.prod.exchangelabs.com (2603:10b6:208:71::23)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98b58b79-9e2c-41ed-b68b-08d6edb24ebb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3181;
x-ms-traffictypediagnostic: VI1PR05MB3181:
x-microsoft-antispam-prvs: <VI1PR05MB3181A59112132E7696D165B0CF130@VI1PR05MB3181.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(189003)(199004)(446003)(4326008)(476003)(81156014)(2616005)(229853002)(6436002)(81166006)(5660300002)(33656002)(6486002)(1076003)(6512007)(6246003)(71200400001)(71190400001)(11346002)(8676002)(66446008)(66556008)(8936002)(25786009)(66066001)(68736007)(102836004)(186003)(478600001)(64756008)(6506007)(386003)(2906002)(3846002)(256004)(316002)(6116002)(6916009)(305945005)(7736002)(36756003)(53936002)(14454004)(486006)(86362001)(66476007)(76176011)(66946007)(26005)(99286004)(73956011)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3181;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zyCKvP4jLMnHs7maBuh70Cmi2gKAls1T+C3pj+KcLFz0uWK5/PmMoqFoNDatOUYyYaaOnllTiy4K8phWz7izguYoVf3N6kRRXh9/hHT9lHQgDS10KDHsqeptAw7lojUNKPOMgXGw1+IwKak9gLWkojVOpFW6uzF0VVkO17Xw0B5gGsjAFq+M+l5BCGw89rKWE7glt3Mvt8AoFNuX1uTLD0BJaioRIoNqkSWMmlWc09QL+52rayefodGR2ph+c61DKmP0CMlKkfpdAcKr3Mb6gPENDYdGRBpTG0OxyXFs8f3XD+JvYmCcDyAi4QgbISWjm/esk8CMmFTqfanvr4TiSmE7fBS2Rd8UtKTR8E1rvwZH8WwgmIJI6yRhMCSPIJPGrW5rm3HA4308gt+9EzdmS3s139/RXrsW5RYXTDIz3c8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A83169ADAFCEE4B832DFBB051B85FAF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b58b79-9e2c-41ed-b68b-08d6edb24ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 14:45:40.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3181
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 05:13:34PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 05, 2019 at 03:32:50PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > This enum is exposed over the sysfs file 'node_type' and over netlink v=
ia
> > RDMA_NLDEV_ATTR_DEV_NODE_TYPE, so declare it in the uapi headers.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> >  drivers/infiniband/core/verbs.c  |  2 +-
> >  include/rdma/ib_verbs.h          | 13 +------------
> >  include/uapi/rdma/rdma_netlink.h | 12 ++++++++++++
> >  3 files changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/=
verbs.c
> > index e666a1f7608d86..56af18456ba776 100644
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -209,7 +209,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rat=
e rate)
> >  EXPORT_SYMBOL(ib_rate_to_mbps);
> >
> >  __attribute_const__ enum rdma_transport_type
> > -rdma_node_get_transport(enum rdma_node_type node_type)
> > +rdma_node_get_transport(unsigned int node_type)
> >  {
> >
> >  	if (node_type =3D=3D RDMA_NODE_USNIC)
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index cdfeeda1db7f31..d5dd3cb7fcf702 100644
> > +++ b/include/rdma/ib_verbs.h
> > @@ -132,17 +132,6 @@ struct ib_gid_attr {
> >  	u8			port_num;
> >  };
> >
> > -enum rdma_node_type {
>=20
> Why did you drop "enum rdma_node_type" and changed to be anonymous enum?

To avoid namespace pollution in a user header

Jason
