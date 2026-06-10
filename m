Return-Path: <linux-rdma+bounces-22081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9LlFJGeIKWpoYwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:53:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512166B0E6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=juDw5aIb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22081-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22081-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFA7E315902A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9D449ED6;
	Wed, 10 Jun 2026 15:42:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC241931A;
	Wed, 10 Jun 2026 15:42:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106158; cv=fail; b=jsIxtZIcwyzkqDkRBG6n1Ptan54Rz3MRgzgvYmCnYDtq5RC1KKN7dtZg8lm80z4E0XrT7Rar0/EBIsaBSjjc9JTT7xAP7/6V3MIPgI2UswBn635SlbV5Uv/XIvxFs71Wo1T0AZYxQBYAuDdXwpks6cCWYg8D755T9sLQTu9yQeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106158; c=relaxed/simple;
	bh=e9Rg811XdYCuEJKKeR3ythh17kL0Vc94MNvTF7Mh1RI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hOArjckjEgn59FBn0XbZxf/yFf3d1DqHjO4SE+p5rDujkdrfsdCPSKqOYKVAeBj9/epYY6K+URHpgwbggjwAAqTkVkhWjFij97PABvRgl7h630Dlto3mCzY2NKIxmw4QNF0gcKrouB86bWB0P2o1jIu2HH6Xl4ylTQgFRzTrMVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=juDw5aIb; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7aWR5qAWqOvXp2s70oMbaSQwNjVgFlCbfpmIRgmBCO71lKp6WObTchG4nSezmHIhMIYW3TOor6fN5ABemUQlibXf+Vz52lvr51Nnh10sW59ImwpQxnO/PC7OzuQ+a2ickgRbb+Lzkng/lTzy3DJ/ow4UYqbxejLyXi0HcXWAVum58yFfBdzrGcmwdlzX+fpcgM39ui04Lwy63tdGmFPAkfQ3FsQf6agcca7GjV6jSoeA1Y1G7Cv07vRFiwiSiVZcjCFeA5hYFgVEX5w5UfgM8YmX1Qg+IHxgmGgPkCrJMwxGUAY96NqWs0BIa0iaRmAr3eckl6lscS9zU4uXJvPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cOylYC0CgNswh1EfHo6NjYFZFnniiTLsbtaYO3V7Ew=;
 b=vbjQc8LH8IRROIJEmSue0O6bxMnsgqgv3rPMdi36rN7HIbycuLRtX7T8DRoS2XVsjUdBSJhhVpwlGlZljlxmd1+kRKk7TMPG64298EImjHw57mY4Dp02EszocsHjEBA+2OVHe37VzcLTVogjDmO9LozLr/5Nnepp5Paq9XROhri9Z6s3jIOEXSG3PnCyiz2Cfx3kJZ5TqeTNmXx+mN0qNP1rKGdtk9zIN53O2MCvS514G4spGuKvZIZgJrgjbwu/OpCHWKp6cnoQa5n+BRr39vh+di7AR/LGNZOzjV5DhLA5PQB1SVcK6+aM0laoubMnY/sJipLjqlQwBZyZCB+YUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cOylYC0CgNswh1EfHo6NjYFZFnniiTLsbtaYO3V7Ew=;
 b=juDw5aIbxZ7I6qJ+V3gsA2/FX7CoakSvCL7KE5Z7MAuDt7KvcaClHkw2yXvIM5/ld1K19tz0CXe1nQwAUULNHopVzfDVf04h4F+2ldM+3sjq5PrrX3jNJu4wLZf83rTL5DIPqwfMSbe6dfI+qvqNOzqW8AoPGX5hY6GGQidjPm8=
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 10 Jun
 2026 15:42:29 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::7b) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 15:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:28 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:24 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 0/5] ionic: RDMA completion timestamping support
