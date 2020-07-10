Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C321BCA8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJR6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 13:58:15 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:47939 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJR6O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 13:58:14 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08ac330000>; Sat, 11 Jul 2020 01:58:11 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 10:58:11 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 10 Jul 2020 10:58:11 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 17:58:10 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 17:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjdYOXk4hGf7f6QCzuen7oL4vEKm3yv0xr8zJjhpwEfNgpxvc4i37Rpjzl3QT2f+QB1Q98DO7zqL/XTrPiPhCUySR8iMy9voG3LFaDwGQFgNUUafgS4aDhiQcNRZTV8TdwCQcNqV9oJg+j9KEnQ4H01n788NLecPNR9PR/LQ+ysWxBUxYKUrSyCdgZAq/xyyXUFHJKXYoQBdklkdBq1+fel+4gqbuU/eBgrm3DfWH396wZMeW4lDWEvyqOVe4B5kr5AZkDzfU6eqoB2baS7TtG9U1Pfr+ZHcFl43D4hI9JmFuKC49kmwWyjVcNydmC8sqkBBzehh46soriSictGEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxQ8/uIU+5i2DjA+v9Zcs6mqPTA/sY8kfFn9o9URARU=;
 b=D3859IYt9so7YFXU8EORlBGs6ozIxkLqKcFzES3F/INZp8D0uDztzDtwQlB8HsvtqNzLi7yZDU1lUkRW2FeOZwOYvPkPznuXFDdabPn9fTC5snoMXGPk8eMMsnMx0j7JSruZ88t74S2aKaWU5hpRLVujfyxjsVxsxpef1+snaqDJHGIOJwHDBFM4FXdXMDKL2HIrD9AAnTYEQ0jkOB+ykGz/lyZ+VkDTEzR4dmP7+GtZsT4qng05DGMGB/kaUzrFgVmj8mllPjuOH/X6CYm8ZAehU1Z/QBKMi5KKd66diuZvdFqP29TBAR6CSblDFSaz/Gu3JgsnagHJbgCB73Oa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 17:58:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 17:58:08 +0000
