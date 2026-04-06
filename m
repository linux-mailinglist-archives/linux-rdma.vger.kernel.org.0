Return-Path: <linux-rdma+bounces-19013-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP/7Ki1502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19013-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:13:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09A3A27E0
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA6C3302254A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AE31B830;
	Mon,  6 Apr 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0D4NuEC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70231D372;
	Mon,  6 Apr 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466720; cv=fail; b=YgcmY/dHfaDDdZQCMaQMfoXSLcjC+b94ZBvv3aGM5kICh5lNve8zH/6pP5D+8DX0xg1ER8sFmoQrykwp6f8bM/gvu0SOIALgnAzwumwh043K2qjbse7JjaTnWUCurPcq6aFf7Bqe8E6B50z026l/GAg6SftonekZELOaZCQGydo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466720; c=relaxed/simple;
	bh=mlYGaSGcypbRrSzsVJd5s6J5OjBBc/13GebHEXUJi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K5HO8JEvtAcev+ZuW6oXw2GVp6B+k8iYt746PC9g4vF1fKr77FwzVhNoem6LS2GzmY+ndSK08QCHRL+JkemPTWrJB0wmzrFg7Esef7WT72QvCzZrbYcfukhdwOckieAfK0cDwmSn3Ksb94RL74FGk7R02Uzbdx6pckY58ceS0dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0D4NuEC; arc=fail smtp.client-ip=40.93.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEtSyEqTQN+dfVguRC3XUriRJPZ/q3JgWpZlpiked6cv2r/kTeKcWFrnMOA327rXegDiMJonm9lW0ErGOGFXMx1YlBd0vrBdOrkXh4oNaWQCSOCM1DLRCtxWIecQU0rFiJMoc6/LXxAHVXJfTFPmvzSQ1ahu4AQDh7Kz5AwrmukPOUKjvlDD1BPpd0aLNIpnT22VflxKC88a1Ouh7CCOQiOSGI6LLlHUcw298NukBfOTvvNumT8gOnOW42NkYxLJnitduQiu2EpT75eD9QosVgvtHF6DHgG0h6GMv1/7PwL/Za58TSCtxx8H90xy/zrtM1WCsbR8dmn/Wz98RmMzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU/5ZDly+FSYMwDs7YwvDW1Y5j8zd67Xk+OGoPFhI1A=;
 b=OgJmjpzWnEIeAru7l6oSn3LwGZk1Ag9pKb5t09QJpy5/sF+QVXMyTtC7vvtO76dxlFYJaryu0jlx/ceWDa8BUdeOPR+V0rHw35IyGG3qcQqB30WKYrBMbUCIylNYnGtVl0lw5TNMSPQs8SAcu0GTslT2uhOuBxnFU+wSu2+ZDAYod4ARektD2VzN7/BUkAGjKp+51E1k/DXRAYAUJ3539Tr8s/IvWZ6/gDhCEM6xWaf8jY77I9u5F39e4t3tpstKNC8IOk6aA5aBPny0Ap2leBlG5KDwqn0X86nCZVtP24s64UQTdnoFl26Tm1lhaTRm54gSZsOo2JHpDIpvsmimdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU/5ZDly+FSYMwDs7YwvDW1Y5j8zd67Xk+OGoPFhI1A=;
 b=S0D4NuEC8YDUhLSfcz5Q2mzSAoyD5PvEB1QeejhndCq5g/Yu+I4Nx/uYQMloK3NeBRMAv4iIsfVEn38KyoL1CN9s4h5+C68a2Cn3D/tojXkCZV3+UULvkveowi6pElhDFTo8s3t5bfbXiGXzV3VVrxx0r1KIL/YtHQZdu6LGMDaBiINrO7XsrlYyJKGqRSrsWYuM2/rrKwnpMGrNOElY2tyZyPg+7+cQi7kq/5lrzXT4wca9KLTlTFa/5bFlG/6Oa5cU+YKA8E53RCKQ7TQsiby9UpH8jiJQm8Nb9d4kD7MsyBQxNQAZ/ijxQb/lndfqeacaQLkvAmDwNjm/+pUa5g==
