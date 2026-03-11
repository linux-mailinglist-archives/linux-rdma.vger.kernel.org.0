Return-Path: <linux-rdma+bounces-18005-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOHIE8essWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18005-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B870F26854F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1151C30D7076
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3C3E63A7;
	Wed, 11 Mar 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="FaTPt/kM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020098.outbound.protection.outlook.com [52.101.193.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90853E63AB
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251742; cv=fail; b=dhLcKjPwc3xGUGMquz9PMfviVTQc1h1VAWVa2KHk3bviSHQ+oa+RnBFN4YpiI4/onXnZmioyta7Ldlw6TaSxtJ7gYVV4FlsT76co4JZdb8cX0d2mPwEmbCGvovIm0Ny+srHoKqRdXf11zNgXmFjlKvwTlK+NMvNL4TihU1VP5JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251742; c=relaxed/simple;
	bh=1gd55yLwN4lqgp1tteInPpMJfnnS/I64bfCDkB0TIDI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTt2sUjswfjAuXfLLojaJBW27mSjnCAO32mYL0Eg8T34iMWmlfQoXETyK8ZPsMF4YFRWdU17Ld/PofZSoUcEe28YugDj6NUk+8Smz8CpImIKn/7oSe6t360M1LSf+160m03rFdfUGyBzjIifTiwo10DC66HDcTPi7xL98Ppas5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=FaTPt/kM; arc=fail smtp.client-ip=52.101.193.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyEH5fd+hVCTr8DGMgdBcdYNImM5Un1l+Jv14akx/Itc6DPMPCyRo4mWp/vIQJZ6Y3egGh2dHNGbC0p3juADvZjamZq1XaUA25kSk2hE36YCe8Ixh9s8t2WGbyq7/DqlcaLfAogoC30l6Xwz2rlrcQMiaHvm7lw/i5kgNMOMGp6tbVX5piGgR34IBeK56KdSbVDjA2MhH2Xz/XhKwjp7+G/p0xUJE4lJu/wa5I9XF0fGuLpgma3D/jWrmQdK/fJRi6Dq2/GzTnLPclb1oIuX+lZe319THurFkrqDIpsXrnZMamjHt7H0w6nLDs7I53yJxAUcPm3P+HmrictLzAYmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Z/WEY4LAu16rMwgZvpaXKKknj6xFhIEj9C9kWw8tM=;
 b=j/mrhDIzxGcMA/Dg1ZeHvRvuxoucGiBdVGqHi+SXWwJ36iucDeYuplISILSXsGCYCnrwJR/Mv7xtzXx3R1zMWMj7I37HLC5Mzw66HC1HSugDy587tElNhU7qPql61eglwvM+4aPJ8RL1mAGmzQ+amI36L2oTD7qEBcqlmytNA9XRLe5/R3EyLusrluxlS5MHSUxEcprl1yQkn4Fvy4LJOwmQNZ+Tg9ZIXZ+htY6dXJbHL4QHzhgRao8NKUXy3FzXRNhixKLilfc+zibtBrbk+NNZrj2A1J9fWiR8ynhJwTLkv7aNIHLkaTbQKal6VZ5etnnPOW8tiJIyFK9xysM/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Z/WEY4LAu16rMwgZvpaXKKknj6xFhIEj9C9kWw8tM=;
 b=FaTPt/kMnoV9VUNERxZ6NNZ8rmeWIkU9ueWxwL2BTHbXt0a2Mzaip7PqQsN9a/8rmOEl1PWx2JX3/bP4ba87UPvQx7ugUNzpMuzxwFod+i/umXyqI94YENGvtHb//O47JiSp6Bs2SgYy38VlNtdObebyYf9U5gjss4H48Iil0tN13rLc5vvU2HOv7M5NZgw04DD1eyIx1oYPGnOcdHAsLTyIKDRpOwjY5x3RBNchWn4tTRcu+JIKm5qtsDuGlBbZUmlIQeQ5mtIfRp4dlkGBUPk4XeWKU33Z6Tg4cwLZLkh3E5FhGtN0nQeG94/15Er+gwvFQ6+JUUomd+gtPMeIVA==
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by CO1PR01MB7354.prod.exchangelabs.com (2603:10b6:303:159::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.12; Wed, 11 Mar 2026 17:55:33 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::d5) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.1
 via Frontend Transport; Wed, 11 Mar 2026 17:55:32 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 6841114D819;
	Wed, 11 Mar 2026 13:55:31 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 64DA81810D6C5;
	Wed, 11 Mar 2026 13:55:31 -0400 (EDT)
Subject: [PATCH for-next resend 21/24] RDMA/hfi2: Add misc header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:31 -0400
Message-ID:
 <177325173138.57064.15637996353487915839.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|CO1PR01MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 918b5491-3c8d-44a7-d9f2-08de7f9763e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|82310400026|36860700016|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1pQQCNKQJmwYBVSG0tzVWfn1pi0AFzZ7v+qDpFrvULFfXuEIF5nY3w1z6wUs1fCdCXKie/+NvVFJgdRLDK8JGJw5ttmfbu/ouX3O/9kVE8K4AGiiM7iWPFc5rogADmjinmsilGkhL4T2wPZNMxvydgDZAnF561bqRf2DGbmjOj8lqqMCQmJ2VnZyLGZpZ/MvNOccnjJvtGS797//+Pt9yLSm19Hz6VKLrE1eYb5qbWTZe4LzyxLrveKp/TdYLLslLNCGxUelmMkkxM94IfaqTZQWQAA/9VHFZWlF7jm8RDuu+rBVtJmJzugdh7eAagNVZs+yFbrPXUwzmtUWxRLcS1UYYI5oij4CmHArrf6vOJPizb+CTSJF2tkvxq0crm2MmCEsqmaysEvzox/JQdtGSBShoZZXlYXr3qZNXcsx827u3QejziMvFeLtBJZRsRnlZPlzSH8LvRt+uyWj/aXFYBh2nC4BsTTOHx+rFkRCM3o0in9cknKPaltfBCW5VJdJDH7vaKxrLNw4eLGiRw5YpEkjf076Qz/S8qL3G1wxD8HGpC1UeJ0eb1Idq/MQpLcgtrwQRLADu3gJn4xUTgyOlpGKFCF0CbB6zmNbXP0k6VYYlzEd5c9P4WMTLPGiB3Zz5vFrm4ei7Db44fWPVx2ItRAZ+HROA44HgsFT7DlEhvOwy4cKO9SrCHVHd0x1rO2F9LIuRqR1fDgeb4pRezVbLWhNDH+QMbSRXney61sgc20ixkgGQBZlwxjfu96jtunRvQEwIMu9XGMa1PLhoQ2vBg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(82310400026)(36860700016)(376014)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XqQpY3Nl3uveSh2w5xiqrIlVT5hGpM/h9HsjV1dw1xTb7QmAF8vztNVwcl0poQLEwkL5xDAfBaZJ++1mU9SuiCDmRoVklTFVVfZhvfPlUGI4ZBuq9XhcSixnhr5DQne7WlLx477v94f1ClDbG55V/PfFVxY3DHUSaiHcGkQvSaoSTL7WyqbsngMR2hSm+GjmaVSFXIW2uK+aOO1le/024O5VgCBpB/DvW1A0+B/N7gtYrEO1Sq1gooKa4ag03hEvXUJ7xn2ifRr7/4/86xWwpomUAsMvRR5bN85AShu7T4PTGDa+GWQxLEsRnJ15YMK2zI6HeRw5vTWF1cASI9R+SX//nHw3je5W0XLP9M+KXAG6T+8lmoP4PAZuhc7wQIM0DruHNPm+II65sffjPWBa9POUwYyrmll52AA7LMANc/43y5zHAV4yjyEKiwzFwqnc
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:32.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918b5491-3c8d-44a7-d9f2-08de7f9763e2
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7354
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18005-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: B870F26854F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are a few headers files that didn't really fit with the rest of the
bunch so adding them all separately.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/common.h     |  336 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/debugfs.h    |   66 ++++++
 drivers/infiniband/hw/hfi2/fault.h      |   70 ++++++
 drivers/infiniband/hw/hfi2/opa_compat.h |   87 +++++++
 drivers/infiniband/hw/hfi2/opfn.h       |   88 +++++++
 drivers/infiniband/hw/hfi2/platform.h   |  372 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/qsfp.h       |  202 +++++++++++++++++
 7 files changed, 1221 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/common.h
 create mode 100644 drivers/infiniband/hw/hfi2/debugfs.h
 create mode 100644 drivers/infiniband/hw/hfi2/fault.h
 create mode 100644 drivers/infiniband/hw/hfi2/opa_compat.h
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.h
 create mode 100644 drivers/infiniband/hw/hfi2/platform.h
 create mode 100644 drivers/infiniband/hw/hfi2/qsfp.h

