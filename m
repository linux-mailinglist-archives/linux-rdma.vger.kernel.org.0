Return-Path: <linux-rdma+bounces-4606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DD96224A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 10:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2C1F225C4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179A15B55D;
	Wed, 28 Aug 2024 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qp0ofYhQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2055.outbound.protection.outlook.com [40.107.117.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AEB67A;
	Wed, 28 Aug 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833664; cv=fail; b=Wg2SHEuLKJ9U+a4EwtBWLpO2vRbUjETZ27x0lgBqjbUOoXo08YeraaRvjv/NN2GDA/kzrOjrr85Wzop3hyNVeLBCBSYabSqHct0xDyY5oIYT6DWExAvUOqUE7gRdjlOZZV/QnmUIf+RTc9WV5FKExCYSAVBPFFf+2IzXRs5V8s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833664; c=relaxed/simple;
	bh=OLGjVgshBJEIYJLeJOJq5iyKQ3NuGlF6A3aF5ODGQxI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZqpyrrNNomB7imZmvOFrGzJ/2wl/A6iPwjlkjB165HPl5+FSnL2lgp3H4ihYZrN+PFJ+KOB6XHmwAFwkT1LkXyINlMoNfK6e7ytYkrXo2xCb8ncdO7UNVrUhcHDFqne0mYs+asAGsilPIzF4+OMApvXH/uUK1Cvqfx+THvcWkj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qp0ofYhQ; arc=fail smtp.client-ip=40.107.117.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY6OgTcYGJsXTSwsf9pkwyooFCz2AMNmYQv3tu3ukGSmvPDf9D28Uyuj4K2yCrfh5AYH8pMdnelW0HULm+A4UnXzzNKEssMFlJb65xmcr6JVV3el4vfQjje7+pa6S9bPuBfPgwWp1KPN7q10kI6NRZ6w0B/U2N6ogwFrpDLOplF1/SwtRZCU37oa5w40gxNaXCQZK2AD0yxZC/lz/GTLdvupHr4K6LMFYsMAzX/49y8yZWZxDscLXspG4rKgflkU2QrsKBHFi1oQKpTCJQmqBsSownpS7o8vcvOYoemygEYjpm1Lc1C282VL3mguZRPTsPqMqBjJE1UN49p27UL0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olFZB3Z/uStj57yUxOBDdSY/bjv95GDuaJAMLqHJ5oU=;
 b=EUV2+CKB634EBFleOVG5c0FVkBYKRKFK/aW05JDmy1qLrNXXgTYfLxigNtHr5YTGaeBNxTfH4FhmtMt33gxg6kGy136jckE59xSKZygGEDaPfCFs702IUH37Zux1QQdzI/PaFhVR4aAhB/kVRjRGaZyNjtPKTrkUMkKVJALUjsbh0v5YfkTFN0PpQJTUfMfvNnF5jW5r239qG+jJ/0DJCWQ1roJ728jzCMnti9dgMBXZHFIpbDB6ecZpUnybPAHuOQwaUFCGUryu34a2M2iVfSOjuHWuSx7o9U/JpyfFzt1nDDpM0gZ05wc/aOIHmrw5zebMlWb809kICZGqJGcykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olFZB3Z/uStj57yUxOBDdSY/bjv95GDuaJAMLqHJ5oU=;
 b=qp0ofYhQ2palNQvVsMZuU+6Nfuk96SrGvFpeoSb3mczC/pTh3Xl3pMii8Gwki4dAPN9eiDYjWln4P01A+24NXvuSLRHei8Ia1iAPZoX7BgpSljWjtq4YBn/k5dVI+37M5R35CwU7+pNalZGMefRt6yRBdeTIwftLTa/8EWYbDMHNtIczFOAefE+8azyHS63Bwe0vlfGg2tTLnRt29zeXRwwnLXU53DgjcDOale3gu0xBnK1q/RJiCrJt3u/irnWNscIPy2b2vDD8IGf84eJ0CodMOtBpNLgjQjod8FTy+SEFqG8GRsSZcfBClL4d3CnDJMBFd1VnZundtUYqk4rOMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by TYZPR06MB6024.apcprd06.prod.outlook.com (2603:1096:400:335::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 08:27:37 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 08:27:37 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] RDMA/sw/rdmavt/mr: Convert to use ERR_CAST()
Date: Wed, 28 Aug 2024 16:27:20 +0800
Message-Id: <20240828082720.33231-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|TYZPR06MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c3e47f-0ae1-414b-fd06-08dcc73b45af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TrAYPYEOPpx9Zn73Pn8s3KAGIWDd6RkhAHzINi26VLseT6GyoUPO5kFBE0Im?=
 =?us-ascii?Q?9gP63yAgFL4YnjZGSKa0q2amfAtbTGPo/XZpwf1XauSd0QepoyNerzupXOMm?=
 =?us-ascii?Q?3aNG+/avrbxi47ZdLfWPcS6m5S7j+1Go5dvEFV1aJFZEQOvIqNEiCm5Eiw2B?=
 =?us-ascii?Q?iiF/rIUWIYt3HsHc6X5DuXmJnCYIIUIR99nBaijit9PFVQiNJq0BDyyFr32m?=
 =?us-ascii?Q?q9/1Lo9pfYp+GzTSpF4O/MAJEQMrTxbFvcwe0Q2jUSFVwBKr13pYV+a6hzO0?=
 =?us-ascii?Q?J0P7a4ktH77LoIMVNZibCX+3SAq3RM1SufLCX1P3kLr4VKW+t/VF0raI6Urh?=
 =?us-ascii?Q?OJC7g3U6SYOPBxVLrVvYebSfEa8Srsux7H7gyRSQZXV3bqzkxds8wIqmwmwi?=
 =?us-ascii?Q?RvTtAxj4fniezEcL3h+OXZN1sGJzmlbJyicEcWEnEWzWPRxJopqealRgHxgZ?=
 =?us-ascii?Q?oS3j2yvwYZ12E8vVkbTZP0IV3Kz/Qy34boVNWq77AuK5sGcKZH+Z6KKe87Id?=
 =?us-ascii?Q?d9BH3Py+K9AEaQXc5dUG99pJXMc1NPx4Y7bWPgBcbfh4SZYCTyGr5avYOMWr?=
 =?us-ascii?Q?BHsDLQJlxrcVsCPI8zwT8X3Vd3UkyAeKSuMcSpBCSbtArKbrMYKFzANo5NTs?=
 =?us-ascii?Q?uHQu4VqzlkF1qQ5Rnlu7lWPwCNPFVLFwQkJv2dH/O10yGVBs4jAQn3Iu3byy?=
 =?us-ascii?Q?4+Ti13Szyy3Numdgyr/F5XUNspeuVNaCZpuB+04BjNsHdNydI50t0Hs9j71G?=
 =?us-ascii?Q?xlWVJo3VYnbnvqyT4vJFfvagGAFVxDkyyXcY5PJLG8u250WeHNXeDCwa+hb1?=
 =?us-ascii?Q?w94JtnPdKG3mIjWyi6mJ6NmOrCVM/I5yecVr3wHfNHvOd5faqAcXLYMz6LEZ?=
 =?us-ascii?Q?TvG6UQr4VoXBoldZqFTLZ2OOTvNvfURzEEw7j/iVCMsh6ugG7rgl8PB8NMoS?=
 =?us-ascii?Q?s2VcXpPSxJd/0FxYjyWAHkDBpWxbWO9iw+L6ZLMNRHoRs+udU4/qIPlkD2zr?=
 =?us-ascii?Q?1KOQvCXJJRm8i7PCYacKK9ETjLwPtgxvZQtCl0Z/cGlINg34iVAM0wXrNKmn?=
 =?us-ascii?Q?obtlbqShrVD0/mQLQQ7ad2tpIRkkGaIyvLNpEzucxUu+PM39P43bJhH/gnac?=
 =?us-ascii?Q?OZ7ONLMySMF7fuUvS6VNquFIPI0Y+i43WQy/90rS4EVEZaPuKw1ZRM3Uifmp?=
 =?us-ascii?Q?KBGg8trRknJUqSpwwrybi7AFMtpw4z52mFGXK35bo2D4oGFsKCAnCfZL8Fxw?=
 =?us-ascii?Q?jyTGrTR6EsYt3Xt5DXB/dB7cisRtYl1HeYQpITo2tACBp0UVXPh7oWspxm7+?=
 =?us-ascii?Q?bZophsX9AsE3l0RwMkBDQk50ausaO3AIGN6u31fAyd1yz6XGWRxhB3H/ZwLk?=
 =?us-ascii?Q?7/CSgKAfNZ0appsgf0m8eoX+p2W35/NL3xeoPkB7aHWoUCFEhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tym1DxLqImENdC8CXoyhCvKPmGmjup29oX9VP0GqAYSwTllwup18s6YNLKD/?=
 =?us-ascii?Q?eqUv6iw/dIyO4TmU0PgE4fLPHPtlF7KmgN0O3Zifeb2l+3KRCIDPnT0o1MPh?=
 =?us-ascii?Q?Cj9/52LHAqaNlaI89COAOW7IDPcdTF01I/KkBVcRFV0EhMyC/KRr4leeGIVt?=
 =?us-ascii?Q?6Bcpz4qhuvOXDB7S4HY3O/O5iS7GICVkL9Tw77M98547Cv9b21c7ipBVVXh+?=
 =?us-ascii?Q?aTdpeURE3vE4wFkKqprDy1KtiBay1POhn9METxrdTFtXHAhCplbTjtypdDo7?=
 =?us-ascii?Q?5GY6h3AP93pDegpCOYcao4yzB0oCRHz5XvY8z+5B8yPhbLRVZ/cPWkzmXWfG?=
 =?us-ascii?Q?9rORw9wJZ2nDwe/7flHWUxZDrGVrKExOPVBHKsiBOTAyCjlYACZYoKnCjj93?=
 =?us-ascii?Q?Ch0jI00WYLnfqzbBlkY6qUMoZoJNyS8cTCLpQIONz+Oi9UkrqZjbHuLJxy0F?=
 =?us-ascii?Q?vDu8RKykq7CcfJhEeHCKaQhDfLDvyKtyWcHgwKpWO/U9J8B4KdgBoULPNO8N?=
 =?us-ascii?Q?yLj7bWujRzZX+xRx3jNqE5r+y565TeU8qjl9nhCxzJIOYbxk8wtAoNLZFEeG?=
 =?us-ascii?Q?mTAD3WuEKHJvdjGDWsfiP3+zYf13w6Qk9Z/lzPMr/NPKGm1z4AUGM/m7YTAz?=
 =?us-ascii?Q?+jg2/s/f9eAzUXoVxfijinwpbfyFjkls7afc3h0zJsEVXJqF9CXtc8Fq2NhO?=
 =?us-ascii?Q?Bz7Ebi3WuIULKYzTHSfs5qnzUWCBpTP/hEKX49DNRuaQIb5+mpFwILoBEEZl?=
 =?us-ascii?Q?ICB1V5zhwqUztkNh+nLFutzN2cleBR0oHznam3jFgHSK35U0L6OWx5nv46NH?=
 =?us-ascii?Q?X0sR+1z955bfEt+jtJfw1LCPW1t/QMopi3QGJsYbHIc5nTauY3BgReobdVvJ?=
 =?us-ascii?Q?p36pyjV+pud3OYVqzg+hSck6iAPNlq+FRxdl2WYQjyEZXksxxgxu5RUsNf9K?=
 =?us-ascii?Q?sFCJa4sjjE1ROKMK5+E8iAV8so2X7b3VCLl9cd41f6kC1jSFfR4jTX1+FTFl?=
 =?us-ascii?Q?On0zupGnpfHgRzGus9JGXs7/fs+7YB3JpW/OUTHy7dvL6JBdgJBasCVegEBR?=
 =?us-ascii?Q?nBuiZYRIaW4JpGWjq356gV6Z5m6tcyM+EAQ2KCOqhNkP3UKD/I48Fuc9vcEB?=
 =?us-ascii?Q?XNxfaPkYHSIwpFuC2ZuIYD8gzEkd1212XitFvlzPWc4JhTn5pWoA8IzZj0jN?=
 =?us-ascii?Q?l+ZseM2CYOA6qz1CK3xqg3YmZVydddfiOcen2Y/PjP+OFJiPY1waJnwOKW8+?=
 =?us-ascii?Q?dHw9ng1IIc2bDGtjht6yJTI6fKx3HHLrtuIm1wektfJIBAOm6gCYyvyi4+Nz?=
 =?us-ascii?Q?71EgQRNXoyZ5MOOWyeohtiZVEQiFK9BZZT1R19f2gteu8AV+7V/H4M8FWPD7?=
 =?us-ascii?Q?rlKVubwDXS7Q8HHOpK+fKapWZR6FMtaxVyzpWuHXa4LoQBWUjb30MadnvGGT?=
 =?us-ascii?Q?kJsmOi7LONM40M8vOkkLWVUyZXeARZHCWjQ8Jgz5AXhqNPZGDMkTVFqO5owL?=
 =?us-ascii?Q?fJEUuq5XS21RBV/9neZn2usQkhm5eDlp2To/0Z91qXRwMoudSPRKjXDuYJf+?=
 =?us-ascii?Q?VFPkiFC3+QdccLRHCS+teWYM6urTOf0hthKZYEfY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c3e47f-0ae1-414b-fd06-08dcc73b45af
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 08:27:36.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glM9C31bnWrkkOb70BT49/Dan0MLqSVxOiOJRHi2x1WyxT6GntP3Fti6WWB6r+R8W2QGFoU1l17LS7ySLjDRUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6024

As opposed to open-code, using the ERR_CAST macro clearly indicates that 
this is a pointer to an error value and a type conversion was performed.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 7a9afd5231d5..5ed5cfc2b280 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -348,13 +348,13 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	umem = ib_umem_get(pd->device, start, length, mr_access_flags);
 	if (IS_ERR(umem))
-		return (void *)umem;
+		return ERR_CAST(umem);
 
 	n = ib_umem_num_pages(umem);
 
 	mr = __rvt_alloc_mr(n, pd);
 	if (IS_ERR(mr)) {
-		ret = (struct ib_mr *)mr;
+		ret = ERR_CAST(mr);
 		goto bail_umem;
 	}
 
@@ -542,7 +542,7 @@ struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 
 	mr = __rvt_alloc_mr(max_num_sg, pd);
 	if (IS_ERR(mr))
-		return (struct ib_mr *)mr;
+		return ERR_CAST(mr);
 
 	return &mr->ibmr;
 }
-- 
2.17.1


