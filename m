Return-Path: <linux-rdma+bounces-16417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APiBEakgWnuIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:31:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F0D5B57
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94B7F3008C25
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E6392834;
	Tue,  3 Feb 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krSxlSJg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA521146C;
	Tue,  3 Feb 2026 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103871; cv=fail; b=Tpb0ECLeXbvDaRptN7fGU3acK6e5Hflo3pqCKqULklU1z39Wb3mNxnRW6aiEPBZkLYbWcKVDNjBguhL1QOHQp6z46qnVVLwNt/iSTQZuFJwwFBMEFdVyEV8BSzRPMipvSjbfvVBpAQ4Q4LmfxT7/itiHciDx64ZZHX2lkF+hXqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103871; c=relaxed/simple;
	bh=ugYKKU+qAsqrCdkgAwydNnNKNrjcfYOtyI6LlEJ2JQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgovHBAKqpARFZw1J4CXSzsWG++pIoMpiFqDbxAMjQNXDXqjsTj/JxAs03L7WxOLRsS3PxWMxwZv77dpZouaD43Cdolcn5fMZEOECKbLJL29CHukI+1dIxaW3xiMzoeuyktmB1IvssvkxnpXbsb9mPz3TB2OhLGRG2SAhcSQwXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krSxlSJg; arc=fail smtp.client-ip=52.101.52.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0lcEb4aRSGf3nxvZ9W8p+O7F72NNLQu4b04bV+YUxwzD/KA2M5wYVPV+mScWstx7VAA4Qc2sP8KmT7WO5HY14/cDSHNfX7jqli95x/qZohb1d3Fxe/ogcCv1JSGs84xElZW7uzyWJPOJaw1pMIyMxMezQnqm8n5ghkfw9T34cYqUKTUnpOOJns/3x6jbH5xvw5yygIFjER5iejUJ0k9t4KYFNBPkPuroqDHt5w+dV1W0ezcbRKPL2vEQVxlJiVzqsZM0QCw8J8sZzUUVZkHlx7SsBdifjCl619daxn48QZQeZ8pe2nSM4r2Q/qNAhUMOLVPArlabPM+qyKRQjRsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htwyLpzhzWDnl4hu+U5o1v1bxCHYer5GlYA4+K1sHMA=;
 b=C565btwgcJ4SmE3Vx4nUo10s0Lc9/Do5784yURvGSLbwA7zh7ACMkKok1g8/7dsf13aKzeXAwBwcR4gbZvkuvNYLASXzu8fkKHb5wiG53cL1mbG/+iZq0EQTSo4niaTaQUUsKyv4+7E+q59a4froJup+XP4iIl7cFr2ketumhNYVK0gdfqCxRVatWKp4nu5451viNRwP5ykiRENyROUkpj54mtj8WLfCcb1hXlX4vZ1oCtVQdZ4y5BZALQrX6hMHG2VKbKE+/YlyJLqIRyzTvG1dNvCTgDM//O2MKXxOnMHoe+RN21zaoER8mbzuEv3ofyNrpQ3jgs/Tpi/ZkKjipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htwyLpzhzWDnl4hu+U5o1v1bxCHYer5GlYA4+K1sHMA=;
 b=krSxlSJgDcrHxaKP1UbbR5haQ28kWxE4E5xEx6wMAbYLmn9XRnQKgJSp7tYWwNOSXUU0jly7CKugmm+UPxT06xAwv/H/FBYg3KPdiTqCyf/0k7l+YE2MN3cDUaX3WIknHhOy1X19eFDBaBsgLgTJd1Edi/cQpxe/nW5jh3fz7h3zlivhQoOGLOrw+K0YnVHs2FPX0ixcZtKrcIqr2su2eJGfpgkmKTBzeV7ZK/gLc//xI4UOrnSYcWY4arG0RC6eq4cjXwOO6/KNh6hvifYTLe/bxc0NrbNk74BDvZ7fTh6S2ivGyfXFP+l/7Z5zZVk0wDIU9Nx4YuxB+yu8wCc2fQ==
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:31:02 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::fe) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:31:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:30:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:30:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:30:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Extend TC max ratelimit
Date: Tue, 3 Feb 2026 09:30:20 +0200
Message-ID: <20260203073021.1710806-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 40abe4b3-fcd4-49b3-3bab-08de62f62e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y7VDyG0NcrK5l3Mi8rTcanz0ehBtHk/Kp7yez+K3gmb9TxPJyi2vy3rbMHka?=
 =?us-ascii?Q?aeBRzgQE/C+zBZ8bH0DgAHR3xOw7amlTXFw6EeAgE43+9iAZMy4bpT0oTM5r?=
 =?us-ascii?Q?JgJxJ/VP6XZnfngB60Q3dca8EEuzV/AY/gx0OuU6cgp+yU7IB1iczYiJohU5?=
 =?us-ascii?Q?wypKH8G35iMJdgexWgoX13udAeEpfhoHtWfzzI0utOoc2GRjNFjVoCunKaeS?=
 =?us-ascii?Q?hmVVoUPU5rV8nMzkQ4Xy3bRLhxk9kmOhZWwb3e06k0f5gx/cgCQaQBIa5dey?=
 =?us-ascii?Q?ysTfUPCUN55b+9cfnUDnqH41Zspmw+puqeXsxw562d4K0TT6hJ27zJRGigHe?=
 =?us-ascii?Q?yxkRuahzSW+PyXmd8U4+yTYXVQ+Lr5FFh6or0N3bdJI4EGp3CWvIz+k58heO?=
 =?us-ascii?Q?lutwjLbelpQWonz1xMys7VUw2uS2lH5lKed7t3qqdxOXwyTRjF0U2OKekmEd?=
 =?us-ascii?Q?eNfMuCQrM2zOes1H3bagStp9dAuzvZM7Nt7z+WCmj919oVHAjNxa6noqF2Hk?=
 =?us-ascii?Q?lY5qFNqllOiaJvcNUl3i4woX5+xrmKkpgq6PNxZd3h6DNyuqbN4G76W5XJFL?=
 =?us-ascii?Q?hWvWMrN3bpRs1VRH3mEQWB3ZT/U67Yl33Q6nCoiAOU/O3B9SAlbSUowRuEyH?=
 =?us-ascii?Q?DJI/+haZz/G3vlJGhA/dbU4OqVeEXdUmeqHC77DiZ7z+LVeAvNmYcGgd0ORv?=
 =?us-ascii?Q?6cdxE/4urbuDhd8kHsmHlcN/DtVfIdDQh2CKObNfVMUGU2lsc/k/UG/E8eef?=
 =?us-ascii?Q?0V5Z7Y2XDKEpef+Fb1RiFIxAZooJkX8YTvLbyAw3pdIdxtPVPQZ1UfKuoRyZ?=
 =?us-ascii?Q?hTG6/Z/ggC3wHnLelW0jXtsJ9lunUKmpKWV1ykMGqGZnTGFmk56XZ1I+IoYr?=
 =?us-ascii?Q?KyzAdA0s7MEOVoTnj5gNP5Ec0SkQJiRRnfVYAHGJC9hj+966Xvdk0fZlZUcA?=
 =?us-ascii?Q?7ySG57zrnUZPIn6jLCba4KggQJbEmk/2j29KDHIO0k0A80nSeQdcH+z4JZH1?=
 =?us-ascii?Q?JJi/j6NZVvHCMHjkoF5pZkZVlvvt3rpdo0opw1jPPyb8y6mPHkZAARKDcJ+A?=
 =?us-ascii?Q?oLWRM/+k3J0lsie2UEFJ5KVd88PWVqU9mPIf7fI3WGbCQM8V4kk4Xzt77IKs?=
 =?us-ascii?Q?V1NqgvGaSd3Lm3+IQe6JspoohinOMzCz7lQGGRFLuaMsLKtCaLd/4ekG/7wL?=
 =?us-ascii?Q?PXKTwavVoUvIdL8Qy0Qmt+5bplGk6WL48XjXOvt0uTW/OFvEHUOYPjFv8BFr?=
 =?us-ascii?Q?v+QNrIIawb2xKuWO1IRaPs1pk1T9Znqog2dlkI8DlUxfA6IZxa6WfZypQ/EK?=
 =?us-ascii?Q?FSc/ldawWH7UKwieCI8jeyQ+0DUEmod7i65N+uy3ycpHySg5DkAQKIVicSMk?=
 =?us-ascii?Q?1v8mCjvfmD20WkHe5BLXklWAoN2YXO7yPNtmN2u7MbcR0HeTQSn9K0gMl7Tk?=
 =?us-ascii?Q?guU+kVmqYb7XCI3PU7u2oy9kMH9nPLIo3ZvfUjNEzU1GTJQUjpkkNiwrJhHX?=
 =?us-ascii?Q?iiG1EXMTMdDXF1LVGELC/akDyKX610JQO7uc4dVDGMRefiThyMddCDE7Y9Xy?=
 =?us-ascii?Q?QUTx/3zydgi6X0IsJ8VUMdaKJCS8ClGDSzel/Ril5pALJUX98jk+EMBWNF9i?=
 =?us-ascii?Q?4LUlWy4anGZdiqIfhBuMuBJFkMsUMXyehIJCk06Dme/sMO9rGNGR9rX2m5xS?=
 =?us-ascii?Q?/nCD3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nShIYW4BXMh/oitAXKlD+UcOGcH5tBTd7WIyeswomSdzxudE+cZWYQr+2tr78jcDVDKYW3jrLnpTNnAkU834OdkTBQFrYV+O6P0IV9GwHh8uRkVWqZ9qbTm1zNoqP8WjVp9j0DMASA7N+MDCxaPZM7x5Nfn65FV5NY19lYM9Guw1qrCMm8jnRmY+enVUa6oPuigpwHUCey/B4CqBgdUv7i0RQGrIe6B/a1PEQ7nr1yhcZrUhheFgEsfSpjDBk/YswrSfudqZ1u7acM5iRWgUN9Ip8dei8GBA16MRnj14hFxDzXQueaLQ/pYzMe8mw8uWiu5DFp02yiuX/MDc7QQ1g/SZj0oTwTY4yBUdR25HfYYUeiDKxMMxLjxLUXPbagPdL512Haj6b1F27U8MoQdHjgPCDiX32Lm9FTtAG8cXoEyo5HHxBky2YMpAIkqa46CS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:31:01.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40abe4b3-fcd4-49b3-3bab-08de62f62e93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-16417-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AA8F0D5B57
