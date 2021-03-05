Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1D32F6A5
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 00:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEXg0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Mar 2021 18:36:26 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2049 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEXfr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Mar 2021 18:35:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6042c0530001>; Fri, 05 Mar 2021 15:35:47 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Mar
 2021 23:35:46 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 5 Mar 2021 23:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIo5AB4UuMjD7MaQYWyOgQxsf8oFRMcsxcHWRH2/MpUZU5+QCUG517HVsnQ9XOVxRcghavjFqnUPpayWnkt7htFWtB1wFopP2su8pt1oCtF7ELxDxXd3u1HCcQ/MpzITwWGEaEgq9cshhKD3lcoeeEX9S/NrCuvp3AvP0DdT9YxYvGwZByt2a1YEwb208L4L2FlyLO2nTyI8AlB3bJ9gYZ0/TCFN6UXote/RhMPtWmLpj84QSma4uFs+bw8Fl5Qc61+xqav4RFdIv9HR21qNTcBNo1LihfDLFnO7EO70XuPoGssS1e9kbDHtFrVIHU8uU6Z/UHAMB8DUBC1a26NpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5bJ9SlZOfKimIygN38chBoVH2bCcb+i7MEDia2nTzw=;
 b=a326Y8/Jw1f3kQmEF30uZGQYtHGIb/JUuVHIG2qGDY5n6LRpseUb5Qj2lUndPmmGPOllSN7BOLnqEIRJWRCq5XUUxjP13mb+MaQScIlSR+QMcFf41BCqJMxjF5+7hw6GJER3af78hMtCgwCPnJEl1JON4+vod9WiKP4b4MBG6xiMMb43Fv6smJN+J5ywYn//XDKuFvNuUYLMI1/iilz+GLolwUx2h9lgbA9W2xIrCk3i2DRMU1TMmz4Fw67P1F7TFdfNecU2u2MZb6cPBuUE04F30WAH0tadKfOBTbKuKRAK6Ws3DnBPK5Nt/82zawwinpYPcpjifHJMLsnOYhdyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5bJ9SlZOfKimIygN38chBoVH2bCcb+i7MEDia2nTzw=;
 b=B9uENSZpK6yzvQ7ZOzn963qq62eVbsOPr/Tyzfoc6Cq4faeomhCNRLAL8T+Gd+krEHaFPjhQGKB7vnSDjl1VglJQ3VETouCzme0EX6TbmxyQ/fknbhbu4tOPVfZ7HOsJoghOBKsb0I6+yvmqho/kMkIHaYIbSn1xuRhaMzIKxxk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 5 Mar
 2021 23:35:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 23:35:44 +0000
