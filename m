Return-Path: <linux-rdma+bounces-18967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GORQCBOCz2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:02:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0873927FC
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EE4230387B9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840F365A11;
	Fri,  3 Apr 2026 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tkB6d7Z9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F43019BA;
	Fri,  3 Apr 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206879; cv=fail; b=rwh+7+2772+FDecrIiMgzJmmg2AA1OM0BSZgWUcRkrC813/on30eKERaTWOzpDy2aQFSyYTzKyB0HlKM5TJUEwRnGXbaghbnb/0Haw8Al5h58KAPR1SDbJaN654OPAhoX2p/qH4+RH+Ck0o2/Y0oodv3sO/xdJuee0raQQkvrbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206879; c=relaxed/simple;
	bh=3KH3zuaicakQgMLFGz2LgkCHOaiIH8NsdvR0Alt9plk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7xkzUXUljnwyY94H6TePbNSEQozv5Im8/FZJe4tzDNKGXLpsYstHuvukMccyTY/IrupevozzBxalFmwa370Art5BbpsS0bQdNBaugupbPundftdq2SUf6SEOmJS1I15rS1H7kMJp7rBinbemESfR67fhYQwKPbVubWBLUgSs+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tkB6d7Z9; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQymLlwjMZnCacqpW1tZsD5kTZGd7p74EUHE/ZRzEeSmCV8mX2uAnTMWJcETDoMRS8Mk7Z35cNkejooqqo7aK+X6QKx6veTBpc1KTyrhQ4yi1bLAPIjvr/2bbokg9hZQSekDK36YVu9zrKht6D6AOKUauH50JrFXfoBpWwAyChPhL6aLJ4SSkBDF5RCP8KZvR99vAsT2ykXvLy4hiSFV1/5nN5yxKRnibn8IxMtYJny9R44kHOMDHORf+6FfIqen6CmXS8D7NNKh5TWzKGEMJy2Okl+LigZ5eeliguX0KtMekwiQRNZvyhHb6YXOjXDBEHZjWASkTo0X1xWa5sUtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40OdODC5/mR2iTYFZx5z0I++7pvj+yVAaaczw7MqSKs=;
 b=xydYefVOkMD/8hAX4K582CJS0GFcOS0bmO8okdPxqhQTUCMTWLI7QFZ9ZRrhrNR+MgB7tvnEBuu7eCICl6sUydVa80W5JgUNrvVHzKvh+XbBs6Wp/YG3F2lkfnVVMngaKI8AgQkRyT8CqGsk8pfwXI5KH9C69/ZOHqUT3SuUNnqPwYQofoKG4bLQsBzloL8KKTyL/4ToWz/szWgveS7VGfC57QmuQ1+bXeRVysXJu96JgLhkbNv/5XAWfrF/u495JG6kEW20HBZ0NxJ9oBu8Q7K72XolzAztRLCbIGLIfvpqws/w2FCTavFcCL4gBZqgxkes7bqp5Uf+TCcr3O5nVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40OdODC5/mR2iTYFZx5z0I++7pvj+yVAaaczw7MqSKs=;
 b=tkB6d7Z9002Q9xHrQSd30Y0lctpIRQlklp3GJ5944ajWq5fgQJ7o+GnILgA2y3L7KAQ9H+ss3F1F1RD9SZ+WGSejYUffbYmKwA1fC/kBaO8oy7Ki1vSJAjflCVhpKPIJLkngQ7NV4iiK9VG1yFGmjzXN0vRTNKwyeQBLPoSETN/S//E3vM5WWZ1p3x7zBHs1H89HVf6cJIneo4uPzMNYv9jm0QW4opxLrMTFLAKNPEdr7ljuC/zIDFXbu+sXrgyNRxTEzcC+0yxalM7YTXlrxWBpv0Ixzfm7OOZdb1smjqHSQjU7Y918kxAsh+Wb6//FYTTczTnKOlhn7gxmjdQLgw==
