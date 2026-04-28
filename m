Return-Path: <linux-rdma+bounces-19638-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NoksIelN8GkcRgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19638-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:04:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0AA47DDE2
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D035D301704E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C6C33A014;
	Tue, 28 Apr 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIWsp3NL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397B22A4E9;
	Tue, 28 Apr 2026 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356163; cv=fail; b=polrsQShv7TAi4PB81BojzDBGGQPcnmsgyGeHiFJlVKMc4IJF0Ud48YQVxXq8P1HozQ8G0HDO7EyrXz8xbqh+dc8XX6pFgHcypg79CyCLIaxO4iXzWAkIAP0vPbnyDPahbn3+edIyrEPgGJprPdSTQTUxMoObK1sFOfd7BNUdtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356163; c=relaxed/simple;
	bh=5D8NM1CYj31mwD7gxIf+qA9qnAWzXjBFV0/626puPYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4bqMBRqsqG4QHGmgz+9g8lfge3OL65kNK0Q0gkQ0UCArBk+6Rsy57bzpKe7QSwzho3w43oREK0IxRq9UNS4dqK0FzTTo9ztN+c9Q2fdBX+q0neU4GQdD/3uwi6U49PK3Se14ss+BwvHECN9Y//C1YY71M3i23scDTI6obk/smw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIWsp3NL; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM4bXfe91S05agKWJsK+r3FI1XYoYofxV+3dGQoKCZhFvN8wC6NHo3njayKdvh0CGVTNJGsClZQTL9vSX6DPOW0DKh+WQBOXT09YQeGZdKccc7FFzPcZH+tjt8QZmI+ocljWcD4z/kvF1gGJT1OYE5Cy3g0ITNq4ye1hmiko3mtTUGyYIYqMp/dUAfp0YwWtjK0jSMYuMJpnHfPeNCrFmtYWojKrw18NAePrrnBFp1OjN9loqIBcqlyRo4fnZjuoCQkFVBPpWE2cJGy/XooDu4f2y9dhnOeXEfOk0Wka00C3c0Vo0P4zjSDi5yHRxckRaJv8tdn71qCkcFAKsVt2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY8claiyhGeGRjGPPRL6ZnSce+mwO6q3zZqDyk7QTRA=;
 b=yU3WsWbf8Sj4ETsQaa4IzwmgoQaaIrw8V9Ok3LcnHiCmPj5RHBSsveBaggLRUdnRkVuLD3mYu9AIyWGufcMaEDhP6vKFw9k9Jo/8mDBL1tOTThqpYMKC2kbEDpl1cciQ7J1LZr4o/kejZ/Tkr/FmzLj46QbFrQ39WeHXMkMUfYqA3gQYpJkT/HT7g0+XxjBxSLKWLFBF4gAjI0wfkw8Nml4DdFBiwWOOieO80zYKBgkcNEjUSYPKSnITwO128HImoSrkMwfokZMW0Skg3jku73wa8vnkaFCEjNoIDBsIDbr9WZ7oNQIKpYui0y8Xp/MomyA90xFYw1WOcw2sPbq7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY8claiyhGeGRjGPPRL6ZnSce+mwO6q3zZqDyk7QTRA=;
 b=YIWsp3NLv1W2UL2yR3Z3GeJpsXw4UDAhucudLT375CHSxdZKmo2PANp86+LZADAB01sXFx6+6ySyBQmkyisVEIxr2RegVCFqgHWKxVFPSpD7kkAIZIJwdMbO6PwGmQ1XKNhJPdSinOG+3XeQmb0AMzH5+nbhnRhG+/sMhO4Bab/xkG0Vp43qhVAiVhZyAwLczZiJCnMxbH8qulEkMwVyV1oV+2spsvhaFC9sRzZDCwGYZDOyThnOpS6gaJC0wf8LDw4rBI5UW1u4xNBqE5hpqYL+I0jYEufuDEyMIBuokzvj8EXxAyvFC1yZej8N2s8GCPZ3wT3KRj2/fRwC2rbLlg==
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 06:02:36 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e1) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 06:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 06:02:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 23:02:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 23:02:11 -0700
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
Subject: [PATCH net V4 3/4] net/mlx5e: SD, Fix missing cleanup on probe error
Date: Tue, 28 Apr 2026 09:01:10 +0300
Message-ID: <20260428060111.221086-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: bd519e78-9efd-4f27-a219-08dea4ebbebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bQ2MFyYIfIhyBHhJ6bBFwMRGLIzdaoKktpLg9AjGokJun/6fpTzYHPYsPiO9jTr8EmbTM5L53SMRFqYG3Qn3hYmXMRY9pvX5/Vu1QSPm8WA4/7bcC30oHfLHi/IDCWDgah+A6t4pwgiAtLyLWzIVn2lo4VrxhQ6qS0zGE+BpLAaOJ1giqTNssQZDYsgreRrrBh2zInxaprp9XE9p+G3rEZewoH5szQX0ga9FvAZY/t6Gda+A1LVfprfgoTgWQ5xlaa9xGiCBy/wVtIwDVGidIMc2T9o+qlruDMrzTvnYMxOk9Bzyz49tI1rZVghmOgL3g/4/Jut3e+i5VTgJpXz4dpySgtPnOiBLCKdxjEOXbRmL6oVEKyZuC4nBcbMd9I2Lx9nW+K366V6hzXzIyrr40Bmx2kaU/AiAWOseqpss+9SZJdQ7ozDYAMzBMarcXRR7YAJkeh7OWsETlu2l4zGG7KQVxcgoPzG8OeBjgffUCqWQe1y+/KS8vN+ldcMP0997CP/DIgKeaCkMZFrXMgcWSO7jNPGhKq22yRh9n+mMHx1krbqIkOHDTNcj9c/euSnkdwFulo/h5Xbb4I4s0ZZPwUqHdPSzxNY8/1OKp+iFg5cXQcDU13zovbhrNbY68Hs7B+SsrL2ic7zwTWJQRu45NQ6gw99X4NzIPzncaCnlfy7Y8vwkdO186bXAIQszEj8pOneMPZqOw6JCODCZdDlk3OJdup1N+kjHdFcAmuqHXXGyRDeIX0dpYkL2Y/0HmUZdDh0OpWcriEv7RCrJBb1nQQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hm+eIx/qWf/kZHboufJiTpxoI7taPrTy+YnAJrvG0SqkKaXkf+25INPomqHnj/h7LrH5cCeKhmO0jqymNJxXRoMVJ2UcG5Ag35IDjUPgcTscHl8bOO0+K3GZiejN/Pv+CKJ/xAYiBUtCwPHOrPAciRNFuGh/ZXSqoJVJcEaUqEQgsdGjNNd5HyzSLwCi8kKgmWK8aDwapXM7rAhkV+JqFDMGzDh0MseycRKjPms6xV5yA8A06Ta55B7UA84RXM5nyjmVLGkl29SwlCJ12PL21aT34Hd0KRvvPFu6dqv+dTmnhdkPP5J7wlyVj+uZLTmJDKhqWWzbNulLUAM/qoekRYeSzm62FrwWYq/wFz/CUTVvXBh/BSusJTYgxKaWCi7ABwvR7rqSoSTcOtSrO9it+yFz3nIKHnGReE/wcx+1BzZDQNCWXGPqtRRgel1VhYTg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:02:35.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd519e78-9efd-4f27-a219-08dea4ebbebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
X-Rspamd-Queue-Id: EF0AA47DDE2
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
	TAGGED_FROM(0.00)[bounces-19638-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


