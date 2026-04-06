Return-Path: <linux-rdma+bounces-19017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGxWNBd502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD093A27D1
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 777FD300B46D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0C322B7B;
	Mon,  6 Apr 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OiS1nvII"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB631E107;
	Mon,  6 Apr 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466734; cv=fail; b=Wx8y7DYwgqU/XZrtLFM48/2Oh7lkLEgns4fKcSAMszOateMy8t1fxNz4xTjqxQ23gIaQBpdAc0ErRbSGOg76WifZotQ3jY33HZzC1IetMZGqaCEc+SnAEIcS4GDNP4KXsq8U3CqlZYRu+vo4V/D4HH6SVe9aMn3KjOj4L6kanvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466734; c=relaxed/simple;
	bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZyS0urxEUre8JkYPq6CbvWZ6OxYMqCCcpYOH/JnJTUUWW06nSW55i2hyDIj2BcuT5RBuU0rL2DvfdxsDBYpulAsNs7ztaXdfOraqLUFO3jIggyWZLvHvslgacl2P9F0ZD+XUxa4Dh+m/qTBekVu5KDPTz/kBVZ/RvDCNtaeKWzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OiS1nvII; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLVyhghrhh01E4cxK50VT3Rm2VF0pZF4UdUeOLX3AMqVUgl3I2cI1mkeaY/f4FGRu5X7cIoSSVFssyHJJTtOXNFBddCyHGsf+jNxZGXcnmszjebAxlSIo+wp2e0nQyE1drOVrQWOwfAOeufYnHkieH9YKKc16hx+efDoVkEUt2jSV9wvOrnbfFM4SFsGJQLH2FhTudrluTAZoiA/PyoWmBdJGtwZUsgL8uNlYo2XdLbMlTCD0vb8IEOQCxKKXpF3pFMWgokkL4VsNg6pIwHAB8NVZuf5IqQb3NbukRDTnM5RjnpfGhI6svTKgJ5miWDEFjVE0n5QneWUZSQ8kxusog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=m4+bq9hAKP9/8Ff1aCU2CFAKE3Ua4jY7kCQbGLZh4UZRNqqnlEGw2D/MdI1P8Ox3C0zmH0g0SqXivn4EudFsFqfKUgbKj0BALG0Hf1KJiRMHf8lOjpb4bB6/rpV/nLYsPCG9bbmT/gBcIslbrLeL5T6yzmJR/2jBhNRn4/8pU+KFuh61PMQ9XIV5hIBKW4q4ZpUlcC2zfZnKFdxIu6JIhrOvvogw0cFWP4966mwCi1SIfr6abRUXUrT2wxC098PQAlqc5jZUcpFgMxs72tUOOOVMAe0RGOiZ5dlbPELzJU28y8B8rM5YIURty6DwoNg6/ug8a2srmx41PTnbATxIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=OiS1nvII6OXqKRX3f2iGy9w7pRYRDcbc0KR32ImuTfR3XLTUwMN3kNSenjXcwBnSUvtQDofWRifs9RZ54iG3qHXA6NykwyfMkiEIePLOzW+N+f9EoswQMhdImYgOHHO6ivCxB4XkHcMFezRMw0S7qDC9gXBN82tf0gYAEUZougfSS5jBFPc/Uc+lIqyv0N1O66ML/u3kni01hhhEsN3B2SIX67rb4Dg+mP12C6gJmU2PAiUL1+6TlBVbb/6wvpcCUNpX5sIHO0AR3o+P5GQSkjiyKUdurOWLENxXLetLPbi4HS1gfLF3L6xHGPaNh53ZXf5JmKVfPXA2vmEsO62OqA==
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 09:12:09 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:55:cafe::4e) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 09:12:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:58 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:54 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:19 +0300
Subject: [PATCH rdma-next v2 08/11] RDMA/mlx5: Fix UAF in DCT destroy due
 to race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-8-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=1831;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
 b=VIq66KhEH7mO+djbco4fUkApyCakU2iMTXJGbEzYTNqErqtAL49b+OtMtZIiH8N4CeMevWSTt
 Z8ffs/gVZUUCK5LLs4NvfTYiBUqE2w0TgH8F4ZufNU9qZsPozyfDcKp
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 677f472d-38d9-41bb-2113-08de93bc948c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r7CWKro4LXwGz0cN/N8Uhf2byPK0+WE+6bXopvJiEssi15LzKxcABu8q7pdsd+wR7MPWwBnqgdR5BS8Nn9FeuRZBvIFOVjY3BF/oc9QE4PzjgX11rhoj2zcX/k5a1Du+vMJYXMHPzSv3ggy4azpV9OpvpcwHGUYbZO5F4LfFB35+avHcTHmD2r1UpTTggROCR+L2bEXXWclKg+VXvwWrSXamyaJKJKocBMxEAe+KbAl4TrGtJPRQiPsxG5ErrOAYhioMlcRsVlfzifS7eFOi2spMougiFMsYH/NKMIEqAqguxMs0laJ3jZpdvoXqUEWxtLmB6X7oPB8aBSegYOCXBRMKlUFHKUyw9JWoslXqJF3LNyq1acpH1sntiXcmyJ302wOugx37FvzNhtMteYfpLU2ceZhomxHYSuzIG8WEQb1aV1wc8Cjk4HRiDsNSu+fDBip5fbd9U+OGRosg1zn5A8sjJQ7VXp5kVNqcZVEtAhN7z+WRfz7pAYS7SY1M6KIZF1pT6wA8anWPJom6VS6MpJ1CeS36fHRzuWPnYtw05QFQ5BtYsrDQBxpRCDHqI+5mN4C/MzzuAHFgCbX+1vJ/aqyMUlqI6c8KsPNhye5P1j7VHMv4KnpDMzASwNvUVofMD+NMV2pEueRy8ZHUedC8eDUwgL33xpJsHJZQVsRVUpV1eTGtJsHE5apc2/eTOZJpa6KwxPxQVYGVgsXINAA533jQ3zwwXIpDjAcrxR7RHbfW84/cAknK3m2QMH3b2LiAmIWkaAW66jYGqVbMwPRqeS1Y3Dsrqx6o9LnBgCWYTQfCATt3hYXB2LbCaVIqVkMr
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ii2SGfkYFfrSNG7/81FmBGIUMDjFJX1hvMk7ZabUVhjTnc6xGC/7K2xJQ1advxOvjtbY806XV17tBhXObQGUzW65xmj+JwXWaT6xUTGOf77xSbO9awBjdBlOBlhEze4IhUDevckbJ686nFCWHNzFmenxHljGI6KjePwFmTBHB+CqOmPKHdHK4w2oz3OOqDBI66xM5xmCMieyGnueyUKVoLfIJ1iA4trFSV5+ZYjG9LCyRFFLMwEbaFqLZabwWUAYrZB4w7W1nnywK/O8dqaedQPRs4UyBHQ69ceKurh6Zj833zAspTk4bxJOBmuS2eV5jQbYcMxcbVZ3Sb3ZIZPp6LqUiEpbvfnGLx41b9Qaw5FbZXSiarmH1am1SKo9QJzXSYL+wjlhjCUIH7XzCpxrfrszNZztU3PR/n3zmvvriPnrP9Fs/Us5FIYTQsyYw3vt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:12:08.7063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f472d-38d9-41bb-2113-08de93bc948c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19017-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6DD093A27D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


