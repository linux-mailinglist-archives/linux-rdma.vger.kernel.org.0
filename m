Return-Path: <linux-rdma+bounces-19577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AcUD3lC72nk/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:03:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8FC4716FC
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40259300089B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426263B47F9;
	Mon, 27 Apr 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lD5exI3e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2E3AC0FC;
	Mon, 27 Apr 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287799; cv=fail; b=HLrsdJAjjKh1skm/xV7fFI3BJRQGV2LuOaaW7bPLcLRNK2CQLl8KOwIzNEDQ7NvmaNL0G3QjRbVRoe0mY2z1SlI1MnZPsBRoOZwNkMQM0UDmlcInBm7YYct5TvDQac5nEsODrC199NKglPXWJosWqEw0rxKXnO+HzJKOxZ54Cs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287799; c=relaxed/simple;
	bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fvp6YbgoabyWcSErINKwzHuVYZsLkfQ4EU+sKQiOJ0wPNdLu4Y2LaFW2PeTm0ssb8sSE8F+nKvYU+a9i4XW9wkn67Sc/2CuasBZINHQhjF94M1JHON4HP77VE+pFDx+UEOufy1qgMtxse+nj62shV+/T9eSIKqVFZWS8eoSTKaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lD5exI3e; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS8/zdgbopz2SHIM1ES1QkLMf611xWb/S/NHyEDJLfKh9NjOiUYbEiTayzr5U2gNdPjTkEblP/5TDEGIvgOh0ELzy5Zv5N0AjJ+x9l3U65mOj9VgbHEqp1VdAqGx4I9zL2PqD32u9DCl7CoYwManXHnM7OF5C3CRxFKy557HMqwR2U0zBw8qBLdb201efzczRPMRxbB3EQKqS252UqFp+ULE/4hsvmBVimbT831uDMwP52bBDneSR+aFeHrB+tCpUjxnCiBP9Ci5D0/01BbSGMwoBeCgvdrBd5zK+PffobCOhhux4JNbrAiO/b8V8ujaYlJPnU/W6Jew5rPfaKicgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=qzwIR43mwqkY1Wfmv2TTi88jI0uoPig8eJ3N8f/5LLyhOAEu7ADDrh1tUNxgP+xFy1dtmQVL3SAVCtrs2z9Tz66JM8hWrc/gz1wX3vpVvyQgSbCZWKhg+goumASu0/XbSl2fw4p591zajv/xJyEMENKaZyQg8OowNsj9sDbfELUJfVtlih0AOVxDeOmvXZIiI/hUooLcx86Bx03LR2N8Ou4ICXg37gdLrI9P1Q/KmciKZyMkUWR4TalD0hspk/1jFBG+F2AAOkJrFkJRxDXyn1E0s/3+BglifIV127DLL1h58+s1xLZaFxsn8ClcrMkUQamaIgiKL7nsuaz5QR2WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=lD5exI3eUZR5MuY7j4EFNwyDbZnwn/fRMSb+6MXq/8Y771ydsnaHJdg4Jf2GGE1fy3ta0xWj97/c53xoOMFZEfZy23+GyO0j9P0YwP9zHVgQ3o+RzKcW8xNrY5IUR59kaRnWLvm4o+ho/yXxL8mqNp3J9vJbIbGG5WNzfZDC6KIzb47pI2MjMt8zCMUmIQ8BaW0xwzgTuR0vd3Gf9gEZo0506Z9VfusD0CIuuKZwmH/17XKjbiXMvDwk/2Zyl7EeKPejQtyqj68ylxr4FgpTo/0KtY0x2MBoRorMwg9Lmkl6ZmtpnLONNp1FM5t69J0DLBszLk9nxB61lIwadTYC+A==
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:03:12 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::83) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:59 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:02:55 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 27 Apr 2026 14:02:33 +0300
Subject: [PATCH rdma-next v3 2/5] RDMA/mlx5: Fix UAF in DCT destroy due to
 race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-security-bug-fixes-v3-2-4621fa52de0e@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=1831;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
 b=EA3QoFw6EKJzAY5HJbr6zHiHkUHEr0UiLZh8BA6ICC+yMdKnNtqM80DfHakhORc4G/98Y6hL8
 GNeVh1o5zZ/CwayL8A6NkbvqcZ+pAvBQuGjJj+PtBOfrTluUmcQsd5Z
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 18092cca-993e-4054-c01b-08dea44c931d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J4O0W3+h1SlubMN+V5TkhSVmC7qovRP8+NjV2imEFzusg3gzzmLuO+4dXrsGVfFAU34qJkbR7S5LmPyfVw0vm7uWju2ab5F+KqE4o3D61U4PymERpPQ+ARvEDTWXmyCHgYXZ/xEbwW2Ras7PqjEbUzIX16F+aNmW4nTukDtAZd/uUkB0q9FUUnNEZdMuTM8T9hl4TA4gs7P0hoVXulopY5KZ+8jtqccUG9T/24+X0k89FZFo+Ey1A6EZOKFq47PNp3lkaQdaEuYbFgC+3nmN9hCPwVbmE1HaMerBSUIbyLd6nWKifjgz5ieE8f8bc2jiicGjQvL0lkajCBi78gKmEsqq17bzRD+DmT+u2PRGzRbF1acQmSCgYxasgbP2j7505rbfw0fI2B81kVY7n386pWGRrdeCvU8OHcKctm7ha4hVyUcSsJqj3wdhTz3m4MffGCLXZGmiYm0U5N80wFxPT80s4Xt86B/v7wdLVdpDnZSEbw/nLMz5vFWe5PfnjWjjM3K7ufvLB6RNSu2ivRFKv807GeiCGKK2/f0DgE1YmS9OHM21wPOeTm7mkvOBDFzoVKVrJCZBAzIc69lZiY9VmZTSp9DiyfzCrAsmrso2vufdoeLLrISmIefMpLxoKemgfx4jGvtQXbA2qlkrrCwQZJvtBJwS3gDVLAhVyYiKlLcjWrMKEr6dJ4SSW0cYgJid1XV0Q4JnKrFv3x7IyzzocNdUy+g9EZwONW1pd1iXQCd8vHDq7Y0qSF6UrICgdZyQ2414I0ZZAxDbSVXOHQ2vo2XE4YDtdOr+ASWmz94P4yH2n0k1PV+4qT31+HiceFXr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3qgTNbfNIUoPHtrdUQ6cWimzx3eSvTpG0gNZDBV8slgjQ4BBCxTvtzP1sPxW8UUFLc6mlNW4/H0HlQ4CEmXSapYc+nlDAzV4UBOK8XUa5ST3ainSOECptL+N6obV3HveAEIJR6rr0/3JwAixYvCsaW9E1mF3AFdB/GWt0OXafKiFCj4UXVarNoBpUnnWALz07d63V1uhG8fKRSljHZrCAM9RLBiT1inKxx/WpHvEfY/5g67Di35QpsLgk16mGFbMQEdDY7SQAfUwcLW9KZIGJRAuCbsmbZjLfaO7CyGFRf+UELC0JU49984KeQdgYfChGekPmNn4JZj6TvfBQYxh5uvQfRm/6c9/GrHaHj7PdXyop72A6u4VRsZkns7fZNm0ePjzPiPjzQdJLYkRu9SRlB0AGg4rz2oud/nkt9iNRCpov3q5prTncsvGa9d2Uw9/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:12.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18092cca-993e-4054-c01b-08dea44c931d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Rspamd-Queue-Id: CE8FC4716FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19577-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

