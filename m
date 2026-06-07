Return-Path: <linux-rdma+bounces-21926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkomDA62JWo6KwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:18:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47665136A
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:18:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=X8GDdSG9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21926-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21926-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29BDF300C91A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854F207A20;
	Sun,  7 Jun 2026 18:18:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B513FEE;
	Sun,  7 Jun 2026 18:18:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856326; cv=fail; b=G13LijUAh7LskBE/DfcKwoNWbTvX6DhVV5I5Dpza6WJl63e2oq61LJrI76qNkRRe9lTgmlNCnFyS7VSizbt0L21d8329vzuuFBAgR9eAFIONXJKS+17SmlD1UPzd+FDlAcViRF1CuIemah6AeOKYEuO6/FXSb7iIV62oxQ4SwFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856326; c=relaxed/simple;
	bh=uHrW111SbUTW1+hOFDIhe1DwhQvdTRlA0YoazO/BsfI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dUnGVay4C/tU3SVP+L8SNOUDzWhbVMV5fmFj1duEeNT447QPfB4k1K6jCuhuXp9m2JC5LVfaRMg0Oglsdx929Up0MEYagnOYiA0Agzl4xWkJlWp6M8j0cEaFCk1DstLr+nsP5SOfxS8MwZxT5jMRivgxnfs9b2ZinEN9VLjtdCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8GDdSG9; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaDfHnx5w3UO5cIMS2Zh2Hx1CV65mT44uREOBYVOizplO5NzcblGqorp31+l2JfMzAA+WREvbpMZjeMM4pLQ6Oh8LtbdoHlahDbj1fczOJDfMc6PlJpnAM5GeHldwD9Ij5H0i3W4Nvw917NgeJllzyJonOkUmwKipc+kd15Rp3FtkD04LrY3oypDn00kUnr/2sf4vsU8E2FMByuQ3byZNorXY3LXsYnEwUZfd2nvvplN2leIzmAB5kcwELC3P5sS97fJ3jW5K65Zj9Ei7R0lFs4OdztH08wbEZszc3qrsH4lvQePJDgjPXDAo3u97Yijd3HoOISuW5OeqPWuXTlXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqjOZDWjdRDS54U0MtAcFAErDhZarIfkGP7hvY+Khj4=;
 b=rdngcEBKzRVVFjgWMlpbTpguqHTFJb5jdFXVW30IkJ0fndQJa8KTunJM/EPO2sRUYCJD6i+RaAPAEegS5L6qbUeYHsCCx0CTO3cW03LYXX+9Xod7CJGeQUJ3czcJ0wF14/WBcFKokRFGH34i/ZltsqiJgXHDik33f1kWSLRhftoVTmvwBgDT2vYWF6h4qceOeLBf/0nJka2MPox7939Y2bpOrpM0v9sY+jVLMVRaV+mKmJjdLw9ZBYXBSE7kcupq5pQmTnoSbv+11EYxAoPsID9eMzwwNL+chMFogdjVOJsTDl21QEcY5i52TxQiP34HM0t8q3Fn0Gz8Vc4xlmzGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqjOZDWjdRDS54U0MtAcFAErDhZarIfkGP7hvY+Khj4=;
 b=X8GDdSG9XkQxvnlGjpE472qRja5J7GpLQoHGjI60fyRi/JCgNVPIkpB46bl4MsZ1S3Rg3xkihL+SCjrfkQZ6yoHOYtE5bjgUlO9LsPycp3S0AJpzDC9vdUxs+PDjE99kP5+yMWPfj4GuQ6NIXm9b/CNURDeWGoBhaFfH8YM7Btx59AI3vtEOHxfetdHLyjpj4meG1KgycMAB6c/Oc8DvOqbd3CmzHgDbC1s8CGhwZ+CW2LrXSFftY94sXRkGHCryza9JNoymIGPlMP/SyR5rTLqDhBv56vHbsrjeJ0iOybDhI504WjAyZXiuKOUhf8p7Wb5qYzJ5hoCOKGfd9reu/A==
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:18:40 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a2) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:18:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:32 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:28 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 0/6] RDMA: Fix restrack UAF in QP/CQ/SRQ destroy
Date: Sun, 7 Jun 2026 21:18:07 +0300
Message-ID: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+1JWoC/x2MwQqDMBAFf0X27MJqQaG/Ih5i8qKLNMpGiyD+e
 0OPMzBzU4YpMr2rmwxfzbqlAk1dkV9cmsEaClMrbSed9GzIhzm/8ukiR704vCCT91EmNFSy3VD
 0fzmQhY/jhOug8Xl+Av8OD20AAAA=
