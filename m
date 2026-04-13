Return-Path: <linux-rdma+bounces-19281-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKHrCGjL3GmcWQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19281-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 326EB3EAEFB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA88F300531F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447103BC68A;
	Mon, 13 Apr 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wv3Y4N8w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0935AC0A;
	Mon, 13 Apr 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077666; cv=fail; b=B5LAygS6/ePnLmjOGsSrtJJ+hG7lEFBCIRPLUObLq5kcEF8OXqo295jXIU4+Z53SUesNBzJ/LoSrxss9hN4jqVD0LthkfNY7HPEWtT0aVqErxItrzcgeqduUlolGGXOTyAonYQ3e2nzj53yUsZ2YLKIq/Wsq5xj4TopwgY7y45s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077666; c=relaxed/simple;
	bh=Coq01puMCWwIklH13SRbJCNhH6XlTfglTm0NYQOkJ0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoC90WrzlAQoysIwR+ClwXUnKzOhOLvX5QGumSnuzHwmTazXmaKIHJSSghjiW2Z0JPckJOHtR5CAk08BhJ11GQSbSTdr5kn9CU7mLXbfFdY0SruzcfENHGuBzToqAJAHWKMYKgBbBL8uv1GxCtdOFKStf1D1Rk0niLf4Dmyqj5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wv3Y4N8w; arc=fail smtp.client-ip=40.93.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aV72raIHbdw+re35/Ghfh/RYNcGFV1H+6Z/vZ58esVYjgbqHCUUNspqrRht1i8p09n7MjFjMETsNTrH1BiE1fvZsijfF9lEfj2alrxfICjwhxg9MXbkq706/tpnoPdlz5VY5ho2+RQ1xKNx5BHTcH6xbf1eL/35+yWnTi99RYyxoyIctfhkxJpmh99WwEVmclmogOMzx1JKfmHDtZwqyFnnNz4yaYTxs1j8B7VFUOYp+YLjP2kKlX9vQS/73FhsbebA/bpMZ1WtqyHjrPRrPiYoDcZrmdyhL4h4I7PRZk7EGuI9RM/jMu5NTu2cjBIngpHH0ihRfXondXQ3Xuh2FBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E3A7JzU4eGkcUPLsxZd0gGk76FOlQYXLlWKxr72Ifk=;
 b=kl51pBzwV+forPs5/QKaX2K9poTdfVMrqbrBNRN1vjQCCXNbRmWDBuOF+0ybaHz6r9NwnbUpzqyaxh1jdusV1s5l0zbGe4u7Gkh44ivijovRTmAOLN31pIWvQfXX+3WCRYBQDGYm4F8a+NYK5Y6YqvCXrxXQUYuaxYOw5hQdgFnebx8T+2hsI//n9A2HzBrNA9Rk5Qouy3lJUyIhCdqozJG6utsPMPSvk883E39ngx+ltYWUEMqyzAnixaPmoTf91O9jBXRxHNFQcpIYovlGxnu4pEmYzDg2YOGb3WssuHt0dbuwFPqNFtDXahrJ+JCIEkCONyKNiWpjsfmTSyQkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E3A7JzU4eGkcUPLsxZd0gGk76FOlQYXLlWKxr72Ifk=;
 b=Wv3Y4N8w91JbZNHP6EoBMtZA+YdulkRNH3FgsoBaHiwDciAgCbp9CYX1qR6fduNusIP4PuLfTeFzHU1fsp/Maa30eSL15X72kXaRyv6OIzEOL4azzrE0rkgilH6B2ovimNTBNyG0qc7+xPwLa3baCdiceyxySlF+ocf2U2ebl2AfBFRjGMgrVqHru1s8oxuasT/CjlTFNYDLpcpK9uTWANzmjczuXBCvXVWSAQgx0ZDT6qHpNrm9OdS+sEk9Ok8u1HHwNG+xhl7rhtSL+LRCVjSvb2Ysuc45IrAVA2aU1g9kz41ayVeeQ8hvWT8grV9m95SP1gRmecIpDwTcO0stPQ==
