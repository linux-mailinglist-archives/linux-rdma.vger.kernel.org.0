Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679A7AE6BE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjIZH0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjIZH0O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 03:26:14 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E398EEB
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 00:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG8GClokfgZz44+ARF2fPEnvEvN6en95BBc1USaREStEPirV9fzLxZVLYVScMK+cfh/8scTjgfS0AozsCB1B383qDEjtsKrS9thyiYd68zl1nC0QLRy1UJ3mVFQxww9VhuNmJQm1yYJcZVMNDGSXvezWh1k6uayagex5bZlTBzVtSHBFFRL4u7w/g7vcufedC72YfV+oHn2wXbP6tD3IJoyscuOvQLuIWJiRxWn/0nItYi74Htuvxc/G0NfgRa1+7PBrjEKqcovkLOS+JSJzj2/MeQKmMd3BqF2JzTB/D4thnQJHZqwh/0F1dxNG8JOjAT9Aammb9r+z9sp4A1h0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZOI6BWhay/Lk+keaFF73GrNgg92GV29VPXBP+8BvBY=;
 b=RjeGlpWq3fZgHRQUibfSMBxqmTt7/IciEtQecPsFwa5/pfUeT7PTRsPmYQ3nHePktx2E+bMCM7/ptiuOXLDByvj7Qtb9r/S0OR8mYF7WdWmAT7vsUoFQbZpluFZSNjGqOFU/LWA7VnyEw2MXTezuWRnwqq4P9Rxv9V7OAYHRlw1TAfaeL8LGokQ6N0nuci00wwnzYq8mavIXmINeDZ42+Idfs6ck4VlhvOvLLoONbvjRlJxLSiAL9UhPZ1jdpBMFXyqNhL9r7rJoXNLw7BaweU7HrZKz0yYuFjXMTKrpPl/fitZY3pIJPJrY+Xjv7QtqTrtfJZxNMcsgUBYXliEUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZOI6BWhay/Lk+keaFF73GrNgg92GV29VPXBP+8BvBY=;
 b=dcwXYjWkackOA4A9ilv+4ZCkTYoGvtS9M3/1HXEHStIQYkie/1dsVrdb+pa8pvlw936/v6XqJRQkK98sbzgAC+oJq32bRJYAH1TJ60oeZlS+QkbG6ToBMD024K0LHLmQrnKnxcXfFsPxKJ0y4qgxNVQs1bjMb3EBLUvcGdWHKGApP1VKfFGCMQepUp61FibJhFgi6GKdmmR593CQcPEv4QQdL0iheDlMPMj3+ony2JLNoYNGxEmnMhDMgMYWu2rbg4n7C02z8odSe+7h82yTNSEezdlyJyQ8KWmrtyJ6xTsUITrimDLzPRo3ixMErncYnXcdIToPFEqPfdicobbCig==
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 26 Sep
 2023 07:26:04 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::a3) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 07:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 07:26:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 00:25:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 00:25:45 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 26 Sep
 2023 00:25:44 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] RDMA/cma: Initialize traffic_class to 0 for multicast path records
Date:   Tue, 26 Sep 2023 10:25:41 +0300
Message-ID: <20230926072541.564177-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f06390-2f69-42c8-44cc-08dbbe61d7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhZSWr4Dqzg1tV6CfMDVcWOk8k+R8bLVD+6S5TafiG8V3vk9w8jGXwZK+rbcEK2A062OfKgpLZdnu7zZUCmfBNOsulLLt/TqqCDTUOEIpH0d2kdrdaGegzZLyhfuviANOaoMbGj2oina1ahSWP0Y6jBg7B+A73clN+M51Y32NZbPFVH/cADkyODhqcEgXzDMyEtbeZdP5nMoFwYJ1MwWZoBxhahwAz1B0VpuuUWyLx2ru7eE1pppkXTs3TnpHsNDNd40ItgWfXNxfhQcaFU/9PtE8UP0PR8QrBFDd/+td8j6pM3muf5yP79BO5Casf8x1NCA63YHc5XpDuXzyAkEQgdwhkHUkLkS8CDOV5xQaBnWWj7iDstUz5bTSoa8+6ng+aWAO81KHNb7Rc7/twogfRk+9jSUmImMIfPYCg6izdvDHMLJEeGY18DFEhuQEyCXM2rJC4RQ2jixWwzDCZ8Gtn4+orwlVSJdHTfaZ7A5SnfE+//zYsFgZwDKyOSJHOQYnJX+EqbI9Nx8Lc3eZKE3azV+Y9rRSFR+uGz0QOdxZlXl+V8XHZXK5bRUvwD8Joa3HpGQQwc4TWb/uLbAnStFF+9DVykKX5uvnk4+yMg1B68Plht5E9wQMwUgJEZ9fENmsCl6vxDUUdwxbXA3Pd3vkmycBnH0Pp1VqJk4T3jOVjlAuqKyLsfqqD1wgMltyPukkp9uAbn4mia9fGqU0oCmfnUvHfXA8UmmhzaKbt3mseU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36756003)(86362001)(40480700001)(4744005)(5660300002)(2906002)(54906003)(2616005)(41300700001)(70586007)(70206006)(478600001)(316002)(6636002)(110136005)(6666004)(7696005)(7636003)(83380400001)(40460700003)(47076005)(36860700001)(356005)(8676002)(336012)(4326008)(8936002)(26005)(426003)(107886003)(82740400003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:26:04.2931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f06390-2f69-42c8-44cc-08dbbe61d7cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Initialize traffic_class to 0 so that it wouldn't have a random value,
which causes a random IP DSCP in RoCEv2.

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c343edf2f664..d3a72f4b9863 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4990,6 +4990,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	ib.rec.rate = IB_RATE_PORT_CURRENT;
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
+	ib.rec.traffic_class = 0;
 
 	if (addr->sa_family == AF_INET) {
 		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
-- 
2.37.1

