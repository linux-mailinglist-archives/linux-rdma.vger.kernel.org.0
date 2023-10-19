Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875D7CF259
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJSIWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjJSIWF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 04:22:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8211F;
        Thu, 19 Oct 2023 01:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek+00DtzTGLSaBo3IBMsJedUcwKYfgVd0E2jh9AL3ZgOOk9QGgxpDS1CP4Eo9XAvNVldOnctWHGq1jBnVkfe5Gwco5kskzFvn66KM3pwzfRW9vZ0520848aoTN4TIpPE167EhiKsELOnAWJIL5Irxo809ZYkmO2uVNGjZzqwlGUulDn9C/E5445yB+qBG/xRXTy0ngjQ4pKoaw7/YUqc3V+Noua5mhO4UaccJyQi1cHkziLlzGfvRhH2YxWLHhNzkhcJYWLKR2DvUJUjLa92VMPhBUdjArEjIvifXL6lUj8yuH5k1I9ITAcoXjY3lpQR/gOsjNj4gjFFW17RcBQVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=ktLpj3fR4o+C46UhWdi3wS07oThtzYwVhCfEoeoWv6ZHGm+wwRCMD5CTP01IM01cotFL7zWmeE6+u8cuzG4awTkWFfql92SCEAebwC+WVADVOw3kXaq2Ngd3vUofzziaVk52u4t9v2pDMuMQVeapmVAW+9vojes9+O0YkajiK1Ymb49hOdOSSeFWWBTWMp6/LJ7Z/sAYK29GeFdS752+KMvTW9Lq745hAWP13tLfKhVJ/s2Dei0WS0oyZTaGXTxURp8KzAl27yVM14eCa2aC5L73sd7RriSsurGfwsZ95Z9VoNvtxA2rGwbZqneA6zz9MdqgbA74vN8sKTjVtz7G7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=Klb9AIi8WAOH+l97zgKfm5ZegnRE0QzOAK8UBkpkXY1pv/vRpaswb/7IeCBDDdBJrY/6I3HL5ra353pHjs/PmqubICI6nW3+MNMYKtjSyZMi+Kx5TD4ny+BsOTiq0lnaw2tk+dnl1QiDVmPBOQcsQjtKGY0qxGy8axbCE2wrfX2HnweWV6wAdJKYNZ37tO2D1VJ72SXWgTcTnq232BQDbg61MjP2I6KNJdXD4nxrHsXTyyk2tiRynwaOSGxLn3fPGzQFJFpIn+E3j9eFxyLtMIQyTPrSJnxIJf7RFbE4AhOhTL5Ss8GpAg/P4Vry6/NRrTHaffLtRH8N+MSgC8mIJA==
Received: from SA9PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:21::30)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 08:22:01 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::91) by SA9PR13CA0025.outlook.office365.com
 (2603:10b6:806:21::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Thu, 19 Oct 2023 08:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 08:22:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 01:21:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 01:21:52 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 19 Oct 2023 01:21:50 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH iproute2-next 1/3] rdma: update uapi headers
Date:   Thu, 19 Oct 2023 11:21:36 +0300
Message-ID: <20231019082138.18889-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231019082138.18889-1-phaddad@nvidia.com>
References: <20231019082138.18889-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: c7efe724-101b-4eaf-76eb-08dbd07c7876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWStwx9QEApwbbEz6dbi2NpIftQ1IX+yaVBK6lHlaMLamZ+bYsEyShryo4s1/mrEP4C9K0J+/6kdUATppTMcBTY2FFeCWnUsQfsUPIB8TYr02Hxhsn69zrK+1nOU4pPKPoSXoPCv0PCHMmQh8uDmqlEe7YVFreHdThIfqfNln63OSsEwhwIfV2eFmmVLJHf30wdLpF0zZxaBz1J3d0yQfUMlUcZihMOmjBXwYI3+g1iotZsJHcE+qwToigvEN+kfOv2anucZ8G4viQ1gLq9r3hZakVKJJlb1Am4FVuu8Io9tg80v7yrGwjtQ95kzWe61voaQIomUWY5i5us1mcYAOVnVwebQFij9JK6GNzYO58LTLyKFihdVPMxGBZKFeVv4Oom87TQjMWaubDf/0nXHgE7GdrFQ6ufwQ+o2Zn0mGS67SiD+9n8m5+cbJ8xpxMEKot3T6Rcg1ytIQNWpLHFKg0bCGsFNKkQ0DsOSgCvDrTKAAlaty+2cxMq2pD/nB8fIAmePb+C80C1n4uiwBUjknUxBADhwTjoIBi2pRBDztOysORdhaH+gC2Z9m9xk23BoqiSCBXBDpFBw9pMv6m6PXlleQZg1PxPVBPDau2VTUs4eQf+66C6CJn5UMc7xjbSOAh9lTzFVw3Iwu3YG8/oi5LV5cfrDCh9i6CW5lnQSQGq3cARRfPs6AcuGUMgn1o3syAuUw81eHAK+usJD3kcEqhwR1UUL15+vmZuzelc9IO/g6omuo099k/V1B3NM9yiu
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(47076005)(336012)(40480700001)(426003)(356005)(7636003)(36756003)(82740400003)(1076003)(26005)(107886003)(2616005)(8936002)(4326008)(478600001)(70586007)(7696005)(8676002)(110136005)(5660300002)(70206006)(83380400001)(54906003)(2906002)(316002)(40460700003)(6666004)(4744005)(86362001)(15650500001)(41300700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:22:01.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7efe724-101b-4eaf-76eb-08dbd07c7876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