Received: from PH8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:510:2cf::27)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 10:54:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::4b) by PH8PR07CA0029.outlook.office365.com
 (2603:10b6:510:2cf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 10:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 10:54:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 03:54:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Apr 2026 03:54:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 03:54:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net V2 3/3] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Mon, 13 Apr 2026 13:53:23 +0300
Message-ID: <20260413105323.186411-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260413105323.186411-1-tariqt@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: a680e69b-c4d0-49fc-3c9e-08de994b0358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tJoubzGDrtdQyKCDhWwBWPkCrgHpfwQkGdy56xIx3cs9hHUY7TE1kRO/3ZZ5Ty+9hPONuQ1UacpgEpFr5/r4boCFGxRtZhXstLYBIIg7b66iZ2TNrQc1lYXqDgOZXXRysD+Nntz7aSrbo4RfIcjtM1uD2WTzaQWYTyDslCiaAQPDP0Vt7/e0LDvGpOW454IEta6BLbcudf/yumEazc4Gd5dzYBdHusTwWT2AtAfinoiQ6ZJlUzdMmgZzTFbsrj9qVduHHB1uVWCn+Nq4mFlYuHnnAwxaKtiCe+HcZx8lDUCoTygxfIoV7t9jqmH8Ctm30yqvBd9AiYfylWWXUdr8Z09q4B0FhfO2Dpplh/ztnkY5SZdgymaZclWhFdfpuc2Eig9OHmfEbwgktanh9ChHYlyxO34bUQ7XLlaxDyYpT3RKJC45WeXZiCxOVHp39olxbBPy0hVUtsrBAcM3VKVAG+ny+yrlrAL0jpqWoxsPBkwXjzbdiatboulR/6m7oYMmQ/z2m/CWO94g37to23Prpjj2Rxuuzi9IWl3VvEVDQmzPYzI9V7zJqrmczjy7TtdgBOkxLgN1FgAbSr7zbU500q7s6VqA2YYEU2OWIlv85moLrDMkZx8/ktD5ASefX+rxndhoivVUmtvlWLgLiigp7BixloqGXxy52cXxuxxrf9/VoGEtzi1SZgYEXI3UrhXrHnEkm/nDqPN0ifh3kTkBU5oEXTY9zSHyarDYgOhGRXgDMjxRlLWbP1qnN/juA1DotVz1MdSmlBJKo8MuzPWFCg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mpq5gHNZlFdlvkK93P9B218NThBWeNo+SJ3g7lqT2cQy6H/UCqwz1yWAeA87KWlFGg4zryKaSCWq9iUTNlyCQKM03rO0SmLXQdUxTGRxBrIuyEnPDcH5kzrc0A2GdLnEUOfQP7uVPjMdY5uBBxgQhEO7BWlPOQTfnVU6l640dTZXLnfRSkEcWmSyznAEI+b9y+ttfXb9GUJpefj4HzS71ugKn8kga0zbLOvbHikJwLeDid0mhnc3rDngSu7tSHXht+ezI1VGOw/LpDMdWSc6MDVL4xlyMogLTDLCWwmLeq9xBs2VaLRri1BJXzT5QgDNNPFdMnpfGAcDhtprhZsOBKVTIRVUn7yi6wUID5DRxAYdQr8ekUguNj9Qnh86LDXaK/D7cPW1+l5yXbIDadWf+iJdIo9YHkZhIhRp1YfA5x5YN9ZtFmwbh/pllfWK4mCP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:54:18.9532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a680e69b-c4d0-49fc-3c9e-08de994b0358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19281-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 326EB3EAEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

When utilizing Socket-Direct single netdev functionality the driver
resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
the current implementation returns the primary ETH auxiliary device
without holding the device lock, leading to a potential race condition
where the ETH device could be unbound or removed concurrently during
probe, suspend, resume, or remove operations.[1]

