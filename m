Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59000EB6D5
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJaSWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 14:22:21 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:16967
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729149AbfJaSWV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 14:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0qIeeIewnax/BIl8vak7k4GYTsfoevHfMnLKSsN++EZcQ3gDr0Qc+U89SNUvF6hqZ7di48Gg/Oyk0q+fqCCftb90g9xB5AIPOmdEPNBhPEz78bA+v4Lubnq1/WFiVrLw2EtlH0J5IpoLla2IBCKUmA0IMNX7MmVc0Mtw8XVxHmAh3U7Edw38nmiiL0yahhMKvRR+fksaFRQkSV1XosH1FYjDRLI/sbSGGo8VXJYUh8pEDytXRnd35555FdJYvHc3pe+kHkNY+CGHOgeZCdDR+CsyG/G59MTelKJyCw5KL+x2GJmSiZZgDvnxLRiTchkLwJ/ZHofoZ9YYWlw8iEN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G58oiRgWls+gCkRVNtlWSE+MU/KPY6DXYbXmpBWHqtE=;
 b=a15YpVAAhnNnJ0GwUKoxclic3LFqcSZOMwyZYOwSTJiWtM42b0vY4cil9Uz7jdauPr/LGnPRDaekrCutkqTsAktNdoZuiFcDbYLlUfVzwemYIWuP8iVafQr2dTpGD2fuu+8ciXYvCoAABTfGe3zE3cruBKqEaC57vifodCDu1ggjP9BIVAP/NkTAMVSnXoFadgq9FGx/aHfnrI8MeFUR33SUwc+fNJNKuKn4R5FxOypDZZfGAHH75Jp2DIlc47UGIpae+TrhUjKgytE7q3YfuuOMHoed2RhsfZhlgGp+oc8tEJC/kO3KjTKz6rwcJ6gmI8bXJp0rkNmAfeIhikK4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G58oiRgWls+gCkRVNtlWSE+MU/KPY6DXYbXmpBWHqtE=;
 b=huFyhNBFaG5jBwH8wpeGlUqUcLAdla5uk0iFxP3kSAG21FS7sqONbBLG1J7WA5vdSOohQPYqe9qARYJaUT6FvhWFqX/LakdAjY4ZYQl88OrdCcnNSArUdJEjL1YI8jwTY1Vb9J6XPE3IPe6J7Bkj0950ZjCqnSZEINr0x18rWPg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6414.eurprd05.prod.outlook.com (20.179.27.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 18:22:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 18:22:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVkBgfjmsUX0MUG0qJpJf2Po+xnw==
Date:   Thu, 31 Oct 2019 18:22:15 +0000
Message-ID: <20191031182211.GA27176@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0212e385-f80a-40a3-dea9-08d75e2f41b2
x-ms-traffictypediagnostic: VI1PR05MB6414:
x-microsoft-antispam-prvs: <VI1PR05MB6414D5E916D50D21361CFF26CF630@VI1PR05MB6414.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(14454004)(6116002)(5660300002)(486006)(256004)(99936001)(4001150100001)(476003)(86362001)(3846002)(8936002)(305945005)(54906003)(4326008)(14444005)(110136005)(6486002)(71190400001)(71200400001)(316002)(26005)(1076003)(7736002)(52116002)(478600001)(36756003)(33656002)(6506007)(64756008)(66476007)(66946007)(25786009)(6512007)(66446008)(66616009)(66556008)(386003)(102836004)(186003)(6436002)(9686003)(2906002)(81166006)(81156014)(8676002)(66066001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6414;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mdnuvx5m0nE2IBjKP6vbF3OFR0VVpdv9Vo5MP7S8cdJ7Hfo+E+bg6QLRMhuXyWNsHDXLE7/TKg0/b7IWu1qZ10aCAPy4squjRbLlCpt/+FAj9WVzJgScc0tJickaJZOtcZO8ME6+M9x7P4LVq4RjoNDt2Sq/eGz7DQjgsKA0Pu9xJ+EhJxPicLZgo8x5dWdnp77+42/CHYcYWOtbzvWU/K8/M+MpRQwa53YVYlgBFeXGIs1+Rfmp84PVBUk+23U5HFEGWR2XmfUd/1dK3qUv2mX6zCGPLbm2/bx7/vhzmmTP0QnhbzP69Ul4Xaxl9/mtBlL/VT8WyHuVvkjBvTdMYSUwB6TLsK7Rvp1KZcaC5ghIjEZPLmgkpHDA6LJbQy865+kMdbpBKQBGwqrEmehLp9aUISFARj+tsjic6tuKmOw2tfIRhCOW7s03ulfgTQGS
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0212e385-f80a-40a3-dea9-08d75e2f41b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 18:22:15.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCPdFlfVQeP0bTmTnbBT9CCDR2NF4RAhBCLwsDJd3UkSRCWJcUgh/Qn0JqXcNpxmMq4h7gUk9avfuMVuhJZFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6414
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

The usual collection of driver bug fixes, and a few regressions. This cycle
has been reasonably quiet on the -rc front, with some higher -next activity
thus far.

The following changes since commit 0417791536ae1e28d7f0418f1d20048ec4d3c6cf:

  RDMA/mlx5: Add missing synchronize_srcu() for MW cases (2019-10-04 15:54:22 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b681a0529968d2261aa15d7a1e78801b2c06bb07:

  RDMA/hns: Prevent memory leaks of eq->buf_list (2019-10-28 15:06:38 -0300)

----------------------------------------------------------------
RDMA subsystem updates for 5.4-rc

A number of bug fixes and a regression fix:

- Various issues from static analysis in hfi1, uverbs, hns, and cxgb4

- Fix for deadlock in a case when the new auto RDMA module loading is
  used

- Missing _irq notation in a prior -rc patch found by lockdep

- Fix a locking and lifetime issue in siw

- Minor functional bug fixes in cxgb4, mlx5, qedr

- Fix a regression where vlan interfaces no longer worked with RDMA CM in
  some cases

----------------------------------------------------------------
Dan Carpenter (1):
      RDMA/uverbs: Prevent potential underflow

Jason Gunthorpe (1):
      RDMA/mlx5: Use irq xarray locking for mkey_table

Kaike Wan (1):
      IB/hfi1: Avoid excessive retry for TID RDMA READ request

Kamal Heib (1):
      RDMA/qedr: Fix reported firmware version

Krishnamraju Eraparaju (2):
      RDMA/iwcm: move iw_rem_ref() calls out of spinlock
      RDMA/siw: free siw_base_qp in kref release routine

Lijun Ou (1):
      RDMA/hns: Prevent memory leaks of eq->buf_list

Mark Zhang (1):
      RDMA/nldev: Skip counter if port doesn't match

Mike Marciniszyn (1):
      IB/hfi1: Use a common pad buffer for 9B and 16B packets

Parav Pandit (2):
      IB/core: Use rdma_read_gid_l2_fields to compare GID L2 fields
      IB/core: Avoid deadlock during netlink message handling

Potnuri Bharat Teja (2):
      iw_cxgb4: fix ECN check on the passive accept
      RDMA/iw_cxgb4: Avoid freeing skb twice in arp failure case

Rafi Wiener (1):
      RDMA/mlx5: Clear old rate limit when closing QP

 drivers/infiniband/core/core_priv.h        |   1 +
 drivers/infiniband/core/device.c           |   2 +
 drivers/infiniband/core/iwcm.c             |  52 +++++++-------
 drivers/infiniband/core/netlink.c          | 107 ++++++++++++++---------------
 drivers/infiniband/core/nldev.c            |   2 +-
 drivers/infiniband/core/uverbs.h           |   2 +-
 drivers/infiniband/core/verbs.c            |   9 +--
 drivers/infiniband/hw/cxgb4/cm.c           |  30 ++++----
 drivers/infiniband/hw/hfi1/sdma.c          |   5 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c      |   5 --
 drivers/infiniband/hw/hfi1/verbs.c         |  10 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   6 +-
 drivers/infiniband/hw/mlx5/mr.c            |   4 +-
 drivers/infiniband/hw/mlx5/qp.c            |   8 ++-
 drivers/infiniband/hw/qedr/main.c          |   2 +-
 drivers/infiniband/sw/siw/siw_qp.c         |   2 +
 drivers/infiniband/sw/siw/siw_verbs.c      |   2 -
 include/rdma/ib_verbs.h                    |   2 +-
 18 files changed, 127 insertions(+), 124 deletions(-)

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl27JlAACgkQOG33FX4g
mxrfUhAAlJ384Q/OvZcm7JYjkQi3cassW5p+Ci0ox8SL8iw7YuhehMovSQ9oGcxm
XBQtDMrLB76XW8DDB1H5J2GGG4ktn8gCWVOyetW8D4jz/C33DAcKdljiF0m7a0jl
kV5YnRwlfhc6+sdptMaK7hx3toHvQFlc+0LQ1kUqp7XHlZsAr7cf3PyxvQmUVCJD
fJvlCz/KUaoqRrzTokaf/rmHLNoUDT3KHsUi6ZIbo/4DjaP6b2i288lg1J4n0hmw
36E96LDlt5jvQS2LPEgei23mWVwiOYeJ6Xtj0GOEKN1J2rdJVx1N0QUyj5ZaYcnk
+rOXFuG5UK7NoIpInpIBFyaG858zqIWw1KqycOSNACcNDeGukB11uvcgV3+0VSTo
KNYtI3tlO9FwhKdYnFhVJSq0kW6bR0qaeR0u9Ivpvha+oyKpQzfW0QPuulsAeiEb
afJOtcXtJDZ0OZsMJhgSAbMXihyO3N3tXDTG8r6isDvhM6l44vjJpXW/Bl+IeiEt
yuAcFOkPq1no52qpex7p0oan2ZHyPagGFjbLiFw33T+POj1Uj6QhuemzRxZnzmGR
X6XjIQN4vBa2wexcoP86mfE0C+uD5yQK8mN3Z0iNu66+1Qs02ZrfDaOkjC1+QYx2
bla/rG9kgLMqaOImSDvYwYFm8djlw6xUhY2LmwYJNUeH5ASy20I=
=Q85E
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
