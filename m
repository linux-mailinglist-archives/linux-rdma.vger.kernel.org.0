Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D814C5073
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiBYVRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 16:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiBYVRG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 16:17:06 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091571D3053;
        Fri, 25 Feb 2022 13:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3xv7ILzB6uaJq6bU1Tv7uzsISMC0lPy0b+D/Krp0fTFEE3ln1x1raj4+VHcbbVCy5MYBbeSZS4Z9nC5z6DTuh1BFtR+DfCTCYqtQT/ZAdHHdRyX0+e3uD5rIXa16yoNxssoLyN8Y7UwP87wz9id1uknxIAuH2UmNtPTP0XAhf/d9MzL+kINC4djsVAhvdolXvuQ/buNHZh5cwaBBhcg7pgei6S6/77+AB519xp//FJKR0W01ak4TMraJzYSUGkechIJSHZEeFohX3sM/VmV5kCqHqmAiURO81nG+GZYW61Yr51A/CIOo9+Vz8FhtCAxaa3CLdgVoIZup9P/Kp3gWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxpB4JbT0UiS4Ksh56xPuDOl6qCtHfOyE6Q2L1swegA=;
 b=KDKHmrv6FqHiQEHlV9kbMITOwiX2q4CQvPvZ5hmWnD0ZJ+RLE3ljQhNKhuA/KdA0t89oeW3g4t3tEBOfavFkPa5Mny4KnFBsrphbKIiD+SjRfz119cnom9PU4v0V2UYvJ4/u6hem56BnctEIyMa8HILdXyXpOEFpDB7x23xFRVVlKfh2w2GiAaple+0smGuxIDvs7npDcIdjRA4Q/+VcxAxtr6Q/vTmEHcBNVXKCfRSyp6C5LS86IDd8GHXdps3ewELVheRbyPTibwvZ3y5I2BSW5RSiXGcb+glgJhnu3YHIoM7rTmgf/d6uHVxYik1VxoySM5PkOEDhruoV4Rbt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxpB4JbT0UiS4Ksh56xPuDOl6qCtHfOyE6Q2L1swegA=;
 b=KDGYG4p6OlfAqIBfcFL09M/DqMi9ZzdKfQbnOS2A87410gJGZygUQA8QX5S2xo4sb3rLnppqMdBjsd8zZnT+g6cFJYoNR01OOWCUD6SCB+sDofKgW10MsTCJAvbxTTSS3sNhvdBOLJ6hv9Ko+utwxTGTmRS94aZyftMJ170YKyOYiS+LZ7kkzbKWca619xhVabuQr84/iGf7Ewohhxt7qxXvcBPDRmgBRR8XflXw69fMPsFHqSA7LPyU9Y+qklFfZwiwx7C1zmKCPq8vHoJgg5ms+Z+yRUcbmKRtgkvH8l89nnkBrZOEZ8PAY97/YSWF4/PAQum1p6yvu/oZgYXG7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 21:16:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 21:16:30 +0000