Fix this by introducing mlx5_sd_put_adev() and updating
mlx5_sd_get_adev() so that secondaries devices would acquire the device
lock of the returned auxiliary device. After the lock is acquired, a
second devcom check is needed[2].
In addition, update The callers to pair the get operation with the new
put operation, ensuring the lock is held while the auxiliary device is
being operated on and released afterwards.

The "primary" designation is determined once in sd_register(). It's set
before devcom is marked ready, and it never changes after that.
In Addition, The primary path never locks a secondary: When the primary
device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
no additional lock is taken.
Therefore lock ordering is always: secondary_lock -> primary_lock. The
reverse never happens, so ABBA deadlock is impossible.

[1]
for example:
BUG: kernel NULL pointer dereference, address: 0000000000000370
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
Call Trace:
 <TASK>
 mlx5e_remove+0x82/0x12a [mlx5_core]
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xc6/0x140
 device_del+0x159/0x3c0
 ? devl_param_driverinit_value_get+0x29/0x80
 mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
 mlx5_unregister_device+0x34/0x50 [mlx5_core]
 mlx5_uninit_one+0x43/0xb0 [mlx5_core]
 remove_one+0x4e/0xc0 [mlx5_core]
 pci_device_remove+0x39/0xa0
 device_release_driver_internal+0x194/0x1f0
 unbind_store+0x99/0xa0
 kernfs_fop_write_iter+0x12e/0x1e0
 vfs_write+0x215/0x3d0
 ksys_write+0x5f/0xd0
 do_syscall_64+0x55/0xe90
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
    CPU0 (primary)                     CPU1 (secondary)
==========================================================================
mlx5e_remove() (device_lock held)
                                     mlx5e_remove() (2nd device_lock held)
                                      mlx5_sd_get_adev()
                                       mlx5_devcom_comp_is_ready() => true
                                       device_lock(primary)
 mlx5_sd_get_adev() ==> ret adev
 _mlx5e_remove()
 mlx5_sd_cleanup()
 // mlx5e_remove finished
 // releasing device_lock
                                       //need another check here...
                                       mlx5_devcom_comp_is_ready() => false

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 17 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h   |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0b8b44bbcb9e..11f80158e107 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_resume(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_resume(actual_adev);
+		mlx5_sd_put_adev(actual_adev, adev);
+		return err;
+	}
 	return 0;
 }
 
@@ -6698,6 +6701,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 		err = _mlx5e_suspend(actual_adev, false);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6795,8 +6800,11 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_probe(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_probe(actual_adev);
+		mlx5_sd_put_adev(actual_adev, adev);
+		return err;
+	}
 	return 0;
 }
 
@@ -6849,6 +6857,8 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 		_mlx5e_remove(actual_adev);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 }
 
 static const struct auxiliary_device_id mlx5e_id_table[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index a5e2e0a411df..6cece851b102 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -546,6 +546,10 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	sd_cleanup(dev);
 }
 
+/* Cannot take devcom lock as a gate for device lock. ABBA deadlock:
+ * primary:  actual_adev_lock -> SD devcom comp lock
+ * secondary: SD devcom comp lock -> actual_adev_lock
+ */
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx)
@@ -563,5 +567,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 	if (dev == primary)
 		return adev;
 
+	device_lock(&primary->priv.adev[idx]->adev.dev);
+	/* In case primary finish removing its adev */
+	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
+		device_unlock(&primary->priv.adev[idx]->adev.dev);
+		return NULL;
+	}
 	return &primary->priv.adev[idx]->adev;
 }
+
+void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
+		      struct auxiliary_device *adev)
+{
+	if (actual_adev != adev)
+		device_unlock(&actual_adev->dev);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 137efaf9aabc..9bfd5b9756b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -15,6 +15,8 @@ struct mlx5_core_dev *mlx5_sd_ch_ix_get_dev(struct mlx5_core_dev *primary, int c
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx);
+void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
+		      struct auxiliary_device *adev);
 
 int mlx5_sd_init(struct mlx5_core_dev *dev);
 void mlx5_sd_cleanup(struct mlx5_core_dev *dev);
-- 
2.44.0


