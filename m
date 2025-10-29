Return-Path: <linux-rdma+bounces-14118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9162FC1BE11
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6676D6E616B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E59340A67;
	Wed, 29 Oct 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp0gIR3O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0A33F39E;
	Wed, 29 Oct 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752666; cv=fail; b=QEvPiHXap94ctIuvUwdOSMWdho919dmBU5JZbPyvzV3LLLziGacWBRAnnjVDZPSoHwxip2oGdw2xV2pYrxGntevISTD3VqVz9EW1P71wvofyIoAXmia3/mG8f+xOJ7yjGgrxFZxGpT4iwLTI//P0kIB2VBln+QKmnsB6HOLrjMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752666; c=relaxed/simple;
	bh=4LFAk5GsGTCpc04IyCt5XHGeSnET48IZrM0FtP7a5/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGQmsex+nXmYfEpWXNLWsk/uh6ZkSHRUphgWxck+eVp5RUAreIRCFti94sGo3WFat655DbyTwPwxWJHcBpu7JQp9D2M1JAh2nwmbnrkNlzhUAB6gcPPuKV9dE0PkjELLI1rV+99/lkdgZKD7ATCzmKCRP5fDLHa/arAlky6VJAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp0gIR3O; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nclax/hslmCxojdhRxw6Ffp/8pJEMWu5Ss7QePE5LIEzl025YcE785BvftezzbUo8BqvHcmiVBFAMTpNJUQFneqZYgiib7PX7O+qIZV0vHpfsfI4mgwOUdQ69XhIm81m9XMtHGzKVQ+7JC9VtialCF80LVZix4W6cOa/Lc94Kvn8XwsyCLGQLGdligLArBKsZDCi5ISIU8PvUzCiLVs08hN7Hcd4zJwbu+sU/D4i1gOD80jNDzUJaj8KNgrC8asU8LHesl9+9U3IvpfdTrlkCbwag5ZTl/Egeuwe8OZsabMJ6UHFMk9bPLShu7VCDZpmizy/vN7JqLifUlTnk0H3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs7PQNxXSRiUIUWBq9VGhUhvMf07nAjfZ3Ryr+UsUO8=;
 b=WSGSKwtb/HjHduGzKlAoQqyys3ftoV2AAFUyYxWIBC3luoxCbYuSIaaGlhzTRtNaL/YbiFXKZst48wlgjadgWKxavM349F3kUVV0ib9Zd3aJNrsMz2z8cEpt1NiaUs0ucsDFY+bGA1ul9RcjAcnasoJbnbPIfVeomOz4DVs3qUzM+bHnMdvXvb0T1PLFT9SDePPcoTZBdM/9bns4mepp3nHTgcOQcR0M0sNO8YKIU5sfN1w1KgugDaRSdWSNrF69KF8QRrETEGTp8dAsNYQ+ZbCOgeDXW3gcH4ydbv23KQ4aSmDknIMDI/Vyb6Eqts6cvwp/XOjwL/90HzHxTYHyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs7PQNxXSRiUIUWBq9VGhUhvMf07nAjfZ3Ryr+UsUO8=;
 b=Gp0gIR3O4RcOPI6siMjgAEkIDqde6Fax8+I3cQBPYijrhGWBOYT4SPt7TicxEfXnbPtFMdMASCahzQXe4dM1Y/GEthWAxOKmjdwS2nwKNZX4xUGGf8SYPnbZ/PRiPmMztioB88S3Ixgz2t2IVapzgow6qxZM11nK0enH3lUUeLYe+FmVtWwq2FitUb9SvhpPOu0x4b3CXgp0PGAckOxBSW27zPb/JZFttF/nLHwQWyhcG0Chdn0/gadU5apFZ8ZOK437ltZQv6OfYmunQYFaCyPKjnnoxihkEYHWYBon8vlzTHelKBhsaoObxLBuiUza1Bw9lxHbRkrrYdkf/Xu6pA==
Received: from BN9PR03CA0378.namprd03.prod.outlook.com (2603:10b6:408:f7::23)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:44:20 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::9f) by BN9PR03CA0378.outlook.office365.com
 (2603:10b6:408:f7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 15:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:44:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:01 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:43:56 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 1/7] net/mlx5: Add OTHER_ESWITCH HW capabilities
