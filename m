Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0554C371
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbiFOI2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbiFOI2r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:28:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C732EF0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eISHNy/UTjSKOMRYTIM88rrRyZ4Ms7+5F9h7ldz8w8W8/G+SMZtUdVW68CMKSqBVTYXWeuJWRbu6HpeiZoXiSH102Ad2Fkun9si4FfnCqmoRoz/fRol7Pfz+y1mkMo5450RXx0ZPqGpn8QHrgDKlVixpOMEWUcYR4t+c3IsDIE37dqeMlxNUK4moBl+PAiuylhPMJk+gAwYlghitJTMWj8Xcp74z3IIG65X8M7jm8AWtXV2FwCJkA6+iTozlUXGuarWZBAQyMY8xGwqaOK4Er/ELEOenYLlR6bKXrwKwI8TomjW9u0zj4N3LsUMPOqjX24lePC+Hb8qbrcYA5dCt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa/+h42APuX26p/dilcvIguvbYU3QmbVYA3SRYT6Fb4=;
 b=XsNT7AossmufoVz2XpFgKK+cZRBshWIKMQJFjFbdfNFaRvl5pfykv9RuUPxBAvQwGWJOLLoY/8hIs8CgG2GM5iVgSNOvopD6nLeIhon9iB/s7BzhJ/xa/LKv4DTbiFwO+CceflLbwbr0/BR5wbqJpKJfNQJBiGwamOvYosPBml14x0VFZZjw2Tcquif/aR+tZzMjaPx9kqLjloZUdA0++h3+glNd2N/JwBzjjLMyEB0ibTcNDVauzKGsCIURxenLWTPigCwQEdTBF8V3csPs2BUb0SkaHeEFPupLo1hX/ckq5zW/Du5ZtAOHtud2PfqrnkSt2PIvzs2Dme6r0dmHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa/+h42APuX26p/dilcvIguvbYU3QmbVYA3SRYT6Fb4=;
 b=cT2Xj1GlnGQT/QpS2bI30K6JUsZtZ8u/YY6xL/lR8/ZtWQQpzZRG4MCHKlDF0nZ0Y5yLfItkj/OBKwFqF5ZNeYGQtifmVPI/ji+J4kSoUahne8ncYQE4802CtmOX/BRdE3N/1t3AwUJDmpdHQymB5Gi1oqiFX1B2XQRDjwLkGi3Kja9T8N7nr8NpeJ0STbVkPsb50JoRFnXwwjWWtGY6PciGeQD8vBHyfp1FHTLZtuJa7Gm8GouqSkRry8WQ2ciMjhhK0O/az2/EeVbk1j8UYliXmI7aAdsKCQjUlTqS3Q0K9EM4cAU25BhQdcAuqMCh1hONZ5xcEJkOJriAaUI+eg==
Received: from MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) by DM6PR12MB3913.namprd12.prod.outlook.com
 (2603:10b6:5:1cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 08:28:44 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::cc) by MWHPR2201CA0055.outlook.office365.com
 (2603:10b6:301:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 08:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 08:28:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 15 Jun
 2022 08:28:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 01:28:42 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 15 Jun 2022 01:28:40 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <sergeygo@nvidia.com>, <leonro@nvidia.com>, <oren@nvidia.com>,
        <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] IB/iser: drain the entire QP during destruction flow
Date:   Wed, 15 Jun 2022 11:28:39 +0300
Message-ID: <20220615082839.26328-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a16f4d0-0760-4bd5-f9db-08da4ea90f70
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39132EC7CFF91326A95E7041DEAD9@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdMmvIuvg6dwcMl8ydVdafHqQ3k000RnceoWA9ea/v7lwloDz9sdbyUe8NSGc4Fd1mU42wWv7Jhg1i3BY4FLE+ddQbAW8ozpFRMQIZw6kLvsTSYqe7qLrCeyvgtUx6oFjjiOVGc7gMzmGJP1nUi3AMLtRqoz+NuzhuoNMd5YkRRrgwpXKHNErba05jiz4uuXtCPbUr2pOAkhhxwLQKfaKy9QFWsMtm8nD7HV9K1SGAK+RrUZYD6L1HF5k/vC9aJBra/2HtHp4qttTUNypYIBnHiV5Pxg44r7jhVkkRrzrA+3zuCRNLkJPc6IeqNo/G95r9ea65jh1OPm1YQj001RWWNMPAjA4VYUq6iadp0WAjrLU8VgeqWikDCOXE62hhXz4eU4uiPwKShhQrIc0O96D8CmqAN3QfAXUZIKbaNuGZjT8TWbePEao01i8uDs8SfAeUGsGwroK3oVlAJ+rCgUC3QZX7i0ZC9mmmxJLIlg2RLEGrbD2VgLr8cpSZu/GDwMndlOiT3Ke5+Iab9I6Qlp2Xfq5dHLsp2aY65troMVa6h8luYndSiAtaubXoRktYPA2+eQhphxDrtjRKDqfnPg/DLpR+YyenuyW9/x8iOyBn4/wREHfpwDYCOYbtb+a8pLIaLGtaQc0Arc+i1sPfB/F+bMWj14qZbM7Iuq+sXYR9KBSAKBbOzcmARMxjD/D2c4bQzytospidf2f3BLKlo+3w==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(1076003)(107886003)(54906003)(2616005)(186003)(70586007)(508600001)(83380400001)(336012)(426003)(47076005)(70206006)(82310400005)(5660300002)(81166007)(356005)(4326008)(86362001)(36756003)(8676002)(26005)(40460700003)(8936002)(2906002)(110136005)(36860700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:28:44.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16f4d0-0760-4bd5-f9db-08da4ea90f70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's important to drain both the sq and the rq to make sure all WRs were
flushed before destroying the QP.

Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 5dbad68c7390..df3e7a1bf293 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -246,6 +246,7 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	device = ib_conn->device;
 	ib_dev = device->ib_device;
 
+	/* +1 for drain */
 	if (ib_conn->pi_support)
 		max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
 	else
@@ -267,7 +268,8 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	init_attr.qp_context = (void *)ib_conn;
 	init_attr.send_cq = ib_conn->cq;
 	init_attr.recv_cq = ib_conn->cq;
-	init_attr.cap.max_recv_wr = ISER_QP_MAX_RECV_DTOS;
+	/* +1 for drain */
+	init_attr.cap.max_recv_wr = ISER_QP_MAX_RECV_DTOS + 1;
 	init_attr.cap.max_send_sge = 2;
 	init_attr.cap.max_recv_sge = 1;
 	init_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
@@ -485,7 +487,7 @@ int iser_conn_terminate(struct iser_conn *iser_conn)
 				 iser_conn, err);
 
 		/* block until all flush errors are consumed */
-		ib_drain_sq(ib_conn->qp);
+		ib_drain_qp(ib_conn->qp);
 	}
 
 	return 1;
-- 
2.18.1

