Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A6A457553
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhKSRWc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:22:32 -0500
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:59937
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236633AbhKSRWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 12:22:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPlOuv5rsiqsMtCSOeyyNnqIzuYcYw/kdHk19JTMwEwh7ZRaxGzdamZzZDgpJvRBBeL37vJVckN30m8bI7Zq4oxmhZywo2Tg7ZzkVnqpyIET7gsyw5Dm8MxuAFpqdk1ye/3/Tu4ZWIhw73Lif1mRkDwwNvi0+2l3N3G9/jNKq5/QdwpCTlRMQgs/95FhfkVe6YOQS4+lt8ItXbwyzAxmE0m3EpxpEN/XukiB0sT7tiuEDdsADjrSKH8IPXZXZh+9/zK1babnz2WleDShqwqQqlMKZNMgPg5Df6STnOkzPeAvCEk1I2o8wiCqWGiqDxFGUqguuW9Q11gLb8zdHpOY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtGE1KzABFqjSIbKL3o4DUm2ySkPgDvaXTf90TxuCT4=;
 b=AAZeTdcshHhqzCmjyJTTtKgoz1n4m1qKHb9fYoQM9Pd8ZrVQOa1CIdqcIQ6t+THkcXHqR1Nft80vGqOloLrirUvA7ndA8XfHyisRJphs29cilTR2SQvb53lGTdgmE3G4qStlu2WrBx2WhoBUMzuBHrDFEIkywXXuVBQQ4BNj+f/D63QJRF6XQs69AMFjJgBzrVIbM14DSE5kB7p+/iuq7gjlW4L/fuFedoS7P0t8vgLJCRwBTOh61cpfl8COX5BGJ7RU91QPl6aXoExK41UZOEY+qh1t3mS94Xon5P5cgqNXsAGRoDBySqFxDRpe6rP2pIT0yxWjx2YPhSmj+beLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtGE1KzABFqjSIbKL3o4DUm2ySkPgDvaXTf90TxuCT4=;
 b=cubuMSbtCrYU/QUiUJonjHB1jpGSJc6R/54j8BFymst42MslsWm4zMFdHEzropDg1Ix4b1qZI/qdwsszQpBiFU5kHZIviC+MRXr7LL0LtaASFUW88vT/dXh6dL0QZBXEdiMw3yUd6aunpbzbMwVNpANY4rXygxracnmJ3d9bMZyTnyripbJKiM+c2eRMXeItNYQ06eBN9KB0shKfDOOUx04QjqS99bNEw5dibpHhzg5NdKYJ+RdN5a9Ge2kmG2GFzI3rv+MXxYW3kgcvyV2JSKuSs+2j5DVPnhY/vOJJqSD8HUV4h3ilC09WuGyes/6ws4WGq/wy6i8z8avbZFPo2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 19 Nov
 2021 17:19:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:19:27 +0000
