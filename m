Return-Path: <linux-rdma+bounces-22312-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +JYONIKhMmr62wUAu9opvQ
	(envelope-from <linux-rdma+bounces-22312-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:30:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B86AD69A1F5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=RzXxlb1g;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22312-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22312-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63114301A15D
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF7401A02;
	Wed, 17 Jun 2026 13:26:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41D39A07E;
	Wed, 17 Jun 2026 13:26:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702778; cv=fail; b=uoLP5y98hJ4btLd9IbZzPB4EJZfQ9Qt8W5BT/Kd1VOYHSd97fYFcRW17dExDnJWAbdox/39jCvlZuQn1s8H7T8fCvXlXiDoCUWwRAd4s9/gOX2JQxsoGo0geCR2gOJkyuX0fQjkr6GXe3kmBQ8giwxqBtEeGM3YLIILMSMpnAc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702778; c=relaxed/simple;
	bh=SmoAlmJZFPetgSTXGfQFqcG0xAtxvYtoEvjYAURlxCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7ebYGayx34P6htYj9sjzDcTOq/jq24tFhX7IT0enfPdL/+pgwymtf6wglN4aEQUcqROrbELMiM7jY3iFXj3qAFyCKafo7gD/E+t+tj2UN/i18S405YtSsGcJ7ZBpW7Pbhawxs4NyFbmmgPpLLH5pAri7iUCEdduij83AtoIYqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzXxlb1g; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3vvwkilsEW6KbHvk1TbIIPPNXeD4tTiY/YaYOPgA8rVsHoep2oFynx56nlkVOe0CaMaSjsVs1xvXtXW5ctRY4Q8TYkqKnPH+FGOexxrOhdp0attM1MljE68NKmYX6khfxFNBD0Kpvlg1L80zx06sFHXkQOq/cgMXr/RwQBXZ2LJ/atYmG5LSEmaoKyD1cWBN6c+E2E0a0YqHtRqWo2/xE6XsrvPUBxNY6efHUPaiqg9rKQ+gRuVHo5gbKpLI6x1H4RDZp2tUXF3a8rafpECSvt5wXhev0rRDM5JJQNzAZ/SleBBBEMaph3yC9B0Lw4zaAg1BR4X8frXJpAcYR+Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6GfnZmwxSxXlQPKeVdVHk1bLS4Un5iLx//Rnh+JDQc=;
 b=C9RWESmvRRsc6kzj5BFwAkQzzpVYTO6Zb5dLfazurRMBlZQ/4hqW5IRQwBFf0NyyaotB8cF0SQamtPhD/dEBZsQEkAPyGgzu1ask2CsA2vTe8U6yiig9+Pe6z/f7+hRZTaeMGF+kCxSUlqdHpcLiPzwL4i9Gg3qxMnUjFPMmJDCtEB6INVdYiWDRhg4rMu5OWMvVninf4DEdGrHsK1Q/T+cHWHOTNCf1YDgFd57N6L5ViHVY59YlKsbQiQR0WOP1yc92v/lwdkHjgLqzBbISQKsM9KbT+hu1qTYz4L81iCz659mmdg2me2Lza1KyKminr6Mps29DAfXk1fuSSzNcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6GfnZmwxSxXlQPKeVdVHk1bLS4Un5iLx//Rnh+JDQc=;
 b=RzXxlb1gG046bSDpJLVgSoaLdkkiiONmENrYzDnJVp1vxgC4oWkmMyt8MeK4Xf5P69Ze02bliuf3OIOmYCRUZiy8Sh/iIqehdkias4hxZCb03R4bl3nfcVO4H+muh4l+FV8IM3qsJg6U2hosGZ+MLzk9J6tbPb3G0EzkOdFjg5A=
Received: from SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::15)
 by DSSPR12MB999238.namprd12.prod.outlook.com (2603:10b6:8:374::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Wed, 17 Jun
 2026 13:26:13 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::33) by SA9P221CA0010.outlook.office365.com
 (2603:10b6:806:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Wed,
 17 Jun 2026 13:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 13:26:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 08:26:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 08:26:12 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 08:26:09 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 0/3] Add Reorder Completion Queue (RCQ) support
