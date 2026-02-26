Return-Path: <linux-rdma+bounces-17227-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MdlEYdUoGmPiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17227-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:11:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91D1A742F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 725BD3140B73
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1323D1CD4;
	Thu, 26 Feb 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6YGLpjM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD443D1CAE;
	Thu, 26 Feb 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114003; cv=fail; b=CTrDinICrM4xBCAqmFoZrEIAvlnckdzplhRiU+oVv2jZpck7SZCsuaaFiXuLS2KhC2O4+N6iHPNWIav/YXPy0b0G0TtuV+J1sPpU+aZqHtdbHSVbSZLBNMUX9jnMIa4S1Byt0Jhb6RXWqgGdyJyYCvOREATjSPSl8TzJHLM9738=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114003; c=relaxed/simple;
	bh=3dh28JHdL1zlta6nRUFAIZV3p0EDw6xLh1s8stbu37M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EdZ21gananOuyCGHKPs067Dsn+NeQrTvIkRY5P4j1aAkukFmU6fZ2U6u1iXJNfO0wNbyiTosD4PP6XqQgon/5V0DVnYm8qm2csi21UtjqfORX0mABImnQjFpAywlTtaQdkq9YPjJYq5vDk9bzsiUSDpBOPjLnT/v+khlFe0Z+XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6YGLpjM; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIDAJyLK0sty5i29o/CmEr66QMkdNH016P5Vo1dernW3OfBYcpq5sy30xC5BUYcY7cebr5M25bOKZ44Gg6ME4welX59GW0P4JBqD4nL6oczsINyKqjzgBPaUXPGmx3qQhzOcXuMTsfChPorfvjgZQkJjG8c6Kv3St8eXHe0f325Qw9AuGLajvR1IX68hnVmIq6CNdrRBHXyyZjjfPszKVC0Xua85pFvO99fks9D1Tpm13MprYL1684xuizx/9cxE3yHHDg1SmVUGXOfCkH2yGjkKYCRRxulGiJMielIHpqYVWei8mMdV1QKyPz6pNOE8kqZe7XaeEbsJTb43i4HtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1G1SwRnNWG2Xsy/6MSLjkheX8O4BOPn2o1t78d2ULw=;
 b=J11kHHbfSHR6fSGRpr8g0bXEauo+sod/F76Akt1Y8CempVcbYjqrjX2I+2mWb6vSRwxHl77Hv973CWCIPNsdYoJ4rZF5mYKp6OXsYO1uCQ1dq4Tg+sPY6qjhHGjt+LrJ9aQv2ip9vbJwMqSf7VJjl9BuYBL09vg+WCASLMCwGqc08KTuRaIBmN4W1UjcKZWYt0AWlsZJP1jtEwo4h6OlHCr/FUqUUUns3rLMnSHqPG1lNFNmxLlrK28q1/nGu0HFz3jIfQo2+9cIOhbGrn3eN0GZv33xU4U3RbZd35126I6SqQZCbp1zVdWgrOWrbe+kTCgllKsDLtyzzCkqYBvl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1G1SwRnNWG2Xsy/6MSLjkheX8O4BOPn2o1t78d2ULw=;
 b=t6YGLpjMa2tfout2Hb1ZrEw/ZPHoyQhIaDFbwwtPcg9MyxIn8Q5xEXPI+8vqlZVQ0k/mRuGwsG25ZJNo+Yp9mmaAaUApyBPfz7dea0TsQ0bP+bZjClQ/4XQgo9EdZilEUE6613nJUTCxk38ZuoHPOuJQ8cctsEnrN3/4IhH3KIx+UjvNG9ZHd/jnI6U/h7ct8bW/9VNmPk1qye2RTtbuVjIuE1coLyyNKweul1YccpQx8KmbEzvg5l4/F/OK492vGSg5CEnBNA8uimp83b8XnkPVicPrvaSHUSI9CG25ckd0gi7sQHpL+F7cZF8OzsPqKRzbZh2me5gpSa3jgr1njQ==
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 13:53:01 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::3d) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 13:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:47 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:46 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:43 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:11 +0200
Subject: [PATCH rdma-next v4 06/11] RDMA/mlx5: Switch from MR cache to FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-6-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=46591;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=P1RLd5oJZo9kkMDaFMZjamk8L88wJsy0geK2bA36KXE=;
 b=tposVYNe16OIwk9I4/JWupZcLpdxGeYHwZcGaQ61Fi1IegVOqocru2EC+2JSKDRamJfssZ5Gn
 80DKkfiBfY+Aplt/y9K05+1ao3MrL1NCxQDBx0I++uLF88SfKS9w3ar
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c513df-7974-48b0-af05-08de753e5ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	199tpAwUYza3ysbdV0P0LFJ8B61zhXjv13opKTdS3vkafG/DQLBQhWRSkE2JsmGfAaBkhGU9koRbwfe/CwStrXshoNVCDbcYK43IHgMGK3EBm62qoNYmzn+bcB8DoJ0vixTZ9pb9c2rJ/W5J85kmoOxAKlCJ6OXVEdeBIC7RhhJLKw4n8rNd6GaVUpb1YXz1OQcE8TGOUmRu4EZBZZdcFlQx5A0qa6W4peKf6O33IMtO54b+REErDjS3w4GfMxwc4ERb2eM7oAtOzD6wbeVUKXmFW29oai9BKFEMpkMlXDbNs8fStyAlY119OLlGokTbYaYOqIqBAQ7b+VrUe+DpWwyA7N2rD1G5RI1j0xg70G/m+zdWSn2NyqozabDr6xa7PAh4eUkn2QIiIN6l3Wrh82/WZJFvAi52gpiLPIep3M3LpoUP6OZVMzFfikf/7MC1tZ6iR7tw89qAtsyKrPVBw6OOGyUsXoXWEig3SwwdzHGaOJS6tTQlHjlKLigC333bv4gTRK5tF2xWs2axzqcoft11ZyV2RIB9rV59ge28ECCJcf32s9VjDxvRMSxxnVivoRglr1SRiT1yEy/w266LfV9s0gneABwYQBu3B8/ypoYXgPKARaiy6LaMOyo0wtR7FnoiYnN0CAviHe4WSkR/2OunGAxVOipnvwgAMK66F7L24NpKFDpFX6aRJZxMuLbHxuGuj1jmM3lhe9cbRUtJtTTaZE6PPwz0VIev+6vN+a2JXM+ZHYp3Nc7+cpoZH3BEfAQwgMuTuabulNCzxtpHlu2D2MPmIV2vcpXiTkALE06GI4M24I5RlfQ23SaUgnYZeUelCNzQjC4rJOWUC7W0Hw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0TUazB4hjjbUoHHPqS5nWfcBV/T3XR9g1ZQRhxQ+Nrz1TgD4EiOM30iltj0JxZQ0Rr3oi3dUJvxgzhJEjpSzSujOjLoBobqoiNSkMOH1cynBl08F98B/LrnVjB+95h9ypJaRmePWvtOKely1KLvmLCQy7DUKQLAwRcr4ezXpraBrWtKzB4/mabySpLHB1nHA1ned1HBLjM6gIfbxmj99RSbogcXgVc9PR7/XcWGYEN/4pIsdi3lG7UdQmRMzvAOFLoiXHH41p1fgt1SNlq7Q/oOehuPmLrRBFaFwV5S60fSCsWSPZuihqOrlhFKfHIsVF4LnYdXboCWdQT6tY5/u28RnRc+3wrjgf4NQ5/L4K3soaZ1CbbYbpYqlEl6Hd/QPcKd9X+ZWuczb+w5f/V859RIHqAbmLm03Cs4zlt3Q5/9WZP+gDe+Xrj2RARUvmZ+n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:00.4292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c513df-7974-48b0-af05-08de753e5ad1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17227-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,rb_key.ph:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CB91D1A742F
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Use the new generic FRMR pools mechanism to optimize the performance of
memory registrations.
The move to the new generic FRMR pools will allow users configuring MR
cache through debugfs of MR cache to use the netlink API for FRMR pools
which will be added later in this series. Thus being able to have more
flexibility configuring the kernel and also being able to configure on
machines where debugfs is not available.

