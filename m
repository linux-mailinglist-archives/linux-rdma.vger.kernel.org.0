Return-Path: <linux-rdma+bounces-15969-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GChMAP3/dWmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15969-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2514804FC
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AAD7302AF22
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAAE31B81B;
	Sun, 25 Jan 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hq7F+xqj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9F31AAA8;
	Sun, 25 Jan 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340802; cv=fail; b=O3SgNixlESRk6xFGe4LLLd2vQGQyPQ+9JoUpgcJDWnu8bIFGLBu+IjWHe09bYAPbk3BiAd7F35oIfg0SRLllAXGituIb1Xow6Oix0ZvA2ws+XFqkjdnPzVeLZdKOsf2rECuWiWX/kovcV6VoR56Q20iTSQ8U6RqFIPwHqtweZj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340802; c=relaxed/simple;
	bh=gzNdEMCDQ2+arF2K33LtZLZOSaDZtZndy7JQdvfru1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PynFzvVNo9jHF3qPyMgw9s0qUuNgCq0z+LDmlt1ywAbqf7fKC8ISgBnHiwRUBwtiPhjgPa3bWB5607KmAYYiwdme8gO8PLlFw61c5g/4Z5LIQEFvDW8KtTRm5z/5boKoTrosUEZLC03N7qG6OsyI3xMUEg1cS75Zi8ocfRT1a7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hq7F+xqj; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEImDQNufZ1yKvy9qnwg9/PQXkVL+MxD52z7+hbM/5RJOkZPxY0jRXWs3cqEbC5oIwC6AVWlQmkEDCZg7nVKLGAEX5AxYgpDMM/AMsJ9CS7GW7VxE1eMQco3usJW44nmxOEKKXNfVMoSsgyZCybFjlG0Tay8aEkYUDsiP32/6JMOYJKFBqai4kyW0q2WThM8hzoFH9hssSt2HzPBNQyBVc/1DdxP/t2DmfTSbRsU8vCesc0TSCuriaLTpAYFiqkpVni7o3zRNmntYy/ttRr+muoJLORq4JD3RiIGjG56Kvz4azuYT0ELagkIufa4gIj7ILHJqnJHvZ5L4jhCdOU9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YUDru1uagGTzqKz3V9/cC8FwgHxeU6cfPpxQwIjclE=;
 b=csStMXn4E3nJmj2pS6pv55bdRV5GbCbNnu5fArxM4CRnTqaOMO/VoJd7r7E/7IBK6oTzhNZ19csgPJ4p6/EKIcSglH292pFs0ZUMl+qTB1616roGrnHO+s7O9AuK4Dql3HLSzATUz3sKv8zBYJS4iom9tw30qaKlDAJS6EPozghhcJTVU8qJ7Z2ai1wupRX9HdY/Kgmi46nb1s7pBHFqN+oKBT8QsqIvAJZkdxZofjxCT/zFRQAYOyfuiD+Xvp3GCwYxhNdHB/hQtq6AERjo7JtG18O7a7Dzm4no8y+aPphoHk3n3eJHEFm9pKre/b0nShP2Lb7+9fa6cHseQw9dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YUDru1uagGTzqKz3V9/cC8FwgHxeU6cfPpxQwIjclE=;
 b=hq7F+xqjnLHoWLIKjNIDq1jNZDJAO0f3dxOU2KO7878hqxkjdmb6LSlaKD0HrEI0H4NOPCVFtHrMH2YR+lfDL3/pa5rlpeSO9Ug8lUF6t1Sk1+Ayibgw+oLbIy0JDklc5WaDxS0pS8iiQUtRpjgCXdkoNK/ZsAqHJ5ZPhjT6Gy6LETeuBNd5OuPytHFCn1fucIs6J121hsGrpQvNMbF6vLsHtuT/ukt0N7eUmsz+RENPAH1po1AXTFX5lJNyvVycDUIw0+lfbZZXT2lczZErvac40hDaf+dIGvhCbHFOwetqGZGO17iYaY5LhwLFu8xlGlrWsqIrBhu1Vg330DcK5w==
Received: from SA9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::17)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sun, 25 Jan
 2026 11:33:17 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::7e) by SA9P221CA0012.outlook.office365.com
 (2603:10b6:806:25::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V6 04/14] devlink: Add helpers to lock nested-in instances
