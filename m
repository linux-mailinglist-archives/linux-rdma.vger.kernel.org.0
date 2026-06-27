Return-Path: <linux-rdma+bounces-22514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gzFvIX75P2qRawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A651C6D23FA
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=jWs0RVDs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22514-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22514-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D347D300721B
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9EC2E7376;
	Sat, 27 Jun 2026 16:25:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020083.outbound.protection.outlook.com [52.101.46.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325272DEA68
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577525; cv=fail; b=XqHRsU/Pzm+WFVno7sMXRD892UFx1/R+ymPuaSiscwDUvVY89TJ8EiwSH6ku5EVR18l9kGphy99ZT5ApgTtdjKwcqnr94mbEi0OrlRqTPY2LxXIQ65ryXgDtDMGU9birX9LWkZjmxe2wV0tAYU65pUcxvoljZpbVZUMBu1XuwAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577525; c=relaxed/simple;
	bh=gRsWDqcBqW9l0k7JVCAp3/cJJUywfgJ6rBv8wXlFmRs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOr1DnP4GBnBX/kxnl1In5/2hXH0pBOwHLI0EHlpoYn/OVYHxLRFAqR/jAHDU7+RXaAKoIrHRp3Z0D3vXb2d0rQS004SpeA8N1IQmWV+8cEgjPb64VVf6P3FN6F9NBoqXzugr3OLYRQM4Bo/+D7TfiZZP/F6PE9bAcqLt1H3PDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=jWs0RVDs; arc=fail smtp.client-ip=52.101.46.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nq0yIwrnLfvUtBDgggkcf1XSX04TgrpYA3/y0tpXPWbq+HYU5sBRnSSQkey0K9W//JbBSUhdk8fUu0bZFYZ+ENEPm8ysgeWD0UNnWTrvps8uOhyNT8oMAUPlZgfVa6rZNZiBU1Q0xNId9/2tK75v+A7Gq2K318Sn8IYZ5KjdseXne04uhVtguHR/f3DRBmJJ+w2mbcyKD6+KCnvNYXz34oRHKt9po/MkKL9YycthBoq/kvLQHXrRhOdomTDBm+Vv22t3wKmAwUYWW4PJCuntLW8PRVtBertFE+gWYpTzxq2snjlqpPbAf+CpiDNDWYPIZD/mHKEyv9nmpMiY/Q1arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DSz6lz3m+mv3KCwLgxK19ZZMvXE06Bz66XGKaCt2W8=;
 b=PgMZhtNP3IEq0wXClDCe+SbCWYzvjxBqr28k5B3ukzCte2sgkUAziUUVUjKxAc1K33o7r9GUvHPk1tR6RC7shr0Ihm/dq8t+Sh3aT2CSMhHdewrNdngM8YDpTYtKa3fD+4U1BkPeOOQjvQtVA8MkxWVAVeIlkaSiv5K/5wWnmrNvtTECm6OhRFd8doIJY4lUfdNd5aaqAwOZ98FiND/Nc9iqaIgPxJaIsbhJ1pBKzF9P5DIuAlxG3z66mSwACVPa83sLgEOQrvHE1/3LasLA5mta8QqjynU1ur8KbyHnlEgmhwlgS+blO0xcOkzOmqAxwZU0Ylio+KmHcRp43ijLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DSz6lz3m+mv3KCwLgxK19ZZMvXE06Bz66XGKaCt2W8=;
 b=jWs0RVDse81AhOcAcI1CZGYxGpXl/YUqyi4Wa3duo6/53CLScJb5UrAqWXZaC47l+Gc8+p6/btVPQcPMS7D3HsrP2PsA42UUnLE8HFj3HHvjhVYgbYWJxAHWysxqme0nP+wtK3FsYFXEeupStUDfw7gH3uMd8LqzsUhzY4G1uxFmnvPcMU1f5xmKzjyerc6oCuznAMYeNRC15Nt7c9Iv5U6ZmFuApyBQ1RM5g/9z7wMv0+qMwJXhJNMdbTzgSrbaG9dl/1moSqQXsc+xnaCvgq1KD9ajE3cgAsX6nhDkwq9jfEe7nJmzwRjjOb/qLhTLWdAKwXO+ewkI1VFnUm0Tyg==
Received: from BY1P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::17)
 by BL1PR01MB7771.prod.exchangelabs.com (2603:10b6:208:39a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Sat, 27 Jun 2026 16:25:11 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::43) by BY1P220CA0042.outlook.office365.com
 (2603:10b6:a03:59e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:10 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 9733C146565;
	Sat, 27 Jun 2026 12:25:09 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 924B41810D6C7;
	Sat, 27 Jun 2026 12:25:09 -0400 (EDT)
Subject: [PATCH v2 for-next 03/24] RDMA/hfi2: Add counter accessor functions
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:09 -0400
Message-ID: <178257750954.371918.12259088339903974149.stgit@awdrv-04>
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|BL1PR01MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f17a17-dcd6-461e-3ac7-08ded468a8c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|3023799007|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	sCILPdxqqc+371aa96CkMw+5mq1wenxI/ipVpD0RKJoXW8/OVrGiiS6HRFJPgT/fVe3E1cDZGQKcXRkzXYV9HXuOnqIKSGdjZtQO/Gzxbd7ErswMMavMuvuXa/J1X6L36/qEiipXY8iI4HcZ0ALxgRyOYw0IClDN4DLlUYPZKzZeT5fXQ6i7xNLO6CyVQoX6dniFFhgBWnqF/GgsH9xsjNRlqaPAobjdnDPfKkPTxPt8zePV++Ug73T8SRZ5FyB6FZNlB+kXUInajikfkjwLsyAA/O5V6FGBcYSeuHG03CQk9ZzBX2Wo4b7Vml/PnB1HvjrELroMFiFX6eSaNgyMCRoc7BWCFfMmY366vwMLfasEq4t6VvEIAP8HTlKPm93NmyupPqPnKEnsyS++HqdObPTpqKj9WG3dFnivxKaLEPjFWeMXlFeMkaYwuRkEqrQBj9mMOUFbDKTVP3GaJh0CswlUVsPe0+UWbCQ3oShJrmZf9kjxm5xHhrekJ6L0A2vB/qTamdLPb6xx948v1zW11wGc19kIIFWFWiRXu8IIbbLBDiEXaXYxKq8oh+vrUmwapVu565yTXbXZxCC7TkWDO296SiFIC7fPDi60JSS31Uq3YB7Yp5jYif9Qe1V/QvGoJHcZnn8TnjzVJTXWeRppCU2ZmlvHE3PzsUcTy3YmReWNOEBfsFWhbFroy6a2TjdoVJrf2mVKbk0L3pBeFrttYA==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jHsLvLwih2/6XEATLUT+3z5bsythpNQrMK3ULsd1iZa7+LjoZFCOEjpnhNeF5yX1wD60VXmAk6951VgqYtKpzOrLkMBY9zlF4Yk4sHm3gHa8mV4U9iLsAWFkp5RhLvf+zas3NmXv5xExu/UiSdKzyON1I8R5ssN2jKDN140PUfpfj9DiByb7iqZLhnFEAhaNH3o92uPkz60WwAZBYCr4cCygivESd5VbJ30zQPxHBh4vj5CEqBfVnbYpTjHVBZItfQBCdzTB/AoEB4IHHl4QDMqF06D642nZjRM46a+lk7S0lePWf+l7UUBISmvsO85tJR2q8+dwp1DEH4YZgk9vqfeuHxTzel35Br4UGRbqnTMbnLpiaa9Y/6QZYrYMdiWh+ORUNWpHf8X9/ysX4aow4BVYB7xXOuACOEoI274alFYWbqcy9uDK9Yg92zD5cliq
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:10.3591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f17a17-dcd6-461e-3ac7-08ded468a8c0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7771
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22514-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:doug.miller@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,awdrv-04:mid];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A651C6D23FA

Add the hardware counter accessor functions and counter table arrays
for the hfi2 driver. These are machine-generated accessor functions
and CNTR_ELEM table entries that map hardware counters to the driver
counter infrastructure. Also add the debugfs and fault infrastructure
headers used by the counter and diagnostic subsystems.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
  Changes since v1:
    - Address Leon's feedback (Re: v1 patch 08, Mar 18 2026): drop
      aspm.h include now that the custom ASPM implementation has been
      removed.
---
 drivers/infiniband/hw/hfi2/chip.h          |  725 ++---
 drivers/infiniband/hw/hfi2/chip_counters.c | 4162 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/debugfs.h       |   66 
 drivers/infiniband/hw/hfi2/fault.h         |   70 
 4 files changed, 4667 insertions(+), 356 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi2/chip_counters.c
 create mode 100644 drivers/infiniband/hw/hfi2/debugfs.h
 create mode 100644 drivers/infiniband/hw/hfi2/fault.h

diff --git a/drivers/infiniband/hw/hfi2/chip.h b/drivers/infiniband/hw/hfi2/chip.h
index 022aad2aa1ff..cf25ea55aaec 100644
--- a/drivers/infiniband/hw/hfi2/chip.h
+++ b/drivers/infiniband/hw/hfi2/chip.h
@@ -24,14 +24,14 @@
 #define TXE_NUM_32_BIT_COUNTER 7
 #define TXE_NUM_64_BIT_COUNTER 30
 #define TXE_NUM_DATA_VL 8
-#define TXE_PIO_SIZE (32 * 0x100000)	/* 32 MB */
-#define RCV_ARRAY_SIZE (64 * 1024 * 8)  /* 64K entries of 8 bytes = 512 KB */
-#define PIO_BLOCK_SIZE 64			/* bytes */
-#define SDMA_BLOCK_SIZE 64			/* bytes */
-#define RCV_BUF_BLOCK_SIZE 64               /* bytes */
-#define PIO_CMASK 0x7ff	/* counter mask for free and fill counters */
-#define WFR_MAX_EAGER_ENTRIES 2048	/* max receive eager entries */
-#define MAX_TID_PAIR_ENTRIES 1024	/* max receive expected pairs */
+#define TXE_PIO_SIZE (32 * 0x100000) /* 32 MB */
+#define RCV_ARRAY_SIZE (64 * 1024 * 8) /* 64K entries of 8 bytes = 512 KB */
+#define PIO_BLOCK_SIZE 64 /* bytes */
+#define SDMA_BLOCK_SIZE 64 /* bytes */
+#define RCV_BUF_BLOCK_SIZE 64 /* bytes */
+#define PIO_CMASK 0x7ff /* counter mask for free and fill counters */
+#define WFR_MAX_EAGER_ENTRIES 2048 /* max receive eager entries */
+#define MAX_TID_PAIR_ENTRIES 1024 /* max receive expected pairs */
 /*
  * Virtual? Allocation Unit, defined as AU = 8*2^vAU, 64 bytes, AU is fixed
  * at 64 bytes for all generation one devices
@@ -60,15 +60,15 @@
 #define WFR_TXE_EPSC_STRIDE 0x100
 
 /* PBC flags */
-#define PBC_INTR		BIT_ULL(31)
-#define PBC_9B_SC4_SHIFT	(30)	/* aka PBC_DC_INFO */
-#define PBC_9B_SC4		BIT_ULL(PBC_9B_SC4_SHIFT)
-#define PBC_TEST_EBP		BIT_ULL(29)
-#define PBC_PACKET_BYPASS	BIT_ULL(28) /* WFR only */
-#define PBC_CREDIT_RETURN	BIT_ULL(25)
-#define PBC_INSERT_BYPASS_ICRC	BIT_ULL(24)
-#define PBC_TEST_BAD_ICRC	BIT_ULL(23)
-#define PBC_FECN		BIT_ULL(22)
+#define PBC_INTR BIT_ULL(31)
+#define PBC_9B_SC4_SHIFT (30) /* aka PBC_DC_INFO */
+#define PBC_9B_SC4 BIT_ULL(PBC_9B_SC4_SHIFT)
+#define PBC_TEST_EBP BIT_ULL(29)
+#define PBC_PACKET_BYPASS BIT_ULL(28) /* WFR only */
+#define PBC_CREDIT_RETURN BIT_ULL(25)
+#define PBC_INSERT_BYPASS_ICRC BIT_ULL(24)
+#define PBC_TEST_BAD_ICRC BIT_ULL(23)
+#define PBC_FECN BIT_ULL(22)
 
 /* return PBC flag for bit sc[4] */
 static inline u64 pbc_sc4_flag(u16 sc5)
@@ -77,20 +77,20 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 }
 
 /* PBC L2 types */
-#define PBC_L2_16B 2	/* 16B header */
-#define PBC_L2_9B  3	/* 9B header */
+#define PBC_L2_16B 2 /* 16B header */
+#define PBC_L2_9B 3 /* 9B header */
 
 /* PbcInsertHcrc field settings */
-#define PBC_IHCRC_LKDETH 0x0	/* insert @ local KDETH offset */
-#define PBC_IHCRC_GKDETH 0x1	/* insert @ global KDETH offset */
-#define PBC_IHCRC_NONE   0x2	/* no HCRC inserted */
+#define PBC_IHCRC_LKDETH 0x0 /* insert @ local KDETH offset */
+#define PBC_IHCRC_GKDETH 0x1 /* insert @ global KDETH offset */
+#define PBC_IHCRC_NONE 0x2 /* no HCRC inserted */
 
 /* WFR PBC fields */
 #define PBC_STATIC_RATE_CONTROL_COUNT_SHIFT 32
 #define PBC_STATIC_RATE_CONTROL_COUNT_MASK 0xffffull
 #define PBC_STATIC_RATE_CONTROL_COUNT_SMASK \
-	(PBC_STATIC_RATE_CONTROL_COUNT_MASK << \
-	PBC_STATIC_RATE_CONTROL_COUNT_SHIFT)
+	(PBC_STATIC_RATE_CONTROL_COUNT_MASK \
+	 << PBC_STATIC_RATE_CONTROL_COUNT_SHIFT)
 
 /* JKR and beyond PBC fields */
 #define PBC_SEND_CTXT_SHIFT 56
@@ -102,8 +102,7 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 /* common PBC fields */
 #define PBC_INSERT_HCRC_SHIFT 26
 #define PBC_INSERT_HCRC_MASK 0x3ull
-#define PBC_INSERT_HCRC_SMASK \
-	(PBC_INSERT_HCRC_MASK << PBC_INSERT_HCRC_SHIFT)
+#define PBC_INSERT_HCRC_SMASK (PBC_INSERT_HCRC_MASK << PBC_INSERT_HCRC_SHIFT)
 
 #define PBC_VL_SHIFT 12
 #define PBC_VL_MASK 0xfull
@@ -111,8 +110,7 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 
 #define PBC_LENGTH_DWS_SHIFT 0
 #define PBC_LENGTH_DWS_MASK 0xfffull
-#define PBC_LENGTH_DWS_SMASK \
-	(PBC_LENGTH_DWS_MASK << PBC_LENGTH_DWS_SHIFT)
+#define PBC_LENGTH_DWS_SMASK (PBC_LENGTH_DWS_MASK << PBC_LENGTH_DWS_SHIFT)
 
 /* Credit Return Fields */
 #define CR_COUNTER_SHIFT 0
@@ -126,193 +124,189 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 #define CR_CREDIT_RETURN_DUE_TO_PBC_SHIFT 12
 #define CR_CREDIT_RETURN_DUE_TO_PBC_MASK 0x1ull
 #define CR_CREDIT_RETURN_DUE_TO_PBC_SMASK \
-	(CR_CREDIT_RETURN_DUE_TO_PBC_MASK << \
-	CR_CREDIT_RETURN_DUE_TO_PBC_SHIFT)
+	(CR_CREDIT_RETURN_DUE_TO_PBC_MASK << CR_CREDIT_RETURN_DUE_TO_PBC_SHIFT)
 
 #define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SHIFT 13
 #define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_MASK 0x1ull
 #define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SMASK \
-	(CR_CREDIT_RETURN_DUE_TO_THRESHOLD_MASK << \
-	CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SHIFT)
+	(CR_CREDIT_RETURN_DUE_TO_THRESHOLD_MASK \
+	 << CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SHIFT)
 
 #define CR_CREDIT_RETURN_DUE_TO_ERR_SHIFT 14
 #define CR_CREDIT_RETURN_DUE_TO_ERR_MASK 0x1ull
 #define CR_CREDIT_RETURN_DUE_TO_ERR_SMASK \
-	(CR_CREDIT_RETURN_DUE_TO_ERR_MASK << \
-	CR_CREDIT_RETURN_DUE_TO_ERR_SHIFT)
+	(CR_CREDIT_RETURN_DUE_TO_ERR_MASK << CR_CREDIT_RETURN_DUE_TO_ERR_SHIFT)
 
 #define CR_CREDIT_RETURN_DUE_TO_FORCE_SHIFT 15
 #define CR_CREDIT_RETURN_DUE_TO_FORCE_MASK 0x1ull
 #define CR_CREDIT_RETURN_DUE_TO_FORCE_SMASK \
-	(CR_CREDIT_RETURN_DUE_TO_FORCE_MASK << \
-	CR_CREDIT_RETURN_DUE_TO_FORCE_SHIFT)
+	(CR_CREDIT_RETURN_DUE_TO_FORCE_MASK \
+	 << CR_CREDIT_RETURN_DUE_TO_FORCE_SHIFT)
 
 /* Specific IRQ sources */
-#define CCE_ERR_INT		  0
-#define RXE_ERR_INT		  1
-#define MISC_ERR_INT		  2
-#define PIO_ERR_INT		  4
-#define SDMA_ERR_INT		  5
-#define EGRESS_ERR_INT		  6
-#define TXE_ERR_INT		  7
-#define PBC_INT			240
-#define GPIO_ASSERT_INT		241
-#define QSFP1_INT		242
-#define QSFP2_INT		243
-#define TCRIT_INT		244
+#define CCE_ERR_INT 0
+#define RXE_ERR_INT 1
+#define MISC_ERR_INT 2
+#define PIO_ERR_INT 4
+#define SDMA_ERR_INT 5
+#define EGRESS_ERR_INT 6
+#define TXE_ERR_INT 7
+#define PBC_INT 240
+#define GPIO_ASSERT_INT 241
+#define QSFP1_INT 242
+#define QSFP2_INT 243
+#define TCRIT_INT 244
 
 /* interrupt source ranges */
-#define IS_GENERAL_ERR_START		  0
-#define IS_SDMAENG_ERR_START		 16
-#define IS_SENDCTXT_ERR_START		 32
-#define IS_SDMA_START			192
-#define IS_SDMA_PROGRESS_START		208
-#define IS_SDMA_IDLE_START		224
-#define IS_VARIOUS_START		240
-#define IS_DC_START			248
-#define IS_RCVAVAIL_START		256
-#define IS_RCVURGENT_START		416
-#define IS_SENDCREDIT_START		576
-#define IS_RESERVED_START		736
-#define IS_LAST_SOURCE			767
+#define IS_GENERAL_ERR_START 0
+#define IS_SDMAENG_ERR_START 16
+#define IS_SENDCTXT_ERR_START 32
+#define IS_SDMA_START 192
+#define IS_SDMA_PROGRESS_START 208
+#define IS_SDMA_IDLE_START 224
+#define IS_VARIOUS_START 240
+#define IS_DC_START 248
+#define IS_RCVAVAIL_START 256
+#define IS_RCVURGENT_START 416
+#define IS_SENDCREDIT_START 576
+#define IS_RESERVED_START 736
+#define IS_LAST_SOURCE 767
 
 /* derived interrupt source values */
-#define IS_GENERAL_ERR_END		15
-#define IS_SDMAENG_ERR_END		31
-#define IS_SENDCTXT_ERR_END		191
-#define IS_SDMA_END                     207
-#define IS_SDMA_PROGRESS_END            223
-#define IS_SDMA_IDLE_END		239
-#define IS_VARIOUS_END			247
-#define IS_DC_END			255
-#define IS_RCVAVAIL_END			415
-#define IS_RCVURGENT_END		575
-#define IS_SENDCREDIT_END		735
-#define IS_RESERVED_END			IS_LAST_SOURCE
+#define IS_GENERAL_ERR_END 15
+#define IS_SDMAENG_ERR_END 31
+#define IS_SENDCTXT_ERR_END 191
+#define IS_SDMA_END 207
+#define IS_SDMA_PROGRESS_END 223
+#define IS_SDMA_IDLE_END 239
+#define IS_VARIOUS_END 247
+#define IS_DC_END 255
+#define IS_RCVAVAIL_END 415
+#define IS_RCVURGENT_END 575
+#define IS_SENDCREDIT_END 735
+#define IS_RESERVED_END IS_LAST_SOURCE
 
 /* DCC_CFG_PORT_CONFIG logical link states */
-#define LSTATE_DOWN    0x1
-#define LSTATE_INIT    0x2
-#define LSTATE_ARMED   0x3
-#define LSTATE_ACTIVE  0x4
+#define LSTATE_DOWN 0x1
+#define LSTATE_INIT 0x2
+#define LSTATE_ARMED 0x3
+#define LSTATE_ACTIVE 0x4
 
 /* DCC_CFG_RESET reset states */
-#define LCB_RX_FPE_TX_FPE_INTO_RESET   (DCC_CFG_RESET_RESET_LCB    | \
-					DCC_CFG_RESET_RESET_TX_FPE | \
-					DCC_CFG_RESET_RESET_RX_FPE | \
-					DCC_CFG_RESET_ENABLE_CCLK_BCC)
-					/* 0x17 */
+#define LCB_RX_FPE_TX_FPE_INTO_RESET                            \
+	(DCC_CFG_RESET_RESET_LCB | DCC_CFG_RESET_RESET_TX_FPE | \
+	 DCC_CFG_RESET_RESET_RX_FPE | DCC_CFG_RESET_ENABLE_CCLK_BCC)
+/* 0x17 */
 
-#define LCB_RX_FPE_TX_FPE_OUT_OF_RESET  DCC_CFG_RESET_ENABLE_CCLK_BCC /* 0x10 */
+#define LCB_RX_FPE_TX_FPE_OUT_OF_RESET DCC_CFG_RESET_ENABLE_CCLK_BCC /* 0x10 */
 
 /* DC8051_STS_CUR_STATE port values (physical link states) */
