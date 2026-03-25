Return-Path: <linux-rdma+bounces-18654-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBoyLBgyxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18654-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:06:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1C32AFF7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FC88301BD61
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09073FF8B6;
	Wed, 25 Mar 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GsmxL8VH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD53563EB;
	Wed, 25 Mar 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465288; cv=fail; b=VGwUk8xtJUnkqLBlPN/R+W6BuGT3YPRUP14DD59WH3DaZqpHqWvqxQjaQevDgg3cpnPVum5HQCjEETqgL09Wlcm4Ywr6bYoTGRHWN19uMWYJ0H0wLojm81mRe6EEE5eJoZxr/WILpoAf+FASD5/UfHA/tKqM1+6BfmBctO+xovw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465288; c=relaxed/simple;
	bh=HpzpnaKGcCcSb+984F7Z60MPP9ReCcmxBfKAt0ez2yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OFIb4IN4wHCWKM+NSUCXp49Vef95fsjJbJi8T5q3dEY/BTsK2firdWnU5eQzVv0VTASc8ZV9hGqnbYBu0pfDKR9zczRdtyTE876JqXI1FpxmH8rnf09ciPbzBdB4ORm7+GzJXwnkmNWu2AXxZykOrXAI5VY86Nx3G2GJh77Fg3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GsmxL8VH; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMjGHSSTtfEPcNYgqQhmmykCNkmDGaE8nlhlnZP/swUbFvS1nUzYxb2g18UZdU6OcpHjp4qwutxrZakt6ZMblcKPTJfEojK2CWgR+L9eEHeigi0tKURRxVBhMaGh+88DUm9psbJIlpnQvYWjpihu8THMrKKDvGHdeT2sDkB+Xn6k0pwdCDyezJfNyReDFN7FtDZRbkZaQD+bV2Mn1C4x8fNlm1tDZ6NtpvaC1Xv+Q3MBt841j2qGApsSVBPaEMFATBCWYvZXDknTVvP6DPwwlny8bQNBLIM4u5Y6DNsH5TgP1ZCEscdUyELVZYMtzMf8iGfwQNNrVViXyn1iWU/GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=wUvjdORnqk597s+NKL3fIf0j60FiySW9uDpCXK4J2b2E+SaBaGuq7n2n1cofEja6f6dLvzrpHpUs5C7DyXPgfKhTggmOoDJoxHey4A9k9d3LV9qPDltLuUP+F5nZML09qbJnrh9KeaaKyYfNoGkEuXekgeuTPcrpMWL9/0Ht9AlNjCHt0q3NdudQH30NffZYrNHrUeZkWiuFmD6N1GbkMswTFuQjLMipVmQwg2hdDxxMXXsSqEykC2fTT99KtFMpdNnk6uFJ+e0Dl1BsqcRWJIo03ZxwxzyDd1nvCd/MuZ2/3CvHi4Y7jVZYTK7/I8geR6Ez1bZClvJR2/vV5vaLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=GsmxL8VH4QFYNFTu2r01mKtx/eq53y1CjTSnK0cmco2SMFswBd6fsZa9XXziM+ZbsFzgXS522EGB1l1te0hkMj6Fs4V2dR207l9n1/ixCo61++/NweYTLr4Yu6sYyJ1LhcWIIbYCe1g4RTcJEW6i/q0xBGg1O9Jo0vA07nwW9tPY9Li0n6c+YHGTA9F5lGjpGKZY+y6bu673h0U9WN/XDAagSgB/DDAP5uruTWdapX8yB350UkxMIMbyvzUnJYdzceYFm3JQ3IUc4ol4W9uyC9rPaqO66kVXnCdMJDKZWWT6y1NSt+j3Q2QiX95yTgyb8Zd7iHTEQ5UJJ8ZvzKcr9g==
