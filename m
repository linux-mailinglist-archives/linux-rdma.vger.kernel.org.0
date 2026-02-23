Return-Path: <linux-rdma+bounces-17066-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EUgLh28nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17066-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:44:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20317D150
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B924304FA71
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF6378D6E;
	Mon, 23 Feb 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGBUpdpY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADB378D78;
	Mon, 23 Feb 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879391; cv=fail; b=gE1k+0P22xQ8bZYkPLTD73aKqJscBrsUTnat40kdHFzeRz/WkkeEz3e35kBVcTbBE6Ta3SL4HlrF5ve9Jg/0bIETi1jEvRc/clDBHQZwiQQOU8Yhzb8Oe0YOwN03/nPqijfbwpymOP1VIphEO65hvdUPk7fyXS+q29JwCM2aJTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879391; c=relaxed/simple;
	bh=ONPIHWouIHPns5eHonQEvmK0r8jIvS3I0jwcc10bK2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIxp0+CUZ9qGQtIxNXT7DaHoXLGc8K3Kxxzb6rRmIf+umO7aiAJgeQdhBV8KPXpd4NxuBhXj9qo8n8FLnqGPx2wIksCbA6WmbzHuIBGCvsmIjJtOvj/xCpCSsPTp0vXGZeUq+ch0fo4KIPIEnYlR4aieYNpxLW/hITAaYfjdOxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGBUpdpY; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLj9aAVvt3AaDUHFN7f7HWr/LOVKfDfKKQw5+q3y1jw7QtMcqLuqYJ4PJg14cry0o4D7woovMN+gmOMy4XAoBbWjAZPrnPiKuTUJuMJ9f42CkIW5xPEsn/nAZH794cOtTvYcvhqPIYx3E9Mke5QUnXL8gpdSdSseGZLuG8chmWKPDSioOXFhqUJqVssxKOieeTL/QC8qYPPujdDj8gIv8Ix6gsOGcZ6yB4QfYb1nYx0SyhF7mNK0o2v+SgDBN/2r/7e3ugSbo+eaMVSwCledQaeew6vCk7u1a0WmFJyT/DF6McfSHEQGFiKN3VqoxIIE4Ueus7SYulGgzuHWV1y0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnPw9l+zjniQH/87hzqrFHK+NVtzNua5emkAR9VaZh8=;
 b=rMXAlqKUeSZnZz3hduAB8yYg9OPkikwtO8kSJLnd9ARWb3OGpMsN1rztWhasGO4TphydxRdVgiuF9PduJ1Qm6imy71VP8c0BjHgEcovhVXu80/5G5Yn4vKcmghfvGqTZphCk8Uv6CImBV4gYj9SHd7+GoedVaY2NtrRED3ZtCFMRtQ2y9cFMSvexfBoR4A1cO43TmwfiQquVfDBqt7AIaXAmzHlDfE1mcj4gfCQs9qUdfqj1ZdISFyAaTMiGyHu+46+A/o5GqwsUc/jjEKBOAZIf4qnjVgsZexqoQ8Hs2nbURjs5ee2ZG4KDXyCzBV7v4D/+aqrBOeXSfcjGfOIMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnPw9l+zjniQH/87hzqrFHK+NVtzNua5emkAR9VaZh8=;
 b=fGBUpdpYrq43f/lN2ldZnyS7yq6fvEnqTJxvV4W39Bt/YCDREFV3Tj4cyGZp+V2h6uk79j0Kpws25qwY4X2RIZM0xKSPUIzgLa3guEQQ8IqHitrSeu2we3/1k3tvJRjeDT2q8Fg9lQErHA+zqd/EUVEInMiwVIx5wFSY7IyqhRaA288Is8W/v4udutcpzVTOsfBOUk1QQHEVTqLoRzEIglBFYfcdgZ2XrPT+p3WOkuXTD+0E+SFjwspBKldX815mC0QRQR5n8XNi4MS9JVM2fyWrO3cdPWKUeaqqb6CVm4yw6YxGsCMORFAdz8ZEMPZ64JZrf90KgkIUfGnMoAArkw==
