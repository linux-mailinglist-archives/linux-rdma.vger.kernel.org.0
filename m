Return-Path: <linux-rdma+bounces-21889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cgkfGtyqI2oDwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:06:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D228064C7F5
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=KmF9Xjju;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21889-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21889-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D69130451E8
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79853009E1;
	Sat,  6 Jun 2026 05:00:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D421A9F88;
	Sat,  6 Jun 2026 05:00:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722022; cv=fail; b=BfN9bQX6363MQFxAqOo3hr5CLPsf62CmKJX9czBBkzUHTvBat1TWndLZQWoIjsC8gfWhnSCSJVWSjl7P+R6sZm35cGMI2Z7NL70xtgwEiC3YI20mS+hL4cPAbmfufcLCTnBwpJ2fdpwBmhAhm964bVhD8WwcvDuaLzwPL/dW8F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722022; c=relaxed/simple;
	bh=8vPFzoWCw6PwCCjJruSWRvlhSM8PagBjV+MiCRbWtcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3n3ixlG95e7L7xtZ31hz+CuvFnhsinghusmKOhC715zXUyHFBtLs2l0aZpxrSVrxFW5qjf5jbTJifPdWtLON183HgWdOUQkcQqKLlyxHecj4b+NHLeaVgSYcSjpfbLDJBLxCycz+sIcUdjnvTxZnCazIN5lT2TMABOqutl1ZMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmF9Xjju; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJYvgQ/75/7Ef2d5hzNbA9+GNX4NMrl6VSqekKg+lQkXV8oCmZr4bJ2yOj2MbQYsGV/kO1ccNHgfr9w53GH8a5VsICioqgCY08ZQCT7eSvxA/gG9vZedidD3EDNjftZ+SPq0Y23Wbsn7l6hTQFaECbgarpOMsMVP3eMKsgDiR7RYa1G7+iBT27rN2B20c1QjM2ODsAKtFCJJPthiBXEacy6uLrqRxj4TSbcRyft+h2baV/obwY/QI0b9QD7W6emq2vMWBqzHsYWw5PIllqMF8OMqBOcBZVEjJBCTT7SlX0nHutcBOkCDlPjyoaATF+gWElLWBU+8Pd+o+WU/WSYosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oglBy3gN8yOxremoic9UKD7TI/L+LsetJamBsbN3TWc=;
 b=PhQpAul0N1viTgAbbygDN5MKlG48qTm1rgk0NICPmPM8YRcEZNVjYDdPZxwfFPdHENL8AYtEhi7HrzhINViKpZa7EwHjteLDQE6XP1tYSp7irkBoDh/Ks/Ih42rFfa20bRI8slNe4Z0nyUy0DmB6pZafg2r6VysheHzeWUcckbCtDZW6JgOaoPmqHZRlXntVmexAFgcRr5VX1kzOZ/Hguq9pY5Cg4fD6JXiWJaWM0YKK88xmsgXL82IXROnnfvfPInRdmCrJqlTFWrAHTvrs0SnTjxRWqKawS1RweUS7xkTJGblydPQDJuwzGJ8j9C7GO9KA2cCSWIzsspQ633hiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oglBy3gN8yOxremoic9UKD7TI/L+LsetJamBsbN3TWc=;
 b=KmF9Xjju+pWHZQtByi646TTW1eRpimq1Z68cS2xqxw6tAUjr+rBWJlCB2p7LIL7Lby3j7rSiKPzI3LSO8qjDwg2Q7dllG6XrSDVDKveF7G01KxieV3MB7k+jfJdfsfZBX8ZLfZWD94Mls+g9EUjFSUbcZ9Nz+h5xm6KmwwrYC68=
Received: from BLAPR03CA0055.namprd03.prod.outlook.com (2603:10b6:208:32d::30)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Sat, 6 Jun 2026
 05:00:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::af) by BLAPR03CA0055.outlook.office365.com
 (2603:10b6:208:32d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Sat, 6
 Jun 2026 05:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:15 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:12 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 0/5] ionic: RDMA completion timestamping support
