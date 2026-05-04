Return-Path: <linux-rdma+bounces-19938-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qByRCarf+GmU2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19938-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:04:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FEA4C24C4
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 299E1303BBB0
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF23E51D5;
	Mon,  4 May 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qasuN4T+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877F3E1205;
	Mon,  4 May 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917803; cv=fail; b=ufKhvmGrwzWWMDX0EXhtbaYuLDsPa9rDaJqGBgM46Dn4ZqgW3E4n+JzauuZO0tGQ+pG+/9Nd2UomqylxgTDPpk+u7AMYzbchAH9la+sviNeUd3th9PgKWTJFHhDwJbqgfSUl6gkeMdfI4vUnI1O1I5Mm5vqwWfSWmf/9DtWP5ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917803; c=relaxed/simple;
	bh=5D8NM1CYj31mwD7gxIf+qA9qnAWzXjBFV0/626puPYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnGkzivgKqPsqvRC7+mp0hpMKdtZZ6/tna4xo3uaOkv7VlLwbZD9nx0Ceq9KDadiGdADT/TqErHY5u68Qsvm331DNYVBJyNdl5v48w9gk+pkSMH65pXxe6JlZqIMC0c1MnihfvbZ+SeaM/9663oKGsDi/4RAjpJNmRAtdXN9jgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qasuN4T+; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXH5e9EO+3AO7KcbUny2PndhIlK6HkHrZCF36+DqoROfxtrvqTwlP9TcBCjaa9WnWurJI85z+TqfVKTRj38iwSdOZD7p5RUNliIbSZyuiJw1PFoT9q9g1+eigKlqu/HOsX9fpXrGU/uS7gNA2v+MQbEWT/TXL+JYH7j7DdLfX5/O6KOO3fkhM54Tr7tupTvGCiQj37MKyPOjOPpGwPxPC1aqzyZhSB0p5q/o642LLetQOGiCATeFF9RyRhBtBKlXzgT9AjQ4Lil2tpiJMNP021ipTnc0k7aAsPvadUh+JdgzIziqgeEzLYRhhv+9BT/wVYrEVcWINB3xmgBk+6u4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY8claiyhGeGRjGPPRL6ZnSce+mwO6q3zZqDyk7QTRA=;
 b=V2mHKIlpHHkWdUIYcN2mRMUy/O6WVNiwyt929gDQbL9ramdLqo82jZxipavIhEmNzJ9S3L0U3rmzlciC5D1FbNeHhUwj8o1YiGvz3YzrrkSuzlKTb/DDIz1b/Sw5j2KhtxDkFwBDKSHuO4gffPRPEbNvy5476oLlQuQQ1PBIXZoi+AJruOCuKkAQMRAw6IEeOa7oHklIaoV3upghLeLiK0eFoGG4vTvpYZvhpUvLZMssJ9HQo1XjMripfHJoj/uHb1TAidYczDedDlSRLdjsgBnDgrwgVtnroWJ7vzAG+ovBmqsQ37Yg7vuN2EVKqvb/2BJEYwwZUotmLeocpX7AMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY8claiyhGeGRjGPPRL6ZnSce+mwO6q3zZqDyk7QTRA=;
 b=qasuN4T+jb6s4ISXo8Qmeo2hNeFy/T8sabONqpYXlTPgEMKPm3abMc66cF9PI+36D1nCS47nJPrhvBSCQ1KCj+I+bS63joplfMBwSs7CDk6+yyNjaL6KWKC9edZS/n1bSs1xGe2BP5MGVo8Q+85Gvw5jr85zASUYzwoAl42GHXl7mBQjavHbsdy0npexpElEPDSC5Cu0fTmFlI/q0JjfusD3W3I+UBCurpFkYRKAGtRx/aneYl+TrSy+dXSacaKReWr+7Va8sh90Es9esj/fLME5UPmuAi6yZcuD651RSSbGk6C29IvRzFo0sg+3IXNoTKNl3AB6YrC+0rEZkENhng==
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 18:03:10 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::e5) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 18:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:03:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:02:37 -0700
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
Subject: [PATCH net V5 3/4] net/mlx5e: SD, Fix missing cleanup on probe error
Date: Mon, 4 May 2026 21:02:05 +0300
Message-ID: <20260504180206.268568-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 547d18f7-6710-4097-3a3e-08deaa07673a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LPL+xDyNc5JzkrwHeguEI4RrmGi8mNVBWpBxJRNCGe+8l9AI5y3hYbJeeIZpnlD9p9zopQBH5f1sOfQlBfSjCrsVcVxpmkVXH9eDInhtPBv1WC36oGRke5iVeaNP38BQyrg6VWsg8vvfAr2ThbIx7wy3bhjb6j5DIPfIEYt8/xmz0lIVLT7gVWne59Nd8rGukY1PnvPkrx0VICixvKMXZUAq5ebfkYGObyvEt+VWZDKZ2q0rSzV1f78EXQhGt9dLB83BYA9FTez66GCAWEpFBi+prnBUPKpu9BMcz7DN8K6icOBNr/e8GiFalIr69q/IZ7VzfBv+ppWE6CN2ONfi7lw/RL98AKV6dBOlrQ03lqOBlaZHzAydey9qDRBPG7Q4TQc7sf8LGgKGDuSQT8daexYsh5En7FRAguYXP5lsLyXl8g0juKWVJDSHyZ9Qaygo3iEUjXJUnUSr344UHNMsAmMQu2uCpHQJq8JWnDUmyt3diSsJwPn7PJGB9nlXwUQzASAnokFjP73wd+bJCR2jb6pd8PIORxL+l6w9QAITNDYosOjXyW3MnJtF2mKf/m4pif1DqcUBH5/ZHkz17XN5t3Lxq0NvGhMcUQ6SccZbrG2j8sF5xYnEJisRJKpOzbBZVSauUlRO42zJY8PPkGgsWEI9BcBW6mLnMxuo0L4yhfZzv5CkzIDowr5Rkai9dVGPySzsax8QFKkSuWbbXwiK6q30cFPMV+I9OK5IJ0GF2Ww=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fHHbp8PyN9ssdpR9Ddp35V7TBjd0uMLmJGYPxXsr6EOIIZ9XcM57e5v4yoncB4a/98fbrCl3sKAJ44QEvwwoJITCtb6xL8oLJd6zSOEs/d7MuCz+lOZavgub6H94yulpuj+xE0EeBtj1skxAv1d996NDm+aNMrrh0+ZtU2LSaymUI3U+ZlIZru9sySVVty3wjApjaA2gbhu8sSqyD9u1D3SjjQK0AFMA9GzflrWNxB1ZTs9VFyHS6vlT7juUPQ/j3HcBmvVE5XDjMkE8rz7/IH12ZW+A+Msjj9zWeWIdHeUmDVkYQrFFdGvpVdUTVf9cF3GOeeOmQ6xlACgikRcNrr+e6f48lPhtxcxp5d9LvW96z19X44IT6g5Lv/i25d6xDlNiQpkPgjaKP3Y0XW6UibhsOQ1TNtLNHz+kbRyJmmlJMuY9zI/GVz6OEGzvxriH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:03:10.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547d18f7-6710-4097-3a3e-08deaa07673a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Rspamd-Queue-Id: 97FEA4C24C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-19938-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Shay Drory <shayd@nvidia.com>

