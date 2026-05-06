Return-Path: <linux-rdma+bounces-20045-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGIxI3nB+mnRSQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20045-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D61DE4D614B
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14EAB30160D8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E72E1F0E;
	Wed,  6 May 2026 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CDvbTnjR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A7F1DF27D;
	Wed,  6 May 2026 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041203; cv=fail; b=rfWq5Eagwb1d9rZkPciOvvWd5Gfp8HqqABRZ38punnzz8gnpjhzyI/iTmW7cUqmr/WHWT95dZVzc1mZUp3EFN3ROnBhVIBxebX4PEB3MuzL1RedQZ8YL27NbM0oytzVS9vl7hnIhOaylvRaDE2VLg1iVoOcHDULRTGZOPTDqslU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041203; c=relaxed/simple;
	bh=hzb6620TgDtBq09MHZTOjKjfhQyL0HChjIeyMTWa9p8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMFq7AL2pqxZZOGFBwUDMKBtDJN1YJskjZrPICz6ciHhraM5CCK2oOfUfNzqU8X7xpuqNvAwCFTttWmAeft7+UAXlSsBL4yXNAEjs2cqig94vOg1TaRjPPDkhvbKX2h+31hQdSFGPDQzVQCOoJSq7sYUf0dxygd/ehHm1ot9/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CDvbTnjR; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qigBfkEkqApJbpExiuWt+oMJujspaKU3SKS31PSKP0OnDClZtOyvxaEFEO9Gc/LAGMMqj6ukUBLRCy5O0moh2QwqBjGuiWmADjjZZ6EKLWgJOCX4eeyRO4d2F9/UNCGVUnTEU0I39zdfUkgITaOqSdbv8cBwNnq1frQE3GZmWf55CoIND/RadguCM2CfI2D5GGHbcD0wcVsZ+z0sCceI7mX7fEum1vKVuCtUt9tl/SNE8OfTVjrKBTAPMoKXpDZZMN8Z1kZDFpKd+6k/IxiOevOclrGU+Bb/5SVoCb+xVtzBdgDxKIyKOefQIRiKYsVfM8JA81/gEiIZ4m/ufSfn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeCmxfBF8d2VqNFmiF5C+BMfI9wyBB0z3m2/ZaNjUZ8=;
 b=PvBwM9OcoYeaO8Q9Wysi780GgaF3Y8snZrXdTQdaKsCgQTo3t+2K7Iqy2bcZ7OX6om1bAv6J19a4v7mqRrFbZAcz/e+dKHjOzE9eewNw2MCpwaCx11XF8SRPZpkpC4ZLsS0gw7EptPjrw0qfqbbUgXyXHosk4YcCECA3/zDFLDBy5HHb6dvTEA4rBZSkVYLQpwn+Ok4sDjT4Hf2kqdVZRcSDts9/+Q7iVWM0i1+6UvFq0qgN2YkEDlJi4wwZ5Vnde1WPZxQfoNDCHr3KuEmlb/cNqIa0oPFaiR8wpwr852c3bnTVs3aAx0+d+uJLuILCWFHFZ9w3GlkUCARL+GoTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeCmxfBF8d2VqNFmiF5C+BMfI9wyBB0z3m2/ZaNjUZ8=;
 b=CDvbTnjRjjlKZCPKH+j9WlE7eMGmys76yhLjWPXDsTs/GXIcUyVbps2ZejpAYnyChOiDGbbnsFJs3SgUTPBqP0osVNX9YBdgXxdi9g+M+sCcyJXvvhiR0EmC6PnoGTQbvCzIUSrIvjCEpzPWPqcEwm2UpDjFcOiqsKN6b54QMx4=
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 04:19:53 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::b4) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 04:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:19:53 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:19:51 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe
	<allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 0/4] RDMA/net/ionic: Misc updates
