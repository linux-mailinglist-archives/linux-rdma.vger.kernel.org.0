Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67453E2B63
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbhHFNa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 09:30:57 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:31841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234112AbhHFNa5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Aug 2021 09:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzuOgG8YM27WaptFIxf5oGTKEkkiXD8yBI3q+aBCBZMkhb26Ri6z0n+PKQdvDWK9GSA2dqXBHKCjvilNK76cZguhxXMMw9WDSputIHjuHD3OAnmrZjPD23o3HRi1HPgabv8p4J5ccAwUd/PmuuCBIP9UyHMGpdZKZ0/Xd2Xs2PDFH/SLluHbFt+LllPnDvc1rqM6D4S2IP5Zj7lESR127B621n/7toCxRz+3WEsuaK60dsygYKJcmLWafoUyLmYYEIYdvozH0f/bHzUg41QfDnuPmIo/hCkrTpcY2DDSHKPVzTNy/0kwpiI9U08xL5VnyzbjbWDudABCQojQh9tFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwmeuUJxEW6jzbEuUpojxBxiTSgkvrdfsJ68i47rPXk=;
 b=TD9653S+3kcS9ca/pxjTKqP/hkKY3+6+DpfBEdOdSZbSlkDiQ5obs/ZwG0aOSndCrgMtJ2SRk5MGcVvW34Ci5RjSiPkmZJ/yErCOMCr6CP/vAaUlCMEpBelBKgCVCElN1huoh3LovzhbgQlij1r3XPNruVpB212jFkwTCyxnYQIxF7HXltbD1x7FJhJ8NifC8IzHE5LHfjJDbsDQoDPI9RCCcYcO++TE8S+Nb++VpSrrUfr2A9INNjlgzcOxhcT+fEcJOPXBTKo5BkisCaH5X5dZc1kuXG/PQZcE7U9DPsEw++hjHeihhIFLpJuLJ8uA2LHpRxf9V/H+XZD1SlT8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwmeuUJxEW6jzbEuUpojxBxiTSgkvrdfsJ68i47rPXk=;
 b=PtvvRspcPKJpFoJCG3N6g11qvPlKYp4gyngz/jFrjm38ANQeH7UMXTQQYzNsCPhyF9itKR0ln3vPqAvKGZ4k9XhNc5y+M2RHSwE6851Qy60bbKsDRn8NaWUnX3VYbMQ6C1vNxzvk6JyNusT+1FaUE8ZIGLWEIZtcbcd3Cg+jCzR09rdFWUD820fxOLc3v6+XA8q5W1ki9gpPkPkjEy1WXe8xmwsTUmfAioJAel2pTIt1o8TiUpcsSZbcHu9j5Iuxs/SR+FMhOLYRoRjNSB/BH5prrWTOaZFQeS57aVMCa1oXj+Lb0pspjErZvdjjvoFFe2QO2ZXwqnyfs427P9+ujw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 13:30:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 13:30:40 +0000
