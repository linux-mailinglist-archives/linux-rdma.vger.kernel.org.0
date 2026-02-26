Return-Path: <linux-rdma+bounces-17226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBIFFV5UoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:10:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F17571A740F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE62730568FC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC173C196B;
	Thu, 26 Feb 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JlG4703U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E663B95F8;
	Thu, 26 Feb 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113997; cv=fail; b=H4fAS8APhcag/m3VDoCCN2m6XV0ZZXCPY13MOujzuEPDp0j9sISaOgN/lJ1zdtz1AkLLpDlQE274xiKf4BVCPK9j6musGwD+82wYzgueti8bzHUDQundCtg/o34WiqL06lr9b0rTth3Jfk1SSbFAuCIVNBASVbhXC21/NfvxHnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113997; c=relaxed/simple;
	bh=n0pUF0t8hUpSUH94/0KWJyiyf6Kq8iUEwkX3T1iiROU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IBjpKZv79i6Z0YzIfG93391n+kw/jTKLSKh6RHSeDE6sjhsWW+6bCdLipgbEhYAGF8sVvyFwN5B+cA2vMeXhe9CsxuFslvm7lSSv6FT2etTFMXuktsZbqw76FKGr/jCC9ePP+iaisEjMdoVUm5Pk2jfZ3z9/AX0a6ZD3yqZ1CMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JlG4703U; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNEL42rooJAA8lgqlafZziPkEzA1UqMb8bhAXXddqPK5XxV9KYcZJqeZPmWcUesxGySUGCRXl+o1mr52e68txSDeZo8w5KVk3wZ7qB6mjVpOuz3pztWgb4PLhug5nZqNmbmOFp6sPKatzjXUlFQRu2/vqu2CS1ZAwuf9moPdUaP/En7yDeev/Ijzrjdyyw2Nkj3Af/akYSpfhw/wcNawfXvBNZW5gDJT2OjEuwwB/XnWub6921gfqSuMZf5gLPTbElVweL6C2pLSjnbtwL7nHZZHdn57zK/kjEh8A/u8q9SUTbiCqLqa3YAsKjxZUmOmnrNvr1BK5EJ+/t17QFHnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTxRER+Y7a/zgWBcYSPIAUqdrts9Fp7Hbnt253InIC0=;
 b=NqHSVkYJ5OjCwsVl9onYSvUPqt0vZmDj8jV8XGk5oxsNmV3Nl5Jvlnytdy/c4cf/qcSfJ5W1rxMW/ib4oIAI0XrTL1bwc1LU7AFmYAdxObYLBnmflu+5yjJ0CuxnNMZ+fZpGBzp/MHklgs669fvatam9kvPa2Z6nSJd+EpPTXspgYg2+Ezn1l/tu0XD29Os+53r1ZbG4l7NqpBqn7F/fkLs7jRsYI57MX2NvzRew+vnV8ioztX1V+ZzQU8W9roIDS2NIQ+/b52ZLyZJ7sE05P7uM+uxrj2h3G3BSdUNhHYEReODmHvW/fAIGy9FnRB0kxYA5ZMkQFywK0rxnDuSV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTxRER+Y7a/zgWBcYSPIAUqdrts9Fp7Hbnt253InIC0=;
 b=JlG4703UiYUQha4Wny+Y4dYwDSqRyXhu7fxj3PVRtMTFEX1VeqZ7/susVRr0VsTqRaX6fsSFn62SgfwrZU7ocqh7YT3LGMLFAdKbE9Zl+sbCOSkbb0csDE2vINx0arrbUDhNK5FTVDOBSjWCYsxnpGSEXsimX1BFkarIX5q9mj2F3ophizEFhEHbfuWqIu3LXP7kZH47ZnjShHGlwlsvO+GOKildZ8sym76gog22e+gHhr6aGzlcCa8+FEqn9zrrxLWOfIv0AcV1LYP4AF53bAUiO7zMVUTo3MtcRYE7d10RWQcEM5avdEue7c4e5tx21JVEk5JGP/r/0dLK6daZeA==
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Thu, 26 Feb 2026 13:53:10 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::1) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Thu,
 26 Feb 2026 13:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:58 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:55 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:14 +0200