When _mlx5e_probe() fails, the preceding successful mlx5_sd_init() is
not undone. Auxiliary bus probe failure skips binding, so mlx5e_remove()
is never called for that adev and the matching mlx5_sd_cleanup() never
runs - leaking the per-dev SD struct.

Call mlx5_sd_cleanup() on the probe error path to balance
mlx5_sd_init().

A similar gap exists on the resume path: mlx5_sd_init() and
mlx5_sd_cleanup() are currently bundled with both probe/remove and
suspend/resume, even though only the FW alias state actually needs to
follow the suspend/resume lifecycle - the sd struct allocation and
devcom membership are software state that should track the full bound
lifetime. As a result, a failed resume can leave a still-bound device
with sd == NULL, which mlx5_sd_get_adev() can't distinguish from a
non-SD device. Fixing this requires sd_suspend/resume APIs which will
only destroy FW resources and is left for a follow-up series.

Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..e21affd0ffc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6775,8 +6775,8 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
 	if (actual_adev)
-		return _mlx5e_resume(actual_adev);
-	return 0;
+		err = _mlx5e_resume(actual_adev);
+	return err;
 }
 
 static int _mlx5e_suspend(struct auxiliary_device *adev, bool pre_netdev_reg)
@@ -6912,9 +6912,16 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 		return err;
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
-	if (actual_adev)
-		return _mlx5e_probe(actual_adev);
+	if (actual_adev) {
+		err = _mlx5e_probe(actual_adev);
+		if (err)
+			goto sd_cleanup;
+	}
 	return 0;
+
+sd_cleanup:
+	mlx5_sd_cleanup(mdev);
+	return err;
 }
 
 static void _mlx5e_remove(struct auxiliary_device *adev)
-- 
2.44.0


