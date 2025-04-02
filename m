Return-Path: <linux-rdma+bounces-9110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F4A788A8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62AF1890576
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35833233158;
	Wed,  2 Apr 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQ897xSO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A1DE2B4
	for <linux-rdma@vger.kernel.org>; Wed,  2 Apr 2025 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577811; cv=fail; b=Mj8bob07c1+7WttlbHIRWyTBMmV5Yhtac+xXezc5E+oG3a1Rubj8aK5ZsdKEaE3HKdc5FSUmAg8EUOiLD+bHUxijIgR1QkgKm9OLyUqEB0n3ye9w2mHWvZ3iJRr79gXLZWD31zY7U9pfp0bUzuIDhS35RahwMjF3Zn+nEK0ye2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577811; c=relaxed/simple;
	bh=p/03IJXPWwSpcVXPIub643bUMAKS/zC6WQu+KXWEL1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7SK45d0DIwxkj6qiS23CW4vxTDGFg/Od9+IZ7FCZsPHi71iKiLDav4x2VwNQxhwTEU0XQxQRcvLjmDrGXEJljYB3ggaaJvDiGybOVGUtnVrlYmRwnq01CRQnf7CdaTz/g740uO1mOorT+dT/IvqHo3duQerjKZDKeW+tqDQUnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQ897xSO; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIWmBK//h83DnhFhkW51u0zuKPQ/Yp1RN0MogwP6623qikD+aAGkxwynomqnsUWYtJ1JoJjdZ0ztLWqM84CBroShzQ8aBGKihPKRgvWiDEJcahAu4Ilg/3EtedgEVQ1t4heuoeCz4q3YIaSdCfb10tF3m6nUa85FXpbB7xS/sbjNSA6IRm7h2SySuFMKKy8tSSikNpZBt5SmF2xxMdtXHli4pXhgAYWqBGSjmHettm2vvjahsROEDDDVfg0fJZYvn5HpfQuZp2mLMSshh4MKN7SyvbgPJTWo13Er43cTxXXjcXdGE+khR/g10aooPSQeJAOcfOWHYswS6FqXj4D7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dGsdyMCmFK6wMiqYoI16hMO6X7OBF4tYeAlUtnkgbM=;
 b=fSqBZqe+lDtzqlIfKJEFshQNTYDrJqin9X/pkoUVF8/IBFa9zpltGJMQqfZIYBqv6LUup8KtsNQLRuLnVeFzBXlbcjeSURbsPZ7o4uQSqcAV5X5RSfnL4zLoRSDHmxUhXiDo8tetzHMs4TKjLqrstYTCwUZ7yViDVwccjvH5tiE/YYBqh7QA34NPjurbwMlZz4FXmkxD6eHGxCivvxEghpTeGWpC+31dgTdKWJmfuma3qyM2MdrljZIEa8Qn2CWEC+uBdNGvq0HH2tf62aFWj9rbVYbTXcW3BMNPAn029nUY2BznH14yeWAqXYU/cK+3qPwE06b6vSJnH8G4rWKgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dGsdyMCmFK6wMiqYoI16hMO6X7OBF4tYeAlUtnkgbM=;
 b=EQ897xSO2BWkYpN+FAL6vxre4HyaB8aD8o9M4UkWNyNhGszhXiQNdbOSarrJzuVJeZpDkR3+VPAnVJN+Z48mU4hrjqEKkS5eP4KhSEQuG5QKiKOe9ZMisWJD+IMLchGocgJs2J1zu+y6lv6H1gKrUQEQBaj+aVuEvfXQDxG6oJRUPTriDsAtCkHtZ2bxc8Ka1BEg00cfLGruuJipFlu2DqFGDugZAfzcu89bLPzL7Mm4+JvsVwJT5IjwSSARSYsl/82IAOlvN5nlQevNT7JilyMz87ytqESNZ4SQ0SGJz6BZ4wsuDgKU7HIlPUC8llPA32A7yMESqNQEVg8Y6sgdKA==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 07:10:06 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::21) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 07:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 07:10:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Apr 2025
 00:09:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Apr
 2025 00:09:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 2 Apr
 2025 00:09:49 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Arnd Bergmann <arnd@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix compilation warning when USER_ACCESS isn't set
