Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADC43CA15
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhJ0MwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 08:52:24 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:41610
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231811AbhJ0MwY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 08:52:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1i+GMC9XZCMTbIkIBQfj1BjWsHIdfR7ExepDf5R0yohvS6TGMKn3bRCaXZLsjtCr+MeXZS0UzyVZUj92Cj8wXzCMknmNIKELd5mFMfI07yFgdiK6+jVoCo5hDHv2kqE19UOn6Z3f5KeEi8Ssa/8oKjJE8kng9gAwYZ1DnyFl8ibf1rkltcgPZaVQRL45hXgen1EOcOx6K6X6z9bmOZV6X6GdcLUZiyFWWAf0c5Nqc7+1N3+EroiCsl6NE2c49f6+C6jtQSzn+N/Be0LC6yLquyLeDFErMhyGlZadAf5C83RrkD+uEcAddnxRLrXQAZkn5mBlzgQp9PWhs+e5OLLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+C1BnDI+TUVb5iPqLEC1vDuBfwQoKnlQ+XTgFHtZ8c=;
 b=V7t1Zt3t/N3EvjM36yCg8YkJbpelVT+Fdl4JVCQp/MRBL/Rpz9sws3QPDu750YVT3ZoIx5i6MMhEY8fb70d7C2waSu8TwUCOO+mucqzpwCiC8XvkGkCDqsRah3ev7n2zea5Az/po7UG+n7q3yj8KD7C/3Yomf+JcTEKcTW7eqH0hNFqAlAf+wuWE/FyOyPRoZmVaMZ/ePROxLqYWf3bbdC6/hsODc+3m53xTvDDZ2fv9N8CXBF7lXe+6Ka2u4QpVUdZqnLKbNhrqGy7R5Y6eDksq79MzaWjathuxmdEohG1xyjmxTp3KFTbI9C0Ae4aYmTqtz8yraOTYaIfUNUjUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+C1BnDI+TUVb5iPqLEC1vDuBfwQoKnlQ+XTgFHtZ8c=;
 b=ETwtHArvxh2XiVIa9Bgc5auKua4YGB/uoKQiD2hWTpIEO1VkFzZlKEwFfnlVefQPtEeXqRMUaxn+JmRKFAxVJmq9BAxznr0u2D7YzN0sOfrZ0de++dIQPJarDFuEoJpomCR8H77cdMV8qBwQ3LZ9lLW5UI5voKeQ/pCSw9HdyobxqkpvZm+P1bGDPzn3jCHHwHUPtwjw+3PZm+0Sgk48hHl8zreyyMh+k++q2WWnZaIT4PsX5ElIhAyNnkl0rqV6OTjy3G+zK8pmrC6lzsBAXKye83ptM7YIDYXsDewJjH/jesV40Dor1VIPFfI5mbw8TgmYplA08oHatIxyFLZljg==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 12:49:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 12:49:56 +0000