Date: Wed, 10 Jun 2026 21:12:11 +0530
Message-ID: <20260610154216.712374-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d29171-441f-4211-7eec-08dec706e0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YkhzeH7Xwbnb3heEijRKq6zaOf9kCcchUDjYtMOqw8sPc+R04YWQnqjYRu+iMhB2Egdr2dLfzuKW80y8CSstv47utYwsG1C3kkD3bzmLISQzjnqRtpcG6CFHBJdSJsDX89aE3qU6YzRYpc1e0vxhkMN0IldPpXYuU20yxN6yl2548QPgNmXjDmbJKJln88vZNpnWmk5z3mIYsP3jABpaWD2FWJtIFQaYVRl97VSMK7O5XgljxZynZnYuZ1V+ZrwZc+wEv0jH7ZCp1YZBPzlvaKi+yT5gjP9aZ2arWFLUhbuqUgYF6agYtbTTs5fu2orGPyWJIl62vN4D+hh9SG1hpI6hL/83kH+vErwR7G787lhWRy3d/dWA3cx/kLhgO4rPXBdKhCu8/AMWS+ewfIHX/5cQ/ILGJleK1+VhR9tptAVYacR3urcF4E7mYJ6tKyvJA19+QOPU04ALssKKnLBK6rKG/15el4WLujQOmXakserEdlKxetrkIVLN6bd3WQPvtMSblBH6jiRU5BRFBdpALB5lmB0HzOo/GQz1qX+2pZBdd0+D/qDR7DvHPVkU0AqiMMqvdlc48MGWw47rhLMkrlC9Kt8/QB83DWWMiLYWQHtJidB+GS08DTCky7Ij1MbtUsFEltTYJxtue5BUtgy8Vjs/wRICwDHe5saGG7cXu3WOc6+t71EcPe6bUArA7ss+/frxOFIo2xQuiHbONAMVTUc1Hi4lG95KNzpR7MwH6D8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(11063799006)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LUAoHx5ZSULge6pONTK0VbSUlyjFyGpSD/mlbEli4Ef9FqbVnPgu/ZSziNdMeeBze5mBe4L6nfsAWhzLS1OAQ0wYEJ5i5S7dVylshPEqbql2dAsttkPd2xGEOy2sXHs0uw5QCuH2gAeI8w5YVWe8c/NHvkeqxxK3TTjA+4K1bzA+OvZoM3WHKIl7PuUIAZA72lTx/P6CEKrl8KIilGi/h+JiamY1VRxF2LpqB4lrkDG9m9/zIVOBmp9XCAwitqYcRTVW8ay86+EiNcLu6wjPnz+9TWTVfV6Em3yiVmkMmxG9dItmXdJOFg9wRJ71KzVs6sCKyfEZOC90Wc8vr1Mb0SDY1yNSv4LHDcplJBLQv+h7Ollyg/Is1whzq/8zgKNFIUhyiZ1c3TkCYI8OLDgK1mE2HaTe2HrPYU+K4dKWS2SB+Uk3oYmXfYNkzMdWLTq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:28.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d29171-441f-4211-7eec-08dec706e0d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22081-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2512166B0E6

Hi,

This series adds RDMA completion timestamp support for ionic.

It enables PHC registration for RDMA timestamp capability, exposes a PHC
state page for safe user-space reads, maps that PHC state through RDMA
ucontext mmap, and extends the RDMA CQE format to carry completion
timestamps.

With this, user space can read completion timestamps and convert them to
wall time with low overhead.

Provider's PR: https://github.com/linux-rdma/rdma-core/pull/1724

v4:
  - Added alias mapping of mlx5_ib_clock_info to ib_uverbs_clock_info
v3:
  - Renamed ib_uverbs_phc_state to ib_uverbs_clock_info
  - Moved mlx5 to use the common clock info structure
  - Addressed review feedback from Sashiko
  - https://lore.kernel.org/linux-rdma/20260606050003.3648306-1-abhijit.gangurde@amd.com/
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
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 12 ++--
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 63 ++++++++++++++++---
 include/uapi/rdma/ib_user_verbs.h             | 33 ++++++++++
 include/uapi/rdma/ionic-abi.h                 |  1 +
 include/uapi/rdma/mlx5-abi.h                  | 15 ++---
 14 files changed, 179 insertions(+), 48 deletions(-)

-- 
2.43.0


