Return-Path: <linux-rdma+bounces-23146-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jYkmFzoHVWqBjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23146-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:41:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D609174D2EB
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TplwMCNy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23146-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23146-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 272B0302F426
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7B3DDDB3;
	Mon, 13 Jul 2026 15:39:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A773438B5;
	Mon, 13 Jul 2026 15:39:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957155; cv=fail; b=EkmpHRAMDcZ4+1XxPaU9Xs53lPWkgTDFH7/pgx8H24DEcnBOamVos4Ti9mxmRB2FtwynQ0sDiJAfyc117k4ZMvtpvjLOAHIqLdmx/v1DrgBC48ULvJ/s3h2+69dkeXCs1R6dLuDK/Z7eHt0X84xygakHUYzim03CQXvVqPOAUO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957155; c=relaxed/simple;
	bh=hA2VJL3RZwKxjNTnbiXcxJeYvN4ELggcsOWBeNCT0vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E4Po2FA1j7E03yb7X4g0VIHtRfbFOT0gLJFzEACPmJSowemvZ2NNyADeZ1Rxjzrghr8JEl/GYHZPZPHQu6VdwbURgErLZWEEq9J972gNd5/OFHOew5uKIyDtqtDeVcvJZiaKfohJVXVK/kVD1ACu9fYgdu5bjOqoaEYgcjCs/Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TplwMCNy; arc=fail smtp.client-ip=40.107.208.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIioQvmrKHF9Z3+cyW7UntZpWpmn0g0Gn+TbLFklfvki9dxZ90QzthFUvW0usXwvUfUhk0HjvdM5e9bL38shnYaBQIdsWPvakudH4SCmolbf16Xtv2a/Gk57WnmHsNz1M9ZwpTg3sv6UgahfjeviCwdwq5185hNunHHLuoysoQboSkg9TDbTELE7/A7Oqm/19KQTj+ajMhWB2A8WhY59IdnYytloWckuA0i/yQiUT039DdREEBrY0Xi1fBlziWcqM3m5ca8wpim41ahP0REsLhQw1CRs1/DeDRe97zXf0V9R6yxm6Rhyg6fNzAhXWsdmWk2uMeGrLfm3MIIPqc04pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhyXlNpxtutvAXD8ugD9MHCzHPZTE8kCEVlPnR6VyuA=;
 b=Qy3u1AOQ/1vXq0V6JZOQi7QgACKNJq2drL4/nTHcSILllXfiWCTBl8bLCYE/Ke8YgYWo4QHniYSrbJ5PsAM9Rg1yqE/znpW83skb1caUIOFC0IKmk8mXpdnVQwTUVK7fBg9E6bjjqguGZx4bVhdNpbI77BbJhu3PGchgh8Of/bnHFdZrXwYZ3Sd+DzzakIpWAfHQAU+TcSYf1fRIVbICQssax2Ddh1uQoCbL15V7WpaV2PJ5I7ODKwN6mM/CY5mX63p2opcSprjDhZ4TNsgPLHHOp0nI9EgpSpt2eL3YpHks4h7rz8Cf3yjLwyzfMWFHvEbaxJpbo7jJ2P/AICLU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhyXlNpxtutvAXD8ugD9MHCzHPZTE8kCEVlPnR6VyuA=;
 b=TplwMCNyPm4syxhVMvXUWTJYwCnu1WE6P6/Kg34fdk76yyd5co9x7b0vFKiOTVPuLAtKoOS1VKJ+D1SR40eILzH4gxIaFm6w/M37JIe4a/meVN8jFHuOT2Cf3R3Rukn9Lnvz/WOmHXM/kjrYmDar5VZzyDpK0XGVpEW6pkBnOiRf9TNUqYOTETqmp2oYnH0zn+7CRkPSoe7z8mVQnIyEQxOZdlZDA6RGMTYKRlQKHM3EgFx+40RbMfCg3fc2V0L44HlKirhCnHuqw8x7bhimG4e/0FDPoUjpVtXL7TJNqmizlMZE2jH4csKpAIP+8ua42eWgbmuD4S8b03JP3ap6jg==
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 15:39:04 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::16) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:39:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:42 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:38 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:06 +0300
Subject: [PATCH rdma-next v2 7/8] RDMA/core: Fix potential use after free
 in uverbs_free_dmah()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-7-bbe8bb270d51@nvidia.com>