Mlx5_ib will save the mkey index as the handle in FRMR pools, same as the
MR cache implementation.
Upon each memory registration mlx5_ib will try to pull a handle from FRMR
pools and upon each deregistration it will push the handle back to it's
appropriate pool.

Use the vendor key field in umr pool key to save the access mode of the
mkey.

Use the option for kernel-only FRMR pool to manage the mkeys used for
registration with DMAH as the translation between UAPI of DMAH and the
mkey property of st_index is non-trivial and changing dynamically.
Since the value for no PH is 0xff and not zero, switch between them in
the frmr_key to have a zero'ed kernel_vendor_key when not using DMAH.

Remove the limitation we had with MR cache for mkeys up to 2^20 dma
blocks and support mkeys up to HW limitations according to caps.

Remove all MR cache related code.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |    7 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   86 +--
 drivers/infiniband/hw/mlx5/mr.c      | 1142 ++++++----------------------------
 drivers/infiniband/hw/mlx5/odp.c     |   19 -
 drivers/infiniband/hw/mlx5/umr.h     |    1 +
 5 files changed, 191 insertions(+), 1064 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c4d2fc58e7a8a8fc65b4585a9e26aadffde899aa..17249f2023de6d2e3bcfe24522e2110b26fdb676 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4876,7 +4876,7 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 
 static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 {
-	mlx5_mkey_cache_cleanup(dev);
+	mlx5r_frmr_pools_cleanup(&dev->ib_dev);
 	mlx5r_umr_resource_cleanup(dev);
 	mlx5r_umr_cleanup(dev);
 }
@@ -4894,9 +4894,10 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mlx5_mkey_cache_init(dev);
+	ret = mlx5r_frmr_pools_init(&dev->ib_dev);
 	if (ret)
-		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
+		mlx5_ib_warn(dev, "frmr pools init failed %d\n", ret);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4f4114d9513000e63b83554cf5903d57cc0d401d..5031c186ed7a97d630fbf976025617a42682da43 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -641,25 +641,12 @@ enum mlx5_mkey_type {
 /* Used for non-existent ph value */
 #define MLX5_IB_NO_PH 0xff
 
-struct mlx5r_cache_rb_key {
-	u8 ats:1;
-	u8 ph;
-	u16 st_index;
-	unsigned int access_mode;
-	unsigned int access_flags;
-	unsigned int ndescs;
-};
-
 struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
-	/* Cacheable user Mkey must hold either a rb_key or a cache_ent. */
-	struct mlx5r_cache_rb_key rb_key;
-	struct mlx5_cache_ent *cache_ent;
-	u8 cacheable : 1;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
@@ -784,68 +771,6 @@ struct umr_common {
 	struct mutex init_lock;
 };
 
-#define NUM_MKEYS_PER_PAGE \
-	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
-
-struct mlx5_mkeys_page {
-	u32 mkeys[NUM_MKEYS_PER_PAGE];
-	struct list_head list;
-};
-static_assert(sizeof(struct mlx5_mkeys_page) == PAGE_SIZE);
-
-struct mlx5_mkeys_queue {
-	struct list_head pages_list;
-	u32 num_pages;
-	unsigned long ci;
-	spinlock_t lock; /* sync list ops */
-};
-
-struct mlx5_cache_ent {
-	struct mlx5_mkeys_queue	mkeys_queue;
-	u32			pending;
-
-	char                    name[4];
-
-	struct rb_node		node;
-	struct mlx5r_cache_rb_key rb_key;
-
-	u8 is_tmp:1;
-	u8 disabled:1;
-	u8 fill_to_high_water:1;
-	u8 tmp_cleanup_scheduled:1;
-
-	/*
-	 * - limit is the low water mark for stored mkeys, 2* limit is the
-	 *   upper water mark.
-	 */
-	u32 in_use;
-	u32 limit;
-
-	/* Statistics */
-	u32                     miss;
-
-	struct mlx5_ib_dev     *dev;
-	struct delayed_work	dwork;
-};
-
-struct mlx5r_async_create_mkey {
-	union {
-		u32 in[MLX5_ST_SZ_BYTES(create_mkey_in)];
-		u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
-	};
-	struct mlx5_async_work cb_work;
-	struct mlx5_cache_ent *ent;
-	u32 mkey;
-};
-
-struct mlx5_mkey_cache {
-	struct workqueue_struct *wq;
-	struct rb_root		rb_root;
-	struct mutex		rb_lock;
-	struct dentry		*fs_root;
-	unsigned long		last_add;
-};
-
 struct mlx5_ib_port_resources {
 	struct mlx5_ib_gsi_qp *gsi;
 	struct work_struct pkey_change_work;
@@ -1182,8 +1107,6 @@ struct mlx5_ib_dev {
 	struct mlx5_ib_resources	devr;
 
 	atomic_t			mkey_var;
-	struct mlx5_mkey_cache		cache;
-	struct timer_list		delay_timer;
 	/* Prevents soft lock on massive reg MRs */
 	struct mutex			slow_path_mutex;
 	struct ib_odp_caps	odp_caps;
@@ -1442,13 +1365,8 @@ int mlx5_ib_query_port_speed(struct ib_device *ibdev, u32 port_num,
 void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
-int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
-void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
-struct mlx5_cache_ent *
-mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
-			      struct mlx5r_cache_rb_key rb_key,
-			      bool persistent_entry);
-
+int mlx5r_frmr_pools_init(struct ib_device *device);
+void mlx5r_frmr_pools_cleanup(struct ib_device *device);
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags, int access_mode,
 				       int ndescs);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6cb21290082079fcfa61d8a3b5de3970d38836ba..cbe34251e340b96abb9c191da7a8c3be71d1ae3b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -31,7 +31,6 @@
  * SOFTWARE.
  */
 
-
 #include <linux/kref.h>
 #include <linux/random.h>
 #include <linux/debugfs.h>
@@ -39,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-resv.h>
+#include <rdma/frmr_pools.h>
 #include <rdma/ib_umem_odp.h>
 #include "dm.h"
 #include "mlx5_ib.h"
@@ -46,15 +46,15 @@
 #include "data_direct.h"
 #include "dmah.h"
 
-enum {
-	MAX_PENDING_REG_MR = 8,
-};
-
-#define MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS 4
 #define MLX5_UMR_ALIGN 2048
 
-static void
-create_mkey_callback(int status, struct mlx5_async_work *context);
+static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
+{
+	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
+		return MLX5_MAX_UMR_EXTENDED_SHIFT;
+	return MLX5_MAX_UMR_SHIFT;
+}
+
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
 				     unsigned long page_size, bool populate,
@@ -111,23 +111,6 @@ static int mlx5_ib_create_mkey(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
-static int mlx5_ib_create_mkey_cb(struct mlx5r_async_create_mkey *async_create)
-{
-	struct mlx5_ib_dev *dev = async_create->ent->dev;
-	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	size_t outlen = MLX5_ST_SZ_BYTES(create_mkey_out);
-
-	MLX5_SET(create_mkey_in, async_create->in, opcode,
-		 MLX5_CMD_OP_CREATE_MKEY);
-	assign_mkey_variant(dev, &async_create->mkey, async_create->in);
-	return mlx5_cmd_exec_cb(&dev->async_ctx, async_create->in, inlen,
-				async_create->out, outlen, create_mkey_callback,
-				&async_create->cb_work);
-}
-
-static int mkey_cache_max_order(struct mlx5_ib_dev *dev);
-static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent);
-
 static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	WARN_ON(xa_load(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key)));
@@ -135,94 +118,6 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	return mlx5_core_destroy_mkey(dev->mdev, mr->mmkey.key);
 }
 
