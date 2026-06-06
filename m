Return-Path: <linux-rdma+bounces-21894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F+OwCXOrI2phwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:09:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2064C830
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Qd8WLQct;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21894-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21894-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7CD730EBA36
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30492303CAE;
	Sat,  6 Jun 2026 05:00:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9E2F7F13;
	Sat,  6 Jun 2026 05:00:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722046; cv=fail; b=sZU19r19M2tFRpHEn8yepM7Cgq9BdvFI7/nbcx6m5sVVneRSLZvtGF/dTwFg5Vlf4Eh9NPu/BgNEDU3GKj83NcwVEAfByhJRuYrY/nxQQx4Z0WM6s9Edgi45UVTLSAoLwdHu6zrLgOCrri4Txdbs0E2vINRKWi0zBUQJMYcJiM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722046; c=relaxed/simple;
	bh=El9A0qcJwLeoqwW52mEsiCTr+/Qaix/HuHSDpRiiJz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se3LhMtLzeu7vm+NnLYE9MfKrzsIUYAbfvcJ0SLMhHPlslpZXkepMOLcl/JXuzK29ftM5TJudXGDVym+pGmZx6GkPQcUnG9GYxnFKKePYm9i5fxM7pYY+3R1YAGBJ1/Yhk6HDa4/iwM/rDee014P+KydSK4awfQBrBcnEpRcYWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qd8WLQct; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6+sbY7T74saq4OwNAw6tBhUxdZX+CpyowIQvDvpeBdBCkg0gB/FDDOEr9/2h0gLoZlknNP1gmv0i5HRlj1+BWCovWQkrvOQ8hqsIf592ETdIpULn7/mTR8HGPgYFWXnsPl3HCmgBop6cT1QWm7ie48mCnroT1VIrD3jpyxlJD0WuQW0Djf0Z70HqnKSeypvw5bhi+aeZMsNmIkA/VoZFsC+7USXNbP07lNH+C/PiVqhRCW3FAZqZe6LTM2++qtYyap1JLgg20Dja1ykQaFDh7Ug80s8rrrGNxh8gBXVtR2VEY9AB3qltQ6yddwxRj0VrTy+/MzcLEskqy2CgIa15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9bNPysfq2ItYP9eja/EvhjPe6OVYOicbBwY6PCGQJ0=;
 b=D/vIlydsOogsIwSKsZqPbVJdSQeg22fWCMS49FXnSTFiNQr0aL0LOqZoWfVXN9X50+44DizbtOU0lqEbo9VrGA2vPBtheNiYgEmtQ9fGnSFk08ZmYgw7E7XWHCd8Qm8e4K32e4+5PaVvZ7OkD2gMifH69cNOmoL843lgFvZgBjqsNCGK/jLOaXC6H9pkwBlDWUrVrUK3T/hqBTvDL1fW7W+xzgwIZOqGXZL2iysos7opScNEa8oAN9r7tlJAksc39Efcuz7dj6FxmCBGGw/4nxcqtCJGyZxSDi0MSHeKIx7/ijn/u6bnwE9PDamZSImnVptg2mkCgDQv4fOBJ/S9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9bNPysfq2ItYP9eja/EvhjPe6OVYOicbBwY6PCGQJ0=;
 b=Qd8WLQctGDQfn1UL3H6dHpMs1YhTHkwy3LvkjhnoXvJMT1fKIC6GUNuyoCX//vPGuWbrlG09zMMpdChaBEK1dBgabKjvqghKax8jftcpxsvc/5dQj/etZHIuSzcAKrQejtXO0o7itG0FO9BNwdAbFV7otRXwp3djfecUtFQxrJ4=
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 05:00:39 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::4) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Sat, 6
 Jun 2026 05:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:34 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:31 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 5/5] RDMA/mlx5: move mlx5 clock info to common struct ib_uverbs_clock_info