Date: Wed, 29 Oct 2025 17:42:53 +0200
Message-ID: <20251029-support-other-eswitch-v1-1-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: ab597a22-b8f7-4118-430a-08de17020658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFnV3E0ZHZoSmdXZ1VEY0dwRjZlcVIzYW02UFd0dXFxSHY0Yk9CMHo3d2RG?=
 =?utf-8?B?Z0VpSG9VZ1dMOFA1bXNVVUw2aHVmc29UVnVrQXlPZ3J6VUdDV0lFaG8wZXA2?=
 =?utf-8?B?RXNueGVzMVE4aVYrUkkzOGxHOHIxZ1I3Wjhybm83Qlg4ZENzSnh4dDFsTXdu?=
 =?utf-8?B?RFBxQzh0MFVod1RHdUZuWUFRN0lqZzdwRWUwYXVuTFFVWUtrdXhWdlhCc3oz?=
 =?utf-8?B?b3F1bjdmVXhYbkhhUWMzSWRBdzJzVWlrUEtweVRkbkMzWlRSWDRqSUNiMXgv?=
 =?utf-8?B?YkhIc0NZOUEvUFJVek1GcU5OZWxIZDdmc21VSFVuZWpzdlZ5Rm1KVXNTai83?=
 =?utf-8?B?Y0FxS0FrSWRETXR5c3pubE9WK0RrWGRZZkdPWU5RdjV5c0ZvbkJlREJrQ0hB?=
 =?utf-8?B?MU5PTTlpWHk1SmxNQVB6NHRVcmUvQVdzMHNYeGpkcU4zajMvYTNWV2gvaldM?=
 =?utf-8?B?Ti8zVFlpaVJ3aGdZcFljQkxUckJTWi9DMVVTV29ZaENRVnE1K3l4emdXV2JU?=
 =?utf-8?B?Tjc5elRGM0lwbDhzVFlpR0RiQjFmSVBORHFqZlg2RW1KRVF2a2ZDT1ZvZjFO?=
 =?utf-8?B?WDFUQUFiWEpOSFIwdGxHem1iNTI3amErTE80WjBJMENHeWtiR2VSU0VTWncz?=
 =?utf-8?B?TytVSUxPWm93dDhuaE1Dai9EMlp2VkJxb2ZCb2JTaHlvV3l4dmxaT2pURUhF?=
 =?utf-8?B?NHQxSFdhTUxHY2xoTTQ0bUN5azVPM0xHZ3dXRDB0aFRrQVhQRHhWQWhaYld0?=
 =?utf-8?B?YmUxMFY1dXVGY3BLOTB0TEU5U0xtNTJpb0M0RDErc1g1dTFMSWdkODhPbDBr?=
 =?utf-8?B?ajRSTEtCZUV1ZGRvM1c5U2hhSnRJVnViNis5SUV2ZGtuWkpCYnlSV2NZaTlT?=
 =?utf-8?B?Y3hlSktrbjJxRmI4UG9aSWF4V0NZU1NpNVBMMzd1NHdJRDY1anJpWmhjUGhB?=
 =?utf-8?B?V0FXWkxPK1NOU1h5UzN2ek9xSjVwV3djTm1YNXZzTThKWEtzMFMvc010U0k5?=
 =?utf-8?B?eGg1VTBzRzBuR2NXMVI5aWJKMkxxaC8zOENUMnpyaE9FbGZmYk1KWGs3UkF4?=
 =?utf-8?B?RlJibEJzVHVUQ2R3N01vUVYyUHVrMlRzNEo0eFRueDVJNVdUazVmdWhodGVx?=
 =?utf-8?B?NGNvQmMrOWtYWnRpSUV5NEdFdTlUaXVEd1VxZjgwdzJxS1RUT3pWOTZPU09H?=
 =?utf-8?B?UHV5a0s1Sm82WE1uS3dOd2xsSkRKSy9YeTVPakl6eXQyVmo0ay9aZWNHMU51?=
 =?utf-8?B?L3ZkMWtYTmVwUzlUc3NvSURxQVM4K3MzWGhRV0FrU3lueGZaQ2FEeU5PS3kz?=
 =?utf-8?B?UitqUW55K281d1FsRlRiNytpMTN3L1NaeHZ0STI3bXJxd3Qwc21zdTZoTGxz?=
 =?utf-8?B?R0ljTTdNRHc3WHF4UTVHT2RlaXVjOS83bUxOOG9jVVNYaUkrcXM5cjFTTnFM?=
 =?utf-8?B?VmZRQmplam1SZGtNV2FHY0xVRmNWMENjRExHVmh4RUJWeEpEcTJ3TmNCc0FQ?=
 =?utf-8?B?aXkrRFNTUEgvZFF0aklBcURJaGhJUHUyL2daL0RKY2RKalJ2clJRSFQyTVNX?=
 =?utf-8?B?c3hNYTJ4MTAyY0dqTTMyNWllOTFNcFlxbTdPU1k2V2RwOUJYVFRKVjJzQzJ6?=
 =?utf-8?B?TzZnNUlWU25NbnI3YSsvRkRJdTY0MXFJRUVUdFc4YWM3TUFZYU12Z285dDRQ?=
 =?utf-8?B?MDZOVEpqcFNZeGtJWjhRR3hFdm9tam9zam80WEZubVBGZHFiRmVjazdJajZM?=
 =?utf-8?B?ay91TUNIUzNsOE4zZ05RY2xFTko5VldwSzdkN1V6dmFZT3ZUcDMyR3J3b2Q4?=
 =?utf-8?B?WkhiZFA0VVRZbkRWY3ZRblVLNEloWEVsbjF5aEpqVUZ0cE9DMXA4QVZDdktt?=
 =?utf-8?B?Y2h4bUZmS1p0bmk3MWpqcXZsZGtRNTlqQi9ZeWpMTDhwZlVnbVlZRXVVKzRv?=
 =?utf-8?B?cGpYNXBWSmJzdVkyVHpwSzEyTExKUGlVN0Fuc0JLQnkvL1V2a0JHN3lrdHlq?=
 =?utf-8?B?UnpIWGlsTVI3R3NaMzlGT0hSV2FBQjMxb0R1Mzd3K2pIU25iVDN0T0g3alRG?=
 =?utf-8?B?dy81Sy96b3daUUpmRXhianNGVDZtZ0NuOFA3eVNwbnNVYkNCczFxeGV5Z1BJ?=
 =?utf-8?Q?/eL3tHwLaLnfMqfm6bRNqLbK5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:19.5124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab597a22-b8f7-4118-430a-08de17020658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