Date:   Fri, 19 Nov 2021 13:19:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20211119171926.GA2987583@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 17:19:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo7Xq-00CXER-OW; Fri, 19 Nov 2021 13:19:26 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e806d7-bf33-45ff-2d92-08d9ab80bdb3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5238F79EC90C61B67D5312B4C29C9@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uWWH0OC51MgFqTFfWetBqZpPl/qtdENr3RMKJKKdTCL1Xv0dU6ZN6A0x1RHZa1dJlwtOiUjLqbsc/hjyPkOeq9RY4pdnMbiDsJrV8mfBjWBWbRNOF35DOvuKpgBZP3vu9lHfkB6rp0X+jg/8WMnOU0s7LScAsMLpJLcY2YmFJxFRGOHYSQojS1/nJ7vpXZuMfY0ZmTq1+YKdvv2stF3IpyaZAWU6AqLr+6YCWzmsmh4XFJv0LYCPMHLLc8SAqRTv4YiOvcPjWvjIBIHecCptx+DgQB6UghlcMfHTf8yJCYdHOPuM5L7O0cvg8EiB0fMCHXd4lCqFak58ATLggS/9SDAItcaVhqrJB85T7faO/WpNM9+EWTPE5nD4e+PubE86ShQUapnaXvh+ATdL5RO6tbqju22sRRxHNv/Zc2NEFNabJa6iVagiKIXjKWHMVwNAACXNUoOQWwbOUJn9jtejgsOKrd8L8C1Cne0ie53uzf6xmGlRp3sRzJd0+afPzhGh2wAJe5Hh9xSrIcGuCNcAM9pqdtVArA7xvL1gI7VO3lfXN3jdLboVQaKrpfj4LUQ9eEV2nlltHUhI32RcLnEURGvklhsFevVb2nA8HZ4B+dwSrKj5zTW/kFfmIWxnsSZ48KOdfUQwVHCVLoWvBwLSMTodXxndC0M+Jy6C+/WVSg52nCEDC3A/OBpHVfMcnzatEfcfFGLZA5WPcTfvGvay5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4001150100001)(1076003)(8936002)(2906002)(66946007)(38100700002)(33656002)(26005)(86362001)(508600001)(9786002)(5660300002)(21480400003)(9746002)(66476007)(4326008)(426003)(36756003)(44144004)(110136005)(83380400001)(2616005)(316002)(8676002)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJ+NsVhEc1KJ7pZwf94hfA09vhrl0DMFMFdub1f9ylzAHus2a4w3lEVzL3B1?=
 =?us-ascii?Q?clBTpTkWkw2ZS/rVl0fZVA6hrATKDZ4jZ4AA3x56gCVUZNtBF2T+fgEOtp9o?=
 =?us-ascii?Q?VRpabo5v/9xKTk1DVjx3xcz3hQToA7dOm4iY/ahxoKkGH+dIXwAjGpNtsHkj?=
 =?us-ascii?Q?uhnDpMnYR8LUqyELx1eHEwgRDnb3uWXh9Bk9moFFi4AJ+ltH+2gfjB+cyRYL?=
 =?us-ascii?Q?gT8iQoFbwgJ86yUXM9Oe8ea/rb8Ghlq091bkQKNwi5HngZ0KpKNGweC7wvd1?=
 =?us-ascii?Q?WUzInbKIPAP5QUVPO3j+OctAIw9jrJH59FweafhZiLGsg4QybsbhHeXYvMz/?=
 =?us-ascii?Q?H+RxjAXz33McBzca2v9oVd+Jy4e/GjiPDF/JyPsQhQa4mp6NqxUHTPGK4os6?=
 =?us-ascii?Q?6Ed+Ke5GOxbLKoRUIgl0KA0jR2PeLlkZt3wCdGSkaaSxNHIX1luNN4yS+V6x?=
 =?us-ascii?Q?RdZxhm5Xuzf08+SXrCgZYRM6DL68MGNnWYmuTpI0I3pvTzPqt2xF59milRNm?=
 =?us-ascii?Q?xFKKkNq2DVtNitx3+RjX8QbBXKYoRxW0eMF5dfeeYX0+5X44V6q+OYXCmCwW?=
 =?us-ascii?Q?OHGJj0uWvr8h3B8mI5XMfxRKqnLsfSIXL4qHL/tbQ4lIT1LWidan0jSQcbIq?=
 =?us-ascii?Q?DY6fGE4NB5vdxll/niw1lcyzAs8sE5fWRoMN5aBJmXCIxnP0nsrcUldVEiFQ?=
 =?us-ascii?Q?+YKhps+/lgDSerA8GVHgvNgOnR21lUV+jgYbBW0zkSY/2/YvEI6pjBfkDgKA?=
 =?us-ascii?Q?w5SMYDkBSlaAkfAo2rXukdS5xkBWYGYokG5p822/JiH72S1M7uJK8ERQq0xN?=
 =?us-ascii?Q?Lzf1gaDIz8TMPnf7iyt324jBqUbXjgEqK3Ht5PbF0Aq36tn4Pq+13V7wrpwv?=
 =?us-ascii?Q?b7OFgKT7nSegBetE5CvKdS6nuhyc0CyJ8lA/5Q0DU3J/UCzWF0hP6wrY2snS?=
 =?us-ascii?Q?Ejh9RK1+rNiXj7xgRoxfaUBP1RTozdBNPDbmMaUb7PfxZ2XNyfrGbtFbGx5H?=
 =?us-ascii?Q?617Q3vGNQ67dSLfaRh2Sf+2TS/enUrryFv0154cerVByklr2oHenHTpHqJeE?=
 =?us-ascii?Q?aLmkYljq7Ihsy5uPHwDxMF1IJAi/Qqhsq8SCNC2l8+wOkGL0ZVLrCOWJMQqd?=
 =?us-ascii?Q?5Xj6FgxMxbeOffQkGqZj3V5JmD+8MhVbUXByh1Uv9fodOH7Gan2IK3oERDMM?=
 =?us-ascii?Q?BmRUg0qwXNPy4xu60RVhB1rSEFxKHPI8L40fafRdC0wK8htdgFlGh+9hBEOg?=
 =?us-ascii?Q?UJpZ3wL5Pp39IrhVuMC8AK7zGSwoSS7CbW/qEcpa5z8weuU7RCrJLodkautl?=
 =?us-ascii?Q?HG51GPwKiCKzlasTEYgOSy990GUp4jW+Hs+qwA0tVxxHl1525Lnk/w255yJ1?=
 =?us-ascii?Q?sSQXlviqrrihDP0xNLy3K8+V4tvl8EXiLsW4u5nCdKncPAL2WR55LwkDB0e0?=
 =?us-ascii?Q?0tWpyZcfa9LP4ZnyLuAbRRTwMlKy4Ef9AeqTFGBIpNkl1VwFBY3DyA+ZW0aU?=
 =?us-ascii?Q?ViGMKcItk8a+oPpBSKIs2DHO7QSG1awPhk2NbObyvgbdyRl4ac8znLjvOw0G?=
 =?us-ascii?Q?QGSXXHmNScLkYV9aaqM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e806d7-bf33-45ff-2d92-08d9ab80bdb3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:19:27.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4fmiJqIxy7HPgfYB0X7zj5e00wqXIbDn5WzUIXXEymx9deRKDGk29fqGN7cbTbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I usually don't send a rc1 pull request, but there a few show stopper
