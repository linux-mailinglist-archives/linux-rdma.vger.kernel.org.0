Return-Path: <linux-rdma+bounces-22639-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5GzLCULRWre5goAu9opvQ
	(envelope-from <linux-rdma+bounces-22639-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:42:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 888AE6ED792
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:42:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IZFI9rYg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22639-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22639-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4C40311DD69
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E044963BF;
	Wed,  1 Jul 2026 12:29:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF354963B3;
	Wed,  1 Jul 2026 12:29:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908961; cv=fail; b=iG8+ZH+68TDltOZeRK/uR1NbacRXVpKBXkqZ6pIpt+G6GAgiWX5HhOS4DmNeD+VOIV57Tuxm1HLIxLWjnUCySUDLTQyozQTwA+mOY8ogjjekVYgroj0ZDVTgmugvtBIlPAdEOFh222SjYYCwV+WhDtxGDBMKzIPwTgENNHV8MnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908961; c=relaxed/simple;
	bh=8uPJeswScIvk9vRITO0KMN3ZS1M094TtFx3GodXuqow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kuC2dd+5NsYBa0N+V2xtAQ21qLlZgkvXoMrW565IRLPBG9I8HhzcEmdbZ9MblT5vNq+628fgPUj3MgZIzJ4xM0fmv5AQQhNyHmsYF0VHYEuiz0HeIdCcMRVMS6WcmxiAkhUGrgObVaLSqIkpz3yLyA3e2eILqmV01E0vzWrwBOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZFI9rYg; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMnGnzBnbZvLFTh/B0CZAIu5ai/NKFRikeMZTcJA5cCbtt/f8FWmbybLT8t0v2uu1NIxRsKDNergzQxNgF4LSP74fehROkCbXUGK0G09bPQDvaf2AVixU/XcQuzSO/ojn4iyxuZ09xmM/cwnEf3vLiznup/uWN8VqLCHNQU0paJ+Reb1gqfforWdM3ox0gL3VW3AHaPi+x47ov9hJ0QTVSTJVVweDb27ME+OQW4Exr+NGRVCn3TxvSwfJ3ljvwi6FPrzqxJNf5fGLsTq4tV8UGc9M0954nP4fXqDFIRgAjxgAz5iwiQ1+mH8lH1BLnzd8BiwyxTJJrxtAgzhGuxSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w9bjwnNmBHrMM5/hUX8pplxLWIAxSVn0ZzPqjieNB0=;
 b=SBgQ26wSUszxRlg15T2dqv5awprQj/QjAddRamRp/tnuI1E6PY1ffAxPBjltJ2a1hFPm9RfljEPwmRWucSKc4mggEUulo4+C5H7Km0vRN2marT8TGQbGiicv25rVWvaaUmFvASu9HGi+skl49L14lIfl1WdeaRqRg8KIiU7JngwiwfpSvoER3WaTQf2WZIfityhqDbITbMyPcTxr1ugbbF8aD5Up8i2SXGRtpN5zwO70lb3nhN5jR+IHBUMAW2tLWlTFwADTMkXdyvnBb1yxheSjIjuHG1tW12wtqicmYK7JOHlRAGmo2AXic0MvP/cSoIcHBuNqoUuHROmCzXgL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w9bjwnNmBHrMM5/hUX8pplxLWIAxSVn0ZzPqjieNB0=;
 b=IZFI9rYg8dic+e3DayzjCqRIL6grmpDwI/KECCT5rGS4Qt06f6IE9nYXexFlMrul+V+bohqGa9ChsWzEIkFmo4ImnGXFr6wY2Fb5g8NRASN1x0z/PCdukdiCOTvcVx7+p3cMBgjdTiIwjhiPKKfrnecw+/0Pl5Bh56oY9bPEMAWP77w+1dp4PodzpbLQIR4F3OUsXV6r1WpxTiUGMyu+2byk+w6JQsAL4qnp8zga7abOYjSe8VAgDm/WpSbyRkZW+C2Sx3H+MEMHDWoBhBnWiThojSmH9K3iO2S6HF+Hw1UXICaoWXGhFSCMugLC6NomE9Cnil6dGhVQZ1tnGX5NGw==
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 12:29:13 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::14) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 05:28:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:28:56 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:52 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:18 +0300
Subject: [PATCH rdma-next 4/8] RDMA/core: Fix potential use after free in
 ib_destroy_srq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-4-c660cda4df2a@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=2320;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Jvu32SVgro+98Enzm7cCVvzDtkMapOP8jisNcoB1yCI=;
 b=4DAijORi+Ew81p1j1t0uckbIpZjLHFuMfQO1t6QFoi3dTuxsLKBeu7D2Fa7Y9ZpOZiwgbcgOx
 EYaq8dhmDD6CF7DR6FunWG6WxIXQSUPDGdGtoSokRA96h/mhdbxC71B
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: fe03122e-f322-4853-ec70-08ded76c5b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|921020|22082099003|18002099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6KqUIbySNHfqQ8IJ+ECHuY2HK19+Bb6+D8oO/YLlAx/pXXtK1Or/DM1Batwh26zMnssdPMCOmWYA2zBxUaqafKkRM/JoXdxzlV99JjBWLXla5dPb/Yay5qWJ72g+GZe71Vhn6A0c6LgpAWtg1J+tC5l84Xvpojaa0cQ9dbc2kw7dnDaJW53WlDy479nv8iGHKoIh0060bYvKZc3TfeMfAEsrHHnVmry4W/XrqlD/IfQXO2F05AMDyLcCSNtmGu2rvCHC850F/5G0qkaV5Vad678FsKrtRFNyx45UiB8/bIFYmdcVBtsK/hVDkAYB2hNgsXkUeJfKXtaFyCj9+NAUxec6nBGg00DjUtWWdOiYrxn3PbIVTOunfCbSKYP42i4X4PhP1eIIPv0cW7GRdK9BPvD7i+WCZ750X8FixHw0bvQOxkjaeKPsTXB1botH+fux0liIDwrPnVgbO2Ra0XqkM+s+vakJXFWsVy8k4EV1Sf7x1hqeuhHoQdDUBNwCjxWi5uEPReqR5JdJylDAJOU40D5sQK4YaXMiJeRD0FwEBoDBc98chABNURQbMkepGcOYu5ZQNWIorpjLhrd/j+8De5l6Dv632eujKhpuyPTxcjsOlcstjArfo8ip18Oi6cMzGbpfFoSMBJKX5HBQVv2jaDpilgqmALDiUM4mOhHO4VW2uoFQz5/OMsXri4OClKEghJjZoBSqHZGjdTHeTfef5KDHUPahEQX4fOdPeInL6sxeQLiaT3PD+h+ifH84J1Ee
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(921020)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GCiaX0Bw8m8452x9fPp7uQmk9tPoC2FFj+ejEL2+kfn2gT2pnaPPnsD8jHXhD2KYYqaxONUiXfAkETb1IjnCK9eyZcIzx4Lp2fUbWthHprQE52mh41HozxL/dj01CCg5BCxqPClMgcCPGwNOlRNxFK1rzUBHRuzNp45Gvb+7WZUtd7REIXWt+/Kv/BhjPetlqLjjQ/7gOYSLIdPfD4C8fyvoaFXzBC0Nm2GMiNygjJ7cItA3nh09X2uQYwtv2Rv+i/4GDSvuyE7sEThZ8S24LVlpV/e8tjlZZv6My4ukjXUb30YxFYqDbtzzT73Iz2YSKLv7ai8VX8tEaUuFyf6IAvK+r6kINuaTQuaEPVbLLOwtlmkd2D295iwQE3026HGC1TAl0X2HkhODS+6X0pBhj796ufVT94vl1sPlwwzxQVW0ElyBQp3eV6NLxwumaXSk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:12.3725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe03122e-f322-4853-ec70-08ded76c5b8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22639-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888AE6ED792

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

In addition, this change preserves the intended inverted order
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
index 568cb71da726a61997149e92aa570e0bcb76926c..bfbc25dee95d031f91ffef5389e81faa08170719 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1140,16 +1140,20 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
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


