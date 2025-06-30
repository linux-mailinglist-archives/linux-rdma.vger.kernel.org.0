Return-Path: <linux-rdma+bounces-11773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956FAEE635
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89705177371
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3ED2E7171;
	Mon, 30 Jun 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="I5AcdGFD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50742E54C2
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306297; cv=fail; b=IPOpTCJRlLRwrywwm6tHClcvvjQ+Nfmch8HM9Im0WaZYMzt/Jex1E7xsRuSGRdQ7M+dkPS4WuprRXcJPBZ2NKWLzSKvtvN5+tucrQtib4ptcYQSSB5Ys8qJMTqxQ/tDj84zmj8SYtko5ygIwGDyN41WsVCHyxYmgQYNNExbS9U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306297; c=relaxed/simple;
	bh=vQqohyFqgDKk9/0CjLcKHh6rd3/3xPzA14hZMT0skck=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUb3utWqpwce3PE6RpbEgOJrmPrEo9MP+5QveeYy1aIPlO5zywZJ3eCSg370KqGTWBriGCnu1hMS3yVrIaGbB9Dl9pQGi+fW4LfTYlsK17o+oYEw94C8FgJmgeZTirP/Pz8AA6Hvm2SRpGCduxvRXyVgMmh1ecxbOstgvRstsa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=I5AcdGFD; arc=fail smtp.client-ip=40.107.93.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQLMFCnhYUN1zSbJA5q2l7FX6DUyTzKw9ewB4+WRYcl41bqf03U7si07MwxaVYk8ta62y+MVC94RzJkXWPYFh01/QOWTNATNeQOc+anWs2oyI+ygpPp8JKrXiL2akoRIGnN5myalL1F32zAD0an/8kyrOSDvvv0KSgKPqkzmFwbWyIgjPzVSPAq9K/wcI6siOlzsVWVGiKiLvcdFQOQJ2/okZk+RbGDtg8uxXZSKJq61EIhvW5rchw3reVSE2tURdcnP2/hHurY+napwd3ZXzXs97KAMjckilITIL0Eyu/V2DYwBspdYBJaJ695QK4xIMHITbAuF56fO81eTA+Salg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYlnqwiOwHf5LPk2sI0raYeA80eRv1CTcIhU+kv3WHA=;
 b=JyMaBqeHFOy3lDyGx3O2+H2ZZKCteCtTxmlFqF3AUWZ2RIRAyWqfEiRNiY7s2frao56iTDO3YnB6uHe3XzmCKGZuVXhpRkrGCmpKIFKtn+DjYH5JuGLh8s9eQAc3TMM4sVhGuAQlqSOxTiEuqMCUdauuaEZ+Vre7uQJnZ4A2cx0IjdKedjqMQYtOGWOzqinWO7dHXtKAJlElpNVu6tcjZkpNXAdYCY5WQnDeTfWn46gQFO0TkB2nnqUTq7xOtyyp6V1YF9QLzD3V0Y6EFDHkoUcRXRryX7Rat02rWELwlyE/R9iK8QComuV9Gegl+LCPdbBuoES0k+WxKjvvnTO6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYlnqwiOwHf5LPk2sI0raYeA80eRv1CTcIhU+kv3WHA=;
 b=I5AcdGFDHzEKl7i92G1V2VN+UEnYvSjbBiCnnZKHWyF1MMcYji7sZlmS5hq7ZAUFwGkk9AmFx490mCxs1U92wY8dlr6vZBhtPhQfShZ9UIMomotiI2IH4y3qLmrcFnfBBhTabGNhF4RWxUGnIAFlH9ocQXELFA2h0jp+M+k7YKKb0xHbR0B3inrUWOepRuydZwhxin3W3p6cE0RZB15n9eVhJEn9hZZopUuAwB21czKAyU6EkdJcXLHzZSWHTlC4M/6UALwKFjtupae8OMC7qDwrNYc4IuD0s6cH5FoWr0DnGnSKAYPq0f361J1C3Id7VIRcWduC7xYft9eAsHhZ3g==
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by DS2PR01MB9278.prod.exchangelabs.com (2603:10b6:8:27d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 17:58:11 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2d) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Mon,
 30 Jun 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id DDE6414D72F;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 8DBEA1848B5D9;
	Mon, 30 Jun 2025 11:31:03 -0400 (EDT)