Date: Wed, 17 Jun 2026 18:56:02 +0530
Message-ID: <20260617132605.1888205-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DSSPR12MB999238:EE_
X-MS-Office365-Filtering-Correlation-Id: 43409123-b18b-435b-0cb3-08decc7400bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|13003099007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ccK/T7hLOdgydi9pyb0DjRtB0qtZumAN+IPlocsT2FFdw0C4nWEZgfqsnolphGdFm+WPS1KNNJx+LyLGSe+l4Xn6w9YQbqrzHqIJPose6L5uErHzYXewpgLR20Xzi/VzujYdf48/sei7is+7HWCvyaO8SEy1GeRe3b+UCI98hAxWaefJUyjv9kTyif3gwD2J3oUDp8Vmj4OECO8e/SQQy6gXDGj/XxbqmOF9T2ZhapV02+C+2NIvIDt53HIuZd42m5f+euzOuPKTPuLP4Hw8lz3jFWLwwWHo+brfMBzVellNPBbYYbx3WeUARH+O1+DYUfFu+wcKAERsc6UrPB7NQH1K6UWbQvc6c1YBg6lkCvYIslmOl1u3OSepXXqfF44jbAQURrxbCIGhE9BDvaSH3o70Zih/CgHg3iOQIjNV20aWC6ruAOyqKXATctmusgN9iWOguSRfiKV4J4untjGded1atQ6d+77fccbrAKsOAu3TMkUDW9yRBUG68zsnbNks1n6rX5veTBE5rlQQE/gKXn3qnQyvRwT7D7eJHilzEqEsPhCfszcKHoehq9nU99GbwdHVlH+xFyw8mkxvWjIQjpDsSKRiyOGaLfNCbK72Sy5bzNJ10yEl1ziM5/j484vLRuSdOpkrig82TgQ+Dy9Y5yFP/Om6iSdLSNhXYPd62ayg0vVrH1EKVX7pc9kgBxQEOepWTr2c/PFrmce7SwWk7mXmL6nomwyr9kpDK/aI0OA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(13003099007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F/RjYMjcusr2Uj6o0XkPPv0fd3jMHlNZMcxopRysOAORH929e5g5It0aq4UDTVdiMvpfHV3HED6SnbSLiv8Xi/nwajXgSwWFq44YayjJknVWrX41kg1aGrigbuI9PJhD4m+ldo3iEDSVXMDfe4BDTiu3wr4uAKFO4mK+GAWGyfWwld19ilI4sbc9/nRWTdw4rOqlxIBpXbEsp9GB0fjsObVWgbfMroXFCNlzG1DejKodJdf2ndfHcQiVA4/grPDcefM9VCNU6IDNOO1ylatIzQoHXPJq3OHHGiKXX+Ypw8pFnDtmTX0Df1j1rzIS/FmN65LSYXtb/1saUR7Pxc0BosDWtZ8xLVPec1ice7IGPF4LMtPjBy5/755bpriZ4BnOCBnmFCmJPGVrGaox5s52Bf8X+GISBKp94b8Kjz04gE8jbKfmGGwWPQCy+IaEIDUL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:26:13.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43409123-b18b-435b-0cb3-08decc7400bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999238
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22312-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B86AD69A1F5

This series adds userspace support for the Reorder Completion Queue (RCQ)
feature in the ionic RDMA driver.

Patch 1 extends the net/ionic firmware identity structure to expose the
rcq_sign_bit field from the RDMA LIF identity.

Patch 2 adds robust udata support to extend the qp creation udata
request

Patch 3 plumbs the RCQ sign bit through the RDMA driver's LIF configuration,
exposes it to userspace via the ucontext response, and allows userspace to
specify ionic specific QP flags during QP creation. This enables rdma-core to
discover RCQ capability at context allocation time and configure QPs with
RCQ support.

PR: https://github.com/linux-rdma/rdma-core/pull/1733

v3:
  - Added robust udata compatibility checks
v2:
  - Dropped QP transport mode selection
  - https://lore.kernel.org/linux-rdma/20260611092544.783731-1-abhijit.gangurde@amd.com/
v1:
  - https://lore.kernel.org/linux-rdma/20260430123931.3256130-1-abhijit.gangurde@amd.com/

Abhijit Gangurde (3):
  net: ionic: Fetch RCQ sign bit from firmware
  RDMA/ionic: Add robust udata compatibility checks to all uapi verbs
  RDMA/ionic: Add RCQ userspace support

 .../infiniband/hw/ionic/ionic_controlpath.c   | 72 ++++++++++++++++---
 drivers/infiniband/hw/ionic/ionic_fw.h        |  2 +
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_if.h    |  6 +-
 include/uapi/rdma/ionic-abi.h                 |  4 +-
 7 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.43.0


