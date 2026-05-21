Return-Path: <linux-rdma+bounces-21076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIy0KEm0DmosBQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:29:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF15A0208
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D7C302977E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F9384CD4;
	Thu, 21 May 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PimpWye2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEC2F8E9B;
	Thu, 21 May 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348332; cv=fail; b=XNt+20n8h4kJw42DcAM4teKHAtrJEwuvHwMbIZ4uerU9+YIo2vCMseqjTt4oIoYKipYHmv/NzQifKwPpELPlRJvTQ2KrME0F1E/5JQy4FYmLC0AoLd3NGEAmXI0D6++CikiDj/fbtCEAwvretiBw29MQ4CTOiT8GSh2SyoA+z0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348332; c=relaxed/simple;
	bh=j/YLYTvilA99yT7CI1PZEBcwp9TeRwpVlfqga4l4DRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1vO4UeD4birR21xkyhKp423oOuDb0z2TYVXlJfrBmLvg82o/QIMiVJDikX+NgyKOD+stFa0DK0Vo5cbg189/3UJmz2vv+OjB1Fq+NZu8bcH9cHrY0D2q44oPdxMkNAdcJQbrLCEljmGf8gh6pzM9+bFIRFIhwFMdAFVO3/31lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PimpWye2; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gfw7I2OnPvn6Z5dfJfW+mrpEOoQVHN5gnhx44uXGQyhKfQby4SbypaoTdsnVQIu1Zu5M0lVEgu7BA0Hm9N4NZ1XGsMpHLEd+BXuLp+uiA2QRPACstpKjF20BI1Xb+qgUNP52YzU1dPoYpZtwCu9phNqDdg9Rxog90GqoZSdfw8U/2h/zA8Z10ba0ErUd0AOHa43/khpwvMLnhiLzIW8g5W0qsCrxBEBmalAJ3xVFIZ7fP7AUVTU5gSspNAZQUrOkIg+Q5bEa46zs1TwNvUdjwsINpht1x6+xmLEgjGnlAaJHE550aWJFhNP7v3YVlzasCURKoZ8xMkTydHjf3LJqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8zvoFIT8uj/+wHxR060BYbZsKS7QIIpQ1ipDHOtXZg=;
 b=cD1NBm4WsuLVpmq9jGNNIgTsS52yUtkhVMcszvnI5HDwTEX8DHpoR9l7g2L1t/VtxZhAAEDrSanshlT23fF2WV+4328RlOME0Pvr6Or6o9PaQ2YWXNqv5C7eCQ+hpvBe/84VNft9Bq1q0FWr3HgTkhmvijTF1/hKNDtmDKTI8S3raKmUPea/Km/uts1U8KbCSwR6d6kgYsaGoeTcvKWNmunGtjUmuEKwNBHDhGjM0gS/Lc9qjEpi5f22ipZwaYGZT1qKH3ANVtfTh6+zyWmqmDJLrljp9YEyAv4grY24eJMVZfGMpZapfTLhzPC6ilUxYAL/T5ih3EB+VGDH5N9yLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8zvoFIT8uj/+wHxR060BYbZsKS7QIIpQ1ipDHOtXZg=;
 b=PimpWye26LTbMSNxGI7/fb4W5LJspA5NUlnx3VdRTesjNGH2Ttb1u4VyUriygt+DJ5dqZXtg43hCv6r1NR05Xv485jEvJOeZOWV8Ik6f+McwHgVFVQmDL0uvtYA54eP9xxUecon+/uxzfgk3Ejq/Ef1AhS8bpu6ZQhXCm9UCpfaGfNF2y90WVnsgNdzzw+eGEKce/xXONDh3yo6CrML0PJ9gPZLmFCUdZTLB3cwTnxCPijHEly9tQbSM7Ny6H6AFvpIOeSUgNYuhmQVIGOOpE4wg5Fwn3rzmJK04e0d9+jvfPaK29N657GQOxCIhIUAkGEvy5J9v7Q+u9upW1+i1eA==