Date: Tue, 5 May 2026 21:19:31 -0700
Message-ID: <20260506041935.1061-1-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: b438ffaa-a8b7-447b-966f-08deab26b903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iISPwWIpudCFNE7miUhhb8pnQc/9VFOfFRg94HAFA6uPfCSuyLv8sKagF1zCXPnBNIWkGwdD93Al4iRRaWZ60M+/sNYjnzjA9PWrGnmmj30fhl/aUDZr1CASc3L1MA2Gj33bifiz8zcS+dlOU63VJ61rQfl7EBUZ9xPyQvCPfauhBtO6XlLMCk2UVRLlaJoYKS8i55D6o9IU4gK927c9s89aYzlE+bw1aaGgbUPNvfHErDirmEPTzP8c1RMBmfsiiFv+74a2vXRoh0qhjk5KHZbuAKrdPTorcBmr1pOAj2XRrFq29CzNsSMsA5ZMKPDnU5gGy0CVYQEMqmO/RVpnVJElwE4FGPlfcQ1oks8ydnUlfarL/Zw8SKyHzTby5WTySBEnxU0wdN4ZRTND3a0/tYuN/8WPTB93TDVd5alg2mRfbOAAhOxnDETp11SWh4VJNP3PPONayOxstIflRdVYfN6RtGB1Wgsyt3prD+rqdv4Q7RHDlfXLeg9Y44fDGOx5EU2buxta8hbkxR1kRuTziP75dX4H3RhDkrIeKVpVoo6CYbYCib8oc9UooAvQyI8hE/COreE4xOZQmli+rr8KHJRWBl8B82lBlyMP6Dq73hhA2+eHA+NRqTL6zWJlCfm9AkwfPJtWmGvxbSIPGrMghsB0fSTY1AjkACa1Vjy8Y+p10dBCloNikxbZXmzdUezANlJFXdEjAN5nHMx48qx3Gzhr03k6WG/BtiQntKRY4ZM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B46txsiXwF0eLB5X81ib7LVFNlIVFAnbLMPEwRiomrmN1uQEcEqHELT29VWpKAU3u+XMN2zbJSNIr1/95YjXdh1UqXGrzVvYKKCNC3FSiv5tOxhZRwvdxx5LFX/qVw1ckt9FJAyBp1W5pu4aQ+5o/n9Q1p0LUsdL1tsXb+6U7/u1sHqpNOSSLhFl2rEnPre49rBq2oWhX2cjQ0RFVAIjPHXkQ3v7O3btrCSEIbXcSMzYICWCi9JUZBGCcmC9jTpwuP+qG+xJ8hTlm/W9xu6d9LIha7k0RFRA9TE93fu6BETkWevU7ulMDBr4Bb6IA9sbaB8KWI/rdRFWW1KidwFa5sZqygN8fH1M5NLOM7p4U6k9K4K47kO/pAa9EnzvO+HGGXllLyXS4XJWBCIKLkLtjMieasGcHY0NtykEJVR7Bv5TDooz26v5ioBJ6VELBMeq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:19:53.3436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b438ffaa-a8b7-447b-966f-08deab26b903
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Rspamd-Queue-Id: D61DE4D614B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20045-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

The big addition in this set is a dedicated debugfs directory under the
main ionic driver's debugfs tree for RDMA-related entries and querying
queue information; a separate patch on top of that adds the ability to
configure DCQCN parameters using debugfs when the firmware is in a mode
that allows it.

Other smaller additions add a devlink parameter to the ionic ethernet
driver for enabling and disabling RDMA, as well as updating the
copyright years for the ionic RDMA driver all in one go.

Abhijit Gangurde (1):
  net/ionic: Add devlink parameter for RDMA

Allen Hubbe (2):
  RDMA/ionic: Add debugfs support
  RDMA/ionic: Add DCQCN parameter configuration via debugfs

Eric Joyner (1):
  RDMA/ionic: Update copyright year to 2026

 drivers/infiniband/hw/ionic/Kconfig           |   2 +-
 drivers/infiniband/hw/ionic/Makefile          |   3 +-
 drivers/infiniband/hw/ionic/ionic_admin.c     |   6 +-
 .../infiniband/hw/ionic/ionic_controlpath.c   |  21 +-
 drivers/infiniband/hw/ionic/ionic_datapath.c  |   2 +-
 drivers/infiniband/hw/ionic/ionic_dcqcn.c     | 629 +++++++++++++++
 drivers/infiniband/hw/ionic/ionic_debugfs.c   | 750 ++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        |  33 +-
 drivers/infiniband/hw/ionic/ionic_hw_stats.c  |   2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |   9 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  43 +-
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |   6 +-
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   6 +-
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |   2 +-
 drivers/infiniband/hw/ionic/ionic_profiles.h  |  86 ++
 drivers/infiniband/hw/ionic/ionic_queue.c     |   2 +-
 drivers/infiniband/hw/ionic/ionic_queue.h     |   2 +-
 drivers/infiniband/hw/ionic/ionic_res.h       |   2 +-
 .../net/ethernet/pensando/ionic/ionic_aux.c   |   3 +-
 .../ethernet/pensando/ionic/ionic_devlink.c   |  75 ++
 20 files changed, 1668 insertions(+), 16 deletions(-)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_dcqcn.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_debugfs.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_profiles.h


base-commit: 8c699be3dad7bba87cdda485dc099226cfc2f706
-- 
2.17.1