X-Rspamd-Action: no action

From: Alexei Lazar <alazar@nvidia.com>

The per-TC rate limit was restricted to 255 Gbps due to the 8-bit
max_bw_value field in the QETC register.
This limit is insufficient for newer, higher-bandwidth NICs.

Extend the rate limit by using the full 16-bit max_bw_value field.
This allows the finer 100Mbps granularity to be used for rates up to
~6.5 Tbps, instead of switching to 1Gbps granularity at higher rates.

The extended range is only used when the device advertises support
via the qetcr_qshr_max_bw_val_msb capability bit in the QCAM register.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |  4 ++
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 66 ++++++++++---------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |  4 +-
 4 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
index 2c98a5299df3..6bd959f9083d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
@@ -29,6 +29,10 @@ struct mlx5e_dcbx {
 	u32                        cable_len;
 	u32                        xoff;
 	u16                        port_buff_cell_sz;
+
+	/* Upper limit for 100Mbps and 1Gbps in Kbps units */
+	u64                        upper_limit_100mbps;
+	u64                        upper_limit_gbps;
 };
 
 #define MLX5E_MAX_DSCP (64)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index fddf7c207f8e..4b86df6d5b9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -58,6 +58,20 @@ enum {
 	MLX5_DCB_CHG_NO_RESET,
 };
 
