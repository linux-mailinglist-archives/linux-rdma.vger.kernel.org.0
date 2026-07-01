Return-Path: <linux-rdma+bounces-22643-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xAosDH8SRWrl6QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22643-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:13:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB066EDE9A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gQCv5cbY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22643-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22643-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EEC93157E7E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587B4A2E01;
	Wed,  1 Jul 2026 12:30:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1047CC6B;
	Wed,  1 Jul 2026 12:30:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909011; cv=fail; b=M1iqtG3v6Vay8ct0BFZp8vdJSszwGeF7V9cABbxRKjN7PBj59gZZqVBlc20O3WlPWjU/bpCQhkO6znA7eQtVP9AVMx/5C9b2/bcPmx567ZwksOmotcTxuGsQRr05PnQqQQPYKZJQmzXOwO8G1I6wHWeT6q++dl/3WNl3KCOOK54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909011; c=relaxed/simple;
	bh=Kzyvzhrg35Mh+93QsdS16TxKMgJDgSrwHhCXnx6ejCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T6vJd3CNtTvh8KIR4EDb5p37IFA2h2JS5x5hmvKXP2VWLlPXueBMl9+2p3pMvhrDWE8pJXYqdzg1yW74QCOFB6IPCkcIrxLRPPmhgCkLMJKvLatJcFAilH/ADXiwswexAT0YNSgKM92hVnxVrhlM4uxn7Byrc5pUxzOxEz2Yfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gQCv5cbY; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1S64Dn90PzT89B2TMqZQ2Y3/f3cvvBB6KUyneoxGwFOCz5x6VplbFMnrIbWEQ2VoOmmoy1ZHB+Kun4bNskCcCUGhTVTqiVdxlQsyg8Ql+EoPpzxz0XbR4OAQr/EQuwakf9esFkWUW48Q3S6zUtVZrrTHdYatuC4Wt3Y1sJORf5ZqjeO38kBw7+npVEuCLq33Tvza/dzypqrO5RCcUaIQuUU4Od7YnhmEU+NfhYa5heBZMmvOF2MT5fnRr2lDi6wtukitjRZKJmvgN2aTUMH1M0a7PWUYtPUmvH9BoTM1KcqWuy+Yumli1BcLYSpE1o94HXu+Xk6UUvzYw+iuC3bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDlKlhWEMI7JrKVX2pBamKwIKRZzhaSZ8J4Z7tjyPyM=;
 b=IgA7/Y2JfhsczJ9FCxfjnNo0oZN1EoSKPsMhoBBKZosupsovwRmsW6naXxUfDk5N66Zhx5G/aROHZ8YYhmsbTLwdINGg1PpWSUOlp7nIB5wtjXgqJluQ6/gvUJzXhhy70ut4anS+DkOhb0EpqHOwqBSClXRMlTG978ADQqYX4yatT5aq9L7RgI7sL586luRvo5RMlE+9YYt5kPKN5VP+D6SBT7+PHDTnmbwsJ5R8KMOFQjX74TzGBjPkOCMRUsNfFKbBeWEMXhwLpUpg4dpgrdd7w/NZRnZyvm3N9K1LfB0bk7XPoL7KjcURviHso0MTBW4p3H1CzT8ZKRCBH44tkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDlKlhWEMI7JrKVX2pBamKwIKRZzhaSZ8J4Z7tjyPyM=;
 b=gQCv5cbYtzoOeAZ/heSOIjiABnJD6y34ZkKypRun7cq3LM5u8rKSEscCPJ8D+6LbSzzgEav7nPVVmgUVlInMajulJ1kigulwB1RXD5X01oy5cY3TM7xqGuYDbRrnuRgxnrNVPziVmhpaHw+9gRRpcAiJfFjypist3QSbTnWSlRG962gWzyDUSLZLGTP2FQF94ZLMzHr85t2tYmQd4T/fNGhONfoOSQynCH+Ww5ggBjE683k/wAquz52h3EwcgI6bv6Rl1UqPtXOfXDDMKfy/Yp4otIX0vHfw1+7Vy+g0mClGYW+EnZDZGATai9zhx+hTWRQxe7vtY6lG8ctfW+yK6g==
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by BN7PPFEDA8E6F1A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 12:30:00 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::9b) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 12:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 05:29:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:29:13 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:29:09 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:22 +0300
Subject: [PATCH rdma-next 8/8] RDMA/core: Fix potential use after free in
 ib_dealloc_pd_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-8-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=2237;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=DiZfUR8iWTusf5KGCmH8juNczeptl7qhlQRRXjLAHto=;
 b=BrO/ba4AGh1HiTvaJUvaja8MqMvV2eOvWV5A6W2oHvSnuVWO+sch0J2iqOEMA50fU4XgiS7NS
 huXkn0Q+AT2B3gqav8h+robSwHH8Oo4QNd/d5N7HTKvyWOrw/g93SNd
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BN7PPFEDA8E6F1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134c9f5-dd6e-42f6-43d8-08ded76c6552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|921020|6133799003|18002099003|11063799006|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	9fgYXX7Eoi0h4Kdn+nCBHxOUn+kNwB9mBkYoPW2DBvKsTFr2Y9iYlWDRsWzxJJloLtuU124lTgMZPHPYUUjtL+HyIyZ7lHvT4z9KZXBgxUNbHZsAtOLySdLjyKrNUzBUE9LP+OR/dtkm4w/kGAixGqpJXU7byhPB+RoRy2YegDr+J+95Da/FYezQtgO5+JD2/xZdqYBOuujceDhSAPkTbUJjZWeSCsSuYR5Mr+xR3fjRBbeAQolM/ZCW9nmuZVbFDfIJWDbKtsL5XY6E9IszUcRkcz7DxOyOXdoe3dZEn3oxULsDUEzyLB5AHTmGv3I2ZaAMAk+TmBOBlrePDwdhT8t9WRlVpu8116hK7zNXSvdtpQABcHgLp8WQEwCh/ybuvmPoF7knsFqSmwxH0VkpX2dXaSmd0+Ho8+mnoEgZMbNcu2cn0oMCScLAyMgE+XPWBCTmGg1sAkLPpL541NUMxbdMdB5qbvvXKHgca9MzOkcNt61+UvgoK4tUB+EC7RjKKc10ZCWlxvUbCqDcBjdmIyUUKdXsF5mQwiucCanlJ3i1+nTYwia/zxXFKGHYYa9AqN2fxWK0qb+ohmOF4O4K6m/3bZ+nvEnbN4JIxkxGrrY775xe/M47ppbt5MJqaFnx7FuLpy8EdNtvNLzW/Lfm++mgNLNzzX+VpfyujiM8i1O9Yrac8bHxJGQUN2mlwywQSXurWzKv0OszukgzqTvXUvkSjYr13QyZeYrmzCTp+1tEvua21GJE6Q5GS/2UQGjj
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(921020)(6133799003)(18002099003)(11063799006)(22082099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b8PTe/vCwly6ijuqMeinKkfLhZJKfAtltI1tGnMQLlPlp0BLuC4hMyH4tnSrrdhkTBNjSCk6DpTzvQro90qGJcrlLgY6ILF2v+qioMGOHHzft/evced8S2uDbv7B9819qnP9nzfP1GvzX2hakBCVG5q1pdngHWjGpzuMXx+eIAkWfsWzxPUwyi1jor5s1nlHiRcGNPZ5SLSVK6SuEz4OjZ8M7U6oT4MfuMeV1DP+DrGuEvLx2OtrCxAe0trXUPtrgjDV1Qq1Kn5Txii9fwDD31Y3671M/irJ4zI4q/2Js9A7BYJkgoRrkpov22lAltP70iyCVKTILAH58ZKPH7wCMj0t6dhcnvigdrCHp9iwjlRdeUO8vna8M9n/6FfduhLhfUn/mIdwI1HxZPqZg9AxzrsBwDYKSuk7Fa6qmj2OLmM/G4LnGGfs8wdG102ZHTZo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:28.7779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134c9f5-dd6e-42f6-43d8-08ded76c6552
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEDA8E6F1A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22643-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AB066EDE9A

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a PD via the netlink path the only synchronization
mechanism for the said PD is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_dealloc_pd_user(), which is too late, since by that point
vendor-specific resources associated with the PD might already be
freed. This can leave a short window where the PD remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
ib_dealloc_pd_user(), ensuring that the PD is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a PD that is in the process of destruction.

In addition, this change preserves the intended inverted order
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 91a7c58fce06 ("RDMA: Restore ability to fail on PD deallocate")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bfbc25dee95d031f91ffef5389e81faa08170719..f86e6f30b1df08396c151000fa7184574a034e0f 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -392,6 +392,7 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 {
 	int ret;
 
+	rdma_restrack_begin_del(&pd->res);
 	if (pd->__internal_mr) {
 		ret = pd->device->ops.dereg_mr(pd->__internal_mr, NULL);
 		WARN_ON(ret);
@@ -399,10 +400,12 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 	}
 
 	ret = pd->device->ops.dealloc_pd(pd, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&pd->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&pd->res);
+	rdma_restrack_commit_del(&pd->res);
 	kfree(pd);
 	return ret;
 }

-- 
2.49.0