Date: Wed, 2 Apr 2025 10:09:44 +0300
Message-ID: <20250402070944.1022093-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0fa0f4-a794-4e44-6850-08dd71b5657b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTytidKzufbHyyurirzXwppLcD/G3ClZ9kWDoUZAJxs3vnLim4ICVOcB+1yd?=
 =?us-ascii?Q?XEVSJISJ2pJoF5GG5DvDdQ7qg9dHXTnoHhq1l5Tqap+F78Nt9/FfEZhL1Ns+?=
 =?us-ascii?Q?KGJNTv1lr0qKI08PG54So4HKbuwZpc4motz1jgnVK2zwN0obTC4tPv3O/GAC?=
 =?us-ascii?Q?geFjfYNhFVX654V9hna77sNT/mC5JRTMLWSNNklIC50QkayOLQakTns8YDea?=
 =?us-ascii?Q?C3J8cNZaz7T0+JRsVYl/obQD+w6HV5EGxzDj8fuo+GCvYjZuZ5/vBXBqlLJB?=
 =?us-ascii?Q?B+ZWlY/cAqFfAMuq3yKGS2CeCrS/G3qja4xvnQ5ek8ugJMWoxy9bNzl5JMl4?=
 =?us-ascii?Q?T938ptZJFg8NwowJhWMMXhB/229gqpLrSuRqErDUfJcnOtzXXq2kS7ZjTjG9?=
 =?us-ascii?Q?ArA6m+1HLZOH6YzNUZK3JJV3Hn4PT3kWt45n1LLfP2oBmM38GMmKNqW0eLEA?=
 =?us-ascii?Q?utQwZ0q4OuXSeOZE+Fc7bY9Mt3wtYgeF6AQFDKQDIfc4DhWcSi4CRMyANzQR?=
 =?us-ascii?Q?euOJLEeS+L/qSGD5HY04/qTN0X1t1zgImPXOw3DIS1XdVgu+/hA7x5NmZIhO?=
 =?us-ascii?Q?0Wq2waBQT7PzpRDmyEs5r6R7NZ4VzP4ioP35pRuXPuegRvIuU8gQSlOK+oAx?=
 =?us-ascii?Q?aS9ZvdZaDJCOA/PcWhrZbZ+iWG8EvfxQpKUdJpiolIpc6p0J4cXsz6vBeM2j?=
 =?us-ascii?Q?VHpSkH0TUWkOsbkOnG1siIa0pboXAPeEkjnOJ0I69UV45I9rKdChJfC5PMmX?=
 =?us-ascii?Q?7jUkCLptwKsf/ElZ8bBCN6n7iSbp1WSNxb5hhTQjiLwU1NAFO+YTnqlbTccl?=
 =?us-ascii?Q?j0492sM1doG82qICIPM5A+WOw9hsiLkiimDWSoGu8wcl5xBoSKYX66y1dK8I?=
 =?us-ascii?Q?AFaZ6TN9tHpN2AwNwroSr0ZukzRcbvbH9QSkZavjU3kZa9Jn4zGPk4qM6dYe?=
 =?us-ascii?Q?2gC6TcZ8MnRMGRHZ0hPv82z/lxdfyuu+PotVPU8MIEbLvNxaS/5krj9jUp5g?=
 =?us-ascii?Q?8ZAqXM0nNHZQ4dZfBkjhe4UpQvkxYKCEg12Behr6xZQiyU5dSTrqIE7JpZBc?=
 =?us-ascii?Q?bjLzXsEYwQVY5+04ZQH6u6SLIBzaDgK17Ti3QEkIq1qiRGkXRn2t2EW5QJyo?=
 =?us-ascii?Q?9Up/XeETVWAj9exJXwo4n/RRnX0O/qZ6UOWcSZrlz7ydi7Kba/9XHkp3iOwI?=
 =?us-ascii?Q?ZChSa270EMe4hrZw/6vOCfqi44Iq2BuTpu6W75W8Lsz6i75HLb7CCbJDWVSH?=
 =?us-ascii?Q?g88PhG8cT4tg0SuZFTP3s+vqYB+6hvJGe9+4spFUb2xUTCFS0di/vjT1EAq1?=
 =?us-ascii?Q?35xAAD2CT0Wj7ZeFgoBNqsQ1EfR/lm5dpTJrF/Z+YTjvXUlyKNw/d79LiH5A?=
 =?us-ascii?Q?JNNZiZp86o9KbLDWDzpDktn+U960IPHkcRmrCVSD81QFxjEQTlwncsf9J0To?=
 =?us-ascii?Q?8KDMfCn057u1a/ZjMIzWnqIjglGkMFk4a+j3dWu9YEBN7Iegrue2ol3Vs5l4?=
 =?us-ascii?Q?5OimAA+s5JOV9Oc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 07:10:06.0253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0fa0f4-a794-4e44-6850-08dd71b5657b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

The cited commit made fs.c always compile, even when
INFINIBAND_USER_ACCESS isn't set. This results in a compilation
warning about an unused object when compiling with W=1 and
USER_ACCESS is unset.

Fix this by defining uverbs_destroy_def_handler() even when
USER_ACCESS isn't set.

Fixes: 36e0d433672f ("RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 2 --
 include/rdma/ib_verbs.h         | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 251246c73b33..0ff9f18a71e8 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -3461,7 +3461,6 @@ DECLARE_UVERBS_NAMED_OBJECT(
 	&UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_DESTROY));
 
 const struct uapi_definition mlx5_ib_flow_defs[] = {
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
 		MLX5_IB_OBJECT_FLOW_MATCHER),
 	UAPI_DEF_CHAIN_OBJ_TREE(
@@ -3472,7 +3471,6 @@ const struct uapi_definition mlx5_ib_flow_defs[] = {
 	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
 		MLX5_IB_OBJECT_STEERING_ANCHOR,
 		UAPI_DEF_IS_OBJ_SUPPORTED(mlx5_ib_shared_ft_allowed)),
-#endif
 	{},
 };
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d42eae69d9a8..901353796fbb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4790,7 +4790,14 @@ void roce_del_all_netdev_gids(struct ib_device *ib_dev,
 
 struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
+#else
+static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
+{
+	return 0;
+}
+#endif
 
 struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
 				     enum rdma_netdev_t type, const char *name,
-- 
2.34.1


