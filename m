Return-Path: <linux-rdma+bounces-19015-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE3aC15502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19015-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:14:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B652C3A2808
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3F243018C19
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613383264E7;
	Mon,  6 Apr 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jIBtwkU8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AC327C13;
	Mon,  6 Apr 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466726; cv=fail; b=hq7ip9Tn7lOgxGMmELbvYcrIXneNJ4LXryQHLlbXMxpOv8CB93cQIMWH1lzSU9zki9sFP6I0bWxXiQJuIerSqfhhTWP/ZbE09iWmBip0o4e2BO3MnnT/rz1d3cZw/Sx6BrDybboFmX173QhKv65hCMU30MVBolfr2fpelAtmtDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466726; c=relaxed/simple;
	bh=07Ei7A7KKyx/vqJR7s+8ixUlAzuruB+Ehpyaj86Sa98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GNUaEdBqbqZ0gz5/8zJbDOp7RaMq61dLhZaqDZIe79V8ghNd8ToXvh6g3ghjzeCkU0wLOW8KUPG1Jy/G0Xd/7aKaeo/dH8TI/mLj+hyvKLe3nNd/zOFBFC7bjII6JF6oZX8amgCJleaHqywMRpcpKGX1mxbCsqhBDSB/DsF/W7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jIBtwkU8; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II5j50+XfyYOTe7a0TyP/OVZmJuze+AyTlijb9sUuC7LgpLNk0FcfS5oOGGRDJfHwBkSjGxjvFfsVLE4+9dyVKuzkstguF86OkQB3eN0JlqVmmf5DIKG5ITt+JdAX818YNMCJdyLqGjDGiXIMH+d4L9XNlE2rrtTPcZnUPVt1i3eQ2ycvW70ehdSYzXilULwrLNDltTh3OWSlKRTlYFcE+Gia+nYz3IWYUopFTSvs5OdBVRU+A7PPtqao3/ApplRT7dkYtYyHWV/lZ7ZS/Xa7e/seFPgQLlzYc/kb4e7L/w+zc9jeQZ25xHetfQG532reQfpjCKScAni036W+POwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtLo7npB8ML4O/w113KywGQ7UkDxwFA/f1k6Bqj39vs=;
 b=W7mMgKkjnkznDoxGFmp8S1rIh04aIZ1hB9MnJqnpWatefwcCTCFEgl7Ad5Q3ZLcYIuyQI/cuauYjgBtGiCrsJxpfx8s62Vi/yqPY3dWAnmPf3CVb+CJ0jTtaBKCWpgK2RS2YM5qyZYpZAkNtRNCpUK2VebAoBc2J+wo+sVE0VXQDd1M576qIPwohfHT9r5Yp5k0MUNUeWavDIfcD1xpjtp50WhyZpkwfLxe9tGu7sVM91iBm3AtjIT/jVGY0VzayTZzcqKz0dT0jCw95PROODBXlsXsK7gJpZI1VVf+TafrQ14gTypf6f6sqIuYUBAeRcO6lvs0K7rDjp2ZdgsiBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtLo7npB8ML4O/w113KywGQ7UkDxwFA/f1k6Bqj39vs=;
 b=jIBtwkU8QGo9lxsR+gRYkIum598REh8vkTRPuxfm3CKpOEhJ82XZHaJ+/Y4OqaOnAAseicunZG2FqdRrrUPtHnkJVJZh8BIqVbn0tP7oacHJ2JqpGm8vrlOq9yff6M3rnp51l38isotqIEuzspFm85pKZJlMCh5ibeZhHU7LIzwSp+RnOTe21SalO7wqTCWku2gWz0KwIY6fweA2o4XslSUofl4mvO5BPCQzsqtotBRnPHLI35EQ43Jv0WsuWHO9lBBLo9IZrH+ojp234NT6VBrnGvWRwwlArP3ycEX4DMLmREoX4kDPiSzkKD8J/Nps9RCNOU9EVlFKqMyjzdE0cQ==
