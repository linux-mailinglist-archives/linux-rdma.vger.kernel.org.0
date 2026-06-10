Return-Path: <linux-rdma+bounces-22049-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vr+QGdCpKGqQHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22049-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AC664E19
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=JCGgbscy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22049-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22049-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95BFB30157A1
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230F8C1F;
	Wed, 10 Jun 2026 00:03:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF153594A
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049801; cv=fail; b=MGGw0fgEOOxUAMiZfIXoPH9gt/iPIdGHxIDyof7lPR8FfGwgmbCPu3BIODmgq9A+x6YwuJHGizz4nmkiASpy7sHwapPimgAv+51BbRXkSf090s3FqRVF8CpB88TCQ5aGL7+IhClsxkxAhM58TMW9lbigu5mjH1m4K88YlKd38v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049801; c=relaxed/simple;
	bh=Eyo4qmdwkvsyp7mn8EDvALgP/EqjY3FGJTBBULVa078=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adaMT5DMJSFhGt5XDX9xMxkdjWizTvqaxZdarxwlAim2pi1yaQHqWwNYtrtCXm0Vbnc8D98WtxKkqrfXOnTuQuK+Sy2/+mLggjRhqNlOBrQErtr0ExkedSIusKmBQUZsnxQr6kDFS7B/TReklwBo6BGkA4fGXYeQhjkQComDmhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCGgbscy; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On+p2XBcU1vKgjM03IA5E0hCWU00zpOhgPY2zXe3MCld5SUwKC4bS2F+9Y9IzUSNrPEwX9QXnPa4UkgGV/k2P6pX9zUnJJazWdXE3iexU5TmfZeb+PjPxiAdKDyZUa71i8LfUq70NHUQrc/ZIn+wnQymdyWOscdCxT/a22C4MKrTzmkjOV14RbobsP07muuwvvIuq68kdr3RlNIyHg6YSWb0P90KMjYxghTzaHIoHk8s7R9IwDOPO3kBjcvcWG68DAKqR6S8TdXER+hlCcbmSiP7qKEwDnxw1V2njY0kQkh59q2nppO3W84ZqiAFHB+nyxVTrXdU6X/GIDdal5iQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vBI+B8vtXx6I/HSOVRdQReabv8pxZkAfw1Fgo/jl/E=;
 b=sPfY95zw+0oNOuLNqnM0f81aSBvxmoftt3N9/aek0OofRriJRB+0VRYQr5HAkw3yCyniSDWiU3i0OGBwQcXJpVkBdtQEflhy+pl4tY7eFFnZhOMOYYN3tdpJng4OA5KP/Dvyo+k+YLAgvUiEqfeO3rA5X8Ueof6XtdYZTi3r/SwJOCK7zP57xoT2MyTBfuXrQvTokkp3DGeXpHwpxkX5pVDCvpSfFuaxUHWJ4hFI6qwUWZF+ordFp34icuXsW8kENhZl/GsFl8ERJ3J4DDBIEG6QjnFxrdeJ4AxysWt5scU9zhUgz/KiRgIyRhBG0h3J+XV57v9Le2TYoETWSk0XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vBI+B8vtXx6I/HSOVRdQReabv8pxZkAfw1Fgo/jl/E=;
 b=JCGgbscywzqQLrgMDfkOUrW6X+6VAwpV4nO3qyDZZCFh5jxAHsBfPj5tLXxja9cvwv+0ubmpMjgjtA4nMspSeZHm1hTA9Vjvna3HiN76rKRSOpybnRGfhmG/fEoGCz5npHf3ClLXZehPETanxGTj9s3haIApvMrcJbO00qNAp22gyaAGfe0Df5wEZz6toXIfKVmXmJM0YlEMFMb+acHLl98a4/8eDWqI89xA366PUZyOrjEihDK9oAGMCRSGtTqC3UW2prKfgpwr1wNDV8LJYR9aj9X7LaVm8djbhyrFhZ3CHtda2QJF2sTYgwFywGczGikDXkLWcgrdghrQDaq5fQ==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:03:16 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:03:16 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 9/9] RDMA/mlx5: Drop FRMR pool handle on UMR revoke failure