-#define PLS_DISABLED			   0x30
-#define PLS_OFFLINE				   0x90
-#define PLS_OFFLINE_QUIET			   0x90
-#define PLS_OFFLINE_PLANNED_DOWN_INFORM	   0x91
-#define PLS_OFFLINE_READY_TO_QUIET_LT	   0x92
-#define PLS_OFFLINE_REPORT_FAILURE		   0x93
-#define PLS_OFFLINE_READY_TO_QUIET_BCC	   0x94
-#define PLS_OFFLINE_QUIET_DURATION	   0x95
-#define PLS_POLLING				   0x20
-#define PLS_POLLING_QUIET			   0x20
-#define PLS_POLLING_ACTIVE			   0x21
-#define PLS_CONFIGPHY			   0x40
-#define PLS_CONFIGPHY_DEBOUCE		   0x40
-#define PLS_CONFIGPHY_ESTCOMM		   0x41
-#define PLS_CONFIGPHY_ESTCOMM_TXRX_HUNT	   0x42
-#define PLS_CONFIGPHY_ESTCOMM_LOCAL_COMPLETE   0x43
-#define PLS_CONFIGPHY_OPTEQ			   0x44
-#define PLS_CONFIGPHY_OPTEQ_OPTIMIZING	   0x44
-#define PLS_CONFIGPHY_OPTEQ_LOCAL_COMPLETE	   0x45
-#define PLS_CONFIGPHY_VERIFYCAP		   0x46
-#define PLS_CONFIGPHY_VERIFYCAP_EXCHANGE	   0x46
+#define PLS_DISABLED 0x30
+#define PLS_OFFLINE 0x90
+#define PLS_OFFLINE_QUIET 0x90
+#define PLS_OFFLINE_PLANNED_DOWN_INFORM 0x91
+#define PLS_OFFLINE_READY_TO_QUIET_LT 0x92
+#define PLS_OFFLINE_REPORT_FAILURE 0x93
+#define PLS_OFFLINE_READY_TO_QUIET_BCC 0x94
+#define PLS_OFFLINE_QUIET_DURATION 0x95
+#define PLS_POLLING 0x20
+#define PLS_POLLING_QUIET 0x20
+#define PLS_POLLING_ACTIVE 0x21
+#define PLS_CONFIGPHY 0x40
+#define PLS_CONFIGPHY_DEBOUCE 0x40
+#define PLS_CONFIGPHY_ESTCOMM 0x41
+#define PLS_CONFIGPHY_ESTCOMM_TXRX_HUNT 0x42
+#define PLS_CONFIGPHY_ESTCOMM_LOCAL_COMPLETE 0x43
+#define PLS_CONFIGPHY_OPTEQ 0x44
+#define PLS_CONFIGPHY_OPTEQ_OPTIMIZING 0x44
+#define PLS_CONFIGPHY_OPTEQ_LOCAL_COMPLETE 0x45
+#define PLS_CONFIGPHY_VERIFYCAP 0x46
+#define PLS_CONFIGPHY_VERIFYCAP_EXCHANGE 0x46
 #define PLS_CONFIGPHY_VERIFYCAP_LOCAL_COMPLETE 0x47
-#define PLS_CONFIGLT			   0x48
-#define PLS_CONFIGLT_CONFIGURE		   0x48
-#define PLS_CONFIGLT_LINK_TRANSFER_ACTIVE	   0x49
-#define PLS_LINKUP				   0x50
-#define PLS_PHYTEST				   0xB0
-#define PLS_INTERNAL_SERDES_LOOPBACK	   0xe1
-#define PLS_QUICK_LINKUP			   0xe2
+#define PLS_CONFIGLT 0x48
+#define PLS_CONFIGLT_CONFIGURE 0x48
+#define PLS_CONFIGLT_LINK_TRANSFER_ACTIVE 0x49
+#define PLS_LINKUP 0x50
+#define PLS_PHYTEST 0xB0
+#define PLS_INTERNAL_SERDES_LOOPBACK 0xe1
+#define PLS_QUICK_LINKUP 0xe2
 
 /* DC_DC8051_CFG_HOST_CMD_0.REQ_TYPE - 8051 host commands */
-#define HCMD_LOAD_CONFIG_DATA  0x01
-#define HCMD_READ_CONFIG_DATA  0x02
-#define HCMD_CHANGE_PHY_STATE  0x03
+#define HCMD_LOAD_CONFIG_DATA 0x01
+#define HCMD_READ_CONFIG_DATA 0x02
+#define HCMD_CHANGE_PHY_STATE 0x03
 #define HCMD_SEND_LCB_IDLE_MSG 0x04
-#define HCMD_MISC		   0x05
+#define HCMD_MISC 0x05
 #define HCMD_READ_LCB_IDLE_MSG 0x06
-#define HCMD_READ_LCB_CSR      0x07
-#define HCMD_WRITE_LCB_CSR     0x08
-#define HCMD_INTERFACE_TEST	   0xff
+#define HCMD_READ_LCB_CSR 0x07
+#define HCMD_WRITE_LCB_CSR 0x08
+#define HCMD_INTERFACE_TEST 0xff
 
 /* DC_DC8051_CFG_HOST_CMD_1.RETURN_CODE - 8051 host command return */
 #define HCMD_SUCCESS 2
 
 /* DC_DC8051_DBG_ERR_INFO_SET_BY_8051.ERROR - error flags */
-#define SPICO_ROM_FAILED		BIT(0)
-#define UNKNOWN_FRAME			BIT(1)
-#define TARGET_BER_NOT_MET		BIT(2)
-#define FAILED_SERDES_INTERNAL_LOOPBACK	BIT(3)
-#define FAILED_SERDES_INIT		BIT(4)
-#define FAILED_LNI_POLLING		BIT(5)
-#define FAILED_LNI_DEBOUNCE		BIT(6)
-#define FAILED_LNI_ESTBCOMM		BIT(7)
-#define FAILED_LNI_OPTEQ		BIT(8)
-#define FAILED_LNI_VERIFY_CAP1		BIT(9)
-#define FAILED_LNI_VERIFY_CAP2		BIT(10)
-#define FAILED_LNI_CONFIGLT		BIT(11)
-#define HOST_HANDSHAKE_TIMEOUT		BIT(12)
-#define EXTERNAL_DEVICE_REQ_TIMEOUT	BIT(13)
-
-#define FAILED_LNI (FAILED_LNI_POLLING | FAILED_LNI_DEBOUNCE \
-			| FAILED_LNI_ESTBCOMM | FAILED_LNI_OPTEQ \
-			| FAILED_LNI_VERIFY_CAP1 \
-			| FAILED_LNI_VERIFY_CAP2 \
-			| FAILED_LNI_CONFIGLT | HOST_HANDSHAKE_TIMEOUT \
-			| EXTERNAL_DEVICE_REQ_TIMEOUT)
+#define SPICO_ROM_FAILED BIT(0)
+#define UNKNOWN_FRAME BIT(1)
+#define TARGET_BER_NOT_MET BIT(2)
+#define FAILED_SERDES_INTERNAL_LOOPBACK BIT(3)
+#define FAILED_SERDES_INIT BIT(4)
+#define FAILED_LNI_POLLING BIT(5)
+#define FAILED_LNI_DEBOUNCE BIT(6)
+#define FAILED_LNI_ESTBCOMM BIT(7)
+#define FAILED_LNI_OPTEQ BIT(8)
+#define FAILED_LNI_VERIFY_CAP1 BIT(9)
+#define FAILED_LNI_VERIFY_CAP2 BIT(10)
+#define FAILED_LNI_CONFIGLT BIT(11)
+#define HOST_HANDSHAKE_TIMEOUT BIT(12)
+#define EXTERNAL_DEVICE_REQ_TIMEOUT BIT(13)
+
+#define FAILED_LNI                                                            \
+	(FAILED_LNI_POLLING | FAILED_LNI_DEBOUNCE | FAILED_LNI_ESTBCOMM |     \
+	 FAILED_LNI_OPTEQ | FAILED_LNI_VERIFY_CAP1 | FAILED_LNI_VERIFY_CAP2 | \
+	 FAILED_LNI_CONFIGLT | HOST_HANDSHAKE_TIMEOUT |                       \
+	 EXTERNAL_DEVICE_REQ_TIMEOUT)
 
 /* DC_DC8051_DBG_ERR_INFO_SET_BY_8051.HOST_MSG - host message flags */
-#define HOST_REQ_DONE		BIT(0)
-#define BC_PWR_MGM_MSG		BIT(1)
-#define BC_SMA_MSG		BIT(2)
-#define BC_BCC_UNKNOWN_MSG	BIT(3)
-#define BC_IDLE_UNKNOWN_MSG	BIT(4)
-#define EXT_DEVICE_CFG_REQ	BIT(5)
-#define VERIFY_CAP_FRAME	BIT(6)
-#define LINKUP_ACHIEVED		BIT(7)
-#define LINK_GOING_DOWN		BIT(8)
-#define LINK_WIDTH_DOWNGRADED	BIT(9)
+#define HOST_REQ_DONE BIT(0)
+#define BC_PWR_MGM_MSG BIT(1)
+#define BC_SMA_MSG BIT(2)
+#define BC_BCC_UNKNOWN_MSG BIT(3)
+#define BC_IDLE_UNKNOWN_MSG BIT(4)
+#define EXT_DEVICE_CFG_REQ BIT(5)
+#define VERIFY_CAP_FRAME BIT(6)
+#define LINKUP_ACHIEVED BIT(7)
+#define LINK_GOING_DOWN BIT(8)
+#define LINK_WIDTH_DOWNGRADED BIT(9)
 
 /* DC_DC8051_CFG_EXT_DEV_1.REQ_TYPE - 8051 host requests */
-#define HREQ_LOAD_CONFIG	0x01
-#define HREQ_SAVE_CONFIG	0x02
-#define HREQ_READ_CONFIG	0x03
-#define HREQ_SET_TX_EQ_ABS	0x04
-#define HREQ_SET_TX_EQ_REL	0x05
-#define HREQ_ENABLE		0x06
-#define HREQ_LCB_RESET		0x07
-#define HREQ_CONFIG_DONE	0xfe
-#define HREQ_INTERFACE_TEST	0xff
+#define HREQ_LOAD_CONFIG 0x01
+#define HREQ_SAVE_CONFIG 0x02
+#define HREQ_READ_CONFIG 0x03
+#define HREQ_SET_TX_EQ_ABS 0x04
+#define HREQ_SET_TX_EQ_REL 0x05
+#define HREQ_ENABLE 0x06
+#define HREQ_LCB_RESET 0x07
+#define HREQ_CONFIG_DONE 0xfe
+#define HREQ_INTERFACE_TEST 0xff
 
 /* DC_DC8051_CFG_EXT_DEV_0.RETURN_CODE - 8051 host request return codes */
-#define HREQ_INVALID		0x01
-#define HREQ_SUCCESS		0x02
-#define HREQ_NOT_SUPPORTED		0x03
-#define HREQ_FEATURE_NOT_SUPPORTED	0x04 /* request specific feature */
-#define HREQ_REQUEST_REJECTED	0xfe
-#define HREQ_EXECUTION_ONGOING	0xff
+#define HREQ_INVALID 0x01
+#define HREQ_SUCCESS 0x02
+#define HREQ_NOT_SUPPORTED 0x03
+#define HREQ_FEATURE_NOT_SUPPORTED 0x04 /* request specific feature */
+#define HREQ_REQUEST_REJECTED 0xfe
+#define HREQ_EXECUTION_ONGOING 0xff
 
 /* MISC host command functions */
 #define HCMD_MISC_REQUEST_LCB_ACCESS 0x1
-#define HCMD_MISC_GRANT_LCB_ACCESS   0x2
+#define HCMD_MISC_GRANT_LCB_ACCESS 0x2
 
 /* idle flit message types */
 #define IDLE_PHYSICAL_LINK_MGMT 0x1
-#define IDLE_CRU		    0x2
-#define IDLE_SMA		    0x3
-#define IDLE_POWER_MGMT	    0x4
+#define IDLE_CRU 0x2
+#define IDLE_SMA 0x3
+#define IDLE_POWER_MGMT 0x4
 
 /* idle flit message send fields (both send and read) */
 #define IDLE_PAYLOAD_MASK 0xffffffffffull /* 40 bits */
@@ -325,14 +319,14 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 #define READ_IDLE_MSG_TYPE_SHIFT 0
 
 /* SMA idle flit payload commands */
-#define SMA_IDLE_ARM	1
+#define SMA_IDLE_ARM 1
 #define SMA_IDLE_ACTIVE 2
 
 /* DC_DC8051_CFG_MODE.GENERAL bits */
 #define DISABLE_SELF_GUID_CHECK 0x2
 
 /* Bad L2 frame error code */
-#define BAD_L2_ERR      0x6
+#define BAD_L2_ERR 0x6
 
 /*
  * Eager buffer minimum and maximum sizes supported by the hardware.
@@ -341,10 +335,10 @@ static inline u64 pbc_sc4_flag(u16 sc5)
  * allocatable for Eager buffer to a single context. All others
  * are limits for the RcvArray entries.
  */
-#define MIN_EAGER_BUFFER       (4 * 1024)
-#define MAX_EAGER_BUFFER       (256 * 1024)
+#define MIN_EAGER_BUFFER (4 * 1024)
+#define MAX_EAGER_BUFFER (256 * 1024)
 #define MAX_EAGER_BUFFER_TOTAL (64 * (1 << 20)) /* max per ctxt 64MB */
-#define MAX_EXPECTED_BUFFER    (2048 * 1024)
+#define MAX_EXPECTED_BUFFER (2048 * 1024)
 #define HFI2_MIN_HDRQ_EGRBUF_CNT 32
 #define HFI2_MAX_HDRQ_EGRBUF_CNT 16352
 
@@ -365,17 +359,17 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 /*
  * Freeze handling flags
  */
-#define FREEZE_ABORT     0x01	/* do not do recovery */
-#define FREEZE_SELF	     0x02	/* initiate the freeze */
-#define FREEZE_LINK_DOWN 0x04	/* link is down */
+#define FREEZE_ABORT 0x01 /* do not do recovery */
+#define FREEZE_SELF 0x02 /* initiate the freeze */
+#define FREEZE_LINK_DOWN 0x04 /* link is down */
 
 /*
  * Chip implementation codes.
  */
-#define ICODE_RTL_SILICON		0x00
-#define ICODE_RTL_VCS_SIMULATION	0x01
-#define ICODE_FPGA_EMULATION	0x02
-#define ICODE_FUNCTIONAL_SIMULATOR	0x03
+#define ICODE_RTL_SILICON 0x00
+#define ICODE_RTL_VCS_SIMULATION 0x01
+#define ICODE_FPGA_EMULATION 0x02
+#define ICODE_FUNCTIONAL_SIMULATOR 0x03
 
 /*
  * 8051 data memory size.
@@ -386,34 +380,34 @@ static inline u64 pbc_sc4_flag(u16 sc5)
  * 8051 firmware registers
  */
 #define NUM_GENERAL_FIELDS 0x17
-#define NUM_LANE_FIELDS    0x8
+#define NUM_LANE_FIELDS 0x8
 
 /* 8051 general register Field IDs */
-#define LINK_OPTIMIZATION_SETTINGS   0x00
-#define LINK_TUNING_PARAMETERS	     0x02
-#define DC_HOST_COMM_SETTINGS	     0x03
-#define TX_SETTINGS		     0x06
-#define VERIFY_CAP_LOCAL_PHY	     0x07
-#define VERIFY_CAP_LOCAL_FABRIC	     0x08
-#define VERIFY_CAP_LOCAL_LINK_MODE   0x09
-#define LOCAL_DEVICE_ID		     0x0a
-#define RESERVED_REGISTERS	     0x0b
-#define LOCAL_LNI_INFO		     0x0c
-#define REMOTE_LNI_INFO              0x0d
-#define MISC_STATUS		     0x0e
-#define VERIFY_CAP_REMOTE_PHY	     0x0f
-#define VERIFY_CAP_REMOTE_FABRIC     0x10
+#define LINK_OPTIMIZATION_SETTINGS 0x00
+#define LINK_TUNING_PARAMETERS 0x02
+#define DC_HOST_COMM_SETTINGS 0x03
+#define TX_SETTINGS 0x06
+#define VERIFY_CAP_LOCAL_PHY 0x07
+#define VERIFY_CAP_LOCAL_FABRIC 0x08
+#define VERIFY_CAP_LOCAL_LINK_MODE 0x09
+#define LOCAL_DEVICE_ID 0x0a
+#define RESERVED_REGISTERS 0x0b
+#define LOCAL_LNI_INFO 0x0c
+#define REMOTE_LNI_INFO 0x0d
+#define MISC_STATUS 0x0e
+#define VERIFY_CAP_REMOTE_PHY 0x0f
+#define VERIFY_CAP_REMOTE_FABRIC 0x10
 #define VERIFY_CAP_REMOTE_LINK_WIDTH 0x11
-#define LAST_LOCAL_STATE_COMPLETE    0x12
-#define LAST_REMOTE_STATE_COMPLETE   0x13
-#define LINK_QUALITY_INFO            0x14
-#define REMOTE_DEVICE_ID	     0x15
-#define LINK_DOWN_REASON	     0x16 /* first byte of offset 0x16 */
-#define VERSION_PATCH		     0x16 /* last byte of offset 0x16 */
+#define LAST_LOCAL_STATE_COMPLETE 0x12
+#define LAST_REMOTE_STATE_COMPLETE 0x13
+#define LINK_QUALITY_INFO 0x14
+#define REMOTE_DEVICE_ID 0x15
+#define LINK_DOWN_REASON 0x16 /* first byte of offset 0x16 */
+#define VERSION_PATCH 0x16 /* last byte of offset 0x16 */
 
 /* 8051 lane specific register field IDs */
-#define TX_EQ_SETTINGS		0x00
-#define CHANNEL_LOSS_SETTINGS	0x05
+#define TX_EQ_SETTINGS 0x00
+#define CHANNEL_LOSS_SETTINGS 0x05
 
 /* Lane ID for general configuration registers */
 #define GENERAL_CONFIG 4
@@ -429,35 +423,35 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 #define LOAD_DATA_FIELD_ID_MASK 0xfull
 #define LOAD_DATA_LANE_ID_SHIFT 32
 #define LOAD_DATA_LANE_ID_MASK 0xfull
-#define LOAD_DATA_DATA_SHIFT   0x0
-#define LOAD_DATA_DATA_MASK   0xffffffffull
+#define LOAD_DATA_DATA_SHIFT 0x0
+#define LOAD_DATA_DATA_MASK 0xffffffffull
 
 /* READ_DATA 8051 command shifts and fields */
 #define READ_DATA_FIELD_ID_SHIFT 40
 #define READ_DATA_FIELD_ID_MASK 0xffull
 #define READ_DATA_LANE_ID_SHIFT 32
 #define READ_DATA_LANE_ID_MASK 0xffull
-#define READ_DATA_DATA_SHIFT   0x0
-#define READ_DATA_DATA_MASK   0xffffffffull
+#define READ_DATA_DATA_SHIFT 0x0
+#define READ_DATA_DATA_MASK 0xffffffffull
 
 /* TX settings fields */
-#define ENABLE_LANE_TX_SHIFT		0
-#define ENABLE_LANE_TX_MASK		0xff
-#define TX_POLARITY_INVERSION_SHIFT	8
-#define TX_POLARITY_INVERSION_MASK	0xff
-#define RX_POLARITY_INVERSION_SHIFT	16
-#define RX_POLARITY_INVERSION_MASK	0xff
-#define MAX_RATE_SHIFT			24
-#define MAX_RATE_MASK			0xff
+#define ENABLE_LANE_TX_SHIFT 0
+#define ENABLE_LANE_TX_MASK 0xff
+#define TX_POLARITY_INVERSION_SHIFT 8
+#define TX_POLARITY_INVERSION_MASK 0xff
+#define RX_POLARITY_INVERSION_SHIFT 16
+#define RX_POLARITY_INVERSION_MASK 0xff
+#define MAX_RATE_SHIFT 24
+#define MAX_RATE_MASK 0xff
 
 /* verify capability PHY fields */
-#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT	0x4
-#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_MASK	0x1
-#define POWER_MANAGEMENT_SHIFT			0x0
-#define POWER_MANAGEMENT_MASK			0xf
+#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT 0x4
+#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_MASK 0x1
+#define POWER_MANAGEMENT_SHIFT 0x0
+#define POWER_MANAGEMENT_MASK 0xf
 
 /* 8051 lane register Field IDs */
-#define SPICO_FW_VERSION 0x7	/* SPICO firmware version */
+#define SPICO_FW_VERSION 0x7 /* SPICO firmware version */
 
 /* SPICO firmware version fields */
 #define SPICO_ROM_VERSION_SHIFT 0
@@ -466,20 +460,20 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 #define SPICO_ROM_PROD_ID_MASK 0xffff
 
 /* verify capability fabric fields */
-#define VAU_SHIFT	0
-#define VAU_MASK	0x0007
-#define Z_SHIFT		3
-#define Z_MASK		0x0001
-#define VCU_SHIFT	4
-#define VCU_MASK	0x0007
-#define VL15BUF_SHIFT	8
-#define VL15BUF_MASK	0x0fff
+#define VAU_SHIFT 0
+#define VAU_MASK 0x0007
+#define Z_SHIFT 3
+#define Z_MASK 0x0001
+#define VCU_SHIFT 4
+#define VCU_MASK 0x0007
+#define VL15BUF_SHIFT 8
+#define VL15BUF_MASK 0x0fff
 #define CRC_SIZES_SHIFT 20
-#define CRC_SIZES_MASK	0x7
+#define CRC_SIZES_MASK 0x7
 
 /* verify capability local link width fields */
-#define LINK_WIDTH_SHIFT 0		/* also for remote link width */
-#define LINK_WIDTH_MASK 0xffff		/* also for remote link width */
+#define LINK_WIDTH_SHIFT 0 /* also for remote link width */
+#define LINK_WIDTH_MASK 0xffff /* also for remote link width */
 #define LOCAL_FLAG_BITS_SHIFT 16
 #define LOCAL_FLAG_BITS_MASK 0xff
 #define MISC_CONFIG_BITS_SHIFT 24
@@ -503,7 +497,7 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 
 /* local LNI link width fields */
 #define ENABLE_LANE_RX_SHIFT 16
-#define ENABLE_LANE_RX_MASK  0xff
+#define ENABLE_LANE_RX_MASK 0xff
 
 /* mask, shift for reading 'mgmt_enabled' value from REMOTE_LNI_INFO field */
 #define MGMT_ALLOWED_SHIFT 23
@@ -511,27 +505,27 @@ static inline u64 pbc_sc4_flag(u16 sc5)
 
 /* mask, shift for 'link_quality' within LINK_QUALITY_INFO field */
 #define LINK_QUALITY_SHIFT 24
-#define LINK_QUALITY_MASK  0x7
+#define LINK_QUALITY_MASK 0x7
 
 /*
  * mask, shift for reading 'planned_down_remote_reason_code'
  * from LINK_QUALITY_INFO field
  */
 #define DOWN_REMOTE_REASON_SHIFT 16
-#define DOWN_REMOTE_REASON_MASK  0xff
+#define DOWN_REMOTE_REASON_MASK 0xff
 
 #define HOST_INTERFACE_VERSION 1
 #define HOST_INTERFACE_VERSION_SHIFT 16
-#define HOST_INTERFACE_VERSION_MASK  0xff
+#define HOST_INTERFACE_VERSION_MASK 0xff
 
 /* verify capability PHY power management bits */
-#define PWRM_BER_CONTROL	0x1
-#define PWRM_BANDWIDTH_CONTROL	0x2
+#define PWRM_BER_CONTROL 0x1
+#define PWRM_BANDWIDTH_CONTROL 0x2
 
 /* 8051 link down reasons */
-#define LDR_LINK_TRANSFER_ACTIVE_LOW   0xa
+#define LDR_LINK_TRANSFER_ACTIVE_LOW 0xa
 #define LDR_RECEIVED_LINKDOWN_IDLE_MSG 0xb
