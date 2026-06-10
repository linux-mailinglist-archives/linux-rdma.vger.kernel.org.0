Return-Path: <linux-rdma+bounces-22044-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cdGdH72pKGqEHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22044-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890B664E04
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Si8X3yRP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22044-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22044-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D1A2303BB92
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410811CAF;
	Wed, 10 Jun 2026 00:03:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90527727
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049782; cv=fail; b=MnHlmbtGHQkcAXLc2XtkL1Bx1C/5Ar4q6PmuBCAndp5JhWchdN5biRPKotNySAmVfu287XViOSO4El+K9sxxBDQbArG99ilZUw2+yKqsjPBHjSWEK6JMFJJoowikH347c3RrSABOcrz4D2tsFUKpJ3/U7BeIJCP/PRImDyNjcAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049782; c=relaxed/simple;
	bh=QCEFiPIG2TA27j6K1/tw22B09ocWRmr6YYwbhN5cBEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1hZDB5cOMUIwIWmE0xoaW2ri18iME8OCXA51dv+7c51i1odqFMGWYbVcebZLCHhQuBRhnTtJKJHvBf8LJzQ082BsBwaB5jlWQQsRmRNlp7DF5jGoxxyLkIhfJT+TlK9/hOeTUNt/u2MWs3Fe3v/lKS5Zs3JXarc9irqf8JXX6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Si8X3yRP; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfIX9cyqm1GqCtQT6rXJ45MXRabIN228pHLem0hpj7UCId9zZ09n06E5uMPg8+ermqmujF8A6WQ5im/nZ6LTxlHLoN1fU8a2gPvl2R2Yzv6Y0h72VPsnwzIuaNmIXYSVvXkYy3VEipnviFoEmPDE0nAkUuVMFQtceS0Lp///+pnUfOIcjTG5UghKfwW6JWDIAPH1LD2XEyKVxNLV7f2c28Bldiup0ysTv3ge9dNT7EL+zwmkRBBvIkRS1GRd+X4mScGBT7td5T9pW1q6KzfxIBjTYWrC/MIjuGco4Sp3XH/qVIWrptnPUwqsO7VD0sOPg0NXonWYGntdAP9TmQnzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNdVxmEZSki6ud1oGhBljRsYZdkmMBvlzXKtFDCD71A=;
 b=mFB+P+TI0HJmpl8792ucsY7ZZOjKuCrP/52b68RYnsgO0yMc5fFCvivGy1yKOGYD9oo4r3AqkohlyovUYOfsN8irSoF71Sr52i9VcD2DvXa2gw59gAkteyu2eagJDAooK/ImCBmkjqq4KDe95aGVO5jrE5DYiSBSk1bt8fG/OmqtbhSiYgt2Q8H5PcoD/lhdEcXkVlq/lMshyQBMyJWRglzp2f6fO8nUliXlKGAs1rPgys7NwnEa/9AY0kOqeh4YjeWlFloeDJSJIS5HKaV5n566S2NBkMBNeLaEpkNOEa4nYkDOQ/XsvfySnUFiQdIMxmFcp1f25hMB3IP0U9iBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNdVxmEZSki6ud1oGhBljRsYZdkmMBvlzXKtFDCD71A=;
 b=Si8X3yRPcyjm5k+oiUlsElZxr8CrNzLRb4zZ0lUa/RNPkF6Niic/Nn5Bj5XlI1JwuEWABTSZ5mTtiltoaeWLU+EHifJIku/JWjdCok2lvf88DGXoE41wQRqQAQ6B4yFQEeK/Ahrx0qHQG/sbUL0JTWrMHF93DWKxNrXEEttAJbMdtlbpcZvsaFv/YQbylH+LQQopAHo3qCpt06ofPdpXAM2rl2d9mGVBTnNrr7l/qKTNuHZ1P/sMKVdxHez5vgDA3fPVefo+ONAIiK+FxJlhTgrzh7EevOkcRxbzq5SpbaqoAVTFr7sQCGo+6byGDnBtKscsEAjy4AWmlt0LMy0XRw==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:02:56 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:02:56 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 4/9] RDMA/core: Fix FRMR aging push to queue error flow