Subject: [PATCH rdma-next v4 09/11] RDMA/core: Add netlink command to
 modify FRMR aging
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-9-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=6608;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=R+5iDSghDu9XC4/xZ5D2yvPOr3YHulTlp4RNrwPZ4dg=;
 b=WTaFbZHaoOONHWBc5fgvnjeuknY54y7GYTEvdtKpWxi5dleMkFoxUU1cTWpu4/p3hKgrb8Lsv
 MnOZap0lniRAkJgmFr1AFIBfkW5iQ1NwqY6eomy3XQvrX3+s+7ZisbD
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5939b518-5431-4ae9-03df-08de753e60a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	MyIYEgKtqiIroK0hR95PvAoC5CoCYXaLUShuzvIgqPvxbZkuZ1WvKKj8nEii0nJAz3yaIiA/3OWSKwXnHzx2snNEGd8+Y3ZvFjLysSphLjZWkmvtIEAEmVeo2xND7hRGygmT96alOK7WYK8mIl4uNMYW1iYK49ojqTL7yWJHdWGsKaBzrupUeHDKM/eJzGbCSMfdo1ELvjy0+BIA1j9EH5xCqty4fhPmuCXjFlyKP1AhQwLLCAQNshQOXVesIfCWQRi6us1pUQDsraAmyshMii27B/ha1IjFEDY7K74g74VHTk29RxMzf4AAXxoNJx7tXOlvS49iS0KiSDvkz9OSDi866PGvhDK3BTFQNrPhuuZMEjhnUjX3ZmxJmMuqKfeK2xtR1YptCiRjkTTKcpscwSsmTZkWM2+e47pH+q/DV5C+tpwKvLGxEv4WuhcgMuerkiqAJOh3tO1goB9ny8UYwS3I0y13z1avjzCXhYDz5GajrzO/sp3XHYiir0tLv3P9S1fGWXQmDYcM4xmlRlKMqIFRmuml3TTPIXIJBR/5rodD33zs7iT5yf/6vz39LnYK8S2Ea/mMOwyM1UFpl9cFWwDMtlu6wNeov35qI7nxZFgW+scXFD6o+plnYjhl4i2hgeuXjxB+fCKZYiqqUg8scXSYKblj/YPs9Ks0vu4acw8AF22SFKP1NQNPKagVf5RMrV0aK7LMJBAXGaQsd4SQ3r2CR9y9MGOftKsR7YZ79gOipwUcofO/2Dj0839PLafpjNXOGoSwIFcAwOUX275DcXq1ZCKYnfcdaPlXhRdHCU88HhxG6fx0X0tn6zpMgf8apaTzxVX0X5JDBO+VZ0E93G5uE9N99NhYbUolnB8TUrQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b9YDXJEDiFwzxgbfuVoS7x++/BXX/PWCh78YZsemKurhWGOBSmVLh7TSLnkMR9iXjAO0JwkO1k+SE8grEucosdXlMrta1b3+HsHUV3tRx6tH7x5KJuqDfgmKo/ZXGQvCFj6Id7wkOV2FLLzCecBorGM/iR/OtzXjKK12xTTXNah7RldVh7dODbDTY17E2afxtQB6tXSjT0WLG4t9cVW7eGR9+pdJA4s02X9sOg+Ks+eEhxbbwDo7vjYjG0tdtI1OVBuqJCwbFvJ1w407akoAFU0Ugn+DJIKHRcTZhNN3iM8bPH8VnEvF4rFPzWeKbjyVUck5SopqRlUJbotjGxVtGFm8Zgonc6KweXKcYdHXuhmGVsQL8hdJd//aaILNjGKW9InQ2RPUFy2XnoOfj/zjrFbxAZHM36LhkJbB8vxBwtXIzRs0qdK6qKdDFgGRJLLU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:10.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5939b518-5431-4ae9-03df-08de753e60a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17226-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:server fail,Nvidia.com:server fail,sto.lore.kernel.org:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F17571A740F
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set FRMR pools aging timer through netlink.
This functionality will allow user to control how long handles reside in
the kernel before being destroyed, thus being able to tune the tradeoff
between memory and HW object consumption and memory registration
optimization.
Since FRMR pools is highly beneficial for application restart scenarios,
this command allows users to modify the aging timer to their application
restart time, making sure the FRMR handles deregistered on application
teardown are kept for long enough in the pools for reuse in the
application startup.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 31 ++++++++++++++++++++++++++++--
 drivers/infiniband/core/frmr_pools.h |  2 ++
 drivers/infiniband/core/nldev.c      | 37 ++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h     |  3 +++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 74504151ad237fbb50f404034521e60a38571913..d50c5473e73eae3e9a939db07030418e5389b93e 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -174,7 +174,7 @@ static void pool_aging_work(struct work_struct *work)
 	if (has_work)
 		queue_delayed_work(
 			pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 }
 
 static void destroy_frmr_pool(struct ib_device *device,
@@ -213,6 +213,8 @@ int ib_frmr_pools_init(struct ib_device *device,
 		return -ENOMEM;
 	}
 
+	pools->aging_period_sec = FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS;
+
 	device->frmr_pools = pools;
 	return 0;
 }
