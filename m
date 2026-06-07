Return-Path: <linux-rdma+bounces-21932-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lZPBNOS2JWpiKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21932-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:22:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF956513A0
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=D6xe9Y75;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21932-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21932-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FEA3018747
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE472D6E5C;
	Sun,  7 Jun 2026 18:19:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04E29B78F;
	Sun,  7 Jun 2026 18:19:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856354; cv=fail; b=NlOL1Uzu6XlAYi2w21Qc/RQQM8XUmYIrNLLVd1ige7A20k5cdGUY7vEshrYkWWehn9/tWLKR8aPYnZ5uVC3j6mUZVGQjJz5nqmfRJRUYOJIy4NY2HkuZ099wQ3yvvROms3tw75WdS8EOCeYxjU8Z9JJJzfqt8Ddyd7rWddxeguA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856354; c=relaxed/simple;
	bh=S/cEIJz/WUn8c8jEjFomlpCgTMz8Vhlds0Jx+rfl+38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WyuTwYJD8U64hTOfEeMnuqpqBv2xE/53RILT3kSfrpHe8a6vRcOFy/69wa50oo2Ttt1oi7I1jpMK2EXlvdl/GJhIAPxpJnrsKLpb4DblV+t1xGE7JJ8kZGcH58S8uwtzj+DXOGJAeSmUFeK+L6ZsrRc0kPneYdVMP0DXkzw+/Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6xe9Y75; arc=fail smtp.client-ip=52.101.56.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BThvtBIKym35VJd2rH2yH2FhQbcMgJKUzir+YKynf3putJLS1L3RfD9mfVneQlMj73FarwsBE5eTLY551MRVUFYmDN3MoweHraAsriWx4M7Xt3ZpdNp5BDK1He1EXv11eHvODSiXi8A+Fa9aLREWJaJS5WFYpZxFlU70SWffBoevTExft3rhwn/mIXkK367Sx8Q/fiYZwmG2ezpmk3q6dB29BRrFcPRZTPo/ZWgYWN6AJFIAnaLLuc917oLI+CeKKsSWHznHcLfUG5FM7EF6HV/0miuRrjIz6O0iiWqeRyovP6zjiaAHQD4lBTB9rslAaPWnHLFf5GU5rYsOYBy4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+6NdJftjKxCPsTKiD2+i1ZkeyYONJGFKlcApIh+EaY=;
 b=r3/YfJAaOxnM58mUATwzKLFwUHiCa0qh3GrpkQKa21Pn84P2456ORERRoSOoTBFPMN+4UKZFeK1m47i11AtBPTCFUz4TK278YHvBwF2ZCBCpQEs/43CQGSL8NFKLvHfkq3ZfqijA5peEHtRNbvCJ2DTUuy1+eieWkAVLh0SfJdkDirlD2Kc9IoSM6LtwNDMmJxX9pk7IJ6JPn1O6tQnyyKVL1thItpiF47a5FAs98ocwLNt9lP+G/0/3LXRxXgvqP9L0rSvkV8Efd2JRHsFESbXQRs05ivTf90z8BMvmtPY+N3KVCJwP12czxSI3nl3QlAJZv+8c8IEd245Tz4JgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+6NdJftjKxCPsTKiD2+i1ZkeyYONJGFKlcApIh+EaY=;
 b=D6xe9Y75TPNwRLnNo3GJYtJU2cCVB+WCDZSi17YJn2bsidMzuMLMiBnGV3OdbE5JzBA3VaNqWcg3ycUyHub/7UtJDF1HbWgGZJsyKdjYheWIkdjii2oW+LjJuYOg4PoZQBhpB5VA5tYd/5it9y6LpcASePzjBH0ve9G++EhyGKrSiv8HYdFyrDnvTrqrT1ZpMo7ct3JNmrlNZ5QhJm+DWBU9S1kCR6QlTBZN7EqDjBxrrs024bORGoQEnZ3Sh9j2LxvdRK8/g+4MOBzQqReM9s8kdoZ32oZeVe295z5P6Rdj0Z/USQuzq6yuNgDptGNBJgkf9bd9KNonlICLB/nejQ==
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:19:07 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::9f) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:19:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:57 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:53 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:13 +0300
Subject: [PATCH rdma-next 6/6] RDMA/core: Fix potential use after free in
 ib_destroy_srq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-6-d72e45eb76c2@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=2325;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=aEOI4/Cq6/Q+2ujAqIn8sk34P+AW64UV0QSSph1IrYo=;
 b=UDmRt2gdMaFTbtntDUN2DY/WOZGtmZ5sZGDkc2CRYmojS7Pr7wOdQ75mbiiCxwEkoTHtpeVvX
 ktHBvSdiWOoBgVr58wWc1ki7FQqMpZThL/Ou2jWupc4Zpn76+TjPLoc
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: d753e420-1786-44bc-9845-08dec4c14377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|22082099003|18002099003|921020|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	T3lOdtRv1GxNZS4O4OWM9ZHUzOCgOJ+2Oc+ipFXV5Ev+5hCnO8HCepuP2GSlI7VKXqJzw41QFuMJFw1hEklK5PmHBX4fDyCLokE3tDXIsNxd6yIqvOU2Jh/CFw8VW/Qvh1NdeMyzqX9gHHsTSSMWCMzk8MCrKv6g6LtekTO0kFl47Fj5PWCk/KbPw9uVbQNETaJXxotqzsPvDETF02IQ/yIaYxKRzzeCa4Sg9R3oR94Lnz5o27zVJZoFhQgyxrMAqSV9xNnPaadaTnyYkaclveDV2tACyKIwu+iim+0hc3bu8WR1SW6QSeZ0Ez/3ZvorpGOQWDHLa6X1wsPJmLIUg7Acuk/yGVr8ckctVupZ0TXNtgOScIUIJGi/p5bOMVSTAOICq8zp+9SCv2PY0q0HQsNiCaUnW+mVM7qmJMh3BoHTjfaxTrCkFWFbXx1YIHJpPI5ER2lg2zqP8iujihK9lfso9kwV3rt1Ed3K5IaJqPnrJvWq9pECnaz29Xs1pQwfVA3wVyjNNyNJrJAXx3LlbdZOUbFlbXDoH52EzguJvIBx0apcSzTSagWQ+6FWvDEqIAFD/ZsBa37A82CKRn/qlfszQ/siQvr45h/NyClZvsxfqBu2nLJlj589vahFIEAtrV6Gfo/3r688+UuH9rIg8NpsLHaW6nm7BcH7oPhyMJUQBYf5xqMqsoRerqZ7UCw5Q0OZdNrYpseGk2mM+/FcCdt6nDcawef3SF4ijsbdWNfDi+URCpGHvgBnxSpkoBomMMLMBrdLGWTXncizgaoW2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xz48dMZtR+SchiTXSSZ48TdY60IP2bGqAsKIdTRsbEd54ye5cyLGmxVFH4ohDDBAL/mwG9/9AylchKnY9Pv4w9pP0qlgxXif9mi6Od8wxYCxCQ9JEmjqdOziPotIACx/z8Vzrlka8aowcOb6NzW1hIzrD/gAEL3lSv6QY8GmNPqGXO591bC00PxzbX3OHCspp0fsYlp63y6aofc0P93N1d/8053Cpyz9woOyaKa2MBGkNdvKFJJiSj+BF6KW7Mn5ULlKPeQDY5NVZm+w95ouYwE5eyVf3c5RlHiIrKwfJQpWZXMdRb2KkM3GJZo5IwtCdK35dDyO3JNmtbtLRux0HO83ZdSACsAKIrTYZIMaWMNtMXcp+vJ/+mldTihFwN+EyCiEPeSGb91XMZw/lNzZpn/r15bPKTcCV/SXGyO4o4I1QKbp88VqkQlzy8a5kAZa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:19:07.1842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d753e420-1786-44bc-9845-08dec4c14377
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21932-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EF956513A0

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a SRQ via the netlink path the only synchronization
mechanism for the said SRQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_srq_user(), which is too late, since by that point
vendor-specific resources associated with the SRQ might already be
freed. This can leave a short window where the SRQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
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
index bca0e48f6805e87554e77139ce6812d6b7236802..12b79ed046ee81ba2e7b199f39aa40c7bda9d892 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1139,16 +1139,20 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 	if (atomic_read(&srq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_begin_del(&srq->res);
+
 	ret = srq->device->ops.destroy_srq(srq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&srq->res);
 		return ret;
+	}
 
 	atomic_dec(&srq->pd->usecnt);
 	if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
-	rdma_restrack_del(&srq->res);
+	rdma_restrack_commit_del(&srq->res);
 	kfree(srq);
 
 	return ret;

-- 
2.49.0


