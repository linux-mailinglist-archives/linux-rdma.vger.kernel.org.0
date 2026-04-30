Return-Path: <linux-rdma+bounces-19782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAk1KwhO82mqzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:41:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D94A2D70
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54700303CE81
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334540629A;
	Thu, 30 Apr 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C4tqemyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6F3FE657;
	Thu, 30 Apr 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552796; cv=fail; b=OORHtCbqM39MjiBmZv6vbp8/okVGI8UByo11YrWmcyN66SdoXZNLu7ehwaoEQ7FEAuLi3XUO36FCQ/JoSGFjnWhUrn4ImlQayEDv6NTtPiAiH2Jdy6hg++kzlW5hDjq0sExgo/fjy1ekHoILnXLZp2f5ymLsGPrcKUUHS3sWtKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552796; c=relaxed/simple;
	bh=CjkgBTKxy2CFKfW4KR3kqCmQW49Omb/pKSz5Ae2VlXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9UdzcVFDLVP2QGOB0K0BEf2vYcKDsmLHA4F0vkg+hEDSAAq4rOs6eCg+gjVuheJQMWklqIl4NU6PUTdeoz/TIgrRtb+TsvSY39tL8sZnDEqYntcapZx38kynvXtsrho3v6LWHyjRFv4/VunU+LNvl5WOAyGagLdeqUd64gQVpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C4tqemyN; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdExT6oCrNCcEutn7/a+naRBK5RKtXhR9he5l659fXeWv6e8xjgBoaP5i2Uaae+goYUIKLYjfhIBD3v2ctStJXgsLPExl8qdakhF25ZlyCtG425ToG8ZMXCACLhMMIbuPSZfXX/4zIbq5nSSpj8qKwCPNfRQkaU354aYHy1vi+J541P0S6+vlwCyur9HzkGD4Vqp9zUn55e/hodfvKe8BIjm75gaKyUJ1fWoKQf5Fy3I8ilD8Y4TztyD3XRPkHz9CcxsWe5iDj2rLgdx7AP1OVUnYdnPrQUljVTnaQvyDgejLi5F1a0eb1Hlwx33RTCfMZKf5J68C/RwQmC/QA26Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHB2HdQJOu67u/apJH5yuzJQA10MBOd/sRS7xS06T9k=;
 b=pADW0f65ValCEXVRPerQpa1aY2WEZgpGnd5Saz06kOHyyqFPmt5b4kto0wVtD/uulZW3IX5HMHPviSMyr94zphRm6NNDs2LoJBu0uzkPzESbPQinzTpEfhSPokwST2s9dqs/qSa39itYmYDcmyXFIc4V5PFiMaiuK17pVGBt5dFkTb/Um8gneV+d0cyCG3++2PGvoZ81f3timvD3yRUucGpGzthA3t2f8vsvHvRrOFPtKKm6JJxX4i/o9h68plbhpvg1WjSZlAKMS2YPaKR/nnPJFpdIbbgDd8gKtLVIkcZ0ZJ9ZGC7gA1PgX98fswzCYPrP9/d4wPIpMdBJz8Ns0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHB2HdQJOu67u/apJH5yuzJQA10MBOd/sRS7xS06T9k=;
 b=C4tqemyNeSpkggdHF/PATzl8rdTQ640vX7r51U8v6vzeBi6MNjAGWkbyFhrvPUOx8tdCgg+tD5leYnyoUmOpUwkI9VM+iUDjfEQv59MJocptxpFJrCMed9prIVFnKNVEJZ444+nuwmxwuYVK9qbvW1i9XbV3Sv2U3ph9HjE/kOI=
Received: from MN2PR20CA0041.namprd20.prod.outlook.com (2603:10b6:208:235::10)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 12:39:49 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::a8) by MN2PR20CA0041.outlook.office365.com
 (2603:10b6:208:235::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:39:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:39:48 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:39:44 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 0/3] Add Reorder Completion Queue (RCQ) support
