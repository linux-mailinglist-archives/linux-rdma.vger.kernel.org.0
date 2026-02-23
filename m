Return-Path: <linux-rdma+bounces-17072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAP7EfO9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B477C17D378
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3061303E32E
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F02937AA64;
	Mon, 23 Feb 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4HVHHyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3437B3FD;
	Mon, 23 Feb 2026 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879430; cv=fail; b=qklzUdRYpmxSQY8gNyud+26WtL07lUAHt2mRsGggDewIkhFelT+ewmZ4CAuAUZUClqltpFb4bMXZE7WZbz3fwLTOTEpuJ/AyBKDeGjuYPYpwiFbjp/Jqc6FyLgbyfdPEOBHzKkI4qjA7OsuI8IxCs7nnSKXDgAvDT0qKJvSp2pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879430; c=relaxed/simple;
	bh=ORLE60xvCq9EWTDyxlMP55suW42iXWJhTE4PZJpf4bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTXY12Jc1c6NBRbQ+gA04CMShARwPeIID0/0y2zc/1cD9h5xAsFPz5pvzsohDARdqcx8refS9gzGk6W11JlcSR26dG8u7piqIEnqaV9PzAj4g3IwPEbrij2vGFONEEWMUcnW+dUa0Wq6Xp4nnWV1S1rkGaicZYdHp1KhytFL2JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4HVHHyN; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAVVU39ULlPhyUUoYiF7c6GPLJXYs/OTHXFcvaIhLEZcXs7ke57PuLzPew0CrhwZuSISQz8eR4B+Jsr9gOA3tUWf6gOcwIW2cX5Ih5oI1/FuUNLKqWQEoXejLWH340HTy7Ds8ZGo0lCZVdnQJAHEZnrqAchVz62CwSP2X2hOI17sr/MP4f8B1UgmLrBUS17SOz6zJoH7zQ5xWeGEK8CGVOTWcg/qEhmqzWezj97Az0WCDTz1lx5jRYlSbOa0IZC+l5Jy+91RY/bEYK2AKcpCeobB4qEoU3OFc4C4TzV7EHQh/GSyJRNPNd49/Kc5KFGrGM0BNCFqkNRd0p1Cm8JNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl6SDmS4pbWpuXctoDjCFLBlEFQA6FwsW8Xu+xmQBVI=;
 b=vXmqRc4tTOAQxOYTtOSRS75pD/vbptAdEmNuye3sq+9d/952B0WLZvBkdr+4Dqz1+EqTjG0W7QmhhNZf57mTp+vAjRddMdfocaAHEChhoYVrJbz16V9H6g+7R8KA4x6V2VkIyPCv20meXRl9ncZuRNYnqN797x62wZEEfLSj1VM1D67c8dj2rZEVNsQYxJNZycj59miHarCJlh8pFga3IuUwlICIWnTUpt9PPPZ/nqpfBD7Z9m4s2I5XtlK4jvUAlzR/sCwUKnps5YlQEibCF5MBU8sxyceaIfW3BOQluHI5l3lh4lUBHRRtplkJXOSO4+bhEyIhhAe/RP82XUQRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl6SDmS4pbWpuXctoDjCFLBlEFQA6FwsW8Xu+xmQBVI=;
 b=B4HVHHyNtpy/3Avs36MvzUJriWmb5BYbTv6SG8RSLoq4GfQIxUXyqLyrG0hnYLnArePCOxl0baN13AMhDtLMwu4Vb+35kmHdhyzrYwLTI4MpuFuSwcnRIUiq+7jmYJxcczYS79nGAQmuRz9x5wKM5/65pfyiYdZkK+CF2hC/iyeBwf7vgh8X8RU4LLmfqzemtKIA/1S50gYqHw/+c9FIYr4F2N48f58Lt6+Subs1HrIU8Ba591/eCQmRA8UPm6yM4tddGoA2QJtZx1zv4Xv9+JFIbjOKRHn1kIxY+bw+W19GRWOQs4oyyhWFIbMW4yUaUkOVh9UnEnraJayXLcsGyQ==
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:39 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::12) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:23 -0800
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
Subject: [PATCH net-next 08/15] net/mlx5e: SHAMPO, Always calculate page size
Date: Mon, 23 Feb 2026 22:41:48 +0200
Message-ID: <20260223204155.1783580-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 117ed158-063d-488b-24ca-08de731c39ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JFra4iSUdAO8zgx7kA+23XbcH55zV3k2ppFBahibsKFo6jDmYOeDXccgkVR?=
 =?us-ascii?Q?iHdxUBpqE4u91+7MmFeEMUtWw1WRrFZ4kLRpxa+N/z+AExN+iHRdiVM7VKFo?=
 =?us-ascii?Q?UQ1AVLwtfbpC1hwD0d6whh4A7QIfly1Dga+289sh0epId/0bndN51Xrrzjea?=
 =?us-ascii?Q?4iAHpNSsGrWsfNPFV8cBP+x2nsysy87d+4C85yVmVKP5IHI8avQYIgVIX52w?=
 =?us-ascii?Q?NtiF56T2Q50c0HhtSKRKORNt0wwefznkmWQkGUCT9dwp8QVXpLvZKqfIoirc?=
 =?us-ascii?Q?kK543nFeDHirKNQ9tk3qvBRkE59TIm1XpYiVE3QJlHJKGrIEoNANVdCJIRqw?=
 =?us-ascii?Q?y61a9sF0yzJgEOTuVLOCHV1kCo5sO+K0T5zfxuUC3JknlDnhPNtwbRKON4It?=
 =?us-ascii?Q?fBYJcxS9GcSzJJ8pYEv77Bjuuz6N/STDEEJ27dIcdY2gEv8ccf0iNcK35sG1?=
 =?us-ascii?Q?4Q5+41eKN9bC/KEj3aZeCkTNWuT9kxtal82/0N+cg1gEGP5UTbdecaO7DAnc?=
 =?us-ascii?Q?QYHGkXujGVXkOp8pWKDOfl5Om7xAIlLHQZGo6gcHciNUmIlPDCjc3bJ0SHHi?=
 =?us-ascii?Q?ycUzcEis45NBPX0EABL+Na70Oth3eKUTXF97b0+LKXMDcQAs4i9ASlUdB5u5?=
 =?us-ascii?Q?3XQ4Pzv5W5Zr2Jjj8zQxbItRqNIjaCcUe2F+06E7ldhoJmdheL08cU/AVIgA?=
 =?us-ascii?Q?aNTGUvn9W7MxEmQ9NL/6PNYA+Ea2yh2hm7rsYGaoWAb33dW9mf2mppPJmIUV?=
 =?us-ascii?Q?UheDUaP2qhKwxC+S6nY2iv3YJItBX4jkdCAhtesQRd7dQRMgrjSEOdgw3Ji7?=
 =?us-ascii?Q?eq0CIHFe6gkmTjj4W9mKPzJPsNFmznwvOtfXGIA77dR/ymH2JZC3dhXhwsO7?=
 =?us-ascii?Q?OwxH7mQdXMDX7CNodU1HrMKg7V3qkYYOH2l/GffTagnuX1Sk501EvDEqHQoP?=
 =?us-ascii?Q?mi9Y8AthDXDqT2m5wMJF9aH44GvALYLWaPI3r9wuIWn7s4joJpm2F+0vNcNi?=
 =?us-ascii?Q?a467ebN9+mU7+oXFKv/ewNGTfHAO/Km9VgqMTY2pdgH3NaZ20c/HOmV2HSqP?=
 =?us-ascii?Q?M5FHJw6te7PN+xo6FNkN6H9w4RxaDvL0dV4say+KUFaHCRxEMkTK+aSFnXHT?=
 =?us-ascii?Q?P/waC07Q3p9maVuXIFJX+VTZb5IpN610dOvRxWAY8a93/qslFxV9/4jbvBNC?=
 =?us-ascii?Q?lQKFIvS++OHo53pXZYtYdg/Bnlqh5VxvAkpA24fhwlYR2uc4fLplsqfE0C//?=
 =?us-ascii?Q?vN09rupVoo7bynz6MlsaAoCAl2F4bpmcu1OGB2Wa8oMExRxK3pc4e4ur8rBF?=
 =?us-ascii?Q?l9Dyx67cYQ0Rdmtf/RnNKwhIPrtBV/N/z99+RH/nIlCp2Vw5Wx+FTRUrTWCa?=
 =?us-ascii?Q?KfWobaYlwfBFuBNma15CdxromMfVOkE6aUtGTFLKJT17BvwUI+nmvWzDbILH?=
 =?us-ascii?Q?MsnCiB1aTzIvUsxAa+3whGjBHcGIz/XGYNHeU6IEWVDhvtJs8Gn/Wd9jE/lf?=
 =?us-ascii?Q?q8ynyWL30g17WYwkXWRNgL7Inz+zf6THMdq6XNf7UQ2ulzUdQCbuZD/9CrHF?=
 =?us-ascii?Q?roxcusYvXdU0itY7UJefeq8ldvb6J04JLQ7zJ/xpChXEdwGFsgP4eWgIQkyZ?=
 =?us-ascii?Q?TuswyiNFqvN5OsHsI9ESV9gHWga7/LdKaQHCOeJXGnqgsVZsTz3h2RoVdaYg?=
 =?us-ascii?Q?bpJhSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0tslJGv1CYYc3+LKq8JjMVF8OMhcbpHHGOK9E57EohSbxLV7OwkJxgE8TeKr7sDn2LUrgS0vo6lIKlvkuust2vrQyBjHV8iHeC8XO1qcEGNPx6Iva6X4/ZpsKUjMbxyoprij59nN0hFKiuzVHVtdvebanFH/9OoAeM39UcZzZ8oQaYcMH7+k1ZgTTj712B28AdXBqfPV/FX9Ek/V8t7d8aFEOBZTnrPY03CaFU12MTAy+PEMhMQ6Ki+30SKBwLwnbY47S4tRV6GukI5WT12dy6RFJMuuLXYMBC2xGmJfhnNpm8ly67NKstnvM1wfBVPC0QsdItQSRyiUl/uSHFGGzjGeTjP2KoFbY/P0RGZwtkN2kd8/mx5/nfuOyFfGTwfNxU+UXa5m3dU7U3DTlt8Ib78uHZT2frdfDKjbbVvpLo1rnbV+GjlercD6tUnLyi5D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:39.6811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ed158-063d-488b-24ca-08de731c39ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17072-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B477C17D378
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Adapt the rx path in SHAMPO mode to calculate page size based on
configured page_shift when dealing with payload data.

