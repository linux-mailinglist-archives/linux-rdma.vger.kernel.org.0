Return-Path: <linux-rdma+bounces-19939-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDMhGMXf+GmU2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19939-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:04:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26B4C24D3
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848F93045B2B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FA3E559F;
	Mon,  4 May 2026 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWbX9Mkm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF7F3E557D;
	Mon,  4 May 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917806; cv=fail; b=VI2n6TrGcz7XBRv23hfICi8t69funNa7sQZjiW7W/mT8TVKo+JbXfgI+1juziKyaNQYNdU0zb2OBeRdpZ9EWlCp17L8/hCqEzrgQ0cUVCMtM4d8WOUfKTzw3p+ImiTcWsyW3mhbCiHkyQSKemL4fiQm18mZnNLXSZifaY8rLFYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917806; c=relaxed/simple;
	bh=KjOffHBDMZoW5gIxD47Tg8fM67JclBPhYqrFl4vA7VU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5D8/uFDoY9QTOSDudb+KlQYIFeOpyb9IBfogcqPiZDKrO0OrrLhjyyIXjEmndtZNT/jBmHOU5gopVE/UlOLTA74Fj28a3bmfGR+HzaTeO5QELfRbIpx8tED+sU5t20bCvHU1RhBv9TXATwbG93GD/xwPfB4GITKjLGcpRtJNXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pWbX9Mkm; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4fuih1EgRnKMPMB7XmYwH6yYmZIF+utVzmW4H8cJUP98czpGPr350B8TMgA+LVa6sFHZglzBLUOPR9fk8c9H19gFAoTO7qC1wEP7rgenh1Bk2Po8OupHWqWCPi8EkUB1owIJ5YpbeXrhpSUVsb+sn2Ejv4Yn5AeNuvJEe3z6yw3zbMM6otFdz7QiS0yCk2eicP7Jk0ekxE0oxWMojXkuHmhh2eUKQXLBuKH6EeyvHAZtBCbYQ8gEIM9IRji939ZBVfnZkMc4LcYBXsvFNy9FaXwqUXN3zIJjNmFdU12PRbcoav2RP1khcIyAJLUZPM029rIzWMO2YCiBkSjvgkghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzxnPVFZxlLeHHKsvaC/rvTG2lACplxKEquUGujYZUU=;
 b=dDXWDeunFBbi62sp14spUGPKx4sLAwYDNU4bfJd1j4SM4NM52BNLsOeQh1z7NJrvcKMsBDP1ELH8UJR7phF+j7NN5Kbrtrka4e5HeZT2Ot/2NNmBGVpZvg82tNsN4+RRcLpMoB5+Fgepvm1lf/kJH2jpQkh8aZMbuJ3c3plJdhrpA5/3l+DBbqxP/zoy+BK8n6/ryrK2mHgIAskMx5VwqEE5c4+nKwE93iZuKtOMS1a8eNrClbKYDl71ysqFLm+tXPRupSPo0uL2xlIzT2A8h6AD+c42tX+j8Y/pjYPu7zUQTysLSUa1vuLz0waANcXCRRG0epfBnElXe3zCfggnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzxnPVFZxlLeHHKsvaC/rvTG2lACplxKEquUGujYZUU=;
 b=pWbX9Mkm6W3It3CDF08g/HDojV+jNDodJeJ/+8ZgMPoBar5nbh9sxZ5URdcAGIfuqevfe30sXnEcVpvk7VQxbgyby7R/fHA8x0eGS36NoEH3DAvcPjN0f92IhntbjJ6/jvo24bkIQDMzcMf6DLC8XOCRwWXVUYJVWLTPoW+0C71rb1p4dN5hHR+z/f7SJW3TC0R8rzlrrAhCRk4SzfZiW3aXTZ/6B0Ec5jT6MK4QXYKX1I4iyLIU7bfpAe21gI57KrRL82rR9txPcl4qGw2BFzsbMIyDwLbDi3TWgqhMLYxhEBxvhdOfSPpT5mwTiy0R7/2vFz6rDE+dPoz7t0AHiQ==
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:03:13 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::a9) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:03:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:48 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:02:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V5 4/4] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Mon, 4 May 2026 21:02:06 +0300
Message-ID: <20260504180206.268568-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504180206.268568-1-tariqt@nvidia.com>
References: <20260504180206.268568-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2230dc59-9a15-47f7-f28d-08deaa0768c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+hGUjx64kB+VSXkeJeD6hbFHpMIdevV6YDRS5v1iuTNsWBVxJPDJTmmOd467a6g5QqymSVOkJBTTWZl7f2XvvLeiWD801OZzITqcSTt7qikSib9KdN8VfNSgw7fGpESDL4Q6pDyAiRV35mavl40zMwc6jCYJGVFu5+8iqfE8yUOEMb1TeeG5msdB1g7reH0FErUj8/JZK4stnU5r1QjhXba3x6kEZNqfliYoSKpkv6LBIXIe9pwvrUX1IGii9WZQJEZMhAF/IxTMWlIOEOdp1lvqv4X4TJTZ90UDROES8kGrE7+WPp926UJvWPGXoBfdCZYuNHDVFifIOr22IGwPf0IOobvCAUpwNcXFu0LPFcCoUZNY6MBI1V2xjE83nLQVCRPGjBVJPLNglT4fZ5NTF184uJBedeodd6Yd+GD4PaLJP2qEuQj+6A6wDlwIYtPGk3ylP5DQUjKhq4Sj+HNEJ+k2UhaFfF+mJBFKo0nXrB8MISwXDmVL/UPDQ4EMi7th5CugJ0eafzoIG2icInklVyyPZ757vlKq7Pe4Nw5hZmcts/w1Jw1qTj754xkdPBKB5IjA0IZ38oAkS1HdDh0P7msUuaV1BO0FIW2LAD3Y3/QRGsoRWgwN+r1fAcvBheU344ysU8pMK5lIiEHFnczFm070ouEqpdaINCGZhBZIg7uqu5mcPPsoVW+NHGQsbWh3DhRMEl9bgwa3J694cVKpyjC8HKLS9vePhvrHRD8dl3g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3aLtUKThyATAiMBjg5tTEdyZu8Zc1wQXMtVNiGQS+aapTxwxyifx/+fammTfwUy9WRUdSUCvJGo0lx9RN2iKPsY71ycu0dp4pSlLtEWKCfPUEilOWCjaupLQO1Xq2w6N9NBnMr32cF5l0hRztn3OjNB2J9/UTYCfa/hAxm1gwN/p54/gTdVCUhURMLn+61TBNy4P1t4e6U3vjLDMN2zUxGLmRzEVTylarqbvDPNMrW1wbhKPb1lIkoVFtxj1WOfyJMrMeXnW6COINRPkKx2hUibhQnWYMZ5MRtpUGPart+NaetIPl1A31GxO4a0CnNb0yO5+EUwamZ9R7q32TOqqTwl8iy7HoseaxSrU6Y9vtpEvdMO5LjkWsNGSoYD0aK89nJYOq4KEHGFNra+rSDFTechA6ADDba9jh26UH2EZdn4TE0kCBTb+ZaEp7tkMdIik
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:03:13.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2230dc59-9a15-47f7-f28d-08deaa0768c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Rspamd-Queue-Id: EF26B4C24D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19939-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Shay Drory <shayd@nvidia.com>

