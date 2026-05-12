Return-Path: <linux-rdma+bounces-20469-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFDhLdvzAmrpywEAu9opvQ
	(envelope-from <linux-rdma+bounces-20469-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:33:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FB51DCCC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5554A301CA74
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42558379C43;
	Tue, 12 May 2026 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2BdmqjpO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5926E6F3;
	Tue, 12 May 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578007; cv=fail; b=TDyhS04CYTQ70Av+bdAzbx3+eVtgVAzo1XcqeFJsxLp/M8zQrUMhh6AL0ZSpV/CzjTt6k7X9KjmsBSbU8RMz7lTiZpfHSclMRL7PkMMq4YLRYsRBODpFivmpy7Ctz78BCguRHbfgTnwzS1eKnb62TNVWTeoIvaLkJb2Z5kScwAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578007; c=relaxed/simple;
	bh=7L6mzvpZRJe//roJg6Ee6lsC5xYCvK/oVdZdEW3EQug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdF685+xjaEl+/5m3TU/R88YTrVJkQmlFnJ94m/oKLpLqmIzj4ebzURDWEakZnxIBcALEesdJyzJl4qJDt+Rit12pujkZ+hAhioPNn6HRrlY9uTycMpF0GLnAwyOiHHnwq72c7Zkq6axjOSxvq2wup2zDSBdTtMeilqciS9ggOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2BdmqjpO; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjNxXO720eUPSmadBc0p+nmVXqJ0He52YsgV1kDzbxrIIz8048r10UYrcdbduVr4SFVIIIyQCYH6efMfHTnQKaDaFR7R2QHF/F4YrHEWwrXf7HDUJ0AYNBGrJpkDPZcFfTuA/epEab8kwTMUwiPhUhRktEz+1Do+yIY1gezr8RiUKU70TCHv8HRLkF9HT/URyjwgHJ2Fsvbl4AM7T1WdIA8oRogg5LkO4FSSnQ+oeHqUe69tIBc0kOfIMMnkmB4sfal8hXcUGW3eBdyTxbYUcXx8Ho/SpK1h5fN4T5WCWDqIYGWs/L65wPskMVvHfAgh2fY8HaBAXJpkZp+1dIeYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASmvjCFwBmAwS/RXVgANqt8duyaIL0LM24e6Lfl6Ghs=;
 b=iNdQK81dhR1pbePcTttH0rR7g/2U3cbSRUv2e0DoG1FAmRVKkqQdff61uLlD5M0YWfcrkXuWODZ5+U02D9SSMroHAKVx6b+cMnTHlp/0ShKNQ8AWK5hbajx3ZxfmrI9b8RmVUDgiVZuGXU6/j9WQ7UVvSQYaD+uY+3V+FqUWheTPq9sma/GBADJdIp89N/dJu4+qtJ4ahzkxY9rI0gyCCl+rHaXgXy20MAl4C7vtDQV6VjLzbOi/y88qa01gSErXcgqYzemUp5oeoyyTRD42cGKwQ/vfrszeLMRP6vIb2AS08uWtgWZb7CnI5TBS5blsLdnuJxiZW/qTnW3mi+jjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASmvjCFwBmAwS/RXVgANqt8duyaIL0LM24e6Lfl6Ghs=;
 b=2BdmqjpOVmgkkcG+6wEGyZ31ohe4mB5VAK7MshmAvE/J2/9UW6iMzCejVxfBwhQVGv2otmbm8szUh6EydU3iKVE5u4CGonnENtl6xLPoDcxNI27e5cCZYX4VaFVaUuxAy6AA5rkrnp52jYP+KvLpdTo2ZHnxNcQXmiifkRtRbcU=
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:26:40 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::2e) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 09:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:26:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 04:26:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 04:26:38 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 04:26:35 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 0/4] ionic: RDMA completion timestamping support
Date: Tue, 12 May 2026 14:56:19 +0530
Message-ID: <20260512092623.1157199-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bde5615-ba81-4762-1c58-08deb0089274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|11063799003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Z72TcN6nRbkREkPIm4XOO8LztbHxb7RVbcudJ5VK/cI1u8tidxFUOW6P7RT0Qumzd804GwOeXp44kfUbCREcCiir/aKkF4KeqBOlMmkXPoGJv3u/zWUSKJgb2Ak16MVlLMk2Peq0dP5pe8DK6C+SWBWUDaqMV3w6EkpPK+M9VziaQvGRD5cT7zf25HmpeV8o4GMIRSbmF2pipQ153a4L0EFYoZ/gWktoJAZIcd8s51yGtV97TU+lnNlGsTnmHog4+5NzvQf6dnp7ZYeYFyIlsslSh8MJTUR6m6CQS4bBnee0dgfWz48+EsF2JH2JgNgbwVhEUOX96UoqyPs69T8myQgHUhr7cUs6cql0BhX4hCl7AxIQwCRINaUTWFNi3RjA1exL59qUI99WCGXUsiY+oIUpz+q8mohsFJPOGNuHSvXLyiDHeFvN2fS3+eF2aWMvSsu7b2zUVzyR3XFc62T/PDI4E6ks/KNdWCKJxFzlBkUuqaRv4bzCnKAL2TRGWEghxj4mNzpMFoGcLWQZIT6bu1aYjwa2t7K6shudYBJIyWjFTN6V/Oim9OTB+LAsgUfpsYx2CubSAa9CrDPcrc8wSzguZcatIgjxh9cUcv6RmY5Gj/0caLHljMLUOwcIHMTOtTyiNuz/nogv4c73ZLoeV/om+BpWNyMzY4cFIYtyWM9PQP7JNOOen/rL6yN89pT2y47o628/aojpuMa4RqAz2TocvwvRINgiWZD4fgwc8lk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(11063799003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mh//EF7pLsR27Ht8CZ5Gq4JlyiZ25O3vAuBlH5Kxzq7sO7Yinmy5FocWokPT4tzPgdI6jgAQajiIJlU6gngPwCoA8b8wRh11sMcWA4W60fLo0Lp4tcYlJ+FQ9jURr4InTswR57KcUdndfEy8s3XxtKVSAvLKFGJHqLcdBvBCp8afYFFtdM0KmViCWa7+25JVd/OBNOD2dD4TG9cY2vQ4eGgBeRxZnidXi2wKAqTExRqj78gzfOx9N/SbFPc6DfoJxspP6LcgIF3DUgcoV/iP8InvVu2uZwqhEcypWi3BEgjDBxhEEVgIRW2icBjir+U4rSY7UoJo5lPvmshO6ujfXiI4EgqX80JThsj6ZdwAqW2Fe9AE1L3GXBj55EjDJVCOgZ+VXBa3lGszp9Jy93CfqMJaPBkaFnD1WTizwRIFTumIvWPxBmlPvrWgMiJWqs/S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:26:39.5616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde5615-ba81-4762-1c58-08deb0089274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Rspamd-Queue-Id: 638FB51DCCC
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
	TAGGED_FROM(0.00)[bounces-20469-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series adds RDMA completion timestamp support for ionic.

It enables PHC registration for RDMA timestamp capability, exposes a PHC
state page for safe user-space reads, maps that PHC state through RDMA
ucontext mmap, and extends the RDMA CQE format to carry completion
timestamps.

With this, user space can read completion timestamps and convert them to
wall time with low overhead.

Patches:
    net: ionic: register PHC for rdma timestamping
    net: ionic: Add PHC state page for user space access
    RDMA/ionic: map PHC state into user space
    RDMA/ionic: add completion timestamp to CQE format

Provider's PR: https://github.com/linux-rdma/rdma-core/pull/1724

v2:
  - changed ionic_phc_state to ib_uverbs_phc_state and moved it under
    ib_user_verbs.h
v1: https://lore.kernel.org/all/20260401102501.3395305-1-abhijit.gangurde@amd.com/

Abhijit Gangurde (4):
  net: ionic: register PHC for rdma timestamping
  net: ionic: Add PHC state page for user space access
  RDMA/ionic: map PHC state into user space
  RDMA/ionic: add completion timestamp to CQE format

 .../infiniband/hw/ionic/ionic_controlpath.c   | 36 ++++++++++-
 drivers/infiniband/hw/ionic/ionic_datapath.c  | 43 ++++++-------
 drivers/infiniband/hw/ionic/ionic_fw.h        | 12 +++-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 62 ++++++++++++++++---
 include/uapi/rdma/ib_user_verbs.h             | 33 ++++++++++
 include/uapi/rdma/ionic-abi.h                 |  1 +
 12 files changed, 167 insertions(+), 34 deletions(-)

-- 
2.43.0


