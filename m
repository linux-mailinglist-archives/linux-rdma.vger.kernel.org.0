Return-Path: <linux-rdma+bounces-18172-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPZSHBrUt2n0VgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18172-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:57:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BB297872
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D4D4308D77C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737938E11F;
	Mon, 16 Mar 2026 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xuvlymt7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DB26059D;
	Mon, 16 Mar 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654410; cv=fail; b=ndX/tg+HMuyZzQtTTHpjtGR7mwQJTGguqbmusJEkDt5NO6jzzYw7fBzVgtYyWjlLHpZDjKJOmXCofQQ0y3eaT49tk3iJFWdw0yJHe4BassIdOxcyd9pNLvdEVVr0G0S08nZHXHRp8lGelCZffOIsMGPwb9/h1SeNCqZNY9JfUxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654410; c=relaxed/simple;
	bh=PIwkQq0fH9IMSz+C/XFKpLScCfrzmr3hrdagycUgQXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRpLixsmPE/WdCuurl709W+vg75IqSOlRNkPcl3jbHeQ3Iy/QKrWu69VXZOJ8vDmjFAr5DlQaBOB+YHWpTlsNc1VySzC2ieiwrbUb1JxOlPRtoizPwH6tLWl9PaqYe+2JRRYC/LGTGJJ4N9bh0DnTbMgeBryN2ts+Ph2/rxQ+w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xuvlymt7; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgvoMGd0c5We8Ui+lGeRI8DKDt6vJ2luVRGlCtgfA2EI4mMphM7oQ2+dAyiycaIEAi1slUbVryopl001+RnhTXkwPu3DgtXzSsgCEX3BwYhRgnIRu8QUVx+hUozs7IfIYMvq9ZrzxPZLyZBhFsiW5yagqxfWrWH9RHiHHJVUxHqlklHy4gMbAZ0KdSA0dORIATJH82IELiplC8eQ3c1rZC1/cXq9TTy+783QeAHEuXcJfLTXco4uCj9HT5CI2voWaOckhw3PyiZLhHAficwzCq5BadLQUDXihcCvdcUnAuOcEyVSjfrrzp378Vg5Qq4C31M9hL8lgJdePVVQqjbDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6tYvGg7gGqhhS9OPvJuDUPtdwJVYDfxdReiAPL9ERY=;
 b=Cd+AAzzID/l5ehFpXCNZ7vF+x5AGrVcRnwCswa8V2sXUE7PeoYMCJsjLa3qziwqaWu6gXtKR0OY02TpoxTKB6+q9Ncb6OQYHSQBLZQ8X0PNb0aXDqbkKKIHO/M+SNsU44QfB5Egw6S08NWcLhCRoByzYhdurT2S/cp/7aSIc41FHoSupvr+Ca11JHE1G7GLwfZQF9/r5aJVgGryblDBiRlltjl2JbXCJQr1QFj6baKn+8sOp7DvRFt27x6CsPhk3OkJIU9R3wa15LJfWLmiR8huted77tTPx8kGKo3ZSlNe3HWM/OBOo6eQ8CwswdcnMpjUOROR47zYLyN1dUU9Bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6tYvGg7gGqhhS9OPvJuDUPtdwJVYDfxdReiAPL9ERY=;
 b=Xuvlymt7ezlqdPkGvd9u0OQGbqaXwOGMOhHWuVc9i4HVMmD9rHfVGGeEkX1/zczduLOKKHfDkmt/P+pHa0v1OZm/ACZ7AeATbmN+sRBe6ywqhRClP6YNs2C3v8K0Cy/gCEfDt25Wh1apyjOcFuYMsrknMbN20YAeIsi5lZtuEHTvVXr2tcjZTqKGeEw+EoNfyWfo3sqHwLVcTOU0IsxFB4XwAZtkZbZH5juLMcuVdgDEInpoEC2PVHU7LEPp+U4efMnRo9CQwSpKBDBu2JXWXr/ykODo5o7nNaEd6qy7875afGEo3eNX7O8zEYJk3q/AC6vJLRYxYbczf83xr83MpQ==
