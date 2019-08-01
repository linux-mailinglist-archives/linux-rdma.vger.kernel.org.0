Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E097E06B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfHAQnw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:43:52 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:10695
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729082AbfHAQnv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQtwvEmclso6o6ozLWM/rdnhNsXLao7p0IjMYYLhdQtslVc5bF0jbemNqviQqUhjbXWLJXqlLGw59wEH52foFl3izzbkQiBNgngysUGWfqiqGP1BqMH2PWwcFuUIe+xd5F3eX4gCufJFlC/XEmtUfN+4u0vH2kj7zke3IcS6JUPFA/3WSrncxBTmuBHBCfhxXVepI3p4AuKA3htxJymcVOAnvksXxs8XRUEziDhIvIvj/yrs/+NTkm7xmOKQaQgfGyOFo2HoAin+0PbEyTztJV0CUfdS4BzubIbZSEM1FXGFjN/2fO5yxqNjsC0YxjY2/doPhss5w2W89DFCci8B2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elPKzyyiTArcPchWkpE0/9AgozlSGylP1FpZVV9R1Bk=;
 b=DjoqREmI0jakUiVbLlam75xFj1pYvUGx2ev6CkNDoMSxMfTQu3mmVgCJWuk+W7Xjq5HcB6JKhMORVDWTMqoJyfLyk4CfImNCYep+1ioQNTxxXXCIuLGtMZEvf7u7cJgtEIe4g9BwHPXRODdz0NydsBctyWIiX81bTNSsnq+FpHnFAhGJm/KevO/MPirTn9dHbGDIGX+VRD3OYgqhR9nFmGN5fQ+AzrrjN2DlgfqDPgmblWOME4bc7HcnCz2dpBwDPh7qXT1NpkFu3fnyk8F0X3l5mRuNaRBKnRb1hZH8Cx1baljqD1RwPlK5wT8ri19B5OAujU6e4XWmpdahklwdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elPKzyyiTArcPchWkpE0/9AgozlSGylP1FpZVV9R1Bk=;
 b=kJxAAC5/EQ9KZJtHfDAFZQfu17eBJ9rVgce3+JXIx5YN05HUIxX0E0R31SeOo3tkvBfBmgjBcbWQ7Z0dCdCGOsTdSDJ3qE2AxG/zowjjwUyMPsguuM7w5bxaG9qgQEk4sA+lZnTVZOIEzi5kUuQrOrQdvTzz/B3qpBHTgB8woSc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5775.eurprd05.prod.outlook.com (20.178.122.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 16:43:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 16:43:34 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Thread-Index: AQHVR3tn3qv1PGIyNEiC/uXBUZXM9qbk6WYAgAAKq4CAAAJ3AIAAA3+AgAAK8ACAAB/ZgIAA0jqAgAA7UYCAAAJNgIAAI8aAgAAcugCAAANkAIAAAnUAgAAFwICAAADHAA==
Date:   Thu, 1 Aug 2019 16:43:34 +0000
Message-ID: <20190801164330.GH23885@mellanox.com>
References: <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
 <20190801082749.GH4832@mtr-leonro.mtl.com>
 <20190801120007.GB23885@mellanox.com>
 <20190801120821.GK4832@mtr-leonro.mtl.com>
 <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
 <20190801155912.GS4832@mtr-leonro.mtl.com>
 <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
 <20190801162008.GF23885@mellanox.com>
 <b74a9eb67af54e8f5050e97a3ab13899de17fe0a.camel@redhat.com>
In-Reply-To: <b74a9eb67af54e8f5050e97a3ab13899de17fe0a.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d97af16-8ef9-4e4a-62f9-08d7169f64f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5775;
x-ms-traffictypediagnostic: VI1PR05MB5775:
x-microsoft-antispam-prvs: <VI1PR05MB57754A5936343D51C6BFCE7BCFDE0@VI1PR05MB5775.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2906002)(2616005)(486006)(11346002)(476003)(446003)(36756003)(386003)(6506007)(76176011)(66066001)(26005)(316002)(8936002)(107886003)(81156014)(81166006)(102836004)(186003)(33656002)(71190400001)(478600001)(3846002)(54906003)(8676002)(6116002)(6916009)(68736007)(25786009)(4326008)(256004)(14444005)(4744005)(71200400001)(5660300002)(6246003)(1076003)(229853002)(6436002)(6486002)(53936002)(66946007)(99286004)(14454004)(305945005)(6512007)(7736002)(64756008)(66446008)(52116002)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5775;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2k/Rm6ibh7HLx/0gsYzFMgzeVxZOtUHTsURVxpPQZi7i50k5Bt3fJtFT8Gt8ysdbtOiBEM29QEElVa0tdTb7AegN8k+wjg3e9u1vqM4y29MMkHgGi7Py/mJbOxco7wauteXu3I/dBin2k091lN74sMz6Ti0CWcp9iV06PjZYGQeCNHYgAyPacl/JK29JeVv4it2q60fUUmdub6RLULyhPcNCmGI3NHwuVKDG8QTrZA6SxOgeczXw6keAhAJOxd0rRv29BdpRJK+1s8zta5D5dvPFy76u2y05deJpboMrvUas84rCVesuyDg8Kno85RgT95BSocQN3YhXK6rnNITv1dbLYhpExt5Y2UwW4UoHdN8Talqg7cuON8bZ+mk0GThNdrC8qecjqMKQnvPfOWPUGnrfOeBKj2FVuiRQo0b7lqs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CE0A06923AC064D84D2D3439FB3829B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97af16-8ef9-4e4a-62f9-08d7169f64f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:43:34.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5775
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 12:40:43PM -0400, Doug Ledford wrote:

> > It does have a lock though, the caller holds it, hence the request for
> > the lockdep.
>=20
> You're right, although I think the lockdep annotation can be a separate
> patch as it's neeeded on more than just the function this patch touches.

Why? This relies on that lock, so it should have the
lockdep_assert_held assert.

If there are more functions with implicit locking theyt they can be
fixed separately...

Jason

