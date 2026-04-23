Return-Path: <linux-rdma+bounces-19500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG9SAskR6mn4sgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:34:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC30452061
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 14:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EA0307BBE5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B33081D6;
	Thu, 23 Apr 2026 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYGGd3eN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7A3EDAB3;
	Thu, 23 Apr 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947537; cv=fail; b=r3+aiFPNaNt1fyy8nEAO+Pf8GD/iEqfnD/Mf1Xr4mx6cw1RgSh5bZz2f+2GcXh1Kjk58M3XZsCQtA2YNOYYhAxbDbOD+itfFwcXQ/GQju9t493thiKi0ikFwnq/Z9zcj5JgOmX8vHHJjjFHXspUfQgfnZ1PFhFaEvtbFZgJXN0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947537; c=relaxed/simple;
	bh=bCpdaUA2qIpI9KR3eA877N3keJc3R0HmxrzvVGrpyCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcZPDei3quwn0GXiD4HzBWzk54um9JTqf6fOQwLC9yHQZqpIn8ceDUcJRZHcio8s6Lt4L76kCp0msZhHOnJOHDxB7bIHlFt8k7bflYSsZMwxTTTjzoiee3zNcbex6ey5PDBvBtta645bDeNkI0L+MIvZYWs3RkWe8cBqR0TaAgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YYGGd3eN; arc=fail smtp.client-ip=52.101.57.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuqmMwMso+DjVnBc3PHHunKwGxxPwfdSyLRb3qbENO6ptoLiqRJUapWlAGyHIphf0B8Vkz2KrvxFj52aY4jOi/qVJeH0DBuuZJkUVHfcxNCqZS3gRlFDUEoyGMP+7OSuloKH4bvNJpsAekUnMtEiEbWAm9WNPIZrrTXWJOOdnyw3rzIuVxdRVGxjT+IAG7FBwcLzvioQS0CMQ5AAA9Isz/gIe2XAVBMt6b0rYEjE12qvV2Z+II/tgXyrMb3+GtexgACPq1ebhq16QXB4vMymbxLVsJ3foXiL2+3KJElofX91OqxG0tjRBiign70hbHmu5xcAMzB5l8DC3VwdJZXv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR5j0pzdofxrFHX0bxsSoW0Xs9lJ8xN8IPSsEVpHdZU=;
 b=KAoDSELQMqaVS1262RxkfFqvYxORdfpr+3ww6+wEETphkqILtzBoqZbD6mQmqNCeGmE9zN9/JQtwiUsQf22+VsO3G7mbBAktG0oci1g1KI0QL2ql26DNghj+JN239lKEdLdFl7z88MeJ4aZrVkN5QZVzX3UrWd/fRXXwbNRi0rIHRBu/kU9P5EOBcN2phi1fJ3sNLIubE6KCGCdc+VFrUtTpE68IqiyTGjgOyWjUZ6rm5pvamPCRTRMVs7TgpoxnCoYnRIndN27l1L2vo1DgsXqZOKFV9J14rBg2EsKuiRnrzEoLut2YOus76bD9wQHylVjREwkgaPyZ5oFB4gm7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5j0pzdofxrFHX0bxsSoW0Xs9lJ8xN8IPSsEVpHdZU=;
 b=YYGGd3eNEojnRDLIppMBajz/7NQfAjhgTTCcjknTqdHQ9S1fh1STiPDBUcIyQM88RPrRQnAS0ymk16dODp6ScalL4sxOAjMBFUDTWq+D/yVD5VKf0wDe10uM4dphRt0eVbqpFk6/PtBGLDNkp6v5uvnKzvqnUI30/2o8O3bRLsFCkMhKDxKJldEdMAcJ1+TEVAuLd/DEGKquH0DebjU5oQi5KXTTwK7IYRAq+SytztUe+krq66RbGA+zo46QXHkXPPtaAE13ds3+t1kM44WBG6caxGTwUregxfdrY4I5/gh0mtJdV5yoaAvbOY0VzkU3S7KUr9jCCxC/ECUZNILgxw==
Received: from BLAPR03CA0093.namprd03.prod.outlook.com (2603:10b6:208:32a::8)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 12:32:08 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::25) by BLAPR03CA0093.outlook.office365.com
 (2603:10b6:208:32a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 12:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 12:32:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Apr
 2026 05:31:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Apr 2026 05:31:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Apr 2026 05:31:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V3 4/4] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Thu, 23 Apr 2026 15:31:04 +0300
