Return-Path: <linux-rdma+bounces-19019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBnxC79502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9453A283B
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 557FE3047BD5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C7321457;
	Mon,  6 Apr 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZGSEx9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A63264D0;
	Mon,  6 Apr 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466745; cv=fail; b=Jfqa7s6cu2fq/0Hm3Rgtd1RO6aczHG9NxmDmz9jaGKIlDW12axccAeuo3vpUl6BMVy7025eykIksgVEz6lmMD64WSYFLXf3tZ2kxxILgV1XRQnbjsZp7ZlSZ/4QSBeMoPqe3dkYFDa54jUJdC4L9TgfYt5yZZkM4AiUyXQJux4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466745; c=relaxed/simple;
	bh=HpzpnaKGcCcSb+984F7Z60MPP9ReCcmxBfKAt0ez2yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eU7zPebdS59X82yQ9hukQJzFSh7WfmsLRhxZmqF7psZ/DnNIbYpcS72zhH3QXCA51Vzm5x3Sfr9u/+hrHeBQzYjDPhbdf6iqOOOVyeXgGTrjl2mUDwzMBTuRTpbH9FSWEm5O+7m1ayqlAyjmKZ6AefuYoA3AgSr6oArN2zDyk/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZGSEx9p; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip5e9lD4CiNg/sJpxUR8DjnliNS/N/Hn5BWGZQNvSSyKnxo2VqcVuZ9+8h/+Mea4TJuCVuZyLImzL1RT8U7c5+kjOsIKfEg4s/aMAMCmFmH18dW0zDw/0rq7M12Zlc7exULhsGYCcgXtLbJrzMViqOu2aExtFXO02rCyNS7pOVJyub/ogT5DFNJ3TS64+FXrIBlRSqXqWTL7iq4f3q1Q8QgSglCdo7r6CVH4NUKBNWYk+kPFmzq5bNdURFON1zY+qkSnOR2JcBHqf0zONdkHjdFZiBv1v4riwVpMnvUqBzZiB5eLroBGOrRagSKJxUogh6CQJrCT+gef6Od5xg+c+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=YorXAme9lM/zrCuBFYhB/NnybV3es9TsaiuEM2X7nWqYP1f49g1t7EBAaetDdNoI5jbKczQgtMnaovfICCQ2V3kxe93u1pYM755/ztlX6SOEm9Bci+qif46A+hk0u/6z8PEk7Q7kzC00r7K6hBsBkiWhaEyz72x0nwIzQeW520NiUA9gkpMIMCwWkBmzO2Kg4+1/erzfr97xBpEqWJPs7SDpdUrotULkOSPESR4923FfVejJqTPE6ucBkgXFhTksX3RoQu7yUCZGC369JPX50a6KfRQzOEsla2aow+bupvZD7ipKNlrGPxMBNHkyttBKiTLC8mASJigyG8fXMUu/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=nZGSEx9pMb0y7exYDqwW8PFgyRAqB9DohRNqSbd37J5ve4H3V+ARCRg3kxnft6Nyb7mirqnSiOsLIU3++jeQmbHNkl6XdNdNL8swob4Gx79MSKHyfrQr/fm/IrH96yn6v3ttWhKWDaAFHKZEOs5oSTFVPsmmkvId7Rec/pm7nmuhLCFy4ayVSI8Yy6qzFx+RAhsH6eJo2ZAOrHLtDpKMR2Hg7V8ol5yCoZNC7OTt0ZcQK3Gpnl2j1VykTPegByidpwZm9ohNS1Stf6Q2CgKmlKnqEExXV44zCvz44EbzZSF4Pe5wJfA3kskRUAQVMnani+I3YC72FtQ8XYpRChk/hg==
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 09:12:20 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:55:cafe::94) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 09:12:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:12:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:12:08 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:12:04 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:21 +0300
Subject: [PATCH rdma-next v2 10/11] RDMA/core: Fix rereg_mr use-after-free
 race
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260406-security-bug-fixes-v2-10-ee8815fa81b7@nvidia.com>
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
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=2925;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HD3aLo6Y2la0d4ALg5OXwr7GfoYNm3Y3+oMXGY0tChc=;
 b=Yx+sJKBIXk9udyiga2cbPR49zU8b2vd/g3yhj3icZ3v7Iy0vbHi2XgqOur3aEEDO0bLvdjTi6
 0lJ4tw5xJ41BcDzGHHvgr8SJSz00HTmi3BVJZD+kuSV1qpM7XqV3vpP
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DSSPR12MB999236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfa6d7b-3611-46e9-4221-08de93bc9b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zZjRUADN+/OJ7ahMAoh8q3fw6UtRcrh2yae9vitRc2uwZ6JD+zz+P28/ptvxrMDvK3BWcZFrDxvny89fc99WIn1pCcI1/f4xdGcC8fThDV4Lx5kDA8HVApCWpl/ihrMO3yCkKdMhnM9yaFfa6K5u6cLiwKB2Qs6ahCUuNMIZk3xXWzTVFYGVi20ThXyMg7CaDfk9F0gR8g9a6dH46Io+TzIq7rsWb4naG4UjYJ9LRp2NYBMl8aVs4vlsDiqQ/W2RWcqIJP4fNUf935ptxTl2saiFtdU/XXKEqyrDhmWr+GfV28J+ZJl1eMbh5ICJQRWa6u58MaMvTNJSX3IWM/fXvGJinqkI/+OBPljznTr2oQV4u/GTk9tfAGFhlDGEgHMSu8szZOUwaZZquQhdp53GONpqYipq7b2BYGfWp5nQmkT8Fsv+eBzIXxeYbZQn++cLHXJxE9Mqe5EfGryd3V4cMQ+YvD3r8XfDfaRVkiTQ9VN/EhOI/VufwFL+R6/7GlF2xsWSSY3UpOL2eYzI6/fM/a1tBgAd6sWzRLrTJBzFHlY9wsEvDy6+O3VIoO6ZNoC4wHyPkqnRhEU/zP7vo7j6x0QxOXcDCUjh+jZY3xtne5PreVFRKijOwr32oPrsrAL8tRQW8mnEMi468Kclg5XsMvZKmfMSbFFKG/Klz9cWKT8w/xMpber+9SHkTLZ5pTFDP6P/085UyLd4usEpo/Cwfpv4h+MTxdCzhBptfsE1LP+l/VxtvVSsJeZMs4HxMV/Rs2uQEFNx9FQuNYZDUFHjhzSLzkllM9UeRcEYO3icV35OBAa6MTUnQq1RVJ2Ub9nJ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pwo3fzMEhHgLnTaZy2xJX8zaQauYmRkpRWBSm+tBwC7dnyrq1GuGWa12vp61AjARTzo64n40+IYki/hgjkZ7NxOe1UyM2uhOXD+3iY1+FsHJOf3MvvWtPgUTvcHkHIEo75/bM2zLB00MQ5rWTFXv1xf3Q6srrwW9j8OQvdYHpdwjyZQp9LVmLYd/jMntr0LqtX+4oWm3/Kdj+1OQ4ZSZpjkdCxHYha2Oyb3DVhl/cHL9bjrH0mOLpjX9ursejqsqz7S1DCEfRq1k33QdUkKu4Sl3sImwqEE/s6sf0ZfHmyIBLZp3QbYi+5OoTE2KRoWbjczugpI2Xh4lKMY5IYdLg0CDVUtvbRqzH24RrDooChFSYDHrRrNHnS3lMFlDkeL0YwF4V/NHAoQ9BKBkxmpFuROM3VXnpxTVjvpMqj/IG3xIexLl7fFrhfvTwLFoHLz0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:12:19.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfa6d7b-3611-46e9-4221-08de93bc9b1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999236
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19019-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7E9453A283B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

