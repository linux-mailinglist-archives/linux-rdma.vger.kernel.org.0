Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073397D6BB8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJYMbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjJYMbb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:31:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7B18B;
        Wed, 25 Oct 2023 05:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+3wJx7pQ7+aYjR15+1V0QpK8fm5LyPD6nMPT0qoOX5FpsxzBSGj4VmxM2nMjnNJkRgcMpZiD0cUzpRWuy8QGUyxm6xOSl2DEOMX6K8WXuZH8rsPRITQtAOgal4ylw4htT9wPhm1ISM6cYN0RhMbVMdME2LbmCdaT9TKiLpgLwgIiutpdjCF/L+XbOEgw6NMQLWvcxNzUW8Gl/edMyskG+Ns6rdn1beeZDAj3Ox0mnhZgiE/K/hhDx+t+czpJ+VkGAtBRk3AfIOatCzwmrqRx6H9jOJ1kJj9dcrOOAcAr01ktqVyz4RRKBjoZIPZzx6YyCEVId8pHML7FRwoRe0Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8AbceBH0wYihj4bmopHYk+seKvlSMdtowcNBp2EW/Y=;
 b=D0I1DOt1IH0eZJ7C1byoe2CXX22aoJo8ig6gAJvqU95FSph+CLnwfhUeb5WVbFwzVxn33lQ2O5PspBeeX8nxn0jIUvtUhqfysvfHOIuHUAdVluepcneEkGpkdaOkBBmsgdmQW6JvsolkmwCrM3sqNUM8k0sJyD+9dqkZyjoT41Qxn6GEL76HqXDRaLT288dVB9/nfJyPKMKrs76D4K833T53tVtPMPCvDsXkjoWdabrs6CBkDafl0iBgVA961slShov/BZyCp4EywjAR9BvTXJ5A15lazseovt2VHi9yUT8YDzn4JZq3YVMs5y+chqo01GKwyvpQ2yomsw0/v7FRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8AbceBH0wYihj4bmopHYk+seKvlSMdtowcNBp2EW/Y=;
 b=s+xTZKXi5udYIlju8Oyr7SlQ5O7uobzO3ys3sRtD+8pqXYIM1GfQBSm/1wRo8SJ2vHyVnPasWlI4QqBy0ozGHOvu9M/os94ZNrelDislAsjaEbPR3FnDtue1S5RUNu+Jwbi6ncWx7srsRfYgfEvqbuhG8KmkW2QD37kO7QncGeyiKX7S602elc0qqlCDRduhOPT6U+TG5WmGiE3fDqNCrMiUgRhcnuwkFHigJ2HNvE+eu/fUupXY54mE9x6tyuHC85rVTMQU+0w8CcSRfEGYRhLceLvHQrc4/UlDTuftSMVgYthhrZgC79gG35CrfwCc66VGwUbc9s4ca+BCDFgNlA==
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:31:25 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::a6) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:10 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 05:31:07 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v3 iproute2-next 0/3] Add support to set privileged qkey parameter
Date:   Wed, 25 Oct 2023 15:30:59 +0300
Message-ID: <20231025123102.27784-1-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 4265ec3d-56d6-4a54-dfcf-08dbd5564da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xw5h+CcEeWRnW2GmC70iY2QEc6A0TmbskYUaj896V+Z90jsqOcv+Ud0wuLNKvQpPcRI4O7zcziaEk8xOdOntyqmxXlMGUXhJmTSwHAwU3IrC+eEe+fF7OuPJTGlaiDBq5Tdo/scCE8KeLJuF2ANS4eArhyM7hOTDuKTrSjfOvQoj5p8E/fCaMq4BzihVr3RPQoDA0fv+VC+XYSjuRXivKAXk64NdzVyArcLyrx6HVIh264Rgb1CghUn2xL3AiDFHuZAcVz1/gv3jjbHagC5fwCTlQ8AWI7GCbuluLzDdICAxjqOLSygS+F/VSwZ9hWEfmpRuFl8QFBCdTu8aV+VrnzUukeNyf+8ZPDN0puEFs9wE6GRUrc2BlmIO3YL/jBl8vVNpPvrjsCcigZp5A8dFcLsD49foEeBaFeozYmU8lJ54OwXN8OVJhTVIPva8BH5pnmEFhVaVLN1IjYusA1+dkG5mL7L8TKMhW1d4sogCkuuplpHDhh6tWC1Zfv2PZbD2aPCZDkIH892Y18bmo9yukDnT0BVfpL8AXB7vbAVN00LstjOAf9iAgf65HD+4gc03ssrBn1Y0JajeMyhdMGrp6SjpCZyCYG+s2wXoJHJr84KzQhC8VE/YMfBIm0n6x4tJ1UcQZEnb2O5gtIBgS8F538lcbnbdM4UzrLNdii//iMdgdLSr3Uc8KEV8TrJSk9iKrCu/ce+hUPUrpBdQatP+kSc0CqYLfjqUpeRtDDhGuA84fDhAxfNnZgm4GFE3nzIL
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(4326008)(8936002)(8676002)(41300700001)(2906002)(40480700001)(40460700003)(5660300002)(110136005)(356005)(7636003)(82740400003)(6666004)(7696005)(36756003)(36860700001)(83380400001)(47076005)(70586007)(336012)(1076003)(426003)(107886003)(2616005)(86362001)(70206006)(26005)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:24.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4265ec3d-56d6-4a54-dfcf-08dbd5564da6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset adds support to enable or disable privileged QKEY.
When enabled, non-privileged users will be allowed to specify a controlled QKEY.
The corresponding kernel commit is 36ce80759f8c
("RDMA/core: Add support to set privileged qkey parameter")

All the information regarding the added parameter and its usage are included
in the commits below and the edited man page.

---
v1->v2:
- Uses print_color_on_off instead of print_color_string for printing.
- Uses parse_on_off instead of manual parsing.
v2->v3:
- Uses shorter argument name at second patch to fit in one line.
- Updates man page for better clarity.

Patrisious Haddad (3):
  rdma: update uapi headers
  rdma: Add an option to set privileged QKEY parameter
  rdma: Adjust man page for rdma system set privileged_qkey command

 man/man8/rdma-system.8                | 32 +++++++++++++++++--
 rdma/include/uapi/rdma/rdma_netlink.h |  6 ++++
 rdma/sys.c                            | 45 +++++++++++++++++++++++++--
 rdma/utils.c                          |  1 +
 4 files changed, 79 insertions(+), 5 deletions(-)

-- 
2.18.1

