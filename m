Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE725A268
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIBAoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30694 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgIBAoQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 20:44:16 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeada0001>; Wed, 02 Sep 2020 08:44:10 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:44:10 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 01 Sep 2020 17:44:10 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:51 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1pDRc5BShlkubut4Kykm48AgMkg3xzPqTbSZMTZYpAcN5lgSOCnTIhrEm2WufWTv21FGeMWREH59s5ndo+UQazhbgOE5cXku+/sJf21+ixmm8TBlQsfcJV7vORulnU/NFQnvPpwzRAgAe1d5Jm+yP+yI5JDfkk5OXriYuKjGtoYHnshgyHpruTVz2usSJ3bfsnsRo0PmvM5f8q8xkyPXnWFsoQbDnVkF5+EdNRqxFFoS6hxmzZpu/mlXB6BwYzb8P6ioDIGReXeDb3Y3diLSzsoDMCYhEqQDek+tXBUbfxWGmxlMo3k8C64Qn4S9KVLVj32QdnD7zH8dvszejo73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojE1JJ9jn+OerZ4O5IPrtQ1gDHW5HHcRWPjNcpoBBY=;
 b=MgaKnI0RdkE9d0XGWxDxNk7uoSwsMl0LkUgU8JLkCEhVy+WhQt92KDfBtu+xPHje5qTVGAK0ribYMj7525vzv+CIyERRDeHdXlJ0oJRJkI7P0nMIKQnY/ISifyLrJ3ikyh6QJOXVaVDJt8oeFeZLzfDJQJoCkEAQ/b0DqB36jc9tRtGbx/v+glebKuECKulcs8os5I+9Oh8UzWntLtgVx4WwKRA9qf5xKxpQM+ZpfH4BMbbVNjH0E9h4/Ga0Q2j88X64qEuYuDRgsbBjQCWO1fiZlGmLPN3bBsZ+kwkDiDLGspitBwoSupsv8qJkEKTJBVBajgQSxtAf8Zv1/Ue5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        "Yishai Hadas" <yishaih@nvidia.com>