Date: Thu, 30 Apr 2026 18:09:28 +0530
Message-ID: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 70da96f3-ebce-4477-d81e-08dea6b5912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YrGVHyQ1ajTfS6HuG5jO4XK6bIaS/5IWpTNVyzZoSQwqU6UDSclMojVoWhDSir2Sjc0Bb8P7pN1AXJcRkljf/gB61Z9odE/Vv/MaTtM0E+yKz2YyGFQP8qvXtbNghl9XlcHYnwW8319S6QqBXH/T9zKWw0jDWnce36Cis7wKM7snVqm5O4nS2UbhgiXBCMZQxgUealpok9ZWG3Yums5ZcDZYcA4TDzHWdTrlrAwowMx0bdyQgB9YM4zYk4NwAQwKWPhXLD57d7JTx1mG63rTsXR1kCY4Jece6hIdIexw/HP2mqDBAv84d+K9bP/mOp1GbRwTezgt7NmvZwddG2eLexBN4CmLGpvBU/TOW7bVnYvNOnB7NFkpMAvquRK7bcB4JO4FudMM4qTac2HHNpTm6cm+TiuOhygsCKmRf+olpS+DJjUcRbTxC7a35IqA6l1nBUIIy3nRIF3N0hYtddl8gMBX1VWql8JGtCxom4JNtCeMpby3lsj7ZfBxSjzjA9wiGzHDWIP/J++/8f6H3C0MNfjfypwabs02/CZXnMMuKy/x3fvNjBsNulrZ/6UTXNI0llKhbU4mZ9rUVlT3UC1uPb0RV/BF9TIGdj/H3zxBOMUvB10EX8Hs44wYSMSExtbZKp9/gty5olCTR7//h2Llfn5SNBDwQ/QJVQA3Tm5w9DeQhKg6V0J8c6N8oYXB9E8mXP0GZp3OjMNH7aLarzQg7ij+CigdmKkfvqQfZpagmLIJHQ39dDJR9JQKakrlLfQX339wgb4MpyCSylfayZNSVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PAv5hhmM7kpDu7duxv7xOD2z/2y1V5uSsaa9OMCgymZ9Q4vUCYGi92f6eHioMwIh78yxFtjFeLXIAOd1Zy9j7QgeOZwxbnf6zBNwwt1XkBtQ5+OnR6vbKIZSgFG0nd15cGUIHA1OsjFlUQLloPkp1+gOQif+/r3BdQIrfqeLFLyUUE/ZK/rOQTgOzlapYofeHim/gIFuH8fjORe0fWGkJB9FTUT6ZudO+WGU3fWBspY1I455PrED5GXGQJZmd3IpF6tP2NCVDxODzDIcS1kmUZI39iQDmLgLvGcb7sx82i1rUUrDkR4lgyobIFJuKx6/UYB5xhIpT8PJMRg7rPT+mp3wop4uEjODRAbg6e8F1tIsnw7MXHqfVSiCDN0LfkDDOF7pItngybT9vIQiGUVB2IbiaTti9046MAcLVDb+pGOped/qB1En6ak6J3HkUp4J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:39:48.7681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70da96f3-ebce-4477-d81e-08dea6b5912c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
X-Rspamd-Queue-Id: 095D94A2D70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19782-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

This series adds support for the Reorder Completion Queue (RCQ) feature in the
ionic RDMA driver, enabling userspace to create and configure QPs.

Patch 1 extends the net/ionic firmware identity structure to expose the
default_qp_transport_mode and rcq_sign_bit fields from the RDMA LIF identity.

Patch 2 plumbs these new firmware capabilities through the RDMA driver's LIF
configuration and exposes them to userspace via the ucontext response,
so that rdma-core can discover device support at context allocation time.

Patch 3 allows userspace to select the QP transport mode during QP creation.
The transport mode maps to the corresponding firmware QP type, and the
RCQ path count is forwarded to firmware during QP modify.

Together, these patches provide the kernel-side plumbing needed for the
rdma-core ionic provider to make use of the RCQ feature on capable hardware.
PR: https://github.com/linux-rdma/rdma-core/pull/1733


Abhijit Gangurde (3):
  net: ionic: Fetch default QP transport mode and RCQ capabilities from
    firmware
  RDMA/ionic: Expose QP transport mode and RCQ sign bit to userspace
  RDMA/ionic: Support QP transport mode selection in create and modify

 .../infiniband/hw/ionic/ionic_controlpath.c   | 20 +++++++++++++------
 drivers/infiniband/hw/ionic/ionic_fw.h        | 18 ++++++++++++++---
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  2 ++
 .../net/ethernet/pensando/ionic/ionic_if.h    | 12 ++++++++++-
 include/uapi/rdma/ionic-abi.h                 |  9 +++++++--
 7 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.43.0


