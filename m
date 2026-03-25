Return-Path: <linux-rdma+bounces-18651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ7WJHUyxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:07:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1232B044
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E9F312F95D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1A356A38;
	Wed, 25 Mar 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hy4jtLmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C853559C4;
	Wed, 25 Mar 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465276; cv=fail; b=qdSX8l4shwHmxB+g7yjeu0+SqhMBPzhc17VTbviDzUm1Uv+KC8AlvrUWA9dfz4eMc2JMzgznrLJ9yhtBcT6SSi8s5/kwHwlp5FPtcQ/VHPCUc0hXMohOlbBhl4nmBQVzXWTxC3nN+PpmOflki0MNsjQ7hGffpD+mjcKW8pV5ya0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465276; c=relaxed/simple;
	bh=mlYGaSGcypbRrSzsVJd5s6J5OjBBc/13GebHEXUJi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=loYx3+Ae1D6eZSvrakbzIPjSUAgmzUkufldiLnvqWkKelCk/4V+C+7roeJu1u7wV9ZcEZcIIB7Ze8SaEg1jk18nqW0FUlrRipNLmwjThoR0CZmfV7RoYpOtpX9aQxIzIdBGmGkgnw7BcbdmzOam2x9gCdDfkfYlA1aG+q27kX0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hy4jtLmJ; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxhsHLPiaoofZ+9ASiuiYYzluNvX60kip0WQBpjgRupI+hg+raz8sl/WQkCTid7m6useNdl1NqtMdPo1KHyGgIaoFLGucKuGUPe24Nsf47zSr5+aaNpDaZY5lc6ziteU8ggAcMheBP72YVD0/O7OE77mJxdSbvo2FmiCJdORDas1BYFT9zLAi1QkoIY2hIPHQJlIODmFRAniGrquvymIrwlAWhqQZ0zFgEAmBOz35r1zjz2WvBji7TQTZNgzFihT+uWE6DHfKOrEmCEvFetZGF4Tbbaxf0nRA0/rfcK9mVUF4V+DwLlrwqTjuUne8QTg3TfHzPKq38aIDD90NjqZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU/5ZDly+FSYMwDs7YwvDW1Y5j8zd67Xk+OGoPFhI1A=;
 b=Jir+RS/ZuXfeDhPPJuQnaemaKlzl1UXtB7qjbR4VvzaBNQhZtvWFYiAw9tUaG55uxrgpbH9XybIQiZ5Fv02vUr5EsMRycQRFp0Aihd6OwsB4s1sgbjjBtdQlk9yKQVmDUDJIWHIlUEzrzgaNvXrvgBqjHEGooZHrMX15eM4nsK9gFcmziUb1l6r504rD9NwXTG4ZM7sk6QNKfohIHZmrnp5Kbrv6ougEUcdDGAsmNPoaW2qoUCcT0q81jCjf8jwxxAvI/0A6HOH2vMXvN5y2J46ylKIGchIgCnjZUsIWOEFzw3xWbiQwm+6MMvibcQ4SsJDS74KpFIfmYRCl+Mjmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/5ZDly+FSYMwDs7YwvDW1Y5j8zd67Xk+OGoPFhI1A=;
 b=hy4jtLmJ/jwTGCvb3MgGF8vu345g6NakTHXsRd2du5EAoFcECJlZsiI2MwfZWQORlFawY9+SZ5kCbiLGtEA2mwUkQiv6B2ke5/i1ikOkj1nFzGzcUFwnGzH/wi8KBz4NxzBumCErTjt/arsw1VhxLvVzRUewh9OaKYKedEbJrnSQiZqphavFby0o0/dmNt1uomZRjZPtWluekVvUNeBGfrwchrTligmJeNvAvLYyuIrYIuzZLr5K3cVjr2liT00rLBvnhY0EmlK2iC3kZ2FQoARr9LEAvO4svtLrQmGFzZZ7nxgMAZtYNZ9uye34YkTvSMWxZt50fCkoO9NTlQgIsQ==