Received: from CH0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:33::33)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:00 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::bb) by CH0PR08CA0028.outlook.office365.com
 (2603:10b6:610:33::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:42:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 01/15] net/mlx5e: Make mlx5e_rq_param naming consistent
Date: Mon, 23 Feb 2026 22:41:41 +0200
Message-ID: <20260223204155.1783580-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: fa17f28d-f2e4-45e6-6016-08de731c2229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgXKRBP+EQAVwDk6SCW9PsVIdkQna/zefGwhRx+aT+OVU6AGfCgndUZUH4uz?=
 =?us-ascii?Q?IHdBqhW8VGnu6ctE/Mgw94j/l9EFjxkQGZSET+zUN/2NOXsmzgtWAUnJ/OEn?=
 =?us-ascii?Q?Py0FWRMECyJhbPpJzK5Hjid7YZgzFJhiWvoyP9ULiPqqVHmO/3yzvChMLZby?=
 =?us-ascii?Q?cFJUoG4YlXqPEFJQzxZrGG6sotJkt54zKVygXQU9Hd+2XUJwlAO9eAKVSmo6?=
 =?us-ascii?Q?wfXu8w2Rvcern8R8d7eMOyxKXLQYAwKwRLLoD6oyaWR8H6jLIqz8kngEsTEu?=
 =?us-ascii?Q?WaAg7eTBPa9iwwlDTsnhJVZ2F1cSZFvVmrQG5XxQ64DBUzQJI4UsZurhRLGS?=
 =?us-ascii?Q?3/I/+NXpxqACCNksUYNkMb7WNK9s88ufeyP2+0UmpMvzB/NxYekQlq7ALDcu?=
 =?us-ascii?Q?YFvFv34krsxhFbhFlG62dMFBBH/wZ1Hwg7og5V3U+SW2kpUEnd9rmQ8WtKWD?=
 =?us-ascii?Q?Sn+Z726dbNofs7ExBKhMALPkSkQaZNmASRw8/APuaQl/7tc5pubBDqyLv29e?=
 =?us-ascii?Q?8bLSF1tG8Wo++FVsogWEAFyKi15RG1Kt1fis5J9g/SvYduZr9FkPRso+sMAb?=
 =?us-ascii?Q?W8BB4XXrrgEaG7T0Mk2+MSX8LUJT0P+bRIm3azQij1MxJ3yTaCTNX1Nt/hbw?=
 =?us-ascii?Q?DQ8rTo6FYm8ppwuD1PoQX3a2rlBSnlUtafdFWgqQKSCW1VR0gUwYzvE/pm5I?=
 =?us-ascii?Q?00NrG3Jod3Z6L6fW573hcpNG1jxzWlq0oTs4K+YGcTp+N7da83Ke24Ar+ov5?=
 =?us-ascii?Q?fcO5T0Ou83g8NZQWS71qjqDucDMWGCjS3E4iOt+9KJZBWw1Ne/pXKj/0xNGu?=
 =?us-ascii?Q?hArJZeKf2oLSPbjuis65/rJCsDS+26bFngk52HNpBMLU8oXblDw/nFmxvQfb?=
 =?us-ascii?Q?WdRYEalwCHHDdf6Y/v5VoACi3fFtyBCCyaNgd4W8OoLr8Z158aA0ioAMpbKl?=
 =?us-ascii?Q?2OO1klEnQAhLlXeEJWYywhutaJ1Us38AvB87cLKsP+01mshHIugNZ7NCyP3g?=
 =?us-ascii?Q?GmuQEnV4yP/DKXH/A8qK5mJvfatK1CcwUtlZMf0BC5zf9F53hCyp61X5CPQ7?=
 =?us-ascii?Q?fwDcbXyj4QjXraEMpJnSKV/4pTV2bXIMgVNm5OSR99g9JWTOMKk9KrTrG+Kf?=
 =?us-ascii?Q?p3g4ZyyAmiOYIbhVxG5TolTF3MewKptg3TCF8w2eQdRBDJL3aOYPd1TIJlNu?=
 =?us-ascii?Q?KT77xhlNXdzMRWVH93VAp5bm7XPJ6Az47HIEkd5Mn6eJ/H55R007Wg9Zk5lf?=
 =?us-ascii?Q?ppsJ509ArBG0Xc89piWKy0ob3mUiJalyzzQH1NRUXfz7FBwOmN7tH21SJ7RA?=
 =?us-ascii?Q?G9ECspwvS3PvrIDHaplnrL+spXdJE4h1/iM0Qwb4DH2T6CikxEXVWgt+OLqK?=
 =?us-ascii?Q?Rguvi+psMSaTwoO+g2hlKY83IVjiRURdILvHwsY9s9QEDls8LJk/mKaLPDiU?=
 =?us-ascii?Q?c1xVwldwPI5IR6sC6Ex+XYUf+eis3JYMQgcdzMJEMBDSiU4XE9JkvGKizHwh?=
 =?us-ascii?Q?dfA8g2ahOirPsfzOknEZFe7or1VxVoAZXyDoucMCQbMxEE3wMy2KOFEwwzKR?=
 =?us-ascii?Q?cTdT00DOVdZ9KKsx917s8UyN5vNlKKuwD556wb7/HDnIAkfZ2KZXt59H/Buo?=
 =?us-ascii?Q?G65ICvIrRb3jLfUY2VYNWVUaAt65A7HhqE/KdmJDopR9t+wampY7t0n2FyWV?=
 =?us-ascii?Q?Kw9O6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xrIkHdlOkUBWbFXj7wlCtbBAWtfLnuGYZ3IMdVuZfS4NZmRKXdsfyCnHqPweHYdLhDRytEGQP3i14CBZdJ+Le3Q27FCKbVGMnIU/eE6irU4j41//TWwpJsKWEEkCKcdIVJHadeHuoTMI6uxvS/52SM1HGrfLLlWMMzneI0I4C2U35OjNBf8oeqRRpZJ+N+ufeEdZ01jxF70HTpT+JAIPNu9xc8cUB99IzxIy2mZr8JeQhfueepgmzjU/dwONyabePRsNwHefW0ZWB/4VsaYVwv6N8qW4fig5vomfFHsTCUaXlrlOF/p9RjIb5CpMwKu9lw5ORugTMde+TE1SCcC4g8D/8CK/EIrzAyN5uGbvF3QCGIBAThP2d5ebgz28P5X9fKWqB5wdKT7aiRme4vXBWYs9Wu+/uPn/zFfvvQc1eHD7fMo4WF0M4Mp6boEsGOJF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:00.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa17f28d-f2e4-45e6-6016-08de731c2229
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17066-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7A20317D150
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

