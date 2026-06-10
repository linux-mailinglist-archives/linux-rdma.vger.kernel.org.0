Return-Path: <linux-rdma+bounces-22043-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eG7nObmpKGqBHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22043-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A0664DFF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="r/vAslBT";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22043-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22043-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CDDA3038118
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400D35959;
	Wed, 10 Jun 2026 00:03:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B98C1F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:02:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049780; cv=fail; b=plpPzh/732k8gIFUYKd8bRmaJW6zFB6bl+xpGoX9s+3WxBG+psAFlgyBozsfxwTJLmjdS1eLT9EoDbGt3G7CQJNw5XUiUsxQvLST3lC970pw4wqQvgbyp67ok9/YcmmABYR9yRx3PnfvUVUCXei0Sg3Ly9a2ydj/v6WrsyP61g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049780; c=relaxed/simple;
	bh=K3rrYnU2/Yu24CJb6Mw3c95Hc4prhfNtvxe96BAO75o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgVEfZH7011iXQTr7C0jpOW4VxKSsUlhBKiMVC7OffPptjEmxk4zL6fUc9D4JcJj3uBoHLGrfecnkvNEZoxu76iAMHPsJfXB72K8HO5rL6UOHR2rXwCkzxFbdAkgiiFd10VpXXW8p6A+0XtZSGC/zkO7Wjg3wGK6NBksdvV4XjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/vAslBT; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvKLOzOKDAdyWtZErv1RbHzw8NP7P0RvBH2hUz4T6N9pwRgUwjjgP2gnnsnHRU3y2KUq5ivKoKC0pYJci6cHOEQrL4g7V7m+q0FJiNLlYY08TldIawNL4SXDuOM4jdpR6knuvvktWak71mn46mmSrPumDJNocuqsfbBa3bPV7Na0juV+U0mhlh/yADBLSa/5NDU0OMmvrcXNofLadusysjRYbLFBdH2Yry5Q7RH7Djo/9Ywu/xZRbT0xsE+PUSPBATgM4lnZx7MTAVwxySeSsCYrL0NsDrSF/GwKy+IZsu6n2TIKFK2mI6pInTOJFvYQ0r3P7V/YjZsKKpxTo07B+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9EcMG6f4NJWizbYJq+154NJlgKwvYk1+wr7Ia9ZKYI=;
 b=BtWHlGo2eoRXwPZ9ja0RGaVSJfoLmiHz6WEakvo+r042nx6BSKYDiHBN9P70KwPYhrcUyCwBDXgazilsDzE5/nsU4ZFM7WfEMKDIv/l7Xj/XWXBgEBX6OwBrY22e0KzYEWboJuI1Z4t7rGjR4My45ulmY0k0FjjmReVvoterwqAuLEm8+xB2H18Qk2E2FXFU+4huAJwf9yCgRJfjex0fxsRBKvEGNzd1aGAj6DzrnIC3dszeyS2oFWC26dUNMIlfwyM2Wc8Wiud+iJ0oDDUGZ6tXUr/vGmIIxvqvNJFQHDaik243Z/hoihFwXclP1FPo2YtwlrEKauOf9iAnydDivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9EcMG6f4NJWizbYJq+154NJlgKwvYk1+wr7Ia9ZKYI=;
 b=r/vAslBTPe0BFTjjVhlrHNjzxoIt1LnHo5Yiyx7zugDWkKNStYMc23rJGnbP83BkvNeQ9Pe6pj57UY1FQwLshUmZEqarR36h5gI3LS0PJHkMhxIlxCYKcWVRG6k9XKvi4CjTTlUt71RV7YemxOAmBELH1AHXP5wNGnlqWQKFZPF7YN1v2qhbKhULP9f0ayzmEexmPVsBvVARvI5TXhtvMCuHGTTgE2AHR4prhnoJoeMjPn6j4/hUivnsAX+Ix6v2Y0qUclFfLcmnOMMTena33f6PJGmHjjvIh7BOR+1rxyuEERsrU9byD601Oh7znComxB1oEbuhryTrkpkzjKmtZw==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:02:53 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:02:53 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 3/9] RDMA/core: Fix skipped usage for driver built FRMR key
