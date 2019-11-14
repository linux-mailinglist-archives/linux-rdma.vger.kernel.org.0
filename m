Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A88FC9A4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNPQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:16:17 -0500
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:16442
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfKNPQR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 10:16:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntbDyHSpxsJE1ulK6Rye8eeB22apZLyiYB3rQt+ibCVBaxJKnT3pmwmJ9OPX+GzVyrxAZifvRy60zgezZjhY5DjiHmk1GgpGns1N2IU0Ig7VlMPOsWDJ4RlnnNx7owsSRKc0cxEJcFJBugdGGmFCTJXhCsUNEqC5Tvt6oABMsqdD5rJ3kDJoz+LC3WYZC2UNCC6v/o3sizoOuFr36Tv/0XFhE3gqxeqaLcrTJv9k5cDU0XlytAawEr8NDkEC2IQ2v71iIOJ0UoRY2YSPongRBm4mko1viBmCOMBw448HUKLI+xez8A8C9lDbRa4fvoZvuKUxfq4lmwYBdQtTMrlRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNbUgpTzOZgAEIQh2Hs0+B8OwrOG04NwCirijog0e0o=;
 b=m4xJOZG/c1eiwzsHrTlI8iHFXLm+ol74GO7d1uFlYjpuD7ziOqzFfadtSs96jY7sAc1l7FfBrdBkzOdJ8XFhSIgYbKPXH7MsFK7RvpneFfaQp7+MNNO1B3v68klgs4V53s+QIKj27VMebzbF8thns5ZA7YWIjX+mCvh1RzoTt59Bdya18YwodIRodfO+rz1XrpfcNmjyVeRfFQK9cABYhKl1wg6KZV2ieS3mNKzbALLtzHd9xDrTKEACeCYM4j0aC2DTbnOR0SnIgR0jNDDlGbuTo1qec628is0OAfppBPRO+UnQJPLQncqZntvW2Mhl08tBNy7M0pDpOh8ka73N5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNbUgpTzOZgAEIQh2Hs0+B8OwrOG04NwCirijog0e0o=;
 b=MNDMnmZzabTKZiahDNq0CdZeZfgQ2902SMWC/13fr4zf14py3nQzrTw2uykIAZPNqk4Dp/r0Ky88+p1WweIn638X7+AK/iulf9svfB2ogRGMtcfgyNNX3ZGyLP/q8rP4ifbNEpZgoY05Ak2TIoeEkVRKXUA3caRAa1G+o53UwlM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4542.eurprd05.prod.outlook.com (20.176.4.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 14 Nov 2019 15:16:13 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 15:16:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVmv5z4tDo6IGeNEiw2DaY1UuNbQ==
Date:   Thu, 14 Nov 2019 15:16:13 +0000
Message-ID: <20191114151609.GA14855@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6619511-ae03-415a-2cbd-08d769159624
x-ms-traffictypediagnostic: VI1PR05MB4542:
x-microsoft-antispam-prvs: <VI1PR05MB4542AA45BCDED7CF0714218ECF710@VI1PR05MB4542.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(81166006)(1076003)(81156014)(8936002)(6512007)(6506007)(25786009)(486006)(8676002)(386003)(9686003)(7736002)(33656002)(36756003)(26005)(52116002)(14454004)(5660300002)(99286004)(2906002)(4326008)(476003)(66446008)(6486002)(6116002)(305945005)(66556008)(66476007)(66616009)(66946007)(66066001)(186003)(86362001)(54906003)(3846002)(316002)(6436002)(71190400001)(478600001)(110136005)(71200400001)(256004)(14444005)(64756008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4542;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 67oPQxmUq9vce47IUdEgp7Jx/CKJvDpeHdYd6T7QoazRVu5U+aJmkrEolAwfr/9C+9svxbA1rbciNh7/kcNR4ngUQVyAsjZUIJdDo07VR4wR0LmiKFBdAQZmfQfesucwts4Gvhq5yEn7rhRXiwvXfof77si2zdAZFpqt1X4AvFLdOyGlmdtplwlmDs0TeK/Z0vc1xBQKwl/60X2SeMC5K+UOCJTA9BEBjQQtW36xjd/ojL0j7zzzbu2jToG20m3hgbnY80v/mCJV9qQKLTYqbQJrk/DCX9rlV8D6YOpSAFH8Ahyd+Oz1E8Av4umFWtQS/Z/SwXlmRA2hCox1eqgeMf75V++QzdGCMXbD+m9eCqgBfuXt+hp7/LadmEVuei+csU2Jn9gpKyaxwlTYbEO9ojTX5od1krzNyEYVVAuZ0adfqI4vnsOKqk7Budh5RYWs
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6619511-ae03-415a-2cbd-08d769159624
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 15:16:13.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NP/MKnaEOMg/lpU1C8h15Fr8g6mYAWdNzJr7aHTdNXwoPldFKhb2DfXE7sYRMd1QRjLqDEwX/Aw8gpQRiyWJTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4542
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Third rc pull request

A small set of bug fixes for the hfi and hns drivers.

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 411c1e6774e2e1f96b1ccce4f119376b94ade3e4:

  RDMA/hns: Correct the value of srq_desc_size (2019-11-06 13:37:02 -0400)

----------------------------------------------------------------
RDMA subsystem updates for 5.4-rc

Bug fixes for old bugs in the hns and hfi1 drivers:

- Calculate various values in hns properly to avoid over/underflows in
  some cases

- Fix an oops, PCI negotiation on Gen4 systems, and bugs related to
  retries

----------------------------------------------------------------
James Erwin (1):
      IB/hfi1: Ensure full Gen3 speed in a Gen4 system

Kaike Wan (3):
      IB/hfi1: Ensure r_tid_ack is valid before building TID RDMA ACK packet
      IB/hfi1: Calculate flow weight based on QP MTU for TID RDMA
      IB/hfi1: TID RDMA WRITE should not return IB_WC_RNR_RETRY_EXC_ERR

Sirong Wang (1):
      RDMA/hns: Correct the value of HNS_ROCE_HEM_CHUNK_LEN

Wenpeng Liang (1):
      RDMA/hns: Correct the value of srq_desc_size

 drivers/infiniband/hw/hfi1/init.c        |  1 -
 drivers/infiniband/hw/hfi1/pcie.c        |  4 ++-
 drivers/infiniband/hw/hfi1/rc.c          | 16 ++++-----
 drivers/infiniband/hw/hfi1/tid_rdma.c    | 57 ++++++++++++++++++--------------
 drivers/infiniband/hw/hfi1/tid_rdma.h    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c |  2 +-
 7 files changed, 46 insertions(+), 39 deletions(-)

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl3Nb7YACgkQOG33FX4g
mxpTtg/+M8SaISD6YKYjhuBMhNvUtnRKjxwwKt5s6hP1+8C04CY+eQykeHKFy7wM
wx4cYiWjuyYgVDeT6m7H4wYQIIqCJqUqGFsfpyEpHKYOKZCj5lk+/94/s9ommvNd
ollogA43qzHTBZ6HLLRbH3DwR7EqXVMdzL/bHoKDDTYxceriXz326lBIrVV4eTRC
4HWKagQEUzj05gbV2+eTo4t0xFBoSm4p4mqq0MkqD3aViWZZs5bQ/PGd3JKcGlxH
sn8vLxltUMLsJ1WurVjjSdJAaeYcJ5exbl0O1U12y89tT+reIiMnQ5rr4dc1S1GW
fwtRfTswliX1IMDZo/yICtFoO2FsHlWUjQj/NeuXEi6QOnATTEO1pHfUFFP7FLlt
44bEqoYxIdzo64YJ4tqcdxvzjTQiftK8CxzcpOava5uYdw2wNEzyHVqVHiKJc99i
fe90IropcVLRACOobJODRe2ozLJnFTFsHh4VgjlVKesYFwF+t4tXC8NgCVngX1+V
RiCcr0jplvoVatcdM5T16hwbaCmN6FEHUK9cOKVJ8xtYvsct0P4CXhJuhYeqfCsu
nTiDgY63VlH3tKGi8r/azagSU/eCnQkXR0Ucl/CyAU+V7jcflk4Ad5VVD1lokEUw
oAwTM32pAzHy5qwKcGR7bJwK2C3HNT5cRTGPrgU0TUPjABHH8Uc=
=6acZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
