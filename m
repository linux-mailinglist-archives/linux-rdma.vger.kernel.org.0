Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9826E8789
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Apr 2023 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjDTBje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Apr 2023 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjDTBjc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Apr 2023 21:39:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A84EDE
        for <linux-rdma@vger.kernel.org>; Wed, 19 Apr 2023 18:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9BaWp1acUORL1WYCbahxSPxGHO9E13/JGfhG8daEVyLO+QeygH2PeuESrpm9C4fFuoqJlb1v2yES8XwGYx0lAZ/DSR7EIE7pesVvswKQgRq/UK1+Qwu5CuM9S+9Nbt0M9iBDLAFute3P6uXZ7L9IPMEKSDM1+X5Yc4ajqaM1pQxyDhHSMLftqCbzo2+GjyrtLVv0wK6vJR3IwrpQW2NqohWfGALAq4T8IkJwkqII2C5iygYV5NLEFMW1gxfGtxo/2Gd7b/i74JdHMio4h+9JmMld+I6BklkghY3PCR+RP940AndjDzTSOj1I0xTa5B3hFNqiJcRCV/D152hiNublg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qehv7CLQJcJU+brb69Ot/YbviWuLwjQuCsKytGY27o=;
 b=jFnXq3AeN7kOOmct5bv9fcJMhy74a4druUOgOXkdQcInX2z7zm+r4bj3JARsaJVXCD/bwZWsAYYK7MoxOKoxnA5QeUmOv7fDQI+zT9rozaKB1ssURcTQEhP4HUvFHHYuJf5k9l121C80hvjkalInnkCKXrNnjjlF9+xPfMlwAdEiA9f2kUUzijFUX4wBlzAO+5d6PBxRsNVz8bGCV5TIvMVqRVpFOdv/kzUDOlnSXOvAOn0A5wfC2vny70sM9G53hm6LJbLINKeMEsE1j70MGxfq8EnoIhUAeprC533X8oYu5OUD/wi6hBHCsc3o76uhXVqQi2cq5x07JV/+H7a9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qehv7CLQJcJU+brb69Ot/YbviWuLwjQuCsKytGY27o=;
 b=sT/tXfPn3U1f9KZxj3bfia6iX5lD5DOwdIl578bdk8ycYCqIQnQy52eCmibPMDT7OLkqjC9xbcP5LRSQDgRrnfpT5NsSshfEQzpqnl2jZfUmyz57gc/f+sGJThlxpUs5U57wyftEWVUAK47aj6qWi0GlXiBsYEngJBNmtYwKkiZJO35vCqhrk25sH0GvhyBuFCbs8Vgu8aSoEi+XKMk6vk9IMpvHd3OGqVLxKDTnB5Ixvqjyp/O9mRL1wr+naSZ7HBzDQL15BcZtrw5kgaVlh/tlja6OwTM+ow/qPbtk+iHIU2weUFxLoJlJqrn7Hw7i/fbof37tHljFTFWlgAcjOg==
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by DM6PR12MB4927.namprd12.prod.outlook.com (2603:10b6:5:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 01:39:19 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::1e) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Thu, 20 Apr 2023 01:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.31 via Frontend Transport; Thu, 20 Apr 2023 01:39:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 18:39:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 19 Apr 2023 18:39:11 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 18:39:09 -0700
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <monis@nvidia.com>,
        <yishaih@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Use correct device num_ports when modify DC
Date:   Thu, 20 Apr 2023 04:39:06 +0300
Message-ID: <20230420013906.1244185-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|DM6PR12MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ae2c89-5cb2-4937-8e4b-08db41400f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuzKrwmcntLClScXS5EidWHI+MaU8CqA5P3ulYKhJHv1TMExlPZNsJGDSSTDaqf5oVHz5kKDvVWf3CCiZQ70wmBxmeBRlPtIu30CJYHE5WqVkSyCcGtumUgTRVG9DTrf6xZh4i5x6MXXuam31y004DBLtOt6MaRq/+6CZ+XhGlV43BKbygYgcZPCd0F5pUxhhgyFnp89gLWl77IOZdCg5D7nuBfGDGpZ+iVaPSlmzPXoTGiv9uMlgavk8YlYIgpZt5GkKMc2ZE9Ind1kurSsD5Eiecco9cjE1IG/ThYLiGWpfvh2rYLiCMPVTM5QFnt+O7KoHYWmQ/i6iuAxwZIO/lG3CLQqmN26NLqhf79rMXVs4JEKUgwgyzNX8eCy9XqPAFaR0x+KDeiUHaG/GleJ6NhMJJ6RmMFhcAvMdi0G91LmxfxuSu2KUsFC10Cl/BFCAYid8nkjdURhVvOAHP7qAPeA4p7FPLBZFav8k6Qs+G0X7bFgRQSkA05zukim7eBuhTmoVD3ACW6U/LMhQ3hF9KD4iDOgHL/ZllSttlVWItZ7ts1xwz2VkA/zVMKWlhwQx10L486nKLPv08vxVzScFEpQ8bWk7EZQQO2T+86R4dEdciVPW8KnlOZTqapagn7GlDcFcGmPPK1EgJgewbMnm9e+pL2Roidda51bKPq/16oUDxr0gAyvWdFM1WP8ykD7lzHerayo99vqxFxxsoqAa7NxvLE1XqQ2FjRrHyjU6GBr1oLHpuh+MWXWEHkXCwFdtzTH3RnJbAumoLS+Mt+rn3pAYcAI+gzVO00U1pda3hM=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(110136005)(6636002)(54906003)(70206006)(40480700001)(6666004)(478600001)(34020700004)(7696005)(7636003)(83380400001)(316002)(356005)(82740400003)(426003)(336012)(47076005)(4326008)(41300700001)(26005)(2616005)(36860700001)(186003)(107886003)(1076003)(70586007)(5660300002)(4744005)(2906002)(8676002)(36756003)(8936002)(40460700003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 01:39:18.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae2c89-5cb2-4937-8e4b-08db41400f17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just like other QP types, when modify DC, the port_num should be
compared with dev->num_ports, instead of HCA_CAP.num_ports.
Otherwise Multi-port vHCA on DC may not work.

Fixes: 776a3906b692 ("IB/mlx5: Add support for DC target QP")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1093d3a0ed43..70ca8ffa9256 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4493,7 +4493,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EINVAL;
 
 		if (attr->port_num == 0 ||
-		    attr->port_num > MLX5_CAP_GEN(dev->mdev, num_ports)) {
+		    attr->port_num > dev->num_ports) {
 			mlx5_ib_dbg(dev, "invalid port number %d. number of ports is %d\n",
 				    attr->port_num, dev->num_ports);
 			return -EINVAL;
-- 
2.37.1