Date: Wed, 10 Jun 2026 03:01:40 +0300
Message-ID: <20260610000145.820592-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 3606b7d3-b5a5-49a2-4b69-08dec6839ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7OjwUIv/TfJ8w+eD/Oo4JOQxm073A/AjOsSSuViSUdAHi7i4uqOySFT27NIylqAI24e4G8I4iM/NqAlWkvq6y1SdpH671wpBg6uLAeFw6ahvklcNGoRK/X5KK8yYEa+5ifCmsBjOw+jXfi+gzNPnbICxLqQvoCZkdn85uiinhEumOli0E1XxfXi1UmOdrAfVNUexCiFlhIHeVxHZQAQqDsYkhse/l728tTEQ4H6lhvUa38XjT+a+vpoXrcXdxVzzoWluV/VdlcBEaTUe6au2bx6jdXyTg0s6SnF4WZLdB/lrBdrM+4yqB/6fGHzQSAVP85b7rDuCmRvabSobUr+JFhK9Mz4B1zCon3KGKtXlJf8/OhR3eyVrklO3AjiSSFB/Ot++VQuM/6eRDzmRlmcVDSXQDJTWBR66EJC/ZWzoJsS7VExYknk7RSlzloMGJvJ89sNifM6FIfy4VQ/9N3mXPb6wZpH8LZYZCsAGakDKStFUKfKdtTeK7nhYQnqMwfNLcPkVWYY3KhThCyop3CwNC5mX5eAxFJ4E6lOcgq2JDPlj2b4/MT6P3To6ui+kca/viHfEwEMf9jxj/gLTch8TSizjg7yTiNfl0l+qXc6VHBH9u2iNt93o1A3e9bjmAfqgax9E3vCZB3+4hKelg7J7DbjdVMrFqD7SzjRZvTGEZpB7jC2eIQuGPE9l4A/yNzOy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxWrCrLUV1Locb8TBzVXHnCYCBVrUWv8KrSasZiJX4oCLwgBMWLWSAT7AhDW?=
 =?us-ascii?Q?V30ToJGSoR+nXbDuZmHtZhOlDyk4NC3+oKP+imvDcrabn6VFTs3Fzp9TBY5g?=
 =?us-ascii?Q?+wSMaeaemuBl1J6nXtmsZx6Sey6r2wwV+Wq3rjFQQ+Gmccjger81B/foi6C/?=
 =?us-ascii?Q?5hedXYRr2v7poHmd5DeAyHC4h/rZyuaR0t8I6/vQxBEqHchhnh7tH/7jineu?=
 =?us-ascii?Q?6VYJmuxkDTSEunXehTb2yHDO05pwUZvpilW4pTHt6RVNJYBUi+cWyNXZACdo?=
 =?us-ascii?Q?yCFACPvIa6thMmsQ4S5LJrLr5NfPQ9vUGj/MycdZT8yCkUTmP1AWGZ6zR8IB?=
 =?us-ascii?Q?vEcn530vbWSPWMX7YJi8eVn6xEppdGxLPmhd9RQfMTaf5srDJmCRKUMsNdjY?=
 =?us-ascii?Q?bzdqnMOTpbQ2rijZIcKO7uECLWwuZBMooDc4JGU0cBia8IeHCDlD9pXIvGgR?=
 =?us-ascii?Q?Qau1ihuGW/BzGx+V2q0K+TuNIm8YSFA5wJom3HFGhCIgDpmsxLHKWUcG88jW?=
 =?us-ascii?Q?8cJL93/iSYvRfLWhhIX0qkWQ65rW5q+tWQIHEeXrKCStVx8nyCx/rYB/U5Rx?=
 =?us-ascii?Q?pO6WpPkRdR5QFVH1FS5bgK3BoNDs6M0061/stAwjUGQZ+VfWYx8AdplIeV2R?=
 =?us-ascii?Q?qlwEOtQ4Rn/TUvH8/qQ4pZxreZNWf+7TAZOi8VCFsh5DHij4zn8GcKqatupd?=
 =?us-ascii?Q?ujf+pA5cs1vaLwYahozfznrhoUbA9ppW4ZgF4Tw1PG5c4cfy3nYblEqpAx9a?=
 =?us-ascii?Q?cl4Wxx/W2wNcEoUAIgMuo4vdQU5rBJbccMneXZ5sWpHDGAP59tFlDRU2dshs?=
 =?us-ascii?Q?9KwkRbdV8quVOfGqqv2opsTThtpgz9J3E/YMOrJU6vUE4EDkZo5brDPKOwJh?=
 =?us-ascii?Q?M9W0xsA2G/kLIVAA2rhrg7RsvyMjtoCPG4M3sjgaVamLbLvHflonCY7Qsv7B?=
 =?us-ascii?Q?JSMLozGU16jmdkEhrgXMijX4ewwVR4rh58Qm0BnKmUqMZvLYIJCLkvCx5Y6F?=
 =?us-ascii?Q?4UlKwDxFGzhPZJjX4jf7CAcYt8PKzl1/2ZdT481htgoWYN8YB+DzxVy07mbD?=
 =?us-ascii?Q?2MhFX6SzVig2sAvYuSszGePKmW4v12lDiNoIAy5Bbh6OwEfgrsfljMyj5OuT?=
 =?us-ascii?Q?+P1Nj43BydH54GcWytLjWdklIkELfwd+Va5D1Wr5zZDfKL/qNqYs+FeFaV1J?=
 =?us-ascii?Q?xCTzFSXB6yfms79dp3QFtfitKDgq/PXLT993zJAktTYgKgfSlc/SNJV59B+v?=
 =?us-ascii?Q?U50lCvOkMHVG3jEEFObLzRGawhu6I2AiqZzCNzEkqyktT9D8JKXA31QlJuYi?=
 =?us-ascii?Q?MeAWzAh5KRi4a9dJAng3yE2DJyXJJtQ2DGNBH5HVMVof44aZSibyABdIO08U?=
 =?us-ascii?Q?g8yY1CYJdCLnvxgstYuoTKT5nUtUYnyBmmZxp+K8/OYQRBRgVq7K3xeWd1/p?=
 =?us-ascii?Q?sFDHbeCZFEAlZpikDFlYd9Njrkt47kQihW5EhNdOqhqFTd6hxU/6H3CySDQ8?=
 =?us-ascii?Q?LXXTaqfB4TNcke9RPRovbm8uroCtfA/U3/kATkb+shkAaklu7XkYsV218Vj2?=
 =?us-ascii?Q?5l3wOcIH5k+DA9o+ws6B7bVKE6JqRQp1dwnoX2wFelx0WUOkR+uXmOgCUdBx?=
 =?us-ascii?Q?AosUrM34qyl+CyTeR1wPphYRU9wiw+sOjBGz3qeq6c1LcMz6f/WnFBKnzBsc?=
 =?us-ascii?Q?HnO1G7gXDYajHcsIymu9SPboW+ShseY1IOHIdrk7gw/zZzYsdt4mbscN5XT8?=
 =?us-ascii?Q?PCKsresWtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3606b7d3-b5a5-49a2-4b69-08dec6839ffa
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:56.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+2N8slDWMLNwiAn5xi01gPzzlYUeRhnOXoqD9d0WrcNrRnCm3gnGlkY6NBtDUcJirCKjENFj84wF+13TFrNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22044-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3890B664E04