diff --git a/drivers/infiniband/hw/hfi2/common.h b/drivers/infiniband/hw/hfi2/common.h
new file mode 100644
index 000000000000..c70e91ba9103
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/common.h
@@ -0,0 +1,336 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _COMMON_H
+#define _COMMON_H
+
+#include <rdma/hfi2-abi.h>
+
+/*
+ * This file contains defines, structures, etc. that are used
+ * to communicate between kernel and user code.
+ */
+
+/* version of protocol header (known to chip also). In the long run,
+ * we should be able to generate and accept a range of version numbers;
+ * for now we only accept one, and it's compiled in.
+ */
+#define IPS_PROTO_VERSION 2
+
+/*
+ * These are compile time constants that you may want to enable or disable
+ * if you are trying to debug problems with code or performance.
+ * HFI2_VERBOSE_TRACING define as 1 if you want additional tracing in
+ * fast path code
+ * HFI2_TRACE_REGWRITES define as 1 if you want register writes to be
+ * traced in fast path code
+ * _HFI2_TRACING define as 0 if you want to remove all tracing in a
+ * compilation unit
+ */
+
+/* driver/hw feature set bitmask */
+#define HFI2_CAP_USER_SHIFT      24
+#define HFI2_CAP_MASK            ((1UL << HFI2_CAP_USER_SHIFT) - 1)
+/* locked flag - if set, only HFI2_CAP_WRITABLE_MASK bits can be set */
+#define HFI2_CAP_LOCKED_SHIFT    63
+#define HFI2_CAP_LOCKED_MASK     0x1ULL
+#define HFI2_CAP_LOCKED_SMASK    (HFI2_CAP_LOCKED_MASK << HFI2_CAP_LOCKED_SHIFT)
+/* extra bits used between kernel and user processes */
+#define HFI2_CAP_MISC_SHIFT      (HFI2_CAP_USER_SHIFT * 2)
+#define HFI2_CAP_MISC_MASK       ((1ULL << (HFI2_CAP_LOCKED_SHIFT - \
+					   HFI2_CAP_MISC_SHIFT)) - 1)
+
+#define HFI2_CAP_KSET(cap) ({ hfi2_cap_mask |= HFI2_CAP_##cap; hfi2_cap_mask; })
+#define HFI2_CAP_KCLEAR(cap)						\
+	({								\
+		hfi2_cap_mask &= ~HFI2_CAP_##cap;			\
+		hfi2_cap_mask;						\
+	})
+#define HFI2_CAP_USET(cap)						\
+	({								\
+		hfi2_cap_mask |= (HFI2_CAP_##cap << HFI2_CAP_USER_SHIFT); \
+		hfi2_cap_mask;						\
+		})
+#define HFI2_CAP_UCLEAR(cap)						\
+	({								\
+		hfi2_cap_mask &= ~(HFI2_CAP_##cap << HFI2_CAP_USER_SHIFT); \
+		hfi2_cap_mask;						\
+	})
+#define HFI2_CAP_SET(cap)						\
+	({								\
+		hfi2_cap_mask |= (HFI2_CAP_##cap | (HFI2_CAP_##cap <<	\
+						  HFI2_CAP_USER_SHIFT)); \
+		hfi2_cap_mask;						\
+	})
+#define HFI2_CAP_CLEAR(cap)						\
+	({								\
+		hfi2_cap_mask &= ~(HFI2_CAP_##cap |			\
+				  (HFI2_CAP_##cap << HFI2_CAP_USER_SHIFT)); \
+		hfi2_cap_mask;						\
+	})
+#define HFI2_CAP_LOCK()							\
+	({ hfi2_cap_mask |= HFI2_CAP_LOCKED_SMASK; hfi2_cap_mask; })
+#define HFI2_CAP_LOCKED() (!!(hfi2_cap_mask & HFI2_CAP_LOCKED_SMASK))
+/*
+ * The set of capability bits that can be changed after initial load
+ * This set is the same for kernel and user contexts. However, for
+ * user contexts, the set can be further filtered by using the
+ * HFI2_CAP_RESERVED_MASK bits.
+ */
+#define HFI2_CAP_WRITABLE_MASK   (HFI2_CAP_SDMA_AHG |			\
+				  HFI2_CAP_HDRSUPP |			\
+				  HFI2_CAP_MULTI_PKT_EGR |		\
+				  HFI2_CAP_NODROP_RHQ_FULL |		\
+				  HFI2_CAP_NODROP_EGR_FULL |		\
+				  HFI2_CAP_ALLOW_PERM_JKEY |		\
+				  HFI2_CAP_STATIC_RATE_CTRL |		\
+				  HFI2_CAP_PRINT_UNIMPL |		\
+				  HFI2_CAP_TID_UNMAP |			\
+				  HFI2_CAP_OPFN)
+/*
+ * A set of capability bits that are "global" and are not allowed to be
+ * set in the user bitmask.
+ */
+#define HFI2_CAP_RESERVED_MASK   ((HFI2_CAP_SDMA |			\
+				   HFI2_CAP_USE_SDMA_HEAD |		\
+				   HFI2_CAP_EXTENDED_PSN |		\
+				   HFI2_CAP_PRINT_UNIMPL |		\
+				   HFI2_CAP_NO_INTEGRITY |		\
+				   HFI2_CAP_PKEY_CHECK |		\
+				   HFI2_CAP_TID_RDMA |			\
+				   HFI2_CAP_OPFN |			\
+				   HFI2_CAP_AIP) <<			\
+				  HFI2_CAP_USER_SHIFT)
+/*
+ * Set of capabilities that need to be enabled for kernel context in
+ * order to be allowed for user contexts, as well.
+ */
+#define HFI2_CAP_MUST_HAVE_KERN (HFI2_CAP_STATIC_RATE_CTRL)
+/* Default enabled capabilities (both kernel and user) */
+#define HFI2_CAP_MASK_DEFAULT    (HFI2_CAP_HDRSUPP |			\
+				 HFI2_CAP_NODROP_RHQ_FULL |		\
+				 HFI2_CAP_NODROP_EGR_FULL |		\
+				 HFI2_CAP_SDMA |			\
+				 HFI2_CAP_PRINT_UNIMPL |		\
+				 HFI2_CAP_STATIC_RATE_CTRL |		\
+				 HFI2_CAP_PKEY_CHECK |			\
+				 HFI2_CAP_MULTI_PKT_EGR |		\
+				 HFI2_CAP_EXTENDED_PSN |		\
+				 HFI2_CAP_AIP |				\
+				 ((HFI2_CAP_HDRSUPP |			\
+				   HFI2_CAP_MULTI_PKT_EGR |		\
+				   HFI2_CAP_STATIC_RATE_CTRL |		\
+				   HFI2_CAP_PKEY_CHECK |		\
+				   HFI2_CAP_EARLY_CREDIT_RETURN) <<	\
+				  HFI2_CAP_USER_SHIFT))
+/*
+ * A bitmask of kernel/global capabilities that should be communicated
+ * to user level processes.
+ */
+#define HFI2_CAP_K2U (HFI2_CAP_SDMA |			\
+		     HFI2_CAP_EXTENDED_PSN |		\
+		     HFI2_CAP_PKEY_CHECK |		\
+		     HFI2_CAP_NO_INTEGRITY)
+
+#define HFI2_USER_SWVERSION ((HFI2_USER_SWMAJOR << HFI2_SWMAJOR_SHIFT) | \
+			     HFI2_USER_SWMINOR)
+#define HFI2_RDMA_USER_SWVERSION \
+	((HFI2_RDMA_USER_SWMAJOR << HFI2_SWMAJOR_SHIFT) | \
+	 HFI2_RDMA_USER_SWMINOR)
+
+/*
+ * Diagnostics can send a packet by writing the following
+ * struct to the diag packet special file.
+ *
+ * This allows a custom PBC qword, so that special modes and deliberate
+ * changes to CRCs can be used.
+ */
+#define _DIAG_PKT_VERS 1
+struct diag_pkt {
+	__u16 version;		/* structure version */
+	__u16 unit;		/* which device */
+	__u16 sw_index;		/* send sw index to use */
+	__u16 len;		/* data length, in bytes */
+	__u16 port;		/* port number */
+	__u16 unused;
+	__u32 flags;		/* call flags */
+	__u64 data;		/* user data pointer */
+	__u64 pbc;		/* PBC for the packet */
+};
+
+/* diag_pkt flags */
+#define F_DIAGPKT_WAIT 0x1	/* wait until packet is sent */
+
+/*
+ * The next set of defines are for packet headers, and chip register
+ * and memory bits that are visible to and/or used by user-mode software.
+ */
+
+/*
+ * Receive Header Flags
+ */
+#define RHF_PKT_LEN_SHIFT	0
+#define RHF_PKT_LEN_MASK	0xfffull
+#define RHF_PKT_LEN_SMASK (RHF_PKT_LEN_MASK << RHF_PKT_LEN_SHIFT)
+
+#define RHF_RCV_TYPE_SHIFT	12
+#define RHF_RCV_TYPE_MASK	0x7ull
+#define RHF_RCV_TYPE_SMASK (RHF_RCV_TYPE_MASK << RHF_RCV_TYPE_SHIFT)
+
+#define RHF_USE_EGR_BFR_SHIFT	15
+#define RHF_USE_EGR_BFR_MASK	0x1ull
+#define RHF_USE_EGR_BFR_SMASK (RHF_USE_EGR_BFR_MASK << RHF_USE_EGR_BFR_SHIFT)
+
+#define RHF_EGR_INDEX_SHIFT	16
+#define RHF_EGR_INDEX_MASK	0x7ffull
+#define RHF_EGR_INDEX_SMASK (RHF_EGR_INDEX_MASK << RHF_EGR_INDEX_SHIFT)
+
+#define RHF_DC_INFO_SHIFT	27
+#define RHF_DC_INFO_MASK	0x1ull
+#define RHF_DC_INFO_SMASK (RHF_DC_INFO_MASK << RHF_DC_INFO_SHIFT)
+
+#define RHF_RCV_SEQ_SHIFT	28
+#define RHF_RCV_SEQ_MASK	0xfull
+#define RHF_RCV_SEQ_SMASK (RHF_RCV_SEQ_MASK << RHF_RCV_SEQ_SHIFT)
+
+#define RHF_EGR_OFFSET_SHIFT	32
+#define RHF_EGR_OFFSET_MASK	0xfffull
+#define RHF_EGR_OFFSET_SMASK (RHF_EGR_OFFSET_MASK << RHF_EGR_OFFSET_SHIFT)
+#define RHF_HDRQ_OFFSET_SHIFT	44
+#define RHF_HDRQ_OFFSET_MASK	0x1ffull
+#define RHF_HDRQ_OFFSET_SMASK (RHF_HDRQ_OFFSET_MASK << RHF_HDRQ_OFFSET_SHIFT)
+#define RHF_K_HDR_LEN_ERR	(0x1ull << 53)
+#define RHF_DC_UNC_ERR		(0x1ull << 54)
+#define RHF_DC_ERR		(0x1ull << 55)
+#define RHF_RCV_TYPE_ERR_SHIFT	56
+#define RHF_RCV_TYPE_ERR_MASK	0x7ul
+#define RHF_RCV_TYPE_ERR_SMASK (RHF_RCV_TYPE_ERR_MASK << RHF_RCV_TYPE_ERR_SHIFT)
+#define RHF_TID_ERR		(0x1ull << 59)
+#define RHF_LEN_ERR		(0x1ull << 60)
+#define RHF_ECC_ERR		(0x1ull << 61)
+#define RHF_RESERVED		(0x1ull << 62)
+#define RHF_ICRC_ERR		(0x1ull << 63)
+
+#define RHF_ERROR_SMASK 0xffe0000000000000ull		/* bits 63:53 */
+
+/* RHF receive types */
+#define RHF_RCV_TYPE_EXPECTED 0
+#define RHF_RCV_TYPE_EAGER    1
+#define RHF_RCV_TYPE_IB       2 /* normal IB, IB Raw, or IPv6 */
+#define RHF_RCV_TYPE_ERROR    3
+#define RHF_RCV_TYPE_BYPASS   4
+#define RHF_RCV_TYPE_INVALID5 5
+#define RHF_RCV_TYPE_INVALID6 6
+#define RHF_RCV_TYPE_INVALID7 7
+
+/* RHF receive type error - expected packet errors */
+#define RHF_RTE_EXPECTED_FLOW_SEQ_ERR	0x2
+#define RHF_RTE_EXPECTED_FLOW_GEN_ERR	0x4
+
+/* RHF receive type error - eager packet errors */
+#define RHF_RTE_EAGER_NO_ERR		0x0
+
+/* RHF receive type error - IB packet errors */
+#define RHF_RTE_IB_NO_ERR		0x0
+
+/* RHF receive type error - error packet errors */
+#define RHF_RTE_ERROR_NO_ERR		0x0
+#define RHF_RTE_ERROR_OP_CODE_ERR	0x1
+#define RHF_RTE_ERROR_KHDR_MIN_LEN_ERR	0x2
+#define RHF_RTE_ERROR_KHDR_HCRC_ERR	0x3
+#define RHF_RTE_ERROR_KHDR_KVER_ERR	0x4
+#define RHF_RTE_ERROR_CONTEXT_ERR	0x5
+#define RHF_RTE_ERROR_KHDR_TID_ERR	0x6
+
+/* RHF receive type error - bypass packet errors */
+#define RHF_RTE_BYPASS_NO_ERR		0x0
+
+/* MAX RcvSEQ */
+#define RHF_MAX_SEQ 13
+
+/* IB - LRH header constants */
+#define HFI2_LRH_GRH 0x0003      /* 1. word of IB LRH - next header: GRH */
+#define HFI2_LRH_BTH 0x0002      /* 1. word of IB LRH - next header: BTH */
+
+/* misc. */
+#define SC15_PACKET 0xF
+#define SIZE_OF_CRC 1
+#define SIZE_OF_LT 1
+#define MAX_16B_PADDING 16 /* CRC = 4 or 8, LT = 1, Pad = 0 to 7 bytes */
+
+#define LIM_MGMT_P_KEY       0x7FFF
+#define FULL_MGMT_P_KEY      0xFFFF
+
+#define DEFAULT_P_KEY LIM_MGMT_P_KEY
+
+#define HFI2_PSM_IOC_BASE_SEQ 0x0
+
+/* Number of BTH.PSN bits used for sequence number in expected rcvs */
+#define HFI2_KDETH_BTH_SEQ_SHIFT 11
+#define HFI2_KDETH_BTH_SEQ_MASK (BIT(HFI2_KDETH_BTH_SEQ_SHIFT) - 1)
+
+static inline __u64 rhf_to_cpu(const __le32 *rbuf)
+{
+	return __le64_to_cpu(*((__le64 *)rbuf));
+}
+
+static inline u64 wfr_rhf_err_flags(u64 rhf)
+{
+	return rhf & RHF_ERROR_SMASK;
+}
+
+static inline u32 rhf_rcv_type(u64 rhf)
+{
+	return (rhf >> RHF_RCV_TYPE_SHIFT) & RHF_RCV_TYPE_MASK;
+}
+
+static inline u32 wfr_rhf_rcv_type_err(u64 rhf)
+{
+	return (rhf >> RHF_RCV_TYPE_ERR_SHIFT) & RHF_RCV_TYPE_ERR_MASK;
+}
+
+/* return size is in bytes, not DWORDs */
+static inline u32 rhf_pkt_len(u64 rhf)
+{
+	return ((rhf & RHF_PKT_LEN_SMASK) >> RHF_PKT_LEN_SHIFT) << 2;
+}
+
+static inline u32 wfr_rhf_egr_index(u64 rhf)
+{
+	return (rhf >> RHF_EGR_INDEX_SHIFT) & RHF_EGR_INDEX_MASK;
+}
+
+static inline u32 wfr_rhf_rcv_seq(u64 rhf)
+{
+	return (rhf >> RHF_RCV_SEQ_SHIFT) & RHF_RCV_SEQ_MASK;
+}
+
+static inline u32 jkr_rhf_rcv_seq(u64 rhf)
+{
+	return (rhf >> 56) & 0xf; /* RHF.RcvSeq */
+}
+
+/* returned offset is in DWORDS */
+static inline u32 rhf_hdrq_offset(u64 rhf)
+{
+	return (rhf >> RHF_HDRQ_OFFSET_SHIFT) & RHF_HDRQ_OFFSET_MASK;
+}
+
+static inline u64 rhf_use_egr_bfr(u64 rhf)
+{
+	return rhf & RHF_USE_EGR_BFR_SMASK;
+}
+
+static inline u64 wfr_rhf_dc_info(u64 rhf)
+{
+	return rhf & RHF_DC_INFO_SMASK;
+}
+
+static inline u32 rhf_egr_buf_offset(u64 rhf)
+{
+	return (rhf >> RHF_EGR_OFFSET_SHIFT) & RHF_EGR_OFFSET_MASK;
+}
+#endif /* _COMMON_H */
diff --git a/drivers/infiniband/hw/hfi2/debugfs.h b/drivers/infiniband/hw/hfi2/debugfs.h
new file mode 100644
index 000000000000..c41b3a468dc9
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/debugfs.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016, 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_DEBUGFS_H
+#define _HFI2_DEBUGFS_H
+
+struct hfi2_ibdev;
+
+#define DEBUGFS_SEQ_FILE_OPS(name) \
+static const struct seq_operations _##name##_seq_ops = { \
+	.start = _##name##_seq_start, \
+	.next  = _##name##_seq_next, \
+	.stop  = _##name##_seq_stop, \
+	.show  = _##name##_seq_show \
+}
+
+#define DEBUGFS_SEQ_FILE_OPEN(name) \
+static int _##name##_open(struct inode *inode, struct file *s) \
+{ \
+	struct seq_file *seq; \
+	int ret; \
+	ret =  seq_open(s, &_##name##_seq_ops); \
+	if (ret) \
+		return ret; \
+	seq = s->private_data; \
+	seq->private = inode->i_private; \
+	return 0; \
+}
+
+#define DEBUGFS_FILE_OPS(name) \
+static const struct file_operations _##name##_file_ops = { \
+	.owner   = THIS_MODULE, \
+	.open    = _##name##_open, \
+	.read    = seq_read, \
+	.llseek  = seq_lseek, \
+	.release = seq_release \
+}
+
+#ifdef CONFIG_DEBUG_FS
+void hfi2_dbg_ibdev_init(struct hfi2_ibdev *ibd);
+void hfi2_dbg_ibdev_exit(struct hfi2_ibdev *ibd);
+void hfi2_dbg_init(void);
+void hfi2_dbg_exit(void);
+
+#else
+static inline void hfi2_dbg_ibdev_init(struct hfi2_ibdev *ibd)
+{
+}
+
+static inline void hfi2_dbg_ibdev_exit(struct hfi2_ibdev *ibd)
+{
+}
+
+static inline void hfi2_dbg_init(void)
+{
+}
+
+static inline void hfi2_dbg_exit(void)
+{
+}
+#endif
+
+#endif                          /* _HFI2_DEBUGFS_H */
diff --git a/drivers/infiniband/hw/hfi2/fault.h b/drivers/infiniband/hw/hfi2/fault.h
new file mode 100644
index 000000000000..58736ce447c0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/fault.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_FAULT_H
+#define _HFI2_FAULT_H
+
+#include <linux/fault-inject.h>
+#include <linux/dcache.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <rdma/rdma_vt.h>
+
+#include "hfi2.h"
+
+struct hfi2_ibdev;
+
+#if defined(CONFIG_FAULT_INJECTION) && defined(CONFIG_FAULT_INJECTION_DEBUG_FS)
+struct fault {
+	struct fault_attr attr;
+	struct dentry *dir;
+	u64 n_rxfaults[(1U << BITS_PER_BYTE)];
+	u64 n_txfaults[(1U << BITS_PER_BYTE)];
+	u64 fault_skip;
+	u64 skip;
+	u64 fault_skip_usec;
+	unsigned long skip_usec;
+	unsigned long opcodes[(1U << BITS_PER_BYTE) / BITS_PER_LONG];
+	bool enable;
+	bool suppress_err;
+	bool opcode;
+	u8 direction;
+};
+
+int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd);
+bool hfi2_dbg_should_fault_tx(struct rvt_qp *qp, u32 opcode);
+bool hfi2_dbg_should_fault_rx(struct hfi2_packet *packet);
+bool hfi2_dbg_fault_suppress_err(struct hfi2_ibdev *ibd);
+void hfi2_fault_exit_debugfs(struct hfi2_ibdev *ibd);
+
+#else
+
+static inline int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd)
+{
+	return 0;
+}
+
+static inline bool hfi2_dbg_should_fault_rx(struct hfi2_packet *packet)
+{
+	return false;
+}
+
+static inline bool hfi2_dbg_should_fault_tx(struct rvt_qp *qp,
+					    u32 opcode)
+{
+	return false;
+}
+
+static inline bool hfi2_dbg_fault_suppress_err(struct hfi2_ibdev *ibd)
+{
+	return false;
+}
+
+static inline void hfi2_fault_exit_debugfs(struct hfi2_ibdev *ibd)
+{
+}
+#endif
+#endif /* _HFI2_FAULT_H */
diff --git a/drivers/infiniband/hw/hfi2/opa_compat.h b/drivers/infiniband/hw/hfi2/opa_compat.h
new file mode 100644
index 000000000000..8e8b7f62082a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/opa_compat.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef _LINUX_H
+#define _LINUX_H
+/*
+ * This header file is for OPA-specific definitions which are
+ * required by the HFI driver, and which aren't yet in the Linux
+ * IB core. We'll collect these all here, then merge them into
+ * the kernel when that's convenient.
+ */
+
+/* OPA SMA attribute IDs */
+#define OPA_ATTRIB_ID_CONGESTION_INFO		cpu_to_be16(0x008b)
+#define OPA_ATTRIB_ID_HFI_CONGESTION_LOG	cpu_to_be16(0x008f)
+#define OPA_ATTRIB_ID_HFI_CONGESTION_SETTING	cpu_to_be16(0x0090)
+#define OPA_ATTRIB_ID_CONGESTION_CONTROL_TABLE	cpu_to_be16(0x0091)
+
+/* OPA PMA attribute IDs */
+#define OPA_PM_ATTRIB_ID_PORT_STATUS		cpu_to_be16(0x0040)
+#define OPA_PM_ATTRIB_ID_CLEAR_PORT_STATUS	cpu_to_be16(0x0041)
+#define OPA_PM_ATTRIB_ID_DATA_PORT_COUNTERS	cpu_to_be16(0x0042)
+#define OPA_PM_ATTRIB_ID_ERROR_PORT_COUNTERS	cpu_to_be16(0x0043)
+#define OPA_PM_ATTRIB_ID_ERROR_INFO		cpu_to_be16(0x0044)
+
+/* OPA status codes */
+#define OPA_PM_STATUS_REQUEST_TOO_LARGE		cpu_to_be16(0x100)
+
+static inline u8 port_states_to_logical_state(struct opa_port_states *ps)
+{
+	return ps->portphysstate_portstate & OPA_PI_MASK_PORT_STATE;
+}
+
+static inline u8 port_states_to_phys_state(struct opa_port_states *ps)
+{
+	return ((ps->portphysstate_portstate &
+		  OPA_PI_MASK_PORT_PHYSICAL_STATE) >> 4) & 0xf;
+}
+
+/*
+ * OPA port physical states
+ * IB Volume 1, Table 146 PortInfo/IB Volume 2 Section 5.4.2(1) PortPhysState
+ * values are the same in OmniPath Architecture. OPA leverages some of the same
+ * concepts as InfiniBand, but has a few other states as well.
+ *
+ * When writing, only values 0-3 are valid, other values are ignored.
+ * When reading, 0 is reserved.
+ *
+ * Returned by the ibphys_portstate() routine.
+ */
+enum opa_port_phys_state {
+	/* Values 0-7 have the same meaning in OPA as in InfiniBand. */
+
+	IB_PORTPHYSSTATE_NOP = 0,
+	/* 1 is reserved */
+	IB_PORTPHYSSTATE_POLLING = 2,
+	IB_PORTPHYSSTATE_DISABLED = 3,
+	IB_PORTPHYSSTATE_TRAINING = 4,
+	IB_PORTPHYSSTATE_LINKUP = 5,
+	IB_PORTPHYSSTATE_LINK_ERROR_RECOVERY = 6,
+	IB_PORTPHYSSTATE_PHY_TEST = 7,
+	/* 8 is reserved */
+
+	/*
+	 * Offline: Port is quiet (transmitters disabled) due to lack of
+	 * physical media, unsupported media, or transition between link up
+	 * and next link up attempt
+	 */
+	OPA_PORTPHYSSTATE_OFFLINE = 9,
+
+	/* 10 is reserved */
+
+	/*
+	 * Phy_Test: Specific test patterns are transmitted, and receiver BER
+	 * can be monitored. This facilitates signal integrity testing for the
+	 * physical layer of the port.
+	 */
+	OPA_PORTPHYSSTATE_TEST = 11,
+
+	OPA_PORTPHYSSTATE_MAX = 11,
+	/* values 12-15 are reserved/ignored */
+};
+
+#endif /* _LINUX_H */
diff --git a/drivers/infiniband/hw/hfi2/opfn.h b/drivers/infiniband/hw/hfi2/opfn.h
new file mode 100644
index 000000000000..c706cc28a1d3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/opfn.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ */
+#ifndef _HFI2_OPFN_H
+#define _HFI2_OPFN_H
+
+/**
+ * DOC: Omni Path Feature Negotion (OPFN)
+ *
+ * OPFN is a discovery protocol for Intel Omni-Path fabric that
+ * allows two RC QPs to negotiate a common feature that both QPs
+ * can support. Currently, the only OPA feature that OPFN
+ * supports is TID RDMA.
+ *
+ * Architecture
+ *
+ * OPFN involves the communication between two QPs on the HFI
+ * level on an Omni-Path fabric, and ULPs have no knowledge of
+ * OPFN at all.
+ *
+ * Implementation
+ *
+ * OPFN extends the existing IB RC protocol with the following
+ * changes:
+ * -- Uses Bit 24 (reserved) of DWORD 1 of Base Transport
+ *    Header (BTH1) to indicate that the RC QP supports OPFN;
+ * -- Uses a combination of RC COMPARE_SWAP opcode (0x13) and
+ *    the address U64_MAX (0xFFFFFFFFFFFFFFFF) as an OPFN
+ *    request; The 64-bit data carried with the request/response
+ *    contains the parameters for negotiation and will be
+ *    defined in tid_rdma.c file;
+ * -- Defines IB_WR_RESERVED3 as IB_WR_OPFN.
+ *
+ * The OPFN communication will be triggered when an RC QP
+ * receives a request with Bit 24 of BTH1 set. The responder QP
+ * will then post send an OPFN request with its local
+ * parameters, which will be sent to the requester QP once all
+ * existing requests on the responder QP side have been sent.
+ * Once the requester QP receives the OPFN request, it will
+ * keep a copy of the responder QP's parameters, and return a
+ * response packet with its own local parameters. The responder
+ * QP receives the response packet and keeps a copy of the requester
+ * QP's parameters. After this exchange, each side has the parameters
+ * for both sides and therefore can select the right parameters
+ * for future transactions
+ */
+
+#include <linux/workqueue.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/rdmavt_qp.h>
+
+/* STL Verbs Extended */
+#define IB_BTHE_E_SHIFT           24
+#define HFI2_VERBS_E_ATOMIC_VADDR U64_MAX
+
+enum hfi2_opfn_codes {
+	STL_VERBS_EXTD_NONE = 0,
+	STL_VERBS_EXTD_TID_RDMA,
+	STL_VERBS_EXTD_MAX
+};
+
+struct hfi2_opfn_data {
+	u8 extended;
+	u16 requested;
+	u16 completed;
+	enum hfi2_opfn_codes curr;
+	/* serialize opfn function calls */
+	spinlock_t lock;
+	struct work_struct opfn_work;
+};
+
+/* WR opcode for OPFN */
+#define IB_WR_OPFN IB_WR_RESERVED3
+
+void opfn_send_conn_request(struct work_struct *work);
+void opfn_conn_response(struct rvt_qp *qp, struct rvt_ack_entry *e,
+			struct ib_atomic_eth *ateth);
+void opfn_conn_reply(struct rvt_qp *qp, u64 data);
+void opfn_conn_error(struct rvt_qp *qp);
+void opfn_qp_init(struct rvt_qp *qp, struct ib_qp_attr *attr, int attr_mask);
+void opfn_trigger_conn_request(struct rvt_qp *qp, u32 bth1);
+int opfn_init(void);
+void opfn_exit(void);
+
+#endif /* _HFI2_OPFN_H */
diff --git a/drivers/infiniband/hw/hfi2/platform.h b/drivers/infiniband/hw/hfi2/platform.h
new file mode 100644
index 000000000000..f886c2c3dd1c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/platform.h
@@ -0,0 +1,372 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#ifndef __PLATFORM_H
+#define __PLATFORM_H
+
+#define METADATA_TABLE_FIELD_START_SHIFT		0
+#define METADATA_TABLE_FIELD_START_LEN_BITS		15
+#define METADATA_TABLE_FIELD_LEN_SHIFT			16
+#define METADATA_TABLE_FIELD_LEN_LEN_BITS		16
+
+/* Header structure */
+#define PLATFORM_CONFIG_HEADER_RECORD_IDX_SHIFT			0
+#define PLATFORM_CONFIG_HEADER_RECORD_IDX_LEN_BITS		6
+#define PLATFORM_CONFIG_HEADER_TABLE_LENGTH_SHIFT		16
+#define PLATFORM_CONFIG_HEADER_TABLE_LENGTH_LEN_BITS		12
+#define PLATFORM_CONFIG_HEADER_TABLE_TYPE_SHIFT			28
+#define PLATFORM_CONFIG_HEADER_TABLE_TYPE_LEN_BITS		4
+
+enum platform_config_table_type_encoding {
+	PLATFORM_CONFIG_TABLE_RESERVED,
+	PLATFORM_CONFIG_SYSTEM_TABLE,
+	PLATFORM_CONFIG_PORT_TABLE,
+	PLATFORM_CONFIG_RX_PRESET_TABLE,
+	PLATFORM_CONFIG_TX_PRESET_TABLE,
+	PLATFORM_CONFIG_QSFP_ATTEN_TABLE,
+	PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE,
+	PLATFORM_CONFIG_TABLE_MAX
+};
+
+enum platform_config_system_table_fields {
+	SYSTEM_TABLE_RESERVED,
+	SYSTEM_TABLE_NODE_STRING,
+	SYSTEM_TABLE_SYSTEM_IMAGE_GUID,
+	SYSTEM_TABLE_NODE_GUID,
+	SYSTEM_TABLE_REVISION,
+	SYSTEM_TABLE_VENDOR_OUI,
+	SYSTEM_TABLE_META_VERSION,
+	SYSTEM_TABLE_DEVICE_ID,
+	SYSTEM_TABLE_PARTITION_ENFORCEMENT_CAP,
+	SYSTEM_TABLE_QSFP_POWER_CLASS_MAX,
+	SYSTEM_TABLE_QSFP_ATTENUATION_DEFAULT_12G,
+	SYSTEM_TABLE_QSFP_ATTENUATION_DEFAULT_25G,
+	SYSTEM_TABLE_VARIABLE_TABLE_ENTRIES_PER_PORT,
+	SYSTEM_TABLE_MAX
+};
+
+enum platform_config_port_table_fields {
+	PORT_TABLE_RESERVED,
+	PORT_TABLE_PORT_TYPE,
+	PORT_TABLE_LOCAL_ATTEN_12G,
+	PORT_TABLE_LOCAL_ATTEN_25G,
+	PORT_TABLE_LINK_SPEED_SUPPORTED,
+	PORT_TABLE_LINK_WIDTH_SUPPORTED,
+	PORT_TABLE_AUTO_LANE_SHEDDING_ENABLED,
+	PORT_TABLE_EXTERNAL_LOOPBACK_ALLOWED,
+	PORT_TABLE_VL_CAP,
+	PORT_TABLE_MTU_CAP,
+	PORT_TABLE_TX_LANE_ENABLE_MASK,
+	PORT_TABLE_LOCAL_MAX_TIMEOUT,
+	PORT_TABLE_REMOTE_ATTEN_12G,
+	PORT_TABLE_REMOTE_ATTEN_25G,
+	PORT_TABLE_TX_PRESET_IDX_ACTIVE_NO_EQ,
+	PORT_TABLE_TX_PRESET_IDX_ACTIVE_EQ,
+	PORT_TABLE_RX_PRESET_IDX,
+	PORT_TABLE_CABLE_REACH_CLASS,
+	PORT_TABLE_MAX
+};
+
+enum platform_config_rx_preset_table_fields {
+	RX_PRESET_TABLE_RESERVED,
+	RX_PRESET_TABLE_QSFP_RX_CDR_APPLY,
+	RX_PRESET_TABLE_QSFP_RX_EMP_APPLY,
+	RX_PRESET_TABLE_QSFP_RX_AMP_APPLY,
+	RX_PRESET_TABLE_QSFP_RX_CDR,
+	RX_PRESET_TABLE_QSFP_RX_EMP,
+	RX_PRESET_TABLE_QSFP_RX_AMP,
+	RX_PRESET_TABLE_MAX
+};
+
+enum platform_config_tx_preset_table_fields {
+	TX_PRESET_TABLE_RESERVED,
+	TX_PRESET_TABLE_PRECUR,
+	TX_PRESET_TABLE_ATTN,
+	TX_PRESET_TABLE_POSTCUR,
+	TX_PRESET_TABLE_QSFP_TX_CDR_APPLY,
+	TX_PRESET_TABLE_QSFP_TX_EQ_APPLY,
+	TX_PRESET_TABLE_QSFP_TX_CDR,
+	TX_PRESET_TABLE_QSFP_TX_EQ,
+	TX_PRESET_TABLE_MAX
+};
+
+enum platform_config_qsfp_attn_table_fields {
+	QSFP_ATTEN_TABLE_RESERVED,
+	QSFP_ATTEN_TABLE_TX_PRESET_IDX,
+	QSFP_ATTEN_TABLE_RX_PRESET_IDX,
+	QSFP_ATTEN_TABLE_MAX
+};
+
+enum platform_config_variable_settings_table_fields {
+	VARIABLE_SETTINGS_TABLE_RESERVED,
+	VARIABLE_SETTINGS_TABLE_TX_PRESET_IDX,
+	VARIABLE_SETTINGS_TABLE_RX_PRESET_IDX,
+	VARIABLE_SETTINGS_TABLE_MAX
+};
+
+struct platform_config {
+	size_t size;
+	const u8 *data;
+};
+
+struct platform_config_data {
+	u32 *table;
+	u32 *table_metadata;
+	u32 num_table;
+};
+
+/*
+ * This struct acts as a quick reference into the platform_data binary image
+ * and is populated by parse_platform_config(...) depending on the specific
+ * META_VERSION
+ */
+struct platform_config_cache {
+	u8  cache_valid;
+	struct platform_config_data config_tables[PLATFORM_CONFIG_TABLE_MAX];
+};
+
+/* This section defines default values and encodings for the
+ * fields defined for each table above
+ */
+
+/*
+ * =====================================================
+ *  System table encodings
+ * =====================================================
+ */
+#define PLATFORM_CONFIG_MAGIC_NUM		0x3d4f5041
+#define PLATFORM_CONFIG_MAGIC_NUMBER_LEN	4
+
+/*
+ * These power classes are the same as defined in SFF 8636 spec rev 2.4
+ * describing byte 129 in table 6-16, except enumerated in a different order
+ */
+enum platform_config_qsfp_power_class_encoding {
+	QSFP_POWER_CLASS_1 = 1,
+	QSFP_POWER_CLASS_2,
+	QSFP_POWER_CLASS_3,
+	QSFP_POWER_CLASS_4,
+	QSFP_POWER_CLASS_5,
+	QSFP_POWER_CLASS_6,
+	QSFP_POWER_CLASS_7
+};
+
+/*
+ * ====================================================
+ *  Port table encodings
+ * ====================================================
+ */
+enum platform_config_port_type_encoding {
+	PORT_TYPE_UNKNOWN,
+	PORT_TYPE_DISCONNECTED,
+	PORT_TYPE_FIXED,
+	PORT_TYPE_VARIABLE,
+	PORT_TYPE_QSFP,
+	PORT_TYPE_MAX
+};
+
+enum platform_config_link_speed_supported_encoding {
+	LINK_SPEED_SUPP_12G = 1,
+	LINK_SPEED_SUPP_25G,
+	LINK_SPEED_SUPP_12G_25G,
+	LINK_SPEED_SUPP_MAX
+};
+
+/*
+ * This is a subset (not strict) of the link downgrades
+ * supported. The link downgrades supported are expected
+ * to be supplied to the driver by another entity such as
+ * the fabric manager
+ */
+enum platform_config_link_width_supported_encoding {
+	LINK_WIDTH_SUPP_1X = 1,
+	LINK_WIDTH_SUPP_2X,
+	LINK_WIDTH_SUPP_2X_1X,
+	LINK_WIDTH_SUPP_3X,
+	LINK_WIDTH_SUPP_3X_1X,
+	LINK_WIDTH_SUPP_3X_2X,
+	LINK_WIDTH_SUPP_3X_2X_1X,
+	LINK_WIDTH_SUPP_4X,
+	LINK_WIDTH_SUPP_4X_1X,
+	LINK_WIDTH_SUPP_4X_2X,
+	LINK_WIDTH_SUPP_4X_2X_1X,
+	LINK_WIDTH_SUPP_4X_3X,
+	LINK_WIDTH_SUPP_4X_3X_1X,
+	LINK_WIDTH_SUPP_4X_3X_2X,
+	LINK_WIDTH_SUPP_4X_3X_2X_1X,
+	LINK_WIDTH_SUPP_MAX
+};
+
+enum platform_config_virtual_lane_capability_encoding {
+	VL_CAP_VL0 = 1,
+	VL_CAP_VL0_1,
+	VL_CAP_VL0_2,
+	VL_CAP_VL0_3,
+	VL_CAP_VL0_4,
+	VL_CAP_VL0_5,
+	VL_CAP_VL0_6,
+	VL_CAP_VL0_7,
+	VL_CAP_VL0_8,
+	VL_CAP_VL0_9,
+	VL_CAP_VL0_10,
+	VL_CAP_VL0_11,
+	VL_CAP_VL0_12,
+	VL_CAP_VL0_13,
+	VL_CAP_VL0_14,
+	VL_CAP_MAX
+};
+
+/* Max MTU */
+enum platform_config_mtu_capability_encoding {
+	MTU_CAP_256   = 1,
+	MTU_CAP_512   = 2,
+	MTU_CAP_1024  = 3,
+	MTU_CAP_2048  = 4,
+	MTU_CAP_4096  = 5,
+	MTU_CAP_8192  = 6,
+	MTU_CAP_10240 = 7
+};
+
+enum platform_config_local_max_timeout_encoding {
+	LOCAL_MAX_TIMEOUT_10_MS = 1,
+	LOCAL_MAX_TIMEOUT_100_MS,
+	LOCAL_MAX_TIMEOUT_1_S,
+	LOCAL_MAX_TIMEOUT_10_S,
+	LOCAL_MAX_TIMEOUT_100_S,
+	LOCAL_MAX_TIMEOUT_1000_S
+};
+
+enum link_tuning_encoding {
+	OPA_PASSIVE_TUNING,
+	OPA_ACTIVE_TUNING,
+	OPA_UNKNOWN_TUNING
+};
+
+/*
+ * Shifts and masks for the link SI tuning values stuffed into the ASIC scratch
+ * registers for integrated platforms
+ */
+#define PORT0_PORT_TYPE_SHIFT		0
+#define PORT0_LOCAL_ATTEN_SHIFT		4
+#define PORT0_REMOTE_ATTEN_SHIFT	10
+#define PORT0_DEFAULT_ATTEN_SHIFT	32
+
+#define PORT1_PORT_TYPE_SHIFT		16
+#define PORT1_LOCAL_ATTEN_SHIFT		20
+#define PORT1_REMOTE_ATTEN_SHIFT	26
+#define PORT1_DEFAULT_ATTEN_SHIFT	40
+
+#define PORT0_PORT_TYPE_MASK		0xFUL
+#define PORT0_LOCAL_ATTEN_MASK		0x3FUL
+#define PORT0_REMOTE_ATTEN_MASK		0x3FUL
+#define PORT0_DEFAULT_ATTEN_MASK	0xFFUL
+
+#define PORT1_PORT_TYPE_MASK		0xFUL
+#define PORT1_LOCAL_ATTEN_MASK		0x3FUL
+#define PORT1_REMOTE_ATTEN_MASK		0x3FUL
+#define PORT1_DEFAULT_ATTEN_MASK	0xFFUL
+
+#define PORT0_PORT_TYPE_SMASK		(PORT0_PORT_TYPE_MASK << \
+					 PORT0_PORT_TYPE_SHIFT)
+#define PORT0_LOCAL_ATTEN_SMASK		(PORT0_LOCAL_ATTEN_MASK << \
+					 PORT0_LOCAL_ATTEN_SHIFT)
+#define PORT0_REMOTE_ATTEN_SMASK	(PORT0_REMOTE_ATTEN_MASK << \
+					 PORT0_REMOTE_ATTEN_SHIFT)
+#define PORT0_DEFAULT_ATTEN_SMASK	(PORT0_DEFAULT_ATTEN_MASK << \
+					 PORT0_DEFAULT_ATTEN_SHIFT)
+
+#define PORT1_PORT_TYPE_SMASK		(PORT1_PORT_TYPE_MASK << \
+					 PORT1_PORT_TYPE_SHIFT)
+#define PORT1_LOCAL_ATTEN_SMASK		(PORT1_LOCAL_ATTEN_MASK << \
+					 PORT1_LOCAL_ATTEN_SHIFT)
+#define PORT1_REMOTE_ATTEN_SMASK	(PORT1_REMOTE_ATTEN_MASK << \
+					 PORT1_REMOTE_ATTEN_SHIFT)
+#define PORT1_DEFAULT_ATTEN_SMASK	(PORT1_DEFAULT_ATTEN_MASK << \
+					 PORT1_DEFAULT_ATTEN_SHIFT)
+
+#define QSFP_MAX_POWER_SHIFT		0
+#define TX_NO_EQ_SHIFT			4
+#define TX_EQ_SHIFT			25
+#define RX_SHIFT			46
+
+#define QSFP_MAX_POWER_MASK		0xFUL
+#define TX_NO_EQ_MASK			0x1FFFFFUL
+#define TX_EQ_MASK			0x1FFFFFUL
+#define RX_MASK				0xFFFFUL
+
+#define QSFP_MAX_POWER_SMASK		(QSFP_MAX_POWER_MASK << \
+					 QSFP_MAX_POWER_SHIFT)
+#define TX_NO_EQ_SMASK			(TX_NO_EQ_MASK << TX_NO_EQ_SHIFT)
+#define TX_EQ_SMASK			(TX_EQ_MASK << TX_EQ_SHIFT)
+#define RX_SMASK			(RX_MASK << RX_SHIFT)
+
+#define TX_PRECUR_SHIFT			0
+#define TX_ATTN_SHIFT			4
+#define QSFP_TX_CDR_APPLY_SHIFT		9
+#define QSFP_TX_EQ_APPLY_SHIFT		10
+#define QSFP_TX_CDR_SHIFT		11
+#define QSFP_TX_EQ_SHIFT		12
+#define TX_POSTCUR_SHIFT		16
+
+#define TX_PRECUR_MASK			0xFUL
+#define TX_ATTN_MASK			0x1FUL
+#define QSFP_TX_CDR_APPLY_MASK		0x1UL
+#define QSFP_TX_EQ_APPLY_MASK		0x1UL
+#define QSFP_TX_CDR_MASK		0x1UL
+#define QSFP_TX_EQ_MASK			0xFUL
+#define TX_POSTCUR_MASK			0x1FUL
+
+#define TX_PRECUR_SMASK			(TX_PRECUR_MASK << TX_PRECUR_SHIFT)
+#define TX_ATTN_SMASK			(TX_ATTN_MASK << TX_ATTN_SHIFT)
+#define QSFP_TX_CDR_APPLY_SMASK		(QSFP_TX_CDR_APPLY_MASK << \
+					 QSFP_TX_CDR_APPLY_SHIFT)
+#define QSFP_TX_EQ_APPLY_SMASK		(QSFP_TX_EQ_APPLY_MASK << \
+					 QSFP_TX_EQ_APPLY_SHIFT)
+#define QSFP_TX_CDR_SMASK		(QSFP_TX_CDR_MASK << QSFP_TX_CDR_SHIFT)
+#define QSFP_TX_EQ_SMASK		(QSFP_TX_EQ_MASK << QSFP_TX_EQ_SHIFT)
+#define TX_POSTCUR_SMASK		(TX_POSTCUR_MASK << TX_POSTCUR_SHIFT)
+
+#define QSFP_RX_CDR_APPLY_SHIFT		0
+#define QSFP_RX_EMP_APPLY_SHIFT		1
+#define QSFP_RX_AMP_APPLY_SHIFT		2
+#define QSFP_RX_CDR_SHIFT		3
+#define QSFP_RX_EMP_SHIFT		4
+#define QSFP_RX_AMP_SHIFT		8
+
+#define QSFP_RX_CDR_APPLY_MASK		0x1UL
+#define QSFP_RX_EMP_APPLY_MASK		0x1UL
+#define QSFP_RX_AMP_APPLY_MASK		0x1UL
+#define QSFP_RX_CDR_MASK		0x1UL
+#define QSFP_RX_EMP_MASK		0xFUL
+#define QSFP_RX_AMP_MASK		0x3UL
+
+#define QSFP_RX_CDR_APPLY_SMASK		(QSFP_RX_CDR_APPLY_MASK << \
+					 QSFP_RX_CDR_APPLY_SHIFT)
+#define QSFP_RX_EMP_APPLY_SMASK		(QSFP_RX_EMP_APPLY_MASK << \
+					 QSFP_RX_EMP_APPLY_SHIFT)
+#define QSFP_RX_AMP_APPLY_SMASK		(QSFP_RX_AMP_APPLY_MASK << \
+					 QSFP_RX_AMP_APPLY_SHIFT)
+#define QSFP_RX_CDR_SMASK		(QSFP_RX_CDR_MASK << QSFP_RX_CDR_SHIFT)
+#define QSFP_RX_EMP_SMASK		(QSFP_RX_EMP_MASK << QSFP_RX_EMP_SHIFT)
+#define QSFP_RX_AMP_SMASK		(QSFP_RX_AMP_MASK << QSFP_RX_AMP_SHIFT)
+
+#define BITMAP_VERSION			1
+#define BITMAP_VERSION_SHIFT		44
+#define BITMAP_VERSION_MASK		0xFUL
+#define BITMAP_VERSION_SMASK		(BITMAP_VERSION_MASK << \
+					 BITMAP_VERSION_SHIFT)
+#define CHECKSUM_SHIFT			48
+#define CHECKSUM_MASK			0xFFFFUL
+#define CHECKSUM_SMASK			(CHECKSUM_MASK << CHECKSUM_SHIFT)
+
+/* platform.c */
+void hfi2_get_platform_config(struct hfi2_pportdata *ppd);
+void free_platform_config(struct hfi2_devdata *dd);
+void get_port_type(struct hfi2_pportdata *ppd);
+int set_qsfp_tx(struct hfi2_pportdata *ppd, int on);
+void tune_serdes(struct hfi2_pportdata *ppd);
+
+#endif			/*__PLATFORM_H*/
diff --git a/drivers/infiniband/hw/hfi2/qsfp.h b/drivers/infiniband/hw/hfi2/qsfp.h
new file mode 100644
index 000000000000..85ce966870a6
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/qsfp.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+/* QSFP support common definitions, for hfi driver */
+
+#define QSFP_DEV 0xA0
+#define QSFP_PWR_LAG_MSEC 2000
+#define QSFP_MODPRS_LAG_MSEC 20
+/* 128 byte pages, per SFF 8636 rev 2.4 */
+#define QSFP_MAX_NUM_PAGES	5
+
+/*
+ * Below are masks for QSFP pins.  Pins are the same for HFI0 and HFI2.
+ * _N means asserted low
+ */
+#define QSFP_HFI0_I2CCLK    BIT(0)
+#define QSFP_HFI0_I2CDAT    BIT(1)
+#define QSFP_HFI0_RESET_N   BIT(2)
+#define QSFP_HFI0_INT_N	    BIT(3)
+#define QSFP_HFI0_MODPRST_N BIT(4)
+
+/* QSFP is paged at 256 bytes */
+#define QSFP_PAGESIZE 256
+/* Reads/writes cannot cross 128 byte boundaries */
+#define QSFP_RW_BOUNDARY 128
+
+/* number of bytes in i2c offset for QSFP devices */
+#define __QSFP_OFFSET_SIZE 1                           /* num address bytes */
+#define QSFP_OFFSET_SIZE (__QSFP_OFFSET_SIZE << 8)     /* shifted value */
+
+/* Defined fields that Intel requires of qualified cables */
+/* Byte 0 is Identifier, not checked */
+/* Byte 1 is reserved "status MSB" */
+#define QSFP_MONITOR_VAL_START 22
+#define QSFP_MONITOR_VAL_END 81
+#define QSFP_MONITOR_RANGE (QSFP_MONITOR_VAL_END - QSFP_MONITOR_VAL_START + 1)
+#define QSFP_TX_CTRL_BYTE_OFFS 86
+#define QSFP_PWR_CTRL_BYTE_OFFS 93
+#define QSFP_CDR_CTRL_BYTE_OFFS 98
+
+#define QSFP_PAGE_SELECT_BYTE_OFFS 127
+/* Byte 128 is Identifier: must be 0x0c for QSFP, or 0x0d for QSFP+ */
+#define QSFP_MOD_ID_OFFS 128
+/*
+ * Byte 129 is "Extended Identifier".
+ * For bits [7:6]: 0:1.5W, 1:2.0W, 2:2.5W, 3:3.5W
+ * For bits [1:0]: 0:Unused, 1:4W, 2:4.5W, 3:5W
+ */
+#define QSFP_MOD_PWR_OFFS 129
+/* Byte 130 is Connector type. Not Intel req'd */
+/* Bytes 131..138 are Transceiver types, bit maps for various tech, none IB */
+/* Byte 139 is encoding. code 0x01 is 8b10b. Not Intel req'd */
+/* byte 140 is nominal bit-rate, in units of 100Mbits/sec */
+#define QSFP_NOM_BIT_RATE_100_OFFS 140
+/* Byte 141 is Extended Rate Select. Not Intel req'd */
+/* Bytes 142..145 are lengths for various fiber types. Not Intel req'd */
+/* Byte 146 is length for Copper. Units of 1 meter */
+#define QSFP_MOD_LEN_OFFS 146
+/*
+ * Byte 147 is Device technology. D0..3 not Intel req'd
+ * D4..7 select from 15 choices, translated by table:
+ */
+#define QSFP_MOD_TECH_OFFS 147
+extern const char *const hfi2_qsfp_devtech[16];
+/* Active Equalization includes fiber, copper full EQ, and copper near Eq */
+#define QSFP_IS_ACTIVE(tech) ((0xA2FF >> ((tech) >> 4)) & 1)
+/* Active Equalization includes fiber, copper full EQ, and copper far Eq */
+#define QSFP_IS_ACTIVE_FAR(tech) ((0x32FF >> ((tech) >> 4)) & 1)
+/* Attenuation should be valid for copper other than full/near Eq */
+#define QSFP_HAS_ATTEN(tech) ((0x4D00 >> ((tech) >> 4)) & 1)
+/* Length is only valid if technology is "copper" */
+#define QSFP_IS_CU(tech) ((0xED00 >> ((tech) >> 4)) & 1)
+#define QSFP_TECH_1490 9
+
+#define QSFP_OUI(oui) (((unsigned int)oui[0] << 16) | ((unsigned int)oui[1] << 8) | \
+			oui[2])
+#define QSFP_OUI_AMPHENOL 0x415048
+#define QSFP_OUI_FINISAR  0x009065
+#define QSFP_OUI_GORE     0x002177
+
+/* Bytes 148..163 are Vendor Name, Left-justified Blank-filled */
+#define QSFP_VEND_OFFS 148
+#define QSFP_VEND_LEN 16
+/* Byte 164 is IB Extended transceiver codes Bits D0..3 are SDR,DDR,QDR,EDR */
+#define QSFP_IBXCV_OFFS 164
+/* Bytes 165..167 are Vendor OUI number */
+#define QSFP_VOUI_OFFS 165
+#define QSFP_VOUI_LEN 3
+/* Bytes 168..183 are Vendor Part Number, string */
+#define QSFP_PN_OFFS 168
+#define QSFP_PN_LEN 16
+/* Bytes 184,185 are Vendor Rev. Left Justified, Blank-filled */
+#define QSFP_REV_OFFS 184
+#define QSFP_REV_LEN 2
+/*
+ * Bytes 186,187 are Wavelength, if Optical. Not Intel req'd
+ *  If copper, they are attenuation in dB:
+ * Byte 186 is at 2.5Gb/sec (SDR), Byte 187 at 5.0Gb/sec (DDR)
+ */
+#define QSFP_ATTEN_OFFS 186
+#define QSFP_ATTEN_LEN 2
+/*
+ * Bytes 188,189 are Wavelength tolerance, if optical
+ * If copper, they are attenuation in dB:
+ * Byte 188 is at 12.5 Gb/s, Byte 189 at 25 Gb/s
+ */
+#define QSFP_CU_ATTEN_7G_OFFS 188
+#define QSFP_CU_ATTEN_12G_OFFS 189
+/* Byte 190 is Max Case Temp. Not Intel req'd */
+/* Byte 191 is LSB of sum of bytes 128..190. Not Intel req'd */
+#define QSFP_CC_OFFS 191
+#define QSFP_EQ_INFO_OFFS 193
+#define QSFP_CDR_INFO_OFFS 194
+/* Bytes 196..211 are Serial Number, String */
+#define QSFP_SN_OFFS 196
+#define QSFP_SN_LEN 16
+/* Bytes 212..219 are date-code YYMMDD (MM==1 for Jan) */
+#define QSFP_DATE_OFFS 212
+#define QSFP_DATE_LEN 6
+/* Bytes 218,219 are optional lot-code, string */
+#define QSFP_LOT_OFFS 218
+#define QSFP_LOT_LEN 2
+/* Bytes 220, 221 indicate monitoring options, Not Intel req'd */
+/* Byte 222 indicates nominal bitrate in units of 250Mbits/sec */
+#define QSFP_NOM_BIT_RATE_250_OFFS 222
+/* Byte 223 is LSB of sum of bytes 192..222 */
+#define QSFP_CC_EXT_OFFS 223
+
+/*
+ * Interrupt flag masks
+ */
+#define QSFP_DATA_NOT_READY		0x01
+
+#define QSFP_HIGH_TEMP_ALARM		0x80
+#define QSFP_LOW_TEMP_ALARM		0x40
+#define QSFP_HIGH_TEMP_WARNING		0x20
+#define QSFP_LOW_TEMP_WARNING		0x10
+
+#define QSFP_HIGH_VCC_ALARM		0x80
+#define QSFP_LOW_VCC_ALARM		0x40
+#define QSFP_HIGH_VCC_WARNING		0x20
+#define QSFP_LOW_VCC_WARNING		0x10
+
+#define QSFP_HIGH_POWER_ALARM		0x88
+#define QSFP_LOW_POWER_ALARM		0x44
+#define QSFP_HIGH_POWER_WARNING		0x22
+#define QSFP_LOW_POWER_WARNING		0x11
+
+#define QSFP_HIGH_BIAS_ALARM		0x88
+#define QSFP_LOW_BIAS_ALARM		0x44
+#define QSFP_HIGH_BIAS_WARNING		0x22
+#define QSFP_LOW_BIAS_WARNING		0x11
+
+#define QSFP_ATTEN_SDR(attenarray) (attenarray[0])
+#define QSFP_ATTEN_DDR(attenarray) (attenarray[1])
+
+/*
+ * struct qsfp_data encapsulates state of QSFP device for one port.
+ * it will be part of port-specific data if a board supports QSFP.
+ *
+ * Since multiple board-types use QSFP, and their pport_data structs
+ * differ (in the chip-specific section), we need a pointer to its head.
+ *
+ * Avoiding premature optimization, we will have one work_struct per port,
+ * and let the qsfp_lock arbitrate access to common resources.
+ *
+ */
+struct qsfp_data {
+	/* Helps to find our way */
+	struct hfi2_pportdata *ppd;
+	struct work_struct qsfp_work;
+	u8 cache[QSFP_MAX_NUM_PAGES * 128];
+	/* protect qsfp data */
+	spinlock_t qsfp_lock;
+	u8 check_interrupt_flags;
+	u8 reset_needed;
+	u8 limiting_active;
+	u8 cache_valid;
+	u8 cache_refresh_required;
+};
+
+int refresh_qsfp_cache(struct hfi2_pportdata *ppd,
+		       struct qsfp_data *cp);
+int get_qsfp_power_class(u8 power_byte);
+int qsfp_mod_present(struct hfi2_pportdata *ppd);
+int get_cable_info(struct hfi2_pportdata *ppd, u32 addr, u32 len, u8 *data);
+
+int i2c_write(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+	      int offset, void *bp, int len);
+int i2c_read(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+	     int offset, void *bp, int len);
+int qsfp_write(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	       int len);
+int qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	      int len);
+int one_qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+		  int len);
+struct hfi2_asic_data;
+int set_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad);
+void clean_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad);