Date: Sun, 25 Jan 2026 13:31:53 +0200
Message-ID: <1769340723-14199-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ebc70d-8e2d-48b9-8851-08de5c05888b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GkMhEvv69C6izCreorCdq6BzI3b1f8SXLxD+I2sslqJbrrYHNceHv8WDTWUY?=
 =?us-ascii?Q?G1CJ1VyD1+np2th1R+K8VaDRL4Vu7gPv2PboSAv1aWO+kgFL8ybCETRQBfJG?=
 =?us-ascii?Q?kHcHqR0hRE9wSnA7BDFSl6DZNW88SAbvZFL7pDINo2lp4bebDk2YD4ZTHPcH?=
 =?us-ascii?Q?HJjJE+NUIPaADm3E7kt234AnZekBuvf4/kzs5kjxWzYWHiTx/gT48lGmBahr?=
 =?us-ascii?Q?/PPrqlU29P2JvVhf60/V3cVmml/iGh4xO8SrsGvkYN9sNtZ7Hw9QXXTMsWlj?=
 =?us-ascii?Q?kkyRzLepjV8eH8nsIQ9RdUmuAhlgqttox1gc819Mfsmi70br7MpwxoyigtbH?=
 =?us-ascii?Q?tOI1C4QvQ8QxhpaM4eC4RXR80GA/6cUaEsC0syqFJZ5plZf0Duz6/pgATS3f?=
 =?us-ascii?Q?i92PV8ZNkcImXpnsxF6iMoXLsZY9dJP/rBoCkQpVg04v++CKtp73STqsbCoE?=
 =?us-ascii?Q?gUinyPa4WSxXF2llKSIAEVyeN48FGES1+r3NkOtQmGpG0lqmnh68+K6lFYnV?=
 =?us-ascii?Q?FUTshj4H4LjWUur8xj/cmiEp+NwqhrPkS5/rTmV9fVENMdQH1o73tMp6dIfh?=
 =?us-ascii?Q?j4LKZBqlh4aoYFhNVcX8RDniosqEPaleb0VhK+tN4Q0jZAE6+NtvzrhTDaya?=
 =?us-ascii?Q?bUF9PQ7ALC+dgjnPqldD3/dY4Rv8mrWzUup4M+A1YlyorXcCKiDt0N+KgYx8?=
 =?us-ascii?Q?rURFUzilVyERjbKsPQ7fS4FR7fruM/exXZCPDYFMuQw/U/e+PQHP4PKG/lBu?=
 =?us-ascii?Q?zo3GonSu//v+6upMajTi4KNtlzcfi7ZORe9WHMLRiJdO+7FVLq5vUpiXg2ji?=
 =?us-ascii?Q?9kRILsfTl+qtsZy+rveiCKdBKbMig+9btcfVI3awK3pcRSmdAFX5wTazC3g+?=
 =?us-ascii?Q?c90nXvRfSXBJRju74Wr6sW8oY0zlyzRObcJp+PmU3/NAFi43p1rXEs09Og4W?=
 =?us-ascii?Q?BF79hOX2om5hGeH/op9QzvTHIim1nBSm7c/V6haFPx/H7/gJg2XeEA/y4/kw?=
 =?us-ascii?Q?B3HNvHCqeTbF/YU0IrNpXLr7LcQq32iFsz1dDn5/FFb8opsd31uu/uOrx6Bn?=
 =?us-ascii?Q?uTpFGnH5grO0+6XRBhCTDazbBI9y9bQn2ZXOFi6xnmvVlvRuJNjXp7rD2M3H?=
 =?us-ascii?Q?yU4FEnt93RIwzCA69XrxxsF/rbtV69hoy+sfBgT+5ByrbfkjYeAzqsormxI0?=
 =?us-ascii?Q?DCez4A+UTVShrDZ/iLpwLcyWRHRMHZyAaYxsL6gu2F/l4lLembpuMsE1A0PD?=
 =?us-ascii?Q?qHRNZ2WZJe+WARPyYi3UGknmvxVwRMjCNQEYpGPXbmDaI8t4XopcM7ansYNc?=
 =?us-ascii?Q?iQSUw8IfVBIfUkayMg208vefmqT1dy38XdgMAJj5/8rl/spAJfbzpLz2vX5J?=
 =?us-ascii?Q?KGo8M+XSYE/T7jYA7CVQa1V+rbQU6x6J1J/27qFeEbp3CMLoStEt+MKr9s6L?=
 =?us-ascii?Q?BIZCG2lhHub3wdyqA1f6NfeG8yrUPoc812hhPMBXnHFGom1f4tzZxr0V/Br/?=
 =?us-ascii?Q?8iptEnbOV9Fiq1Wb9/F9OWLqao0q5TiuNj+rl621NWBiIbfH5+HH89PVIN8O?=
 =?us-ascii?Q?PjZ5XHNtDuy7p8Cg7XxvoIY7VzJNPVXdtXVRhPmLByRmxW67ot1XTclsWkwE?=
 =?us-ascii?Q?2DVplcrBiwbwfXu63x9VJyNCjChR7/OXtuMxnQkSETEpFTs57ajKFgHWdneE?=
 =?us-ascii?Q?33OCCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:16.7083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ebc70d-8e2d-48b9-8851-08de5c05888b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15969-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B2514804FC
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming code will need to obtain a reference to locked nested-in
devlink instances. Add helpers to lock, obtain an already locked
reference and unlock/unref the nested-in instance.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          | 42 +++++++++++++++++++++++++++++++++++++
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6ae62c7f2a80..f228190df346 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -67,6 +67,48 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 		devlink_rel_free(rel);
 }
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+
+	if (!rel)
+		return NULL;
+	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
+	if (!devlink)
+		return NULL;
+	devl_lock(devlink);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_unlock(devlink);
+	devlink_put(devlink);
+	return NULL;
+}
+
+/* Returns the nested in devlink object and validates its lock is held. */
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+	unsigned long index;
+
+	if (!rel)
+		return NULL;
+	index = rel->nested_in.devlink_index;
+	devlink = xa_find(&devlinks, &index, index, DEVLINK_REGISTERED);
+	if (devlink)
+		devl_assert_locked(devlink);
+	return devlink;
+}
+
+void devlink_nested_in_put_unlock(struct devlink_rel *rel)
+{
+	struct devlink *devlink = devlink_nested_in_get_locked(rel);
+
+	if (devlink) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
+}
+
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 14eaad9cfe35..aea43d750d23 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -120,6 +120,9 @@ typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel);
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel);
+void devlink_nested_in_put_unlock(struct devlink_rel *rel);
 void devlink_rel_nested_in_clear(u32 rel_index);
 int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
 			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
-- 
2.40.1