Date:   Fri, 6 Aug 2021 10:30:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210806133039.GA3396590@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Fri, 6 Aug 2021 13:30:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mBzvr-00EFse-Kc; Fri, 06 Aug 2021 10:30:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14324ae3-1aa3-4432-cdb8-08d958de6241
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111D14C42B0BC8442109BBDC2F39@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1fyye2S+/MMVAj/8qEgTOLGN13AZvqG+OKnAq8RNtDtH7aI0K2FQsnXTL3W+qnDOEb/zsT05ljWY+czEiRh0BzjtYxtXP0tJndQWf4rIqJEdn5vtLJir6gdMg0r3JqKidzhJV4x8s2qxkjvf+yt50tUjM/ldpiQXckGJjE6sUZwIP5I8Wufg/MyHCi7H+uQxOK0BgBy9QQ2uUm6Js4mG//NrQzK/O4hmSt9r/Jyt7+A6W01EgawdtDQPVTD9sU21OYcVjLAu8GCUwZvYD1AcUBay3yLQSDQ2RMkYuwSLvGwPZHE3xen5CScW9E3lJMg6M7P+T358Xj+MM+x42l2Fta60WWlVmoVHvX9/ITFFoQHASX+87uYQZ353mwCjYCJ3mJCBXJd/5Y6fq8tEoIiRdbeR4bDBIpLPGHTD7OVh+VlZ70vctqbCGUdZbMQr0LDsmGUvs1EQEp8qppIU38+HDxPFiI744tYaslfNh+pgIiKUQ+aeyVWfIpTd5x17h8+YFJNrtqETopHuc/bG35tcFJHUxvvVzPv2kBCJ2PEhE6/Py2c18c8DyfuIe+c/TnTrvHVU3Bl+WA1p/xDNeVAK2MpaHgWstHO2pM9KvtOh5EFt4YCmqW3fhfZEfj65I+zVMGeAcEivT+89LavDWWJDFW7q3/cQ9tKQgegoHmS32/RQVTBUNRxqfyR6fCdEJkbC7rCMopC8tCjIOI5JC8c4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(8676002)(44144004)(8936002)(2906002)(66476007)(66556008)(26005)(9746002)(1076003)(186003)(508600001)(2616005)(9786002)(86362001)(426003)(66946007)(110136005)(4326008)(83380400001)(38100700002)(21480400003)(36756003)(33656002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Vr0o74LUF0kRXZfnVZoqJNPS2PDN2PiCTSjIIwLEwNZ6M9ElbIAsMQ7/Xyk?=
 =?us-ascii?Q?CXsD+PK5t7MqS1wMUfs2eQrTew1DlZoRq/wsVKvAxuY+pozKGua9wGxEObyj?=
 =?us-ascii?Q?eQ3oIylKx0/Fr61wbsveSBJI//aUiCE4VpdD/rUWCEOoBehn1bQb2SPotZUW?=
 =?us-ascii?Q?sSMqkjxu60PVsTQQ4drbvvjpa+IilN9j/us1NePw12XYccQ41OGMCMbTLnXG?=
 =?us-ascii?Q?O0/CDiexUA/1k40dVxb6Clw7riMkoClj+dWLa8ZrEW2/kDV9MPLf08sInX+U?=
 =?us-ascii?Q?mPxTzwlE76mL9Do9yQkQ7msSmwGxkPRGe5K5NvbxYQPKzjzNV9Q6UxS2Cyoc?=
 =?us-ascii?Q?C+lfzvfZF4G09DBf58WiZSXjJHg6ZnxqSO8GQJ0IGeGOg1aFGeXCpgVE2DGc?=
 =?us-ascii?Q?3I3V7bT2a1cCET8nhIZU+9W/vop04HEKzH0c9CaSTUHzy/lOfyZQ9UsXndWM?=
 =?us-ascii?Q?0azirB70WIMuq2LAkd6hwBGHyWiCnmHRVYlbrINeQe9Pk2diwCNvTk8CDYXn?=
 =?us-ascii?Q?SqbPtDvEP/X0LDbumOxgcD/9CEoMDv7SYCwp+2M1QReWlYiqXA2OJPbov2y+?=
 =?us-ascii?Q?/S/oOwm30ZcYnpyddSPWasOQ5lbPZUwuX2UXMYOGoBXAHf0kMU6RZTwth6Is?=
 =?us-ascii?Q?+cr15+o+rZ6U1wIzF/uGzGIdX4fxpng9+fg9lbfp0+8agUymSNVmnVR4uO++?=
 =?us-ascii?Q?1vK7qRnmWy44HBM/6gkpVxdPusKlymh3/eiWNIaXuQrMrVgjpr+sF4lKOuDC?=
 =?us-ascii?Q?xg6Ntn4y3AhVWZd+2c81diuhBNqey1BGygdB5GPOVLaFNyJEWyO6DEghNeJy?=
 =?us-ascii?Q?frNUCyftAZE4bpzZxJHXTbqg1QxjYbFhg5Rls7ZeCKirJ+uUJQrfu3hDFWyR?=
 =?us-ascii?Q?KYQC40nqZCSy6btiIJx+sOLUq+8TCNLnpqTGO5Elg0CR6F5Cx7585oDraHsR?=
 =?us-ascii?Q?gjVjrXpxYG4zoc11NKX1YT99uV/8MapejA4KoLcmhHD+uLufzbVofAz0woJv?=
 =?us-ascii?Q?eXRwoY6XItbdVr4hTgFXJtIUw/gm0TwKRtkm16alXgz/8YCWnAQ73lea4RFK?=
 =?us-ascii?Q?k+7KqX3SWpvynjc7U28HXcebMv868nvGQdm2MTuGIH5XFOK1tHMwumIafGmW?=
 =?us-ascii?Q?ZK6FEmZJjH8p1nnvXiKsaFU9q2l+9PP/5EthHQTaazd/4ZCCC8DjALQtjTqT?=
 =?us-ascii?Q?HZDIDXH1+WO4kSZVFkRrFr73sO73zZSEWVAZkS7LnVy6u2j54OItYSlThMiG?=
 =?us-ascii?Q?ghudDvLBd+8AJ5K0lTo9W8ZHa/pc9FBs+2TJKhZv7gD79N+W3857+n5K3iFy?=
 =?us-ascii?Q?5wikJJwx74pmrx8PvvsoE+Rx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14324ae3-1aa3-4432-cdb8-08d958de6241
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 13:30:40.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW+CDQvpbxOZ/183y6QRnvr3TO9V9ylMCVNAFVJ69vI4g6zVRPQ1SKMnbl7GYldL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Rather more regressions that usual, but nothing too scary. Good to
know people are testing