A potential race condition exists between mlx5_core_destroy_dct() and
mlx5_core_create_dct() that can lead to a use-after-free.

After _mlx5_core_destroy_dct() releases the DCT to firmware, the DCTN
can be immediately reallocated for a new DCT being created concurrently.
If the create path stores the new DCT in the xarray before the destroy path
erases it, the destroy will incorrectly delete the new DCT's entry.
Later accesses then hit freed memory.

Fix by replacing the unconditional xa_erase_irq() with xa_cmpxchg_irq()
that only erases the entry if it hasn't already been replaced (still
contains XA_ZERO_ENTRY), preserving any newly created DCT.

Fixes: afff24899846 ("RDMA/mlx5: Handle DCT QP logic separately from low level QP interface")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index 146d03ae40bd9fd9650530fba77eb7e942d5fe79..a7a4f9420271a228e161aaac1ffa432d304ce431 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -314,7 +314,14 @@ int mlx5_core_destroy_dct(struct mlx5_ib_dev *dev,
 		xa_cmpxchg_irq(&table->dct_xa, dct->mqp.qpn, XA_ZERO_ENTRY, dct, 0);
 		return err;
 	}
-	xa_erase_irq(&table->dct_xa, dct->mqp.qpn);
+
+	/*
+	 * A race can occur where a concurrent create gets the same dctn
+	 * (after hardware released it) and overwrites XA_ZERO_ENTRY with
+	 * its new DCT before we reach here. In that case, we must not erase
+	 * the entry as it now belongs to the new DCT.
+	 */
+	xa_cmpxchg_irq(&table->dct_xa, dct->mqp.qpn, XA_ZERO_ENTRY, NULL, 0);
 	return 0;
 }
 

-- 
2.49.0


