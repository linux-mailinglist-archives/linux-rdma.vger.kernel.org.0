Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471276D062F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjC3NNy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC3NNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:13:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA42AF1D
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfLYKtV4ft5Qg3YYqHuufAhu4iRYbrqr2rJJjZoa6pLbo7Xa4DdPlEj94RAXJKQRO8fYBIynVdsXFtNT6Nvzo294/Wq+vYLAAf4nOg7pXpOooysHe5APuVTWWfiGZZWJEROUscPQPG61Mm2qFAy/2IAOlgJFko1tBaiZW+FVnX6C7qPehyTaSYzq50I71jsomjf/q/7OA7tUiNNOX6ERTBedR9tkUbtNW8aDoCOzzQr1/VnJ1YNNSZ8PBmh/+j7kX9BnfUksNjvelV4IBpfb08640x0kMCsvPET1eVxxSA2mDNak7NbEotydggHCGLnNhkgz0W0C/KMmRrkr8yf0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6W8y2/d2QQJqS2g3SEgm4WE5Xlj2uDgwT4EPBVbxrA=;
 b=kR58AdmcQRekw776lrpp0iNPh6i53LfD7BUhyPKbopht3PUYp0lZ032GXUPVXY+PqRvbdKNQfKPzhqRp+aibIV7V0tR+b0X6InKkGMnniT4v+b1Nh++qeOhpsLoQg25wkPtxOQa5wM7UhMTP/v5dLBGT+yhgkqb8NiYUfoQ5F+zLeFpbeLoyFuSSwL8eJJauORjorea6pqpDt/gmrsN6TDRUTF+D73/CqB/McGBOWeIG8xvlHhdvh1e4UHnzBdHQoVYbfbGcNhCeUD1pNZa7lYnYrQdr1dKavAn3lpxboLy2VqoQhHY2dbD3QlxhLQBpBoKZHSZzJebRVjTMs06xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6W8y2/d2QQJqS2g3SEgm4WE5Xlj2uDgwT4EPBVbxrA=;
 b=YeC2sGj2Z7uzrsSYcxjDzW+8xGUQg2MlHi+tou/BeN/X+56M5x9ModJGS3a30o/KVskwGqAULSFQ+hiYaOpLc6MCKu09Gfw4uzjcHZ95PDUZQ+4CS0eefRCvAyXlbWuCqZA1G3DcpJUObez4UlG0C01WNW9r6FK2TEdmx/RQGBrfzS3MILRg5n3qzrBJa7wtuEX60Daii06jb1DzwJA9zGKkrLo1OBkxePcKC9IQ9XQdbuXj1c0NgPdXgaluxQyTJNAaUSOgrCJWHdd9N8WMW/IDlj3BZrFFzXtD1VzubahXgE6uVPYntfXd/HA2WzhniVqWC+WRnW/H5xHDkXyWBQ==
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 13:13:45 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::14) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 13:13:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:13:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:13:41 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:13:39 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <oren@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] IB/iser: remove redundant new line
Date:   Thu, 30 Mar 2023 16:13:33 +0300
Message-ID: <20230330131333.37900-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230330131333.37900-1-mgurtovoy@nvidia.com>
References: <20230330131333.37900-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 23218639-7ad4-4358-4527-08db31209730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuvpJ37V9VkWYB8xNkC4QIdQEULocVssKV0/LrNqycfANUlQf168Tfkw0vOIFEyxVZIa7CYBZ1Uu3NICLu4uJByOyTQdS5xkAaAp7zVYvp7KX6RLCtLRWzE35e3Ow61RD2BOfAaIFn9h/B9+YnoHT0y1YVblhahjNa9R3yXwTJxWW+GdPZWIgtTvMmDqPBao13UqjfZ4S1lcYkWvgptm89AXC783GAC75pPnX7zxk59qxNkUR4cXPjwGYaWy+eU1EKLpO6mBvKIVoBBoXeRumzDeNxWiiXmzZ0iRKTEd2w5PcxsKI0+yuf23zsB9Hk9CA14Fzvt9zDt12dRKASH4f4fCSjVMWnd8C6sCQ+qyX0Q3PRHoj4NefAg9ZTEzmLVeOcKW8XwkgYHxG3jUsZ3/3ngqRbXrzNu7XwZ6MNTIYQ9q2R9zeUFh9VWKJjSR5y7FwHnyfcCxM322tG2RiXswuOI2UFV4q7ToL7tBQ4AfnkB/CkUe+HZ7J9Td7ab6b3Xrz2QIIKhrOj8kvT+RUmc3h+TNEW9+7Bj4yYzkLv2QQfPr4I9YOZhTcgfHygWc3J9YQSbHf9Z1t/WMxu1JppQ50bN0tPohKfWnmZw7D5gTGLDe0kRgF5dgFPcgBVgsHKLl+FN2X7weTAA39SCuvLR3gMI/RV6uxK4AcQBI7SfdyigFZLT/6/jm4JHaSKj5WXbSee9gGm8h9zWlsw15VvewV4hJgKVd50sey+2w8uuEl5+vvvYtBJ1+eO8RV6iqagObhPA8GDCpZm2Ry4t5nrM6Sw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(316002)(26005)(47076005)(107886003)(110136005)(6666004)(54906003)(4326008)(6636002)(186003)(70586007)(8676002)(70206006)(478600001)(36860700001)(41300700001)(82740400003)(4744005)(356005)(5660300002)(7636003)(36756003)(2906002)(40460700003)(83380400001)(40480700001)(2616005)(336012)(426003)(86362001)(8936002)(82310400005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:13:44.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23218639-7ad4-4358-4527-08db31209730
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This commit doesn't change any logic.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_initiator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 354928408399..39ea73f69016 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -460,7 +460,6 @@ int iser_send_data_out(struct iscsi_conn *conn, struct iscsi_task *task,
 	iser_dbg("data-out itt: %d, offset: %ld, sz: %ld\n",
 		 itt, buf_offset, data_seg_len);
 
-
 	err = iser_post_send(&iser_conn->ib_conn, tx_desc);
 	if (!err)
 		return 0;
-- 
2.18.1