-#define LDR_RECEIVED_HOST_OFFLINE_REQ  0xc
+#define LDR_RECEIVED_HOST_OFFLINE_REQ 0xc
 
 /* verify capability fabric CRC size bits */
 enum {
@@ -544,17 +538,17 @@ enum {
 
 /* misc status version fields */
 #define STS_FM_VERSION_MINOR_SHIFT 16
-#define STS_FM_VERSION_MINOR_MASK  0xff
+#define STS_FM_VERSION_MINOR_MASK 0xff
 #define STS_FM_VERSION_MAJOR_SHIFT 24
-#define STS_FM_VERSION_MAJOR_MASK  0xff
+#define STS_FM_VERSION_MAJOR_MASK 0xff
 #define STS_FM_VERSION_PATCH_SHIFT 24
-#define STS_FM_VERSION_PATCH_MASK  0xff
+#define STS_FM_VERSION_PATCH_MASK 0xff
 
 /* LCB_CFG_CRC_MODE TX_VAL and RX_VAL CRC mode values */
-#define LCB_CRC_16B			0x0	/* 16b CRC */
-#define LCB_CRC_14B			0x1	/* 14b CRC */
-#define LCB_CRC_48B			0x2	/* 48b CRC */
-#define LCB_CRC_12B_16B_PER_LANE	0x3	/* 12b-16b per lane CRC */
+#define LCB_CRC_16B 0x0 /* 16b CRC */
+#define LCB_CRC_14B 0x1 /* 14b CRC */
+#define LCB_CRC_48B 0x2 /* 48b CRC */
+#define LCB_CRC_12B_16B_PER_LANE 0x3 /* 12b-16b per lane CRC */
 
 /*
  * the following enum is (almost) a copy/paste of the definition
@@ -565,81 +559,81 @@ enum {
 	PORT_LTP_CRC_MODE_14 = 1, /* 14-bit LTP CRC mode (optional) */
 	PORT_LTP_CRC_MODE_16 = 2, /* 16-bit LTP CRC mode */
 	PORT_LTP_CRC_MODE_48 = 4,
-		/* 48-bit overlapping LTP CRC mode (optional) */
+	/* 48-bit overlapping LTP CRC mode (optional) */
 	PORT_LTP_CRC_MODE_PER_LANE = 8
-		/* 12 to 16 bit per lane LTP CRC mode (optional) */
+	/* 12 to 16 bit per lane LTP CRC mode (optional) */
 };
 
 /* timeouts */
-#define LINK_RESTART_DELAY 1000		/* link restart delay, in ms */
-#define TIMEOUT_8051_START 5000         /* 8051 start timeout, in ms */
-#define DC8051_COMMAND_TIMEOUT 1000	/* DC8051 command timeout, in ms */
-#define FREEZE_STATUS_TIMEOUT 20	/* wait for freeze indicators, in ms */
-#define VL_STATUS_CLEAR_TIMEOUT 5000	/* per-VL status clear, in ms */
-#define CCE_STATUS_TIMEOUT 10		/* time to clear CCE Status, in ms */
+#define LINK_RESTART_DELAY 1000 /* link restart delay, in ms */
+#define TIMEOUT_8051_START 5000 /* 8051 start timeout, in ms */
+#define DC8051_COMMAND_TIMEOUT 1000 /* DC8051 command timeout, in ms */
+#define FREEZE_STATUS_TIMEOUT 20 /* wait for freeze indicators, in ms */
+#define VL_STATUS_CLEAR_TIMEOUT 5000 /* per-VL status clear, in ms */
+#define CCE_STATUS_TIMEOUT 10 /* time to clear CCE Status, in ms */
 
 /* cclock tick time, in picoseconds per tick: 1/speed * 10^12  */
-#define ASIC_CCLOCK_PS  1242	/* 805 MHz */
+#define ASIC_CCLOCK_PS 1242 /* 805 MHz */
 
 /*
  * Mask of enabled MISC errors.  Do not enable the two RSA engine errors -
  * see firmware.c:run_rsa() for details.
  */
-#define DRIVER_MISC_MASK \
-	(~(MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK \
-		| MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK))
+#define DRIVER_MISC_MASK                                   \
+	(~(MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK | \
+	   MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK))
 
 /* valid values for the hfi2_loopback module parameter */
-#define LOOPBACK_NONE	0	/* no hfi2_loopback - default */
+#define LOOPBACK_NONE 0 /* no hfi2_loopback - default */
 #define LOOPBACK_SERDES 1
-#define LOOPBACK_LCB	2
-#define LOOPBACK_CABLE	3	/* external cable */
+#define LOOPBACK_LCB 2
+#define LOOPBACK_CABLE 3 /* external cable */
 
 /* set up bits in MISC_CONFIG_BITS */
 #define LOOPBACK_SERDES_CONFIG_BIT_MASK_SHIFT 0
-#define EXT_CFG_LCB_RESET_SUPPORTED_SHIFT     3
+#define EXT_CFG_LCB_RESET_SUPPORTED_SHIFT 3
 
 /* read and write hardware registers */
 u64 hfi2_read_csr(const struct hfi2_devdata *dd, u32 offset);
 void hfi2_write_csr(const struct hfi2_devdata *dd, u32 offset, u64 value);
 u64 hfi2_read_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
-		  u32 stride);
+		       u32 stride);
 void hfi2_write_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
-		    u32 stride, u64 value);
+			 u32 stride, u64 value);
 
 int hfi2_read_lcb_csr(struct hfi2_pportdata *ppd, u32 offset, u64 *data);
 int hfi2_write_lcb_csr(struct hfi2_pportdata *ppd, u32 offset, u64 data);
 
-void __iomem *hfi2_get_csr_addr(
-	const struct hfi2_devdata *dd,
-	u32 offset);
+void __iomem *hfi2_get_csr_addr(const struct hfi2_devdata *dd, u32 offset);
 
 bool hfi2_wfr_check_synth_status(struct hfi2_devdata *dd);
 void hfi2_wfr_update_synth_status(struct hfi2_devdata *dd);
 
 u8 hfi2_encode_rcv_header_entry_size(u8 size);
 int hfi2_validate_rcvhdrcnt(struct hfi2_devdata *dd, uint thecnt);
-void hfi2_set_hdrq_regs(struct hfi2_pportdata *ppd, u16 ctxt, u8 entsize, u16 hdrcnt,
-		   u8 kdeth_rcv_hdr);
-void hfi2_wfr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size);
+void hfi2_set_hdrq_regs(struct hfi2_pportdata *ppd, u16 ctxt, u8 entsize,
+			u16 hdrcnt, u8 kdeth_rcv_hdr);
+void hfi2_wfr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt,
+				  u32 size);
 
-u64 hfi2_wfr_create_pbc(struct hfi2_pportdata *ppd, bool hfi2_loopback, u64 flags, int srate_mbs,
-		   u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
+u64 hfi2_wfr_create_pbc(struct hfi2_pportdata *ppd, bool hfi2_loopback,
+			u64 flags, int srate_mbs, u32 vl, u32 dw_len, u32 l2,
+			u32 dlid, u32 sctxt);
 
 /* firmware.c */
 #define SBUS_MASTER_BROADCAST 0xfd
-#define NUM_PCIE_SERDES 16	/* number of PCIe serdes on the SBus */
+#define NUM_PCIE_SERDES 16 /* number of PCIe serdes on the SBus */
 extern const u8 hfi2_pcie_serdes_broadcast[];
 extern const u8 hfi2_pcie_pcs_addrs[2][NUM_PCIE_SERDES];
 
 /* SBus commands */
 #define RESET_SBUS_RECEIVER 0x20
 #define WRITE_SBUS_RECEIVER 0x21
-#define READ_SBUS_RECEIVER  0x22
-void hfi2_sbus_request(struct hfi2_devdata *dd,
-		  u8 receiver_addr, u8 data_addr, u8 command, u32 data_in);
-int hfi2_sbus_request_slow(struct hfi2_devdata *dd,
-		      u8 receiver_addr, u8 data_addr, u8 command, u32 data_in);
+#define READ_SBUS_RECEIVER 0x22
+void hfi2_sbus_request(struct hfi2_devdata *dd, u8 receiver_addr, u8 data_addr,
+		       u8 command, u32 data_in);
+int hfi2_sbus_request_slow(struct hfi2_devdata *dd, u8 receiver_addr,
+			   u8 data_addr, u8 command, u32 data_in);
 void hfi2_set_sbus_fast_mode(struct hfi2_devdata *dd);
 void hfi2_clear_sbus_fast_mode(struct hfi2_devdata *dd);
 int hfi2_firmware_init(struct hfi2_devdata *dd);
@@ -657,24 +651,25 @@ void hfi2_release_hw_mutex(struct hfi2_devdata *dd);
  *	HFI0 bits  7:0
  *	HFI2 bits 15:8
  */
-#define CR_SBUS  0x01	/* SBUS, THERM, and PCIE registers */
-#define CR_EPROM 0x02	/* EEP, GPIO registers */
-#define CR_I2C1  0x04	/* QSFP1_OE register */
-#define CR_I2C2  0x08	/* QSFP2_OE register */
-#define CR_DYN_SHIFT 8	/* dynamic flag shift */
-#define CR_DYN_MASK  ((1ull << CR_DYN_SHIFT) - 1)
+#define CR_SBUS 0x01 /* SBUS, THERM, and PCIE registers */
+#define CR_EPROM 0x02 /* EEP, GPIO registers */
+#define CR_I2C1 0x04 /* QSFP1_OE register */
+#define CR_I2C2 0x08 /* QSFP2_OE register */
+#define CR_DYN_SHIFT 8 /* dynamic flag shift */
+#define CR_DYN_MASK ((1ull << CR_DYN_SHIFT) - 1)
 
 /*
  * Bitmask of static ASIC states these are outside of the dynamic ASIC
  * block chip resources above.  These are to be set once and never cleared.
  * Must be holding the SBus dynamic flag when setting.
  */
-#define CR_THERM_INIT	0x010000
+#define CR_THERM_INIT 0x010000
 
-int hfi2_acquire_chip_resource(struct hfi2_devdata *dd, u32 resource, u32 mswait);
+int hfi2_acquire_chip_resource(struct hfi2_devdata *dd, u32 resource,
+			       u32 mswait);
 void hfi2_release_chip_resource(struct hfi2_devdata *dd, u32 resource);
 bool hfi2_check_chip_resource(struct hfi2_devdata *dd, u32 resource,
-			 const char *func);
+			      const char *func);
 void hfi2_init_chip_resources(struct hfi2_devdata *dd);
 void hfi2_finish_chip_resources(struct hfi2_devdata *dd);
 
@@ -685,7 +680,8 @@ void hfi2_finish_chip_resources(struct hfi2_devdata *dd);
 #define QSFP_WAIT 20000 /* long enough for FW update to the F4 uc */
 
 void hfi2_fabric_serdes_reset(struct hfi2_devdata *dd);
-int hfi2_read_8051_data(struct hfi2_devdata *dd, u32 addr, u32 len, u64 *result);
+int hfi2_read_8051_data(struct hfi2_devdata *dd, u32 addr, u32 len,
+			u64 *result);
 
 /* wfr specific */
 int hfi2_wfr_find_used_resources(struct hfi2_devdata *dd);
@@ -693,16 +689,16 @@ int hfi2_wfr_early_per_chip_init(struct hfi2_devdata *dd);
 int hfi2_wfr_mid_per_chip_init(struct hfi2_devdata *dd);
 int hfi2_wfr_late_per_chip_init(struct hfi2_devdata *dd);
 void hfi2_wfr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
-			    u64 *kctxt_ctrl, bool enable);
+				 u64 *kctxt_ctrl, bool enable);
 
 /* chip.c */
-void hfi2_read_misc_status(struct hfi2_devdata *dd, u8 *ver_major, u8 *ver_minor,
-		      u8 *ver_patch);
+void hfi2_read_misc_status(struct hfi2_devdata *dd, u8 *ver_major,
+			   u8 *ver_minor, u8 *ver_patch);
 int hfi2_write_host_interface_version(struct hfi2_devdata *dd, u8 version);
 void hfi2_read_guid(struct hfi2_devdata *dd);
 int hfi2_wait_fm_ready(struct hfi2_devdata *dd, u32 mstimeout);
 void hfi2_set_link_down_reason(struct hfi2_pportdata *ppd, u8 lcl_reason,
-			  u8 neigh_reason, u8 rem_reason);
+			       u8 neigh_reason, u8 rem_reason);
 int hfi2_set_link_state(struct hfi2_pportdata *ppd, u32 state);
 void hfi2_init_kdeth_qp(struct hfi2_devdata *dd);
 int hfi2_port_ltp_to_cap(int port_ltp);
@@ -719,16 +715,18 @@ void hfi2_qsfp_event(struct work_struct *work);
 void hfi2_start_freeze_handling(struct hfi2_devdata *dd, int flags);
 void hfi2_start_linkdown_handling(struct hfi2_pportdata *ppd);
 int hfi2_send_idle_sma(struct hfi2_devdata *dd, u64 message);
-int hfi2_load_8051_config(struct hfi2_devdata *dd, u8 target, u8 addr, u32 data);
-int hfi2_read_8051_config(struct hfi2_devdata *dd, u8 target, u8 addr, u32 *data);
+int hfi2_load_8051_config(struct hfi2_devdata *dd, u8 target, u8 addr,
+			  u32 data);
+int hfi2_read_8051_config(struct hfi2_devdata *dd, u8 target, u8 addr,
+			  u32 *data);
 int hfi2_start_link(struct hfi2_pportdata *ppd);
 int hfi2_bringup_serdes(struct hfi2_pportdata *ppd);
 bool hfi2_apply_link_downgrade_policy(struct hfi2_pportdata *ppd,
-				 bool refresh_widths);
-void hfi2_update_usrhead(struct hfi2_ctxtdata *rcd, u32 hd, u32 updegr, u32 egrhd,
-		    u32 intr_adjust, u32 npkts);
-void hfi2_update_usrhead_ctxt(struct hfi2_devdata *dd, u16 ctxt, u32 hd, u32 intr_cnt,
-			 u32 updegr, u32 egrhd);
+				      bool refresh_widths);
+void hfi2_update_usrhead(struct hfi2_ctxtdata *rcd, u32 hd, u32 updegr,
+			 u32 egrhd, u32 intr_adjust, u32 npkts);
+void hfi2_update_usrhead_ctxt(struct hfi2_devdata *dd, u16 ctxt, u32 hd,
+			      u32 intr_cnt, u32 updegr, u32 egrhd);
 int hfi2_stop_drain_data_vls(struct hfi2_pportdata *ppd);
 int hfi2_open_fill_data_vls(struct hfi2_pportdata *ppd);
 u32 hfi2_ns_to_cclock(struct hfi2_devdata *dd, u32 ns);
@@ -748,14 +746,15 @@ u32 hfi2_driver_lstate(struct hfi2_pportdata *ppd);
 int hfi2_acquire_lcb_access(struct hfi2_devdata *dd, int sleep_ok);
 int hfi2_release_lcb_access(struct hfi2_devdata *dd, int sleep_ok);
 #define LCB_START DC_LCB_CSRS
-#define LCB_END   DC_8051_CSRS /* next block is 8051 */
+#define LCB_END DC_8051_CSRS /* next block is 8051 */
 extern uint hfi2_num_vls;
 
 extern uint disable_integrity;
 u64 hfi2_read_dev_cntr(struct hfi2_devdata *dd, int index, int vl);
 u64 hfi2_write_dev_cntr(struct hfi2_devdata *dd, int index, int vl, u64 data);
 u64 hfi2_read_port_cntr(struct hfi2_pportdata *ppd, int index, int vl);
-u64 hfi2_write_port_cntr(struct hfi2_pportdata *ppd, int index, int vl, u64 data);
+u64 hfi2_write_port_cntr(struct hfi2_pportdata *ppd, int index, int vl,
+			 u64 data);
 u32 hfi2_read_logical_state(struct hfi2_devdata *dd);
 void hfi2_force_recv_intr(struct hfi2_ctxtdata *rcd);
 void hfi2_force_intr(struct hfi2_devdata *dd, u16 nr);
@@ -806,7 +805,7 @@ enum {
 	C_SDMA_ERR_CNT,
 	C_SDMA_IDLE_INT_CNT,
 	C_SDMA_PROGRESS_INT_CNT,
-/* MISC_ERR_STATUS */
+	/* MISC_ERR_STATUS */
 	C_MISC_PLL_LOCK_FAIL_ERR,
 	C_MISC_MBIST_FAIL_ERR,
 	C_MISC_INVALID_EEP_CMD_ERR,
@@ -820,7 +819,7 @@ enum {
 	C_MISC_CSR_WRITE_BAD_ADDR_ERR,
 	C_MISC_CSR_READ_BAD_ADDR_ERR,
 	C_MISC_CSR_PARITY_ERR,
-/* CceErrStatus */
+	/* CceErrStatus */
 	/*
 	 * A special counter that is the aggregate count
 	 * of all the cce_err_status errors.  The remainder
@@ -868,7 +867,7 @@ enum {
 	C_CCE_CSR_WRITE_BAD_ADDR_ERR,
 	C_CCE_CSR_READ_BAD_ADDR_ERR,
 	C_CCE_CSR_PARITY_ERR,
-/* RcvErrStatus */
+	/* RcvErrStatus */
 	C_RX_CSR_PARITY_ERR,
 	C_RX_CSR_WRITE_BAD_ADDR_ERR,
 	C_RX_CSR_READ_BAD_ADDR_ERR,
@@ -933,7 +932,7 @@ enum {
 	C_RX_RCV_HDR_UNC_ERR,
 	C_RX_DC_INTF_PARITY_ERR,
 	C_RX_DMA_CSR_COR_ERR,
-/* SendPioErrStatus */
+	/* SendPioErrStatus */
 	C_PIO_PEC_SOP_HEAD_PARITY_ERR,
 	C_PIO_PCC_SOP_HEAD_PARITY_ERR,
 	C_PIO_LAST_RETURNED_CNT_PARITY_ERR,
@@ -970,12 +969,12 @@ enum {
 	C_PIO_CSR_PARITY_ERR,
 	C_PIO_WRITE_ADDR_PARITY_ERR,
 	C_PIO_WRITE_BAD_CTXT_ERR,
-/* SendDmaErrStatus */
+	/* SendDmaErrStatus */
 	C_SDMA_PCIE_REQ_TRACKING_COR_ERR,
 	C_SDMA_PCIE_REQ_TRACKING_UNC_ERR,
 	C_SDMA_CSR_PARITY_ERR,
 	C_SDMA_RPY_TAG_ERR,
-/* SendEgressErrStatus */
+	/* SendEgressErrStatus */
 	C_TX_READ_PIO_MEMORY_CSR_UNC_ERR,
 	C_TX_READ_SDMA_MEMORY_CSR_UNC_ERR,
 	C_TX_EGRESS_FIFO_COR_ERR,
@@ -1040,17 +1039,17 @@ enum {
 	C_TX_RESERVED_2,
 	C_TX_PKT_INTEGRITY_MEM_UNC_ERR,
 	C_TX_PKT_INTEGRITY_MEM_COR_ERR,
-/* SendErrStatus */
+	/* SendErrStatus */
 	C_SEND_CSR_WRITE_BAD_ADDR_ERR,
 	C_SEND_CSR_READ_BAD_ADD_ERR,
 	C_SEND_CSR_PARITY_ERR,
-/* SendCtxtErrStatus */
+	/* SendCtxtErrStatus */
 	C_PIO_WRITE_OUT_OF_BOUNDS_ERR,
 	C_PIO_WRITE_OVERFLOW_ERR,
 	C_PIO_WRITE_CROSSES_BOUNDARY_ERR,
 	C_PIO_DISALLOWED_PACKET_ERR,
 	C_PIO_INCONSISTENT_SOP_ERR,
-/*SendDmaEngErrStatus */
+	/*SendDmaEngErrStatus */
 	C_SDMA_HEADER_REQUEST_FIFO_COR_ERR,
 	C_SDMA_HEADER_STORAGE_COR_ERR,
 	C_SDMA_PACKET_TRACKING_COR_ERR,
@@ -1075,7 +1074,7 @@ enum {
 	C_SDMA_TOO_LONG_ERR,
 	C_SDMA_GEN_MISMATCH_ERR,
 	C_SDMA_WRONG_DW_ERR,
-	SHARED_DEV_CNTR_LAST  /* keep last */
+	SHARED_DEV_CNTR_LAST /* keep last */
 };
 
 /* chip specific counter start points - keep a separate range per chip */
@@ -1138,7 +1137,7 @@ enum {
 	C_CCE_PCI_TR_ST,
 	C_CCE_PIO_WR_ST,
 	C_CCE_ERR_INT,
-	WFR_DEV_CNTR_LAST  /* keep last */
+	WFR_DEV_CNTR_LAST /* keep last */
 };
 
 #define WFR_NUM_DEV_CNTRS (WFR_DEV_CNTR_LAST - WFR_DEV_CNTR_FIRST)
@@ -1151,7 +1150,7 @@ enum {
 	C_CCE_PIO_ERR_INT,
 	C_CCE_SDMA_ERR_INT,
 	C_CCE_CSR_ERR_INT,
-	JKR_DEV_CNTR_LAST  /* keep last */
+	JKR_DEV_CNTR_LAST /* keep last */
 };
 
 #define JKR_NUM_DEV_CNTRS (JKR_DEV_CNTR_LAST - JKR_DEV_CNTR_FIRST)
@@ -1236,30 +1235,30 @@ enum {
 #define JKR_NUM_PORT_CNTRS (JKR_PORT_CNTR_LAST - JKR_PORT_CNTR_FIRST)
 
 /* SendEgressErrInfo bits that correspond to a PortXmitDiscard counter */
-#define WFR_PORT_DISCARD_EGRESS_ERRS \
-	(SEND_EGRESS_ERR_INFO_TOO_LONG_IB_PACKET_ERR_SMASK \
-	| SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR_SMASK \
-	| SEND_EGRESS_ERR_INFO_VL_ERR_SMASK)
+#define WFR_PORT_DISCARD_EGRESS_ERRS                         \
+	(SEND_EGRESS_ERR_INFO_TOO_LONG_IB_PACKET_ERR_SMASK | \
+	 SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR_SMASK |         \
+	 SEND_EGRESS_ERR_INFO_VL_ERR_SMASK)
 
-#define RT_ADDR_SHIFT 12	/* 4KB kernel address boundary */
+#define RT_ADDR_SHIFT 12 /* 4KB kernel address boundary */
 
 /* PIO Send Memory Address details */
-#define PIO_ADDR_CONTEXT_MASK	0xfful
-#define PIO_ADDR_CONTEXT_SHIFT	16
-#define SOP_DISTANCE	(TXE_PIO_SIZE / 2)	/* distance btw non-SOP and SOP space */
-#define PIO_BLOCK_MASK	(PIO_BLOCK_SIZE - 1)
-#define PIO_BLOCK_QWS	(PIO_BLOCK_SIZE / sizeof(u64))	/* num QWs in a block */
+#define PIO_ADDR_CONTEXT_MASK 0xfful
+#define PIO_ADDR_CONTEXT_SHIFT 16
+#define SOP_DISTANCE (TXE_PIO_SIZE / 2) /* distance btw non-SOP and SOP space */
+#define PIO_BLOCK_MASK (PIO_BLOCK_SIZE - 1)
+#define PIO_BLOCK_QWS (PIO_BLOCK_SIZE / sizeof(u64)) /* num QWs in a block */
 
 u64 hfi2_get_all_cpu_total(u64 __percpu *cntr);
 void hfi2_start_cleanup(struct hfi2_devdata *dd);
 void hfi2_clear_tids(struct hfi2_ctxtdata *rcd);
 void hfi2_init_ctxt(struct send_context *sc);
-void hfi2_wfr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
-		 u32 type, unsigned long pa, u16 order, bool flush);
+void hfi2_wfr_put_tid(struct hfi2_ctxtdata *rcd, u32 index, u32 type,
+		      unsigned long pa, u16 order, bool flush);
 void hfi2_wfr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type);
 void hfi2_wfr_set_port_tid_config(struct hfi2_devdata *dd, int pidx, u16 ctxt,
-			     u32 eager_base, u16 alloced,
-			     u32 expected_base, u32 expected_count);
+				  u32 eager_base, u16 alloced,
+				  u32 expected_base, u32 expected_count);
 void hfi2_quiet_serdes(struct hfi2_pportdata *ppd);
 u64 hfi2_rctxt_ctrl_op(struct hfi2_devdata *dd, u16 ctxt, unsigned int op);
 void hfi2_rcvctrl(struct hfi2_devdata *dd, unsigned int op,
@@ -1291,7 +1290,8 @@ int hfi2_set_intr_bits(struct hfi2_devdata *dd, u16 first, u16 last, bool set);
 void hfi2_init_qsfp_int(struct hfi2_pportdata *ppd);
 void hfi2_clear_all_interrupts(struct hfi2_devdata *dd);
 void hfi2_remap_intr(struct hfi2_devdata *dd, int isrc, int msix_intr);
-void hfi2_remap_sdma_interrupts(struct hfi2_devdata *dd, int engine, int msix_intr);
+void hfi2_remap_sdma_interrupts(struct hfi2_devdata *dd, int engine,
+				int msix_intr);
 void hfi2_reset_interrupts(struct hfi2_devdata *dd);
 u16 hfi2_get_qp_map(struct hfi2_pportdata *ppd, u16 idx);
 void hfi2_init_aip_rsm(struct hfi2_pportdata *ppd);
@@ -1310,8 +1310,8 @@ void hfi2_release_rsm_rules(struct hfi2_devdata *dd);
  * number.
  */
 struct hfi2_is_table {
-	int start;	 /* interrupt source type start */
-	int end;	 /* interrupt source type end */
+	int start; /* interrupt source type start */
+	int end; /* interrupt source type end */
 	/* routine that returns the name of the interrupt source */
 	char *(*is_name)(char *name, size_t size, unsigned int source);
 	/* routine to call when receiving an interrupt */
@@ -1322,18 +1322,18 @@ extern const struct hfi2_is_table hfi2_is_table[];
 
 /* table entry for general interrupt enable */
 struct gi_enable_entry {
-	u32 start;	/* starting source number */
-	u32 end;	/* ending source number */
+	u32 start; /* starting source number */
+	u32 end; /* ending source number */
 };
 
 extern const struct gi_enable_entry hfi2_wfr_gi_enable_table[];
 
 /* interrupt clear down register type */
 enum icd_type {
-	ICD_NORMAL,	/* non-indexed register */
-	ICD_SDMA,	/* indexed SDMA register */
-	ICD_INGRESS,	/* indexed ingress register */
-	ICD_EGRESS,	/* indexed egress register */
+	ICD_NORMAL, /* non-indexed register */
+	ICD_SDMA, /* indexed SDMA register */
+	ICD_INGRESS, /* indexed ingress register */
+	ICD_EGRESS, /* indexed egress register */
 };
 
 /*
@@ -1343,26 +1343,37 @@ enum icd_type {
  * in the top-level CceIntStatus.
  */
 struct err_reg_info {
-	u32 status;		/* status CSR offset */
-	u32 clear;		/* clear CSR offset */
-	u32 mask;		/* mask CSR offset */
-	enum icd_type type;	/* register type */
+	u32 status; /* status CSR offset */
+	u32 clear; /* clear CSR offset */
+	u32 mask; /* mask CSR offset */
+	enum icd_type type; /* register type */
 	void (*handler)(struct hfi2_devdata *dd, u32 source, u64 reg);
 	const char *desc;
 };
 
 /* helpers for filling out struct err_reg_info */
-#define EE_N(reg, handler, desc) \
-	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_NORMAL, handler, desc }
-
-#define EE_S(reg, handler, desc) \
-	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_SDMA, handler, desc }
-
-#define EE_I(reg, handler, desc) \
-	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_INGRESS, handler, desc }
-
-#define EE_E(reg, handler, desc) \
-	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_EGRESS, handler, desc }
+#define EE_N(reg, handler, desc)                                            \
+	{                                                                   \
+		reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_NORMAL, handler, \
+			desc                                                \
+	}
+
+#define EE_S(reg, handler, desc)                                               \
+	{                                                                      \
+		reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_SDMA, handler, desc \
+	}
+
+#define EE_I(reg, handler, desc)                                             \
+	{                                                                    \
+		reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_INGRESS, handler, \
+			desc                                                 \
+	}
+
+#define EE_E(reg, handler, desc)                                            \
+	{                                                                   \
+		reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_EGRESS, handler, \
+			desc                                                \
+	}
 
 char *hfi2_is_sdma_eng_err_name(char *buf, size_t bsize, unsigned int source);
 char *hfi2_is_sendctxt_err_name(char *buf, size_t bsize, unsigned int source);
@@ -1372,9 +1383,9 @@ char *hfi2_is_rcv_urgent_name(char *buf, size_t bsize, unsigned int source);
 char *hfi2_is_send_credit_name(char *buf, size_t bsize, unsigned int source);
 
 void hfi2_interrupt_clear_down(struct hfi2_devdata *dd, u32 context,
-			  const struct err_reg_info *eri);
+			       const struct err_reg_info *eri);
 void hfi2_handle_sdma_eng_err(struct hfi2_devdata *dd, unsigned int context,
-			 u64 err_status);
+			      u64 err_status);
 void hfi2_is_sdma_eng_int(struct hfi2_devdata *dd, unsigned int source);
 void hfi2_is_sendctxt_err_int(struct hfi2_devdata *dd, unsigned int hw_context);
 void hfi2_is_rcv_avail_int(struct hfi2_devdata *dd, unsigned int source);
