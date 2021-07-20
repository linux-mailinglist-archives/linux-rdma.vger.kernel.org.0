Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16EA3CF5FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGTHhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:45 -0400
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com ([40.107.212.80]:20242
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234127AbhGTHhb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVtI1sBMlcN8r16u03HvzAIitkt3saS7xP2uIAPYX7D9larsmRVKifSX3GYNtYoE2qAbjikGGoz1hoJ/5V2TJhcGElpS0rUQwXQyLjCEq2ODgWVI4jTw6GTJwI9vk6mMUH4wK/OaioyOu0S8jqR/+AJMnLAYNdIGwdOAI1rdUiwnudbO/nLYjK5JutEmevtameSFWMQ11UwHPRMdtv9r2LMyEG//JwbugAoXkNldTnrusyOgyqWuYKB5ROgLKsxN6lEtdzRW3tpSuTEqYQ3Ah1pIEMmK8FTEE8YIUYeG4baMmNWe8HGrKO5kc4oFyQ2bQ/sXzCz4UWcGr5O20GKJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrHe1WmG//l5SAprw3VDWcQmsFnBuf3Vp6D58iJImMs=;
 b=OK2BM3YQyvx2A6Ki0v/mbNQpKwSFNbuBagCcnWFjBlgBeV3BiJNUPfGzCpiZ1GmDBFlTRS730nIu1rcou77aGFD1fDMPqmDvOp4aUHdwGoPT5GDfDQqGG0QQwJ4VTu6mVorraA/utTfZd3eOlezv2kE9SWFwh3sEOwhSrT6GCqFlApkcAvm5Jfn48T/Zt4gvgDQAHSfcTN3/5OcWZnP8sYwFppVDOjWfSukZnb2uIIF261VAzV2VdVgqy4/CyyUItnmUS5fBiSo2orcpukEepPLCpG2Nl1UXR4HaUeRZ2n//WtJrvvPruRtIHloe2fp+yBMjp/E7iDb0Mo6W/QUbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrHe1WmG//l5SAprw3VDWcQmsFnBuf3Vp6D58iJImMs=;
 b=RsYPY7QrANAD7Km5OqAwwE9cChksQMi2zvFRwMWKZ/Mk4VL2ryD02bBFsV3oCtDcU2PdCy/i0kZjtvnC1dSDIgYbWu8dj+urbZRbPhLiqUDDucj2+z8nAmn4nKIwTNEQLd5PIRYGjnVsScHG7TV/ill0yD4unmwQqb1NnEoSzc+dZ54nuojDs8Wqs4nYpAXAyS1pJAeNwCX1wYjF0N6zfxGPRmG+XUWqJ0JanLSYwNN0b5c4G5uhKKTQXC7/ugXBEhpCft0RZP2VxVpeb9BWe+dlnfq0Y7EDxEt/ZmSK9w0SBzxpU6DFkhjP2w7PiPillrwQZVXGoU8TXfHASnNt/g==
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by MN2PR12MB3821.namprd12.prod.outlook.com (2603:10b6:208:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:07 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::d4) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:07 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:18:07 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:05 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 17/27] mlx5: Implement mlx5dv devx_obj APIs over vfio
Date:   Tue, 20 Jul 2021 11:16:37 +0300
Message-ID: <20210720081647.1980-18-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a58c724-f2e5-47f8-be1f-08d94b56e7d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38211E964AEF6A59F24FAFAAC3E29@MN2PR12MB3821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBmBUAOoNuheJx2Tt/M3B9cEyt1vPhbUDkiUdKXRdjcjzTFaHPXA1HvbAXizmmFsa3oBbcHMUb4bHk8n7IaJERWz3SUpo+99j+yllcrXSCW4na/wwTgVRmjnT8BROJOI8jIUgeJttfG6utngEanNu3oB1qefleCKvHv5GFA+TZlHGQvAxczfz1wZAfzmW6wXdIVsCZQ64EJcH0w4DUYw1eG9pX+fc4RBvJ91dK2BV6PuCPzuwsUCcrZEmy6w7ol73/dBWbM9qoSq5quUcq+o13FrjOBHvtrtUMAMhZB2vrD3jbh/ZPLKK8OTZMP11PJk3AiauwzZs9qHtmShdYjffAAX4KIyBd6F/60fF80MgwdMBShIcOH8FoozNikVbM+fl85zZ5kfR/EnT4FQV6sjijuZAM4HMiiBbUc0UBhBpzxIphYancFOvSBhLpRvKTqBKDt7UPM2oZJuix4Vv7kn9FenXx4MSFV82G1bdrKCTxliiOogfoUzyvI4lFBXetIEL5sC0WRTRlOemQgal6Bp+WBJrjT6gfs7HoLG9TzJuJUJmMyZNhRsVatpJa+/Nkkync/7ALr10vbdso3fhgyPoUEguVE/N6xmnM3chXsgZQqakYhDoasA6TndJ5YLNJaiaQUovsWL1YmkBRv+jERGTC1x9dBPxgH8WSaRk9z9w90jLktMOkSXC9a7RVqyUieUUIXgZazWm4e7lRSMbT7Ly/byYYcVQ0V+3j/uwQ8uYa2fVvRRJYUFkVylFDbE9tM2
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(186003)(4326008)(82740400003)(82310400003)(8936002)(7696005)(6916009)(36860700001)(70206006)(478600001)(36756003)(2906002)(5660300002)(30864003)(7636003)(6666004)(1076003)(426003)(336012)(2616005)(356005)(107886003)(70586007)(83380400001)(26005)(316002)(8676002)(47076005)(54906003)(86362001)(42413003)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:07.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a58c724-f2e5-47f8-be1f-08d94b56e7d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Implement mlx5dv vfio APIs: devx_obj_create/query/modify/destroy, as
well as the devx_general_cmd

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  | 565 ++++++++++++++++++++++++++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.c | 413 ++++++++++++++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.h |   8 +
 3 files changed, 975 insertions(+), 11 deletions(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 1bd7466..175fe4a 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -54,7 +54,10 @@ enum {
 	MLX5_CMD_OP_DESTROY_MKEY = 0x202,
 	MLX5_CMD_OP_CREATE_EQ = 0x301,
 	MLX5_CMD_OP_DESTROY_EQ = 0x302,
+	MLX5_CMD_OP_CREATE_CQ = 0x400,
+	MLX5_CMD_OP_DESTROY_CQ = 0x401,
 	MLX5_CMD_OP_CREATE_QP = 0x500,
+	MLX5_CMD_OP_DESTROY_QP = 0x501,
 	MLX5_CMD_OP_RST2INIT_QP = 0x502,
 	MLX5_CMD_OP_INIT2RTR_QP = 0x503,
 	MLX5_CMD_OP_RTR2RTS_QP = 0x504,
@@ -63,31 +66,71 @@ enum {
 	MLX5_CMD_OP_INIT2INIT_QP = 0x50e,
 	MLX5_CMD_OP_CREATE_PSV = 0x600,
 	MLX5_CMD_OP_DESTROY_PSV = 0x601,
+	MLX5_CMD_OP_CREATE_SRQ = 0x700,
+	MLX5_CMD_OP_DESTROY_SRQ = 0x701,
+	MLX5_CMD_OP_CREATE_XRC_SRQ = 0x705,
+	MLX5_CMD_OP_DESTROY_XRC_SRQ = 0x706,
+	MLX5_CMD_OP_CREATE_DCT = 0x710,
+	MLX5_CMD_OP_DESTROY_DCT = 0x711,
 	MLX5_CMD_OP_QUERY_DCT = 0x713,
+	MLX5_CMD_OP_CREATE_XRQ = 0x717,
+	MLX5_CMD_OP_DESTROY_XRQ = 0x718,
 	MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT = 0x752,
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT = 0x755,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
+	MLX5_CMD_OP_ALLOC_Q_COUNTER = 0x771,
+	MLX5_CMD_OP_DEALLOC_Q_COUNTER = 0x772,
+	MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT = 0x782,
+	MLX5_CMD_OP_DESTROY_SCHEDULING_ELEMENT = 0x783,
 	MLX5_CMD_OP_ALLOC_PD = 0x800,
 	MLX5_CMD_OP_DEALLOC_PD = 0x801,
 	MLX5_CMD_OP_ALLOC_UAR = 0x802,
 	MLX5_CMD_OP_DEALLOC_UAR = 0x803,
 	MLX5_CMD_OP_ACCESS_REG = 0x805,
+	MLX5_CMD_OP_ATTACH_TO_MCG = 0x806,
+	MLX5_CMD_OP_DETACH_FROM_MCG = 0x807,
+	MLX5_CMD_OP_ALLOC_XRCD = 0x80e,
+	MLX5_CMD_OP_DEALLOC_XRCD = 0x80f,
+	MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN = 0x816,
+	MLX5_CMD_OP_DEALLOC_TRANSPORT_DOMAIN = 0x817,
+	MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT = 0x827,
+	MLX5_CMD_OP_DELETE_VXLAN_UDP_DPORT = 0x828,
+	MLX5_CMD_OP_SET_L2_TABLE_ENTRY = 0x829,
+	MLX5_CMD_OP_DELETE_L2_TABLE_ENTRY = 0x82b,
 	MLX5_CMD_OP_QUERY_LAG = 0x842,
 	MLX5_CMD_OP_CREATE_TIR = 0x900,
+	MLX5_CMD_OP_DESTROY_TIR = 0x902,
+	MLX5_CMD_OP_CREATE_SQ = 0x904,
 	MLX5_CMD_OP_MODIFY_SQ = 0x905,
+	MLX5_CMD_OP_DESTROY_SQ = 0x906,
+	MLX5_CMD_OP_CREATE_RQ = 0x908,
+	MLX5_CMD_OP_DESTROY_RQ = 0x90a,
+	MLX5_CMD_OP_CREATE_RMP = 0x90c,
+	MLX5_CMD_OP_DESTROY_RMP = 0x90e,
+	MLX5_CMD_OP_CREATE_TIS = 0x912,
 	MLX5_CMD_OP_MODIFY_TIS = 0x913,
+	MLX5_CMD_OP_DESTROY_TIS = 0x914,
 	MLX5_CMD_OP_QUERY_TIS = 0x915,
+	MLX5_CMD_OP_CREATE_RQT = 0x916,
+	MLX5_CMD_OP_DESTROY_RQT = 0x918,
 	MLX5_CMD_OP_CREATE_FLOW_TABLE = 0x930,
+	MLX5_CMD_OP_DESTROY_FLOW_TABLE = 0x931,
 	MLX5_CMD_OP_QUERY_FLOW_TABLE = 0x932,
 	MLX5_CMD_OP_CREATE_FLOW_GROUP = 0x933,
+	MLX5_CMD_OP_DESTROY_FLOW_GROUP = 0x934,
 	MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY = 0x936,
+	MLX5_CMD_OP_DELETE_FLOW_TABLE_ENTRY = 0x938,
 	MLX5_CMD_OP_CREATE_FLOW_COUNTER = 0x939,
+	MLX5_CMD_OP_DEALLOC_FLOW_COUNTER = 0x93a,
 	MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT = 0x93d,
 	MLX5_CMD_OP_DEALLOC_PACKET_REFORMAT_CONTEXT = 0x93e,
+	MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT = 0x940,
+	MLX5_CMD_OP_DEALLOC_MODIFY_HEADER_CONTEXT = 0x941,
 	MLX5_CMD_OP_CREATE_GENERAL_OBJECT = 0xa00,
 	MLX5_CMD_OP_MODIFY_GENERAL_OBJECT = 0xa01,
 	MLX5_CMD_OP_QUERY_GENERAL_OBJECT = 0xa02,
+	MLX5_CMD_OP_DESTROY_GENERAL_OBJECT = 0xa03,
 	MLX5_CMD_OP_CREATE_UMEM = 0xa08,
 	MLX5_CMD_OP_DESTROY_UMEM = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING = 0xb00,
@@ -236,6 +279,27 @@ struct mlx5_ifc_create_flow_table_out_bits {
 	u8         icm_address_31_0[0x20];
 };
 
+struct mlx5_ifc_destroy_flow_table_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	u8         table_type[0x8];
+	u8         reserved_at_88[0x18];
+
+	u8         reserved_at_a0[0x8];
+	u8         table_id[0x18];
+
+	u8         reserved_at_c0[0x140];
+};
+
 struct mlx5_ifc_query_flow_table_in_bits {
 	u8         opcode[0x10];
 	u8         reserved_at_10[0x10];
@@ -2991,6 +3055,17 @@ struct mlx5_ifc_alloc_flow_counter_out_bits {
 	u8	reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_dealloc_flow_counter_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         flow_counter_id[0x20];
+
+	u8         reserved_at_60[0x20];
+};
+
 enum {
 	MLX5_OBJ_TYPE_FLOW_METER = 0x000a,
 	MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
@@ -3422,6 +3497,18 @@ struct mlx5_ifc_create_tir_out_bits {
 	u8         icm_address_31_0[0x20];
 };
 
+struct mlx5_ifc_destroy_tir_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         tirn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_create_qp_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -3459,6 +3546,18 @@ struct mlx5_ifc_create_qp_in_bits {
 	u8         pas[0][0x40];
 };
 
+struct mlx5_ifc_destroy_qp_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         qpn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 enum mlx5_qpc_opt_mask_32 {
 	MLX5_QPC_OPT_MASK_32_QOS_QUEUE_GROUP_ID = 1 << 1,
 	MLX5_QPC_OPT_MASK_32_UDP_SPORT = 1 << 2,
@@ -3898,7 +3997,13 @@ struct mlx5_ifc_create_flow_group_in_bits {
 	u8         opcode[0x10];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0x60];
+	u8         reserved_at_20[0x20];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
 	u8         reserved_at_88[0x18];
@@ -3921,6 +4026,29 @@ struct mlx5_ifc_create_flow_group_out_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_destroy_flow_group_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	u8         table_type[0x8];
+	u8         reserved_at_88[0x18];
+
+	u8         reserved_at_a0[0x8];
+	u8         table_id[0x18];
+
+	u8         group_id[0x20];
+
+	u8         reserved_at_e0[0x120];
+};
+
 struct mlx5_ifc_dest_format_bits {
 	u8         destination_type[0x8];
 	u8         destination_id[0x18];
@@ -3977,7 +4105,14 @@ struct mlx5_ifc_set_fte_in_bits {
 	u8         opcode[0x10];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0x60];
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
 	u8         reserved_at_88[0x18];
@@ -4186,6 +4321,18 @@ struct mlx5_ifc_create_psv_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_destroy_psv_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         psvn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_mbox_out_bits {
 	u8	status[0x8];
 	u8	reserved_at_8[0x18];
@@ -4726,4 +4873,418 @@ struct mlx5_ifc_destroy_umem_out_bits {
 	u8        reserved_at_40[0x40];
 };
 
+struct mlx5_ifc_delete_fte_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	u8         table_type[0x8];
+	u8         reserved_at_88[0x18];
+
+	u8         reserved_at_a0[0x8];
+	u8         table_id[0x18];
+
+	u8         reserved_at_c0[0x40];
+
+	u8         flow_index[0x20];
+
+	u8         reserved_at_120[0xe0];
+};
+
+struct mlx5_ifc_create_cq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         cqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_cq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         cqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_alloc_transport_domain_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         transport_domain[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_dealloc_transport_domain_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         transport_domain[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_rmp_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         rmpn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_rmp_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         rmpn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_sq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         sqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_sq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         sqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_rq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         rqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_rq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         rqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_rqt_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         rqtn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_rqt_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         rqtn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_tis_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         tisn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_tis_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         tisn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_alloc_q_counter_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x18];
+	u8         counter_set_id[0x8];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_dealloc_q_counter_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x18];
+	u8         counter_set_id[0x8];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_alloc_modify_header_context_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         modify_header_id[0x20];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_dealloc_modify_header_context_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         modify_header_id[0x20];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_scheduling_element_out_bits {
+	u8         reserved_at_0[0x80];
+
+	u8         scheduling_element_id[0x20];
+
+	u8         reserved_at_a0[0x160];
+};
+
+struct mlx5_ifc_create_scheduling_element_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         scheduling_hierarchy[0x8];
+	u8         reserved_at_48[0x18];
+
+	u8         reserved_at_60[0x3a0];
+};
+
+struct mlx5_ifc_destroy_scheduling_element_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         scheduling_hierarchy[0x8];
+	u8         reserved_at_48[0x18];
+
+	u8         scheduling_element_id[0x20];
+
+	u8         reserved_at_80[0x180];
+};
+
+struct mlx5_ifc_add_vxlan_udp_dport_in_bits {
+	u8         reserved_at_0[0x60];
+
+	u8         reserved_at_60[0x10];
+	u8         vxlan_udp_port[0x10];
+};
+
+struct mlx5_ifc_delete_vxlan_udp_dport_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x40];
+
+	u8         reserved_at_60[0x10];
+	u8         vxlan_udp_port[0x10];
+};
+
+struct mlx5_ifc_set_l2_table_entry_in_bits {
+	u8         reserved_at_0[0xa0];
+
+	u8         reserved_at_a0[0x8];
+	u8         table_index[0x18];
+
+	u8         reserved_at_c0[0x140];
+
+};
+
+struct mlx5_ifc_delete_l2_table_entry_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x80];
+
+	u8         reserved_at_a0[0x8];
+	u8         table_index[0x18];
+
+	u8         reserved_at_c0[0x140];
+};
+
+struct mlx5_ifc_create_srq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         srqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_srq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         srqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_xrc_srq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         xrc_srqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_xrc_srq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         xrc_srqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_dct_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         dctn[0x18];
+
+	u8         ece[0x20];
+};
+
+struct mlx5_ifc_destroy_dct_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         dctn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_xrq_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         xrqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_xrq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         xrqn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_attach_to_mcg_in_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         qpn[0x18];
+
+	u8         reserved_at_60[0x20];
+
+	u8         multicast_gid[16][0x8];
+};
+
+struct mlx5_ifc_detach_from_mcg_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         qpn[0x18];
+
+	u8         reserved_at_60[0x20];
+
+	u8         multicast_gid[16][0x8];
+};
+
+struct mlx5_ifc_alloc_xrcd_out_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         reserved_at_40[0x8];
+	u8         xrcd[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_dealloc_xrcd_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         xrcd[0x18];
+
+	u8         reserved_at_60[0x20];
+};
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 5e55697..0bc9aed 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -2460,14 +2460,6 @@ end:
 	return NULL;
 }
 
