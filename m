Return-Path: <linux-rdma+bounces-16411-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOtsN/2fgWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16411-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:13:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB3D5978
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48620302D9C4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FF3921E0;
	Tue,  3 Feb 2026 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gn0KNfJW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD143921D0;
	Tue,  3 Feb 2026 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102715; cv=fail; b=pGbxeRAvzPpMO/9t/p3M+8g7+McjH8k5qnJwKKg4br22qQxDMiRb359bPveG316mwTcyzj9vDi29QpRedCDiSQq1GRShGr0taT3V440ZOlaw8rnAgfACBJQBtsmtrHf9fhhb5CpoqWg2znv0k5r8ZtZJ9Hn5hYI9uFkf79ZnZdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102715; c=relaxed/simple;
	bh=egl0fmOIj7zO5A9NIVKzGt68lYKsaGJjdvfd35iKDr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYTsBO7vSEci28/QVdWmrV692jjCTP/UXwUzuDfBaaAyoLSk/ScCDhXCpGJ8HamPqpHd1/LtWjuPI6Au4a5jeFUswu0KR0vrE8VILd8byDYHUquKNxhvAmwgKbj4FCecX63HQ88JSa3XvTpbFYFokVkEHRY0HFygxB0I3qVsfeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gn0KNfJW; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz0i0RO5t0eVfR87uEnsnV+dVjTjwD+0xnU051a8SQvpshoVVrK3vqevkrlRT2zTRX298P+ZBSLR0IVUEeRxLcqEnnJG8fbTajh2DSgJlmZlHGd7X6VLCR9SSrlyWGi8I1p3yhO8C9BW05WT1fTs5zTsjX87HxzjNITixw7lT6QoZ7n8G4/Ycu+3qUrV344N3LpRtjbjXP55X8mnrwQJ3gtkOKBV/BLpBtXG7E/VbAvgaWY7bzfsoV29l+b4WYndolE5gIRiTRTS3DyqRVfLPGayyIViAtD+hj96EhFwol5KHUbEPQ8j2CTvPzTfPfFgzg9kgzl8Ft88AaYfCo3K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNetfffhvdWWj85Ax7O4Nt/B0AJj8D5JWKtCOpcOSp4=;
 b=SxJLYgbWCnczHhtcLW1vYGETjPdzq+Mj9ymJ5B8FtKHKRrb+7bakmxd0PL9wZ2llw3xQKPTJ1kOf7dzGJPJtHLU8DDyx6k8rWMBoBubhczqVyD+zvbl+7MlBxRNekTrGI2W4eV+iS6kYjMjqiRQaqlFls+7FA/fDOpT1kagjzwyxRYeU+EYa8v8fO6tak7xaP4HB019kzdvEvE9nPtU/pXaACjdhqpAI9qotV10or2HAOfKkvTh6u4TAh0oM/dFH7Sp3bJpchVuO49t4PlUu3qyiYG9IyKh/sCfeNgFyrCFNuoe9ERFlySod+AP5JKEiZweQEjLxHHI1hR4ij72H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNetfffhvdWWj85Ax7O4Nt/B0AJj8D5JWKtCOpcOSp4=;
 b=gn0KNfJWISLBIWuZPYXNVy9Q7s4SFDE/2czT7i94gWtwNSsv5jhFAcWnX5vY+1OJqCLt7A3IoGjOoWuYCswNb4PjJye5RMbMNzsvBavRkfpY4ZPg1/tvvCFejcAPCCoMIJr5FRTO4FWlRy4ENXzTimsNEHxaj6HOvQzV4+faYkmSCBj5e6n5Z8QuZb9ZA0KZftoJtWeEjN+a0V+g0OTcCrm4QyCjGLNmLFq6N+x2lCbcXyBX8j8hnB1/ZhorxiWYe3NV37rEYMzLsCqKqLUM8jlA/4jPnPlE9WhNcc0bnFa1z5D3e6Uy0upeJbYoo/qjy4Q2Wr/5zMZsFBqfoniBZw==
