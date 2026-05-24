Return-Path: <linux-rdma+bounces-21203-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Mm/CbcbE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21203-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:39:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 956205C2ECD
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B013015A53
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A26397E80;
	Sun, 24 May 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAZYT/21"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F039C01A;
	Sun, 24 May 2026 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637138; cv=fail; b=MM3VKDwyNY+vLS7O4sbPbmt9Mn3A3AvXC+uqKKf6jueCwl6v0gb/mRH4D8N75Mv1DxmuwgnZTb9cMUu4vae2OfY6tx6LKRdWYrkwAMjTXK7lZVcqLaQEdp6nPeEN9d5DfY/3GDYws5BTJPfQ/QVQqGes1wf4ht0CFjJAJyC8uvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637138; c=relaxed/simple;
	bh=cHQxrP1LR31KVj72AJV2fdObn32s82UeAK5GyXwbFLs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=exXQYMVxBQS7Hr58hSYgFeLDY76ie73kZrhkrcgUTUhu8ekA1LCs1LcvERYT9vsmHmzZAKB1wV1TXUd21SPR13EUX5COBtG5pc7MG30V6HpdUonNd58ecxr1Xr6nFeZ8dmVNEraxJubCEmP4nF+L/MEZwR07Qe8Gfd2gu4o5fbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAZYT/21; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJcQse4LigOHw4RCbev7uzHPBjEhj7/qUfHd86Z33WPca0m2sn423ue40TSxAmkOxEvSK/VekeFWkw0V7pPWXg68pBcTNyR3hUrUV6gjWtHiLIs3+HkmXYR+kftVeW2eU2Q+B8CQVUJi5q5o3+z/dxt/QXr4PTegI+/hsVjUCracdw/ULE3OiODtQgVtp18RTZ0T7kuHnxDkG/+4AsW8di+4wkkc7WsTnpZaX4L2npaygoYft8sE73kRKyc9SOzDhNu3LVPeO3012QmJrVM6rOSuUaK0PtczdjKi8lOm9LB2ztrP7L6f6ashOisgzxjuBb71WUyZaiuMw4UYR+G72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVRjMoslpC952PneAHMDAR5G8lmgmN2RINXiQjVZwHA=;
 b=K5JgnMfEmYMVrS2Pua7jToScjO0Bxr8RTM8tYLE7IMtIghkNS4EjFEfz/MIWoIvT0VvYNVLUK9TqAV5oYkT6QfC1pP9GtyD1LsLbboe7KoNc38OLDffmT1cqJnuWqUkfdAikY8FF/1r4pX8uHkuO21Xlu+fOqLZ+38RdFNeqTfiaDVe8zgG6CukAPwbFLX18wOlzNeLQritbreqENTc8KbSfUZH09XpiWVrrhKAZ2omTmLYTu7Bafi2wNs240cyhWjlem8KN6Q+eawEGfnImK0afeI48fcpzuUh91mlXuVgTPSnDU076d3Lzy+5MDpfWYhgULdj4C5B1AwtYgJMPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVRjMoslpC952PneAHMDAR5G8lmgmN2RINXiQjVZwHA=;
 b=YAZYT/21I4kwYgHR/8VE5eaFaS2Oap5nag7nk1aCHNmDkwQFpnFFYBmKRtro8sH6Kl23MBLjA35rcIhrNjcR8LB5blt/kjQLR+Vxr2sDjEh8UHtnC9YbtnZYyuEUdoQrjNqJo02jy7RT5ij37qRyXQLdAAP0+54Zjz1iIWiQDoleYrFUGlm4zO3CUrDUMe7FJNltWxI42cHVw0ExFQuPTTghfqXuiJ5h738sM7ie4Aon5iPZnzaO9E3o4LeuIqXPRVmMddEHeup0mF9+U0rFxIT67Z9783TBLewnXWSdqN8Wo1OuJcE0rQ5ewMBn1V7VcZJVZOVjb5/NLbHGk67HEA==
Received: from PH7P220CA0077.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::12)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:38:51 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::20) by PH7P220CA0077.outlook.office365.com
 (2603:10b6:510:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:38:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:36 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:33 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 0/8] RDMA: Extend packet pacing support to UD and
 UC QPs
Date: Sun, 24 May 2026 18:38:01 +0300
Message-ID: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkbE2oC/x2MQQqAIBAAvxJ7TjArrb4SHaxWWyILjQjCv2edh
 jnMPBDQEwbosgc8XhRod0mKPINp0c4iozk5CC4kr0XFDj2teH4gZ9mIRjaqNmWrOKTm8Gjo/n8
 9+HnTzOF9whDjC6pqnxNqAAAA