X-Change-ID: 20260607-restrack-uaf-fix-d3e0bccf0be1
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=1989;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=uHrW111SbUTW1+hOFDIhe1DwhQvdTRlA0YoazO/BsfI=;
 b=Ss/6nwwrhP1m/BndXj+NudTgIbpGnfCd0FRqZfzoMvVfbMzQ7ugc1smakkHUe23WFymPbCmyO
 8MSw1tN9eN7B+F30xt2LYb1nYxx7gAlPjYbJsJGSXoEC8gJxq+hUayu
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e52f5ab-1565-4808-4fa9-08dec4c13355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|921020|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wZkVVauRClliH7vwKk+qjTYDw6BK6NKJ+7rgfdUhe7akCAZ7YKlgpek2mTn79WWJK4Dt5/1RWifwK2EPpyZErS2jb0QQ9eSlvVRnJ8E3JBGrCE2jaJH94kXkCk/FoXPsGtxdV9S/WhV4yjwp7A82SwUdwxRFgU39UVfOiiOaIXZTsTq3MOIv6QdKzeuQT5szXtlur3Kgjl2DjhbmCoqmjrpmHJpnmf5utihT8+mbDk4E3MkCcivqgF6M/WnBfSbpzOk6YTp0dwhQ158YBI715/wL4Zh4PA1spPEy9L5kujVt4NFDH4+KTKfWv0C9HnCN3vf0meupbKQF7ylE39znyTtzdbgCPPnb6As3SRwO1utFaYlBHbDOVADk+0StQPJu0zrSlqf0X9E6nc3iiMRe7KBCypV//5wko5EPHwuMWk++0EMYWFuDvtGfjJyr7i2dA520Qei6et9/Nke1/YC5DQoHTbe79Jqj22zy5r4bfalThLCRkVivCpHV95pblsAvlPWMcoz/ShXRbTbZxaoClLZZaV5GzkhhLmQ6RLlVD1HjEg3L5M+nUyxS/i4scGL48V2TImOjR5Kj6X70i0yZT1y2Ajt0RPU+L5bW+rqXn/3hZU/DDa33ofsZLMiLyuDo7gyI2m8iMaLIxzmi1fmZ3+4CjZ9E4r5dLuAd/rUXcjSqgO5Jms+wvhb9FEwOzG2ikhSL2Xsijc3W59nFrUTZ+YIpa36XwkXDlKMgGoL3aiZVNYvnGxDYpBhhsCaMBJ7TBBxZ3xc3qfoGg28CIbCZGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(921020)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vsU4jrpw9uPWCE2YsZmM91XoSuSdKwn5tKOopElS8xdm2kw3g45afjC+EMbJs0XUYBnviCCv5ihJ8H85SgaDrNtxRlUzJNTZQdX5ixSWQY0iEcrDpe2wqo4+avAk5mIecvKfo8q2ZAJJvIi3p4fGtFZr96+KW3aAtwMY8X/BgxeaAwVuiYJOT+aYxVp3VYbQbuZKIEKE2QY8dfPtXR92dV/DidRLt0X9mCkBs/aqNq6Q6v5mEAm0Y/NjgYhu6Vk4vC303XGH3X0/YL2iSK43jDMXs3aX2wZH9aUz+7mkLjTdkaCsGvTZ0Mz5jloJRDwAuJYhda04WSX5P557RBBV+p3SsYevd5xK3nG7zdWRaVpp6UC0Erb46hjiQRHICmXvCmkqXiKieBTE+PoHSHgtcKhfm0iAoeiF9jQSKyniMZRm/YPL1pO78OmbVsnXxwME
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:18:40.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e52f5ab-1565-4808-4fa9-08dec4c13355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21926-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A47665136A

The resource-tracking (restrack) database is the back-end for the netlink
"rdma resource show" interface which pins objects with
rdma_restrack_get().
The QP/CQ/SRQ destroy flows call rdma_restrack_del() at the end of
ib_destroy_*_user(), after device->ops.destroy_*() had already freed the 
vendor object. Therefore, a concurrent netlink dump could look the
object up and touch freed memory, causing a use-after-free via
ib_query_qp() for instance.

Fix this by splitting the delete into a begin/commit/abort sequence:
begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
drops the birth reference and waits for in-flight readers to drain,
while keeping the index reserved. The destroy paths run begin_del()
first, then commit_del() on success or abort_del() on error.
abort_del() re-inserts into the reserved slot, so it needs no allocation
and cannot fail.

The first two patches remove DCT and raw RSS QP restrack tracking as
they have never worked (their ID is unset/reserved at create time).

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Patrisious Haddad (6):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/mlx5: Remove raw RSS QP restrack tracking
      RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()

 drivers/infiniband/core/restrack.c    | 120 ++++++++++++++++++++++++++++++----
 drivers/infiniband/core/restrack.h    |   3 +
 drivers/infiniband/core/verbs.c       |  21 ++++--
 drivers/infiniband/hw/mlx5/qp.c       |   2 +
 drivers/infiniband/hw/mlx5/restrack.c |   3 -
 5 files changed, 130 insertions(+), 19 deletions(-)
---
base-commit: d6ab440240a04b8737ee4c7bb21af9182e451733
change-id: 20260607-restrack-uaf-fix-d3e0bccf0be1

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