When utilizing Socket-Direct single netdev functionality the driver
resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
the current implementation returns the primary ETH auxiliary device
without holding the device lock, leading to a potential race condition
where the ETH device could be unbound or removed concurrently during
probe, suspend, resume, or remove operations.[1]

Fix this by introducing mlx5_sd_put_adev() and updating
mlx5_sd_get_adev() so that secondaries devices would get a ref and
acquire the device lock of the returned auxiliary device. After the lock
is acquired, a second devcom check is needed[2].
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
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 11 +++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 39 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  2 +
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e21affd0ffc4..b09806dfebe5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6774,8 +6774,10 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
+	if (actual_adev) {
 		err = _mlx5e_resume(actual_adev);
+		mlx5_sd_put_adev(actual_adev, adev);
+	}
 	return err;
 }
 
@@ -6815,6 +6817,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 		err = _mlx5e_suspend(actual_adev, false);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 	return err;
 }
 
@@ -6916,11 +6920,14 @@ static int mlx5e_probe(struct auxiliary_device *adev,
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
 
@@ -6973,6 +6980,8 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 		_mlx5e_remove(actual_adev);
 
 	mlx5_sd_cleanup(mdev);
+	if (actual_adev)
+		mlx5_sd_put_adev(actual_adev, adev);
 }
 
 static const struct auxiliary_device_id mlx5e_id_table[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 89b7e4d67303..6e199161b008 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -562,22 +562,55 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	sd_cleanup(dev);
 }
 
+/* Lock order:
+ *   primary:   actual_adev_lock -> SD devcom comp lock
+ *   secondary: SD devcom comp lock -> (drop) -> actual_adev_lock
+ * The two locks are never held together, so no ABBA.
+ */
 struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 					  struct auxiliary_device *adev,
 					  int idx)
 {
 	struct mlx5_sd *sd = mlx5_get_sd(dev);
 	struct mlx5_core_dev *primary;
+	struct mlx5_adev *primary_adev;
 
 	if (!sd)
 		return adev;
 
-	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+	mlx5_devcom_comp_lock(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
+		mlx5_devcom_comp_unlock(sd->devcom);
 		return NULL;
+	}
 
 	primary = mlx5_sd_get_primary(dev);
-	if (dev == primary)
+	if (!primary || dev == primary) {
+		mlx5_devcom_comp_unlock(sd->devcom);
 		return adev;
+	}
+
+	primary_adev = primary->priv.adev[idx];
+	get_device(&primary_adev->adev.dev);
+	mlx5_devcom_comp_unlock(sd->devcom);
 
-	return &primary->priv.adev[idx]->adev;
+	device_lock(&primary_adev->adev.dev);
+	/* Primary may have completed remove between dropping devcom and
+	 * acquiring device_lock; recheck.
+	 */
+	if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
+		device_unlock(&primary_adev->adev.dev);
+		put_device(&primary_adev->adev.dev);
+		return NULL;
+	}
+	return &primary_adev->adev;
+}
+
+void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
+		      struct auxiliary_device *adev)
+{
+	if (actual_adev != adev) {
+		device_unlock(&actual_adev->dev);
+		put_device(&actual_adev->dev);
+	}
 }
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