Subject: [PATCH for-next 15/23] RDMA/hfi2: Add in MAD handling related headers
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:31:03 -0400
Message-ID:
 <175129746352.1859400.3502114867739117290.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS2PR01MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9d5288-8859-447d-d0b7-08ddb7ffad68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1I0YzlDeWJCaHFUZHpQanoySnF3WXU1UlcrR2hnamRUNEZ2ZlZkeUlmUXJS?=
 =?utf-8?B?ZU1oeFFuT0ZTMXptSlUwc29EanhYQUdINktJWVNibmdVcTFzOVNudVM1R0tK?=
 =?utf-8?B?cG1rNmU4MkVvRGd6VVQ3R3NkUTczUXZSazJoeDBNWnZDTUliNVU5M25yQkU5?=
 =?utf-8?B?Y3Bycmd4N2Y4TkhOZWF4d25FMmF3SkZRKzJTVTFCNFYrL2M0SENxWE9yQmZO?=
 =?utf-8?B?Y0owU1A2VjlNVUEvaW96eEc1L3pDWGJ6R3VvVGRoNXBBZ291eWZOM09wZTRX?=
 =?utf-8?B?VmoyMGJOb25mNjNmVWlVcVNTRWFuSHZKbTRicnNLTDcrQmRkTHZtd1lTN0My?=
 =?utf-8?B?dS9aMlE3ZWNYODlvSnBPNHJNYW1xSmkzenFSSGQrSnZyeWFyRGpPWEIzYm9j?=
 =?utf-8?B?cU9HMzl3M1ExMlJGU2oxK2MveXpwYTJXNXNCNFBHdm9HOTNUaGJzMGxLd3F5?=
 =?utf-8?B?V24wNm5hMzAvME9oem1jMkFyaTI3VDVZcE5jUmJ2TXBkeDArOVpPWDdYRUF2?=
 =?utf-8?B?bGVmdWYwS0ZyTkRMQjJTd3Z3eUdWaGV6aG5OdUI3T084azZ4OUhnbjJQTCtU?=
 =?utf-8?B?d09MZmx0UHBnT1pmOENtVXJhZWtsVFgwb1lkTmF3UmI3RC92SDNWalVpTDBl?=
 =?utf-8?B?b2t0V0FDbHpvV1c5OHZmSVltem54aXh1dGx1eWtEZmp1RlgwcU1ObGtJV1V1?=
 =?utf-8?B?N1o2bzQ5NWpKYVl2WFdjS28zTmdkSmM4bFJHRWk2eExweXJqbjN5SG5WdGwy?=
 =?utf-8?B?bk5JWGdIYmJ3dzNSWVNvUHRBekE4MUVxOFNKT1RnbGU3QzMyR012N1ZJSFhC?=
 =?utf-8?B?bUhmWjBrK2lScEZmQ0VCazlvRjdLVFZkZERQOGRDMi9ZdllHYXNKMng0ZHNt?=
 =?utf-8?B?dzBjaDVmOWtkdGlBU21nbkNZY1QzRWlaNWhuM2VodGI1T2VrTnZEQjhORVFr?=
 =?utf-8?B?cGFJSTRxVVFBTTBUbGp5aXVQSnh0Q2RqdGNNV3BZRVpMQmE3ZjBxTmcvaStm?=
 =?utf-8?B?S0kveHZPaDVXVHgvd2lWTUQ0THpUUkpJc0x4OUkvSlNoN2JZa28wNmV3cC85?=
 =?utf-8?B?ZFVTNWx2b0ErOGtlWXliKy82MElnSkdOSlpaV3U1dXlCY2RLWC8wSmxzZ1R4?=
 =?utf-8?B?OTN1REYxR1ovTUpUTGwzTlB6NVFNM2F6OFRUYm5WUVErLzdvNzI4YnlQT1ZZ?=
 =?utf-8?B?SWo3ZWtxK1pycm9raGZ1VnBaNWptUkFqa1pLNmErdjZTeGIxUFBFM2Y3R1J0?=
 =?utf-8?B?ODZKOFNNWHFoRDN2dDFjdEl5SVNQSlMyb2RxREdQc0lMK2tGTDhzT1BaamZv?=
 =?utf-8?B?N25oc0NTVmNkbWxDNytFbkdaSlB2R214WUxYc3J2UDZHbEhMa0xFN3owVDNy?=
 =?utf-8?B?aGJrS3ltZ1NEbXFMSkJuY25yWVZFcFF1TnhGOFYwWkFzam44R1dmTDhMN1dP?=
 =?utf-8?B?WHJ0MU9rRHgxcGorcU1sb01hbmFvVm8vOTdiYVV4TmxMK3o0UEdHdmhuU1RC?=
 =?utf-8?B?bGRTVDBMUWFTZFZiakdMeWM1TWdBME9kMEtUUU1ZZWFZR0c1WFdmM0FsK1Fh?=
 =?utf-8?B?ZDY1d0xRRCtPM2VHdFZmcVpZMzZmemNlT21TL25xOHJ0cmpzeEZlZ1FkLzhv?=
 =?utf-8?B?UDFtRnR3SDdLVVZxS2N1ZW5NQXNyd3lCQnVOU3g5S1NuOWVGUFordGk5N2Jj?=
 =?utf-8?B?aUs0TmludGMxQ1VDNEU5bFEzRGhZTEFOOEE0c0R2WDRUWFJNYllRc3RMR29l?=
 =?utf-8?B?VC9kZFVoaEdGT2p3ZWdOb0J4Q0R3d2JoRy85WmVCelZ6VTZhaEdPWnVGM2tG?=
 =?utf-8?B?QjdqcjlGbkI2RlBCQ1p0KzJDc0hsaXdibWVLeFFZVGI3dEdGRGVxMGo3ZE9H?=
 =?utf-8?B?cFRaSFRmS3ZDSUxRSVI5MkdkRHpVM1lNdXNrdHVybFJ3RkZnRGxoSC9sa0ti?=
 =?utf-8?B?RWdqR0lkcjZiLzg5TmliTDV2bkVvUG5XeS82WTZvaHRRbjU0RXpqWUpaRmlM?=
 =?utf-8?B?NUZvM1dTQXhDajY2R3pjaGVQRDBSME9NSHEwWkN6TVlOV1NaQWhaaWNZN2NM?=
 =?utf-8?Q?EYysTE?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9d5288-8859-447d-d0b7-08ddb7ffad68
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9278

