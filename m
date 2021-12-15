Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69F475A19
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhLON5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 08:57:47 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:30016
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243075AbhLON5p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atb92jjdP3OJL+VymEBv7HIUwHeNGT+fVCcLPyq5beqxK5ynwWYC4HrKW7ifIDHjlejTNVCAi+QouaxHFJ8bqH0VVM2nfZ7i8D+e3qGmJNzQM1heNLccr9Uko69wGJz3+BCB7jJlFnKChQc/OEbbN1JiaVpy8txZx1a/HkZ5r77RzyT0R9sFOzx9+X5K8Qt6xkbwExPvsAi1M25922DkH/Stq0AKJ72xB/GuSo9t7fYp+b1ySsFTT2gaHEQ7OW3RTvMfz594Nv2XJdH2IUm3WJNC7FUwQ74Ow2/qSGoRP4pF2cs9uzMUzRdvVlZTf90qYwWiyE4cUOpXsVKWmgcfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq2wK9QRJ5SqQED2BmR69h1cHmwjDt3kzEN/dXbURVY=;
 b=jqFlWh658cw5v56y/X0am8JddzDniRYlPC/3SJF01bmWPKoB9d/5CeMPueAGer+C0uCiVeHTIj4mkOKdPLh4v4pTMcUPnkqR/aALfHVqpMqqTZbuWwPDk1N8A6e3NbC9q8n5WDZtXbNVsDsi5L9X+yhXvfdtj9Hp8Rp9WAbYM5jKznoIUic51BYqKsi2WwHfqGTsnapQf3g4oNgERMW3YRvCmArD1xVtYpSN2V38KW6OruvGtxw9+bRSiyC/PnrlKiePSIQjrS6wIbFeFsNlTWkOWyp3LzbemfX3LtVhqDC0RioyHn1RBKQmhua1UPD6Z6/8kCeAQHB9yulVKzkaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq2wK9QRJ5SqQED2BmR69h1cHmwjDt3kzEN/dXbURVY=;
 b=k1Z3uIl3taX07GdTIbgMhqs2dYdnKFpQxQBm7fpgNd7r6oAmhChzgc58SeAeFpWf4lIRzovIt9IKmI0s9d4200lydb2aUtd0UvKuL1N6JTOwvZClGwe6XwXG06dZ6Ef6tvWVfsQsqCGA1MUeFVk+p45Z18GtIMvbtXZAVGn3wCxltd97JiYgJrU0mJ7T4GmFjs3zgYWmJoPDxV33aFHVAXEXFKwO3WHvAf58u5E0KBoHoxfkMBA+S4PCbgsNrZdYE3oiwPXy3ucMq6PAdNAyApBVoG48Tta595DxQkr8kW7oHtsycUGnmWjd2kZVZb3yYU/5aWda7RHhN7lyc3rJvQ==
Received: from BN6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:405:2::15)
 by BN6PR12MB1761.namprd12.prod.outlook.com (2603:10b6:404:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 13:57:44 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::10) by BN6PR11CA0005.outlook.office365.com
 (2603:10b6:405:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 13:57:43 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:28 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Dec
 2021 13:57:26 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Dec 2021 13:57:24 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <sagi@grimberg.me>, <jgg@nvidia.com>
CC:     <oren@nvidia.com>, <israelr@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/6] IB/iser: remove deprecated pi_guard module param
Date:   Wed, 15 Dec 2021 15:57:16 +0200
Message-ID: <20211215135721.3662-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211215135721.3662-1-mgurtovoy@nvidia.com>
References: <20211215135721.3662-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea9534fe-7862-4504-4b3c-08d9bfd2de25
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17614A6F1872220CC6F002E3DE769@BN6PR12MB1761.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVrd2c3fNL9sL0M+GYNEZ6+ozcre2zzeNCvLxcFcDS+4eEQODVcm5gYCNG0CcxblECE4YP6yziPg3Vwj0N++az0D0RCAol7AAXfGiuYCAUcpZjzj/Z7oV/t+7+cam1UVK5J6JjNpy4m1IivmUe7K6BG8kjU3wQ7CyaOBwzY4QQ3AHfWg3yANd+JNztIGa3/temRjoznIid7wmOJaWvE4T3Rm2AGBbvmL8YX8BzfYHHRQPipmNZshKztpwv9efwl6vXkNJx4eflmfcQqaYx98+H3eB63Odo77Q0Z/ps+fCNUWpAepWZeODu1+2O1NhhjtDzjmCAFcE2aP6RzTk4jHd8y4u021FKJnWhHvKygujoYjJKvwQrY6OOPiwg1EL/Wp0mFTFtxnWrZh795ju5f+uGUhYGyz13depwnkqEoaGv4jOzkMFVUcW6UwSlPZ4jA7Z646wvVGVsw6X5QRrxFfB0SJgAn69WO+Z/YaftdIlJAbwGDk2TbGjfOfMSBop2QN2tqqPjS0NCYwEB2saBpBRUnlWl/bhFlaANJIp6+t+7YFobJb58qtfXGD2ct+PD/a0gIPoDdzCEy7OPu3utJ8sa/vFZgEJGqfr6mrVry/4tv/AqushhnrXHxiLxGNA0TSSKa79n5f/m4wcsxhqJJu4MRGf+cl084uT8UypywxdgseaQSGBjXy8ff6nikWygoRRSIzVTdgsHUYC1nOcdk8NDB1xT/JAKLvBWpYC25YsHWO+n+zAB5k0aKDHNmcB0BfcH0sMeUyr3DgSs4ZuhVB5MJ58sgHYkUPbOToI/og99o=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(26005)(2906002)(34020700004)(186003)(47076005)(316002)(54906003)(82310400004)(5660300002)(110136005)(1076003)(107886003)(8936002)(4326008)(83380400001)(86362001)(508600001)(356005)(2616005)(426003)(336012)(36860700001)(40460700001)(7636003)(6636002)(8676002)(70206006)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 13:57:43.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9534fe-7862-4504-4b3c-08d9bfd2de25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No need for this dead code. This commit doesn't change any
functionality since one can still run "modprobe ib_iser
pi_guard=<type>".

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 4 ----
 drivers/infiniband/ulp/iser/iscsi_iser.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 776e46ee95da..410df19bdfb5 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -113,10 +113,6 @@ bool iser_pi_enable = false;
 module_param_named(pi_enable, iser_pi_enable, bool, S_IRUGO);
 MODULE_PARM_DESC(pi_enable, "Enable T10-PI offload support (default:disabled)");
 
-int iser_pi_guard;
-module_param_named(pi_guard, iser_pi_guard, int, S_IRUGO);
-MODULE_PARM_DESC(pi_guard, "T10-PI guard_type [deprecated]");
-
 static int iscsi_iser_set(const char *val, const struct kernel_param *kp)
 {
 	int ret;
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 9f6ac0a09a78..22d2586b08cd 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -486,7 +486,6 @@ struct iser_global {
 extern struct iser_global ig;
 extern int iser_debug_level;
 extern bool iser_pi_enable;
-extern int iser_pi_guard;
 extern unsigned int iser_max_sectors;
 extern bool iser_always_reg;
 
-- 
2.18.1