Received: from CYXPR02CA0052.namprd02.prod.outlook.com (2603:10b6:930:cd::22)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:01:23 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::9d) by CYXPR02CA0052.outlook.office365.com
 (2603:10b6:930:cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:01:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:01:01 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:56 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:09 +0200
Subject: [PATCH rdma-next 09/10] RDMA/core: Fix rereg_mr use-after-free
 race
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260325-security-bug-fixes-v1-9-c8332981ad26@nvidia.com>
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
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=2925;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HD3aLo6Y2la0d4ALg5OXwr7GfoYNm3Y3+oMXGY0tChc=;
 b=L6KsfKrypV/LuOrXeoM/V3F7f20LWwSoo2JNN8nEknLvRpDg4eTJOWO5qkJXATKzhTE1EPiYI
 O1PZxQv0sceCzrCiUKJy3WuoFYa+4UV0wF9pgBRtiutt7w9b7MXHB36
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b53a5ca-3438-4829-4c00-08de8aa0e86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1K8EVh3/eUFxIzHJn2LXiZKVfn1FjQ/4aZ3yPr7vSbpypJZX0tdEeu21qi+LvrmET6+q3gl4uXi9xLbqW/UR2Lxtw+ddc4o6U51DAdnYOm1LyFX6j309tbnLlK2+rpgDNLrn6VuTaxcqSuylURxoaLLik/j1xZkA7GsyahYy1HZibAG+J4n/o4W3Hli9EFZHDz3vc0YOKpGuKwDTcGUJtl26aBR56Kig/diGe+7p2XBbTbtAzt1ki2gxVsxr7oarIm1AgN2j9uBit1lxofjTDjyzcnk0Cu08rMeby+NYzot9tPj2ft/ujOkV7nGgd/ZIDspN4sI+b3WuOyFT9LzqO9nnKlzn5BiXLSCdhYrSMIImemAP+wJG6JAVpltjyFbCtWA767Wv41IR5Lg3KSsUuj+sMg5RCcUyM4Ot3FgfPOW8EYQx/lhr/N9Utkkf2OC847vHduO2vgmF0F3jM17xHyJ3mYTHAkoCUwNVNI0mfEOIYye2d7j5uvMme8zgDVxlMX3omGmPH8zMQk0DlZyXIlj5qpNjkNIzEDFKyNKVJouVo44HlNiKyovCA8omMGw5AsCvut4cv3XVuKg3SLMyD4/0a3QvaMV/yweJSkemfGFP5PHEyQ7aV+2TWd0TRjgVgKlpg3yQi8NUPmkWOJyccxfeNs7YheKfeG9ZzLAOSVcCTj1JqMsfPRWN1z12E6tgwSc61V+/N+p18Z7Qp0f7L4R4P9ACjfI4GETC5KBkbhd4TqeMDWUGsj8JWhDRUmnb43k7NUr+V8Fz7XbBwxhhxuCkN7hScARlTe0uNdRpaZxC4HY2LIr1Vgb+XbmXC7Le
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j0mG7+ha/pmk8qXaL3qIbU/BRrtvbwaU1eUdQb4u38Yc7yPQ5YpZ0DOV+B1DgBN7ET2TghLYyhhZ7MGoaWpqqr4KNDlO2QmWdul7FBDfgjDNV99UpLWORiwXN/33yb9sfMMLsv98JLNlCbJu3o2dT34j2woqDbBRSbMdCxZLxqlpTb7H68kkxs30xImLwJFqDBqzxBRcCMJsDAhbhS2PhlAZbdcnqIt79NyhJt1eAuc/F60JkcOrtQZqAiRz+BWGJ2ZzDc9E1EwkMJhCSs1GIB9Y4XhdMKJuLE0ZnP1tC0op/4ZNjfF4Hz0LzABiIMGZYSzjH0w+aidx6AvBSVEBwkiN1aRnad2GyT9LzQ4yafgdA1IZgtA7BMd7GpoJY4f6suqxdMo8/mGyV/41f7SBqusDEWCCZC57bpCSeDjDBHKN5mwNupWnG1uxFaUHsI5W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:23.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b53a5ca-3438-4829-4c00-08de8aa0e86b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18654-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B7E1C32AFF7
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


