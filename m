Return-Path: <linux-rdma+bounces-19637-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZyIM9N8GncRQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19637-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:03:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4160A47DDCB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFCAD304565E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83456342146;
	Tue, 28 Apr 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lHH0ccV9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B23446AB;
	Tue, 28 Apr 2026 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356162; cv=fail; b=NwuaxHXt8KHaGMX85PcR6GF1KFmi4bQl+9sJMA4QQXHMWdzB0XVTsLHuwmO0Lfil1N1WSe0X2PRD1APW4e7YYTr3EkyslHi36RGxEyRrQGmykSTWruIVBGTdX6bPHkwPEwiF3dQLmOLRIkoH+RsaSwqSsHtC8DU+11ZxRbuEYZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356162; c=relaxed/simple;
	bh=2wZ4zIltWBg7Lqc/xvyJTSY68mPb0yCdv6S2fgqjLKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVUKA7zkwDbLYN46j6QOqvn82b9EfY6ZhZk1dj5lubgnHgBfuLt1S2I97xazHunWWkD+hZIGbkEZQinFSJpVEMHD5rnURpivHDtz43SdeKCZoonDzDSt7EuHDXFXrkQBegf54hvGBDek3KIXZObTMsjW2A5u0xZXCyXHhGUmM7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lHH0ccV9; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI4zt6Mwe3X9xrVGVpP//fY+YpIOeFJUoG3G8oost4Ab4/FWscnma13t2irzTwq2ks5GyNDlZOXMbZyNBjUXJob9do/aesxJ417rrRX3dPoO1POCTr/5zF03VVkyOwr95c9F7TRVsbLX3WurHIcvxCYOVhbTr66Sii2PnupQC95+QQQ/qYkLySCCdS5ujHVSL1JYIYKdc7SKy1qG0JjymaDhzvAlNHIW+ew/CLVEFbS65zjkCemeBwMsqqbd4TGC22j4r9D2UQXgA/EUHdF2ChjwgiFyOvrL5/y9lJDMW/qj7bI4UEBsH8BFQQe/Q8NrD7UV282osB3uEU6i32k9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaRF09kzOYJvfxCXm/rqgG3dLcLRT2ms0+y4V3Ab8O8=;
 b=AnNj8njiDWuWF+Fc3U8e96AWEGj0fT4PiE/PQpeA5Mv2OP4TaV50/+ErRmm81hrvCtealCvsJdE+lEgOXrrlWLBE2g9fncbbPgDoLLHE+tacLjDLXE8pxpn9d7bF9qUsFA4VuyD7cGJ8yBwiTz+MQrGtOd/04K/80NnZen6zXZnv3wVx9ToYiahNmT2N0j4RvKfPCZWkcKdRwOsqubYYYi30KbN3JtLmq/xrogdKUDQU7cVcq9GCWQmWei8ENTAX7jSCQ+M0MferVTiagLBTbzO5EupQykVV8GEPTVzTTb6CJvkUTklYmq2nj+VqMWdf2Oj0+iaN7K/IMhANp6ZI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaRF09kzOYJvfxCXm/rqgG3dLcLRT2ms0+y4V3Ab8O8=;
 b=lHH0ccV9Tjc85r/pcHVFdezb01gwU7sZp/LMjF29H/Os+7V4ZEvYWrsF39gr9ffCQFlMcJDEOv4ZbfZM3dg6Kj7DCDIvWQqmq4hPA7bmdjI8+6x4hOsdxkGZ0blPqsof/ne8IxFkUdjHntH2N25R0TCJ1/Lryk7IdgELCIi1ZY0w7ccqeyNJj7f62mf5TAs3efTP9zmgunId6LFYLlblCaS8fvhHHp3CsNy2HF1tuyuv9I7B0Y7++u9RmnNQfmnE8ZiGEfh1RSV7Pj40Y2ArQlnmVZn8Gfup6weS/LHqbXu2+81ord5Su0ZRAumVerRxUs+LU+MZt0udou9FQz07pg==