When a driver creates a new MR during rereg_user_mr, a race window
exists between rdma_alloc_commit_uobject() for the new MR and the point
where the code reads that MR to populate the response keys.

A concurrent rereg_mr or destroy_mr could destroy the MR in this window
and cause UAF in the first thread.

Racing flow between two rereg_mr calls:

 CPU0                           CPU1
 ----                           ----
 rereg_user_mr(mr_handle)
   uobj_get_write(mr_handle) -> mr0
   mr1 = driver→rereg()
   rdma_alloc_commit_uobject(mr1)
   // mr1 replaced mr0 and is unlocked
   uobj_put_destroy(mr0)
                                rereg_user_mr(mr_handle)
                                  uobj_get_write(mr_handle) -> mr1
                                  mr2 = driver→rereg()
                                  rdma_alloc_commit_uobject(mr2)
                                  // mr2 replaced mr1 and is unlocked
                                  uobj_put_destroy(mr1)
                                  // Destroys mr1!

   resp.lkey = mr1->lkey; // UAF - mr1 was freed!
   resp.rkey = mr1->rkey; // UAF - mr1 was freed!

Fix by storing lkey/rkey in local variables before the new MR is
unlocked and using the local variables to set the user response.

Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a768436ba46805a81ab5a0b8acd4d64b4f2b1b51..91a62d2ade4dd0ce402604ec283f8cdc70d2ef06 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -778,6 +778,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_pd *orig_pd;
 	struct ib_pd *new_pd;
 	struct ib_mr *new_mr;
+	u32 lkey, rkey;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -846,6 +847,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 		new_mr->uobject = uobj;
 		atomic_inc(&new_pd->usecnt);
 		new_uobj->object = new_mr;
+		lkey = new_mr->lkey;
+		rkey = new_mr->rkey;
 
 		rdma_restrack_new(&new_mr->res, RDMA_RESTRACK_MR);
 		rdma_restrack_set_name(&new_mr->res, NULL);
@@ -871,11 +874,13 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 			mr->iova = cmd.hca_va;
 			mr->length = cmd.length;
 		}
+		lkey = mr->lkey;
+		rkey = mr->rkey;
 	}
 
 	memset(&resp, 0, sizeof(resp));
-	resp.lkey      = mr->lkey;
-	resp.rkey      = mr->rkey;
+	resp.lkey = lkey;
+	resp.rkey = rkey;
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 

-- 
2.49.0


