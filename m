Return-Path: <linux-rdma+bounces-19626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCFEOFBH8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:36:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8B47DAE1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844A4305BDDC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356E33A00C;
	Tue, 28 Apr 2026 05:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c9HAqLWT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581F31065B;
	Tue, 28 Apr 2026 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354222; cv=fail; b=WNq5Ig7LzjCq9oAtfS46533NHG5bz4eOkRiyZ4JXDDI7KoAMpucCweNgV0bbOuxZHHJjLlB2vacji54qj9wmicgT7XbV35Z+0f9qKidamAKreG+VkrBWqMnulrFoLsGdrsvk5DocY7c3vlLIn5DhNUaTouLhpNtNTuAo+5JwGlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354222; c=relaxed/simple;
	bh=hjDr/xZFCr6MKE9RGKUJdQa2A6drucmKVE0frEa/QUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qevJpD8Vz33/n/08UuWNael/sjCsyJscLhljQZy2v2WvWh4oPcB6XmmzzwX7CUoL0ttFeNqPgHyqccEbp2mGKE2Kd0yRwnpP3GReEbKiF+F1q5S9G5jLz/YElv0yQA5Ylyo7nZwZvX0ljF0JF2HnnMJpNZfHTSUAmlUfFTfQGyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c9HAqLWT; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NodW/WLCVgMGU31hEY21JA2k3s5SBXuQqKEGw6BNTdFM1NjbZKT9HizSjqXCg8cKMzJiS9mSxzxNZhWEHqOnNucBVPoU35LGXSdJEZpW6EwGFvCtE8Fn8mUZ+BAZMuqJdWCOulByhEwVQZ6Amt97kNtch39RtCsmRZ2ZosUqcc5rOROOclh5d3u2evsz2jB48BZ7JwOy0nWy3uIDQ/CFy68AwVxMVxtYK5Vou7uG89YbBM4CylNiih68MNoGsxOxcYArq60nePEgNmPPSVQWMm2fk+bhMcH4EIjqDC+Md+9/0d+zwpo7G86e9pgUmudunoKGX4aMEDbvV53FOPTeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DmrHmbGLgOzHJtGhnAy/KnRmTXMi/Dj/vNEQNH0/oU=;
 b=Do1UE48CJtYBvKaVVbUYJ+FhFNH/cesYAd3QWeMm3nQ/PrtIDznbq5jMUhSbRv9ecEEiv70MXvj7ESIPXJXBdTtcxO43egXa4Cv2mq+RKtUGipoj8qh4jb6hyVCLX6Yp28YuXGos6Gi7AUZ3Xctf3AKoObf0wKeB3q066x/pNw7dUBCFXWAHENdkl87Iuh+ccF6mxvF1XL8A94BLdfquP98Q8rjFgHRM/LZ3VV2UjEn+R72+WF05QgkSV0IZxxCKLSA9BG6QP7B+mm8Xl8UZXx5YuWH3Ug+UnyT3nwuV0zH238Jh0YxVWgR7sjOtg0yUCE01zvkq5S010PXesFyiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DmrHmbGLgOzHJtGhnAy/KnRmTXMi/Dj/vNEQNH0/oU=;
 b=c9HAqLWTJUfzZmo0jTaHlI2zohb8ESN0Rw9BvRiHgq6mkNBUFW0Rf0Q2wfpXYuhFVoEPu9RfZvgJ8JfPqaYqS2O9YbxLeZapcOiD0pZZ4LlxvX17iygWHLyAi3nbjb5UA35kkT0OwhhBio7q05z/uxqQEhdwP1FBHSV8Vlvca97X7oWcWYUw0g5KLk43xglayi6kE7G6XHzhAyQUbwTd1njBmfezkWkHxVrqjuV2lIpIBrQgGOCnHAm+Gi7lEILKHOHez8Tujw5robpTBe9u0Q/zaGaxhGTugJmtCe7tZLllXYA1yBlvTcqcNxHKBrHlY5wlrHnQqqNd67/UhUpqpA==
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:30:16 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::f3) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:30:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:29:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next 0/3] net/mlx5: enable sub-page allocations for mlx5_frag_buf
Date: Tue, 28 Apr 2026 08:29:17 +0300
Message-ID: <20260428052920.219201-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f87cc6-023f-482e-72a3-08dea4e73a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|20046099003;
X-Microsoft-Antispam-Message-Info:
	62v6rjLveyLK3o1fqSH3LjfG/AZtzs4bYZFVQnc8Bd4x1j5KEafjn5nnG4eX+zbanMwIRY4T8tlZDovc5kjkCmzcvfqmFMV/tVmGOh/2NpBGvrhJgsXYzQH6hBYRtruATeUpm+HXt0S9PRntTJQn9DEmtomTDt6wY3z7JbO+RDtrG3VNoJidqmqDgE33t1+/4406uoxp/7UlvfhWPsSTGlrnGaILWKELHkGitEmRPNVto3HRhgLlKlroXmLHNiQi15Kx+/flzcVD/zRKle+iWkq7vEI42ah+YRN2k30ZItzya5tMZX19xh3IX2Lqn5TXuYHl5sHnSGUqnb1HEBjbvUK7zIRGPd0SLHWYuIupr5jCgci9aRoB/WDaPTEK50A134zsWcuCNjAOTEyQnoYy0HHEsW6GzGa3flgQ0PwbEaJn66M+cBv1hH4efRPUFcjhs3Ct5Wo7oNJcaRXuz670St3ty2nEiISFjf3XsBPbGBh5j/TPQwiru5/1dTzV9cmLoRsql29owf0NKuNGkpfzDXiC/sFz+fcAC0j4wr2KaUaMaTc2XNCiT/x7hJm7uHsfBDKgSHG9oOa4l1F1gODqmhbkZoMogn2BAjB1eF548/Gvauy83/3ZKA6zr1edeRgzCFf7bQ4foF4YpH+fPuMgpfM2MaozW9mrQ8ZmpCkQd+xKBf6V+t9RYIZlm5m3s2USt3/GNAJByWtkoJCX3BUCCSxnrWxfdxGKeqXDe97Txy13/zgWZpbwQVXTp+WY7WhYYgHluN1aVhiOdvLu5+NTHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eSnO7GcyWDEQ79vdhFGU1iUvMgOe2wm7cLsh/WgLBNDNfIT0DEwzq/hc9GiD7GWEsuS04e2nCk4Q1NsNr1QLYcUCEgIXaaT9nFOU0EzjvUZIsSExRrf1Vjrm368PoBk6WkJyAb/o9IE484yesqX8MeXuGQX3oqIvgONL6B79f4I7ovbtlestGqCLaYlhOD5ux9BVxHBiAiBp+5uQJaQG0epHwf6DWQWQiz6IOkcGAs2ifdPGutrDeTlleZZVKVcfAHp6+1AEFevX7KFM3LSny6dH05qj/JLvflmQOEwg84WSDk9bmvhugwhDn6RaHOnB963zj0yvJ8b7Wj4LzeIUrWivzBFeE32G3b725BSn1xOBn6wcBk5RgHKopMl7Xf7CqvrbVrdEUJucnMyvBdPFlYryXhXM2bbTQWCtRBVVN4Z7Hi/McB74VR//59oOwJE2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:30:15.7337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f87cc6-023f-482e-72a3-08dea4e73a79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
