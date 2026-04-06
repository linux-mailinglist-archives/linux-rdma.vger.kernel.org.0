Return-Path: <linux-rdma+bounces-19010-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBMZEdp402nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19010-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:11:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D221F3A2796
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 091AA3004633
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612231F9A2;
	Mon,  6 Apr 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCEsmAa/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440731D759;
	Mon,  6 Apr 2026 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466707; cv=fail; b=mMTWIoQ2/7v9Us8mgAzxU05O2IxFNhNtAGKJLovBEBjks9WsW08yPOYmDhTgrAklp1+4e9CldgQe5iVi047oFJ/Czsay98wG2ZM43FMOWqGp1OrPwwIa5pbybKeOIIhCiuyIXarYOMe4LRIMdjsLl9x843rjy8zAPl48ogB8JAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466707; c=relaxed/simple;
	bh=yqmKEBYziMBddfqM5RbkWI/eEd54On0zvT25cLZqa1c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=h5f5ytcDoXScAN2/n8DQLzXGU1ePIF6lO8fcho9mNBIXH7AtEfLhQWrsex1yg5mUpgvobTii9HxHs0kOHLDizToF3KP7l1J/kVWWnsfu8qi6xF3NW/438+cLscC+SNWxwC2zCa8yba3w9YRXJuSOCF+MDuYBj3kN5Py296T8Hu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCEsmAa/; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHHzOXaPq87oW/uVpV35TIgZEBUJXLVT0nPs1F9xIfprE6v7wO17by189+Qk3XDA+d/WMdFLRg8IVE9DPs/bS8W/shunVfagl++0m2bGB4nv9YRnY6tuBSH7VwbPuwakhHWSlcZoc7R2W86TcnhWfQdAzQ6Opfq2LsT3jtNjJ4OaQY6CmhBSKvM3CkvpTVTCc3/HGkOU4OiAdlnsunG1HUauUTj1H/L0eKlCO9GsyCpQrpvWCUPFBXOZbquPbTsldWiAuH6UoB+rj2wbTy5Rrv8t+UgNHli1/Q0lyMwWcOFnLs8eACW2DMoibOUelB8aXI6bpuvePDc+gFmE+FGvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zIuri+nDThsD7SFfYRQEOI4teVbfA9WvOeJOFEPKcQ=;
 b=IoDs3TkUvzoYBDWuLW2YYtbrP5EOujPzG24k+gmer+iO2H+eiPN9uyBxDuR6tTZPVwFA+Lc/ppdFfBXsD8QNEQzafCzTNV7gIpKJChgwM+7CZL7bgmGhwrSvkAeQ6agNkOD3A4IAEnCqNiVk/2rms4InPZFvzjgcKZxFLbn2h2ExB0inyZji9uEOgVmFZCASdRAH+x3BEBmlHhjOKg5yvJqNlDu9MEu7/DOcU9hufTWU+tBO5ttQRFAsbb0aMMYNId7nBHsIzrjhZZpNH/Sj2IrlmmU7n4+mOXnXXQjWlxOg+wQ5kW7Q3bcIOXboD8848OD+wWpjCSWva0sd2ipSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zIuri+nDThsD7SFfYRQEOI4teVbfA9WvOeJOFEPKcQ=;
 b=cCEsmAa/Ms+GN4MlLU33l4XKNYwnGKijCYW6fXQ9n0zMKvpK1QNC12eOoyxL441Qr+RMM706R42pTk6q73fMT0wzsoE6zquR9P2/f00Dkg9DeDHp4i0ZuBZ2SaRzK4j+lo0nrYrB20qS2nK1nIREvAKWL3PycscoWTScrly2ZDeXPiCAkQwJdNxgm/lk4bGt8uI/ZkEpsE9+ucE6fXysjj9oa8i+xWPWXIqITxvbywZFMH6lnebo5gy4tgfUnb3U6FzDSCB2UN3rza5Rv25yLiUDlBxyhqGnintVdfx9UqLQi2vUbmWhFEJlrAif9c1egs8e8v2QGzZiXwtRJd9MMg==
Received: from BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) by
 PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 09:11:40 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::1) by BL0PR01CA0035.outlook.office365.com
 (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:22 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:18 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v2 00/11] RDMA: Stability and race condition
 fixes
Date: Mon, 6 Apr 2026 12:11:11 +0300
Message-ID: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9402kC/32NMQ6DMBAEv4KuzkX4SBCk4h8RhWMfcAUmso0FQ
 vw9Fg9IuZqd3QMCe+EAr+IAz0mCLC4HuhVgJu1GRrE5A5VUlxU9MbBZvcQdP+uIg2wcsB4sD0S
 2fSiCLH49XyB7b/B21uh4i9BnNEmIi9+vu6Suwr/lpLBE01QVtY3SlurOJbGi72aZoT/P8weZb
 YHewAAAAA==
