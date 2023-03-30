Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6E6CFCA4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjC3HYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjC3HYL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 03:24:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AF35A2
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 00:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzKvohDPK0GqSazzrVdl6vKww9qiJVAaGYcUO74tDJHq2e/exkyQV7EenBiV7jehElKH33nmI+CuqBcvW/J9sBTP4DB/olQ4yT8DyT34OPnMlBney3AKrad9+vSkfoGUHRN/y6mUlP+XVTJm4jHfAedxHOKZmBdz1GrKhwEUc9zvAQ3Xr+82im/pyYvVkMO+Xz78qDfRevGnwiix66EQB3ufYMIkv9mAsNe84M3YKBazFbxKGB5y6gzeclmFaKlKipu6DhLhsMt2dap01XFJNWnVXJp+t6R/XEO6nq/8o8oRGf0KvklnrGPvz0TPT6tbcCE/4Hopxwhn/L2gHgkLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq5+24aV64CEb9eJIs727e7xv6oOE6Wv8VmeTs4EzrM=;
 b=g0w51p6fJLgf9vY1NsH0cqhiHUS3c/QBgvHZ9scZfOXdMEWMCIPdFnkForwzoOBPPKL64BxHralBkWhFHvf2hLnXZPMIelksbE1jSJN/Bi6pS3+0que2KZboyx0q1ZE0YaBC1NnCY7OXg3/a5PZPvm3SFBJu6dIF78YkFwXbc+x9zCeob5I/YyQh1Wy2c2uo8hYxtHRT1NVgDOe9CKthRHYf4wHF2ZBTaGpRehxoSAGyWfmBUCUFewZ/zFzp/6NgyHeiaxje5vuvCtzib7m2iWgVQBxMIb2lv1+BPNHgAsiE2eNEmbSiny4UX7q3MjioaVM9IByuHQDrwu98elWPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5+24aV64CEb9eJIs727e7xv6oOE6Wv8VmeTs4EzrM=;
 b=Pv3Ipm9E3c93D2clVWY5+q1oqRuY/b65+9lGttTtTb8Q2cN82yGKDj+gLlMgIE67b2siPK8HA7nCm54du/OqRb7wurtrjVc15pr8Bc5UB1TT/7pxBMqnTy0mLuux1R/XXADtvRfhBPoXGJLYq+xdTr0YR/ssaVibb5DD6s3tH5wXpWxfWc8FT5foPxLuOpXsWUkJo9pxsm2KiSu3SeObFwWqc8fumvgIRuhcF5SjUd05WOgC1GUQeTRNNFiEqX8A+4ZnRdOdIjXhyMW0N2TvgXx4dz/LIijCc20SDNd4fGbvS1V75q+BNPV8XPtEHUSnZm8DdNtItJ/G6edVnWRSCQ==
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 07:24:08 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143::4) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 07:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 07:24:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 00:23:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 00:23:55 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Thu, 30 Mar
 2023 00:23:54 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <chuck.lever@oracle.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH RESEND rdma-next] RDMA/cm: Trace icm_send_rej event before the cm state is reset
Date:   Thu, 30 Mar 2023 10:23:51 +0300
Message-ID: <20230330072351.481200-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bd56b1-a19b-4140-7e0c-08db30efc042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIEdiht/D7K/smlcYR5MBb1bgG/MjxKc/X/6LwjJi2a26eqFN/VWlmHjIVrv+k0E6VvzLiaKeBWM0CvE7AGRlFNhlN/LlOk3WXdjmQSFAtDKVro6LC8CR9yaWuhk0slzRpX72U+eTZH++G7zdfxahbKbUtTUqwGJMLgy15m/nWwa4dNrLYSlcq8fYpVH+D6JFvTPy6eIcbTgx9rcut83G3gtpyjo7ucUwzPNKRrIlajdEQ4oCOObHkhBq61ZBzxZ3seNMEr1nHlxBTAS25ewJWZeFV7ELCbYaBK5+MEmEXZJ1cP8sOHuc8lFDvVt44UgnHuf+fxb+ZN6ipJvih9wWmDNvJmB78+Lpbot6OPcthR4E42XdleXYqlUJu8mhR000R3CGL7Vi3AxH5vK+OX3Go9I/puD3AlHGU7zVIPXOGsvHBDtw74pjIGGzpBxHWSAjXoFSTshJ0F0x692cE2dCBgZz7BB1yw2jsnqVGogXzl+gO/O/9GyEPs+k0ImIhBQRk0Bsrxl3MlGcZ568pPjeF9pOYb4r+fN+WYen1R4WVHxfad5q0WQzWCHuYSmaYvwqw/M+J1d5BxYKau93k6Coi/E3a/Zt46lTVSsAU0IBs7OPmnRg6IFZERW2LirphLAE4fcpK1HKF+CxCM5BVTXlDmxg+wgiDcEJFbRv+InypU9gPHYrWd7IcIwOlAwYz1aF2JG3hRT45n4ay753+NjdJduZ/TVnotf4NH6hEhceo22ZX95VMMGIzuPFqCL/o7ITzKjhHbEFdWzd6XGHlHa+9FMQK8uExnLrhaSgVqDgpI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(107886003)(2616005)(40460700003)(7696005)(1076003)(36756003)(26005)(186003)(47076005)(6666004)(82310400005)(40480700001)(4326008)(86362001)(36860700001)(70206006)(70586007)(8676002)(41300700001)(7636003)(316002)(8936002)(5660300002)(356005)(54906003)(6636002)(34020700004)(110136005)(82740400003)(426003)(336012)(478600001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:24:08.1769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd56b1-a19b-4140-7e0c-08db30efc042
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Trace icm_send_rej event before the cm state is reset to idle, so that
correct cm state will be logged. For example when an incoming request is
rejected, the old trace log was:
    icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
With this patch:
    icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Fixes: 8dc105befe16 ("RDMA/cm: Add tracepoints to track MAD send operations")
---
 drivers/infiniband/core/cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 603c0aecc361..ff58058aeadc 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2912,6 +2912,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;
 
+	trace_icm_send_rej(&cm_id_priv->id, reason);
+
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -2942,7 +2944,6 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
-	trace_icm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
-- 
2.37.1

