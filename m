Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4B3A2BBD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFJMjo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:39:44 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:17824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230267AbhFJMjo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPdsb9e8c/AVEeyGouFg6i09PmGRF0ZpL+PhzwySEsUbB466ZJIY+nzIUUwNlgIPV6d9W8WBDeJiTf1vt2wO7v9HwpvStbE+0RBOKxgsixmcoQCCBuBnq4Fedd6YxmIve7Etv+BHvjGYR0Z55uZFkArMCxA23ps5UutHEh8IQLXUQ3IprmRPIjlLyphAsJQfcEhkMJOaKsplmIJXQGTZz31+CLGgtsE1Nc88B1fIbmpq2/l7q+lTyJDosG2dVT/e1cfn+Mzm17/Z5hefiAv5Kpux6XOrf4YsNCE6Q8wUMRUfgJg/gS2jvKnl5y3HYwTepYbkbTef3rpZVid/YuM9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1foA0E2LBWBujWYPA/xQuUkf9ncEdAuRV08wYK3aloM=;
 b=ioRFvP42XhyX7kJRjkW0CTPcVLayo3xQoYwJKUjbumZWdCHK6bGVXjI2uLbLdGh0JK7IdWmcKT3Qmy7jgO+MSmf5VdkxJ9ZldOmVsH7szW5R1Oq58qsgMVc1sFQ5Wzpz8QWEpCvbhvdTNwJahLjxiR0s1WsYq6cNanCqWb2/mOobIj8yu2O8XRxp/21b7xzeZvcU2wnpT+B1K4jbT/S/44DheSIjtfI1vyy65HHZt7QPhPSn1uHWpo8JKYOEgFDaBJc+w6FhOam1Ps87mwDOIadnjngQ2g0KyTUW3egBLK1Tn9DSHhhuPxrsP5zSo2OrbBiyofOFdndAvMfKt+lA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1foA0E2LBWBujWYPA/xQuUkf9ncEdAuRV08wYK3aloM=;
 b=oFtgiESF8Dgp3teqO3kouQjYSkJt1fOjDu4r+tKndC/eMeJTFN5gNJijl1SrLl4fB8mV46rZ9YsFFEDHbRWriL5v1OtKUHuSMMCKZHWwwwIjFeLOsSBrfZfjPP/CXcpcH6RcN2bD4X+Me/9UbzPKhNrV7iEoe6RvLIdi7VhEUaHR0WPE8xGJEMj4rRiqGPUvaC0EHh9SmgCBx0EuqhF/ETD16hzWKAj9LP90k4BqW0yR7A6KFTGQY+tmWfJ2HNbNG9lCswOItw5jBjUGmSn6/3SpYR4ATt4AWgtF7bpiLR/8vTvomN1bycLlCuJ2JmBr7EKQcAB53o6yApOYjXcz4w==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 12:37:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 12:37:46 +0000