-static void create_mkey_warn(struct mlx5_ib_dev *dev, int status, void *out)
-{
-	if (status == -ENXIO) /* core driver is not available */
-		return;
-
-	mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
-	if (status != -EREMOTEIO) /* driver specific failure */
-		return;
-
-	/* Failed in FW, print cmd out failure details */
-	mlx5_cmd_out_err(dev->mdev, MLX5_CMD_OP_CREATE_MKEY, 0, out);
-}
-
-static int push_mkey_locked(struct mlx5_cache_ent *ent, u32 mkey)
-{
-	unsigned long tmp = ent->mkeys_queue.ci % NUM_MKEYS_PER_PAGE;
-	struct mlx5_mkeys_page *page;
-
-	lockdep_assert_held(&ent->mkeys_queue.lock);
-	if (ent->mkeys_queue.ci >=
-	    ent->mkeys_queue.num_pages * NUM_MKEYS_PER_PAGE) {
-		page = kzalloc_obj(*page, GFP_ATOMIC);
-		if (!page)
-			return -ENOMEM;
-		ent->mkeys_queue.num_pages++;
-		list_add_tail(&page->list, &ent->mkeys_queue.pages_list);
-	} else {
-		page = list_last_entry(&ent->mkeys_queue.pages_list,
-				       struct mlx5_mkeys_page, list);
-	}
-
-	page->mkeys[tmp] = mkey;
-	ent->mkeys_queue.ci++;
-	return 0;
-}
-
-static int pop_mkey_locked(struct mlx5_cache_ent *ent)
-{
-	unsigned long tmp = (ent->mkeys_queue.ci - 1) % NUM_MKEYS_PER_PAGE;
-	struct mlx5_mkeys_page *last_page;
-	u32 mkey;
-
-	lockdep_assert_held(&ent->mkeys_queue.lock);
-	last_page = list_last_entry(&ent->mkeys_queue.pages_list,
-				    struct mlx5_mkeys_page, list);
-	mkey = last_page->mkeys[tmp];
-	last_page->mkeys[tmp] = 0;
-	ent->mkeys_queue.ci--;
-	if (ent->mkeys_queue.num_pages > 1 && !tmp) {
-		list_del(&last_page->list);
-		ent->mkeys_queue.num_pages--;
-		kfree(last_page);
-	}
-	return mkey;
-}
-
-static void create_mkey_callback(int status, struct mlx5_async_work *context)
-{
-	struct mlx5r_async_create_mkey *mkey_out =
-		container_of(context, struct mlx5r_async_create_mkey, cb_work);
-	struct mlx5_cache_ent *ent = mkey_out->ent;
-	struct mlx5_ib_dev *dev = ent->dev;
-	unsigned long flags;
-
-	if (status) {
-		create_mkey_warn(dev, status, mkey_out->out);
-		kfree(mkey_out);
-		spin_lock_irqsave(&ent->mkeys_queue.lock, flags);
-		ent->pending--;
-		WRITE_ONCE(dev->fill_delay, 1);
-		spin_unlock_irqrestore(&ent->mkeys_queue.lock, flags);
-		mod_timer(&dev->delay_timer, jiffies + HZ);
-		return;
-	}
-
-	mkey_out->mkey |= mlx5_idx_to_mkey(
-		MLX5_GET(create_mkey_out, mkey_out->out, mkey_index));
-	WRITE_ONCE(dev->cache.last_add, jiffies);
-
-	spin_lock_irqsave(&ent->mkeys_queue.lock, flags);
-	push_mkey_locked(ent, mkey_out->mkey);
-	ent->pending--;
-	/* If we are doing fill_to_high_water then keep going. */
-	queue_adjust_cache_locked(ent);
-	spin_unlock_irqrestore(&ent->mkeys_queue.lock, flags);
-	kfree(mkey_out);
-}
-
 static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 {
 	int ret = 0;
@@ -242,537 +137,6 @@ static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 	return ret;
 }
 