Received: from CH2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:610:50::40)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 09:46:44 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::ef) by CH2PR16CA0030.outlook.office365.com
 (2603:10b6:610:50::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 09:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 09:46:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 02:46:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 02:46:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 02:46:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2026-03-16
Date: Mon, 16 Mar 2026 11:46:00 +0200
Message-ID: <20260316094603.6999-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: eae105a5-7bb0-45aa-ff85-08de8340ef0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bART4y2Ox1GEilO0k+/clErL7cTQxxgE8o87D6+/9YDzHzIieZmsSgE391+7nCcFQ8S9jr+Nca4cOVvWu8lFXbgiP+bLYZ5dAXZggZUmH71aF7JQENXtSyGFh70w8pQvcCAxLdd8ZSDUprKDJVkykrIg+4gEcrHiDLJuUAEFvxkOjIM4TfKpUjidC9lIx9v/amZ7gxmt3j0wo5Uj0i7+DmOTsLAokedsQuJmJyiITRJRQlZLkWjTVqIvxoyEcIi+mHhosHHbUjPUnMws8eKELdB/wVOAFcc2WQm8JKQ7jNTabMl/uNur2S7bPIHECw77YnXTsZUQeF/HYbOnei+xh3GN5pGr+0BfZzP7O5UsZijlGL1IjO5oU6vWGvCm1VCfrlvcyKdWMd4XvQbNfEOPCAOcXHqkZuSwHyNBvUkImMcBikYhN5Ue1N0NFXO4y2cBIYeFi21TNIM1bTzrS8y9ffG96BsO0BOdxREulFEtPJJOF3wBd9hZch8/F9NjbRp0E+a6OJ9K/6u2wRJOWlNGOyel9KjNFDP/pJbPvWNO6TdqqeQDqsbDXNZmfqOodZXYEkXJjzZ1LCFYo835YBzf1c7MeC+cgCxdyWZFKAsar/6McFh4/CfAGnaXbYCLSnk1jZmyrO4eqBwkKhNeeU5UOO9Tw+AEub0yJGQLaXuYiNdpPmuT3nEdYGYOPPZ7MqwyZxprvt0baJ+EjpiF7kR3UDn62saCvAeh4+sCg8dKfp1anZdLM3NW5o+p/Iw/8dpEXuAAEaNxpeAqX22PtElhaw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2fniLjdS/JoLmLNgH65UoPvhHl4L26enH64px6peGUHcYR+vU2dI8WmLYcxrBokp1ft7A7bT2U+imegt4zTHYKkQiagUyMUP+NoCiG3xKO36QBiJls3bGSSig8AMgLSdi+3dfaaQRK+nW5lYI0khG2uM+uj3bzWMlxjJGBQSTh1kk3u2AXuaBgS+EJ0d1wl6WQNB7oJCTiyevqbJLWJiUGBROqEOWDjAGgwiv/tzNX9OJ2hsmqQHdCGjv1eqNhp/FdKgdmoQvn/Jfy1GpbHpk7FieBsafcsBuwy4HOJ1dKzzEfBIA0R+bu83j5gUy3pmr1FH28iLIC44ntCHn3Ic7F6fujGT3weVYzuLVqFddNt3vvokcp5hfdfkLcIgrZjIhZTBgbMJrQh6Xjz+jBBFF4rma/A7g+uNQmCVWj4Hg2rMl+NgAThT6KmQ7cBEiq65
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:46:44.3423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eae105a5-7bb0-45aa-ff85-08de8340ef0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18172-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 030BB297872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

Cosmin Ratiu (1):
  net/mlx5: qos: Restrict RTNL area to avoid a lock cycle

Jianbo Liu (2):
  net/mlx5e: Prevent concurrent access to IPSec ASO context
  net/mlx5e: Fix race condition during IPSec ESN update

 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 +
 .../mlx5/core/en_accel/ipsec_offload.c        | 50 ++++++++-----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 23 ++++-----
 3 files changed, 32 insertions(+), 42 deletions(-)


base-commit: 43d222fbcdff9a715dbe63a0c9e5902f1c9ddd10
-- 
2.44.0


