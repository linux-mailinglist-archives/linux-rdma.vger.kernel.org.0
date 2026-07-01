Return-Path: <linux-rdma+bounces-22640-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U65IMSgMRWpX5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22640-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 393AD6ED892
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=T2aMs+4w;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22640-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22640-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B73A328F76A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8F4963D5;
	Wed,  1 Jul 2026 12:29:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC94963DB;
	Wed,  1 Jul 2026 12:29:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908965; cv=fail; b=N5Y1lVS2LWac9+AI+v72YUPR4xcfVOIKsk6IGT4lzSjDH9cCg+arJe/bSavrPHVR8HzD1kXBgX0UpnzmGtt21XjlAodWAdar0OTNmMomBSZ6t7De1NaurndFpn6RFtFkaRDgrdMx12vvCSdZBP/nRcvoy8Mo1CJ5LnpxWXPukQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908965; c=relaxed/simple;
	bh=Vt9ZlM30PkQ1zNX1IBG1omQHLzQfl7o6PrRiDbYOzFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kfmxqIjd9GJLB1H0ghUp3Ykio69vQ5I8xCV3p/G1LS3QrxULlKgU49AF73I28PjJGcUgoX6TUB/PVhJ55V3SA40KzHak0DJwAf0nBXJbueI8vzz2WrvtJF6fAIm042Z2iAKORIaoP/b3gAFuJbXYDEUmlJREaMTptovJEYAl8nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T2aMs+4w; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qggrhHfPo9TAX2Jwpy9Qezmicivkgy4nnnw7cIVTdtPJG3yftxEC6yO5zfztDMh75C4+GjPEVNOqnzPUjLOaAvR76Vj3gPGkRBflmHHNJ/Q7ZpqtbnQY3eKA7Cq9APqH4nlviQ/vmpnaiNbLQOTTwbgoaCLMUuKuWlDi1FZtOrUGNJ/zwMIVLx2r1o+oH5yaCj/WPUiwHJUcmWxgsri2I1+u1p7FLewk/Iy/QQAXtHaJCGFmdJJ5tOz+Prd44/XkquT05+Ph5HzEKpeDPWumqL7X9lgLO73CBTlwMFO6OeaRKpZDqJG3ldE+MOq+5sOZ71mqqLYIQ9tY4EQso30Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=383NTG1HYU1Jw0b2zygGl9BJ1U7FwiEB9NxcGHRbErw=;
 b=sNkvHNB6MwLZ8eJKKSCqT4CVgz/8f13HX0DQpfmsi4ijp1pL00E0wbG+u3pSk0jTbR0sJflP3Ox3f9538imGyH3LMCr3qjqsYiJ0gP/y+GLkkPnHA2f7wKiAaGvQikQqMAmRHJHf3jR4oSeiOMYOnOq3VmWMsHtACS4kENoT1OOID0JAYUcC33h42XzeFZBgJxGKnKpovpaYhoxjvS9FR+vm3HXlTFS0m2sF5x93d/ap3D0jNZzYqTqf9Lz9AAeqG+6D4q3kA2YHohDeI3YBrJdO38WGGH1c5S0r3ofkfbwEldiwBi1Lhb8nvddCDUH+pWH/9dVIyvjiEkuFRk8/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=383NTG1HYU1Jw0b2zygGl9BJ1U7FwiEB9NxcGHRbErw=;
 b=T2aMs+4wck862AZLh1MR235uhvxkX3AXBd6t8UD+e1t6l3XyypORMCkQDkZBzdQOiWmcbGr07Pm5Akuo7B5t87J11ZMj3HyWfvQXiw5sZ75WeiDHZbfOnBDLq2DQwfCWEDeorXGMweYysrc4PfCWK9YwV7gM/5ZkTi4iTg6XNCLw51woZaOOGJ/NE03LT5jRoRjE5/NAKCrGUA9/tBsVaXn+Fe6f0KbngVsTrZoz5jRST5mXncljkDE21GvbKZzFulk/9y7wNFQanjTJQ/E8sANmgyb7Z7pinttgfkQ8e0weTPPfVz3XQ410saxfafSKEjGTrL0RkwO4Ri4+x2nRfA==
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:29:14 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::35) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 12:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 05:29:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:29:00 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:57 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:19 +0300
Subject: [PATCH rdma-next 5/8] RDMA/core: Fix potential use after free in
 counter_release()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-5-c660cda4df2a@nvidia.com>