-static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
-{
-	set_mkc_access_pd_addr_fields(mkc, ent->rb_key.access_flags, 0,
-				      ent->dev->umrc.pd);
-	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, ent->rb_key.access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2,
-		(ent->rb_key.access_mode >> 2) & 0x7);
-	MLX5_SET(mkc, mkc, ma_translation_mode, !!ent->rb_key.ats);
-
-	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_mkc_octo_size(ent->rb_key.access_mode,
-				   ent->rb_key.ndescs));
-	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
-
-	if (ent->rb_key.ph != MLX5_IB_NO_PH) {
-		MLX5_SET(mkc, mkc, pcie_tph_en, 1);
-		MLX5_SET(mkc, mkc, pcie_tph_ph, ent->rb_key.ph);
-		if (ent->rb_key.st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
-			MLX5_SET(mkc, mkc, pcie_tph_steering_tag_index,
-				 ent->rb_key.st_index);
-	}
-}
-
-/* Asynchronously schedule new MRs to be populated in the cache. */
-static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
-{
-	struct mlx5r_async_create_mkey *async_create;
-	void *mkc;
-	int err = 0;
-	int i;
-
-	for (i = 0; i < num; i++) {
-		async_create = kzalloc_obj(struct mlx5r_async_create_mkey);
-		if (!async_create)
-			return -ENOMEM;
-		mkc = MLX5_ADDR_OF(create_mkey_in, async_create->in,
-				   memory_key_mkey_entry);
-		set_cache_mkc(ent, mkc);
-		async_create->ent = ent;
-
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (ent->pending >= MAX_PENDING_REG_MR) {
-			err = -EAGAIN;
-			goto free_async_create;
-		}
-		ent->pending++;
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-
-		err = mlx5_ib_create_mkey_cb(async_create);
-		if (err) {
-			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
-			goto err_create_mkey;
-		}
-	}
-
-	return 0;
-
-err_create_mkey:
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	ent->pending--;
-free_async_create:
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-	kfree(async_create);
-	return err;
-}
-
-/* Synchronously create a MR in the cache */
-static int create_cache_mkey(struct mlx5_cache_ent *ent, u32 *mkey)
-{
-	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	void *mkc;
-	u32 *in;
-	int err;
-
-	in = kzalloc(inlen, GFP_KERNEL);
-	if (!in)
-		return -ENOMEM;
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_cache_mkc(ent, mkc);
-
-	err = mlx5_core_create_mkey(ent->dev->mdev, mkey, in, inlen);
-	if (err)
-		goto free_in;
-
-	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
-free_in:
-	kfree(in);
-	return err;
-}
-
-static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
-{
-	u32 mkey;
-
-	lockdep_assert_held(&ent->mkeys_queue.lock);
-	if (!ent->mkeys_queue.ci)
-		return;
-	mkey = pop_mkey_locked(ent);
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-	mlx5_core_destroy_mkey(ent->dev->mdev, mkey);
-	spin_lock_irq(&ent->mkeys_queue.lock);
-}
-
-static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
-				bool limit_fill)
-	__acquires(&ent->mkeys_queue.lock) __releases(&ent->mkeys_queue.lock)
-{
-	int err;
-
-	lockdep_assert_held(&ent->mkeys_queue.lock);
-
-	while (true) {
-		if (limit_fill)
-			target = ent->limit * 2;
-		if (target == ent->pending + ent->mkeys_queue.ci)
-			return 0;
-		if (target > ent->pending + ent->mkeys_queue.ci) {
-			u32 todo = target - (ent->pending + ent->mkeys_queue.ci);
-
-			spin_unlock_irq(&ent->mkeys_queue.lock);
-			err = add_keys(ent, todo);
-			if (err == -EAGAIN)
-				usleep_range(3000, 5000);
-			spin_lock_irq(&ent->mkeys_queue.lock);
-			if (err) {
-				if (err != -EAGAIN)
-					return err;
-			} else
-				return 0;
-		} else {
-			remove_cache_mr_locked(ent);
-		}
-	}
-}
-
-static ssize_t size_write(struct file *filp, const char __user *buf,
-			  size_t count, loff_t *pos)
-{
-	struct mlx5_cache_ent *ent = filp->private_data;
-	u32 target;
-	int err;
-
-	err = kstrtou32_from_user(buf, count, 0, &target);
-	if (err)
-		return err;
-
-	/*
-	 * Target is the new value of total_mrs the user requests, however we
-	 * cannot free MRs that are in use. Compute the target value for stored
-	 * mkeys.
-	 */
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	if (target < ent->in_use) {
-		err = -EINVAL;
-		goto err_unlock;
-	}
-	target = target - ent->in_use;
-	if (target < ent->limit || target > ent->limit*2) {
-		err = -EINVAL;
-		goto err_unlock;
-	}
-	err = resize_available_mrs(ent, target, false);
-	if (err)
-		goto err_unlock;
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-
-	return count;
-
-err_unlock:
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-	return err;
-}
-
-static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
-			 loff_t *pos)
-{
-	struct mlx5_cache_ent *ent = filp->private_data;
-	char lbuf[20];
-	int err;
-
-	err = snprintf(lbuf, sizeof(lbuf), "%ld\n",
-		       ent->mkeys_queue.ci + ent->in_use);
-	if (err < 0)
-		return err;
-
-	return simple_read_from_buffer(buf, count, pos, lbuf, err);
-}
-
-static const struct file_operations size_fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.write	= size_write,
-	.read	= size_read,
-};
-
-static ssize_t limit_write(struct file *filp, const char __user *buf,
-			   size_t count, loff_t *pos)
-{
-	struct mlx5_cache_ent *ent = filp->private_data;
-	u32 var;
-	int err;
-
-	err = kstrtou32_from_user(buf, count, 0, &var);
-	if (err)
-		return err;
-
-	/*
-	 * Upon set we immediately fill the cache to high water mark implied by
-	 * the limit.
-	 */
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	ent->limit = var;
-	err = resize_available_mrs(ent, 0, true);
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-	if (err)
-		return err;
-	return count;
-}
-
-static ssize_t limit_read(struct file *filp, char __user *buf, size_t count,
-			  loff_t *pos)
-{
-	struct mlx5_cache_ent *ent = filp->private_data;
-	char lbuf[20];
-	int err;
-
-	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->limit);
-	if (err < 0)
-		return err;
-
-	return simple_read_from_buffer(buf, count, pos, lbuf, err);
-}
-
-static const struct file_operations limit_fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.write	= limit_write,
-	.read	= limit_read,
-};
-
-static bool someone_adding(struct mlx5_mkey_cache *cache)
-{
-	struct mlx5_cache_ent *ent;
-	struct rb_node *node;
-	bool ret;
-
-	mutex_lock(&cache->rb_lock);
-	for (node = rb_first(&cache->rb_root); node; node = rb_next(node)) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		ret = ent->mkeys_queue.ci < ent->limit;
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		if (ret) {
-			mutex_unlock(&cache->rb_lock);
-			return true;
-		}
-	}
-	mutex_unlock(&cache->rb_lock);
-	return false;
-}
-
-/*
- * Check if the bucket is outside the high/low water mark and schedule an async
- * update. The cache refill has hysteresis, once the low water mark is hit it is
- * refilled up to the high mark.
- */
-static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
-{
-	lockdep_assert_held(&ent->mkeys_queue.lock);
-
-	if (ent->disabled || READ_ONCE(ent->dev->fill_delay) || ent->is_tmp)
-		return;
-	if (ent->mkeys_queue.ci < ent->limit) {
-		ent->fill_to_high_water = true;
-		mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
-	} else if (ent->fill_to_high_water &&
-		   ent->mkeys_queue.ci + ent->pending < 2 * ent->limit) {
-		/*
-		 * Once we start populating due to hitting a low water mark
-		 * continue until we pass the high water mark.
-		 */
-		mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
-	} else if (ent->mkeys_queue.ci == 2 * ent->limit) {
-		ent->fill_to_high_water = false;
-	} else if (ent->mkeys_queue.ci > 2 * ent->limit) {
-		/* Queue deletion of excess entries */
-		ent->fill_to_high_water = false;
-		if (ent->pending)
-			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					   secs_to_jiffies(1));
-		else
-			mod_delayed_work(ent->dev->cache.wq, &ent->dwork, 0);
-	}
-}
-
-static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
-{
-	u32 mkey;
-
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	while (ent->mkeys_queue.ci) {
-		mkey = pop_mkey_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		mlx5_core_destroy_mkey(dev->mdev, mkey);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-	}
-	ent->tmp_cleanup_scheduled = false;
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-}
-
-static void __cache_work_func(struct mlx5_cache_ent *ent)
-{
-	struct mlx5_ib_dev *dev = ent->dev;
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	int err;
-
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	if (ent->disabled)
-		goto out;
-
-	if (ent->fill_to_high_water &&
-	    ent->mkeys_queue.ci + ent->pending < 2 * ent->limit &&
-	    !READ_ONCE(dev->fill_delay)) {
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		err = add_keys(ent, 1);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (ent->disabled)
-			goto out;
-		if (err) {
-			/*
-			 * EAGAIN only happens if there are pending MRs, so we
-			 * will be rescheduled when storing them. The only
-			 * failure path here is ENOMEM.
-			 */
-			if (err != -EAGAIN) {
-				mlx5_ib_warn(
-					dev,
-					"add keys command failed, err %d\n",
-					err);
-				queue_delayed_work(cache->wq, &ent->dwork,
-						   secs_to_jiffies(1));
-			}
-		}
-	} else if (ent->mkeys_queue.ci > 2 * ent->limit) {
-		bool need_delay;
-
-		/*
-		 * The remove_cache_mr() logic is performed as garbage
-		 * collection task. Such task is intended to be run when no
-		 * other active processes are running.
-		 *
-		 * The need_resched() will return TRUE if there are user tasks
-		 * to be activated in near future.
-		 *
-		 * In such case, we don't execute remove_cache_mr() and postpone
-		 * the garbage collection work to try to run in next cycle, in
-		 * order to free CPU resources to other tasks.
-		 */
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		need_delay = need_resched() || someone_adding(cache) ||
-			     !time_after(jiffies,
-					 READ_ONCE(cache->last_add) + 300 * HZ);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (ent->disabled)
-			goto out;
-		if (need_delay) {
-			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
-			goto out;
-		}
-		remove_cache_mr_locked(ent);
-		queue_adjust_cache_locked(ent);
-	}
-out:
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-}
-
-static void delayed_cache_work_func(struct work_struct *work)
-{
-	struct mlx5_cache_ent *ent;
-
-	ent = container_of(work, struct mlx5_cache_ent, dwork.work);
-	/* temp entries are never filled, only cleaned */
-	if (ent->is_tmp)
-		clean_keys(ent->dev, ent);
-	else
-		__cache_work_func(ent);
-}
-
-static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
-			     struct mlx5r_cache_rb_key key2)
-{
-	int res;
-
-	res = key1.ats - key2.ats;
-	if (res)
-		return res;
-
-	res = key1.access_mode - key2.access_mode;
-	if (res)
-		return res;
-
-	res = key1.access_flags - key2.access_flags;
-	if (res)
-		return res;
-
-	res = key1.st_index - key2.st_index;
-	if (res)
-		return res;
-
-	res = key1.ph - key2.ph;
-	if (res)
-		return res;
-
-	/*
-	 * keep ndescs the last in the compare table since the find function
-	 * searches for an exact match on all properties and only closest
-	 * match in size.
-	 */
-	return key1.ndescs - key2.ndescs;
-}
-
-static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
-				 struct mlx5_cache_ent *ent)
-{
-	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
-	struct mlx5_cache_ent *cur;
-	int cmp;
-
-	/* Figure out where to put new node */
-	while (*new) {
-		cur = rb_entry(*new, struct mlx5_cache_ent, node);
-		parent = *new;
-		cmp = cache_ent_key_cmp(cur->rb_key, ent->rb_key);
-		if (cmp > 0)
-			new = &((*new)->rb_left);
-		if (cmp < 0)
-			new = &((*new)->rb_right);
-		if (cmp == 0)
-			return -EEXIST;
-	}
-
-	/* Add new node and rebalance tree. */
-	rb_link_node(&ent->node, parent, new);
-	rb_insert_color(&ent->node, &cache->rb_root);
-
-	return 0;
-}
-
-static struct mlx5_cache_ent *
-mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
-			   struct mlx5r_cache_rb_key rb_key)
-{
-	struct rb_node *node = dev->cache.rb_root.rb_node;
-	struct mlx5_cache_ent *cur, *smallest = NULL;
-	u64 ndescs_limit;
-	int cmp;
-
-	/*
-	 * Find the smallest ent with order >= requested_order.
-	 */
-	while (node) {
-		cur = rb_entry(node, struct mlx5_cache_ent, node);
-		cmp = cache_ent_key_cmp(cur->rb_key, rb_key);
-		if (cmp > 0) {
-			smallest = cur;
-			node = node->rb_left;
-		}
-		if (cmp < 0)
-			node = node->rb_right;
-		if (cmp == 0)
-			return cur;
-	}
-
-	/*
-	 * Limit the usage of mkeys larger than twice the required size while
-	 * also allowing the usage of smallest cache entry for small MRs.
-	 */
-	ndescs_limit = max_t(u64, rb_key.ndescs * 2,
-			     MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS);
-
-	return (smallest &&
-		smallest->rb_key.access_mode == rb_key.access_mode &&
-		smallest->rb_key.access_flags == rb_key.access_flags &&
-		smallest->rb_key.ats == rb_key.ats &&
-		smallest->rb_key.st_index == rb_key.st_index &&
-		smallest->rb_key.ph == rb_key.ph &&
-		smallest->rb_key.ndescs <= ndescs_limit) ?
-		       smallest :
-		       NULL;
-}
-
-static struct mlx5_ib_mr *_mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-					       struct mlx5_cache_ent *ent)
-{
-	struct mlx5_ib_mr *mr;
-	int err;
-
-	mr = kzalloc_obj(*mr);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
-
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	ent->in_use++;
-
-	if (!ent->mkeys_queue.ci) {
-		queue_adjust_cache_locked(ent);
-		ent->miss++;
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		err = create_cache_mkey(ent, &mr->mmkey.key);
-		if (err) {
-			spin_lock_irq(&ent->mkeys_queue.lock);
-			ent->in_use--;
-			spin_unlock_irq(&ent->mkeys_queue.lock);
-			kfree(mr);
-			return ERR_PTR(err);
-		}
-	} else {
-		mr->mmkey.key = pop_mkey_locked(ent);
-		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-	}
-	mr->mmkey.cache_ent = ent;
-	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->mmkey.rb_key = ent->rb_key;
-	mr->mmkey.cacheable = true;
-	init_waitqueue_head(&mr->mmkey.wait);
-	return mr;
-}
-
 static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
 					 int access_flags)
 {
@@ -797,254 +161,201 @@ static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
 	return ret;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       int access_flags, int access_mode,
-				       int ndescs)
-{
-	struct mlx5r_cache_rb_key rb_key = {
-		.ndescs = ndescs,
-		.access_mode = access_mode,
-		.access_flags = get_unchangeable_access_flags(dev, access_flags),
-		.ph = MLX5_IB_NO_PH,
-	};
-	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
+#define MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK 1ULL
+#define MLX5_FRMR_POOLS_KEY_VENDOR_KEY_SUPPORTED \
+	MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK
 
-	if (!ent)
-		return ERR_PTR(-EOPNOTSUPP);
-
-	return _mlx5_mr_cache_alloc(dev, ent);
-}
-
-static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
-{
-	if (!mlx5_debugfs_root || dev->is_rep)
-		return;
+#define MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT 16
+#define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK 0xFF0000
+#define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK 0xFFFF
 
-	debugfs_remove_recursive(dev->cache.fs_root);
-	dev->cache.fs_root = NULL;
-}
-
-static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
-					    struct mlx5_cache_ent *ent)
+static struct mlx5_ib_mr *
+_mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
+		      int access_flags, int access_mode,
+		      unsigned long page_size, u16 st_index, u8 ph)
 {
-	int order = order_base_2(ent->rb_key.ndescs);
-	struct dentry *dir;
-
-	if (!mlx5_debugfs_root || dev->is_rep)
-		return;
-
-	if (ent->rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
-		order = MLX5_IMR_KSM_CACHE_ENTRY + 2;
-
-	sprintf(ent->name, "%d", order);
-	dir = debugfs_create_dir(ent->name, dev->cache.fs_root);
-	debugfs_create_file("size", 0600, dir, ent, &size_fops);
-	debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-	debugfs_create_ulong("cur", 0400, dir, &ent->mkeys_queue.ci);
-	debugfs_create_u32("miss", 0600, dir, &ent->miss);
-}
+	struct mlx5_ib_mr *mr;
+	int err;
 
-static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
-{
-	struct dentry *dbg_root = mlx5_debugfs_get_dev_root(dev->mdev);
-	struct mlx5_mkey_cache *cache = &dev->cache;
+	mr = kzalloc_obj(*mr);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
-	if (!mlx5_debugfs_root || dev->is_rep)
-		return;
+	mr->ibmr.frmr.key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
+	mr->ibmr.frmr.key.access_flags =
+		get_unchangeable_access_flags(dev, access_flags);
+	mr->ibmr.frmr.key.num_dma_blocks =
+		ib_umem_num_dma_blocks(umem, page_size);
+	mr->ibmr.frmr.key.vendor_key =
+		access_mode == MLX5_MKC_ACCESS_MODE_KSM ?
+			MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK :
+			0;
+
+	/* Normalize ph: swap 0 and MLX5_IB_NO_PH */
+	if (ph == MLX5_IB_NO_PH || ph == 0)
+		ph ^= MLX5_IB_NO_PH;
+
+	mr->ibmr.frmr.key.kernel_vendor_key =
+		st_index | (ph << MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT);
+	err = ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	if (err) {
+		kfree(mr);
+		return ERR_PTR(err);
+	}
+	mr->mmkey.key = mr->ibmr.frmr.handle;
+	init_waitqueue_head(&mr->mmkey.wait);
 
-	cache->fs_root = debugfs_create_dir("mr_cache", dbg_root);
+	return mr;
 }
 
-static void delay_time_func(struct timer_list *t)
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+				       int access_flags, int access_mode,
+				       int ndescs)
 {
-	struct mlx5_ib_dev *dev = timer_container_of(dev, t, delay_timer);
-
-	WRITE_ONCE(dev->fill_delay, 0);
-}
+	struct ib_frmr_key key = {
+		.access_flags =
+			get_unchangeable_access_flags(dev, access_flags),
+		.vendor_key = access_mode == MLX5_MKC_ACCESS_MODE_MTT ?
+				      0 :
+				      MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK,
+		.num_dma_blocks = ndescs,
+		.kernel_vendor_key = 0, /* no PH and no ST index */
+	};
+	struct mlx5_ib_mr *mr;
+	int ret;
 