Date:   Wed, 27 Oct 2021 09:49:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20211027124955.GA602533@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 12:49:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfiNP-002Wsx-6Z; Wed, 27 Oct 2021 09:49:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dcb9098-5930-448a-7310-08d99948474a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190215BBCD20375B7603A53C2859@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysYY7/R+EJHpWjC44g31DwiekFrCMTEU7rEROAOb/jVmrZrE+v0699Xe8BOltjI8feGY6aITbaElZr67o8eMfuoJE7tY0lHTmEE3OM5oB0SS8yEnCK3Dfe6pVlxwxLbhhB9EyPMP5aqhzU9J0NbFkcEdx/cPM30j8yJXM0qco5fIorwCRw1uOt0L/savSLnl+5N1HyOXO6Ft+toNpu5samfhbRYVu4TmQmJn9QzeByDFEqoCXJSM6MgWhqpT/0570i+diKGzLNWenaSkF+kvArZOw5l65NXB8h+NywagHi2tyrjfRzbDvTTQsLzcepYXHD4e0s1QTWum9o45wR0Eb3Cs8aRxZ92WnrooJRHsoUpTM4aA0jMd22MzyMxnMzJpG73Lb0qYKi5vgBoC2jyCUGTTtmlD8ox3gvxBM2IvcHzYztABVzvhi0F0b8HHPZFu9X2BhpHwyAAx+Dv8wsAwV40/2e+pRSH9hV75jGLbh/01p1X4mkTFS+FB43euRJ5KDiS8qmfMuXLaLLJQqE5XcVkDz4zTEmk9A/BZIBXTDojH8yRoV/62t0xUNkluurlZzS1jlpFT6mSQp5x2M3n4SmTCr9MNcdfq73obsw58QplXv9SHwtQz3KAa0cdtWL+eoeG5dERjyuI4ulfrLlJJ+utCnAjdSZOc2COAqQsqtj21E5F4fBA35eHsHPkeHVP1hQuU3fV5fWouD8cchC/RjZVMXkpJ3pgsWmjKNvuaYyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(316002)(110136005)(2616005)(86362001)(4001150100001)(5660300002)(508600001)(2906002)(38100700002)(21480400003)(26005)(8676002)(4326008)(1076003)(186003)(8936002)(9746002)(9786002)(44144004)(66946007)(33656002)(66476007)(426003)(83380400001)(66556008)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YuM7gbS6qVT1e99WkPJGK/O49pO7Kh+d+ypWD1lsP5yFlSSDrUGRHEqnSFcL?=
 =?us-ascii?Q?P9tV9RgIeYVPxh0ahYDqUXBLaBY5vn7cRLr5MStIGwPH71p5yJ2suurl/KhC?=
 =?us-ascii?Q?+4g68BkQSJ1l3iybAsIaQBdjzvHRN1huC9fjHqUctjCRxl3s0zccYgTNVQ5E?=
 =?us-ascii?Q?nJRMCGTp83exBJk0fUuzvr5cT36VU40w33Zz3Dl6NAjL1NP3s9uxajrLbMx9?=
 =?us-ascii?Q?gtuxMZ7LiR7p8IoHi4+NKJWPyIT1GyDjiczpOrbNccxkABwDv9fzL6uV4fXQ?=
 =?us-ascii?Q?jBWTOdBMty+2he8KNExujaSGG577MTeUykExq0M7EPtM60MP+Y96ksnSOlCj?=
 =?us-ascii?Q?LT2u7YJq6WJQxNxFOCY6wIFCJWA6Ta8/H69lOtlAc98dZNoheIhAzeF8VCvS?=
 =?us-ascii?Q?sZyBUbDp+yi5mIW2KSxBsNOmfg4w8jGhh9y2eSlncSAI1Xntw7gBmokbNTh5?=
 =?us-ascii?Q?j8g9bSp/LwtnB/D79cVp2NfSZ6IBurliNFyU78JKqXzZMIzoOeSHkLt3Ntz1?=
 =?us-ascii?Q?T+eLyd9f/3o82TxBXEV/+Bo7tqSEwdFQsQ5yZWRoSFH8P7hIeyD/STvR6/nT?=
 =?us-ascii?Q?ZkNZUWEWISFT7mUiLTmXj2mQ3XtJAyam+FM8fTRJhDEiV7TlvD4KVcEgdQfV?=
 =?us-ascii?Q?M+l1qeaEjEXc6uNaknIcP8V2S19g2U30OmdKI0E+2r6GMikEBLqPnZ8KUpBj?=
 =?us-ascii?Q?vXAjSdDtXg2C/ZoFLYdE1ELm8UEwK+sbNvlg57vYQpTQZSRaQNkBPprr/gdI?=
 =?us-ascii?Q?aStaYJraDdO8HzjmslxsCWwahxsPvHdfqXvCd+4JJU02KQQpyJ0nPLnx4tL8?=
 =?us-ascii?Q?jFQ6c0AT1NW+k96vm+UKKmQZSp0nPMmlyquc/G+z+b0EBCwrK7wwKr2pq5Hw?=
 =?us-ascii?Q?C01HBuH1dKxn4Ek2y6MaXMRJZN1vPk6JQ6KVGodc9nIWcyJDY9o5R0o6ch0m?=
 =?us-ascii?Q?Wt5+Dg70ejV21vWv1J3aPLN3rSVgGJS/E+r/68hVVSbpRTYFLCac9l3UB5tF?=
 =?us-ascii?Q?2FiqPHuI4MQFp0zNedAj3XuF+KUd/w8z2vOZecxbHUwg/TVA1NhLf3UJZAq9?=
 =?us-ascii?Q?B+Jy7w/ka1qpgzqQwA6BtsEAnjV3kyoCvbA3uslvpkPu8C46U1Pi5rcjNKBU?=
 =?us-ascii?Q?iDlL6m4RUGZCBNSCja+5zIQ+9y+IpzBf2NJQY9V4IJzOp0jCOOLumMQ+5lhf?=
 =?us-ascii?Q?U78gMW/IIlgdItMJPafCafjkVhj4KiHNAiy6bBav3a+ehRYtSfSckMjmhE49?=
 =?us-ascii?Q?1uk0sz/12wUIsRNv9r6KkE4OujwImm3WKjUpzOx9mOqt9KUikHLE+86JAPj2?=
 =?us-ascii?Q?ufb3l48kC1Vg9jjN8yu/c9HBCFLeAcXhUWvS6QLraKDQQN9LiUFges6fMZtc?=
 =?us-ascii?Q?GQMg/6i94tACK8hy2R7mz6TwnOet8ObScGFTgYo4llgYpV5FSS76ZFQKbVrU?=
 =?us-ascii?Q?aBunA+rph3kAj1kqkcQZ599+Kc8LfC/1b9Da7qGfwFLjGLiUx9jddiKYKQ7l?=
 =?us-ascii?Q?Ijs+ZAlFRzuaLzqmT5+07/JCna24O7mJ2cCTtXkypAnh07XhtepuiT2zLkt0?=
 =?us-ascii?Q?6hU/xpgqcUJ6JSTXx/c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcb9098-5930-448a-7310-08d99948474a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 12:49:56.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klNSHuKdQAmOHtqpZOncD/N6pcaTbbo4rWTPVZ7aS3RX8dDS08vj1jLGu9Lbb8ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing very exciting here, it has been a quiet cycle overall.