This structure is used under different names: rq_param, rq_params,
param, rqp. Refactor the code to use a single name: rq_param.

This patch has no functional change.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  5 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   | 27 +++++-----
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  4 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |  9 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 50 +++++++++----------
 5 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ea2cd1f5d1d0..550426979627 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1060,13 +1060,14 @@ void mlx5e_timestamp_init(struct mlx5e_priv *priv);
 struct mlx5e_xsk_param;
 
 struct mlx5e_rq_param;
-int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
+int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *rq_param,
 		  struct mlx5e_xsk_param *xsk, int node, u16 q_counter,
 		  struct mlx5e_rq *rq);
 #define MLX5E_RQ_WQES_TIMEOUT 20000 /* msecs */
 int mlx5e_wait_for_min_rx_wqes(struct mlx5e_rq *rq, int wait_time);
 void mlx5e_close_rq(struct mlx5e_rq *rq);
-int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_counter);
+int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *rq_param,
+		    u16 q_counter);
 void mlx5e_destroy_rq(struct mlx5e_rq *rq);
 
 bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 8e99d07586fa..3fdaf003e1d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -883,14 +883,16 @@ static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *param
 int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 struct mlx5e_params *params,
 			 struct mlx5e_xsk_param *xsk,
-			 struct mlx5e_rq_param *param)
+			 struct mlx5e_rq_param *rq_param)
 {
-	void *rqc = param->rqc;
-	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	void *rqc = rq_param->rqc;
 	u32 lro_timeout;
 	int ndsegs = 1;
+	void *wq;
 	int err;
 
+	wq = MLX5_ADDR_OF(rqc, rqc, wq);
+
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ: {
 		u8 log_wqe_num_of_strides = mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk);
@@ -938,11 +940,12 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		MLX5_SET(wq, wq, log_wq_sz, params->log_rq_mtu_frames);
-		err = mlx5e_build_rq_frags_info(mdev, params, xsk, &param->frags_info,
-						&param->xdp_frag_size);
+		err = mlx5e_build_rq_frags_info(mdev, params, xsk,
+						&rq_param->frags_info,
+						&rq_param->xdp_frag_size);
 		if (err)
 			return err;
-		ndsegs = param->frags_info.num_frags;
+		ndsegs = rq_param->frags_info.num_frags;
 	}
 
 	MLX5_SET(wq, wq, wq_type,          params->rq_wq_type);
