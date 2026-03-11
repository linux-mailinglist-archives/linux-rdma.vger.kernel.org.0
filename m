Return-Path: <linux-rdma+bounces-18004-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJy1EsOssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18004-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F93268548
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A32BC30CCD59
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B64E3E63B0;
	Wed, 11 Mar 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="C5mf5iZU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022096.outbound.protection.outlook.com [40.107.209.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275B3DD51F
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251740; cv=fail; b=IMfK8JMluTjsoj8QxjiXpP9t5hKeETvbYuEx12UVqXPnowqzH+TkZOSJHW2shFTOwDwUvUBE8BReDmGDd2uZkINX5ruF66Jx1PZkEqedatFdmB10ruZmWJ8CovrwXu4qp5tjjZ9DqpIBYdYX7QVJkZ+U372vjf+YY3yNZpYZvJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251740; c=relaxed/simple;
	bh=sp5g6GBlxku5Jmntif9VqtLcqbPX0ioNcpcoiKvm6wA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDB7inXEip6ohR4BNWARxFz5vEOIxTUBy4JxVY2zQX/IseD6m8PmEhkvisx8mVh/8zON+1RRhy8Ew5bmb+/F5rrpaidTRxEfiOsmE8SuGQK1SI3WteGf43aKTwTYOfFnqhojeHoo02APkg8MThCyEumkwvF/ub9ANTp9y9wQbFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=C5mf5iZU; arc=fail smtp.client-ip=40.107.209.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boFZIhNr0MJigK1UvQV4vl7EdCt3RE1xXGRzQ6TWw3LFPbr3KPN9PRlGK+2/xhE5Mt6ClU/jcWduNuiXlIMXjBUrp+3pMU1t3XkljSTn/cGd5sQsZF9FP7sBaAsntaG7WTpD3e30l5cCkPAKvD1l1zSbO/2i59B/9qOxuZC3ZQB5OpeBtgJv4Z4b5lszeI0k4ftG78ZIN+DV7BAk48ipq8qz96xldCDccYMfhyNBoLT5i0lgg5tCWJSWjXoHjWSlP2jYXZu6zpHB98cn95sh1eqEwNG9nWBNvwg1ROXmSoTyJ8od4d+ertoYC3XkfUUdv0GJOh34KOy5bHKANX39ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57xUYPaM1xv2sa0CtSz1kMV6JOzjyHmxV3aFYBOIAxA=;
 b=YCSySwiLYP8qrTNN8QFLqGRwq6NrskVUAhxHOzW6ZVdcEHkiT8Orla+sMlceyOjGTy9e0J926m/QDP48Sm1+MN6YmxaiX9NMeyVd6oYM+J41KqAn/rF8jlmFxtHYx3GjlWptorQOTgF//WXlXzcriTwDdUoe9HnxsE8YevtczRuJZnPHka+EGVAkQtVTCH8HA1AZwzWyljZ8RvMlW327efBFPOd8T9Eh8kxL129z8AP1FhbWuYgekj9mudoG0N1tZt1ikD66J7wbC3Mm5YjupWkZmKg0zbBJzrPfOqKZZHvTEgrc/TwxemmLg2mw5oOxroNqFj+nQ4NIb/BBUng35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57xUYPaM1xv2sa0CtSz1kMV6JOzjyHmxV3aFYBOIAxA=;
 b=C5mf5iZUUd3b250LjTSrQcGUlHorsLEWheQPjesk7VtCA5JOvRT46qgF0S6Sc5gSfAzkSsjlquQS/5b+Z67R+e1kh9dH8ZVvFSKYATYt51z54zFgrd/fXq/lLb6EO4Y5rYwuuufQJpReXxphAUTEnmZeFhq2MhZnCrI0AXghYRdASmNhMiBFKpJU5MFloqmgfKzWcuuTINw+R1xy5WZGm47agh/8/tbqyi1EFyTrcwZvhUZg417oagiMjC6dJJhaB30NgqKKH4rEck53InrGyj9pmwlQoAR3kBTMS/7+hTU64Ur4gEC2lYpvt2y7f2v4W3W85rpkxwCml4w3o73RPw==