Thanks,
Jason

The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2638a32348bbb1c384dbbd515fd2b12c155f0188:

  RDMA/iw_cxgb4: Fix refcount underflow while destroying cqs. (2021-08-05 22:33:00 -0300)

----------------------------------------------------------------
RDMA v5.14 second rc Pull Request

Several small recent regressions:

- Typo causing incorrect operation of the mlx5 mkey cache expiration

- Revert a CM patch that is breaking some ULPs

- Typo breaking SRQ in rxe

- Revert a rxe patch breaking icrc calculation

- Static checker warning about unbalance locking in hns

- Subtle cxgb4 regression from a recent atomic to refcount conversion

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Delay emptying a cache entry when a new MR is added to it recently

Bob Pearson (2):
      RDMA/rxe: Use the correct size of wqe when processing SRQ
      RDMA/rxe: Restore setting tot_len in the IPv4 header

Dakshaja Uppalapati (1):
      RDMA/iw_cxgb4: Fix refcount underflow while destroying cqs.

Mike Marciniszyn (1):
      RDMA/cma: Revert INIT-INIT patch

Yangyang Li (1):
      RDMA/hns: Fix the double unlock problem of poll_sem

 drivers/infiniband/core/cma.c             | 17 ++++++++++++++++-
 drivers/infiniband/hw/cxgb4/cq.c          | 12 +++++++++---
 drivers/infiniband/hw/cxgb4/ev.c          |  6 ++----
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h    |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_cmd.c  |  7 +++----
 drivers/infiniband/hw/hns/hns_roce_main.c |  4 +---
 drivers/infiniband/hw/mlx5/mr.c           |  4 ++--
 drivers/infiniband/sw/rxe/rxe_net.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_resp.c      |  2 +-
 9 files changed, 37 insertions(+), 19 deletions(-)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmENOXwACgkQOG33FX4g
mxqHDQ//dSNDWM0KYjmyT+wL2q6Emc3Ug+RBl8cZYFxc5bIQC+3UAwiDDpyQ6VXr
bpuZrl36fdrQa5GC8vr0sOh8CSF906Z8nJb/8uoC3la1/Vv1WdX4PT43H+AOEe56
59EMrqDQRqaft2f/lh4Kf99d8bdMSujqpkpEkCMuQ/1iUvBMfh1bcLyf4Nccl/Cw
1LHcd0CKEw6JNFX6d9Ta+uk1t3La8gO4SGzNFuSWexiZpOtBjvWtjZ+2ROifEIfa
zr8Yil1t7SR0+o3dM0TtYUOVGgeYIB8jNDh7Hwo1kYDqZpsDHvXa6OoYVK78kRPA
z5Q6yX1tttiDV+JIZ7l3s53HaFxwZGHjyX6y8WCMbPRX3uuwKMXLWlhYpcdxmvLS
m00foe12vsWr5e/YywcAA9afZfrr5mIp8g88qbwrWOXdFwzbe0MruoEY7qMLW9Gr
MIT/Ineq6f+21YiAZ0Q2bkof9ezXpmfxZjjuSJ8S1kg0cbud+DmF3W/lXzkSsEa5
8MqmH+KX/xxaAdow64bJQi4k4XWTzelTos6t708WTEp9+wpOciKVFFNL3zPd1p/T
gbYSzdEiY/9oSsMBqsa+tvdBB7gGaePjV+WUb8ZgzcVKgLc3M0DCgLpAGTXu7yzz
gdNraE2n/N8J6UJXZk3OsHqSpqQvRh6xzQKPAwgkitbwIEn2YOw=
=/A8k
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