@@ -1413,11 +1424,13 @@ extern struct cntr_entry hfi2_wfr_dev_cntrs[];
 extern struct cntr_entry hfi2_jkr_dev_cntrs[];
 extern struct cntr_entry hfi2_wfr_port_cntrs[];
 extern struct cntr_entry hfi2_jkr_port_cntrs[];
+extern struct cntr_entry hfi2_shared_dev_cntrs[];
+extern struct cntr_entry hfi2_shared_port_cntrs[];
 
 struct flag_table {
-	u64 flag;	/* the flag */
-	char *str;	/* description string */
-	u16 extra;	/* extra information */
+	u64 flag; /* the flag */
+	char *str; /* description string */
+	u16 extra; /* extra information */
 	u16 unused0;
 	u32 unused1;
 };
diff --git a/drivers/infiniband/hw/hfi2/chip_counters.c b/drivers/infiniband/hw/hfi2/chip_counters.c
new file mode 100644
index 000000000000..6ef48aed1414
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_counters.c
@@ -0,0 +1,4162 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+/*
+ * This file contains all of the code that is specific to the HFI chip
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+#include "file_ops.h"
+#include "trace.h"
+#include "mad.h"
+#include "pio.h"
+#include "sdma.h"
+#include "eprom.h"
+#include "efivar.h"
+#include "platform.h"
+#include "debugfs.h"
+#include "fault.h"
+#include "netdev.h"
+#include "chip_registers_jkr.h"
+
+#define CNTR_MAX 0xFFFFFFFFFFFFFFFFULL
+
+#define CNTR_ELEM(name, csr, offset, flags, accessor) \
+	{                                             \
+		name, csr, offset, flags, accessor    \
+	}
+
+/* 32bit RXE */
+#define RXE32_PORT_CNTR_ELEM(name, counter, flags)          \
+	{                                                   \
+		name, (counter) * 8, 0, flags | CNTR_32BIT, \
+			port_access_rxe32_csr               \
+	}
+
+/* 64bit RXE */
+#define RXE64_PORT_CNTR_ELEM(name, counter, flags) \
+	CNTR_ELEM(#name, (counter) * 8, 0, flags, port_access_rxe64_csr)
+
+/* 32bit TXE */
+#define TXE32_PORT_CNTR_ELEM(name, counter, flags)             \
+	CNTR_ELEM(#name, (counter) * 8, 0, flags | CNTR_32BIT, \
+		  port_access_txe32_csr)
+
+/* 64bit TXE */
+#define TXE64_PORT_CNTR_ELEM(name, counter, flags) \
+	CNTR_ELEM(#name, (counter) * 8, 0, flags, port_access_txe64_csr)
+
+/* CCE */
+#define CCE_PERF_DEV_CNTR_ELEM(name, counter, flags)            \
+	CNTR_ELEM(name, (counter * 8 + CCE_COUNTER_ARRAY32), 0, \
+		  flags | CNTR_32BIT, dev_access_u32_csr)
+
+#define CCE_INT_DEV_CNTR_ELEM(name, counter, flags)                  \
+	CNTR_ELEM(#name, (counter * 8 + CCE_INT_COUNTER_ARRAY32), 0, \
+		  flags | CNTR_32BIT, dev_access_u32_csr)
+
+/* DC */
+#define DC_PERF_CNTR(name, counter, flags) \
+	CNTR_ELEM(#name, counter, 0, flags, dev_access_u64_csr)
+
+#define DC_PERF_CNTR_LCB(name, counter, flags) \
+	CNTR_ELEM(#name, counter, 0, flags, dc_access_lcb_cntr)
+
+/* ibp counters */
+#define SW_IBP_CNTR(name, cntr) \
+	CNTR_ELEM(#name, 0, 0, CNTR_SYNTH, access_ibp_##cntr)
+
+/**
+ * ctxt_csr_addr - return addr for readq/writeq for a per-context register
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ * @ctxt: the context number
+ * @stride: the per-context stride
+ *
+ * This routine returns the appropriate ioremaped BAR address based on the
+ * offset and context.
+ */
+static inline void __iomem *ctxt_csr_addr(const struct hfi2_devdata *dd,
+					  u32 offset, u32 ctxt, u32 stride)
+{
+	void __iomem *base;
+	u32 cbi = ctxt_bar_idx(ctxt);
+	u32 cbc = ctxt_bar_ctxt(ctxt);
+
+	if (offset >= dd->base2_start) {
+		base = dd->bar_maps[cbi].kregbase2;
+		offset -= dd->base2_start;
+	} else {
+		base = dd->bar_maps[cbi].kregbase1;
+	}
+
+	if (!base) {
+		WARN(1, "bad context: offset 0x%x, ctxt %d, stride %d\n",
+		     offset, ctxt, stride);
+		/* return address of first register of bar0 - not writable */
+		return dd->bar_maps[0].kregbase1;
+	}
+	return base + offset + (cbc * stride);
+}
+
+/**
+ * hfi2_addr_from_offset - return addr for readq/writeq
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * This routine selects the appropriate base address
+ * based on the indicated offset.
+ */
+static inline void __iomem *hfi2_addr_from_offset(const struct hfi2_devdata *dd,
+						  u32 offset)
+{
+	return ctxt_csr_addr(dd, offset, 0, 0);
+}
+
+/**
+ * hfi2_read_csr - read CSR at the indicated offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * Return: the value read or all FF's if there
+ * is no mapping
+ */
+u64 hfi2_read_csr(const struct hfi2_devdata *dd, u32 offset)
+{
+	if (dd->flags & HFI2_PRESENT)
+		return readq(hfi2_addr_from_offset(dd, offset));
+	return -1;
+}
+
+/**
+ * hfi2_write_csr - write CSR at the indicated offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ * @value: value to write
+ */
+void hfi2_write_csr(const struct hfi2_devdata *dd, u32 offset, u64 value)
+{
+	if (dd->flags & HFI2_PRESENT) {
+		void __iomem *base = hfi2_addr_from_offset(dd, offset);
+
+		/* avoid write to RcvArray */
+		if (WARN_ON(offset >= dd->params->rcv_array_offset &&
+			    offset < (dd->params->rcv_array_offset +
+				      dd->params->rcv_array_size)))
+			return;
+		writeq(value, base);
+	}
+}
+
+u64 hfi2_read_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
+		       u32 stride)
+{
+	if (unlikely(!(dd->flags & HFI2_PRESENT)))
+		return -1;
+	return readq(ctxt_csr_addr(dd, offset, ctxt, stride));
+}
+
+void hfi2_write_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
+			 u32 stride, u64 value)
+{
+	if (unlikely(!(dd->flags & HFI2_PRESENT)))
+		return;
+	writeq(value, ctxt_csr_addr(dd, offset, ctxt, stride));
+}
+
+/**
+ * hfi2_get_csr_addr - return te iomem address for offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * Return: The iomem address to use in subsequent
+ * writeq/readq operations.
+ */
+void __iomem *hfi2_get_csr_addr(const struct hfi2_devdata *dd, u32 offset)
+{
+	if (dd->flags & HFI2_PRESENT)
+		return hfi2_addr_from_offset(dd, offset);
+	return NULL;
+}
+
+static inline u64 read_write_csr(const struct hfi2_devdata *dd, u32 csr,
+				 int mode, u64 value)
+{
+	u64 ret;
+
+	if (mode == CNTR_MODE_R) {
+		ret = hfi2_read_csr(dd, csr);
+	} else if (mode == CNTR_MODE_W) {
+		hfi2_write_csr(dd, csr, value);
+		ret = value;
+	} else {
+		dd_dev_err(dd, "Invalid cntr register access mode");
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "csr 0x%x val 0x%llx mode %d", csr, ret, mode);
+	return ret;
+}
+
+/* Dev Access */
+static u64 dev_access_u32_csr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	u64 csr = entry->csr;
+
+	if (entry->flags & CNTR_SDMA) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 0x100 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 dev_access_sde_desc_fetched_cnt(const struct cntr_entry *entry,
+					   void *context, int idx, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 csr = dd->params->send_dma_desc_fetched_cnt_reg +
+		  (dd->params->txe_sdma_stride * idx);
+
+	if (idx < dr->first_sdma_engine || idx >= dr->last_sdma_engine)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 access_sde_err_cnt(const struct cntr_entry *entry, void *context,
+			      int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine &&
+	    idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].err_cnt;
+	return 0;
+}
+
+static u64 access_sde_int_cnt(const struct cntr_entry *entry, void *context,
+			      int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine &&
+	    idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].sdma_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_idle_int_cnt(const struct cntr_entry *entry,
+				   void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine &&
+	    idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].idle_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_progress_int_cnt(const struct cntr_entry *entry,
+				       void *context, int idx, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine &&
+	    idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].progress_int_cnt;
+	return 0;
+}
+
+static u64 access_ovf_csr(const struct cntr_entry *entry, void *context,
+			  int idx, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (idx < 0 || idx >= dd->num_rcd) {
+		ppd_dev_err(ppd, "Invalid ovf counter idx %d", idx);
+		return 0;
+	}
+
+	if (mode == CNTR_MODE_R)
+		return read_kctxt_csr(dd, idx,
+				      dd->params->rcv_hdr_ovfl_cnt_reg);
+	write_kctxt_csr(dd, idx, dd->params->rcv_hdr_ovfl_cnt_reg, data);
+	return 0;
+}
+
+static u64 dev_access_u64_csr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	u64 val = 0;
+	u64 csr = entry->csr;
+
+	if (entry->flags & CNTR_VL) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 8 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+
+	val = read_write_csr(dd, csr, mode, data);
+	return val;
+}
+
+static u64 dc_access_lcb_cntr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	u32 csr = entry->csr;
+	int ret = 0;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	if (mode == CNTR_MODE_R)
+		ret = hfi2_read_lcb_csr(&dd->pport[HFI2_PORT_IDX], csr, &data);
+	else if (mode == CNTR_MODE_W)
+		ret = hfi2_write_lcb_csr(&dd->pport[HFI2_PORT_IDX], csr, data);
+
+	if (ret) {
+		if (!(dd->flags & HFI2_SHUTDOWN))
+			dd_dev_err(dd, "Could not acquire LCB for counter 0x%x",
+				   csr);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "csr 0x%x val 0x%llx mode %d", csr, data, mode);
+	return data;
+}
+
+/* Port Access */
+static u64 port_access_txe32_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->send_counter_array32_reg +
+		  (dd->params->txe_eport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_txe64_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->send_counter_array64_reg +
+		  (dd->params->txe_eport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	if (entry->flags & CNTR_VL) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 8 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_rxe32_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->rcv_counter_array32_reg +
+		  (dd->params->rxe_iport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_rxe64_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 csr = entry->csr + dd->params->rcv_counter_array64_reg +
+		  (dd->params->rxe_iport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+/* Software defined */
+static inline u64 read_write_sw(struct hfi2_devdata *dd, u64 *cntr, int mode,
+				u64 data)
+{
+	u64 ret;
+
+	if (mode == CNTR_MODE_R) {
+		ret = *cntr;
+	} else if (mode == CNTR_MODE_W) {
+		*cntr = data;
+		ret = data;
+	} else {
+		dd_dev_err(dd, "Invalid cntr sw access mode");
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "val 0x%llx mode %d", ret, mode);
+
+	return ret;
+}
+
+static u64 access_sw_link_dn_cnt(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->link_downed, mode, data);
+}
+
+static u64 access_sw_link_up_cnt(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->link_up, mode, data);
+}
+
+static u64 access_sw_unknown_frame_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->unknown_frame_count, mode, data);
+}
+
+static u64 access_sw_xmit_discards(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;
+	u64 zero = 0;
+	u64 *counter;
+
+	if (vl == CNTR_INVALID_VL)
+		counter = &ppd->port_xmit_discards;
+	else if (vl >= 0 && vl < C_VL_COUNT)
+		counter = &ppd->port_xmit_discards_vl[vl];
+	else
+		counter = &zero;
+
+	return read_write_sw(ppd->dd, counter, mode, data);
+}
+
+static u64 access_xmit_constraint_errs(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	return read_write_sw(ppd->dd, &ppd->port_xmit_constraint_errors, mode,
+			     data);
+}
+
+static u64 access_rcv_constraint_errs(const struct cntr_entry *entry,
+				      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	return read_write_sw(ppd->dd, &ppd->port_rcv_constraint_errors, mode,
+			     data);
+}
+
+u64 hfi2_get_all_cpu_total(u64 __percpu *cntr)
+{
+	int cpu;
+	u64 counter = 0;
+
+	for_each_possible_cpu(cpu)
+		counter += *per_cpu_ptr(cntr, cpu);
+	return counter;
+}
+
+static u64 read_write_cpu(struct hfi2_devdata *dd, u64 *z_val,
+			  u64 __percpu *cntr, int vl, int mode, u64 data)
+{
+	u64 ret = 0;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	if (mode == CNTR_MODE_R) {
+		ret = hfi2_get_all_cpu_total(cntr) - *z_val;
+	} else if (mode == CNTR_MODE_W) {
+		/* A write can only zero the counter */
+		if (data == 0)
+			*z_val = hfi2_get_all_cpu_total(cntr);
+		else
+			dd_dev_err(dd, "Per CPU cntrs can only be zeroed");
+	} else {
+		dd_dev_err(dd, "Invalid cntr sw cpu access mode");
+		return 0;
+	}
+
+	return ret;
+}
+
+static u64 access_sw_cpu_intr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return read_write_cpu(dd, &dd->z_int_counter, dd->int_counter, vl, mode,
+			      data);
+}
+
+static u64 access_sw_cpu_rcv_limit(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return read_write_cpu(dd, &dd->z_rcv_limit, dd->rcv_limit, vl, mode,
+			      data);
+}
+
+static u64 access_sw_pio_wait(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_piowait;
+}
+
+static u64 access_sw_pio_drain(const struct cntr_entry *entry, void *context,
+			       int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->verbs_dev.n_piodrain;
+}
+
+static u64 access_sw_ctx0_seq_drop(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->ctx0_seq_drop;
+}
+
+static u64 access_sw_vtx_wait(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_txwait;
+}
+
+static u64 access_sw_kmem_wait(const struct cntr_entry *entry, void *context,
+			       int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_kmem_wait;
+}
+
+static u64 access_sw_send_schedule(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return read_write_cpu(dd, &dd->z_send_schedule, dd->send_schedule, vl,
+			      mode, data);
+}
+
+/* Software counters for the error status bits within MISC_ERR_STATUS */
+static u64 access_misc_pll_lock_fail_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[12];
+}
+
+static u64 access_misc_mbist_fail_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[11];
+}
+
+static u64 access_misc_invalid_eep_cmd_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[10];
+}
+
+static u64 access_misc_efuse_done_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[9];
+}
+
+static u64 access_misc_efuse_write_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[8];
+}
+
+static u64
+access_misc_efuse_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[7];
+}
+
+static u64 access_misc_efuse_csr_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[6];
+}
+
+static u64 access_misc_fw_auth_failed_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[5];
+}
+
+static u64 access_misc_key_mismatch_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[4];
+}
+
+static u64 access_misc_sbus_write_failed_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[3];
+}
+
+static u64
+access_misc_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[2];
+}
+
+static u64 access_misc_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[1];
+}
+
+static u64 access_misc_csr_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[0];
+}
+
+/*
+ * Software counter for the aggregate of
+ * individual CceErrStatus counters
+ */
+static u64
+access_sw_cce_err_status_aggregated_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_cce_err_status_aggregate;
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within CceErrStatus
+ */
+static u64 access_cce_msix_csr_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[40];
+}
+
+static u64 access_cce_int_map_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[39];
+}
+
+static u64 access_cce_int_map_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[38];
+}
+
+static u64 access_cce_msix_table_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[37];
+}
+
+static u64 access_cce_msix_table_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[36];
+}
+
+static u64
+access_cce_rxdma_conv_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[35];
+}
+
+static u64
+access_cce_rcpl_async_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[34];
+}
+
+static u64 access_cce_seg_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[33];
+}
+
+static u64 access_cce_seg_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[32];
+}
+
+static u64 access_la_triggered_cnt(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[31];
+}
+
+static u64 access_cce_trgt_cpl_timeout_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[30];
+}
+
+static u64 access_pcic_receive_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[29];
+}
+
+static u64
+access_pcic_transmit_back_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[28];
+}
+
+static u64
+access_pcic_transmit_front_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[27];
+}
+
+static u64 access_pcic_cpl_dat_q_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[26];
+}
+
+static u64 access_pcic_cpl_hd_q_unc_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[25];
+}
+
+static u64 access_pcic_post_dat_q_unc_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[24];
+}
+
+static u64 access_pcic_post_hd_q_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[23];
+}
+
+static u64 access_pcic_retry_sot_mem_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[22];
+}
+
+static u64 access_pcic_retry_mem_unc_err(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[21];
+}
+
+static u64
+access_pcic_n_post_dat_q_parity_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[20];
+}
+
+static u64 access_pcic_n_post_h_q_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[19];
+}
+
+static u64 access_pcic_cpl_dat_q_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[18];
+}
+
+static u64 access_pcic_cpl_hd_q_cor_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[17];
+}
+
+static u64 access_pcic_post_dat_q_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[16];
+}
+
+static u64 access_pcic_post_hd_q_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[15];
+}
+
+static u64 access_pcic_retry_sot_mem_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[14];
+}
+
+static u64 access_pcic_retry_mem_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[13];
+}
+
+static u64
+access_cce_cli1_async_fifo_dbg_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[12];
+}
+
+static u64
+access_cce_cli1_async_fifo_rxdma_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[11];
+}
+
+static u64 access_cce_cli1_async_fifo_sdma_hd_parity_err_cnt(
+	const struct cntr_entry *entry, void *context, int vl, int mode,
+	u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[10];
+}
+
+static u64 access_cce_cl1_async_fifo_pio_crdt_parity_err_cnt(
+	const struct cntr_entry *entry, void *context, int vl, int mode,
+	u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[9];
+}
+
+static u64
+access_cce_cli2_async_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[8];
+}
+
+static u64 access_cce_csr_cfg_bus_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[7];
+}
+
+static u64
+access_cce_cli0_async_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[6];
+}
+
+static u64 access_cce_rspd_data_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[5];
+}
+
+static u64 access_cce_trgt_access_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[4];
+}
+
+static u64
+access_cce_trgt_async_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[3];
+}
+
+static u64 access_cce_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[2];
+}
+
+static u64 access_cce_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[1];
+}
+
+static u64 access_ccs_csr_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within RcvErrStatus
+ */
+static u64 access_rx_csr_parity_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[63];
+}
+
+static u64 access_rx_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[62];
+}
+
+static u64 access_rx_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[61];
+}
+
+static u64 access_rx_dma_csr_unc_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[60];
+}
+
+static u64 access_rx_dma_dq_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[59];
+}
+
+static u64 access_rx_dma_eq_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[58];
+}
+
+static u64 access_rx_dma_csr_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[57];
+}
+
+static u64 access_rx_rbuf_data_cor_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[56];
+}
+
+static u64 access_rx_rbuf_data_unc_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[55];
+}
+
+static u64
+access_rx_dma_data_fifo_rd_cor_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[54];
+}
+
+static u64
+access_rx_dma_data_fifo_rd_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[53];
+}
+
+static u64 access_rx_dma_hdr_fifo_rd_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[52];
+}
+
+static u64 access_rx_dma_hdr_fifo_rd_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[51];
+}
+
+static u64 access_rx_rbuf_desc_part2_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[50];
+}
+
+static u64 access_rx_rbuf_desc_part2_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[49];
+}
+
+static u64 access_rx_rbuf_desc_part1_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[48];
+}
+
+static u64 access_rx_rbuf_desc_part1_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[47];
+}
+
+static u64 access_rx_hq_intr_fsm_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[46];
+}
+
+static u64 access_rx_hq_intr_csr_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[45];
+}
+
+static u64 access_rx_lookup_csr_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[44];
+}
+
+static u64
+access_rx_lookup_rcv_array_cor_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[43];
+}
+
+static u64
+access_rx_lookup_rcv_array_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[42];
+}
+
+static u64
+access_rx_lookup_des_part2_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[41];
+}
+
+static u64
+access_rx_lookup_des_part1_unc_cor_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[40];
+}
+
+static u64
+access_rx_lookup_des_part1_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[39];
+}
+
+static u64
+access_rx_rbuf_next_free_buf_cor_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[38];
+}
+
+static u64
+access_rx_rbuf_next_free_buf_unc_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[37];
+}
+
+static u64
+access_rbuf_fl_init_wr_addr_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[36];
+}
+
+static u64
+access_rx_rbuf_fl_initdone_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[35];
+}
+
+static u64
+access_rx_rbuf_fl_write_addr_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[34];
+}
+
+static u64
+access_rx_rbuf_fl_rd_addr_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[33];
+}
+
+static u64 access_rx_rbuf_empty_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[32];
+}
+
+static u64 access_rx_rbuf_full_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[31];
+}
+
+static u64 access_rbuf_bad_lookup_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[30];
+}
+
+static u64 access_rbuf_ctx_id_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[29];
+}
+
+static u64 access_rbuf_csr_qeopdw_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[28];
+}
+
+static u64
+access_rx_rbuf_csr_q_num_of_pkt_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[27];
+}
+
+static u64
+access_rx_rbuf_csr_q_t1_ptr_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[26];
+}
+
+static u64
+access_rx_rbuf_csr_q_hd_ptr_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[25];
+}
+
+static u64
+access_rx_rbuf_csr_q_vld_bit_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[24];
+}
+
+static u64
+access_rx_rbuf_csr_q_next_buf_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[23];
+}
+
+static u64
+access_rx_rbuf_csr_q_ent_cnt_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[22];
+}
+
+static u64
+access_rx_rbuf_csr_q_head_buf_num_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[21];
+}
+
+static u64
+access_rx_rbuf_block_list_read_cor_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[20];
+}
+
+static u64
+access_rx_rbuf_block_list_read_unc_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[19];
+}
+
+static u64 access_rx_rbuf_lookup_des_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[18];
+}
+
+static u64 access_rx_rbuf_lookup_des_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[17];
+}
+
+static u64
+access_rx_rbuf_lookup_des_reg_unc_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[16];
+}
+
+static u64
+access_rx_rbuf_lookup_des_reg_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[15];
+}
+
+static u64 access_rx_rbuf_free_list_cor_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[14];
+}
+
+static u64 access_rx_rbuf_free_list_unc_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[13];
+}
+
+static u64 access_rx_rcv_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[12];
+}
+
+static u64 access_rx_dma_flag_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[11];
+}
+
+static u64 access_rx_dma_flag_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[10];
+}
+
+static u64 access_rx_dc_sop_eop_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[9];
+}
+
+static u64 access_rx_rcv_csr_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[8];
+}
+
+static u64
+access_rx_rcv_qp_map_table_cor_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[7];
+}
+
+static u64
+access_rx_rcv_qp_map_table_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[6];
+}
+
+static u64 access_rx_rcv_data_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[5];
+}
+
+static u64 access_rx_rcv_data_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[4];
+}
+
+static u64 access_rx_rcv_hdr_cor_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[3];
+}
+
+static u64 access_rx_rcv_hdr_unc_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[2];
+}
+
+static u64 access_rx_dc_intf_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[1];
+}
+
+static u64 access_rx_dma_csr_cor_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendPioErrStatus
+ */
+static u64
+access_pio_pec_sop_head_parity_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[35];
+}
+
+static u64
+access_pio_pcc_sop_head_parity_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[34];
+}
+
+static u64
+access_pio_last_returned_cnt_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[33];
+}
+
+static u64
+access_pio_current_free_cnt_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[32];
+}
+
+static u64 access_pio_reserved_31_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[31];
+}
+
+static u64 access_pio_reserved_30_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[30];
+}
+
+static u64 access_pio_ppmc_sop_len_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[29];
+}
+
+static u64
+access_pio_ppmc_bqc_mem_parity_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[28];
+}
+
+static u64 access_pio_vl_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[27];
+}
+
+static u64 access_pio_vlf_sop_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[26];
+}
+
+static u64 access_pio_vlf_v1_len_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[25];
+}
+
+static u64
+access_pio_block_qw_count_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[24];
+}
+
+static u64
+access_pio_write_qw_valid_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[23];
+}
+
+static u64 access_pio_state_machine_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[22];
+}
+
+static u64 access_pio_write_data_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[21];
+}
+
+static u64 access_pio_host_addr_mem_cor_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[20];
+}
+
+static u64 access_pio_host_addr_mem_unc_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[19];
+}
+
+static u64
+access_pio_pkt_evict_sm_or_arb_sm_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[18];
+}
+
+static u64 access_pio_init_sm_in_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[17];
+}
+
+static u64 access_pio_ppmc_pbl_fifo_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[16];
+}
+
+static u64
+access_pio_credit_ret_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[15];
+}
+
+static u64
+access_pio_v1_len_mem_bank1_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[14];
+}
+
+static u64
+access_pio_v1_len_mem_bank0_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[13];
+}
+
+static u64
+access_pio_v1_len_mem_bank1_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[12];
+}
+
+static u64
+access_pio_v1_len_mem_bank0_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[11];
+}
+
+static u64
+access_pio_sm_pkt_reset_parity_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[10];
+}
+
+static u64
+access_pio_pkt_evict_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[9];
+}
+
+static u64
+access_pio_sbrdctrl_crrel_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[8];
+}
+
+static u64
+access_pio_sbrdctl_crrel_parity_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[7];
+}
+
+static u64 access_pio_pec_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[6];
+}
+
+static u64 access_pio_pcc_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[5];
+}
+
+static u64 access_pio_sb_mem_fifo1_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[4];
+}
+
+static u64 access_pio_sb_mem_fifo0_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[3];
+}
+
+static u64 access_pio_csr_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[2];
+}
+
+static u64 access_pio_write_addr_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[1];
+}
+
+static u64 access_pio_write_bad_ctxt_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendDmaErrStatus
+ */
+static u64
+access_sdma_pcie_req_tracking_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[3];
+}
+
+static u64
+access_sdma_pcie_req_tracking_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[2];
+}
+
+static u64 access_sdma_csr_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[1];
+}
+
+static u64 access_sdma_rpy_tag_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendEgressErrStatus
+ */
+static u64
+access_tx_read_pio_memory_csr_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[63];
+}
+
+static u64
+access_tx_read_sdma_memory_csr_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[62];
+}
+
+static u64 access_tx_egress_fifo_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[61];
+}
+
+static u64 access_tx_read_pio_memory_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[60];
+}
+
+static u64
+access_tx_read_sdma_memory_cor_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[59];
+}
+
+static u64 access_tx_sb_hdr_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[58];
+}
+
+static u64 access_tx_credit_overrun_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[57];
+}
+
+static u64 access_tx_launch_fifo8_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[56];
+}
+
+static u64 access_tx_launch_fifo7_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[55];
+}
+
+static u64 access_tx_launch_fifo6_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[54];
+}
+
+static u64 access_tx_launch_fifo5_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[53];
+}
+
+static u64 access_tx_launch_fifo4_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[52];
+}
+
+static u64 access_tx_launch_fifo3_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[51];
+}
+
+static u64 access_tx_launch_fifo2_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[50];
+}
+
+static u64 access_tx_launch_fifo1_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[49];
+}
+
+static u64 access_tx_launch_fifo0_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[48];
+}
+
+static u64 access_tx_credit_return_vl_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[47];
+}
+
+static u64 access_tx_hcrc_insertion_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[46];
+}
+
+static u64 access_tx_egress_fifo_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[45];
+}
+
+static u64 access_tx_read_pio_memory_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[44];
+}
+
+static u64
+access_tx_read_sdma_memory_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[43];
+}
+
+static u64 access_tx_sb_hdr_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[42];
+}
+
+static u64
+access_tx_credit_return_partiy_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[41];
+}
+
+static u64
+access_tx_launch_fifo8_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[40];
+}
+
+static u64
+access_tx_launch_fifo7_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[39];
+}
+
+static u64
+access_tx_launch_fifo6_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[38];
+}
+
+static u64
+access_tx_launch_fifo5_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[37];
+}
+
+static u64
+access_tx_launch_fifo4_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[36];
+}
+
+static u64
+access_tx_launch_fifo3_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[35];
+}
+
+static u64
+access_tx_launch_fifo2_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[34];
+}
+
+static u64
+access_tx_launch_fifo1_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[33];
+}
+
+static u64
+access_tx_launch_fifo0_unc_or_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[32];
+}
+
+static u64
+access_tx_sdma15_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[31];
+}
+
+static u64
+access_tx_sdma14_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[30];
+}
+
+static u64
+access_tx_sdma13_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[29];
+}
+
+static u64
+access_tx_sdma12_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[28];
+}
+
+static u64
+access_tx_sdma11_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[27];
+}
+
+static u64
+access_tx_sdma10_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[26];
+}
+
+static u64
+access_tx_sdma9_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[25];
+}
+
+static u64
+access_tx_sdma8_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[24];
+}
+
+static u64
+access_tx_sdma7_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[23];
+}
+
+static u64
+access_tx_sdma6_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[22];
+}
+
+static u64
+access_tx_sdma5_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[21];
+}
+
+static u64
+access_tx_sdma4_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[20];
+}
+
+static u64
+access_tx_sdma3_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[19];
+}
+
+static u64
+access_tx_sdma2_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[18];
+}
+
+static u64
+access_tx_sdma1_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[17];
+}
+
+static u64
+access_tx_sdma0_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[16];
+}
+
+static u64 access_tx_config_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[15];
+}
+
+static u64 access_tx_sbrd_ctl_csr_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[14];
+}
+
+static u64 access_tx_launch_csr_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[13];
+}
+
+static u64 access_tx_illegal_vl_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[12];
+}
+
+static u64
+access_tx_sbrd_ctl_state_machine_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[11];
+}
+
+static u64 access_egress_reserved_10_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[10];
+}
+
+static u64 access_egress_reserved_9_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[9];
+}
+
+static u64
+access_tx_sdma_launch_intf_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[8];
+}
+
+static u64
+access_tx_pio_launch_intf_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[7];
+}
+
+static u64 access_egress_reserved_6_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[6];
+}
+
+static u64
+access_tx_incorrect_link_state_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[5];
+}
+
+static u64 access_tx_linkdown_err_cnt(const struct cntr_entry *entry,
+				      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[4];
+}
+
+static u64
+access_tx_egress_fifi_underrun_or_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[3];
+}
+
+static u64 access_egress_reserved_2_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[2];
+}
+
+static u64
+access_tx_pkt_integrity_mem_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[1];
+}
+
+static u64
+access_tx_pkt_integrity_mem_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendErrStatus
+ */
+static u64
+access_send_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[2];
+}
+
+static u64 access_send_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[1];
+}
+
+static u64 access_send_csr_parity_cnt(const struct cntr_entry *entry,
+				      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendCtxtErrStatus
+ */
+static u64
+access_pio_write_out_of_bounds_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[4];
+}
+
+static u64 access_pio_write_overflow_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[3];
+}
+
+static u64
+access_pio_write_crosses_boundary_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[2];
+}
+
+static u64 access_pio_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[1];
+}
+
+static u64 access_pio_inconsistent_sop_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendDmaEngErrStatus
+ */
+static u64
+access_sdma_header_request_fifo_cor_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[23];
+}
+
+static u64
+access_sdma_header_storage_cor_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[22];
+}
+
+static u64
+access_sdma_packet_tracking_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[21];
+}
+
+static u64 access_sdma_assembly_cor_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[20];
+}
+
+static u64 access_sdma_desc_table_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[19];
+}
+
+static u64
+access_sdma_header_request_fifo_unc_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[18];
+}
+
+static u64
+access_sdma_header_storage_unc_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[17];
+}
+
+static u64
+access_sdma_packet_tracking_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[16];
+}
+
+static u64 access_sdma_assembly_unc_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[15];
+}
+
+static u64 access_sdma_desc_table_unc_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[14];
+}
+
+static u64 access_sdma_timeout_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[13];
+}
+
+static u64 access_sdma_header_length_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[12];
+}
+
+static u64 access_sdma_header_address_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[11];
+}
+
+static u64 access_sdma_header_select_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[10];
+}
+
+static u64 access_sdma_reserved_9_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[9];
+}
+
+static u64
+access_sdma_packet_desc_overflow_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[8];
+}
+
+static u64 access_sdma_length_mismatch_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[7];
+}
+
+static u64 access_sdma_halt_err_cnt(const struct cntr_entry *entry,
+				    void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[6];
+}
+
+static u64 access_sdma_mem_read_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[5];
+}
+
+static u64 access_sdma_first_desc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[4];
+}
+
+static u64
+access_sdma_tail_out_of_bounds_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[3];
+}
+
+static u64 access_sdma_too_long_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[2];
+}
+
+static u64 access_sdma_gen_mismatch_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[1];
+}
+
+static u64 access_sdma_wrong_dw_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[0];
+}
+
+static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	u64 val = 0;
+	u64 csr = entry->csr;
+
+	val = read_write_csr(dd, csr, mode, data);
+	if (mode == CNTR_MODE_R) {
+		val = val > CNTR_MAX - dd->sw_rcv_bypass_packet_errors ?
+			      CNTR_MAX :
+			      val + dd->sw_rcv_bypass_packet_errors;
+	} else if (mode == CNTR_MODE_W) {
+		dd->sw_rcv_bypass_packet_errors = 0;
+	} else {
+		dd_dev_err(dd, "Invalid cntr register access mode");
+		return 0;
+	}
+	return val;
+}
+
+#define def_access_sw_cpu(cntr)                                                \
+	static u64 access_sw_cpu_##cntr(const struct cntr_entry *entry,        \
+					void *context, int vl, int mode,       \
+					u64 data)                              \
+	{                                                                      \
+		struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context; \
+		return read_write_cpu(ppd->dd, &ppd->ibport_data.rvp.z_##cntr, \
+				      ppd->ibport_data.rvp.cntr, vl, mode,     \
+				      data);                                   \
+	}
+
+def_access_sw_cpu(rc_acks);
+def_access_sw_cpu(rc_qacks);
+def_access_sw_cpu(rc_delayed_comp);
+
+#define def_access_ibp_counter(cntr)                                           \
+	static u64 access_ibp_##cntr(const struct cntr_entry *entry,           \
+				     void *context, int vl, int mode,          \
+				     u64 data)                                 \
+	{                                                                      \
+		struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context; \
+                                                                               \
+		if (vl != CNTR_INVALID_VL)                                     \
+			return 0;                                              \
+                                                                               \
+		return read_write_sw(ppd->dd, &ppd->ibport_data.rvp.n_##cntr,  \
+				     mode, data);                              \
+	}
+
+def_access_ibp_counter(loop_pkts);
+def_access_ibp_counter(rc_resends);
+def_access_ibp_counter(rnr_naks);
+def_access_ibp_counter(other_naks);
+def_access_ibp_counter(rc_timeouts);
+def_access_ibp_counter(pkt_drops);
+def_access_ibp_counter(dmawait);
+def_access_ibp_counter(rc_seqnak);
+def_access_ibp_counter(rc_dupreq);
+def_access_ibp_counter(rdma_seq);
+def_access_ibp_counter(unaligned);
+def_access_ibp_counter(seq_naks);
+def_access_ibp_counter(rc_crwaits);
+
+struct cntr_entry hfi2_shared_dev_cntrs[SHARED_DEV_CNTR_LAST] = {
+	[C_CCE_PCI_CR_ST] = CCE_PERF_DEV_CNTR_ELEM(
+		"CcePciCrSt", CCE_PCIE_POSTED_CRDT_STALL_CNT, CNTR_NORMAL),
+	[C_CCE_SDMA_INT] = CCE_INT_DEV_CNTR_ELEM(CceSdmaInt, CCE_SDMA_INT_CNT,
+						 CNTR_NORMAL),
+	[C_CCE_MISC_INT] = CCE_INT_DEV_CNTR_ELEM(CceMiscInt, CCE_MISC_INT_CNT,
+						 CNTR_NORMAL),
+	[C_CCE_RCV_AV_INT] = CCE_INT_DEV_CNTR_ELEM(
+		CceRcvAvInt, CCE_RCV_AVAIL_INT_CNT, CNTR_NORMAL),
+	[C_CCE_RCV_URG_INT] = CCE_INT_DEV_CNTR_ELEM(
+		CceRcvUrgInt, CCE_RCV_URGENT_INT_CNT, CNTR_NORMAL),
+	[C_CCE_SEND_CR_INT] = CCE_INT_DEV_CNTR_ELEM(
+		CceSndCrInt, CCE_SEND_CREDIT_INT_CNT, CNTR_NORMAL),
+	[C_SW_CPU_INTR] =
+		CNTR_ELEM("Intr", 0, 0, CNTR_NORMAL, access_sw_cpu_intr),
+	[C_SW_CPU_RCV_LIM] = CNTR_ELEM("RcvLimit", 0, 0, CNTR_NORMAL,
+				       access_sw_cpu_rcv_limit),
+	[C_SW_CTX0_SEQ_DROP] = CNTR_ELEM("SeqDrop0", 0, 0, CNTR_NORMAL,
+					 access_sw_ctx0_seq_drop),
+	[C_SW_VTX_WAIT] =
+		CNTR_ELEM("vTxWait", 0, 0, CNTR_NORMAL, access_sw_vtx_wait),
+	[C_SW_PIO_WAIT] =
+		CNTR_ELEM("PioWait", 0, 0, CNTR_NORMAL, access_sw_pio_wait),
+	[C_SW_PIO_DRAIN] =
+		CNTR_ELEM("PioDrain", 0, 0, CNTR_NORMAL, access_sw_pio_drain),
+	[C_SW_KMEM_WAIT] =
+		CNTR_ELEM("KmemWait", 0, 0, CNTR_NORMAL, access_sw_kmem_wait),
+	[C_SW_TID_WAIT] = CNTR_ELEM("TidWait", 0, 0, CNTR_NORMAL,
+				    hfi2_access_sw_tid_wait),
+	[C_SW_SEND_SCHED] = CNTR_ELEM("SendSched", 0, 0, CNTR_NORMAL,
+				      access_sw_send_schedule),
+	[C_SDMA_DESC_FETCHED_CNT] = CNTR_ELEM(
+		"SDEDscFdCn", 0, 0, CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+		dev_access_sde_desc_fetched_cnt),
+	[C_SDMA_INT_CNT] = CNTR_ELEM("SDMAInt", 0, 0,
+				     CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+				     access_sde_int_cnt),
+	[C_SDMA_ERR_CNT] = CNTR_ELEM("SDMAErrCt", 0, 0,
+				     CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+				     access_sde_err_cnt),
+	[C_SDMA_IDLE_INT_CNT] = CNTR_ELEM("SDMAIdInt", 0, 0,
+					  CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+					  access_sde_idle_int_cnt),
+	[C_SDMA_PROGRESS_INT_CNT] = CNTR_ELEM(
+		"SDMAPrIntCn", 0, 0, CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+		access_sde_progress_int_cnt),
+	/* MISC_ERR_STATUS */
+	[C_MISC_PLL_LOCK_FAIL_ERR] =
+		CNTR_ELEM("MISC_PLL_LOCK_FAIL_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_pll_lock_fail_err_cnt),
+	[C_MISC_MBIST_FAIL_ERR] = CNTR_ELEM("MISC_MBIST_FAIL_ERR", 0, 0,
+					    CNTR_NORMAL,
+					    access_misc_mbist_fail_err_cnt),
+	[C_MISC_INVALID_EEP_CMD_ERR] =
+		CNTR_ELEM("MISC_INVALID_EEP_CMD_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_invalid_eep_cmd_err_cnt),
+	[C_MISC_EFUSE_DONE_PARITY_ERR] =
+		CNTR_ELEM("MISC_EFUSE_DONE_PARITY_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_efuse_done_parity_err_cnt),
+	[C_MISC_EFUSE_WRITE_ERR] = CNTR_ELEM("MISC_EFUSE_WRITE_ERR", 0, 0,
+					     CNTR_NORMAL,
+					     access_misc_efuse_write_err_cnt),
+	[C_MISC_EFUSE_READ_BAD_ADDR_ERR] =
+		CNTR_ELEM("MISC_EFUSE_READ_BAD_ADDR_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_efuse_read_bad_addr_err_cnt),
+	[C_MISC_EFUSE_CSR_PARITY_ERR] =
+		CNTR_ELEM("MISC_EFUSE_CSR_PARITY_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_efuse_csr_parity_err_cnt),
+	[C_MISC_FW_AUTH_FAILED_ERR] =
+		CNTR_ELEM("MISC_FW_AUTH_FAILED_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_fw_auth_failed_err_cnt),
+	[C_MISC_KEY_MISMATCH_ERR] = CNTR_ELEM("MISC_KEY_MISMATCH_ERR", 0, 0,
+					      CNTR_NORMAL,
+					      access_misc_key_mismatch_err_cnt),
+	[C_MISC_SBUS_WRITE_FAILED_ERR] =
+		CNTR_ELEM("MISC_SBUS_WRITE_FAILED_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_sbus_write_failed_err_cnt),
+	[C_MISC_CSR_WRITE_BAD_ADDR_ERR] =
+		CNTR_ELEM("MISC_CSR_WRITE_BAD_ADDR_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_csr_write_bad_addr_err_cnt),
+	[C_MISC_CSR_READ_BAD_ADDR_ERR] =
+		CNTR_ELEM("MISC_CSR_READ_BAD_ADDR_ERR", 0, 0, CNTR_NORMAL,
+			  access_misc_csr_read_bad_addr_err_cnt),
+	[C_MISC_CSR_PARITY_ERR] = CNTR_ELEM("MISC_CSR_PARITY_ERR", 0, 0,
+					    CNTR_NORMAL,
+					    access_misc_csr_parity_err_cnt),
+	/* CceErrStatus */
+	[C_CCE_ERR_STATUS_AGGREGATED_CNT] =
+		CNTR_ELEM("CceErrStatusAggregatedCnt", 0, 0, CNTR_NORMAL,
+			  access_sw_cce_err_status_aggregated_cnt),
+	[C_CCE_MSIX_CSR_PARITY_ERR] =
+		CNTR_ELEM("CceMsixCsrParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_msix_csr_parity_err_cnt),
+	[C_CCE_INT_MAP_UNC_ERR] = CNTR_ELEM("CceIntMapUncErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_cce_int_map_unc_err_cnt),
+	[C_CCE_INT_MAP_COR_ERR] = CNTR_ELEM("CceIntMapCorErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_cce_int_map_cor_err_cnt),
+	[C_CCE_MSIX_TABLE_UNC_ERR] =
+		CNTR_ELEM("CceMsixTableUncErr", 0, 0, CNTR_NORMAL,
+			  access_cce_msix_table_unc_err_cnt),
+	[C_CCE_MSIX_TABLE_COR_ERR] =
+		CNTR_ELEM("CceMsixTableCorErr", 0, 0, CNTR_NORMAL,
+			  access_cce_msix_table_cor_err_cnt),
+	[C_CCE_RXDMA_CONV_FIFO_PARITY_ERR] =
+		CNTR_ELEM("CceRxdmaConvFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_rxdma_conv_fifo_parity_err_cnt),
+	[C_CCE_RCPL_ASYNC_FIFO_PARITY_ERR] =
+		CNTR_ELEM("CceRcplAsyncFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_rcpl_async_fifo_parity_err_cnt),
+	[C_CCE_SEG_WRITE_BAD_ADDR_ERR] =
+		CNTR_ELEM("CceSegWriteBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_cce_seg_write_bad_addr_err_cnt),
+	[C_CCE_SEG_READ_BAD_ADDR_ERR] =
+		CNTR_ELEM("CceSegReadBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_cce_seg_read_bad_addr_err_cnt),
+	[C_LA_TRIGGERED] = CNTR_ELEM("Cce LATriggered", 0, 0, CNTR_NORMAL,
+				     access_la_triggered_cnt),
+	[C_CCE_TRGT_CPL_TIMEOUT_ERR] =
+		CNTR_ELEM("CceTrgtCplTimeoutErr", 0, 0, CNTR_NORMAL,
+			  access_cce_trgt_cpl_timeout_err_cnt),
+	[C_PCIC_RECEIVE_PARITY_ERR] =
+		CNTR_ELEM("PcicReceiveParityErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_receive_parity_err_cnt),
+	[C_PCIC_TRANSMIT_BACK_PARITY_ERR] =
+		CNTR_ELEM("PcicTransmitBackParityErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_transmit_back_parity_err_cnt),
+	[C_PCIC_TRANSMIT_FRONT_PARITY_ERR] =
+		CNTR_ELEM("PcicTransmitFrontParityErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_transmit_front_parity_err_cnt),
+	[C_PCIC_CPL_DAT_Q_UNC_ERR] =
+		CNTR_ELEM("PcicCplDatQUncErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_cpl_dat_q_unc_err_cnt),
+	[C_PCIC_CPL_HD_Q_UNC_ERR] = CNTR_ELEM("PcicCplHdQUncErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_pcic_cpl_hd_q_unc_err_cnt),
+	[C_PCIC_POST_DAT_Q_UNC_ERR] =
+		CNTR_ELEM("PcicPostDatQUncErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_post_dat_q_unc_err_cnt),
+	[C_PCIC_POST_HD_Q_UNC_ERR] =
+		CNTR_ELEM("PcicPostHdQUncErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_post_hd_q_unc_err_cnt),
+	[C_PCIC_RETRY_SOT_MEM_UNC_ERR] =
+		CNTR_ELEM("PcicRetrySotMemUncErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_retry_sot_mem_unc_err_cnt),
+	[C_PCIC_RETRY_MEM_UNC_ERR] = CNTR_ELEM("PcicRetryMemUncErr", 0, 0,
+					       CNTR_NORMAL,
+					       access_pcic_retry_mem_unc_err),
+	[C_PCIC_N_POST_DAT_Q_PARITY_ERR] =
+		CNTR_ELEM("PcicNPostDatQParityErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_n_post_dat_q_parity_err_cnt),
+	[C_PCIC_N_POST_H_Q_PARITY_ERR] =
+		CNTR_ELEM("PcicNPostHQParityErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_n_post_h_q_parity_err_cnt),
+	[C_PCIC_CPL_DAT_Q_COR_ERR] =
+		CNTR_ELEM("PcicCplDatQCorErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_cpl_dat_q_cor_err_cnt),
+	[C_PCIC_CPL_HD_Q_COR_ERR] = CNTR_ELEM("PcicCplHdQCorErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_pcic_cpl_hd_q_cor_err_cnt),
+	[C_PCIC_POST_DAT_Q_COR_ERR] =
+		CNTR_ELEM("PcicPostDatQCorErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_post_dat_q_cor_err_cnt),
+	[C_PCIC_POST_HD_Q_COR_ERR] =
+		CNTR_ELEM("PcicPostHdQCorErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_post_hd_q_cor_err_cnt),
+	[C_PCIC_RETRY_SOT_MEM_COR_ERR] =
+		CNTR_ELEM("PcicRetrySotMemCorErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_retry_sot_mem_cor_err_cnt),
+	[C_PCIC_RETRY_MEM_COR_ERR] =
+		CNTR_ELEM("PcicRetryMemCorErr", 0, 0, CNTR_NORMAL,
+			  access_pcic_retry_mem_cor_err_cnt),
+	[C_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERR] =
+		CNTR_ELEM("CceCli1AsyncFifoDbgParityError", 0, 0, CNTR_NORMAL,
+			  access_cce_cli1_async_fifo_dbg_parity_err_cnt),
+	[C_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERR] =
+		CNTR_ELEM("CceCli1AsyncFifoRxdmaParityError", 0, 0, CNTR_NORMAL,
+			  access_cce_cli1_async_fifo_rxdma_parity_err_cnt),
+	[C_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR] =
+		CNTR_ELEM("CceCli1AsyncFifoSdmaHdParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_cli1_async_fifo_sdma_hd_parity_err_cnt),
+	[C_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR] =
+		CNTR_ELEM("CceCli1AsyncFifoPioCrdtParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_cl1_async_fifo_pio_crdt_parity_err_cnt),
+	[C_CCE_CLI2_ASYNC_FIFO_PARITY_ERR] =
+		CNTR_ELEM("CceCli2AsyncFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_cli2_async_fifo_parity_err_cnt),
+	[C_CCE_CSR_CFG_BUS_PARITY_ERR] =
+		CNTR_ELEM("CceCsrCfgBusParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_csr_cfg_bus_parity_err_cnt),
+	[C_CCE_CLI0_ASYNC_FIFO_PARTIY_ERR] =
+		CNTR_ELEM("CceCli0AsyncFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_cli0_async_fifo_parity_err_cnt),
+	[C_CCE_RSPD_DATA_PARITY_ERR] =
+		CNTR_ELEM("CceRspdDataParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_rspd_data_parity_err_cnt),
+	[C_CCE_TRGT_ACCESS_ERR] = CNTR_ELEM("CceTrgtAccessErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_cce_trgt_access_err_cnt),
+	[C_CCE_TRGT_ASYNC_FIFO_PARITY_ERR] =
+		CNTR_ELEM("CceTrgtAsyncFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_cce_trgt_async_fifo_parity_err_cnt),
+	[C_CCE_CSR_WRITE_BAD_ADDR_ERR] =
+		CNTR_ELEM("CceCsrWriteBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_cce_csr_write_bad_addr_err_cnt),
+	[C_CCE_CSR_READ_BAD_ADDR_ERR] =
+		CNTR_ELEM("CceCsrReadBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_cce_csr_read_bad_addr_err_cnt),
+	[C_CCE_CSR_PARITY_ERR] = CNTR_ELEM("CceCsrParityErr", 0, 0, CNTR_NORMAL,
+					   access_ccs_csr_parity_err_cnt),
+
+	/* RcvErrStatus */
+	[C_RX_CSR_PARITY_ERR] = CNTR_ELEM("RxCsrParityErr", 0, 0, CNTR_NORMAL,
+					  access_rx_csr_parity_err_cnt),
+	[C_RX_CSR_WRITE_BAD_ADDR_ERR] =
+		CNTR_ELEM("RxCsrWriteBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_rx_csr_write_bad_addr_err_cnt),
+	[C_RX_CSR_READ_BAD_ADDR_ERR] =
+		CNTR_ELEM("RxCsrReadBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_rx_csr_read_bad_addr_err_cnt),
+	[C_RX_DMA_CSR_UNC_ERR] = CNTR_ELEM("RxDmaCsrUncErr", 0, 0, CNTR_NORMAL,
+					   access_rx_dma_csr_unc_err_cnt),
+	[C_RX_DMA_DQ_FSM_ENCODING_ERR] =
+		CNTR_ELEM("RxDmaDqFsmEncodingErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_dq_fsm_encoding_err_cnt),
+	[C_RX_DMA_EQ_FSM_ENCODING_ERR] =
+		CNTR_ELEM("RxDmaEqFsmEncodingErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_eq_fsm_encoding_err_cnt),
+	[C_RX_DMA_CSR_PARITY_ERR] = CNTR_ELEM("RxDmaCsrParityErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_rx_dma_csr_parity_err_cnt),
+	[C_RX_RBUF_DATA_COR_ERR] = CNTR_ELEM("RxRbufDataCorErr", 0, 0,
+					     CNTR_NORMAL,
+					     access_rx_rbuf_data_cor_err_cnt),
+	[C_RX_RBUF_DATA_UNC_ERR] = CNTR_ELEM("RxRbufDataUncErr", 0, 0,
+					     CNTR_NORMAL,
+					     access_rx_rbuf_data_unc_err_cnt),
+	[C_RX_DMA_DATA_FIFO_RD_COR_ERR] =
+		CNTR_ELEM("RxDmaDataFifoRdCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_data_fifo_rd_cor_err_cnt),
+	[C_RX_DMA_DATA_FIFO_RD_UNC_ERR] =
+		CNTR_ELEM("RxDmaDataFifoRdUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_data_fifo_rd_unc_err_cnt),
+	[C_RX_DMA_HDR_FIFO_RD_COR_ERR] =
+		CNTR_ELEM("RxDmaHdrFifoRdCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_hdr_fifo_rd_cor_err_cnt),
+	[C_RX_DMA_HDR_FIFO_RD_UNC_ERR] =
+		CNTR_ELEM("RxDmaHdrFifoRdUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dma_hdr_fifo_rd_unc_err_cnt),
+	[C_RX_RBUF_DESC_PART2_COR_ERR] =
+		CNTR_ELEM("RxRbufDescPart2CorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_desc_part2_cor_err_cnt),
+	[C_RX_RBUF_DESC_PART2_UNC_ERR] =
+		CNTR_ELEM("RxRbufDescPart2UncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_desc_part2_unc_err_cnt),
+	[C_RX_RBUF_DESC_PART1_COR_ERR] =
+		CNTR_ELEM("RxRbufDescPart1CorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_desc_part1_cor_err_cnt),
+	[C_RX_RBUF_DESC_PART1_UNC_ERR] =
+		CNTR_ELEM("RxRbufDescPart1UncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_desc_part1_unc_err_cnt),
+	[C_RX_HQ_INTR_FSM_ERR] = CNTR_ELEM("RxHqIntrFsmErr", 0, 0, CNTR_NORMAL,
+					   access_rx_hq_intr_fsm_err_cnt),
+	[C_RX_HQ_INTR_CSR_PARITY_ERR] =
+		CNTR_ELEM("RxHqIntrCsrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_hq_intr_csr_parity_err_cnt),
+	[C_RX_LOOKUP_CSR_PARITY_ERR] =
+		CNTR_ELEM("RxLookupCsrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_csr_parity_err_cnt),
+	[C_RX_LOOKUP_RCV_ARRAY_COR_ERR] =
+		CNTR_ELEM("RxLookupRcvArrayCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_rcv_array_cor_err_cnt),
+	[C_RX_LOOKUP_RCV_ARRAY_UNC_ERR] =
+		CNTR_ELEM("RxLookupRcvArrayUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_rcv_array_unc_err_cnt),
+	[C_RX_LOOKUP_DES_PART2_PARITY_ERR] =
+		CNTR_ELEM("RxLookupDesPart2ParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_des_part2_parity_err_cnt),
+	[C_RX_LOOKUP_DES_PART1_UNC_COR_ERR] =
+		CNTR_ELEM("RxLookupDesPart1UncCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_des_part1_unc_cor_err_cnt),
+	[C_RX_LOOKUP_DES_PART1_UNC_ERR] =
+		CNTR_ELEM("RxLookupDesPart1UncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_lookup_des_part1_unc_err_cnt),
+	[C_RX_RBUF_NEXT_FREE_BUF_COR_ERR] =
+		CNTR_ELEM("RxRbufNextFreeBufCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_next_free_buf_cor_err_cnt),
+	[C_RX_RBUF_NEXT_FREE_BUF_UNC_ERR] =
+		CNTR_ELEM("RxRbufNextFreeBufUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_next_free_buf_unc_err_cnt),
+	[C_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR] =
+		CNTR_ELEM("RxRbufFlInitWrAddrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rbuf_fl_init_wr_addr_parity_err_cnt),
+	[C_RX_RBUF_FL_INITDONE_PARITY_ERR] =
+		CNTR_ELEM("RxRbufFlInitdoneParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_fl_initdone_parity_err_cnt),
+	[C_RX_RBUF_FL_WRITE_ADDR_PARITY_ERR] =
+		CNTR_ELEM("RxRbufFlWrAddrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_fl_write_addr_parity_err_cnt),
+	[C_RX_RBUF_FL_RD_ADDR_PARITY_ERR] =
+		CNTR_ELEM("RxRbufFlRdAddrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_fl_rd_addr_parity_err_cnt),
+	[C_RX_RBUF_EMPTY_ERR] = CNTR_ELEM("RxRbufEmptyErr", 0, 0, CNTR_NORMAL,
+					  access_rx_rbuf_empty_err_cnt),
+	[C_RX_RBUF_FULL_ERR] = CNTR_ELEM("RxRbufFullErr", 0, 0, CNTR_NORMAL,
+					 access_rx_rbuf_full_err_cnt),
+	[C_RX_RBUF_BAD_LOOKUP_ERR] = CNTR_ELEM("RxRBufBadLookupErr", 0, 0,
+					       CNTR_NORMAL,
+					       access_rbuf_bad_lookup_err_cnt),
+	[C_RX_RBUF_CTX_ID_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCtxIdParityErr", 0, 0, CNTR_NORMAL,
+			  access_rbuf_ctx_id_parity_err_cnt),
+	[C_RX_RBUF_CSR_QEOPDW_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQEOPDWParityErr", 0, 0, CNTR_NORMAL,
+			  access_rbuf_csr_qeopdw_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_NUM_OF_PKT_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQNumOfPktParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_num_of_pkt_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_T1_PTR_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQTlPtrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_t1_ptr_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_HD_PTR_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQHdPtrParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_hd_ptr_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_VLD_BIT_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQVldBitParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_vld_bit_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_NEXT_BUF_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQNextBufParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_next_buf_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_ENT_CNT_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQEntCntParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_ent_cnt_parity_err_cnt),
+	[C_RX_RBUF_CSR_Q_HEAD_BUF_NUM_PARITY_ERR] =
+		CNTR_ELEM("RxRbufCsrQHeadBufNumParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_csr_q_head_buf_num_parity_err_cnt),
+	[C_RX_RBUF_BLOCK_LIST_READ_COR_ERR] =
+		CNTR_ELEM("RxRbufBlockListReadCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_block_list_read_cor_err_cnt),
+	[C_RX_RBUF_BLOCK_LIST_READ_UNC_ERR] =
+		CNTR_ELEM("RxRbufBlockListReadUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_block_list_read_unc_err_cnt),
+	[C_RX_RBUF_LOOKUP_DES_COR_ERR] =
+		CNTR_ELEM("RxRbufLookupDesCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_lookup_des_cor_err_cnt),
+	[C_RX_RBUF_LOOKUP_DES_UNC_ERR] =
+		CNTR_ELEM("RxRbufLookupDesUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_lookup_des_unc_err_cnt),
+	[C_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR] =
+		CNTR_ELEM("RxRbufLookupDesRegUncCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_lookup_des_reg_unc_cor_err_cnt),
+	[C_RX_RBUF_LOOKUP_DES_REG_UNC_ERR] =
+		CNTR_ELEM("RxRbufLookupDesRegUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_lookup_des_reg_unc_err_cnt),
+	[C_RX_RBUF_FREE_LIST_COR_ERR] =
+		CNTR_ELEM("RxRbufFreeListCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_free_list_cor_err_cnt),
+	[C_RX_RBUF_FREE_LIST_UNC_ERR] =
+		CNTR_ELEM("RxRbufFreeListUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rbuf_free_list_unc_err_cnt),
+	[C_RX_RCV_FSM_ENCODING_ERR] =
+		CNTR_ELEM("RxRcvFsmEncodingErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rcv_fsm_encoding_err_cnt),
+	[C_RX_DMA_FLAG_COR_ERR] = CNTR_ELEM("RxDmaFlagCorErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_rx_dma_flag_cor_err_cnt),
+	[C_RX_DMA_FLAG_UNC_ERR] = CNTR_ELEM("RxDmaFlagUncErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_rx_dma_flag_unc_err_cnt),
+	[C_RX_DC_SOP_EOP_PARITY_ERR] =
+		CNTR_ELEM("RxDcSopEopParityErr", 0, 0, CNTR_NORMAL,
+			  access_rx_dc_sop_eop_parity_err_cnt),
+	[C_RX_RCV_CSR_PARITY_ERR] = CNTR_ELEM("RxRcvCsrParityErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_rx_rcv_csr_parity_err_cnt),
+	[C_RX_RCV_QP_MAP_TABLE_COR_ERR] =
+		CNTR_ELEM("RxRcvQpMapTableCorErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rcv_qp_map_table_cor_err_cnt),
+	[C_RX_RCV_QP_MAP_TABLE_UNC_ERR] =
+		CNTR_ELEM("RxRcvQpMapTableUncErr", 0, 0, CNTR_NORMAL,
+			  access_rx_rcv_qp_map_table_unc_err_cnt),
+	[C_RX_RCV_DATA_COR_ERR] = CNTR_ELEM("RxRcvDataCorErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_rx_rcv_data_cor_err_cnt),
+	[C_RX_RCV_DATA_UNC_ERR] = CNTR_ELEM("RxRcvDataUncErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_rx_rcv_data_unc_err_cnt),
+	[C_RX_RCV_HDR_COR_ERR] = CNTR_ELEM("RxRcvHdrCorErr", 0, 0, CNTR_NORMAL,
+					   access_rx_rcv_hdr_cor_err_cnt),
+	[C_RX_RCV_HDR_UNC_ERR] = CNTR_ELEM("RxRcvHdrUncErr", 0, 0, CNTR_NORMAL,
+					   access_rx_rcv_hdr_unc_err_cnt),
+	[C_RX_DC_INTF_PARITY_ERR] = CNTR_ELEM("RxDcIntfParityErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_rx_dc_intf_parity_err_cnt),
+	[C_RX_DMA_CSR_COR_ERR] = CNTR_ELEM("RxDmaCsrCorErr", 0, 0, CNTR_NORMAL,
+					   access_rx_dma_csr_cor_err_cnt),
+	/* SendPioErrStatus */
+	[C_PIO_PEC_SOP_HEAD_PARITY_ERR] =
+		CNTR_ELEM("PioPecSopHeadParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pec_sop_head_parity_err_cnt),
+	[C_PIO_PCC_SOP_HEAD_PARITY_ERR] =
+		CNTR_ELEM("PioPccSopHeadParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pcc_sop_head_parity_err_cnt),
+	[C_PIO_LAST_RETURNED_CNT_PARITY_ERR] =
+		CNTR_ELEM("PioLastReturnedCntParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_last_returned_cnt_parity_err_cnt),
+	[C_PIO_CURRENT_FREE_CNT_PARITY_ERR] =
+		CNTR_ELEM("PioCurrentFreeCntParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_current_free_cnt_parity_err_cnt),
+	[C_PIO_RSVD_31_ERR] = CNTR_ELEM("Pio Reserved 31", 0, 0, CNTR_NORMAL,
+					access_pio_reserved_31_err_cnt),
+	[C_PIO_RSVD_30_ERR] = CNTR_ELEM("Pio Reserved 30", 0, 0, CNTR_NORMAL,
+					access_pio_reserved_30_err_cnt),
+	[C_PIO_PPMC_SOP_LEN_ERR] = CNTR_ELEM("PioPpmcSopLenErr", 0, 0,
+					     CNTR_NORMAL,
+					     access_pio_ppmc_sop_len_err_cnt),
+	[C_PIO_PPMC_BQC_MEM_PARITY_ERR] =
+		CNTR_ELEM("PioPpmcBqcMemParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_ppmc_bqc_mem_parity_err_cnt),
+	[C_PIO_VL_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioVlFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_vl_fifo_parity_err_cnt),
+	[C_PIO_VLF_SOP_PARITY_ERR] =
+		CNTR_ELEM("PioVlfSopParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_vlf_sop_parity_err_cnt),
+	[C_PIO_VLF_V1_LEN_PARITY_ERR] =
+		CNTR_ELEM("PioVlfVlLenParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_vlf_v1_len_parity_err_cnt),
+	[C_PIO_BLOCK_QW_COUNT_PARITY_ERR] =
+		CNTR_ELEM("PioBlockQwCountParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_block_qw_count_parity_err_cnt),
+	[C_PIO_WRITE_QW_VALID_PARITY_ERR] =
+		CNTR_ELEM("PioWriteQwValidParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_qw_valid_parity_err_cnt),
+	[C_PIO_STATE_MACHINE_ERR] = CNTR_ELEM("PioStateMachineErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_pio_state_machine_err_cnt),
+	[C_PIO_WRITE_DATA_PARITY_ERR] =
+		CNTR_ELEM("PioWriteDataParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_data_parity_err_cnt),
+	[C_PIO_HOST_ADDR_MEM_COR_ERR] =
+		CNTR_ELEM("PioHostAddrMemCorErr", 0, 0, CNTR_NORMAL,
+			  access_pio_host_addr_mem_cor_err_cnt),
+	[C_PIO_HOST_ADDR_MEM_UNC_ERR] =
+		CNTR_ELEM("PioHostAddrMemUncErr", 0, 0, CNTR_NORMAL,
+			  access_pio_host_addr_mem_unc_err_cnt),
+	[C_PIO_PKT_EVICT_SM_OR_ARM_SM_ERR] =
+		CNTR_ELEM("PioPktEvictSmOrArbSmErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pkt_evict_sm_or_arb_sm_err_cnt),
+	[C_PIO_INIT_SM_IN_ERR] = CNTR_ELEM("PioInitSmInErr", 0, 0, CNTR_NORMAL,
+					   access_pio_init_sm_in_err_cnt),
+	[C_PIO_PPMC_PBL_FIFO_ERR] = CNTR_ELEM("PioPpmcPblFifoErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_pio_ppmc_pbl_fifo_err_cnt),
+	[C_PIO_CREDIT_RET_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioCreditRetFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_credit_ret_fifo_parity_err_cnt),
+	[C_PIO_V1_LEN_MEM_BANK1_COR_ERR] =
+		CNTR_ELEM("PioVlLenMemBank1CorErr", 0, 0, CNTR_NORMAL,
+			  access_pio_v1_len_mem_bank1_cor_err_cnt),
+	[C_PIO_V1_LEN_MEM_BANK0_COR_ERR] =
+		CNTR_ELEM("PioVlLenMemBank0CorErr", 0, 0, CNTR_NORMAL,
+			  access_pio_v1_len_mem_bank0_cor_err_cnt),
+	[C_PIO_V1_LEN_MEM_BANK1_UNC_ERR] =
+		CNTR_ELEM("PioVlLenMemBank1UncErr", 0, 0, CNTR_NORMAL,
+			  access_pio_v1_len_mem_bank1_unc_err_cnt),
+	[C_PIO_V1_LEN_MEM_BANK0_UNC_ERR] =
+		CNTR_ELEM("PioVlLenMemBank0UncErr", 0, 0, CNTR_NORMAL,
+			  access_pio_v1_len_mem_bank0_unc_err_cnt),
+	[C_PIO_SM_PKT_RESET_PARITY_ERR] =
+		CNTR_ELEM("PioSmPktResetParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_sm_pkt_reset_parity_err_cnt),
+	[C_PIO_PKT_EVICT_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioPktEvictFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pkt_evict_fifo_parity_err_cnt),
+	[C_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioSbrdctrlCrrelFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_sbrdctrl_crrel_fifo_parity_err_cnt),
+	[C_PIO_SBRDCTL_CRREL_PARITY_ERR] =
+		CNTR_ELEM("PioSbrdctlCrrelParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_sbrdctl_crrel_parity_err_cnt),
+	[C_PIO_PEC_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioPecFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pec_fifo_parity_err_cnt),
+	[C_PIO_PCC_FIFO_PARITY_ERR] =
+		CNTR_ELEM("PioPccFifoParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_pcc_fifo_parity_err_cnt),
+	[C_PIO_SB_MEM_FIFO1_ERR] = CNTR_ELEM("PioSbMemFifo1Err", 0, 0,
+					     CNTR_NORMAL,
+					     access_pio_sb_mem_fifo1_err_cnt),
+	[C_PIO_SB_MEM_FIFO0_ERR] = CNTR_ELEM("PioSbMemFifo0Err", 0, 0,
+					     CNTR_NORMAL,
+					     access_pio_sb_mem_fifo0_err_cnt),
+	[C_PIO_CSR_PARITY_ERR] = CNTR_ELEM("PioCsrParityErr", 0, 0, CNTR_NORMAL,
+					   access_pio_csr_parity_err_cnt),
+	[C_PIO_WRITE_ADDR_PARITY_ERR] =
+		CNTR_ELEM("PioWriteAddrParityErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_addr_parity_err_cnt),
+	[C_PIO_WRITE_BAD_CTXT_ERR] =
+		CNTR_ELEM("PioWriteBadCtxtErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_bad_ctxt_err_cnt),
+	/* SendDmaErrStatus */
+	[C_SDMA_PCIE_REQ_TRACKING_COR_ERR] =
+		CNTR_ELEM("SDmaPcieReqTrackingCorErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_pcie_req_tracking_cor_err_cnt),
+	[C_SDMA_PCIE_REQ_TRACKING_UNC_ERR] =
+		CNTR_ELEM("SDmaPcieReqTrackingUncErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_pcie_req_tracking_unc_err_cnt),
+	[C_SDMA_CSR_PARITY_ERR] = CNTR_ELEM("SDmaCsrParityErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_sdma_csr_parity_err_cnt),
+	[C_SDMA_RPY_TAG_ERR] = CNTR_ELEM("SDmaRpyTagErr", 0, 0, CNTR_NORMAL,
+					 access_sdma_rpy_tag_err_cnt),
+	/* SendEgressErrStatus */
+	[C_TX_READ_PIO_MEMORY_CSR_UNC_ERR] =
+		CNTR_ELEM("TxReadPioMemoryCsrUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_pio_memory_csr_unc_err_cnt),
+	[C_TX_READ_SDMA_MEMORY_CSR_UNC_ERR] =
+		CNTR_ELEM("TxReadSdmaMemoryCsrUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_sdma_memory_csr_err_cnt),
+	[C_TX_EGRESS_FIFO_COR_ERR] =
+		CNTR_ELEM("TxEgressFifoCorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_egress_fifo_cor_err_cnt),
+	[C_TX_READ_PIO_MEMORY_COR_ERR] =
+		CNTR_ELEM("TxReadPioMemoryCorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_pio_memory_cor_err_cnt),
+	[C_TX_READ_SDMA_MEMORY_COR_ERR] =
+		CNTR_ELEM("TxReadSdmaMemoryCorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_sdma_memory_cor_err_cnt),
+	[C_TX_SB_HDR_COR_ERR] = CNTR_ELEM("TxSbHdrCorErr", 0, 0, CNTR_NORMAL,
+					  access_tx_sb_hdr_cor_err_cnt),
+	[C_TX_CREDIT_OVERRUN_ERR] = CNTR_ELEM("TxCreditOverrunErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_tx_credit_overrun_err_cnt),
+	[C_TX_LAUNCH_FIFO8_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo8CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo8_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO7_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo7CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo7_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO6_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo6CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo6_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO5_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo5CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo5_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO4_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo4CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo4_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO3_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo3CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo3_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO2_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo2CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo2_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO1_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo1CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo1_cor_err_cnt),
+	[C_TX_LAUNCH_FIFO0_COR_ERR] =
+		CNTR_ELEM("TxLaunchFifo0CorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo0_cor_err_cnt),
+	[C_TX_CREDIT_RETURN_VL_ERR] =
+		CNTR_ELEM("TxCreditReturnVLErr", 0, 0, CNTR_NORMAL,
+			  access_tx_credit_return_vl_err_cnt),
+	[C_TX_HCRC_INSERTION_ERR] = CNTR_ELEM("TxHcrcInsertionErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_tx_hcrc_insertion_err_cnt),
+	[C_TX_EGRESS_FIFI_UNC_ERR] =
+		CNTR_ELEM("TxEgressFifoUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_egress_fifo_unc_err_cnt),
+	[C_TX_READ_PIO_MEMORY_UNC_ERR] =
+		CNTR_ELEM("TxReadPioMemoryUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_pio_memory_unc_err_cnt),
+	[C_TX_READ_SDMA_MEMORY_UNC_ERR] =
+		CNTR_ELEM("TxReadSdmaMemoryUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_read_sdma_memory_unc_err_cnt),
+	[C_TX_SB_HDR_UNC_ERR] = CNTR_ELEM("TxSbHdrUncErr", 0, 0, CNTR_NORMAL,
+					  access_tx_sb_hdr_unc_err_cnt),
+	[C_TX_CREDIT_RETURN_PARITY_ERR] =
+		CNTR_ELEM("TxCreditReturnParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_credit_return_partiy_err_cnt),
+	[C_TX_LAUNCH_FIFO8_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo8UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo8_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO7_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo7UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo7_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO6_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo6UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo6_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO5_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo5UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo5_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO4_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo4UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo4_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO3_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo3UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo3_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO2_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo2UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo2_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO1_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo1UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo1_unc_or_parity_err_cnt),
+	[C_TX_LAUNCH_FIFO0_UNC_OR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchFifo0UncOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_fifo0_unc_or_parity_err_cnt),
+	[C_TX_SDMA15_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma15DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma15_disallowed_packet_err_cnt),
+	[C_TX_SDMA14_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma14DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma14_disallowed_packet_err_cnt),
+	[C_TX_SDMA13_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma13DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma13_disallowed_packet_err_cnt),
+	[C_TX_SDMA12_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma12DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma12_disallowed_packet_err_cnt),
+	[C_TX_SDMA11_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma11DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma11_disallowed_packet_err_cnt),
+	[C_TX_SDMA10_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma10DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma10_disallowed_packet_err_cnt),
+	[C_TX_SDMA9_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma9DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma9_disallowed_packet_err_cnt),
+	[C_TX_SDMA8_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma8DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma8_disallowed_packet_err_cnt),
+	[C_TX_SDMA7_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma7DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma7_disallowed_packet_err_cnt),
+	[C_TX_SDMA6_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma6DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma6_disallowed_packet_err_cnt),
+	[C_TX_SDMA5_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma5DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma5_disallowed_packet_err_cnt),
+	[C_TX_SDMA4_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma4DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma4_disallowed_packet_err_cnt),
+	[C_TX_SDMA3_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma3DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma3_disallowed_packet_err_cnt),
+	[C_TX_SDMA2_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma2DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma2_disallowed_packet_err_cnt),
+	[C_TX_SDMA1_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma1DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma1_disallowed_packet_err_cnt),
+	[C_TX_SDMA0_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("TxSdma0DisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma0_disallowed_packet_err_cnt),
+	[C_TX_CONFIG_PARITY_ERR] = CNTR_ELEM("TxConfigParityErr", 0, 0,
+					     CNTR_NORMAL,
+					     access_tx_config_parity_err_cnt),
+	[C_TX_SBRD_CTL_CSR_PARITY_ERR] =
+		CNTR_ELEM("TxSbrdCtlCsrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sbrd_ctl_csr_parity_err_cnt),
+	[C_TX_LAUNCH_CSR_PARITY_ERR] =
+		CNTR_ELEM("TxLaunchCsrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_launch_csr_parity_err_cnt),
+	[C_TX_ILLEGAL_CL_ERR] = CNTR_ELEM("TxIllegalVLErr", 0, 0, CNTR_NORMAL,
+					  access_tx_illegal_vl_err_cnt),
+	[C_TX_SBRD_CTL_STATE_MACHINE_PARITY_ERR] =
+		CNTR_ELEM("TxSbrdCtlStateMachineParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sbrd_ctl_state_machine_parity_err_cnt),
+	[C_TX_RESERVED_10] = CNTR_ELEM("Tx Egress Reserved 10", 0, 0,
+				       CNTR_NORMAL,
+				       access_egress_reserved_10_err_cnt),
+	[C_TX_RESERVED_9] = CNTR_ELEM("Tx Egress Reserved 9", 0, 0, CNTR_NORMAL,
+				      access_egress_reserved_9_err_cnt),
+	[C_TX_SDMA_LAUNCH_INTF_PARITY_ERR] =
+		CNTR_ELEM("TxSdmaLaunchIntfParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_sdma_launch_intf_parity_err_cnt),
+	[C_TX_PIO_LAUNCH_INTF_PARITY_ERR] =
+		CNTR_ELEM("TxPioLaunchIntfParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_pio_launch_intf_parity_err_cnt),
+	[C_TX_RESERVED_6] = CNTR_ELEM("Tx Egress Reserved 6", 0, 0, CNTR_NORMAL,
+				      access_egress_reserved_6_err_cnt),
+	[C_TX_INCORRECT_LINK_STATE_ERR] =
+		CNTR_ELEM("TxIncorrectLinkStateErr", 0, 0, CNTR_NORMAL,
+			  access_tx_incorrect_link_state_err_cnt),
+	[C_TX_LINK_DOWN_ERR] = CNTR_ELEM("TxLinkdownErr", 0, 0, CNTR_NORMAL,
+					 access_tx_linkdown_err_cnt),
+	[C_TX_EGRESS_FIFO_UNDERRUN_OR_PARITY_ERR] =
+		CNTR_ELEM("EgressFifoUnderrunOrParityErr", 0, 0, CNTR_NORMAL,
+			  access_tx_egress_fifi_underrun_or_parity_err_cnt),
+	[C_TX_RESERVED_2] = CNTR_ELEM("Tx Egress Reserved 2", 0, 0, CNTR_NORMAL,
+				      access_egress_reserved_2_err_cnt),
+	[C_TX_PKT_INTEGRITY_MEM_UNC_ERR] =
+		CNTR_ELEM("TxPktIntegrityMemUncErr", 0, 0, CNTR_NORMAL,
+			  access_tx_pkt_integrity_mem_unc_err_cnt),
+	[C_TX_PKT_INTEGRITY_MEM_COR_ERR] =
+		CNTR_ELEM("TxPktIntegrityMemCorErr", 0, 0, CNTR_NORMAL,
+			  access_tx_pkt_integrity_mem_cor_err_cnt),
+	/* SendErrStatus */
+	[C_SEND_CSR_WRITE_BAD_ADDR_ERR] =
+		CNTR_ELEM("SendCsrWriteBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_send_csr_write_bad_addr_err_cnt),
+	[C_SEND_CSR_READ_BAD_ADD_ERR] =
+		CNTR_ELEM("SendCsrReadBadAddrErr", 0, 0, CNTR_NORMAL,
+			  access_send_csr_read_bad_addr_err_cnt),
+	[C_SEND_CSR_PARITY_ERR] = CNTR_ELEM("SendCsrParityErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_send_csr_parity_cnt),
+	/* SendCtxtErrStatus */
+	[C_PIO_WRITE_OUT_OF_BOUNDS_ERR] =
+		CNTR_ELEM("PioWriteOutOfBoundsErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_out_of_bounds_err_cnt),
+	[C_PIO_WRITE_OVERFLOW_ERR] =
+		CNTR_ELEM("PioWriteOverflowErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_overflow_err_cnt),
+	[C_PIO_WRITE_CROSSES_BOUNDARY_ERR] =
+		CNTR_ELEM("PioWriteCrossesBoundaryErr", 0, 0, CNTR_NORMAL,
+			  access_pio_write_crosses_boundary_err_cnt),
+	[C_PIO_DISALLOWED_PACKET_ERR] =
+		CNTR_ELEM("PioDisallowedPacketErr", 0, 0, CNTR_NORMAL,
+			  access_pio_disallowed_packet_err_cnt),
+	[C_PIO_INCONSISTENT_SOP_ERR] =
+		CNTR_ELEM("PioInconsistentSopErr", 0, 0, CNTR_NORMAL,
+			  access_pio_inconsistent_sop_err_cnt),
+	/* SendDmaEngErrStatus */
+	[C_SDMA_HEADER_REQUEST_FIFO_COR_ERR] =
+		CNTR_ELEM("SDmaHeaderRequestFifoCorErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_request_fifo_cor_err_cnt),
+	[C_SDMA_HEADER_STORAGE_COR_ERR] =
+		CNTR_ELEM("SDmaHeaderStorageCorErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_storage_cor_err_cnt),
+	[C_SDMA_PACKET_TRACKING_COR_ERR] =
+		CNTR_ELEM("SDmaPacketTrackingCorErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_packet_tracking_cor_err_cnt),
+	[C_SDMA_ASSEMBLY_COR_ERR] = CNTR_ELEM("SDmaAssemblyCorErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_sdma_assembly_cor_err_cnt),
+	[C_SDMA_DESC_TABLE_COR_ERR] =
+		CNTR_ELEM("SDmaDescTableCorErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_desc_table_cor_err_cnt),
+	[C_SDMA_HEADER_REQUEST_FIFO_UNC_ERR] =
+		CNTR_ELEM("SDmaHeaderRequestFifoUncErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_request_fifo_unc_err_cnt),
+	[C_SDMA_HEADER_STORAGE_UNC_ERR] =
+		CNTR_ELEM("SDmaHeaderStorageUncErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_storage_unc_err_cnt),
+	[C_SDMA_PACKET_TRACKING_UNC_ERR] =
+		CNTR_ELEM("SDmaPacketTrackingUncErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_packet_tracking_unc_err_cnt),
+	[C_SDMA_ASSEMBLY_UNC_ERR] = CNTR_ELEM("SDmaAssemblyUncErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_sdma_assembly_unc_err_cnt),
+	[C_SDMA_DESC_TABLE_UNC_ERR] =
+		CNTR_ELEM("SDmaDescTableUncErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_desc_table_unc_err_cnt),
+	[C_SDMA_TIMEOUT_ERR] = CNTR_ELEM("SDmaTimeoutErr", 0, 0, CNTR_NORMAL,
+					 access_sdma_timeout_err_cnt),
+	[C_SDMA_HEADER_LENGTH_ERR] =
+		CNTR_ELEM("SDmaHeaderLengthErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_length_err_cnt),
+	[C_SDMA_HEADER_ADDRESS_ERR] =
+		CNTR_ELEM("SDmaHeaderAddressErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_address_err_cnt),
+	[C_SDMA_HEADER_SELECT_ERR] =
+		CNTR_ELEM("SDmaHeaderSelectErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_header_select_err_cnt),
+	[C_SMDA_RESERVED_9] = CNTR_ELEM("SDma Reserved 9", 0, 0, CNTR_NORMAL,
+					access_sdma_reserved_9_err_cnt),
+	[C_SDMA_PACKET_DESC_OVERFLOW_ERR] =
+		CNTR_ELEM("SDmaPacketDescOverflowErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_packet_desc_overflow_err_cnt),
+	[C_SDMA_LENGTH_MISMATCH_ERR] =
+		CNTR_ELEM("SDmaLengthMismatchErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_length_mismatch_err_cnt),
+	[C_SDMA_HALT_ERR] = CNTR_ELEM("SDmaHaltErr", 0, 0, CNTR_NORMAL,
+				      access_sdma_halt_err_cnt),
+	[C_SDMA_MEM_READ_ERR] = CNTR_ELEM("SDmaMemReadErr", 0, 0, CNTR_NORMAL,
+					  access_sdma_mem_read_err_cnt),
+	[C_SDMA_FIRST_DESC_ERR] = CNTR_ELEM("SDmaFirstDescErr", 0, 0,
+					    CNTR_NORMAL,
+					    access_sdma_first_desc_err_cnt),
+	[C_SDMA_TAIL_OUT_OF_BOUNDS_ERR] =
+		CNTR_ELEM("SDmaTailOutOfBoundsErr", 0, 0, CNTR_NORMAL,
+			  access_sdma_tail_out_of_bounds_err_cnt),
+	[C_SDMA_TOO_LONG_ERR] = CNTR_ELEM("SDmaTooLongErr", 0, 0, CNTR_NORMAL,
+					  access_sdma_too_long_err_cnt),
+	[C_SDMA_GEN_MISMATCH_ERR] = CNTR_ELEM("SDmaGenMismatchErr", 0, 0,
+					      CNTR_NORMAL,
+					      access_sdma_gen_mismatch_err_cnt),
+	[C_SDMA_WRONG_DW_ERR] = CNTR_ELEM("SDmaWrongDwErr", 0, 0, CNTR_NORMAL,
+					  access_sdma_wrong_dw_err_cnt),
+};
+
+struct cntr_entry hfi2_wfr_dev_cntrs[WFR_NUM_DEV_CNTRS] = {
+#define A(x) ((x)-WFR_DEV_CNTR_FIRST) /* absolute number */
+	[A(C_DC_UNC_ERR)] = DC_PERF_CNTR(DcUnctblErr, DCC_ERR_UNCORRECTABLE_CNT,
+					 CNTR_SYNTH),
+	[A(C_DC_RCV_ERR)] = CNTR_ELEM("DcRecvErr", DCC_ERR_PORTRCV_ERR_CNT, 0,
+				      CNTR_SYNTH, access_dc_rcv_err_cnt),
+	[A(C_DC_FM_CFG_ERR)] =
+		DC_PERF_CNTR(DcFmCfgErr, DCC_ERR_FMCONFIG_ERR_CNT, CNTR_SYNTH),
+	[A(C_DC_RMT_PHY_ERR)] = DC_PERF_CNTR(
+		DcRmtPhyErr, DCC_ERR_RCVREMOTE_PHY_ERR_CNT, CNTR_SYNTH),
+	[A(C_DC_DROPPED_PKT)] =
+		DC_PERF_CNTR(DcDroppedPkt, DCC_ERR_DROPPED_PKT_CNT, CNTR_SYNTH),
+	[A(C_DC_MC_XMIT_PKTS)] = DC_PERF_CNTR(
+		DcMcXmitPkts, DCC_PRF_PORT_XMIT_MULTICAST_CNT, CNTR_SYNTH),
+	[A(C_DC_MC_RCV_PKTS)] = DC_PERF_CNTR(
+		DcMcRcvPkts, DCC_PRF_PORT_RCV_MULTICAST_PKT_CNT, CNTR_SYNTH),
+	[A(C_DC_XMIT_CERR)] = DC_PERF_CNTR(
+		DcXmitCorr, DCC_PRF_PORT_XMIT_CORRECTABLE_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_CERR)] = DC_PERF_CNTR(
+		DcRcvCorrCnt, DCC_PRF_PORT_RCV_CORRECTABLE_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_FCC)] =
+		DC_PERF_CNTR(DcRxFCntl, DCC_PRF_RX_FLOW_CRTL_CNT, CNTR_SYNTH),
+	[A(C_DC_XMIT_FCC)] =
+		DC_PERF_CNTR(DcXmitFCntl, DCC_PRF_TX_FLOW_CRTL_CNT, CNTR_SYNTH),
+	[A(C_DC_XMIT_FLITS)] = DC_PERF_CNTR(
+		DcXmitFlits, DCC_PRF_PORT_XMIT_DATA_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_FLITS)] =
+		DC_PERF_CNTR(DcRcvFlits, DCC_PRF_PORT_RCV_DATA_CNT, CNTR_SYNTH),
+	[A(C_DC_XMIT_PKTS)] = DC_PERF_CNTR(
+		DcXmitPkts, DCC_PRF_PORT_XMIT_PKTS_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_PKTS)] =
+		DC_PERF_CNTR(DcRcvPkts, DCC_PRF_PORT_RCV_PKTS_CNT, CNTR_SYNTH),
+	[A(C_DC_RX_FLIT_VL)] = DC_PERF_CNTR(
+		DcRxFlitVl, DCC_PRF_PORT_VL_RCV_DATA_CNT, CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_RX_PKT_VL)] = DC_PERF_CNTR(
+		DcRxPktVl, DCC_PRF_PORT_VL_RCV_PKTS_CNT, CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_RCV_FCN)] =
+		DC_PERF_CNTR(DcRcvFcn, DCC_PRF_PORT_RCV_FECN_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_FCN_VL)] = DC_PERF_CNTR(
+		DcRcvFcnVl, DCC_PRF_PORT_VL_RCV_FECN_CNT, CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_RCV_BCN)] =
+		DC_PERF_CNTR(DcRcvBcn, DCC_PRF_PORT_RCV_BECN_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_BCN_VL)] = DC_PERF_CNTR(
+		DcRcvBcnVl, DCC_PRF_PORT_VL_RCV_BECN_CNT, CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_RCV_BBL)] =
+		DC_PERF_CNTR(DcRcvBbl, DCC_PRF_PORT_RCV_BUBBLE_CNT, CNTR_SYNTH),
+	[A(C_DC_RCV_BBL_VL)] = DC_PERF_CNTR(DcRcvBblVl,
+					    DCC_PRF_PORT_VL_RCV_BUBBLE_CNT,
+					    CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_MARK_FECN)] =
+		DC_PERF_CNTR(DcMarkFcn, DCC_PRF_PORT_MARK_FECN_CNT, CNTR_SYNTH),
+	[A(C_DC_MARK_FECN_VL)] = DC_PERF_CNTR(DcMarkFcnVl,
+					      DCC_PRF_PORT_VL_MARK_FECN_CNT,
+					      CNTR_SYNTH | CNTR_VL),
+	[A(C_DC_TOTAL_CRC)] = DC_PERF_CNTR_LCB(
+		DcTotCrc, DC_LCB_ERR_INFO_TOTAL_CRC_ERR, CNTR_SYNTH),
+	[A(C_DC_CRC_LN0)] = DC_PERF_CNTR_LCB(
+		DcCrcLn0, DC_LCB_ERR_INFO_CRC_ERR_LN0, CNTR_SYNTH),
+	[A(C_DC_CRC_LN1)] = DC_PERF_CNTR_LCB(
+		DcCrcLn1, DC_LCB_ERR_INFO_CRC_ERR_LN1, CNTR_SYNTH),
+	[A(C_DC_CRC_LN2)] = DC_PERF_CNTR_LCB(
+		DcCrcLn2, DC_LCB_ERR_INFO_CRC_ERR_LN2, CNTR_SYNTH),
+	[A(C_DC_CRC_LN3)] = DC_PERF_CNTR_LCB(
+		DcCrcLn3, DC_LCB_ERR_INFO_CRC_ERR_LN3, CNTR_SYNTH),
+	[A(C_DC_CRC_MULT_LN)] = DC_PERF_CNTR_LCB(
+		DcMultLn, DC_LCB_ERR_INFO_CRC_ERR_MULTI_LN, CNTR_SYNTH),
+	[A(C_DC_TX_REPLAY)] = DC_PERF_CNTR_LCB(
+		DcTxReplay, DC_LCB_ERR_INFO_TX_REPLAY_CNT, CNTR_SYNTH),
+	[A(C_DC_RX_REPLAY)] = DC_PERF_CNTR_LCB(
+		DcRxReplay, DC_LCB_ERR_INFO_RX_REPLAY_CNT, CNTR_SYNTH),
+	[A(C_DC_SEQ_CRC_CNT)] = DC_PERF_CNTR_LCB(
+		DcLinkSeqCrc, DC_LCB_ERR_INFO_SEQ_CRC_CNT, CNTR_SYNTH),
+	[A(C_DC_ESC0_ONLY_CNT)] = DC_PERF_CNTR_LCB(
+		DcEsc0, DC_LCB_ERR_INFO_ESCAPE_0_ONLY_CNT, CNTR_SYNTH),
+	[A(C_DC_ESC0_PLUS1_CNT)] = DC_PERF_CNTR_LCB(
+		DcEsc1, DC_LCB_ERR_INFO_ESCAPE_0_PLUS1_CNT, CNTR_SYNTH),
+	[A(C_DC_ESC0_PLUS2_CNT)] = DC_PERF_CNTR_LCB(
+		DcEsc0Plus2, DC_LCB_ERR_INFO_ESCAPE_0_PLUS2_CNT, CNTR_SYNTH),
+	[A(C_DC_REINIT_FROM_PEER_CNT)] = DC_PERF_CNTR_LCB(
+		DcReinitPeer, DC_LCB_ERR_INFO_REINIT_FROM_PEER_CNT, CNTR_SYNTH),
+	[A(C_DC_SBE_CNT)] =
+		DC_PERF_CNTR_LCB(DcSbe, DC_LCB_ERR_INFO_SBE_CNT, CNTR_SYNTH),
+	[A(C_DC_MISC_FLG_CNT)] = DC_PERF_CNTR_LCB(
+		DcMiscFlg, DC_LCB_ERR_INFO_MISC_FLG_CNT, CNTR_SYNTH),
+	[A(C_DC_PRF_GOOD_LTP_CNT)] = DC_PERF_CNTR_LCB(
+		DcGoodLTP, DC_LCB_PRF_GOOD_LTP_CNT, CNTR_SYNTH),
+	[A(C_DC_PRF_ACCEPTED_LTP_CNT)] = DC_PERF_CNTR_LCB(
+		DcAccLTP, DC_LCB_PRF_ACCEPTED_LTP_CNT, CNTR_SYNTH),
+	[A(C_DC_PRF_RX_FLIT_CNT)] = DC_PERF_CNTR_LCB(
+		DcPrfRxFlit, DC_LCB_PRF_RX_FLIT_CNT, CNTR_SYNTH),
+	[A(C_DC_PRF_TX_FLIT_CNT)] = DC_PERF_CNTR_LCB(
+		DcPrfTxFlit, DC_LCB_PRF_TX_FLIT_CNT, CNTR_SYNTH),
+	[A(C_DC_PRF_CLK_CNTR)] =
+		DC_PERF_CNTR_LCB(DcPrfClk, DC_LCB_PRF_CLK_CNTR, CNTR_SYNTH),
+	[A(C_DC_PG_DBG_FLIT_CRDTS_CNT)] = DC_PERF_CNTR_LCB(
+		DcFltCrdts, DC_LCB_PG_DBG_FLIT_CRDTS_CNT, CNTR_SYNTH),
+	[A(C_DC_PG_STS_PAUSE_COMPLETE_CNT)] = DC_PERF_CNTR_LCB(
+		DcPauseComp, DC_LCB_PG_STS_PAUSE_COMPLETE_CNT, CNTR_SYNTH),
+	[A(C_DC_PG_STS_TX_SBE_CNT)] = DC_PERF_CNTR_LCB(
+		DcStsTxSbe, DC_LCB_PG_STS_TX_SBE_CNT, CNTR_SYNTH),
+	[A(C_DC_PG_STS_TX_MBE_CNT)] = DC_PERF_CNTR_LCB(
+		DcStsTxMbe, DC_LCB_PG_STS_TX_MBE_CNT, CNTR_SYNTH),
+	[A(C_CCE_PCI_TR_ST)] = CCE_PERF_DEV_CNTR_ELEM(
+		"CcePciTrSt", CCE_PCIE_TRGT_STALL_CNT, CNTR_NORMAL),
+	[A(C_CCE_PIO_WR_ST)] = CCE_PERF_DEV_CNTR_ELEM(
+		"CcePioWrSt", CCE_PIO_WR_STALL_CNT, CNTR_NORMAL),
+	[A(C_CCE_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CceErrInt, WFR_CCE_ERR_INT_CNT, CNTR_NORMAL),
+#undef A
+};
+
+struct cntr_entry hfi2_jkr_dev_cntrs[JKR_NUM_DEV_CNTRS] = {
+#define A(x) ((x)-JKR_DEV_CNTR_FIRST) /* absolute number */
+	[A(C_CCE_RW_ST_BY_R)] =
+		CCE_PERF_DEV_CNTR_ELEM("CceRdWrStByRd", 0, CNTR_NORMAL),
+	[A(C_CCE_OTHER_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CceOtherInt, JKR_C_CCE_OTHER_INT_CNT, CNTR_NORMAL),
+	[A(C_CCE_PBC_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CcePbcInt, JKR_C_CCE_PBC_INT_CNT, CNTR_NORMAL),
+	[A(C_CCE_PIO_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CcePioErrInt, JKR_C_CCE_PIO_ERR_INT_CNT, CNTR_NORMAL),
+	[A(C_CCE_SDMA_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CceSdmaErrInt, JKR_C_CCE_SDMA_ERR_INT_CNT, CNTR_NORMAL),
+	[A(C_CCE_CSR_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(
+		CceCsrErrInt, JKR_C_CCE_CSR_ERR_INT_CNT, CNTR_NORMAL),
+#undef A
+};
+
+struct cntr_entry hfi2_shared_port_cntrs[SHARED_PORT_CNTR_LAST] = {
+	[C_TX_UNSUP_VL] = TXE32_PORT_CNTR_ELEM(TxUnVLErr, SEND_UNSUP_VL_ERR_CNT,
+					       CNTR_NORMAL),
+	[C_TX_INVAL_LEN] =
+		TXE32_PORT_CNTR_ELEM(TxInvalLen, SEND_LEN_ERR_CNT, CNTR_NORMAL),
+	[C_TX_MM_LEN_ERR] = TXE32_PORT_CNTR_ELEM(
+		TxMMLenErr, SEND_MAX_MIN_LEN_ERR_CNT, CNTR_NORMAL),
+	[C_TX_UNDERRUN] = TXE32_PORT_CNTR_ELEM(TxUnderrun, SEND_UNDERRUN_CNT,
+					       CNTR_NORMAL),
+	[C_TX_FLOW_STALL] = TXE32_PORT_CNTR_ELEM(
+		TxFlowStall, SEND_FLOW_STALL_CNT, CNTR_NORMAL),
+	[C_TX_DROPPED] = TXE32_PORT_CNTR_ELEM(TxDropped, SEND_DROPPED_PKT_CNT,
+					      CNTR_NORMAL),
+	[C_TX_HDR_ERR] = TXE32_PORT_CNTR_ELEM(TxHdrErr, SEND_HEADERS_ERR_CNT,
+					      CNTR_NORMAL),
+	[C_TX_PKT] =
+		TXE64_PORT_CNTR_ELEM(TxPkt, SEND_DATA_PKT_CNT, CNTR_NORMAL),
+	[C_TX_WORDS] =
+		TXE64_PORT_CNTR_ELEM(TxWords, SEND_DWORD_CNT, CNTR_NORMAL),
+	[C_TX_WAIT] = TXE64_PORT_CNTR_ELEM(TxWait, SEND_WAIT_CNT, CNTR_SYNTH),
+	[C_TX_FLIT_VL] = TXE64_PORT_CNTR_ELEM(TxFlitVL, SEND_DATA_VL0_CNT,
+					      CNTR_SYNTH | CNTR_VL),
+	[C_TX_PKT_VL] = TXE64_PORT_CNTR_ELEM(TxPktVL, SEND_DATA_PKT_VL0_CNT,
+					     CNTR_SYNTH | CNTR_VL),
+	[C_TX_WAIT_VL] = TXE64_PORT_CNTR_ELEM(TxWaitVL, SEND_WAIT_VL0_CNT,
+					      CNTR_SYNTH | CNTR_VL),
+	[C_RCV_OVF] = RXE32_PORT_CNTR_ELEM("RcvOverflow", RCV_BUF_OVFL_CNT,
+					   CNTR_SYNTH),
+	[C_RX_LEN_ERR] = RXE32_PORT_CNTR_ELEM("RxLenErr", RCV_LENGTH_ERR_CNT,
+					      CNTR_SYNTH),
+	[C_RX_SHORT_ERR] =
+		RXE32_PORT_CNTR_ELEM("RxShrErr", RCV_SHORT_ERR_CNT, CNTR_SYNTH),
+	[C_RX_ICRC_ERR] =
+		RXE32_PORT_CNTR_ELEM("RxICrcErr", RCV_ICRC_ERR_CNT, CNTR_SYNTH),
+	[C_RX_EBP] = RXE32_PORT_CNTR_ELEM("RxEbpCnt", RCV_EBP_CNT, CNTR_SYNTH),
+	[C_RX_PKEY_MISMATCH] = RXE32_PORT_CNTR_ELEM(
+		"RxPkeyMismatch", RCV_PKEY_MISMATCH_CNT, CNTR_SYNTH),
+	[C_RX_PKT] = RXE64_PORT_CNTR_ELEM(RxPkt, RCV_DATA_PKT_CNT, CNTR_NORMAL),
+	[C_RX_WORDS] =
+		RXE64_PORT_CNTR_ELEM(RxWords, RCV_DWORD_CNT, CNTR_NORMAL),
+	[C_SW_LINK_DOWN] = CNTR_ELEM("SwLinkDown", 0, 0,
+				     CNTR_SYNTH | CNTR_32BIT,
+				     access_sw_link_dn_cnt),
+	[C_SW_LINK_UP] = CNTR_ELEM("SwLinkUp", 0, 0, CNTR_SYNTH | CNTR_32BIT,
+				   access_sw_link_up_cnt),
+	[C_SW_UNKNOWN_FRAME] = CNTR_ELEM("UnknownFrame", 0, 0, CNTR_NORMAL,
+					 access_sw_unknown_frame_cnt),
+	[C_SW_XMIT_DSCD] = CNTR_ELEM("XmitDscd", 0, 0, CNTR_SYNTH | CNTR_32BIT,
+				     access_sw_xmit_discards),
+	[C_SW_XMIT_DSCD_VL] = CNTR_ELEM("XmitDscdVl", 0, 0,
+					CNTR_SYNTH | CNTR_32BIT | CNTR_VL,
+					access_sw_xmit_discards),
+	[C_SW_XMIT_CSTR_ERR] = CNTR_ELEM("XmitCstrErr", 0, 0, CNTR_SYNTH,
+					 access_xmit_constraint_errs),
+	[C_SW_RCV_CSTR_ERR] = CNTR_ELEM("RcvCstrErr", 0, 0, CNTR_SYNTH,
+					access_rcv_constraint_errs),
+	[C_SW_IBP_LOOP_PKTS] = SW_IBP_CNTR(LoopPkts, loop_pkts),
+	[C_SW_IBP_RC_RESENDS] = SW_IBP_CNTR(RcResend, rc_resends),
+	[C_SW_IBP_RNR_NAKS] = SW_IBP_CNTR(RnrNak, rnr_naks),
+	[C_SW_IBP_OTHER_NAKS] = SW_IBP_CNTR(OtherNak, other_naks),
+	[C_SW_IBP_RC_TIMEOUTS] = SW_IBP_CNTR(RcTimeOut, rc_timeouts),
+	[C_SW_IBP_PKT_DROPS] = SW_IBP_CNTR(PktDrop, pkt_drops),
+	[C_SW_IBP_DMA_WAIT] = SW_IBP_CNTR(DmaWait, dmawait),
+	[C_SW_IBP_RC_SEQNAK] = SW_IBP_CNTR(RcSeqNak, rc_seqnak),
+	[C_SW_IBP_RC_DUPREQ] = SW_IBP_CNTR(RcDupRew, rc_dupreq),
+	[C_SW_IBP_RDMA_SEQ] = SW_IBP_CNTR(RdmaSeq, rdma_seq),
+	[C_SW_IBP_UNALIGNED] = SW_IBP_CNTR(Unaligned, unaligned),
+	[C_SW_IBP_SEQ_NAK] = SW_IBP_CNTR(SeqNak, seq_naks),
+	[C_SW_IBP_RC_CRWAITS] = SW_IBP_CNTR(RcCrWait, rc_crwaits),
+	[C_SW_CPU_RC_ACKS] =
+		CNTR_ELEM("RcAcks", 0, 0, CNTR_NORMAL, access_sw_cpu_rc_acks),
+	[C_SW_CPU_RC_QACKS] =
+		CNTR_ELEM("RcQacks", 0, 0, CNTR_NORMAL, access_sw_cpu_rc_qacks),
+	[C_SW_CPU_RC_DELAYED_COMP] = CNTR_ELEM("RcDelayComp", 0, 0, CNTR_NORMAL,
+					       access_sw_cpu_rc_delayed_comp),
+	[C_RCV_HDR_OVF] =
+		CNTR_ELEM("RcvHdrOvr", 0, 0, CNTR_OVF, access_ovf_csr),
+};
+
+struct cntr_entry hfi2_wfr_port_cntrs[WFR_NUM_PORT_CNTRS] = {
+#define A(x) ((x)-WFR_PORT_CNTR_FIRST) /* absolute number */
+	[A(C_WFR_RX_DROPPED_PKT)] = RXE32_PORT_CNTR_ELEM(
+		"RxDroppedPkt", RCV_DROPPED_PKT_CNT, CNTR_SYNTH),
+	[A(C_WFR_RX_DROPPED_BYPASS_PKT)] = RXE32_PORT_CNTR_ELEM(
+		"RxDroppedBypassPkt", RCV_DROPPED_BYPASS_PKT_CNT, CNTR_SYNTH),
+	[A(C_WFR_RX_TID_FULL)] = RXE32_PORT_CNTR_ELEM(
+		"RxTIDFullErr", RCV_TID_FULL_ERR_CNT, CNTR_NORMAL),
+	[A(C_WFR_RX_TID_INVALID)] = RXE32_PORT_CNTR_ELEM(
+		"RxTIDInvalid", RCV_TID_VALID_ERR_CNT, CNTR_NORMAL),
+	[A(C_WFR_RX_TID_FLGMS)] = RXE32_PORT_CNTR_ELEM(
+		"RxTidFLGMs", RCV_TID_FLOW_GEN_MISMATCH_CNT, CNTR_NORMAL),
+	[A(C_WFR_RX_CTX_EGRS)] = RXE32_PORT_CNTR_ELEM(
+		"RxCtxEgrS", RCV_CONTEXT_EGR_STALL, CNTR_NORMAL),
+	[A(C_WFR_RCV_TID_FLSMS)] = RXE32_PORT_CNTR_ELEM(
+		"RxTidFLSMs", RCV_TID_FLOW_SEQ_MISMATCH_CNT, CNTR_NORMAL),
+#undef A
+};
+
+/* RcvCounterArray32 selected indices specific to JKR */
+enum {
+	JKR_RCV_L2_TYPE_DISABLED = 5,
+	JKR_RCV_DROPPED_PKT_CNT_16B = 18,
+	JKR_RCV_DROPPED_PKT_CNT_9B = 19,
+	JKR_RCV_TID_FULL_ERR_CNT = 20,
+	JKR_RCV_TID_VALID_ERR_CNT = 21,
+	JKR_RCV_TID_FLOW_GEN_MISMATCH_CNT = 22,
+	JKR_RCV_CONTEXT_EGR_STALL = 24,
+	JKR_RCV_TID_FLOW_SEQ_MISMATCH_CNT = 25,
+};
+
+struct cntr_entry hfi2_jkr_port_cntrs[JKR_NUM_PORT_CNTRS] = {
+#define A(x) ((x)-JKR_DEV_CNTR_FIRST) /* absolute number */
+	[A(C_JKR_RX_L2_TYPE_DISABLED)] = RXE32_PORT_CNTR_ELEM(
+		"RxL2TypeDisabled", JKR_RCV_L2_TYPE_DISABLED, CNTR_SYNTH),
+	[A(C_JKR_RX_DROPPED_PKT_16B)] = RXE32_PORT_CNTR_ELEM(
+		"RxDroppedPkt16B", JKR_RCV_DROPPED_PKT_CNT_16B, CNTR_SYNTH),
+	[A(C_JKR_RX_DROPPED_PKT_9B)] = RXE32_PORT_CNTR_ELEM(
+		"RxDroppedPkt9B", JKR_RCV_DROPPED_PKT_CNT_9B, CNTR_SYNTH),
+	[A(C_JKR_RX_TID_FULL)] = RXE32_PORT_CNTR_ELEM(
+		"RxTIDFullErr", JKR_RCV_TID_FULL_ERR_CNT, CNTR_NORMAL),
+	[A(C_JKR_RX_TID_INVALID)] = RXE32_PORT_CNTR_ELEM(
+		"RxTIDInvalid", JKR_RCV_TID_VALID_ERR_CNT, CNTR_NORMAL),
+	[A(C_JKR_RX_TID_FLGMS)] = RXE32_PORT_CNTR_ELEM(
+		"RxTidFLGMs", JKR_RCV_TID_FLOW_GEN_MISMATCH_CNT, CNTR_NORMAL),
+	[A(C_JKR_RX_CTX_EGRS)] = RXE32_PORT_CNTR_ELEM(
+		"RxCtxEgrS", JKR_RCV_CONTEXT_EGR_STALL, CNTR_NORMAL),
+	[A(C_JKR_RCV_TID_FLSMS)] = RXE32_PORT_CNTR_ELEM(
+		"RxTidFLSMs", JKR_RCV_TID_FLOW_SEQ_MISMATCH_CNT, CNTR_NORMAL),
+#undef A
+};
diff --git a/drivers/infiniband/hw/hfi2/debugfs.h b/drivers/infiniband/hw/hfi2/debugfs.h
new file mode 100644
index 000000000000..c41b3a468dc9
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/debugfs.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016, 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_DEBUGFS_H
+#define _HFI2_DEBUGFS_H
+
+struct hfi2_ibdev;
+
+#define DEBUGFS_SEQ_FILE_OPS(name) \
+static const struct seq_operations _##name##_seq_ops = { \
+	.start = _##name##_seq_start, \
+	.next  = _##name##_seq_next, \
+	.stop  = _##name##_seq_stop, \
+	.show  = _##name##_seq_show \
+}
+
+#define DEBUGFS_SEQ_FILE_OPEN(name) \
+static int _##name##_open(struct inode *inode, struct file *s) \
+{ \
+	struct seq_file *seq; \
+	int ret; \
+	ret =  seq_open(s, &_##name##_seq_ops); \
+	if (ret) \
+		return ret; \
+	seq = s->private_data; \
+	seq->private = inode->i_private; \
+	return 0; \
+}
+
+#define DEBUGFS_FILE_OPS(name) \
+static const struct file_operations _##name##_file_ops = { \
+	.owner   = THIS_MODULE, \
+	.open    = _##name##_open, \
+	.read    = seq_read, \
+	.llseek  = seq_lseek, \
+	.release = seq_release \
+}
+
+#ifdef CONFIG_DEBUG_FS
+void hfi2_dbg_ibdev_init(struct hfi2_ibdev *ibd);
+void hfi2_dbg_ibdev_exit(struct hfi2_ibdev *ibd);
+void hfi2_dbg_init(void);
+void hfi2_dbg_exit(void);
+
+#else
+static inline void hfi2_dbg_ibdev_init(struct hfi2_ibdev *ibd)
+{
+}
+
+static inline void hfi2_dbg_ibdev_exit(struct hfi2_ibdev *ibd)
+{
+}
+
+static inline void hfi2_dbg_init(void)
+{
+}
+
+static inline void hfi2_dbg_exit(void)
+{
+}
+#endif
+
+#endif                          /* _HFI2_DEBUGFS_H */
diff --git a/drivers/infiniband/hw/hfi2/fault.h b/drivers/infiniband/hw/hfi2/fault.h
new file mode 100644
index 000000000000..58736ce447c0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/fault.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_FAULT_H
+#define _HFI2_FAULT_H
+
+#include <linux/fault-inject.h>
+#include <linux/dcache.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <rdma/rdma_vt.h>
+
+#include "hfi2.h"
+
+struct hfi2_ibdev;
+
+#if defined(CONFIG_FAULT_INJECTION) && defined(CONFIG_FAULT_INJECTION_DEBUG_FS)
+struct fault {
+	struct fault_attr attr;
+	struct dentry *dir;
+	u64 n_rxfaults[(1U << BITS_PER_BYTE)];
+	u64 n_txfaults[(1U << BITS_PER_BYTE)];
+	u64 fault_skip;
+	u64 skip;
+	u64 fault_skip_usec;
+	unsigned long skip_usec;
+	unsigned long opcodes[(1U << BITS_PER_BYTE) / BITS_PER_LONG];
+	bool enable;
+	bool suppress_err;
+	bool opcode;
+	u8 direction;
+};
+
+int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd);
+bool hfi2_dbg_should_fault_tx(struct rvt_qp *qp, u32 opcode);
+bool hfi2_dbg_should_fault_rx(struct hfi2_packet *packet);
+bool hfi2_dbg_fault_suppress_err(struct hfi2_ibdev *ibd);
+void hfi2_fault_exit_debugfs(struct hfi2_ibdev *ibd);
+
+#else
+
+static inline int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd)
+{
+	return 0;
+}
+
+static inline bool hfi2_dbg_should_fault_rx(struct hfi2_packet *packet)
+{
+	return false;
+}
+
+static inline bool hfi2_dbg_should_fault_tx(struct rvt_qp *qp,
+					    u32 opcode)
+{
+	return false;
+}
+
+static inline bool hfi2_dbg_fault_suppress_err(struct hfi2_ibdev *ibd)
+{
+	return false;
+}
+
+static inline void hfi2_fault_exit_debugfs(struct hfi2_ibdev *ibd)
+{
+}
+#endif
+#endif /* _HFI2_FAULT_H */