@@ -953,23 +956,23 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 	MLX5_SET(rqc, rqc, vsd,            params->vlan_strip_disable);
 	MLX5_SET(rqc, rqc, scatter_fcs,    params->scatter_fcs_en);
 
-	param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
-	mlx5e_build_rx_cq_param(mdev, params, xsk, &param->cqp);
+	rq_param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
+	mlx5e_build_rx_cq_param(mdev, params, xsk, &rq_param->cqp);
 
 	return 0;
 }
 
 void mlx5e_build_drop_rq_param(struct mlx5_core_dev *mdev,
-			       struct mlx5e_rq_param *param)
+			       struct mlx5e_rq_param *rq_param)
 {
-	void *rqc = param->rqc;
+	void *rqc = rq_param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
 
 	MLX5_SET(wq, wq, wq_type, MLX5_WQ_TYPE_CYCLIC);
 	MLX5_SET(wq, wq, log_wq_stride,
 		 mlx5e_get_rqwq_log_stride(MLX5_WQ_TYPE_CYCLIC, 1));
 
-	param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
+	rq_param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
 }
 
 void mlx5e_build_tx_cq_param(struct mlx5_core_dev *mdev,
@@ -1097,7 +1100,7 @@ static u32 mlx5e_mpwrq_total_umr_wqebbs(struct mlx5_core_dev *mdev,
 
 static u8 mlx5e_build_icosq_log_wq_sz(struct mlx5_core_dev *mdev,
 				      struct mlx5e_params *params,
-				      struct mlx5e_rq_param *rqp)
+				      struct mlx5e_rq_param *rq_param)
 {
 	u32 wqebbs, total_pages, useful_space;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 74660e7fe674..13add74d1b97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -660,13 +660,13 @@ static void mlx5e_ptp_build_rq_param(struct mlx5_core_dev *mdev,
 				     struct net_device *netdev,
 				     struct mlx5e_ptp_params *ptp_params)
 {
-	struct mlx5e_rq_param *rq_params = &ptp_params->rq_param;
+	struct mlx5e_rq_param *rq_param = &ptp_params->rq_param;
 	struct mlx5e_params *params = &ptp_params->params;
 
 	params->rq_wq_type = MLX5_WQ_TYPE_CYCLIC;
 	mlx5e_init_rq_type_params(mdev, params);
 	params->sw_mtu = netdev->max_mtu;
-	mlx5e_build_rq_param(mdev, params, NULL, rq_params);
+	mlx5e_build_rq_param(mdev, params, NULL, rq_param);
 }
 
 static void mlx5e_ptp_build_params(struct mlx5e_ptp *c,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 5981c71cae2d..50c14ad29ed6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -90,8 +90,10 @@ static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 	return xdp_rxq_info_reg(&rq->xdp_rxq, rq->netdev, rq_xdp_ix, c->napi.napi_id);
 }
 
-static int mlx5e_open_xsk_rq(struct mlx5e_channel *c, struct mlx5e_params *params,
-			     struct mlx5e_rq_param *rq_params, struct xsk_buff_pool *pool,
+static int mlx5e_open_xsk_rq(struct mlx5e_channel *c,
+			     struct mlx5e_params *params,
+			     struct mlx5e_rq_param *rq_param,
+			     struct xsk_buff_pool *pool,
 			     struct mlx5e_xsk_param *xsk)
 {
 	u16 q_counter = c->priv->q_counter[c->sd_ix];
@@ -102,7 +104,8 @@ static int mlx5e_open_xsk_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	if (err)
 		return err;
 
-	err = mlx5e_open_rq(params, rq_params, xsk, cpu_to_node(c->cpu), q_counter, xskrq);
+	err = mlx5e_open_rq(params, rq_param, xsk, cpu_to_node(c->cpu),
+			    q_counter, xskrq);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 7eb691c2a1bd..f2ce24cf56ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -780,7 +780,7 @@ static int mlx5e_create_rq_hd_mkey(struct mlx5_core_dev *mdev,
 
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
-				struct mlx5e_rq_param *rqp,
+				struct mlx5e_rq_param *rq_param,
 				struct mlx5e_rq *rq,
 				int node)
 {
@@ -791,7 +791,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
 
-	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
+	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rq_param);
 	hd_buf_size = hd_per_wq * BIT(MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE);
 	nentries = hd_buf_size / PAGE_SIZE;
 	if (!nentries) {
@@ -852,18 +852,17 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			  struct mlx5e_xsk_param *xsk,
-			  struct mlx5e_rq_param *rqp,
+			  struct mlx5e_rq_param *rq_param,
 			  int node, struct mlx5e_rq *rq)
 {
+	void *rqc_wq = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
 	struct mlx5_core_dev *mdev = rq->mdev;
-	void *rqc = rqp->rqc;
-	void *rqc_wq = MLX5_ADDR_OF(rqc, rqc, wq);
 	u32 pool_size;
 	int wq_sz;
 	int err;
 	int i;
 
-	rqp->wq.db_numa_node = node;
+	rq_param->wq.db_numa_node = node;
 	INIT_WORK(&rq->recover_work, mlx5e_rq_err_cqe_work);
 	INIT_WORK(&rq->rx_timeout_work, mlx5e_rq_timeout_work);
 
@@ -879,8 +878,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
-		err = mlx5_wq_ll_create(mdev, &rqp->wq, rqc_wq, &rq->mpwqe.wq,
-					&rq->wq_ctrl);
+		err = mlx5_wq_ll_create(mdev, &rq_param->wq, rqc_wq,
+					&rq->mpwqe.wq, &rq->wq_ctrl);
 		if (err)
 			goto err_rq_xdp_prog;
 
@@ -925,14 +924,14 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_mkey;
 
-		err = mlx5_rq_shampo_alloc(mdev, params, rqp, rq, node);
+		err = mlx5_rq_shampo_alloc(mdev, params, rq_param, rq, node);
 		if (err)
 			goto err_free_mpwqe_info;
 
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
-		err = mlx5_wq_cyc_create(mdev, &rqp->wq, rqc_wq, &rq->wqe.wq,
-					 &rq->wq_ctrl);
+		err = mlx5_wq_cyc_create(mdev, &rq_param->wq, rqc_wq,
+					 &rq->wqe.wq, &rq->wq_ctrl);
 		if (err)
 			goto err_rq_xdp_prog;
 
@@ -940,7 +939,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 		wq_sz = mlx5_wq_cyc_get_size(&rq->wqe.wq);
 
-		rq->wqe.info = rqp->frags_info;
+		rq->wqe.info = rq_param->frags_info;
 		rq->buff.frame0_sz = rq->wqe.info.arr[0].frag_stride;
 
 		err = mlx5e_init_wqe_alloc_info(rq, node);
@@ -1085,7 +1084,8 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 	xdp_rxq_info_unreg(&rq->xdp_rxq);
 }
 
-int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_counter)
+int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *rq_param,
+		    u16 q_counter)
 {
 	struct mlx5_core_dev *mdev = rq->mdev;
 	u8 ts_format;
@@ -1107,7 +1107,7 @@ int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_cou
 	rqc = MLX5_ADDR_OF(create_rq_in, in, ctx);
 	wq  = MLX5_ADDR_OF(rqc, rqc, wq);
 
-	memcpy(rqc, param->rqc, sizeof(param->rqc));
+	memcpy(rqc, rq_param->rqc, sizeof(rq_param->rqc));
 
 	MLX5_SET(rqc,  rqc, cqn,		rq->cq.mcq.cqn);
 	MLX5_SET(rqc,  rqc, state,		MLX5_RQC_STATE_RST);
@@ -1323,7 +1323,7 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 
 }
 
-int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
+int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *rq_param,
 		  struct mlx5e_xsk_param *xsk, int node, u16 q_counter,
 		  struct mlx5e_rq *rq)
 {
@@ -1333,11 +1333,11 @@ int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
 	if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
 		__set_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state);
 
-	err = mlx5e_alloc_rq(params, xsk, param, node, rq);
+	err = mlx5e_alloc_rq(params, xsk, rq_param, node, rq);
 	if (err)
 		return err;
 
-	err = mlx5e_create_rq(rq, param, q_counter);
+	err = mlx5e_create_rq(rq, rq_param, q_counter);
 	if (err)
 		goto err_free_rq;
 
@@ -2507,16 +2507,17 @@ static int mlx5e_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
 }
 
 static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *params,
