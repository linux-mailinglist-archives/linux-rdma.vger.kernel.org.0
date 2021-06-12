Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928DF3A4D21
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jun 2021 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFLGgy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Jun 2021 02:36:54 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:56416
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230012AbhFLGgy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Jun 2021 02:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y33qN7w+Zne28dVQWQhvuGWyJe0unXvekXWH2kQetQYY/cVB8SJaQpoyIG147Np+0p9TzDJ533TVi1KWUy59xSRCsEbfr8Nw6bjeIRMOZolPbgovE2zVHCdrKDRDaH4BltVRGAcQnZSVKCZ/3KPGjx7Muc42Ir6GNu8q+EC7cb1sl8sZ2GB8kMtI7p+Qpno/isuOu6OqqCgNM2NVcJPLSzfvJwoi2ATWsoQHMG3uLAWBDVOgIV+0ZqL2hLLszij4lTWxBbfPHM/RgKHNAUvBv5DVmLYY3Oa0x7B5MC55QRbV6mRDL5d3buXw8G4Fz+EeNBdOhGPQHOSllGocb9azig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKTdvy/hdGks7/aAlnHPGFigBmSSfsORVJEr5kLczlo=;
 b=Zzdtn1lOci5DTTw2L37rulKl3bOpU8TABwFDq2RjTJfl5+tK4zguuh7axsgWkXAqeE61sPJ/dqJiwuqftzH7ctAK3AgaxyaKiJG1fdbqA79Uqd+u1Zw56oG3X9GvZbI78jhhUH29RjCcwKqbBRoS9f/bLV46aZSXyMM7Dzj8wtc/GZvgF7WOfRxSanKBk/l3HhUXxSPxu82f0rQQsW3zt2lGPPcpDQZB6DP6kItDuG1lhOboxS9i5HtxPTQQR6ELeIKZAuGKikhbQHZiaApAqw04iBxfK2rpdaJp+V+JSEmaQQcH+PzD71qQh2PDRvKVa55eQz4yIusOc4ZxEX05bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKTdvy/hdGks7/aAlnHPGFigBmSSfsORVJEr5kLczlo=;
 b=af0GnEXPAa9+c5i5Vu7E/DIPphwjEP71pKphxgzIjsjsLTgUEKsR2SWF0otWPMO+lGnKmm9eq9r1LE8/59Xlot9+6Lw+mIV6dg+mi4wep6ZkAcO5P8CBe4oJQxw5zwqAJnHAsIYUXPOVs3ka9r2Wc2zQXVpPbzoHJ+4ZjLmheh5yeTlbKOdMqPhnPT1GQOBKNJ5FW59DNiX/PicHrABr5vUUxhDEgJT48l13rDPM5m99uKCvMUSEZefEEtA9jFCOd1zGIueenwvNAKDpT4WVyz3A+MDUg/bo/3S2awVlajWOYgOqj5QzIFeBClE03mLEp8TLOPw7er2DpcoqJlsncw==
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by DM6PR12MB3146.namprd12.prod.outlook.com (2603:10b6:5:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Sat, 12 Jun
 2021 06:34:51 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::83) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Sat, 12 Jun 2021 06:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; cornelisnetworks.com; dkim=none (message not
 signed) header.d=none;cornelisnetworks.com; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 06:34:51 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 12 Jun
 2021 06:34:50 +0000
Date:   Sat, 12 Jun 2021 09:34:46 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA: Fix kernel-doc warnings about wrong
 comment
