Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886307D6BBF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjJYMbl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjJYMbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:31:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDD18B;
        Wed, 25 Oct 2023 05:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KScNn7p7KYRolwKV93LcUsG4xzSt/FDtiFmN+xRVq7pDbhG+d4k29+geEnyJhCl1L3UMPX8nTD6Em8tcZ8ZXBKRlltCMnbvpI0SwWFS0OQy+YKecp/Qgj8u7eGh2IuHrLxdsBSuEHR7mPBYAw8EMDspflIavi21WwCWeK69MG/7F5WIliu3kC/enqfu2a7eUXNr1QgglR1xUk+JsGF/DdRRwhiL/c/z9rqUUh8CNsCKnh/x4D+fbERhPJPyp+4Kl2/EUZ4eRF6pNYOqdCdA93Yj7mkE/IFL6kTFhje7uskdC5UJhwQcfiCB8Zn/UyLG4zH/GIx0PR/sjZpDcd/RX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=mkvfOzZVpsQR1P77ButKRkiCPDJZP2vS07suAvUOBmteAzQoPrSqrhvR/5lWgsAU8xujQ48rlQoEFPLG44aakh44sfAdyU+8rJHXo47pz6f7KMx457bGgHmxTeHH7Elaw6cLb0o8j6zAQIrUF3w9tk3yP9H8vQyQoarlJXigueDmRkD1Uz8gGE6p6sheefsdWKILWoxm2qaBcPdN3GYViRM7J+cf38/HSoUm/L/EkS1Nb5CWFRZVPHjNB5P24kPb2ZEuQt1txI4xZF2NgxM6OBjLMFgipOrIHyqzkyPb3l1ARCevh7KR79dyLC9jP/Q1SyZanxBHlOaki+7IdeTIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=shoWkeZyfzWu42gmRQY+MFU8iu4pL8G4I8EAnbKkdzYHrzBPDYG2LzkYSWiOckgaRZXlVH+4tzcjKV0c1+QliolSt+JkSggUsiOb8hQLuyysmkqXnvzzRsvsUf35wJg4bTtwPT7Ihft0WRJxAWPuWcs+IJ8d4iYzg5CDAGaGxFpPmHUGww0NycyxGU7Ll6lT4inCWRVQlxClOndIn3YhaGAsZVYY8WksNwpnW8Kx7YFIUp9FpJH9+gKDWXC+HxShDGkmbccJfLOGYWeuvJE3wOnD8CBei41oWS4jaT0wCy3HtZ69HVHrhlYE8kA7PJXJtYxMv3+UKaM0eXeWGizPhA==
Received: from SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 12:31:34 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::22) by SN1PR12CA0099.outlook.office365.com
 (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:13 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 05:31:10 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v3 iproute2-next 1/3] rdma: update uapi headers
Date:   Wed, 25 Oct 2023 15:31:00 +0300
Message-ID: <20231025123102.27784-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231025123102.27784-1-phaddad@nvidia.com>
References: <20231025123102.27784-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 599024c3-2bf8-40b3-45eb-08dbd5565302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y01+X3f4u+mMnB9e8vBWPwOgcGMAL9C2iIwwHwsyUAniQ3OfRcPiNB2O34KBW07nYMfcUoS3LTKx/vt8ZgKzliZ45GNgbJOhIBk/MIp6o8Al3viiNw/BBaYGQUR3+ttIGMULx1uw90fUq8fD6Qklws1BHxtW9lnKnEhFTNGv1josYXGXFw91lexoT9oAB8/B/RKmjEHb2ntaZfoeQnkbWKnFZidur3Tujw/R+OPGS54m4fyMpStImH+sTQM0WVqnk8EPcrv5JgKbR/8gbvih2+ZR1t37XPnr0zxVwicWKU9t11GyVqzx6YUM2neY3+p1elGWCxQPd7Zm0DjM+Ux1hUCnYrtGyiUzLdxcQIGzSSa0Y24ey+xDctLqK1ayyZTs2gzqjnkLj/MwqcdtSkOV3C9yI0eqqXUPFXU3ZYFuC+RdMMavjlt84DCFcs/pYavlS6ASk5E21W8UOfJ3InFx8ohqBn3wuUaIBub2v64LZInViYae2PWP7i7nZP9shxmUCnED+G2Op5+QJOAHgJM5kAY2WgyZGh+rnQPjv8n0dL02kX+7h76OLK5Ijz3sQn1L9DaKqzFR52Qha8bYKCRGUPoJHNZNi69PljWghIOAS9p4vL2kIH/j/8vphV991xjpZnOSLqocJEOCV8N0pK+OWV8T3r8iG5dw+UawgnSWDBGff7MemTMWYIdByHngfyYdqKQIO5n7l6uob/4TCXqq+nUC6jlclH7VtKstt05PAtnFu6YdvLawbgeIeLH11GE5
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(107886003)(2906002)(4744005)(5660300002)(82740400003)(54906003)(478600001)(356005)(316002)(110136005)(70586007)(6666004)(7696005)(1076003)(70206006)(41300700001)(7636003)(426003)(47076005)(2616005)(83380400001)(40480700001)(86362001)(336012)(36860700001)(15650500001)(36756003)(4326008)(40460700003)(8676002)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:33.8368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599024c3-2bf8-40b3-45eb-08dbd5565302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update rdma_netlink.h file upto kernel commit 36ce80759f8c
("RDMA/core: Add support to set privileged qkey parameter")

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 92c528a0..3a506efa 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -554,6 +554,12 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX,	/* u32 */
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, /* u8 */
 
+	/*
+	 * To enable or disable using privileged_qkey without being
+	 * a privileged user.
+	 */
+	RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE,	/* u8 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.18.1