From: Michael Guralnik <michaelgur@nvidia.com>

Aging pools with pinned handles requires moving handles from the
active queue to a non-empty inactive queue that might fail on new page
allocation, we are currently not handling the fault and leaking any mkey
that fails the push.

Fix by Introducing push_queue_to_queue_locked() that fills the
destination's partial tail page from the source and then splices the
remaining source pages onto the destination, performing no allocation.

Replace the per-handle move loop in age_pinned_pool() and the
open-coded splice in pool_aging_work() with calls to the helper.
As the helper cannot fail under memory pressure, removing a class of
GFP_ATOMIC allocations under the pool lock and simplifying the error
flow.

Fixes: 020d189d16a6 ("RDMA/core: Add pinned handles to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 53 ++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 6170466ea958..927642c06f3a 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -97,13 +97,44 @@ static void destroy_all_handles_in_queue(struct ib_device *device,
 	}
 }
 
+/*
+ * Bulk-move all handles from @src into @dst without allocating new pages.
+ * If @dst has a partial tail page, fill it handle-by-handle from @src first
+ * to preserve the invariant that only the tail page is partial, then splice
+ * the remaining @src pages onto @dst. On return @src is empty.
+ *
+ * Caller must hold the lock protecting both queues.
+ */
+static void splice_frmr_queue_locked(struct frmr_queue *dst,
+				     struct frmr_queue *src)
+{
+	u32 free_in_tail = dst->ci % NUM_HANDLES_PER_PAGE;
+	u32 handle;
+
+	if (free_in_tail) {
+		free_in_tail = NUM_HANDLES_PER_PAGE - free_in_tail;
+		while (free_in_tail && src->ci) {
+			handle = pop_handle_from_queue_locked(src);
+			push_handle_to_queue_locked(dst, handle);
+			free_in_tail--;
+		}
+	}
+
+	if (src->ci > 0) {
+		list_splice_tail_init(&src->pages_list, &dst->pages_list);
+		dst->num_pages += src->num_pages;
+		dst->ci += src->ci;
+		src->num_pages = 0;
+		src->ci = 0;
+	}
+}
+
 static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
 {
 	struct ib_frmr_pools *pools = device->frmr_pools;
 	u32 total, to_destroy, destroyed = 0;
 	bool has_work = false;
 	u32 *handles;
-	u32 handle;
 
 	spin_lock(&pool->lock);
 	total = pool->queue.ci + pool->inactive_queue.ci + pool->in_use;
@@ -112,7 +143,7 @@ static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
 		return false;
 	}
 