-static int mlx5r_mkeys_init(struct mlx5_cache_ent *ent)
-{
-	struct mlx5_mkeys_page *page;
+	mr = kzalloc_obj(*mr);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
-	page = kzalloc_obj(*page);
-	if (!page)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&ent->mkeys_queue.pages_list);
-	spin_lock_init(&ent->mkeys_queue.lock);
-	list_add_tail(&page->list, &ent->mkeys_queue.pages_list);
-	ent->mkeys_queue.num_pages++;
-	return 0;
-}
+	init_waitqueue_head(&mr->mmkey.wait);
 
-static void mlx5r_mkeys_uninit(struct mlx5_cache_ent *ent)
-{
-	struct mlx5_mkeys_page *page;
+	mr->ibmr.frmr.key = key;
+	ret = ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
+	if (ret) {
+		kfree(mr);
+		return ERR_PTR(ret);
+	}
+	mr->mmkey.key = mr->ibmr.frmr.handle;
+	mr->mmkey.type = MLX5_MKEY_MR;
 
-	WARN_ON(ent->mkeys_queue.ci || ent->mkeys_queue.num_pages > 1);
-	page = list_last_entry(&ent->mkeys_queue.pages_list,
-			       struct mlx5_mkeys_page, list);
-	list_del(&page->list);
-	kfree(page);
+	return mr;
 }
 
