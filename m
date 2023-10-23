Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED537D32AA
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjJWLWp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 07:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjJWLWo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 07:22:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75508D6;
        Mon, 23 Oct 2023 04:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6FEXOh4sa8uj5KHdpj3GAL4pCWBRNetDTupcWydLP5CwHBK9/avZFkFEQIaw4EKsfj7Tkd/8GDZzfJamo9SuNld7Xf795ONuZUQuuBLF2e7Bx1g9MLdtOe9gKmO4vjwvryeZ1/90EdWD95zTGT6ilBoIhW1tuukEyRou0qsG21mSEDik+X9yzdHbTNiHNZ9uMtOPQ8JyRan7uEpJ8iyuh4JySFm/33vCgYITXWa8OnO08QYbUWhxwMsvCvEfW/R+DlvrqUdJcpgKmy+HIWdSQ3+Mf4Np4UDTv6pwSsQ19Pj2isjB4GNoWWWvMaVpbQNcEcF+VXxR7cL+BS+e0j/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeBs+nqN8S+Gs8K77KBlA0L/wpa/SFF/1q8XmE/5sYE=;
 b=BBuwA0MbxvXRqgw8C2O2ClMzjYT8A+du+lDG+9sv66ILBPDAKhzuTU3DBQmqcAW2hxBf7j7aQpid2StKAEN2sqecn+Q0Jmo7FBmLTCy8ZlFa6icYrh4VSHZCKT3BU4RBt/0MjzTg4XEsjjr3VWuhDCqN9MKJnLUwi8nEb3r/4sM0HnF7p/ndE5hUDeLDpPDTwbINu1Go75rft+nmedrHWxhGJKI/nyE5+ByMOrW4jkb1VYn1qE+aG2MEMFD193wYCApp4Er5OEzLIMHz+y7HFQ3aqcJBPNc0Vh3eqr1AhFKvtX0LhXfVVjuyVxLKy4f/8WQSyKDCAyrXFx3Lb9BIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeBs+nqN8S+Gs8K77KBlA0L/wpa/SFF/1q8XmE/5sYE=;
 b=Wj+irSz6wHXzzAffG9qKbls9pYoUYwaKiLHMBu4Q4TZeVBCaVIAntEDELNG8etfwYPziVnYkfYTzzWE0yqYtXIQ6RZR8Ykg6CkahU4k3RBp7BecJbxT0vWHRJRbwjfBzxugSCH8LhuzvTv78iVeDAW7kOTD0OMWCdVQnriaIJZNiVosmJkCju+g2TlUlymuBDm4DimhKHLRHCjbx6Epla/TQEJBsNgvMgGPRHks0+78n0sLR5RC6wB9m0Gj2zKMljF3qsNqMRN5w6Nu1OvsC6oWZf7e9vO7wlBe/WOXhgqOHHIDuXIe9/0NwX0FsNW335wod7nELhPBLBbl8B6A3DQ==
Received: from BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 11:22:39 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::67) by BL1PR13CA0134.outlook.office365.com
 (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14 via Frontend
 Transport; Mon, 23 Oct 2023 11:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 11:22:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 04:22:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 04:22:25 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 04:22:23 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v2 iproute2-next 0/3] Add support to set privileged qkey parameter
Date:   Mon, 23 Oct 2023 14:22:14 +0300
Message-ID: <20231023112217.3439-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 848c3ee4-beb6-4945-2019-08dbd3ba5dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SlJ9Ny3cB0OdvoB131u598LHtPBb+AwlijbJnOaPCYcEgAZErxNs/bxl0IO7znUqPCvcMrVE3p5nkpJ94cd21/qbr9uV0AhHUpAthvOEH4SI0miKGcq19y5eCTAZeFIsYawcyRaVgkOQHmH8gRfngxFGGwQa+lj+jEaO4D7IhOGl53uhmVer2dsU0tmm9oOEtARY1wg56en4/DvXGsE7faYrJ884OFdSIuyTrmKOlLl3fAdU6NImx0sWYTbJeSKB1iA0ypPVqKJ4t5Slw6449jN7kJa4EP/BNe2AAj2jj2D5uvHtmIemjOMQaryKUNbSyJl0wWi/b6qMp0wLoAd2v6M/0jicWU6kG8hiLlPnQrS/QfMTXlYiRXS/GsvDyK1CTkt+y4HYRiu1TnGytRcp0mPaaEohpmbx6ApSSMBQoO70+oLpVPsdsw59aBsTWqMZfyAl0FPyAcFp1WJRQtW18FmSeFhA3b4htMHSS0uMGOMUOc4Oq9b4EIqN0wn4tO/ZofyUy1VG1E08Oh0x6kJZd4oGcUjJB8pJrMM0MHZzG/zPDbqa6dmudMx1UVjeU0yP3U8/S2QzVSjF4+EZVLH4O3TWIxUquWZxuai8oF8icyB8M+Cicez39fwNTAxAkqbaop9qQgMICUYJPglFibT4MPnSWMt5pCdGGyPZ+YgMszcUaC/lWfpzHNd/LyF27w2dXF9OA+pK8u+7KRXSTgmgA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(4744005)(2906002)(110136005)(316002)(70586007)(54906003)(356005)(2616005)(82740400003)(70206006)(7696005)(7636003)(107886003)(478600001)(1076003)(6666004)(40480700001)(47076005)(426003)(336012)(83380400001)(4326008)(41300700001)(36756003)(86362001)(5660300002)(8936002)(8676002)(36860700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:22:39.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848c3ee4-beb6-4945-2019-08dbd3ba5dba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset adds support to enable or disable privileged QKEY.
When enabled, non-privileged users will be allowed to specify a controlled QKEY.
The corresponding kernel commit is yet to be merged so currently there
is no hash but the commit name is
("RDMA/core: Add support to set privileged qkey parameter")

All the information regarding the added parameter and its usage are included
in the commits below and the edited man page.

---
v1->v2:
- Uses print_color_on_off instead of print_color_string for printing.
- Uses parse_on_off instead of manual parsing.

Patrisious Haddad (3):
  rdma: update uapi headers
  rdma: Add an option to set privileged QKEY parameter
  rdma: Adjust man page for rdma system set privileged_qkey command

 man/man8/rdma-system.8                | 32 ++++++++++++++++---
 rdma/include/uapi/rdma/rdma_netlink.h |  6 ++++
 rdma/sys.c                            | 46 +++++++++++++++++++++++++--
 rdma/utils.c                          |  1 +
 4 files changed, 78 insertions(+), 7 deletions(-)

-- 
2.18.1