-	to_destroy = total - pool->pinned_handles;
+	to_destroy = min(total - pool->pinned_handles, pool->inactive_queue.ci);
 
 	handles = kcalloc(to_destroy, sizeof(*handles), GFP_ATOMIC);
 	if (!handles) {
@@ -121,15 +152,13 @@ static bool age_pinned_pool(struct ib_device *device, struct ib_frmr_pool *pool)
 	}
 
 	/* Destroy all excess handles in the inactive queue */
-	while (pool->inactive_queue.ci && destroyed < to_destroy) {
-		handles[destroyed++] = pop_handle_from_queue_locked(
+	for (; destroyed < to_destroy; destroyed++)
+		handles[destroyed] = pop_handle_from_queue_locked(
 			&pool->inactive_queue);
-	}
 
 	/* Move all handles from regular queue to inactive queue */
-	while (pool->queue.ci) {
-		handle = pop_handle_from_queue_locked(&pool->queue);
-		push_handle_to_queue_locked(&pool->inactive_queue, handle);
+	if (pool->queue.ci > 0) {
+		splice_frmr_queue_locked(&pool->inactive_queue, &pool->queue);
 		has_work = true;
 	}
 
@@ -158,13 +187,7 @@ static void pool_aging_work(struct work_struct *work)
 	/* Move all pages from regular queue to inactive queue */
 	spin_lock(&pool->lock);
 	if (pool->queue.ci > 0) {
-		list_splice_tail_init(&pool->queue.pages_list,
-				      &pool->inactive_queue.pages_list);
-		pool->inactive_queue.num_pages = pool->queue.num_pages;
-		pool->inactive_queue.ci = pool->queue.ci;
-
-		pool->queue.num_pages = 0;
-		pool->queue.ci = 0;
+		splice_frmr_queue_locked(&pool->inactive_queue, &pool->queue);
 		has_work = true;
 	}
 	spin_unlock(&pool->lock);
-- 
2.52.0


