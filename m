Return-Path: <linux-rdma+bounces-19580-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGmsG01D72kx/gAAu9opvQ
	(envelope-from <linux-rdma+bounces-19580-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:06:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E64717CB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15879305C5A3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0314245005;
	Mon, 27 Apr 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hwe4PKdD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435483B4EB4;
	Mon, 27 Apr 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287813; cv=fail; b=hAVYrvYQZDYaKofzv9j1S6McoNUjfTvAqd+7nKJmpSX3OJ7iYksNpypMEldBRlHay9ALruZ2mVB1Slo/yD05bjjdAUudCaeNlP+/larkG+f3RplIISfrv/b8j2yjflJg5k4OR3yaHQNGFnrVKXUeQivtv+Oc9Vm1LUqBoaQpkvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287813; c=relaxed/simple;
	bh=HpzpnaKGcCcSb+984F7Z60MPP9ReCcmxBfKAt0ez2yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JymBjrsde0hSB5rW469odFVJuWef2zjc06yUxHVYUseh8FuMmorEVyASdPAhWISLCWuNAbngTl3C1WEEBXURfcj8tBRZhMoiFQEqmE/2fBCtJoSTMQZGyRXheE21yy6guI/k3JzpMuYQ6t337dXTk1oS7cm3y+P460NLBTn7kfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hwe4PKdD; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMnC9bxke+qhybZyR6nqtLngJfRJCw4DJ3JMMBTUXu/OeKzPOddVEHP1MzKFnSH+HEun3gveM0WDUzeZIksLt1rJMaFke/JGPB6W7KmWWsYEVkRbD9DiRUxdZ4takWAHaL43NP+YwuZX+tGuA7RYQiLnx4ko/AW473kRbcXPnnebt1YkWbi7hD/wRYAIUHhWUnAFAgzNnYyjhUJschK6Bserw3DSlPBYQoGS7+p+iWDJYGSGh17XgDOUAiROMzX+wSKc+hoVx3h6Deq5WLavBJpph/4ZvYnBqGp4DN0S/CVBNw+nI5ki93ClA1gOdvCwBXatwitxdCWpfwutzB6qDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=CiruCi2yApvSeL3+u9YIyZqqiw/nzRcMWgnkCEChwoI3Nr6uhmc8432jUNobydMkyiONQB9LOc2Gjkr8p0Lf4hRj2jVGPbwmjRVVNsFum7vDoLHI8b4nkmqhRZ3s8EZTU/DF+dB2LfR0F4gvMPW+W4mVHIqH8oeyqN1RQbqmf8JvaXJQuPN4BgqG1AwoY3zvAZwB9W5a4c32R8cOLW7JCIHTcqO28gSn9iMnVQIjWgMH13AzaB6JI7Aqa/3fgy5qa5ee9OKnNqDZpG/HkbJagYql1wPBpE2xz92ejHM/akZd1AVKo7yf10mEewZS7LgvbyQoSsD0Zy+zps6syw/6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWNvwNU3G9i+nUe96uBuBDeWT+SjQAGZmET9NQQkc8M=;
 b=Hwe4PKdDKDvUAuR2bIUZGdNJ2DMHwLbsUYrsqENenOEhxo104QQ6FDP4frk+xyjKiWs7n8grPpFk+uSd9FveqLhAcAR32h7vaVkQj2S9srvu5Q6BQyVQwK+65V2Kzi3Um/UW7b9QoaS1XbUBZeAV2jVOl5x2JvyWwETjlpCZS//mc67ioUyqvChQ9WmR+NHW3lrAkWOS0b88YHVV8OvduolnjlcnKU1f8R04P4nvS+BfNYVussrpMPw5bwZOe8HT8qkqHGNROKqUjyt3qiqt6dOPUeWy9IKh89+25GQ9s15mCOE0dnzeluYqBr+l28sN83stvSNdYptsnYtvPzes9Q==
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:03:27 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::71) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:09 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:03:05 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 27 Apr 2026 14:02:35 +0300
Subject: [PATCH rdma-next v3 4/5] RDMA/core: Fix rereg_mr use-after-free
 race
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260427-security-bug-fixes-v3-4-4621fa52de0e@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=2925;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=HD3aLo6Y2la0d4ALg5OXwr7GfoYNm3Y3+oMXGY0tChc=;
 b=utzIK+zSdBtiIrD5sn782ONr8EYW0InQgcs+L+YkFfgtkkeyjHdsRaosxeufQHpz9ws18MTd8
 /ZdsO7GFCBxBFQ7dfVKxPgJXPi2ZX4+giGn5ria36sCQeHsffSc6OnT
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: e0830418-386f-491c-4519-08dea44c9b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	6xdPxzUKyyfRpXiGtc8kSf0TwrWthbO0/gkgKoFuoYSw9HOSk5Qb+Lib289yJ75ZuyJm6grfKLeGBMiDIEHCZ0vCXmCXwjSIg01xJjCMl5FBnnfNxEzHfWZSLEcJOZAVHiEDjU6XRUASsYegDjl2+M8kzpOEOaC9l+AG62xys4YKIVAPurPdMk/naXdftIOmyqDFZzOAm+zYgY8F/YpWMNcjJFoqTSnHmgU9nSc2W4AMtKCTK87houRCHfLBFiv8aexFz7xJUjW+jHJk4LqiuFo4pi78fxNOjUzWZd7/az9iKvFIjeBQlKS544+EBIBdxyqoeYk0xk8lS4WPW96fiGVnDcaBURw7L6ejlo91lGe4w58jFkTsBy+ov1YoTwjt0OvO/DMVdMvvnd8Y6cOHqNaJ9DPxQi84MfDrQEFFwt7xiulnRqDMJ9WLAEEQoNCsKmppK6d4qQeyXoN//zMLj5NX7ZXVSyOna7Ly+6i6cy7R4KAB6ds+R3Nz8L3o5aPOTSR58CiyUy0rvOl6KM0fcHlQQMCPQdk/5/QmqrmonKKmtQ9R1UEFKAFfBcSTniw5iPyDJRPvDMZ5jyAgf/aq5uuhDkdkE1doyze7M7Odv3L/xgGzy3UwbAEJ+ZzwSuGTPprzJTaIF4JtXkQ8e4clcVRWnCE/FEZN66Md2bAg5xICsfIe4wNjZizntgHDgh/EgbK7OC+Tk62tFCg/SKzt3LkJFGAtIh7J3a5A93AXPG0wwBhwnGl0gIzhCJuG9QWJfrObdmfpJA1/kAGPIKAFagQIdq58gGR4075sVZ2L0HIeRwJaovefwACxambzsIxH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	83LCoeI9j4xWClqDFTn+dqKFLXyAA8aZ11MgWTBQGuCD4NbmM4nDfAC0ILywRd8gK9eNMmdqDco6X9OQke/WiOs3Sa/MyLLI/YDWZD9ZYvImL1n6R4oby4IrRd7EShKhLc1pBTK2js0KUONsqG/p1iuh0R1w8M6SyM2mIS1Kv0K36CVhX5mwi17K93c3S+clmIfCEhGAB1PIEW2U43yC83JAoxslstHW+Hj3Zo++nmt+xqCRHX5C6mH7z/hyymdEOhdVX/SX5eOnwCSfx8mMxA121e3p/tKkRFAurdK4C1hL9DZPj43kq+0ch7R6plwxVRbA7rMEFvRQjqHMwJrFiZAhsC7zoM2TgCmnXlweg50EAUKEi+DOmYGoJ+YBE1kvgxSj3lX+C5yxVff+wl/GinYG8t8MCUFsyrIuxKLafAB1BhZlRA08QVpXqA4QYGEr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:25.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0830418-386f-491c-4519-08dea44c9b24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
X-Rspamd-Queue-Id: C30E64717CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19580-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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


