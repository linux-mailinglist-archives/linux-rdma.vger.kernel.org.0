Return-Path: <linux-rdma+bounces-17223-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FyBKspSoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17223-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:03:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA281A72D9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 909FF31F24B8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF13B5319;
	Thu, 26 Feb 2026 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCLi/cO+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEA3B52E7;
	Thu, 26 Feb 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113986; cv=fail; b=dDm3Np+Lg0wl2iwscnw1pXs6AxzLJuu7/1IYk7g/YoQUvxfwxx2Q2P+QwAPZxmwnJcf8Nj7eQ0hD0g/kS70Wh8Zeq+vE/7lFc91hSDPC3M50E/3xW8uTNbbkrNrdD77hzChn5C1k7T4GJXYaYpL8bWU1pigpW/wXJjJxmsZTNNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113986; c=relaxed/simple;
	bh=Zxc879TYOs15/Jg9MUaAj7s2TMqwoTHJt9GACovtg5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cnHQ7E8nQcOtlIeKdcj0VEkUjhzj6+7LjDtHJoRKGTIIZ8Hdv5Z70SbNYCAj+RAwudMUvxPwL6LWdWMJYOvLQdJOkPGtX7Ilbc/coTuo+v8FlY8S3/qmtvr/JUlmCyfzZc6bxlwQN/2GJnXO5nldQIyyPwy9iGKYryoWzraERck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCLi/cO+; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaGvSOgVIJOP2zd0aMMfwyU71N9sGKBqiCRUH5oHVFOqPFIUa84gB61iFHMgvAwczsWcV1VTF5jPCM5eN1b+AHeFR41SpRukzt2MNTeuZ4QL/hDKNC+IhKYle2yUAOR3AuK6Z5frivsSnrFaHONxFOLiRGPDAZX0+xTUZ99m+OI6PzB2sFGaZGtbeQoeOYDlM+ir3d9DTelLR4K1oaLhJeb+UwQHmmh9Hrwql1go/9umawFtdh+SHjLHnog5HS6NndwjEOLTSJ3dAnc8IutikaYJUbPSbW0qk8gD/0EmYp+ZaweV8WBYQuSScoMryBJ+2miErWOX/W+F3fhZLmdNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDnoFgKmqF3JZvf/qEtl9hC7Q8XA7/Y5eU+VlqLCCDo=;
 b=koUM+fpYVht6Doy03+dVSGE22VXYjwBWh+vJyR7Qv0ELsNHFwn5nZMnvnCG5AAP6tKgxtQhkKl+Kb/IZzUBC0vz9k/ZZ6QsCHB42BNiDyW9VHABecbwl+vIqZSObmbt9GgDvLOsGX6ruBpAn4fbGNCXTDu63oo6uPHhng4PVLqgQE/C+joZZdg1Wm7ogUqBZZIqkv3EmjbYuAZePHLpoOrweAB0Bbs/7kErt+QikzR6/50mSPII1ERuAmaaj0mK2L+4i0cBEhkaX/t8dU7vFGLgdarUm2LMRdqd1g2yyRAHkz9G/vFWxZSyjA11+U0r59ECbdHB58XUZ+woD8rR1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDnoFgKmqF3JZvf/qEtl9hC7Q8XA7/Y5eU+VlqLCCDo=;
 b=XCLi/cO+G81X6nQD5uokVlVPXACdrLBzCqRBh8jXmuZ5v42Cb9w0KgDqSwThglznezjPnsygyeEWGiMnEtgSNg1LVot4p8ZdpTFmDGk2iL/wY+xDLZbXxlEbxd16W6O8ozu0gNpVug3g4XCcgwZjCQ9eVHuzIkhz21DDjyXFQrrof/cpcilHHa/q/h2BeVuqscC31sbvecFzrexmnXxpdo4x/3cI4zO/XhmAZFTgAPFurNCzO9P4HuBZFxsDZPYpWaxZhvCHjaqfAyRISZhattQ/q7ZtdMic3zXfgekDRP4dZiY6b+QCyB9wcLJOJ9oQBwzweGrcEwEDcoamz3oS3w==