Received: from BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42) by
 IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Mon, 6 Apr 2026 09:11:56 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::ab) by BL0PR01CA0029.outlook.office365.com
 (2603:10b6:208:71::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:45 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:40 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:16 +0300
Subject: [PATCH rdma-next v2 05/11] RDMA/core: Fix potential use after free
 in ib_destroy_cq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-5-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=2124;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=W/2WlJLn689ImNNVXH7wlhyztcjmNw/q/99rPLeorOI=;
 b=65ZOx4WWP6Wq/6aOp880KDfUBpzx3dnDCziPEd6rhGE5X6ax7S/HYVoyYy++n5SCXN5bfXeys
 U9UaSK/8qzXCK0N34dNq6jCUGX6E1lO8N/ju079pRj6batom7ia6Hz7
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d016fc0-5a4d-424c-34d3-08de93bc8d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DDb9ikj8+lyB0DbsuQiNdZk5At6dkEPoMZVZujRU0Eo0WMQrw+a1biVW5jewbkdgyxdP8b+UD4oorbEqCS7xV5D13EyzS1y6UwV/joaRxTiDI8PaIopYncJZ//OLp1eca+wYJaB/KjFCjL2wnacpjffgQ3qFBRyGSQcYo8aY8CQJy+p6pZ2WWlDiCvwYlEV9urIrgTiOGpvOcOkBqAcKdgSul1mPBiWbCe9ebGCmyleQk317tWEuEVX4463imkNRjT6vrsOquLbqhXvBUPT5jSPEGgY9tnF8deNsRvaOQCLvo0GMvSRNQUymlWSUUycXqPBsty+j/K+HC1WTwAelonZbJIMcLAwo4ngr57hhbbS7iS8ilMjJFDW5VUu/5bOdM43XfcK4Uyl5/AM6witiJ4c90KZvquUKw8x9FIN6i/i+GQaXb0rGDlql4mSqbI/u41dEfm8O+FJqA4dANpG2dyFiUrJdKSRuTNb5sjKWql3nfpJRZFL8B+NNU6Fie3pzFRERxWcfhUHZgQJuZZw8h6XhJtwm5UXLriHMZ7Y2Gz2gDDkS7g+ISE9lNwjIxJQOOfQBzqZu8/SPY2g76MT0+hQn1et65Cp5Wo+2hxp1v4lRbYKeluwhyDebyJeuctzaQAw0exu0HSK/XZGT2SZxpN6IhUbffsP50WxUnkRoQSgPAtSx17tXfOMnRJTOl0MtYtpTolSlnx4IMgIXxWAZXzJzA+bba+9et+f9VpIqCYsHM8WGxR5nOyQV3C433vTqDgimIcTr37fzgEix8eWOx3/8JXnGcHviIydVky5NSlRNEWFsj1uR+bpr9otCH8u8
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bDpXSsEYWQjWlW68YXdvG/MxJYlOjZk/cyZWnW4n6iIqmCpv/L0VAGaiRx7JMmC3TT4LjV/S6mMIdw5XjK3XDGv3Gbj5JDehqqCX2dtLN7qf56TThUPgZGaCl6f+U8lFUOBwKTr1yR9vJTpViRqwb4+a6g86LGzb7Fy7fbnlHqov7eSZ2webpNJ/4Mq9Bob6pYJb6HewfaJHVvZXrxIFu1DjRqmsRFT51rsd0+DuW1vvzga18mdQfsSnLHbDN5a+Qfv2qwr26jqsyiMVjtUBh6ILCHfkspK2ZqCktzE7n29pzXcUGIf3SHBdJ/KBulmKYVIygTupYC6pjkRpNr3ig+3M+601rr3MI2Gu6MmApxUsnFCcGnlSu/KKjAq1w+/pDYyCc5Q6KNEBGDSduwXGjyIS17P5i9mcNEeabK7qNJJBn5C5Zhq7r1u6fqnZEMzP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:56.3268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d016fc0-5a4d-424c-34d3-08de93bc8d30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19013-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2D09A3A27E0
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


