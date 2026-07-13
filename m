Return-Path: <linux-rdma+bounces-23144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cw0nNpIHVWqPjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:43:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0E74D313
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=BnR3jTrD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23144-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23144-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91687302BBD5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA943EAC8B;
	Mon, 13 Jul 2026 15:38:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0073DE44D;
	Mon, 13 Jul 2026 15:38:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957137; cv=fail; b=r0MX6+eTgeHuXf0L58uOY0kWuSGrlX44+iqR2Hsbo/HQJ1vEt6XDfKbwPu6bisoQ2/LLWGVMRqXQqcq1orAVbkEJjZGN2dRgauT9Z9vnMdvMt+aOR2GI9Oh2b7N+2qPhQzWg5JlSyeU39VncN6U9o3mBqYj03chFpaSP0uTGtnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957137; c=relaxed/simple;
	bh=Vt9ZlM30PkQ1zNX1IBG1omQHLzQfl7o6PrRiDbYOzFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gaSamTSWOhqm4heyW/xupjGXmhQbfmwqvFNNoMbeqyIBCCns9nnei5rHeVLn9QiDXQOqldPeVZY21l1LzJvCDu71Ig4YgrSFb/k8/6SQMbYTCC1u6MvBoGQHE8tNUN226OR55OJXgw02P2yjv3tE09Pp98lJopaohjfMTuK5eyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BnR3jTrD; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfUdoTRJ61JmnPn83lNhMC1qs7doFzE9N1PwiMlCRgGeIAsVFXGoJgmAXX1FnGGh7tMuT8x0EYOznI4S3AK0hkyU2YysRWTnlLkNZnp/x9gGX9VZvicmSb3lqDBKIqxuOq6EmHrTeJJuPdXItllXufSIFx1iG/aijRFFxU2Nv3u8G0YexOwraUwDDobKnqL+vktXgbfPwW0NT+FdlJwPTz9St7zOIktAjWuVN4uKNlARaIV8sKTxOH4QesKpsd2A1DT31AqlkFGv9QYowPkPgLc53B2sfYW5/xQ38hgdkT4CKgehWqKEfLRhSp+jtear2HYScMmf1BrYWaohINJE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=383NTG1HYU1Jw0b2zygGl9BJ1U7FwiEB9NxcGHRbErw=;
 b=r90YttpSRGoGrDXxXeRf/m3Nk/yNb2kVqnKs7jvu1g3dTt7yUS9tg0Uj4/9iuOMMxbMnzmvZMydD1z7Max7jyFTtFduiWoi3e4CP7bQTgufw7B9z5s/ENF2C8nZA67S0CA0dkUyFVQpCdUGjVQRLxVlMjwI5R/RFouF71Ky+0qkNVgTr3Zzz8LzHJKTqPfGqMLkIxJHKqQmCVS8FP/NgU2puw6p76+IQUPh9jat3m6ex2Q2pNq56J8Oh3JQN1FbSaOs4RxvrEPEMLZQmuit9JXX/gsPYiCMUJqQ/QP3k7qkQnSGJMnNc6cCkf6MAHlIt1hh677gI62j8gOXrL72j0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=383NTG1HYU1Jw0b2zygGl9BJ1U7FwiEB9NxcGHRbErw=;
 b=BnR3jTrDKdRF9/9zPOxde0iFwf/hOAIaGDwW6sXL0xmoLuRg63aIooDpjrISGcLodG6b6ux7jlMLKwfe4g4UbiOPQ/cO6V27Zc4OBHAirIajLTdNiqMUryC3Xyn1hikZzt8RF0f9CmLFA2ou1NalCNcX8ppfufyey00zG+nm8nwInakZeboJLF58rNbJMdbO/g5VlEcDSG5YAH47fsgqB6lOr5IbubQUrcgpTF8FCSUgdzzJW7tiQIY2M9sGO4vYqaYVWZ3za0c8XmAze0/+6kXgny0rMoeikGYRYtHKX0C1nYbY9PgGHUxZ6+BtsuEki7lp7YOGVkYajilAyVcR7w==
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 15:38:50 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::72) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 15:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:33 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:28 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:04 +0300
Subject: [PATCH rdma-next v2 5/8] RDMA/core: Fix potential use after free
 in counter_release()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-5-bbe8bb270d51@nvidia.com>