-struct mlx5_cache_ent *
-mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
-			      struct mlx5r_cache_rb_key rb_key,
-			      bool persistent_entry)
+static int mlx5r_create_mkeys(struct ib_device *device, struct ib_frmr_key *key,
+			      u32 *handles, unsigned int count)
 {
-	struct mlx5_cache_ent *ent;
-	int order;
-	int ret;
+	int access_mode =
+		key->vendor_key & MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK ?
+			MLX5_MKC_ACCESS_MODE_KSM :
+			MLX5_MKC_ACCESS_MODE_MTT;
 
-	ent = kzalloc_obj(*ent);
-	if (!ent)
-		return ERR_PTR(-ENOMEM);
+	struct mlx5_ib_dev *dev = to_mdev(device);
+	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	u16 st_index;
+	void *mkc;
+	u32 *in;
+	int err, i;
+	u8 ph;
 
-	ret = mlx5r_mkeys_init(ent);
-	if (ret)
-		goto mkeys_err;
-	ent->rb_key = rb_key;
-	ent->dev = dev;
-	ent->is_tmp = !persistent_entry;
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
-	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+	set_mkc_access_pd_addr_fields(mkc, key->access_flags, 0, dev->umrc.pd);
+	MLX5_SET(mkc, mkc, free, 1);
+	MLX5_SET(mkc, mkc, umr_en, 1);
+	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, ma_translation_mode, !!key->ats);
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 get_mkc_octo_size(access_mode, key->num_dma_blocks));
+	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 
-	ret = mlx5_cache_ent_insert(&dev->cache, ent);
-	if (ret)
-		goto ent_insert_err;
-
-	if (persistent_entry) {
-		if (rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
-			order = MLX5_IMR_KSM_CACHE_ENTRY;
-		else
-			order = order_base_2(rb_key.ndescs) - 2;
-
-		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5r_umr_can_load_pas(dev, 0))
-			ent->limit = dev->mdev->profile.mr_cache[order].limit;
-		else
-			ent->limit = 0;
-
-		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
+	st_index = key->kernel_vendor_key &
+		   MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
+	ph = key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK;
+	if (ph) {
+		/* Normalize ph: swap MLX5_IB_NO_PH for 0 */
+		if (ph == MLX5_IB_NO_PH)
+			ph = 0;
+		MLX5_SET(mkc, mkc, pcie_tph_en, 1);
+		MLX5_SET(mkc, mkc, pcie_tph_ph, ph);
+		if (st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+			MLX5_SET(mkc, mkc, pcie_tph_steering_tag_index,
+				 st_index);
 	}
 
-	return ent;
-ent_insert_err:
-	mlx5r_mkeys_uninit(ent);
-mkeys_err:
-	kfree(ent);
-	return ERR_PTR(ret);
-}
-
-static void mlx5r_destroy_cache_entries(struct mlx5_ib_dev *dev)
-{
-	struct rb_root *root = &dev->cache.rb_root;
-	struct mlx5_cache_ent *ent;
-	struct rb_node *node;
-
-	mutex_lock(&dev->cache.rb_lock);
-	node = rb_first(root);
-	while (node) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		node = rb_next(node);
-		clean_keys(dev, ent);
-		rb_erase(&ent->node, root);
-		mlx5r_mkeys_uninit(ent);
-		kfree(ent);
+	for (i = 0; i < count; i++) {
+		assign_mkey_variant(dev, handles + i, in);
+		err = mlx5_core_create_mkey(dev->mdev, handles + i, in, inlen);
+		if (err)
+			goto free_in;
 	}
-	mutex_unlock(&dev->cache.rb_lock);
+free_in:
+	kfree(in);
+	if (err)
+		for (; i > 0; i--)
+			mlx5_core_destroy_mkey(dev->mdev, handles[i]);
+	return err;
 }
 
-int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
+static void mlx5r_destroy_mkeys(struct ib_device *device, u32 *handles,
+				unsigned int count)
 {
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct rb_root *root = &dev->cache.rb_root;
-	struct mlx5r_cache_rb_key rb_key = {
-		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
-		.ph = MLX5_IB_NO_PH,
-	};
-	struct mlx5_cache_ent *ent;
-	struct rb_node *node;
-	int ret;
-	int i;
+	struct mlx5_ib_dev *dev = to_mdev(device);
+	int i, err;
 
-	mutex_init(&dev->slow_path_mutex);
-	mutex_init(&dev->cache.rb_lock);
-	dev->cache.rb_root = RB_ROOT;
-	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
-	if (!cache->wq) {
-		mlx5_ib_warn(dev, "failed to create work queue\n");
-		return -ENOMEM;
+	for (i = 0; i < count; i++) {
+		err = mlx5_core_destroy_mkey(dev->mdev, handles[i]);
+		if (err)
+			pr_warn_ratelimited(
+				"mlx5_ib: failed to destroy mkey %d: %d",
+				handles[i], err);
 	}
+}
 
-	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	mlx5_mkey_cache_debugfs_init(dev);
-	mutex_lock(&cache->rb_lock);
-	for (i = 0; i <= mkey_cache_max_order(dev); i++) {
-		rb_key.ndescs = MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS << i;
-		ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
-		if (IS_ERR(ent)) {
-			ret = PTR_ERR(ent);
-			goto err;
-		}
-	}
+static int mlx5r_build_frmr_key(struct ib_device *device,
+				const struct ib_frmr_key *in,
+				struct ib_frmr_key *out)
+{
+	struct mlx5_ib_dev *dev = to_mdev(device);
 
-	ret = mlx5_odp_init_mkey_cache(dev);
-	if (ret)
-		goto err;
+	/* check HW capabilities of users requested frmr key */
+	if ((in->ats && !MLX5_CAP_GEN(dev->mdev, ats)) ||
+	    ilog2(in->num_dma_blocks) > mkey_max_umr_order(dev))
+		return -EOPNOTSUPP;
 
-	mutex_unlock(&cache->rb_lock);
-	for (node = rb_first(root); node; node = rb_next(node)) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-	}
+	if (in->vendor_key & ~MLX5_FRMR_POOLS_KEY_VENDOR_KEY_SUPPORTED)
+		return -EOPNOTSUPP;
 
-	return 0;
+	out->ats = in->ats;
+	out->access_flags =
+		get_unchangeable_access_flags(dev, in->access_flags);
+	out->vendor_key = in->vendor_key;
+	out->num_dma_blocks = in->num_dma_blocks;
 
-err:
-	mutex_unlock(&cache->rb_lock);
-	mlx5_mkey_cache_debugfs_cleanup(dev);
-	mlx5r_destroy_cache_entries(dev);
-	destroy_workqueue(cache->wq);
-	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
-	return ret;
+	return 0;
 }
 
-void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
-{
-	struct rb_root *root = &dev->cache.rb_root;
-	struct mlx5_cache_ent *ent;
-	struct rb_node *node;
-
-	if (!dev->cache.wq)
-		return;
-
-	mutex_lock(&dev->cache.rb_lock);
-	for (node = rb_first(root); node; node = rb_next(node)) {
-		ent = rb_entry(node, struct mlx5_cache_ent, node);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		ent->disabled = true;
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		cancel_delayed_work(&ent->dwork);
-	}
-	mutex_unlock(&dev->cache.rb_lock);
-
-	/*
-	 * After all entries are disabled and will not reschedule on WQ,
-	 * flush it and all async commands.
-	 */
-	flush_workqueue(dev->cache.wq);
+static struct ib_frmr_pool_ops mlx5r_frmr_pool_ops = {
+	.create_frmrs = mlx5r_create_mkeys,
+	.destroy_frmrs = mlx5r_destroy_mkeys,
+	.build_key = mlx5r_build_frmr_key,
+};
 
-	mlx5_mkey_cache_debugfs_cleanup(dev);
+int mlx5r_frmr_pools_init(struct ib_device *device)
+{
+	struct mlx5_ib_dev *dev = to_mdev(device);
 
-	/* At this point all entries are disabled and have no concurrent work. */
-	mlx5r_destroy_cache_entries(dev);
+	mutex_init(&dev->slow_path_mutex);
+	return ib_frmr_pools_init(device, &mlx5r_frmr_pool_ops);
+}
 
-	destroy_workqueue(dev->cache.wq);
-	timer_delete_sync(&dev->delay_timer);
+void mlx5r_frmr_pools_cleanup(struct ib_device *device)
+{
+	ib_frmr_pools_cleanup(device);
 }
 
 struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
@@ -1106,13 +417,6 @@ static int get_octo_len(u64 addr, u64 len, int page_shift)
 	return (npages + 1) / 2;
 }
 
-static int mkey_cache_max_order(struct mlx5_ib_dev *dev)
-{
-	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
-		return MKEY_CACHE_LAST_STD_ENTRY;
-	return MLX5_MAX_UMR_SHIFT;
-}
-
 static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 			  u64 length, int access_flags, u64 iova)
 {
@@ -1141,8 +445,6 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     u16 st_index, u8 ph)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5r_cache_rb_key rb_key = {};
-	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
 	unsigned long page_size;
 
