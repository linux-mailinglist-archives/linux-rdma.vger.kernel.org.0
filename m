Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470EA412E9C
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 08:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhIUG31 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 02:29:27 -0400
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:49598
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229826AbhIUG3Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 02:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxOfA8Hir3hT/4o5KX4GaDHEAjhnGoL5dzFZUbU2Wy3WNefxxRcC3XptNp1MOUARWmDOl/UiEDh5hNs9IuKEAKDG5bvnAH8cHScM8tbKQaMAQnbrc97XR5UtgTMYtj4a9CgF4RTkSMZxQ1QBiLerj1iBUE2jVYde38U4XsCqpC3nuG5yp9Szgbkhx1uprVMspz1U7Kgxgjlgn1e/FXiy2V+UjPU2/S7Bs5OMJaT/s/p6QE41RovsYDxztGjj0isDtFnfezJGJPTTlMfukhAITMehfqCeBoyDbGeDni9WQZikdBKbEhoIAEDimGR9gPDvOa6txtWDUDzz0wkczX5SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zXpASqH+1illgAJcAaM76eEHUxCuRv1yBbRm1p3K6Qc=;
 b=cFOJH9kNzoRGnb+2ygWFw1/rsCSY81smF4pVI5nZcFQ53smNaUz4QuQ5eQoMmzcX5ZYR0MrOaHGTw10JEoFjCkYhp4MJ6bBjw57NjrmxcHSCSQmhGWTJHGAVoe3tJ6esBc+8LXiBzKTNUSIWbUWZsAbYyyDZ1RfTH7rsC9KUvr3WGTF876BAupodUcdChSwhDFZjL9PPlZ/6Tx5g4+WAV2ynzeZDc4mh8SHmsl4BJi8EzcPvDC3tnX4tooW5Fnbpqp/sxJkBLhHOp5M+dcvYrl2TQJeb6UhxxUgmoIL8SZCLbB8lnlrkiyG2LoEVfObqIKRUzxnZewLuL6ydsevSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXpASqH+1illgAJcAaM76eEHUxCuRv1yBbRm1p3K6Qc=;
 b=DrTslbMxrZHx7T3MnFAVtHx7eqtZJSa4cUxTjnqsfwCT4lDPRkicMz3tCc6Lw1TpqWY/JOmGeWwJRJswzjNVB5ouFXtKxuaaNrWmfTb1y46gzzmFTBX+dNLDjmde+5LZRcUT7bYz20Ka2iv5gWI9sXDGmr/ocQXRrSYNA+mE7u5hLTws4ov16w0TY8NRUv/pFijQPX1SVQXO46PwN9G0JTHWS/ug0sV3Z1+KaKU6tfHJNNHR1uFwwyhuEDQuRs+Njl2gS72bHMvArxB+ahxH9tqnjlPYZaSqOLxnvpUAKdLhx9ERTWm3WJe4ecovVU6oZPoMLh0ikrlbsN2XOLvWNg==
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 06:27:54 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::46) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 06:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 06:27:54 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Sep
 2021 23:27:53 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 06:27:52 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <aharonl@nvidia.com>,
        <netao@nvidia.com>, <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH iproute2-next 0/3] Optional counter statistics support
Date:   Tue, 21 Sep 2021 09:27:23 +0300
Message-ID: <20210921062726.79973-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b984b3-4bcc-4694-ee1a-08d97cc8f212
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR12MB410587E1B0C65F114911A474C7A19@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFL7iwDvguP3KEOhuuVom0kMSNj3gfa1OWulMMWE+ATfNa0zJQGPbZWeJARhC4ZtTM2H3vJ55GZLuJo+kMJnSfTKixEAB35NFNmunmM7tQ4RXJMY4nGupB01czygTl6YSxyWpD04bkj7ohquHVAbYg9tZwzBjkjdKrp0wM0Rsw3KfnguruHWA/4OPk0fN9MKBxuZin0FTtf5V7vrSPpsbGzX2JzvK5CX/CmFctRFUk8RriJ71bMrAG7Pt+ARy4WG1OG9ASX7+PL8gJ375o55OJ/XaXbsoc+atNyktX8NJGvGDuSvOytvwf1rbfZEYGAm0ToKPFtg47l0Z9l2BHyAV/sU0e9l+Sf2Y5RDLwctu9NfAkmUVpuSP4hKoUS7qwSG15CAeyjNWeW3EGqje90sGCrOePfQu/8GL946MUPys1GbqOiN/Nx2D71ZADsUu2a6JJb/CZ8Q43uBgf8t/zWwCP7xFNhh9QPHRIWNqlSmG7d43OLWkV6ib7LIhoIKSrcG58u3pmbKM+N2rzZ83yzB66onCzNS7ldLbKJJeFteEyPeaHNeAkDYQchBRqgqCR+3mBMsse49Dwnb/z05vwf/SFzv2BJXHwxXmY6Pc563HvdWPAPgkx0eZrcpXJTXnkV1cD7eJEzZXrF5dVo/4OfxacD016+VMPZzhDAOSwBM/KZZTCYAvyJw9D9uJU1PhX2JksT2LhyDjI93xIT/dCproU9MLXI6Pqqo0MOtvEtjQBvLAX9c8Q5ZOmbbWy728AKg1MIFpQKFEpoeDjT8Dm/VnA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(966005)(2616005)(186003)(36860700001)(36756003)(508600001)(6666004)(47076005)(70206006)(8676002)(7696005)(426003)(336012)(82310400003)(316002)(83380400001)(54906003)(70586007)(1076003)(8936002)(7636003)(5660300002)(26005)(86362001)(4326008)(2906002)(107886003)(4744005)(356005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:27:54.5066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b984b3-4bcc-4694-ee1a-08d97cc8f212
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

---------------------------------
Kernel patch is not accepted yet.
---------------------------------

Hi,

This is supplementary part of kernel series [1], which provides an
extension to the rdma statistics tool that allows to set or list
optional counters dynamically, using netlink.

Thanks

[1] https://www.spinics.net/lists/linux-rdma/msg105567.html

Neta Ostrovsky (3):
  rdma: Update uapi headers
  rdma: Add stat "mode" support
  rdma: Add optional-counters set/unset support

 man/man8/rdma-statistic.8             |  55 +++++
 rdma/include/uapi/rdma/rdma_netlink.h |   3 +
 rdma/stat.c                           | 327 ++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)

-- 
2.26.2

