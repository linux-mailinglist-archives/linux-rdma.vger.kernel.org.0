Return-Path: <linux-rdma+bounces-18968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNAoGAaCz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:01:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB23927EC
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9885030311BD
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035D38836C;
	Fri,  3 Apr 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyAE+/n9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6223E320;
	Fri,  3 Apr 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206879; cv=fail; b=SIJd/xSexS5I9jPBq8+cOE+yl0iYnFeRgJSR+DAw9gsRQ34yoU+8ZAzry1jl4ZG1azNrvbP7ADPgL5YsHqzg0JXOQ0LgmDG87Ein1h2ehy83EVNdFQZPfXbXTx0LGGwelW2METzx0hBP0vU+LgeD0EBtWzzWMThFHPkF+TlbuUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206879; c=relaxed/simple;
	bh=fulxs8Sc9JLiDZJJ3bMNjhR4DZoV0ePSp1GjNSRtkpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ+qhw0r4zr8p+ix65OiPd/by6dfG896Qy10r4NP68ePAp9RodEe5MAuBhOYjDq6NZuunUDM4hziwyr7BBZEMftSP0aSooCqQQe7BUvE4tv8cri2NrX5uCDbwDQwTusoDPzx2QbqjE8zqGiHLScppH1sBADBimO7kCPHTn4JVPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyAE+/n9; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQKb6uX7ymokU/J0Caf7XERo8Frw7HI8Ok0jfwz8uZZLCJq2ZOWXsIO1C+fCmv1+eKo+ufossMnx5ugJbKaSmtk1M2GtlD+Z/kXLJ8/B4Q3m9/SyDk+YCY6W5iX3KJGxrE3MTPThRWRSSGWR3eAFqdTYtpAs99VWg32AftXjB+LDH/Odn7/GDrVeKhvMdxEu6bmC6TOgVBWCifrH6OEdsvDK5Cf9p98MVoVSc3AD2kQsDQLQ4USAubDE/ft+VdAObZbhe6IgpLI9GpMxCv33fWAsRhBPwc2yHOkLHCyJL3MSsTOYkvjYPyHpucMqJy4VzOK2hko4DbkvxW747D+gUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+j5qxY9oRyVTNdMuAPs37vjcx0P/UpbK6WCh0u+roo=;
 b=WCm/GT7lv4lN6PaLaeKNhvHvnxZHDpERcomVEtfVxo6mZQGPftd4pptmncXH8lmO0vGYmJ3yn8FksHx8NyRbvaQdMC6DXSjNfSL8IZIGqaBuKeNKAbfRlyVTSM9koZizQRgkXTeH59ApQh4T4iF5ZPu57WLkgXMhz+WPVW0/kz9ryKw3682xGWZ7D59l49LNeR/n05sQTlxTtiHLDtUDDu2Y1jACer1FtsSxsqglfi0H08d5cNWtN5IS6ezdlNgLneJwXd33mCxy6oJT/nhhyvCaZBnlGeNmmxFvRf5wBPYq2oWj7HYlLMSoznYz+9v3KD9+W15MKtsCQjRMJ76ioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+j5qxY9oRyVTNdMuAPs37vjcx0P/UpbK6WCh0u+roo=;
 b=dyAE+/n914amc4vkMaCuC1oP1xfe4D2T9oOZWGPdUU0UNB5M8b1z8WbZ620m5e6hBRXsvihaepdbPNvfodRYRgFCX3173JoyCend6czmh4OF5P3jGgcO9JvGTxGQY7Z8B34QtFNIV7h3vfOU66YxBdvp8eeUcZ3Siw5+IyR2aD2K76LAv7qUJaWPPg1PgbgGY0M1eje70TATUsOCxqetjEx+qfOVg3MM5q/IqqP0KFxi6E0tH5w/yiAkJ+HoRjgFtuTy+eTV59POp+/AQVym594QItd8EQTubJcuU0qg8ith2BanV6y6X/K7Pqm4vEKwnLgG3ZS4ovCxTLVuMSdu5Q==
