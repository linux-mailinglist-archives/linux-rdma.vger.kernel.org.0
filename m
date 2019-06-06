Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6430637DE7
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 22:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfFFUO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 16:14:29 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:33090
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfFFUO3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 16:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0E1HjKonCXrDe+jQccFfs3o6VLpAeGk115hcbiJ6RA=;
 b=P/sKyPeQd8+u0095tKNbmGYczgZzYfHTXRhvj//J9+jI1W27r0v87NNNAZeGwdU53HEOLmSmbdiPt7fTRJ1Dd3JRy0PxQHyFtJ8v39L1P80lNipcXPVMPWd3NR8Hcf0ptw0skl16Sx4vbTEo9TZYpumBwJoChZnESFvQbn7zR5E=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5214.eurprd05.prod.outlook.com (20.178.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 20:14:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 20:14:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVHKRvaslonjpP+0u/K3AsBbZRRw==
Date:   Thu, 6 Jun 2019 20:14:24 +0000
Message-ID: <20190606201420.GA9763@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae9ddb0-5a1c-493a-339b-08d6eabb9195
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(49563074)(7193020);SRVR:VI1PR05MB5214;
x-ms-traffictypediagnostic: VI1PR05MB5214:
x-microsoft-antispam-prvs: <VI1PR05MB52142C352E2145DE879C1890CF170@VI1PR05MB5214.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39840400004)(346002)(366004)(199004)(189003)(66616009)(14454004)(478600001)(68736007)(1076003)(256004)(36756003)(14444005)(6116002)(3846002)(486006)(99936001)(476003)(2906002)(54906003)(8936002)(4326008)(64756008)(66946007)(66556008)(66446008)(7736002)(53936002)(8676002)(81156014)(66476007)(186003)(305945005)(26005)(9686003)(6512007)(102836004)(73956011)(71200400001)(6486002)(6436002)(386003)(25786009)(6506007)(5660300002)(52116002)(66066001)(316002)(99286004)(81166006)(110136005)(86362001)(33656002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5214;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4IAviXQAa+A1qZ9TDNaNlZ7WS04mYsGZm7BlHFHVo89214R1FgLx+yCrB208Ky2Z1zNPI5j4eQqtfyz8Iv2WXY4cj7163z+ICwTfZVHNurWMWs06AzsYMg4KhS5yM+3Fp/km1s9+sRTUGasrjnxCZvKpQxnmpbR9PrjJhBVq5daEAzgCYmREZLXpBvxeMlCJC7XaeV0JGtPTLAFQiTaqFmlm6zw9u3Es+BsYLXuQlp1StlXWxSI6j3nz7QXNLAAc8ukRfXa+QJ5KnlJEbU8lbt7oU7IqiexjNRq/hoyhsifn867yK2JOUuBBpviPCOSK/mEVo6rzq5Q/6y783S4s+c52VcZfJ9kigiaAO5rmRKoggEzpBGEl+Q3y9+BzQmrjAMHPRXYQYdBvo9MLY2+x/DApzJcyJN6MGCUsuWlh+tQ=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae9ddb0-5a1c-493a-339b-08d6eabb9195
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 20:14:24.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5214
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Things are looking pretty quiet here in RDMA, not too many bug fixes rolling
in right now. Here is the first batch of proposed rc fixes.

Thanks,
Jason

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 4f240dfec6bcc852b124ea7c419fb590949fbd4c:

  RDMA/efa: Remove MAYEXEC flag check from mmap flow (2019-05-29 13:13:03 -0300)

----------------------------------------------------------------
5.2 First rc pull request

The usual driver bug fixes and fixes for a couple of regressions introduced in
5.2:

- Fix a race on bootup with RDMA device renaming and srp. SRP also needs to
  rename its internal sys files

- Fix a memory leak in hns

- Don't leak resources in efa on certain error unwinds

- Don't panic in certain error unwinds in ib_register_device

- Various small user visible bug fix patches for the hfi and efa drivers

- Fix the 32 bit compilation break

----------------------------------------------------------------
Gal Pressman (2):
      RDMA/uverbs: Pass udata on uverbs error unwind
      RDMA/efa: Remove MAYEXEC flag check from mmap flow

Jason Gunthorpe (1):
      RDMA/core: Clear out the udata before error unwind

Kamal Heib (1):
      RDMA/core: Fix panic when port_data isn't initialized

Kamenee Arumugam (1):
      IB/hfi1: Validate page aligned for a given virtual address

Leon Romanovsky (2):
      RDMA/srp: Rename SRP sysfs name after IB device rename trigger
      RDMA/hns: Fix PD memory leak for internal allocation

Michal Kubecek (1):
      mlx5: avoid 64-bit division

Mike Marciniszyn (3):
      IB/rdmavt: Fix alloc_qpn() WARN_ON()
      IB/hfi1: Insure freeze_work work_struct is canceled on shutdown
      IB/{qib, hfi1, rdmavt}: Correct ibv_devinfo max_mr value

 drivers/infiniband/core/device.c              | 49 +++++++++++++++++++--------
 drivers/infiniband/core/rdma_core.h           |  2 ++
 drivers/infiniband/core/uverbs_cmd.c          | 30 +++++++++++-----
 drivers/infiniband/core/uverbs_std_types_cq.c |  2 +-
 drivers/infiniband/core/uverbs_std_types_mr.c |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  1 -
 drivers/infiniband/hw/hfi1/chip.c             |  1 +
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     |  3 ++
 drivers/infiniband/hw/hfi1/verbs.c            |  2 --
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  1 +
 drivers/infiniband/hw/mlx5/cmd.c              |  9 +++--
 drivers/infiniband/hw/mlx5/main.c             |  2 +-
 drivers/infiniband/hw/qib/qib_verbs.c         |  2 --
 drivers/infiniband/sw/rdmavt/mr.c             |  2 ++
 drivers/infiniband/sw/rdmavt/qp.c             |  3 +-
 drivers/infiniband/ulp/srp/ib_srp.c           | 18 +++++++++-
 include/rdma/ib_verbs.h                       |  1 +
 17 files changed, 95 insertions(+), 35 deletions(-)

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlz5dBkACgkQOG33FX4g
mxqKzA/6A4oEKSMyJt3TMx2Z6sJoHYWqibV/AZsra4wgA0rzGPdV3cpIwg7qeccD
dMAecHl6GILXs3dCZVKs/C5cLL9YDBBpwFWlVR4eu4BppeDA9dKt66rI2a+JFbUb
taSjmTnNUAiBWG9HhZAy2KQMARgNcvwQ+4z5USMzUXclDTTQ3w2s4hjtxDrxOb2V
24Xnep5VGS7ca0wNocypa1SwbilRR0Z+3axHbKvMFXT0LsJsDf52VRcX2JaxMNXG
7L/HKI78PVQLiz0Y8qJjTiiHeM8RDpgrf8pEIa+XnUKXvTn5YoVDI8RwOyZ3qC9G
5dLVOXOAvvJ8pLRXGwsAwvxwqHkV2EbbsODXqwXx8tqlvID7ENVMn3sZDIc9l9cp
j3aEuh1mL3iQLxuLz9Ye2cWgUEEzrQkpIGfI25lV5VFZ/G1h77aUIANkB561jWM+
TiVMo3/2qbY/KBQ8M7chYCx+EgrCisd6Yw4l7ghbVR5q69RMWdhNT7QP9frblva4
p1kRW2FyQcstLol87jQJn5eSngU9lF9W4C+o28mG97Nn6pIFX7pivTwrRFi9A6LE
5OvTvYjB7kuJNNtGmG/H1DWLBv7TIw/0Xp9X/bJs2ULG9tjYuS17gNhmH0YnX2NK
tY59L6/d849+9Nn+28uOOoB76cugQHG6qFe2e5TzuqZMAFmxKbI=
=FV44
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
