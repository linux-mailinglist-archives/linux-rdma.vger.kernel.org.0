Return-Path: <linux-rdma+bounces-17441-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JZZNnU/p2kNgAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17441-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:07:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF41F69B1
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1F6313975F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 20:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6939EF15;
	Tue,  3 Mar 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eUEMbYsQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F3389117
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568297; cv=fail; b=V7tp6osCkpZy+B1zRCmxvUSw1grytrlnC0d7j4T1sUnqPAq+HNkIMJNYhLEUjIctHrS6HqzLuLi/uQlJToAFEvcORWPoY7ErUy3XNNStobVRzRe8EjRr2EX3ufPD6ugDYnStDhY+X/7N1QG9sFCiM0gh+aw7vw9uwwF++dDXB7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568297; c=relaxed/simple;
	bh=X/wTdnE2oRa79VIvcNV/e9WLxQTK8pjj8GgKL0z8h90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CA8x6L4FeApmbnkZvU5vdXL4Bx4xRDGDugJfr37eR33rc2ITzlxU5Y3oTMo9spYa4+zHo1pF57ge2DxMJqNgy6GDxp15IqBYbYVSyHgXRS+mPA9TMErRMB93RlRIH2vw9e5ZrPsIGXk7R8IThfSaeOFfmowtphIciug67zmoOCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eUEMbYsQ; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYkFe32FYyPMUEsL1k+WhHA6zXyTLwRJ05hxHaJGNXEnzlGrc9Hv2BZX5U/CzYES1YJ+++16/qlkp2Z1HPlinrtge8XKHLxV/BQawm0N+JeFOUJuAlfH4j+Vf++uXSGuB/exDU29880eosW/WJRcIVCw9COH5o1EWj3EvMRyccK9zVKKKMkJKVbvX//3ykuPGqWwPMaxpZLFFSA98KRDlY7TTSGxCNJiSUuonBoY7PD0Irzg6r+VvlMcsGI3E88HiqbXaqy1OLgHSQsoZC/SQfs5AuASoz5drej00RbeBrk7BhhhUfYLUO/t8upqB2PNW9fBw3g1HBIC0nLQwsiA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnbDNpsTIG1/uVdNaVxwvQHw8ph3nZiEZn33OBhYeeM=;
 b=knDCiP9rmI6RLIDYm6mj5iuT2QXwdhxzBK1w8oqouPfs/HYrRE60bLjbhb+rLG3xOVEYHSRTRrPekg4L7eAnViAUndGur6t3vlPObCDGSu8F1oxa8AfyKZEflZjd+2P+0s5Lk7SZlCbXFiSmV7irGHoj6VozGUiSUlOXYvojMUoU4l3InP+V45lmLnA3bn4Vd4ifGQe+wJXMFuNNKebcXQS4hMakgZxIyBoAA8/NaVHs/SYJ3GwRLDgINj6Rh30O1KjHDfiGYG96MMs8Mx8HIoiDi1mV2yZVJUlgrTaxHpSDiya2JArBudTzOB6tp8fvA5ZLsYYnuGQJPlqKGxy5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnbDNpsTIG1/uVdNaVxwvQHw8ph3nZiEZn33OBhYeeM=;
 b=eUEMbYsQit9NkVmTo4wlVncU6T91bElW0q1QGYmqibo7GbHZokIAm4EbppAQkFO8XknBwCyGREBSXcSAMdNTW/dOwkC7YTX2Rv+7OX+bPELiVJYsh2PYkR031S1Xr9Ue16NfczCB07TY15JxM5w8nFdo1e4PkQBGHvMsSRNRA433zVf2GJKxhrSH1IS7vaDu50BE4Et3IdHQGdeOEiwVWq9wYBKJBSUSNUTEradgSaoWde7jRvNdf7doO4QxVHn7XnflFkRYtSYhrdRmZcQyaa9H0mfYhd28DI+Pg4+5T8sx47GnC0QOHfBTu1ZI57UT7nczLuRtsRVrDeKkZ98dbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:04:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:04:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 01/13] RDMA: Use copy_struct_from_user() instead of open coding