Date:   Thu, 10 Jun 2021 09:37:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210610123745.GA1260478@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 12:37:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrJwP-005I0C-EP; Thu, 10 Jun 2021 09:37:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba841ee-b72a-4bb1-b6f0-08d92c0c8cc5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52057D94C555524AE06FE259C2359@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mazMKprgeMv53ZjPC60JSZhPb5b/+P/XhAoiEmlghsEVZuLw+X/hC8n+MYekoFHwgcwS+uf/mrlr3xWuBi/Jp/r/W8Jd80+bEu1wcCrGYNxdZbSAVJQMgjYO2ESt5cv3zJbNbfvH1Uoklp9Tgjp8CSbzQFziX69NrIMMPApDOhzf+6ohgTx27hw6++vtmPe6xmoL+3fwySwgeSLfdDy4HSCCkLhOcmdL23fKrNI/bCJ59FMw8HbCHXzPbC9d9iCPPxIgEEzqzhfHDQKG59Evpl4HgsZfrdwrC7089y010j1lagCvzRa+hSj8c6g4TyO886G2YZjC4FZ2TVCahg+DOwqEeCnPJ+AKXR5pgkC1/fP+lM12Q1ZCM7hVaNdesJNvEJ6CDuuEXvhiz6Emgqc2a+sZ+5fWP5C9yAReQ5vAxUkprCCqfJH1qxk5EDa0aIn1MAc+zhB46Y6n4u6gJ8nf3vTDQO3R0e928VxGluJLdAkVHXY1y+UsH+CGxp/XvmsH6VM7OvQs3Hv7eFE7ueYh1uo1paZP+CQPajIyVPpBFzBhdCcDE6LypWdrvfsjuB7XLqtQGd+zC4svJo5L9ivo6G05usx2WknEHqIm85Vo94NfXxkI/31Sd0+cpOeQbvKRbnTkp5pXq3emwI8KOmlVcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(8676002)(2906002)(478600001)(9746002)(8936002)(110136005)(36756003)(4326008)(86362001)(9786002)(2616005)(426003)(38100700002)(83380400001)(66476007)(66946007)(5660300002)(21480400003)(66556008)(1076003)(33656002)(44144004)(186003)(26005)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYW2xJmvolmSF1rFa3sklqF/Br5aIexpjGhmSxLBxvNR0Qd2LKIJ/GSUDrDy?=
 =?us-ascii?Q?12HZCz+0uTW1xPKjkxTLwx2Q3PXCQuO9pPn0EEU4AG29VwpdrBy4fUvg4N0h?=
 =?us-ascii?Q?G01i6/hqfcfC7TgBESuSVzoIFmcihMHCO/51sUzerm1R9PplwEkW4/vQf/dd?=
 =?us-ascii?Q?u8DykoKKmQgt1mMCn2ECALtI9yYdmSfYCAZcB3UbvwD4vaAVWRBqdu7MFRSs?=
 =?us-ascii?Q?5E1yNJ1NVWgfNYxquZLfUGUengyCsqv0GJaPF+gvyXNI9KomJBT2nPtVLPkP?=
 =?us-ascii?Q?VjUDPJpgKVFxIBq+YdZSJq729rhzilFqyom0WuBoTb8QOFI1VxMVsQKbzssS?=
 =?us-ascii?Q?BrW21qb+CyiUTJcwDb2ZYdUGJ5nTLggMVgMUb8iYacWJOYSoM4/VsEBnpa81?=
 =?us-ascii?Q?i6f25d3B/ZouJx6g1ZhruJkaop6Aq+Pqae3G14OJfPW7OdJdy8Hmbx8OcagO?=
 =?us-ascii?Q?nwyyZQExy1unxazc8n0chXmgw0YexesAoVUR60SMmSVGXWU38s5RZa6N1rPT?=
 =?us-ascii?Q?QgGcMkZF8ex+alv1W0cAOx5NTTdqDlAsLJi6oDIVNAAMHTLp2XkxHe5Jz7Qf?=
 =?us-ascii?Q?Wrn6pEDs02KS70uqNbfuvrdEgqulbEQ++YSIK0jI6waiP/+LYBxxWI/ESgNb?=
 =?us-ascii?Q?V9NpXYvozGcmzAcnxyG39wmaYVNX3eC8MW3/cQiFPXy039Czs38D6FFWAAHx?=
 =?us-ascii?Q?mPD1rQ0aJZQ+GPS4sx3sSf9HU5nh6dCK4opvsHWzE9LyCEok7ZoGEwDO3FdQ?=
 =?us-ascii?Q?Rr5z49/E+amNOHGjD3z6G6ZK1XL2FQLdmMDjIKZQDQonK3aAft5DBVuTFS6V?=
 =?us-ascii?Q?7yoNg+Gle4njjz0/orzRt1xZ/Yq/efuvYI9fn8PLtisB9Pso4I3/zycmkwLp?=
 =?us-ascii?Q?llNFwONcmRbdg+r+3/9h0CXHjq50hgfTF9NvrfeymQ1ZY9XtwQIFvdevBR53?=
 =?us-ascii?Q?yPlD67GJMKMwacr8yAyMhTpdjt3AumLSVykigGyX6O5+fPawKS3XCWVZbXSx?=
 =?us-ascii?Q?T4214WM2WdA1Y0iMe6NMaCeTAWOrLAAynhujuDKSG0ZjvHoc3DI2oT5EeVAU?=
 =?us-ascii?Q?aCGsrVOtXZDoiKbMdzMY9fQXRqSyufurmyNwzvaRdZ3Gpmh9ZlzpDz2ZbfR4?=
 =?us-ascii?Q?kJCtlzUSVKCewoGnI1tQAgodtHQdqCX0GkYiCyIh/R+Iof8b1iRW2uSwVM4P?=
 =?us-ascii?Q?ybEmGSENKid7tvroLcjtMuBgOCIpT1TdmN6TrN0Oe7I+75hbNzbi7eykftNg?=
 =?us-ascii?Q?AKWj0DFZ7ZHIqU52qrpNkMqQiuUfiSxpCafFnOIlwnXGLFa5Y0KPsSOLHC1M?=
 =?us-ascii?Q?kauLHph+/RXhN4nk7o7Bn7dG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba841ee-b72a-4bb1-b6f0-08d92c0c8cc5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 12:37:46.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXcct0WqNP5X32MK/GJVOoKIuoXMXP/LavSOnxySrD2wsqJyOF+gpncpOesfYKrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing very exciting here - only the mlx5/mr.c is fixing something