Received: from CH0PR03CA0311.namprd03.prod.outlook.com (2603:10b6:610:118::13)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:11:49 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::96) by CH0PR03CA0311.outlook.office365.com
 (2603:10b6:610:118::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend
 Transport; Tue, 3 Feb 2026 07:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next 4/5] selftest: netdevsim: Add devlink port resource test
Date: Tue, 3 Feb 2026 09:10:32 +0200
Message-ID: <20260203071033.1709445-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203071033.1709445-1-tariqt@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: b657ca2c-8124-4f98-458c-08de62f37faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQzMZYw5ZMGAK9vDyHUNiDlOqHeXO/uqk9oDB7ObNc5Dnidfzh4MJdmxmMsv?=
 =?us-ascii?Q?0fp9lX3CXjyFkVb3Cy+85WcfBsOA41xqcjVGlzSBF+vQYO3ia8bn1M/66iY0?=
 =?us-ascii?Q?cZ2d33QmxZn52vGkKGesfmbPCLJBaMjR3cMpcXXHkRFvSWedzGMqa1ZH9P+I?=
 =?us-ascii?Q?XKuitSr0J/D6634fKv4zDCMHCCNxM0KtF7y5ZqNiU0ylRayvRhyrnwxwzwFJ?=
 =?us-ascii?Q?8v5FPDiQHzVP54ZiLVKEMJJg8ziD12vOTX2ei78FP+5vliV+3JC2v9p3QlN/?=
 =?us-ascii?Q?kGXlWLOl2GaCNKkTVpixzHP185UR5mms5IGPrao7Vb4ysfMQoANdpg6cDJdV?=
 =?us-ascii?Q?b79wWO0977g8GWR9PIGbVbBLcM+ndWLuZ1Sz028INtMot02JrDhhpvnmj4V5?=
 =?us-ascii?Q?nuuKMSR0R/Xv+OX/94ukIe/RHBLEr4xgynvCuax2bFVoTJthFDaYdFkHU0cA?=
 =?us-ascii?Q?1hZiijomtDcvyf8YBixRsZbujAZkdbpz0W8Sm1tWWy2iqMvebrfLD9nyLp+x?=
 =?us-ascii?Q?AblEn0nBttTmHYq6gXKV+P5XOx4o1wGBaBZ6LiCLwBQciKQRKFptjrGtRpKT?=
 =?us-ascii?Q?Wr4TD/ixLDYLrmr5wAZsBSyVAXt0GYVSvEIP7Gij8jzUHe+wEI8SPLVFweX7?=
 =?us-ascii?Q?k1hqYUxWBEVhysnX/8FqUsuDCCl/SOSvoRnxxa1gI8nZ3W+ogQeyzacO/qJR?=
 =?us-ascii?Q?zeel/YqtWA+VhycvfP5Y9e3lSYodWbAU8T6d1/TI146lmYbIM8RyCsY9UWEB?=
 =?us-ascii?Q?H1p16EJ+Xob8Gqb88iFBjOsH0XxOGbiXAegl3q6NcrrRbS8M/cVu3LPavAfY?=
 =?us-ascii?Q?cOoHwmkEpbu0w3VDkC06xScNZ2IvvvpWJOQHsnpPivgwwtrHbPO2NsFJnAPf?=
 =?us-ascii?Q?6dXvcarNx3hCArNkbwv+KW4aIHShBUovVh91fqH3U7YDi6H18pD/QyA+e013?=
 =?us-ascii?Q?NAGiOA3MVKyKOk0l8vG9eccGiw55OiApGQBezPwokn6fJL1Rr9P/GdatDSed?=
 =?us-ascii?Q?0/mcz9eySAIbcibAnJw6hcRtxWXWLfy7CCp6807l0kIFe4u5shv0cpPvPHR6?=
 =?us-ascii?Q?UBy3bfDeZsFSf/3VOLnCYaEY2c5AJiwrLeVhbq/NLu775k5OCq/nvY6MFfZb?=
 =?us-ascii?Q?9fusOY8uhtRw7YSxEaI4xlNATvrI8ock+YqAgpyQdbREdnL4Cz+UaqNZBmqR?=
 =?us-ascii?Q?jVWXB/4uKFiYOdBLhDHWhPzQm9cC9skzDmL4lkjVVnHAjx7MejO2OQ2ARcuS?=
 =?us-ascii?Q?6cNzRL9/sSbMN63IevzbskBpacIeo/1ZEUac3IZTb6dSPJ47uGa50obJrbm+?=
 =?us-ascii?Q?Nj8Fh8PPOsydpdLHpVhYnkYflLecHeXUDPfuGFcPTW0IyNE7RcuP1iQ5ePOV?=
 =?us-ascii?Q?4xNhFLbAsGxxhKRAp+yh2H4D1EFEFb1c48vcreFNRtuOFpVnVBcX6A7XoWuh?=
 =?us-ascii?Q?QoaqQjHAZcF/3WN9HJZJGCC9GiGnwYryMC8J52edZBX8wtAdzxI2+Mh9Lrp+?=
 =?us-ascii?Q?bv8tkbPjkBPwNdf8lEJysTHuJ6xchcF57VNPqJjsV36bmMwuS+8pHr2SdEQH?=
 =?us-ascii?Q?DGz+GI+C69QZWPUVkWZWT+LogwM6/w+c8EY7TcaJOC3hPBXI3dEpwEC0/u1e?=
 =?us-ascii?Q?jCxHTCscLJcYu2CekcKB68c0jl4IWiQu3oYRRAiIaKgmglYWce4PWHCcZMpj?=
 =?us-ascii?Q?re2xBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EgKlvxBtVhjVT3+X2gUfA4hPKX8z85a1rQ2ABlSHFeqjqAk1DyILbeJS7gsBM2HtdzW1ztnOR4Oa8xD7daAe7c7uZ/ukPAeHYTXqr86vdwETuxTT/o1ZNUohZD+Tqh4EjFpWj/pqeQAj4wuJwtvTbcmSZ7PMhND/n0+8pbJeWwO9u113pOuSENwaHy60IrKxG8BkWryQJactWS/hFmiBvk6rWzHEWsoma+xzEAQenNr8gPBDuB40C8IoqfppgQZ/uONza7uHoRooqOwQxAjjMc9+yAZSiE86rOwu5sRn2eY98OF+z4Urk/YIayz4XcX3Upkv3ZEUoWxY26bJMvm3vvjBA6DWAGSP97z5yZ4rMMm8qwRlE9CvePG/KrwGYT5vcVkSHmNTvaaOGjpB5WfWN/gWULmCHf3RwAjX/Es/NSPOOQMy3LfHf82Zkfu4qVRl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:49.0195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b657ca2c-8124-4f98-458c-08de62f37faa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16411-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CADB3D5978
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add selftest to verify port-level resource functionality using netdevsim.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 1b529ccaf050..674f0e981ab0 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test dev_info_test \
+	   netns_reload_test resource_test port_resource_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
 source $lib_dir/lib.sh
@@ -856,6 +856,36 @@ rate_test()
 	log_test "rate test"
 }
 
+port_resource_test()
+{
+	RET=0
+
+	local first_port="${DL_HANDLE}/0"
+	local name
+	local size
+
+	devlink port resource show "$first_port" > /dev/null 2>&1
+	check_err $? "Failed to show port resource for $first_port"
+
+	name=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].name")
+	[ "$name" == "max_sfs" ]
+	check_err $? "Unexpected resource name $name (expected max_sfs)"
+
+	size=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].size")
+	[ "$size" == "20" ]
+	check_err $? "Unexpected resource size $size (expected 20)"
+
+	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
+	check_err $? "Failed to show port resources for $DL_HANDLE"
+
+	devlink port resource show > /dev/null 2>&1
+	check_err $? "Failed to dump all port resources"
+
+	log_test "port resource test"
+}
+
 setup_prepare()
 {
 	modprobe netdevsim
-- 
2.40.1