Date:   Fri, 5 Mar 2021 19:35:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210305233541.GA1943904@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 23:35:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lIJyv-0089lD-Ks; Fri, 05 Mar 2021 19:35:41 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bc406e-d9e0-4f7c-adeb-08d8e02f64a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27794BE00BE21D745D09C7BCC2969@DM6PR12MB2779.namprd12.prod.outlook.com>
X-Header: ProcessedBy-CMR-outbound
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/cD8U/Kz5VrU5+QBskRjepIiD6aZo9w8W87YrcxfgL912MpbNBFEDhPZB8rEjKH75ouC597zg/tgDt3eN299WNQhbVmyYfw3jA139GFR6gowrV0rPP7G07aeBerUt9DvYO6UZDtfUK3twaEFfCyrQfr2jjgDDVzMilUk8bBb72dytk4TGQeOl77Khj0o+hl2AgeXYJ91upWX5LtDZ9XQVpjZPtKivgO30hNcBT43o7+HH1N49qvHP4WTP+nRojCI0cWr0fx0Ou5VV/X6dKKH0htY/QsaSy7yS2tX6Fi2LSpfjWPV4QRDLFMyu2gYXlfQPEZluu5xqya+eONrlLd2k1Qq+7CcsjUmETnayS4CHNznB+pUyvgQTb/mF5hMroDLk7VjFEFLMUK7/0sy0qamKJDjSTNBm3tiBnaTvcLHAhZE005lr4LAqTGyb6i9XqptBCYOqsyt1/iv29UWc4wGTw/gxWHXkn9vuleLmj7X3MOVWgVqkWFxFjK6wZ8WbVUT8HC6bqTsOnKobC7xm8f8SUvqYUz+8IkcC460FtV6uMaoUZFBBZ4mqgTqglaaBlh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(36756003)(426003)(2616005)(1076003)(83380400001)(186003)(8676002)(2906002)(8936002)(86362001)(9786002)(4326008)(9746002)(21480400003)(26005)(478600001)(5660300002)(44144004)(33656002)(110136005)(316002)(66476007)(66946007)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cYyG6A/BHI9Ky1J4sXTZj7fCCoVjj1k48pqzYW+rqw8qCT3SHIX2/1Irwhg6?=
 =?us-ascii?Q?HoiwFz6grGySA4+dGXqYpz6mosHRvypUHmH5o7KVhycjIT94TZHkPlfUlyrm?=
 =?us-ascii?Q?FdpnDM19rL24cFi0tmyFHH56ToFzQTQ23ajPn/3+m2vr1phmgLptzx82bTWW?=
 =?us-ascii?Q?qoWmb0VTVbCJTsKRik7PHXdYJQk6s8zZaiICfiOIaP7n9WfEd4ENlhkMr8KF?=
 =?us-ascii?Q?TBtmraOczddpYLXwgLMTLdYeKSndV7QKxi7+2XVtjllfkbNIuBpENZWjo88F?=
 =?us-ascii?Q?cBy2bj8hgZmoteHRNQrsjGKn6OvkRqUgQ+9xocnbhISz6QhK6FawV6MPGNjv?=
 =?us-ascii?Q?J8aWdECtSyfz15OOn8vB3fuc54bp75mM7SecJ8VbQp2Kwsl3XVMkxrCe+dlR?=
 =?us-ascii?Q?yoEdKRtJnzm0xPQs+M943mTcxi8djh+FBwdIeHvWrHnfVVXq+RT6aXXy4soD?=
 =?us-ascii?Q?tRTABYbYQH8NHjV3G0/SF8AHzOn5iXLb/A+uLfaKtMOI3zmsgsgMYVV6KGZf?=
 =?us-ascii?Q?WeqtzxQ4mfjc9b7sWK4Maj7F/cz9GrqMN9GsVFpGabwqN885SeGhmQedorM3?=
 =?us-ascii?Q?4OPazpWtzhk7aqrOwGsvd2qxogwgHT+HgoGFqT7/UttWGPhAmAwF/4pVCQ+r?=
 =?us-ascii?Q?aYN3S2XKjPZ3P6kENGshAR70rvSvCTFpkV+oLFCIE/LTCQThVtvYEvMWAlZF?=
 =?us-ascii?Q?3rknrCMNs5JN/Y/RAm7MiHeNi35AnMhhVNNA4OgUM81GfCci6Fc2NwvzgwoG?=
 =?us-ascii?Q?ILH+gKK+FoDVESXIz47GFJMAzxrZKq7jORGp9EnEn0v6uzHE3Smm/wKsW9Mo?=
 =?us-ascii?Q?DQMGANrOQgGjaCWBiqLh6es2oCsPGFBOdYbydj8aTPfk4yHs4TcvE0eQ6ow8?=
 =?us-ascii?Q?BYD+CfDwe43+94dErjJ+31cqgrM2Qnv8K8EmFS6+fo27n48taG7X7uqWM6y9?=
 =?us-ascii?Q?Z9N2UbhsJifW3IidNedQJvuE4ksOMQoMka/uk7KylfXL9+hIuzVS5+UlGD2W?=
 =?us-ascii?Q?coIKlHB9mazgkGGAqaQrcfp7+IpkmrqxLfjfoRXE/EOZ58SNDTfVEVIRnzLq?=
 =?us-ascii?Q?h4HomRtDmJvw30jb2d68BrfVbJiYgJYAcjDPVN+JEnlhA9cOosGSt5O3y1lp?=
 =?us-ascii?Q?aMfW183fgU5ROD7AQKC0XX6LIvrz/ZeRZeQmLnvbLmJqLc8uMiGz+g1005wO?=
 =?us-ascii?Q?818wdYqR/YtqiPjXYYwOuYZ7Q5UKdCcmeHsUAHEH2tEisRWn9cgtOifM8lJA?=
 =?us-ascii?Q?Qi4NZhesUJmIPN6mHrL0IYNSXEzBqh5hMTLMr5LPDSu1eF4dmOfdxHxeihhU?=
 =?us-ascii?Q?dxirtH3M0tPRyJpfAPfbAbuW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc406e-d9e0-4f7c-adeb-08d8e02f64a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 23:35:43.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrKKDE7/QY6jAgHOXqvRT4Wg4QSEzvgRGnUoLEyblA1VQNh6Bm7QG8bpYjlPgJjX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
