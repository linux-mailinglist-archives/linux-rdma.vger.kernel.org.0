Return-Path: <linux-rdma+bounces-11770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0EAAEE633
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71213A3306
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CE2E62AF;
	Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="L6N2j4is"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022119.outbound.protection.outlook.com [40.107.200.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F192D130C
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306295; cv=fail; b=rOP2+t/MQIYvpuLOfp7AhlReFZOM/dXTVSgN4fT1OJl8Rkbqh5q0LrjZMAP+wZ74rX9X6lU7y6kCJKt0hLGU1eOLgUbOGngsN/bftkplBP4pyuybPhXn/yuyiG+a4exYzLknQDQkub/YC6g0QED0BjBIFWayBUdQY/5AoRO6Pgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306295; c=relaxed/simple;
	bh=TVvETOObqXLc80Zb1+1wFWiQ3aXnrz7Y2upts/+Xxbo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkfxRdPh2g5Nu4ku0gV/tlw/IlTbut8MLbkvAifnTlvQeUxCJJ/ySqKNx0NXwKGIBsC5UGqJEb7+3y1X3ukGe7RhXmsw1eeHREoOkHMgpoiEiRZ3QrSFX88HJmyG2PX/+PBhS3PjxwGthv1vdJMzwQIBBfcNWpb3XZIDAhGq2f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=L6N2j4is; arc=fail smtp.client-ip=40.107.200.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoIPdXPt7damskfhdzzjPGY6YlE06r3GAZC7r8VNuRu8OKadP2hyZwRyQedkH2n05i6vSsK4GmQWGG2aKcrCnN+H4Rmk0Dffcr+Eg84DMXPB5MDYV6qMVZ7tiHr1lh9ybHfBBHvn8bwB2aEQNeg7+irEenbcEAgKLwIUDWCUiHvstPyPfecrBprZD3QlWTw8ruKxXPnPtc8X0b7W3nFdXiHxA9JkzxeF4Zy38N6qScTgPly/r8uZeImxeEqJZtwzV0GJZvVU4PigN7F23BKakHq8BGGAZZi+znYd/7cSGlBOxaT7WFhNkTro7+mQel3gEfnjNp0PNlzNn5WKPnMpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCBW0W8bjir9iHaD+qsLv5nNvZ6J9RfqB1gBHL96FM8=;
 b=ZgNjoY72CPyfq/JsCH/NNaCXHlrm/6CmpjwMkksqTxfZ4w8y4+2Q8H+jn6xwF3DNSCNFyZ1vKV8gHxc59PbPF4GwQhXPQep1qsyhxvzthID9AQzFEtk5PRTQH3bcsGyVfM95wsOBH6A+q9/u54U4X2WnCXF6FZTLXzoOGGgGC2pVPrYV7uEb9f7T13AAJ4SBDrVsVV//RFdB7UPtgqnTWN5oiN25l5gHhQEcedAedSvuDkgS20bXG1ZOuT7pJlsDPKf6t1E4Blcf2dZE0DxDFtLvAGNEG225wPsHIadU1bHC9z8E1LYjx7+iinMBOxNIQV6h/PHHvh3SqAqOxUOxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCBW0W8bjir9iHaD+qsLv5nNvZ6J9RfqB1gBHL96FM8=;
 b=L6N2j4isMbdCTDLwPKcdnhBoD/HM7a1Y4DFjlV8Rrq0quObnswoV/umUQeIbouibzXuG5s6iaTHceXAdyGALPM0/vkUoAWsVqY7CsluI8Hc/m6oyVaMjz4JDnRxxEFuayDXNN+4ckA9krBRp8JGw1dGOisj+fcv2wS56aa9x3yecU1Q6dmg0MCROShuAVYRpJV2YFP1+wH9Lc0AA4ka21UoZEZKNwhK1uuOWOViG0WBUU+0uTRCosB+d5ojNOI2irWRiFDDP79kc8x2wXls+GxO9uRonOxTUNj4tuc+be/ilkZfULLjmzbYJoM/TCA6saDyAZChvfuUmS3ALLKI8Jw==
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by CY1PR01MB9200.prod.exchangelabs.com (2603:10b6:930:fd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Mon, 30 Jun 2025 17:58:10 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::7d) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E277914D732;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id A503E1811CE67;
	Mon, 30 Jun 2025 11:29:57 -0400 (EDT)
Subject: [PATCH for-next 02/23] RDMA/rdmavt: Add ucontext alloc/dealloc
 passthrough
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:29:57 -0400
Message-ID:
 <175129739764.1859400.4204183223785461584.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CY1PR01MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 94953d6d-0af7-461e-0c0c-08ddb7ffad21
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFHVHRISUJTQUdtTWNvVHJuaGh4UlZMM2g5Lzg0UlozU3hOcEI2YzkyRUFt?=
 =?utf-8?B?TDBjNk9vQUYvR2ttYm9qZGl4RUxZTVVlY2JqdWlHNGZzalY5bUFvZUVFZXBR?=
 =?utf-8?B?NFMrTGZId3dTUWZyQ0VEcEJSRjhWS3ZQS29pUVRBZnpnRW1xU1VFTUxnakNP?=
 =?utf-8?B?S0ZuWVJLMjV5SjBkUFBBRldmLzI4NlZ5ZmNTSU9PUzBuQnRlUzJjOHBNZksz?=
 =?utf-8?B?V1JRK2lwNWszL2FxZCtVSXBscStrL1Brb01JNE0xcjU2UUhsRnVvVSs0ZFJw?=
 =?utf-8?B?aEpGdjIxeFVpOGxjRHNiVzBVZWF6NEQ0VEpZSHJqZVU1ZnZOeWNQbnAvbHVN?=
 =?utf-8?B?ZVpHc0w0QjIwUHM0UU16dzVyWlBGUi9Ub3VxTis2c0llTnY5UjF5ZG5hNGg3?=
 =?utf-8?B?OXZaOCttQXhqZVRucDJEdVpTU0VtWTNoUDhydkNXM0I0aGd4Z0FkVzJkRC8w?=
 =?utf-8?B?QjhuczJXQXB5ZWNyMDZkNGY4SURUVjJ0UlFYVm81UUlnL3l3Y0pwb1BsU0dz?=
 =?utf-8?B?Z1NmYTdGc0xBMEFCM1FjckRvUGtNTzArbTFjT04wOVZ6MlJhZU1oZ2lNMUd3?=
 =?utf-8?B?QS8rOW1NMS91Z09sOGRsOUlKMnBaRlI4OG1vWGVWZi8zVWdISU1jdFZJdE9Q?=
 =?utf-8?B?ZXhsYU1uSDlGb3JRUUdBZnVCR0RNeTBvSjh0WnlwazdzalBnZG05ZWJQOW5G?=
 =?utf-8?B?eW12anh6SWQ2L1VUSHBWbW1EZFVSZmVGdkd5TjNsUzRJdHIwQ1Z4aDhuRWlp?=
 =?utf-8?B?clpvL1VkQUJ0NnhxQmFicE5FTnZ0N0UwcFhXdEZLRm9aR3p1dU5HZDljR1NL?=
 =?utf-8?B?Qy83bUpOSHNZN2Q1ZnVCT3RDSGQ5Y252aTFHSFM5V3VFVGhMR1g2Q1RPRTNN?=
 =?utf-8?B?Z1dZa1dPU2VJQzAvekdScUxncFlCd2ZnWmxoT0x0MzlIZm9sMjdNalVTZ0Ja?=
 =?utf-8?B?NFMySjZYc0hwamY1eStRRi9rZG80OU9ycVI2QURrQlRjbkdsUWhhbjVJMkNl?=
 =?utf-8?B?TG9qUTA4Z1l3Q3lIc1pFK0JlU1BCN0NiT1FaeENxTEZRM3VucFgydWlVUDJV?=
 =?utf-8?B?VUVDN25SZFhPUTZ1Y2N1cVpnK0gyTmpDQ01oa3BhUGVEbUNOZkhKWTVzSFFD?=
 =?utf-8?B?TTNQWjRxQS9MUlhTZ3BQMENnZGgrNDVoOEFYSkpsWDNHL1NaSHBwMm9ZdmtF?=
 =?utf-8?B?amcxTisvRFg3NlZqbmpra0NnaDN5ZjhWeVB4NGZYUStzbyt5enI5eE5jRDVr?=
 =?utf-8?B?aUhJaFpWRHJQdDhxNmlmZkdKQUhWbWVydVpuWDU0S2FMS0xBWGRjNDd2SVZF?=
 =?utf-8?B?NHZ4ZFRCb0s2M1FwZm9ESjlOOWJtMTllbkdYa1l3cGVYWW1WaGpzejhNbzkz?=
 =?utf-8?B?a2JzbTBDdkJ0aGJ6NW5HS0tVdkVLNzlWMms0NGp0eXRBMlhHZ1RyMUpra2cw?=
 =?utf-8?B?SExEYmw5aTYreVdOTzdVQllpT3p4RHN6ZHZML2FXVFhHeEh2Zi93R0h0dHJO?=
 =?utf-8?B?V0lvUnJ0eGVjc3JBODVoWndmTG9NQVZvR21jVTJMR2cyVlpnWkpnYVowakdI?=
 =?utf-8?B?SHFOWXVtdUZYL3dMRERzV1BTMjQwUGdzNStUR3pkYkZ6Vk9PTWU4cjRYY1Zk?=
 =?utf-8?B?ZVBqa1ZpQ1VOYlAvbTlXa0VsRkthRkFhOHhtV3Eyd2VqVTB4WU43SUNGNWpL?=
 =?utf-8?B?N1g2YjRsZWxVeU1hNkRiSEVvdys0ZFlIUjc0aW90ajRCYzNISkh4MFdFeTRK?=
 =?utf-8?B?MGJhUjdzL2R1Nm5qbWY1dGoyZHFkQVFiRVZRemZTeWV6azRJSTJlekpkWU5o?=
 =?utf-8?B?d3cvRFRTNVBJSms2eDFDYzR0aGNZQVdtK3dVemwxMy9CTUcxZkhnM21aR3Bz?=
 =?utf-8?B?U0xhNHZMYXpOQ3V5TFk4ZVpvZEt0VGFwSXNES0VUd0NDMmozdWJVUFNEeDRX?=
 =?utf-8?B?angycGlaYmhxQ2E3UW4wUERIUllmWklFeUZneVJRZGxHT3FrNVl5OG5PVDYv?=
 =?utf-8?B?d2pOT2JBMHNseTJ6Skt5a1puZUYyU1pCZzhJK09yZGJLSUFNUUhzVG42cVJU?=
 =?utf-8?Q?O48cfe?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.4972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94953d6d-0af7-461e-0c0c-08ddb7ffad21
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9200

From: Dean Luick <dean.luick@cornelisnetworks.com>

Add a private data pointer to the ucontext structure and add
per-client pass-throughs.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/sw/rdmavt/vt.c |    8 ++++++++
 include/rdma/rdma_vt.h            |    7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index 5499025e8a0a..d25b970d2891 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -244,6 +244,10 @@ static int rvt_query_gid(struct ib_device *ibdev, u32 port_num,
  */
 static int rvt_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 {
+	struct rvt_dev_info *rdi = ib_to_rvt(uctx->device);
+
+	if (rdi->driver_f.alloc_ucontext)
+		return rdi->driver_f.alloc_ucontext(uctx, udata);
 	return 0;
 }
 
@@ -253,6 +257,10 @@ static int rvt_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
  */
 static void rvt_dealloc_ucontext(struct ib_ucontext *context)
 {
+	struct rvt_dev_info *rdi = ib_to_rvt(context->device);
+
+	if (rdi->driver_f.dealloc_ucontext)
+		rdi->driver_f.dealloc_ucontext(context);
 	return;
 }
 
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index c429d6ddb129..8671c6da16bb 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -149,6 +149,7 @@ struct rvt_driver_params {
 /* User context */
 struct rvt_ucontext {
 	struct ib_ucontext ibucontext;
+	void *priv;
 };
 
 /* Protection domain */
@@ -359,6 +360,12 @@ struct rvt_driver_provided {
 
 	/* Get and return CPU to pin CQ processing thread */
 	int (*comp_vect_cpu_lookup)(struct rvt_dev_info *rdi, int comp_vect);
+
+	/* allocate a ucontext */
+	int (*alloc_ucontext)(struct ib_ucontext *uctx, struct ib_udata *udata);
+
+	/* deallocate a ucontext */
+	void (*dealloc_ucontext)(struct ib_ucontext *context);
 };
 
 struct rvt_dev_info {



