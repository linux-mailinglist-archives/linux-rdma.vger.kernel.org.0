Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A881251DCBE
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443312AbiEFQFj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443311AbiEFQFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 12:05:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE269CCB;
        Fri,  6 May 2022 09:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT3ZBZYNq4kCVh94y+yilizC1vRfzKttbEr+lGH/TE26QmuLZZEwvOvjygFN9zUgBUXRIF7zExyh6CI1/eNJiOgQLOMxquzyxlixZHKJJ+4cFAMBxrZJyZTXFirz8pw3AQ+zPd3nVzRYJYHZo6QfNTJj+tHYLr81I18H1c4CciZjqTBqmfhM0Sqz+Bj14G2Su1Z4txxyEJJstKhOrYGp6BoHuIltSD1/yXHCGqDl3NHucDENMMfqf/GlcGi0s8SON3dsKd4qSKNMChj+XZMZ3Q+CRREG1fncP+tEeYuQC34y+dhJMskP9lNjQ70lWEydjH5fGWbmc31SGRuljbgFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABKlwoDNfGL7SO9zoH+Z6rxhhunkENDfaOKcO2QyVMc=;
 b=EQf4KLMis+Lw6QIMEmNm0jmPtVC3LWZmtaf88LI+dF/8t0P8ZAJBJpm447e+CIEzNNecPSQ1tibZs5vttCP4qFAergC4ih4gkSDA0nt1E//rin6jZhDiKK8hE+/XEXBf0q4wYX1GG7V1x8AJ6ikmdRep2Il3OssBoxgFYmNw7GZUyzSxqMKONnzLcyeQ1F8IWtar6q4CATRHcC5Umyw4TwdRGkcQG57ylMtwJCY1BVHwL4CPLlDiwT90GHWOqybXxcRHWbXXQLVS02sv7BT0NQIjSVOaEP9GqqcEuUDjvOlU/xqsR09Gm75jaBMcKmROSnwNFVNxTUji4qmiAvAhew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABKlwoDNfGL7SO9zoH+Z6rxhhunkENDfaOKcO2QyVMc=;
 b=kYF0KQcUGXr3s2p8/bZ3Ckhw88BZOn5/haC2jJnTg4x8CHuWsJHF0LqHyi2c073W3LO+yQtWTq1WIXFYCfsACJNa+pzsR0NMUufeurzRHotle5mzilRt6QL93OskEODYXPZmGtXcWvK8r3MiuawLzM5ToDrBJaMWAp7qXKrrGzQdDKFBcLvA+Ux92VQhOnxGGucGuhuA2xGC0FSvE3coWW6E0SGfd/84PqDNs3Ot1FKlfDnEuODECbSvTOfH9N1gZRhFFzb4TCL7L6tqXyJfSxNeQMQByCN6BXkX7yVjznLLgEAgwVt76lPlrG2lr9SeUZi5nIhC6PSabgY4srObcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 16:01:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 16:01:52 +0000
