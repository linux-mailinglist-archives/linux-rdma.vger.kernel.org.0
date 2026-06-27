Return-Path: <linux-rdma+bounces-22530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpDrNM/5P2qnawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6560F6D243B
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=AO2tFHsz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22530-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22530-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6473C3010B81
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF52475E3;
	Sat, 27 Jun 2026 16:26:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021112.outbound.protection.outlook.com [40.93.194.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9DC2F1FE4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:26:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577610; cv=fail; b=ev2WtmRhog/G4cHkPQcBSMUOXvRkTYZe+KVxhp0rwSWOqwh6vNvk0cBkk66HUS6ISlcsCccOawhlGqMu46R8qlKWEFaVhIWPwPGiSawJ6LvddR63b+NnRjg8snaoGpXrEuSq+rtOpRbTThxBtgMyaWAc6W2yzdfn2DNpjKnY77Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577610; c=relaxed/simple;
	bh=kUnhQejfDhtHPmrovq1X+DhQ+AjeJNX9Zi/uq71TCWU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEtU8fVv2LHoCM0eZp61ycNj9JxgBVr+0lVPnW0eYlnuZ0CVe2B8hQ4Y9NSdbxH8PxQAsW/wjQPwNiw0eH1Rz9jTR3z/JQY6N7Am7D3bUChxRsPCrH9/frQCuEjFiFDmVDPewAFkOOjkh9RLBlXKU2vsZGm+iX3gQzcCWvR/OIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=AO2tFHsz; arc=fail smtp.client-ip=40.93.194.112
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T42z3ZgPTURH2pxpXONdR4NDVyUWk49Sz3yvyuSWhG3X9cDh+4PhwCol0AGFunioaHhW//h3tCJ8R8nXtBcIrS990aRi+8hUzAm6N2dmRnHKL0lLny4EMhZkjo8jW38rYRKtxuNbJBxxmfbNscP+jbpbkauY4CXUp2xKWpdhT99KANrCXZwq8t2Wjs3jwsxT99pX5+qpYgNZnXtW19102tJJ41B1eJpO4hs7e/7rDOIOpNeAzDU9VKRpO6inZfVdWMfYiWhKZxBXJ5gZiiLpvun8TREhjbZhI40ewE+YfwRw2PB4ij7zlVfdfn5TdcevJWzAkFPelrisbWiZkisbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRa6R59dMc8HaCOT9VdvHJrCt3Ljhw+CkRV49wHiCM0=;
 b=ZkM7IrYRoEbvXV3CT3PsezEUrfsKHHbF0FxISzxF4dDDSkdb9rpSbmQso8+rqoUvCC21t7WJk5jw8dczasQnJzEjt94dEcHGr1BfV2/lr7zHgqF3i9qzJkfwbOc8ju9s/uu3ZtZ0OpMi0wbgmE1UDAAHm3WldLpPFAedmkC64dPbOO8SohxJjWEar12z1y9K/r48ivCIbk9mYrgj4CInoQQQ7Huc2IZs3qFAH+O/3Bsv1has16zimQMzDwRSqeDfFS6N9uMHmRWMrJVzDxoLx0PigfxIeBxdqTAr1SJzR7LVeZH4fQ5+wXGoCXQd30E0fATS6v7F+iroeYoyenWLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRa6R59dMc8HaCOT9VdvHJrCt3Ljhw+CkRV49wHiCM0=;
 b=AO2tFHszpqt/Mh3Ty9LcL7/6ECrg0RodZ6bkse7Nq6/zCONLuh9SWsAQy9WZoOI/SU5XMyhsZk4ZLyMLg+eZT42baBrkSUYGcf6J7LoZ4tBSUXeLGHtcn554jP21Fj4TnIDeBCKxsESsOoFGoXlQi0llxaa/wcBvYoT4+KTgUh0o5L2se3NIjIsjJ+l/yRQGlzP2wahs5grLou6j8OWfpMSR8ZEzR2heJxDXPjs3idc+msCj+x7CbByEcxMsS3KCQx5KYYC+G28vzuE4TM472pJPcdpbk7FmjvogLn5IIHJpmkK5/hMBtlttg3aIQcDDyvdEaGKeSujchdRsphpa5w==
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by SJ0PR01MB8060.prod.exchangelabs.com (2603:10b6:a03:4d5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Sat, 27 Jun 2026 16:26:36 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::63) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sat, 27
 Jun 2026 16:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:26:36 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 9D3E3146565;
	Sat, 27 Jun 2026 12:26:35 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 98EB11810D6C7;
	Sat, 27 Jun 2026 12:26:35 -0400 (EDT)
Subject: [PATCH v2 for-next 20/24] RDMA/hfi2: Add misc header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:26:35 -0400
Message-ID: <178257759558.371918.3864646324146342205.stgit@awdrv-04>
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SJ0PR01MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bf72dd-b4d3-46c0-06dd-08ded468dbba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|3023799007|6133799003|55112099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d9jNbx/GAF7sl8kbJ/Gixexf4+7Y8RhvxTTq58W7Hgn/gDqk/saUpxzt1mqnpgxxO1XXep2DncKjXlJcHAnBN0hJLqeg+pmr4LxZhFOOC2iiZ6KXsqLBkTId1+FKAQwGIPQnK4ofT6DudDh5vmZpPAwiqFenalFu6z1xnSKvQaha743YXWJSR9+3tT2yUOmjV6xsN4ufOC88CJZ6BGHQrj31h1SXkXGk5jsTYRKrtWbtibyPQs2oEZlXXSn2Y6Rdo23VB9vWdEU0ikn1tGLabYoDIDhbLSfCW+4VSnTkVNKjpy7+5q1ojECl3P4jFj2NO9fbJ8TsSoXbT/dqZyFB+gbc7n8hK8PGD5kQEk+ToF718qWrKpAt8aRKqKt/ft6TQdW0yOY/sGmuuStsIquS7DIXlnC9goV+Xd4AFupLRvdWzIOFCOlYnDX2XGjMvBrddTDpA2TmgHZtfPfqPMySIAPRfREyFYDB/v2TTzfcWD7Kvhrgoh+X68qIptp4e0caWXWi0/wNVbJ2BZ6edahkHBRQm72hKkWQQG5g3ybJ/A6zxUjIIAj4d93uN5K6EpIi/vFF+aODETg7LeVjzoIZaZDPdSLIqB4jpj3QyTdSEqcExJR7UqmA3Z6pjuc3NB9XEqCYO0Yk6OjCWZSHa7ZNTCSRLf4sfUPKhoUOCDAdfCreQ8I1E6q928f4n36upT4PCymZ0GioCG9ypRL3r+CcWA==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3HkDQOTqRsPexlZ5zQPQukniYhC20/ZSch06VqFrYGOvBKPEJdbTFZR+NeQI98KTF7/2CpEJ0Z2biwYRss7yRTcJ0nYDaF/sjFbaIlMoVKFFh1TTnVydRpy5nURxjyfZ5fm7WPhnS5Lw3Xl53F5TDysrSiRJ731EjOABfdRLo6k7R3pPOVaf/0qmBla5dw50eJAwWHc4R7pAZPEFZkeS89howu5swGYs7BT1M7GyuBOuib8bc3Ldez95N27ZauXhtHXIBJidA4sCkJiFTpcHNFGgemI9dMFiTQBK5g8VcH0rLYQrCYT9Hyanla+p4nql+OF0dS6uGBQkoolz3lOErhOgIUHNudGYIYDjXV7ijTqDn/JiDvhDc+dbBdlab1hTNSYAG0h6ZJeJv+61xZHdUNxQt5OyyW0TdmHQN7uvztc2id2WWmweE1HPEnjYzgu5
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:26:36.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bf72dd-b4d3-46c0-06dd-08ded468dbba
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22530-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,cornelisnetworks.com:from_mime,vger.kernel.org:from_smtp,awdrv-04:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6560F6D243B

There are a few header files that didn't really fit with the rest of the
bunch so adding them all separately.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/opfn.h     |   88 ++++++++
 drivers/infiniband/hw/hfi2/platform.h |  372 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/qsfp.h     |  202 ++++++++++++++++++
 3 files changed, 662 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.h
 create mode 100644 drivers/infiniband/hw/hfi2/platform.h
 create mode 100644 drivers/infiniband/hw/hfi2/qsfp.h

diff --git a/drivers/infiniband/hw/hfi2/opfn.h b/drivers/infiniband/hw/hfi2/opfn.h
new file mode 100644
index 000000000000..87fad4e7286e
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
+void hfi2_opfn_send_conn_request(struct work_struct *work);
+void hfi2_opfn_conn_response(struct rvt_qp *qp, struct rvt_ack_entry *e,
+			struct ib_atomic_eth *ateth);
+void hfi2_opfn_conn_reply(struct rvt_qp *qp, u64 data);
+void hfi2_opfn_conn_error(struct rvt_qp *qp);
+void hfi2_opfn_qp_init(struct rvt_qp *qp, struct ib_qp_attr *attr, int attr_mask);
+void hfi2_opfn_trigger_conn_request(struct rvt_qp *qp, u32 bth1);
+int hfi2_opfn_init(void);
+void hfi2_opfn_exit(void);
+
+#endif /* _HFI2_OPFN_H */
diff --git a/drivers/infiniband/hw/hfi2/platform.h b/drivers/infiniband/hw/hfi2/platform.h
new file mode 100644
index 000000000000..5ae163520a8a
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
+ * and is populated by hfi2_parse_platform_config(...) depending on the specific
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
+void hfi2_free_platform_config(struct hfi2_devdata *dd);
+void hfi2_get_port_type(struct hfi2_pportdata *ppd);
+int hfi2_set_qsfp_tx(struct hfi2_pportdata *ppd, int on);
+void hfi2_tune_serdes(struct hfi2_pportdata *ppd);
+
+#endif			/*__PLATFORM_H*/
diff --git a/drivers/infiniband/hw/hfi2/qsfp.h b/drivers/infiniband/hw/hfi2/qsfp.h
new file mode 100644
index 000000000000..4cf81313c579
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
+int hfi2_refresh_qsfp_cache(struct hfi2_pportdata *ppd,
+		       struct qsfp_data *cp);
+int hfi2_get_qsfp_power_class(u8 power_byte);
+int hfi2_qsfp_mod_present(struct hfi2_pportdata *ppd);
+int hfi2_get_cable_info(struct hfi2_pportdata *ppd, u32 addr, u32 len, u8 *data);
+
+int hfi2_i2c_write(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+	      int offset, void *bp, int len);
+int hfi2_i2c_read(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+	     int offset, void *bp, int len);
+int hfi2_qsfp_write(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	       int len);
+int hfi2_qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	      int len);
+int hfi2_one_qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+		  int len);
+struct hfi2_asic_data;
+int hfi2_set_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad);
+void hfi2_clean_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad);