Date: Wed, 10 Jun 2026 03:01:39 +0300
Message-ID: <20260610000145.820592-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5b4f95-cc66-4c9e-199b-08dec6839e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7N07MBRQodEc6VPWj8bwpJyQM3I/Jx9VYOal8HiHvTyIWQ76cGAfurlkOqCpbmlbo4a3xN971XUwGcqGbD5zSYS1cYhXVZO5VEtaBFY+Sr1StD7vVm6sU9jNDcQxoNSy35WHuuKC8MNWniVmehDyYjhJOFWrrixKdmk1AC4SgU33LyyeqeiEo6JZhnUMzthPcH1gxfovpRZlkphy6JO08W5/t9PgQkmi/aaOqxfEo0g1imR8p2H1o5T8XsAiHXbnMQRMNZDRwXtmk3ZGV2YAWLQ++kdaLUUIQ+1bNode+akrV2quL01bDgZu2f1qvlaHYgiPSV/co7S20aqLbjfT9Tk2qwgr5YbI+k/9j6KJKRxubph0/u8GDY+zpw6KWDSw2WlKom4BJ8xTLY9DUhT6sO1kyASBEnMz5zPwxkR2DRAGAWtFJfW47FXcm90iIeogBkLI4ZhLnMobYmwLjtcWIg2YppSKSont7/l7xAF7NwWvTbPE4hObDvkVuZtUv1cynM+Vs2myRYbvpUzeFBEBhA3T+T+mi4Gio0UjAM+q2y3udHf+EWmChIkYOQUe8itzFGTPP9hB6oUPAE+Z4s6Bc5hP0jP82VBYdyDBBaARx4I/gFqx/Ajo2NU7N1kEw29E/K/KClP1DBZX7KVakuw/CF9uXfajMYFU2vYkizEzPf/bi1m/4k6sBFeQ0DJ9q6FN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bCTgcQifKAQypQVv0fmn0Lba+Y/ytBa1qud+DleGTHtuy9qWHmzaAKEEhyk?=
 =?us-ascii?Q?xf8JNwXGG29r466FuDDM5lTP1WjjYijyPcZfb8TnDfbXzRxXNAy+kRjZb/vP?=
 =?us-ascii?Q?W2g2SHNRwQxsDlwn6QXML0YMexDQN+xC4gkFupdlwVP105LiMLtKjDv2asfq?=
 =?us-ascii?Q?9HPpU2d87UEgW590tbVLM2xCog5eftS6XpQF4sfQyhb0aR/quXkHNfUcMteL?=
 =?us-ascii?Q?u/R7fLvU5Ibhway8LHRuA1Oc8Wu4FvI5mueRsCGSQecIkmURNgPefcLc45OB?=
 =?us-ascii?Q?iM3Df+ES5m7lAMiHZwFGut9M0OcKdMcn87fHBq3/Vv/1mu1VlZzcD/6KZlts?=
 =?us-ascii?Q?dn22zz6jkTuBF2W7QJxg2o468oqMPOITWD0NEY+U+nF9rYio4Q1R4kgXscce?=
 =?us-ascii?Q?4GUJR0MVTrhc0dLvG7ebqnx91AC5/Onn2PGf3AhCDuPPVy8rrMUKFB7mpx3D?=
 =?us-ascii?Q?B1CI52KQZYBmV6rz1MbcDryN4N/EzDJq7eRID3cfQkfFGjujcIC2Qt7wH0Ql?=
 =?us-ascii?Q?JxBkFRV8viCcSFVbXot25nwufvFTJletHiTwnAkJIqIdtggTMj9Hoflhdhac?=
 =?us-ascii?Q?XDhzTw7sZPSF+KUQxjilU1d4OIi2thUmgKsOQ/UzaHPymdb3I7AzeHgQ8mwt?=
 =?us-ascii?Q?wz320HjGzIYliFJzwDioAwUI9p4hEvyarQjguJS4DjA61AMbftDvNYonLtXA?=
 =?us-ascii?Q?qWXkLCrtM783wPd3GjYsee53FxaGY4sNwu6dsoTSTHpHY6OPEFzBRTEo7MJD?=
 =?us-ascii?Q?lDb3zfYFo3C1R1VnKRVCcPeXUyQPp4l9RUNH9mYx2pSaOKR7DHf7G46XRHl0?=
 =?us-ascii?Q?tKPjyGm/ljaZGByh/iXIFxSVSJJTRu1QLD6xuOTsHBOZo0Dz1lPCI7ymr9rY?=
 =?us-ascii?Q?EHqP8U1Iz1PpYIb0v6ICqiaXW9EBwm7+ijsDtmYs6OldD7CaifZ/SMKqXIVt?=
 =?us-ascii?Q?ix8aXt58U3xayFlwgdKhz4FBFkBJ7LSFXzoMGkD4OZmfc5/qtEep9f7C32Cq?=
 =?us-ascii?Q?OgNQeW6KUlul4U4DAphHpVXUVEX3YwjJzUpxYctw/EBUbSIzQ8cbH62zA3uq?=
 =?us-ascii?Q?+k35cpzusY2gzj+yJjolHQ7v0DUX7cFiEJdqlQAwV7DZi39a4fYkat/ntVH0?=
 =?us-ascii?Q?Tf2X3QIh4d4l3pMk/OGUI2eSeokbMWnPj9ZFXWb3vH5quJZw1MUuLUK11ESm?=
 =?us-ascii?Q?4q2mKDuT/SKDpd86SGwuTxA6qbO6vOTE2yU4dYwNmm4sXDa7P6rrLjaWRh53?=
 =?us-ascii?Q?BuBzhy2PjBkDimrDZuGGctZMx5ORyXtk1OUiLBggFlall+ceYZ51i3f2aQFA?=
 =?us-ascii?Q?1fRWEUXUqOCcXC+TJaoLBD9JWR9Osm5/V1xcgxGDma5IKAZwAGCT9HVUjHjr?=
 =?us-ascii?Q?v6JAnSDEFtedDtIRHy6avOuNRs98uENC/jqsZ9fnjJThiTXZqKvSyuw9mewa?=
 =?us-ascii?Q?uGMKg1Bl1/Svuo30+RUK7Ba/61PcOA3mfb19V7Om7d/yudisUcIWrXpYsSeo?=
 =?us-ascii?Q?DYMpn9Si3Y8zAIJN5Imy5d92IscvLFJxeTqUWs9zDB2sGZihzQvNpY/4NMOG?=
 =?us-ascii?Q?KtjLIX8dcXMSEVpEJPxLFMV1zIe1Kwd0mD4heN1RADxxH0+97uNsBGrkQRnI?=
 =?us-ascii?Q?kKq1NzKQbaLZFnVzqWWMYS1Mus7mzhM3aNsneIIExcpPVMVRKqS1gHtC26kz?=
 =?us-ascii?Q?4F7T3KB3hR3QjYkLzM/aglYjEg64xW7FSjVapaYEmDp2/hRmJLJJ0+2bpomO?=
 =?us-ascii?Q?yBikJLe2Iw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b4f95-cc66-4c9e-199b-08dec6839e1b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:53.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnnjKOC/yvcNj2kP9x+lc7djyQoA1Yox5ORhGrsEqaKDwKYy2w83AbUnwpJxhuWl0feSD0se77V8B4oha7cxtA==
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
	TAGGED_FROM(0.00)[bounces-22043-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E8A0664DFF

From: Michael Guralnik <michaelgur@nvidia.com>

When creating FRMR handles following a netlink command to pin handles,
use the key after driver callback instead of using the key passed directly
from user.

Fixes: 020d189d16a6 ("RDMA/core: Add pinned handles to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 5e992ff3d7cf..6170466ea958 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -426,7 +426,7 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 	if (!handles)
 		return -ENOMEM;
 
-	ret = pools->pool_ops->create_frmrs(device, key, handles,
+	ret = pools->pool_ops->create_frmrs(device, &driver_key, handles,
 					    needed_handles);
 	if (ret) {
 		kfree(handles);
-- 
2.52.0