Date: Wed, 10 Jun 2026 03:01:45 +0300
Message-ID: <20260610000145.820592-10-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 994b8079-a9e1-48fb-cab5-08dec683ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/bWSUxynEWCUKG2Oq7bp9tUA9tIJL08VpE+ThcCdVoP6s8I4D6KGzSelj8cD6y0eNbosajQUhEkK13Xzr+o7tr1x9eyzmBaXNfcNH1GZ0sGoGg32r8x1Pn72lIH1PC5Mwb+y+glIuO0Pi+5MRmrlP6g+D6NQ/aQBzcrvyYm2VmRF7NXPGzfVwRkp4S0TvcsU1d1KfWOUMs2OsuwzMYvKLzANtI8anF+OrT5BK3bJit4yjb7GmhKA32TOd7MW7m9udvqYwupo31DpXcIMEQEomy+t6owxRftCS/p4qx1QajQZ9WkC+JKF6KFMcbf9MhN0geslLG2ukAopjmXQpGUjv0OL/Wej6tLNhlawyYaq3kbcGg8nj0UiV7HkbYiyTbdeEJg9hiXmY0Mk5SIj4iCfwLqf8ICqeP13vl4m7rzn7pqi5tAMk33ZXBGyHzJcMjPT7lxs3fa7XCnaBk70JUeqRLrgYCuU/m5N4NuKMmPWcKY/gtpEN1Mm+rAtKR2PWPsEINWoykaoxkB05mbWHyWPdNOvJnrXIbBD9dXHEIhK6PkpLx7/yn+R0sHjqNLWNvRDMcspfFaaF9LTfQSR/rJIJUrdp/ZtrKGkMF7oVt2yb2sFKAxq6MrJ2cUX9RwMxIm5iejBWqx0VXCIYJFbkBYicNuouN3uOa7G6aNQBzL8KmoGf7Zz2CRiCGdvzQ/5n8V6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jHKc4b1iJlyow3NqOGS5tu2DHAAcdWFd/IAoh0FNEUwYmW39QTZTdsMYnrCb?=
 =?us-ascii?Q?8PDcG8/SCRTCsZ3liwX6/zMfYGAMJNaDq2pn25aa7lipZG6PrfCiit29drc0?=
 =?us-ascii?Q?0EoVSpFBz5a41IaKkKorCz28KzP/uVQ0FZPUomM7BhJ8iwvqmOm2c4K1BajL?=
 =?us-ascii?Q?KEU3THOiMFhyGKPqTdnEZUZlcbxq8ZifuLQ+CUnUM2PMlkN7BbrHvVy2pxoj?=
 =?us-ascii?Q?YBiRTWIxupc/oXMWWWKpqNIaeesNtHlP5zrrpaj/R/6d6kBUYcyHiyL97/DF?=
 =?us-ascii?Q?tVxsHWIKS3cR5JEgxs3Ogrst5PQ92s03iIoehi126Y63S8T/UMrx3nsi4D13?=
 =?us-ascii?Q?MtRhqKZVT3MM5bwz+0mGYpPIM8ZOGXcIi9GNW4fVJWT3GXrMwL2OYbTfzv4j?=
 =?us-ascii?Q?l+NDBFJFuAQ3n5ZeaBKcoCl3SU//u6KW03bC0VByMPpbo2PzIRJf8e3zy0Ap?=
 =?us-ascii?Q?RVw2vT5cnRN0DvPKjpE9dYnY6Wc//+7ReERtigkcjMYG2P1icQz4cGOoJYTO?=
 =?us-ascii?Q?5oumD6OBNfdvA/B56p+kCkEXcubQqAyO++qYdDaQySSbYirgufhNTV79ue6m?=
 =?us-ascii?Q?0m37xihgG/G4MVfEq2ishO6ewKt2EPf4kMaKVzRrznuYVZFaKjlsn3lUCWh5?=
 =?us-ascii?Q?zQJrO+WE2XC8L8ubh7ouubFSXmB/9OyC0Ges0/EFVmUhjvwhlftGH5Vs/w6U?=
 =?us-ascii?Q?LOGJBJogH4ZyrMxUo0fa5P4WcG0ZVWrPg2Lvc3T9/SWBkoplZKv6+sRy1njX?=
 =?us-ascii?Q?RLkaMzMipbF72KGmORGim1VL2sfkkTl7F0iruqshSBSEorWGQgyRIF20RGlI?=
 =?us-ascii?Q?qvmjxG9uG9wccr62oE3WAj01ik0/jL1uiAUJpTchuGUP8/0LgrE73OjK4VVO?=
 =?us-ascii?Q?MdUHTrSGufcAmGn9PwIh+5opmOopVUQBCZ+ao45KLlr8w/prcdiH21FSH7sw?=
 =?us-ascii?Q?BstTTPRGXKDtsxwsIdQ3gBY09+8fwncDP0xju0DexEuPs0EPchc5wspx45ey?=
 =?us-ascii?Q?QPPiuQuJ/Pkgvhf0Rpr0C14GUGwsioxpF+XVHX2WqS4FZexqb09O1TKyFH8W?=
 =?us-ascii?Q?ST/yfJ6CT9gIPtJym4KUHA7oShBBAe0fY1N0flJxbkEbvldEv8gaYvaPyvEy?=
 =?us-ascii?Q?nB1oxSSf08iahQmmAY8MejuENjr3ywKHWkn5DiLcKbcEU1yrM/ECRNfSc7Vr?=
 =?us-ascii?Q?EVl0s9p8csWL3u1VnIzoDYzIpznUr6C02Kj8w4b1oF8aoflTXqgJxxFqqIAR?=
 =?us-ascii?Q?UR9kqZyRLLslXEnr37JNquwEEA0KrETHHHYP9g/voy41NwoymrCL3FkMYsqE?=
 =?us-ascii?Q?Hk7qGPfBnvLSBDdvotw8vvhgky4Q4uzBreGB4kLBnvA56n2wHWV+GozT172t?=
 =?us-ascii?Q?wClCs4xh8XuczchsCYyv4aysolSdqo1R0TADr90YximfvEFnP5RzeZPtz/aV?=
 =?us-ascii?Q?+8315NyGepIzHhGxCAycB2jMN9iSekBXwhJzpGYmCeEugoq5tQs47X+XrJoY?=
 =?us-ascii?Q?c02n2yvmd2RWO6zfqycSah1dhibgHru9D5BdCLwrnfYQdF1aNYqXNimoFKeB?=
 =?us-ascii?Q?Klh2upNgN/QrriZVf/OiS0nCNGKnqHg381I1w0hK680vbQrgQ7kq/qrJvfJx?=
 =?us-ascii?Q?eSx/1Bv+y+FtlxunfI9kwOwXJvWmKe1YQeuGsjZLojHfX5qQhQ7jdcKTmUvR?=
 =?us-ascii?Q?8t87pE5bxqjAPQY+CjTK4laJkY6ROwkEJ0rtb9lA3hMt0sZHy0syeiiHt69m?=
 =?us-ascii?Q?gVoOGjCELQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994b8079-a9e1-48fb-cab5-08dec683ac23
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:03:16.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxQQi4kwtDXFO2yV1W0OcRRE0SjAZOHpUQLTWOQLOP/yF8ItouY5V5wCWZHY+0FXDLSpOr0Y8iASvXqPiNWHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22049-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F3AC664E19

From: Michael Guralnik <michaelgur@nvidia.com>

When UMR revoke fails during MR cleanup, the handle is left in an
unknown state and cannot be returned to the pool. The driver already
destroys the mkey via the fallback path, but the pool's in_use counter
is never decremented, drifting upward over time.

Call ib_frmr_pool_drop on the revoke-failure path so the pool's
accounting stays consistent with the handles it has handed out.

Fixes: 36680ef7bceb ("RDMA/mlx5: Switch from MR cache to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1a6a8ccf6832..067e80f7875b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1379,9 +1379,11 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
 	bool is_odp = is_odp_mr(mr);
 	int ret;
 
-	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
-		ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
-		return 0;
+	if (mr->ibmr.frmr.pool) {
+		if (!mlx5_umr_revoke_mr_with_lock(mr)) {
+			ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
+			return 0;
+		}
 	}
 
 	if (is_odp)
@@ -1403,6 +1405,10 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
 		dma_resv_unlock(
 			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
+
+	if (mr->ibmr.frmr.pool && !ret)
+		ib_frmr_pool_drop(&mr->ibmr);
+
 	return ret;
 }
 
-- 
2.52.0