Message-ID: <YMRVhi0+a/ZX3Vho@unreal>
References: <8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b40bbff098247962af5a7b35d47b2e964daa523.1622726066.git.leonro@nvidia.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c456bb-a133-4986-6c22-08d92d6c2eeb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3146:
X-Microsoft-Antispam-PRVS: <DM6PR12MB314604AB690451C440DA7DD9BD339@DM6PR12MB3146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjsjZPXIPsTESDUDEIhRaTUnlW8HLzeviZ1vOSr9LO/Tw8HH1wRC7GhSqlDLuTitAu3/3OAds2mixm4FdfKp/49lGZV5h3yyCAUQYDD/D5+jzsuXwezFYywkriV8q111jDtc0EOggcve/S6X3WfTzbHH1IhjK+5b41K3Q9l6ADz5E3Ww3VmJPuuzSB1Cier0NXdpXkK+KL2vFkANM9ljpKEUxoJzbM+GC0lAy+52MoUGvnHibzbBJcHL1VgUq7VWlQjhaLR+iBnzYc/OWpiiTuEXuEDosRo/3QqQe8hCxFGfMxKbnnigAm/8itKFvKJ/xQvJZcFfNSD7CPM38/9GLpqIPClHji0dS++uNTQWR6T4OLVALDk36qhSiXm2gsSNYpCSUTTC5XNwYmXaJy1b+S1H993QhszQpSxOuFcaqogIPLjMzP+KUksSRujQq7AlI2b7GB46G7Ay9F/1VGEGaMEoPrxIL6Wfs5VSQ0aW+LkGxf7C2uv7R3SNCbxhTE0ogBDnCQKGGXP1NxTy+2FMZd0m+GC3BLPuOT67L+Q1OeewWR428mRT11qSq86yyWTK9GaWQmL4r0KtZZ9k48yB68k/tRs8/u5A/TqDc54sch0WdteznuyhaSzYPp4js3FeMGN6f1eMRISTE012XrM05R0aSg1OMoUFH9RXZzcm69R/V9lXjqmcS6nTNEzziWclHxefp/YUjz0lvY7AJB/UIGdvipm4W/QAs7BZuU518bS5BeWwcj6mHwmeg7JR8ESXuYYM0KSWWqrt7WLArFD32g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(186003)(16526019)(356005)(47076005)(7636003)(2906002)(9686003)(26005)(36860700001)(5660300002)(426003)(6666004)(82310400003)(83380400001)(70586007)(8676002)(966005)(4326008)(86362001)(70206006)(8936002)(6636002)(478600001)(316002)(82740400003)(36906005)(33716001)(110136005)(54906003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 06:34:51.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c456bb-a133-4986-6c22-08d92d6c2eeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3146
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 04:16:36PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Compilation with W=1 produces warnings similar to the below.
> 
>   drivers/infiniband/ulp/ipoib/ipoib_main.c:320: warning: This comment
> 	starts with '/**', but isn't a kernel-doc comment. Refer
> 	Documentation/doc-guide/kernel-doc.rst
> 
> All such occurrences were found with the following one line
>  git grep -A 1 "\/\*\*" drivers/infiniband/
> 
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com> #rtrs
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Changelog:
>  v0 https://lore.kernel.org/lkml/635def71048cbffe76e2dd324cf420d8a465ee9d.1622460676.git.leonro@nvidia.com:
>  * Rebased to drop i40iw
>  * Added Jack's ROB
> ---
>  drivers/infiniband/core/iwpm_util.h       | 2 +-
>  drivers/infiniband/core/roce_gid_mgmt.c   | 5 +++--
>  drivers/infiniband/hw/hfi1/chip.c         | 4 ++--
>  drivers/infiniband/hw/hfi1/file_ops.c     | 6 +++---
>  drivers/infiniband/hw/hfi1/hfi.h          | 2 +-
>  drivers/infiniband/hw/hfi1/init.c         | 4 ++--
>  drivers/infiniband/hw/hfi1/pio.c          | 2 +-
>  drivers/infiniband/sw/rdmavt/mr.c         | 4 ++--
>  drivers/infiniband/sw/rdmavt/qp.c         | 3 ++-
>  drivers/infiniband/sw/rdmavt/vt.c         | 4 ++--
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 7 ++++---
>  drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
>  drivers/infiniband/ulp/isert/ib_isert.c   | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c    | 4 ++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c    | 2 +-
>  15 files changed, 29 insertions(+), 26 deletions(-)

Jason, reminder.

Thanks
