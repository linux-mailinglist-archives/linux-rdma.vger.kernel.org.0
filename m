Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8745013653E
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 03:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgAJCRK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 21:17:10 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:38911
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730668AbgAJCRK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Jan 2020 21:17:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlSB9gw+LzMU7Z+ec1B31MrhbVgIBApLx1xgWxiV1J4AM7A0tyRGlu6NhpmTxMzNbg0mm19y9iO5tF6hH12lMvXLz3wP0svoRdyJlIGixlQ2GxH70vKlyxn/051SnE0oxjEL7eNk+psyN6BSGXNlWNZejNCsDSmzyhrQXy88rWU/EMXayTiwsi4vvkRRMU+mBTGPVtXgXCDwC143tufiK41z6jjUBuqF/WuxDtZHNfQSDlW+7rSr7HQmUc0zRGgxv7ECx4H7q3W6ggt43FF9PZr/gCGTUkeaVG1VUWC+J5dupsEn176vhuU7NC/El3jRmdls1WTuCjY4BVos5Jlt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr16rIJTCC1eefDNek4Lk468Le3w0iFIOgf5ynpTcwQ=;
 b=dKILr5/Qm6EGc4xorPr4I/ZHzpdi2Vf9cShnJYQ69lg5y4Fk7dQ+9ZCHMb/GZDtwYPpzC9Xykdfh2VxfUtQilQHZxgcSvgOhvRyGEOUbo157BSS29f2kZx/Y5uF28NiAPgAYlZt6iwIyAj7eL8mnCuaLIteqbe51UtmOqkyA64n30sxrmm67S4S1u3LMmR/lWKsrmFcTVvWLPSK+TDam/WCltK8WTxd0DXxMGULgr4AaC5ao/MqAGDTkLNMtN1sa8witwF2+AAJWWjnKtQ8HkPXu6kNU8uiJPtSk9qx5UNaVjLUfjYPUToq1iwgAS/X8cVW9zLiVBTrZZU6fsDRaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr16rIJTCC1eefDNek4Lk468Le3w0iFIOgf5ynpTcwQ=;
 b=CsncPSl2rdnxLM3ml/+C/v7w1pblq6FZ5vJLmWHnlnZXrcEfJ99RLAivj73mmRJwVT9CgnpFkWTr8psBsp46qhxFDU1cKyMPWQtBl1swF4BJUGoTDeyNnIeVH5nV3lzcrO7JhtWzvH1lj6e61F3f0kqCvJa6hbF+o5BAwP1xQOI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3437.eurprd05.prod.outlook.com (10.170.239.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 10 Jan 2020 02:16:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 02:16:27 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 02:16:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ipjqZ-0001bH-Fo; Thu, 09 Jan 2020 22:16:23 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVx1v2bZiuTuTbz0W/q1nZ7yjcuQ==
Date:   Fri, 10 Jan 2020 02:16:26 +0000
Message-ID: <20200110021623.GA6057@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f77d8665-46de-4b21-2084-08d7957318d5
x-ms-traffictypediagnostic: VI1PR05MB3437:
x-microsoft-antispam-prvs: <VI1PR05MB34378AEADEA3ED8E50D08C11CF380@VI1PR05MB3437.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:211;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(9746002)(66556008)(110136005)(64756008)(54906003)(33656002)(5660300002)(66476007)(36756003)(66946007)(52116002)(186003)(1076003)(86362001)(2906002)(316002)(4001150100001)(81166006)(81156014)(66446008)(26005)(71200400001)(66616009)(9786002)(8936002)(8676002)(9686003)(4326008)(478600001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3437;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vkn/0KwN4RsL+X2AXDeibdIBLIQUAuE7vCQbXY6w0GmWSDbTjv3zyMhGgVv0weBv2q97hd/q8VPz4Qwty8PICX3CbyUG31/Kyf+ZKO7+tss6SFTFL6GjOK4p8piqttfZksNcMuSpn3yLDPR9few0IbPJDB+hvyqhjV7buifN7QaHz0XgZmDY/MmulMkQ5LXdX34snKsPbQgqcqTaJUKYU9udSEOj0Eb8Tq5R7N0GYfMG6dHRrf3Gsk9TXYMJTOgVL+Xl7Bl73+14BTj+BNKllmQvatpa/FKxMiI56MY3vvq6yNu7lp9+7jAdDZ9Or5qSgKJgvSVF2dxR3uPwlrPmVEt508xD+xebKv/FW/k3hS3Su9vmV3yGB+ZnM21e6p1fn/eAaSoM0bvbKf4GeXk7XfefnDZKadNWru3BmRDtEd07KQZXwq9v9yTHiov//KTLnViMGTVDmgtHuVRgKE+zoQhygaTcjWs7yvsXZm4voJuP7+BepeEdRZoC98BvHjPM
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77d8665-46de-4b21-2084-08d7957318d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 02:16:26.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGFyel1oehy7HexD/v7bTUteHdY62/hBAWOQ+doC2XZylsOxFJ8BRJ3sQt3vQ5HQ8yw1hcFgu02vZPBp23hvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3437
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

First rc pull request

A very small set of fixes, most people seem to still be recovering
=66rom December!

Thanks,
Jason

The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 9554de394b7eee01606e64c3806cd43893f3037e:

  i40iw: Remove setting of VMA private data and use rdma_user_mmap_io (2020=
-01-07 15:07:37 -0400)

----------------------------------------------------------------
First RDMA subsystem updates for 5.5-rc

Five small driver fixes:

- Fix error flow with MR allocation in bnxt_re

- An errata work around for bnxt_re

- Misuse of the workqueue API in hfi1

- Protocol error in hfi1

- Regression in 5.5 related to the mmap rework with i40iw

----------------------------------------------------------------
Kaike Wan (2):
      IB/hfi1: Don't cancel unused work item
      IB/hfi1: Adjust flow PSN with the correct resync_psn

Selvin Xavier (2):
      RDMA/bnxt_re: Avoid freeing MR resources if dereg fails
      RDMA/bnxt_re: Fix Send Work Entry state check while polling completio=
ns

Shiraz Saleem (1):
      i40iw: Remove setting of VMA private data and use rdma_user_mmap_io

 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++------
 drivers/infiniband/hw/hfi1/iowait.c       |  4 +++-
 drivers/infiniband/hw/hfi1/tid_rdma.c     |  9 +++++++++
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 14 ++++++--------
 5 files changed, 27 insertions(+), 16 deletions(-)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl4X3nUACgkQOG33FX4g
mxptxw/9FYWDEChxYBddnesiRpJANSciNFu50rVHChLrAvkhUp/ThuZcj2p8eZGr
kin6y6ntQuNw7r161KCuIVVqGcUezJXALJTg5/LM78RbNIhGPPA3OiY2+0Bh4BRH
pLhIhjs6G9giMjYuqkxL1y+FcjgTfJ4fjaHK3F2m3RI+DREe7EsjxgRCpMNHZyQH
8bSbPhnG7XLN2TKoxcZZfrXZOyzryTUUxr3TO/xPsd8g1NONO4grTYL2J0dgLQop
zVgrIfw/hw7f/o8eYfQUzWHgfP4T7SE5gOVOTgXT4D5lEKCchgMYAxc0yVlCtMxU
cDlEqd552i/EaFlM8DvRr3z7y1KQ2OzKh8YO8y9j7SIVt7HOIX66yzlI2XKEe+vx
8QyJpjZh1AN/qc63iw3oPprR9qjfnwuXCe2k2eOD5CRfs73BWuBuzlKybvN1qETj
lZ4jjZe0fBi+xlUM8CWHguYYOi3fbRG1NSymVl+y4nGSCuTBgUscZy/lFldYi1z4
m+eWBH8aL4KygVjclPoLsvNc3hPoOx5h9qd6MzsL05bdyBJZmrxdYZL5Ubio+Ky/
Ga1YdDOJ2XSIGMea6G2HknZ+3IaxJ78ktFXi4qp3oA7eSa1cyyexXXEsimOGi2Mm
cpSbL/foqf4YeTzTWnySMs1TQkteomTSVg493q/5Ydvx0Ln7kQg=
=FsV4
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