Date: Sat, 6 Jun 2026 10:29:58 +0530
Message-ID: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a81a77-71d5-406f-7f6b-08dec3887fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	elNuUSf4gr2WZ+cSHf8icdNQdWsdqkjcel4pXRXDfutKtD3W52QooVR8s7pkLE13Z7ktxzlOCFcvuAtscg8Oaw5b1/l0dGypUTBm3hUzk00K7FAYkfQkVesYwO3ezjTQBZpFGTyXPbSSm4NPY362VxoxGNnaGFkpxbTmw8tvISW65+/iMvTV90HsYmATsu5boxaTBQjU1vDFEubmceNdbJ3/ocyLBtAsW6tJr9qx8wi8uyAXk3NVgCXYvgHdvqT+/1ZLLt7ZYQHhqrtuzhL/hnqXVC6auoG1OF5w2vzbn1l+3EMCKGyMl/NsKvvFv1ISya54Itl9GO+q5t5qEUQnQXUb2vx2KDgpbh/Mp5HCFkJrl2FKFas5HX5Q7I6ufF5sMCxpA6C+rdO2DsbamwlgXsG+FWAmlzr1iBuTxPeJdXRAv9j5EypcEY79IYms9Q9kW+Mr4mkObZWVHY3qLGRKVJxesYQGPVdntlVr2I5JV53nXnoSk1cxl18LLx6F+S+Iqnx7J3UZWIGfSDPFL6jWs4RuODmtHIqZRBdBuQG2OmAkOH6ORs9XjiWWOKQs6mFy0dqcsnToNj2tBAzikoyBKM5SxBw0FSSVoQU1U0RCNZLBp6jpYs+jaUyDLzW4cHC+uSCb7hyIPYurRKpfbm5LJA2paVFQXLEbuh/2dfG8hHKSzgN3B/KOFGkcqIxnptYjcpV69W1XMfTcZLz1POWBFjdZdUPn040RfD1bFxFVFks=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eL7VVs4p+Z2whBRQxs0HicbwJonuw2EHpbi8mv+re3KGcnN5RCOtTrmWJP4LnQ4BWWwYK4cpzfF8TtF5mk9JBfoaHHkGguwiKLO7UZbgUVKN/2NijUcwGnO3CxO2T5ahvAlhsummu7JHFOLmAYhWmnoNlYSRWsXWS7IG5O4F8tRQCFIDUqrdBKptHCKFvnL6Hxp/3onRt+v8/izajXt3zU3NGj5W//g+W7VuLn0maMSPnpEWQl1znyV8Yf4UN/EwJCQFL1In6k0EPVExm2lWFTvEQ1MQzp3qejJj/zVkygFXSZDgFaiDR9AFEHJ8DKIMf+dhcnq2gpLyU+sUJbjN9EMvudQTEPlsY7MT2iYpao3MN0/ydxBT53hnu38LFgSC9UNVdDJL++0Y4QHszgS8Rs5PoJvYeX9EpYZLnzJqHirxc2dt6GnomW4M6mI1XDGf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:16.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a81a77-71d5-406f-7f6b-08dec3887fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
	TAGGED_FROM(0.00)[bounces-21889-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:from_mime,amd.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D228064C7F5

Hi,

This series adds RDMA completion timestamp support for ionic.

It enables PHC registration for RDMA timestamp capability, exposes a PHC
state page for safe user-space reads, maps that PHC state through RDMA
ucontext mmap, and extends the RDMA CQE format to carry completion
timestamps.

With this, user space can read completion timestamps and convert them to
wall time with low overhead.

Provider's PR: https://github.com/linux-rdma/rdma-core/pull/1724

v3:
  - Renamed ib_uverbs_phc_state to ib_uverbs_clock_info
  - Moved mlx5 to use the common clock info structure
  - Addressed review feedback from Sashiko
v2:
  - changed ionic_phc_state to ib_uverbs_phc_state and moved it under
    ib_user_verbs.h
  - https://lore.kernel.org/linux-rdma/20260512092623.1157199-1-abhijit.gangurde@amd.com/
v1:
  - https://lore.kernel.org/all/20260401102501.3395305-1-abhijit.gangurde@amd.com/

Abhijit Gangurde (5):
  net: ionic: register PHC for rdma timestamping
  net: ionic: Add PHC state page for user space access
  RDMA/ionic: map PHC state into user space
  RDMA/ionic: add completion timestamp to CQE format
  RDMA/mlx5: move mlx5 clock info to common struct ib_uverbs_clock_info

 .../infiniband/hw/ionic/ionic_controlpath.c   | 34 ++++++++++
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 43 ++++++-------
 drivers/infiniband/hw/ionic/ionic_fw.h        | 12 +++-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  8 +--
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 12 ++--
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 63 ++++++++++++++++---
 include/linux/mlx5/driver.h                   |  2 +-
 include/uapi/rdma/ib_user_verbs.h             | 33 ++++++++++
 include/uapi/rdma/ionic-abi.h                 |  1 +
 include/uapi/rdma/mlx5-abi.h                  |  3 +
 16 files changed, 183 insertions(+), 42 deletions(-)

-- 
2.43.0


