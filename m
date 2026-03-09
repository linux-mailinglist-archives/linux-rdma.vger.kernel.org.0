Return-Path: <linux-rdma+bounces-17813-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePXUOoAxr2kYPgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17813-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:45:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D172410D7
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 318C530B9145
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7836C5BC;
	Mon,  9 Mar 2026 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="OGfOf6XJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022119.outbound.protection.outlook.com [40.93.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2036494E
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089095; cv=fail; b=hU6J1XiV9iIHHQZtAU4kqKsHcV8SI0wmKRfLxQOH7aCj2xif8PrNpC9/B5Riz1hYTLKpedIBNoflhdp+MZzrYfKsD33XvF+UMmzmwrB47nR9vinoHN/qiP7xRed/bW28XiQGgOEQpYoQpasAfFygHyOTucM3YRz1dRYlqKxa8R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089095; c=relaxed/simple;
	bh=wvyaxoJVPp2qNnlfjcrXhtko/VKSn92Y8Zuo2KtPLVw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+jK9Qr4UWYRWrGFupB0wIVUcnJCKx2DqNFdrxfZVi0DEw+EbiuyBqb+XmoWV2RSUfdNRHPcMhQSlkZQVAhcoHyZK5jVE5Aas7IOosLw1q3KWqVeNoOKLzYw1YONd9dBpK35eLLx+5UjuQX/v2W7fcyX2vb6j47Kao0s8LcxrEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=OGfOf6XJ; arc=fail smtp.client-ip=40.93.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb8OPpsBdeRcOb4Jv7WqlEpuguKBVT2UqNUSTnsP7uvK3DIFxGYwbal2TJ+9Os6xKCdVJqgL6YwpvzxyLuTpq8QojTkMh8tzTdsGXrPcBrlcnXw46TKDsvlavRlHket16qPAuOpT2Rwu3rEDknuqdvB+OrzLD55yNa7g9UWtUULQgWDAi6wJN1LZZYvwX0K7TbELcjTWNerdmAwBUPj4WK5yIXNX89GQ+bAYkqkX/42kRx5BobkhNifM1Xb2VIc8uNiCpoQh3WwAy+Pvw3nqtlLh/Pm7OrWoeY2Myvb9xfdoDSpe7L/faR7TAkq8HMfVMU0ABENMge3fNnRrPXvOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmmXrvjnRFWlfrGM5+Gjh/rqqMouk9c1GJGLuQY2tWY=;
 b=DqGzZ/IZsgeKVf1hLoOCdO6h+fcWAUbXJIgq230oDWaLf8j0oq6OKeUoZHIswk5V0BrdTzJX60AqqjEkmW3TYWFvczjE6au3HfJPE69xBmM4MX5opW8GyU8xC5s9UB8Ga6qr2iK1wyM9hjr9hU559P+9E+Nz7qo0DvlhVJXF6lZHsL+rXvrKRlr3Fktwsw5Hycc2jPqhu669x+mGjXmIKALMtjhBjFRVAdv0Lsk6d7qXhZ7X3MRlVER6yN87YhQ32JtudOaw6gKnOBVahNWwo039i4YDSiZtriLplO985wILt853jLueTle250cT4JDbN3iY4coIVfjJiB9TAfp8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmmXrvjnRFWlfrGM5+Gjh/rqqMouk9c1GJGLuQY2tWY=;
 b=OGfOf6XJAwq+gk1eRGoHublqIrVvr0KKjzcwj+g2r8/af71IN3QW47+Vg7pPJFumP94TD5qU6fxtKlYj9/A6Gmzq06mThwQkZQOWDDz+wZbpcKG8k1hIBM7dohLDS0rkVj/n+tK40DGbg8n9PRNUR9HtIgRTBQ80ZqclNxMMW71dvbKwiL7CTB4P/8BPG0nJeen0JC9x6jT52Ch7gkt6E5XMam7e9I+Wiy7zu/4HixiNPQf5uuc9kJkeD/DPNZMy+H2oZRTRvw87nGfsmkva/KcI1/cscig8eyHnm1QV86F8gnUCk72eiUO+dKdaLNUCqKjwg/0sNhnwtUi3rpdXXg==
