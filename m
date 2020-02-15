Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D821600B4
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgBOVcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 16:32:17 -0500
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:6102
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgBOVcQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Feb 2020 16:32:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm1TUUpceH+yH1ibfuM7g6mWa+j9KPEp7peeApG+NF5+ffW4bo1sGp54wuPDDycrosHzIWaaHgyLi+RpT+is6kFvQDFIV3HvT1qj52asUhmGkpkNus45JkeutOKnork1YG61P1xjyypvZ9//mlX4dTE6UJ37qqR/4l753chv/hN2vSzlCD5r7afuSU+Yhnw8kR++O6eEMF9quDp5G5BcySzSjOd0NxjMq11HW/JzehstyQB+XZqCVQg//zaBwgpkagufMFSmLYpCBzqLwM49THhsoUxmbgzt/KOMnG6pYSb+VmomzNmz7JIgfaNHHAqxF3t6ulheObEzJ++8K8PVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+V64nj1BX5oXnPJ3XZP6m0cyD8hCQTZIU9DuoYzvBA=;
 b=W1nP6iAyTcMZbCW9RmbrerqnHoR2fvEKtaUdMZGFjrek0EJgcfWLRnOBoEY8LkbekW1VUywDdcwntVf0R9l03sH8ZlHslSxgSx2R9dQ2k7aui6G3xeVrTEi+QCR13I1pxzy2ylqvxXbOECHe/YPv6+seB9HV+vXalAMcmv+uecWqjvBnhnQ813iWFOQldCfIucpzccu4LKmAxW/N2+XwdE/zYSlrOSYWj91hlVbq2b2F8uFzSYCUZ4lP2+vEnjsJDeiEPzUe7XHgbvfb02we7e5VT60CiGJjOdJvANJqMMqHK3+yIo6q/EdaBJBG7w62ispVNsjunluZY7Mf17oy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+V64nj1BX5oXnPJ3XZP6m0cyD8hCQTZIU9DuoYzvBA=;
 b=ZF7Wn3CuXoEPAiUB6klES3G25UzyViT5/AKUJNa8oaZOvX+I7TylqOlumCyicnZVTWW0Z8hx7IQa4X3JK0zDYmAOfnL7N/Zd2JuKOUDpjfczRKLJ1vT+BFRd+tIFGIyouiybNBl8vqitmvgUJyJlkFe3s7j4CM1h52lbXH6yz70=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6974.eurprd05.prod.outlook.com (20.181.33.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Sat, 15 Feb 2020 21:32:11 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.028; Sat, 15 Feb 2020
 21:32:10 +0000
Date:   Sat, 15 Feb 2020 17:32:04 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200215213204.GA16455@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR02CA0032.namprd02.prod.outlook.com (2603:10b6:208:fc::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Sat, 15 Feb 2020 21:32:10 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j352i-0004LR-7v; Sat, 15 Feb 2020 17:32:04 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f684d384-459c-4e0f-17b3-08d7b25e83da
X-MS-TrafficTypeDiagnostic: VI1PR05MB6974:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6974740D46871D1A5EFE6B69CF140@VI1PR05MB6974.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 03142412E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39850400004)(376002)(366004)(189003)(199004)(81156014)(81166006)(2906002)(9686003)(4326008)(26005)(8676002)(478600001)(86362001)(36756003)(1076003)(66556008)(8936002)(9786002)(9746002)(66476007)(186003)(5660300002)(66946007)(52116002)(44144004)(316002)(21480400003)(110136005)(33656002)(24400500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6974;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rYJOBKJCj44ENGoHl1L4AHgujFDVNGo0BPDNbyKspGsHoOv0mivDyN3WuZcjeMCD1PXfPhZnVjxfaXGoFDK0eLkR9br5Zbw192P1zZTKWVBt+VeF+ghyxeWyvCYW4/VFh8pEJWCvauux/r63zqR9uyYeyKrhPQN2LRPkfztLTiNYHw3ndb5B3eWE+qczOSXae/a1/GhZND4izMmYGQRL8ZmTkKo0a32a9grBwycqc4ztDbtm6SsivVrXEh9+mM8YjmMPZGfoBLM0ZpBP1n5mx85ipVJcAsYaC1tuAzg16D+IEea3qdfmmCQBYLCCt1ZIgR/LkBAeDEgQjVYRY8sllk8FyqY4TGWTxMO/+LuTJl2Vg3kUJgbujbztzc2CH9ISrmbT4ZSwaPoiuDb2NOyldeck1UcJ7sFSe0I4Zs4GXph6NLfePVuNTF7PgUkuH3G4V6tux/4YsXm7RY5kpzRO4kizc7a0v44FOCOnFesh6kW78Wz1wZks61O4sRzc93OG0Lc9TBJxkOiUFdC2MgW4A==
X-MS-Exchange-AntiSpam-MessageData: aWb2aHnxiyBWwSy/x6IATkFGnpFao0hkAN/Fp4eyQ5Wlp+zgV58f7rsrr1fbwSWco74kFQXrfif7ljvkn8Bx4rNGaJKYZemqS8RUWi/hTnkU77+Au9Kl7YlgZUuI3u2WkUHdQO0dzJN+tbQj347zyw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f684d384-459c-4e0f-17b3-08d7b25e83da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2020 21:32:10.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpM910z+peYpRJHZdOEx5f4hL92i4wzLLyVg+4oJySP/levGkSxl6pTtTegNg1XYCD+hM/gk7L1/0O8ZKtnWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6974
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

Not too much going on here, though there are about 4 fixes related to
stuff merged during the last merge window.

We also see the return of a syzkaller instance with access to RDMA
devices, and a few bugs detected by that squished.

Regards,
Jason

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 685eff513183d6d64a5f413531e683d23b8b198b:

  IB/mlx5: Use div64_u64 for num_var_hw_entries calculation (2020-02-14 15:21:52 -0400)

----------------------------------------------------------------
First RDMA 5.6 pull request

Various crashers and a few regression fixes for things in the 5.6 merge
window:

- Fix three crashers and a memory memory leak for HFI1

- Several bugs found by syzkaller

- A bug fix for the recent QP counters feature on older mlx5 HW

- Locking inversion in cxgb4

- Unnecessary WARN_ON in siw

- A umad crasher regression during unload, from a bug fix for something
  else

- Bugs introduced in the merge window
  * Missed list_del in uverbs file rework, core and mlx5 devx
  * Unexpected integer math truncation in the mlx5 VAR patches
  * Compilation bug fix for the VAR patches on 32 bit

----------------------------------------------------------------
Avihai Horon (1):
      RDMA/core: Fix invalid memory access in spec_filter_size

Jason Gunthorpe (1):
      IB/mlx5: Use div64_u64 for num_var_hw_entries calculation

Kaike Wan (2):
      IB/hfi1: Acquire lock to release TID entries when user file is closed
      IB/rdmavt: Reset all QPs when the device is shut down

Kamal Heib (1):
      RDMA/hfi1: Fix memory leak in _dev_comp_vect_mappings_create

Krishnamraju Eraparaju (2):
      RDMA/iw_cxgb4: initiate CLOSE when entering TERM
      RDMA/siw: Remove unwanted WARN_ON in siw_cm_llp_data_ready()

Leon Romanovsky (2):
      RDMA/mlx5: Prevent overflow in mmap offset calculations
      RDMA/core: Fix protection fault in get_pkey_idx_qp_list

Mark Zhang (1):
      IB/mlx5: Return failure when rts2rts_qp_counters_set_id is not supported

Michael Guralnik (1):
      RDMA/core: Add missing list deletion on freeing event queue

Mike Marciniszyn (1):
      IB/hfi1: Close window for pq and request coliding

Yishai Hadas (1):
      RDMA/mlx5: Fix async events cleanup flows

Yonatan Cohen (1):
      IB/umad: Fix kernel crash while unloading ib_umad

Zhu Yanjun (1):
      RDMA/rxe: Fix soft lockup problem due to using tasklets in softirq

 drivers/infiniband/core/security.c         | 24 ++++-----
 drivers/infiniband/core/user_mad.c         |  5 +-
 drivers/infiniband/core/uverbs_cmd.c       | 15 +++---
 drivers/infiniband/core/uverbs_std_types.c |  1 +
 drivers/infiniband/hw/cxgb4/cm.c           |  4 ++
 drivers/infiniband/hw/cxgb4/qp.c           |  4 +-
 drivers/infiniband/hw/hfi1/affinity.c      |  2 +
 drivers/infiniband/hw/hfi1/file_ops.c      | 52 +++++++++++-------
 drivers/infiniband/hw/hfi1/hfi.h           |  5 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c  |  5 +-
 drivers/infiniband/hw/hfi1/user_sdma.c     | 17 ++++--
 drivers/infiniband/hw/mlx5/devx.c          | 51 ++++++++++--------
 drivers/infiniband/hw/mlx5/main.c          |  6 +--
 drivers/infiniband/hw/mlx5/qp.c            |  9 ++--
 drivers/infiniband/sw/rdmavt/qp.c          | 84 ++++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_comp.c       |  8 +--
 drivers/infiniband/sw/siw/siw_cm.c         |  5 +-
 17 files changed, 172 insertions(+), 125 deletions(-)

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl5IY08ACgkQOG33FX4g
mxqwyg/+OUch4WevGureBt2cOdRKWPYgnQqqcnP1Hhqqm45LB/l40uw3t34nFU8Y
SgFv8CpV0FXMS2jg7pyfzZsWCKurllx7EPJSt4ppGHaNZJTEXTIjndIgJHFbVRII
/wRghWDZJfBWUDvUNedgfLaL33MV26wsv4xyVIwSPmw//aj+HcRspup0YSj/ltox
KctXsoZmUD9cqHdHL+q8OSjW/s2LdkNAnAtqVcqSVtV96YCBapQTSqZrJ6c39tkp
DGb/bvvl0jfEm/Udb2tAZ2KraO7BP8nx4h8IUczvW8FEQFzo7UJu1XbPWbBCED4b
Zh8G47qvsmp/oZ6u9r5h4ru1scy+LIqo8m2PR7SDnxF/ShyFmAiDibM+786S//wN
VXNEhYPHviBQbHP8LH12lC1AROn1a4bA21bYmk0qyFtWBCkc4gJ5Ye3R6jkH+H9+
FCtWwa9kEuEbPeFu5Qj59AK2DSICJXjO7akVUw/QE9tZ4Vdc1qT6AJIjPtVl+0u/
fWrolP92rlghU1RYaRYhp4AUtAe9MzusKoC/F/RzpgbMUVhYbd37nCQWbC5gn8B0
1tZyhOOKtHcvtstRE/+pGGfEhCx48Ho5Dz8MjYMKbXeWFuDTlSJjTRozgBq6pPMZ
Yo8jDjJ65sUXkdSFuD1rwgl0K9HwynB8/lKJP+35Qwu0Ov3MvFc=
=rNG6
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