@@ -245,6 +247,31 @@ void ib_frmr_pools_cleanup(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_frmr_pools_cleanup);
 
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct rb_node *node;
+
+	if (!pools)
+		return -EINVAL;
+
+	if (period_sec == 0)
+		return -EINVAL;
+
+	WRITE_ONCE(pools->aging_period_sec, period_sec);
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		mod_delayed_work(pools->aging_wq, &pool->aging_work,
+				 secs_to_jiffies(period_sec));
+	}
+	read_unlock(&pools->rb_lock);
+
+	return 0;
+}
+
 static inline int compare_keys(struct ib_frmr_key *key1,
 			       struct ib_frmr_key *key2)
 {
@@ -513,7 +540,7 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 
 	if (ret == 0 && schedule_aging)
 		queue_delayed_work(pools->aging_wq, &pool->aging_work,
-			secs_to_jiffies(FRMR_POOLS_DEFAULT_AGING_PERIOD_SECS));
+			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 
 	return ret;
 }
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index b144273ee34785623d2254d19f5af40869e00e83..81149ff15e003358b6d060c98fb68120c9a0e8b9 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -54,8 +54,10 @@ struct ib_frmr_pools {
 	const struct ib_frmr_pool_ops *pool_ops;
 
 	struct workqueue_struct *aging_wq;
+	u32 aging_period_sec;
 };
 
 int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 			     u32 pinned_handles);
+int ib_frmr_pools_set_aging_period(struct ib_device *device, u32 period_sec);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 6637c76165be2555a732ce8e062e886f4309ce40..8d004b7568b7b48e7103abbf0b7c3fb7acacba4f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -184,6 +184,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2799,6 +2800,38 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
+				     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_device *device;
+	u32 aging_period;
+	int err;
+
+	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
+			  extack);
+	if (err)
+		return err;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+
+	err = ib_frmr_pools_set_aging_period(device, aging_period);
+
+	ib_device_put(device);
+	return err;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2908,6 +2941,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
 		.dump = nldev_frmr_pools_get_dumpit,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_SET] = {
+		.doit = nldev_frmr_pools_set_doit,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8f17ffe0190cb86131109209c45caec155ab36da..f9c295caf2b1625e3636d4279a539d481fdeb4ac 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -310,6 +310,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -598,6 +600,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.49.0


