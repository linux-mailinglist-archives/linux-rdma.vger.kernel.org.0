Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA523F6030
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Aug 2021 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhHXOX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 10:23:57 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:54144
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232311AbhHXOX5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 10:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erIDxU0RBTzAFGi6xU9wHQ4wFFoGVTLjxphiSlfZuBJl+tVB/Y0cjLeDa8SfDlje8BJHfLF0x6wWrXcJxbztGdIlI5YI7oQi/J/aO7YVLaqK7pAja753WGhXGvVTklQPUKGkj497G+t9uI1FSU6RoB8ogb6Zx36FKc+7RBOKyEoeXGsxuVzQ5zEUVkTh+p9zSlvrpqxzHaweGLtGVlpxldIRc/LFwobVR3tn9sRo4Rh392mSE6TEXZ8Ycw6rzxoC3L7ybC63AHCvozjPm4H5NMCOcsZHxcHKHkhTnnRJVsY3Lxy4HEwzlVgfBtQGqm3UKIkxvjkzBv1MMkhB+MPKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySLhDAK1VrxOTNE7AAe+l/E29lmViuxos+JrRO6q80=;
 b=TD0P7PjPVranvL9T4kNsuUywrRfMcSfBs2zD11ABa7DpU4AU47KFkoiCFOy4aWAnnmrVWSvYdyujGDjm9w9b46jCA0nJKV2NBEeLvBp+76LPCpUo17VkEPFrD4MkmlXBSLryu/7kNFo1qTgI19StyTXU2axWEbZPLxKsZD7e9EpPnphdnXTHmd14yKKufFmDwxr4mP7WQZNOizB/Ix181j8tX5jLDPMm/Ns6DmvAZH2oSqf0IXyF5MTysWwzd1Th65jJ4wjA56LaZE2fkkvYKigKH2kb93awMW862iYoYUogSRcHJTu0sSuHQ3rtRK2uFujNBP2mWXioIEmuW5IDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySLhDAK1VrxOTNE7AAe+l/E29lmViuxos+JrRO6q80=;
 b=OgfGXlnG3/2dqyG96nt8T8KmnOpJI8LQY60oKw10/sqdWvRrPkMm/qw7TOvNMvU1XsxunEXohZbmoUZw4GYn6AOYH2AlbX/D+B4bKKJB19Uf0fxhebXgSmqTKiEEYLRMAg5BaDsprtve7y/m3PYwmqKn0FdsaTd2xveOJiZu45RjfWBus/XIfKN/NyOh3HEilvE/XsR/I3eGGqKMicdh5x1448RT/INh/41npyF3tQ5XgBiolcRMX41ceEOXPNKmslM6Q8AZ8QxehUXMI4LFh8s8aNC+Po3QumyXekdbzduK+wn+FWSY3ZGOs1RFDH05MdMtJ5Co3uV5/fr45bJiGw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 14:23:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 14:23:12 +0000