In the new HW there is an embedded micro on the card which manages alot of
what used to be done in sw as far as the MAD layer is concerned. We do
still need to support MADs in SW for the older generation HW so those
definitions move as well.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/cport.h       |  247 +++++++++++++++++
 drivers/infiniband/hw/hfi2/cport_traps.h |   43 +++
 drivers/infiniband/hw/hfi2/mad.h         |  448 ++++++++++++++++++++++++++++++
 3 files changed, 738 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/cport.h
 create mode 100644 drivers/infiniband/hw/hfi2/cport_traps.h
 create mode 100644 drivers/infiniband/hw/hfi2/mad.h

diff --git a/drivers/infiniband/hw/hfi2/cport.h b/drivers/infiniband/hw/hfi2/cport.h
new file mode 100644
index 000000000000..d08d8e04261d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks.
+ */
+
+#ifndef _CPORT_H
+#define _CPORT_H
+
+/*****************************************************
+ * "Public" software interfaces (inside driver only).
+ */
+
+/*
+ * Op-codes for requests (and associated responses).
+ * CPORT firmware must have the same definitions.
+ */
+#define CH_OP_PING		0	/* simple ping/echo command */
+#define CH_OP_WHO		1
+#define CH_OP_HOW		2
+#define CH_OP_START		3	/* driver start/options */
+#define CH_OP_STOP		4	/* driver stop (unload) */
+#define CH_OP_TRAP		5	/* notification of TRAP condition */
+#define CH_OP_TRAP_REPRESS	6	/* TRAP acknowledge */
+#define CH_OP_MAD_9B		7	/* Local MAD packets 9B */
+#define CH_OP_MAD_16B		8	/* Local MAD packets 16B */
+#define CH_OP_UMAD_9B		9	/* User MAD packets 9B */
+#define CH_OP_UMAD_16B		10	/* User MAD packets 16B */
+
+/*
+ * Error codes for responses.
+ * CPORT firmware must have the same definitions.
+ */
+#define MSG_RSP_STATUS_OK			0
+#define MSG_RSP_STATUS_SEQ_NO_ERROR		1
+#define MSG_RSP_STATUS_OPCODE_UNSUPPORTED	2
+#define MSG_RSP_STATUS_INVALID_STATE		3
+#define MSG_RSP_STATUS_RETRY			4
+#define MSG_RSP_STATUS_DENIED			5
+
+struct cport_options {
+	u16 bare_metal:1;
+	u16 gsi:1;
+	u16 flr:1;
+	u16 spi_we:1;
+	u16 local_mad:1;
+	u16 _resv:11;
+};
+
+struct cport_trap_status {
+	u32 psc:1;	/* Port State Change */
+	u32 li:1;	/* Link Integrity */
+	u32 bo:1;	/* Buffer Overrun */
+	u32 fw:1;	/* Flow Watchdog */
+	u32 cc:1;	/* Capability Change */
+	u32 sic:1;	/* System Image Change */
+	u32 bmk:1;	/* Bad M Key */
+	u32 bqk:1;	/* Bad Q Key */
+	u32 lwc:1;	/* Link Width Change */
+	u32 qsfp:1;	/* QSFP Fault */
+	u32 _resv:22;
+};
+
+/* Fields in 4-qword payload of WHO response */
+struct cport_who_payload {
+	/* qword 1 */
+	u16 _resv1:8;
+	u16 introp:8;	/* interop level */
+	struct cport_options fixed;
+	struct cport_options suppt;
+	u16 max_msg;	/* max cport msg length */
+	/* qword 2 */
+	u64 vers_bld:32;
+	u64 vers_pat:8;
+	u64 vers_mnt:8;
+	u64 vers_min:8;
+	u64 vers_maj:8;
+	/* qword 3 */
+	u64 node_guid;
+	/* qword 4 */
+	struct cport_trap_status trap_sup;
+	u16 _resv2;
+	u16 max_aux;	/* max cport aux length */
+};
+
+/* Fields in 3-qword payload of HOW response */
+struct cport_how_payload {
+	/* qword 1 */
+	u16 pt0_log_st:2;
+	u16 pt1_log_st:2;
+	u16 pt2_log_st:2;
+	u16 pt3_log_st:2;
+	u16 interop:8;
+	struct cport_options opts_ena;
+	u16 pt0_phy_st:8;
+	u16 pt1_phy_st:8;
+	u16 pt2_phy_st:8;
+	u16 pt3_phy_st:8;
+	/* qword 2 */
+	struct cport_trap_status trap_ena;
+	struct cport_trap_status trap_sts;
+	/* qword 3 */
+	u64 started:8;
+	u64 _resv1:56;
+};
+
+/* Fields in 1-qword payload of START request/response */
+struct cport_start_payload {
+	u16 sidx:3;
+	u16 _resv1:5;
+	u16 interop:8;
+	struct cport_options opts_ena;
+	struct cport_trap_status trap_ena;
+};
+
+/* Fields in 1-qword payload of STOP request/response */
+struct cport_stop_payload {
+	u64 sidx:3;
+	u64 _resv1:61;
+};
+
+/* Fields in 1-qword payload of TRAP or TRAP_REPRESS request */
+struct cport_trap_payload {
+	struct cport_trap_status trap_sts;
+	u32 _resv1;
+};
+
+/*
+ * Non-blocking request interface.
+ *
+ * cport_send_req_nb() returns 'handle' (or IS_ERR(handle)).
+ * Caller supplies 'wait' which will be "upped" when the matching response
+ * is received.  Caller also supplies a timeout for the OUTBOX_EMPTY wait.
+ * This is generally needed if the caller will be using a timeout when waiting
+ * for completion, to ensure that the send kworker also times out and exits.
+ * Timeouts, etc, use cport_send_cancel() to terminate without receiving response.
+ *
+ * Payload is always copied to internal buffer, so caller
+ * may dispose of their buffer immediately on return.
+ *
+ * Timeout value of MAX_SCHEDULE_TIMEOUT causes infinite wait for OUTBOX_EMPTY.
+ *
+ * One of cport_send_comp() or cport_send_cancel() must be called in order
+ * to fully release 'handle'.
+ *
+ * Response payload and length is provided in 'rsp_pld' and 'rsp_len',
+ * which has been kalloc'ed and must be kfree'ed by caller.
+ *
+ * cport_send_comp() returns the status (error code) from the response.
+ */
+void *cport_send_req_nb(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			void *payload, int len, struct semaphore *wait, long timeout);
+int cport_send_comp(struct hfi2_devdata *dd, void *handle,
+		    void **rsp_pld, int *rsp_len);
+void cport_send_cancel(struct hfi2_devdata *dd, void *handle);
+
+/*
+ * Blocking request interface with timeout.
+ *
+ * The caller may dispose of 'payload' immediately on return.
+ * Response payload and length is provided in 'rsp_pld' and 'rsp_len',
+ * which has been kalloc'ed and must be kfree'ed by caller.
+ *
+ * Timeout value of MAX_SCHEDULE_TIMEOUT causes infinite wait for response
+ * and OUTBOX_EMPTY.
+ *
+ * Returns the status (error code) from the response.
+ */
+int cport_send_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload, int len,
+		   void **rsp_pld, int *rsp_len, long timeout);
+
+/*
+ * CPORT Notification interface.
+ *
+ * A notification is defined as a request that has no response.
+ * This is implicitly non-blocking.
+ *
+ * The caller may dispose of 'payload' immediately on return.
+ *
+ * Returns 0 if the request was successfully queued.
+ */
+int cport_send_notif(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload, int len);
+
+/**************************************
+ * API for notifications from CPORT
+ */
+
+/*
+ * Handler prototype for callbacks.
+ *
+ * Returns response status (error) value. Must setup response payload
+ * if appropriate. Whether or not a response is actually sent depends on
+ * whether the request asked for one. Default is no payload (0 length).
+ *
+ * The semantics for responses are defined by the op-code. Error responses
+ * may have different payloads than successful responses (or no payload at all).
+ * Payloads may even be optional.
+ */
+typedef int (*cport_handler)(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			     void *payload, int len, void *handle);
+
+/*
+ * Register a callback for a range of op-codes. Only one callback may be
+ * registered for a given op-code. Returns 0 on success (valid op-code range).
+ */
+int cport_register_cb(struct hfi2_devdata *dd, u8 op_start, u8 op_end, cport_handler func);
+
+/*
+ * Prepare a response payload for 'len' bytes of payload from callback.
+ *
+ * Returns NULL on error, including 'len' out of bounds. Returned pointer
+ * is not disposable directly.
+ */
+void *cport_resp_alloc(void *handle, int len);
+
+/*
+ * Set static buffer for response payload of 'len' bytes from callback.
+ *
+ * Buffer may be disposed of immediately on return. If 'len' exceeds
+ * maximum allowed, returns -EINVAL.
+ */
+int cport_resp_set(void *handle, void *payload, int len);
+
+/*
+ * Interrupt handler for MctxtCportToPcieInt
+ */
+void is_cport_int(struct hfi2_devdata *dd, unsigned int source);
+
+/*
+ * Start a CPORT ping for count iterations.
+ */
+int cport_ping_start(struct hfi2_devdata *dd, unsigned int count);
+
+/*
+ * Initialize the CPORT communication facility.
+ *
+ * If the device does not have a CPORT, this returns 0.
+ */
+int cport_init(struct hfi2_devdata *dd);
+
+/*
+ * Shutdown the CPORT communication facility.
+ *
+ * If the device has no CPORT, this does nothing.
+ */
+int cport_exit(struct hfi2_devdata *dd);
+
+#endif /* _CPORT_H */
diff --git a/drivers/infiniband/hw/hfi2/cport_traps.h b/drivers/infiniband/hw/hfi2/cport_traps.h
new file mode 100644
index 000000000000..cff14649b78a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport_traps.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks.
+ */
+
+#ifndef _CPORT_TRAPS_H
+#define _CPORT_TRAPS_H
+
+#include "cport.h"
+
+/*
+ * Facility to handle CPORT "TRAPS".
+ */
+
+/*
+ * Handler prototype for callbacks.
+ *
+ * @traps indicates which traps are being reported, and is not restricted
+ * to the trap(s) registered to this callback. At least one of the traps
+ * that was requested will be set.
+ */
+typedef void (*cport_trap_handler)(struct hfi2_devdata *dd,
+				   struct cport_trap_status traps);
+
+/*
+ * Register for a callback when certain CPORT TRAPs occur.
+ *
+ * @traps indicates the TRAPs to be detected.
+ * @func will be called when at least one of @traps is set.
+ */
+int register_cport_trap(struct hfi2_devdata *dd, struct cport_trap_status traps,
+			cport_trap_handler func);
+
+/*
+ * Deregister for a callback on CPORT TRAPs.
+ *
+ * @func All registered callbacks using this function will be removed.
+ *
+ * On return, @func will not be called for any traps.
+ */
+int deregister_cport_trap(struct hfi2_devdata *dd, cport_trap_handler func);
+
+#endif /* _CPORT_TRAPS_H */
diff --git a/drivers/infiniband/hw/hfi2/mad.h b/drivers/infiniband/hw/hfi2/mad.h
new file mode 100644
index 000000000000..d599deb8e7ae
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mad.h
@@ -0,0 +1,448 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ */
+
+#ifndef _HFI2_MAD_H
+#define _HFI2_MAD_H
+
+#include <rdma/ib_pma.h>
+#include <rdma/opa_smi.h>
+#include <rdma/opa_port_info.h>
+#include "opa_compat.h"
+
+/*
+ * OPA Traps
+ */
+#define OPA_TRAP_GID_NOW_IN_SERVICE             cpu_to_be16(64)
+#define OPA_TRAP_GID_OUT_OF_SERVICE             cpu_to_be16(65)
+#define OPA_TRAP_ADD_MULTICAST_GROUP            cpu_to_be16(66)
+#define OPA_TRAL_DEL_MULTICAST_GROUP            cpu_to_be16(67)
+#define OPA_TRAP_UNPATH                         cpu_to_be16(68)
+#define OPA_TRAP_REPATH                         cpu_to_be16(69)
+#define OPA_TRAP_PORT_CHANGE_STATE              cpu_to_be16(128)
+#define OPA_TRAP_LINK_INTEGRITY                 cpu_to_be16(129)
+#define OPA_TRAP_EXCESSIVE_BUFFER_OVERRUN       cpu_to_be16(130)
+#define OPA_TRAP_FLOW_WATCHDOG                  cpu_to_be16(131)
+#define OPA_TRAP_CHANGE_CAPABILITY              cpu_to_be16(144)
+#define OPA_TRAP_CHANGE_SYSGUID                 cpu_to_be16(145)
+#define OPA_TRAP_BAD_M_KEY                      cpu_to_be16(256)
+#define OPA_TRAP_BAD_P_KEY                      cpu_to_be16(257)
+#define OPA_TRAP_BAD_Q_KEY                      cpu_to_be16(258)
+#define OPA_TRAP_SWITCH_BAD_PKEY                cpu_to_be16(259)
+#define OPA_SMA_TRAP_DATA_LINK_WIDTH            cpu_to_be16(2048)
+
+/*
+ * Generic trap/notice other local changes flags (trap 144).
+ */
+#define	OPA_NOTICE_TRAP_LWDE_CHG        0x08 /* Link Width Downgrade Enable
+					      * changed
+					      */
+#define OPA_NOTICE_TRAP_LSE_CHG         0x04 /* Link Speed Enable changed */
+#define OPA_NOTICE_TRAP_LWE_CHG         0x02 /* Link Width Enable changed */
+#define OPA_NOTICE_TRAP_NODE_DESC_CHG   0x01
+
+struct opa_mad_notice_attr {
+	u8 generic_type;
+	u8 prod_type_msb;
+	__be16 prod_type_lsb;
+	__be16 trap_num;
+	__be16 toggle_count;
+	__be32 issuer_lid;
+	__be32 reserved1;
+	union ib_gid issuer_gid;
+
+	union {
+		struct {
+			u8	details[64];
+		} raw_data;
+
+		struct {
+			union ib_gid	gid;
+		} __packed ntc_64_65_66_67;
+
+		struct {
+			__be32	lid;
+		} __packed ntc_128;
+
+		struct {
+			__be32	lid;		/* where violation happened */
+			u8	port_num;	/* where violation happened */
+		} __packed ntc_129_130_131;
+
+		struct {
+			__be32	lid;		/* LID where change occurred */
+			__be32	new_cap_mask;	/* new capability mask */
+			__be16	reserved2;
+			__be16	cap_mask3;
+			__be16	change_flags;	/* low 4 bits only */
+		} __packed ntc_144;
+
+		struct {
+			__be64	new_sys_guid;
+			__be32	lid;		/* lid where sys guid changed */
+		} __packed ntc_145;
+
+		struct {
+			__be32	lid;
+			__be32	dr_slid;
+			u8	method;
+			u8	dr_trunc_hop;
+			__be16	attr_id;
+			__be32	attr_mod;
+			__be64	mkey;
+			u8	dr_rtn_path[30];
+		} __packed ntc_256;
+
+		struct {
+			__be32		lid1;
+			__be32		lid2;
+			__be32		key;
+			u8		sl;	/* SL: high 5 bits */
+			u8		reserved3[3];
+			union ib_gid	gid1;
+			union ib_gid	gid2;
+			__be32		qp1;	/* high 8 bits reserved */
+			__be32		qp2;	/* high 8 bits reserved */
+		} __packed ntc_257_258;
+
+		struct {
+			__be16		flags;	/* low 8 bits reserved */
+			__be16		pkey;
+			__be32		lid1;
+			__be32		lid2;
+			u8		sl;	/* SL: high 5 bits */
+			u8		reserved4[3];
+			union ib_gid	gid1;
+			union ib_gid	gid2;
+			__be32		qp1;	/* high 8 bits reserved */
+			__be32		qp2;	/* high 8 bits reserved */
+		} __packed ntc_259;
+
+		struct {
+			__be32	lid;
+		} __packed ntc_2048;
+
+	};
+	u8	class_data[];
+};
+
+#define IB_VLARB_LOWPRI_0_31    1
+#define IB_VLARB_LOWPRI_32_63   2
+#define IB_VLARB_HIGHPRI_0_31   3
+#define IB_VLARB_HIGHPRI_32_63  4
+
+#define OPA_MAX_PREEMPT_CAP         32
+#define OPA_VLARB_LOW_ELEMENTS       0
+#define OPA_VLARB_HIGH_ELEMENTS      1
+#define OPA_VLARB_PREEMPT_ELEMENTS   2
+#define OPA_VLARB_PREEMPT_MATRIX     3
+
+#define IB_PMA_PORT_COUNTERS_CONG       cpu_to_be16(0xFF00)
+#define LINK_SPEED_25G		1
+#define LINK_SPEED_12_5G	2
+#define LINK_WIDTH_DEFAULT	4
+#define DECIMAL_FACTORING	1000
+/*
+ * The default link width is multiplied by 1000
+ * to get accurate value after division.
+ */
+#define FACTOR_LINK_WIDTH	(LINK_WIDTH_DEFAULT * DECIMAL_FACTORING)
+
+struct ib_pma_portcounters_cong {
+	u8 reserved;
+	u8 reserved1;
+	__be16 port_check_rate;
+	__be16 symbol_error_counter;
+	u8 link_error_recovery_counter;
+	u8 link_downed_counter;
+	__be16 port_rcv_errors;
+	__be16 port_rcv_remphys_errors;
+	__be16 port_rcv_switch_relay_errors;
+	__be16 port_xmit_discards;
+	u8 port_xmit_constraint_errors;
+	u8 port_rcv_constraint_errors;
+	u8 reserved2;
+	u8 link_overrun_errors; /* LocalLink: 7:4, BufferOverrun: 3:0 */
+	__be16 reserved3;
+	__be16 vl15_dropped;
+	__be64 port_xmit_data;
+	__be64 port_rcv_data;
+	__be64 port_xmit_packets;
+	__be64 port_rcv_packets;
+	__be64 port_xmit_wait;
+	__be64 port_adr_events;
+} __packed;
+
+#define IB_SMP_UNSUP_VERSION    cpu_to_be16(0x0004)
+#define IB_SMP_UNSUP_METHOD     cpu_to_be16(0x0008)
+#define IB_SMP_UNSUP_METH_ATTR  cpu_to_be16(0x000C)
+#define IB_SMP_INVALID_FIELD    cpu_to_be16(0x001C)
+
+#define OPA_MAX_PREEMPT_CAP         32
+#define OPA_VLARB_LOW_ELEMENTS       0
+#define OPA_VLARB_HIGH_ELEMENTS      1
+#define OPA_VLARB_PREEMPT_ELEMENTS   2
+#define OPA_VLARB_PREEMPT_MATRIX     3
+
+#define HFI2_XMIT_RATE_UNSUPPORTED               0x0
+#define HFI2_XMIT_RATE_PICO                      0x7
+/* number of 4nsec cycles equaling 2secs */
+#define HFI2_CONG_TIMER_PSINTERVAL               0x1DCD64EC
+
+#define IB_CC_SVCTYPE_RC 0x0
+#define IB_CC_SVCTYPE_UC 0x1
+#define IB_CC_SVCTYPE_RD 0x2
+#define IB_CC_SVCTYPE_UD 0x3
+
+/*
+ * There should be an equivalent IB #define for the following, but
+ * I cannot find it.
+ */
+#define OPA_CC_LOG_TYPE_HFI	2
+
+struct opa_hfi2_cong_log_event_internal {
+	u32 lqpn;
+	u32 rqpn;
+	u8 sl;
+	u8 svc_type;
+	u32 rlid;
+	u64 timestamp; /* wider than 32 bits to detect 32 bit rollover */
+};
+
+struct opa_hfi2_cong_log_event {
+	u8 local_qp_cn_entry[3];
+	u8 remote_qp_number_cn_entry[3];
+	u8 sl_svc_type_cn_entry; /* 5 bits SL, 3 bits svc type */
+	u8 reserved;
+	__be32 remote_lid_cn_entry;
+	__be32 timestamp_cn_entry;
+} __packed;
+
+#define OPA_CONG_LOG_ELEMS	96
+
+struct opa_hfi2_cong_log {
+	u8 log_type;
+	u8 congestion_flags;
+	__be16 threshold_event_counter;
+	__be32 current_time_stamp;
+	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
+	struct opa_hfi2_cong_log_event events[OPA_CONG_LOG_ELEMS];
+} __packed;
+
+#define IB_CC_TABLE_CAP_DEFAULT 31
+
+/* Port control flags */
+#define IB_CC_CCS_PC_SL_BASED 0x01
+
+struct opa_congestion_setting_entry {
+	u8 ccti_increase;
+	u8 reserved;
+	__be16 ccti_timer;
+	u8 trigger_threshold;
+	u8 ccti_min; /* min CCTI for cc table */
+} __packed;
+
+struct opa_congestion_setting_entry_shadow {
+	u8 ccti_increase;
+	u8 reserved;
+	u16 ccti_timer;
+	u8 trigger_threshold;
+	u8 ccti_min; /* min CCTI for cc table */
+} __packed;
+
+struct opa_congestion_setting_attr {
+	__be32 control_map;
+	__be16 port_control;
+	struct opa_congestion_setting_entry entries[OPA_MAX_SLS];
+} __packed;
+
+struct opa_congestion_setting_attr_shadow {
+	u32 control_map;
+	u16 port_control;
+	struct opa_congestion_setting_entry_shadow entries[OPA_MAX_SLS];
+} __packed;
+
+#define IB_CC_TABLE_ENTRY_INCREASE_DEFAULT 1
+#define IB_CC_TABLE_ENTRY_TIMER_DEFAULT 1
+
+/* 64 Congestion Control table entries in a single MAD */
+#define IB_CCT_ENTRIES 64
+#define IB_CCT_MIN_ENTRIES (IB_CCT_ENTRIES * 2)
+
+struct ib_cc_table_entry {
+	__be16 entry; /* shift:2, multiplier:14 */
+};
+
+struct ib_cc_table_entry_shadow {
+	u16 entry; /* shift:2, multiplier:14 */
+};
+
+struct ib_cc_table_attr {
+	__be16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry ccti_entries[IB_CCT_ENTRIES];
+} __packed;
+
+struct ib_cc_table_attr_shadow {
+	u16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry_shadow ccti_entries[IB_CCT_ENTRIES];
+} __packed;
+
+#define CC_TABLE_SHADOW_MAX \
+	(IB_CC_TABLE_CAP_DEFAULT * IB_CCT_ENTRIES)
+
+struct cc_table_shadow {
+	u16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry_shadow entries[CC_TABLE_SHADOW_MAX];
+} __packed;
+
+/*
+ * struct cc_state combines the (active) per-port congestion control
+ * table, and the (active) per-SL congestion settings. cc_state data
+ * may need to be read in code paths that we want to be fast, so it
+ * is an RCU protected structure.
+ */
+struct cc_state {
+	struct rcu_head rcu;
+	struct cc_table_shadow cct;
+	struct opa_congestion_setting_attr_shadow cong_setting;
+};
+
+/*
+ * OPA BufferControl MAD
+ */
+
+/* attribute modifier macros */
+#define OPA_AM_NPORT_SHIFT	24
+#define OPA_AM_NPORT_MASK	0xff
+#define OPA_AM_NPORT_SMASK	(OPA_AM_NPORT_MASK << OPA_AM_NPORT_SHIFT)
+#define OPA_AM_NPORT(am)	(((am) >> OPA_AM_NPORT_SHIFT) & \
+					OPA_AM_NPORT_MASK)
+
+#define OPA_AM_NBLK_SHIFT	24
+#define OPA_AM_NBLK_MASK	0xff
+#define OPA_AM_NBLK_SMASK	(OPA_AM_NBLK_MASK << OPA_AM_NBLK_SHIFT)
+#define OPA_AM_NBLK(am)		(((am) >> OPA_AM_NBLK_SHIFT) & \
+					OPA_AM_NBLK_MASK)
+
+#define OPA_AM_START_BLK_SHIFT	0
+#define OPA_AM_START_BLK_MASK	0xff
+#define OPA_AM_START_BLK_SMASK	(OPA_AM_START_BLK_MASK << \
+					OPA_AM_START_BLK_SHIFT)
+#define OPA_AM_START_BLK(am)	(((am) >> OPA_AM_START_BLK_SHIFT) & \
+					OPA_AM_START_BLK_MASK)
+
+#define OPA_AM_PORTNUM_SHIFT	0
+#define OPA_AM_PORTNUM_MASK	0xff
+#define OPA_AM_PORTNUM_SMASK	(OPA_AM_PORTNUM_MASK << OPA_AM_PORTNUM_SHIFT)
+#define OPA_AM_PORTNUM(am)	(((am) >> OPA_AM_PORTNUM_SHIFT) & \
+					OPA_AM_PORTNUM_MASK)
+
+#define OPA_AM_ASYNC_SHIFT	12
+#define OPA_AM_ASYNC_MASK	0x1
+#define OPA_AM_ASYNC_SMASK	(OPA_AM_ASYNC_MASK << OPA_AM_ASYNC_SHIFT)
+#define OPA_AM_ASYNC(am)	(((am) >> OPA_AM_ASYNC_SHIFT) & \
+					OPA_AM_ASYNC_MASK)
+
+#define OPA_AM_START_SM_CFG_SHIFT	9
+#define OPA_AM_START_SM_CFG_MASK	0x1
+#define OPA_AM_START_SM_CFG_SMASK	(OPA_AM_START_SM_CFG_MASK << \
+						OPA_AM_START_SM_CFG_SHIFT)
+#define OPA_AM_START_SM_CFG(am)		(((am) >> OPA_AM_START_SM_CFG_SHIFT) \
+						& OPA_AM_START_SM_CFG_MASK)
+
+#define OPA_AM_CI_ADDR_SHIFT	19
+#define OPA_AM_CI_ADDR_MASK	0xfff
+#define OPA_AM_CI_ADDR_SMASK	(OPA_AM_CI_ADDR_MASK << OPA_CI_ADDR_SHIFT)
+#define OPA_AM_CI_ADDR(am)	(((am) >> OPA_AM_CI_ADDR_SHIFT) & \
+					OPA_AM_CI_ADDR_MASK)
+
+#define OPA_AM_CI_LEN_SHIFT	13
+#define OPA_AM_CI_LEN_MASK	0x3f
+#define OPA_AM_CI_LEN_SMASK	(OPA_AM_CI_LEN_MASK << OPA_CI_LEN_SHIFT)
+#define OPA_AM_CI_LEN(am)	(((am) >> OPA_AM_CI_LEN_SHIFT) & \
+					OPA_AM_CI_LEN_MASK)
+
+/* error info macros */
+#define OPA_EI_STATUS_SMASK	0x80
+#define OPA_EI_CODE_SMASK	0x0f
+
+struct vl_limit {
+	__be16 dedicated;
+	__be16 shared;
+};
+
+struct buffer_control {
+	__be16 reserved;
+	__be16 overall_shared_limit;
+	struct vl_limit vl[OPA_MAX_VLS];
+};
+
+struct sc2vlnt {
+	u8 vlnt[32]; /* 5 bit VL, 3 bits reserved */
+};
+
+/*
+ * The PortSamplesControl.CounterMasks field is an array of 3 bit fields
+ * which specify the N'th counter's capabilities. See ch. 16.1.3.2.
+ * We support 5 counters which only count the mandatory quantities.
+ */
+#define COUNTER_MASK(q, n) (q << ((9 - n) * 3))
+#define COUNTER_MASK0_9 \
+	cpu_to_be32(COUNTER_MASK(1, 0) | \
+		    COUNTER_MASK(1, 1) | \
+		    COUNTER_MASK(1, 2) | \
+		    COUNTER_MASK(1, 3) | \
+		    COUNTER_MASK(1, 4))
+
+void hfi2_event_pkey_change(struct hfi2_devdata *dd, u32 port);
+void hfi2_handle_trap_timer(struct timer_list *t);
+u16 tx_link_width(u16 link_width);
+u64 get_xmit_wait_counters(struct hfi2_pportdata *ppd, u16 link_width,
+			   u16 link_speed, int vl);
+int hfi2_mad_init(struct hfi2_devdata *dd);
+int hfi2_mad_deinit(struct hfi2_devdata *dd);
+int get_sc2vlt_tables(struct hfi2_pportdata *ppd, void *data);
+
+int cport_send_recv_mad(struct hfi2_devdata *dd, u8 sb,
+			const void *mad, int len,
+			void *omad, size_t *omad_len);
+int update_from_opa_portinfo(struct hfi2_pportdata *ppd,
+			     struct opa_smp *smp,
+			     struct opa_port_info *pi);
+
+/**
+ * get_link_speed - determine whether 12.5G or 25G speed
+ * @link_speed: the speed of active link
+ * @return: Return 2 if link speed identified as 12.5G
+ * or return 1 if link speed is 25G.
+ *
+ * The function indirectly calculate required link speed
+ * value for convert_xmit_counter function. If the link
+ * speed is 25G, the function return as 1 as it is required
+ * by xmit counter conversion formula :-( 25G / link_speed).
+ * This conversion will provide value 1 if current
+ * link speed is 25G or 2 if 12.5G.This is done to avoid
+ * 12.5 float number conversion.
+ */
+static inline u16 get_link_speed(u16 link_speed)
+{
+	return (link_speed == 1) ?
+		 LINK_SPEED_12_5G : LINK_SPEED_25G;
+}
+
+/**
+ * convert_xmit_counter - calculate flit times for given xmit counter
+ * value
+ * @xmit_wait_val: current xmit counter value
+ * @link_width: width of active link
+ * @link_speed: speed of active link
+ * @return: return xmit counter value in flit times.
+ */
+static inline u64 convert_xmit_counter(u64 xmit_wait_val, u16 link_width,
+				       u16 link_speed)
+{
+	return (xmit_wait_val * 2 * (FACTOR_LINK_WIDTH / link_width)
+		 * link_speed) / DECIMAL_FACTORING;
+}
+#endif				/* _HFI2_MAD_H */



