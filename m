Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF0282756
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJCXUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14605 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgJCXUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907390002>; Sat, 03 Oct 2020 16:20:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:15 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/zxZo6PTrJf2QfaGMbwGHmZbx1LRfIdKW/NPWgPAbYrMTDl19mCEMfjxQwHnc3vSggjOdVkTDnDHuirCc81QZikTBiL4ynJoN18iqqhGLluWzb04Xm3tnRYM1loLojH1Au9pwYSL56sx+1t8pMZBw0SxLsvS4HFL9B0nGZFJXM8v9qxi9LerkgYJTY8Urindp3uT75dOaTp+m/ia4kz1SVsAEknghCGp/XoUmq4/NPvDHeMs8wx+9WPoM23QZJ7z3S028KkDcLLi3od8lhFxNawTEoC2xXgeBnedENe16E6dcq6D9qo/kPYOII2xXpzpQk65vp2ItUDdn6hMTBaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbP0YHRZ/8UZYmxfvTdU0eDarphJ4dKIWpX+C9AcnTA=;
 b=VwJTsp7ag78gjJ7V8cbQQH6PfXYjvmOJcEwkqL88YFxEShCgjYB/hIRR5gPAaO7P/R3u4cmgFtZ0KiE7iOnZzbJ7uvjH+szhx2MZrObAwk61IVrUnHm9KVh1u6qDWHU0l/8NIljrE7RGv46lhNjARpjlvUITL/0Rn+sfWdi+ARe2mz5icgSFGpvhO4ypL8kHt4JlXKeC5DBDSADOt/necF8dvUkJxMK97ST3vBIIU3kyI6bzwEateMZvn6uWKot0nlo1wnqdVHZh6bS/nlx5yqSx+rvxGmu/cTUptfYG4uxVSIBD1Gk5ORDiyLynssUxD0b+wkwJ3VdVDD0pGCdrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 00/11] Reduce uverbs_cmd_mask and remove uverbs_ex_cmd_mask
Date:   Sat, 3 Oct 2020 20:20:00 -0300
Message-ID: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0011.namprd15.prod.outlook.com (2603:10b6:208:1b4::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 23:20:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075cB-Ef; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767225; bh=5R3gvCDkJDrDWK1CF6qhTg3l+pV7xbpWUKJ+fo1OxtE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=EE/unHDxi/g/L2Iks9BDoGlolv5Vis5q+msgw8fpUhgp9TDUrrI9n8y13eNchnGIq
         uaRoLJTy5PEwc07bUpF+WliaZo3HNf5HbEkaCxw3gZNrVPm3pfaiIkf+gyAdQS7tdd
         NqzJTInIbQYL889gQtZU6t9XFC0PrXiM9FPNVytn2h2SnMWzMLzqoChu19TziS121z
         8rFxHZJucqwLlR8dgzz/0+gn2MdbXdGyo9twtuFY+aofUSrt4C2M0yMxtC19GXVXZG
         BQf4NmU5Un+zC62XmxEoA7HzvzEOV1Y591qIDtzoe1Kza3w/fXNysfa4GqozjnfF/m
         4ygmgNzfpyGXA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These have become increasingly redundant as the uverbs core layer has got
better at not invoking drivers in situations they are not supporting.

The remaining uses are only in rxe and rvt for kernel datapath commands
these drivers expose to userspace.

There are many, many weird and wrong things in the drivers related to
these masks. This closes a number of troublesome cases.

Jason Gunthorpe (11):
  RDMA/cxgb4: Remove MW support
  RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
  RDMA: Remove elements in uverbs_cmd_mask that all drivers set
  RDMA: Move more uverbs_cmd_mask settings to the core
  RDMA: Check srq_type during create_srq
  RDMA: Check attr_mask during modify_qp
  RDMA: Check flags during create_cq
  RDMA: Check create_flags during create_qp
  RDMA/core Remove uverbs_ex_cmd_mask
  RDMA: Remove uverbs cmds from drivers that don't use them
  RDMA: Remove AH from uverbs_cmd_mask

 drivers/infiniband/core/device.c              | 33 ++++++++
 drivers/infiniband/core/uverbs_cmd.c          | 26 +++---
 drivers/infiniband/core/uverbs_uapi.c         |  5 +-
 drivers/infiniband/core/verbs.c               |  5 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 10 ++-
 drivers/infiniband/hw/bnxt_re/main.c          | 30 +------
 drivers/infiniband/hw/cxgb4/cq.c              |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 -
 drivers/infiniband/hw/cxgb4/mem.c             | 84 -------------------
 drivers/infiniband/hw/cxgb4/provider.c        | 24 ------
 drivers/infiniband/hw/cxgb4/qp.c              |  8 +-
 drivers/infiniband/hw/efa/efa_main.c          | 22 +----
 drivers/infiniband/hw/efa/efa_verbs.c         |  6 ++
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  3 +
 drivers/infiniband/hw/hns/hns_roce_main.c     | 35 +-------
 drivers/infiniband/hw/hns/hns_roce_qp.c       | 14 +---
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  4 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     | 29 ++-----
 drivers/infiniband/hw/mlx4/main.c             | 52 +-----------
 drivers/infiniband/hw/mlx4/qp.c               |  5 +-
 drivers/infiniband/hw/mlx4/srq.c              |  4 +
 drivers/infiniband/hw/mlx5/main.c             | 55 +-----------
 drivers/infiniband/hw/mlx5/qp.c               | 10 ++-
 drivers/infiniband/hw/mlx5/srq.c              |  5 ++
 drivers/infiniband/hw/mthca/mthca_provider.c  | 28 +------
 drivers/infiniband/hw/mthca/mthca_qp.c        |  3 +
 drivers/infiniband/hw/ocrdma/ocrdma_main.c    | 38 +--------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 11 ++-
 drivers/infiniband/hw/qedr/main.c             | 29 -------
 drivers/infiniband/hw/qedr/verbs.c            | 13 +++
 drivers/infiniband/hw/usnic/usnic_ib_main.c   | 19 -----
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  7 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  3 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    | 28 -------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 +-
 drivers/infiniband/sw/rdmavt/ah.c             |  1 -
 drivers/infiniband/sw/rdmavt/cq.c             |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c             | 10 ++-
 drivers/infiniband/sw/rdmavt/vt.c             | 28 +------
 drivers/infiniband/sw/rxe/rxe_verbs.c         | 45 +++-------
 drivers/infiniband/sw/siw/siw_main.c          | 24 ------
 drivers/infiniband/sw/siw/siw_verbs.c         | 12 +++
 include/rdma/ib_verbs.h                       |  5 +-
 include/uapi/rdma/ib_user_verbs.h             | 14 ----
 47 files changed, 206 insertions(+), 606 deletions(-)

--=20
2.28.0