+static const struct {
+	int scale;
+	const char *units_str;
+} mlx5e_bw_units[] = {
+	[MLX5_100_MBPS_UNIT] = {
+		.scale = 100,
+		.units_str = "Mbps",
+	},
+	[MLX5_GBPS_UNIT] = {
+		.scale = 1,
+		.units_str = "Gbps",
+	},
+};
+
 #define MLX5_DSCP_SUPPORTED(mdev) (MLX5_CAP_GEN(mdev, qcam_reg)  && \
 				   MLX5_CAP_QCAM_REG(mdev, qpts) && \
 				   MLX5_CAP_QCAM_REG(mdev, qpdpm))
@@ -559,7 +573,7 @@ static int mlx5e_dcbnl_ieee_getmaxrate(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv    = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
+	u16 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
 	int err;
 	int i;
@@ -594,57 +608,41 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv    = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
+	u16 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
-	u64 upper_limit_100mbps;
-	u64 upper_limit_gbps;
 	int i;
-	struct {
-		int scale;
-		const char *units_str;
-	} units[] = {
-		[MLX5_100_MBPS_UNIT] = {
-			.scale = 100,
-			.units_str = "Mbps",
-		},
-		[MLX5_GBPS_UNIT] = {
-			.scale = 1,
-			.units_str = "Gbps",
-		},
-	};
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
-	upper_limit_100mbps = U8_MAX * MLX5E_100MB_TO_KB;
-	upper_limit_gbps = U8_MAX * MLX5E_1GB_TO_KB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
-		if (!maxrate->tc_maxrate[i]) {
+		u64 rate = maxrate->tc_maxrate[i];
+
+		if (!rate) {
 			max_bw_unit[i]  = MLX5_BW_NO_LIMIT;
 			continue;
 		}
-		if (maxrate->tc_maxrate[i] <= upper_limit_100mbps) {
-			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_100MB_TO_KB);
+		if (rate <= priv->dcbx.upper_limit_100mbps) {
+			max_bw_value[i] = div_u64(rate, MLX5E_100MB_TO_KB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
-			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_1GB_TO_KB);
+		} else if (rate <= priv->dcbx.upper_limit_gbps) {
+			max_bw_value[i] = div_u64(rate, MLX5E_1GB_TO_KB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
 		} else {
 			netdev_err(netdev,
 				   "tc_%d maxrate %llu Kbps exceeds limit %llu\n",
-				   i, maxrate->tc_maxrate[i],
-				   upper_limit_gbps);
+				   i, rate, priv->dcbx.upper_limit_gbps);
 			return -EINVAL;
 		}
 	}
 
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		u8 unit = max_bw_unit[i];
+
 		netdev_dbg(netdev, "%s: tc_%d <=> max_bw %u %s\n", __func__, i,
-			   max_bw_value[i] * units[max_bw_unit[i]].scale,
-			   units[max_bw_unit[i]].units_str);
+			   max_bw_value[i] * mlx5e_bw_units[unit].scale,
+			   mlx5e_bw_units[unit].units_str);
 	}
 
 	return mlx5_modify_port_ets_rate_limit(mdev, max_bw_value, max_bw_unit);
