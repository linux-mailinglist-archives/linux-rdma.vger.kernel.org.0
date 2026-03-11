Return-Path: <linux-rdma+bounces-17981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAekAeamsWn4EAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:31:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A62680AB
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9E63059FDD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303CB36C9FB;
	Wed, 11 Mar 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Ckz+jpCk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022138.outbound.protection.outlook.com [52.101.53.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A89322C6D
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250089; cv=fail; b=tbTKtQlzUHJq15JGIVJieXHQ4w1KwF6lbFqp7/UmZDLgHwmASClR3Ke6j3nElP/tySAYwwCoBeoyTiTJdZRv4AZ5GdzBoKeHjRe+c0/DcNlx4w+dDUJZAkTtH3saQFBId0cCDBxZGSzdkHnV50BJ+EdRG1MyUjDnpqQmDsef9W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250089; c=relaxed/simple;
	bh=6iCCKECAd8Xh0idJtPC2zdRDbySyj7QRBBQS/vnP8iU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdft5RI7T3qedqc0Jh4L7QciRNHcboFL1KEOXVHJa5U6GsvPo2TdbJR9WQnrdQXXUqk8OwpWVDm0W2CMAImbI71ycBCpAdK9NlKwACHpXDvC8P85O6+TTRUROSgz85A+vxHHIaOqDLH5OIVaOepjgjvvpdwZzx3OrigwbKZroe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Ckz+jpCk; arc=fail smtp.client-ip=52.101.53.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1/3YfOZQ62XWqIrYJ6B+Ek7HXrLQoa0KDtneGYxBSJ8OmNheUh5rgk4O8Rj99I6PyerGhK3ypcoZcPXhDNtcxPkam7V7AMZTBBbsE4EmXaNvffxmDUzMhq2fRKSJ4b7L2mLEcBIgmzG+7wJZC373uFeCX2dFtwlNn0NmktpiP+iN90c3DF0hC/Z8SaszdpocQLwREUkLydtmmWFlGTpNcKr6rpyctFqnIVE3Nal0S+P7BIhEa6XYBzYMNFNQ+YEMiRXzRCGSIDxVq0C6v6GLbsZXaJ1f+YnWJvbu8mpjb8vkog9VNoIv4RYo/bb79xJat8hLtENqFtt8GcDGMW9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rq+m7HKO/tQP5Y0xDqjb+r1InAGIASX9+Fm8U4mAhg=;
 b=XX0xoOZI1AkgmalPrVmKdKVi5Mu7ckuEoSM52sQq3AQltYdUtI2kfSbKP1DikLei80JLEnPR3iRUyf7XdTd74ee/XblNd6c3+Y6z5f5iDuIN9kzmfpSO+P2mlSzBo6FP/YT3Hy+pWqupZzPRiE8TZvtlW6YQz8MEXZZcu/64mVT6dqG0TFhIdfGwbXdDD7HD88vLNgpgndr1079trrWLKD0W9Vi9JMdx1A7f8/f3LN7Kl3WL71/apZAbSqtMwqK3KjGdsJwt+egZcoaqo/hIWJPj/XVMYNmytqDml/v54o8bZG4i6HmxEdUT4Hk6z8Rguxj7av+LHsB3yM7fg/3zcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rq+m7HKO/tQP5Y0xDqjb+r1InAGIASX9+Fm8U4mAhg=;
 b=Ckz+jpCkhFQxdbrT/7esAzxaywi88ZsU7tml7/2oqfnj7SNNsT8IAO4r4E/eKM3zdwqSTrCnDukCZ2UGlBd74wgLRyyvkeFynwEVy2pUfDnYBkrRfN3TAXaSG4fm7bbH7cFGhpUlxB/bTXYImbSd3aKN6zkFJu5eVo7/UZ6CqxsjwMRIdwBmKJdMJhVXsub1d+AH46hx6PUbbGkubxjqqavhNh8y/qBlvfJR9FurgHVBcFqhWBqGDXOTlMn9shAJTTah05c6IQIN1ELkVS4u3QrU3jGnEIy6r6StKJRV9GpcThLDfMk97lgGi0prKFbDOuQej6wcQM8eljZAJ4SjWQ==
Received: from BN9PR03CA0062.namprd03.prod.outlook.com (2603:10b6:408:fc::7)
 by DS1PR01MB9037.prod.exchangelabs.com (2603:10b6:8:21d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:28:04 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::a4) by BN9PR03CA0062.outlook.office365.com
 (2603:10b6:408:fc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:28:03 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 5B05814D813;
	Wed, 11 Mar 2026 13:28:03 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 443991810D6C5;
	Wed, 11 Mar 2026 13:28:03 -0400 (EDT)
Subject: [PATCH for-next 2/4] RDMA/rdmavt: Add ucontext alloc/dealloc
 passthrough
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:28:03 -0400
Message-ID:
 <177325008318.52243.7367786996925601681.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS1PR01MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 94404fd5-df38-4f7a-875e-08de7f938d19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|34020700016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DCX5tbKBz7bplvf0HoROxyOvkp+hY6Wn0DyacPpuYobudV/9POERokeq5w0cMen4hSdg7U5HPdhHWfRUiegefxiHJHu5xg1nLa8INeYS0Vq6UBIP99N6CiHEtPKbabBwwNR+4IpFNfN/JNx8Xt4xYwX/ZDCAgC/IdlyyLxeU5fX7KubOLYjrXooQ116dSyx8RMq/ozAS1W415+/CLUJmmbZY0sJ0sZxaSNEKuxlzwEZtBWYEuGeYFUs3KvcZDvlJmh7iSOT33qcIithglKL3dFTFHr6/Gzwi8dx1MQmgrxpLoYRSEjX97Ldv50ERRJRKb+K/7SlNMsXejUAq+0yaxmdz595aHh8r/0aUJRnLRdeELOVqtNelDquB+qIttYgeVF71IabPwoNU/LsRXRbRZWaSnruo7RDxXoQxZ4jvW3TJx/7KM+JIg4zcADyxKWoDIZiJ512+LC9D0OkDuXj5RlRQJsMZQX82SIfrZkQgqT0CIr5SCVxj+84YZt5dFywUTxG9lGRwlgc27n9yG4wIfKXfv3p6VjsqU+W8+Y+uSfKEQixUmsBpx8k4OxjKH4K6uSSOefVZ5/1cKxT7new+7Au9EtoFplpG4QSbqH5msFz/NU07LrRF8SMY9KLPhu0oO3oSAudoz6ia6H1KLqBvO9NOzeUX2ixNN1Hun/p3M5Dmkdhze+TjemEQl46C95wa125X/3eo1drudzLc3PszCrZaS03jcLWFFaE7ijMRDaZmLzGksigd30sfXYBvDCpURcIM1kRu+/BTYlGRw+koAw==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(34020700016)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Czp5sbz9/ScEAhrNB/9w823kLkUeQg7pckgZpAxdsnwp+3HUlLY6xI10kuJkiAlypgf+HLdTeIQSSj0gMCALQYo4I457oyYhEvsd+lVTrGryVfSjaG/duejDWjQtewuOSIWJ7VN3675jgGWnsvw9lQBvRR7qwnPylyNmP7NBiCIjjpZU5aE2W7M3B/DX7yBMJAcDYwAWpTPncCra+TfwxzcHu3XHOsRTQeEHo6LumE1rszvrdwQY430ki48Ux83cy+h8cYk/N2qf45lPUqGZ+kzvrYHyBgS78aqjuq+M+W2OG3NX0bWBZuJII5kIRPKV7XXTSvl1Xtsg0AuhuoNsQmRiGLqnjYXbgYC35YZP2kRlh9k8AvyQXuhPwJjDi5OILSHHYa7c5oqk5en0ejUkDghqez7qzAEykQPSyzzpdLjXwrHqH+EiU1RS5s+U1XIr
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:28:03.6667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94404fd5-df38-4f7a-875e-08de7f938d19
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9037
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17981-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 816A62680AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 0c28b412d81a..033d8932aff1 100644
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



