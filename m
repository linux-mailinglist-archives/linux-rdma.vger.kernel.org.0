Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9231A5B0344
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiIGLil (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIGLih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 07:38:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF5EE01
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 04:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH/eqYVxLyIUvrq1Z7Llc2mD4BKiLDS71lTdHCUrbWWxtusXp6b+yubssw2QhD8AuLP1Ea/79vh+gpzY74Dl1FagufXKTkzURNysSnB2IFjsy0PRz1DGuDA1DFDFJ2n9PrU/7HEwHhTRN8h5fqUMRYTKtzuTW7vjiKRv4joILSqyfRinwl89qb6UWdJJIeWHOs7cJKgWslsme94APVJwSEPwq4bm/CpEir+mWvr9ltuU43dSmJoG1KkBm+X3ZOrvXvl3n7TjF3IhxjotwQ7eUznJm33GS0WiUFsjpTr9zbKiOKXjV2FzuzWvob/v1ICOLcjOF9VpZTuNPxfDsP5R6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPFj95z91bKm4MdVCkwtrgSKWTrFTaKzHkyQtqUCOWQ=;
 b=eP4cFPuU0JdOQ5aDPaIsfg+efOExbY6AYVlm7zYQ1zsSgL8u02ZgPr4/Ww0Arp/FDullHCHK+E9dbD+H4dB2puDo+jpNOAmKyMLHVnV6V0VcL2SZU6+jXZRqT7L5S6sbk7CFNboPae6anJJLO4Pqm5t2TMyCeReVdM9aQ0FxxmpRl7wY6VtQ2q5QHG1PddUGFHRS4SPsVrhbie9sVAlVVAbDQK7eWqHWG1P6zCZUx2qpaIhK4s0Lar/sZuICISP/Y3v1vwfSTPYxsvT9CWJb3aSgfAzr7IgND1+DBtLOTaCFdSw03i1aoom5kyhdeDjBS0cB7ngxxTXEuJ6IEIIGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPFj95z91bKm4MdVCkwtrgSKWTrFTaKzHkyQtqUCOWQ=;
 b=YdyA79F4NS8dscLMp1t+iZhoDOnDOtvYl7iGIdmurwyfBO4Ua8a1Itjxfe1B3H8fKWzG9bPdMfz5tWbZeWb7sBmN2qy7Irvl7YCbzXKqKkMv2TApIIqavNgXnT6/IKF1uKgM+DRGKhK88NBdVJlzsY2r6/OEFHrEqyaDp8JkeYKnkLFODyKZ6ROSU08uw8qUl+m2F6WUmEEA+tOsS5Vl5yTEUB6YxsmBSwpoZG+tkciMV6Phn92yNBbTP9w+5Stdg3DvOHOlpUCU7dWFT0Wo2+YwVjybztQeQRMoBLq4d+jPMKopXGrIWFETFYp+SPoAU2UxsMiX7lFleRvYDXt4gg==
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 7 Sep
 2022 11:38:34 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9a) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4 via Frontend
 Transport; Wed, 7 Sep 2022 11:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:38:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 11:38:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 04:38:32 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 7 Sep
 2022 04:38:29 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     Patrisious Haddad <phaddad@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH rdma-next 1/4] net/mlx5: Introduce CQE error syndrome