-			     struct mlx5e_rq_param *rq_params)
+			     struct mlx5e_rq_param *rq_param)
 {
 	u16 q_counter = c->priv->q_counter[c->sd_ix];
 	int err;
 
-	err = mlx5e_init_rxq_rq(c, params, rq_params->xdp_frag_size, &c->rq);
+	err = mlx5e_init_rxq_rq(c, params, rq_param->xdp_frag_size, &c->rq);
 	if (err)
 		return err;
 
-	return mlx5e_open_rq(params, rq_params, NULL, cpu_to_node(c->cpu), q_counter, &c->rq);
+	return mlx5e_open_rq(params, rq_param, NULL, cpu_to_node(c->cpu),
+			     q_counter, &c->rq);
 }
 
 static struct mlx5e_icosq *
@@ -3577,15 +3578,14 @@ static void mlx5e_free_drop_rq(struct mlx5e_rq *rq)
 
 static int mlx5e_alloc_drop_rq(struct mlx5_core_dev *mdev,
 			       struct mlx5e_rq *rq,
-			       struct mlx5e_rq_param *param)
+			       struct mlx5e_rq_param *rq_param)
 {
-	void *rqc = param->rqc;
-	void *rqc_wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	void *rqc_wq = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
 	int err;
 
-	param->wq.db_numa_node = param->wq.buf_numa_node;
+	rq_param->wq.db_numa_node = rq_param->wq.buf_numa_node;
 
-	err = mlx5_wq_cyc_create(mdev, &param->wq, rqc_wq, &rq->wqe.wq,
+	err = mlx5_wq_cyc_create(mdev, &rq_param->wq, rqc_wq, &rq->wqe.wq,
 				 &rq->wq_ctrl);
 	if (err)
 		return err;
-- 
2.44.0