From: Patrisious Haddad <phaddad@nvidia.com>

Add OTHER_ESWITCH capabilities which includes other_eswitch and
eswitch_owner_vhca_id to all steering objects.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 47 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 07614cd95bed..9b8f88987d2f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -5251,13 +5251,15 @@ struct mlx5_ifc_set_fte_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -8809,13 +8811,15 @@ struct mlx5_ifc_destroy_flow_table_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -8840,13 +8844,15 @@ struct mlx5_ifc_destroy_flow_group_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -8985,13 +8991,15 @@ struct mlx5_ifc_delete_fte_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -9535,13 +9543,15 @@ struct mlx5_ifc_create_flow_table_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x20];
 
@@ -9580,7 +9590,8 @@ struct mlx5_ifc_create_flow_group_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x20];
@@ -9588,7 +9599,7 @@ struct mlx5_ifc_create_flow_group_in_bits {
 	u8         table_type[0x8];
 	u8         reserved_at_88[0x4];
 	u8         group_type[0x4];
-	u8         reserved_at_90[0x10];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -11876,10 +11887,12 @@ struct mlx5_ifc_set_flow_table_root_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
-	u8         reserved_at_60[0x20];
+	u8         reserved_at_60[0x10];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         table_type[0x8];
 	u8         reserved_at_88[0x7];
@@ -11919,14 +11932,16 @@ struct mlx5_ifc_modify_flow_table_in_bits {
 	u8         op_mod[0x10];
 
 	u8         other_vport[0x1];
-	u8         reserved_at_41[0xf];
+	u8         other_eswitch[0x1];
+	u8         reserved_at_42[0xe];
 	u8         vport_number[0x10];
 
 	u8         reserved_at_60[0x10];
 	u8         modify_field_select[0x10];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x8];
+	u8         eswitch_owner_vhca_id[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];

-- 
2.47.1