Date: Tue,  3 Mar 2026 15:49:58 -0400
Message-ID: <1-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9059ad-3f6a-4960-9c1c-08de796021fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	M5V/njFz2ivEB4bXmvJqaFXVKrjb35XS8A873qUcUVXRsWz6NifSZOZAYm3WxBPEap9cM2nEH6QBnwT3JXBKmooaxI6mQUYaSO3RUNCeGPjKzT2fyKOy5fbah/9J06elTn2ItZYodaZ3QrTJ6seRIx0NpdTsRLPdLtOfBL/NYQpu0vhjLJTY1OhTZ6ZrvTgtptoj67eW/y+gpPJkV/1mj6NqX3EJqor6kieBHhJZnEYQXsDYWke9QQbA68t8SMkToIUlVVV5OactNhkK62TdYbbiATsttOScqeri1s6h0Nzkk/Jk6anHWkZ4PUS2aejHZuiLJL/PnvU0JIYG8QI1OJeBKWoTTGBu4LIzEipxz6FgI5ad4qpJi3fjN5giETh56XDmQu2PP6HsjRvlnp2XOwwpj60PUgSjv/x9gj2kSSO6WCbjK550RjVZmao3GwptfIOvR2shtAkXtl4izZOpsc0DHtM1m/UDAOmcE+RAk8Zc26njN9bmWgpGaE31+huiq4PuyWLnDcfkSBOBZt4Xcyz28eAmZx22GfYdVr2hqpuANq3DTgemHWn9sYQXfHNVYN5t4E98OZffIB/ayQ3NzTpSE04cmuOtprwjKtZ6ntiAu7dLOsNXIxQSbbvo9B1TSD4RvfBURyLfZKNqaapn832gxiIFnxx/JERCXYNDITBD9LBrtepwSiwNe6MVdoEWTE0c0eW6+L9AEmizm0qIzfi5Jf3hWezd3Jceq/BKcPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YouASXabn9L6KN5ldHOgh29pzy3xdfHUrtw0WR3rP+O4HpeBqjV402m8sbB9?=
 =?us-ascii?Q?L7vcU3PAfxyax7aeE581Uy+oH7OC03EcI3JhRFSyXPTaySTSWQhiXp+u/tZb?=
 =?us-ascii?Q?2Vaxot7HUxGEk79SStYwVgB+we+9iHrkCP/IMbqiEAiPzN+vt5iHgkIgz3I7?=
 =?us-ascii?Q?lZq3VUSxK/dAHYYfoBy04RympaHv1K0YeLlHufY68MAthf5UeUFhZ6aqZrYH?=
 =?us-ascii?Q?OqcEEuGH6IIq9F0LyXBdh4e2UUpgZjzMLM9/X1qgemy6HvFyQuBd1HoKoVX+?=
 =?us-ascii?Q?XMgKzq1GBC0D5lQe2CtvxIKVXH3lcwtBcIye4z7nwGT7NSORSRGZKUg0JWbx?=
 =?us-ascii?Q?TH8T7OEO7GEPgsV2Us4kI8gi4Dw42fUwLHlG7KXsGRTYWIIEW73wmm2jmdyM?=
 =?us-ascii?Q?5PWzi6UC0C+EXD5DL2m7l+I76cqUEkuNQI5Y61b2bMxjXCbdMQVFwN/lqDiu?=
 =?us-ascii?Q?MPndNzB4d0PVT2x09hRrje3+yR33mmOhikwNvIqNHVuz9zOOjYNu9MlETk8v?=
 =?us-ascii?Q?RIh6FutmSHIN+kjunUY9wpI3I6sl2URcoGiEn45PBC8nbU5kCevFQVpEUgNE?=
 =?us-ascii?Q?6a5jiOWautPfsazvrRMhbfdQ093c2VK/JNhBWCs746UbGuNk9LcPfoDQJwyU?=
 =?us-ascii?Q?Dkz7pDQ+jx4+GItEpglzOnbPxXHnLVpf6nVam+wvTnk3uobYj77bD/qKvL8B?=
 =?us-ascii?Q?rMhQH8LP7cWxdF1gKiy4sDX3bzPbLPG0qEz68B+fcOB+9y02coeuztcHSYQH?=
 =?us-ascii?Q?XlYMYR8qimDDpbpxZhuk5ZEIAbHQl0+ss9jZ94uZze8KL4165VFOtjkFf1ep?=
 =?us-ascii?Q?MmLLpd9FpQKBQcx62jQjPSG7zjbBo6h3TORwi6FKlD9ZiyrDol8rS72r7sTB?=
 =?us-ascii?Q?pvT3WRN5kEkNWGTyTDIFvlSka0DlLCg9yqlMxr/nXfSJe8jvwSTzXUB3Af1n?=
 =?us-ascii?Q?LR4U4jqWDoeeNSz0B6fVAsb9T0Gix6G9+bjQMXkOukePLJGVet6siNK5yE9p?=
 =?us-ascii?Q?NlU4J38wXc0gOU6FlkTD47lC2KwZ6d+4DaeoJ3AWlPxouDkJF+SheJ3kIA3w?=
 =?us-ascii?Q?CmFld2KQreOQk8ToNBO0knxrhrGvLqFvlpj/enaHQmWjzRARMammpLnRmafi?=
 =?us-ascii?Q?RmfikDOLtljDH0Os8KZ2dq0tvdIYn41WBppcuSWT4Di7RD4ebCsxMLuTNC9s?=
 =?us-ascii?Q?Keo85o0TlPXrpNtMOQ3J+ei2CEKSCkt9kkqXsSQL9VYZp533TvGnqD+Cg8wU?=
 =?us-ascii?Q?G9zwRGP0EdYSrL6pU6GxrzCknq3P6JSUT9M8WXMWYYDyzYEWOtTvudNyeOiC?=
 =?us-ascii?Q?6nXzKMTE1J0fJYhuzYWSnAvxT0BW4ipgNPIiVVZJFud/W7Lz/Q+YIA0g+ENq?=
 =?us-ascii?Q?FCSoMZk6tPJZTiCQxZGFm6nXtM4fV5jx4BpxW9fcEPMrd4lUXoVMPE7OmoaL?=
 =?us-ascii?Q?TgPRZJYHAG/KOg/8KbyMczYylqJ66otUuqIcIKqtfK57Q/t6/l5P3Ptgc6p6?=
 =?us-ascii?Q?3A2WFOYC95O4AREDYbof56TKPt+AGyEJKBfo91LXdaXptiWypvsBZHD75Cdv?=
 =?us-ascii?Q?VRFYyc1S+Ys9etWoOfPvPOj5ukindiKu/Pjyu7ZaDTIJh47lbBnSQP2sXeZ+?=
 =?us-ascii?Q?Z8PTGlGKrKu2zy7u2LhsU1myxiNqJ41fHYysnNf9ODVlcVxfqzqs5BxkSmt7?=
 =?us-ascii?Q?H68LBJEVmOJpLLvWq75avRyALQCztaJ3N4lMyB4ruaE3FKr7KrLsOAZk2zGb?=
 =?us-ascii?Q?BfYZOHn28w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9059ad-3f6a-4960-9c1c-08de796021fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:04:52.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzV30Z5boBrzEISQ+ZAYsDZY4pElsBJpOwc1zPC7RowhLVi+zbQyBjk0xZIWwt/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
