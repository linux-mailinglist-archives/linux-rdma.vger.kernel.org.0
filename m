Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AFE38E2C3
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhEXIx5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 04:53:57 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:26720
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232426AbhEXIx5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 May 2021 04:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hD849xyj2Ese1FwG/JN0NPlWl6w9Lud5zcB8RQdyeXm5nAxFccFxyVhklkKHbeYVvdT06hC2tJfHjLxhlQheRQ6VtJ+jYcJwZnBhN/OVubuQHArMtLrBeBbGDLFHbGGA3pf1YGrJoSwZiRj9nG0Id+7nkRaNmIt/H3IEAPvw3qZbPdffi8Plq5q1SEo/HqQg6GCUNfa96CbGwi2/n0ZuEL5chOZIYM2W3+5JOH0MM8ZkPxRXj2hQZOTkfcXDI+MFgSVrAIfYLH8c93+4Rq28ddP1zNE7anucX11jxY1RqYmTZHX44WrRW23d9stAP60TfYUb9Zx/QqtUhlCzNGejUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO/m5iG6WK3fHqCTJww14Nvr9xdj3Lsvkaum7pxxn8Y=;
 b=Gt9+jWbmnNqPzVL1c6BIHp3HUost6E/SF0XNuNzeNo2C0DY5igJh7zXaiPsVS7VdrbiTRa9a+mRmkcupnCo6VWmBBGf0CfnS0sMYkBj4OCPFXqR2c9C2jp2MYBqyMQPgSv0mTGg+eztr9nJB/+mXR2bCh5RsVYKCtXVlHKlSk+iz45LXU5eWpCmLYZf5R+d0fR0z7weuqcGDZQsndktxFe9e8sPdnxTmIQXuySjGVrQ5eLQCi7vPDMysP52TzOTOx71qQDOcfgMh/Kud7/M75RCpmTdJwB9T10hNBfUdFyMf9qZ2racqNiQ64+pSnQ3IGthEDLTQX60JY0iL5k+Bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO/m5iG6WK3fHqCTJww14Nvr9xdj3Lsvkaum7pxxn8Y=;
 b=GxANvnkwkPtZqZlot+xaiowaopi2XSQrOD98ptKaITuX6rV0L0voq6yeip15B79C0HDSp+/XxFLjdUd1chw42hwBYiPMpzSOq1AT6JbOZphVdTkdhfouUgnW7LaJ78D6vIub/y9hYEkLESVoyz6U37urqpj2M+RQh2fYeig/VSbPzMKZy0jpm5Z5f9+s3CxuMFti/9YN/22pHSqpos3+Qg5j734QLUe/YIeo8Aq90qodLkKBoNjwMi6sKsB6WrsrqcNgDGLDfHM/4ZKnKhoMpG9hEIxl9u4Hp2prloIlQpIG+Gh+dtB/XD7mShMPcvtlw2TO8r1ZCf5ePmNWrIH2FQ==
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 08:52:28 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::47) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 08:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 08:52:28 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 08:52:27 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 May 2021 08:52:25 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] IB/isert: set rdma cm afonly flag
Date:   Mon, 24 May 2021 11:52:25 +0300
Message-ID: <20210524085225.29064-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a8194eb-f6d6-40c3-65c2-08d91e91425a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4483DC5D038F9C2DFD01B02CDE269@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlxf0uyKTmCXC9loLNRY0wD2+sSEgCTPEkr/L6cCri0wftr9wwGScr1zlnv7tZq2BPEnJoZC0XQz9FSlj8Oe1+YqzWqXZL1UiBAci/OnxCklWhRbvQHKPf16B3Va0AIPy0fo3Jxq5LGvoG1jbpgViQ+MVP0jCF05rTFlCIw7HLFJWs1lwsLrcfae16SiDQk/8TpSGYB8HScridmJnppH5CiEWY7FzIzC6FbMy05WqA4BzD1CLmsOTfIykmYrDfZGAepdGA9zogQb5O28yUztUKDqb6PYSHvUq3xLhf1+yk/s1rP7gTL5sNDL56kfDc3NJ1awkz5Qxz+UK/n2j0bzMza1RwGY47WQo5p5N+rNrKwbgEcmRw/ZX1jAfsU8Id1FXPtnDsTvvfTBp6myi5NwiAt9RDeHntM1/XXPA8LdzYx9w1bTPaaTF8Zsy9o4wdmleX39EKvQ17mWNXVHqcmAY7P7cSdgrPo/XjK43IOIF7wY5zHuKKpShp4RuGWpehALPGV2k/nyZiNnYPREmHzqk5PliemoyS4UjJfeMS0l2fWzHG1T51elgjMZTQiKcwbwqugkKdt4MBWddF+ujeIGDwlAKgVqSmmTo4NSUC2cmgyKZ/mojiyDfchPanfDxc2oKV1VCGjLg43oL7Brg5fn3g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(7636003)(36860700001)(47076005)(54906003)(82740400003)(6636002)(107886003)(356005)(8936002)(8676002)(316002)(70206006)(70586007)(82310400003)(478600001)(2906002)(36756003)(36906005)(5660300002)(2616005)(186003)(4326008)(26005)(1076003)(426003)(110136005)(336012)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 08:52:28.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8194eb-f6d6-40c3-65c2-08d91e91425a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This will allow both IPv4 and IPv6 sockets to bind a single port at the
same time. Same behaviour is implemented in NVMe/RDMA target.

Reviewed-by: Alaa Hleihel <alaa@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 18266f07c58d..160efef66031 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2231,6 +2231,16 @@ isert_setup_id(struct isert_np *isert_np)
 	}
 	isert_dbg("id %p context %p\n", id, id->context);
 
+	/*
+	 * Allow both IPv4 and IPv6 sockets to bind a single port
+	 * at the same time.
+	 */
+	ret = rdma_set_afonly(id, 1);
+	if (ret) {
+		isert_err("rdma_set_afonly() failed: %d\n", ret);
+		goto out_id;
+	}
+
 	ret = rdma_bind_addr(id, sa);
 	if (ret) {
 		isert_err("rdma_bind_addr() failed: %d\n", ret);
-- 
2.18.1