Received: from BLAPR03CA0162.namprd03.prod.outlook.com (2603:10b6:208:32f::22)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:52:58 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::dd) by BLAPR03CA0162.outlook.office365.com
 (2603:10b6:208:32f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:43 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:42 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:39 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:10 +0200
Subject: [PATCH rdma-next v4 05/11] RDMA/core: Add pinned handles to FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-5-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=6701;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=R8D+akg6PQqEUpXOCD8MXIvV81j7N6OKTWwNmS4EdvU=;
 b=mfFSP/l2fU8841OeLFZny8OS+PI1qA2jEDhl62tfWdux/JSzXIJ17HVbMp0+CpMd7SJiXi1MQ
 KWpbZI8y+QfBGiOSvVwqbAX/vHyfoaBaRrQW09NGGNku7mcs7TG7l77
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: d86c1068-e84b-468b-e7d1-08de753e59b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	B9XT5NRWZBrht92bbDLpcirxBekD6N9dZRrhLoQAkFP3O2pnoGaNGRm3fZc2E5iUB6hesiWpmr8FsS46+rCWEE+ZVZxYHicYgqzLNzJAPzQGoxld4UdPkqq5LkADhE+EfHh0P7EPtApjjn9/qdmES9uO82/UhVuipv86nY4OZTtG9g4+mqqFLgs8iOMbVXCbJv02BnTzD2oimot2QYsJAFDqnbqOC4bTHkSA1Q4QXKuErPBgJGd0rjnBh1xnPhzxFxc1h7Pz66bkW4pFckjcDZTHBQtRemqZw2CcLpIbwyRnAI+sf21x17oCE3L8xCQPI7+3/96O/ZHCqn5SCd7/4Mad40t/SgzPeQTfD7iJYFS1ys+iAGo652zYj1spdE1Jh2Cyb7zdb/pFU7oaq0MBAaf682Xp8Sjw/7BN3Sd8jCU4A5/HO6s2M/mL+uz/b4cdE0SVPxNGPhWIv6E2LI54a7kwI+WlAEZ1dhmj2/XQOEfRaWJiatUpDY3GEntx+3idSIuuP58MDfVn5XnFwu7VEZwZObLpk8CjccivWpvPc9rUpxI+3sW8m8TTyOy8pa8AfDXhLWjRBZlqaKTX2d+BIrbNVEpxMbJw0G0dcEe7KS81ORSJuSqQZbef26M2qCJbpTfvBLsg6DfcVNO4E0ZDBPwDcKpu9qDt5tyBMPHNIN68Cy+RHlubQcfvqVW0IiSgwL0Kkr9Q1zPv4Pr1Z65v8XPSHSfv/0Fv/iCdIPDGDQ2bYnJD3lkWXDRlWMA0ngkCQ2KLlyfneDrzkbjb6u+UAKRLNJ56ZDot/E/l8QKebjbiCYq4GFgps4Growr3pvJDJ9W8G6dtQ+uO6MNyipFhS0tLFti5gauPDAV9+9+sglA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TpvKTKD9UMwr+6PljGI7i07hn2OEodp5saWqr/Qq45uKelfjC3Qv0OYaq+Z9h1sZ/fmh4kFqpRoRR3AXnHaUwcGY3++CNJ+fHmL0ztcjS36DtRqofpBFUDUYsNvo2LaXCOquldHSGfUhyr8ipWA5PsAtmHL5BxFPylpRtn1PiOF+KBfJr/UA3DJIMvVPmHB4OB4Dk4/w/dXSwhbNCry0m0gWiGWmCj86gLQzmYLdm63j5gSysHIuEHlTkjew9GvwB73n65pVgXIdv1Rjv+4+p8v9WfmIfuYpWHiKnnIPFfCo2YiKqloJfAdmo0YnZOzu0qsOjD+1UsJUi0sxAzO0ieU/EROUSQZkzFS2pxnvJDRwBo1SHKKba653uAFTDwtdRB6TXOxytoLyYT9O3XoUZreMyDpi/4L5OmuI209MXEcQO4yZp8o/jFGGzA1JM/9k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:58.5007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86c1068-e84b-468b-e7d1-08de753e59b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17223-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4CA281A72D9
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add a configuration of pinned handles on a specific FRMR pool.
The configured amount of pinned handles will not be aged and will stay
available for users to claim.

Upon setting the amount of pinned handles to an FRMR pool, we will make
sure we have at least the pinned amount of handles associated with the
pool and create more, if necessary.
The count for pinned handles take into account handles that are used by
user MRs and handles in the queue.

Introduce a new FRMR operation of build_key that allows drivers to
manipulate FRMR keys supplied by the user, allowing failing for
unsupported properties and masking of properties that are modifiable.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 127 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |   3 +
 include/rdma/frmr_pools.h            |   2 +
 3 files changed, 132 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 6a3d1cc75cb0d305ce125a0da1e31d530252514c..74504151ad237fbb50f404034521e60a38571913 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -97,6 +97,50 @@ static void destroy_all_handles_in_queue(struct ib_device *device,
 	}
 }
 
