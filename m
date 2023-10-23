Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2866F7D32AF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjJWLWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjJWLWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 07:22:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD87DC;
        Mon, 23 Oct 2023 04:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5y4tlGsg/+yLFzwVqrSiOTWJmFH+S019+ng2VT8bZ/y/tHyMK3qeanO8KrfaF05J3hzNjweFb5hwXmqJkMAAoUsyx8PEhLlDlYlQVTjhUmB8be4HYtQN5o2nRCUfWggfxV2Hkxb2RgPQ0Iq6/ip1U2qjBvNZ2ULEzpfGgCsdKBnHAYknJN75Jwvi7BbuQAGj36likPqMoUsGVA6N7kpyVy3a33N33LWoyxReeZs/4TkFElNR41m/F5nUTHsB14G9goUA3VUSXNLg9F540+g+53mHVapUjAxpmGdLgt2JUVDaDLVM9ydfpdzvwVLSm4vBFolQb4SEka4z5+DE1NyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=ib/rqb4Tcb8K3EJyLIRENzXbjhqkuzifngSNkbSQgDrH97CeqOLVx6X8gEfuf06nex/6gjcVqGHlT/D+JdlFzVAwHCaUWROdVHe/R8tSZvfqEfbKj7OKh4fFgFrJDyogrEuk33OrtOkKUNJfk9eVbknIdnXZ/qpW/EKN5im+KR75WlVWbmkU7zus//m45x10szDz9YX72N7yos/SJBTJ4jO6nMDOwycEwrYozxOPA9meQfY7RTiUEoAxpg6TBBDCIK8CuyAlI4c974vq7ekKW4K1ZixY8kHdL8rBRs80zbyUKRIUSwMchNCC3ecRf/vBkPVP+WZgKHdKUxrpiDATdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT5cGa1kYFuFJ4qwnSfU9RogM8ZgzHTquc3/GC3tuu8=;
 b=tCKADiI3PailqbfxRil4q8gNjzrVg9LOJt6h8C1rLqsFCzqzYMXy3u2pUtEcx+UYsBXgKzw/550gogcXMNSa0F/I5zqdviaBgel4iDj1nElbYgoCZlafvZvPO3mTQK9YzAjLS5NrrbXIkxdiZ6OhZnLGKewXRPzRE5U0PmD6Vc9d/P0wv5yz04rMBrAMSfju3E3NohvxQa0GJwIfbPbgPB2I5wQrQp2fkqsLSDJVCNIgfHgJMIkfCmAAU0l/DJ4GorAA8LzDFJ+bgzPv1rJrt9CSjb20bEE5eG4Aeew5KMAcjrG4dx6FzdglI3hTTqXRENXkx8Wsh7WdI5+xBcGjYQ==
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 11:22:45 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::eb) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 11:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 11:22:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 04:22:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 04:22:29 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 04:22:26 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v2 iproute2-next 1/3] rdma: update uapi headers
Date:   Mon, 23 Oct 2023 14:22:15 +0300
Message-ID: <20231023112217.3439-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231023112217.3439-1-phaddad@nvidia.com>
References: <20231023112217.3439-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e122a1-3db8-40db-e804-08dbd3ba6185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzCAF6bI08tlsAP2dUZDrdAKsplzs48XevEnSzLZfLaThYoVJGGl3F7Pp61qf6IGxV9SksI2iFELL7/hPAL6ZuyJRdbLWjD5TldqDnV506GCVGIM2MVd1wUVo6YHf/ibZhnhTpZWtKclCCRgIU1bX5rcM/y4bXemP6AVM0rerwOgDlMeRYo+4+VNSoGpkmsPwtx66w3Djwq6V2EUUimliwB/IU2wrMJHvONyYJVWHNw30GwPcsiSEni1GQ4awbpid/VB7Aqcd7BU4qSQV1Z4wtfmnNJJVauRJ8Jl80g9olf9RNQ5GhhtsEQPqIoogDpd5hagpzi3KopQw4FmafOjFdf2bH0DUDL/eWvzoSupkK8nOcrd7YvcJ5FfhEZl+9CIEgdLCqIRfzAmcxwTZau3zCLDRYS+unWZ+NamCwCdOwyIzCI6pv6x8oMWHsLogRFjr2AMhhKXsgCQDpU/2N7O96IT9NI75/kfab1PPrcvvkyL4/LXNgDku7RNu6xb4pqZJNW4ZPKMbUFCvmPqbhYw/jvS1VFz9UKUKyEKwM+Q7XbS+8LgLyHDkUHVUMZ9sSVWiy4Y7KOCL1EORK8fgo7EvALalSFeu4W3Qw3kHPtRWAx+sBIKz/k9KbZO4SpW5uLrTYFLMGRg06Br+3Xfa3HkfnPJyzHVFs6KIfzlJt6L85QsyLndTkvk3EExMv0KCmzHFCME8JrdehZNDmWC1s3Npg3rIUr/MtjImTZjKB9rIrAAdUJ8Z3Bqfq7hIbcVz1tn
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(8936002)(41300700001)(356005)(40460700003)(82740400003)(7636003)(426003)(1076003)(2616005)(336012)(107886003)(478600001)(8676002)(70206006)(86362001)(4326008)(2906002)(15650500001)(4744005)(316002)(36756003)(70586007)(54906003)(110136005)(5660300002)(6666004)(7696005)(26005)(36860700001)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:22:45.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e122a1-3db8-40db-e804-08dbd3ba6185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