recently introduced.

Thanks,
Jason

The following changes since commit 8124c8a6b35386f73523d27eacb71b5364a68c4c:

  Linux 5.13-rc4 (2021-05-30 11:58:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2ba0aa2feebda680ecfc3c552e867cf4d1b05a3a:

  IB/mlx5: Fix initializing CQ fragments buffer (2021-06-10 08:59:34 -0300)

----------------------------------------------------------------
RDMA second v5.13 rc Pull Request

A mixture of small bug fixes and a small security issue:

 - WARN_ON when IPoIB is automatically moved between namespaces

 - Long standing bug where mlx5 would use the wrong page for the doorbell
   recovery memory if fork is used

 - Security fix for mlx4 that disables the timestamp feature

 - Several crashers for mlx5

 - Plug a recent mlx5 memory leak for the sig_mr

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Delete right entry from MR signature database

Alaa Hleihel (1):
      IB/mlx5: Fix initializing CQ fragments buffer

Kamal Heib (1):
      RDMA/ipoib: Fix warning caused by destroying non-initial netns

Maor Gottlieb (1):
      RDMA: Verify port when creating flow rule

Mark Bloch (1):
      RDMA/mlx5: Block FDB rules when not in switchdev mode

Mark Zhang (1):
      RDMA/mlx5: Use different doorbell memory for different processes

Shay Drory (1):
      RDMA/mlx4: Do not map the core_clock page to user space unless enabled

 drivers/infiniband/core/uverbs_cmd.c         |  5 +++++
 drivers/infiniband/hw/mlx4/main.c            |  8 +-------
 drivers/infiniband/hw/mlx5/cq.c              |  9 ++++-----
 drivers/infiniband/hw/mlx5/doorbell.c        |  7 ++++++-
 drivers/infiniband/hw/mlx5/fs.c              | 11 ++++++++---
 drivers/infiniband/hw/mlx5/mr.c              |  4 ++--
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c |  1 +
 drivers/net/ethernet/mellanox/mlx4/fw.c      |  3 +++
 drivers/net/ethernet/mellanox/mlx4/fw.h      |  1 +
 drivers/net/ethernet/mellanox/mlx4/main.c    |  6 ++++++
 include/linux/mlx4/device.h                  |  1 +
 11 files changed, 38 insertions(+), 18 deletions(-)

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmDCB5YACgkQOG33FX4g
mxpyzQ/9GvH+Vry87OniCEPZvyDo27gEKKtAZVPB4XWSn+m3u9SUXY7GlGJMYNHc
1YYNk77agxOgmjlQ4fErMSX04y4In/++4Bj6Xsxpc0jEKB5I+JTY79KLGN2lwxP8
gX6JK3MlLx4l7fW27oHOk7zncueyIcOX499dSpJuKiw/vET1Pygqq0fXViVwzEQ9
fbVvopHj2XzrhYPYZYTByrO9YWtmavIjUL2JZGL6CgUSpQNI5NHZXGcutuEKHQw7
WfnmgoPaf+HTmxDYVFRGjkYgi2unbcEaHzGcqR5Z2wtPhrfFx/WEHAWZyuKakjJO
1gx6RS3wOqJ21OyHM+3ajpaC/xuHCt0/BWqFis6Fi12WghCJeUFVqkZk/CZc8hai
v2KXXpT0KcZtzEnDg8Y+G/upUSLLuSnlUKHEk//XTonNHRS53xDuV4MEoAM5aX3V
Z+JQuGtRCXlrJXVQ/yRxxhvd1IIb/Cppn5t40cZby7UPbWATeDytjoIX/wnyXJGF
rksCkh7hjf2PfGdPeDwID/12JQgDLvLBGZgBoSEbeGCEaJdcf1GI5dIDLiNnOqP1
pJ9LQRHDtxEJ8/zOe3v52Vq27QMYvGwcg4IABzk0E7erwZQLdOyASajdTx0qo3Xv
F6Ob22mDKIJ6Ch/YA8Of2WuY0MTz10RO2An0owV7WCTuVbaY+4Y=
=qMyl
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