Subject: [PATCH 00/14] RDMA: Improve use of umem in DMA drivers
Date:   Tue, 1 Sep 2020 21:43:28 -0300
Message-ID: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:208:178::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:208:178::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:43:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsI-005P0p-RD; Tue, 01 Sep 2020 21:43:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9cca4c6-393f-4ac8-d28b-08d84ed940a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834679C49D8FD1F014A45FAC22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpnuIpvQmC7WOdz8BM0Dy9VaUQur6A03gfO5Rv2ZYdSh5ZzcYdPLFs581HDuqQEXaOUSOCb5sq9BT7grMx25+FhRFUXkgEU3kwFJstws6QWotvJYNASlHnW4bYGYVkbAR6ZF4LjEuzblcsnkC0gnUOCE3q0AHZYRnWp7nuC7oMD52xuAQXwivSl98Xt3CYuMSG5iesDkz1YYA5wYdqzC877G/a7skrMnTOW9oDSKnRTW9x+LOePy62vhSvzK2WvqCJ7C/qDoXnmPo81oL+gYUiffM4h86prd7gLLeUXHu7vaWwOvGFKr899zatzfJrppPOybGMkFktiJuujvbUmWBwljlBHY9NbheA6ONlZyAEEcaJy5p1W/UpT9KYWrSOA3iiout8xKp6kVUBznF7br+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(6636002)(36756003)(5660300002)(7416002)(4216001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KFW2hMRukDqJzfnMq/ZIUeYomqjD8Iw9RR6i0mPqMVV2NR1fqnWl2hrExOSKMN0NcDc3IQRd47nATtBJFWWR0dD3dGRlxCGPLl/fn7LlOrYZxhY1gOkYKgbcnZLp9idBOdtM8lFZhng263K9jdc+NvBSDMUH0U8u5Ivo4OfymBP5vJeoGsuSZuk2wbFQWXkxV14ZYq3SvJoWCkUSHTbeg1knL2vTEHNRju5AbhfU5iL51w1h6tM6Med+0Loa4kCZepJ5Q0kRLB3W77rPQ2SuGO0H3k5t9aV0Z3rYozHmfHBmOBxZ11dhNHS4w1fHAj9bOrcIgdE5hU0yYmd70OmA3N2ldxKV1W8pkO883JcNo6KlsHtSjZWl3NPDKCVOTGYAFGlf+8K5blhg3mtgz5QKkV5iZPdjHI/jwt14hZcziqoiPCt/fyUb9Krz2oJO8H5GGJPiq7yd11E9a4cpo/Vzs53df2dE9lna9M/WxUJh3gS8VqIZ0HVpf0gI19VTdVZDb9TxaPwVDEQG4Yb9/gW65PTVG1QyS4e55mRbU26yEQqTbxSBlLgQ1q14wtbuVkQ6aq4xjow0Nunz0j7Js507KF7si/eaNB4DYxkia2G11fs4tS4TDOvInhGZGWwZF++WNoEnp1JakpXOC37DUcDBWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cca4c6-393f-4ac8-d28b-08d84ed940a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:47.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqrImoM5mcuWBsyFHOa+QFOpyd+a4ZLlyaZtX+BlAMtiHvl32eUuD5PaKZ8WqLKE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007450; bh=vUjJj6Kx6+7PmfgXEzGSPOpTfYW0uT40D8rQPdPAZdQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=OXw9ijJRp7/HaMQBHpVQJrbr5/O/ULNPNmcW9vUUlQsHtOmUucNlJZO83dNkKVWcL
         30aUl0T8rUvnOon1qv53TuOx6tdZG0TdYcJnUxM7hX233PkxQUnMh7hSMoEc6kXuDm
         y3xCDp75KQWC0abIt6Iv/in78wUw5Id3aVJdY7Gn46ODMNz3e/Q0wuPIKSHsbnF4w8
         cGafy3/3XdVgO1DMeoK9uKhOFRxgQvbwN6pxGx8VxGKO3BKsfxuFZv1msdGdpoRwGA
         AY2DmOtiLx8Ruu+ImxHjp/I5Fa+SCsAQlSS8Aeun8Zt0azkhV0BB9F19qT6cneGFfg
         0REL63gvCaPMQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Most RDMA drivers rely on a linear table of DMA addresses organized in
some device specific page size.

For a while now the core code has had the rdma_for_each_block() SG
iterator to help break a umem into DMA blocks for use in the device lists.

Improve on this by adding rdma_umem_for_each_dma_block(),
ib_umem_dma_offset() and ib_umem_num_dma_blocks().

Replace open codings, or calls to fixed PAGE_SIZE APIs, in most of the
drivers with one of the above APIs.

Get rid of the really weird and duplicative ib_umem_page_count().

Fix two problems with ib_umem_find_best_pgsz().

At this point many of the driver have a clear path to call
ib_umem_find_best_pgsz() and replace hardcoded PAGE_SIZE or PAGE_SHIFT
values when constructing their DMA lists.

This is the first series in an effort to modernize the umem usage in all
the DMA drivers.

Jason Gunthorpe (14):
  RDMA/umem: Fix ib_umem_find_best_pgsz() for mappings that cross a page
    boundary
  RDMA/umem: Prevent small pages from being returned by
    ib_umem_find_best_pgsz()
  RDMA/umem: Use simpler logic for ib_umem_find_best_pgsz()
  RDMA/umem: Add rdma_umem_for_each_dma_block()
  RDMA/umem: Replace for_each_sg_dma_page with
    rdma_umem_for_each_dma_block
  RDMA/umem: Split ib_umem_num_pages() into ib_umem_num_dma_blocks()
  RDMA/qedr: Use rdma_umem_for_each_dma_block() instead of open-coding
  RDMA/qedr: Use ib_umem_num_dma_blocks() instead of
    ib_umem_page_count()
  RDMA/bnxt: Do not use ib_umem_page_count() or ib_umem_num_pages()
  RDMA/hns: Use ib_umem_num_dma_blocks() instead of opencoding
  RDMA/ocrdma: Use ib_umem_num_dma_blocks() instead of
    ib_umem_page_count()
  RDMA/pvrdma: Use ib_umem_num_dma_blocks() instead of
    ib_umem_page_count()
  RDMA/mlx5: Use ib_umem_num_dma_blocks()
  RDMA/umem: Rename ib_umem_offset() to ib_umem_dma_offset()

 .clang-format                                 |  1 +
 drivers/infiniband/core/umem.c                | 41 ++++++-----
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 72 +++++++------------
 drivers/infiniband/hw/cxgb4/mem.c             |  8 +--
 drivers/infiniband/hw/efa/efa_verbs.c         |  3 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       | 49 +++++--------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
 drivers/infiniband/hw/mlx4/cq.c               |  8 +--
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  3 +-
 drivers/infiniband/hw/mlx4/mr.c               | 14 ++--
 drivers/infiniband/hw/mlx4/qp.c               | 17 ++---
 drivers/infiniband/hw/mlx4/srq.c              |  5 +-
 drivers/infiniband/hw/mlx5/mem.c              |  5 +-
 drivers/infiniband/hw/mthca/mthca_provider.c  |  8 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   | 26 +++----
 drivers/infiniband/hw/qedr/verbs.c            | 50 ++++++-------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  |  2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_misc.c    |  9 ++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c            |  2 +-
 include/rdma/ib_umem.h                        | 45 +++++++++---
 include/rdma/ib_verbs.h                       | 24 -------
 26 files changed, 184 insertions(+), 226 deletions(-)

--=20
2.28.0

