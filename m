Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE7D1136
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbfJIO2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 10:28:21 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:19623
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731390AbfJIO2V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Oct 2019 10:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0xgr8HZV+ruZCQLKdjBhk/DVGmtPfe8fIozJsA8oseAOziLJkzVldV1YYbfJ6eip2zGEWhL7a35uWJ+GhyAIybdP+UB7nB8JmQm1ijN4JJP4pq1ciDZdUJpq9/U6YG9WLxn7x9GGmJgH96kSUhCfxChJBuW4T+9cbA1JB8oRUZtvmX6zr5igt86ySslikQSqP2S4aOS0RK6iXpKdJ6jM03F7YsIUby7omOV5RfXrqEwX610V6hNzghHTnSttRibr5TGJq8xXb8p9rLGPmR4IBnvzjg+VDLYey0oqQ9KzspXxYZsJlrz0NfgftwV90xpbW23omZ85mUbuEpddg+aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DvsMKUIWhMOTO1UNS8MAXBFHvZXgSZGqZ7pMFY59BI=;
 b=NEufk4yhoH2F27J6oWJ9ggwhfqkE0FW1aMoEOLra4oBgsearx1vaaMZMbQvxQbSfBFeEOlIizKy0P9ljoRGiSn4B2nChO0g/7r0u9YHdvi4nvJj0zYnOw6zf0g3v5G93P0UnsjuB53nu3MPnjpSGk1aRetKWcAJTjHZir4uG/3f1EYRM1yJLdHlWHiuJJac2VbI6gVWsriZzQe7Y5i5q5DMvjWNalMmjH0l/FVBJFA0u2YaAW/Dm11GtS7mwZtZF4sL0dA03NJw2BTTqFkuXX+oezCos2ZvqSkhF9t8vqNjgcvptw18xj3O+dCntKtIIJErsWZUegXRDSvmqlDpfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DvsMKUIWhMOTO1UNS8MAXBFHvZXgSZGqZ7pMFY59BI=;
 b=rjK5QeDqMpTfje7swtn7F7xpac9XcmvucDxthvzJoJoV4U2DKWovnRKEyboejeQGphtsS5xtt6pZGH3o3zK/ImpzOdozka5faFSq+pHRUHTgGCOooaCnvbwqCN5KQtqzf0v0AKVf2PnjtGTWJkdvVOme8zjFsD6FTSTvCR6Th0g=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5660.eurprd05.prod.outlook.com (20.178.106.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 14:28:15 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2327.023; Wed, 9 Oct 2019
 14:28:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVfq3JiPPlLGHm0U+89M4HCo82oQ==
Date:   Wed, 9 Oct 2019 14:28:15 +0000
Message-ID: <20191009142811.GA29521@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:70::14) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 075d0292-ce12-4387-df26-08d74cc4ebc8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5660:
x-microsoft-antispam-prvs: <DB7PR05MB566071946F7BB9B51B75A828CF950@DB7PR05MB5660.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(6116002)(5660300002)(7736002)(6506007)(2906002)(386003)(305945005)(1076003)(486006)(99936001)(66066001)(256004)(25786009)(476003)(36756003)(14444005)(4326008)(186003)(26005)(66616009)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(33656002)(54906003)(6436002)(316002)(110136005)(8676002)(52116002)(3846002)(9686003)(6512007)(81156014)(81166006)(86362001)(99286004)(71200400001)(71190400001)(14454004)(102836004)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5660;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mu48uZS3R0EfXAiePib7nZLmXdP3RSH7FjgnIYWwFd6NqEXdgxBGH8wF5QpnDS8XXyQJVjNbZLjjRWiVxO/Szj9kWKHPjWmMkZhjRb23EF8POdz0Dv/cK70lOPdJlJF876qxLGNxdKVLKZGnLnMdJ/BXRQv7xoCCcl/tOdPrhT/CpAgyAZ7X/6BBlnZFq3SPB+XfM6jFGLkxUQySK8jEVrrbUAMkYZImhUSE3tiXRszxtqzG4t/vBUmoD2ugGdtlSeRYX1NgS3h6aDYMKwiKHyDgFQ3d9DKwyiHKNlobyAY81n8nd/IWwMu929qAOcFzux8oo82xL9OnOuTvFXW+ZbcivES5fZ6+jhXvqNxP4+NcrJ1xCbYPWr2k4uSZMKzj9SJvhuLDR9h1YEOYlkIPGYUUDvlPz1/d+5CKFBPeHyw=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075d0292-ce12-4387-df26-08d74cc4ebc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 14:28:15.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvivC+vXyUtshK+4QVVli09cdX+sxSriH134RAHhmczpvECmBqJnzq1/IJFR0sAnLYvtqbV4NEyLWymg0Pp2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5660
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

The usual collection of driver bug fixes, and a few regressions from the merge
window. Nothing particularly worrisome.

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0417791536ae1e28d7f0418f1d20048ec4d3c6cf:

  RDMA/mlx5: Add missing synchronize_srcu() for MW cases (2019-10-04 15:54:22 -0300)