X-OriginatorOrg: Nvidia.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing special here, though Bob's regression fixes for rxe would have
made it before the rc cycle had there not been such strong winter
weather!

Thanks,
Jason

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 545c4ab463c2224557e56b2609f88ed5be265405:

  RDMA/rxe: Fix errant WARN_ONCE in rxe_completer() (2021-03-05 14:15:22 -0400)

----------------------------------------------------------------
RDMA 5.12 first rc pull request

- Fix corner cases in the rxe reference counting cleanup that are causing
  regressions in blktests for SRP

- Two kdoc fixes so W=1 is clean

- Missing error return in error unwind for mlx5

- Wrong lock type nesting in IB CM

----------------------------------------------------------------
Bob Pearson (3):
      RDMA/rxe: Fix missed IB reference counting in loopback
      RDMA/rxe: Fix extra deref in rxe_rcv_mcast_pkt()
      RDMA/rxe: Fix errant WARN_ONCE in rxe_completer()

Julian Braha (1):
      RDMA/rxe: Fix missing kconfig dependency on CRYPTO

Leon Romanovsky (2):
      RDMA/mlx5: Set correct kernel-doc identifier
      RDMA/uverbs: Fix kernel-doc warning of _uverbs_alloc

Saeed Mahameed (1):
      RDMA/cm: Fix IRQ restore in ib_send_cm_sidr_rep

YueHaibing (1):
      IB/mlx5: Add missing error code

 drivers/infiniband/core/cm.c           |  5 +--
 drivers/infiniband/core/uverbs_ioctl.c |  2 +-
 drivers/infiniband/hw/mlx5/devx.c      |  4 ++-
 drivers/infiniband/hw/mlx5/odp.c       |  2 +-
 drivers/infiniband/sw/rxe/Kconfig      |  1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   | 55 +++++++++++++------------------
 drivers/infiniband/sw/rxe/rxe_net.c    | 10 +++++-
 drivers/infiniband/sw/rxe/rxe_recv.c   | 59 ++++++++++++++++++++--------------
 8 files changed, 76 insertions(+), 62 deletions(-)

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmBCwEoACgkQOG33FX4g
mxpgrQ/+M4v5AUXrnBIF9MB1MkzXLE8+zIiQgn85dVqpydwb+Lz0R7IQ2iP/cW5h
M9pTc57owEt78CXykRoHI8NqYW8Ju/o8pb8ReZ+x5iZdbeXlGy5KqN9XZUtxCKsr
fjt5ac86O6WLURuBpa0RHvQt9EkaUaMHnuAWaDjD2tDO11uiYbtUPAcQOKTu/Sl/
z2UjFoqZl/yWBbRBpl5q1LSGLenDGxsRqYxU0z+e00O2GnbQ+afxik3/lUHP60rP
bzskd/MxG10zAkKVnMam3GoHHCIplYO4gsV5CYDRSC5NV+D9yAzTtro7gA0z44xl
zcABlbPH/eY0W3EFKC+T7UfrpullPqLRNyK0eOuB5F5AuKHpvwfi5MO697/yrBnu
W+kwC995m/eg5/e9ymm2/Da+hipLvd2p8CZpR1pB/cw3Y6gRYrt0VHRC/H98RKST
FhHhxhM8g1erLwAAtZyQQtxiaqXD2HxoxKMG9BUiTWV6qwh6VHrhoaAQGf6mBA+p
zLtoaFVPGFxu2hP/cNHeoAgOejYL0zPyhxnQ/M6Xw+OaXju5qVXTVd0+D+uJPYgi
IA/ZPTrIMXxknVf4za5vF5aYFYOnlq7Lr3lwmygCf5cTeYd6Wlv+gmeAxb3jyC8b
0uvo/z524pY62E/8P20rW5Fu8v8ScAXSFmgAKD9pnko5t5jszUg=
=fZ32
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