X-Change-ID: 20260325-security-bug-fixes-6fdef22d9412
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=2696;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=yqmKEBYziMBddfqM5RbkWI/eEd54On0zvT25cLZqa1c=;
 b=WtFmoHkmBSXX8MKC4Pdt/Nci5Pf1h/DHFm1XzCfu5nTa/sesOwTIkrpX8+QQObkMi6vEgV33a
 H3/FMo78svHBbgV1fJH637JNV9XahXRXE1liBeEvc7Ko6765XaqtC4/
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: a4117b6d-843e-44dc-08a1-08de93bc81b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|921020|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zBZUPTnPmA7Kw5pe+tYrZuIuE02gs1XgOtSy5DQ4V4EVr7JQDZL1B9FamxkXr/vQ2rEjcHZC8JrnOsDkyhreZb/GxpGpr8NSwuCPsMuid8FCIi8H1HgMeJVC10gg7HQq1SdQJxm4YVodm0GFxzrfF71uGZNoxAJW3sJEpVRx6Cd7WHo6i/fJ8cXE/RrPPgHSbItz3xNWhwbIuy538XC7gH8kvMYIxPFbj0z35d/JVRIAscYrcBVCvgcSx1WAfmtfrbSf1IgMjvXAGOipSkfEqjoahKdSKLJnrwwetxCsy/aR+nGjDAs9Rwoep0jKBUy+x0qlXJ52Q0gB6C1b7OuRRIHh3hYaq2Q9+FTlFq61/CSRyhWw6BOoHlyNTfGWUujJuS5Bhpb4dEnMI1Q1Wz+pugnFUPBiHnbvrUjlfLxkes+iFai5bAR6nl5ZCvB84CKvkqhTNrOzubZbZ7+D1UfhRSjchzqDNWA2V449oqcknlNhHE/5o8y7oW0rUZQ2/nQO7qFK4blWzX3uj8U2bktL3G72G5FnT16+38yYd1tAYTk3zwz284CjghS/avjDJurDl4mLl6Xy4DULSRIqQ9otNB5VgJF8ZNjOdX9H+nhlt6Zr3/x3HnHM5/2FUAyT4wHCRx9ajyktFmTj1ToOytVymFtKeLiEPq/vvwdagbZPoqVVs62S6yMj2eucCp1WlRtMH+xnJcdGFfjXKWwCiYcNMy5O/vV+KsdxHR343UT5Usu1KYKOPdir0nJtmyzq7Axbb+RffaT1zZ34ZyZzKENnx3g0duJgA9z3RtzZ8I+ge5rxrTxCIoVUEkH74yyws/uhAsJpx0muNTKRztEMSxoZYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dmFW6RwOSevCPjrFKouYhtInTe2IxNiAswUOdhpf8gHBLfB5GpaS1UKYIIX5GI4ZHeQvp6O0i12vwuRMwOKGHh8D6B8QEx45iGfafCopaGXf81YPpjhZmYGQrN3pO/mpGybe1vwUAsJgL6M8rhdHGWThWUZHEn4iw3z/cGqIblEB/PxoDoGwS5IIUQUIsWQBziWES0dx5WYIUeRuPIDheB3jgRcIdVqLzjVaSVshIZyIR5JU8NGKutXiMciu7bOlqZtiEKlNpYEZg9NEswmYszhMZ838eF5SomltdYR6K3jY1+X6eejrkTTEMIpej7giu451DG+8CMsunGpxG2TbkmGHBjbax9NIR1P7RgHKCv4+9ReQXMMz8WDGtHPRjyoFO0mbDs3HEv6zFMMRGeVY5GS52+EeAO3L32L42VqiLECSu8/xpY5uQeJnrzTgB2o8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:37.0570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4117b6d-843e-44dc-08a1-08de93bc81b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19010-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D221F3A2796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses several stability issues in RDMA core and the
mlx5 driver, mainly around use-after-free conditions in resource
destruction paths and race windows in concurrent create/destroy flows.

Patches 1-6 fix a restrack race window affecting QP, CQ and SRQ
resources in destroy flows.
The core problem is that rdma_restrack_del() was being called at the
end of the destroy routines, leaving a window where the resource could
still be looked up via netlink after vendor-specific resources were
already freed. Three preparatory patches lay the groundwork followed by
three fixes.

Patches 7-8 fix xarray race conditions in the mlx5 SRQ and DCT destroy
paths where a concurrent create can reuse the same firmware object
number right after firmware releases it, causing the destroy path to
incorrectly erase the newly created entry.

The remaining patches are independent fixes.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v2:
- Added patch "RDMA/mlx5: Remove raw RSS QP restrack tracking" to
  also suppress broken tracking for raw RSS QPs, which suffer from
  the same silent failures as DCTs
- Link to v1: https://lore.kernel.org/r/20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com

---
Edward Srouji (2):
      RDMA/mlx5: Fix UAF in SRQ destroy due to race with create
      RDMA/mlx5: Fix UAF in DCT destroy due to race with create

Maher Sanalla (1):
      IB/core: Fix IPv6 netlink message size in ib_nl_ip_send_msg()

Michael Guralnik (2):
      RDMA/core: Fix rereg_mr use-after-free race
      RDMA/mlx5: Fix null-ptr-deref in Raw Packet QP creation

Patrisious Haddad (6):
      RDMA/mlx5: Remove DCT restrack tracking
      RDMA/mlx5: Remove raw RSS QP restrack tracking
      RDMA/core: Preserve restrack resource ID on reinsertion
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()

 drivers/infiniband/core/addr.c        |  2 +-
 drivers/infiniband/core/restrack.c    | 20 ++++++++++++++++----
 drivers/infiniband/core/uverbs_cmd.c  |  9 +++++++--
 drivers/infiniband/core/verbs.c       | 21 ++++++++++++++++-----
 drivers/infiniband/hw/mlx5/qp.c       |  7 +++++++
 drivers/infiniband/hw/mlx5/qpc.c      |  9 ++++++++-
 drivers/infiniband/hw/mlx5/restrack.c |  3 ---
 drivers/infiniband/hw/mlx5/srq_cmd.c  |  9 ++++++++-
 8 files changed, 63 insertions(+), 17 deletions(-)
---
base-commit: 6edef31ef9004ed51624246a04f7f81112f485b0
change-id: 20260325-security-bug-fixes-6fdef22d9412

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