Date:   Wed, 7 Sep 2022 14:37:57 +0300
Message-ID: <20220907113800.22182-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220907113800.22182-1-phaddad@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: c97dea38-18fb-4cc5-c59c-08da90c57efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW5pS4JQrn3qeiKrpSVgtbkwlazrg3dGxwRDmrYG9qofVeKcf8DlLcXgT6EoxSqH6zXD8BRopI9zdFXD5Mra1xUBtOqvIrQmuSKCZR0zqQv9SZ92GPlFqxw3AbUdHJOSHs+3M1dZeUiZov7VFDDCpFbq2VJ9R8ZMHzfQTreLtmJgzTu5iU3NiQXzKHjc2ys85EfXWW7mi3OXqzuNZ74g66yYjvb2UJKin915eZj9ZbCjpTavCrNcv52W+8fToZ1DzlAhn9aJ/rTpGPP+h2qEguQmSedsomV7WuuO+Fu8spx8lemGgZL+RcMws6RT0n51gBvhNVaQQa3rcO1oBY4WFGVI0a/cJEypJOoMpRbBA1Yfi6+6BAIFmZweGd49j+TlGLlDEnEj6um4CWwUhUgNYZsAcyRZkGSN1rs9P12SEgp6kURnMyE/Ts5+Bij8C1RqoG2gQDLTL/vXj4SsvB14vyvMBRTABt8JCAG8q2sYjzqPMQy/Kg/mfsmWD56ZwHaZcg+yoIk3MZ1n87X1ChN4bi1fOicHOFQ0PvtXVbXIuUYTTyip7C4fOXFh1Df+D2g83mfIJ1VCcofLXwX7DEQKy2Gfw2HCaYysUOmWfE2a0Ae9jBMespUs0bOYqJGrsC84osJK+KdJ6BmeDDda6KGS7NzXfXqcTIvGjElgSV1lpS26rzYM2dhZr9S3MGD2hKkRpHX+WAYcf08DucrlZWuqymwVaHf3fKeGHhtBHu6XfL21llhxub8stmzWDiIYMZfEtR2y26wRr9UQyEbujL1vY8yvk4gOtipRLAa8tGVpjw7ELJhcB2BQEiCFhfF/ChIp
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(478600001)(1076003)(70206006)(41300700001)(36860700001)(54906003)(316002)(8936002)(8676002)(4326008)(82740400003)(70586007)(356005)(110136005)(2616005)(81166007)(26005)(107886003)(2906002)(336012)(36756003)(5660300002)(82310400005)(7696005)(83380400001)(6666004)(40480700001)(86362001)(40460700003)(47076005)(426003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:38:33.8795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97dea38-18fb-4cc5-c59c-08da90c57efb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduces CQE error syndrome bits which are inside qp_context_extension
and are used to report the reason the QP was moved to error state.
Useful for cases in which a CQE is generated, such as remote write
rkey violaton.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 47 +++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4acd5610e96b..1c3b258baaa7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1441,7 +1441,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         null_mkey[0x1];
 	u8         log_max_klm_list_size[0x6];
 
-	u8         reserved_at_120[0xa];
+	u8         reserved_at_120[0x2];
+	u8	   qpc_extension[0x1];
+	u8	   reserved_at_123[0x7];
 	u8         log_max_ra_req_dc[0x6];
 	u8         reserved_at_130[0x9];
 	u8         vnic_env_cq_overrun[0x1];
@@ -1605,7 +1607,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         log_bf_reg_size[0x5];
 
-	u8         reserved_at_270[0x6];
+	u8         reserved_at_270[0x3];
+	u8	   qp_error_syndrome[0x1];
+	u8	   reserved_at_274[0x2];
 	u8         lag_dct[0x2];
 	u8         lag_tx_port_affinity[0x1];
 	u8         lag_native_fdb_selection[0x1];
@@ -5257,6 +5261,37 @@ struct mlx5_ifc_query_rmp_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_cqe_error_syndrome_bits {
+	u8         hw_error_syndrome[0x8];
+	u8         hw_syndrome_type[0x4];
+	u8         reserved_at_c[0x4];
+	u8         vendor_error_syndrome[0x8];
+	u8         syndrome[0x8];
+};
+
+struct mlx5_ifc_qp_context_extension_bits {
+	u8         reserved_at_0[0x60];
+
+	struct mlx5_ifc_cqe_error_syndrome_bits error_syndrome;
+
+	u8         reserved_at_80[0x580];
+};
+
+struct mlx5_ifc_qpc_extension_and_pas_list_in_bits {
+	struct mlx5_ifc_qp_context_extension_bits qpc_data_extension;
+
+	u8         pas[0][0x40];
+};
+
+struct mlx5_ifc_qp_pas_list_in_bits {
+	struct mlx5_ifc_cmd_pas_bits pas[0];
+};
+
+union mlx5_ifc_qp_pas_or_qpc_ext_and_pas_bits {
+	struct mlx5_ifc_qp_pas_list_in_bits qp_pas_list;
+	struct mlx5_ifc_qpc_extension_and_pas_list_in_bits qpc_ext_and_pas_list;
+};
+
 struct mlx5_ifc_query_qp_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -5273,7 +5308,7 @@ struct mlx5_ifc_query_qp_out_bits {
 
 	u8         reserved_at_800[0x80];
 
-	u8         pas[][0x40];
+	union mlx5_ifc_qp_pas_or_qpc_ext_and_pas_bits qp_pas_or_qpc_ext_and_pas;
 };
 
 struct mlx5_ifc_query_qp_in_bits {
@@ -5283,7 +5318,8 @@ struct mlx5_ifc_query_qp_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x8];
+	u8         qpc_ext[0x1];
+	u8         reserved_at_41[0x7];
 	u8         qpn[0x18];
 
 	u8         reserved_at_60[0x20];
@@ -8417,7 +8453,8 @@ struct mlx5_ifc_create_qp_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x8];
+	u8         qpc_ext[0x1];
+	u8         reserved_at_41[0x7];
 	u8         input_qpn[0x18];
 
 	u8         reserved_at_60[0x20];
-- 
2.18.1