Date:   Fri, 25 Feb 2022 17:16:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220225211629.GA352636@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdfcd88-d10d-4f3f-1329-08d9f8a417c0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3799560654788D10D4D4A6C4C23E9@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZDKbRYZ3sR/jDv3hfLGfc8q5qKh+F4PKSq6CR7qQJwTo/UsW5h8YZWO4zxl2DNenXiXU5Iau6nhTJBXpRkrzFvTRxoZUM+FLacQqKH7e0u6LyQ5EAHttnlUVKJtJpjJTCu0gEkKv+5nyRVXvQL69N9t1TxgULeWRJ3aWxDCMkgRYd+b4Jl43ZTm8XsDG6o/4xBB900tCciZeSoICqW8eq6KTMGDN5XMiXX5L6ORfBqDw4sXPekjrss+3X24BN8brBOm7muGcmLUTfeZKIAs2k02NEuwOsmhhkzWWECze35To/HXIQ6SsHalec8SPmEtncxsF6498aXH9sJ+Z5OfnkDwfIB7wTukovkPhrJ2fXB1WaLgDD64FExTpD0S+khEHUrLOPeSR4yMVFTLwL0gDWIxGv1iEYY2Rp2Dt3gUpfIegnVq3iysA5+XykBRf3qYGhG7zGfIVUdwvY9ieMff8wcrLTL6l3WUmRWCQVpCskvatOE/mM23pwZfKDnKAX3udLyzT7kuyfWl3kX80osGpQSzn1gVq6+nEJ3wLwIbZiON4H7j9jZkNd0/Zk4URa2jN3a/15KAwWGUTJf81gw1UFnmv5D8vXDZNb7zsZhT+Z3Y9bzmV78/DNdC+qOkiSykmkHwkJKj4sfR6KEkHwMQysLNI/KL+tVgz+ND7WNS5pP0C0nW3SyizoWesVIAE4/0y2QtKobxFxe0NxHmVWRkU7cH0IUjENH9oiKXXvL3pvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(33656002)(38100700002)(4326008)(66476007)(86362001)(8676002)(6916009)(66556008)(66946007)(5660300002)(1076003)(21480400003)(2906002)(6486002)(6506007)(44144004)(8936002)(6512007)(36756003)(2616005)(83380400001)(186003)(508600001)(26005)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLV/ujDs1o3JGPMth9UV6eBq1dGEZnwhONJEYI8u/ItaZYcHcdgmKtnS7fwY?=
 =?us-ascii?Q?s5wfbQNvpioKLyGTna/0elPHDISCSqXimTPdZ/m4h8eALMA4d664GgMo4NPL?=
 =?us-ascii?Q?17ZoWYCoxm8++DCvp/0qTqInQoQZlps0UvzbBEBgXB9Y4gbdsB5M1uQB010a?=
 =?us-ascii?Q?jTFPiPIzBzJhkWxm0W+ZX8Ieh2IKfU8TszcF6DFznwPXfvvtaViFFIrgrkve?=
 =?us-ascii?Q?QdqBs7TKCXO8M2u4o3LqZNYf43xjMP2GlwOYbZL+n6hBbTp5F6GgKUtFGZUn?=
 =?us-ascii?Q?O11lWbnRhNbBBCve1CjsvKuJPISTK9TlibDt4ZqtmPBZ2SRAMzBVCf9temBU?=
 =?us-ascii?Q?+C4hFypjNs+esNX1mnhCA17dCXhDT83jQmKsY4kCK2fEzIMzy3jMxMmXfsep?=
 =?us-ascii?Q?S3c6zvhJmwpN94OOIWdaiuDQAjAyo+mecYaLEXH5u5PCZqmsV8lsDs2pJ6Gr?=
 =?us-ascii?Q?CFumoSl0/BvZiY/HMBFg6pB9wAodcvu2eHl549XV71dXtcQkIZntdKAl9A7R?=
 =?us-ascii?Q?7H5HMshiIvn3aUdTjsw2k/deasz5W50pzNEGSUwIx0D+FJyXTXyUTIbPdYdm?=
 =?us-ascii?Q?UtJ+nIEKi31wNK8MsO+kYSXUZpDMxCgdkLsbP9+NIRbYLAjMK/gD6k6wKH+A?=
 =?us-ascii?Q?LSUD50GKnrQxqnqVvtdQfm509450lA23F681dUtBVUwDLEehE+PoVAbLxtE8?=
 =?us-ascii?Q?coIRzI6c2lmjyxVZ7niUn5DKFQqM9DYs0vPvCaabRxZCqfvioXsUMUJNUQGL?=
 =?us-ascii?Q?Z+wL4AzEF7iWQAUyky6Moc8zFLpG6rBEqK5ujGPDkTDvYEK2w/PNgN/HBDlR?=
 =?us-ascii?Q?sn+5Jo3s0gjTVIzwEEiPAaq8Mtx5EakLzd6r3UnWneRn4GHMpVnpQiRgOatE?=
 =?us-ascii?Q?4ep1EFyfwqNXqbJjyBay9MewHxwXEgDKvp9rdFDm5nskkZDurW72ShCVIB4s?=
 =?us-ascii?Q?rsrHs9o9snQQQwzs/J7qgfgU+oyz5D/aVRew8MWIyuMSKQPkS7ZZvMziwkq+?=
 =?us-ascii?Q?5z7Nj5TOyyXhsjKTth+lQTm+jVulNEyytnm9b8ZNtFdntnywtZvk4kAYzBXm?=
 =?us-ascii?Q?K6cg3LI57Convr8lOlfNa7alMx6x22WaXd2EJhqAW7JwVwum5a7GHQIVJdsI?=
 =?us-ascii?Q?BswRMAfqGy5baP8oqIeHPSppLYo2AkKIOpl6IrervzledgSv3rq+TWRAHI4q?=
 =?us-ascii?Q?8ouNhkeaDc6AfJ2smBpQG4SOxlH/ZmeuVJjR3V3SYOak952rSCkBdqYCYyQl?=
 =?us-ascii?Q?wM8WM8qoVNzlZadwwiEF/A7ivO0Lys26/PjoImTGaK3pJKolomGQxNNNr8Hf?=
 =?us-ascii?Q?H4srva0O01v2rJXv09n9sWCPlVnaOsZsDWzwEAkdOTGHJnnw/yyY034z3Rj5?=
 =?us-ascii?Q?H8PzmPjQnnbtzvBy+r0z1jnJdXEY/6SGdK0DuQ/GFW2kAWbo1z8V7bXp6gK3?=
 =?us-ascii?Q?9rxa+pWBENw7X3A8PsyPFihb2ZBOiC5LsgAHL3+9PY5jBWyYxk83CiXV24NC?=
 =?us-ascii?Q?W3dfXsoYre8zVufFHQJiElsuLgi33wjB2mC1dXAIm8t00PDK99P3XLT4m/a7?=
 =?us-ascii?Q?R6VDO9ftjKB8Oee9rwg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdfcd88-d10d-4f3f-1329-08d9f8a417c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 21:16:30.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQ5MaaBC9U938CPP6W9mqUb0ddrOFfSiQ5Qf2k+Vfqj9vTpdIwCNMc2ZmZVWokJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small rc PR, usual bug fixes, thanks

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 22e9f71072fa605cbf033158db58e0790101928d:

  RDMA/cma: Do not change route.addr.src_addr outside state checks (2022-02-25 16:46:51 -0400)