X-Rspamd-Queue-Id: 6ED8B47DAE1
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
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19626-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

See detailed description by Nimrod below [1].

Regards,
Tariq

[1]
This series aims to improve memory utilization for DMA-coherent
fragmented-buffer allocations on systems with large PAGE_SIZE.

Before this change, such allocations were page-granular, as they were
backed by full pages. On large-page systems this caused significant
internal waste for small objects. For example, a single 4K request
consumed an entire 64K page.

The common kernel solution for sub-page coherent DMA allocations is the
DMA pool API. However, those pools do not return pages to the system
until teardown. That behavior is not a good fit for mlx5_frag_buf
allocations, since they back interface resources (WQs and CQs).
Interfaces may be removed dynamically, so their memory footprint should
reflect live usage to avoid situations where large amounts of memory
remain tied up in pools.

This series introduces a lightweight mlx5-local pool implementation for
sub-page coherent DMA allocations, which immediately returns free
backing pages. It wires mlx5_frag_buf allocations to use these internal
pools, while keeping the mechanism reusable for other mlx5-internal
coherent DMA allocation users in follow-up work.


Nimrod Oren (3):
  net/mlx5: wire frag buf pools lifecycle hooks
  net/mlx5: add frag buf pools create/destroy paths
  net/mlx5: use internal dma pools for frag buf alloc

 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 328 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/main.c    |   7 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +
 include/linux/mlx5/driver.h                   |   9 +-
 4 files changed, 312 insertions(+), 34 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.44.0