References: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
In-Reply-To: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>, Majd Dibbiny
	<majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=2228;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=oVEMYQlFUHAEGHJgNL4rGUdO0yTXkQAU4Dezp6h1Zzs=;
 b=8vEGOzKD3k+rJjCLA0Ra96zNEgkPzO3Ba1gIvyI58y3wGKcYRkG6Ea244logUEpyH9y6Pc3PT
 mq/j38QOfIcC9eNp8nNdDOiAAjbR3pgQUXtsYVDno+SxnyhrXQlXVW8
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: d74119a5-8009-4ccb-0429-08ded76c5cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|921020|6133799003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FK60H+TbhuuH+j1Po9Q03Xu0YSxt4lPD0LsBukQ4TEaPjiCrWaCoLEsKQmDYZxex4i/RRDYTh9pAaOFjTDGEdyiBSQ31ZinJl54qc/j+YaaIOwZOsCUpMZGHKYTDskXo5dENL5s3OpERziEFMdAkPpluXLTz3V9gsdT46saEWN4EGeO9ATaa7lIOOKHPkcbtWDu3v6aD+0XLmYznT6EA24QC6LGmSC1K0atsgmhuJ6esGSOtZcH378dwQbyxvJDb4DDLWWge4izzF0JHB9vZoH94fA4oXY1FmULsuJtStGl4XNa5nCq8dx2jRoxwWS1TDuu4qww0F308kPXxHBZvePOH38pP5T91f6LnsUMeQfitDK+fpKQowfFSc80YPv7wLvGS1GhIegpZNCit3KdpDoinBRCzvZREYVao3WjUv772WegHuHj/aquE0vA0SRfFX7WRo6TSp2hM3fmfWCtgMqiAopBCDs7872IFHzGzxxnqE6dw+IbsC53MFxXwkXUhTpc31edLD2A9NFlYpRb4GSYegTguAjAzH84PFE/+SK4KSmSM/HblqXjfILaZobLz7/aHYKI/872jb2pD/G3yGOHICMEiB9r8TzpTJrJoPo/Q8X1hg0m24q8MLck2Ht3LZWstHRtXrfJ0KsPs87iqQmtFXQIlEiaBXaSMXR7qXtpLrr6h0S2dwNL3fgcsKmPHAoaEdXEyzrN9kP1lSI0VnkqcYjks7WITJ01Uleg6jkTu1DQvbS2xSUtHSh9Gt6xs
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(921020)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aLFiSUC8jXtDPMixJ2MKGJuPbhqQmLgL6vylyl+7U+c4M/QcwnJuUon+ZfJoHyaFoYBFJ/swT//v2PDufa+7Y+XG3FgzSnK5jWHw9YxK0jgBY6mpR2LnZxK1Nts/F8m3dorxJt7KySDj8zfv6KjbmWPV/qX9YHLCPIte6zPDZk/PKgDLUdoZHOKMvD8VeEfwIR8iVICPiOmkkmBz6YqJjv2flhgqiNnK+VtWiG1zAlFMGqzwNVPp2noyG5GWitCVg0GSxE0pWhYgcojQQf8M9GQWNrKYteD0i+wpxaKacZyRIk+3vmrZlTGM1vH54jeaZuDAg958TIz2v7BS0e3TRE8p+N/v5/yWyVyIvzpVynJOLDaBUkaWNRUl7zjl7+fAowno/aAmuhA4ets7HGvMoFPiee1hAaIVQbI2sS4UAOdv2O6+t7yNoe7VLQHlKR2h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:14.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74119a5-8009-4ccb-0429-08ded76c5cc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22640-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 393AD6ED892

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a counter via the netlink path the only synchronization
mechanism for the said counter is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
counter_release(), which is too late, since by that point
vendor-specific resources associated with the counter might already be
freed. This can leave a short window where the counter remains
accessible through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_del() call to be before the
freeing of the vendor-specific resources, ensuring that the counter is
removed from restrack before its internal resources are released.
This guarantees that no new users hold references to a counter that is
in the process of destruction.

Fixes: 99fa331dc862 ("RDMA/counter: Add "auto" configuration mode support")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/counters.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index a9e189194c1300a37479502959ddc1d1687bd40e..a2c85840c501a74752973bcb31452da9aa2e84fa 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -234,7 +234,6 @@ static void rdma_counter_free(struct rdma_counter *counter)
 
 	mutex_unlock(&port_counter->lock);
 
-	rdma_restrack_del(&counter->res);
 	rdma_free_hw_stats_struct(counter->stats);
 	kfree(counter);
 }
@@ -329,6 +328,7 @@ static void counter_release(struct kref *kref)
 
 	counter = container_of(kref, struct rdma_counter, kref);
 	counter_history_stat_update(counter);
+	rdma_restrack_del(&counter->res);
 	counter->device->ops.counter_dealloc(counter);
 	rdma_counter_free(counter);
 }
@@ -490,7 +490,8 @@ static struct rdma_counter *rdma_get_counter_by_id(struct ib_device *dev,
 		return NULL;
 
 	counter = container_of(res, struct rdma_counter, res);
-	kref_get(&counter->kref);
+	if (!kref_get_unless_zero(&counter->kref))
+		counter = NULL;
 	rdma_restrack_put(res);
 
 	return counter;

-- 
2.49.0