References: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
In-Reply-To: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=2228;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=oVEMYQlFUHAEGHJgNL4rGUdO0yTXkQAU4Dezp6h1Zzs=;
 b=fUbD9O4Q/YQtuB5caRrEuuLPDd/0F0IgL9wGp8/Q5STdHW5iHyvpt9c+3LJfgeZpbuIFWmKiV
 +nmw6Vo99xjCOEtVH7fUxBCgSTlewclUMiPXKVqcOtjNDULpk2Buscm
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 127385ea-e3bc-434b-3850-08dee0f4d68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|921020|6133799003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p28pJGSJmIpPUqx6YkSb91x+RxO71GkYNKg7BqKdym1ML9pbI7AlW7pv7D4wP7p4EBufggJPp6llgc2S7FY7c9dzt2SAGwffYJpJqORFjpws3UvQpnFpzqNYyd093lNDVYJ2wbqh1KP8xOW23VdnbJBp0ffPr6KNiX638vZ5TiSb3cIVB6t2DG647jpiob4067sgfUCvcUpeVuPKyO99wppQG7xKFbnW6EwWZb0eePLPzY+OSPIp9W32wivthufBNzozldATXliWLymaA02WQPzM6sXtLbiSjrUYSiJR8PhqV20fjVtdUtgrwY13dl/Slx/Q2XeTryg/9Q0EIx3m1A6H39DCnWosFQXHKV+rxisxK1kcSEsd6p03j/lyty0y9N+4EIvoR9xosw8OdahbosakfC2SaSaLPCWsEH22KUzz+naWzm945r60DnmsMMGLXhRom9HX5kr9ecC6x77x2dQKDxz9d9WVxiCmLbuPGijBjXoHJ4JIWGMSybkMOUE5LzVQRulE7fp8Ebqp7wgZf9vG8TynZZ5vRK/yDf+LP7pDy/3xOuE3wHtlgQ1skMgTsBGc6vzjd7xUIp4L88povK60qtys/W69IfWjWDbu//N87Zn0YEgPfFAFGe1udmUmVS+2nilUwTCgeSDUuBYUIcWM/fxZUYkN5rrgCSAD4bmk6Jkpk1Zeg75dOQlg3HR2/LohqLouyP6jlvlnC8vKOjenBsY0R7aRLpPjx67TBMeBf58UfxpeQDfrCJZtkWtf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(6133799003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ja4eSVuDng3GdlBUcuOLmIIGbNvJV7iVxrbbnNm4Px8RkGkLosR7s/ZfwXU5AdLOiIcv/jMlcevY/qNmiaZmqCyUALet7JNQLHeNcdKk2KBsAbVQNImFDnIoWmTv0OlDfUFI5sh94MVNOANFBa3/aH4PQp2W99LMD22qw+rpg3qa0yB/mM+SfPtl2dS0FqqXUyCmpwW5fjUK6mN7BeOM0vIbibCFG9VxEcOUbHXEot6zQ+DokeiqkbkMG7/s9zSZ0cYupnhF81tnjkHKWoeZaP8vJtbzLAETtbgkvZZgRkTGMqcYKfSHiCtrHRw1vUFyRTtzrGW31ecvVOnydhjXFXE76kZ0cdGuHUYwpD9/MBzc+mQikVzsGtGYC7UQQlesdLMk59yhKrgHMW5pE4ZySd10W+MACboanZy0dfiJkqbYmhmNX2UqQc5W+8ToGtAC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:50.9136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127385ea-e3bc-434b-3850-08dee0f4d68f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23144-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8D0E74D313

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


