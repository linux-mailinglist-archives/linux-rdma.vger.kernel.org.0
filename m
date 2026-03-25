Return-Path: <linux-rdma+bounces-18650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKfsMZcxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415432AF91
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48518307762D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B73ED13E;
	Wed, 25 Mar 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fn/tU+cp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2630B529;
	Wed, 25 Mar 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465275; cv=fail; b=lVCKpeO0WkW5CUMG0nkw5y5wJNZR7g12T+IIDbXymT5kXGlxobl05tYytq4w59ycLLneKhNrfTyl//hs3se3+pL15kMPpvZLfq8P3BXbgbzE4p3Z6JzjouY2MkwqYYpViye5PtpLVrrOxNHDkeWyr/5ZJ9q9jw5F+1jhQZD55So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465275; c=relaxed/simple;
	bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RXOapNV5xN3v29jeXOofoC8kcYYJxT6xwMuxmwmfDa6MbhPMhFP5kUMQK4epDA+7z2pZmPGzChw+OLDoMK2L54CykM4uSYGZks+nAtjCtdA7BV1SpTqZAdIzH4WFNKx2f9OsYaTFudLU0GATrxenhJ/Xo6Oy7PVI5tKzjFJ0G18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fn/tU+cp; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO3eMZ8IB9wH7sUm42IOAhBjCIOrLEmtUaTOeaQNDRz0M+/6zmWHk1ztRCSUKSyuG61i43NCJ8tTcjQZy5iCzkYzNgxm0Rz1C56bJ6Pq0XTGRMeAtJSxnSsdi/q3VyciOuB4XVwayh9QCorAqu0B11lzI2ZHAtXlc4t1sjA9r0wLCuejSmFef8SArk07sSmyUaFkmlZ/2glA83/A7lSCjdUSQDf6fkWEbb79pmfh5liZ2RdHSrTfr32NYUiKNmVkwlOLiA4kcVI9C4m52lqi7eOnVy90k2YLaeIXh12gXpjepegQ7kzkrawnb1ZQ5AlIDG3TH0XoLSxPgWyjrJ6fJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=JBEDGTomhgdEKYrVqkC1b+t/s+lRmzQqkwXg5KsznR7oc1GZyL+LDHh2c3kUd8g9nDXLMENkHuneJxORLWZQ9skkqN+1Sx20QhWo3680Eyf1cWyz3liSA5wGZJb4DNGuDmgGRAsZtgP2QCsJNKmtI+c6ruJzzwnOWleLikvGwJ7Gjat36CN8x+2ad+ATJLeCwlfLxQlTN7PMuWiOo2uYcJ//A9IeNkpxqeq64pwQYPvhhjnkEBPbS6BZfHpgj3eykf+ARAWIz0JnNUrXkuF4w9S1cQvl9p3Il7nfq5vnYPGzUc1CthO0jIM5mQxBi8on06t3DPqQwX/4xaSQi3C1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdrlkJezMnENZVh5CigvNI2d54O86poiPpOc5lFYrsU=;
 b=Fn/tU+cppN519BCGorZKfVIke2VzPC7Dsrt3UXzP8RuWnzfvV6qBo1B3w1V5BU+4H5RDgkq5SbJ5KUNhMP5WJiKFDt9Ybx6vnDTazAly1c9RhDnoMjGzOe5AstckbftJHTTY5Sfrzm0IcbQnbM5xad+WhLw6fmTVJug3nX/yfBYuL35ye1r2YFt5KroNZ6Xfh+fHhkYwdOMD395J3LMBZ2v59BPKDzqDTG5x5lVByWzVRwlR19lJ8vzMGvibzGvMxQY/3KYBbRtBKz8PloxIMDK8ffPnDH28VQ2UtFlHZF9UFTE1AgYTxi9v2fHJ7kON5Ia+vpy3C0H7tuENRYs25A==
