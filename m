Return-Path: <linux-rdma+bounces-18972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NgWNtKEz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:13:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25F392A86
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5160930C8DC4
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6888A38A711;
	Fri,  3 Apr 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9RxoFCE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EE351C21;
	Fri,  3 Apr 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207443; cv=fail; b=flbuxi7jhsF4vMhCfTNvXmLCfMyrQ58K8oUDrbBUuVLi6FnvTuzgP32vq9SJ+ERzvpCUSC6O5V4/95D6RvRIF+kA2QM8WF8ieHRJAOdrrHdfzy3u6dPZQrYuVQsamLUw+LfhHrn57xWr0sZi6TRzqZY6D49vYKxfEznxHpzKhaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207443; c=relaxed/simple;
	bh=3cLzeTQz+axIu9ibQmftIIT703GC8m4rlrkRn9/aDJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcikJndqgvChFrYOXVbV/tx5BwYIRa9LAMQL3b1z/uK0TeC6yKZ76yNxvNow3Rx4QzrnjL3rEVaE+qmckp+ZwKQFngKG7/kwsp8MIoIqRmH86Yf4+oHM6j04k9ArUQagIHIZgR3h1/l8a105iZ1OEU2HjWDC9uMHEfwsMqvc02Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9RxoFCE; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIouTOlEK5LUx4Ki11ePv/JAl7iTJ2pPNq84ZOOwIKIs7DWGjX2/17U67O0feluRZCtowoTV4TaGsd6DdKLfjTpBRup26qALkvRRoslvsdcOxMn5+KoeTf3SueTngR6IMt2hUWw9FLD0OL9eMLbe51azpkqqzrMOXcqk12/Eedipzja3ZPhe6CwtFxVnDNk02HNsnIAdWlajv9+q+SRKtzxq5hbLa4sLblp3mM62v2/0Sp3z3VWlOTglP4Xi9dMLoGE1mLE5EdYp1nZMteQCaiRl+JYg+4SC7kii2E4A9d01mEoc3TqMs0Nem4AGYzu1+Onx9t+0Xb1cOXTugJ2WCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qONcD78g1HSL0+uIWC1etG7mC+rtyWlq1dGoNUnGo=;
 b=OjKQ4gKJiyJJW6yfpAJ33CBRYNedb1n4FjGymSFFzknfp1NB5v0NuKacEuxh9YsHBENYiz/bn+uPDmbRQ27T6y15eVkHHZ+6bcaVg/Khpg8IIiC5/gQPmrrKXO1vNfFtJl5WnJls6y4OJsY0C7xxrsuH6HCFzuTzFguxXZJbPJdPr7Y/UfSHsXON+YTiJVN6QixJGYhfQZLxeE9yhBvJTPuEZbuefEbaanoCPBKeHRDLWrzB6X9NnfhexnGTdyeba9afmxuw3HdNm6dNks8iaMBb8UnAswXiYLhIF+QFclUymwZ5H2BeCN6WxN/cZrbsbTdrSghKE54AN6lYKzqJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qONcD78g1HSL0+uIWC1etG7mC+rtyWlq1dGoNUnGo=;
 b=j9RxoFCEUwyW/CvEyF054mAaDBFPVeYe3kGN4ueQtGnguhwq0grxzcM7gl3NGs8ZJKKS3fa6caV0q/8hgn9Z5n9j4Th5Tp2+Ie0f0AEOzsEiPvUQhCfAND629fYKltGmsKExl9vmWSUMeBbdAZ8Cw/EQSeyt+tHIDvQ0qVheB1gtu/aa9Kpb6pFKiQs9WA4NxuwqVI5LdHtGaB/m3BJFVG/JFNmRedAA/9W9P0DGk6fpGSyqk7JZVZQutdb9wW1aB7CxSAD3FgIJVH24RyL1TkDaDwbSd7mACzkJ+YnkUaFIRAuHeo17PzEaTTV0HnuHMQkOBg86SIoel7gQ/Jdscg==
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 09:10:36 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6a) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Fri,
 3 Apr 2026 09:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 3 Apr 2026 09:10:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:10:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Dragos
 Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
	<horms@kernel.org>, "Jacob Keller" <jacob.e.keller@intel.com>, Lama Kayal
	<lkayal@nvidia.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V2 2/5] net/mlx5e: XDP, Improve dma address calculation of linear part for XDP_TX