Received: from MN2PR19CA0041.namprd19.prod.outlook.com (2603:10b6:208:19b::18)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Mon, 6 Apr
 2026 09:11:59 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::6e) by MN2PR19CA0041.outlook.office365.com
 (2603:10b6:208:19b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 09:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:49 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:45 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:17 +0300
Subject: [PATCH rdma-next v2 06/11] RDMA/core: Fix potential use after free
 in ib_destroy_srq_user()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-6-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=2320;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=+VtBN5/ICOt22ljghD3KcEb67UyEfMhhKiqtiu5cMQY=;
 b=aMrEbfcYVCcYW9/glyrLincUHBSWujkcDO6+9ISMiiLxDIRoVOwxC4+NABNvzYqGZvzVflQCC
 dY4Fyk8ogFODsQcyMsXk2xV6Lzgv/IJxP7ma98yFhl0DNdUQU0YVZJS
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d162912-f2fb-467d-1d86-08de93bc8eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1TKs666fr+EjS8IibTVcYqZm5xo5MAqTgK/IRUzfZSDArMcnHurFgH472bk3BZPnTkU0hkLPOv5UVq1zr3q2/1xicvVHLKkgU2osddxumAgtRzXl/GK2hQCzm+PLLvR9D/6/NIee7oBIQy6jg6VKbRrZmqvtzDzKPORqBAZUZjmOP3NxOY+DqnxYFJBuvbZIDHmqHRaeE/OnorBhZoU+h6bHhXUUoldq9MJ2UujU8vNy3TB6wdxUfLlAxiPbnmgT4bEmI7I2uLNkFIk1qm5g9EdDViuUXUYYpnHR1Z6e8Hku1DExaAvjMX0y0lSi84d7UImLO8vIJGXZqUXf6dOsO1Vn2LIeTzQ7+SP90oNgt5vuqSVOq5LGr5L1MSv94nc0kct6CfGNamVOQzrQko8fqNnVLMB3HvYO3N/cLN8Ub11LtERvCLSNAji1FO3mgvlIfquCSNzCCHDLn6kjU9pKTlRNFlAu5AjoJvPz1/MXUWy98cRir6luQS1UHfAd9+0Dbh1yOASs22o8s83TEQEsnJm8P1k6vcsfqXVqoxEc+hVb9nFHFNeOp4wsX4EwgguO8yrd3Br4sVH4GPnGgEoLot1iFtL/Zc37+dxicKVxixIk2NJf9KfBrY1jxZroHB2/qa5cOGoUQU95IaV1HMEjomM876KOc6kOjhI588J1nms6Zo7HDFdcmnOY7ZSEWXjYl2boY0K5448t+uD3Ju1+QYDrbLPUqvR9onjVRpRRTh/alfxD3nJci0CXj59OkvawVq0m0cle1bC/OWKX0aCSegiwBVeTJTBEo557+bpbT5TqW//MotTwK6zUDxLqQOzK
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W/zk/1ouAyyHZyXzFwRD9U7h4NSTFkp6+tn46xX2sO9xIpHDeWSrzIN/6uXyl/7j0BnFlbxtrFiZBl6ZoPdyLNtuxK/46l9G1n2Q5EzfW1HWjk/awvfX8/K9N3S3pfvOr7ooGal18HyWpRId+1alWZ+QOt9By7dz6EWLBvxQ0IHxatbByhHhc1O0ymMCSR4FYPCXWFA9f9IHvJOLpawxYbqv76hcN8nktYfmVS5ynUTsgHTQJ9DnZLEOo8Gh3kzda95bYxKA6j1WhTSLECyeGZPv7CkfA9Bl4tHA3cEuvUBOtPzvRX3pqDHMFssJh2SEHl6OoXsJE/sUNkxThfy6BiV/ci2psYCFJrKBzkk/b3XncBrvoFFR4x0zebvaeYe6EnszJ9JqjX/Yj002pQsKIDDjaZ8HGkpGnsf1FZyaqXwMEbkfUX9Xxga93Lv2POP4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:58.9058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d162912-f2fb-467d-1d86-08de93bc8eb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19015-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B652C3A2808
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a SRQ via the netlink path the only synchronization
mechanism for the said SRQ is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
ib_destroy_srq_user(), which is too late, since by that point
vendor-specific resources associated with the SRQ might already be
freed. This can leave a short window where the SRQ remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_del() call to the start of
ib_destroy_srq_user(), ensuring that the SRQ is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a SRQ that is in the process of destruction.

In addition, this change preserves the intended asymmetric behavior
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: 48f8a70e899f ("RDMA/restrack: Add support to get resource tracking for SRQ")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 0e8f99807c7c0ce063ed0c1561f4ba42b485b69d..5921c6d008bb10bcce5f3b9bcc99de72193941db 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1139,16 +1139,20 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 	if (atomic_read(&srq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_del(&srq->res);
+
 	ret = srq->device->ops.destroy_srq(srq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_new(&srq->res, RDMA_RESTRACK_SRQ);
+		rdma_restrack_add(&srq->res);
 		return ret;
+	}
 
 	atomic_dec(&srq->pd->usecnt);
 	if (srq->srq_type == IB_SRQT_XRC && srq->ext.xrc.xrcd)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
-	rdma_restrack_del(&srq->res);
 	kfree(srq);
 
 	return ret;

-- 
2.49.0


