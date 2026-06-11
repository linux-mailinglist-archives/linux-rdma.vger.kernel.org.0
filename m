Return-Path: <linux-rdma+bounces-22099-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+2ZMyl/KmrjrAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22099-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:26:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D9E67062D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:26:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="rNBprQ/D";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22099-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22099-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6B32300B9E0
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E833921CE;
	Thu, 11 Jun 2026 09:25:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8524336D;
	Thu, 11 Jun 2026 09:25:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169956; cv=fail; b=ezrFhMiThorLGUj2KEF6JPTYZhS+9/ctXwIRzV6L7MhuiPhqirVvLYdsSxT//JzjfnwipIc9CgO3XqaGRgRUO4bVMbAtY+x0n/vwynkfcyPW4Yb+RKDn+LKxFlNw+gic2gLzSl8FdZ1MZ3CC8gW94owe6ZwGlcsUOJWmKKfwCmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169956; c=relaxed/simple;
	bh=A9+IDDXC0avNwGEk4fSjMTvZy/kmaQi6enmGTfmGOng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vE8+3ulUwXDNuMCs+qBF6bZAv5AFraHKPk09OkeMA7p/LvB+NsvsrWjRp/fitEf1/9gOS36svNkIsRlPdPQ+Hq9lA35c/x/GfGgDk9JukiXj8SdxUsybjPlvl0MMAM/k6MiIJQApmLsQ1iCNQ9rrkLRClWmhYirGZiVNCWBPT48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rNBprQ/D; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6noanDlLdlVpFDKLs9HA9TurE8q2VvOC6pcCxHeOPypABP8xb7kD15KtdpclPSXBDP42+w5GlkRQ7mq17yhA6533fJO2dOmHcCsI/UsGhu70J7wr2iaY3wrxiEKRb2CRaKD3POkQALIh9sySfHm63NUBizWLccnZP8pOsipCH5nlVkSrIoxolJ83xklXdBSVB5KdDj+sfAo6HLPULCu7TF4pIZp1ZhMt8WJgAuhbhVkA+uRF8c4l8X0lJin4KM0qcNI9rjP2lKx+ezOyOjAzIh7jc9+xIEFVBbuJENr3wlEHKgJddyMaQixxbsZb+oOm+bObb6p1gwoX4ZwCcUZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmPkGwr+neyVvRqZTycAEi9GyPNSvgCuNUXEkMFb8bY=;
 b=QsouidIlBkVwC6PBSrs9Ee0gtO4ce2L8A+EAj6nSgQ0ZdrwwhWujKlP+Nmw2rzIZ+xJEwBc2V6cIV0KCggYovaMFdpVwxvORRch6uYhnL5REMaJ3DlKPewntWrHKF/EOTbQn662D+jXYXiMMv5dUyY9oL7c9DvcB+IBvsc0rEf0TIH+u9b7B5V7WG/2mFYpdxmXxd5d6Rx0xhPSGpph8T120EdBVmVidOHtH+Igqs/BmT3KbjllwFniz1V0tX1abZWHSD3++0ykHY8IhbbTLZNSnsHxYQbrwet6FR2nUk7h+I7NAKjX9L9Qj468bmCdG1Nn0/3P1RPwBia+C6AmD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmPkGwr+neyVvRqZTycAEi9GyPNSvgCuNUXEkMFb8bY=;
 b=rNBprQ/D99sDzEJN5cWjST8f/qihDMMUXQAXsYhB8Q4eWDRM5XrXcDlhzKqZyUe6/ihxr1ZAhzO/vyuIuE5x/XgwHyQ40cGA2iTr9P8kfuCSYShvr2dkIbz4EhcuuKDD+yxyJDGvYJvvzZG0MpyA2N9LW+am1oBL94IEe6iSIug=
Received: from CH2PR14CA0004.namprd14.prod.outlook.com (2603:10b6:610:60::14)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:25:52 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::4a) by CH2PR14CA0004.outlook.office365.com
 (2603:10b6:610:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 09:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:25:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 04:25:51 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 04:25:47 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 0/2] Add Reorder Completion Queue (RCQ) support