Thanks,
Jason

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 64733956ebba7cc629856f4a6ee35a52bc9c023f:

  RDMA/sa_query: Use strscpy_pad instead of memcpy to copy a string (2021-10-25 11:51:51 -0300)

----------------------------------------------------------------
RDMA v5.15 second rc pull request

Usual collection of small bug fixes:

- irdma issues with CQ entries, VLAN completions and a mutex deadlock

- Incorrect DCT packets in mlx5

- Userspace triggered overflows in qib

- Locking error in hfi

- Typo in errno value in qib/hfi1

- Double free in qedr

- Leak of random kernel memory to userspace with a netlink callback

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Initialize the ODP xarray when creating an ODP MR

Dan Carpenter (1):
      RDMA/rdmavt: Fix error code in rvt_create_qp()

Mark Zhang (1):
      RDMA/sa_query: Use strscpy_pad instead of memcpy to copy a string

Mike Marciniszyn (2):
      IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt fields
      IB/hfi1: Fix abba locking issue with sc_disable()

Mustafa Ismail (2):
      RDMA/irdma: Set VLAN in UD work completion correctly
      RDMA/irdma: Do not hold qos mutex twice on QP resume

Patrisious Haddad (1):
      RDMA/mlx5: Set user priority for DCT

Prabhakar Kushwaha (1):
      rdma/qedr: Fix crash due to redundant release of device's qp memory

Shiraz Saleem (1):
      RDMA/irdma: Process extended CQ entries correctly

 drivers/infiniband/core/sa_query.c        |  5 +++--
 drivers/infiniband/hw/hfi1/pio.c          |  9 ++++++---
 drivers/infiniband/hw/irdma/uk.c          |  4 ++--
 drivers/infiniband/hw/irdma/verbs.c       |  8 ++++++--
 drivers/infiniband/hw/irdma/ws.c          | 13 ++++++------
 drivers/infiniband/hw/mlx5/mr.c           |  2 +-
 drivers/infiniband/hw/mlx5/qp.c           |  2 ++
 drivers/infiniband/hw/qedr/qedr.h         |  1 +
 drivers/infiniband/hw/qedr/qedr_iw_cm.c   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c        |  5 ++++-
 drivers/infiniband/hw/qib/qib_user_sdma.c | 33 +++++++++++++++++++++----------
 drivers/infiniband/sw/rdmavt/qp.c         |  2 +-
 12 files changed, 57 insertions(+), 29 deletions(-)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmF5SvAACgkQOG33FX4g
mxq46BAAkROJlg3IIOhY1SPl7ph6UNWBnRtls6zrlZMeThFqLcHH5kErpULVNXZl
oWZ9nH6frnTlqWRcCuSaJGArFbJpY1OMMqaq7AJUAD393Kkg8Irsdb8yRI7kVds7
I3ENz6PtEdvldhVrwc22Y3zbjgLmFdLMAU3Lz6AYDQCNgSRy+KaouPe/qU5zOUF5
O+RrCPflsgddI65YtJ2hN/aNKaFukeb/GeOK6BJks2rHJpJAeF0Z9n1aouK8qpvA
tmHrM4AwbF7c7XP3yDtXce+0lgWdw7WisuqiLt/hpZhCnQFdA+8GyxsOezF64hQE
0Lsad0b6wLjguKmjAhBED9qcKhKogmum78mB2onzbNdxBiz2e5DNdiqSm1+FthBN
eYbXKpEGYKUoIzSp6DjRGnhssM2hPFtq57vrG8LCMKUOzOzBJAFCt4oCGL17Gfyc
QlcMf3AWvhi/F6g6qEybzZRAAQ1dqDDeg+B8sSqoKVGyJEOS/PbMHdNqR1gxaSQF
sm4maqcm70Y5UT9Wjqu8/0CGtqvQXm7jLRbwOg6knnqJxVcxR8OklCa03ow+PYoU
7HH/+rP+SjcEol/kmladI219AuEyBgOupkFz3JkLbF0VH9GBFapz5M/snS2dDiXB
s3dzyAwSjRTN+Ip8T/F/UKAEUJ6OSQgdnNbu3kKZHyO+3O7taoY=
=55Xu
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