+static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 total, to_destroy, destroyed = 0;
+	bool has_work = false;
+	u32 *handles;
+	u32 handle;
+
+	spin_lock(&pool->lock);
+	total = pool->queue.ci + pool->inactive_queue.ci + pool->in_use;
+	if (total <= pool->pinned_handles) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	to_destroy = total - pool->pinned_handles;
+
+	handles = kcalloc(to_destroy, sizeof(*handles), GFP_ATOMIC);
+	if (!handles) {
+		spin_unlock(&pool->lock);
+		return true;
+	}
+
+	/* Destroy all excess handles in the inactive queue */
+	while (pool->inactive_queue.ci && destroyed < to_destroy) {
+		handles[destroyed++] = pop_handle_from_queue_locked(
+			&pool->inactive_queue);
+	}
+
+	/* Move all handles from regular queue to inactive queue */
+	while (pool->queue.ci) {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		push_handle_to_queue_locked(&pool->inactive_queue, handle);
+		has_work = true;
+	}
+
+	spin_unlock(&pool->lock);
+
+	if (destroyed)
+		pools->pool_ops->destroy_frmrs(device, handles, destroyed);
+	kfree(handles);
+	return has_work;
+}
+
 static void pool_aging_work(struct work_struct *work)
 {
 	struct ib_frmr_pool *pool = container_of(
@@ -104,6 +148,11 @@ static void pool_aging_work(struct work_struct *work)
 	struct ib_frmr_pools *pools = pool->device->frmr_pools;
 	bool has_work = false;
 
+	if (pool->pinned_handles) {
+		has_work = age_pinned_pool(pool->device, pool);
+		goto out;
+	}
+
 	destroy_all_handles_in_queue(pool->device, pool, &pool->inactive_queue);
 
 	/* Move all pages from regular queue to inactive queue */
@@ -120,6 +169,7 @@ static void pool_aging_work(struct work_struct *work)
 	}
 	spin_unlock(&pool->lock);
 
+out:
 	/* Reschedule if there are handles to age in next aging period */
 	if (has_work)
 		queue_delayed_work(
@@ -298,6 +348,83 @@ static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
 	return pool;
 }
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_key driver_key = {};
+	struct ib_frmr_pool *pool;
+	u32 needed_handles;
+	u32 current_total;
+	int i, ret = 0;
+	u32 *handles;
+
+	if (!pools)
+		return -EINVAL;
+
+	ret = ib_check_mr_access(device, key->access_flags);
+	if (ret)
+		return ret;
+
+	if (pools->pool_ops->build_key) {
+		ret = pools->pool_ops->build_key(device, key, &driver_key);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(&driver_key, key, sizeof(*key));
+	}
+
+	pool = ib_frmr_pool_find(pools, &driver_key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &driver_key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	spin_lock(&pool->lock);
+	current_total = pool->in_use + pool->queue.ci + pool->inactive_queue.ci;
+
+	if (current_total < pinned_handles)
+		needed_handles = pinned_handles - current_total;
+	else
+		needed_handles = 0;
+
+	pool->pinned_handles = pinned_handles;
+	spin_unlock(&pool->lock);
+
+	if (!needed_handles)
+		goto schedule_aging;
+
+	handles = kcalloc(needed_handles, sizeof(*handles), GFP_KERNEL);
+	if (!handles)
+		return -ENOMEM;
+
+	ret = pools->pool_ops->create_frmrs(device, key, handles,
+					    needed_handles);
+	if (ret) {
+		kfree(handles);
+		return ret;
+	}
+
+	spin_lock(&pool->lock);
+	for (i = 0; i < needed_handles; i++) {
+		ret = push_handle_to_queue_locked(&pool->queue,
+						  handles[i]);
+		if (ret)
+			goto end;
+	}
+
+end:
+	spin_unlock(&pool->lock);
+	kfree(handles);
+
+schedule_aging:
+	/* Ensure aging is scheduled to adjust to new pinned handles count */
+	mod_delayed_work(pools->aging_wq, &pool->aging_work, 0);
+
+	return ret;
+}
+
 static int get_frmr_from_pool(struct ib_device *device,
 			      struct ib_frmr_pool *pool, struct ib_mr *mr)
 {
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
index 814d8a2106c2978a1a1feca3ba50420025fca994..b144273ee34785623d2254d19f5af40869e00e83 100644
--- a/drivers/infiniband/core/frmr_pools.h
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -45,6 +45,7 @@ struct ib_frmr_pool {
 
 	u32 max_in_use;
 	u32 in_use;
+	u32 pinned_handles;
 };
 
 struct ib_frmr_pools {
@@ -55,4 +56,6 @@ struct ib_frmr_pools {
 	struct workqueue_struct *aging_wq;
 };
 
+int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
+			     u32 pinned_handles);
 #endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index da92ef4d7310c0fe0cebf937a0049f81580ad386..333ce31fc762efb786cd458711617e7ffbd971d0 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -26,6 +26,8 @@ struct ib_frmr_pool_ops {
 			    u32 *handles, u32 count);
 	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
 			      u32 count);
+	int (*build_key)(struct ib_device *device, const struct ib_frmr_key *in,
+			 struct ib_frmr_key *out);
 };
 
 int ib_frmr_pools_init(struct ib_device *device,

-- 
2.49.0