Received: from PH8P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::25)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:01:03 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::93) by PH8P220CA0005.outlook.office365.com
 (2603:10b6:510:345::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:36 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:31 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:04 +0200
Subject: [PATCH rdma-next 04/10] RDMA/core: Fix potential use after free in
 ib_destroy_cq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-4-c8332981ad26@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=2124;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=W/2WlJLn689ImNNVXH7wlhyztcjmNw/q/99rPLeorOI=;
 b=dNzHZd6qmvrjv6rZIVVQMzOkh62HvcNJFGNLmw58dlWUjAgNwMNM/fKOd70F4TcsbKE3DQ66o
 0eg5T8Q72muAywgFDP7I7BqI5JlWfaPE2Uo6fvITi7+RZ0NmgV/ES5Y
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d15659-b409-4e15-fd7e-08de8aa0dc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9U8f4Dybf8DH1Cu5A4xee4e6kfnh1kBM9sjHw0RJBEUfFicrJxPex8kqPzFhQK49dykupOzem0hnKWoeGM7NQ+YZVCV04pSpgEQTq/bXvDtBsRVKb3TI08eiCooyQG0qi43SqWwQGQp2XkvUDusD8LHAIkNuzuNwDps+En/Ou7LZKoTHMomhCdwnsvF0sDFt/U6jGUCRTidbzt7GPHfxfqJSoOZtM/Vc2G/UTK+ZvEnAYGpoivwm5Y/RP8x9in0AnRuXx9E3fJPleD6BJcpzfMnxbLtc05AezGv2kJAIKANbqw7yslJWoNnqhqwY2VlxrlSHnY4ouBPH2/ldiuocbIva6PMM0lU86Q/FrtMlGkNnf6a2Ql36N1LIo4Kog+o6wwCNTgERHIReZdHrPpUEMNLgDJJrZZ5eCwd0SiIfO+AMXKDE5h/DcN1xwfFsU9uprtqXcdcfmaD5sggkFEfYuZfbpbhOVzJFgggbu0EyTQKTKfiS5kI/kXROSoXVnnBgOOn15Q+4YMEjMS3e9cQPRKDYSfvtlnxDwC3iqyT8/2j772pWf3Dw4OiOt57l/i63rsvfeXTTutTedZLY5oxJMhSOOtJubAcjx054d1+AsFIQiSNLWJATajh2mTCoG7c7yjj7bdgUSgVNid2k26O6JhBtz4UVvybeEI52CjF0op3rkR9yrOJyBk5MTiVTP0cquyl0DnFTZD81/xGkGdly9wNiGiN6kvwoiBPpU/8ZgIHOX4aGagZ5Uo5/Vz/LsQwr5/3F/WLk+J/HrgqWgBJs72hB6kKiG3n3nSbeWDMr/i0vWuMnlr6XL3ozbRbDRpOe
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y+rfFUCmDojN5ss+K97QHhf3IDLkVfI3eVJNJFEEEm/Uwp/kECMfufV4Tlt1FmeoCb9smu9FXnkajgjnPXArXuosCHxHeN3lEQaznmzNoqQnWDfsOoYRDw6yDjcCTVjRFMidqHurTs1JqJrP9VUnngcT9Opp0OCM1NTKSyLrfck26h3mObCQAM1NKzEvTfHLBh4XucN3q4ZDt834H257cB1r6QcUMYK0VGaODsCUk2sn0FsCD13b8hxRXVUhYHmY9WBBXixcMJwDiwrqmc462qBEwqxswPU5PZ7g3GHdKuEq7X8eEulV8XHHlRwuTQb52yf1Dob48//n2HuUbosAFJwasnvoTRZ9cwJldUQ6DnQF7vsPZfQf0ITrQmQsy52PpT6sfwAxR2so8wxLMA8BnJldbbOsDTfqigVRMwcPMcI3uyQ3htrqdIvG9cTW5IBW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:03.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d15659-b409-4e15-fd7e-08de8aa0dc92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18651-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 2AD1232B044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a CQ via the netlink path the only synchronization
mechanism for the said CQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_cq_user(), which is too late, since by that point
vendor-specific resources associated with the CQ might already be
freed. This can leave a short window where the CQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_del() call to the start of
ib_destroy_cq_user(), ensuring that the CQ is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a CQ that is in the process of destruction.

In addition, this change preserves the intended asymmetric behavior
between create and destroy routines: resources are added to the
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
index f1438d5802a3e97e22cdb607cf90a097d041a162..0e8f99807c7c0ce063ed0c1561f4ba42b485b69d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2256,12 +2256,16 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_del(&cq->res);
+
 	ret = cq->device->ops.destroy_cq(cq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_new(&cq->res, RDMA_RESTRACK_CQ);
+		rdma_restrack_add(&cq->res);
 		return ret;
+	}
 
 	ib_umem_release(cq->umem);
-	rdma_restrack_del(&cq->res);
 	kfree(cq);
 	return ret;
 }

-- 
2.49.0