Received: from DS7PR05CA0006.namprd05.prod.outlook.com (2603:10b6:5:3b9::11)
 by LV5PR01MB994146.prod.exchangelabs.com (2603:10b6:408:363::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Mon, 9 Mar
 2026 20:44:48 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8b) by DS7PR05CA0006.outlook.office365.com
 (2603:10b6:5:3b9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Mon,
 9 Mar 2026 20:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:44:47 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 9E3C614D715;
	Mon,  9 Mar 2026 16:44:44 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 9AE961810D6D7;
	Mon,  9 Mar 2026 16:44:44 -0400 (EDT)
Subject: [PATCH for-next 1/4] RDMA/OPA: Update OPA link speed list
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:44:44 -0400
Message-ID:
 <177308908456.1279894.16723781060261360236.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|LV5PR01MB994146:EE_
X-MS-Office365-Filtering-Correlation-Id: f7770de7-1bfd-40e4-1aef-08de7e1cb3ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	U7Uq9Z0i2zCBqdqu6SLI1n2fM82wposN10uf61e9Le6PY0QCTiXM+Xj7dHktjx6bHkcQNJDszKEnNxf2csXwJCJzgqE562Ebgp7FcgXswAopi0NYYk24WoIr2NV9aBYFyfBBFWYHfUGAeM/LBlGiZGs66BPAuY6ygxHtgUDuc+9+cWMvXfCfh9qkE+E3ipGeFHkeQSSPOwH0m0KAB+ZvDJKRD7VsaZAOXjzMgiIJTVmgc4wRcne3h0ltOjRkcDOx7GpKsMOlH90PQUd1u5S1XeVO1HpOd+gGciuMvlyNLYsUGkn/+ZLTCgsEYD5m5/lMyoXkgYSR23SlBTegLchNKALEN/2nlH+AKLaNWXn6jP3GccBvcjiSxx9SZn1h3F6lZJc1rtpzvxTp/3MssrX4n13v8lOUlzHxqP+NNC5Qroq8nx8IZNNO/PbvWait2McHxairfVxtLIvXNDu5rKtl7SeAc+bwFKpfas/eBYgS/14/X5cLEGb57PasC9HA5+yeSj1JiNahw9dUXv14z3kr1NpVWOU9/I9Vrg2gJkXo1QihUXk3T3kkO+iBn6B2MlY+dwDJGcjosdPYQCT08882UOMTKDv3uMLnZlsYsaxRhC57SUJmHe31c2tihrnHoBZiBVOBQtv3AHcyaBGzhK0ebzZ4fb65JsOp21DSuy4ocbLQKYZUkkSpGue5kJmchhPhnGozMYJWixAYfs/RaM0Fa84UII95Vzhliea2Cg0nd5+MjlUgnsHnCJfyF+CWJNb8v47s4XSvbNniX1XFCZlGHQ==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o7bFFb13k90SekgAa5peX/OCi2g0zUv/TjWvbZlxQTsxMaOXijVEgOoviMKVCuN24rIFOjVhCpaJevz3y6hOPRR94Y3qIi7jNo+tgKkj18q3lWtSRVB2Sqn0AEmG/05WG4n+1TBNb+RvEMb/appTVYBvglvCRH6a97fIKYBajmk16YOUfI6VR4rXhhs9lYWGHmuiHv2BlCvjKi1WJLfOwzwOsR6SkzlgmufHLVcDz0Er1vjV4X2YFllbKMCqK0lsQ2NoHjUM28Vcu9XZnF41J9eWL0WXG5jbbYvhMHSVhIe6phByOEUP61O46DOasjoT24ejYyUWXbPUuWtpqlBNgqb4kSYIoYxnHZfREfyNTA1Tq3LMSN4HaBSpmaGImAAz4Ldwca576QcVI/Drea5eWruuypWbK0oL7W5zJnFNXSZ/ppOg5yh8qGffJq6bKxZc
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:44:47.4654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7770de7-1bfd-40e4-1aef-08de7e1cb3ee
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR01MB994146
X-Rspamd-Queue-Id: 49D172410D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17813-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Dean Luick <dean.luick@cornelisnetworks.com>

Update the list of available link speeds.  Fix comments.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 include/rdma/opa_port_info.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/rdma/opa_port_info.h b/include/rdma/opa_port_info.h
index 73bcac90a048..fb66d3a1dfa9 100644
--- a/include/rdma/opa_port_info.h
+++ b/include/rdma/opa_port_info.h
@@ -93,9 +93,11 @@
 #define OPA_LINKINIT_QUARANTINED                (9 << 4)
 #define OPA_LINKINIT_INSUFIC_CAPABILITY         (10 << 4)
 
-#define OPA_LINK_SPEED_NOP              0x0000  /*  Reserved (1-5 Gbps) */
-#define OPA_LINK_SPEED_12_5G            0x0001  /*  12.5 Gbps */
-#define OPA_LINK_SPEED_25G              0x0002  /*  25.78125?  Gbps (EDR) */
+#define OPA_LINK_SPEED_NOP           0x0000  /* no change */
+#define OPA_LINK_SPEED_12_5G         0x0001  /* 12.5 Gbps */
+#define OPA_LINK_SPEED_25G           0x0002  /* 25.78125 Gbps */
+#define OPA_LINK_SPEED_50G           0x0004  /* 53.125 Gbps */
+#define OPA_LINK_SPEED_100G          0x0008  /* 106.25 Gbps */
 
 #define OPA_LINK_WIDTH_1X            0x0001
 #define OPA_LINK_WIDTH_2X            0x0002