@@ -1154,33 +456,12 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
 
-	rb_key.access_mode = access_mode;
-	rb_key.ndescs = ib_umem_num_dma_blocks(umem, page_size);
-	rb_key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
-	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
-	rb_key.st_index = st_index;
-	rb_key.ph = ph;
-	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
-	/*
-	 * If the MR can't come from the cache then synchronously create an uncached
-	 * one.
-	 */
-	if (!ent) {
-		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(pd, umem, iova, access_flags, page_size, false, access_mode,
-				st_index, ph);
-		mutex_unlock(&dev->slow_path_mutex);
-		if (IS_ERR(mr))
-			return mr;
-		mr->mmkey.rb_key = rb_key;
-		mr->mmkey.cacheable = true;
-		return mr;
-	}
-
-	mr = _mlx5_mr_cache_alloc(dev, ent);
+	mr = _mlx5_frmr_pool_alloc(dev, umem, access_flags, access_mode,
+				   page_size, st_index, ph);
 	if (IS_ERR(mr))
 		return mr;
 
+	mr->mmkey.type = MLX5_MKEY_MR;
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
@@ -1810,18 +1091,24 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 				  unsigned long *page_size)
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	u8 access_mode;
 
-	/* We only track the allocated sizes of MRs from the cache */
-	if (!mr->mmkey.cache_ent)
+	/* We only track the allocated sizes of MRs from the frmr pools */
+	if (!mr->ibmr.frmr.pool)
 		return false;
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
-	*page_size = mlx5_umem_mkc_find_best_pgsz(
-		dev, new_umem, iova, mr->mmkey.cache_ent->rb_key.access_mode);
+	access_mode = mr->ibmr.frmr.key.vendor_key &
+				      MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK ?
+			      MLX5_MKC_ACCESS_MODE_KSM :
+			      MLX5_MKC_ACCESS_MODE_MTT;
+
+	*page_size =
+		mlx5_umem_mkc_find_best_pgsz(dev, new_umem, iova, access_mode);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (mr->mmkey.cache_ent->rb_key.ndescs) >=
+	return (mr->ibmr.frmr.key.num_dma_blocks) >=
 	       ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
