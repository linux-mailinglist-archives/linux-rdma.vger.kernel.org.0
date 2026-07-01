Return-Path: <linux-rdma+bounces-22638-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oBp2CyMLRWrd5goAu9opvQ
	(envelope-from <linux-rdma+bounces-22638-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:42:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC626ED78D
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TRErg1tz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22638-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22638-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09527311C4CE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B974963A8;
	Wed,  1 Jul 2026 12:29:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345E48125B;
	Wed,  1 Jul 2026 12:29:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908958; cv=fail; b=kdd0vGcUmn2z9y0Z3Qo0TeGZe5wsuDHuZLJcTe/P3WAKQ2TBCkJW5fp5B6Fqae52YVN+3oxljAm++RxQzjjcdCIytklLNVjG7Z7xQGjHQQYoqxkbeIqG7UFhOXhnkY+zwEYkZoRuv8oMkxyzR86UqMzeUIEloBlJS2XoGTBn1kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908958; c=relaxed/simple;
	bh=eDMhseWuOEgZ+n+3gA6lnopUnT0yII4WZ2zjPykid2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IWMFtmaL+tqJ5lxulzj/G9ou6IFXmxcym/uxBpVW4DKIbkHY/mJqaAoMVwPXdK9yap4+vtd7epqZnmQKZ+rlXBrFzodYOSAVTib6GBhIK9nRS7robzP6LCU1GaEqG0LTyEAQduJYz10PxgxDUo+BzuZTPHXrUyprgEIOkgWQpsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TRErg1tz; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ3FuiAwBjAks52K16E83jDzG/esglWLn+6OH4O5ZEdTrM4tZg/e6E+/z9c4SNzFVy1OCAIZwFMVPj9cEYX7h3UbqOhqq5G9qcGGMS7ENhrhojA4Sqc66SgINpTOxXEIKQcfo7ZE6HvSxveHOH0mCx65Nmcz5TCf9HzwR+GSY4vpUzk9RAiaHFlinclaMvoNC6mOq0za28jiUWWnRAPkPmXiNgNOgxScZePyIg270uRDDt/UBFLwfwULMa4CB2Th8nLWA7HiPraoqEpnrKODXf6tt+Mpz2GrJP1GLJG2QaSqQL2hy6SWsK9RMUBXjk1Q4OiVRbQ8AZSTQWYf83QuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSsZlEr4sftCZO0An4cBC6NS6aCPmOAVGQFKHHs2o6k=;
 b=rxytYC0IxkJd4nCIztX4RkCQyufrpCwZgblWK2ru9nWb9LgK4fx1En9CuL+O7YVKvSI+Cycd0VJu4JZuS1bNQ6ykqlzAp47l7RjRpgNFGgpVwRgVJFIQJnKV4771JgGGxJPvSa/oBd3pcw9YhOP4SMyDNeA7Yxb9kbSgz6OG9QwhCgo3jsGvkj0VAzoHatqrl/YjT4rBg6z+g7I2lKn6Dc4h2EENaIX3SWtkhlHQ6ZjVh6FKmQp6oHmDAxQGXgVgGt9hmLeuiCfHUZymyujt2ZQnvvdqHFivr0Esg3SROJdrsraAf1Uop0xk0ngihWsXc8pKjvuBdEIDhN2FL4kuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSsZlEr4sftCZO0An4cBC6NS6aCPmOAVGQFKHHs2o6k=;
 b=TRErg1tzkBeDxwMuIrqNjxbuoSonDag7JlGljz+e9N8/t9dcVg+hFFVqiCQFC9oQTEbI2+C8Id4HyP6XyraC2rSYNTFQDSdDvEn3BZM/QHlLjD5/ojPdD/98Wx2kEaEMmmjH2PZ5rZ3zlDL6nbUGzotSSwAYCoFNGfBYLflmFKDz7U4kkvBeYVuexWELUqv4kGraTp6Gs1EtZjt88SU70K8CR9X2l/mIdeC7UUiPpBj8GCnyHXh7/zOFmcSj+2PZEs0VwNOSPWEm1GXD0ass1DSkLQcraAie7GKhV1GDmVuY1TuJtihqdCAfTlylF5CuVJjxN9pu3tdJq7OOllHq0g==
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:29:06 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::68) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 05:28:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:28:52 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:48 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:17 +0300
Subject: [PATCH rdma-next 3/8] RDMA/core: Fix potential use after free in
 ib_destroy_cq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-3-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=2091;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=59+xBgMrEC1iEA9mz6DuYykfQTNa0ycMh8hgh3/0epM=;
 b=AwqJJ1gzsVC48QI2+aM0q8V2rQmQVpT8/HtJPh5IVjVmfGS/MDs8VpldBj4xE1b6+lf9T+3aS
 xOsK/i3gpGqAFAsRzJjLlj2QsechOXbx6MJxO8AVUhKaQiO64Vn1Hpj
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: ee03c75d-e9cd-4d5f-0518-08ded76c57f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|5023799004|56012099006|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QhNn6B0LSAKn93Y6FEjqYt+Pg1lsFXuMza7eXtLO9B7u5xcwb/k+KqhBjJ0WifPpycH/CJc2gP2mJnm5yAO5lKH5JlB0vJt5MmTcNLi7KVCesrCiQnT2X+w8ECW0TfObXFsvFnjWu/Q0s4cz896j3LoagI+vg9NO/kcCwVBbE1PvjUqwtgTFt/Pmv6mAxWvxU/NqHccjDe2147pVRG8Y1+ADdYdJBaIFPP1j68/2gCNaKMHXGlEAu1J19bRVzE8LzpGcf8SNSNcGnNBXnxtdaZFnIoO5z08qV+RluKp5szfOjiRX1cfigZtTBYKp5f1onypHUjiYI7B9OcJL9M3Mx6hFpUbKgKLzCVmX2iTpl8fsri0nqQWn2EabreY5ME8Askia+fhue5qxDZYzpDmSZUTnCudh15QkHFqyfixr1Meix2IIhCdAa7VBfrf3WQzuM6h1UQD3xutjExk10AezDgq4c0MEN9ooTbKhUrai8PIsyGEL9+8c0uSusy5oCfZl3h3cS6cM/zB8Wh2JwKscKpHV/Lg7uJKcveUd2DvGHQzqitocDxQdY3TO9E0GbnFrApQzRnK0m40oug1uOS4w6mWk8B6UsdcDFfX7wf10GsaN/qHqvKxHUcQtErZWwbNvHM28mNauGpSxMig/HJHMJhytcW5jlBpnbz7roekQHzsFFM1ho5ivAZHoUyACn0meril2/opQ+bdJPRKhhS1yZpXGrSSibCczj75IXuCF5Ud+qrqUQUyJMOvEpdeRuQ1L
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3D5UkYHoBf+ryxlf86+bIbQFdd5dCYuiXWDWEDOPXkc1xttdfFxTDmAP4mF6XVmUEVKLpatn02XBiS/pwwt8J5ppbNqJw7ysrqg2qYcVnylU1HIqoYb0fY2DHlXnHwITam0dPHroWj6Pypxsrqan1R6l1y+kuPAhYFf11QXtyQFt4a5VGIqcIT2swcSKMrvUNVU9ZKKKukPIxupDkXcvv/YDuMqacV71PUrLTqTnqALloKgZkdLOnN4CM/IEznPhFjyN6tL8iBol9fVcVGEOo8l7/f2SoCGPH5WEEAwXDuh9q5vSwJG4kATBBmZDguOzRD4yQtAeUqOZcNnINoPFfTW+Ij9onx+Sgb7nZJ6eZzoWF2KQ2Rz+Dw60dvfNqZLRucO7vjH0NjxsL38ozlZOr30AC/oLq3hzN5DAKDSrKLTqZ+nPW5ej+1lpqYfJOe1I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:06.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee03c75d-e9cd-4d5f-0518-08ded76c57f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22638-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCC626ED78D

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a CQ via the netlink path the only synchronization
mechanism for the said CQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_cq_user(), which is too late, since by that point
vendor-specific resources associated with the CQ might already be
freed. This can leave a short window where the CQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
ib_destroy_cq_user(), ensuring that the CQ is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a CQ that is in the process of destruction.

In addition, this change preserves the intended inverted order
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 08f294a1524b ("RDMA/core: Add resource tracking for create and destroy CQs")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7abb89a4e6a019b965d36446d64609ed2c33d1c0..568cb71da726a61997149e92aa570e0bcb76926c 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2247,11 +2247,15 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_begin_del(&cq->res);
+
 	ret = cq->device->ops.destroy_cq(cq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&cq->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&cq->res);
+	rdma_restrack_commit_del(&cq->res);
 	kfree(cq);
 	return ret;
 }

-- 
2.49.0