Received: from BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16)
 by CY1PR01MB9243.prod.exchangelabs.com (2603:10b6:930:106::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 17:55:27 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::4b) by BYAPR21CA0006.outlook.office365.com
 (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.2 via Frontend Transport; Wed,
 11 Mar 2026 17:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:55:27 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 60E6D14D819;
	Wed, 11 Mar 2026 13:55:26 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 5CC0D1810D6C5;
	Wed, 11 Mar 2026 13:55:26 -0400 (EDT)
Subject: [PATCH for-next resend 20/24] RDMA/hfi2: Support ipoib
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:26 -0400
Message-ID:
 <177325172635.57064.244652532682759103.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|CY1PR01MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5e4e63-34be-4d69-5740-08de7f9760b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|34020700016|82310400026|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ul1giTPYFs9c0oHApBqA7LKH9cJLSDm+GL3ABtCvfr68xA02DAFvdt+LRNXhkagrYoRNffoiCT57ppDrvciYB64CsQ7AbPuHUqubykJlTN7w+jf8pOyOxTLor8RdGgoERg9LGJ5jlKpI6OLoBXFol98fKK0ak0S5A5cEwR9hncXdHNLVKeBssbjPbJyI1PWXN4iT7Mxn7tR94vmNvk3MSN8t/0h4tm0RV6S9HD0QdGWin9pl3I6Ay+vGekj3XJMKwM+U+UIb5DszjYpWzM+0t6fOXBcwL8maILL9CkKl+bjcxNEtlh5+0g6jVYKVqqxj7/KSAEJVLx63an4f6sB8MK6yYeZCVb5Ejc203spJlR1wAphsdV/nSiMrH+FLgpIDLam5jy+ETlPoaSb7s0tVAQk1evmBx4ZK91t0WnZWG6E8oMx975Ks/aQ8ZDIoQEp4wQqvbGq7f+prGyZnfuCvFA6W9v+zuobV6mPptpevS8Touj9f50OrHROQxBLsnTrbnDQtQawDVAYD38gzWx7w/bCyVKtFVcefQxdO9AhlGF99ZlfGzdNFCXQ63nRZNwE02q3Y/wx5YMRuquvxBQMin9ss8XRI52OW23gRNEdyOSfuTft0SHnvBXkSBxk6E0EkQr/ar6qk5+1CHdQp0IWbjiLG0vdkseH7EHNDWAV+bCCSjNPV6pPIh/iWbrIz2NXjzDofP5K2SpY4cw6GO2QOsgcm8//q0nrAVDHGqUW5lmfggknI9znN5fP92SA7KskcVZsqlWMA5K8MR95TjX8CJA==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(34020700016)(82310400026)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PqU72YX0Y8b1dSqPZGPH78vem53oZtgAOdXLIl+8r0Rr9h5t3DaY1dAyzWH0BGc2jPtGt+oX+eZZHRVaDGm15h3FjtwqOvpCyXhpU13+XtdlIZh4OEhZdg5JDVnxtlQl+zfcGYPjZsqpMaseBLhV7VxolEhbK1vOHu3w00llv7+OPZquv/1qic2TtPV0h+g/WhenuF294F+JMwBrGe4q3wyACz1m9PQjaNZhMxi4nTeOxdqb2q1Krpb/0uInZUL8mlbYq88jbRLxamArWneuXyDWOeFhnB101cuznHIfvXndgIafEpmQxDe+uSB/AEVr5sNdRSNZyxhvDIO8nlwFhpPucHluf02cMKGrXDWADF9pM/zduaHIH93JboAAoZ8RI+Zyf+P+wtwxtvzOGnzy7XfVAGf1hQQdJipoc2qGJm4BcweyRgE80rVMuxw1m7M9
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:27.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5e4e63-34be-4d69-5740-08de7f9760b0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9243
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18004-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A5F93268548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bring in ipoib support.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/ipoib_main.c |  258 +++++++++
 drivers/infiniband/hw/hfi2/ipoib_rx.c   |   93 +++
 drivers/infiniband/hw/hfi2/ipoib_tx.c   |  872 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/netdev_rx.c  |  494 ++++++++++++++++++
 4 files changed, 1717 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_main.c
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_rx.c
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_tx.c
 create mode 100644 drivers/infiniband/hw/hfi2/netdev_rx.c

diff --git a/drivers/infiniband/hw/hfi2/ipoib_main.c b/drivers/infiniband/hw/hfi2/ipoib_main.c
new file mode 100644
index 000000000000..3e6d142d16cc
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ipoib_main.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ */
+
+/*
+ * This file contains HFI2 support for ipoib functionality
+ */
+
+#include "ipoib.h"
+#include "hfi2.h"
+
+static u32 qpn_from_mac(const u8 *mac_arr)
+{
+	return (u32)mac_arr[1] << 16 | mac_arr[2] << 8 | mac_arr[3];
+}
+
+static int hfi2_ipoib_dev_init(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	int ret;
+
+	ret = priv->netdev_ops->ndo_init(dev);
+	if (ret)
+		return ret;
+
+	ret = hfi2_netdev_add_data(priv->ppd,
+				   qpn_from_mac(priv->netdev->dev_addr),
+				   dev);
+	if (ret < 0) {
+		priv->netdev_ops->ndo_uninit(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void hfi2_ipoib_dev_uninit(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+
+	free_percpu(dev->tstats);
+	dev->tstats = NULL;
+
+	hfi2_netdev_remove_data(priv->ppd, qpn_from_mac(priv->netdev->dev_addr));
+
+	priv->netdev_ops->ndo_uninit(dev);
+}
+
+static int hfi2_ipoib_dev_open(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	int ret;
+
+	ret = priv->netdev_ops->ndo_open(dev);
+	if (!ret) {
+		struct hfi2_ibport *ibp = to_iport(priv->device,
+						   priv->port_num);
+		struct rvt_qp *qp;
+		u32 qpn = qpn_from_mac(priv->netdev->dev_addr);
+
+		rcu_read_lock();
+		qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+		if (!qp) {
+			rcu_read_unlock();
+			priv->netdev_ops->ndo_stop(dev);
+			return -EINVAL;
+		}
+		rvt_get_qp(qp);
+		priv->qp = qp;
+		rcu_read_unlock();
+
+		hfi2_netdev_enable_queues(priv->ppd);
+		hfi2_ipoib_napi_tx_enable(dev);
+	}
+
+	return ret;
+}
+
+static int hfi2_ipoib_dev_stop(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+
+	if (!priv->qp)
+		return 0;
+
+	hfi2_ipoib_napi_tx_disable(dev);
+	hfi2_netdev_disable_queues(priv->ppd);
+
+	rvt_put_qp(priv->qp);
+	priv->qp = NULL;
+
+	return priv->netdev_ops->ndo_stop(dev);
+}
+
+static const struct net_device_ops hfi2_ipoib_netdev_ops = {
+	.ndo_init         = hfi2_ipoib_dev_init,
+	.ndo_uninit       = hfi2_ipoib_dev_uninit,
+	.ndo_open         = hfi2_ipoib_dev_open,
+	.ndo_stop         = hfi2_ipoib_dev_stop,
+};
+
+static int hfi2_ipoib_mcast_attach(struct net_device *dev,
+				   struct ib_device *device,
+				   union ib_gid *mgid,
+				   u16 mlid,
+				   int set_qkey,
+				   u32 qkey)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	u32 qpn = (u32)qpn_from_mac(priv->netdev->dev_addr);
+	struct hfi2_ibport *ibp = to_iport(priv->device, priv->port_num);
+	struct rvt_qp *qp;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+
+	qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+	if (qp) {
+		rvt_get_qp(qp);
+		rcu_read_unlock();
+		if (set_qkey)
+			priv->qkey = qkey;
+
+		/* attach QP to multicast group */
+		ret = ib_attach_mcast(&qp->ibqp, mgid, mlid);
+		rvt_put_qp(qp);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return ret;
+}
+
+static int hfi2_ipoib_mcast_detach(struct net_device *dev,
+				   struct ib_device *device,
+				   union ib_gid *mgid,
+				   u16 mlid)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	u32 qpn = (u32)qpn_from_mac(priv->netdev->dev_addr);
+	struct hfi2_ibport *ibp = to_iport(priv->device, priv->port_num);
+	struct rvt_qp *qp;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+
+	qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+	if (qp) {
+		rvt_get_qp(qp);
+		rcu_read_unlock();
+		ret = ib_detach_mcast(&qp->ibqp, mgid, mlid);
+		rvt_put_qp(qp);
+	} else {
+		rcu_read_unlock();
+	}
+	return ret;
+}
+
+static void hfi2_ipoib_netdev_dtor(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+
+	hfi2_ipoib_txreq_deinit(priv);
+	hfi2_ipoib_rxq_deinit(priv->netdev);
+}
+
+static void hfi2_ipoib_set_id(struct net_device *dev, int id)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+
+	priv->pkey_index = (u16)id;
+	ib_query_pkey(priv->device,
+		      priv->port_num,
+		      priv->pkey_index,
+		      &priv->pkey);
+}
+
+static int hfi2_ipoib_setup_rn(struct ib_device *device,
+			       u32 port_num,
+			       struct net_device *netdev,
+			       void *param)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(device);
+	struct rdma_netdev *rn = netdev_priv(netdev);
+	struct hfi2_ipoib_dev_priv *priv;
+	int rc;
+
+	rn->send = hfi2_ipoib_send;
+	rn->tx_timeout = hfi2_ipoib_tx_timeout;
+	rn->attach_mcast = hfi2_ipoib_mcast_attach;
+	rn->detach_mcast = hfi2_ipoib_mcast_detach;
+	rn->set_id = hfi2_ipoib_set_id;
+	rn->hca = device;
+	rn->port_num = port_num;
+	rn->mtu = netdev->mtu;
+
+	priv = hfi2_ipoib_priv(netdev);
+	priv->dd = dd;
+	priv->ppd = &dd->pport[port_num - 1];
+	priv->netdev = netdev;
+	priv->device = device;
+	priv->port_num = port_num;
+	priv->netdev_ops = netdev->netdev_ops;
+
+	ib_query_pkey(device, port_num, priv->pkey_index, &priv->pkey);
+
+	rc = hfi2_ipoib_txreq_init(priv);
+	if (rc) {
+		dd_dev_err(dd, "IPoIB netdev TX init - failed(%d)\n", rc);
+		return rc;
+	}
+
+	rc = hfi2_ipoib_rxq_init(netdev);
+	if (rc) {
+		dd_dev_err(dd, "IPoIB netdev RX init - failed(%d)\n", rc);
+		hfi2_ipoib_txreq_deinit(priv);
+		return rc;
+	}
+
+	netdev->netdev_ops = &hfi2_ipoib_netdev_ops;
+
+	netdev->priv_destructor = hfi2_ipoib_netdev_dtor;
+	netdev->needs_free_netdev = true;
+	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	return 0;
+}
+
+int hfi2_ipoib_rn_get_params(struct ib_device *device,
+			     u32 port_num,
+			     enum rdma_netdev_t type,
+			     struct rdma_netdev_alloc_params *params)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(device);
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_portrsrcs *pr;
+
+	if (type != RDMA_NETDEV_IPOIB)
+		return -EOPNOTSUPP;
+
+	if (!port_num || port_num > dd->num_pports)
+		return -EINVAL;
+	pr = &dr->ppr[port_num - 1];
+
+	if (!HFI2_CAP_IS_KSET(AIP) || !pr->num_netdev_contexts)
+		return -EOPNOTSUPP;
+
+	params->sizeof_priv = sizeof(struct hfi2_ipoib_rdma_netdev);
+	params->txqs = dr->last_sdma_engine - dr->first_sdma_engine;
+	params->rxqs = pr->num_netdev_contexts;
+	params->param = NULL;
+	params->initialize_rdma_netdev = hfi2_ipoib_setup_rn;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/hfi2/ipoib_rx.c b/drivers/infiniband/hw/hfi2/ipoib_rx.c
new file mode 100644
index 000000000000..be001c3d9b29
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ipoib_rx.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ */
+
+#include "netdev.h"
+#include "ipoib.h"
+
+#define HFI2_IPOIB_SKB_PAD ((NET_SKB_PAD) + (NET_IP_ALIGN))
+
+static void copy_ipoib_buf(struct sk_buff *skb, void *data, int size)
+{
+	skb_checksum_none_assert(skb);
+	skb->protocol = *((__be16 *)data);
+
+	skb_put_data(skb, data, size);
+	skb->mac_header = HFI2_IPOIB_PSEUDO_LEN;
+	skb_pull(skb, HFI2_IPOIB_ENCAP_LEN);
+}
+
+static struct sk_buff *prepare_frag_skb(struct napi_struct *napi, int size)
+{
+	struct sk_buff *skb;
+	int skb_size = SKB_DATA_ALIGN(size + HFI2_IPOIB_SKB_PAD);
+	void *frag;
+
+	skb_size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	skb_size = SKB_DATA_ALIGN(skb_size);
+	frag = napi_alloc_frag(skb_size);
+
+	if (unlikely(!frag))
+		return napi_alloc_skb(napi, size);
+
+	skb = build_skb(frag, skb_size);
+
+	if (unlikely(!skb)) {
+		skb_free_frag(frag);
+		return NULL;
+	}
+
+	skb_reserve(skb, HFI2_IPOIB_SKB_PAD);
+	return skb;
+}
+
+struct sk_buff *hfi2_ipoib_prepare_skb(struct hfi2_netdev_rxq *rxq,
+				       int size, void *data)
+{
+	struct napi_struct *napi = &rxq->napi;
+	int skb_size = size + HFI2_IPOIB_ENCAP_LEN;
+	struct sk_buff *skb;
+
+	/*
+	 * For smaller(4k + skb overhead) allocations we will go using
+	 * napi cache. Otherwise we will try to use napi frag cache.
+	 */
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE))
+		skb = napi_alloc_skb(napi, skb_size);
+	else
+		skb = prepare_frag_skb(napi, skb_size);
+
+	if (unlikely(!skb))
+		return NULL;
+
+	copy_ipoib_buf(skb, data, size);
+
+	return skb;
+}
+
+int hfi2_ipoib_rxq_init(struct net_device *netdev)
+{
+	struct hfi2_ipoib_dev_priv *ipoib_priv = hfi2_ipoib_priv(netdev);
+	struct hfi2_pportdata *ppd = ipoib_priv->ppd;
+	int ret;
+
+	ret = hfi2_netdev_rx_init(ppd);
+	if (ret)
+		return ret;
+
+	hfi2_init_aip_rsm(ppd);
+
+	return ret;
+}
+
+void hfi2_ipoib_rxq_deinit(struct net_device *netdev)
+{
+	struct hfi2_ipoib_dev_priv *ipoib_priv = hfi2_ipoib_priv(netdev);
+	struct hfi2_pportdata *ppd = ipoib_priv->ppd;
+
+	hfi2_deinit_aip_rsm(ppd);
+	hfi2_netdev_rx_destroy(ppd);
+}
diff --git a/drivers/infiniband/hw/hfi2/ipoib_tx.c b/drivers/infiniband/hw/hfi2/ipoib_tx.c
new file mode 100644
index 000000000000..1c2de57cfae2
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ipoib_tx.c
@@ -0,0 +1,872 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ */
+
+/*
+ * This file contains HFI2 support for IPOIB SDMA functionality
+ */
+
+#include <linux/log2.h>
+#include <linux/circ_buf.h>
+
+#include "sdma.h"
+#include "verbs.h"
+#include "trace_ibhdrs.h"
+#include "ipoib.h"
+#include "trace_tx.h"
+#include "qp.h"
+
+/* Add a convenience helper */
+#define CIRC_ADD(val, add, size) (((val) + (add)) & ((size) - 1))
+#define CIRC_NEXT(val, size) CIRC_ADD(val, 1, size)
+#define CIRC_PREV(val, size) CIRC_ADD(val, -1, size)
+
+struct ipoib_txparms {
+	struct hfi2_devdata        *dd;
+	struct rdma_ah_attr        *ah_attr;
+	struct hfi2_ibport         *ibp;
+	struct hfi2_ipoib_txq      *txq;
+	union hfi2_ipoib_flow       flow;
+	u32                         dqpn;
+	u8                          hdr_dwords;
+	u8                          entropy;
+};
+
+static struct ipoib_txreq *
+hfi2_txreq_from_idx(struct hfi2_ipoib_circ_buf *r, u32 idx)
+{
+	return (struct ipoib_txreq *)(r->items + (idx << r->shift));
+}
+
+static u32 hfi2_ipoib_txreqs(const u64 sent, const u64 completed)
+{
+	return sent - completed;
+}
+
+static u64 hfi2_ipoib_used(struct hfi2_ipoib_txq *txq)
+{
+	return hfi2_ipoib_txreqs(txq->tx_ring.sent_txreqs,
+				 txq->tx_ring.complete_txreqs);
+}
+
+static void hfi2_ipoib_stop_txq(struct hfi2_ipoib_txq *txq)
+{
+	trace_hfi2_txq_stop(txq);
+	if (atomic_inc_return(&txq->tx_ring.stops) == 1)
+		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
+}
+
+static void hfi2_ipoib_wake_txq(struct hfi2_ipoib_txq *txq)
+{
+	trace_hfi2_txq_wake(txq);
+	if (atomic_dec_and_test(&txq->tx_ring.stops))
+		netif_wake_subqueue(txq->priv->netdev, txq->q_idx);
+}
+
+static uint hfi2_ipoib_ring_hwat(struct hfi2_ipoib_txq *txq)
+{
+	return min_t(uint, txq->priv->netdev->tx_queue_len,
+		     txq->tx_ring.max_items - 1);
+}
+
+static uint hfi2_ipoib_ring_lwat(struct hfi2_ipoib_txq *txq)
+{
+	return min_t(uint, txq->priv->netdev->tx_queue_len,
+		     txq->tx_ring.max_items) >> 1;
+}
+
+static void hfi2_ipoib_check_queue_depth(struct hfi2_ipoib_txq *txq)
+{
+	++txq->tx_ring.sent_txreqs;
+	if (hfi2_ipoib_used(txq) >= hfi2_ipoib_ring_hwat(txq) &&
+	    !atomic_xchg(&txq->tx_ring.ring_full, 1)) {
+		trace_hfi2_txq_full(txq);
+		hfi2_ipoib_stop_txq(txq);
+	}
+}
+
+static void hfi2_ipoib_check_queue_stopped(struct hfi2_ipoib_txq *txq)
+{
+	struct net_device *dev = txq->priv->netdev;
+
+	/* If shutting down just return as queue state is irrelevant */
+	if (unlikely(dev->reg_state != NETREG_REGISTERED))
+		return;
+
+	/*
+	 * When the queue has been drained to less than half full it will be
+	 * restarted.
+	 * The size of the txreq ring is fixed at initialization.
+	 * The tx queue len can be adjusted upward while the interface is
+	 * running.
+	 * The tx queue len can be large enough to overflow the txreq_ring.
+	 * Use the minimum of the current tx_queue_len or the rings max txreqs
+	 * to protect against ring overflow.
+	 */
+	if (hfi2_ipoib_used(txq) < hfi2_ipoib_ring_lwat(txq) &&
+	    atomic_xchg(&txq->tx_ring.ring_full, 0)) {
+		trace_hfi2_txq_xmit_unstopped(txq);
+		hfi2_ipoib_wake_txq(txq);
+	}
+}
+
+static void hfi2_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
+{
+	struct hfi2_ipoib_dev_priv *priv = tx->txq->priv;
+
+	if (likely(!tx->sdma_status)) {
+		dev_sw_netstats_tx_add(priv->netdev, 1, tx->skb->len);
+	} else {
+		++priv->netdev->stats.tx_errors;
+		dd_dev_warn(priv->dd,
+			    "%s: Status = 0x%x pbc 0x%llx txq = %d sde = %d\n",
+			    __func__, tx->sdma_status,
+			    le64_to_cpu(tx->sdma_hdr->pbc), tx->txq->q_idx,
+			    tx->txq->sde->this_idx);
+	}
+
+	napi_consume_skb(tx->skb, budget);
+	tx->skb = NULL;
+	sdma_txclean(priv->dd, &tx->txreq);
+}
+
+static void hfi2_ipoib_drain_tx_ring(struct hfi2_ipoib_txq *txq)
+{
+	struct hfi2_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+	int i;
+	struct ipoib_txreq *tx;
+
+	for (i = 0; i < tx_ring->max_items; i++) {
+		tx = hfi2_txreq_from_idx(tx_ring, i);
+		tx->complete = 0;
+		dev_kfree_skb_any(tx->skb);
+		tx->skb = NULL;
+		sdma_txclean(txq->priv->dd, &tx->txreq);
+	}
+	tx_ring->head = 0;
+	tx_ring->tail = 0;
+	tx_ring->complete_txreqs = 0;
+	tx_ring->sent_txreqs = 0;
+	tx_ring->avail = hfi2_ipoib_ring_hwat(txq);
+}
+
+static int hfi2_ipoib_poll_tx_ring(struct napi_struct *napi, int budget)
+{
+	struct hfi2_ipoib_txq *txq =
+		container_of(napi, struct hfi2_ipoib_txq, napi);
+	struct hfi2_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+	u32 head = tx_ring->head;
+	u32 max_tx = tx_ring->max_items;
+	int work_done;
+	struct ipoib_txreq *tx =  hfi2_txreq_from_idx(tx_ring, head);
+
+	trace_hfi2_txq_poll(txq);
+	for (work_done = 0; work_done < budget; work_done++) {
+		/* See hfi2_ipoib_sdma_complete() */
+		if (!smp_load_acquire(&tx->complete))
+			break;
+		tx->complete = 0;
+		trace_hfi2_tx_produce(tx, head);
+		hfi2_ipoib_free_tx(tx, budget);
+		head = CIRC_NEXT(head, max_tx);
+		tx =  hfi2_txreq_from_idx(tx_ring, head);
+	}
+	tx_ring->complete_txreqs += work_done;
+
+	/* Finished freeing tx items so store the head value. */
+	smp_store_release(&tx_ring->head, head);
+
+	hfi2_ipoib_check_queue_stopped(txq);
+
+	if (work_done < budget)
+		napi_complete_done(napi, work_done);
+
+	return work_done;
+}
+
+static void hfi2_ipoib_sdma_complete(struct sdma_txreq *txreq, int status)
+{
+	struct ipoib_txreq *tx = container_of(txreq, struct ipoib_txreq, txreq);
+
+	trace_hfi2_txq_complete(tx->txq);
+	tx->sdma_status = status;
+	/* see hfi2_ipoib_poll_tx_ring */
+	smp_store_release(&tx->complete, 1);
+	napi_schedule_irqoff(&tx->txq->napi);
+}
+
+static int hfi2_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
+					struct ipoib_txparms *txp)
+{
+	struct hfi2_devdata *dd = txp->dd;
+	struct sdma_txreq *txreq = &tx->txreq;
+	struct sk_buff *skb = tx->skb;
+	int ret = 0;
+	int i;
+
+	if (skb_headlen(skb)) {
+		ret = sdma_txadd_kvaddr(dd, txreq, skb->data, skb_headlen(skb));
+		if (unlikely(ret))
+			return ret;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		ret = sdma_txadd_page(dd,
+				      txreq,
+				      skb_frag_page(frag),
+				      skb_frag_off(frag),
+				      skb_frag_size(frag));
+		if (unlikely(ret))
+			break;
+	}
+
+	return ret;
+}
+
+static int hfi2_ipoib_build_tx_desc(struct ipoib_txreq *tx,
+				    struct ipoib_txparms *txp)
+{
+	struct hfi2_devdata *dd = txp->dd;
+	struct sdma_txreq *txreq = &tx->txreq;
+	struct hfi2_sdma_header *sdma_hdr = tx->sdma_hdr;
+	u16 pkt_bytes =
+		sizeof(sdma_hdr->pbc) + (txp->hdr_dwords << 2) + tx->skb->len;
+	int ret;
+
+	ret = sdma_txinit(dd, txreq, 0, pkt_bytes, hfi2_ipoib_sdma_complete);
+	if (unlikely(ret))
+		return ret;
+
+	/* add pbc + headers */
+	ret = sdma_txadd_kvaddr(dd,
+				txreq,
+				sdma_hdr,
+				sizeof(sdma_hdr->pbc) + (txp->hdr_dwords << 2));
+	if (unlikely(ret))
+		return ret;
+
+	/* add the ulp payload */
+	return hfi2_ipoib_build_ulp_payload(tx, txp);
+}
+
+static void hfi2_ipoib_build_ib_tx_headers(struct ipoib_txreq *tx,
+					   struct ipoib_txparms *txp)
+{
+	struct hfi2_ipoib_dev_priv *priv = tx->txq->priv;
+	struct send_context *sc = hfi2_qp_to_send_context(priv->qp, txp->flow.sc5);
+	struct hfi2_sdma_header *sdma_hdr = tx->sdma_hdr;
+	struct sk_buff *skb = tx->skb;
+	struct hfi2_pportdata *ppd = ppd_from_ibp(txp->ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rdma_ah_attr *ah_attr = txp->ah_attr;
+	struct ib_other_headers *ohdr;
+	struct ib_grh *grh;
+	u64 pbc;
+	u16 dwords;
+	u16 slid;
+	u16 dlid;
+	u16 lrh0;
+	u32 bth0;
+	u32 sqpn = (u32)(priv->netdev->dev_addr[1] << 16 |
+			 priv->netdev->dev_addr[2] << 8 |
+			 priv->netdev->dev_addr[3]);
+	u16 payload_dwords;
+	u8 pad_cnt;
+
+	pad_cnt = -skb->len & 3;
+
+	/* Includes ICRC */
+	payload_dwords = ((skb->len + pad_cnt) >> 2) + SIZE_OF_CRC;
+
+	/* header size in dwords LRH+BTH+DETH = (8+12+8)/4. */
+	txp->hdr_dwords = 7;
+
+	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
+		grh = &sdma_hdr->hdr.ibh.u.l.grh;
+		txp->hdr_dwords +=
+			hfi2_make_grh(txp->ibp,
+				      grh,
+				      rdma_ah_read_grh(ah_attr),
+				      txp->hdr_dwords - LRH_9B_DWORDS,
+				      payload_dwords);
+		lrh0 = HFI2_LRH_GRH;
+		ohdr = &sdma_hdr->hdr.ibh.u.l.oth;
+	} else {
+		lrh0 = HFI2_LRH_BTH;
+		ohdr = &sdma_hdr->hdr.ibh.u.oth;
+	}
+
+	lrh0 |= (rdma_ah_get_sl(ah_attr) & 0xf) << 4;
+	lrh0 |= (txp->flow.sc5 & 0xf) << 12;
+
+	dlid = opa_get_lid(rdma_ah_get_dlid(ah_attr), 9B);
+	if (dlid == be16_to_cpu(IB_LID_PERMISSIVE)) {
+		slid = be16_to_cpu(IB_LID_PERMISSIVE);
+	} else {
+		u16 lid = (u16)ppd->lid;
+
+		if (lid) {
+			lid |= rdma_ah_get_path_bits(ah_attr) &
+				((1 << ppd->lmc) - 1);
+			slid = lid;
+		} else {
+			slid = be16_to_cpu(IB_LID_PERMISSIVE);
+		}
+	}
+
+	/* Includes ICRC */
+	dwords = txp->hdr_dwords + payload_dwords;
+
+	/* Build the lrh */
+	sdma_hdr->hdr.hdr_type = HFI2_PKT_TYPE_9B;
+	hfi2_make_ib_hdr(&sdma_hdr->hdr.ibh, lrh0, dwords, dlid, slid);
+
+	/* Build the bth */
+	bth0 = (IB_OPCODE_UD_SEND_ONLY << 24) | (pad_cnt << 20) | priv->pkey;
+
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(txp->dqpn);
+	ohdr->bth[2] = cpu_to_be32(mask_psn((u32)txp->txq->tx_ring.sent_txreqs));
+
+	/* Build the deth */
+	ohdr->u.ud.deth[0] = cpu_to_be32(priv->qkey);
+	ohdr->u.ud.deth[1] = cpu_to_be32((txp->entropy <<
+					  HFI2_IPOIB_ENTROPY_SHIFT) | sqpn);
+
+	/* Construct the pbc. */
+	pbc = dd->params->create_pbc(ppd, false, pbc_sc4_flag(txp->flow.sc5), 0,
+				     sc_to_vlt(ppd, txp->flow.sc5),
+				     dwords - SIZE_OF_CRC +
+					(sizeof(sdma_hdr->pbc) >> 2),
+				     PBC_L2_9B, dlid,
+				     sc->hw_context);
+	sdma_hdr->pbc = cpu_to_le64(pbc);
+}
+
+static struct ipoib_txreq *hfi2_ipoib_send_dma_common(struct net_device *dev,
+						      struct sk_buff *skb,
+						      struct ipoib_txparms *txp)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(txp->ibp);
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	struct hfi2_ipoib_txq *txq = txp->txq;
+	struct ipoib_txreq *tx;
+	struct hfi2_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+	u32 tail = tx_ring->tail;
+	int ret;
+
+	if (unlikely(!tx_ring->avail)) {
+		u32 head;
+
+		if (hfi2_ipoib_used(txq) >= hfi2_ipoib_ring_hwat(txq))
+			/* This shouldn't happen with a stopped queue */
+			return ERR_PTR(-ENOMEM);
+		/* See hfi2_ipoib_poll_tx_ring() */
+		head = smp_load_acquire(&tx_ring->head);
+		tx_ring->avail =
+			min_t(u32, hfi2_ipoib_ring_hwat(txq),
+			      CIRC_CNT(head, tail, tx_ring->max_items));
+	} else {
+		tx_ring->avail--;
+	}
+	tx = hfi2_txreq_from_idx(tx_ring, tail);
+	trace_hfi2_txq_alloc_tx(txq);
+
+	/* so that we can test if the sdma descriptors are there */
+	tx->txreq.num_desc = 0;
+	tx->txq = txq;
+	tx->skb = skb;
+	INIT_LIST_HEAD(&tx->txreq.list);
+
+	hfi2_ipoib_build_ib_tx_headers(tx, txp);
+
+	ret = hfi2_ipoib_build_tx_desc(tx, txp);
+	if (likely(!ret)) {
+		if (txq->flow.as_int != txp->flow.as_int) {
+			txq->flow.tx_queue = txp->flow.tx_queue;
+			txq->flow.sc5 = txp->flow.sc5;
+			txq->sde = sdma_select_engine_sc(ppd,
+							 txp->flow.tx_queue,
+							 txp->flow.sc5);
+			trace_hfi2_flow_switch(txq);
+		}
+
+		return tx;
+	}
+
+	sdma_txclean(priv->dd, &tx->txreq);
+
+	return ERR_PTR(ret);
+}
+
+static int hfi2_ipoib_submit_tx_list(struct net_device *dev,
+				     struct hfi2_ipoib_txq *txq)
+{
+	int ret;
+	u16 count_out;
+
+	ret = sdma_send_txlist(txq->sde,
+			       iowait_get_ib_work(&txq->wait),
+			       &txq->tx_list,
+			       &count_out);
+	if (likely(!ret) || ret == -EBUSY || ret == -ECOMM)
+		return ret;
+
+	dd_dev_warn(txq->priv->dd, "cannot send skb tx list, err %d.\n", ret);
+
+	return ret;
+}
+
+static int hfi2_ipoib_flush_tx_list(struct net_device *dev,
+				    struct hfi2_ipoib_txq *txq)
+{
+	int ret = 0;
+
+	if (!list_empty(&txq->tx_list)) {
+		/* Flush the current list */
+		ret = hfi2_ipoib_submit_tx_list(dev, txq);
+
+		if (unlikely(ret))
+			if (ret != -EBUSY)
+				++dev->stats.tx_carrier_errors;
+	}
+
+	return ret;
+}
+
+static int hfi2_ipoib_submit_tx(struct hfi2_ipoib_txq *txq,
+				struct ipoib_txreq *tx)
+{
+	int ret;
+
+	ret = sdma_send_txreq(txq->sde,
+			      iowait_get_ib_work(&txq->wait),
+			      &tx->txreq,
+			      txq->pkts_sent);
+	if (likely(!ret)) {
+		txq->pkts_sent = true;
+		iowait_starve_clear(txq->pkts_sent, &txq->wait);
+	}
+
+	return ret;
+}
+
+static int hfi2_ipoib_send_dma_single(struct net_device *dev,
+				      struct sk_buff *skb,
+				      struct ipoib_txparms *txp)
+{
+	struct hfi2_ipoib_txq *txq = txp->txq;
+	struct hfi2_ipoib_circ_buf *tx_ring;
+	struct ipoib_txreq *tx;
+	int ret;
+
+	tx = hfi2_ipoib_send_dma_common(dev, skb, txp);
+	if (IS_ERR(tx)) {
+		int ret = PTR_ERR(tx);
+
+		dev_kfree_skb_any(skb);
+
+		if (ret == -ENOMEM)
+			++dev->stats.tx_errors;
+		else
+			++dev->stats.tx_carrier_errors;
+
+		return NETDEV_TX_OK;
+	}
+
+	tx_ring = &txq->tx_ring;
+	trace_hfi2_tx_consume(tx, tx_ring->tail);
+	/* consume tx */
+	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
+	ret = hfi2_ipoib_submit_tx(txq, tx);
+	trace_sdma_output_ibhdr(txq->priv->dd,
+				&tx->sdma_hdr->hdr,
+				ib_is_sc5(txp->flow.sc5), ret);
+	if (likely(!ret)) {
+tx_ok:
+		hfi2_ipoib_check_queue_depth(txq);
+		return NETDEV_TX_OK;
+	}
+
+	txq->pkts_sent = false;
+
+	if (ret == -EBUSY || ret == -ECOMM)
+		goto tx_ok;
+
+	/* mark complete and kick napi tx */
+	smp_store_release(&tx->complete, 1);
+	napi_schedule(&tx->txq->napi);
+
+	++dev->stats.tx_carrier_errors;
+
+	return NETDEV_TX_OK;
+}
+
+static int hfi2_ipoib_send_dma_list(struct net_device *dev,
+				    struct sk_buff *skb,
+				    struct ipoib_txparms *txp)
+{
+	struct hfi2_ipoib_txq *txq = txp->txq;
+	struct hfi2_ipoib_circ_buf *tx_ring;
+	struct ipoib_txreq *tx;
+
+	/* Has the flow change ? */
+	if (txq->flow.as_int != txp->flow.as_int) {
+		int ret;
+
+		trace_hfi2_flow_flush(txq);
+		ret = hfi2_ipoib_flush_tx_list(dev, txq);
+		if (unlikely(ret)) {
+			if (ret == -EBUSY)
+				++dev->stats.tx_dropped;
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+	tx = hfi2_ipoib_send_dma_common(dev, skb, txp);
+	if (IS_ERR(tx)) {
+		int ret = PTR_ERR(tx);
+
+		dev_kfree_skb_any(skb);
+
+		if (ret == -ENOMEM)
+			++dev->stats.tx_errors;
+		else
+			++dev->stats.tx_carrier_errors;
+
+		return NETDEV_TX_OK;
+	}
+
+	tx_ring = &txq->tx_ring;
+	trace_hfi2_tx_consume(tx, tx_ring->tail);
+	/* consume tx */
+	smp_store_release(&tx_ring->tail, CIRC_NEXT(tx_ring->tail, tx_ring->max_items));
+	list_add_tail(&tx->txreq.list, &txq->tx_list);
+
+	hfi2_ipoib_check_queue_depth(txq);
+
+	trace_sdma_output_ibhdr(txq->priv->dd,
+				&tx->sdma_hdr->hdr,
+				ib_is_sc5(txp->flow.sc5), 0);
+
+	if (!netdev_xmit_more())
+		(void)hfi2_ipoib_flush_tx_list(dev, txq);
+
+	return NETDEV_TX_OK;
+}
+
+static u8 hfi2_ipoib_calc_entropy(struct sk_buff *skb)
+{
+	if (skb_transport_header_was_set(skb)) {
+		u8 *hdr = (u8 *)skb_transport_header(skb);
+
+		return (hdr[0] ^ hdr[1] ^ hdr[2] ^ hdr[3]);
+	}
+
+	return (u8)skb_get_queue_mapping(skb);
+}
+
+int hfi2_ipoib_send(struct net_device *dev,
+		    struct sk_buff *skb,
+		    struct ib_ah *address,
+		    u32 dqpn)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	struct ipoib_txparms txp;
+	struct rdma_netdev *rn = netdev_priv(dev);
+
+	if (unlikely(skb->len > rn->mtu + HFI2_IPOIB_ENCAP_LEN)) {
+		dd_dev_warn(priv->dd, "packet len %d (> %d) too long to send, dropping\n",
+			    skb->len,
+			    rn->mtu + HFI2_IPOIB_ENCAP_LEN);
+		++dev->stats.tx_dropped;
+		++dev->stats.tx_errors;
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	txp.dd = priv->dd;
+	txp.ah_attr = &ibah_to_rvtah(address)->attr;
+	txp.ibp = to_iport(priv->device, priv->port_num);
+	txp.txq = &priv->txqs[skb_get_queue_mapping(skb)];
+	txp.dqpn = dqpn;
+	txp.flow.sc5 = txp.ibp->sl_to_sc[rdma_ah_get_sl(txp.ah_attr)];
+	txp.flow.tx_queue = (u8)skb_get_queue_mapping(skb);
+	txp.entropy = hfi2_ipoib_calc_entropy(skb);
+
+	if (netdev_xmit_more() || !list_empty(&txp.txq->tx_list))
+		return hfi2_ipoib_send_dma_list(dev, skb, &txp);
+
+	return hfi2_ipoib_send_dma_single(dev, skb,  &txp);
+}
+
+/*
+ * hfi2_ipoib_sdma_sleep - ipoib sdma sleep function
+ *
+ * This function gets called from sdma_send_txreq() when there are not enough
+ * sdma descriptors available to send the packet. It adds Tx queue's wait
+ * structure to sdma engine's dmawait list to be woken up when descriptors
+ * become available.
+ */
+static int hfi2_ipoib_sdma_sleep(struct sdma_engine *sde,
+				 struct iowait_work *wait,
+				 struct sdma_txreq *txreq,
+				 uint seq,
+				 bool pkts_sent)
+{
+	struct hfi2_ipoib_txq *txq =
+		container_of(wait->iow, struct hfi2_ipoib_txq, wait);
+
+	write_seqlock(&sde->waitlock);
+
+	if (likely(txq->priv->netdev->reg_state == NETREG_REGISTERED)) {
+		if (sdma_progress(sde, seq, txreq)) {
+			write_sequnlock(&sde->waitlock);
+			return -EAGAIN;
+		}
+
+		if (list_empty(&txreq->list))
+			/* came from non-list submit */
+			list_add_tail(&txreq->list, &txq->tx_list);
+		if (list_empty(&txq->wait.list)) {
+			struct hfi2_ibport *ibp = to_iport(txq->priv->device,
+							   txq->priv->port_num);
+
+			if (!atomic_xchg(&txq->tx_ring.no_desc, 1)) {
+				trace_hfi2_txq_queued(txq);
+				hfi2_ipoib_stop_txq(txq);
+			}
+			ibp->rvp.n_dmawait++;
+			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
+		}
+
+		write_sequnlock(&sde->waitlock);
+		return -EBUSY;
+	}
+
+	write_sequnlock(&sde->waitlock);
+	return -EINVAL;
+}
+
+/*
+ * hfi2_ipoib_sdma_wakeup - ipoib sdma wakeup function
+ *
+ * This function gets called when SDMA descriptors becomes available and Tx
+ * queue's wait structure was previously added to sdma engine's dmawait list.
+ */
+static void hfi2_ipoib_sdma_wakeup(struct iowait *wait, int reason)
+{
+	struct hfi2_ipoib_txq *txq =
+		container_of(wait, struct hfi2_ipoib_txq, wait);
+
+	trace_hfi2_txq_wakeup(txq);
+	if (likely(txq->priv->netdev->reg_state == NETREG_REGISTERED))
+		iowait_schedule(wait, system_highpri_wq, WORK_CPU_UNBOUND);
+}
+
+static void hfi2_ipoib_flush_txq(struct work_struct *work)
+{
+	struct iowait_work *ioww =
+		container_of(work, struct iowait_work, iowork);
+	struct iowait *wait = iowait_ioww_to_iow(ioww);
+	struct hfi2_ipoib_txq *txq =
+		container_of(wait, struct hfi2_ipoib_txq, wait);
+	struct net_device *dev = txq->priv->netdev;
+
+	if (likely(dev->reg_state == NETREG_REGISTERED) &&
+	    likely(!hfi2_ipoib_flush_tx_list(dev, txq)))
+		if (atomic_xchg(&txq->tx_ring.no_desc, 0))
+			hfi2_ipoib_wake_txq(txq);
+}
+
+int hfi2_ipoib_txreq_init(struct hfi2_ipoib_dev_priv *priv)
+{
+	struct net_device *dev = priv->netdev;
+	u32 tx_ring_size, tx_item_size;
+	struct hfi2_ipoib_circ_buf *tx_ring;
+	int i, j;
+
+	/*
+	 * Ring holds 1 less than tx_ring_size
+	 * Round up to next power of 2 in order to hold at least tx_queue_len
+	 */
+	tx_ring_size = roundup_pow_of_two(dev->tx_queue_len + 1);
+	tx_item_size = roundup_pow_of_two(sizeof(struct ipoib_txreq));
+
+	priv->txqs = kcalloc_node(dev->num_tx_queues,
+				  sizeof(struct hfi2_ipoib_txq),
+				  GFP_KERNEL,
+				  priv->dd->node);
+	if (!priv->txqs)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		struct hfi2_ipoib_txq *txq = &priv->txqs[i];
+		struct ipoib_txreq *tx;
+
+		tx_ring = &txq->tx_ring;
+		iowait_init(&txq->wait,
+			    0,
+			    hfi2_ipoib_flush_txq,
+			    NULL,
+			    hfi2_ipoib_sdma_sleep,
+			    hfi2_ipoib_sdma_wakeup,
+			    NULL,
+			    NULL);
+		txq->priv = priv;
+		txq->sde = NULL;
+		INIT_LIST_HEAD(&txq->tx_list);
+		atomic_set(&txq->tx_ring.stops, 0);
+		atomic_set(&txq->tx_ring.ring_full, 0);
+		atomic_set(&txq->tx_ring.no_desc, 0);
+		txq->q_idx = i;
+		txq->flow.tx_queue = 0xff;
+		txq->flow.sc5 = 0xff;
+		txq->pkts_sent = false;
+
+		netdev_queue_numa_node_write(netdev_get_tx_queue(dev, i),
+					     priv->dd->node);
+
+		txq->tx_ring.items =
+			kvzalloc_node(array_size(tx_ring_size, tx_item_size),
+				      GFP_KERNEL, priv->dd->node);
+		if (!txq->tx_ring.items)
+			goto free_txqs;
+
+		txq->tx_ring.max_items = tx_ring_size;
+		txq->tx_ring.shift = ilog2(tx_item_size);
+		txq->tx_ring.avail = hfi2_ipoib_ring_hwat(txq);
+		tx_ring = &txq->tx_ring;
+		for (j = 0; j < tx_ring_size; j++) {
+			hfi2_txreq_from_idx(tx_ring, j)->sdma_hdr =
+				kzalloc_node(sizeof(*tx->sdma_hdr),
+					     GFP_KERNEL, priv->dd->node);
+			if (!hfi2_txreq_from_idx(tx_ring, j)->sdma_hdr)
+				goto free_txqs;
+		}
+
+		netif_napi_add_tx(dev, &txq->napi, hfi2_ipoib_poll_tx_ring);
+	}
+
+	return 0;
+
+free_txqs:
+	for (i--; i >= 0; i--) {
+		struct hfi2_ipoib_txq *txq = &priv->txqs[i];
+
+		netif_napi_del(&txq->napi);
+		tx_ring = &txq->tx_ring;
+		for (j = 0; j < tx_ring_size; j++)
+			kfree(hfi2_txreq_from_idx(tx_ring, j)->sdma_hdr);
+		kvfree(tx_ring->items);
+	}
+
+	kfree(priv->txqs);
+	priv->txqs = NULL;
+	return -ENOMEM;
+}
+
+static void hfi2_ipoib_drain_tx_list(struct hfi2_ipoib_txq *txq)
+{
+	struct sdma_txreq *txreq;
+	struct sdma_txreq *txreq_tmp;
+
+	list_for_each_entry_safe(txreq, txreq_tmp, &txq->tx_list, list) {
+		struct ipoib_txreq *tx =
+			container_of(txreq, struct ipoib_txreq, txreq);
+
+		list_del(&txreq->list);
+		sdma_txclean(txq->priv->dd, &tx->txreq);
+		dev_kfree_skb_any(tx->skb);
+		tx->skb = NULL;
+		txq->tx_ring.complete_txreqs++;
+	}
+
+	if (hfi2_ipoib_used(txq))
+		dd_dev_warn(txq->priv->dd,
+			    "txq %d not empty found %u requests\n",
+			    txq->q_idx,
+			    hfi2_ipoib_txreqs(txq->tx_ring.sent_txreqs,
+					      txq->tx_ring.complete_txreqs));
+}
+
+void hfi2_ipoib_txreq_deinit(struct hfi2_ipoib_dev_priv *priv)
+{
+	int i, j;
+
+	for (i = 0; i < priv->netdev->num_tx_queues; i++) {
+		struct hfi2_ipoib_txq *txq = &priv->txqs[i];
+		struct hfi2_ipoib_circ_buf *tx_ring = &txq->tx_ring;
+
+		iowait_cancel_work(&txq->wait);
+		iowait_sdma_drain(&txq->wait);
+		hfi2_ipoib_drain_tx_list(txq);
+		netif_napi_del(&txq->napi);
+		hfi2_ipoib_drain_tx_ring(txq);
+		for (j = 0; j < tx_ring->max_items; j++)
+			kfree(hfi2_txreq_from_idx(tx_ring, j)->sdma_hdr);
+		kvfree(tx_ring->items);
+	}
+
+	kfree(priv->txqs);
+	priv->txqs = NULL;
+}
+
+void hfi2_ipoib_napi_tx_enable(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		struct hfi2_ipoib_txq *txq = &priv->txqs[i];
+
+		napi_enable(&txq->napi);
+	}
+}
+
+void hfi2_ipoib_napi_tx_disable(struct net_device *dev)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		struct hfi2_ipoib_txq *txq = &priv->txqs[i];
+
+		napi_disable(&txq->napi);
+		hfi2_ipoib_drain_tx_ring(txq);
+	}
+}
+
+void hfi2_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
+{
+	struct hfi2_ipoib_dev_priv *priv = hfi2_ipoib_priv(dev);
+	struct hfi2_ipoib_txq *txq = &priv->txqs[q];
+
+	dd_dev_info(priv->dd, "timeout txq %p q %u stopped %u stops %d no_desc %d ring_full %d\n",
+		    txq, q,
+		    __netif_subqueue_stopped(dev, txq->q_idx),
+		    atomic_read(&txq->tx_ring.stops),
+		    atomic_read(&txq->tx_ring.no_desc),
+		    atomic_read(&txq->tx_ring.ring_full));
+	dd_dev_info(priv->dd, "sde %p engine %u\n",
+		    txq->sde,
+		    txq->sde ? txq->sde->this_idx : 0);
+	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
+	dd_dev_info(priv->dd, "sent %llu completed %llu used %llu\n",
+		    txq->tx_ring.sent_txreqs, txq->tx_ring.complete_txreqs,
+		    hfi2_ipoib_used(txq));
+	dd_dev_info(priv->dd, "tx_queue_len %u max_items %u\n",
+		    dev->tx_queue_len, txq->tx_ring.max_items);
+	dd_dev_info(priv->dd, "head %u tail %u\n",
+		    txq->tx_ring.head, txq->tx_ring.tail);
+	dd_dev_info(priv->dd, "wait queued %u\n",
+		    !list_empty(&txq->wait.list));
+	dd_dev_info(priv->dd, "tx_list empty %u\n",
+		    list_empty(&txq->tx_list));
+}
+
diff --git a/drivers/infiniband/hw/hfi2/netdev_rx.c b/drivers/infiniband/hw/hfi2/netdev_rx.c
new file mode 100644
index 000000000000..954aa0a25322
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/netdev_rx.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ *
+ */
+
+/*
+ * This file contains HFI2 support for netdev RX functionality
+ */
+
+#include "sdma.h"
+#include "verbs.h"
+#include "netdev.h"
+#include "hfi2.h"
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <rdma/ib_verbs.h>
+
+static void hfi2_netdev_rxq_deinit(struct hfi2_netdev_rx *rx);
+
+static int hfi2_netdev_setup_ctxt(struct hfi2_netdev_rx *rx,
+				  struct hfi2_ctxtdata *uctxt)
+{
+	unsigned int rcvctrl_ops;
+	struct hfi2_devdata *dd = rx->dd;
+	int ret;
+
+	uctxt->rhf_rcv_function_map = netdev_rhf_rcv_functions;
+	uctxt->do_interrupt = &handle_receive_interrupt_napi_sp;
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
+	clear_rcvhdrtail(uctxt);
+
+	rcvctrl_ops = HFI2_RCVCTRL_CTXT_DIS;
+	rcvctrl_ops |= HFI2_RCVCTRL_INTRAVAIL_DIS;
+
+	if (!HFI2_CAP_KGET_MASK(uctxt->flags, MULTI_PKT_EGR))
+		rcvctrl_ops |= HFI2_RCVCTRL_ONE_PKT_EGR_ENB;
+	if (HFI2_CAP_KGET_MASK(uctxt->flags, NODROP_EGR_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_EGR_DROP_ENB;
+	if (HFI2_CAP_KGET_MASK(uctxt->flags, NODROP_RHQ_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_RHQ_DROP_ENB;
+	if (HFI2_CAP_KGET_MASK(uctxt->flags, DMA_RTAIL))
+		rcvctrl_ops |= HFI2_RCVCTRL_TAILUPD_ENB;
+
+	hfi2_rcvctrl(uctxt->dd, rcvctrl_ops, uctxt);
+done:
+	return ret;
+}
+
+static int hfi2_netdev_allocate_ctxt(struct hfi2_pportdata *ppd,
+				     struct hfi2_ctxtdata **ctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ctxtdata *uctxt;
+	int ret;
+
+	if (dd->flags & HFI2_FROZEN)
+		return -EIO;
+
+	ret = hfi2_create_ctxtdata(ppd, dd->node, DYNAMIC_CONTEXT, &uctxt);
+	if (ret < 0) {
+		dd_dev_err(dd, "Unable to create ctxtdata, failing open\n");
+		return -ENOMEM;
+	}
+
+	uctxt->flags = HFI2_CAP_KGET(MULTI_PKT_EGR) |
+		HFI2_CAP_KGET(NODROP_RHQ_FULL) |
+		HFI2_CAP_KGET(NODROP_EGR_FULL) |
+		HFI2_CAP_KGET(DMA_RTAIL);
+	/* Netdev contexts are always NO_RDMA_RTAIL */
+	uctxt->fast_handler = handle_receive_interrupt_napi_fp;
+	uctxt->slow_handler = handle_receive_interrupt_napi_sp;
+	hfi2_set_seq_cnt(uctxt, 1);
+
+	hfi2_stats.sps_ctxts++;
+
+	dd_dev_info(dd, "created netdev context %d\n", uctxt->ctxt);
+	*ctxt = uctxt;
+
+	return 0;
+}
+
+static void hfi2_netdev_deallocate_ctxt(struct hfi2_pportdata *ppd,
+					struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	flush_wc();
+
+	/*
+	 * Disable receive context and interrupt available, reset all
+	 * RcvCtxtCtrl bits to default values.
+	 */
+	hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS |
+		     HFI2_RCVCTRL_TIDFLOW_DIS |
+		     HFI2_RCVCTRL_INTRAVAIL_DIS |
+		     HFI2_RCVCTRL_ONE_PKT_EGR_DIS |
+		     HFI2_RCVCTRL_NO_RHQ_DROP_DIS |
+		     HFI2_RCVCTRL_NO_EGR_DROP_DIS, uctxt);
+
+	if (uctxt->msix_intr != CCE_NUM_MSIX_VECTORS)
+		msix_free_irq(dd, uctxt->msix_intr);
+
+	uctxt->msix_intr = CCE_NUM_MSIX_VECTORS;
+	uctxt->event_flags = 0;
+
+	hfi2_clear_tids(uctxt);
+	hfi2_clear_ctxt_pkey(dd, uctxt);
+
+	hfi2_stats.sps_ctxts--;
+
+	hfi2_free_ctxt(uctxt);
+}
+
+static int hfi2_netdev_allot_ctxt(struct hfi2_netdev_rx *rx,
+				  struct hfi2_ctxtdata **ctxt)
+{
+	int rc;
+	struct hfi2_devdata *dd = rx->dd;
+	struct hfi2_pportdata *ppd = rx->ppd;
+
+	rc = hfi2_netdev_allocate_ctxt(ppd, ctxt);
+	if (rc) {
+		dd_dev_err(dd, "netdev ctxt alloc failed %d\n", rc);
+		return rc;
+	}
+
+	rc = hfi2_netdev_setup_ctxt(rx, *ctxt);
+	if (rc) {
+		dd_dev_err(dd, "netdev ctxt setup failed %d\n", rc);
+		hfi2_netdev_deallocate_ctxt(ppd, *ctxt);
+		*ctxt = NULL;
+	}
+
+	return rc;
+}
+
+/**
+ * hfi2_num_netdev_contexts - Count of netdev recv contexts to use.
+ * @dd: device on which to allocate netdev contexts
+ * @available_contexts: count of available receive contexts
+ * @cpu_mask: mask of possible cpus to include for contexts
+ *
+ * Return: count of physical cores on a node or the remaining available recv
+ * contexts for netdev recv context usage up to the maximum of
+ * HFI2_MAX_NETDEV_CTXTS.
+ * A value of 0 can be returned when acceleration is explicitly turned off,
+ * a memory allocation error occurs or when there are no available contexts.
+ *
+ */
+u32 hfi2_num_netdev_contexts(struct hfi2_devdata *dd, u32 available_contexts,
+			     struct cpumask *cpu_mask)
+{
+	cpumask_var_t node_cpu_mask;
+	unsigned int available_cpus;
+
+	if (!HFI2_CAP_IS_KSET(AIP))
+		return 0;
+
+	/* Always give user contexts priority over netdev contexts */
+	if (available_contexts == 0) {
+		dd_dev_info(dd, "No receive contexts available for netdevs.\n");
+		return 0;
+	}
+
+	if (!zalloc_cpumask_var(&node_cpu_mask, GFP_KERNEL)) {
+		dd_dev_err(dd, "Unable to allocate cpu_mask for netdevs.\n");
+		return 0;
+	}
+
+	cpumask_and(node_cpu_mask, cpu_mask, cpumask_of_node(dd->node));
+
+	available_cpus = cpumask_weight(node_cpu_mask);
+
+	free_cpumask_var(node_cpu_mask);
+
+	return min3(available_cpus, available_contexts,
+		    (u32)HFI2_MAX_NETDEV_CTXTS);
+}
+
+static int hfi2_netdev_rxq_init(struct hfi2_netdev_rx *rx)
+{
+	int i;
+	int rc;
+	struct hfi2_devdata *dd = rx->dd;
+	struct hfi2_pportdata *ppd = rx->ppd;
+	struct net_device *dev = rx->rx_napi;
+
+	rx->num_rx_q = dd->rsrcs.ppr[rx->ppd->hw_pidx].num_netdev_contexts;
+	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
+			       GFP_KERNEL, dd->node);
+
+	if (!rx->rxq) {
+		ppd_dev_err(ppd, "Unable to allocate netdev queue data\n");
+		return (-ENOMEM);
+	}
+
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi2_netdev_rxq *rxq = &rx->rxq[i];
+
+		rc = hfi2_netdev_allot_ctxt(rx, &rxq->rcd);
+		if (rc)
+			goto bail_context_irq_failure;
+
+		hfi2_rcd_get(rxq->rcd);
+		rxq->rx = rx;
+		rxq->rcd->napi = &rxq->napi;
+		ppd_dev_info(ppd, "Setting rcv queue %d napi to context %d\n",
+			    i, rxq->rcd->ctxt);
+		/*
+		 * Disable BUSY_POLL on this NAPI as this is not supported
+		 * right now.
+		 */
+		set_bit(NAPI_STATE_NO_BUSY_POLL, &rxq->napi.state);
+		netif_napi_add(dev, &rxq->napi, hfi2_netdev_rx_napi);
+		rc = msix_netdev_request_rcd_irq(rxq->rcd);
+		if (rc)
+			goto bail_context_irq_failure;
+	}
+
+	return 0;
+
+bail_context_irq_failure:
+	ppd_dev_err(ppd, "Unable to allot receive context\n");
+	hfi2_netdev_rxq_deinit(rx);
+	return rc;
+}
+
+static void hfi2_netdev_rxq_deinit(struct hfi2_netdev_rx *rx)
+{
+	int i;
+
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi2_netdev_rxq *rxq = &rx->rxq[i];
+
+		if (!rxq->rcd)
+			continue;
+		netif_napi_del(&rxq->napi);
+		hfi2_netdev_deallocate_ctxt(rx->ppd, rxq->rcd);
+		hfi2_rcd_put(rxq->rcd);
+		rxq->rcd = NULL;
+	}
+
+	kfree(rx->rxq);
+	rx->rxq = NULL;
+	rx->num_rx_q = 0;
+}
+
+static void enable_queues(struct hfi2_netdev_rx *rx)
+{
+	int i;
+
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi2_netdev_rxq *rxq = &rx->rxq[i];
+
+		dd_dev_info(rx->dd, "enabling queue %d on context %d\n", i,
+			    rxq->rcd->ctxt);
+		napi_enable(&rxq->napi);
+		hfi2_rcvctrl(rx->dd,
+			     HFI2_RCVCTRL_CTXT_ENB | HFI2_RCVCTRL_INTRAVAIL_ENB,
+			     rxq->rcd);
+	}
+}
+
+static void disable_queues(struct hfi2_netdev_rx *rx)
+{
+	int i;
+
+	msix_netdev_synchronize_irq(rx->ppd);
+
+	for (i = 0; i < rx->num_rx_q; i++) {
+		struct hfi2_netdev_rxq *rxq = &rx->rxq[i];
+
+		dd_dev_info(rx->dd, "disabling queue %d on context %d\n", i,
+			    rxq->rcd->ctxt);
+
+		/* wait for napi if it was scheduled */
+		hfi2_rcvctrl(rx->dd,
+			     HFI2_RCVCTRL_CTXT_DIS | HFI2_RCVCTRL_INTRAVAIL_DIS,
+			     rxq->rcd);
+		napi_synchronize(&rxq->napi);
+		napi_disable(&rxq->napi);
+	}
+}
+
+/**
+ * hfi2_netdev_rx_init - Incrememnts netdevs counter. When called first time,
+ * it allocates receive queue data and calls netif_napi_add for each queue.
+ *
+ * @dd: hfi2 dev data
+ */
+int hfi2_netdev_rx_init(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+	int res = 0;
+
+	mutex_lock(&hfi2_mutex);
+	if (rx->netdevs++ == 0) {
+		res = hfi2_netdev_rxq_init(rx);
+		if (res)
+			rx->netdevs--;
+	}
+	mutex_unlock(&hfi2_mutex);
+	return res;
+}
+
+/**
+ * hfi2_netdev_rx_destroy - Decrements netdevs counter, when it reaches 0
+ * napi is deleted and receive queses memory is freed.
+ *
+ * @dd: hfi2 dev data
+ */
+int hfi2_netdev_rx_destroy(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	/* destroy the RX queues only if it is the last netdev going away */
+	mutex_lock(&hfi2_mutex);
+	if (--rx->netdevs == 0)
+		hfi2_netdev_rxq_deinit(rx);
+	mutex_unlock(&hfi2_mutex);
+
+	return 0;
+}
+
+/**
+ * hfi2_alloc_rx - Allocates the rx support structure
+ * @dd: hfi2 dev data
+ *
+ * Allocate the rx structure to support gathering the receive
+ * resources and the dummy netdev.
+ *
+ * Updates ppd struct pointers upon success.
+ *
+ * Return: 0 (success) -error on failure
+ *
+ */
+int hfi2_alloc_rx(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	struct hfi2_netdev_rx *rx;
+	int i;
+
+	dd_dev_info(dd, "hfi2 rx allocating, size %ld\n", sizeof(*rx));
+
+	for (i = 0; i < dd->num_pports; i++) {
+		ppd = &dd->pport[i];
+
+		rx = kzalloc_node(sizeof(*rx), GFP_KERNEL, dd->node);
+
+		if (!rx) {
+			hfi2_free_rx(dd);
+			return -ENOMEM;
+		}
+		rx->dd = dd;
+		rx->ppd = ppd;
+		rx->rx_napi = alloc_netdev_dummy(0);
+		if (!rx->rx_napi) {
+			kfree(rx);
+			return -ENOMEM;
+		}
+
+		xa_init(&rx->dev_tbl);
+		atomic_set(&rx->enabled, 0);
+		/* rx->netdevs is already zero from kzalloc */
+		ppd->netdev_rx = rx;
+	}
+
+	return 0;
+}
+
+void hfi2_free_rx(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	dd_dev_info(dd, "hfi2 rx freed\n");
+	for (i = 0; i < dd->num_pports; i++) {
+		ppd = &dd->pport[i];
+		kfree(ppd->netdev_rx);
+		ppd->netdev_rx = NULL;
+	}
+}
+
+/**
+ * hfi2_netdev_enable_queues - This is napi enable function.
+ * It enables napi objects associated with queues.
+ * When at least one device has called it, it increments atomic counter.
+ * Disable function decrements counter and when it is 0,
+ * calls napi_disable for every queue.
+ *
+ * @dd: hfi2 dev data
+ */
+void hfi2_netdev_enable_queues(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	if (!rx)
+		return;
+
+	if (atomic_fetch_inc(&rx->enabled))
+		return;
+
+	mutex_lock(&hfi2_mutex);
+	enable_queues(rx);
+	mutex_unlock(&hfi2_mutex);
+}
+
+void hfi2_netdev_disable_queues(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	if (!rx)
+		return;
+
+	if (atomic_dec_if_positive(&rx->enabled))
+		return;
+
+	mutex_lock(&hfi2_mutex);
+	disable_queues(rx);
+	mutex_unlock(&hfi2_mutex);
+}
+
+/**
+ * hfi2_netdev_add_data - Registers data with unique identifier
+ * to be requested later this is needed for IPoIB VLANs
+ * implementations.
+ * This call is protected by mutex idr_lock.
+ *
+ * @dd: hfi2 dev data
+ * @id: requested integer id up to INT_MAX
+ * @data: data to be associated with index
+ */
+int hfi2_netdev_add_data(struct hfi2_pportdata *ppd, int id, void *data)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	return xa_insert(&rx->dev_tbl, id, data, GFP_NOWAIT);
+}
+
+/**
+ * hfi2_netdev_remove_data - Removes data with previously given id.
+ * Returns the reference to removed entry.
+ *
+ * @dd: hfi2 dev data
+ * @id: requested integer id up to INT_MAX
+ */
+void *hfi2_netdev_remove_data(struct hfi2_pportdata *ppd, int id)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	return xa_erase(&rx->dev_tbl, id);
+}
+
+/**
+ * hfi2_netdev_get_data - Gets data with given id
+ *
+ * @dd: hfi2 dev data
+ * @id: requested integer id up to INT_MAX
+ */
+void *hfi2_netdev_get_data(struct hfi2_pportdata *ppd, int id)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+
+	return xa_load(&rx->dev_tbl, id);
+}
+
+/**
+ * hfi2_netdev_get_first_data - Gets first entry with greater or equal id.
+ *
+ * @dd: hfi2 dev data
+ * @start_id: requested integer id up to INT_MAX
+ */
+void *hfi2_netdev_get_first_data(struct hfi2_pportdata *ppd, int *start_id)
+{
+	struct hfi2_netdev_rx *rx = ppd->netdev_rx;
+	unsigned long index = *start_id;
+	void *ret;
+
+	ret = xa_find(&rx->dev_tbl, &index, UINT_MAX, XA_PRESENT);
+	*start_id = (int)index;
+	return ret;
+}