----------------------------------------------------------------
RDMA subsystem updates for 5.4-rc

Various minor bug fixes posted in the last couple of weeks:

- Various missed memory frees and error unwind bugs

- Fix regressions in a few iwarp drivers from 5.4 patches

- A few regressions added in past kernels

- Squash a number of races in mlx5 ODP code

----------------------------------------------------------------
Adit Ranadive (1):
      RDMA/vmw_pvrdma: Free SRQ only once

Bart Van Assche (1):
      RDMA/iwcm: Fix a lock inversion issue

Christophe JAILLET (1):
      RDMA/core: Fix an error handling path in 'res_get_common_doit()'

Greg KH (1):
      RDMA/cxgb4: Do not dma memory off of the stack

Jack Morgenstein (1):
      RDMA/cm: Fix memory leak in cm_add/remove_one

Jason Gunthorpe (6):
      RDMA/mlx5: Do not allow rereg of a ODP MR
      RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an implicit MR
      RDMA/odp: Lift umem_mutex out of ib_umem_odp_unmap_dma_pages()
      RDMA/mlx5: Order num_pending_prefetch properly with synchronize_srcu
      RDMA/mlx5: Put live in the correct place for ODP MRs
      RDMA/mlx5: Add missing synchronize_srcu() for MW cases

Krishnamraju Eraparaju (1):
      RDMA/siw: Fix serialization issue in write_space()

Leon Romanovsky (1):
      RDMA/nldev: Reshuffle the code to avoid need to rebind QP in error path

Michal Kalderon (1):
      RDMA/core: Fix use after free and refcnt leak on ndev in_device in iwarp_query_port

Mohamad Heib (1):
      IB/core: Fix wrong iterating on ports

Navid Emamdoost (1):
      RDMA/hfi1: Prevent memory leak in sdma_init

Potnuri Bharat Teja (1):
      RDMA/iw_cxgb4: fix SRQ access from dump_qp()

Shiraz, Saleem (1):
      RDMA/i40iw: Associate ibdev to netdev before IB device registration

 drivers/infiniband/core/cm.c                  |  3 ++
 drivers/infiniband/core/cma.c                 |  3 +-
 drivers/infiniband/core/device.c              |  9 ++--
 drivers/infiniband/core/nldev.c               | 12 ++---
 drivers/infiniband/core/security.c            |  2 +-
 drivers/infiniband/core/umem_odp.c            |  6 ++-
 drivers/infiniband/hw/cxgb4/device.c          |  7 ++-
 drivers/infiniband/hw/cxgb4/mem.c             | 28 ++++++-----
 drivers/infiniband/hw/cxgb4/qp.c              | 10 +---
 drivers/infiniband/hw/hfi1/sdma.c             |  5 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  4 ++
 drivers/infiniband/hw/mlx5/devx.c             | 58 +++++++----------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  3 +-
 drivers/infiniband/hw/mlx5/mr.c               | 68 +++++++++++----------------
 drivers/infiniband/hw/mlx5/odp.c              | 58 ++++++++++++++++++-----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 -
 drivers/infiniband/sw/siw/siw_qp.c            | 15 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/mr.c  |  8 +---
 18 files changed, 154 insertions(+), 147 deletions(-)

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl2d7nkACgkQOG33FX4g
mxpxgRAAhF8UrKU9CW2mmqyYjZ7pAtM9IVgfN0Vn17fijXrYc1hC9dDwlQv1dk1c
EUlucKp7jTQxRHqNpZ++W0acGF7TO8rh03aty8KGqQN8jQs6xQOYyFUJNCdri6Mp
s2e/0Hk7x2H1xXwyDGnZAARZZ3rvdJ29AXxzC5ZXwHsssS8oM+ox19W22MtrZCV2
y6vSFFue7xi+TDPCUFgS8nacebfsM3gkkGShNEP1LNTM95UoLtYrdvrcyuXCXoWP
ty+X6p+r1riyU+deVboWOkwetRDDfgS0y1X2c4XidWE1HqzrsVh4vDZAptbmW6aB
hOcBO4Ofm1W1WBJLc2Tnq3SGQ9XcR8Ezns3ZX/qtdQ6QCrt7YpiMe+kSPE/ZKf7g
RDL6lvMHFM8Qr2c/EzHCyeZbGWwy/XV5awNrOmk6WBT11vvg8pBKeUrimlnIqo0a
ft9MfHSAmVVsOxUgNrQOUSLEPxNTn9v++Ou6Bqv+F6Go1ODS5gKWtRKfyJGH6D6j
ETDGctGU7IOerkBqMIhN/RrwEU/ync/iDxEirSzLoHCAWgs9vUBTWwP/efLVC+ef
v5V7rfVIlIKQZHjmz3bzuqnR/e4cRgjRwGWxy4JvohlyS8vPxQQssys0/exRRTwW
mIS7RZYmBAiacT3kNhhav4yJbBfxEENzJeZmMhWBUoLv4t3wBwg=
=Fhmu
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