Message-ID: <20260423123104.201552-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260423123104.201552-1-tariqt@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ba2855-4ad5-4e72-83a8-08dea1345575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q/feWj1A9dd9qtgcczTlnE0YN94eYolMWVMF/THNKtVv2mgxSVVmJYMIGyWKdd6Pdi+3TGpUE2opdLlKDAO/IDYrjeICuHHgTbnq3uAH2uNumfBvhFfAKY91U/QquHitFiOknfDEBFsI79Pjsqv0axy5kJGa7LZ0/p167MYWyBnO8EJBneQibbdCpqgCzrY9sRlqZBhaLQhmNtj0LQlMhjkZnU1dFgEOSV6LjCgenGczoNMNCXr53x/q+x+GYPsdNF29yQZT3ehRDhE/bRdRljMI7KtEiS9oBQmS5tSEqkQR9XP4DqbSgB+0Aysu55taJiJapcwgzFMU/tOR88L6pxslIadyIDZ+AH4ziY4JbFtCnoIHsUXJevKjjs3ws47JGqXWHW7WfiGw1oj2q601fg3bZaYqgokFQGlyQRx8UdeZ4ehRtGnCejEMfaNr2+KoNZWzOVztyOrFtefMGM5R4fQxW4qdYl2zj7uPQD16dWOe3Qmyi1dbqHRABKFv8SoDx3Tb4/MpQ3H7QWknMkNpdG/0hykdpjCJI33DrzKBWoGGDz70nvzFSpl0YABqJLXO7HXPTZBJRfTU5bdChOqBqvX91fVOuy8OmxIaAXd954DERX/bWskPc8Ykx8hB/6NYSGBvJTyfarCrb/mStJS+P5Q5xpwxxDniVGNI7d8qI8/rVwKv9ScjAhn0+lhupW3yOrHfBVtdxV4BOPOGxvXTTNYw6b4c47lhH996wA5Dbro3QBFdP/5g7vPOJCuKKV1rmhY0SauewXoE5smcPx2hVw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+gzdFAT9M5aTRoU4AcaaXOTEc41qdabbn3D2MUp8UjtvzgHJbb/aWyZEXTx5DA3QllVGumcQvWnXWl7s+Ri0xMsrXCy4DoZnO+MwZpYKpUZ50YmDZFCn7VaioLku1dS88e36afYbZtbm9Gvk7BaZwXiKjx6NF875awWoaIPAS/bXcFR1Uw+2H2pqMYOwEVycRrVekIMOM4o1nwBawBEgFuM4qTYKKfTZRozk9aGfbO8x7HQqIr29vDSWNBA1vB81+spT0GNWqpEzceCLvZxiE2Mehgkuqk5arSTIKuRY1RUmn2A0ZYyS6bI/TW1TZBp1RLi53F/SriPIuAS5BI+ensXhOfDqkFAOblWfluurrpZtQtpkMF+tfre8l/lqk1vHWa20Ch5cYwgCgS3E4J0bmLTfMcfP5Yo4fAmbOILYExuaPh96YrI6jFb/o08WMfTp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 12:32:07.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba2855-4ad5-4e72-83a8-08dea1345575
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19500-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qemu.org:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: ACC30452061
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
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 10 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c    | 17 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h    |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c340ad2fe09..c4cb5369f0a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6778,11 +6778,14 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 		err = _mlx5e_resume(actual_adev);
 		if (err)
 			goto sd_cleanup;
+		mlx5_sd_put_adev(actual_adev, adev);
 	}
 	return 0;
 
 sd_cleanup:
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6822,6 +6825,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 		err = _mlx5e_suspend(actual_adev, false);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6923,11 +6928,14 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 		err = _mlx5e_probe(actual_adev);
 		if (err)
 			goto sd_cleanup;
+		mlx5_sd_put_adev(actual_adev, adev);
 	}
 	return 0;
 
 sd_cleanup:
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6980,6 +6988,8 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 		_mlx5e_remove(actual_adev);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 }
 
 static const struct auxiliary_device_id mlx5e_id_table[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 897b0d81b27d..f7b226823ab4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -538,6 +538,10 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	sd_cleanup(dev);
 }
 
+/* Cannot take devcom lock as a gate for device lock. ABBA deadlock:
+ * primary:  actual_adev_lock -> SD devcom comp lock
+ * secondary: SD devcom comp lock -> actual_adev_lock
+ */
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx)
@@ -555,5 +559,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
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