Date: Fri, 3 Apr 2026 12:09:24 +0300
Message-ID: <20260403090927.139042-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090927.139042-1-tariqt@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: e54f1a06-4f6c-4702-7f8f-08de9160ddbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YMNwlsnT848i/ZXCFsW4OfMTwWEwp5hZPuohrGS0r70O1A1n/KvvXiQGzPZoRZ12X5xU8m2Qv5fouCc3IpOx7Tat9+l1AQMA/QUAhshNiqOnP8vhpxo3vMpyVG7XBZ84Ki426NzuSmw5asXw9MXsQ7Qc5kdkj0qiAbqqDNY56cN+XATzC6pLQFd4s7oadQs/FVsQGiE3UeLtdB/wmm7HSQb6siFZFw+HY9oQEsStEQPFRZUxgmtnEbjVEXumYEPvHffYQZs8+P+3Wn1JbB9cCPB2S4tDTq03Cj9CzHlkK0GjEngKF6tx5EhgUypS3XxIRWT9lWTbzvrYEXpS+yCbCNRyh+Y0y1DIFZ6YLVknHVgBQ7MGA8Mr0p4Ox9+1Eea5R980JbaS5DvRLF4sglaEYJfbB3etk0X2ah7r9rDEMzbbYn63jrZZdVYNqw9CfZisbSWRP70fzqKty3KJeW/ab7K6DBzqRVfg7JEsQ1KsUtNZpxdw2x4AqiBczG94c4DY15UnY3mnGKUHWoH+C0RhfsYXX2cVuUujEoIL4Ylco5D75dJTd7KAIfCuKHg4AIAd0Qp6y0nW0Opf4IDOQXKbSO9TgvhUevl/irx1PbRvoCrBumpQ9L2Fw6YlJVwJ/+ivhgtRjqxvaDZO482sXbb87b1wOyE7vC4zZVgXXJEAN/xXGkPvIZJoUc5lJGJIIMrO+KpMjratnv2VXjs6q1kOlkORkzgrSQaGWhwBqgNVhmlIXRzNcfEmEd36rKujK6B/jYlRRErTEbHh/PbORJOG4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zf2iqqAzP8meeaBVOAbTz2ZNdIijRdxikqHzYtTVAJW4ES/QCD6eqdSCUgedQo9JBYMEjBISQz1RYQC0Z//lfAvMIPt62QZfBlSvQKm55WbdIHnLqU9GyzbqiIVrUsN0Qjb7l8pNSxgm3Zg1Yt1iQhczgU9lZxgiXxOra0Grvpu68ukCe4IkUJxJY8LIVRJAPnfywqEZkYgZERN1uzcSpeyoEr8Kouax1FFcRmsYYH9uHHuHm9tcfqqHQIOTEXHsg+iG3AR3Clj0OuIqp/Jlji78sr5Lb1tc1ZXXETCu9s2oIHhVTVggF5phofvtOkp0tmmcnA8E7GFKGmstLie/1pGbhvY3IY3/y6Kxz8HLQhZj4Q05JRv47etTev/ujtsRLHggb/3BVeeoOFK/9+57RkjDEJ+X5H/k6ixf5cCRjsUtB86a5n/mbq92dedj3OsD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:35.4754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54f1a06-4f6c-4702-7f8f-08de9160ddbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18972-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8E25F392A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

When calculating the dma address of the linear part of an XDP frame, the
formula assumes that there is a single XDP buffer per page. Extend the
formula to allow multiple XDP buffers per page by calculating the data
offset in the page.

This is a preparation for the upcoming removal of a single XDP buffer
per page limitation when the formula will no longer be correct.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 04e1b5fa4825..d3bab198c99c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -123,7 +123,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	 * mode.
 	 */
 
-	dma_addr = page_pool_get_dma_addr(page) + (xdpf->data - (void *)xdpf);
+	dma_addr = page_pool_get_dma_addr(page) + offset_in_page(xdpf->data);
 	dma_sync_single_for_device(sq->pdev, dma_addr, xdptxd->len, DMA_BIDIRECTIONAL);
 
 	if (xdptxd->has_frags) {
-- 
2.44.0