@@ -1268,6 +1266,8 @@ static u16 mlx5e_query_port_buffers_cell_size(struct mlx5e_priv *priv)
 void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 {
 	struct mlx5e_dcbx *dcbx = &priv->dcbx;
+	bool max_bw_msb_supported;
+	u16 type_max;
 
 	mlx5e_trust_initialize(priv);
 
@@ -1285,5 +1285,11 @@ void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 	priv->dcbx.port_buff_cell_sz = mlx5e_query_port_buffers_cell_size(priv);
 	priv->dcbx.cable_len = MLX5E_DEFAULT_CABLE_LEN;
 
+	max_bw_msb_supported = MLX5_CAP_QCAM_FEATURE(priv->mdev,
+						     qetcr_qshr_max_bw_val_msb);
+	type_max = max_bw_msb_supported ? U16_MAX : U8_MAX;
+	priv->dcbx.upper_limit_100mbps = type_max * MLX5E_100MB_TO_KB;
+	priv->dcbx.upper_limit_gbps = type_max * MLX5E_1GB_TO_KB;
+
 	mlx5e_ets_init(priv);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index e4b0aa16c1d2..b635b423d972 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -345,10 +345,10 @@ int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
 int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 				u8 tc, u8 *bw_pct);
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
+				    u16 *max_bw_value,
 				    u8 *max_bw_unit);
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
+				   u16 *max_bw_value,
 				   u8 *max_bw_unit);
 int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
 int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e8a0884ea477..9fca591652f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -773,7 +773,7 @@ int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 }
 
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
+				    u16 *max_bw_value,
 				    u8 *max_bw_units)
 {
 	u32 in[MLX5_ST_SZ_DW(qetc_reg)] = {0};
@@ -796,7 +796,7 @@ int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 }
 
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
+				   u16 *max_bw_value,
 				   u8 *max_bw_units)
 {
 	u32 out[MLX5_ST_SZ_DW(qetc_reg)];

base-commit: a22f57757f7e88c890499265c383ecb32900b645
-- 
2.44.0