Received: from SJ0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:a03:331::17)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 07:25:20 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a8) by SJ0PR03CA0072.outlook.office365.com
 (2603:10b6:a03:331::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 07:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 07:25:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 00:25:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 21 May 2026 00:25:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 00:24:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov
 (AMD)" <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr
 Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Tejun Heo" <tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Christian Brauner <brauner@kernel.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: Clear FW reset-in-progress bit before reload
Date: Thu, 21 May 2026 10:24:32 +0300
Message-ID: <20260521072434.362624-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260521072434.362624-1-tariqt@nvidia.com>
References: <20260521072434.362624-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 431180ed-9e73-4cae-68e4-08deb70a1d45
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rFkd2NAdPHy0LxWGNX1MI7583EqqCqkM3wZ3/rGeKxArh0l6YsXyQNpNNDN3SzobLIWQPlH099fetIhEix8GOUknjv7jd2UF6HxU3KmhmR1l0sZvVIZYnddpBXQYDzCn+9UINe96c1znqxMMWw92MNP8p/QwLzmzpXFhRlyHG6rWImfJW41XtsOo3WC1qp9U9i02MbipVansMed1EI8NwMo4v3qQxd9YXhyqCWdo0dw0ExsOQ/Y8pektmw2RI2R1sPr1sEnX1TPtXw7G39NUD/FnDw83Mrke3YL8USErJQANnQ1ViTtg+gNxtgm8I7x+o2PNA6W6oyNj84CPMOxURGYx/d49PJ/mXDxzfownrdhl4v+BG7N5NAO7fbPopyOAjpCWxnECjNpfxcgfIXfPIjqK9vHhIbZbyYGRg2gSetYKoabQcupPUoCcoH9PIVSw4MQXxsmyZwkHKpAIabwwaJLmXJjFXCiOpOAPTUBCNCENsqN1XyaGTJrPyY+AR8OA/6/vrvT98o8Gh+03blhBdgJkZwtTOX6Ne6LroVw2Ll5qs0VAuucYDzynV4L7k1/nWS3AKtQJUd+HItR2w+No4e8BnwaG10XJ1d8+VD1mgNARFtmfsU3FmVCVHeJFO/53Ar7QvSh5pRdFR+bu3CM+YRZc1NnLIRrMyPCeIIbbnBZ2SVeoafFl8kvaz6rsG+PnUfZru0VFYyk8OXmRISd/SO+EPpCBA/9MPtO37LacjpM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	odMayCZjGkBeqF19hxKslJhC1Fk0h8Mu0UA91FzGjBd4qbO45QEibWx0pNtA754IK5jomoWsRxKothuuJvIR2NqAH3z3wi0iEm4Y42IG1uayAuSMl2qtlkTBAIidlel1kndG4RLtaMKlxvcJOprBpcrP3hLifV2NVCaaJvhK9RXiHnM5ghkR2oahd0foimct3f3xUIJ0asBVuJDE4AqaO9JlMO4KTQWWbssL9sjfiTRGw4Uuf4XZC6jHHOoGt3eiGvZub7icjxxAYC2G8SFYYrwcso9o7gwsw2PFNlLRUGnVgGVsveTwgU1WBaeSGpyparJhaw8yk38S8CuCv8Rg/A8HlqznbvU7TN2vc2dAB6Q41JhIMI04qSHXq2jySANl9yFIW9/iwsYzRwQ8PM4WuaaNm1idz9AP3aTb/SRjFOuORT6NsnViX18mJsVZtGNw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:25:20.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 431180ed-9e73-4cae-68e4-08deb70a1d45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21076-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F2EF15A0208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

mlx5 sets MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS when acknowledging a
sync reset request. This bit blocks devlink reload and other devlink
operations while the firmware reset is running, but it was kept set
until after the driver reload finished.

Clear the reset-in-progress bit once the reset unload flow is done and
PCI access is back, before reloading the device. For a reset initiated
through devlink, clear it before completing the reload waiter. For a
reset reported through an asynchronous firmware event, keep the unload
flow outside devl_lock, then take devl_lock before clearing the bit and
reloading through the devl-locked load helper.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 07440c58713a..7283e5b49eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -238,24 +238,30 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
+	int err;
 
 	/* if this is the driver that initiated the fw reset, devlink completed the reload */
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
+		clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS,
+			  &fw_reset->reset_flags);
 		complete(&fw_reset->done);
-	} else {
-		mlx5_sync_reset_unload_flow(dev, false);
-		if (mlx5_health_wait_pci_up(dev))
-			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
-		else
-			mlx5_load_one(dev, true);
-		devl_lock(devlink);
-		devlink_remote_reload_actions_performed(devlink, 0,
-							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
-							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
-		devl_unlock(devlink);
+		return;
 	}
 
+	mlx5_sync_reset_unload_flow(dev, false);
+	err = mlx5_health_wait_pci_up(dev);
+
+	devl_lock(devlink);
 	clear_bit(MLX5_FW_RESET_FLAGS_RESET_IN_PROGRESS, &fw_reset->reset_flags);
+	if (err)
+		mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
+	else
+		mlx5_load_one_devl_locked(dev, true);
+
+	devlink_remote_reload_actions_performed(devlink, 0,
+						BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
+						BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
+	devl_unlock(devlink);
 }
 
 static void mlx5_stop_sync_reset_poll(struct mlx5_core_dev *dev)
-- 
2.44.0


