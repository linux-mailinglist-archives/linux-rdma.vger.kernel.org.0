Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B001E660
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEOArC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:47:02 -0400
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:14464
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfEOArC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 May 2019 20:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KmoUhlgxQ//AIr6HMkjLMvpDIlChpZngSkB0f87Xh8=;
 b=Qz4Qh3IfI/wOJDgFHeG/mJPYWfVbWd66xUNOe1ylEijkByoM2OGtdrVhiRTS/OfgATF9NJ/wQGTzMbtUXG+IpmdVxu27LIjSYFXaQvcYKFEy1oxtFbUmFfAfko9ob9N5NjYbZCK4d9mVVibhsErThcSM4Rl6W/ptCsc7dnElY3I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5760.eurprd05.prod.outlook.com (20.178.122.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 00:46:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 00:46:58 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVCrezaWb+XpDsLE6G1142j/hRCg==
Date:   Wed, 15 May 2019 00:46:58 +0000
Message-ID: <20190515004652.GA17171@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ab173d9-079d-4703-4fc2-08d6d8ced5b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:VI1PR05MB5760;
x-ms-traffictypediagnostic: VI1PR05MB5760:
x-microsoft-antispam-prvs: <VI1PR05MB57607E5ABA14A6185E23268DCF090@VI1PR05MB5760.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(478600001)(305945005)(33656002)(66066001)(7736002)(71190400001)(71200400001)(2906002)(14454004)(6116002)(3846002)(52116002)(86362001)(6486002)(316002)(110136005)(102836004)(6506007)(26005)(25786009)(476003)(53936002)(386003)(6512007)(9686003)(4326008)(186003)(1076003)(81156014)(14444005)(256004)(81166006)(8676002)(66556008)(54906003)(68736007)(6436002)(5660300002)(73956011)(66946007)(36756003)(8936002)(99936001)(486006)(66616009)(99286004)(64756008)(66446008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5760;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8rqojCJAT+AbXVUyOOw7xJk5lg+CbQJyjYugSOtfXIrAW6Md0Rn5amxN20F4KBqv2aGORHvxF+oTpFuJejekXe7Y7+HIykSseqVTnpSAqSc6lzBNMtYw/3Ha8O2v1gPqufvp3J15LshDthpt2GPKQfQ4S5iOWbTkURpXWHhLGIYbGhUoBfEskfcqhqBLEgRhI7GOp7SuSWOP+cmemqTTgTMY3pwc290n6R0NLyB/OSH61rAyn3EHhx0DvhRUeAdhfYppRoOp7nRZJGoFyrxy7856aXsIgosiTui1vbX+HdL3nr3yZKUENj9VPLozaESx7My0BNUYq/ATVelGEt3KSlyze8eIyD+90s7EKsPCTIGOb9MMfxFAtktGTPGDgHqaSvLf3/dSGnqPtdAzkWUIpVHAdy5sF1UkSZS36S0R+TM=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab173d9-079d-4703-4fc2-08d6d8ced5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 00:46:58.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5760
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the 2nd proposed RDMA patches for 5.2.

As requested the main reason to send this is to fix the gcc 9.1
warnings that many people may hit now that FC30 is out.

Thanks,
Jason

The following changes since commit b79656ed44c6865e17bcd93472ec39488bcc4984:

  RDMA/ipoib: Allow user space differentiate between valid dev_port (2019-05-07 16:13:23 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to c191f93454bcc92810b9c8cdb895a452a57948c2:

  net/mlx5: Set completion EQs as shared resources (2019-05-14 10:22:09 -0300)

----------------------------------------------------------------
5.2 Merge Window second pull request

This is being sent to get a fix for the gcc 9.1 build warnings, and I've
also pulled in some bug fix patches that were posted in the last two
weeks.

- Avoid the gcc 9.1 warning about overflowing a union member

- Fix the wrong callback type for a single response netlink to doit

- Bug fixes from more usage of the mlx5 devx interface

----------------------------------------------------------------
Jason Gunthorpe (1):
      RDMA: Directly cast the sockaddr union to sockaddr

Parav Pandit (1):
      RDMA/core: Change system parameters callback from dumpit to doit

Yishai Hadas (2):
      IB/mlx5: Verify DEVX general object type correctly
      net/mlx5: Set completion EQs as shared resources

 drivers/infiniband/core/addr.c               | 16 ++++++++--------
 drivers/infiniband/core/nldev.c              | 27 +++++++++++++++------------
 drivers/infiniband/hw/mlx5/devx.c            | 13 ++++++++++---
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c     |  5 ++---
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c     |  5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c |  3 +++
 include/linux/mlx5/mlx5_ifc.h                |  2 +-
 include/uapi/rdma/rdma_netlink.h             |  2 +-
 8 files changed, 42 insertions(+), 31 deletions(-)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlzbYXkACgkQOG33FX4g
mxqzBhAAmocSn2V083QOUUOPoRRjoJWVZZmVulrCp7jpNqI5i+3Cn+JriYC+82SA
87nAzbKOGqvSBg0lldSQRrrl1HjOGrAmGA2r10Iae24xqwAJ9NLErmJghpTW+QhY
owTBX/2TJuadLtwADvhCqQMmTLSm1KeRpgPeDz73XDPveRQuzjGdSSWVXQ7z1nGH
tLwCPZrOIAXK4ErUg/TfrVSmmsFDE0kkFpHlIzvP5t7rYyDhKt/Mgx1WghjdK8nE
3qQ40F2iEYoCW5sx15r3SwXEUfo7yO5B+c2LnkBjhEE0OY25syoDOnM8Q1MV6jcR
pblf0XAstS41DjYPB/7CObiSY6K37l6YybGflJwIaEU5zWc78DaIh1UD3WZddAvJ
OHszh/OO+nxWUya1KdJrwsstSlcKaZR/wwPnmE8OEO1cpj2k/vYRDgW8DuFcKQdV
qE7xfHcmP466KIZygLv8YGBCn1BLij3lz4EsDLa4dksA81/L7K5KQqpToVKjW9Lo
G7m8zny0ZQITN8JPckf1J0JF6MiHAD42youRcJB2il/PyrKOmQYJQ6BZvhzmndYb
8zvVC+Y4kwk615VmGuXq16Qwx72QEHuSfQb5dPbv2GfR26ntJJQT+VhceGMhtw53
chjalaGI+M4CtqBoLYNb/w08V7mERMlh3CklugHJXm/8QEE9AM8=
=F5G/
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
