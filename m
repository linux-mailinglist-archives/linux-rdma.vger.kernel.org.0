Return-Path: <linux-rdma+bounces-17827-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPvNEZMzr2kPQQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17827-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:54:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145CC2412D7
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 217B330B84A5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F9369211;
	Mon,  9 Mar 2026 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="MHyYOh90"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021107.outbound.protection.outlook.com [52.101.62.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B5284663
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089521; cv=fail; b=oVXCZoGG64Rmm0AiDApWvaBBelMYuYS+P3ELuzuFC0unLiPBJTBLzVGRDkqOq/YG/Pqih6DBdMnPClnjskalIEHX1vaX1WmA/90SMTcqkYgBCkKH837QC7WR2+avmrQSUw0MGujpAxe1Pe7Z3djtmpZ7IrMjD73Xmgjty3SrmQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089521; c=relaxed/simple;
	bh=7C9MKPngupfjNVu9TrDy3SA3mrSPtw4Jjb30KQgdNFE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy1sTG8wr8yFF9vRnM0GXGip51y+o7At3QgX9CaqMpg30L4wyK5AUITdIlCq96buPTwz0YjBiMh9u91PJh+GHMCO1BipV1sUEcs/OcnoyG9Au6WGpV1OhIzQob62ddkqjC1yY75+aufPmvbcGT7fr6YDfidqSqKkC040xTJ64js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=MHyYOh90; arc=fail smtp.client-ip=52.101.62.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2x/NGytXIzVoxZFSSSTTjOefJIUAhVeQj8cTgKpeW7tz+k7cTCR7NLAQ7ARIclderPur3N1XZIrjS+9eC3Gr6C4oJ2kWpIrArGfkKhLJmeBedfeWQV7E+RXxy+saCurDG5d2YgsSCSWGX5aDA9xsESUPq3YH1Ek/dfdTmsTB0WeK1/ml/eFyLMrIoOQyGEtwc3XyxbOBiwKYwKPw8FG3Bqr8lObHRv7mcSnEKGe/zx0vc1c4xHYG5jnrz+4AfXhxTqhAI5/e2pQBI/8VKzHn2gUvRisERbQEUJwIKB4caY2UlPhRTdy4E4LKiRBjUWdxwCfIH9Vd3Zo4aqxpK8f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA3VKdqdu3mIpVe1XcDVA1Uvdn2vx2rfzDRkhnyJAiY=;
 b=bg+emNPCO7xmeFk+PgctMoim+/CbxXRs8lHiacfYTmzlltSfSW2XNAW/MySy8v1F//OUqqgSsR/f4ay1mYILKQtrKg9KKOaB+3l1f4QZt0mMgPmETXmeItmNSu4LFHSGqp6bObCz6ZPNjFEV44RpnquMvtcUXFSZHbedvYJZx6w2yjzaZ8TTo8EowEIBkZAC49A7GfvbmA4UiL6RNTauQo9VFxRB/FAakZ3NhCOHOD8kk6nYMWaHsQqjrQ1MOQUS/rtLGvllCNRWvh9DxTq8R74CaOIRNeKu90JBZS1fBnydxnbUcMz52Ge0ZOhvjSMnypsamy+zZR7BRgEqryj8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA3VKdqdu3mIpVe1XcDVA1Uvdn2vx2rfzDRkhnyJAiY=;
 b=MHyYOh90Ne3yEcn6LpR3aVdgqqoihHeW8ps2WvP+6SNZezudGe0M6CWmfNKdFibATKfV6XcaKRReT67sS0AqyiUVnQXDo9QNI38m1nkG0bAXP8qz2mRYYFuB9fCnjKeqAWXYULf9ea0rwG/cQb6z53fFfZtaT17lsZs7JVm6zo8M4DXzTV+n22cY17ETFe47uMF+BT2lQ6A7YdXhgW5iwPzGQ3mNswuo8sPTmsqFioFaPDeHMNjDdO3YZLjV8YGJIwXzigQUT2C8h6yhcL49fEmhUo6AeOrM2WCYO6JNYBPBltfDp9YjWPZRHYN5rwf37Xr0rxls4Aqz5jQDVen7gQ==
Received: from SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11)
 by DS7PR01MB7757.prod.exchangelabs.com (2603:10b6:8:7c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.23; Mon, 9 Mar 2026 20:51:48 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::1f) by SA0PR11CA0066.outlook.office365.com
 (2603:10b6:806:d2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 20:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:51:48 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 8C80E14D715;
	Mon,  9 Mar 2026 16:51:47 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 887801810D6D7;
	Mon,  9 Mar 2026 16:51:47 -0400 (EDT)
Subject: [PATCH for-next 16/24] RDMA/hfi2: Implement data moving
 infrastructure
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:51:47 -0400
Message-ID:
 <177308950749.1280641.17182093906965197611.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177308916470.1280641.1779641444229092453.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177308916470.1280641.1779641444229092453.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR01MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: f76dd0b1-f1d9-4e62-6503-08de7e1dae9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	GAUbaMxN/z2I9+oYQIT2gGQ7NyW/VbdohLxrhuaNaNmFcmAriOewG+Iaq33yt6W02iqETWvzmtKl5V/+FUPJ4KlJyzbDI2F3A3xVgiadnOFtnHlu6KtSUO5XOGlDd7sZqgU5hHLY6HshOMpzgiNXYoxPWzwlO1GOe0CyGdaeIk5YCh2N469RYIX/jfDN4aQdgEhhWW/wK06J74JxrocOPsd/gWpw253P9a5oQkAfjHpLD+bGxxghTb/mLWv26Fi5EHh7pwBZmNeuvS/Pv9EWOeoZXNreMY1WoDUydt+BY2BUTtQysq74qDtYmjUUTnwgjAnbGYFtpeQLmQZaYL6J8lC4Z2ss8K8qezDt6a4h6QhZ5/vk0tePPKwEixRg5XGhKqI5NGe/3ZKzxeADWEHRhYKiUL4s0lfom4EIe0KhSVPsCi4yVTam+J1LUDkE8pRuKPzNOFwxGC7fWwWoojdQJYtNyzxENnXTFQfdFEhMFenPzqzMd9NMpkD8B0lRaJ2yru1n45njLLJjuA0C5kkxmni2mYi+3xHj6R5xlTno6R0S6dCBeT95TN+9JWieqEUb5oIoctvUDOk3EaSMJQBdFJhRrDw9EUYKOws0/f7e4o5urD8dj7NC+3tnt8RexGF0PTUzNDRhWVNqjJMhjDlajnDVgbcp7wnRXp5I2Pm7Bw4oI+wioKFUZ5S7NfOWEGVQhjA1G4auICCtGmZ9NpiIokVqRswfUdeWgIs8dJgO1CFQx80UHAA4TzfvpDh1yCoCIxlRxG6pE4KAfz9tVbjaNQ==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x2KnPlnq+/jWvI97etm3WX6DxJ+oYuYduAR68FrOOHbgg3OR2xMvZCDLbnF2qkk6psVQwavbAEV0F7rP8u5LtiQmFsUu3MUwhE7ZrK3NJyiQE9XtDWZRR+QxxhWpDwyiJIlOg8tY9uZNfxrlIr3pNLuhK4KfC7FE+cTZ2ddVBTZ57vc1/POmiuJT42NvQPSCM+O9fR5qpAfRBwXgrel1Pj4Pmr7Ce4twjQDq0oEZLW7GaVNrFiloiDJHdmrfxvPIaZ+VhZOeJfop5cyixLGtE4wnxS71o3tXF4Dm2eDMSHZCpzYcKV6FliaJfDVa0/eqU5e8sKnP4OsYMrAWRB7gjAPcPnaTxdICRwb5QJJR6X6F0YjNgaqMM5m5mYqhdrjByI3Oc4dbHHAsk1w9Pqf+Pxs3wn0/6Spf46P8uYPXSpEeGiS/BV/M8c6882l5zvd0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:51:48.0034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76dd0b1-f1d9-4e62-6503-08de7e1dae9c
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7757
X-Rspamd-Queue-Id: 145CC2412D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17827-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid,kdeth.om:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Start to add the underlying code that enables verbs and ipoib which
follows.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/exp_rcv.c      |   79 +
 drivers/infiniband/hw/hfi2/file_ops.c     | 1292 ++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/mmu_rb.c       |  344 ++++++
 drivers/infiniband/hw/hfi2/pin_system.c   |  539 +++++++++
 drivers/infiniband/hw/hfi2/pinning.c      |   66 +
 drivers/infiniband/hw/hfi2/tid_system.c   |  481 ++++++++
 drivers/infiniband/hw/hfi2/user_exp_rcv.c | 1013 ++++++++++++++++++
 drivers/infiniband/hw/hfi2/user_pages.c   |  108 ++
 drivers/infiniband/hw/hfi2/user_sdma.c    | 1667 +++++++++++++++++++++++++++++
 9 files changed, 5589 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/file_ops.c
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.c
 create mode 100644 drivers/infiniband/hw/hfi2/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi2/tid_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_pages.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_sdma.c

diff --git a/drivers/infiniband/hw/hfi2/exp_rcv.c b/drivers/infiniband/hw/hfi2/exp_rcv.c
new file mode 100644
index 000000000000..838438fffef3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/exp_rcv.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include "exp_rcv.h"
+#include "trace.h"
+
+/**
+ * hfi2_exp_tid_set_init - initialize exp_tid_set
+ * @set: the set
+ */
+static void hfi2_exp_tid_set_init(struct exp_tid_set *set)
+{
+	INIT_LIST_HEAD(&set->list);
+	set->count = 0;
+}
+
+/**
+ * hfi2_exp_tid_group_init - initialize rcd expected receive
+ * @rcd: the rcd
+ */
+void hfi2_exp_tid_group_init(struct hfi2_ctxtdata *rcd)
+{
+	hfi2_exp_tid_set_init(&rcd->tid_group_list);
+	hfi2_exp_tid_set_init(&rcd->tid_used_list);
+	hfi2_exp_tid_set_init(&rcd->tid_full_list);
+}
+
+/**
+ * hfi2_alloc_ctxt_rcv_groups - initialize expected receive groups
+ * @rcd: the context to add the groupings to
+ */
+int hfi2_alloc_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 tidbase;
+	struct tid_group *grp;
+	int i;
+	u32 ngroups;
+
+	ngroups = rcd->expected_count / dd->rcv_entries.group_size;
+	rcd->groups =
+		kcalloc_node(ngroups, sizeof(*rcd->groups),
+			     GFP_KERNEL, rcd->numa_id);
+	if (!rcd->groups)
+		return -ENOMEM;
+	tidbase = 0;
+	for (i = 0; i < ngroups; i++) {
+		grp = &rcd->groups[i];
+		grp->size = dd->rcv_entries.group_size;
+		grp->base = tidbase;
+		tid_group_add_tail(grp, &rcd->tid_group_list);
+		tidbase += dd->rcv_entries.group_size;
+	}
+
+	return 0;
+}
+
+/**
+ * hfi2_free_ctxt_rcv_groups - free  expected receive groups
+ * @rcd: the context to free
+ *
+ * The routine dismantles the expect receive linked
+ * list and clears any tids associated with the receive
+ * context.
+ *
+ * This should only be called for kernel contexts and the
+ * a base user context.
+ */
+void hfi2_free_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd)
+{
+	kfree(rcd->groups);
+	rcd->groups = NULL;
+	hfi2_exp_tid_group_init(rcd);
+
+	hfi2_clear_tids(rcd);
+}
diff --git a/drivers/infiniband/hw/hfi2/file_ops.c b/drivers/infiniband/hw/hfi2/file_ops.c
new file mode 100644
index 000000000000..a18aa1b3d91e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/file_ops.c
@@ -0,0 +1,1292 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2020 Intel Corporation.
+ */
+
+#include <linux/poll.h>
+#include <linux/cdev.h>
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+#include <linux/sched/mm.h>
+#include <linux/bitmap.h>
+
+#include <rdma/ib.h>
+
+#include "hfi2.h"
+#include "pio.h"
+#include "common.h"
+#include "trace.h"
+#include "mmu_rb.h"
+#include "user_sdma.h"
+#include "user_exp_rcv.h"
+#include "aspm.h"
+#include "pinning.h"
+#include "file_ops.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+#define SEND_CTXT_HALT_TIMEOUT 1000 /* msecs */
+
+/*
+ * File operation functions
+ */
+static u64 kvirt_to_phys(void *addr);
+static void init_subctxts(struct hfi2_ctxtdata *uctxt,
+			  const struct hfi2_assign_ctxt_cmd *uinfo);
+static int init_user_ctxt(struct hfi2_filedata *fd,
+			  struct hfi2_ctxtdata *uctxt);
+static void user_init(struct hfi2_ctxtdata *uctxt);
+static int setup_base_ctxt(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt);
+static int setup_subctxt(struct hfi2_ctxtdata *uctxt);
+
+static int find_sub_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo);
+static int allocate_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo,
+			 struct hfi2_ctxtdata **cd);
+static void deallocate_ctxt(struct hfi2_ctxtdata *uctxt);
+static vm_fault_t vma_fault(struct vm_fault *vmf);
+
+static const struct vm_operations_struct vm_ops = {
+	.fault = vma_fault,
+};
+
+/*
+ * Masks and offsets defining the mmap tokens
+ */
+#define HFI2_MMAP_OFFSET_MASK   0xfffULL
+#define HFI2_MMAP_OFFSET_SHIFT  0
+#define HFI2_MMAP_SUBCTXT_MASK  0xfULL
+#define HFI2_MMAP_SUBCTXT_SHIFT 12
+#define HFI2_MMAP_CTXT_MASK     0xffULL
+#define HFI2_MMAP_CTXT_SHIFT    16
+#define HFI2_MMAP_TYPE_MASK     0xfULL
+#define HFI2_MMAP_TYPE_SHIFT    24
+#define HFI2_MMAP_MAGIC_MASK    0xffffffffULL
+#define HFI2_MMAP_MAGIC_SHIFT   32
+
+#define HFI2_MMAP_MAGIC         0xdabbad00
+
+#define HFI2_MMAP_TOKEN_SET(field, val)	\
+	(((val) & HFI2_MMAP_##field##_MASK) << HFI2_MMAP_##field##_SHIFT)
+#define HFI2_MMAP_TOKEN_GET(field, token) \
+	(((token) >> HFI2_MMAP_##field##_SHIFT) & HFI2_MMAP_##field##_MASK)
+#define HFI2_MMAP_TOKEN(type, ctxt, subctxt, addr)   \
+	(HFI2_MMAP_TOKEN_SET(MAGIC, HFI2_MMAP_MAGIC) | \
+	HFI2_MMAP_TOKEN_SET(TYPE, type) | \
+	HFI2_MMAP_TOKEN_SET(CTXT, ctxt) | \
+	HFI2_MMAP_TOKEN_SET(SUBCTXT, subctxt) | \
+	HFI2_MMAP_TOKEN_SET(OFFSET, (offset_in_page(addr))))
+
+#define dbg(fmt, ...)				\
+	pr_info(fmt, ##__VA_ARGS__)
+
+static inline int is_valid_mmap(u64 token)
+{
+	return (HFI2_MMAP_TOKEN_GET(MAGIC, token) == HFI2_MMAP_MAGIC);
+}
+
+struct hfi2_filedata *hfi2_alloc_filedata(struct hfi2_devdata *dd)
+{
+	struct hfi2_filedata *fd;
+
+	/* The real work is performed later in assign_ctxt() */
+
+	fd = kzalloc_obj(fd, GFP_KERNEL);
+
+	if (!fd || init_srcu_struct(&fd->pq_srcu))
+		goto nomem;
+	spin_lock_init(&fd->pq_rcu_lock);
+	spin_lock_init(&fd->tid_lock);
+	spin_lock_init(&fd->invalid_lock);
+	fd->rec_cpu_num = -1; /* no cpu affinity by default */
+	fd->dd = dd;
+	/* no port yet */
+	fd->ppd = NULL;
+	return fd;
+nomem:
+	kfree(fd);
+	return NULL;
+}
+
+ssize_t hfi2_do_write_iter(struct hfi2_filedata *fd, struct iov_iter *from)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_user_sdma_comp_q *cq = fd->cq;
+	int done = 0, reqs = 0;
+	unsigned long dim = from->nr_segs;
+	int idx;
+
+	if (!HFI2_CAP_IS_KSET(SDMA))
+		return -EINVAL;
+	if (!user_backed_iter(from))
+		return -EINVAL;
+	idx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (!cq || !pq) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
+		return -EIO;
+	}
+
+	trace_hfi2_sdma_request(fd->dd, fd->uctxt->ctxt, fd->subctxt, dim);
+
+	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
+		return -ENOSPC;
+	}
+
+	while (dim) {
+		const struct iovec *iov = iter_iov(from);
+		int ret;
+		unsigned long count = 0;
+
+		ret = hfi2_user_sdma_process_request(
+			fd, (struct iovec *)(iov + done),
+			dim, &count);
+		if (ret) {
+			reqs = ret;
+			break;
+		}
+		dim -= count;
+		done += count;
+		reqs++;
+	}
+
+	srcu_read_unlock(&fd->pq_srcu, idx);
+	return reqs;
+}
+
+static inline void mmap_cdbg(u16 ctxt, u16 subctxt, u8 type, u8 mapio, u8 vmf,
+			     u64 memaddr, void *memvirt, dma_addr_t memdma,
+			     ssize_t memlen, struct vm_area_struct *vma)
+{
+	hfi2_cdbg(PROC,
+		  "%u:%u type:%u io/vf/dma:%d/%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx",
+		  ctxt, subctxt, type, mapio, vmf, !!memdma,
+		  memaddr ?: (u64)memvirt, memlen,
+		  vma->vm_end - vma->vm_start, vma->vm_flags);
+}
+
+int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd;
+	unsigned long flags;
+	u64 memaddr = 0;
+	void *memvirt = NULL;
+	dma_addr_t memdma = 0;
+	u8 mapio = 0, vmf = 0;
+	ssize_t memlen = 0;
+	int ret = 0;
+	u32 cbi;
+	u32 cbc;
+	u16 ctxt;
+	u16 subctxt;
+
+	if (!uctxt || !(vma->vm_flags & VM_SHARED)) {
+		ret = -EINVAL;
+		goto done;
+	}
+	dd = uctxt->dd;
+	ctxt = uctxt->ctxt;
+	subctxt = fd->subctxt;
+
+	/*
+	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
+	 * the beginning.
+	 */ 
+	vma->vm_pgoff = 0;
+	flags = vma->vm_flags;
+
+	switch (type) {
+	case PIO_BUFS:
+	case PIO_BUFS_SOP:
+		cbi = ctxt_bar_idx(uctxt->sc->hw_context);
+		cbc = ctxt_bar_ctxt(uctxt->sc->hw_context);
+		memaddr = ((dd->bar_maps[cbi].physaddr + TXE_PIO_SEND) +
+				/* chip pio base */
+			   (cbc * BIT(16))) +
+				/* 64K PIO space / ctxt */
+			(type == PIO_BUFS_SOP ?
+				(TXE_PIO_SIZE / 2) : 0); /* sop? */
+		/*
+		 * Map only the amount allocated to the context, not the
+		 * entire available context's PIO space.
+		 */
+		memlen = PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE);
+		flags &= ~VM_MAYREAD;
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+		mapio = 1;
+		break;
+	case PIO_CRED: {
+		u64 cr_page_offset;
+		if (flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		/*
+		 * The credit return location for this context could be on the
+		 * second or third page allocated for credit returns (if number
+		 * of enabled contexts > 64 and 128 respectively).
+		 */
+		cr_page_offset = ((u64)uctxt->sc->hw_free -
+			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
+				   PAGE_MASK;
+		memvirt = (void *)dd->cr_base[uctxt->numa_id].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
+		memlen = PAGE_SIZE;
+		flags &= ~VM_MAYWRITE;
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		/*
+		 * The driver has already allocated memory for credit
+		 * returns and programmed it into the chip. Has that
+		 * memory been flagged as non-cached?
+		 */
+		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
+		break;
+	}
+	case RCV_RHEQ:
+		memlen = rheq_size(uctxt);
+		memvirt = uctxt->rheq;
+		memdma = uctxt->rheq_dma;
+		if (!memvirt) {
+			ret = -EINVAL;
+			goto done;
+		}
+		if (vma->vm_flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		break;
+	case RCV_HDRQ:
+		memlen = rcvhdrq_size(uctxt);
+		memvirt = uctxt->rcvhdrq;
+		memdma = uctxt->rcvhdrq_dma;
+		break;
+	case RCV_EGRBUF: {
+		unsigned long vm_start_save;
+		unsigned long vm_end_save;
+		int i;
+		/*
+		 * The RcvEgr buffer need to be handled differently
+		 * as multiple non-contiguous pages need to be mapped
+		 * into the user process.
+		 */
+		memlen = uctxt->egrbufs.size;
+		if ((vma->vm_end - vma->vm_start) != memlen) {
+			dd_dev_err(dd, "Eager buffer map size invalid (%lu != %lu)\n",
+				   (vma->vm_end - vma->vm_start), memlen);
+			ret = -EINVAL;
+			goto done;
+		}
+		if (vma->vm_flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		vm_flags_clear(vma, VM_MAYWRITE);
+		/*
+		 * Mmap multiple separate allocations into a single vma.  From
+		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
+		 * requires the mmap to exactly fill the vma starting at
+		 * vma_start.  Adjust the vma start and end for each eager
+		 * buffer segment mapped.  Restore the originals when done.
+		 */
+		vm_start_save = vma->vm_start;
+		vm_end_save = vma->vm_end;
+		vma->vm_end = vma->vm_start;
+		for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
+			memlen = uctxt->egrbufs.buffers[i].len;
+			memvirt = uctxt->egrbufs.buffers[i].addr;
+			memdma = uctxt->egrbufs.buffers[i].dma;
+			vma->vm_end += memlen;
+			mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr,
+				  memvirt, memdma, memlen, vma);
+			ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+						memvirt, memdma, memlen);
+			if (ret < 0) {
+				vma->vm_start = vm_start_save;
+				vma->vm_end = vm_end_save;
+				goto done;
+			}
+			vma->vm_start += memlen;
+		}
+		vma->vm_start = vm_start_save;
+		vma->vm_end = vm_end_save;
+		ret = 0;
+		goto done;
+	}
+	case UREGS:
+		/*
+		 * Map the part of BAR0 that contains this context's user
+		 * registers.  RcvHdrTail is the first register in the hardware
+		 * UCTXT block.  The TidFlow table is contained within this
+		 * memory range.
+		 */
+		cbi = ctxt_bar_idx(uctxt->ctxt);
+		cbc = ctxt_bar_ctxt(uctxt->ctxt);
+		memaddr = (unsigned long)dd->bar_maps[cbi].physaddr +
+				dd->params->rcv_hdr_tail_reg +
+				(cbc * dd->params->rxe_uctxt_stride);
+		memlen = dd->params->rxe_uctxt_stride;
+		// hack: accept a 4K mmap for uregs
+		{
+		ssize_t sz = vma->vm_end - vma->vm_start;
+		if (sz != memlen && sz == PAGE_SIZE) {
+			printk("%s: UREGS override memlen to 4K\n", __func__);
+			memlen = PAGE_SIZE;
+		}
+		}
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		mapio = 1;
+		break;
+	case EVENTS:
+		/*
+		 * Use the page where this context's flags are. User level
+		 * knows where it's own bitmap is within the page.
+		 */
+		memaddr = (unsigned long)
+			(dd->events + uctxt_offset(uctxt)) & PAGE_MASK;
+		memlen = PAGE_SIZE;
+		/*
+		 * v3.7 removes VM_RESERVED but the effect is kept by
+		 * using VM_IO.
+		 */
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case STATUS:
+		if (flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		memaddr = kvirt_to_phys((void *)dd->status);
+		memlen = PAGE_SIZE;
+		flags |= VM_IO | VM_DONTEXPAND;
+		break;
+	case RTAIL:
+		if (!HFI2_CAP_IS_USET(DMA_RTAIL)) {
+			/*
+			 * If the memory allocation failed, the context alloc
+			 * also would have failed, so we would never get here
+			 */
+			ret = -EINVAL;
+			goto done;
+		}
+		if ((flags & VM_WRITE) || !hfi2_rcvhdrtail_kvaddr(uctxt)) {
+			ret = -EPERM;
+			goto done;
+		}
+		memlen = PAGE_SIZE;
+		memvirt = (void *)hfi2_rcvhdrtail_kvaddr(uctxt);
+		memdma = uctxt->rcvhdrqtailaddr_dma;
+		flags &= ~VM_MAYWRITE;
+		break;
+	case SUBCTXT_UREGS:
+		memaddr = (u64)uctxt->subctxt_uregbase;
+		memlen = PAGE_SIZE;
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case SUBCTXT_RCV_HDRQ:
+		memaddr = (u64)uctxt->subctxt_rcvhdr_base;
+		memlen = rcvhdrq_size(uctxt) * uctxt->subctxt_cnt;
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case SUBCTXT_EGRBUF:
+		memaddr = (u64)uctxt->subctxt_rcvegrbuf;
+		memlen = uctxt->egrbufs.size * uctxt->subctxt_cnt;
+		flags |= VM_IO | VM_DONTEXPAND;
+		flags &= ~VM_MAYWRITE;
+		vmf = 1;
+		break;
+	case SDMA_COMP: {
+		struct hfi2_user_sdma_comp_q *cq = fd->cq;
+
+		if (!cq) {
+			ret = -EFAULT;
+			goto done;
+		}
+		memaddr = (u64)cq->comps;
+		memlen = PAGE_ALIGN(sizeof(*cq->comps) * cq->nentries);
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if ((vma->vm_end - vma->vm_start) != memlen) {
+		hfi2_cdbg(PROC, "%u:%u Memory size mismatch %lu:%lu",
+			  uctxt->ctxt, fd->subctxt,
+			  (vma->vm_end - vma->vm_start), memlen);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	vm_flags_reset(vma, flags);
+	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma,
+		  memlen, vma);
+	if (vmf) {
+		vma->vm_pgoff = PFN_DOWN(memaddr);
+		vma->vm_ops = &vm_ops;
+		ret = 0;
+	} else if (memdma) {
+		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+					memvirt, memdma, memlen);
+	} else if (mapio) {
+		ret = io_remap_pfn_range(vma, vma->vm_start,
+					 PFN_DOWN(memaddr),
+					 memlen,
+					 vma->vm_page_prot);
+	} else if (memvirt) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      PFN_DOWN(__pa(memvirt)),
+				      memlen,
+				      vma->vm_page_prot);
+	} else {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      PFN_DOWN(memaddr),
+				      memlen,
+				      vma->vm_page_prot);
+	}
+done:
+	return ret;
+}
+
+/*
+ * Local (non-chip) user memory is not mapped right away but as it is
+ * accessed by the user-level code.
+ */
+static vm_fault_t vma_fault(struct vm_fault *vmf)
+{
+	struct page *page;
+
+	page = vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+void hfi2_dealloc_filedata(struct hfi2_filedata *fdata)
+{
+	struct hfi2_ctxtdata *uctxt = fdata->uctxt;
+	struct hfi2_devdata *dd = fdata->dd;
+	unsigned long flags, *ev;
+
+	if (!uctxt)
+		goto done;
+
+	hfi2_cdbg(PROC, "closing ctxt %u:%u", uctxt->ctxt, fdata->subctxt);
+
+	flush_wc();
+	/* drain user sdma queue */
+	hfi2_user_sdma_free_queues(fdata, uctxt);
+
+	/* release the cpu */
+	hfi2_put_proc_affinity(fdata->rec_cpu_num);
+
+	/* clean up rcv side */
+	hfi2_user_exp_rcv_free(fdata);
+
+	/*
+	 * fdata->uctxt is used in the above cleanup.  It is not ready to be
+	 * removed until here.
+	 */
+	fdata->uctxt = NULL;
+	hfi2_rcd_put(uctxt);
+
+	/*
+	 * Clear any left over, unhandled events so the next process that
+	 * gets this context doesn't get confused.
+	 */
+	ev = dd->events + uctxt_offset(uctxt) + fdata->subctxt;
+	*ev = 0;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	__clear_bit(fdata->subctxt, uctxt->in_use_ctxts);
+	if (!bitmap_empty(uctxt->in_use_ctxts, HFI2_MAX_SHARED_CTXTS)) {
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		goto done;
+	}
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	/*
+	 * Disable receive context and interrupt available, reset all
+	 * RcvCtxtCtrl bits to default values.
+	 */
+	hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS |
+		     HFI2_RCVCTRL_TIDFLOW_DIS |
+		     HFI2_RCVCTRL_INTRAVAIL_DIS |
+		     HFI2_RCVCTRL_TAILUPD_DIS |
+		     HFI2_RCVCTRL_ONE_PKT_EGR_DIS |
+		     HFI2_RCVCTRL_NO_RHQ_DROP_DIS |
+		     HFI2_RCVCTRL_NO_EGR_DROP_DIS |
+		     HFI2_RCVCTRL_URGENT_DIS, uctxt);
+	/* Clear the context's J_KEY */
+	hfi2_clear_ctxt_jkey(dd, uctxt);
+	/*
+	 * If a send context is allocated, reset context integrity
+	 * checks to default and disable the send context.
+	 */
+	if (uctxt->sc) {
+		sc_disable(uctxt->sc);
+		priv_reg_op(dd, uctxt->sc->ppd->hw_pidx, uctxt->sc->hw_context,
+			    uctxt->sc->type, SC_CHK_ADJ_OP, 0);
+	}
+
+	hfi2_free_ctxt_rcv_groups(uctxt);
+	hfi2_clear_ctxt_pkey(dd, uctxt);
+
+	uctxt->event_flags = 0;
+
+	deallocate_ctxt(uctxt);
+done:
+	cleanup_srcu_struct(&fdata->pq_srcu);
+	kfree(fdata);
+}
+
+/*
+ * Convert kernel *virtual* addresses to physical addresses.
+ * This is used to vmalloc'ed addresses.
+ */
+static u64 kvirt_to_phys(void *addr)
+{
+	struct page *page;
+	u64 paddr = 0;
+
+	page = vmalloc_to_page(addr);
+	if (page)
+		paddr = page_to_pfn(page) << PAGE_SHIFT;
+
+	return paddr;
+}
+
+/**
+ * complete_subctxt - complete sub-context info
+ * @fd: valid filedata pointer
+ *
+ * Sub-context info can only be set up after the base context
+ * has been completed.  This is indicated by the clearing of the
+ * HFI2_CTXT_BASE_UINIT bit.
+ *
+ * Wait for the bit to be cleared, and then complete the subcontext
+ * initialization.
+ *
+ */
+static int complete_subctxt(struct hfi2_filedata *fd)
+{
+	int ret;
+	unsigned long flags;
+
+	/*
+	 * sub-context info can only be set up after the base context
+	 * has been completed.
+	 */
+	ret = wait_event_interruptible(
+		fd->uctxt->wait,
+		!test_bit(HFI2_CTXT_BASE_UNINIT, &fd->uctxt->event_flags));
+
+	if (test_bit(HFI2_CTXT_BASE_FAILED, &fd->uctxt->event_flags))
+		ret = -ENOMEM;
+
+	/* Finish the sub-context init */
+	if (!ret) {
+		fd->rec_cpu_num = hfi2_get_proc_affinity(fd->uctxt->numa_id);
+		ret = init_user_ctxt(fd, fd->uctxt);
+	}
+
+	if (ret) {
+		int last;
+
+		spin_lock_irqsave(&fd->dd->uctxt_lock, flags);
+		__clear_bit(fd->subctxt, fd->uctxt->in_use_ctxts);
+		last = bitmap_empty(fd->uctxt->in_use_ctxts, HFI2_MAX_SHARED_CTXTS);
+		spin_unlock_irqrestore(&fd->dd->uctxt_lock, flags);
+		hfi2_rcd_put(fd->uctxt);
+
+		/*
+		 * When last is true this was the last reference to fd->uctxt.
+		 * No new references to uctxt will be taken. So this task
+		 * must free uctxt.
+		 */
+		if (last)
+			deallocate_ctxt(fd->uctxt);
+		fd->uctxt = NULL;
+	}
+
+	return ret;
+}
+
+int hfi2_do_assign_ctxt(struct hfi2_filedata *fd,
+			const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	struct hfi2_ctxtdata *uctxt = NULL;
+	int ret;
+	u8 pidx = uinfo->port - 1;
+	u8 kdeth_rcv_hdr = uinfo->kdeth_rcvhdrsz;
+
+	if (fd->uctxt)
+		return -EINVAL;
+
+	if (uinfo->subctxt_cnt > HFI2_MAX_SHARED_CTXTS)
+		return -EINVAL;
+
+	/* check, then assign port ASAP */
+	if (pidx >= fd->dd->num_pports)
+		return -EINVAL;
+	fd->ppd = fd->dd->pport + pidx;
+
+	/* verify kdeth receive header size */
+	if (kdeth_rcv_hdr == 0) /* change to default size */
+		kdeth_rcv_hdr = DEFAULT_RCVHDRSIZE;
+	if (kdeth_rcv_hdr < 2 || kdeth_rcv_hdr > 31) /* valid HW range */
+		return -EINVAL;
+
+	/*
+	 * Acquire the mutex to protect against multiple creations of what
+	 * could be a shared base context.
+	 */
+	mutex_lock(&hfi2_mutex);
+	/*
+	 * Get a sub context if available  (fd->uctxt will be set).
+	 * ret < 0 error, 0 no context, 1 sub-context found
+	 */
+	ret = find_sub_ctxt(fd, uinfo);
+
+	/*
+	 * Allocate a base context if context sharing is not required or a
+	 * sub context wasn't found.
+	 */
+	if (!ret) {
+		ret = allocate_ctxt(fd, uinfo, &uctxt);
+		if (ret == 0) {
+			/* override - must be done before setup_base_ctxt() */
+			uctxt->kdeth_rcv_hdr = kdeth_rcv_hdr;
+		}
+	}
+
+	mutex_unlock(&hfi2_mutex);
+
+	/* Depending on the context type, finish the appropriate init */
+	switch (ret) {
+	case 0:
+		ret = setup_base_ctxt(fd, uctxt);
+		if (ret)
+			deallocate_ctxt(uctxt);
+		break;
+	case 1:
+		ret = complete_subctxt(fd);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * match_ctxt - match context
+ * @fd: valid filedata pointer
+ * @uinfo: user info to compare base context with
+ * @uctxt: context to compare uinfo to.
+ *
+ * Compare the given context with the given information to see if it
+ * can be used for a sub context.
+ */
+static int match_ctxt(struct hfi2_filedata *fd,
+		      const struct hfi2_assign_ctxt_cmd *uinfo,
+		      struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_devdata *dd = fd->dd;
+	unsigned long flags;
+	u16 subctxt;
+
+	/* Skip dynamically allocated kernel contexts */
+	if (uctxt->sc && (uctxt->sc->type == SC_KERNEL))
+		return 0;
+
+	/* Skip ctxt if it doesn't match the requested one */
+	if (memcmp(uctxt->uuid, uinfo->uuid, sizeof(uctxt->uuid)) ||
+	    uctxt->jkey != generate_jkey(current_uid()) ||
+	    uctxt->subctxt_id != uinfo->subctxt_id ||
+	    uctxt->subctxt_cnt != uinfo->subctxt_cnt)
+		return 0;
+
+	/* Verify the sharing process matches the base */
+	if (uctxt->userversion != uinfo->userversion)
+		return -EINVAL;
+
+	/* Find an unused sub context */
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	if (bitmap_empty(uctxt->in_use_ctxts, HFI2_MAX_SHARED_CTXTS)) {
+		/* context is being closed, do not use */
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		return 0;
+	}
+
+	subctxt = find_first_zero_bit(uctxt->in_use_ctxts,
+				      HFI2_MAX_SHARED_CTXTS);
+	if (subctxt >= uctxt->subctxt_cnt) {
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		return -EBUSY;
+	}
+
+	fd->subctxt = subctxt;
+	__set_bit(fd->subctxt, uctxt->in_use_ctxts);
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	fd->uctxt = uctxt;
+	hfi2_rcd_get(uctxt);
+
+	return 1;
+}
+
+/**
+ * find_sub_ctxt - fund sub-context
+ * @fd: valid filedata pointer
+ * @uinfo: matching info to use to find a possible context to share.
+ *
+ * The hfi2_mutex must be held when this function is called.  It is
+ * necessary to ensure serialized creation of shared contexts.
+ *
+ * Return:
+ *    0      No sub-context found
+ *    1      Subcontext found and allocated
+ *    errno  EINVAL (incorrect parameters)
+ *           EBUSY (all sub contexts in use)
+ */
+static int find_sub_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	struct hfi2_ctxtdata *uctxt;
+	struct hfi2_devdata *dd = fd->dd;
+	struct hfi2_pportdata *ppd = fd->ppd;
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	u16 i;
+	int ret;
+
+	if (!uinfo->subctxt_cnt)
+		return 0;
+
+	for (i = pr->first_dyn_alloc_ctxt;
+	     i < pr->rcv_context_base + pr->num_rcv_contexts;
+	     i++) {
+		uctxt = hfi2_rcd_get_by_index(dd, i);
+		if (uctxt) {
+			ret = match_ctxt(fd, uinfo, uctxt);
+			hfi2_rcd_put(uctxt);
+			/* value of != 0 will return */
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* return true if there are any user allocated contexts across all ports */
+static bool any_user_allocated_contexts(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		if (dd->pport[i].freectxts != dr->ppr[i].num_user_contexts)
+			return true;
+	}
+	return false;
+}
+
+static int allocate_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo,
+			 struct hfi2_ctxtdata **rcd)
+{
+	struct hfi2_devdata *dd = fd->dd;
+	struct hfi2_pportdata *ppd = fd->ppd;
+	struct hfi2_ctxtdata *uctxt;
+	int ret, numa;
+
+	if (dd->flags & HFI2_FROZEN) {
+		/*
+		 * Pick an error that is unique from all other errors
+		 * that are returned so the user process knows that
+		 * it tried to allocate while the SPC was frozen.  It
+		 * it should be able to retry with success in a short
+		 * while.
+		 */
+		return -EIO;
+	}
+
+	if (!ppd->freectxts)
+		return -EBUSY;
+
+	/*
+	 * If we don't have a NUMA node requested, preference is towards
+	 * device NUMA node.
+	 */
+	fd->rec_cpu_num = hfi2_get_proc_affinity(dd->node);
+	if (fd->rec_cpu_num != -1)
+		numa = cpu_to_node(fd->rec_cpu_num);
+	else
+		numa = numa_node_id();
+	ret = hfi2_create_ctxtdata(ppd, numa, DYNAMIC_CONTEXT, &uctxt);
+	if (ret < 0) {
+		dd_dev_err(dd, "user ctxtdata allocation failed\n");
+		return ret;
+	}
+	hfi2_cdbg(PROC, "[%u:%u] pid %u assigned to CPU %d (NUMA %u)",
+		  uctxt->ctxt, fd->subctxt, current->pid, fd->rec_cpu_num,
+		  uctxt->numa_id);
+
+	/*
+	 * Allocate and enable a PIO send context.
+	 */
+	uctxt->sc = sc_alloc(ppd, SC_USER, uctxt->rcvhdrqentsize, numa);
+	if (!uctxt->sc) {
+		ret = -ENOMEM;
+		goto ctxdata_free;
+	}
+	hfi2_cdbg(PROC, "allocated send context %u(%u)", uctxt->sc->sw_index,
+		  uctxt->sc->hw_context);
+	ret = sc_enable(uctxt->sc);
+	if (ret)
+		goto ctxdata_free;
+
+	/*
+	 * Setup sub context information if the user-level has requested
+	 * sub contexts.
+	 * This has to be done here so the rest of the sub-contexts find the
+	 * proper base context.
+	 * NOTE: _set_bit() can be used here because the context creation is
+	 * protected by the mutex (rather than the spin_lock), and will be the
+	 * very first instance of this context.
+	 */
+	__set_bit(0, uctxt->in_use_ctxts);
+	if (uinfo->subctxt_cnt)
+		init_subctxts(uctxt, uinfo);
+	uctxt->userversion = uinfo->userversion;
+	uctxt->flags = hfi2_cap_mask; /* save current flag state */
+	init_waitqueue_head(&uctxt->wait);
+	strscpy(uctxt->comm, current->comm, sizeof(uctxt->comm));
+	memcpy(uctxt->uuid, uinfo->uuid, sizeof(uctxt->uuid));
+	uctxt->jkey = generate_jkey(current_uid());
+	hfi2_stats.sps_ctxts++;
+	/*
+	 * Disable ASPM when there are open user/PSM contexts to avoid
+	 * issues with ASPM L1 exit latency
+	 */
+	if (!any_user_allocated_contexts(dd))
+		aspm_disable_all(dd);
+	ppd->freectxts--;
+
+	*rcd = uctxt;
+
+	return 0;
+
+ctxdata_free:
+	hfi2_free_ctxt(uctxt);
+	return ret;
+}
+
+static void deallocate_ctxt(struct hfi2_ctxtdata *uctxt)
+{
+	mutex_lock(&hfi2_mutex);
+	hfi2_stats.sps_ctxts--;
+	uctxt->ppd->freectxts++;
+	/* enable ASPM if there are no user contexts */
+	if (!any_user_allocated_contexts(uctxt->dd))
+		aspm_enable_all(uctxt->dd);
+	mutex_unlock(&hfi2_mutex);
+
+	hfi2_free_ctxt(uctxt);
+}
+
+static void init_subctxts(struct hfi2_ctxtdata *uctxt,
+			  const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	uctxt->subctxt_cnt = uinfo->subctxt_cnt;
+	uctxt->subctxt_id = uinfo->subctxt_id;
+	set_bit(HFI2_CTXT_BASE_UNINIT, &uctxt->event_flags);
+}
+
+static int setup_subctxt(struct hfi2_ctxtdata *uctxt)
+{
+	int ret = 0;
+	u16 num_subctxts = uctxt->subctxt_cnt;
+
+	uctxt->subctxt_uregbase = vmalloc_user(PAGE_SIZE);
+	if (!uctxt->subctxt_uregbase)
+		return -ENOMEM;
+
+	/* We can take the size of the RcvHdr Queue from the master */
+	uctxt->subctxt_rcvhdr_base = vmalloc_user(rcvhdrq_size(uctxt) *
+						  num_subctxts);
+	if (!uctxt->subctxt_rcvhdr_base) {
+		ret = -ENOMEM;
+		goto bail_ureg;
+	}
+
+	uctxt->subctxt_rcvegrbuf = vmalloc_user(uctxt->egrbufs.size *
+						num_subctxts);
+	if (!uctxt->subctxt_rcvegrbuf) {
+		ret = -ENOMEM;
+		goto bail_rhdr;
+	}
+
+	return 0;
+
+bail_rhdr:
+	vfree(uctxt->subctxt_rcvhdr_base);
+	uctxt->subctxt_rcvhdr_base = NULL;
+bail_ureg:
+	vfree(uctxt->subctxt_uregbase);
+	uctxt->subctxt_uregbase = NULL;
+
+	return ret;
+}
+
+static void user_init(struct hfi2_ctxtdata *uctxt)
+{
+	unsigned int rcvctrl_ops = 0;
+
+	/* initialize poll variables... */
+	uctxt->urgent = 0;
+	uctxt->urgent_poll = 0;
+
+	/*
+	 * Now enable the ctxt for receive.
+	 * For chips that are set to DMA the tail register to memory
+	 * when they change (and when the update bit transitions from
+	 * 0 to 1.  So for those chips, we turn it off and then back on.
+	 * This will (very briefly) affect any other open ctxts, but the
+	 * duration is very short, and therefore isn't an issue.  We
+	 * explicitly set the in-memory tail copy to 0 beforehand, so we
+	 * don't have to wait to be sure the DMA update has happened
+	 * (chip resets head/tail to 0 on transition to enable).
+	 */
+	if (hfi2_rcvhdrtail_kvaddr(uctxt))
+		clear_rcvhdrtail(uctxt);
+
+	/* Setup J_KEY before enabling the context */
+	hfi2_set_ctxt_jkey(uctxt->dd, uctxt, uctxt->jkey);
+
+	rcvctrl_ops = HFI2_RCVCTRL_CTXT_ENB;
+	rcvctrl_ops |= HFI2_RCVCTRL_URGENT_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, HDRSUPP))
+		rcvctrl_ops |= HFI2_RCVCTRL_TIDFLOW_ENB;
+	/*
+	 * Ignore the bit in the flags for now until proper
+	 * support for multiple packet per rcv array entry is
+	 * added.
+	 */
+	if (!HFI2_CAP_UGET_MASK(uctxt->flags, MULTI_PKT_EGR))
+		rcvctrl_ops |= HFI2_RCVCTRL_ONE_PKT_EGR_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, NODROP_EGR_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_EGR_DROP_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, NODROP_RHQ_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_RHQ_DROP_ENB;
+	/*
+	 * The RcvCtxtCtrl.TailUpd bit has to be explicitly written.
+	 * We can't rely on the correct value to be set from prior
+	 * uses of the chip or ctxt. Therefore, add the rcvctrl op
+	 * for both cases.
+	 */
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, DMA_RTAIL))
+		rcvctrl_ops |= HFI2_RCVCTRL_TAILUPD_ENB;
+	else
+		rcvctrl_ops |= HFI2_RCVCTRL_TAILUPD_DIS;
+	hfi2_rcvctrl(uctxt->dd, rcvctrl_ops, uctxt);
+}
+
+static int init_user_ctxt(struct hfi2_filedata *fd,
+			  struct hfi2_ctxtdata *uctxt)
+{
+	int ret;
+
+	ret = hfi2_user_sdma_alloc_queues(uctxt, fd);
+	if (ret)
+		return ret;
+
+	ret = hfi2_user_exp_rcv_init(fd, uctxt);
+	if (ret)
+		hfi2_user_sdma_free_queues(fd, uctxt);
+
+	return ret;
+}
+
+static int setup_base_ctxt(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_devdata *dd = uctxt->dd;
+	int ret = 0;
+
+	hfi2_init_ctxt(uctxt->sc);
+
+	/* Now allocate the RcvHdr queue and eager buffers. */
+	ret = hfi2_create_rcvhdrq(dd, uctxt);
+	if (ret)
+		goto done;
+
+	ret = hfi2_setup_eagerbufs(uctxt);
+	if (ret)
+		goto done;
+
+	/* If sub-contexts are enabled, do the appropriate setup */
+	if (uctxt->subctxt_cnt)
+		ret = setup_subctxt(uctxt);
+	if (ret)
+		goto done;
+
+	ret = hfi2_alloc_ctxt_rcv_groups(uctxt);
+	if (ret)
+		goto done;
+
+	ret = init_user_ctxt(fd, uctxt);
+	if (ret) {
+		hfi2_free_ctxt_rcv_groups(uctxt);
+		goto done;
+	}
+
+	user_init(uctxt);
+
+	/* Now that the context is set up, the fd can get a reference. */
+	fd->uctxt = uctxt;
+	hfi2_rcd_get(uctxt);
+
+done:
+	if (uctxt->subctxt_cnt) {
+		/*
+		 * On error, set the failed bit so sub-contexts will clean up
+		 * correctly.
+		 */
+		if (ret)
+			set_bit(HFI2_CTXT_BASE_FAILED, &uctxt->event_flags);
+
+		/*
+		 * Base context is done (successfully or not), notify anybody
+		 * using a sub-context that is waiting for this completion.
+		 */
+		clear_bit(HFI2_CTXT_BASE_UNINIT, &uctxt->event_flags);
+		wake_up(&uctxt->wait);
+	}
+
+	return ret;
+}
+
+/*
+ * Find all user contexts in use, and set the specified bit in their
+ * event mask.
+ * See also find_ctxt() for a similar use, that is specific to send buffers.
+ */
+int hfi2_set_uevent_bits(struct hfi2_pportdata *ppd, const int evtbit)
+{
+	struct hfi2_ctxtdata *uctxt;
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	u16 ctxt;
+
+	if (!dd->events)
+		return -EINVAL;
+
+	for (ctxt = pr->first_dyn_alloc_ctxt;
+	     ctxt < pr->rcv_context_base + pr->num_rcv_contexts;
+	     ctxt++) {
+		uctxt = hfi2_rcd_get_by_index(dd, ctxt);
+		if (uctxt) {
+			unsigned long *evs;
+			int i;
+			/*
+			 * subctxt_cnt is 0 if not shared, so do base
+			 * separately, first, then remaining subctxt, if any
+			 */
+			evs = dd->events + uctxt_offset(uctxt);
+			set_bit(evtbit, evs);
+			for (i = 1; i < uctxt->subctxt_cnt; i++)
+				set_bit(evtbit, evs + i);
+			hfi2_rcd_put(uctxt);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * manage_rcvq - manage a context's receive queue
+ * @uctxt: the context
+ * @subctxt: the sub-context
+ * @start_stop: action to carry out
+ *
+ * start_stop == 0 disables receive on the context, for use in queue
+ * overflow conditions.  start_stop==1 re-enables, to be used to
+ * re-init the software copy of the head register
+ */
+int manage_rcvq(struct hfi2_ctxtdata *uctxt, u16 subctxt, int start_stop)
+{
+	struct hfi2_devdata *dd = uctxt->dd;
+	unsigned int rcvctrl_op;
+
+	if (subctxt)
+		return 0;
+
+	/* atomically clear receive enable ctxt. */
+	if (start_stop) {
+		/*
+		 * On enable, force in-memory copy of the tail register to
+		 * 0, so that protocol code doesn't have to worry about
+		 * whether or not the chip has yet updated the in-memory
+		 * copy or not on return from the system call. The chip
+		 * always resets it's tail register back to 0 on a
+		 * transition from disabled to enabled.
+		 */
+		if (hfi2_rcvhdrtail_kvaddr(uctxt))
+			clear_rcvhdrtail(uctxt);
+		rcvctrl_op = HFI2_RCVCTRL_CTXT_ENB;
+	} else {
+		rcvctrl_op = HFI2_RCVCTRL_CTXT_DIS;
+	}
+	hfi2_rcvctrl(dd, rcvctrl_op, uctxt);
+	/* always; new head should be equal to new tail; see above */
+
+	return 0;
+}
+
+/*
+ * clear the event notifier events for this context.
+ * User process then performs actions appropriate to bit having been
+ * set, if desired, and checks again in future.
+ */
+int user_event_ack(struct hfi2_ctxtdata *uctxt, u16 subctxt,
+		   unsigned long events)
+{
+	int i;
+	struct hfi2_devdata *dd = uctxt->dd;
+	unsigned long *evs;
+
+	if (!dd->events)
+		return 0;
+
+	evs = dd->events + uctxt_offset(uctxt) + subctxt;
+
+	for (i = 0; i <= _HFI2_MAX_EVENT_BIT; i++) {
+		if (!test_bit(i, &events))
+			continue;
+		clear_bit(i, evs);
+	}
+	return 0;
+}
+
+int set_ctxt_pkey(struct hfi2_ctxtdata *uctxt, u16 pkey)
+{
+	int i;
+	struct hfi2_pportdata *ppd = uctxt->ppd;
+	struct hfi2_devdata *dd = uctxt->dd;
+
+	if (!HFI2_CAP_IS_USET(PKEY_CHECK))
+		return -EPERM;
+
+	if (pkey == LIM_MGMT_P_KEY || pkey == FULL_MGMT_P_KEY)
+		return -EINVAL;
+
+	for (i = 0; i < dd->params->pkey_table_size; i++)
+		if (pkey == ppd->pkeys[i])
+			return hfi2_set_ctxt_pkey(dd, uctxt, pkey);
+
+	return -ENOENT;
+}
+
+/**
+ * ctxt_reset - Reset the user context
+ * @uctxt: valid user context
+ */
+int ctxt_reset(struct hfi2_ctxtdata *uctxt)
+{
+	struct send_context *sc;
+	struct hfi2_devdata *dd;
+	int ret = 0;
+
+	if (!uctxt || !uctxt->dd || !uctxt->sc)
+		return -EINVAL;
+
+	/*
+	 * There is no protection here. User level has to guarantee that
+	 * no one will be writing to the send context while it is being
+	 * re-initialized.  If user level breaks that guarantee, it will
+	 * break it's own context and no one else's.
+	 */
+	dd = uctxt->dd;
+	sc = uctxt->sc;
+
+	/*
+	 * Wait until the interrupt handler has marked the context as
+	 * halted or frozen. Report error if we time out.
+	 */
+	wait_event_interruptible_timeout(
+		sc->halt_wait, (sc->flags & (SCF_HALTED | SCF_LINK_DOWN)),
+		msecs_to_jiffies(SEND_CTXT_HALT_TIMEOUT));
+	if (!(sc->flags & (SCF_HALTED | SCF_LINK_DOWN)))
+		return -ENOLCK;
+
+	/*
+	 * If the send context was halted due to a Freeze, wait until the
+	 * device has been "unfrozen" before resetting the context.
+	 */
+	if (sc->flags & SCF_FROZEN) {
+		wait_event_interruptible_timeout(
+			dd->event_queue,
+			!(READ_ONCE(dd->flags) & HFI2_FROZEN),
+			msecs_to_jiffies(SEND_CTXT_HALT_TIMEOUT));
+		if (dd->flags & HFI2_FROZEN)
+			return -ENOLCK;
+
+		if (dd->flags & HFI2_FORCED_FREEZE)
+			/*
+			 * Don't allow context reset if we are into
+			 * forced freeze
+			 */
+			return -ENODEV;
+
+		sc_disable(sc);
+		ret = sc_enable(sc);
+		hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_ENB, uctxt);
+	} else {
+		ret = sc_restart(sc);
+	}
+	if (!ret)
+		sc_return_credits(sc);
+
+	return ret;
+}
+
+/* expects stats is already zeroed with memtype and index filled in */
+int hfi2_get_pinning_stats(struct hfi2_filedata *fd,
+			   struct hfi2_pin_stats *stats)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+	int lockidx;
+	int ret;
+
+	if (!pinning_type_supported(stats->memtype))
+		return -EINVAL;
+
+	lockidx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (pq)
+		ret = pinning_interfaces[stats->memtype].get_stats(pq, stats->index, stats);
+	else
+		ret = -EIO;
+	srcu_read_unlock(&fd->pq_srcu, lockidx);
+
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/mmu_rb.c b/drivers/infiniband/hw/hfi2/mmu_rb.c
new file mode 100644
index 000000000000..7ebdc5ab691c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mmu_rb.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2016 - 2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/mmu_notifier.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched/mm.h>
+
+#include "mmu_rb.h"
+#include "trace.h"
+
+static unsigned long mmu_node_start(struct mmu_rb_node *);
+static unsigned long mmu_node_last(struct mmu_rb_node *);
+static int mmu_notifier_range_start(struct mmu_notifier *,
+		const struct mmu_notifier_range *);
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
+					   unsigned long, unsigned long);
+static void release_immediate(struct kref *refcount);
+static void handle_remove(struct work_struct *work);
+
+static const struct mmu_notifier_ops mn_opts = {
+	.invalidate_range_start = mmu_notifier_range_start,
+};
+
+INTERVAL_TREE_DEFINE(struct mmu_rb_node, node, unsigned long, __last,
+		     mmu_node_start, mmu_node_last, static, __mmu_int_rb);
+
+static unsigned long mmu_node_start(struct mmu_rb_node *node)
+{
+	return node->addr & PAGE_MASK;
+}
+
+static unsigned long mmu_node_last(struct mmu_rb_node *node)
+{
+	return PAGE_ALIGN(node->addr + node->len) - 1;
+}
+
+static int _hfi2_mmu_rb_register(void *ops_arg,
+				 const struct mmu_rb_ops *ops,
+				 struct workqueue_struct *wq,
+				 struct mmu_rb_handler **handler,
+				 const struct mmu_notifier_ops *mnops)
+{
+	struct mmu_rb_handler *h;
+	void *free_ptr;
+	int ret;
+
+	free_ptr = kzalloc(sizeof(*h) + cache_line_size() - 1, GFP_KERNEL);
+	if (!free_ptr)
+		return -ENOMEM;
+
+	h = PTR_ALIGN(free_ptr, cache_line_size());
+	h->root = RB_ROOT_CACHED;
+	h->ops = ops;
+	h->ops_arg = ops_arg;
+	INIT_HLIST_NODE(&h->mn.hlist);
+	spin_lock_init(&h->lock);
+	h->mn.ops = &mn_opts;
+	INIT_WORK(&h->del_work, handle_remove);
+	INIT_LIST_HEAD(&h->del_list);
+	INIT_LIST_HEAD(&h->lru_list);
+	h->wq = wq;
+	h->free_ptr = free_ptr;
+
+	ret = mmu_notifier_register(&h->mn, current->mm);
+	if (ret) {
+		kfree(free_ptr);
+		return ret;
+	}
+
+	*handler = h;
+	return 0;
+}
+
+int hfi2_mmu_rb_register(void *ops_arg,
+			 const struct mmu_rb_ops *ops,
+			 struct workqueue_struct *wq,
+			 struct mmu_rb_handler **handler)
+{
+	return _hfi2_mmu_rb_register(ops_arg, ops, wq, handler, &mn_opts);
+}
+
+void hfi2_mmu_rb_unregister(struct mmu_rb_handler *handler)
+{
+	struct mmu_rb_node *rbnode;
+	struct rb_node *node;
+	unsigned long flags;
+	struct list_head del_list;
+
+	/* Prevent freeing of mm until we are completely finished. */
+	mmgrab(handler->mn.mm);
+
+	/* Unregister first so we don't get any more notifications. */
+	mmu_notifier_unregister(&handler->mn, handler->mn.mm);
+
+	/*
+	 * Make sure the wq delete handler is finished running.  It will not
+	 * be triggered once the mmu notifiers are unregistered above.
+	 */
+	flush_work(&handler->del_work);
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	while ((node = rb_first_cached(&handler->root))) {
+		rbnode = rb_entry(node, struct mmu_rb_node, node);
+		rb_erase_cached(node, &handler->root);
+		/* move from LRU list to delete list */
+		list_move(&rbnode->list, &del_list);
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&rbnode->list);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+
+	/* Now the mm may be freed. */
+	mmdrop(handler->mn.mm);
+
+	kfree(handler->free_ptr);
+}
+
+int hfi2_mmu_rb_insert(struct mmu_rb_handler *handler,
+		       struct mmu_rb_node *mnode)
+{
+	struct mmu_rb_node *node;
+	unsigned long flags;
+	int ret = 0;
+
+	trace_hfi2_mmu_rb_insert(mnode);
+
+	if (current->mm != handler->mn.mm)
+		return -EPERM;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
+	if (node) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+	__mmu_int_rb_insert(mnode, &handler->root);
+	list_add_tail(&mnode->list, &handler->lru_list);
+	mnode->handler = handler;
+unlock:
+	spin_unlock_irqrestore(&handler->lock, flags);
+	return ret;
+}
+
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi2_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
+/* Caller must hold handler lock */
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
+					   unsigned long addr,
+					   unsigned long len)
+{
+	struct mmu_rb_node *node = NULL;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	if (!handler->ops->filter) {
+		node = __mmu_int_rb_iter_first(&handler->root, addr,
+					       (addr + len) - 1);
+	} else {
+		for (node = __mmu_int_rb_iter_first(&handler->root, addr,
+						    (addr + len) - 1);
+		     node;
+		     node = __mmu_int_rb_iter_next(node, addr,
+						   (addr + len) - 1)) {
+			if (handler->ops->filter(node, addr, len))
+				return node;
+		}
+	}
+	return node;
+}
+
+/*
+ * Must NOT call while holding mnode->handler->lock.
+ * mnode->handler->ops->remove() may sleep and mnode->handler->lock is a
+ * spinlock.
+ */
+static void release_immediate(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	trace_hfi2_mmu_release_node(mnode);
+	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
+}
+
+/* Caller must hold mnode->handler->lock */
+static void release_nolock(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	queue_work(mnode->handler->wq, &mnode->handler->del_work);
+}
+
+/*
+ * struct mmu_rb_node->refcount kref_put() callback.
+ * Adds mmu_rb_node to mmu_rb_node->handler->del_list and queues
+ * handler->del_work on handler->wq.
+ * Does not remove mmu_rb_node from handler->lru_list or handler->rb_root.
+ * Acquires mmu_rb_node->handler->lock; do not call while already holding
+ * handler->lock.
+ */
+void hfi2_mmu_rb_release(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	struct mmu_rb_handler *handler = mnode->handler;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+	queue_work(handler->wq, &handler->del_work);
+}
+
+void hfi2_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
+{
+	struct mmu_rb_node *rbnode, *ptr;
+	struct list_head del_list;
+	unsigned long flags;
+	bool stop = false;
+
+	if (current->mm != handler->mn.mm)
+		return;
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
+		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
+					&stop)) {
+			__mmu_int_rb_remove(rbnode, &handler->root);
+			/* move from LRU list to delete list */
+			list_move(&rbnode->list, &del_list);
+			++handler->internal_evictions;
+		}
+		if (stop)
+			break;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
+		trace_hfi2_mmu_rb_evict(rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+}
+
+unsigned long hfi2_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg)
+{
+	struct mmu_rb_node *node = NULL, *next;
+	int i;
+
+	next = __mmu_int_rb_iter_first(&handler->root, start, ~0ULL - start);
+	for (i = 0; i < count; i++) {
+		node = next;
+		if (!node)
+			return ~0UL;
+
+		next = __mmu_int_rb_iter_next(node, start + node->len, ~0ULL);
+		fn(node, arg);
+	}
+	return node->addr;
+}
+
+static int mmu_notifier_range_start(struct mmu_notifier *mn,
+		const struct mmu_notifier_range *range)
+{
+	struct mmu_rb_handler *handler =
+		container_of(mn, struct mmu_rb_handler, mn);
+	struct rb_root_cached *root = &handler->root;
+	struct mmu_rb_node *node, *ptr = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
+	     node; node = ptr) {
+		/* Guard against node removal. */
+		ptr = __mmu_int_rb_iter_next(node, range->start,
+					     range->end - 1);
+		trace_hfi2_mmu_mem_invalidate(node);
+		/* Remove from rb tree and lru_list. */
+		__mmu_int_rb_remove(node, root);
+		list_del_init(&node->list);
+		kref_put(&node->refcount, release_nolock);
+		handler->external_evictions++;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Work queue function to remove all nodes that have been queued up to
+ * be removed.  The key feature is that mm->mmap_lock is not being held
+ * and the remove callback can sleep while taking it, if needed.
+ */
+static void handle_remove(struct work_struct *work)
+{
+	struct mmu_rb_handler *handler = container_of(work,
+						struct mmu_rb_handler,
+						del_work);
+	struct list_head del_list;
+	unsigned long flags;
+	struct mmu_rb_node *node;
+
+	/* remove anything that is queued to get removed */
+	spin_lock_irqsave(&handler->lock, flags);
+	list_replace_init(&handler->del_list, &del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		node = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&node->list);
+		trace_hfi2_mmu_release_node(node);
+		handler->ops->remove(handler->ops_arg, node);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/pin_system.c b/drivers/infiniband/hw/hfi2/pin_system.c
new file mode 100644
index 000000000000..2ad8e90c3261
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pin_system.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+
+#include "hfi2.h"
+#include "common.h"
+#include "pinning.h"
+#include "mmu_rb.h"
+#include "user_sdma.h"
+#include "trace.h"
+
+struct sdma_mmu_node {
+	struct mmu_rb_node rb;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct page **pages;
+	unsigned int npages;
+};
+
+static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
+			   unsigned long len);
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *arg2,
+			 bool *stop);
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
+
+static const struct mmu_rb_ops sdma_rb_ops = {
+	.filter = sdma_rb_filter,
+	.evict = sdma_rb_evict,
+	.remove = sdma_rb_remove,
+};
+
+static int init_system_pinning(struct hfi2_user_sdma_pkt_q *pq)
+{
+	struct hfi2_devdata *dd = pq->dd;
+	struct mmu_rb_handler **handler = (struct mmu_rb_handler **)
+		&PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	int ret;
+
+	ret = hfi2_mmu_rb_register(pq, &sdma_rb_ops, dd->hfi2_wq,
+				   handler);
+	if (ret)
+		dd_dev_err(dd,
+			   "[%u:%u] Failed to register system memory DMA support with MMU: %d\n",
+			   pq->ctxt, pq->subctxt, ret);
+	return ret;
+}
+
+static void free_system_pinning(struct hfi2_user_sdma_pkt_q *pq)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	if (handler)
+		hfi2_mmu_rb_unregister(handler);
+}
+
+static u32 sdma_cache_evict(struct hfi2_user_sdma_pkt_q *pq, u32 npages)
+{
+	struct evict_data evict_data;
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	evict_data.cleared = 0;
+	evict_data.target = npages;
+	hfi2_mmu_rb_evict(handler, &evict_data);
+	return evict_data.cleared;
+}
+
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi2_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *e)
+{
+	return e->rb.handler->mn.mm;
+}
+
+static void free_system_node(struct sdma_mmu_node *e)
+{
+	if (e->npages) {
+		trace_unpin_sdma_mem(mm_from_sdma_node(e), HFI2_MEMINFO_TYPE_SYSTEM, 0,
+				     e, e->rb.addr, e->rb.len,
+				     0, (e->npages * PAGE_SIZE));
+		unpin_vector_pages(mm_from_sdma_node(e), e->pages, 0,
+				   e->npages);
+		atomic_sub(e->npages, &e->pq->n_locked);
+	}
+	kfree(e);
+}
+
+/*
+ * A valid @n covers the @start and at least some of [@start, @end)
+ */
+static bool covered_by(struct mmu_rb_node *n, unsigned long start,
+		       unsigned long end)
+{
+	return n->addr <= start && start < (n->addr + n->len);
+}
+
+/*
+ * kref from kref_get() in here will be transferred to the struct
+ * user_sdma_txreq to which the retval struct sdma_mmu_node* is being used for.
+ */
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi2_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		handler->misses++;
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+
+	/* This kref will become the user_sdma_request's kref */
+	kref_get(&rb_node->refcount);
+	handler->hits++;
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return container_of(rb_node, struct sdma_mmu_node, rb);
+}
+
+/*
+ * @start on page boundary.
+ */
+static int pin_system_pages(struct user_sdma_request *req, struct sdma_mmu_node *e,
+			    uintptr_t start, int npages)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	int pinned, cleared;
+	struct page **pages;
+
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+retry:
+	if (!hfi2_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
+				npages)) {
+		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
+			 atomic_read(&pq->n_locked), npages);
+		cleared = sdma_cache_evict(pq, npages);
+		if (cleared >= npages)
+			goto retry;
+	}
+
+	pinned = hfi2_acquire_user_pages(current->mm, start, npages, 0, pages);
+	trace_pin_sdma_mem(current->mm, HFI2_MEMINFO_TYPE_SYSTEM, start,
+			   npages * PAGE_SIZE, pinned, false, e,
+			   0, max(pinned, 0) * PAGE_SIZE);
+	if (pinned < 0) {
+		kfree(pages);
+		return pinned;
+	}
+	if (pinned != npages) {
+		unpin_vector_pages(current->mm, pages, 0, pinned);
+		return -EFAULT;
+	}
+	e->rb.addr = start;
+	e->rb.len = (npages * PAGE_SIZE);
+	e->pages = pages;
+	e->npages = npages;
+	atomic_add(pinned, &pq->n_locked);
+	return 0;
+}
+
+/*
+ * kref refcount on returned node will be 2 on successful addition: one kref
+ * from kref_init() for mmu_rb_handler and one kref to prevent the returned
+ * node from being released until after the returned node is assigned to an
+ * SDMA descriptor (struct sdma_desc) under add_from_iovec(), even if the
+ * virtual address range for the returned node is invalidated between now and
+ * then.
+ *
+ * @return ERR_PTR() or struct sdma_mmu_node *
+ */
+static struct sdma_mmu_node *
+add_system_pinning(struct user_sdma_request *req, unsigned long start,
+		   unsigned long len)
+
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	struct sdma_mmu_node *e;
+	int ret;
+
+	e = kzalloc_obj(e, GFP_KERNEL);
+	if (!e)
+		return ERR_PTR(-ENOMEM);
+
+	/* First kref becomes the mmu_rb_handler's kref */
+	kref_init(&e->rb.refcount);
+
+	/* This kref will become the user_sdma_request's kref */
+	kref_get(&e->rb.refcount);
+
+	e->pq = pq;
+	ret = pin_system_pages(req, e, start, PFN_DOWN(len));
+	if (!ret) {
+		ret = hfi2_mmu_rb_insert(PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM), &e->rb);
+		if (ret) {
+			free_system_node(e);
+			return ERR_PTR(ret);
+		}
+		return e;
+	}
+	kfree(e);
+	return ERR_PTR(ret);
+}
+
+/*
+ * @return ERR_PTR() or struct sdma_mmu_node *
+ */
+static struct sdma_mmu_node *
+get_system_cache_entry(struct user_sdma_request *req, size_t req_start,
+		       size_t req_len)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
+	u64 end = PFN_ALIGN(req_start + req_len);
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	if ((end - start) == 0) {
+		SDMA_DBG(req,
+			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
+			 req_start, req_len, start, end);
+		return ERR_PTR(-EINVAL);
+	}
+
+	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
+
+	while (1) {
+		struct sdma_mmu_node *e =
+			find_system_node(handler, start, end);
+		u64 prepend_len = 0;
+
+		SDMA_DBG(req, "e %p start %llx end %llx", e, start, end);
+		if (!e) {
+			e = add_system_pinning(req, start, end - start);
+			if (IS_ERR(e) && PTR_ERR(e) == -EEXIST) {
+				/*
+				 * Another execution context has inserted a
+				 * conficting entry first.
+				 */
+				continue;
+			}
+			return e;
+		}
+
+		if (e->rb.addr <= start) {
+			/*
+			 * This entry covers at least part of the region. If it doesn't extend
+			 * to the end, then this will be called again for the next segment.
+			 */
+			return e;
+		}
+
+		SDMA_DBG(req, "prepend: e->rb.addr %lx, e->rb.refcount %d",
+			 e->rb.addr, kref_read(&e->rb.refcount));
+		prepend_len = e->rb.addr - start;
+
+		/*
+		 * e will not be returned, instead a new node will be. So
+		 * release the reference.
+		 */
+		kref_put(&e->rb.refcount, hfi2_mmu_rb_release);
+
+		/* Prepend a node to cover the beginning of the allocation */
+		e = add_system_pinning(req, start, prepend_len);
+		if (IS_ERR(e) && PTR_ERR(e) == -EEXIST) {
+			/* Another execution context has inserted a conficting entry first. */
+			continue;
+		}
+		return e;
+	}
+}
+
+static void sdma_mmu_node_put(void *ctx)
+{
+	struct sdma_mmu_node *n = ctx;
+
+	kref_put(&n->rb.refcount, hfi2_mmu_rb_release);
+}
+
+static int add_from_entry(struct user_sdma_request *req,
+			  struct user_sdma_txreq *tx,
+			  struct sdma_mmu_node *e,
+			  size_t start,
+			  size_t from_entry)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	unsigned int page_offset;
+	unsigned int from_page;
+	size_t page_index;
+
+	/*
+	 * Because the cache may be more fragmented than the memory that is being accessed,
+	 * it's not strictly necessary to have a descriptor per cache entry.
+	 */
+	while (from_entry) {
+		int ret;
+
+		page_index = PFN_DOWN(start - e->rb.addr);
+		if (page_index >= e->npages) {
+			SDMA_DBG(req,
+				 "Request for page_index %zu >= e->npages %u",
+				 page_index, e->npages);
+			return -EINVAL;
+		}
+
+		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
+		from_page = PAGE_SIZE - page_offset;
+		if (from_page >= from_entry)
+			from_page = from_entry;
+
+		ret = sdma_txadd_page(pq->dd, &tx->txreq,
+				      e->pages[page_index],
+				      page_offset, from_page);
+		if (ret) {
+			/*
+			 * When there's a failure, the entire request is freed by
+			 * user_sdma_send_pkts().
+			 */
+			SDMA_DBG(req,
+				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_page %u",
+				 ret, page_index, page_offset, from_page);
+			return ret;
+		}
+		start += from_page;
+		from_entry -= from_page;
+	}
+	return 0;
+}
+
+/*
+ * On success, prior to returning, adjusts @remaining, @req->iov_idx,
+ * and @req->iov[req->iov_idx].offset to reflect the data that has
+ * been consumed.
+ *
+ * @remaining: as input, maximum amount of data to add from iovecs at
+ *   @iov and after. As output, the amount of data remaining after
+ *   data was added to packet.
+ */
+static int add_to_txreq(struct user_sdma_request *req,
+			struct user_sdma_txreq *tx,
+			struct user_sdma_iovec *iov,
+			u32 *remaining)
+{
+	struct mmu_rb_handler *cache =
+		PINNING_STATE(req->pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	struct user_sdma_pinref *ht =
+		hfi2_user_sdma_mru_ref(tx, HFI2_MEMINFO_TYPE_SYSTEM);
+	struct sdma_mmu_node *e = (ht ? ht->ptr : NULL);
+	u32 rem = *remaining;
+	int ret = 0;
+
+	while (rem && iov->type == HFI2_MEMINFO_TYPE_SYSTEM) {
+		u64 start = (uintptr_t)iov->iov.iov_base + iov->offset;
+		u64 end = (uintptr_t)iov->iov.iov_base + iov->iov.iov_len;
+		u64 from_this;
+
+		/* Keep using e as long as it covers [start,end) */
+		if (!e || !covered_by(&e->rb, start, end)) {
+			if (ht)
+				cache->hint_misses++;
+			e = get_system_cache_entry(req, start, end - start);
+			if (IS_ERR(e))
+				return PTR_ERR(e);
+			/* transfer e's kref to tx */
+			ret = hfi2_user_sdma_add_ref(tx, e, iov->type);
+			if (ret) {
+				sdma_mmu_node_put(e);
+				return ret;
+			}
+		} else if (ht) {
+			hfi2_user_sdma_touch_ref(tx, ht);
+			cache->hint_hits++;
+		}
+		ht = NULL;
+
+		/* Limit by remaining data in e or iovec, then by caller remaining */
+		from_this = min((e->rb.addr + e->rb.len) - start, end - start);
+		from_this = min_t(u64, from_this, rem);
+		ret = add_from_entry(req, tx, e, start, from_this);
+		SDMA_DBG(req, "iov %p iov_range [%llx,%llx) e %p e_range [%lx,%lx) from_this %llu ret %d",
+			 iov, start, end, e, e->rb.addr, e->rb.addr + e->rb.len,
+			 from_this, ret);
+		if (ret) {
+			/* tx destructor will kref_put() e */
+			return ret;
+		}
+
+		rem -= from_this;
+		iov->offset += from_this;
+		if ((u64)iov->offset >= iov->iov.iov_len) {
+			req->iov_idx++;
+			iov++;
+		}
+	}
+	*remaining = rem;
+	return 0;
+}
+
+static void add_system_stats(const struct mmu_rb_node *e, void *arg)
+{
+	struct hfi2_pin_stats *stats = arg;
+
+	stats->cache_entries++;
+	/*
+	 * '- 1' to account for kref held by mmu_rb_handler.
+	 *
+	 * We're assured that mmu_rb_handler has kref for e because:
+	 * - This function is called in a for-each loop over mmu_rb_handler's rb_nodes
+	 * - That loop is called inside of an mmu_rb_handler->lock critical section
+	 * - Once added to an mmu_rb_handler's cache, mmu_rb_nodes can only be
+	 *    destroyed or queued for destruction inside an mmu_rb_handler->lock
+	 *    critical section
+	 *
+	 * So the fact that e was passed in here means it is still in an mmu_rb_handler's cache.
+	 *
+	 * That said, kref_read() here can overcount the number of actual
+	 * sdma_descs holding references to e. That is because user_sdma
+	 * and mmu_rb_handler code take additional krefs to prevent
+	 * mmu_rb_nodes from being destroyed after the user SDMA request is
+	 * submitted and gets as far as pinning pages, even if the userspace
+	 * virtual address range is invalidated in the meantime. I.e. once the
+	 * user SDMA request gets as far as pinning pages, those pages will
+	 * remain resident up until the SDMA engine completes the request.
+	 */
+	stats->total_refcounts += kref_read(&e->refcount) - 1;
+	stats->total_bytes += e->len;
+}
+
+static int get_system_stats(struct hfi2_user_sdma_pkt_q *pq, int index,
+			    struct hfi2_pin_stats *stats)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	unsigned long next = 0;
+
+	if (index == -1) {
+		stats->index = 1;
+		return 0;
+	}
+
+	if (index != 0)
+		return -EINVAL;
+
+	stats->memtype = HFI2_MEMINFO_TYPE_SYSTEM;
+	stats->id = 0;
+	while (next != ~0UL) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&handler->lock, flags);
+		/* Take stats on 100 nodes at a time.
+		 * This is a balance between time/cost of the operation and
+		 * the latency of other operations waiting for the lock.
+		 */
+		next = hfi2_mmu_rb_for_n(handler, next, 100, add_system_stats,
+					 stats);
+		spin_unlock_irqrestore(&handler->lock, flags);
+		/* This is to allow the lock to be acquired from other places. */
+		ndelay(100);
+	}
+
+	stats->hits = handler->hits;
+	stats->misses = handler->misses;
+	stats->hint_hits = handler->hint_hits;
+	stats->hint_misses = handler->hint_misses;
+	stats->internal_evictions = handler->internal_evictions;
+	stats->external_evictions = handler->external_evictions;
+
+	return 0;
+};
+
+static struct pinning_interface system_pinning_interface = {
+	.init = init_system_pinning,
+	.free = free_system_pinning,
+	.add_to_sdma_packet = add_to_txreq,
+	.put = sdma_mmu_node_put,
+	.get_stats = get_system_stats,
+};
+
+void register_system_pinning_interface(void)
+{
+	register_pinning_interface(HFI2_MEMINFO_TYPE_SYSTEM,
+				   &system_pinning_interface);
+	pr_info("%s System memory DMA support enabled\n", "hfi2");
+}
+
+void deregister_system_pinning_interface(void)
+{
+	deregister_pinning_interface(HFI2_MEMINFO_TYPE_SYSTEM);
+}
+
+static bool sdma_rb_filter(struct mmu_rb_node *e, unsigned long addr,
+			   unsigned long len)
+{
+	return (bool)(e->addr == addr);
+}
+
+/*
+ * Return 1 to remove the node from the rb tree and call the remove op.
+ *
+ * Called with the rb tree lock held.
+ */
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
+			 void *evict_arg, bool *stop)
+{
+	struct sdma_mmu_node *e =
+		container_of(mnode, struct sdma_mmu_node, rb);
+	struct evict_data *evict_data = evict_arg;
+
+	/* e will be evicted, add its pages to our count */
+	evict_data->cleared += e->npages;
+
+	/* have enough pages been cleared? */
+	if (evict_data->cleared >= evict_data->target)
+		*stop = true;
+
+	return 1; /* remove this node */
+}
+
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
+{
+	struct sdma_mmu_node *e =
+		container_of(mnode, struct sdma_mmu_node, rb);
+
+	free_system_node(e);
+}
diff --git a/drivers/infiniband/hw/hfi2/pinning.c b/drivers/infiniband/hw/hfi2/pinning.c
new file mode 100644
index 000000000000..86519255bce1
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pinning.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "pinning.h"
+#include "trace.h"
+
+struct pinning_interface pinning_interfaces[PINNING_MAX_INTERFACES];
+
+void register_pinning_interface(unsigned int type,
+				struct pinning_interface *interface)
+{
+	pinning_interfaces[type] = *interface;
+}
+
+void deregister_pinning_interface(unsigned int type)
+{
+	memset(&pinning_interfaces[type], 0, sizeof(pinning_interfaces[type]));
+}
+
+int init_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (pinning_interfaces[i].init) {
+			ret = pinning_interfaces[i].init(pq);
+			if (ret)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	while (--i >= 0) {
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+	return ret;
+}
+
+void free_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq)
+{
+	unsigned int i;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (trace_pin_stats_enabled() &&
+		    pinning_interfaces[i].get_stats) {
+			struct hfi2_pin_stats s = {0};
+			int ret;
+
+			ret = pinning_interfaces[i].get_stats(pq, 0, &s);
+			if (!WARN_ON_ONCE(ret))
+				trace_pin_stats(pq, &s);
+		}
+
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/tid_system.c b/drivers/infiniband/hw/hfi2/tid_system.c
new file mode 100644
index 000000000000..11217d02e71c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/tid_system.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2018 Intel Corporation.
+ */
+#include "user_exp_rcv.h"
+
+/*
+ * Host memory TID implementation.
+ */
+struct system_tid_user_buf {
+	struct tid_user_buf common;
+	struct mmu_interval_notifier notifier;
+	/*
+	 * cover_mutex serializes mmu_interval_read_retry() and
+	 * mmu_interval_set_seq() on notifier
+	 */
+	struct mutex cover_mutex;
+	unsigned int npages;
+	struct page **pages;
+	long mmu_seq;
+};
+
+struct system_tid_node {
+	struct tid_rb_node common;
+	struct mmu_interval_notifier notifier;
+	struct page *pages[];
+};
+
+static bool sys_tid_invalidate(struct mmu_interval_notifier *mni,
+			       const struct mmu_notifier_range *range,
+			       unsigned long cur_seq);
+
+static bool sys_cover_invalidate(struct mmu_interval_notifier *mni,
+				 const struct mmu_notifier_range *range,
+				 unsigned long cur_seq);
+static void sys_unnotify(struct tid_user_buf *tbuf);
+
+/*
+ * Still takes a tid_user_buf, not system_tid_user_buf since
+ * this may be called through interface in addition to internally.
+ */
+static void sys_user_buf_free(struct tid_user_buf *tbuf);
+
+static const struct mmu_interval_notifier_ops tid_mn_ops = {
+	.invalidate = sys_tid_invalidate,
+};
+
+static const struct mmu_interval_notifier_ops tid_cover_ops = {
+	.invalidate = sys_cover_invalidate,
+};
+
+static inline int num_user_pages(unsigned long addr,
+				 unsigned long len)
+{
+	const unsigned long spage = addr & PAGE_MASK;
+	const unsigned long epage = (addr + len - 1) & PAGE_MASK;
+
+	return 1 + ((epage - spage) >> PAGE_SHIFT);
+}
+
+static inline struct mm_struct *mm_from_tid_node(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	return snode->notifier.mm;
+}
+
+static bool sys_tid_invalidate(struct mmu_interval_notifier *mni,
+			       const struct mmu_notifier_range *range,
+			       unsigned long cur_seq)
+{
+	struct system_tid_node *node =
+		container_of(mni, struct system_tid_node, notifier);
+
+	if (node->common.freed)
+		return true;
+
+	/* take action only if unmapping */
+	if (range->event != MMU_NOTIFY_UNMAP)
+		return true;
+
+	hfi2_user_exp_rcv_invalidate(&node->common);
+
+	return true;
+}
+
+static int sys_node_register_notify(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+	const u32 length = node->npages * (1 << node->page_shift);
+
+	return mmu_interval_notifier_insert(&snode->notifier, current->mm,
+					    node->vaddr, length,
+					    &tid_mn_ops);
+}
+
+static void sys_node_unregister_notify(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	if (snode->common.use_mn)
+		mmu_interval_notifier_remove(&snode->notifier);
+}
+
+static void sys_node_dma_unmap(struct tid_rb_node *node)
+{
+	struct hfi2_devdata *dd = node->fdata->uctxt->dd;
+
+	dma_unmap_single(&dd->pcidev->dev, node->dma_addr, node->npages * PAGE_SIZE,
+			 DMA_FROM_DEVICE);
+}
+
+/*
+ * Release pinned receive buffer pages.
+ */
+static void sys_node_unpin_pages(struct hfi2_filedata *fd,
+				 struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+	struct page **pages;
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+	struct mm_struct *mm;
+
+	dma_unmap_single(&dd->pcidev->dev, node->dma_addr,
+			 node->npages * PAGE_SIZE, DMA_FROM_DEVICE);
+	pages = &snode->pages[0];
+	mm = mm_from_tid_node(node);
+	hfi2_release_user_pages(mm, pages, node->npages, true);
+	fd->tid_n_pinned -= node->npages;
+}
+
+static struct tid_node_ops sys_nodeops;
+
+static struct tid_rb_node *sys_node_init(struct hfi2_filedata *fd,
+					 struct tid_user_buf *tbuf,
+					 u32 rcventry,
+					 struct tid_group *grp,
+					 struct hfi2_page_iter *piter)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+	struct system_tid_node *snode;
+	unsigned int npages;
+	struct page **pages;
+	dma_addr_t phys;
+	u16 pageidx;
+
+	if (iter->setidx >= tbuf->n_psets)
+		return ERR_PTR(-EINVAL);
+
+	npages = tbuf->psets[iter->setidx].count;
+	pageidx = tbuf->psets[iter->setidx].idx;
+	pages = sbuf->pages + pageidx;
+
+	if (!npages)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Allocate snode first so we can handle a potential failure before
+	 * we've programmed anything.
+	 */
+	snode = kzalloc(struct_size(snode, pages, npages), GFP_KERNEL);
+	if (!snode)
+		return ERR_PTR(-ENOMEM);
+
+	phys = dma_map_single(&dd->pcidev->dev, __va(page_to_phys(pages[0])),
+			      npages * PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&dd->pcidev->dev, phys)) {
+		dd_dev_err(dd, "Failed to DMA map Exp Rcv pages 0x%llx\n",
+			   phys);
+		kfree(snode);
+		return ERR_PTR(-EFAULT);
+	}
+
+	snode->common.fdata = fd;
+	mutex_init(&snode->common.invalidate_mutex);
+	snode->common.phys = page_to_phys(pages[0]);
+	snode->common.npages = npages;
+	snode->common.page_shift = PAGE_SHIFT;
+	snode->common.rcventry = rcventry;
+	snode->common.dma_addr = phys;
+	snode->common.vaddr = tbuf->vaddr + (pageidx * PAGE_SIZE);
+	snode->common.grp = grp;
+	snode->common.freed = false;
+	snode->common.ops = &sys_nodeops;
+	snode->common.use_mn = fd->use_mn;
+	snode->common.type = HFI2_MEMINFO_TYPE_SYSTEM;
+	memcpy(snode->pages, pages, flex_array_size(snode, pages, npages));
+
+	return &snode->common;
+}
+
+static void sys_node_free(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	kfree(snode);
+}
+
+static struct tid_node_ops sys_nodeops = {
+	.init = sys_node_init,
+	.free = sys_node_free,
+	.register_notify = sys_node_register_notify,
+	.unregister_notify = sys_node_unregister_notify,
+	.dma_unmap = sys_node_dma_unmap,
+	.unpin_pages = sys_node_unpin_pages,
+};
+
+static unsigned int sys_page_size(struct tid_user_buf *tbuf)
+{
+	return PAGE_SIZE;
+}
+
+/*
+ * Invalidation during insertion callback.
+ */
+static bool sys_cover_invalidate(struct mmu_interval_notifier *mni,
+				 const struct mmu_notifier_range *range,
+				 unsigned long cur_seq)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(mni, struct system_tid_user_buf, notifier);
+
+	/* take action only if unmapping */
+	if (range->event == MMU_NOTIFY_UNMAP) {
+		mutex_lock(&sbuf->cover_mutex);
+		mmu_interval_set_seq(mni, cur_seq);
+		mutex_unlock(&sbuf->cover_mutex);
+	}
+
+	return true;
+}
+
+static struct tid_user_buf_ops sys_bufops;
+
+/*
+ * System memory never honors @allow_unaligned.
+ */
+static int sys_user_buf_init(u16 expected_count, bool notify,
+			     unsigned long vaddr, unsigned long length,
+			     bool allow_unaligned,
+			     struct tid_user_buf **tbuf)
+{
+	struct system_tid_user_buf *sbuf;
+	int ret;
+
+	if (!IS_ALIGNED(vaddr, max(EXP_TID_ADDR_SIZE, PAGE_SIZE)))
+		return -EINVAL;
+
+	sbuf = kzalloc_obj(sbuf, GFP_KERNEL);
+	if (!sbuf)
+		return -ENOMEM;
+	*tbuf = &sbuf->common;
+	mutex_init(&sbuf->cover_mutex);
+
+	ret = tid_user_buf_init(expected_count, vaddr, length, notify, &sys_bufops,
+				HFI2_MEMINFO_TYPE_SYSTEM, *tbuf);
+	if (ret)
+		goto fail_release_mem;
+
+	sbuf->npages = num_user_pages(vaddr, length);
+
+	return 0;
+fail_release_mem:
+	sys_user_buf_free(&sbuf->common);
+	return ret;
+}
+
+static void sys_user_buf_free(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+
+	kfree(sbuf->pages);
+	tid_user_buf_free(tbuf);
+	kfree(sbuf);
+}
+
+/*
+ * Pin receive buffer pages.
+ */
+static int pin_rcv_pages(struct hfi2_filedata *fd, struct system_tid_user_buf *sbuf)
+{
+	int pinned;
+	unsigned int npages = sbuf->npages;
+	unsigned long vaddr = sbuf->common.vaddr;
+	struct page **pages = NULL;
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+
+	if (npages > fd->uctxt->expected_count) {
+		dd_dev_err(dd, "Expected buffer too big\n");
+		return -EINVAL;
+	}
+
+	/* Allocate the array of struct page pointers needed for pinning */
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	/*
+	 * Pin all the pages of the user buffer. If we can't pin all the
+	 * pages, accept the amount pinned so far and program only that.
+	 * User space knows how to deal with partially programmed buffers.
+	 */
+	if (!hfi2_can_pin_pages(dd, current->mm, fd->tid_n_pinned, npages)) {
+		kfree(pages);
+		return -ENOMEM;
+	}
+
+	pinned = hfi2_acquire_user_pages(current->mm, vaddr, npages, true, pages);
+	if (pinned <= 0) {
+		kfree(pages);
+		return pinned;
+	}
+	sbuf->pages = pages;
+	fd->tid_n_pinned += pinned;
+	return pinned;
+}
+
+static int sys_pin_pages(struct hfi2_filedata *fd, struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	int ret;
+
+	if (WARN_ON(fd->use_mn != tbuf->use_mn))
+		return -EINVAL;
+
+	if (tbuf->use_mn) {
+
+		ret = mmu_interval_notifier_insert(&sbuf->notifier, current->mm, tbuf->vaddr,
+						   sbuf->npages * PAGE_SIZE, &tid_cover_ops);
+		if (ret)
+			return ret;
+		sbuf->mmu_seq = mmu_interval_read_begin(&sbuf->notifier);
+	}
+
+	ret = pin_rcv_pages(fd, sbuf);
+	if (ret <= 0 && tbuf->use_mn)
+		sys_unnotify(tbuf);
+
+	return ret;
+}
+
+static void sys_unpin_pages(struct hfi2_filedata *fd,
+			    struct tid_user_buf *tbuf,
+			    unsigned int idx,
+			    unsigned int npages)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	struct page **pages;
+	struct mm_struct *mm;
+
+	pages = &sbuf->pages[idx];
+	mm = current->mm;
+	hfi2_release_user_pages(mm, pages, npages, false);
+	fd->tid_n_pinned -= npages;
+}
+
+static int sys_find_phys_blocks(struct tid_user_buf *tidbuf, unsigned int npages)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tidbuf, struct system_tid_user_buf, common);
+	unsigned int pagecount, pageidx, setcount = 0, i;
+	unsigned long pfn, this_pfn;
+	struct page **pages = sbuf->pages;
+	struct tid_pageset *list = tidbuf->psets;
+
+	if (!npages)
+		return -EINVAL;
+
+	/*
+	 * Look for sets of physically contiguous pages in the user buffer.
+	 * This will allow us to optimize Expected RcvArray entry usage by
+	 * using the bigger supported sizes.
+	 */
+	pfn = page_to_pfn(pages[0]);
+	for (pageidx = 0, pagecount = 1, i = 1; i <= npages; i++) {
+		this_pfn = i < npages ? page_to_pfn(pages[i]) : 0;
+
+		/*
+		 * If the pfn's are not sequential, pages are not physically
+		 * contiguous.
+		 */
+		if (this_pfn != ++pfn) {
+			/*
+			 * At this point we have to loop over the set of
+			 * physically contiguous pages and break them down it
+			 * sizes supported by the HW.
+			 * There are two main constraints:
+			 *     1. The max buffer size is MAX_EXPECTED_BUFFER.
+			 *        If the total set size is bigger than that
+			 *        program only a MAX_EXPECTED_BUFFER chunk.
+			 *     2. The buffer size has to be a power of two. If
+			 *        it is not, round down to the closes power of
+			 *        2 and program that size.
+			 */
+			while (pagecount) {
+				int maxpages = pagecount;
+				u32 bufsize = pagecount * PAGE_SIZE;
+
+				if (bufsize > MAX_EXPECTED_BUFFER)
+					maxpages =
+						MAX_EXPECTED_BUFFER >>
+						PAGE_SHIFT;
+				else if (!is_power_of_2(bufsize))
+					maxpages =
+						rounddown_pow_of_two(bufsize) >>
+						PAGE_SHIFT;
+
+				list[setcount].idx = pageidx;
+				list[setcount].count = maxpages;
+				pagecount -= maxpages;
+				pageidx += maxpages;
+				setcount++;
+			}
+			pageidx = i;
+			pagecount = 1;
+			pfn = this_pfn;
+		} else {
+			pagecount++;
+		}
+	}
+	tidbuf->n_psets = setcount;
+	return 0;
+}
+
+static bool sys_invalidated(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	bool ret = false;
+
+	if (!tbuf->use_mn)
+		return false;
+
+	mutex_lock(&sbuf->cover_mutex);
+	ret = mmu_interval_read_retry(&sbuf->notifier, sbuf->mmu_seq);
+	mutex_unlock(&sbuf->cover_mutex);
+	return ret;
+}
+
+static void sys_unnotify(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+
+	if (tbuf->use_mn)
+		mmu_interval_notifier_remove(&sbuf->notifier);
+}
+
+static struct tid_user_buf_ops sys_bufops = {
+	.init = sys_user_buf_init,
+	.free = sys_user_buf_free,
+	.pin_pages = sys_pin_pages,
+	.page_size = sys_page_size,
+	.unpin_pages = sys_unpin_pages,
+	.find_phys_blocks = sys_find_phys_blocks,
+	.invalidated = sys_invalidated,
+	.unnotify = sys_unnotify,
+};
+
+int register_system_tid_ops(void)
+{
+	return register_tid_ops(HFI2_MEMINFO_TYPE_SYSTEM, &sys_bufops, &sys_nodeops);
+}
+
+void deregister_system_tid_ops(void)
+{
+	deregister_tid_ops(HFI2_MEMINFO_TYPE_SYSTEM);
+}
diff --git a/drivers/infiniband/hw/hfi2/user_exp_rcv.c b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
new file mode 100644
index 000000000000..98761a511f5e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
@@ -0,0 +1,1013 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2018 Intel Corporation.
+ */
+#include <asm/page.h>
+#include <linux/string.h>
+
+#include "mmu_rb.h"
+#include "user_exp_rcv.h"
+#include "trace.h"
+
+static void unlock_exp_tids(struct hfi2_ctxtdata *uctxt,
+			    struct exp_tid_set *set, struct hfi2_filedata *fd);
+static void cacheless_tid_rb_remove(struct hfi2_filedata *fdata,
+				    struct tid_rb_node *tnode);
+static int program_rcvarray(struct hfi2_filedata *fd, struct tid_user_buf *tbuf,
+			    struct tid_group *grp, u16 count, u32 *tidlist,
+			    unsigned int *tididx, struct hfi2_page_iter *iter,
+			    unsigned int *pmapped);
+static int unprogram_rcvarray(struct hfi2_filedata *fd, u32 tidinfo);
+static void __clear_tid_node(struct hfi2_filedata *fd,
+			     struct tid_rb_node *node);
+static void clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node);
+
+/*
+ * Initialize context and file private data needed for Expected
+ * receive caching. This needs to be done after the context has
+ * been configured with the eager/expected RcvEntry counts.
+ */
+int hfi2_user_exp_rcv_init(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt)
+{
+	int ret = 0;
+
+	fd->entry_to_rb = kcalloc(uctxt->expected_count,
+				  sizeof(*fd->entry_to_rb), GFP_KERNEL);
+	if (!fd->entry_to_rb)
+		return -ENOMEM;
+
+	if (!HFI2_CAP_UGET_MASK(uctxt->flags, TID_UNMAP)) {
+		fd->invalid_tid_idx = 0;
+		fd->invalid_tids = kcalloc(uctxt->expected_count,
+					   sizeof(*fd->invalid_tids),
+					   GFP_KERNEL);
+		if (!fd->invalid_tids) {
+			kfree(fd->entry_to_rb);
+			fd->entry_to_rb = NULL;
+			return -ENOMEM;
+		}
+		fd->use_mn = true;
+	}
+
+	/*
+	 * PSM does not have a good way to separate, count, and
+	 * effectively enforce a limit on RcvArray entries used by
+	 * subctxts (when context sharing is used) when TID caching
+	 * is enabled. To help with that, we calculate a per-process
+	 * RcvArray entry share and enforce that.
+	 * If TID caching is not in use, PSM deals with usage on its
+	 * own. In that case, we allow any subctxt to take all of the
+	 * entries.
+	 *
+	 * Make sure that we set the tid counts only after successful
+	 * init.
+	 */
+	spin_lock(&fd->tid_lock);
+	if (uctxt->subctxt_cnt && fd->use_mn) {
+		u16 remainder;
+
+		fd->tid_limit = uctxt->expected_count / uctxt->subctxt_cnt;
+		remainder = uctxt->expected_count % uctxt->subctxt_cnt;
+		if (remainder && fd->subctxt < remainder)
+			fd->tid_limit++;
+	} else {
+		fd->tid_limit = uctxt->expected_count;
+	}
+	spin_unlock(&fd->tid_lock);
+
+	return ret;
+}
+
+void hfi2_user_exp_rcv_free(struct hfi2_filedata *fd)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	mutex_lock(&uctxt->exp_mutex);
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_full_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_full_list, fd);
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_used_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_used_list, fd);
+	mutex_unlock(&uctxt->exp_mutex);
+
+	kfree(fd->invalid_tids);
+	fd->invalid_tids = NULL;
+
+	kfree(fd->entry_to_rb);
+	fd->entry_to_rb = NULL;
+}
+
+static struct tid_user_buf_ops *bufops[HFI2_MAX_MEMINFO_ENTRIES];
+static struct tid_node_ops *nodeops[HFI2_MAX_MEMINFO_ENTRIES];
+
+/*
+ * Register TID memory-pinning implementation for @type memory.
+ *
+ * @type one of the HFI2_MEMINFO_TYPE* defines found in hfi2_ioctl.h
+ * @op Buffer ops to register
+ * @nops Node ops to register
+ *
+ * @return 0 on success, non-zero on error
+ */
+int register_tid_ops(u16 type, struct tid_user_buf_ops *op,
+		     struct tid_node_ops *nops)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return -EINVAL;
+	bufops[type] = op;
+	nodeops[type] = nops;
+	return 0;
+}
+
+void deregister_tid_ops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return;
+	bufops[type] = NULL;
+	nodeops[type] = NULL;
+}
+
+static struct tid_user_buf_ops *get_bufops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return NULL;
+	return bufops[type];
+}
+
+static struct tid_node_ops *get_nodeops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return NULL;
+	return nodeops[type];
+}
+
+int tid_user_buf_init(u16 pset_size, unsigned long vaddr, unsigned long length,
+		      bool notify, struct tid_user_buf_ops *ops, u16 type,
+		      struct tid_user_buf *tbuf)
+{
+	tbuf->vaddr = vaddr;
+	tbuf->length = length;
+	tbuf->use_mn = notify;
+	tbuf->psets = kcalloc(pset_size, sizeof(*tbuf->psets), GFP_KERNEL);
+	if (!tbuf->psets)
+		return -ENOMEM;
+	tbuf->ops = ops;
+	tbuf->type = type;
+	return 0;
+}
+
+void tid_user_buf_free(struct tid_user_buf *tbuf)
+{
+	kfree(tbuf->psets);
+	tbuf->psets = NULL;
+}
+
+/**
+ * create_user_buf - create user buf for @memtype, store at @*ubuf
+ * @fd: filedata pointer
+ * @memtype: memory type (one of HFI2_MEMINFO_TYPE* defines)
+ * @tinfo: TID info from user
+ * @allow_unaligned: whether unaligned buffers are permitted
+ * @ubuf: output pointer for the created user buffer
+ *
+ * Return: 0 on success, non-zero on failure.
+ */
+static int create_user_buf(struct hfi2_filedata *fd, u16 memtype,
+			   struct hfi2_tid_info *tinfo, bool allow_unaligned,
+			   struct tid_user_buf **ubuf)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct tid_user_buf_ops *ops;
+	int ret;
+
+	ops = get_bufops(memtype);
+	if (!ops)
+		return -EINVAL;
+
+	if (tinfo->length == 0)
+		return -EINVAL;
+
+	ret = ops->init(uctxt->expected_count, fd->use_mn, tinfo->vaddr,
+			tinfo->length, allow_unaligned, ubuf);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int page_array_iter_next(struct hfi2_page_iter *piter)
+{
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+
+	if (!iter->tbuf->psets || !iter->tbuf->n_psets)
+		return -EINVAL;
+
+	iter->setidx++;
+
+	return (iter->setidx < iter->tbuf->n_psets);
+}
+
+static void page_array_iter_free(struct hfi2_page_iter *piter)
+{
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+
+	kfree(iter);
+}
+
+static struct hfi2_page_iter_ops page_array_iter_ops = {
+	.next = page_array_iter_next,
+	.free = page_array_iter_free
+};
+
+static struct hfi2_page_iter *tid_user_buf_iter_begin(struct tid_user_buf *tbuf)
+{
+	struct page_array_iter *iter;
+
+	if (!tbuf->psets || !tbuf->n_psets)
+		return ERR_PTR(-EINVAL);
+
+	iter = kzalloc_obj(iter, GFP_KERNEL);
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+
+	iter->common.ops = &page_array_iter_ops;
+	iter->tbuf = tbuf;
+
+	return &iter->common;
+}
+
+static struct hfi2_page_iter *create_dma_iter(struct tid_user_buf *tbuf)
+{
+	if (tbuf->ops->iter_begin)
+		return tbuf->ops->iter_begin(tbuf);
+
+	return tid_user_buf_iter_begin(tbuf);
+}
+
+/*
+ * Get number of TID-ready pinned-pagesets for @tbuf using hfi2_page_iter.
+ *
+ * @return >= 0 for number of pagesets, < 0 on error.
+ */
+static int pagesets_iter(struct tid_user_buf *tbuf, int cap)
+{
+	struct hfi2_page_iter *iter;
+	int p = 0;
+	int ret;
+
+	iter = create_dma_iter(tbuf);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	while (true) {
+		if (p >= cap)
+			break;
+		p++;
+		ret = iter->ops->next(iter);
+		if (ret < 0)
+			goto bail;
+		else if (!ret)
+			break;
+	}
+	ret = p;
+bail:
+	iter->ops->free(iter);
+	return ret;
+}
+
+/*
+ * Get number of TID-ready pinned-pagesets for @tbuf.
+ *
+ * Each pageset is a physically contiguous range of pages and:
+ * - Starts on a 4KiB-aligned address.
+ * - Length is power-of-two in range [4KiB,2MiB].
+ *
+ * @cap hint on how many pagesets can be returned.
+ *
+ * @return >= 0 number of pagesets, < 0 on error.
+ */
+static int pagesets(struct tid_user_buf *tbuf, int cap)
+{
+	int ret;
+
+	if (tbuf->ops->find_phys_blocks) {
+		ret = tbuf->ops->find_phys_blocks(tbuf, cap);
+		if (ret)
+			return (ret < 0 ? ret : -EFAULT);
+
+		return tbuf->n_psets;
+	}
+
+	/* No find_phys_blocks(); count using iterator */
+	return pagesets_iter(tbuf, cap);
+}
+
+/*
+ * RcvArray entry allocation for Expected Receives is done by the
+ * following algorithm:
+ *
+ * The context keeps 3 lists of groups of RcvArray entries:
+ *   1. List of empty groups - tid_group_list
+ *      This list is created during user context creation and
+ *      contains elements which describe sets (of 8) of empty
+ *      RcvArray entries.
+ *   2. List of partially used groups - tid_used_list
+ *      This list contains sets of RcvArray entries which are
+ *      not completely used up. Another mapping request could
+ *      use some of all of the remaining entries.
+ *   3. List of full groups - tid_full_list
+ *      This is the list where sets that are completely used
+ *      up go.
+ *
+ * An attempt to optimize the usage of RcvArray entries is
+ * made by finding all sets of physically contiguous pages in a
+ * user's buffer.
+ * These physically contiguous sets are further split into
+ * sizes supported by the receive engine of the HFI. The
+ * resulting sets of pages are stored in struct tid_pageset,
+ * which describes the sets as:
+ *    * .count - number of pages in this set
+ *    * .idx - starting index into struct page ** array
+ *                    of this set
+ *
+ * From this point on, the algorithm deals with the page sets
+ * described above. The number of pagesets is divided by the
+ * RcvArray group size to produce the number of full groups
+ * needed.
+ *
+ * Groups from the 3 lists are manipulated using the following
+ * rules:
+ *   1. For each set of 8 pagesets, a complete group from
+ *      tid_group_list is taken, programmed, and moved to
+ *      the tid_full_list list.
+ *   2. For all remaining pagesets:
+ *      2.1 If the tid_used_list is empty and the tid_group_list
+ *          is empty, stop processing pageset and return only
+ *          what has been programmed up to this point.
+ *      2.2 If the tid_used_list is empty and the tid_group_list
+ *          is not empty, move a group from tid_group_list to
+ *          tid_used_list.
+ *      2.3 For each group is tid_used_group, program as much as
+ *          can fit into the group. If the group becomes fully
+ *          used, move it to tid_full_list.
+ */
+int hfi2_user_exp_rcv_setup(struct hfi2_filedata *fd,
+			    struct hfi2_tid_info *tinfo, bool allow_unaligned,
+			    bool do_tidcnt_check)
+{
+	int ret = 0, need_group = 0, pinned;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	/*
+	 * mapped and mapped_pages are implementation-sized pages, not
+	 * EXP_TID_ADDR_SIZE-sized.
+	 */
+	unsigned int ngroups, pageset_count, tididx = 0, mapped,
+					     mapped_pages = 0;
+
+	u16 memtype = (tinfo->flags & HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK);
+	struct tid_user_buf *tidbuf;
+	struct hfi2_page_iter *iter;
+	u32 *tidlist = NULL;
+	unsigned int psets;
+
+	trace_hfi2_exp_tid_update(uctxt->ctxt, fd->subctxt, tinfo);
+
+	ret = create_user_buf(fd, memtype, tinfo, allow_unaligned, &tidbuf);
+	if (ret)
+		return ret;
+
+	pinned = tidbuf->ops->pin_pages(fd, tidbuf);
+	if (pinned <= 0) {
+		dd_dev_warn_ratelimited(dd,
+					"%s: Failed to pin %lu bytes (%d)\n",
+					__func__, tidbuf->length, pinned);
+		ret = (pinned < 0) ? pinned : -ENOSPC;
+		goto fail_free;
+	}
+
+	/* Cannot program TIDs for < EXP_TID_ADDR_SIZE pages */
+	if (tidbuf->ops->page_size(tidbuf) < EXP_TID_ADDR_SIZE) {
+		ret = -EOPNOTSUPP;
+		goto fail_unpin;
+	}
+
+	/* Find sets of physically contiguous pages */
+	ret = pagesets(tidbuf, pinned);
+	if (ret < 0)
+		goto fail_unpin;
+	psets = (unsigned int)ret;
+
+	/* Reserve the number of expected tids to be used. */
+	spin_lock(&fd->tid_lock);
+	if (fd->tid_used + psets > fd->tid_limit)
+		pageset_count = fd->tid_limit - fd->tid_used;
+	else
+		pageset_count = psets;
+	fd->tid_used += pageset_count;
+	spin_unlock(&fd->tid_lock);
+
+	if (!pageset_count) {
+		ret = -ENOSPC;
+		goto fail_unreserve;
+	}
+
+	ngroups = pageset_count / dd->rcv_entries.group_size;
+	tidlist = kcalloc(pageset_count, sizeof(*tidlist), GFP_KERNEL);
+	if (!tidlist) {
+		ret = -ENOMEM;
+		goto fail_unreserve;
+	}
+
+	tididx = 0;
+	iter = create_dma_iter(tidbuf);
+	if (IS_ERR(iter)) {
+		ret = PTR_ERR(iter);
+		goto fail_unreserve;
+	} else if (!iter) {
+		ret = -EFAULT;
+		goto fail_unreserve;
+	}
+
+	/*
+	 * From this point on, we are going to be using shared (between master
+	 * and subcontexts) context resources. We need to take the lock.
+	 */
+	mutex_lock(&uctxt->exp_mutex);
+	/*
+	 * The first step is to program the RcvArray entries which are complete
+	 * groups.
+	 */
+	while (ngroups && uctxt->tid_group_list.count) {
+		struct tid_group *grp = tid_group_pop(&uctxt->tid_group_list);
+
+		ret = program_rcvarray(fd, tidbuf, grp,
+				       dd->rcv_entries.group_size, tidlist,
+				       &tididx, iter, &mapped);
+		/*
+		 * If there was a failure to program the RcvArray
+		 * entries for the entire group, reset the grp fields
+		 * and add the grp back to the free group list.
+		 */
+		if (ret <= 0) {
+			tid_group_add_tail(grp, &uctxt->tid_group_list);
+			hfi2_cdbg(TID, "Failed to program RcvArray group %d",
+				  ret);
+			goto unlock;
+		}
+
+		tid_group_add_tail(grp, &uctxt->tid_full_list);
+		ngroups--;
+		mapped_pages += mapped;
+	}
+
+	while (tididx < pageset_count) {
+		struct tid_group *grp, *ptr;
+		/*
+		 * If we don't have any partially used tid groups, check
+		 * if we have empty groups. If so, take one from there and
+		 * put in the partially used list.
+		 */
+		if (!uctxt->tid_used_list.count || need_group) {
+			if (!uctxt->tid_group_list.count)
+				goto unlock;
+
+			grp = tid_group_pop(&uctxt->tid_group_list);
+			tid_group_add_tail(grp, &uctxt->tid_used_list);
+			need_group = 0;
+		}
+		/*
+		 * There is an optimization opportunity here - instead of
+		 * fitting as many page sets as we can, check for a group
+		 * later on in the list that could fit all of them.
+		 */
+		list_for_each_entry_safe(grp, ptr, &uctxt->tid_used_list.list,
+					 list) {
+			unsigned int use = min_t(unsigned int, pageset_count - tididx,
+					     grp->size - grp->used);
+
+			ret = program_rcvarray(fd, tidbuf, grp, use, tidlist,
+					       &tididx, iter, &mapped);
+			if (ret < 0) {
+				hfi2_cdbg(
+					TID,
+					"Failed to program RcvArray entries %d",
+					ret);
+				goto unlock;
+			} else if (ret > 0) {
+				if (grp->used == grp->size)
+					tid_group_move(grp,
+						       &uctxt->tid_used_list,
+						       &uctxt->tid_full_list);
+				mapped_pages += mapped;
+				need_group = 0;
+				/* Check if we are done so we break out early */
+				if (tididx >= pageset_count)
+					break;
+			} else if (WARN_ON(ret == 0)) {
+				/*
+				 * If ret is 0, we did not program any entries
+				 * into this group, which can only happen if
+				 * we've screwed up the accounting somewhere.
+				 * Warn and try to continue.
+				 */
+				need_group = 1;
+			}
+		}
+	}
+unlock:
+	mutex_unlock(&uctxt->exp_mutex);
+
+	iter->ops->free(iter);
+
+	/*
+	 * mapped_pages is based on implementation page size, not expected
+	 * receive addressing.
+	 *
+	 * E.g. if implementation uses 64KiB pages and expected receive
+	 * addressing is based on 4KiB, for 128KiB of mapped memory,
+	 * mapped_pages=2 not mapped_pages=32.
+	 */
+	hfi2_cdbg(TID, "total mapped: tidpairs:%u pages:%u (%d)", tididx,
+		  mapped_pages, ret);
+
+	/* fail if nothing was programmed, set error if none provided */
+	if (tididx == 0) {
+		if (ret >= 0)
+			ret = -ENOSPC;
+		goto fail_unreserve;
+	}
+
+	/* adjust reserved tid_used to actual count */
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count - tididx;
+	spin_unlock(&fd->tid_lock);
+
+	/* unpin all pages not covered by a TID */
+	tidbuf->ops->unpin_pages(fd, tidbuf, mapped_pages,
+				 pinned - mapped_pages);
+
+	/* check for an invalidate during setup */
+	if (tidbuf->ops->invalidated(tidbuf)) {
+		ret = -EBUSY;
+		goto fail_unprogram;
+	}
+
+	/* verify claimed incoming TID buffer has enough entries for result */
+	if (do_tidcnt_check && tinfo->tidcnt < tididx) {
+		ret = -ENOSPC;
+		goto fail_unprogram;
+	}
+
+	tinfo->tidcnt = tididx;
+	/* Should never happen but detect if somehow implementation pinned too many pages */
+	if (check_mul_overflow(mapped_pages, tidbuf->ops->page_size(tidbuf),
+			       &tinfo->length)) {
+		ret = -EFAULT;
+		goto fail_unprogram;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(tinfo->tidlist), tidlist,
+			 sizeof(tidlist[0]) * tididx)) {
+		ret = -EFAULT;
+		goto fail_unprogram;
+	}
+
+	tidbuf->ops->unnotify(tidbuf);
+	tidbuf->ops->free(tidbuf);
+	kfree(tidlist);
+	return 0;
+
+fail_unprogram:
+	/* unprogram, unmap, and unpin all allocated TIDs */
+	tinfo->tidlist = (unsigned long)tidlist;
+	hfi2_user_exp_rcv_clear(fd, (struct hfi2_tid_info *)tinfo);
+	tinfo->tidlist = 0;
+	pinned = 0; /* nothing left to unpin */
+	pageset_count = 0; /* nothing left reserved */
+fail_unreserve:
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count;
+	spin_unlock(&fd->tid_lock);
+fail_unpin:
+	tidbuf->ops->unnotify(tidbuf);
+	if (pinned > 0)
+		tidbuf->ops->unpin_pages(fd, tidbuf, 0, pinned);
+fail_free:
+	tidbuf->ops->free(tidbuf);
+	kfree(tidlist);
+	return ret;
+}
+
+int hfi2_user_exp_rcv_clear(struct hfi2_filedata *fd,
+			    struct hfi2_tid_info *tinfo)
+{
+	int ret = 0;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	u32 *tidinfo;
+	unsigned int tididx;
+
+	if (unlikely(tinfo->tidcnt > fd->tid_used))
+		return -EINVAL;
+
+	tidinfo = memdup_array_user(u64_to_user_ptr(tinfo->tidlist),
+				    tinfo->tidcnt, sizeof(tidinfo[0]));
+	if (IS_ERR(tidinfo))
+		return PTR_ERR(tidinfo);
+
+	mutex_lock(&uctxt->exp_mutex);
+	for (tididx = 0; tididx < tinfo->tidcnt; tididx++) {
+		ret = unprogram_rcvarray(fd, tidinfo[tididx]);
+		if (ret) {
+			hfi2_cdbg(TID, "Failed to unprogram rcv array %d", ret);
+			break;
+		}
+	}
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= tididx;
+	spin_unlock(&fd->tid_lock);
+	tinfo->tidcnt = tididx;
+	mutex_unlock(&uctxt->exp_mutex);
+
+	kfree(tidinfo);
+	return ret;
+}
+
+int hfi2_user_exp_rcv_invalid(struct hfi2_filedata *fd,
+			      struct hfi2_tid_info *tinfo, bool do_tidcnt_check)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	unsigned long *ev =
+		uctxt->dd->events + (uctxt_offset(uctxt) + fd->subctxt);
+	u32 *array;
+	int ret = 0;
+
+	if (!fd->invalid_tids)
+		return -EINVAL;
+
+	/*
+	 * copy_to_user() can sleep, which will leave the invalid_lock
+	 * locked and cause the MMU notifier to be blocked on the lock
+	 * for a long time.
+	 * Copy the data to a local buffer so we can release the lock.
+	 */
+	array = kcalloc(uctxt->expected_count, sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return -EFAULT;
+
+	spin_lock(&fd->invalid_lock);
+	if (do_tidcnt_check && tinfo->tidcnt < fd->invalid_tid_idx) {
+		ret = -ENOSPC;
+	} else if (fd->invalid_tid_idx) {
+		memcpy(array, fd->invalid_tids,
+		       sizeof(*array) * fd->invalid_tid_idx);
+		memset(fd->invalid_tids, 0,
+		       sizeof(*fd->invalid_tids) * fd->invalid_tid_idx);
+		tinfo->tidcnt = fd->invalid_tid_idx;
+		fd->invalid_tid_idx = 0;
+		/*
+		 * Reset the user flag while still holding the lock.
+		 * Otherwise, PSM can miss events.
+		 */
+		clear_bit(_HFI2_EVENT_TID_MMU_NOTIFY_BIT, ev);
+	} else {
+		tinfo->tidcnt = 0;
+	}
+	spin_unlock(&fd->invalid_lock);
+
+	if (ret == 0 && tinfo->tidcnt) {
+		if (copy_to_user((void __user *)tinfo->tidlist, array,
+				 sizeof(*array) * tinfo->tidcnt))
+			ret = -EFAULT;
+	}
+	kfree(array);
+
+	return ret;
+}
+
+/*
+ * Convert @node's implementation-defined npages to number of
+ * EXP_TID_ADDR_SIZE pages.
+ *
+ * @return number of EXP_TID_ADDR_SIZE pages
+ */
+static unsigned int node_npages(const struct tid_rb_node *node)
+{
+	/* Underflow/overflow protection here depends on other places enforcing that:
+	 *   page_shift >= EXP_TID_ADDR_SHIFT
+	 *   node->npages * (1 << page_shift) <= MAX_EXPECTED_BUFFER
+	 */
+	return (node->npages << node->page_shift) >> EXP_TID_ADDR_SHIFT;
+}
+
+/*
+ * DMA-map and program single TID entry for physically contiguous pinned page
+ * range.
+ *
+ * @fd
+ * @tbuf
+ * @rcventry
+ * @grp
+ * @iter
+ * @onode out node. Undefined on error.
+ *
+ * @return 0 on success, non-zero on error.
+ */
+static int set_rcvarray_entry(struct hfi2_filedata *fd,
+			      struct tid_user_buf *tbuf, u32 rcventry,
+			      struct tid_group *grp,
+			      struct hfi2_page_iter *iter,
+			      struct tid_rb_node **onode)
+{
+	struct tid_node_ops *nodeops = get_nodeops(tbuf->type);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	struct tid_rb_node *node;
+	int ret;
+
+	if (WARN_ON(!nodeops))
+		return -EINVAL;
+
+	node = nodeops->init(fd, tbuf, rcventry, grp, iter);
+	if (IS_ERR(node))
+		return PTR_ERR(node);
+
+	if (node->use_mn) {
+		ret = node->ops->register_notify(node);
+		if (ret)
+			goto out_unmap;
+	}
+	*onode = node;
+	fd->entry_to_rb[node->rcventry] = node;
+
+	/* RcvArray entry requires EXP_TID_ADDR_SIZE page-size npages */
+	dd->params->put_tid(uctxt, rcventry, PT_EXPECTED, node->dma_addr,
+			    ilog2(node_npages(node)) + 1, false);
+
+	trace_hfi2_exp_tid_reg(uctxt->ctxt, fd->subctxt, rcventry,
+			       node_npages(node), node->vaddr, node->phys,
+			       node->dma_addr, node->type);
+	return 0;
+out_unmap:
+	hfi2_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
+		  node->rcventry, node->vaddr, node->phys, ret);
+
+	node->ops->dma_unmap(node);
+	node->ops->free(node);
+
+	return -EFAULT;
+}
+
+/**
+ * program_rcvarray() - program an RcvArray group with receive buffers
+ * @fd: filedata pointer
+ * @tbuf: pointer to struct tid_user_buf that has the user buffer starting
+ *	  virtual address, buffer length, page pointers, pagesets (array of
+ *	  struct tid_pageset holding information on physically contiguous
+ *	  chunks from the user buffer), and other fields.
+ * @grp: RcvArray group
+ * @count: number of struct tid_pageset's to program
+ * @tidlist: the array of u32 elements when the information about the
+ *           programmed RcvArray entries is to be encoded.
+ * @tididx: starting offset into tidlist
+ * @iter: iterator for the user buffer pagesets
+ * @pmapped: (output parameter) number of implementation pages programmed into the RcvArray
+ *           entries.
+ *
+ * This function will program up to 'count' number of RcvArray entries from the
+ * group 'grp'. To make best use of write-combining writes, the function will
+ * perform writes to the unused RcvArray entries which will be ignored by the
+ * HW. Each RcvArray entry will be programmed with a physically contiguous
+ * buffer chunk from the user's virtual buffer.
+ *
+ * Return:
+ * -EINVAL if the requested count is larger than the size of the group,
+ * -ENOMEM or -EFAULT on error from set_rcvarray_entry(), or
+ * number of RcvArray entries programmed.
+ */
+static int program_rcvarray(struct hfi2_filedata *fd, struct tid_user_buf *tbuf,
+			    struct tid_group *grp, u16 count, u32 *tidlist,
+			    unsigned int *tididx, struct hfi2_page_iter *iter,
+			    unsigned int *pmapped)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	u16 idx;
+	u32 tidinfo = 0, rcventry, useidx = 0;
+	int mapped = 0;
+	int ret;
+
+	/* Count should never be larger than the group size */
+	if (count > grp->size)
+		return -EINVAL;
+
+	/* Find the first unused entry in the group */
+	for (idx = 0; idx < grp->size; idx++) {
+		if (!(grp->map & (1 << idx))) {
+			useidx = idx;
+			break;
+		}
+		uctxt->dd->params->rcv_array_wc_fill(uctxt, grp->base + idx,
+						     PT_EXPECTED);
+	}
+
+	idx = 0;
+	while (idx < count) {
+		struct tid_rb_node *node;
+
+		/*
+		 * If this entry in the group is used, move to the next one.
+		 * If we go past the end of the group, exit the loop.
+		 */
+		if (useidx >= grp->size) {
+			break;
+		} else if (grp->map & (1 << useidx)) {
+			uctxt->dd->params->rcv_array_wc_fill(
+				uctxt, grp->base + useidx, PT_EXPECTED);
+			useidx++;
+			continue;
+		}
+
+		rcventry = grp->base + useidx;
+		ret = set_rcvarray_entry(fd, tbuf, rcventry, grp, iter, &node);
+		if (ret)
+			return ret;
+		mapped += node->npages;
+
+		/* In-memory TIDs requires EXP_TID_ADDR_SIZE page-size npages */
+		tidinfo = create_tid(rcventry, node_npages(node));
+		tidlist[(*tididx)++] = tidinfo;
+		grp->used++;
+		grp->map |= 1 << useidx++;
+		idx++;
+		ret = iter->ops->next(iter);
+		if (ret < 0) {
+			/* Make sure ret won't be treated as a success value */
+			return ret;
+		} else if (!ret && idx < count) {
+			/* Exhausted all DMA-pagesets but not done programming */
+			return -EFAULT;
+		}
+	}
+
+	/* Fill the rest of the group with "blank" writes */
+	for (; useidx < grp->size; useidx++)
+		uctxt->dd->params->rcv_array_wc_fill(uctxt, grp->base + useidx,
+						     PT_EXPECTED);
+	*pmapped = mapped;
+	return idx;
+}
+
+static int unprogram_rcvarray(struct hfi2_filedata *fd, u32 tidinfo)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	struct tid_rb_node *node;
+	u32 tidctrl = EXP_TID_GET(tidinfo, CTRL);
+	u32 tididx = EXP_TID_GET(tidinfo, IDX) << 1, rcventry;
+
+	if (tidctrl == 0x3 || tidctrl == 0x0)
+		return -EINVAL;
+
+	rcventry = tididx + (tidctrl - 1);
+
+	if (rcventry >= uctxt->expected_count) {
+		dd_dev_err(dd,
+			   "Invalid RcvArray entry (%u) index for ctxt %u\n",
+			   rcventry, uctxt->ctxt);
+		return -EINVAL;
+	}
+
+	node = fd->entry_to_rb[rcventry];
+	if (!node || node->rcventry != rcventry)
+		return -EBADF;
+
+	node->ops->unregister_notify(node);
+	cacheless_tid_rb_remove(fd, node);
+
+	return 0;
+}
+
+static void __clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	mutex_lock(&node->invalidate_mutex);
+	if (node->freed)
+		goto done;
+	node->freed = true;
+
+	trace_hfi2_exp_tid_unreg(uctxt->ctxt, fd->subctxt, node->rcventry,
+				 node_npages(node), node->vaddr, node->phys,
+				 node->dma_addr, node->type);
+
+	/* Make sure device has seen the write before pages are unpinned */
+	uctxt->dd->params->put_tid(uctxt, node->rcventry, PT_EXPECTED, 0, 0,
+				   true);
+
+	node->ops->unpin_pages(fd, node);
+done:
+	mutex_unlock(&node->invalidate_mutex);
+}
+
+static void clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	__clear_tid_node(fd, node);
+
+	node->grp->used--;
+	node->grp->map &= ~(1 << (node->rcventry - node->grp->base));
+
+	if (node->grp->used == node->grp->size - 1)
+		tid_group_move(node->grp, &uctxt->tid_full_list,
+			       &uctxt->tid_used_list);
+	else if (!node->grp->used)
+		tid_group_move(node->grp, &uctxt->tid_used_list,
+			       &uctxt->tid_group_list);
+	node->ops->free(node);
+}
+
+/*
+ * As a simple helper for hfi2_user_exp_rcv_free, this function deals with
+ * clearing nodes in the non-cached case.
+ */
+static void unlock_exp_tids(struct hfi2_ctxtdata *uctxt,
+			    struct exp_tid_set *set, struct hfi2_filedata *fd)
+{
+	struct tid_group *grp, *ptr;
+	int i;
+
+	list_for_each_entry_safe(grp, ptr, &set->list, list) {
+		list_del_init(&grp->list);
+
+		for (i = 0; i < grp->size; i++) {
+			if (grp->map & (1 << i)) {
+				u16 rcventry = grp->base + i;
+				struct tid_rb_node *node;
+
+				node = fd->entry_to_rb[rcventry];
+				if (!node || node->rcventry != rcventry)
+					continue;
+
+				node->ops->unregister_notify(node);
+				cacheless_tid_rb_remove(fd, node);
+			}
+		}
+	}
+}
+
+/**
+ * Unprogram TID for @node, updating user TID invalidation events when
+ * @node->fdata->use_mn is true.
+ */
+void hfi2_user_exp_rcv_invalidate(struct tid_rb_node *node)
+{
+	struct hfi2_filedata *fdata = node->fdata;
+	struct hfi2_ctxtdata *uctxt = fdata->uctxt;
+
+	trace_hfi2_exp_tid_inval(uctxt->ctxt, fdata->subctxt, node->vaddr,
+				 node->rcventry, node_npages(node),
+				 node->dma_addr, node->type);
+
+	/* clear the hardware rcvarray entry */
+	__clear_tid_node(fdata, node);
+
+	/* User TID invalidation events not in use, nothing else to do */
+	if (!node->use_mn)
+		return;
+
+	spin_lock(&fdata->invalid_lock);
+	if (fdata->invalid_tid_idx < uctxt->expected_count) {
+		/* In-memory TIDs requires EXP_TID_ADDR_SIZE page-size npages */
+		fdata->invalid_tids[fdata->invalid_tid_idx] =
+			create_tid(node->rcventry, node_npages(node));
+		if (!fdata->invalid_tid_idx) {
+			unsigned long *ev;
+
+			/*
+			 * hfi2_set_uevent_bits() sets a user event flag
+			 * for all processes. Because calling into the
+			 * driver to process TID cache invalidations is
+			 * expensive and TID cache invalidations are
+			 * handled on a per-process basis, we can
+			 * optimize this to set the flag only for the
+			 * process in question.
+			 */
+			ev = uctxt->dd->events +
+			     (uctxt_offset(uctxt) + fdata->subctxt);
+			set_bit(_HFI2_EVENT_TID_MMU_NOTIFY_BIT, ev);
+		}
+		fdata->invalid_tid_idx++;
+	}
+	spin_unlock(&fdata->invalid_lock);
+}
+
+static void cacheless_tid_rb_remove(struct hfi2_filedata *fdata,
+				    struct tid_rb_node *tnode)
+{
+	fdata->entry_to_rb[tnode->rcventry] = NULL;
+	clear_tid_node(fdata, tnode);
+}
diff --git a/drivers/infiniband/hw/hfi2/user_pages.c b/drivers/infiniband/hw/hfi2/user_pages.c
new file mode 100644
index 000000000000..700520886a56
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_pages.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+
+static unsigned long cache_size = 256;
+module_param(cache_size, ulong, 0644);
+MODULE_PARM_DESC(cache_size, "Send and receive side cache size limit (in MB)");
+
+/*
+ * Determine whether the caller can pin pages.
+ *
+ * This function should be used in the implementation of buffer caches.
+ * The cache implementation should call this function prior to attempting
+ * to pin buffer pages in order to determine whether they should do so.
+ * The function computes cache limits based on the configured ulimit and
+ * cache size. Use of this function is especially important for caches
+ * which are not limited in any other way (e.g. by HW resources) and, thus,
+ * could keeping caching buffers.
+ *
+ */
+bool hfi2_can_pin_pages(struct hfi2_devdata *dd, struct mm_struct *mm,
+			u32 nlocked, u32 npages)
+{
+	unsigned long ulimit_pages;
+	unsigned long cache_limit_pages;
+	unsigned int usr_ctxts;
+	int pidx;
+
+	/*
+	 * Perform RLIMIT_MEMLOCK based checks unless CAP_IPC_LOCK is present.
+	 */
+	if (!capable(CAP_IPC_LOCK)) {
+		ulimit_pages =
+			DIV_ROUND_DOWN_ULL(rlimit(RLIMIT_MEMLOCK), PAGE_SIZE);
+
+		/*
+		 * Pinning these pages would exceed this process's locked memory
+		 * limit.
+		 */
+		if (atomic64_read(&mm->pinned_vm) + npages > ulimit_pages)
+			return false;
+
+		/*
+		 * Only allow 1/4 of the user's RLIMIT_MEMLOCK to be used for HFI
+		 * caches.  This fraction is then equally distributed among all
+		 * existing user contexts.  Note that if RLIMIT_MEMLOCK is
+		 * 'unlimited' (-1), the value of this limit will be > 2^42 pages
+		 * (2^64 / 2^12 / 2^8 / 2^2).
+		 *
+		 * The effectiveness of this check may be reduced if I/O occurs on
+		 * some user contexts before all user contexts are created.  This
+		 * check assumes that this process is the only one using this
+		 * context (e.g., the corresponding fd was not passed to another
+		 * process for concurrent access) as there is no per-context,
+		 * per-process tracking of pinned pages.  It also assumes that each
+		 * user context has only one cache to limit.
+		 */
+		usr_ctxts = 0;
+		for (pidx = 0; pidx < dd->num_pports; pidx++)
+			usr_ctxts += (dd->rsrcs.ppr[pidx].num_rcv_contexts -
+				      dd->rsrcs.ppr[pidx].n_krcv_queues);
+		if (nlocked + npages > (ulimit_pages / usr_ctxts / 4))
+			return false;
+	}
+
+	/*
+	 * Pinning these pages would exceed the size limit for this cache.
+	 */
+	cache_limit_pages = cache_size * (1024 * 1024) / PAGE_SIZE;
+	if (nlocked + npages > cache_limit_pages)
+		return false;
+
+	return true;
+}
+
+int hfi2_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t npages,
+			    bool writable, struct page **pages)
+{
+	int ret;
+	unsigned int gup_flags = FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);
+
+	ret = pin_user_pages_fast(vaddr, npages, gup_flags, pages);
+	if (ret < 0)
+		return ret;
+
+	atomic64_add(ret, &mm->pinned_vm);
+
+	return ret;
+}
+
+void hfi2_release_user_pages(struct mm_struct *mm, struct page **p,
+			     size_t npages, bool dirty)
+{
+	unpin_user_pages_dirty_lock(p, npages, dirty);
+
+	if (mm) { /* during close after signal, mm can be NULL */
+		atomic64_sub(npages, &mm->pinned_vm);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/user_sdma.c b/drivers/infiniband/hw/hfi2/user_sdma.c
new file mode 100644
index 000000000000..b3eacf40f110
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_sdma.c
@@ -0,0 +1,1667 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/dmapool.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/uio.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/mmu_context.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+
+#include "hfi2.h"
+#include "sdma.h"
+#include "user_sdma.h"
+#include "verbs.h" /* for the headers */
+#include "common.h" /* for struct hfi2_tid_info */
+#include "trace.h"
+
+static uint hfi2_sdma_comp_ring_size = 128;
+module_param_named(sdma_comp_size, hfi2_sdma_comp_ring_size, uint, 0444);
+MODULE_PARM_DESC(sdma_comp_size,
+		 "Size of User SDMA completion ring. Default: 128");
+
+static unsigned int initial_pkt_count = 8;
+
+static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts);
+static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status);
+static inline void pq_update(struct hfi2_user_sdma_pkt_q *pq);
+static void user_sdma_free_request(struct user_sdma_request *req);
+static int check_header_template(struct user_sdma_request *req,
+				 struct user_sdma_txreq *tx, u32 lrhlen,
+				 u32 datalen);
+static int set_txreq_header(struct user_sdma_request *req,
+			    struct user_sdma_txreq *tx, u32 datalen);
+static int set_txreq_header_ahg(struct user_sdma_request *req,
+				struct user_sdma_txreq *tx, u32 len);
+static inline void set_comp_state(struct hfi2_user_sdma_pkt_q *pq,
+				  struct hfi2_user_sdma_comp_q *cq, u16 idx,
+				  enum hfi2_sdma_comp_state state, int ret);
+static inline u32 set_pkt_bth_psn(__be32 bthpsn, u8 expct, u32 frags);
+static inline u32 get_lrh_len(struct user_sdma_request *req, u32 len);
+
+static int defer_packet_queue(struct sdma_engine *sde, struct iowait_work *wait,
+			      struct sdma_txreq *txreq, uint seq,
+			      bool pkts_sent);
+static void activate_packet_queue(struct iowait *wait, int reason);
+
+static int defer_packet_queue(struct sdma_engine *sde, struct iowait_work *wait,
+			      struct sdma_txreq *txreq, uint seq,
+			      bool pkts_sent)
+{
+	struct hfi2_user_sdma_pkt_q *pq =
+		container_of(wait->iow, struct hfi2_user_sdma_pkt_q, busy);
+
+	write_seqlock(&sde->waitlock);
+	trace_hfi2_usdma_defer(pq, sde, &pq->busy);
+	if (sdma_progress(sde, seq, txreq))
+		goto eagain;
+	/*
+	 * We are assuming that if the list is enqueued somewhere, it
+	 * is to the dmawait list since that is the only place where
+	 * it is supposed to be enqueued.
+	 */
+	xchg(&pq->state, SDMA_PKT_Q_DEFERRED);
+	if (list_empty(&pq->busy.list)) {
+		pq->busy.lock = &sde->waitlock;
+		iowait_get_priority(&pq->busy);
+		iowait_queue(pkts_sent, &pq->busy, &sde->dmawait);
+	}
+	write_sequnlock(&sde->waitlock);
+	return -EBUSY;
+eagain:
+	write_sequnlock(&sde->waitlock);
+	return -EAGAIN;
+}
+
+static void activate_packet_queue(struct iowait *wait, int reason)
+{
+	struct hfi2_user_sdma_pkt_q *pq =
+		container_of(wait, struct hfi2_user_sdma_pkt_q, busy);
+
+	trace_hfi2_usdma_activate(pq, wait, reason);
+	xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
+	wake_up(&wait->wait_dma);
+};
+
+#define HEADER_ALIGN 256 /* memory alignment for header descriptors */
+
+int hfi2_user_sdma_alloc_queues(struct hfi2_ctxtdata *uctxt,
+				struct hfi2_filedata *fd)
+{
+	int ret = -ENOMEM;
+	char buf[64];
+	struct hfi2_devdata *dd;
+	struct hfi2_user_sdma_comp_q *cq;
+	struct hfi2_user_sdma_pkt_q *pq;
+
+	if (!uctxt || !fd)
+		return -EBADF;
+
+	if (!hfi2_sdma_comp_ring_size)
+		return -EINVAL;
+
+	dd = uctxt->dd;
+
+	pq = kzalloc(sizeof(*pq), GFP_KERNEL);
+	if (!pq)
+		return -ENOMEM;
+	pq->dd = dd;
+	pq->ctxt = uctxt->ctxt;
+	pq->subctxt = fd->subctxt;
+	pq->n_max_reqs = hfi2_sdma_comp_ring_size;
+	atomic_set(&pq->n_reqs, 0);
+	init_waitqueue_head(&pq->wait);
+	atomic_set(&pq->n_locked, 0);
+
+	iowait_init(&pq->busy, 0, NULL, NULL, defer_packet_queue,
+		    activate_packet_queue, NULL, NULL);
+
+	pq->reqs = kcalloc(hfi2_sdma_comp_ring_size, sizeof(*pq->reqs),
+			   GFP_KERNEL);
+	if (!pq->reqs)
+		goto pq_reqs_nomem;
+
+	pq->req_in_use = bitmap_zalloc(hfi2_sdma_comp_ring_size, GFP_KERNEL);
+	if (!pq->req_in_use)
+		goto pq_reqs_no_in_use;
+
+	snprintf(buf, 64, "txreq-kmem-cache-%u-%u-%u", dd->unit, uctxt->ctxt,
+		 fd->subctxt);
+	pq->txreq_cache = kmem_cache_create(buf, sizeof(struct user_sdma_txreq),
+					    HEADER_ALIGN, SLAB_HWCACHE_ALIGN,
+					    NULL);
+	if (!pq->txreq_cache) {
+		dd_dev_err(dd, "[%u] Failed to allocate TxReq cache\n",
+			   uctxt->ctxt);
+		goto pq_txreq_nomem;
+	}
+
+	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	if (!cq)
+		goto cq_nomem;
+
+	cq->comps = vmalloc_user(
+		PAGE_ALIGN(sizeof(*cq->comps) * hfi2_sdma_comp_ring_size));
+	if (!cq->comps)
+		goto cq_comps_nomem;
+
+	cq->nentries = hfi2_sdma_comp_ring_size;
+
+	ret = init_pinning_interfaces(pq);
+	if (ret)
+		goto pq_mmu_fail;
+
+	rcu_assign_pointer(fd->pq, pq);
+	fd->cq = cq;
+
+	return 0;
+
+pq_mmu_fail:
+	vfree(cq->comps);
+cq_comps_nomem:
+	kfree(cq);
+cq_nomem:
+	kmem_cache_destroy(pq->txreq_cache);
+pq_txreq_nomem:
+	bitmap_free(pq->req_in_use);
+pq_reqs_no_in_use:
+	kfree(pq->reqs);
+pq_reqs_nomem:
+	kfree(pq);
+
+	return ret;
+}
+
+static void flush_pq_iowait(struct hfi2_user_sdma_pkt_q *pq)
+{
+	unsigned long flags;
+	seqlock_t *lock = pq->busy.lock;
+
+	if (!lock)
+		return;
+	write_seqlock_irqsave(lock, flags);
+	if (!list_empty(&pq->busy.list)) {
+		list_del_init(&pq->busy.list);
+		pq->busy.lock = NULL;
+	}
+	write_sequnlock_irqrestore(lock, flags);
+}
+
+int hfi2_user_sdma_free_queues(struct hfi2_filedata *fd,
+			       struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+
+	trace_hfi2_sdma_user_free_queues(uctxt->dd, uctxt->ctxt, fd->subctxt);
+
+	spin_lock(&fd->pq_rcu_lock);
+	pq = srcu_dereference_check(fd->pq, &fd->pq_srcu,
+				    lockdep_is_held(&fd->pq_rcu_lock));
+	if (pq) {
+		rcu_assign_pointer(fd->pq, NULL);
+		spin_unlock(&fd->pq_rcu_lock);
+		synchronize_srcu(&fd->pq_srcu);
+		/* at this point there can be no more new requests */
+		iowait_sdma_drain(&pq->busy);
+		/* Wait until all requests have been freed. */
+		wait_event_interruptible(pq->wait, !atomic_read(&pq->n_reqs));
+		kfree(pq->reqs);
+		free_pinning_interfaces(pq);
+		bitmap_free(pq->req_in_use);
+		kmem_cache_destroy(pq->txreq_cache);
+		flush_pq_iowait(pq);
+		kfree(pq);
+	} else {
+		spin_unlock(&fd->pq_rcu_lock);
+	}
+	if (fd->cq) {
+		vfree(fd->cq->comps);
+		kfree(fd->cq);
+		fd->cq = NULL;
+	}
+	return 0;
+}
+
+static u8 dlid_to_selector(u16 dlid)
+{
+	static u8 mapping[256];
+	static int initialized;
+	static u8 next;
+	int hash;
+
+	if (!initialized) {
+		memset(mapping, 0xFF, 256);
+		initialized = 1;
+	}
+
+	hash = ((dlid >> 8) ^ dlid) & 0xFF;
+	if (mapping[hash] == 0xFF) {
+		mapping[hash] = next;
+		next = (next + 1) & 0x7F;
+	}
+
+	return mapping[hash];
+}
+
+/* return the data length expressed in the template LRH */
+static inline u32 template_data_len(struct user_sdma_request *req)
+{
+	u32 len;
+
+	if (req->is16b) {
+		/*
+		 * The incoming LRH template length is:
+		 *   lrh_len = header_len + data_len + ICRC
+		 *   => data_len = lrh_len - header_len - ICRC
+		 *   header_len = req->hsize - sizeof(PBC)
+		 *   ICRC = 8 bytes (for 16B packets)
+		 */
+		len = req->lrh_len_bytes - (req->hsize - sizeof(req->h.pbc)) -
+		      8;
+	} else {
+		/*
+		 * The minimum representable packet data length in a
+		 * header is 4 bytes, therefore, when the data length
+		 * request is less than 4 bytes, there's only one
+		 * packet, and the packet data length is equal to that
+		 * of the request data length.
+		 */
+		if (req->data_len < sizeof(u32))
+			len = req->data_len;
+		else
+			len = (req->lrh_len_bytes - (req->hsize - 4));
+	}
+
+	return len;
+}
+
+/*
+ * Decide if the PBC is for 9B or 16B packets.
+ * Expect the PBC to be endianized for the CPU.
+ *
+ * Return:
+ * 0       - PBC is 9B or 16B, set is_16b accordingly
+ * -EINVAL - PBC not 9B or 16B
+ *
+ */
+static int check_pbc_16b(struct hfi2_devdata *dd, u64 pbc, bool *is_16b)
+{
+	u32 l2type;
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* WFR: if bypass is set, it is 16B, else 9B */
+		*is_16b = !!(pbc & PBC_PACKET_BYPASS);
+		return 0;
+	}
+
+	/* JKR and beyond */
+	l2type = (pbc >> PBC_L2_TYPE_SHIFT) & 0x3;
+	if (l2type == PBC_L2_16B) {
+		*is_16b = true;
+		return 0;
+	}
+	if (l2type == PBC_L2_9B) {
+		*is_16b = false;
+		return 0;
+	}
+	/* unexpected l2 type */
+
+	return -EINVAL;
+}
+
+/**
+ * hfi2_user_sdma_process_request() - Process and start a user sdma request
+ * @fd: valid file descriptor
+ * @iovec: array of io vectors to process
+ * @dim: overall iovec array size
+ * @count: number of io vector array entries processed
+ */
+int hfi2_user_sdma_process_request(struct hfi2_filedata *fd,
+				   struct iovec *iovec, unsigned long dim,
+				   unsigned long *count)
+{
+	int ret = 0, i;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_pportdata *ppd = uctxt->ppd;
+	struct hfi2_user_sdma_pkt_q *pq =
+		srcu_dereference(fd->pq, &fd->pq_srcu);
+	struct hfi2_user_sdma_comp_q *cq = fd->cq;
+	struct hfi2_devdata *dd = pq->dd;
+	unsigned long idx = 0;
+	u8 pcount = initial_pkt_count;
+	struct sdma_req_info info;
+	u64 cpu_pbc;
+	unsigned long rsize;
+	void *rhdr; /* header remainder */
+	__be32 *bth;
+	struct hfi2_kdeth_header *kdeth;
+	bool lrh_grh;
+
+	/*
+	 * For PSM2-CUDA backwards compatibility.
+	 * Start by assuming u16 .flags not present.
+	 * Add sizeof(u16) back once determined that .flags is present.
+	 */
+	int infosz = sizeof(struct sdma_req_info);
+	struct user_sdma_request *req;
+	size_t header_offset;
+	u8 opcode, sc, vl;
+	u16 pkey;
+	u32 slid;
+	u16 dlid;
+	u32 selector;
+
+	if (iovec[idx].iov_len < infosz) {
+		hfi2_cdbg(
+			SDMA,
+			"[%u:%u:%u] First vector not big enough for info %lu/%u",
+			dd->unit, uctxt->ctxt, fd->subctxt, iovec[idx].iov_len,
+			infosz);
+		return -EINVAL;
+	}
+	ret = copy_from_user(&info, iovec[idx].iov_base, sizeof(info));
+	if (ret) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u] Failed to copy info QW (%d)",
+			  dd->unit, uctxt->ctxt, fd->subctxt, ret);
+		return -EFAULT;
+	}
+
+	trace_hfi2_sdma_user_reqinfo(dd, uctxt->ctxt, fd->subctxt,
+				     (u16 *)&info);
+	if (info.comp_idx >= hfi2_sdma_comp_ring_size) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u:%u] Invalid comp index", dd->unit,
+			  uctxt->ctxt, fd->subctxt, info.comp_idx);
+		return -EINVAL;
+	}
+
+	/*
+	 * Sanity check the header io vector count.  Need at least 1 vector
+	 * (header) and cannot be larger than the actual io vector count.
+	 */
+	if (req_iovcnt(info.ctrl) < 1 || req_iovcnt(info.ctrl) > dim) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u:%u] Invalid iov count %d, dim %ld",
+			  dd->unit, uctxt->ctxt, fd->subctxt, info.comp_idx,
+			  req_iovcnt(info.ctrl), dim);
+		return -EINVAL;
+	}
+
+	if (!info.fragsize) {
+		hfi2_cdbg(SDMA,
+			  "[%u:%u:%u:%u] Request does not specify fragsize",
+			  dd->unit, uctxt->ctxt, fd->subctxt, info.comp_idx);
+		return -EINVAL;
+	}
+
+	/* Try to claim the request. */
+	if (test_and_set_bit(info.comp_idx, pq->req_in_use)) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u] Entry %u is in use", dd->unit,
+			  uctxt->ctxt, fd->subctxt, info.comp_idx);
+		return -EBADSLT;
+	}
+	/*
+	 * All safety checks have been done and this request has been claimed.
+	 */
+	trace_hfi2_sdma_user_process_request(dd, uctxt->ctxt, fd->subctxt,
+					     info.comp_idx);
+	req = pq->reqs + info.comp_idx;
+	req->data_iovs = req_iovcnt(info.ctrl) - 1; /* subtract header vector */
+	req->data_len = 0;
+	req->pq = pq;
+	req->cq = cq;
+	req->ahg_idx = -1;
+	req->iov_idx = 0;
+	req->sent = 0;
+	req->seqnum = 0;
+	req->seqcomp = 0;
+	req->seqsubmitted = 0;
+	req->tids = NULL;
+	req->has_error = 0;
+	req->hsize = 0; /* set below */
+	req->lrh_len_bytes = 0; /* set below */
+	req->pad_mask = 0; /* set below */
+	req->tailsize = 0; /* set below */
+	req->is16b = false; /* set below */
+	INIT_LIST_HEAD(&req->txps);
+	req->n_pinrefs = 0;
+	req->pinref_seqnum = 0;
+
+	memcpy(&req->info, &info, sizeof(info));
+
+	/* The request is initialized, count it */
+	atomic_inc(&pq->n_reqs);
+
+	if (req_opcode(info.ctrl) == EXPECTED) {
+		/* expected must have a TID info and at least one data vector */
+		if (req->data_iovs < 2) {
+			SDMA_DBG(
+				req,
+				"Not enough vectors for expected request: 0x%x",
+				info.ctrl);
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->data_iovs--;
+	}
+
+	if (!info.npkts || req->data_iovs > ARRAY_SIZE(req->iovs)) {
+		SDMA_DBG(req, "Too many vectors (%u/%u)", req->data_iovs,
+			 (u32)ARRAY_SIZE(req->iovs));
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	if (req_has_meminfo(info.ctrl)) {
+		/* Copy the meminfo from the user buffer */
+		if (iovec[idx].iov_len < infosz + sizeof(req->meminfo)) {
+			SDMA_DBG(
+				req,
+				"First vector not big enough for meminfo %lu/%lu",
+				iovec[idx].iov_len,
+				infosz + sizeof(req->meminfo));
+			ret = -EINVAL;
+			goto free_req;
+		}
+		ret = copy_from_user(&req->meminfo,
+				     iovec[idx].iov_base + sizeof(info),
+				     sizeof(req->meminfo));
+		if (ret) {
+			SDMA_DBG(req, "Failed to copy meminfo (%d)", ret);
+			ret = -EFAULT;
+			goto free_req;
+		}
+		header_offset = sizeof(info) + sizeof(req->meminfo);
+	} else {
+		req->meminfo.types = 0;
+		header_offset = sizeof(info);
+	}
+
+	/* copy in the PBC to find the packet type: 9B or 16B */
+	if (iovec[idx].iov_len < header_offset + sizeof(req->h.pbc)) {
+		SDMA_DBG(req, "First vector not big enough for pbc %lu/%lu",
+			 iovec[idx].iov_len,
+			 header_offset + sizeof(req->h.pbc));
+		ret = -EINVAL;
+		goto free_req;
+	}
+	ret = copy_from_user(&req->h.pbc, iovec[idx].iov_base + header_offset,
+			     sizeof(req->h.pbc));
+	if (ret) {
+		SDMA_DBG(req, "Failed to copy header template pbc (%d)", ret);
+		ret = -EFAULT;
+		goto free_req;
+	}
+	header_offset += sizeof(req->h.pbc);
+
+	cpu_pbc = le64_to_cpu(*(__le64 *)req->h.pbc);
+	vl = (cpu_pbc >> PBC_VL_SHIFT) & PBC_VL_MASK;
+
+	ret = check_pbc_16b(dd, cpu_pbc, &req->is16b);
+	if (ret) {
+		SDMA_DBG(req, "Bad header template PBC L2 type");
+		goto free_req;
+	}
+	if (req->is16b) {
+		/*
+		 * 16B not supported for WFR expected - all code here assumes
+		 * the ICRC QW does not land in memory.  Would require
+		 * coordination between library and driver.
+		 */
+		if (dd->params->chip_type == CHIP_WFR &&
+		    req_opcode(req->info.ctrl) == EXPECTED) {
+			SDMA_DBG(req, "WFR expected not supported");
+			ret = -EOPNOTSUPP;
+			goto free_req;
+		}
+
+		/* extra appended by the driver */
+		req->tailsize = 8; /* ICRC QW size */
+
+		req->hsize = sizeof(req->h.hdr16b);
+		rhdr = req->h.hdr16b.lrh; /* remainder of header */
+		bth = req->h.hdr16b.bth;
+		kdeth = &req->h.hdr16b.kdeth;
+	} else {
+		req->hsize = sizeof(req->h.hdr9b);
+		rhdr = req->h.hdr9b.lrh; /* remainder of header */
+		bth = req->h.hdr9b.bth;
+		kdeth = &req->h.hdr9b.kdeth;
+	}
+	rsize = req->hsize - sizeof(req->h.pbc); /* header remainder size */
+
+	/* copy in rest of header: LRH (9B or 16B), BTH, and KDETH */
+	if (iovec[idx].iov_len < header_offset + rsize) {
+		SDMA_DBG(req, "First vector not big enough for header %lu/%lu",
+			 iovec[idx].iov_len, header_offset + rsize);
+		ret = -EINVAL;
+		goto free_req;
+	}
+	ret = copy_from_user(rhdr, iovec[idx].iov_base + header_offset, rsize);
+	if (ret) {
+		SDMA_DBG(req, "Failed to copy header template (%d)", ret);
+		ret = -EFAULT;
+		goto free_req;
+	}
+
+	if (req->is16b) {
+		struct hfi2_16b_header *hdr = rhdr;
+
+		if (hfi2_16B_get_l2(hdr) != PBC_L2_16B) {
+			SDMA_DBG(req, "Non-matching L2 (%d)",
+				 hfi2_16B_get_l2(hdr));
+			ret = -EINVAL;
+			goto free_req;
+		}
+
+		sc = hfi2_16B_get_sc(hdr);
+		slid = hfi2_16B_get_slid(hdr);
+		dlid = hfi2_16B_get_dlid(hdr);
+		lrh_grh = hfi2_16B_get_l4(hdr) == OPA_16B_L4_IB_GLOBAL;
+		req->lrh_len_bytes = hfi2_16B_get_len(hdr) << 3;
+		req->pad_mask = 0x7; /* round up to 8 bytes */
+	} else {
+		struct ib_header *hdr = rhdr;
+		bool sc4 = (le16_to_cpu(req->h.hdr9b.pbc[1]) >> 14) & 0x1;
+
+		/* sanitize the pbc if no rate control */
+		if (!HFI2_CAP_IS_USET(STATIC_RATE_CTRL))
+			req->h.hdr9b.pbc[2] = 0;
+
+		sc = hfi2_9B_get_sc5(hdr, sc4);
+		slid = ib_get_slid(hdr);
+		dlid = ib_get_dlid(hdr);
+		lrh_grh = ib_get_lnh(hdr) == HFI2_LRH_GRH;
+		req->lrh_len_bytes = ib_get_len(hdr) << 2;
+		req->pad_mask = 0x3; /* round up to 4 bytes */
+	}
+
+	/* Validate the opcode. Do not trust packets from user space blindly. */
+	opcode = (be32_to_cpu(bth[0]) >> 24) & 0xff;
+	if ((opcode & USER_OPCODE_CHECK_MASK) != USER_OPCODE_CHECK_VAL) {
+		SDMA_DBG(req, "Invalid opcode (%d)", opcode);
+		ret = -EINVAL;
+		goto free_req;
+	}
+	/*
+	 * Validate the vl. Do not trust packets from user space blindly.
+	 * VL comes from PBC, SC comes from LRH, and the VL needs to
+	 * match the SC look up.
+	 */
+	if (vl >= ppd->vls_operational || vl != sc_to_vlt(ppd, sc)) {
+		SDMA_DBG(req, "Invalid SC(%u)/VL(%u)", sc, vl);
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	/* Checking P_KEY for requests from user-space */
+	pkey = (u16)be32_to_cpu(bth[0]);
+	if (egress_pkey_check(ppd, slid, pkey, sc, PKEY_CHECK_INVALID)) {
+		ret = -EINVAL;
+		SDMA_DBG(req, "P_KEY check failed\n");
+		goto free_req;
+	}
+
+	/*
+	 * Also should check the BTH.lnh. If it says the next header is GRH then
+	 * the RXE parsing will be off and will land in the middle of the KDETH
+	 * or miss it entirely.
+	 */
+	if (lrh_grh) {
+		SDMA_DBG(req, "User tried to pass in a GRH");
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	req->koffset = le32_to_cpu(kdeth->swdata[6]);
+	/*
+	 * Calculate the initial TID offset based on the values of
+	 * KDETH.OFFSET and KDETH.OM that are passed in.
+	 */
+	req->tidoffset = KDETH_GET(kdeth->ver_tid_offset, OFFSET) *
+			 (KDETH_GET(kdeth->ver_tid_offset, OM) ?
+				  KDETH_OM_LARGE :
+				  KDETH_OM_SMALL);
+	trace_hfi2_sdma_user_initial_tidoffset(dd, uctxt->ctxt, fd->subctxt,
+					       info.comp_idx, req->tidoffset);
+	idx++;
+
+	/* Save all the IO vector structures */
+	for (i = 0; i < req->data_iovs; i++) {
+		req->iovs[i].type =
+			HFI2_MEMINFO_TYPE_ENTRY_GET(req->meminfo.types, i);
+		if (!pinning_type_supported(req->iovs[i].type)) {
+			SDMA_DBG(req, "Pinning type not supported: %u\n",
+				 req->iovs[i].type);
+			req->data_iovs = i;
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->iovs[i].context = req->meminfo.context[i];
+		req->iovs[i].offset = 0;
+		memcpy(&req->iovs[i].iov, iovec + idx++,
+		       sizeof(req->iovs[i].iov));
+		if (req->iovs[i].iov.iov_len == 0) {
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->data_len += req->iovs[i].iov.iov_len;
+	}
+	trace_hfi2_sdma_user_data_length(dd, uctxt->ctxt, fd->subctxt,
+					 info.comp_idx, req->data_len);
+	/* reject if not enough data provided for the template */
+	if (req->data_len < template_data_len(req)) {
+		ret = -EINVAL;
+		goto free_req;
+	}
+	if (pcount > req->info.npkts)
+		pcount = req->info.npkts;
+	/*
+	 * Copy any TID info
+	 * User space will provide the TID info only when the
+	 * request type is EXPECTED. This is true even if there is
+	 * only one packet in the request and the header is already
+	 * setup. The reason for the singular TID case is that the
+	 * driver needs to perform safety checks.
+	 */
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		u16 ntids = iovec[idx].iov_len / sizeof(*req->tids);
+		u32 *tmp;
+
+		if (!ntids || ntids > MAX_TID_PAIR_ENTRIES) {
+			ret = -EINVAL;
+			goto free_req;
+		}
+
+		/*
+		 * We have to copy all of the tids because they may vary
+		 * in size and, therefore, the TID count might not be
+		 * equal to the pkt count. However, there is no way to
+		 * tell at this point.
+		 */
+		tmp = memdup_array_user(iovec[idx].iov_base, ntids,
+					sizeof(*req->tids));
+		if (IS_ERR(tmp)) {
+			ret = PTR_ERR(tmp);
+			SDMA_DBG(req, "Failed to copy %d TIDs (%pe)", ntids,
+				 tmp);
+			goto free_req;
+		}
+		req->tids = tmp;
+		req->n_tids = ntids;
+		req->tididx = 0;
+		idx++;
+	}
+
+	selector = dlid_to_selector(dlid);
+	selector += uctxt->ctxt + fd->subctxt;
+	req->sde = sdma_select_user_engine(ppd, selector, vl);
+
+	if (!req->sde || !sdma_running(req->sde)) {
+		ret = -ECOMM;
+		goto free_req;
+	}
+
+	/* We don't need an AHG entry if the request contains only one packet */
+	if (req->info.npkts > 1 && HFI2_CAP_IS_USET(SDMA_AHG))
+		req->ahg_idx = sdma_ahg_alloc(req->sde);
+
+	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
+	pq->state = SDMA_PKT_Q_ACTIVE;
+
+	/*
+	 * This is a somewhat blocking send implementation.
+	 * The driver will block the caller until all packets of the
+	 * request have been submitted to the SDMA engine. However, it
+	 * will not wait for send completions.
+	 */
+	while (req->seqsubmitted != req->info.npkts) {
+		ret = user_sdma_send_pkts(req, pcount);
+		if (ret < 0) {
+			int we_ret;
+
+			if (ret != -EBUSY)
+				goto free_req;
+			we_ret = wait_event_interruptible_timeout(
+				pq->busy.wait_dma,
+				pq->state == SDMA_PKT_Q_ACTIVE,
+				msecs_to_jiffies(SDMA_IOWAIT_TIMEOUT));
+			trace_hfi2_usdma_we(pq, we_ret);
+			if (we_ret <= 0)
+				flush_pq_iowait(pq);
+		}
+	}
+	*count += idx;
+	return 0;
+free_req:
+	/*
+	 * If the submitted seqsubmitted == npkts, the completion routine
+	 * controls the final state.  If sequbmitted < npkts, wait for any
+	 * outstanding packets to finish before cleaning up.
+	 */
+	if (req->seqsubmitted < req->info.npkts) {
+		if (req->seqsubmitted)
+			wait_event(pq->busy.wait_dma,
+				   (req->seqcomp == req->seqsubmitted - 1));
+		user_sdma_free_request(req);
+		pq_update(pq);
+		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
+	}
+	return ret;
+}
+
+/*
+ * Determine the proper size of the packet data.
+ *
+ * The size of the data of the first packet is in the header template.
+ *
+ * The size of the remaining packets is the minimum of the frag size (MTU)
+ * or remaining data in the request.
+ */
+static inline u32 compute_data_length(struct user_sdma_request *req)
+{
+	u32 len;
+
+	if (!req->seqnum) {
+		len = template_data_len(req);
+	} else if (req_opcode(req->info.ctrl) == EXPECTED) {
+		u32 tidlen = EXP_TID_GET(req->tids[req->tididx], LEN) *
+			     EXP_TID_ADDR_SIZE;
+		/*
+		 * Get the data length based on the remaining space in the
+		 * TID pair.
+		 */
+		len = min(tidlen - req->tidoffset, (u32)req->info.fragsize);
+		/* If we've filled up the TID pair, move to the next one. */
+		if (unlikely(!len) && ++req->tididx < req->n_tids &&
+		    req->tids[req->tididx]) {
+			tidlen = EXP_TID_GET(req->tids[req->tididx], LEN) *
+				 EXP_TID_ADDR_SIZE;
+			req->tidoffset = 0;
+			len = min_t(u32, tidlen, req->info.fragsize);
+		}
+		/*
+		 * Since the TID pairs map entire pages, make sure that we
+		 * are not going to try to send more data that we have
+		 * remaining.
+		 */
+		len = min(len, req->data_len - req->sent);
+	} else {
+		len = min(req->data_len - req->sent, (u32)req->info.fragsize);
+	}
+	trace_hfi2_sdma_user_compute_length(req->pq->dd, req->pq->ctxt,
+					    req->pq->subctxt,
+					    req->info.comp_idx, len);
+	return len;
+}
+
+static inline u32 pad_len(struct user_sdma_request *req, u32 len)
+{
+	return (len + req->pad_mask) & ~req->pad_mask;
+}
+
+/*
+ * Return in bytes the size to be put into the LRH
+ */
+static inline u32 get_lrh_len(struct user_sdma_request *req, u32 len)
+{
+	if (req->is16b) {
+		/* header - PBC + data length + trailing ICRC QW */
+		return req->hsize - sizeof(u64) + len + 8;
+	}
+
+	/* (Size of complete header - size of PBC) + 4B ICRC + data length */
+	return req->hsize - sizeof(u64) + 4 + len;
+}
+
+/*
+ * Convert a PBC length (DW) to an LRH length (bytes).  Important: incoming
+ * PBC length is whole bottom of PBC, be sure to mask.
+ */
+static inline u16 pbc2lrh(struct user_sdma_request *req, u16 pbclen)
+{
+	if (req->is16b) {
+		/*
+		 * 16B: Both PBC and LRH include QW ICRC, just subtract off PBC.
+		 */
+		return ((pbclen & 0xfff) - 2) << 2;
+	}
+	/* 9B: len - PBC + ICRC */
+	return ((pbclen & 0xfff) - 2 + 1) << 2;
+}
+
+/* convert a LRH length (bytes) to a PBC length (DW) */
+static inline u16 lrh2pbc(struct user_sdma_request *req, u16 lrhlen)
+{
+	if (req->is16b) {
+		/* 16B: to DW, ICRC QW already included, add 2 for PBC */
+		return ((lrhlen >> 2) + 2) & 0xfff;
+	}
+	/*
+	 * 9B: to DW, len includes ICRC use that for half of PBC, add 1 for
+	 * second half of PBC
+	 */
+	return ((lrhlen >> 2) + 1) & 0xfff;
+}
+
+static int user_sdma_txadd_ahg(struct user_sdma_request *req,
+			       struct user_sdma_txreq *tx, u32 datalen)
+{
+	int ret;
+	u16 pbclen = le16_to_cpu(req->h.pbc[0]);
+	u32 lrhlen = get_lrh_len(req, pad_len(req, datalen));
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+
+	/*
+	 * Copy the request header into the tx header
+	 * because the HW needs a cacheline-aligned
+	 * address.
+	 * This copy can be optimized out if the hdr
+	 * member of user_sdma_request were also
+	 * cacheline aligned.
+	 */
+	memcpy(&tx->h, &req->h, req->hsize);
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		pbclen = (pbclen & 0xf000) | lrh2pbc(req, lrhlen);
+		tx->h.pbc[0] = cpu_to_le16(pbclen);
+	}
+	ret = check_header_template(req, tx, lrhlen, datalen);
+	if (ret)
+		return ret;
+	ret = sdma_txinit_ahg(pq->dd, &tx->txreq, SDMA_TXREQ_F_AHG_COPY,
+			      req->hsize + datalen, req->ahg_idx, 0, NULL, 0,
+			      user_sdma_txreq_cb);
+	if (ret)
+		return ret;
+	ret = sdma_txadd_kvaddr(pq->dd, &tx->txreq, &tx->h, req->hsize);
+	if (ret)
+		sdma_txclean(pq->dd, &tx->txreq);
+	return ret;
+}
+
+static void free_pinref(struct user_sdma_pinref *d)
+{
+	pinning_interfaces[d->memtype].put(d->ptr);
+}
+
+static void free_pinrefs(struct user_sdma_pinref *pinrefs, u16 n_pinrefs)
+{
+	u16 i;
+
+	if (!pinrefs)
+		return;
+	for (i = 0; i < n_pinrefs; i++)
+		free_pinref(&pinrefs[i]);
+}
+
+/*
+ * Evict + free a pinref last-used by a now-completed packet (user_sdma_txreq).
+ */
+static inline int evict_complete_pinref(struct user_sdma_request *req)
+{
+	u16 i;
+
+	for (i = 0; i < req->n_pinrefs; i++) {
+		if (req->pinrefs[i].req_seqnum > req->seqcomp)
+			continue;
+		free_pinref(&req->pinrefs[i]);
+		req->pinrefs[i].ptr = NULL;
+		req->n_pinrefs--;
+		return i;
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * @return:
+ * * 0 on success
+ * * -EINVAL or -ENOMEM on error
+ */
+static int request_add_ref(struct user_sdma_request *req, void *ptr,
+			   u16 memtype)
+{
+	int ret;
+	u16 i;
+
+	if (req->n_pinrefs >= ARRAY_SIZE(req->pinrefs)) {
+		ret = evict_complete_pinref(req);
+		if (ret < 0)
+			return ret;
+		i = (u16)ret;
+	} else {
+		i = req->n_pinrefs;
+	}
+	req->n_pinrefs++;
+	req->pinrefs[i].ptr = ptr;
+	req->pinrefs[i].memtype = memtype;
+	req->pinrefs[i].req_seqnum = req->seqnum;
+	req->pinrefs[i].pinref_seqnum = req->pinref_seqnum++;
+	return 0;
+}
+
+/*
+ * Add pinref made from (@ptr,@put) to @tx->pinrefs.
+ */
+static int txreq_add_ref(struct user_sdma_txreq *tx, void *ptr, u16 memtype)
+{
+	u16 i;
+
+	/* Should not happen; internal error, check just in case */
+	if (WARN_ON_ONCE(tx->n_pinrefs >= MAX_DESC))
+		return -ENOMEM;
+	if (!tx->pinrefs) {
+		size_t bytes;
+
+		bytes = array_size(MAX_DESC, sizeof(tx->pinrefs[0]));
+		tx->pinrefs = kmalloc(bytes, GFP_KERNEL);
+		if (!tx->pinrefs)
+			return -ENOMEM;
+	}
+	i = tx->n_pinrefs++;
+	tx->pinrefs[i].ptr = ptr;
+	tx->pinrefs[i].memtype = memtype;
+	/* .req_seqnum and .pinref_seqnum are N/A for pinrefs in tx->pinrefs */
+	return 0;
+}
+
+/**
+ * Try adding @ptr to @tx->req->pinrefs first but add to @tx->pinrefs if
+ * there is no space in @tx->req->pinrefs.
+ */
+int hfi2_user_sdma_add_ref(struct user_sdma_txreq *tx, void *ptr, u16 memtype)
+{
+	int ret;
+
+	/* Should not happen; internal error, check just in case */
+	if (WARN_ON_ONCE(!ptr || !pinning_type_supported(memtype)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!pinning_interfaces[memtype].put))
+		return -EINVAL;
+	ret = request_add_ref(tx->req, ptr, memtype);
+	if (!ret)
+		return 0;
+	if (ret != -ENOMEM)
+		return ret;
+	/* No space in req->pinrefs and no entries could be evicted */
+	return txreq_add_ref(tx, ptr, memtype);
+}
+
+/**
+ * @return most-recently used pinref for @memtype from @tx->req. Most-recent
+ *         determined by &user_sdma_pinref->pinref_seqnum.
+ */
+struct user_sdma_pinref *hfi2_user_sdma_mru_ref(struct user_sdma_txreq *tx,
+						u16 memtype)
+{
+	struct user_sdma_request *req = tx->req;
+	struct user_sdma_pinref *mru = NULL;
+	u16 i;
+
+	for (i = 0; i < req->n_pinrefs; i++) {
+		if (req->pinrefs[i].memtype != memtype)
+			continue;
+		if (!mru || req->pinrefs[i].pinref_seqnum > mru->pinref_seqnum)
+			mru = &req->pinrefs[i];
+	}
+
+	return mru;
+}
+
+/*
+ * Update @d->req_seqnum and @d->pinref_seqnum from @tx->req.
+ */
+void hfi2_user_sdma_touch_ref(struct user_sdma_txreq *tx,
+			      struct user_sdma_pinref *d)
+{
+	d->req_seqnum = tx->req->seqnum;
+	d->pinref_seqnum = tx->req->pinref_seqnum++;
+}
+
+static void user_sdma_free_txreq(struct user_sdma_txreq *tx)
+{
+	free_pinrefs(tx->pinrefs, tx->n_pinrefs);
+	kfree(tx->pinrefs);
+	kmem_cache_free(tx->req->pq->txreq_cache, tx);
+}
+
+static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
+{
+	int ret = 0;
+	u16 count;
+	unsigned npkts = 0;
+	struct user_sdma_txreq *tx = NULL;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_devdata *dd;
+	struct user_sdma_iovec *iovec = NULL;
+
+	if (!req->pq)
+		return -EINVAL;
+
+	pq = req->pq;
+	dd = pq->dd;
+
+	/* If tx completion has reported an error, we are done. */
+	if (READ_ONCE(req->has_error))
+		return -EFAULT;
+
+	/*
+	 * Check if we might have sent the entire request already
+	 */
+	if (unlikely(req->seqnum == req->info.npkts)) {
+		if (!list_empty(&req->txps))
+			goto dosend;
+		return ret;
+	}
+
+	if (!maxpkts || maxpkts > req->info.npkts - req->seqnum)
+		maxpkts = req->info.npkts - req->seqnum;
+
+	while (npkts < maxpkts) {
+		u32 datalen = 0;
+
+		/*
+		 * Check whether any of the completions have come back
+		 * with errors. If so, we are not going to process any
+		 * more packets from this request.
+		 */
+		if (READ_ONCE(req->has_error))
+			return -EFAULT;
+
+		tx = kmem_cache_alloc(pq->txreq_cache, GFP_KERNEL);
+		if (!tx)
+			return -ENOMEM;
+		tx->pinrefs = NULL;
+		tx->n_pinrefs = 0;
+		tx->flags = 0;
+		tx->req = req;
+		/*
+		 * For the last packet set the ACK request
+		 * and disable header suppression.
+		 */
+		if (req->seqnum == req->info.npkts - 1)
+			tx->flags |= (TXREQ_FLAGS_REQ_ACK |
+				      TXREQ_FLAGS_REQ_DISABLE_SH);
+
+		/*
+		 * Calculate the payload size - this is min of the fragment
+		 * (MTU) size or the remaining bytes in the request but only
+		 * if we have payload data.
+		 */
+		if (req->data_len) {
+			iovec = &req->iovs[req->iov_idx];
+			if (READ_ONCE(iovec->offset) == iovec->iov.iov_len) {
+				if (++req->iov_idx == req->data_iovs) {
+					ret = -EFAULT;
+					goto free_tx;
+				}
+				iovec = &req->iovs[req->iov_idx];
+				WARN_ON(iovec->offset);
+			}
+
+			datalen = compute_data_length(req);
+
+			/*
+			 * Disable header suppression for the payload <= 8DWS.
+			 * If there is an uncorrectable error in the receive
+			 * data FIFO when the received payload size is less than
+			 * or equal to 8DWS then the RxDmaDataFifoRdUncErr is
+			 * not reported.There is set RHF.EccErr if the header
+			 * is not suppressed.
+			 */
+			if (!datalen) {
+				SDMA_DBG(req,
+					 "Request has data but pkt len is 0");
+				ret = -EFAULT;
+				goto free_tx;
+			} else if (datalen <= 32) {
+				tx->flags |= TXREQ_FLAGS_REQ_DISABLE_SH;
+			}
+		}
+
+		/*
+		 * protocol decision: provider must give QWORD aligned data
+		 * for 16B (as opposed to driver padding missing bytes)
+		 */
+		if (req->is16b && (datalen & req->pad_mask)) {
+			SDMA_DBG(req, "16B packet size %u not QWORD aligned\n",
+				 datalen);
+			ret = -EINVAL;
+			goto free_tx;
+		}
+
+		if (req->ahg_idx >= 0) {
+			if (!req->seqnum) {
+				ret = user_sdma_txadd_ahg(req, tx, datalen);
+				if (ret)
+					goto free_tx;
+			} else {
+				int changes;
+
+				changes =
+					set_txreq_header_ahg(req, tx, datalen);
+				if (changes < 0) {
+					ret = changes;
+					goto free_tx;
+				}
+			}
+		} else {
+			ret = sdma_txinit(dd, &tx->txreq, 0,
+					  req->hsize + datalen + req->tailsize,
+					  user_sdma_txreq_cb);
+			if (ret)
+				goto free_tx;
+			/*
+			 * Modify the header for this packet. This only needs
+			 * to be done if we are not going to use AHG. Otherwise,
+			 * the HW will do it based on the changes we gave it
+			 * during sdma_txinit_ahg().
+			 */
+			ret = set_txreq_header(req, tx, datalen);
+			if (ret)
+				goto free_txreq;
+		}
+
+		req->koffset += datalen;
+		if (req_opcode(req->info.ctrl) == EXPECTED)
+			req->tidoffset += datalen;
+		req->sent += datalen;
+		while (datalen) {
+			ret = add_to_sdma_packet(iovec->type, req, tx, iovec,
+						 &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
+		/* 16B requests need to have the ICRC QW added */
+		if (req->is16b) {
+			ret = sdma_txadd_daddr(dd, &tx->txreq,
+					       dd->sdma_pad_phys, 8);
+			if (ret)
+				goto free_txreq;
+		}
+		list_add_tail(&tx->txreq.list, &req->txps);
+		/*
+		 * It is important to increment this here as it is used to
+		 * generate the BTH.PSN and, therefore, can't be bulk-updated
+		 * outside of the loop.
+		 */
+		tx->seqnum = req->seqnum++;
+		npkts++;
+	}
+dosend:
+	ret = sdma_send_txlist(req->sde, iowait_get_ib_work(&pq->busy),
+			       &req->txps, &count);
+	req->seqsubmitted += count;
+	if (req->seqsubmitted == req->info.npkts) {
+		/*
+		 * The txreq has already been submitted to the HW queue
+		 * so we can free the AHG entry now. Corruption will not
+		 * happen due to the sequential manner in which
+		 * descriptors are processed.
+		 */
+		if (req->ahg_idx >= 0)
+			sdma_ahg_free(req->sde, req->ahg_idx);
+	}
+	return ret;
+
+free_txreq:
+	sdma_txclean(dd, &tx->txreq);
+free_tx:
+	user_sdma_free_txreq(tx);
+	return ret;
+}
+
+static int check_header_template(struct user_sdma_request *req,
+				 struct user_sdma_txreq *tx, u32 lrhlen,
+				 u32 datalen)
+{
+	/*
+	 * Perform safety checks for any type of packet:
+	 *    - transfer size is multiple of 64bytes
+	 *    - packet length is multiple of pad_mask+1 (4 or 8) bytes
+	 *    - packet length is not larger than MTU size
+	 *
+	 * These checks are only done for the first packet of the
+	 * transfer since the header is "given" to us by user space.
+	 * For the remainder of the packets we compute the values.
+	 */
+	if (req->info.fragsize % PIO_BLOCK_SIZE || lrhlen & req->pad_mask ||
+	    lrhlen > get_lrh_len(req, req->info.fragsize))
+		return -EINVAL;
+
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		/*
+		 * The header is checked only on the first packet. Furthermore,
+		 * we ensure that at least one TID entry is copied when the
+		 * request is submitted. Therefore, we don't have to verify that
+		 * tididx points to something sane.
+		 */
+		u32 tidval = req->tids[req->tididx],
+		    tidlen = EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE,
+		    tididx = EXP_TID_GET(tidval, IDX),
+		    tidctrl = EXP_TID_GET(tidval, CTRL), tidoff;
+		__le32 kval;
+		struct hfi2_kdeth_header *kdeth;
+
+		if (req->is16b) {
+			kval = tx->h.hdr16b.kdeth.ver_tid_offset;
+			kdeth = &req->h.hdr16b.kdeth;
+		} else {
+			kval = tx->h.hdr9b.kdeth.ver_tid_offset;
+			kdeth = &req->h.hdr9b.kdeth;
+		}
+		tidoff = KDETH_GET(kval, OFFSET) *
+			 (KDETH_GET(kdeth->ver_tid_offset, OM) ?
+				  KDETH_OM_LARGE :
+				  KDETH_OM_SMALL);
+		/*
+		 * Expected receive packets have the following
+		 * additional checks:
+		 *     - offset is not larger than the TID size
+		 *     - TIDCtrl values match between header and TID array
+		 *     - TID indexes match between header and TID array
+		 */
+		if ((tidoff + datalen > tidlen) ||
+		    KDETH_GET(kval, TIDCTRL) != tidctrl ||
+		    KDETH_GET(kval, TID) != tididx)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Correctly set the BTH.PSN field based on type of
+ * transfer - eager packets can just increment the PSN but
+ * expected packets encode generation and sequence in the
+ * BTH.PSN field so just incrementing will result in errors.
+ */
+static inline u32 set_pkt_bth_psn(__be32 bthpsn, u8 expct, u32 frags)
+{
+	u32 val = be32_to_cpu(bthpsn),
+	    mask = (HFI2_CAP_IS_KSET(EXTENDED_PSN) ? 0x7fffffffull :
+						     0xffffffull),
+	    psn = val & mask;
+	if (expct)
+		psn = (psn & ~HFI2_KDETH_BTH_SEQ_MASK) |
+		      ((psn + frags) & HFI2_KDETH_BTH_SEQ_MASK);
+	else
+		psn = psn + frags;
+	return psn & mask;
+}
+
+/* set the length field of a 16B LRH header */
+static inline void hfi2_16B_set_len(__le32 *lrh, u32 len)
+{
+	u32 value;
+
+	value = le32_to_cpu(lrh[0]);
+	value &= ~OPA_16B_LEN_MASK;
+	value |= OPA_16B_LEN_MASK & (len << OPA_16B_LEN_SHIFT);
+	lrh[0] = cpu_to_le32(value);
+}
+
+static int set_txreq_header(struct user_sdma_request *req,
+			    struct user_sdma_txreq *tx, u32 datalen)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	struct hfi2_kdeth_header *kdeth;
+	__be32 *bth;
+	u8 omfactor; /* KDETH.OM */
+	u16 pbclen;
+	int ret;
+	u32 tidval = 0, lrhlen = get_lrh_len(req, pad_len(req, datalen));
+
+	/* Copy the header template to the request before modification */
+	memcpy(&tx->h, &req->h, req->hsize);
+
+	/*
+	 * Check if the PBC and LRH length are mismatched. If so
+	 * adjust both in the header.
+	 */
+	pbclen = le16_to_cpu(tx->h.pbc[0]);
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		pbclen = (pbclen & 0xf000) | lrh2pbc(req, lrhlen);
+		tx->h.pbc[0] = cpu_to_le16(pbclen);
+		if (req->is16b)
+			hfi2_16B_set_len(tx->h.hdr16b.lrh, lrhlen >> 3);
+		else
+			tx->h.hdr9b.lrh[2] = cpu_to_be16(lrhlen >> 2);
+		/*
+		 * Third packet
+		 * This is the first packet in the sequence that has
+		 * a "static" size that can be used for the rest of
+		 * the packets (besides the last one).
+		 */
+		if (unlikely(req->seqnum == 2)) {
+			/*
+			 * From this point on the lengths in both the
+			 * PBC and LRH are the same until the last
+			 * packet.
+			 * Adjust the template so we don't have to update
+			 * every packet
+			 */
+			req->h.pbc[0] = tx->h.pbc[0];
+			if (req->is16b)
+				hfi2_16B_set_len(req->h.hdr16b.lrh,
+						 lrhlen >> 3);
+			else
+				req->h.hdr9b.lrh[2] = tx->h.hdr9b.lrh[2];
+		}
+	}
+	/*
+	 * We only have to modify the header if this is not the
+	 * first packet in the request. Otherwise, we use the
+	 * header given to us.
+	 */
+	if (unlikely(!req->seqnum)) {
+		ret = check_header_template(req, tx, lrhlen, datalen);
+		if (ret)
+			return ret;
+		goto done;
+	}
+
+	if (req->is16b) {
+		bth = tx->h.hdr16b.bth;
+		kdeth = &tx->h.hdr16b.kdeth;
+	} else {
+		bth = tx->h.hdr9b.bth;
+		kdeth = &tx->h.hdr9b.kdeth;
+	}
+
+	bth[2] = cpu_to_be32(set_pkt_bth_psn(
+		bth[2], (req_opcode(req->info.ctrl) == EXPECTED), req->seqnum));
+
+	/* Set ACK request on last packet */
+	if (unlikely(tx->flags & TXREQ_FLAGS_REQ_ACK))
+		bth[2] |= cpu_to_be32(1UL << 31);
+
+	/* Set the new offset */
+	kdeth->swdata[6] = cpu_to_le32(req->koffset);
+	/* Expected packets have to fill in the new TID information */
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		tidval = req->tids[req->tididx];
+		/*
+		 * If the offset puts us at the end of the current TID,
+		 * advance everything.
+		 */
+		if ((req->tidoffset) ==
+		    (EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE)) {
+			req->tidoffset = 0;
+			/*
+			 * Since we don't copy all the TIDs, all at once,
+			 * we have to check again.
+			 */
+			if (++req->tididx > req->n_tids - 1 ||
+			    !req->tids[req->tididx]) {
+				return -EINVAL;
+			}
+			tidval = req->tids[req->tididx];
+		}
+		omfactor = EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE >=
+					   KDETH_OM_MAX_SIZE ?
+				   KDETH_OM_LARGE_SHIFT :
+				   KDETH_OM_SMALL_SHIFT;
+		/* Set KDETH.TIDCtrl based on value for this TID. */
+		KDETH_SET(kdeth->ver_tid_offset, TIDCTRL,
+			  EXP_TID_GET(tidval, CTRL));
+		/* Set KDETH.TID based on value for this TID */
+		KDETH_SET(kdeth->ver_tid_offset, TID, EXP_TID_GET(tidval, IDX));
+		/* Clear KDETH.SH when DISABLE_SH flag is set */
+		if (unlikely(tx->flags & TXREQ_FLAGS_REQ_DISABLE_SH))
+			KDETH_SET(kdeth->ver_tid_offset, SH, 0);
+		/*
+		 * Set the KDETH.OFFSET and KDETH.OM based on size of
+		 * transfer.
+		 */
+		trace_hfi2_sdma_user_tid_info(pq->dd, pq->ctxt, pq->subctxt,
+					      req->info.comp_idx,
+					      req->tidoffset,
+					      req->tidoffset >> omfactor,
+					      omfactor != KDETH_OM_SMALL_SHIFT);
+		KDETH_SET(kdeth->ver_tid_offset, OFFSET,
+			  req->tidoffset >> omfactor);
+		KDETH_SET(kdeth->ver_tid_offset, OM,
+			  omfactor != KDETH_OM_SMALL_SHIFT);
+	}
+done:
+	if (req->is16b) {
+		trace_hfi2_sdma_user_header16b(pq->dd, pq->ctxt, pq->subctxt,
+					       req->info.comp_idx,
+					       &tx->h.hdr16b, tidval);
+	} else {
+		trace_hfi2_sdma_user_header(pq->dd, pq->ctxt, pq->subctxt,
+					    req->info.comp_idx, &tx->h.hdr9b,
+					    tidval);
+	}
+	return sdma_txadd_kvaddr(pq->dd, &tx->txreq, &tx->h, req->hsize);
+}
+
+static int set_txreq_header_ahg(struct user_sdma_request *req,
+				struct user_sdma_txreq *tx, u32 datalen)
+{
+	u32 ahg[AHG_KDETH_ARRAY_SIZE];
+	int idx = 0;
+	u8 omfactor; /* KDETH.OM */
+	u8 off;
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	__be32 *bth;
+	struct hfi2_kdeth_header *kdeth;
+	u16 pbclen = le16_to_cpu(req->h.pbc[0]);
+	u32 val32, tidval = 0, lrhlen = get_lrh_len(req, pad_len(req, datalen));
+	size_t array_size = ARRAY_SIZE(ahg);
+
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		/* PBC.PbcLengthDWs */
+		idx = ahg_header_set(
+			ahg, idx, array_size, 0, 0, 12,
+			(__force u16)cpu_to_le16(lrh2pbc(req, lrhlen)));
+		if (idx < 0)
+			return idx;
+		/* LRH.PktLen */
+		if (req->is16b) {
+			idx = ahg_header_set(ahg, idx, array_size, 3, 4, 11,
+					     (__force u16)cpu_to_le16(lrhlen >>
+								      3));
+		} else {
+			/* 9B: need the full 16 bits due to byte swap */
+			idx = ahg_header_set(ahg, idx, array_size, 3, 0, 16,
+					     (__force u16)cpu_to_be16(lrhlen >>
+								      2));
+		}
+		if (idx < 0)
+			return idx;
+	}
+
+	if (req->is16b) {
+		bth = tx->h.hdr16b.bth;
+		kdeth = &tx->h.hdr16b.kdeth;
+		off = 2; /* BTH and KDETH are 2 DW further in */
+	} else {
+		bth = tx->h.hdr9b.bth;
+		kdeth = &tx->h.hdr9b.kdeth;
+		off = 0; /* no extra DW offset */
+	}
+
+	/*
+	 * Do the common updates
+	 */
+	/* BTH.PSN and BTH.A */
+	val32 = (be32_to_cpu(bth[2]) + req->seqnum) &
+		(HFI2_CAP_IS_KSET(EXTENDED_PSN) ? 0x7fffffff : 0xffffff);
+	if (unlikely(tx->flags & TXREQ_FLAGS_REQ_ACK))
+		val32 |= 1UL << 31;
+	idx = ahg_header_set(ahg, idx, array_size, 6 + off, 0, 16,
+			     (__force u16)cpu_to_be16(val32 >> 16));
+	if (idx < 0)
+		return idx;
+	idx = ahg_header_set(ahg, idx, array_size, 6 + off, 16, 16,
+			     (__force u16)cpu_to_be16(val32 & 0xffff));
+	if (idx < 0)
+		return idx;
+	/* KDETH.Offset */
+	idx = ahg_header_set(ahg, idx, array_size, 15 + off, 0, 16,
+			     (__force u16)cpu_to_le16(req->koffset & 0xffff));
+	if (idx < 0)
+		return idx;
+	idx = ahg_header_set(ahg, idx, array_size, 15 + off, 16, 16,
+			     (__force u16)cpu_to_le16(req->koffset >> 16));
+	if (idx < 0)
+		return idx;
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		__le16 val;
+		u16 tidoff;
+
+		tidval = req->tids[req->tididx];
+
+		/*
+		 * If the offset puts us at the end of the current TID,
+		 * advance everything.
+		 */
+		if ((req->tidoffset) ==
+		    (EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE)) {
+			req->tidoffset = 0;
+			/*
+			 * Since we don't copy all the TIDs, all at once,
+			 * we have to check again.
+			 */
+			if (++req->tididx > req->n_tids - 1 ||
+			    !req->tids[req->tididx])
+				return -EINVAL;
+			tidval = req->tids[req->tididx];
+		}
+		omfactor = ((EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE) >=
+			    KDETH_OM_MAX_SIZE) ?
+				   KDETH_OM_LARGE_SHIFT :
+				   KDETH_OM_SMALL_SHIFT;
+		/* KDETH.OM and KDETH.OFFSET (TID) */
+		tidoff = ((!!(omfactor - KDETH_OM_SMALL_SHIFT)) << 15) |
+			 ((req->tidoffset >> omfactor) & 0x7fff);
+		idx = ahg_header_set(ahg, idx, array_size, 7 + off, 0, 16,
+				     tidoff);
+		if (idx < 0)
+			return idx;
+		/* KDETH.TIDCtrl, KDETH.TID, KDETH.Intr, KDETH.SH */
+		val = cpu_to_le16(((EXP_TID_GET(tidval, CTRL) & 0x3) << 10) |
+				  (EXP_TID_GET(tidval, IDX) & 0x3ff));
+
+		if (unlikely(tx->flags & TXREQ_FLAGS_REQ_DISABLE_SH)) {
+			val |= cpu_to_le16(
+				(KDETH_GET(kdeth->ver_tid_offset, INTR)
+				 << AHG_KDETH_INTR_SHIFT));
+		} else {
+			val |= KDETH_GET(kdeth->ver_tid_offset, SH) ?
+				       cpu_to_le16(0x1 << AHG_KDETH_SH_SHIFT) :
+				       cpu_to_le16(
+					       (KDETH_GET(kdeth->ver_tid_offset,
+							  INTR)
+						<< AHG_KDETH_INTR_SHIFT));
+		}
+
+		idx = ahg_header_set(ahg, idx, array_size, 7 + off, 16, 14,
+				     (__force u16)val);
+		if (idx < 0)
+			return idx;
+	}
+
+	trace_hfi2_sdma_user_header_ahg(pq->dd, pq->ctxt, pq->subctxt,
+					req->info.comp_idx, req->sde->this_idx,
+					req->ahg_idx, ahg, idx, tidval);
+	sdma_txinit_ahg(pq->dd, &tx->txreq, SDMA_TXREQ_F_USE_AHG, datalen,
+			req->ahg_idx, idx, ahg, req->hsize, user_sdma_txreq_cb);
+
+	return idx;
+}
+
+/**
+ * user_sdma_txreq_cb() - SDMA tx request completion callback.
+ * @txreq: valid sdma tx request
+ * @status: success/failure of request
+ *
+ * Called when the SDMA progress state machine gets notification that
+ * the SDMA descriptors for this tx request have been processed by the
+ * DMA engine. Called in interrupt context.
+ * Only do work on completed sequences.
+ */
+static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
+{
+	struct user_sdma_txreq *tx =
+		container_of(txreq, struct user_sdma_txreq, txreq);
+	struct user_sdma_request *req;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_user_sdma_comp_q *cq;
+	enum hfi2_sdma_comp_state state = COMPLETE;
+
+	if (!tx->req)
+		return;
+
+	req = tx->req;
+	pq = req->pq;
+	cq = req->cq;
+
+	if (status != SDMA_TXREQ_S_OK) {
+		SDMA_DBG(req, "SDMA completion with error %d", status);
+		WRITE_ONCE(req->has_error, 1);
+		state = ERROR;
+	}
+
+	req->seqcomp = tx->seqnum;
+	user_sdma_free_txreq(tx);
+
+	/* sequence isn't complete?  We are done */
+	if (req->seqcomp != req->info.npkts - 1)
+		return;
+
+	user_sdma_free_request(req);
+	set_comp_state(pq, cq, req->info.comp_idx, state, status);
+	pq_update(pq);
+}
+
+static inline void pq_update(struct hfi2_user_sdma_pkt_q *pq)
+{
+	if (atomic_dec_and_test(&pq->n_reqs))
+		wake_up(&pq->wait);
+}
+
+static void user_sdma_free_request(struct user_sdma_request *req)
+{
+	if (!list_empty(&req->txps)) {
+		struct sdma_txreq *t, *p;
+
+		list_for_each_entry_safe(t, p, &req->txps, list) {
+			struct user_sdma_txreq *tx =
+				container_of(t, struct user_sdma_txreq, txreq);
+			list_del_init(&t->list);
+			sdma_txclean(req->pq->dd, t);
+			user_sdma_free_txreq(tx);
+		}
+	}
+
+	free_pinrefs(req->pinrefs, req->n_pinrefs);
+	kfree(req->tids);
+	clear_bit(req->info.comp_idx, req->pq->req_in_use);
+}
+
+static inline void set_comp_state(struct hfi2_user_sdma_pkt_q *pq,
+				  struct hfi2_user_sdma_comp_q *cq, u16 idx,
+				  enum hfi2_sdma_comp_state state, int ret)
+{
+	if (state == ERROR)
+		cq->comps[idx].errcode = -ret;
+	smp_wmb(); /* make sure errcode is visible first */
+	cq->comps[idx].status = state;
+	trace_hfi2_sdma_user_completion(pq->dd, pq->ctxt, pq->subctxt, idx,
+					state, ret);
+}