----------------------------------------------------------------
Second v5.17 rc request

- Older "does not even boot" regression in qib from July

- Bug fixes for error unwind in rtrs

- Avoid a deadlock syzkaller found in srp

- Fix another UAF syzkaller found in cma

----------------------------------------------------------------
Bart Van Assche (1):
      RDMA/ib_srp: Fix a deadlock

Jason Gunthorpe (1):
      RDMA/cma: Do not change route.addr.src_addr outside state checks

Md Haris Iqbal (2):
      RDMA/rtrs-clt: Fix possible double free in error case
      RDMA/rtrs-clt: Move free_permit from free_clt to rtrs_clt_close

Mike Marciniszyn (1):
      IB/qib: Fix duplicate sysfs directory name

 drivers/infiniband/core/cma.c          | 38 ++++++++++++++++++++-------------
 drivers/infiniband/hw/qib/qib_sysfs.c  |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 39 ++++++++++++++++++----------------
 drivers/infiniband/ulp/srp/ib_srp.c    |  6 ++++--
 4 files changed, 49 insertions(+), 36 deletions(-)

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmIZRyYACgkQOG33FX4g
mxo8bA/+J7KioNqLOS61boY+TXygmQVznPaE3u1J5dK4OskhDSCtJFdXccePyrNA
ervs+ZyqglCmolxohrTVly+bK9u/eOJYakPYkokeiKwhcSFy6LbR9xgV7CN5UPnc
wcbOslGxS+8vq/Pu2qorRR7Ll85R6pCVVeru4nfW8UFtYNDGNKjMG9fg6r7n7f5x
WPuxLZSDAxKOc8AnmX2ZeUNCpEzS7411XS/jYUzL0oWVliMnrqOup8imZxX3RnSK
9bYA7XMXP20v9uecG/LJIsOlpn5LUfat4SlXVRnkzlThPTa8dzmj9xcBe6z27nwv
j0/j7nVy0G7/z8XLdifcrwKt/diIl3dn89ZngGjEwaYhfOPqZEYK2L4DEAAfhWSj
L8qiPKXFh+1WnA1CQ5Mh88chopRdopO7nesSmWyi4k5xXsQMJv0GiBqcYPHdzRl4
c00/o/CYQWPsZlCJH4XSGvf5CbD68QTGBQxCEgPzPjv1C/uq02KdEHFYR5RIOg0J
G3y8wR1dbwJX85+Kp5IZpejVWg99BlLZJ4gLC4X69zCQysVh7WUVlBCM78g0vUpT
kXGGGWCu3K59aCtOWCE0+xWx7LE3Z9IVnghfWZ5pvStMrZFZr/oYdcg0zRWQ1oGc
D1VmJf1t+bZBHshukhWNc+4HBPWrn67F1RJMaft0J/m0EAqSi40=
=aEDe
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