Received: from PH8PR05CA0005.namprd05.prod.outlook.com (2603:10b6:510:2cc::14)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:01:11 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::dd) by PH8PR05CA0005.outlook.office365.com
 (2603:10b6:510:2cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Wed,
 25 Mar 2026 19:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:50 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:46 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:07 +0200
Subject: [PATCH rdma-next 07/10] RDMA/mlx5: Fix UAF in DCT destroy due to
 race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-7-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=1831;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=fqOQHBTsMGDyYBanPsNjePtGmdZDn4173XYf0fqm5Jc=;
 b=HVrx5zywE6frDApwvCAbVdObCyGeI14b++0nawIjjCi6XlAH/6DXshsCiE3bo/KR58xIQcTdk
 P1EcaxC9qUUAlNAQNPuYvCDSEIfAXlNIlcxqZq1JW+We1F31JUaVbyg
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: da48f3ec-5cd4-49dc-f2e2-08de8aa0e157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GakfGqxhU6ttnxg3PzkbMirAwAsbng3BWtHEg7tSrQ2KByWg8ZF72t/AMKMDXMxKBR7PrkOfg+1xoNQW7ShybO0Pxi/sj9DVnCDkeZeGfJV4V2+c6eOFx/hSP2wiieI9zqJo1l9guFyXaJdVP7CBA5ZP51tQEBlipiyCm6W/5UCw7cRQArBuQ4krj4w5XjVUAdKrcCLf+5fQYtQ8ZOgZX/8LPVnGAlfccsLmPr2wAHF3xx1ZO12u8uKAc9/PH7jCi5UCME260dneek/rdr4B4QredewIl9ffu0qqwI3Yd1e9b+omvayOHGTqBR/qeOGTidOFo3qaMqg1Kx2LUPxQ7jJOG0N7vlUL+mGfDl9r92a4bilsA8z5L12E5E9iew0lno+OISE8iorcbMd/xamSAA+NMbk/lQENWYziX5/Lbih7OcKk7vBETHhbeukUHw8nUTcZYS3tQfaeXCjKlGAaqKALVmj3MSBy+6IQdIM1AFmXwvvORXo3h+jy2sRsqAzMuzEpIeK9IwQOnLrjMmDKW7Aor61Db4X1KlQDtt24xFFqbijgElwTOfR9oHlJHere6juVoti6OavQz2CTDO2oCMHAf2EJf6eCImlEb8ht/i7VYfYyeE6bu8JBvdyrFA1itNdA9kwqT9AzZoxnHEvYDZs2bRUH/T8T/PQui5dy1OLTAJMA6Jg16586lxuCA14rQVvCnSlAZkVE9gCH+iCQm/l9WenXGwbWvmJTzBew9O4/QrXo9hyuTq9ypxTirvOiB5Z40rp5A2OOOoWt3cet7vp8tpymSqlSzGADUE2nA8c4cguaQ8LjKIsAP8xV5O+l
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/P27WPV6d+8H2jf3vRjdTQDcdX8Z/Miz+BguKElOqu3WwuLCX0gWMToMBol/qq4w33mUY6tcOzUwPAXPLXix2uYMl6dcCfMoZTJsV+VPPNDaFHQKPe+7OxE0dKnEdDHaQrjqFFyXh7CibB4XCFZTbl8zXfLkMZTSdBcwpfH7h9e7PJ6N3WDkInzhcJ9i3Z7vhCQCVIps+vLR6vDC27Dg/h/TBSn7XhmXeatALrUxayZsuvaMaDOI4gJzE8RGlrH0wQ80MASPRyTMr+ROzwN2MRNjR6tkJ1+o25P8YUAeHAHrZdNO9Nr6LSUecgQ0onbRjl6nSEmHH0q47vy4t81qfAh5trjiDMWXGDFpKWor7D5P5UTN2nBhu2IN01MFCvaSPc7rzmTGyBNtGYLB02uD10SdwM+MPHZoA8e4J6slW9KEnsnsyRJKQvQ0WjD3J5q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:11.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da48f3ec-5cd4-49dc-f2e2-08de8aa0e157
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18650-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6415432AF91
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