Received: from CH2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:610:38::32)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:01:15 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::3c) by CH2PR05CA0055.outlook.office365.com
 (2603:10b6:610:38::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Fri,
 3 Apr 2026 09:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:01:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:00:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:00:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:00:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Rename MLX5_PF page counter type to MLX5_SELF
Date: Fri, 3 Apr 2026 12:00:27 +0300
Message-ID: <20260403090028.137783-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090028.137783-1-tariqt@nvidia.com>
References: <20260403090028.137783-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 65984b34-5338-4c77-16a9-08de915f8f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P0BxzPS2ZxrJ4MGqi3aEm4lXuiPNsivhc35eb2Qr7oCJ1wYjB7tvAgNKiUCrWLUxj1RRaR3MFHK1nlXnk2s2MSgBZI9OC6lvU9cVORU1VFMwk0Ecc1ZmG+1myZtPy7Ol/9tKBEbIZkGActiRhXKZssmDubtFIK71/CqvxCIMwoPPImP5UsN+k/TGmMaqlGuz3phIjwWValUl1I+GuE5dThymJzRzqaskjX6ClPMI+3Y72XCnSvohb10Myl1zH9qlDcBPvE9XC4ntcty45ircyszr92SuDlBhBS+bPG2fLQOxAz5F7HEhwMkTqfvGZC4jCo6aT/udN5W5quTdKk+CHbHcNgrmqF1azqGwWsQ4lRMV5xtAoDb8Vjb9t5D8XBR5nZnz18ymk/j+iDs6NoE1XddK9giz4XEUKADNEC3MnJ0EyuQnaR04X6BPpU/lxUwyVBkNozZevKl/U0nKQUl92qa3aDUDoyKB92xVDkFDzzazQCsRrMQ57KNangE6IqkadPzV22BuEJNguCg4Zgl5inyhte110FcYz+rQj5YwYN55YOgIkyvoAoE7jo8xACqAjI1Xlf8jSEFD2M3yUb6DjGkOHBw4zvKyxi4kXHycacxctWYnxBxSAlL4fivhptpvcPFR8gusuK1heE365CyZsttWwSAScO6Hykqi6dVZidW3kq622V3NvSft+LArOseGYGJMGPKiELAUKe7Pp4pro0NiSO9foTDkSSLHQljCdhFXSfBkBEoqmgh2j31mnqprkvlq6awlUWJnU7Iil7Rb9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zsJS6nKAHmHeVFQnK6t/18SVYgQUaJ77RGRN+veu/AF5cZofcK6I6zTsg+IY6wgOEOpnUbactuabA4eyQsyzafYHgxsxcYJMF85toxsA7/lKsG7oX7NHKO4xEXdeJAQ5WGSl1CNk8x4YvfE+ZxTWk1nT8ITgdfMqdL0e+sF7hgXoE3fLdr7vY5jYGVPuOAja2I/7MM9yKxm4sptQ1vU9uvZHJUb2MLJW+aIQDCYZNHzPR+yYqofn4mR2y0lzSdgh2uStqKoF3ELOg/4ic+7R/M9IR95CnlfYtQiz8iHmTzwqWcN76I04jMM1UxfTN3S+d5VU3WR79nS0JfU6e8rkKT3qU+5bqSBzh1w1SzxxUH51rr8K8LcmVTTYs8IL4LBE0QwwkUg9NrAHXaOIw1ShYsDZ/xJhVmGlguwa0zh3UMmaNZBeDIfPHoKGFTlWZl71
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:01:14.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65984b34-5338-4c77-16a9-08de915f8f5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18968-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 07CB23927EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moshe Shemesh <moshe@nvidia.com>

The MLX5_PF enum value in mlx5_func_type is used to track firmware
page allocations for the page manager function itself, which is either
the ECPF on SmartNIC systems or the host PF when there is no ECPF.

Rename it to MLX5_SELF to accurately reflect that this counter tracks
pages allocated by the manager for its own use, regardless of whether
it is a PF or ECPF.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 3 ++-
 include/linux/mlx5/driver.h                         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 5ccb3ce98acb..77ffa31cc505 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -77,7 +77,8 @@ static u32 get_function(u16 func_id, bool ec_function)
 static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_function)
 {
 	if (!func_id)
-		return mlx5_core_is_ecpf(dev) && !ec_function ? MLX5_HOST_PF : MLX5_PF;
+		return mlx5_core_is_ecpf(dev) && !ec_function ?
+			MLX5_HOST_PF : MLX5_SELF;
 
 	if (func_id <= max(mlx5_core_max_vfs(dev), mlx5_core_max_ec_vfs(dev))) {
 		if (ec_function)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index b8b5af78284d..10bc913591d5 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -550,7 +550,7 @@ struct mlx5_debugfs_entries {
 };
 
 enum mlx5_func_type {
-	MLX5_PF,
+	MLX5_SELF,
 	MLX5_VF,
 	MLX5_SF,
 	MLX5_HOST_PF,
-- 
2.44.0