Date:   Fri, 6 May 2022 13:01:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220506160151.GA596656@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fad01df-d448-4962-b376-08da2f79bc48
X-MS-TrafficTypeDiagnostic: CH0PR12MB5250:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5250919560399367185F2B09C2C59@CH0PR12MB5250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm/2oOyKRYYrqNigEH0oWrJWwE/jZHbdg+vLKufeeSYO0xJhJS4FV6stpcSGABJnwCGP2Q0olOn7qeafZTMW66FedxwsZ/KDgiT8xu9akJnMD6IkCx4/z+3Q0rKe8uYrzsMWY3HVnZLStZvfNv1jqgxjD6xXlTBveIDQuMNSndcNFQqerX+jEkNUiP1rRgPezRViKu1583ZQNHYThG+jhaMYXMIH5X5O8kK1W1NckOvmpRBQKvTj8tlrNPk6phhhJ5ZTUqkZPHy04DH2eL5J8BhbRHKBYsliPStF7Ry4ICbHZI1j/PhtRzJCUU7BrJI9KKnurYO6xqzIwFUM26Wnvv2U3E+6DOHKfZ8TEAfBgO+2k+swJUhlhiZE+2YkC6F71i2baTTBbEPt1uKWRqiBLCiMJvlh6A9EBvDDPvZAj5nVAznOM8AWrq7q09jviTQIVe8wRcKpXV/TKRKbFP6r7e1rlhw15LCUqLmz7BPHNdrJN/s0I15DtyWFobiZIRD3yAbettSgvJBF5ADnMZesHgy8CcxDWQ4yCXxJnm4RxMmGJJYovDHwDKPq+UrtwWpEzrr6ajhNkiCreo7RN1RtIUARgWHneeJU9to9rl0OcOmb9thIy/Ppj1IDjtxrvhhPahJO3k4Lb3DNrL7hn+AmXNrYiQ+UNlYN0zJuSX+w2EQLxBwtfNGwsZxhhc10cnAyqRA2g9iIPmvJlLM2YTJGtXNWqWwARfypp0c6EXVgQXsubxkQ36+8K12kvgqJynZP+f9e/Tko9uAcQnxeAAwTVas9Xdt9F5DUJCBqLW+2dx0Td3RqqmRH8gCiFTuXaixX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(107886003)(26005)(1076003)(508600001)(83380400001)(66946007)(6512007)(4326008)(66476007)(8676002)(8936002)(6506007)(44144004)(21480400003)(5660300002)(316002)(6916009)(2906002)(186003)(86362001)(2616005)(33656002)(6486002)(966005)(66556008)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nC+ATjJA8zpuYYAPlwnEbnI31so1NoeHghgroiyTVWMI6pqc8+X29eqcRVFh?=
 =?us-ascii?Q?kfQJq2ke4BB23d9ZG04SG/WKWoy6Uz+ZVpLp4giO5LkJc8mpA+gWiorbbuWs?=
 =?us-ascii?Q?Kg5aae0UMBiV81UTaTzDxhLaAyjZBtmbPY+wYazIBqtGEBy93ptQk1cE3bgQ?=
 =?us-ascii?Q?bRJk1J0nSSSbpPJQCZtkqXiuUFEQpbfQvOb3tpULjY+WakdqIMgmHJreKUwB?=
 =?us-ascii?Q?Nr9w8nclMqNkW4SH92V5GU60+1TNnSb2MV2QuP1uVn1m/skq2JTK2zHBF4uq?=
 =?us-ascii?Q?s01mQ8aAEZJIa3kYQPF+VytuvGpC44izxRMko1lwlkqlRJxmuVq33idFiQFS?=
 =?us-ascii?Q?3dGvQqRA05+/O9yC60LF7BYFtXvv2l2HhfysCzQ8wyJF38/1NCpdVgspE7Xf?=
 =?us-ascii?Q?4kA6JnfTKUIJDb9eMqTWiH+fgzoaLIA4NJvwzFtmBnGpq1Lk06gEXLfS/7Zm?=
 =?us-ascii?Q?6yA+JgzW75YtMmXd8E6t2am4OoHvzwRID3tB3FyPYnbPMV70p2/OgGzoNvyw?=
 =?us-ascii?Q?/yP/hjFq+rvK0aC01gVfOQXSTC3/B6TRd/QVLLbftIEx+aeiGWQILpkuCOVN?=
 =?us-ascii?Q?gu6AFK3s0AvAiUFZdeYJqHr9aAoe34CjzgEKzokHeouE+VUmXFlpIx7B0dQ3?=
 =?us-ascii?Q?Xn5nxZKlZvAmk3gzEkEmGToJKQtdgQcjMPCw+tLAypCe3QRmy6wXmOapzjb9?=
 =?us-ascii?Q?nA5cbsSQrCRbWo7JuIU2ES+dR6hlOKwUkNqUATv86KdFzNdWk5z/aBetFDrv?=
 =?us-ascii?Q?Hsqmw08U8looyXv/fbF6mxTL/7fJEVbTfA8lfNgNC6+wQJo6WlXab2DvBkln?=
 =?us-ascii?Q?51xJR7lO4JksOgwM8CMlHgtzYUb+LHzBkiDIsZmF8b2V0qxDKx8EyHNnmzDV?=
 =?us-ascii?Q?XN8Np8XEkSa4AhoWFrhOXjmdISvzrrP2CX5MaRArljd804Ug9PsSL/We/g1a?=
 =?us-ascii?Q?JNfGsHLmeIadouCucfVOBOlasr9Do0uumK/5fdJW6nwvXjJOSO3oadNwtDvu?=
 =?us-ascii?Q?xswhdIU4y2CFKowMlCGZ1+C3k6LMG3wOq3AfJI93mlHSWKxsxDiA59/wD+eT?=
 =?us-ascii?Q?d9Lj0+BHgE+CJay7fzCEVquZ/FDj1fsbqvM85ne/KbfnFaHOZC2X+fBNivWe?=
 =?us-ascii?Q?g6OY6ubSb9tQ7fRpHs3hh1+WXqYdItydiLptfnICQPHPlsyT/NIWPCGIS7Ma?=
 =?us-ascii?Q?RieuZnPKkZ8SZ+qkZAK27ejKLfCHSm0qMmRqfnqCPFbnHo5iPlBd7JJQ2e1/?=
 =?us-ascii?Q?s7FuOnSDviFCbh1WhWsMWaPI/shXmzq1KeA0pIesA9HfW5wC8dZ8BB2KHkCI?=
 =?us-ascii?Q?ILXL5hyWoOXx4837cmB7JM5kaZVFbUmWvXE9H+YzgNj5T9fG7sXW6oCjjzbA?=
 =?us-ascii?Q?ZX7qw+FmqnZ8vIpghck5Lwld32wYFD1SWYb3cgA42vyRCJfu6rmhl2poVdFL?=
 =?us-ascii?Q?VM0aLOiLui3zqlyMqAY5JM0+YoTuLlEjrEyLP0mQD2baj5DAW0QTe3F4CyBg?=
 =?us-ascii?Q?hwg0biXy5z3XIofC1i5JwnKSzk7L+czvRA6xzKRRP5AH0DgdJUgTPGHkD7Xr?=
 =?us-ascii?Q?yFLpLYw4X7CaOYkdTj3aUwjX4v6fWk39veQr5KGZ6qWhHGqRm4Z7nk4v8qpe?=
 =?us-ascii?Q?ac6bfFtfjRUy+9J5+/wlwVOETNcH/appOsweL+alIwOYbvXZcKFRqIu5mO6S?=
 =?us-ascii?Q?kb3m0BwvnIEP2l2HKNbapttqQWQ0WbpSqdTFpB/ta2y+GyzkPhCLrLGeSKzz?=
 =?us-ascii?Q?dKFwz17Nrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad01df-d448-4962-b376-08da2f79bc48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 16:01:52.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV+KTi9VhQ+mjeKOsyv6C/iQBeVRm4tjYeLi5aXe7JV7THix7FHCxJuRZ2T1AGgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small update, still some rxe bugs that need fixing, but that is normal