References: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
In-Reply-To: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>, Majd Dibbiny
	<majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=2177;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Eg9C505NCnlykfgzHCbIan3jypwLn/hzfWIj6xB190s=;
 b=KeC9BsBP6IiZr0dX79rXIPvDoXCk7sbDkzngGb0dW5U8/a1+1JIxBEM+GyfFKVsU/BzPtb3ta
 TryJfPFhtTCCe18PxYqFOcgmx7NtyiM4jkBnFGl5XuNR2JZQj6LvYKs
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b5f455-5fb6-4951-9a90-08dee0f4deb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|921020|22082099003|18002099003|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ezx8Xefy+PEGD/CMFpCjUD0RulAq8hJE0GIpW2g1L674QFxhGrgOTw1HrHj/4YcLWtBodF5ckfS5faWM/qTPke5q3ed7C5a+a9zTWymc9TRT/sqG1Oz8pCaXqHzX5UKQ88rhZHHxksSTcHc66BRbHZEMWw1i/5qjjxO7JddwIFTvlzMrXF5Av9OzkBLtOILkDLdyIc5Mt2IiTvciLm//oPXUKnef3m0IeX5JH5hhSOA/zWiZaw5Zioal7TYyJPjoGkiynJ35LUJsA2cvc1ZTWoX7SDy3HdjhmAJjX5ngwde1OSvNcNDakhhiZ48PWxQLdhsrllsMqN2VD8JXLQZLtm38xfgq+BurM7+y7FEi+AHCJzgflzaeIT/NXDm+laLY2pGA1aogVpqcq7k8X0jO5sUUco4wAICenmJDxeVTJiFxlSti5Kn8pvQae6o5Qni3zjFpmw9wnXQrmwJsX5Qiakw2zBkcB/jzw+PKu3il4rPSW/LcB7KD9jdJxO3HADWnGT1fwHsK7LOhcJj8O76EVxaYlBE6BS1Y7QSTtpTxK0JHCw2k5ut599XXGgPcq5CCP8POlZztok7t8Z761uSIcQFAOqnWv5v6hdjN+2C4C6To3HqoYzHv1T3PvtYV7QZLjqIqeNiohgRqB3ngfbYApHTIFR2433yjStOYs1/XgX4Yv+bKNRc2JJCbXu+4WmWPUIZnufxllLLcEUO3fVrCzD/umrAGXe1X37fH5jzBxAD/GsvrV1VNoasB2I1BCsEC
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(921020)(22082099003)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	85znkHFtRcRY0I6uRm8IXh1OK2YN/VgZWtEeUH7WO7YxtaXtnvuw+oaASpGdgGLq1etJ2vxftKRTf/4SwmlblzA0iMiUUs7ulAqCRlyeTP3749fteBd+NBWqJr30tI2l5YYqB+VfX06m1Nien/2RLZvq//paNgowEdmoeRC7SPB36N7l6bheu67jHHoJDpp/FpOkZrDwZUOT+yX+lht7POXJZ1XlN4WMsZpWSCPEBuudM9VCZH/6uLFGVR3wmMsszvdrRSmGTJR8AP63eZ3Nwy7Gwedt8qtfhw2oVDUqxXPf3NveSj0Zj6OsI9qQkrF69K5kt5Kpeb8F1HK/3EwGtWsTWUjpimZnpQjPTB2U66yqtvcWLf3ZiLL67Rh7uGSYg62BkYG8EpMLj8JX5VK3y781+sW94NZw+t9SJBt3fFWO1nbBC05Z7BYJivjVVfKb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:39:04.4478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b5f455-5fb6-4951-9a90-08dee0f4deb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23146-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D609174D2EB

From: Patrisious Haddad <phaddad@nvidia.com>

When accessing a dmah via the netlink path the only synchronization
mechanism for the said dmah is rdma_restrack_get().
Currently, rdma_restrack_del() is invoked at the end of
uverbs_free_dmah(), which is too late, since by that point
vendor-specific resources associated with the dmah might already be
freed. This can leave a short window where the dmah remains accessible
through restrack, leading to a potential use-after-free.

Fix this by moving the rdma_restrack_begin_del() call to the start of
uverbs_free_dmah(), ensuring that the dmah is removed from restrack
before its internal resources are released. This guarantees that no new
users hold references to a dmah that is in the process of destruction.

In addition, this change preserves the intended inverted order
between create and destroy routines: resources are added to
restrack at the end of successful creation, and hence shall be removed
from the restrack first thing during the destruction flow, which keeps
the lifecycle management consistent and predictable.

Fixes: d83edab562a4 ("RDMA/core: Introduce a DMAH object and its alloc/free APIs")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_dmah.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
index 97101e0938263d114d6c1e398895bb8335915202..9873ab49a60132ce32891b96909c1dbfc383fe60 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -18,11 +18,14 @@ static int uverbs_free_dmah(struct ib_uobject *uobject,
 	if (atomic_read(&dmah->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_begin_del(&dmah->res);
 	ret = dmah->device->ops.dealloc_dmah(dmah, attrs);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&dmah->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&dmah->res);
+	rdma_restrack_commit_del(&dmah->res);
 	kfree(dmah);
 	return 0;
 }

-- 
2.49.0


