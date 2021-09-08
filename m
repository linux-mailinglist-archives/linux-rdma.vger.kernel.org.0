Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89904041DD
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhIHXlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 19:41:44 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:18615
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235595AbhIHXln (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 19:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocI+VftSnOP69ejuJWObX5cgFoMajHu1GMLb+cS7hZddCkYV0UFhwSzt6pbZWE/8qGCKCz/p0iL4Mnm1n/YyxWEEXJLQdYXr0rsHjj706dHWdL+fQytdXI96pNXd+U4FuXzlGNXyO/uIwClm3JM6sRV39r+Bb37zkf4pls6D0kvOkw5AsjTN9hJ4+QdUdwYIVG1bDtuJ51Jsc+df+M8mEFlK9+vqA1X4Xplyh8HZUOypCw/2OWGv73KSDRcaxfoY9gt4/THAUV9j2xBV18iNC41WeVgVcb1idpKj1oag0s2V27n0RHwp0nxoHny92GIjYEzlnpisVJ9GVTMpKJYk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=niKDznqEkhR+VQRnxKv5DPlbYBdwwvocqaoH4ew8e/M=;
 b=Qw5ZOAe7JCOnNa7n5TeceGA1Hl831pkY6u8ooGoGCX52+oZX3GerDk/Fp4HonakB9GD/+1+EA5PNQ6/WopYaZDp7xMFai0lwOy6AwKdN1gXQoNQOXyuLBZBVqYSa2oglFfHh6qi6KCIzhfTALQFA5mbVeDSS/bzTTy16LgarPjgpTN8b59bBHVUtdEYS2IFhBn3VtnnQnwCwmW0jklFdKcoVnIE2hFecN/dy1iZ13Uofm+JzGCTowzYEUscJNpiBfxu4+DCsNG5UWcFL26VOcIeUxh7Iw7NxEPR6XRqagiBDiQdrYEpn4QvzYlrpAb4+5iQLbGhV1J4pyZqnyCyKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niKDznqEkhR+VQRnxKv5DPlbYBdwwvocqaoH4ew8e/M=;
 b=J8Ol+XMO7d0U2wR6jfY8Q69V+vmeF0I3C9sSr7mb22zt3r269ta48KpFJdt3hi/SUo5AHtu2dZJpdkUSblN/s9tX51Mg2/iFyEET2UMc4SqaIlHmQL3W1diHaEERtJ5vkcbK2haIPlrD8dfY1yXCrG0+HydHBX/dpxJtnaHOKSHybHw/OoRBNxAmiv5uc5l0JD3Gc2FNorqtYtfEABhr/drs9A45GJ67yysGcQqj9CkKLC6s5F8lvBbzRjhczUZOhitfVzuKamgwqtI1u6GRKLZAlaBH7GdUGWyXtlwRuojuvXxIrMO+kN7W2PxHGucp8M40S36oDM5ax1edrj7pyg==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 23:40:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 23:40:33 +0000
Date:   Wed, 8 Sep 2021 20:40:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210908234032.GA3545321@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0144.namprd02.prod.outlook.com (2603:10b6:208:35::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 23:40:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mO7BA-00EsKl-KY; Wed, 08 Sep 2021 20:40:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3501227f-5c1a-4d8b-d677-08d973220d0a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50477CF6670CD6A5FCE7D6C8C2D49@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96mlg04Ld1wgWGWUUbA+48avsVj9A0tRLnz3sBDt3lhoPApyKOJ6zzHHGqT5i0QMyMs32Yz/cB+IoI6GpO0v/e2ykxDSOTsHq4Q0rS8tARAUlxgOR9zXspHnuGURluoxxvQfNSrEaCe/PelQxs6pSoxbKxj6GoXeymntgJ5ueE2eJI/sAgxfhysUlCGyNbgMHREpUURrjrYyiGBaRlzRioAlZPM5u0IvtKBqRMG7TSaEF145oUBZ3d3laEaeO6y5WnHZ8oVkXno9T33HtMV4A3evwyyxD9/vZV62RHX1TRZhlcSDzEfGiyj5M7J0QIvdnSgixpwtX5oEYvNC7wiouXjv0FGLbLc7e3J7sBS/sczQ4AaoMbGAyxvsLit9tQgJEmFrtvDBPA5PXcxWlMb8AzyP1ul3HNjBy/ZhLXUfGs6rcc4TDlFPqyE1ceFw4CADCh4j22E4apWtnUR1ZpkO97WGGsCFDtFmVZzyD9dP0u4LKMaqIfTNxBUvpKsw6K4SCN6AOo5sN1xIQAJXTYEOqNlyKWFnPa5+V8mCgMIardWVWASA/gPuVOgbYUSteA+J65qcpjXWQSlLHjvXIMGf/KdmWPFibZMgugkhapfibxF9vIhrJ954sH7M1zZrzfTha4ZmTjMOAKQRw5w0LjlVbK6LlIq9eKZHt/yk9rrXKpDGARsud2Tvxskn5G0G6g1hawrKtAhD4fUTE0sW7l9cJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(2616005)(316002)(8936002)(44144004)(9786002)(110136005)(2906002)(4326008)(86362001)(9746002)(426003)(66476007)(478600001)(1076003)(5660300002)(33656002)(66946007)(66556008)(26005)(8676002)(186003)(83380400001)(36756003)(38100700002)(21480400003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4KYmtqaCP1+x1Re0j0mo/OyypFFWYaGZ4ljR/hscL1aUofRfHcCsdM7+TptX?=
 =?us-ascii?Q?cKPjpDRYdSJvhGJqNDv9KnHNq4zAV0xVcH7U75/eRShmqWPAZGqP0n+QhfZE?=
 =?us-ascii?Q?gMNDT8QCATqKsYgTW7FCZRlWT6uX3v/8l4l9txY7YRt48Inh948++S0/0Oij?=
 =?us-ascii?Q?Iql01Wtxrk3UwMqNVJsp4HyXo3uurdAiG7I0We+1tO0FSqDbk7O0RHAxZmjd?=
 =?us-ascii?Q?1WSWUW6NOBFMkSu/PQmscxbcItdM8Uq5EIoBkbhNxwjZ9HNQbjd4ae3NY+6l?=
 =?us-ascii?Q?8Xz/JEYkhE3Lj6RO8JhCzeRbMqJ9Gc86uEQTest1bwGbVVQp52YtnKwA6ysh?=
 =?us-ascii?Q?WUy0hei9vtHClOpOBOqmoM7hLUSIIcV8FKwd+b1NXHQL1j8gvqMsACJgGpGE?=
 =?us-ascii?Q?SogiovLGnXASzwYd+oSk1Tbok9VzqU+Xz2bMUCt+KWJYvMK7SJN9ReI7+Qhj?=
 =?us-ascii?Q?fZD7laDmQPXrB+46tZvqWtCvIe0JMT43oFUf4bc/2nXDYRXlDt9U4A+p1PDP?=
 =?us-ascii?Q?87nVfTxu81OmJL/h+2YNtxzg7V5gIlUC4JiDHYdhp76M3oyPJOI2hw5XUZtl?=
 =?us-ascii?Q?NMgToJWEyCtVJqPQeBBc23Up8O4YvZCvEk9EwNUGQbQ0ZclaTloJ2nSRxEwU?=
 =?us-ascii?Q?S4jsHYo8MGJCJJMNU9GPdN7g/oPl/TysKotPhBZKnFNVRWkHAMwt3KWASkkB?=
 =?us-ascii?Q?FrQMdbdpUf2qZEk8cg9mKnv+8Z2jjiZ/rgq5j4DbImKEToN/M8KtMl9B/gOb?=
 =?us-ascii?Q?Uv4MRifANFEICHj07mn4n5iomvUNM6LqfNQ1m9ucPQK4pLrjLnX8mPPZDEs5?=
 =?us-ascii?Q?sOhMAGHfqUImQVLx9fnzRh6tnETCdaF3CZQt2iuUXZUnBUdV6UL6z+tbslmW?=
 =?us-ascii?Q?D5hyLSZj1wi29/TYPSgRJlNvuDsey2uLUk+INz+Eci0WidYY/m1Plp0U1T9Q?=
 =?us-ascii?Q?Mxi0YBSAAzg2fDGmMNzajvz9MzPHyhkWDY6hULnt4zV5ogmDCnaHucz+HHnE?=
 =?us-ascii?Q?0A2TgKB1ZUs9CUF1c9tzW8LAVXRvjASMhIjDEoxGT6o1RCe15X34Een+J2VL?=
 =?us-ascii?Q?wTVW/F/fqJMOdmL1kD5XJ/hrP9hnwe3/RjRE9nxNbCtyMTmwfcr3Hlqg0027?=
 =?us-ascii?Q?IVbB6nNNXXhr3OqmwxNc2mLyZjQN6RY5XO4Zta5vphlQp8WqGkQ7ZJ/PIyS1?=
 =?us-ascii?Q?HxKjRWlpOzNNa+rznHciFy+M98I+Lm7vGp43FDJxPY7UN4YG1RC0XL476TnO?=
 =?us-ascii?Q?gx3s1N6KV/KQi7FMPhqZKtrR5iqlI0/gzR+9qheMH5zcKU8zUlR79/Z+8pQP?=
 =?us-ascii?Q?4Jfy2Qt09oouoBPXifGXfM3t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3501227f-5c1a-4d8b-d677-08d973220d0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 23:40:33.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8ARMBUfEohoenGxj+HXANl0sJHltxNXpSxelS35zjzpntiQ7LtJ/khfPvMY2Uhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I don't usually send a second PR in the merge window, but the fix to
mlx5 is significant enough that it should start going through the
process ASAP. Along with it comes some of the usual -rc stuff that
would normally wait for a -rc2 or so.

Thanks,
Jason

The following changes since commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac:

  Merge branch 'sg_nents' into rdma.git for-next (2021-08-30 09:49:59 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2169b908894df2ce83e7eb4a399d3224b2635126:

  IB/hfi1: make hist static (2021-09-08 08:33:04 -0300)

----------------------------------------------------------------
RDMA v5.15 merge window 2nd Pull Request

An important error case regression fixes in mlx5:

- Wrong size used when computing the error path smaller allocation request
  leads to corruption

- Confusing but ultimately harmless alignment mis-calculation

- Static checker warnings:
    Null pointer subtraction in qib
    kcalloc in bnxt_re
    Missing static on global variable in hfi1

----------------------------------------------------------------
Jason Gunthorpe (1):
      IB/qib: Fix null pointer subtraction compiler warning

Len Baker (1):
      RDMA/bnxt_re: Prefer kcalloc over open coded arithmetic

Niklas Schnelle (2):
      RDMA/mlx5: Fix number of allocated XLT entries
      RDMA/mlx5: Fix xlt_chunk_align calculation

chongjiapeng (1):
      IB/hfi1: make hist static

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
 drivers/infiniband/hw/hfi1/trace.c       | 2 +-
 drivers/infiniband/hw/mlx5/mr.c          | 4 ++--
 drivers/infiniband/hw/qib/qib_sysfs.c    | 4 +++-
 4 files changed, 8 insertions(+), 6 deletions(-)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmE5Se0ACgkQOG33FX4g
mxrN0w/6A03D6TXwI13Ldjh8d03OBUwOz5UQL30peaTS2Gg0dMIxqGmP21j1fRc3
y2x4ifDbGQ4KnH0OS4Iw/Vu8HxsECX5Z6q2NA9JypN1wY0ACjK7YsMPamEIRvi18
zGbmwpPe475pYtKCmxa+QFHIGK8xvmq2IFdC1NVptTjQ+Zf7UahAZAREArtNyis6
CcpxVVbNPjBYhyBHQYccnaePdO3mtmdP0lpPBtzLlw19+1VytzrvBTFeZB1Vivq9
HDd4O1tJQkGcEZSqR12MSlknDGJ7SpGIK9zQDd8UZrdsVvSNWOuDxVHVoS+mKJ5P
CFKbG8ps004rMJVfk2pDfYihewraLHUgsxNwwiK0LJ5ktpPvc31ZczGH+/ARFU5p
WjhTkDYJ/4VFk2UyQn+lwRc3NuKLuEW6XEzSAW8jDxhvs9/OJPxg5Y80U3KqyB2q
BD2vD6/AtSU+EAHaXL4C7ZZNZJlr7DXEd42jrR+Ya2SlGhdIeL3l1PMt6mkv5Jdp
QIWlTwKLYAjYthb7KsEjg7Gy5edD90ZkKs54l27zzjy/rR6WuChbTfA8CFbRo2z+
5SDadsw3NQC8ZqwKRG9qpnhdqXi489h2OSRZ+iCU6ODOUyWdZfjiectH6y9/uYLI
Gidb2hUHW21lfZaiX8PPbi1I2IEnTjg8CieGPdqx8lU/LOEw850=
=7mp0
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