X-Change-ID: 20260524-packet-pacing-bef6875f3970
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2392;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=cHQxrP1LR31KVj72AJV2fdObn32s82UeAK5GyXwbFLs=;
 b=vn0W3aG16aYMTsBpIXfXRJ10BVYZReuW1mP/clqJiVLsSim/YhD/l9zsDNsuX6Oy5T3UMgMBZ
 D+uNFMf8XiHAXGETzR4ESqcCWD9t20UVfRrhrDKDg64tbx+AMpdIFtO
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: ff720bde-3c2c-470f-db8e-08deb9aa8e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OvAHiUlRY0gGsWYN444fHtWVqewJEEbtrZQy9/95cXuTExpb62Qhwkqm+G4ROLbWoKENKDgY541wy1lO0Pfm+1ngbnoso/BSUIR2TWovLOdszrufblM5mO9pYgPqCRzKhsgemkT0ij2SyJlan0dLTTRV98owsH6ylDU6uChNXByOUI8/vdIpdrQ6ZNa6quKYOAUguyYtf7yz3abM/M+n4YYTtuN6c4706ar3OTiAFkheZowemjgnL74+7uY1XX79WPCADby9/TC8Wb210x6J9J3aANUwE8ppQj0o/E8MvdVl2n4nfEvKJ3amRIBur5LlxPakenB9Li0vL3y942yVw9p4Uz6Fzo0+cHyjwZtQ9YS860xpqP25D/RR7BQB0qE4wkpoBkzr/Gg2lCXS1T7yOFnbSGH+FzJdgkaw+60RLFaimtruSm22MKhLRHiCCjVKlaKjvLLR0X3mFXog6ZkWQmL9gSauO7i0G1BKWZ4REbI4wwVcmF9EIkNyuTK9C2f8NT4fzrqsqIzJ3JvjcGg6ot3C0O/hgWcPbvN+/sACT3cYal0LdHrCuIuqaAT9QH/RQp8b8meCck9RtJTrWk7BbQyPPCEnLksjSJzovN0hRMxtqMb+lrgKPUxVXr9jQNmzB8uGa+eb7YnabtsqTPpQC8zNZu42IGhnt405RR8zs70HJngWs3/2nEnYgFtl9ReMIhFX+7Qm+Wjt6tr9M7a3QsW1CqXz3LpkMQbUEctHN8Y=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+cfaf9Ot2nCx+nKJT8c0trxOz7QDkp9wEsfmZ94drS3F0Leno3SW5jQMyesB8AyrY71SaLQ8OkmgPGBDs0pHVOzibmByQQAUbCMQQ+IHfxhHvsgeTwGDLDt6Pb9IljcV36DaQfzvDUqLTRMGCNA+vy0PlEo5yk3qxGdlIAbXeDWkaA29oUlXnvbeTIYLEgK8M/zKxIvCGwCc9lC0t6TD00r4wSp5z4N8ezJkZRMhyyL0+KuF2K8DfCvcGpO7ku1ziz0prIUrVscWmUGK8nHno43E0v28Vp0RqVMXKcQ3o8VUDBma0Na6rJM8H0RyU/8reUnScD/EQtVOfgkHt/dGW4hzSR6yfu7uMfmcdVcmSW7dnPs09dLG0PNcy4noh8YssMoZzBb7cAZDv44ygyDkQvAuyFBLMm03a5Y64jW19BGgScJbYLo4YbN7Lpz6xlC4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:38:51.1416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff720bde-3c2c-470f-db8e-08deb9aa8e18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21203-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 956205C2ECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The primary goal of this series is to extend mlx5 packet pacing (rate
limit) beyond raw packet QPs to cover UD and UC QPs while keeping the
IB core free of vendor-specific policy for non-standard modify
attributes.

Today, IB_QP_RATE_LIMIT is restricted by the IB core qp_state_table
to RC QPs only. It is also the only non-standard modify QP attribute,
but as rate limit support expands across vendors, and as additional
non-standard attributes are likely to follow, centralizing such policy
in the core becomes impractical. Each driver is better positioned to
enforce its own supported QP types and transitions over non-standard
attributes. The series therefore removes IB_QP_RATE_LIMIT from the
qp_state_table and modifies the affected vendor drivers to validate the
attribute locally, preserving their existing behavior.

The patches are ordered so that every vendor driver validates
the attribute internally before the core delegation takes effect.
Patches 1-5 implement the mlx5 feature itself, patches 6-7 prepare
bnxt_re and ionic, and patch 8 performs the IB core change.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Maher Sanalla (8):
      net/mlx5: Add UD and UC packet pacing caps
      RDMA/mlx5: Refactor raw packet QP rate limit handling
      RDMA/mlx5: Add support for rate limit in UD and UC QPs
      RDMA/mlx5: Support deferred rate limit configuration
      RDMA/mlx5: Report packet pacing capabilities when querying device
      RDMA/bnxt_re: Validate rate limit attribute in modify QP
      RDMA/ionic: Validate rate limit attribute in modify QP
      IB/core: Delegate IB_QP_RATE_LIMIT validation to drivers

 drivers/infiniband/core/verbs.c                 |  13 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  22 ++-
 drivers/infiniband/hw/ionic/ionic_controlpath.c |  21 +-
 drivers/infiniband/hw/mlx5/main.c               |  37 ++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |   1 +
 drivers/infiniband/hw/mlx5/qp.c                 | 253 +++++++++++++++++-------
 include/linux/mlx5/mlx5_ifc.h                   |   8 +-
 include/linux/mlx5/qp.h                         |   1 +
 8 files changed, 256 insertions(+), 100 deletions(-)
---
base-commit: 67464f388d52ec172be62c99fc43697437ffa384
change-id: 20260524-packet-pacing-bef6875f3970

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


