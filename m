Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5586270B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfGHR0a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 13:26:30 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:10446
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfGHR0a (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 13:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRC+K9Bk2bN7q6nV4YE/5XwddsIKYQSxQk1oUtgN9kY=;
 b=W8oAZv5WAtQSJ1o/twa6y5yagF3s56yP/pndH+7C8V5QR6ftUCYQYxZXHBQxI+cVS6+TYhZOFncLzEWcE4E9+R6Iawwod8nGVuZuOKr2hU3OihOlOo0HjJWf/l2mIXtKxwcLqG2RQcmcYWf+fahKdGUPZPNQmbiqaHnfYVApk84=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4560.eurprd05.prod.outlook.com (20.176.3.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 17:26:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 17:26:26 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Thread-Topic: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Thread-Index: AQHVM03PMkTOZfAu1E673erRlNxWJ6a8RACAgAGHAYCAAzLpAA==
Date:   Mon, 8 Jul 2019 17:26:25 +0000
Message-ID: <20190708172622.GK23966@mellanox.com>
References: <20190705162157.17336-1-leon@kernel.org>
 <20190705171555.GH31525@mellanox.com>
 <20190706163523.GA18182@mtr-leonro.mtl.com>
In-Reply-To: <20190706163523.GA18182@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d68c6835-a76a-4c52-d7f0-08d703c967a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4560;
x-ms-traffictypediagnostic: VI1PR05MB4560:
x-microsoft-antispam-prvs: <VI1PR05MB4560C1C7F42F53DF79120348CFF60@VI1PR05MB4560.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(52116002)(6512007)(6486002)(86362001)(186003)(305945005)(478600001)(102836004)(68736007)(8936002)(76176011)(26005)(6506007)(256004)(386003)(53936002)(316002)(6246003)(8676002)(99286004)(7736002)(4744005)(5660300002)(6436002)(2906002)(81156014)(25786009)(4326008)(476003)(107886003)(33656002)(36756003)(6916009)(73956011)(66946007)(66066001)(229853002)(66476007)(3846002)(6116002)(2616005)(1076003)(446003)(11346002)(66556008)(14454004)(81166006)(54906003)(64756008)(486006)(71190400001)(71200400001)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4560;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j5BUmlToA0F5D03eqLxvHpfz9ryKOTFDWww4PbQ+Fy1cYdoXzWji9QZiuHM+nXnyPBF+aI2zcrO6/7vHq3ERfJiX1PeestDjSWvv29B7jr03S2jy2dWyOVUt2zTAIHsSLZfTp8a8f9PH7fYd/1hECYwpOrQHEYdXg9iSFxFspbfzrVTyHJaDMwvJWiSkGEcPFQwQ55lnLVpgEdTp7CLKw6Spyun3bHpu37SAkJ284wtcAFZIIZYs45U+93R1jLjgRkRU/Xv0ZrlAOjNWrdojamNO8cZrJG0qTzU74Pdsp0NdLKHPwLT4BK8xZDsj6gwFeiM+Iru2x2F7uWq3urb6TdN7k498naJL5Wg3nM0ITugvTZ9GKHIBH8rwOSoYbCfxPnUA3508WTO1lF0zSRbnaW/N2RZVydeyL/nhltxhgok=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <222E646B4B28FA4CBD753A499A6EE5F5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68c6835-a76a-4c52-d7f0-08d703c967a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 17:26:25.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4560
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 06, 2019 at 07:35:23PM +0300, Leon Romanovsky wrote:
> > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > index 30eb68f36109..c5f8a9f17063 100644
> > > +++ b/include/rdma/ib_verbs.h
> > > @@ -308,8 +308,8 @@ struct ib_rss_caps {
> > >  };
> > >
> > >  enum ib_tm_cap_flags {
> > > -	/*  Support tag matching on RC transport */
> > > -	IB_TM_CAP_RC		    =3D 1 << 0,
> > > +	/*  Support tag matching with rendezvous offload for RC transport *=
/
> > > +	IB_TM_CAP_RNDV_RC =3D 1 << 0,
> > >  };
> >
> > This is in the wrong header, right?
>=20
> It predates our all-to-uapi headers approach and moving to UAPI this stru=
ct
> is definitely too much for a fix which should go to stable@.

Well, lets send a patch to fix it please

Jason