-static struct mlx5dv_devx_obj *
-vfio_devx_obj_create(struct ibv_context *context, const void *in,
-		     size_t inlen, void *out, size_t outlen)
-{
-	errno = EOPNOTSUPP;
-	return NULL;
-}
-
 static int vfio_devx_query_eqn(struct ibv_context *ibctx, uint32_t vector,
 			       uint32_t *eqn)
 {
@@ -2682,15 +2674,418 @@ static int vfio_init_obj(struct mlx5dv_obj *obj, uint64_t obj_type)
 	return 0;
 }
 
+static int vfio_devx_general_cmd(struct ibv_context *context, const void *in,
+				 size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(context);
+
+	return mlx5_vfio_cmd_exec(ctx, (void *)in, inlen, out, outlen, 0);
+}
+
+static bool devx_is_obj_create_cmd(const void *in)
+{
+	uint16_t opcode = DEVX_GET(general_obj_in_cmd_hdr, in, opcode);
+
+	switch (opcode) {
+	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
+	case MLX5_CMD_OP_CREATE_MKEY:
+	case MLX5_CMD_OP_CREATE_CQ:
+	case MLX5_CMD_OP_ALLOC_PD:
+	case MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN:
+	case MLX5_CMD_OP_CREATE_RMP:
+	case MLX5_CMD_OP_CREATE_SQ:
+	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RQT:
+	case MLX5_CMD_OP_CREATE_TIR:
+	case MLX5_CMD_OP_CREATE_TIS:
+	case MLX5_CMD_OP_ALLOC_Q_COUNTER:
+	case MLX5_CMD_OP_CREATE_FLOW_TABLE:
+	case MLX5_CMD_OP_CREATE_FLOW_GROUP:
+	case MLX5_CMD_OP_CREATE_FLOW_COUNTER:
+	case MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT:
+	case MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT:
+	case MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT:
+	case MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT:
+	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
+	case MLX5_CMD_OP_CREATE_QP:
+	case MLX5_CMD_OP_CREATE_SRQ:
+	case MLX5_CMD_OP_CREATE_XRC_SRQ:
+	case MLX5_CMD_OP_CREATE_DCT:
+	case MLX5_CMD_OP_CREATE_XRQ:
+	case MLX5_CMD_OP_ATTACH_TO_MCG:
+	case MLX5_CMD_OP_ALLOC_XRCD:
+		return true;
+	case MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY:
+	{
+		uint8_t op_mod = DEVX_GET(set_fte_in, in, op_mod);
+
+		if (op_mod == 0)
+			return true;
+		return false;
+	}
+	case MLX5_CMD_OP_CREATE_PSV:
+	{
+		uint8_t num_psv = DEVX_GET(create_psv_in, in, num_psv);
+
+		if (num_psv == 1)
+			return true;
+		return false;
+	}
+	default:
+		return false;
+	}
+}
+
+static uint32_t devx_get_created_obj_id(const void *in, const void *out,
+					uint16_t opcode)
+{
+	switch (opcode) {
+	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
+		return DEVX_GET(general_obj_out_cmd_hdr, out, obj_id);
+	case MLX5_CMD_OP_CREATE_UMEM:
+		return DEVX_GET(create_umem_out, out, umem_id);
+	case MLX5_CMD_OP_CREATE_MKEY:
+		return DEVX_GET(create_mkey_out, out, mkey_index);
+	case MLX5_CMD_OP_CREATE_CQ:
+		return DEVX_GET(create_cq_out, out, cqn);
+	case MLX5_CMD_OP_ALLOC_PD:
+		return DEVX_GET(alloc_pd_out, out, pd);
+	case MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN:
+		return DEVX_GET(alloc_transport_domain_out, out,
+				transport_domain);
+	case MLX5_CMD_OP_CREATE_RMP:
+		return DEVX_GET(create_rmp_out, out, rmpn);
+	case MLX5_CMD_OP_CREATE_SQ:
+		return DEVX_GET(create_sq_out, out, sqn);
+	case MLX5_CMD_OP_CREATE_RQ:
+		return DEVX_GET(create_rq_out, out, rqn);
+	case MLX5_CMD_OP_CREATE_RQT:
+		return DEVX_GET(create_rqt_out, out, rqtn);
+	case MLX5_CMD_OP_CREATE_TIR:
+		return DEVX_GET(create_tir_out, out, tirn);
+	case MLX5_CMD_OP_CREATE_TIS:
+		return DEVX_GET(create_tis_out, out, tisn);
+	case MLX5_CMD_OP_ALLOC_Q_COUNTER:
+		return DEVX_GET(alloc_q_counter_out, out, counter_set_id);
+	case MLX5_CMD_OP_CREATE_FLOW_TABLE:
+		return DEVX_GET(create_flow_table_out, out, table_id);
+	case MLX5_CMD_OP_CREATE_FLOW_GROUP:
+		return DEVX_GET(create_flow_group_out, out, group_id);
+	case MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY:
+		return DEVX_GET(set_fte_in, in, flow_index);
+	case MLX5_CMD_OP_CREATE_FLOW_COUNTER:
+		return DEVX_GET(alloc_flow_counter_out, out, flow_counter_id);
+	case MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT:
+		return DEVX_GET(alloc_packet_reformat_context_out, out,
+				packet_reformat_id);
+	case MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT:
+		return DEVX_GET(alloc_modify_header_context_out, out,
+				modify_header_id);
+	case MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT:
+		return DEVX_GET(create_scheduling_element_out, out,
+				scheduling_element_id);
+	case MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT:
+		return DEVX_GET(add_vxlan_udp_dport_in, in, vxlan_udp_port);
+	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
+		return DEVX_GET(set_l2_table_entry_in, in, table_index);
+	case MLX5_CMD_OP_CREATE_QP:
+		return DEVX_GET(create_qp_out, out, qpn);
+	case MLX5_CMD_OP_CREATE_SRQ:
+		return DEVX_GET(create_srq_out, out, srqn);
+	case MLX5_CMD_OP_CREATE_XRC_SRQ:
+		return DEVX_GET(create_xrc_srq_out, out, xrc_srqn);
+	case MLX5_CMD_OP_CREATE_DCT:
+		return DEVX_GET(create_dct_out, out, dctn);
+	case MLX5_CMD_OP_CREATE_XRQ:
+		return DEVX_GET(create_xrq_out, out, xrqn);
+	case MLX5_CMD_OP_ATTACH_TO_MCG:
+		return DEVX_GET(attach_to_mcg_in, in, qpn);
+	case MLX5_CMD_OP_ALLOC_XRCD:
+		return DEVX_GET(alloc_xrcd_out, out, xrcd);
+	case MLX5_CMD_OP_CREATE_PSV:
+		return DEVX_GET(create_psv_out, out, psv0_index);
+	default:
+		/* The entry must match to one of the devx_is_obj_create_cmd */
+		assert(false);
+		return 0;
+	}
+}
+
+static void devx_obj_build_destroy_cmd(const void *in, void *out,
+				       void *din, uint32_t *dinlen,
+				       struct mlx5dv_devx_obj *obj)
+{
+	uint16_t opcode = DEVX_GET(general_obj_in_cmd_hdr, in, opcode);
+	uint16_t uid = DEVX_GET(general_obj_in_cmd_hdr, in, uid);
+	uint32_t *obj_id = &obj->object_id;
+
+	*obj_id = devx_get_created_obj_id(in, out, opcode);
+	*dinlen = DEVX_ST_SZ_BYTES(general_obj_in_cmd_hdr);
+	DEVX_SET(general_obj_in_cmd_hdr, din, uid, uid);
+
+	switch (opcode) {
+	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
+		DEVX_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+		DEVX_SET(general_obj_in_cmd_hdr, din, obj_id, *obj_id);
+		DEVX_SET(general_obj_in_cmd_hdr, din, obj_type,
+			 DEVX_GET(general_obj_in_cmd_hdr, in, obj_type));
+		break;
+
+	case MLX5_CMD_OP_CREATE_UMEM:
+		DEVX_SET(destroy_umem_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_UMEM);
+		DEVX_SET(destroy_umem_in, din, umem_id, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_MKEY:
+		DEVX_SET(destroy_mkey_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_MKEY);
+		DEVX_SET(destroy_mkey_in, din, mkey_index, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_CQ:
+		DEVX_SET(destroy_cq_in, din, opcode, MLX5_CMD_OP_DESTROY_CQ);
+		DEVX_SET(destroy_cq_in, din, cqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_PD:
+		DEVX_SET(dealloc_pd_in, din, opcode, MLX5_CMD_OP_DEALLOC_PD);
+		DEVX_SET(dealloc_pd_in, din, pd, *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN:
+		DEVX_SET(dealloc_transport_domain_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_TRANSPORT_DOMAIN);
+		DEVX_SET(dealloc_transport_domain_in, din, transport_domain,
+			 *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_RMP:
+		DEVX_SET(destroy_rmp_in, din, opcode, MLX5_CMD_OP_DESTROY_RMP);
+		DEVX_SET(destroy_rmp_in, din, rmpn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_SQ:
+		DEVX_SET(destroy_sq_in, din, opcode, MLX5_CMD_OP_DESTROY_SQ);
+		DEVX_SET(destroy_sq_in, din, sqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_RQ:
+		DEVX_SET(destroy_rq_in, din, opcode, MLX5_CMD_OP_DESTROY_RQ);
+		DEVX_SET(destroy_rq_in, din, rqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_RQT:
+		DEVX_SET(destroy_rqt_in, din, opcode, MLX5_CMD_OP_DESTROY_RQT);
+		DEVX_SET(destroy_rqt_in, din, rqtn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_TIR:
+		DEVX_SET(destroy_tir_in, din, opcode, MLX5_CMD_OP_DESTROY_TIR);
+		DEVX_SET(destroy_tir_in, din, tirn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_TIS:
+		DEVX_SET(destroy_tis_in, din, opcode, MLX5_CMD_OP_DESTROY_TIS);
+		DEVX_SET(destroy_tis_in, din, tisn, *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_Q_COUNTER:
+		DEVX_SET(dealloc_q_counter_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
+		DEVX_SET(dealloc_q_counter_in, din, counter_set_id, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_FLOW_TABLE:
+		*dinlen = DEVX_ST_SZ_BYTES(destroy_flow_table_in);
+		DEVX_SET(destroy_flow_table_in, din, other_vport,
+			 DEVX_GET(create_flow_table_in,  in, other_vport));
+		DEVX_SET(destroy_flow_table_in, din, vport_number,
+			 DEVX_GET(create_flow_table_in,  in, vport_number));
+		DEVX_SET(destroy_flow_table_in, din, table_type,
+			 DEVX_GET(create_flow_table_in,  in, table_type));
+		DEVX_SET(destroy_flow_table_in, din, table_id, *obj_id);
+		DEVX_SET(destroy_flow_table_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_FLOW_TABLE);
+		break;
+	case MLX5_CMD_OP_CREATE_FLOW_GROUP:
+		*dinlen = DEVX_ST_SZ_BYTES(destroy_flow_group_in);
+		DEVX_SET(destroy_flow_group_in, din, other_vport,
+			 DEVX_GET(create_flow_group_in, in, other_vport));
+		DEVX_SET(destroy_flow_group_in, din, vport_number,
+			 DEVX_GET(create_flow_group_in, in, vport_number));
+		DEVX_SET(destroy_flow_group_in, din, table_type,
+			 DEVX_GET(create_flow_group_in, in, table_type));
+		DEVX_SET(destroy_flow_group_in, din, table_id,
+			 DEVX_GET(create_flow_group_in, in, table_id));
+		DEVX_SET(destroy_flow_group_in, din, group_id, *obj_id);
+		DEVX_SET(destroy_flow_group_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_FLOW_GROUP);
+		break;
+	case MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY:
+		*dinlen = DEVX_ST_SZ_BYTES(delete_fte_in);
+		DEVX_SET(delete_fte_in, din, other_vport,
+			 DEVX_GET(set_fte_in,  in, other_vport));
+		DEVX_SET(delete_fte_in, din, vport_number,
+			 DEVX_GET(set_fte_in, in, vport_number));
+		DEVX_SET(delete_fte_in, din, table_type,
+			 DEVX_GET(set_fte_in, in, table_type));
+		DEVX_SET(delete_fte_in, din, table_id,
+			 DEVX_GET(set_fte_in, in, table_id));
+		DEVX_SET(delete_fte_in, din, flow_index, *obj_id);
+		DEVX_SET(delete_fte_in, din, opcode,
+			 MLX5_CMD_OP_DELETE_FLOW_TABLE_ENTRY);
+		break;
+	case MLX5_CMD_OP_CREATE_FLOW_COUNTER:
+		DEVX_SET(dealloc_flow_counter_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_FLOW_COUNTER);
+		DEVX_SET(dealloc_flow_counter_in, din, flow_counter_id,
+			 *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT:
+		DEVX_SET(dealloc_packet_reformat_context_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_PACKET_REFORMAT_CONTEXT);
+		DEVX_SET(dealloc_packet_reformat_context_in, din,
+			 packet_reformat_id, *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT:
+		DEVX_SET(dealloc_modify_header_context_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_MODIFY_HEADER_CONTEXT);
+		DEVX_SET(dealloc_modify_header_context_in, din,
+			 modify_header_id, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT:
+		*dinlen = DEVX_ST_SZ_BYTES(destroy_scheduling_element_in);
+		DEVX_SET(destroy_scheduling_element_in, din,
+			 scheduling_hierarchy,
+			 DEVX_GET(create_scheduling_element_in, in,
+				  scheduling_hierarchy));
+		DEVX_SET(destroy_scheduling_element_in, din,
+			 scheduling_element_id, *obj_id);
+		DEVX_SET(destroy_scheduling_element_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_SCHEDULING_ELEMENT);
+		break;
+	case MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT:
+		*dinlen = DEVX_ST_SZ_BYTES(delete_vxlan_udp_dport_in);
+		DEVX_SET(delete_vxlan_udp_dport_in, din, vxlan_udp_port, *obj_id);
+		DEVX_SET(delete_vxlan_udp_dport_in, din, opcode,
+			 MLX5_CMD_OP_DELETE_VXLAN_UDP_DPORT);
+		break;
+	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
+		*dinlen = DEVX_ST_SZ_BYTES(delete_l2_table_entry_in);
+		DEVX_SET(delete_l2_table_entry_in, din, table_index, *obj_id);
+		DEVX_SET(delete_l2_table_entry_in, din, opcode,
+			 MLX5_CMD_OP_DELETE_L2_TABLE_ENTRY);
+		break;
+	case MLX5_CMD_OP_CREATE_QP:
+		DEVX_SET(destroy_qp_in, din, opcode, MLX5_CMD_OP_DESTROY_QP);
+		DEVX_SET(destroy_qp_in, din, qpn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_SRQ:
+		DEVX_SET(destroy_srq_in, din, opcode, MLX5_CMD_OP_DESTROY_SRQ);
+		DEVX_SET(destroy_srq_in, din, srqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_XRC_SRQ:
+		DEVX_SET(destroy_xrc_srq_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_XRC_SRQ);
+		DEVX_SET(destroy_xrc_srq_in, din, xrc_srqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_DCT:
+		DEVX_SET(destroy_dct_in, din, opcode, MLX5_CMD_OP_DESTROY_DCT);
+		DEVX_SET(destroy_dct_in, din, dctn, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_XRQ:
+		DEVX_SET(destroy_xrq_in, din, opcode, MLX5_CMD_OP_DESTROY_XRQ);
+		DEVX_SET(destroy_xrq_in, din, xrqn, *obj_id);
+		break;
+	case MLX5_CMD_OP_ATTACH_TO_MCG:
+		*dinlen = DEVX_ST_SZ_BYTES(detach_from_mcg_in);
+		DEVX_SET(detach_from_mcg_in, din, qpn,
+			 DEVX_GET(attach_to_mcg_in, in, qpn));
+		memcpy(DEVX_ADDR_OF(detach_from_mcg_in, din, multicast_gid),
+		       DEVX_ADDR_OF(attach_to_mcg_in, in, multicast_gid),
+		       DEVX_FLD_SZ_BYTES(attach_to_mcg_in, multicast_gid));
+		DEVX_SET(detach_from_mcg_in, din, opcode,
+			 MLX5_CMD_OP_DETACH_FROM_MCG);
+		DEVX_SET(detach_from_mcg_in, din, qpn, *obj_id);
+		break;
+	case MLX5_CMD_OP_ALLOC_XRCD:
+		DEVX_SET(dealloc_xrcd_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_XRCD);
+		DEVX_SET(dealloc_xrcd_in, din, xrcd, *obj_id);
+		break;
+	case MLX5_CMD_OP_CREATE_PSV:
+		DEVX_SET(destroy_psv_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_PSV);
+		DEVX_SET(destroy_psv_in, din, psvn, *obj_id);
+		break;
+	default:
+		/* The entry must match to one of the devx_is_obj_create_cmd */
+		assert(false);
+		break;
+	}
+}
+
+static struct mlx5dv_devx_obj *
+vfio_devx_obj_create(struct ibv_context *context, const void *in,
+		     size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(context);
+	struct mlx5_devx_obj *obj;
+	int ret;
+
+	if (!devx_is_obj_create_cmd(in)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	obj = calloc(1, sizeof(*obj));
+	if (!obj) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	ret = mlx5_vfio_cmd_exec(ctx, (void *)in, inlen, out, outlen, 0);
+	if (ret)
+		goto fail;
+
+	devx_obj_build_destroy_cmd(in, out, obj->dinbox,
+				   &obj->dinlen, &obj->dv_obj);
+	obj->dv_obj.context = context;
+
+	return &obj->dv_obj;
+fail:
+	free(obj);
+	return NULL;
+}
+
 static int vfio_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in,
 				size_t inlen, void *out, size_t outlen)
 {
-	return EOPNOTSUPP;
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(obj->context);
+
+	return mlx5_vfio_cmd_exec(ctx, (void *)in, inlen, out, outlen, 0);
+}
+
+static int vfio_devx_obj_modify(struct mlx5dv_devx_obj *obj, const void *in,
+				size_t inlen, void *out, size_t outlen)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(obj->context);
+
+	return mlx5_vfio_cmd_exec(ctx, (void *)in, inlen, out, outlen, 0);
+}
+
+static int vfio_devx_obj_destroy(struct mlx5dv_devx_obj *obj)
+{
+	struct mlx5_devx_obj *mobj = container_of(obj,
+						  struct mlx5_devx_obj, dv_obj);
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(obj->context);
+	uint32_t out[DEVX_ST_SZ_DW(general_obj_out_cmd_hdr)];
+	int ret;
+
+	ret = mlx5_vfio_cmd_exec(ctx, mobj->dinbox, mobj->dinlen,
+				 out, sizeof(out), 0);
+	if (ret)
+		return ret;
+
+	free(mobj);
+	return 0;
 }
 
 static struct mlx5_dv_context_ops mlx5_vfio_dv_ctx_ops = {
+	.devx_general_cmd = vfio_devx_general_cmd,
 	.devx_obj_create = vfio_devx_obj_create,
 	.devx_obj_query = vfio_devx_obj_query,
+	.devx_obj_modify = vfio_devx_obj_modify,
+	.devx_obj_destroy = vfio_devx_obj_destroy,
 	.devx_query_eqn = vfio_devx_query_eqn,
 	.devx_alloc_uar = vfio_devx_alloc_uar,
 	.devx_free_uar = vfio_devx_free_uar,
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 766c48c..2165a22 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -9,6 +9,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include "mlx5.h"
+#include "mlx5_ifc.h"
 
 #include <infiniband/driver.h>
 #include <util/interval_set.h>
@@ -303,6 +304,13 @@ struct mlx5_vfio_context {
 	struct mlx5_dv_context_ops *dv_ctx_ops;
 };
 
+#define MLX5_MAX_DESTROY_INBOX_SIZE_DW	DEVX_ST_SZ_DW(delete_fte_in)
+struct mlx5_devx_obj {
+	struct mlx5dv_devx_obj dv_obj;
+	uint32_t dinbox[MLX5_MAX_DESTROY_INBOX_SIZE_DW];
+	uint32_t dinlen;
+};
+
 static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
 {
 	return container_of(ibdev, struct mlx5_vfio_device, vdev.device);
-- 
1.8.3.1