Received: from CH2PR14CA0057.namprd14.prod.outlook.com (2603:10b6:610:56::37)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:01:10 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::72) by CH2PR14CA0057.outlook.office365.com
 (2603:10b6:610:56::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:01:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:00:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:00:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:00:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2026-04-03
Date: Fri, 3 Apr 2026 12:00:26 +0300
Message-ID: <20260403090028.137783-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 30be65e9-22a0-444a-2fca-08de915f8ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	STkP2GJpdZZHvgU43ccALaRuNDEpzbT26NEkskh1PP1fExbBeyxiQmn3BApzh1HNKQp5JLjtclBl/Z4L4W9leEnuROdDc1c93fEzZtuYYjiCPzvXY6qvfkb1FBJHUmq+lZW1sCCCd1MbToe8Hvfd7gmFOO5SZEaldMPt8XS31eA9qLaWPeGBLlEfggo25UN/lTxpEZhf0qCNy2be1Ppvhx2xJivYpRphi3gTSoab3KfZJ+uJ6Q7a0i6SQrqUXHMY4ETomu7Lq6GlBytMR3bBk+d8abnpYNN0VNVfAQYmCg98kAubPQ+NgzQuH7/n9by7Q2Fdrr+BrJgPpR2CG/mz9corVU5u6zx2y3MV0BZuS1o1HBzkQIqNgP+slR7+yq896saNnA15aObHKBOAowJUa2IEdb7qxDToRHFMnlFMYjyEIPPKyCcBJVnNoaWHocBUMWrCXzCDIVRp5GxJLYkuMhrIzEBL+YsR37qbucHXAwFHm6xztKeIL00CjYE1INqjNt8dVoHUoCk7nQ4NIT1DXKse74bOoEK+7dyjMCTfY4xqZY0pkAMY4ZqTKYWbL9UTlDOyFNeftXTC50YEdnGnqhmqcc9PD7320bZ8g8enBVfU12jryayqypY8A/sE57mIAUXK8gf9Bv66hA5Jn6wR75GOvPUxRanysZrztE+xFTjSDdlOC2NXsCdPEE56RuJIhNRzImdXThObRu36IKfqeP4ZaAQtVQYK1V8YuXUnTzQbVliuIxs6ncWm0RTbBLy4zuxBg8YouQJ21G2l+OIXbA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iaoJUp2fbd+wOnzsUrZeszDZ+uvyxPlKYf1EHdFL1wouApAPpYqQ3hgWrwHbqqqo6gCvGN/huFpNUE5S5AO1dQMMLMPe3BhwXlmBDhKPNxltPU24QyoqFqumYRjt7b7NQDGbHqCCgcBU88q+oda6eUKHBQVuORLoGQxEHPPX67cnMCEaOtSrQL/WbGDpRPaMVmSAkcbOzUoIW5G9tbKhFEbX3twf7+v879PbwW4RTXZVr+/gmOJUk+ZVsC1ilKHQMTLL7Cya+AhgyifCIV+qJdZmgsOWjEe4UdifttgsB//+PQdRhp13+P+5RSS4oHzNUiqHQ6XSnAueABH+sPKrQVWWYQ4mQCi0iy/FNGE9xmUTRFSJLb8JS2J1/c1RDRPEUof1p6dcfW3yaGcXq6O6XXx50vXSYDVn25ZhocpJSE+FnwgF8bHMAcxnhMASxGx8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:01:10.3228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30be65e9-22a0-444a-2fca-08de915f8ce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18967-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AC0873927FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

Regards,
Tariq

Moshe Shemesh (2):
  net/mlx5: Rename MLX5_PF page counter type to MLX5_SELF
  net/mlx5: Add icm_mng_function_id_mode cap bit

 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 3 ++-
 include/linux/mlx5/driver.h                         | 2 +-
 include/linux/mlx5/mlx5_ifc.h                       | 8 +++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)


base-commit: 26469110c750c8179560637dd813e5d65b8148d2
-- 
2.44.0