Received: from CH2PR02CA0004.namprd02.prod.outlook.com (2603:10b6:610:4e::14)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 06:02:34 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::7f) by CH2PR02CA0004.outlook.office365.com
 (2603:10b6:610:4e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 06:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 06:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 23:02:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V4 4/4] net/mlx5e: SD, Fix race condition in secondary device probe/remove
Date: Tue, 28 Apr 2026 09:01:11 +0300
Message-ID: <20260428060111.221086-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428060111.221086-1-tariqt@nvidia.com>
References: <20260428060111.221086-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: b666741c-f924-4fc0-eba4-08dea4ebbdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rTihfXtBiskwxiFiTuum9bC8/snr0dGn0lldUTC5/bceI3S69C6GkUzme/tYxy9UB0WaYYBAoulzY7BCjJLr7HqHtquuBkBpyEMl3RGaJK1dnMkfh7Yx1OFzK2Uff+ye9PYGQBTx/Zy3jWjtHhwmC4ZMSJGq1Kn0sXtf4XlLPvluM5nL0+tQRKWTPqansfRjjwYg6Ditr437wMECjFJzZxHYPOt6vuEq/AMW2M5Kg6GT9VufNr9SwNEDSP6YlQ7ro8oe3DvoohJf4BHDVUlhgY50nU+/60dVCFKOmfq/2LaTCFJeC7APCaYzoDlHfhFXw0i7RdJ2qTnyE0/m3y0LX2/UYLF/sm2vVWw9X6TBiTDzvQgPuuz6skHqND/EzhZVF50K5S1kz1MmWliECJKkqd0dN+SmOk+7JqJGCz8nfePhCvnlzoxYR3hebeC6FI2eWHqhm4GgD0rOz/bQfj9JIlIMJwjOZFQfP6efNncqxsKlKZnAjh23J8ikEx/vZ5Z7BCStoyArWg5ihvhckDpPdSWiFrL51gD0W/H1/iGxqqOcGb7Peu0rqcEfW5kKThUX66cGANXH1eoB4fqW8mmkIPk+O0IaTbA8Sqf3FPUK539ftzxk9SSfNdWCQyXZjUe2xwEQd76djwAbcJOw11LenHd4u3hBCL4ukWa9rAG8D6/ZWjbqhnolKI10XLXgpvEyISdJnaXEDcn4CxFpEvr45TRjz8BRi/rsThW7d3rtq6vYud/dFWUDr7/k7+fN9TAnhHU9odvLOH06DO8RCV2BGg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hnrqgxsUuDrFSmIi9wwTs07nlNfF5chcOQMPri1ttE6RlhpnbgsvkT080rYHYiV+ORAT01TyL1MqzQGFOslf2YM5OmyEzCX4zILIpcYOWhgAz1sxoN6iAGhvAwR37M1JnuQk+wAd71KD1WTGQ02DX5x2av0NKCYHX8i1OER5x09xLC/gKQGLJnLSI3qLHnDrnhEFoa35RWotEnetKRBsLFwS7ID12n+amuzjUi2ClqlPhBLsy/zqq66pudiOIbOi4tqhUDbIG0jiK/DXuHH67bxDJd+4wR5IMnksPAFDuWlO0MAOPJ6FuC4fQT3i0rXYVwVIlRHz9Yq8SkB/A6r8Bdjw41F0qTPLFpcHIFF3+YCprh2pWYWEbwAE172KNieHUQ0gceMK725lWzWQVU0mH4AdJvLQMGAcCSSi+pa/3ECuCnmNc+EdnhDbmh/EFCEc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:02:34.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b666741c-f924-4fc0-eba4-08dea4ebbdeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
X-Rspamd-Queue-Id: 4160A47DDCB
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
	TAGGED_FROM(0.00)[bounces-19637-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qemu.org:url,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
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
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 11 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c    | 17 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h    |  2 ++
 3 files changed, 29 insertions(+), 1 deletion(-)

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
index 7a1787f15320..a43ae482a679 100644
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


