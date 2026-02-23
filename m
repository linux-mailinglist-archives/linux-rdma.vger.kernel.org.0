Return-Path: <linux-rdma+bounces-17078-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIh2KVa9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17078-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:49:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4117D2CE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54768307F355
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEF37F8BD;
	Mon, 23 Feb 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgXb8noT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49D3783C4;
	Mon, 23 Feb 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879480; cv=fail; b=C2ZpOY3h7ZU2GspxMThw8+TExFJAElJZo/rcBRsfckT/B09xRNRjRRkUVvjV7cPlLlu46yI7rrCOIz1AozLQan4F5AOWgiC7qr1C4Q3kYkvwBW+/oTw44agKSSAxqWQ90HytkMlyrSbOU9yelkSzS4eD5vb7xCdGiqCxGWGKpfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879480; c=relaxed/simple;
	bh=7SrZnD/ACrtHFzZJ9goNaEAAMqBvh6uS+fbuSrxdGak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abIPyymSBe/+q6S5NHmfL2PrP4Eh4v+6+cx61+9mheG6H7ka+ozSr1MJD8+64Le2rirG3RUhEvFj0vaE67I/Zubyrgg9bQgKBsU9mYEN3qr73FMAtNOxPN38GJyYblt8GY5Yfrty36P/82GSeOZATZFpvBdpCbZWEa0sqEbGmPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgXb8noT; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT6FvQIxlQ8AXW1QkJ2074KsObrFnwyjt5cRluZlRgNhUzEPWG2q5quKCzXuCd7cP1/Ym6SbsDkUIbn6ECA5ZfVCI0IqNcOv68ui54sumkkAB7Q4UymldtcBSppMN6i87gJxO5plHMJY3/gy/htdGb6U703eKMpS/VAjyqM3UyB4YRkaiXyVwwKw08tWVv4kghQA3mJkpADhZPKlcNtBaMGBXG7kd2es8ZEMDi+T3vxzVCX8yd5AhS4buC9TkEtBOnkduV1ioEY7UXyxYve0N+RUQvIP/6lpP2oaKvTlehRPazd5ho0Bd3KQRqjNYEggHkk31pNTUnDieLi4+9fwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSv/PvjyA836ZBIqYKg7e1URlAbh4Xst5CEZ68eRIV8=;
 b=oth8apcN6ptRTSTxgDFfcAwhGUqjL6u1Z9pJfQkbfoDF+sUkeIUktwePj24RfJjqpQ8OG1YzLQo1Im4KZgDhi5LRDxks6kFD936/38qgbK5XLLDvyUUro2SuuTo43FwPsdmD2ZBjCtkq/VboBROqJi8GZbiPGf425EnqCaCeFFdgS7J+G0z+u32Tt5NKJ4TTQIWoCSXal+WHSMOYRm2J9xtaczz7jDt2SZu45oCoi0hCYkql5dxaigzJlnyqh2YJ7NOLiYUaUH3fT37q2N3sYGj+vUjbr+nFI18Sl/bFnuyKqPK0GngaGbfDwMpN5CfS8uU/NEMbHXfUGy7sdWPB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSv/PvjyA836ZBIqYKg7e1URlAbh4Xst5CEZ68eRIV8=;
 b=sgXb8noTW1l4hfrQ1Ia7sG9gfT4tPKLiU+vTnpvVX23Yr6Vf1GLAxZhiDOPHAas58jAhyB1EWXMTu351S0pHLBcw3UPMCXQGLBF611fi1jl4qANvVELG0PLfXpSjwiZftmMyIpmQ9ne84zOwgXuvJGriDk7ISzqmoHNpkAx0HidKtduHTB/FdAnkivGzi7O3bcjUP09zLQDXxAg9SefsPsgL/J+ljU0sFRznO0PdfhgeK/0f8QQ9+soEL+Ulf4Fn8rxUbyKnXi7T4h7CGf3CHldragdu55ZtRT8YZbCoxZFe1bgeYPkDHyZG8W5My9A8hqTbRgjEEu828ISNONVesA==
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:44:25 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::d7) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Mon,
 23 Feb 2026 20:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:44:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:08 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:44:08 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:44:02 -0800
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
Subject: [PATCH net-next 14/15] net/mlx5e: Add param helper to calculate max page size
Date: Mon, 23 Feb 2026 22:41:54 +0200
Message-ID: <20260223204155.1783580-15-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a7b956-685d-4a89-aae8-08de731c54c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hHSdPrG5rcXbk76w/SyWgKIq9qDNOgXLKvSiuqY9TxIXMpP8ZgIxX/Idl2yf?=
 =?us-ascii?Q?xXw6oVZ9sc+tdeucZ0XErYRH8sHs+CwYN4x266mGxhjGG22Glm4ZzuJIzt89?=
 =?us-ascii?Q?jszMZiir1YkKdDi8bLHxtI5Rss3O5YXTVffs2NePxDmjCojGkeGscYPPWIaU?=
 =?us-ascii?Q?7V2ft6WgQtQ1ebkM5pgA5ukupOLb4VjcK3nMXp7uufYiEK2oUJbdzjDEsvt4?=
 =?us-ascii?Q?JiyXgEx8F3IPzQcAbNP3ykMgt45gaIV3oKjfeEQTC/aFlZI00JalQZWvM4P/?=
 =?us-ascii?Q?bMv/vS4Uk0Dfw3WIhNeA2Yv8+IX9gXrgaZ1qbVNytD3ZlgkpX9wMMIxhcbCi?=
 =?us-ascii?Q?4e08F3u6MP+gXvHNM5w5YcxSRoWfEJ7sf5U0Kwtw9fYRLqxDRRWojEmFQoDb?=
 =?us-ascii?Q?6iGxa2MTi2JEm9x7mhvAo0T15ozGbGwgOWzD9xrIDC7XOsUarTUvhm5gZV0r?=
 =?us-ascii?Q?QMmieCtzSSdTwPx66bKmsECZAMdlUqFjou3uj5DM8pX8x9CvP+yqoz/g2lLY?=
 =?us-ascii?Q?aK6o0or9qJp6fjuuXPA0HvmsLvNcmpicCgYCOG4c1kNQht8WZ8PCasZk6JE3?=
 =?us-ascii?Q?L+v9oWex3gDWtiMs+r5hqXtaSpH+pxJ5j/bIx5g+jh0Ff9VznfOQSAEyKpzB?=
 =?us-ascii?Q?cRL1DEHro/4qv77jSkPUgeI4iood3tLCBnrdtnhOkhXjsaro6CIwxQG7JBAA?=
 =?us-ascii?Q?Wch5C+O1kDgjGa0EAbGoB6GscYLC2wAiOa5il5KuPv9Sg/jZVj7iDRRt/GVs?=
 =?us-ascii?Q?srKHTzlkuNdOgKDqEuPai0mwfQnf+jPa6CL1W2u5X51KS8k7HutESx1CGzzC?=
 =?us-ascii?Q?YJBTHwFeiGyGz5yaBonzYe06geAiNXn7uyznGg0eGhIARwZMVOjG7SPLzDkU?=
 =?us-ascii?Q?hjdbu5U8lIzCfhBYyW76u+/84utwxkpEkyDDrzzguP9+6ECwC/Mwqsrc6o8g?=
 =?us-ascii?Q?Bhcu82VRad9KitdDvfI35MSx+GA8Z3mRqQ+p5XTjfevfdnh5QhWte6B7rPbA?=
 =?us-ascii?Q?r21WvV207T7bjFOdyknDZIkEkORmRrXZXTOrHIr8Y7oBBft4bhThs+IMNLte?=
 =?us-ascii?Q?qVfzUlmQFh9XBJTnWeWpwF9xbVIg4NzmsPcSiYQQ5TRWTYO8YhOZXmAvJIbO?=
 =?us-ascii?Q?CIL040hGrBmFAc2dDj/OOPG4fydCgWu1Wmfkm/vx3ONUIuJSvYOTNyWnDpLq?=
 =?us-ascii?Q?4WMoY+tm08E9CeLJrm0oXdHK1wEGYrZLoUkZiOLHZ7LsNxzmz4njdgp+2/n0?=
 =?us-ascii?Q?nblnuLssLIR5hJ+uamNUixg3SYR4iVT37TjINBV2tLlN98wm1X056x6EeabL?=
 =?us-ascii?Q?3LpqZB6MB5/ghZuiasHLHY14zZZqN/ICTLCY4HCGB9ivE1UXIrRfoYH796n8?=
 =?us-ascii?Q?EoCtMhozjWapoegX8n6jk60VRMVNllcFu6aZKDS1hvSiob4SfXbBgnFb8yli?=
 =?us-ascii?Q?FxnFWhNguTLrYa4SUvMRatI0E3yNOCyH6nGCXzdOeG/qGXF4Y8HEcrTxffxn?=
 =?us-ascii?Q?g0AxGKpMe20TvirqUOh9SvRq1nbSP42Fn3gmjCSzd7eIh5SpRzsKnXJidDaf?=
 =?us-ascii?Q?MGl53yeQB9Y911RhV7Q0N+9Vj2xjAc7sh55VD+zIDwgpQIdotIKM3s06UoGB?=
 =?us-ascii?Q?M0wXVEA5PjOMGoPhHLwF4L54WWMnAYc/QzNYJfi+tnEU3n/jJjCBWtaAESbS?=
 =?us-ascii?Q?tioU3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XDfcy5ZpXKqUDU2jmqUaON602js/nH3OWFGE71849Vm7XRVgmqpYbttas/jsCG5EUMkvMJHom6K3gvNTHB33WXznvbCJy9klUNHJHW75nOyBIReAa6U1TdcP/vXbfK2KSlxNoWp3UJReArbMCjos6o5aIxpIUOOX1slNIUTxEekBXTjtmwcK5PsEl/tLdAUu4TOmz1TUsGgscx9Igt1WznMsUedUVSMFTrJtnxG6rvc7uVGbuV3gYWpQt0U9eRVPRbVjvc2ErCx90usRthIy+cnHDhEfqW2hcro2sYyHPAA1WTlFPlEFajeUe4s2YQLe0fgaLpLNYDWyVkedgdz+zYI6eWypWmyJgR215gUkOEWhhy4nveUn5HbOLhUK0nnzedfZbRE3QSas7eH4zO8Wk/2F0RrVAGz0ofa8PYY9wJmzrHkyr/f3Pxm0z4DatSt/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:44:24.9587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a7b956-685d-4a89-aae8-08de731c54c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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
	TAGGED_FROM(0.00)[bounces-17078-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 62A4117D2CE
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

This function will be necessary to determine the upper limit of
rx-page-size.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 12 ++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 304b46ecc8df..26bb31c56e45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -501,6 +501,18 @@ u16 mlx5e_get_rq_headroom(struct mlx5_core_dev *mdev,
 	return 0;
 }
 
+u32 mlx5e_mpwrq_max_page_size(struct mlx5_core_dev *mdev)
+{
+	if (mlx5_core_is_ecpf(mdev))
+		return PAGE_SIZE;
+
+	/* Two MTTs are needed to form an octword. Driver is using a
+	 * single page per MTT for simplicity. Hence the limit of having
+	 * at least 2 pages per WQE.
+	 */
+	return BIT(MLX5_MPWRQ_MAX_LOG_WQE_SZ - 1);
+}
+
 u16 mlx5e_calc_sq_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
 	bool is_mpwqe = MLX5E_GET_PFLAG(params, MLX5E_PFLAG_SKB_TX_MPWQE);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 5b6d528bce9b..9b1a2aed17c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -121,6 +121,7 @@ u8 mlx5e_mpwqe_get_min_wqe_bulk(unsigned int wq_sz);
 u16 mlx5e_get_rq_headroom(struct mlx5_core_dev *mdev,
 			  struct mlx5e_params *params,
 			  struct mlx5e_rq_opt_param *rqo);
+u32 mlx5e_mpwrq_max_page_size(struct mlx5_core_dev *mdev);
 
 /* Build queue parameters */
 
-- 
2.44.0