@@ -1882,7 +1169,8 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || mr->data_direct ||
-	    mr->mmkey.rb_key.ph != MLX5_IB_NO_PH)
+	    (mr->ibmr.frmr.key.kernel_vendor_key &
+	     MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK) != 0)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(
@@ -2023,47 +1311,6 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
-static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
-				    struct mlx5_ib_mr *mr)
-{
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
-	int ret;
-
-	if (mr->mmkey.cache_ent) {
-		spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-		goto end;
-	}
-
-	mutex_lock(&cache->rb_lock);
-	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
-	if (ent) {
-		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
-			if (ent->disabled) {
-				mutex_unlock(&cache->rb_lock);
-				return -EOPNOTSUPP;
-			}
-			mr->mmkey.cache_ent = ent;
-			spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-			mutex_unlock(&cache->rb_lock);
-			goto end;
-		}
-	}
-
-	ent = mlx5r_cache_create_ent_locked(dev, mr->mmkey.rb_key, false);
-	mutex_unlock(&cache->rb_lock);
-	if (IS_ERR(ent))
-		return PTR_ERR(ent);
-
-	mr->mmkey.cache_ent = ent;
-	spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-
-end:
-	ret = push_mkey_locked(mr->mmkey.cache_ent, mr->mmkey.key);
-	spin_unlock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-	return ret;
-}
-
 static int mlx5_ib_revoke_data_direct_mr(struct mlx5_ib_mr *mr)
 {
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
@@ -2129,33 +1376,12 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
 	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
 			      !to_ib_umem_dmabuf(mr->umem)->pinned;
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 	bool is_odp = is_odp_mr(mr);
-	bool from_cache = !!ent;
 	int ret;
 
-	if (mr->mmkey.cacheable && !mlx5_umr_revoke_mr_with_lock(mr) &&
-	    !cache_ent_find_and_store(dev, mr)) {
-		ent = mr->mmkey.cache_ent;
-		/* upon storing to a clean temp entry - schedule its cleanup */
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (from_cache)
-			ent->in_use--;
-		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
-			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
-					 secs_to_jiffies(30));
-			ent->tmp_cleanup_scheduled = true;
-		}
-		spin_unlock_irq(&ent->mkeys_queue.lock);
+	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
+	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
 		return 0;
-	}
-
-	if (ent) {
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		ent->in_use--;
-		mr->mmkey.cache_ent = NULL;
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-	}
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
@@ -2239,7 +1465,7 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 			mlx5_ib_free_odp_mr(mr);
 	}
 
-	if (!mr->mmkey.cache_ent)
+	if (!mr->ibmr.frmr.pool)
 		mlx5_free_priv_descs(mr);
 
 	kfree(mr);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4c1dea4fd526a6cf0f0dc581f47b4bb8dda94896..1119ce163ea7835f4da271a3bea7bc73d44d07b6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1875,25 +1875,6 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
-{
-	struct mlx5r_cache_rb_key rb_key = {
-		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
-		.ndescs = mlx5_imr_ksm_entries,
-		.ph = MLX5_IB_NO_PH,
-	};
-	struct mlx5_cache_ent *ent;
-
-	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return 0;
-
-	ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
-	if (IS_ERR(ent))
-		return PTR_ERR(ent);
-
-	return 0;
-}
-
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
 	.advise_mr = mlx5_ib_advise_mr,
 };
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index e9361f0140e7b49ea3cf59a6093bf766d8dfebbb..7eeaf6a94c9743ac10f7f62069f603468da75565 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -9,6 +9,7 @@
 
 #define MLX5_MAX_UMR_SHIFT 16
 #define MLX5_MAX_UMR_PAGES (1 << MLX5_MAX_UMR_SHIFT)
+#define MLX5_MAX_UMR_EXTENDED_SHIFT 43
 
 #define MLX5_IB_UMR_OCTOWORD	       16
 #define MLX5_IB_UMR_XLT_ALIGNMENT      64

-- 
2.49.0


