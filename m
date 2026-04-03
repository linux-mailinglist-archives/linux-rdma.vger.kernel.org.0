Return-Path: <linux-rdma+bounces-18976-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNaAEP2Gz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18976-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:23:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92936392BC2
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D94302A501
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40323644D1;
	Fri,  3 Apr 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uT1jRJqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397A38A714;
	Fri,  3 Apr 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208017; cv=fail; b=p+4JkB2xrCDXzQ5W8KGTfaWdkTZQaYhJ8gbfxKllsrKUNDcMRKlMh9vorMx6SMFhPiqjpuvpsWQiXqVTmniJCH7l7f2p086PStRkiI8tdCIRTUT3kSSAdXngkr5Qc5ZYZ1T1CB5Byrlbha6ElpYVSodL5nE3dQZS1rvc8KuKhfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208017; c=relaxed/simple;
	bh=j7fg4+oH4QoOcvnn1tJUyLNGfjkmjCKcKwCf+O64E2I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aownydiWdiX8hebtgqYpxlIMPyU83QcpLRj8yJ4NWw99KRrRlD9rLf79R6JVBwfcwk9b85z9kWdZXrGAT2DzN4CKnnQBjiNRAk1ozFpIhck6mvRGdj/OOxt7oSCwQYM1BCX6DaUwafZU7QhTS0wfZOmkR9lYlV80vCHnkKmK49w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uT1jRJqG; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/tWVk4L26Ml67N5xHjghyKs9CmuHwviL0SchmJRZRsPt54N/0LB6ZTX4xK0salZFBghauodI4zrqKY9G3FpG8cgBp8+7wJ4X9QmbcT04FpBVsra8z8hnW8FdC/gX5lFkOrwesgdWd2lS+1VesBaPk9Y89Di7jIZpFeM0x0Zm2NHrX3t35BFdBYL7BoDAxKEqdr+16qaDyvkBEOsaF7JQuVVEbXzBSZT87k/4HUVJPdXBsxXvHx/nxyBigIJFd78lqEeSxcRu3djbszAAGpXti1/zKqJgXEGLZ2XmSvOCXgNNsZP3RyHIfC45RzESrlG7yN9CKibCfxMsS5qCr3P2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWGCOKd6ra6cR45nFSI72N++dXX/fsdB8h2K3wngMGg=;
 b=B8cb4wGxGYn6ChXIuu4BdYPtlyzKxF9LZ8oARPuDVktWZ9Sj8txx7kHXfEm9xpUj7a/Uk/bSBX7ORM+fo9YV3mNJ20SyN3MlirwWF8ts+VZZsMkmA7JBPFSnEsX0+c8LfaWqJZ8gCM18if2kXG5ucCkbOH0dqU9wdnZK6RKD2C06v30gvgeO4aDvEcxw0m7j/9HhdZc3DWXl0VvMYaApsEBwbPKsA8n4VtmzLGSHlI5xLUFYINxDiblKIEbr99Y7fTlcEzTqQvKH04bKad78/HANZmtWonbMQwpl/9b4SgxTWTpMjQ81Am9iJ+PLqQDgLAvgG/ZNanmDQVLTLPbwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWGCOKd6ra6cR45nFSI72N++dXX/fsdB8h2K3wngMGg=;
 b=uT1jRJqGruePdb7MitZRYyqPCkbdK9TwlmurAOCm7fDD/p10GYm/1RWYVw1f7nskG6GpUtt2j2Qe3bBIyPEtzE7VlTxYA9lCLt5FggrY9tpNprIzKLHhb+bDDx3R3NAgfTWm7OB2K6nUVHsXh+Exv3mHdjpjfEzsr9qqGVq9Z+e2YmvmETfOB8PKdjflDxzrRvsRL68NgaM2t4Tr+oY4nu4ZRRJ9/3QGt9ecP3lvHpgY76kYq7Cg0KtKUER6reV9fQc5SVAQe9XdsHheaHFFrtLie4kRpY0l5rptqlC8WwbaTERzC1o2pwABUGWZXBADaEIrxw4dXprd+OVEwcZ/IA==
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 09:20:10 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::85) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:20:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:20:01 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:20:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:19:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>, <stable@vger.kernel.org>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Update the list of the PCI supported devices
Date: Fri, 3 Apr 2026 12:17:56 +0300
Message-ID: <20260403091756.139583-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cec93f-a5b0-40b0-4862-08de91623482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y2ggXIbSfqS+byqwI1OW437dCIrMZGaU4cpHLLfToRqKppi6cFXsfipN0JteEMXIKcVb0pBIWeWCcBqtibWzk/EN7tH1BUPSk4tPge3+/DCYEn6pB/wjWXPgjxqSHrC/OLJBU/KSEYKhLb8Tke0Y6AB6A7EWPAnjZ36E8j7T5YLw5wGpXTcePOd8gPS8g4uCkpdI2uiam+CcBLEd60VINu2twqzfb0gpH2cFUKUYRjD6WMwh2r5xNofiM4Ca4xy1KKw5fsiXZq5c5YgpBY/sYxfE6IrJ0R/cTwwk9ArxnwZ+n04+65sg7sdapxxKNo1y8M6P34qpDnXuaTCcZG4e7HWY6V6BLcI/5YCINpilk5uuOAhqgfbAD32z57Cy+XGRWIij72rTnkNXrGGirDvWZ6yo2PYDCrFCJdAfHmOa6L6ftJ5QURL3zX1/oWkBvvl75jDUL7+hklOhI2yyhN9f3lbwk2/KCT1JPT7Z0MWoO6/WpumwUNxGjb39Dm97Cu9bWS5a4Gm7p1K1CbLgycIpRtjEcAfOJ5kEPTi9n1BFZIP1riX3P3i+Ii9PJXfmab/mVtLVtyrq5hggUdMxzzWIYwDNVwgpj551hkzG5yky7J5EQJkPYELoHACCjZ8v0S2+OhuhRFcsXxMt6jOmTSKFuxAL6nzJg1ORJ64iEwdsvmH7d4KxqjNjrXM01R8+CYToexWMTWtb5zklV/5lMk2dTyinJ8CDTnP569+qBKElTyJxf5595XUJcU0LNt9D6E4VMJAu5HF4Cs+jN/L6+nBYWw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wMqtTVYEKKgo/OvdbVptL70UZTszW6uCd6/+hdZtqg8GNCmqjBC5wWSl6gbVFdHcMmBD3OT9wN3ZrMgaQqTYjek9apOHXQASdqePEwxlupABzOx19RiLGZtByLCMEYbRry3NmnFKVU4MT66wB8WsdSde6hpwksYkEDmqF/i9imOgV4Om/JI5q1rd1GAUX562Jgvs0xs6JwBibvaM8XIjwpndBMj88XYvevPraLyntKO4YZ2R1VUmlZHhs2enfmTKHTnmk/i1Lx0oLe91vZf613ggXKgmv37SwbixIvXVUtObIeHhJ7LbSJrlCVmTqdr0KcuThRrr43GlaXx+ve9CKSaRPZOwUiyHFx/7nifqG4chYDcJy121V0/TQBC4dzIuxvEVBQmGev6H9WX5idow95oWW5YbMEiOpK3ZKr0ojFL94yu63zZutVeGDlQtoNyd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:20:10.5321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cec93f-a5b0-40b0-4862-08de91623482
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18976-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 92936392BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Add the upcoming ConnectX-10 NVLink-C2C device ID to the table of
supported PCI device IDs.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index dc7f20a357d9..a8fa85430e33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2285,6 +2285,7 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
 	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
 	{ PCI_VDEVICE(MELLANOX, 0x1027) },			/* ConnectX-10 */
+	{ PCI_VDEVICE(MELLANOX, 0x2101) },			/* ConnectX-10 NVLink-C2C */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */

base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
-- 
2.44.0


