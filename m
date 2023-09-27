Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1FE7AFF6F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 11:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjI0JFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Sep 2023 05:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjI0JFd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Sep 2023 05:05:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB1C0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Sep 2023 02:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/MIGmBeT22MuWN+otbB3bfML8qzQcyewsiih8ZmNPdPsEZqiw10xvjue3b19pqG8IIZU7ylCSV0fgqSk5ipsmwTcwSBo065neiNEFU8/9OXuQUEPf9ZlJ5ZdY98UumFIOo/GStk7sW/Ikb3cPEaFfoBpCMofwg1tHpW1T9E0Ti2GIFjP4bn3NxFbvC6WHi2LUXR8/ssCt9DFWYz8v6Ws2EHl3OF5Vv/3nb2/fJWBWND6+2EduOkJUlQVlWGwrffRqivTu4kh7w1QugFYo2n3zrihCTA7QJWKpOpBcSLChGjMx9Kwyfi18UETuLkZwEbOFhL3wdh/4Y4QpwoTkUu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcnXREmnCYlYphFe64BdOJb2DZ+Bds/dd8LO+mQ/PII=;
 b=Dp3Y1sz357KqSliw3/HusoiHZBpbPqfXmdKG9VPCm0+BUmqNAh+vOZ8Lg5Tttvj04jyMC/5j99LURwmWeTgg0qkccbNbJ4M1Wun6uY9GqhXC1Lj6iTzKLbbBu8niMk2TMfPHrjfN5I3KHsu/xWYjshJIUPNzGW/VOwYoR9gOXA+pKGhT15geWDgU3wP2LtbNWRqjDz5FPv6HtLwsIt71gPOSGHEO1QFIdkKjmAgUH82d0Ls+1FDrv+Un3iZOwAr9jXJIPOS+7Dlqpd31kA8UF7gdm3qfVsLRJMcK/n7awL6QyPGkEjonB4dAy1ZWoAiXJ7lt/5wo/BNMyQuLKfMgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcnXREmnCYlYphFe64BdOJb2DZ+Bds/dd8LO+mQ/PII=;
 b=fbYAy9Ozz776lokUX1HF0qnbzmtiDho92c6jSQW/dAXj4Xy+WreSo9HACF3+kBSY6LUlzUUFRCPoN5/1faKvTsspVYPX5QQ4q/gPrVzi6M5/Savjp46uP1b7POkTT04hNzK7m/qLxee51TsLicf6kW1KhB9w3YbRo0kDzWcXTul1ngvVVhQg4SgyRLEUncbsNIV99HNPO++FT91CcGc6Ykly66SLpm2q7jmR2Lu94wa2jHWwSB8T630pe4qPILQ5xuDjnVElQwiy1h05FnL/sCvrkdTNjIQvKIMKHEkVEvf09nfQy03KJHNlmMXCM+UHfzfsNTR1wCB3RapkshXiLg==
Received: from MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:05:30 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::dd) by MN2PR06CA0001.outlook.office365.com
 (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 09:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:05:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Sep
 2023 02:05:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Sep
 2023 02:05:14 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 27 Sep
 2023 02:05:13 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1] RDMA/cma: Initialize ib_sa_multicast structure to 0 when join
Date:   Wed, 27 Sep 2023 12:05:11 +0300
Message-ID: <20230927090511.603595-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f905e9-6f57-4b33-16e1-08dbbf38e631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4dUZEUamwDmEcqJrqHicJbs+V+jvBHJZutvJajkk763si+aKW7SlOe88l8EvmCwrwo2wbR6v8Pg99+UZJY1SX/Nlh566sc6XleEBX3a/djOkcbfWbM2prZXc9pa4Stv7ac9n3n1HonM1R1Oh1Vc0OEwY4TpbVc/Gi1dJNduZyIpQH+C5ik9cx9V1WbH/P0YsTyvtOZZv43aCJw9MLjhKryxIk6V4fDfKF9IcDMPBIon5iWLqRC/pKdIxhRkqYdry36WgWiRELJFM8Jl6ci7Gi/cRwaYVt49+2vkX20JEudEAng2MzXXrtOVkIIg4Gu6m3LMlaXXh+X40Yww58ccVtWIm9YoAnuVSm+6W3qooy/6nnUWNvLuWYVao22zga8F/8+P1gkESAcSjF7KiUpBxPb8lVMWUF0ObaANmiqCb9BFAbABySi6kAF1MW8KSC+K0+LJqLdY4HRuYJIWPWI20wMxl7+ks4oUWXYgdtKrVUwDkQ5XSegZa4JOC/gHPh7NlqwOxUjAY8lOCJEArVIAsnaeUlMVtuq05GUeByJE4ROyJyFRoZi638NrA8HQx+rnV6Sz9/N/2V/V2GocH0d6CezMuV0i0qzNapvpH8hZ6mLB6sItopSbZZp5kx6gaJYL3UzK7C2avxrLHi0wJlWAKxZ1bw28JPS4OkFojCVCC4mw5/aP5ScdxI4rRtHeXXdZz/tEo9T4unCNqzrNKaGOGjOnuCvhMtaaNt849n85Gv/J35PB/Q075qLlPjYmaZlcmwzDUobHfie2ysrbOQcqBEj58SIAFYRBB7n+tOrK33k=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(107886003)(7696005)(83380400001)(7636003)(82740400003)(356005)(86362001)(36860700001)(47076005)(36756003)(1076003)(2616005)(26005)(40480700001)(336012)(426003)(2906002)(110136005)(4326008)(478600001)(8676002)(8936002)(70206006)(54906003)(70586007)(5660300002)(316002)(41300700001)(966005)(6636002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:05:30.2076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f905e9-6f57-4b33-16e1-08dbbf38e631
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Initialize the structure to 0 so that it's fields won't have random
values. For example fields like rec.traffic_class (as well as
rec.flow_label and rec.sl) is used to generate the user AH through:
  cma_iboe_join_multicast
    cma_make_mc_event
      ib_init_ah_from_mcmember

And a random traffic_class causes a random IP DSCP in RoCEv2.

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
Changelog:
v1:
 * Initialize the ib_sa_multicast structure instead of the rec.traffic_class field only
v0: https://lore.kernel.org/all/20230926072541.564177-1-markzhang@nvidia.com/
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c343edf2f664..1e2cd7c8716e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4968,7 +4968,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	int err = 0;
 	struct sockaddr *addr = (struct sockaddr *)&mc->addr;
 	struct net_device *ndev = NULL;
-	struct ib_sa_multicast ib;
+	struct ib_sa_multicast ib = {};
 	enum ib_gid_type gid_type;
 	bool send_only;
 
-- 
2.37.1