for rxe.

Also, I replaced my Yubikey with a newer one that can do the smaller
edwards curves and so have a generated a new pgp subkey. I signed the
tag with the new key and this message with the old. It should be on
the keyservers now, but if you have trouble it is in the kernel.org
repo:

https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/A5F46BDD553C74FA.asc

Thanks,
Jason

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to bfdc0edd11f9501b891a069b5bbd3b16731941e1:

  RDMA/rxe: Change mcg_lock to a _bh lock (2022-05-04 21:29:25 -0300)

----------------------------------------------------------------
v5.18 second rc pull request

A few recent regressions in rxe's multicast code, and some old driver
bugs:

- Error case unwind bug in rxe for rkeys

- Dot not call netdev functions under a spinlock in rxe multicast code

- Use the proper BH lock type in rxe multicast code

- Fix idrma deadlock and crash

- Add a missing flush to drain irdma QPs when in error

- Fix high userspace latency in irdma during destroy due to
  synchronize_rcu()

- Rare race in siw MPA processing

----------------------------------------------------------------
Bob Pearson (4):
      RDMA/rxe: Fix "Replace mr by rkey in responder resources"
      RDMA/rxe: Recheck the MR in when generating a READ reply
      RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock
      RDMA/rxe: Change mcg_lock to a _bh lock

Cheng Xu (1):
      RDMA/siw: Fix a condition race issue in MPA request processing

Duoming Zhou (1):
      RDMA/irdma: Fix deadlock in irdma_cleanup_cm_core()

Mustafa Ismail (1):
      RDMA/irdma: Fix possible crash due to NULL netdev in notifier

Shiraz Saleem (1):
      RDMA/irdma: Reduce iWARP QP destroy time

Tatyana Nikolova (1):
      RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state

 drivers/infiniband/hw/irdma/cm.c      | 33 ++++--------
 drivers/infiniband/hw/irdma/utils.c   | 21 ++++----
 drivers/infiniband/hw/irdma/verbs.c   |  4 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 95 ++++++++++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 35 +++++++++----
 drivers/infiniband/sw/siw/siw_cm.c    |  7 +--
 6 files changed, 92 insertions(+), 103 deletions(-)

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmJ1RmgACgkQOG33FX4g
mxqgQxAAnO1CVmoZdEYygfmb48SNs60x7Eq29z6pM4XWxSXx7x5AbtEr+GBzRTX2
dBoSEEeC8sW7KUmmcLOLM7lFmjkLD0bjC/EthmamKr9NEK7jqB5LzU01cqP5a+zh
4Y9nCVDZhEoxUh5WeQT4pkZpgp3hHWXkaD1zZDoih1CSAIKPYAtFlZXyoD46r3rc
yzDWQKKeOZ0TX19+M2SEW5qoR7WR79lsvVeIAThe7aNmihIGEaisJaUEh+lpbL6X
oMyoj5HhPMyVmxh4a8Hd/VWWyApdIa7TUDCev1D8CvWfKZbd15XY9Q3ElNMlOErq
Qg6ChsvT7i5gy9ybyqAd9ypq+HW+JRmFVY1bcgpBbJ8qvSyMjj/69hghWEcfuf2r
mrryP/ZlNdbF4HV6UBaj7hKAIGGQ4lWtcHmollfnKmBQUbyLcVg6jVhYx0xfebxO
AIPsAv+syKlxamJCfd1AuqSwuyzbRRCh9MG5JB61jEbO9hGMB7vyvM2krKv9Km1k
aqMBG23FzTqk5fuZzmB/EV2XmCjPkZPn+gsyLtFlclJwTN5R1PF49jRfihPMcHSS
oShLkGZSP3jTm8sDM5RS9hKXFty2R+ikqrHtgmzhuxBtnwTll8OS9YPXvXqGrEWG
wnG7RFqBkNxc9OTVb869w9c65mBZm8fFgALMH+Aozg5U9qp9gII=
=Cmfj
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
