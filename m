Return-Path: <linux-rdma+bounces-18652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDjHIJIyxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:08:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83B32B04B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E072313A760
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D135A933;
	Wed, 25 Mar 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3Jeo/e2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C53F99E4;
	Wed, 25 Mar 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465278; cv=fail; b=Ku6G0g40wN8L2Hn3VJ3QW1R0XzmUeAwCzC10cANcxdPswOELVKOXAPtO+tBAd7vz0/VBYngD3Ziz6YxtvFuWZmEIsZkz3Q0GP0muRKNQs4LioLVY3JaT0/e0V/6f5tJls4E/LwHRRIUIKu/3J8bW73TiNQWXvrck5jxOPzYwXlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465278; c=relaxed/simple;
	bh=07Ei7A7KKyx/vqJR7s+8ixUlAzuruB+Ehpyaj86Sa98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OaYt202iHq05pfRaVqOoyppHqn7VSJcLOL+0CuMIJHA1oXeRSP62otsGFe1jZjgO+amf4m9y9PRRBRSSUroeyNdI+PKOe2/gMCOiIgSAxCWaYC1IMx0XkJ14GstdSIUVGSQdVh9PZhjNpQkmmsAaxkqcKuXwUkWh3MUrjqGz7D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N3Jeo/e2; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovBHkqEFk5G8jSnmtUF7OR3fY6pGcJB2/hrwQFz2LI1C7xzifZ5hg5C2+X21R2hOTF/OKgil8TBo/yZYA88yqO/0isLN93ktsewLwh4a/O50qpEMaTagAuKDrqK3HODLUz9BHr7ldYeQJXPFEOutMCN9v77jaY0zq2Ab5ZrrY7hkvOn2x0kN620slFqqx74+s/UioDbpEFxdOk3Pd7+F8An1Qlt9C+ITobYaR/x63RsemmvoxMhNIMzP7aKgN0zM6U6VDzqqlI2VIa2Pp8B0U4T9zIad0dWtZc5o8ic+oRc6NL+uD0T3MO/TutOIcAeQDnylJqkvmw+osV4NTnMCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtLo7npB8ML4O/w113KywGQ7UkDxwFA/f1k6Bqj39vs=;
 b=gvj0TOuB0Ergb/DFj+agX0QwtNx1X26QGzYYhn7mzHHFHdE1vaSVzW7wjf6lp/TnFfsfxS4Ma1WtWOqg5B6sAA/0UDcmJrZRQvvbJ/6vdbvc6mWON1ImoZfOWo1gh/9IwsLyKqMISJL+8WsZk5/XjIjRVMIXv5kRbcwFwpy4G7+xoZjJDX/3+zUSM5MTGDeBa4AlnzIaeIbi7bcFj2Zti8QztbHNx548aNioJAtXSnLjavfeFNwXVru4jfdFWzlKp9DyLkJ5aAZvHJ+C5JjlTeS4v/r0YwruH3TbVGXIfZoXD3tlw9CDqhp75TaVlquZXW5gPy9h3GJFXvWDklgJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtLo7npB8ML4O/w113KywGQ7UkDxwFA/f1k6Bqj39vs=;
 b=N3Jeo/e2gNkPXDO/jr45y7geK2Jlbye3dmHY7EVmdYmrhdqPSOqCipMr4isYHmBJWPp8qj4bL5Z4ItkTxGGfUQMfFibiOaCqWkv+3Im44CiHIkDQuY62VrDP8eVghbwiN7yuYTt7X8XVtzI0vdQnapOmtV7wTcSfX+Fg9T639eToQyFv+urdNDJcZjK3T79DYfscSWocd01SxVhrrg+AXF1c72DcIEmy9kOdVYkaat0dzA4uTSWFbisFIW04awiYcTkMHlvw9n+ZwacpOcq+faCFvGcXb0XG7BU+jUi7CwaV8hco2VL920MUvFHixsGdpaavbxCmtOOGMGPG6HKiXQ==
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21; Wed, 25 Mar 2026 19:01:12 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::59) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:40 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:36 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:05 +0200
Subject: [PATCH rdma-next 05/10] RDMA/core: Fix potential use after free in
 ib_destroy_srq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-5-c8332981ad26@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=2320;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=+VtBN5/ICOt22ljghD3KcEb67UyEfMhhKiqtiu5cMQY=;
 b=1edRBtXzudf+3d85XfQrU0qi78uqAjREt2MpPaKIM9JBtttPz51dtZiRyKTVdH//YM+o6FIye
 QcxPMrBrNhgDoR4kTdhylq/wyIR+Lz8LUhJ6ykxGfLgkwfEUqjmp/DP
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: bf17f7aa-de32-4ba8-b849-08de8aa0deb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ngbQ+3adwyxJl2tjTMkex9u9c4z3yiyIfnGf+7nW5EHbqeMtTEp9sK86OtNhgcR3Lbpqc6BTqRUku+YOk7rQZvdSd3TnfvEj37mMEwP8vcY/45aDtFOfAlU9aWg2Ffcarp2fdFFFjoqaxeqSCugw9rnS1b41gNwz8Xuaw94IfV2Hgzc2O89CINNStdp5U/R9d9PFlCenpy8NWcpnPzIIlSjpTWHJykVDcwUxIcBGsajgJbmzQYHZXrfsK3Q0rMMgggsT1CG80ZQXUHz3N0UZyyS8U7uR+ThAfkEefgKodIQJohqHQZFFoczNs//6j0A+asH2PHR2JppPnlnUnroDpw8yCbFV73LNRursHpBXA9aRVMfuYrziEQEDyU3/1V43D3HeMMXKoW3pwCtc3OclfJxUhtZCvgfpZVVwqbDc6v8bQ0PtKB2858WoFkxwRrKkxnvYSKUHEtLOET3Diw6X9ia2NB2L4gZODJjJJq3fLGVU8z3WPeQqLUmjuUj0wMlPUZk2G1w6+gZlNpIJLBb8Gw2uBcdZem10UxGT/Qygm2I9KTTCFeuc7LqKk8JS03uF4yrAzyV+a78c6JT1hvXUCLBOzF6eeIseQ3MUfchyDU4SF4L11js1HI934O2k7ffBZqh2fP3jZY8IG4I0vAy49j7npr1Weu5o+t+b5JQSgr8PrSxVvt8Y/mhA3fZRQUpZ8an3dby2QMyog+GA3afuEyiTqLi0AvM6SFz11US2wKTVEKZFR54d8BN1orMx6RzUOuLfzBxax04Ujj3RcORvEl2b8AyVbOj3SfmClSg/7/Ii+3VENTp3hTMSWIytKrTQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H0df5UcQAPiRGkJrd2glf11FGtX4WzytL+oi0G+SH8nZktSblsuuGlXC2YXtle75GnQ9mX7JiiDEUSg3v1B0zkhnivNzsxVeuGGHTVWszXVVMR03u2z+c/pIGdW4zt4z+8H1nyaQzOCQ8PzfomGukDsTdtfftaVEczC426PfTor4C7P4uaj9LL/OSFGt2cgtW8tofa3GmlKIHotQPU1oPkYFjvCoU3GXOFh3FnN4nX0nPYdAtvkYgBjxYIcT5NpDBedmVBknNcqRxC/ZhPq8z6FwipSzb6LngOU9ahXCWWdEvssyYZaZC6Ps438tCE80JHmAgOi9cq2dIdWs70NzcM/ZSPOMuaojS8LrqfVeg3LSFt/JyCqCgZ/8UzSzTtd6v97BvEZ4UpVsJMQ5RkA59FR8dX2NlvAZi2j/ok7K2PkTQWIq9CDMc518S5YD1nOg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:06.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf17f7aa-de32-4ba8-b849-08de8aa0deb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18652-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EE83B32B04B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a SRQ via the netlink path the only synchronization
mechanism for the said SRQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_srq_user(), which is too late, since by that point
vendor-specific resources associated with the SRQ might already be
freed. This can leave a short window where the SRQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_del() call to the start of
ib_destroy_srq_user(), ensuring that the SRQ is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a SRQ that is in the process of destruction.

In addition, this change preserves the intended asymmetric behavior
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 48f8a70e899f ("RDMA/restrack: Add support to get resource tracking for SRQ")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 0e8f99807c7c0ce063ed0c1561f4ba42b485b69d..5921c6d008bb10bcce5f3b9bcc99de72193941db 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1139,16 +1139,20 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 	if (atomic_read(&srq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_del(&srq->res);
+
 	ret = srq->device->ops.destroy_srq(srq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_new(&srq->res, RDMA_RESTRACK_SRQ);
+		rdma_restrack_add(&srq->res);
 		return ret;
+	}
 
 	atomic_dec(&srq->pd->usecnt);
 	if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
-	rdma_restrack_del(&srq->res);
 	kfree(srq);
 
 	return ret;

-- 
2.49.0