Date:   Tue, 24 Aug 2021 11:23:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210824142310.GA1070942@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 14:23:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIXKY-004Ucr-TV; Tue, 24 Aug 2021 11:23:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1782f0ae-1513-4d7c-638f-08d9670ab420
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5508AB6FBA0A5C1138D6B3D1C2C59@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwXQ0ae3FW78PVueFaxZ51Ga+U78sqdBHQ4L3FsNtx9W4dagwHhDkQMkZlMj/D2xtFcDbPeck8YSJwsy1bCD3dyQyf5fhUio5ImhH8404qTXAeEccsmriWURPQUsDBd+qdYdxw5NlhSVsqGv8WVyuDztyuMYvVQJMmoRNx3tK52En3v3uRPjCDMOsGSndnXJHN5S/rqU6OTUr5KDXKFri6MO9qbWhyl2qnQeaNRJYszc6Ha8mCHzR+gJA6qPQtvKfU3WN6mLlobDD4D1yJF80W7q5fTA0U1HSKgIgxquQMyqPrlCYzuA8jSXXmRKHCcsR0eZ1aLG6ofzgW4qI+UVDHIPg3TjFCkOzQ1alyjrCUYPVMEqSzQCwcHDuT26yGFy9/AdUNyu1S5xd0SEl7Uz2sMhUUYztGLOgwiq0xyq3r9R20RwtTbDa5npLq9fqeX8soCfODR6yPDjrOj4Sj4VSthi7DFFuAaO7rX4CwKdXkkY3ClwjL/D5iL7+cAsrId1brSkTXYVzCCw8Q4m3jKVhYF3tNZawdceS9D9ZBdN6BZYGmS+2awYEG1tqb66E8vAi8idPCERPEBLDj4Sh1Jl/9p1W+xl2n8qxDzJnf4upoHgmuxpGxapxF5ib65LFEdtmx5dVuz6jIj9565UutB+i8PCEY/Flwr8dChzagUd9QtbKSK3a5FGiJ7P0XHbUmAltwSdq4QBSJXSJxSbayMpdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(86362001)(38100700002)(1076003)(36756003)(426003)(83380400001)(186003)(8676002)(8936002)(66476007)(26005)(9746002)(66556008)(9786002)(21480400003)(2906002)(110136005)(316002)(4326008)(33656002)(5660300002)(66946007)(478600001)(44144004)(2616005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jipne8kceQYz4LlXaDmAujlz9Iywe3BjIM0gJmxPtKVjjkwy425bac+uHqCq?=
 =?us-ascii?Q?kb3JplK759cGX9GlVtLP/RD9LvIZhbdmZJnf5ZRQJDS7FhcW8KkMcOhgxHNH?=
 =?us-ascii?Q?Rrb13sNS6Nm+13xPYfxbwHVWoTpTLSpKF6jS2MvHuodwRe0zP6D3nX1S9Zql?=
 =?us-ascii?Q?QiJND6FPmUT3cuuk3VamrZaTJNJSlSeuyUKoo/ptHeaHtfiRqL4ZgNcoYN0S?=
 =?us-ascii?Q?ze6Qhlxr7GnSpjsKUr91CeCzWJ40iiV0Fkd6M2ZYGarFRfduW0dGgikOlc+X?=
 =?us-ascii?Q?jEt/VAhucZfAQs7pDYF6Rxrh4Vy7n96Io7XNUS7wEnQ0fUQ+oomxx132NRwH?=
 =?us-ascii?Q?bpQIc4AW52BIazFbILC/HEbVrdHgPqoKI3tvZ5E9tgzGjb0iYAneij+/9P/S?=
 =?us-ascii?Q?x0TOu1mNPrQ33ugjnheizVCXNo0BnzODxjRxYtMz4s7z0ySg5UK5w6iTGnKL?=
 =?us-ascii?Q?sJA4JDb2lVuhWLd35rchI9Vb+/UCLQNRltZJRAtOsIBilfaI9sqpfAun0d4U?=
 =?us-ascii?Q?7cN95qa9CnYX5FKnLPRVnn+fSBEJHFYQVVcLij7ma7e3EHC1r+nFUK88JWAJ?=
 =?us-ascii?Q?I4qZ19/gNRMQAdnChp3GB7+cJTXj6daHY9TFVIOxKRt9SZoKmvcvyiBxeB84?=
 =?us-ascii?Q?qmJf/Nsbp22oR4oJIZRDYJsqrxRznHG/WkoPXsDpetZP3ORe/emFI49va6o7?=
 =?us-ascii?Q?IofDhXgkwmx43WK8BOWz+vnLdnJt8lfgOZhOrU4DSmubYAp5cMmdOHLaTumr?=
 =?us-ascii?Q?ig072kCrxuk8vxSFVV8bo56BMQ+ERCchx+6Cq3cxQpE4MreSj6iqNCf3676X?=
 =?us-ascii?Q?N+K/klWFOMns9KnE7yH/uQ+IqYkWnm50R+HC7n6ywU6Ysg19aUEIHaMQjwHo?=
 =?us-ascii?Q?g4GreSENb3SAhsScGs+ZQ5WnWOMeEi9dOHqOfrh6crMTd8mnmuhdrY5DAjGA?=
 =?us-ascii?Q?/cVwjsnl3MtXGvdu5GuoQ6nsVhefrv375voyblFh1bH0qINd7vQsNxPxb0Ww?=
 =?us-ascii?Q?RMayzsSab+Y1h6Um0YIkFZ+PXHZzzVgGycXntzMAiqYrQAGagDVQRk4eVW1I?=
 =?us-ascii?Q?rMvgK4Vvcj3oQeu/hdxWGAC0qyYIsYax6XxMrUxNpI/xiANTL0wVOTAWCHHP?=
 =?us-ascii?Q?9mXtud1U3ulreiBmHeRbgwFg0T5MUyYdI+J37Xqxz8Izo+M10S3f/pYeLuPl?=
 =?us-ascii?Q?cTgKHzESXWxAQ2YkhifPZvKrxeWvch/yK7dsmeYjRPe9cDQ4rMPMlML3NiyB?=
 =?us-ascii?Q?m3FA73II+Qr/gwQNGy5IBNl6mYyeZIW9uE4MWrqWywlm7EJztVqa4PWsWgvP?=
 =?us-ascii?Q?G2YY9JXF2dobtCbKAqJy0go0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1782f0ae-1513-4d7c-638f-08d9670ab420
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 14:23:12.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOD2wpH2wVnu5n7/tcqH92gKBSjCu9XH5n1ml9ULdMROe1B6z7IFaZ4Xf1KVPf8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The first three items are significant for rc and the rest is error
flow fixes and other minor things.

Thanks,
Jason

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to cc4f596cf85e97ca6606e1bd10b3b9851ef52ddf:

  RDMA/rxe: Zero out index member of struct rxe_queue (2021-08-20 15:48:58 -0300)

----------------------------------------------------------------
RDMA v5.14 third rc Pull Request

Several small fixes, the first three are significant:

- mlx5 crash unloading drivers with a rare HW config

- Missing userspace reporting for the new dmabuf objects

- Random rxe failure due to missing memory zeroing

- Static checker/etc reports: missing spin lock init, null pointer deref on
  error,  extra unlock on error path, memory allocation under spinlock,
  missing IRQ vector cleanup

- kconfig typo in the new irdma driver

----------------------------------------------------------------
Bob Pearson (1):
      RDMA/rxe: Fix memory allocation while in a spin lock

Dinghao Liu (1):
      RDMA/bnxt_re: Remove unpaired rtnl unlock in bnxt_re_dev_init()

Gal Pressman (2):
      RDMA/uverbs: Track dmabuf memory regions
      RDMA/efa: Free IRQ vectors on error flow

Lukas Bulwahn (1):
      RDMA/irdma: Use correct kconfig symbol for AUXILIARY_BUS

Maor Gottlieb (1):
      RDMA/mlx5: Fix crash when unbind multiport slave

Naresh Kumar PBS (1):
      RDMA/bnxt_re: Add missing spin lock initialization

Tuo Li (1):
      IB/hfi1: Fix possible null-pointer dereference in _extend_sdma_tx_descs()

Xiao Yang (1):
      RDMA/rxe: Zero out index member of struct rxe_queue

 drivers/infiniband/core/uverbs_std_types_mr.c | 3 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 1 +
 drivers/infiniband/hw/bnxt_re/main.c          | 1 -
 drivers/infiniband/hw/efa/efa_main.c          | 1 +
 drivers/infiniband/hw/hfi1/sdma.c             | 9 ++++-----
 drivers/infiniband/hw/irdma/Kconfig           | 2 +-
 drivers/infiniband/hw/mlx5/main.c             | 3 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c         | 2 +-
 drivers/infiniband/sw/rxe/rxe_queue.c         | 2 +-
 9 files changed, 14 insertions(+), 10 deletions(-)

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmElAMwACgkQOG33FX4g
mxpkfw/7BSFUTo+AJ7UB4sdSbXZC4ylFr9rBrHpbCGB3pVy/grpQNyFNIPW1CYC9
t4v6cPOEviwBdHX5WLrtdof8ES37RkBM75X6JPZifHCKLy4MZuh8mKWusoHhknb7
jB0kOhH5ac42YSH+xMnUggwTdfvm01RRkpGXbVLVZ0mKWjmUWOBcEcZeHqIWbdVp
KIwrr/bUBYq5A916t8ajwV8Nts3pyCUgLQbqNzjvcwdnlCL0eDun0DeQsbgECGsh
rdSQJ5Kne1dP51arHDsf4DTqciyhAHRBg9VDewwm7oTbPvnTlm0USN3gEealwpZL
+oYSxc0nNAtcerUa2YFIdapb7BBdy6llNZqVrKvef4KbVG9Yyy5sYZ5x8fct3QIc
kYdPgQkfghX5jFv5/icQnJa9bt15Pucu7hKd7Hzl+buPb8CTCTHczPuGceCNHMLB
f4MkuXGQ2D0VP3cD1Rq1aCFJFlwMjP6Vqpszs6zajb43W51M7Ngx9hXl5ykAxoPH
tdIgqWl2DW/8xEE6nYudo2yqWbEbtGwI3QcNmXvQTxU25LfS+6zujoV+EFeyiqrH
oQcd5FDrhmoEypT1KJwmdk92lIIoNm+cio2hYJU+cy+DAbxSZAi6HYw5xlJyPqnd
9lZ2NfM/zkoCaJ3C+FKcGf+kmfiLNOJxrjek2MDD57xL0VWPHNI=
=8LFg
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