Date: Sat, 6 Jun 2026 10:30:03 +0530
Message-ID: <20260606050003.3648306-6-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f47bf95-9edc-48d2-fc9c-08dec3888db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	vCwTJDlslYP3sNf0dRFZmsYPANJRtbJXKoIFM4U6+kNkOMt8KXjUqcpmTjlevBf+qjLdDR7ZV4aku3D8H6Au3tp1x5jsmB+y1ezLW2juavvjjzbcyS/s87r3kBRcfKTx8SgTR6vDLoBnV1ecpe1okFYveTICTa/Q2ku7qiIuSv96f84CXfpLW9vds04VR3UAbI/1gDC0RdGp2tqA7cblqRCOPwXpf49OR6GDLJwmvIhho4f06AhXbvZt4jyv9FAkH4dFR78lRPo6SOrZD2UCx/b71d2HG/VvS2H4lWT7nMYg50xrOUfRPS7+FWApQ7Y8GHFL3twxbvvHtOwIYVk7um0+VHE0oTxXXqPtZaSW9PX3rkVmuCEUg7MmsjNzCc3SEF0A1/rjXn24xyw9kiW+riv019hxdBcI3exBFnGbiD02oEQFZJw+IqhweGAxlzwaHC56UJ3yheJasSA2WFkEZo7UYcaqHFRm+9US8SQquDQc2s1hxkiFCU+8ARneA5Iluj1LIfzGfg6sBhQOrwpAAXBWuPVWP+zBl0Aj/meDS+7NQfPYz2b3g25Q9r9IL+f40eRKMGXRUYX3agF346lZA4k1E6l+upOYvVfftgF57CI9re70ZORpU/T1QMHzRFVn7pGvGxLcsI8L2HTKvoVZWKbMlux3u7ibsKl5R0AfoYkLvomkPM48dQ8W9AabEW0A84DHmX4Rd7h/snFSGnh412abuLrBLQHPx6zlLX6vgn0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fRkzJzh48p5to+QoBJAUGwJYjBo4zTpDoq4Kg0tkhtcYT+vskaqmLKeMmGyOcUYNFjrUbMJ8vp7OnN61hIdAqWr+o+X5QbTG3x+BCXC5vP8CY56PEIhCAQu+/iBhEh7UlIQHsrlRM0iSIKVsz3qGYH1nzM5rXsOzeC8Wb1qBvnf9gSY6dndN9Ag0768SZmnhHQ8zLAMvaVB8xF+sL+UACH3hfBESH7FgVauCgdYHjwKYpr6sOpffnXRJRM1lXQPr+N2oPyKO1DBBJoilEaqEFJex1Qk7i/qqJ6nKKudgBUXGtMgy+RIzmtikJnnWg6U6UJxa11CRbKwexUCqOiepVYeneSNi1dhMb/5eqN9eaaPYvGV7ZwHtyDVZ5ryrY+eteWZPE7kMoKUChzCjmtNKzTH8pJZXdzdiE5QJ6RPtVhUYmy83eHkXwxACXMtMIVhc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:39.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f47bf95-9edc-48d2-fc9c-08dec3888db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21894-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94B2064C830

Use struct ib_uverbs_clock_info from ib_user_verbs.h for clock info.

The original struct mlx5_ib_clock_info remains in mlx5-abi.h for
userspace ABI compatibility.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 8 ++++----
 include/linux/mlx5/driver.h                         | 2 +-
 include/uapi/rdma/mlx5-abi.h                        | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index d0ba83d77cd1..fce6687a2773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -412,7 +412,7 @@ static u64 read_internal_timer(struct cyclecounter *cc)
 
 static void mlx5_update_clock_info_page(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
+	struct ib_uverbs_clock_info *clock_info = mdev->clock_info;
 	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_timer *timer;
 	u32 sign;
@@ -1228,7 +1228,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
+	struct ib_uverbs_clock_info *clock_info = mdev->clock_info;
 	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_timer *timer = &clock->timer;
 	u64 overflow_cycles;
@@ -1263,10 +1263,10 @@ static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
 static void mlx5_init_clock_info(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = mdev->clock;
-	struct mlx5_ib_clock_info *info;
+	struct ib_uverbs_clock_info *info;
 	struct mlx5_timer *timer;
 
-	mdev->clock_info = (struct mlx5_ib_clock_info *)get_zeroed_page(GFP_KERNEL);
+	mdev->clock_info = (struct ib_uverbs_clock_info *)get_zeroed_page(GFP_KERNEL);
 	if (!mdev->clock_info) {
 		mlx5_core_warn(mdev, "Failed to allocate IB clock info page\n");
 		return;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5405ca1038f9..3b310331d582 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -774,7 +774,7 @@ struct mlx5_core_dev {
 #endif
 	struct mlx5_clock       *clock;
 	struct mlx5_clock_dev_state *clock_state;
-	struct mlx5_ib_clock_info  *clock_info;
+	struct ib_uverbs_clock_info *clock_info;
 	struct mlx5_fw_tracer   *tracer;
 	struct mlx5_rsc_dump    *rsc_dump;
 	u32                      vsc_addr;
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 8a6ad6c6841c..1a190883d5ea 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -472,6 +472,9 @@ struct mlx5_ib_modify_wq {
 	__u32	reserved;
 };
 
+/*
+ * deprecated, see struct ib_uverbs_clock_info from ib_user_verbs.h
+ */
 struct mlx5_ib_clock_info {
 	__u32 sign;
 	__u32 resv;
-- 
2.43.0