Date: Thu, 11 Jun 2026 14:55:41 +0530
Message-ID: <20260611092544.783731-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 67be36d6-d539-4a0d-f2e9-08dec79b6e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	S1Cvrr+ezLnos+1eAvU6FkSQ18u/0v53VO2urROHk8DDBfO7seKgNf9r1lJPNcrThIViVF+CismoOgCoPDE7EV0QS1nMkwyy7a8ydVpzBZy1XbM3qTTuXj4WJBPcgTrR7ghtYR0KYVhtyv5XHPjpcLxWDkJesE4E3DCH4eAfKOSr7eYFDjM9qPdHjghQipWFf1yBToBy/T0SjHdk9fuOlvD0lCA6oW8S7BFBSVGLWGYkxIUOYzsfbDZRZOh6jOdFyLCZaHqE5j8eXcjpUWksVLcKZEgctFhQrpOx0yFstnAphipEKvXwuhffjcEm/8i1/383Bar/jxoADxhIcyv77j8fpBfUSKYzJjYMN+np0RC5gypPc7U87X3ZHmIDPTS4hxcTFHaWezjRqSiAyqhO/69QiJgbW/DC+VSID1TrFc/SK+ebm9mq56qt8ExZS7TsMmbWpJgmE26NZQRVXuoaQJIrZ/VMEBDKveRbH3a/vKvV3rXoROVqoBZ0vRSnwhxI7BQiJt4m13vx4HA2h6qYkFNkIjDjQctP23gl0ZB86czHGrfeaH3HFdw2625/FCxn8WivXhFQauGO3NU6glTix0wOWyPIHi99ajiu6S5E5JlDRJ4YbyKgKZBo/yQ71DtJy1ownJG6Zv0EfMQtgNkNCPI9sZdC6owVnsQNgLIgAmjXmO/k1BhuRUs8qORXhNMgXEF4/+au2Pi1VoEw0jRbNsk4VSTFq/Phq8fWMaAtOfc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H3duD4VNnQHDGyWGyDydDr7i8w+GvMB1ztxLCeDPMxN1Pg6NinZfMJKMgMML6IRl8ukFr5IOS5QGSZ4l70mJgBr05esPV2ciFcFT5/1A9vibRsno7RaeyQ51daOjchnibg+uA3sR+dhx/JcbLbnNsX7XL1D06VSBuqTUW0N8QAocbyyzwXNev7Um/csZ6BNAvJRldAorFm3OyYzs9iE0Y7HLp1i2MnY4phgpOW5RtT8LbHO6/diJHp0gfOI+6g3PsWzidg8jNvZBydeSEL7H7QTAAT9CWX3wrYy6glzHe6mAfuvCeJrA7pJ4cTSBJ6l/1jTmKGXU6oD/c8fXrMyJJmB032H7Pn9TwNJDhkqrCpM0oXqN+tfUz9XEX160ujPvtBjJhJ89K6RtZyt07JIyv2izMrysZrazHzLIDmrAT5mXdrNAsU/1Zg5kbloW75/s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:25:52.0108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be36d6-d539-4a0d-f2e9-08dec79b6e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22099-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71D9E67062D

This series adds userspace support for the Reorder Completion Queue (RCQ)
feature in the ionic RDMA driver.

Patch 1 extends the net/ionic firmware identity structure to expose the
rcq_sign_bit field from the RDMA LIF identity.

Patch 2 plumbs the RCQ sign bit through the RDMA driver's LIF configuration,
exposes it to userspace via the ucontext response, and allows userspace to
specify ionic specific QP flags during QP creation. This enables rdma-core to
discover RCQ capability at context allocation time and configure QPs with
RCQ support.

PR: https://github.com/linux-rdma/rdma-core/pull/1733

v2:
  - Dropped QP transport mode selection
v1:
  - https://lore.kernel.org/linux-rdma/20260430123931.3256130-1-abhijit.gangurde@amd.com/

Abhijit Gangurde (2):
  net: ionic: Fetch RCQ sign bit from firmware
  RDMA/ionic: Add RCQ userspace support

 drivers/infiniband/hw/ionic/ionic_controlpath.c | 11 +++++++----
 drivers/infiniband/hw/ionic/ionic_fw.h          |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c     |  1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h     |  1 +
 drivers/net/ethernet/pensando/ionic/ionic_if.h  |  6 +++++-
 include/uapi/rdma/ionic-abi.h                   |  4 +++-
 6 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.43.0