driver regressions this cycle. Good news is that people test rc1!

Thanks,
Jason

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to df4e6faaafe2e4ff4dcdf6d5f5b1e2cb1fec63f7:

  MAINTAINERS: Update for VMware PVRDMA driver (2021-11-19 09:45:40 -0400)

----------------------------------------------------------------
RDMA v5.16 first rc pull request

There are a few big regressions items from the merge window suggesting
that people are testing rc1's but not testing the for-next branches:

- Warnings fixes

- Crash in hf1 when creating QPs and setting counters

- Some old mlx4 cards fail to probe due to missing counters

- Syzkaller crash in the new counters code

----------------------------------------------------------------
Bryan Tan (1):
      MAINTAINERS: Update for VMware PVRDMA driver

Dennis Dalessandro (1):
      IB/hfi1: Properly allocate rdma counter desc memory

Jack Wang (1):
      RDMA/mlx4: Do not fail the registration on port stats

Leon Romanovsky (3):
      RDMA/netlink: Add __maybe_unused to static inline in C file
      RDMA/core: Set send and receive CQ before forwarding to the driver
      RDMA/nldev: Check stat attribute before accessing it

 MAINTAINERS                        |  3 ++-
 drivers/infiniband/core/nldev.c    |  3 ++-
 drivers/infiniband/core/verbs.c    |  3 +++
 drivers/infiniband/hw/hfi1/verbs.c |  5 ++---
 drivers/infiniband/hw/mlx4/main.c  | 18 +++++++++++++++---
 include/rdma/rdma_netlink.h        |  2 +-
 6 files changed, 25 insertions(+), 9 deletions(-)

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmGX3JsACgkQOG33FX4g
mxrlCw/+O9gW5bRjDfnWPP99p0lJNHaSqCsCaCYAIT6dE2aXmWSsY6tSBQs9yte0
7BlgxszzHG1YXJ+t9634pwudAzbh50o789nvyWFx+tryNiwFIcweqC/Af+OOaCd7
E+9oOscFfXMPybc64KGynwBWaBYc+IFnkzpFi6A3kpn0Ue/RfqufJj97grMiIsUs
H7efZwRWxa3ZMi/jfbGJwa+8/FaPzpXwFyt+23F76iogGnmfL4b7P334HUhLBKnb
CTmWJYfKUMaHorl/hOevL/6A0ows9Kk8pdl3tTBySOFZZ18sPyOBiFs+8Db35ebb
DxRCE3ZGUmqlgAuaSdWHhLTO6X0+zcWFkLIpsQtfcS80wOldVkaYdmEhAVTnsK3n
RJiZEcZVz0HOVem0ID2XbSbOyPawwTiLQ0+dQ32uRJrxK1UMD28HPObFINxoQOjQ
vZuV2/dLQInx5w9PUZ2LoYEMjCBbUyBGgLqnP7I9CWia+AxCMjJkrNj+qwJIy06W
YzqFpiI1I6WsGby7Tj3F25u/4Iih5JehYg45Wd/ChgmleLaO5tKddMqnvS8fkS+p
M1P98gcw6rbH9vp4HjvpM+Zvlfa1p3ACFNSlo502E4uKc0UDjpwK9AupSNl1Xlwm
OLf9OV54crEycw7Vpu2L4bm9kMBcXg7g7WZmtA692KbMMSikYSk=
=CM+m
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
