Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E152B526A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgKPUXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:8471 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbgKPUXV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb60001>; Tue, 17 Nov 2020 04:23:18 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRUdL3/2h49AqsLg/0AcCLC4O/a0CvQ4R9+hJxJxrKNi2NCVqz9nUJ7lrjntmFdaY4gFx5vLGnnsCq5MlBc+Ig+S1E7Yon+7PXFc4ifiCt2IOVyS4gK+Jvl4BoqVTWWaIfbiueoDt7du+LGerw042mB0sVS4bWhnFt0Yszgyo1RQ5vR7vqBpjIgTXBTUj/UUAnDC6qDiU4mxWuitNZVAJ+s8BAsWF+oipgVQMJQhEu0LITw260Ti4ouylCrZZjT9Le0L5uvmSMwlc/KyZ4gpIOJ5CM/eiWp6mo9sAdv/5y/mV+h0ft1lSwPY9wWK8jrB4YV/9usLnIsT6uTWEjKkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPtNzq6UtRoWTVD8rG90Hd7cFb333DcDG3yVUaxq0fU=;
 b=NUtgKc05MnsTU8vu3btu1pzK8Rkbx3TtTdjGIzkNKVE3gC9OPuJ7myQpXMvVtwUaJy71hLZHiWsdezhF3NWsPsFXT8Q+KYmIOMj1WD/zmZs+ppaZiK4J9KhHbNqrYjnwY4CD66KN8I6e1UXbr3sjJsBsKSkl6O8kOao73uiN9OMOABJ4pNvYrCiHnZbBDIBbPk0RNY9OVgzzsWTFlsM/U7FJao3IEKOY1HkbjOt7mQ7qqZBSv9F/GVHo12KbpP/lC2jIrCBULy28/tjLkPOMF9ZVrruvg0885Bw9+++XZ7JgRvLlrLDwemk82eNRJ90I6ddmJZrS6J+yh32P18VdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
CC:     Gal Pressman <galpress@amazon.com>
Subject: [PATCH 0/9] Simplify query_device() in libibverbs
Date:   Mon, 16 Nov 2020 16:23:01 -0400
Message-ID: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l7j-MO; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558198; bh=pU+sBqw47QhehseFcVqlhu0Q4mZI0LnqkxKZtA0+2/k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=pINAdJuM4svBO+qXwhmr3lkNWKYiarzHELC60mk/sJUVKdlX/M/njryLaA65Y7KQc
         qTs/p3huNx9NnGufhFR/6c1ZnrQGNa/NuDLLiR/aSpSTSf1aXN//CUoL6P/weDsPSa
         l48XOvwiJZSaGSA7OV+ZEHyd3WDY9cIWESPOmbuuS1iyRQ0/FRv3ZGwIWJtnZ/HyaQ
         xnKehBlvdGfJHodyVk2wzy1k6uj2ONTclZ8b2UC0QvRX4V9KNRUH3+hxCv3b9Ec5wC
         FqqXMc1StLefqbk7RU7pBHyKoGSlluhRLhTFwsYCLYczeTJYjkVXggNP+Hfw1x2JjT
         5WASyjud9ShHA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that that kernel implements query_device_ex for every driver we should
do the same in userspace. Have providers implement only query_device_ex()
and feed query_device() down the same path. This eliminates some
duplicated code in the providers and allows every provider to fully
support query_device_ex with any new kernel features added.

This is a PR:

https://github.com/linux-rdma/rdma-core/pull/890

Jason Gunthorpe (9):
  verbs: Simplify query_device_ex
  verbs: Add ibv_cmd_query_device_any()
  mlx5: Move context initialization out of mlx5_query_device_ex()
  efa: Move the context intialization out of efa_query_device_ex()
  mlx4: Move the context intialization out of mlx4_query_device_ex()
  providers: Remove normal query_device() from providers that have _ex
  providers: Convert all providers to implement query_device_ex
  verbs: Remove dead code
  verbs: Delete query_device() internal support

 libibverbs/cmd.c                   | 212 -----------------------------
 libibverbs/cmd_device.c            | 155 +++++++++++++++++++++
 libibverbs/device.c                |   1 +
 libibverbs/driver.h                |  19 +--
 libibverbs/dummy_ops.c             |  21 +--
 libibverbs/libibverbs.map.in       |   2 +-
 libibverbs/verbs.c                 |   5 +-
 libibverbs/verbs.h                 |   3 +-
 providers/bnxt_re/main.c           |   2 +-
 providers/bnxt_re/verbs.c          |  30 ++--
 providers/bnxt_re/verbs.h          |   5 +-
 providers/cxgb4/dev.c              |  10 +-
 providers/cxgb4/libcxgb4.h         |   3 +-
 providers/cxgb4/verbs.c            |  14 +-
 providers/efa/efa.c                |  15 +-
 providers/efa/verbs.c              |  82 ++++++-----
 providers/efa/verbs.h              |   2 +-
 providers/hfi1verbs/hfiverbs.c     |   2 +-
 providers/hfi1verbs/hfiverbs.h     |   5 +-
 providers/hfi1verbs/verbs.c        |  13 +-
 providers/hns/hns_roce_u.c         |   8 +-
 providers/hns/hns_roce_u.h         |   3 +-
 providers/hns/hns_roce_u_verbs.c   |  15 +-
 providers/i40iw/i40iw_umain.c      |   2 +-
 providers/i40iw/i40iw_umain.h      |   4 +-
 providers/i40iw/i40iw_uverbs.c     |  18 ++-
 providers/ipathverbs/ipathverbs.c  |   2 +-
 providers/ipathverbs/ipathverbs.h  |   5 +-
 providers/ipathverbs/verbs.c       |  13 +-
 providers/mlx4/mlx4.c              |  34 +----
 providers/mlx4/mlx4.h              |   3 +-
 providers/mlx4/verbs.c             |  86 +++++++-----
 providers/mlx5/mlx5.c              |  11 +-
 providers/mlx5/mlx5.h              |   3 +-
 providers/mlx5/verbs.c             | 129 +++++++++---------
 providers/mthca/mthca.c            |   2 +-
 providers/mthca/mthca.h            |   3 +-
 providers/mthca/verbs.c            |  13 +-
 providers/ocrdma/ocrdma_main.c     |   2 +-
 providers/ocrdma/ocrdma_main.h     |   4 +-
 providers/ocrdma/ocrdma_verbs.c    |  20 +--
 providers/qedr/qelr_main.c         |   2 +-
 providers/qedr/qelr_verbs.c        |  21 +--
 providers/qedr/qelr_verbs.h        |   3 +-
 providers/rxe/rxe.c                |  15 +-
 providers/siw/siw.c                |  20 +--
 providers/vmw_pvrdma/pvrdma.h      |   3 +-
 providers/vmw_pvrdma/pvrdma_main.c |   2 +-
 providers/vmw_pvrdma/verbs.c       |  13 +-
 util/util.h                        |   3 +
 50 files changed, 511 insertions(+), 552 deletions(-)

--=20
2.29.2

