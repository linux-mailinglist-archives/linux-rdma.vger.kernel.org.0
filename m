Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3412F6D062E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC3NNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjC3NNv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 09:13:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AAF8A7B
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 06:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9Pc7SdIZAj3rUBCGQQRjQNB4tyqxRYL3Gdr1uJTmoSGO0T3qVbikaeYb85S+Dnqwua8KgCKzpap09JTpm4v0zK0FZvvQgltmWsx+LUOFcESr1VdWxLelkM/3JbPkYFQo8lKHq+PUUpb2CoOBe4TfblRQGdI5JMfsMyY820U6atybj00RGECf96+mrm2/eFXCwNf30E3cBEXcqHl+YVOkztic797K0GAMCb58CMLzdMvr/XQWIDoTR3u7J5W22eNlZSWjsiQLNI9ES3ZG4DjduoOtV+xrtlI3CKgtg9ebNJWOGY1/MICQMa3PHuOk0cSBHapQHaaM9yx1G0nzBtosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95bSpiYNBq84mooa77VzcRbH3MGgwiMkhQb8/pmxTg4=;
 b=FNlPEBvJnUn7Rsl1rn+zdaGZmGoochhsyNVSuHp2uJrf7xg8si1/jnCLAmQD7/IcpezysF4y9OgIddeMMVkPDDPAvPV3icmEerX9M8NeYWMQ+f6AeMEtQnx0JCAhy2Cgx0bSWeG/tymfmTU+HhmZxRVMJe0Z24LdZIo5Mnp7cOZf9FlmS0L45+46r/vxlCAVoPvHuVIxOBu/2BAOURQmNERRWwUIpVzwPFIGrNzRCyUulQqiUFqloaUuapaQQlwGSbOJw9YMR5/u2VfhMnyMCZfDnju79qjMHxAbi0BGkW9aNxyJQ3QOBcxBhh4UKcjy6PoneKfwKIsayCsZ0m2NcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95bSpiYNBq84mooa77VzcRbH3MGgwiMkhQb8/pmxTg4=;
 b=RevU5cn3eOYWMGeuCOArETWBLJLJQEL/WCCtWcOetbWFed4uIDNNN8yhK/tLYD/g5m2tYSW7IoNwYdOKgvq95y2yupXq6GVh4uXazE3BBLyllWgl2i++KReudOsui+/Nlr+lnabpgDLwzynxowAkBEoQerzDXUjzms52Q5r6huDYomjt24T1zz7/wFI7cRNlQcv9pMmjFTHU1pnFEgFAhympwxajJX16rvy+OXCcKZwD8ovstVTwiVnWLvbCH1H/mbMwVwo0OuhTHhSvRtczssFrb2U/gtG9hSTrmbqjl3IOHbOUIBuQ33ViPVhmO3nthl5/m870vKP7Aot1ByW8Qg==
Received: from MW4PR03CA0210.namprd03.prod.outlook.com (2603:10b6:303:b8::35)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 13:13:44 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7d) by MW4PR03CA0210.outlook.office365.com
 (2603:10b6:303:b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 13:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.23 via Frontend Transport; Thu, 30 Mar 2023 13:13:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 06:13:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 30 Mar 2023 06:13:36 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 30 Mar 2023 06:13:34 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <oren@nvidia.com>, <sergeygo@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/3] IB/iser: remove unused macros
Date:   Thu, 30 Mar 2023 16:13:31 +0300
Message-ID: <20230330131333.37900-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: b456163b-b726-4db6-e261-08db312096f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjJYhNZgX0KNOYPNa3JESELjHSjrzVksgM+Z4e/hKJeUOLixTc+fPdQOc3rNkoO2y0gYgEXAAU0ekfUrYlD4iJHETNy4p6W7cwKXtOyN1YuHCcrAbrHfpGNgLCqkn8i5z2cDPo6yp/cb3+p8KR1SUa6c1QcblhNHEFoBm8ioWpSepOfA4h0lJx7C59xD5nwP1Fxz3tGkqxZJYzPU1q/5zFTqhDVrMxt51JYSfe9C48kH/ghBbT5Y4DF3u8nWZBA9RqUBruBIhYMlx3bT/6QDnxOVo3skreWSZntKVVQsqxlfr79wtnQCrsFFFe1HU8pPB9W+vsk5/5keX9/kjtwK5qQqIPsiBa8WuvqhNKNf93t+JH6Ht38aewrC/5U5TZB/gpLIrm7d3B+fe7QSr7fL5LX91TC1lVcDzpgJKBkT5DkvCPeZ5S114mz2owUNaKX6uW59mHTSlc3btKA0RaLDVMGvrcBd/4fIlTS6WXoUov6IA2JJeKfOIKfeQPDmo4FnOQ4Uk+KYXoTjTW8mykMPX1xFnXo4VUhJh6qwCKIPh9/mRBidl6zV7i8bSGCwMqCytUEhdTAyPuPpBDYiD44M65jw6OwkrIQxUD85FTTsvEU/muEp+6QGZ9DSk+GTq+kRdbZU/EMlZ+AtY5Gag/yCuS0dGjI15cCeD1FwhaSeN5AA7BELU2v86PtkgAXkVp+8Vpnd8zEZhjnjfb9oslgl3MPXgnukRoElmsVs/8TTHT/DZi58IdWEw3KS2/KRExXyV6LltRLg46pB1CNCsNzbEuOVJY/45m1TISrQmdJc8Z+XJl3e9wbX5VCeDuVTkNRM
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(82310400005)(478600001)(40480700001)(40460700003)(82740400003)(54906003)(110136005)(70206006)(70586007)(36860700001)(4326008)(8676002)(41300700001)(34020700004)(6636002)(186003)(336012)(26005)(107886003)(1076003)(47076005)(2616005)(426003)(83380400001)(6666004)(7636003)(316002)(2906002)(356005)(5660300002)(8936002)(4744005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:13:44.3530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b456163b-b726-4db6-e261-08db312096f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The removed macros are old leftovers.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 1b8eda0dae4e..95b8eebf7e04 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -37,12 +37,6 @@
 
 #include "iscsi_iser.h"
 
-#define ISCSI_ISER_MAX_CONN	8
-#define ISER_MAX_RX_LEN		(ISER_QP_MAX_RECV_DTOS * ISCSI_ISER_MAX_CONN)
-#define ISER_MAX_TX_LEN		(ISER_QP_MAX_REQ_DTOS  * ISCSI_ISER_MAX_CONN)
-#define ISER_MAX_CQ_LEN		(ISER_MAX_RX_LEN + ISER_MAX_TX_LEN + \
-				 ISCSI_ISER_MAX_CONN)
-
 static void iser_qp_event_callback(struct ib_event *cause, void *context)
 {
 	iser_err("qp event %s (%d)\n",
-- 
2.18.1