Date:   Fri, 10 Jul 2020 14:58:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200710175806.GA2067493@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 17:58:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtxHi-008frY-AT; Fri, 10 Jul 2020 14:58:06 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 318f4316-e0fe-44c2-37e7-08d824facd1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114FCED284B76E84DC959C3C2650@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSBnEP2b8Yl7NuwJ6hexgvFo8pvy+PQBkMiu8lrwkNb7r1HrFVNmNqy1dpClp53zGpIAFvWidTuddbvqigmeNmAsvvkxfamDvvZfBHUZdgialgDgaU5aD3DGKcTaGqWaUoGv6VHAy+sca4AUXid4dZ9T4PJM2fruasv+TZ3oJoLAAC11VSlvu0z74OjRwZbzOPEipwvQYRYTh/CpNXsdrFML7f+rXCXV3ynzkJtJAsMmO67C0bQp2o4z/FkXaqpULk+0OkWXB1PdSBJJ5z9aoAnjvxQoS5/KaYNIsXdfxX4Mf9OkYQLMor7fWtbHZRu6yWynCDlDj+N+P7RnuTSMBf1YYleqjLjmp6zadNHYg7DHhBaZo2tABn3H/qzJ2dlO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(83380400001)(2616005)(66946007)(66476007)(33656002)(86362001)(316002)(8936002)(8676002)(9786002)(66556008)(110136005)(9746002)(1076003)(186003)(21480400003)(26005)(44144004)(36756003)(2906002)(478600001)(426003)(4326008)(5660300002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: utvh0YqQv6TceV9qVfVCR9OvaXxgEcxoia9YuWdBVWsEmY2dhwG8xVth0AoZDJD0w4/NeslhP6bwCTNDLomDPu/ysWuB8TCl0tqCZCziK3xwEUvDL48BmYXUbE/9IoyDqW7bwClrJzygvPcNZxZ2JJ/Hrm/AVv6m4FzU6cxQyJAbJkhZmQJh+8x/vE+bI/WF8hpsldaipMb0kLrtT8kZqkn5VAVg0NNNTJVjYHVqsgv5ExFpRFEpJfq+KpmcK8HXGOJNeDYUPVOd8x1y39ST/8mDvTX9qqugCzIoevUoU/8aLV77OvyDVwjyObTcUFxYPgO+AggECQrz+FO/FhWNNnzTPkraIhgYbYGpWc3Do9+IOt/X/xa6gtHNpxHe5t6SoCgiW9fAeGc9Tgu8Ifn1uYNe7g8AbSP0cIxkWoTJoiBy32dIVxkhv1b2hpsr/N5dhYlgJIT/C6UF3iLuf2eupScW2kPaNLVGMzLoDMlQAoo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f4316-e0fe-44c2-37e7-08d824facd1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 17:58:07.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g76mLXJgDYKisBakAGiSv1vizGGuNU/ZgJz0UbsRrVGPzDwh+WhxPBTK9tVdA/2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594403891; bh=cxQ8/uIU+5i2DjA+v9Zcs6mqPTA/sY8kfFn9o9URARU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=OQlJs/LFt4yD3ZgyE2uIOaxj+5i6niGTlS4W02YLPE8mkHOGsiC1qPdZRbBXCoK+r
         KgkLyw4Igie0dfOnETbXRNuMTm/nyFomk75EV9Gv1Un6CWrIm5KLYiVgpFmkUd3OWi
         GhAfcbtZ7CH2PhItk1+cFCENYQhJ34azmiu3WE4aXlU+M9P7lQVg9wxSYHinG+HPX/
         TjtQt8SjrdGZHTi/Z8AG3NtxMz8naOaBmq/GBbwOBQRd4sc5+Wyd2kTJPSpK4SxIJT
         wNrZTLtFyGJNjV8trBB5vXJ5h0oHxI5/zK3y60rE33m5xGUFsyeg49lfq7HXq1gzXi
         w1RIxS4nK++vA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

Fairly normal here, things are actually somewhat quiet when look at
the next release.

Thanks,
Jason

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0a03715068794e4b524f66ebbf412ab1f2933f3f:

  RDMA/mlx5: Set PD pointers for the error flow unwind (2020-07-08 20:15:59 -0300)

----------------------------------------------------------------
RDMA second 5.8 rc pull request

Small update, a few more merge window bugs and normal driver bug fixes:

- Two merge window regressions in mlx5: a error path bug found by
  syzkaller and some lost code during a rework preventing ipoib from
  working in some configurations

- Silence clang compilation warning in OPA related code

- Fix a long standing race condition in ib_nl for ACM

- Resolve when the HFI1 is shutdown

----------------------------------------------------------------
Aya Levin (1):
      IB/mlx5: Fix 50G per lane indication

Divya Indi (1):
      IB/sa: Resolv use-after-free in ib_nl_make_request()

Kaike Wan (2):
      IB/hfi1: Do not destroy hfi1_wq when the device is shut down
      IB/hfi1: Do not destroy link_wq when the device is shut down

Kamal Heib (1):
      RDMA/siw: Fix reporting vendor_part_id

Leon Romanovsky (2):
      RDMA/mlx5: Fix legacy IPoIB QP initialization
      RDMA/mlx5: Set PD pointers for the error flow unwind

Nathan Chancellor (1):
      IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'

 drivers/infiniband/core/sa_query.c    | 38 ++++++++++++++++-------------------
 drivers/infiniband/hw/hfi1/init.c     | 37 +++++++++++++++++++++++++---------
 drivers/infiniband/hw/hfi1/qp.c       |  7 +++++--
 drivers/infiniband/hw/hfi1/tid_rdma.c |  5 ++++-
 drivers/infiniband/hw/mlx5/main.c     |  2 +-
 drivers/infiniband/hw/mlx5/qp.c       |  7 ++++++-
 drivers/infiniband/sw/siw/siw_main.c  |  3 ++-
 7 files changed, 63 insertions(+), 36 deletions(-)

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8IrCsACgkQOG33FX4g
mxqKBQ//abz9ipHSq5ooN4X9XakYwwi4uenH2bu3lAX6GVse/2TjlIUK4OF0+faf
EpxejoR8d+7MMkT7k8NRpfzRCX6gTuZQZRvZGmtZZ8sAKpx9TdkSloZVPRkmsCnd
jFv2zPulleipPFf7286Yv4GQgo+qAsiDB8QJ7VEukgUhQg99T6ycihJHTOo8PxBQ
rH6Te9f+iC9jSg3zuiwRcZb9t3HhZA1v7Za1KW0GhvT2CgrE4z5XqmBrJQM+Wr9/
hTyUvT+EEIctc+gPEBKT2jUbnLxJDBeMk+owBI41SJsi1CA6V1tvkE+97DUzusvz
xMdcolw2Tu7Poe/3/3MVxeAQrwJfXkCopA63af04kPqWZoUN/Kf/KB032dcKXbpf
Hy7G6Ngr4CBBek2kb3vMuQzOdhACUw8ZazS8EWLa/UMdsXoDDigXhExz6vcstvLy
WlsOAZ4yu0pM4FIIr7TR5atA6RVrF/wVUCrHwtIbZN2aRZtwhYfRhkTmMC76UJQu
EfkBcd1NuJSkP1/V4el/WK5+FEf4bud31MQ8Cl3rl/bIC6tRvzcXo9EdwJ28A5kq
KY/62agJqCBEerdyBl6jfb0s9LGtCBUBPCCEYwEXDJBvKpAprqwb4HiUfkdghIvI
E9Gu43n9mgDlcmCJBVP0boBMOSCfVt4FRCRpJq2+fG32SNDeFJo=
=ZXa5
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