X-Rspamd-Queue-Id: 45AF41F69B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17441-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

This entire function is just open coding copy_struct_from_user(), call it
directly, it is faster anyhow.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 758ed4ae5f7a85..5e5f049c3845a3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -83,28 +83,16 @@ static int uverbs_response(struct uverbs_attr_bundle *attrs, const void *resp,
 	return 0;
 }
 
-/*
- * Copy a request from userspace. If the provided 'req' is larger than the
- * user buffer then the user buffer is zero extended into the 'req'. If 'req'
- * is smaller than the user buffer then the uncopied bytes in the user buffer
- * must be zero.
- */
 static int uverbs_request(struct uverbs_attr_bundle *attrs, void *req,
 			  size_t req_len)
 {
-	if (copy_from_user(req, attrs->ucore.inbuf,
-			   min(attrs->ucore.inlen, req_len)))
-		return -EFAULT;
+	int ret;
 
-	if (attrs->ucore.inlen < req_len) {
-		memset(req + attrs->ucore.inlen, 0,
-		       req_len - attrs->ucore.inlen);
-	} else if (attrs->ucore.inlen > req_len) {
-		if (!ib_is_buffer_cleared(attrs->ucore.inbuf + req_len,
-					  attrs->ucore.inlen - req_len))
-			return -EOPNOTSUPP;
-	}
-	return 0;
+	ret = copy_struct_from_user(req, req_len, attrs->ucore.inbuf,
+				    attrs->ucore.inlen);
+	if (ret == -E2BIG)
+		ret = -EOPNOTSUPP;
+	return ret;
 }
 
 /*
-- 
2.43.0


