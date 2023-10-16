Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF907C9F87
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 08:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPGbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJPGbj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 02:31:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72209FC;
        Sun, 15 Oct 2023 23:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/n5KUF2S1UlL12PL4DtBlS0stBMYh1u6itN9YI7ty4MhYQilup+4ntcjL9qGKhJo+Qya693tE0X78Gu8krH4XN9nRQbbBK4hXhKA2sLovthbBI6dYYwod+vm1QDgVNQ7sbe0VR+x+bT4T2bg2Hblk4eADmLYrhK/k6+NCffr99cm7ih6Vns0UcT1vVxASskvQ399/iUdN1eebAdYHq1sC7gMgBYZdF0Fl8xP7feyIHszsQ+RyBfGKjdCWGBsOiOPO0UTjJpPbsf/ok4AoCj5kxq8Sr9YBgb4sfGaHF2cQ2x9H2h3rxBn7oyTfD/zgylujkE+8UzsgU24ezHPx82qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FftpG80GYZ16N+T9TOjTVnrVmxkjoKJgk75CY0eTZLk=;
 b=jJbqlXnAa3tFQHiHnQ0C635oft+vLl2aD6i5c2jbrtQaN7Iae23m2fg+cCPkVsIOo7gR2y+DiQq219FUy6oFJ5NZUOOeMvcXunLtCFta6QBqKlhS6cslJ1PSGqG8mrsKjhxq5XInMzqGB4qOTARwbsuvRJidH6BezM/xnfPedSEABZ+RwyuF4Wp24lVG9FT3xZ0n662V4c6WSCYjb8CPxQnOf3XSgR+YrE/g3MSuYrnpRc+NY0bCR3Vh/TKdkMglJTV+70Ws162b5JNbnrkBT/agtEeU9n5mmhNDSBPpxK09bBDnd+qeZN676v9VSPIlpMjvIKjQBaKO0EAYeZa27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FftpG80GYZ16N+T9TOjTVnrVmxkjoKJgk75CY0eTZLk=;
 b=e4ZYpJPIC+GEC1LTh1P/eD4o7U2UN+vc/BeBTKph0qk/UoISNSqDDieCMbp4lcb05/WWRnrvveBXAV6BnQnDQXPCVxNI0kZBHl0KX7eyz6EdZVXavJZQWVkHaYSh80K5n5n+YCXISTXOCmzTtgIPe3eVlU99oReuC11+OsHYj8+GKwfsRV6DHl9slA+FU3g/bgdu5OtAAgdXTsqdpOjLh6wjFzQoqNpgCcg2b6lVNIOS53+s4n94upWJY9jIk4/kH/Yn8HsA/CzGnS4WkNwkuH7jCAg0ZyNZFVh7NMI0hHMo2sITvxzeiLjAUhLMAQ77STSSlM0/Wx/iX+PG+Lp1mA==
Received: from BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 06:31:33 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::ed) by BYAPR08CA0022.outlook.office365.com
 (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 06:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:31:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:14 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 15 Oct
 2023 23:31:11 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [RFC iproute2-next 1/3] rdma: update uapi headers
Date:   Mon, 16 Oct 2023 09:31:01 +0300
Message-ID: <20231016063103.19872-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231016063103.19872-1-phaddad@nvidia.com>
References: <20231016063103.19872-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM6PR12MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 387683ee-a874-464b-b968-08dbce118a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS4Mn0jeetlIVlD07F9GAgy3P/49prHxV1s03m6lCEf3M2L3rXgOeNYi3EgPdD4ukLEP7fE8uF6V9eAER8GRIJRjKG10ZCulzJDaZ7MtY4Awom1Hz12gaQRh522g6FHOk1i4S+RWVPJGPIiCk8CFD1wNIt66NSUoSoXdeTunsSB4mZbyilhwbeJug+J97nU99SEc38jBxy3E4LdeHhI54omb9mu0MXsphTzwhlFvc4xKBs/hn7JvWxRDE/aCGge7WMN1CyjCiZR9Bg+TNCWwWm3nRbxetq+dNDlI/Is3ulnAJXwx0DTX3KTbmC2qkcVbWdqd+VbdoY2bu2uZyzMfnpyE5FrZ2AYwySDE0NUlzN9FQoDaa7J1MwHRMD90JtIWugOqFfbdVEPzqtZVXE7xqYKGWNUlZl1L3ofHlyf8P73QOJFV09Q+mkTxSItt+arxbEpgNZGf/8G4v7VW+RwnJLhj6t51B0MFuRS+pmjY48h9p6Q4uA+ke5L7Aih/P73dC1qN5UyYPJhEmFh0vKneU+7eFQBHn0EShFcouN1b3PPeISYHicoYcxrUDYiV8XZObQdBpgK7pR9UNteqnRqAxEiUpK2IA/oEA5GBrN9IDdEscNG6EJm5NHHMPpIvQot1y2mt3DIdm+e2enPw3eulvRQ2Q2+A/qMT9KMxMaOWi7NTzRHuOUPOebaGQo12AbjpbYvzQgaQ3d0eSxswje+t1qjTs+ffva2ia9gpncMIgzxNGPZYMA6hECBPdQwB5waI
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(356005)(7636003)(40480700001)(82740400003)(478600001)(4744005)(2906002)(6666004)(7696005)(316002)(70206006)(70586007)(54906003)(41300700001)(4326008)(5660300002)(8676002)(8936002)(110136005)(15650500001)(107886003)(83380400001)(26005)(336012)(426003)(1076003)(2616005)(40460700003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:31:32.6407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387683ee-a874-464b-b968-08dbce118a00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update rdma_netlink.h file upto kernel commit ????????????
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