This is necessary as an upcoming patch will add support for using
different page sizes.

This change has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 34 ++++++++++++-------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index efcfcddab376..fc95ea00666b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1847,11 +1847,14 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 			   struct mlx5e_frag_page *frag_page,
 			   u32 data_bcnt, u32 data_offset)
 {
+	u32 page_size = BIT(rq->mpwqe.page_shift);
+
 	net_prefetchw(skb->data);
 
 	do {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
+		u32 pg_consumed_bytes = min_t(u32, page_size - data_offset,
+					      data_bcnt);
 		unsigned int truesize = pg_consumed_bytes;
 
 		mlx5e_add_skb_frag(rq, skb, frag_page, data_offset,
@@ -1872,6 +1875,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
+	u32 page_size = BIT(rq->mpwqe.page_shift);
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
@@ -1926,9 +1930,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		linear_hr = skb_headroom(skb);
 		linear_data_len = headlen;
 		linear_frame_sz = MLX5_SKB_FRAG_SZ(skb_end_offset(skb));
-		if (unlikely(frag_offset >= PAGE_SIZE)) {
+		if (unlikely(frag_offset >= page_size)) {
 			frag_page++;
-			frag_offset -= PAGE_SIZE;
+			frag_offset -= page_size;
 		}
 	}
 
@@ -1940,7 +1944,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
 		pg_consumed_bytes =
-			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+			min_t(u32, page_size - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -1978,7 +1982,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		nr_frags_free = old_nr_frags - sinfo->nr_frags;
 		if (unlikely(nr_frags_free)) {
 			frag_page -= nr_frags_free;
-			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+			truesize -= (nr_frags_free - 1) * page_size +
 				ALIGN(pg_consumed_bytes,
 				      BIT(rq->mpwqe.log_stride_sz));
 		}
@@ -2166,15 +2170,16 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 	rq->hw_gro_data->skb = NULL;
 }
 
-static bool
-mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
+static bool mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb,
+					      u16 data_bcnt,
+					      u32 page_size)
 {
 	int nr_frags = skb_shinfo(skb)->nr_frags;
 
-	if (PAGE_SIZE >= GRO_LEGACY_MAX_SIZE)
+	if (page_size >= GRO_LEGACY_MAX_SIZE)
 		return skb->len + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 	else
-		return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+		return page_size * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
@@ -2183,18 +2188,19 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	u16 header_index	= mlx5e_shampo_get_cqe_header_index(rq, cqe);
 	u32 wqe_offset		= be32_to_cpu(cqe->shampo.data_offset);
 	u16 cstrides		= mpwrq_get_cqe_consumed_strides(cqe);
-	u32 data_offset		= wqe_offset & (PAGE_SIZE - 1);
 	u32 cqe_bcnt		= mpwrq_get_cqe_byte_cnt(cqe);
 	u16 wqe_id		= be16_to_cpu(cqe->wqe_id);
-	u32 page_idx		= wqe_offset >> PAGE_SHIFT;
 	u16 head_size		= cqe->shampo.header_size;
 	struct sk_buff **skb	= &rq->hw_gro_data->skb;
 	bool flush		= cqe->shampo.flush;
 	bool match		= cqe->shampo.match;
+	u32 page_size = BIT(rq->mpwqe.page_shift);
 	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5e_mpw_info *wi;
 	struct mlx5_wq_ll *wq;
+	u32 data_offset;
+	u32 page_idx;
 
 	wi = mlx5e_get_mpw_info(rq, wqe_id);
 	wi->consumed_strides += cstrides;
@@ -2210,7 +2216,11 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		goto mpwrq_cqe_out;
 	}
 
-	if (*skb && (!match || !(mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt)))) {
+	data_offset = wqe_offset & (page_size - 1);
+	page_idx = wqe_offset >> rq->mpwqe.page_shift;
+	if (*skb &&
+	    !(match && mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt,
+							 page_size))) {
 		match = false;
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 	}
-- 
2.44.0


