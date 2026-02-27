Return-Path: <linux-rdma+bounces-17264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLEuBEfvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AB61B1652
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46DA03020FEB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146CA28151C;
	Fri, 27 Feb 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPWiVYnK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951002773C1
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154686; cv=fail; b=Zy4Eg4f3b0XBqemMzyaQa65/CCJpKx1wthWotdBBU9ODMaS7/U7W16rOlVBztmL9OOZUNpKkzghGmTBECkM2uHayxc2b/I8IgXfl9+XWNQw/YrquMCi9O8jnKYlMuKik/bhLhE0y5nfDgoI5R976QgtTz7r2IJ6hQmiAaYgizf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154686; c=relaxed/simple;
	bh=pgxOSl27fo07G6t93hax7tKJi6SeHV1vkX/sknfnFZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjsvcrKn1oa7QYjXXdIuEVXwG8S1lVPncfYbIR+k7E3inQIfhmMkyVd4+gVdwHV30YMYHFagxAq4Ru6soW4E9xdT0/TBqzSYds7M1DwZVNlbkMXCkAftsoH3SJu2ez5oLWaA2iPqNBm1LWHsZSzqHGNyH8S0XmoJrFzhBtzz4Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPWiVYnK; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWqB7uXigHogcv8Sw5G6fp4M9VQKmmQIeR15nX0iqso+h53X1M51/mOOmVxTto6kYN0qPFwJpt5X4CT93yCPkuviB0dVpmGHVRF1ixCQBP/NfpETpJQ63E5mFTPScFa2oNsf20tHYvDz79W3+yVXz+a2+7tJAc1E62bfY5s73QyD2rCY4pqtBzXoPk/FAkIYzzikpwZFpQ8yzu6kKXtPzaRgFEHz4jBy/46Xv9EZezwflRsZ0FIobxT+nnbFuTyFT6XUw603coAaSiK77l6z0amkDVumBGV+WEnSUdIu93JKhsiFC5F2ePa/8egLsbI9QerF2ihaTYEjOxDb1p1tQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Razhz+7UZKS8a7skRldfBOmgt3Br9ed3Yk9fjs3og=;
 b=UTSFW76F0M2c9948NzCFB8aGczxfHemLzM9A1NEKrME6Las4VwVRDZn6GwGAenaoS73deRZo+3TrV3Z3RtWnO43XEs3CQ92bULbjG+J9IwXcqHktilgup2oQ7p1QtMeKuk/C9fx3yQCIYRAaX6d4bKsFTOMmImkROnoND+wDasj+tfHTTeByT650Y9ve6ZLFinL4D5ugFvAA1InE1Yd6jSNX8pcnS+RoSrh5zMmzDpXW6AiSDJQc9odFyMvaaklqTrG0Hol+y36ciXbvPcYtAkvDfftWYD3qLUorU23gvtOIz9SUS5PPBf9d3Sz8mt0IzEQ77KvdFWRH2NSUamo/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Razhz+7UZKS8a7skRldfBOmgt3Br9ed3Yk9fjs3og=;
 b=nPWiVYnKMx7OZ+hK7aQCHt/GCK85q8ca4ehEM205+7NwwI+rPNr3kXvcZBo31QdbGr1BwYV2RE/EIzetvxixlhVuuAljEsmwvROE4OolQ7hGdLpwWe83La7PFNtqpRPmyOwLY2IuGN18gBcbr2aKp1RRypSWJpD14QqkTfXu4GUIrTZp+XbDB4/3zE8rL3Jf9LsoQAWnGNH6Qc+70LpXwBaZtSvDqDV+ezJ91qMxqWF3ni1tVc3igFq99adtKnDGEY7ZLYryD8la9OTeE5GRJlwgbETqgpGyWGvOeEoOu19CrqlAYg/UKlaiOOYvnEjDBsR74BJp8YZeWk/PQcJpGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:21 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 05/13] RDMA: Add ib_respond_udata()
Date: Thu, 26 Feb 2026 21:11:08 -0400
Message-ID: <5-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 197e1add-8e8c-40fa-1307-08de759d1c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	DI8UwdPvPub/ZWKXSBRAeIoOJM/jXnrRU074G2nppN1iijWgYXbTd3CXYTrkc+h/5BAwIB09GcVwhfDsKS3C5SBf75A1UZ31dN1v/iSPxq7qU64xbMVpNbkdqdwXd2VtjArIK5FkpQsY2F49EsUpvg0uZnZaP3zdBcWdrpMdL3l4Q/pIFYNIr/zymYWMfvIA4TUATYd6jQD+faU7bRQTzANIKO1H+PDBNBEXbOzj7F3PqX8e64RxhPpwZYBMqwwywDqSFdJrbAG5NmFSLbY30G/SVsHkwG95oGUT9Z+rDC4MR6PH1ktwLvViTL8KTRvYRMnUuMAnxlsgOb+L93qXew7+KecrOHTgl5A6T8Vk1hebrY7GPbiur1A8G31kzASTnicvhwOvWjkp8piKg8eqJkEqDwhClb1qwoIOgFvmZhYrft85o2djMJMvjAITEtz1wxFJx1+uMU2jHSfHVTj9Ehti24jAzlSisMWZfxFfH5AH+ksMZHIxktbpIaN5zFDsxqiBc4iFIAg+pqAeyTHwNvFqYRjcFiBWNzb4vTxaDPID+VXM/0cJghjMV14e125SjNZGTeoYzIP85UbyZLevtxDv/Gkgg1Or8kBJtmdFeve3vCTzgeBWxatwkHU3P6LyDKq0Z4hzCT/R4ORSzLj/WWZVPuSrWahOKfbkOGfTIbl+RR4xuWiddXDErBy+6Dc8rkdzSZGGoqbSEvMqqYXVl7biVD6g1EvFA7NPF0FcpTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xT0HfWNZDL5gzh8i8NDMJZHDb+y/JaFu6jWjlwMcrHJ1NkNCo1AoDdD1I6zs?=
 =?us-ascii?Q?o9g/aTbzXJrS3GSCCbu7TSsgnPUZ0bN3MxyBhD3J9IgQXWh6nHYQSs6eiWS9?=
 =?us-ascii?Q?iZprvyFowSUOUyvnHjbHbaBNtmlQcYuTdKqZbqd0Nqe/sRahJ4B8T/GFZRGE?=
 =?us-ascii?Q?S38BSWymoGG5VI0SsVZiAzUlOBxbCiIvCVdsEw0Y7+FSxF++Qr5G7B4/+Q7o?=
 =?us-ascii?Q?LC0l3fOoZYTZWstrfv3qbilTQmsgGU4wDjOUBi3gs/77ApALlussTGgCbj1S?=
 =?us-ascii?Q?eVJmsFR/O4MERuOyyCirX7/0ezHcXQkFyxO5EYJwPFOWALrFgIV9Znu9h+s1?=
 =?us-ascii?Q?pE5oSxcX1+rTEhtMHzglL2T+rumWzXKSVK5W898FqKLPZ3OYcObH/VQTEgHj?=
 =?us-ascii?Q?X2iwvZXkXbL2I4kzuT4nTyadFPxv6n387oY7rgdBoNHZzA5CdkjznEX+YdNN?=
 =?us-ascii?Q?wxzw7pSmQ5zxdFTt1adDTtzfFqIL+7lw8zIjwncN0vqAfgOsBvSXckLvjRxk?=
 =?us-ascii?Q?OIj6o5556E7Y834S/7AGQQheD14IE+p22uWghIUraXkDyALz7yvpbOezqHin?=
 =?us-ascii?Q?DLdUeClCJf3DxYtbp6ondIsSDAmzL2+mKD/FDGZdBIiuE78hVxJc6BEhEDC0?=
 =?us-ascii?Q?zKLnKRY+oxM+5E8t1cf84MHK2IgrejumfTLPPXcY3AXAXvlYZkQ6uaBUZ/WL?=
 =?us-ascii?Q?lzlQxd9Mpf7ZPxAYOmFumqGIHKtbq3o4YbQ5sgoHPJQM3AMbL8dIm3zaCtqP?=
 =?us-ascii?Q?BRhm8M+NXsMDjtxZvd9XOy6Xv6AlQRjDxPqk7jIEIBHJQ4ZKVIpfdOK7Xbyk?=
 =?us-ascii?Q?jJl3VH3qyqJYt9Go2rDZH3VcqTx5Kx83Vmw//JdNtCkslnBYrr3gN3cz08Ab?=
 =?us-ascii?Q?y50EHZlIllra1iV2cRvLAW+hKStJ+A1cin4wYNJ0sbpTX/PFjftir/tskHtC?=
 =?us-ascii?Q?cxrBGUl4+8035DoCc7DK0Ljx7GOEnJc3Xeo+R+SC5NEBGj6Gb11TyOYYOvK7?=
 =?us-ascii?Q?TveY7LyXnHYQgE1ZowBrrJZY1102xf9N/AoJ4mQUqEvuqQZ2EsPg96fAzF9w?=
 =?us-ascii?Q?Hl3jogwWa8szrhet1NwzxHw6g2n9Jo0DObsgWuOf0v6m6b7tAIQRIABJMk8R?=
 =?us-ascii?Q?boV3GLMxWI5SgEyq3Lh+XusR7CljKDLDei3/YN+0tCA8UTYl7anbi+RQExSr?=
 =?us-ascii?Q?mjNtWkqLDuRFHOqRqUH1WaAx+B7x6MxljHSRzillzJeWdvM9B4qeU2I0kCdh?=
 =?us-ascii?Q?eL7Jih06rEPPqmWudS7i024TnK9H57u0TPPEXuoKKlcT2or8wt5Lut2pXtAS?=
 =?us-ascii?Q?/mCrUtyPFae0Mhj64T2Jcu2ie/O8iWgx0S400YEGWbu2ep3agP8GAwo768as?=
 =?us-ascii?Q?Mc1tAGok1tFuJw3s6tJlxiALC38P0+iPl8Zn4Iwbb1dgxY/rxrOD4W7jI5eU?=
 =?us-ascii?Q?xZUxs4O0floVqnyTk+Bk41+cxrqwweUZkOVq7rXwsnv6ABqHnwuov9R37XUA?=
 =?us-ascii?Q?I/sUpCyrXkSZo58K8wHNYzR1gua7116C4JlBVCYA8JhpTI6tpfpLQzSWR9mf?=
 =?us-ascii?Q?4KBjgCp0WSIW1dywkvZjQNkI7lBpiPHID3ZleHjvYx586hkKWdqO5jzFaifa?=
 =?us-ascii?Q?K9X+42LWjdDYfnzh24CGkwjxRmK2iWfV3wwogTmtWbktaap5MybKRbQRU6OJ?=
 =?us-ascii?Q?+a1FXcLY4wPTdFJqEXS4AVtxhH1KrSYvioc3p7Ng8ZNQPbQvAEJB9bMHnfre?=
 =?us-ascii?Q?SvLRIy/2mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197e1add-8e8c-40fa-1307-08de759d1c7e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:18.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkSDwX2ettr1p7GZQIx0jENfHXLbxtxAPD1mHN8lr/JkH41rceP4YwDyK3Y6/jzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17264-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 33AB61B1652
X-Rspamd-Action: no action

Wrap the common copy_to_user() pattern used in drivers and enhance it
to zero pad as well. Include debug logging on failures.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 24 +++++++++++++++++++
 include/rdma/uverbs_ioctl.h            | 33 ++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 5e5b00c6236fa8..b61af625e679b2 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -910,3 +910,27 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(_ib_copy_validate_udata_cm_fail);
+
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
+{
+	size_t copy_len;
+
+	/* 0 length copy_len is a NOP for copy_to_user() and doesn't fail. */
+	copy_len = min(len, udata->outlen);
+	if (copy_to_user(udata->outbuf, src, copy_len))
+		goto err_fault;
+	if (copy_len < udata->outlen) {
+		if (clear_user(udata->outbuf + copy_len,
+			       udata->outlen - copy_len))
+			goto err_fault;
+	}
+	return 0;
+err_fault:
+	ibdev_dbg(
+		rdma_udata_to_dev(udata),
+		"System call driver out udata has EFAULT (%zu into %zu) for ioctl %ps called by %pSR\n",
+		len, udata->outlen, uverbs_get_handler_fn(udata),
+		__builtin_return_address(0));
+	return -EFAULT;
+}
+EXPORT_SYMBOL(_ib_respond_udata);
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e4719419460422..720f173c2b3fc7 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -900,6 +900,7 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 
 int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 			       size_t kernel_size, size_t minimum_size);
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -964,6 +965,11 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 	return -EVINAL;
 }
 
+static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
+				    size_t len)
+{
+	return -EINVAL;
+}
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
@@ -1069,4 +1075,31 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 		ret;                                                          \
 	})
 
+/**
+ * ib_respond_udata - Copy a driver data response to userspace
+ * @_udata: The system calls ib_udata struct
+ * @_rep: Kernel buffer containing the response driver data on the stack
+ *
+ * Copy driver data response structures back to userspace in a way that
+ * is forwards and backwards compatible. Longer kernel structs are truncated,
+ * userspace has made some kind of error if it needed the truncated information.
+ * Shorter structs are zero padded.
+ */
+#define ib_respond_udata(_udata, _rep) \
+	_ib_respond_udata(_udata, &(_rep), sizeof(_rep))
+
+/**
+ * ib_respond_empty_udata - Zero fill the response buffer to userspace
+ * @_udata: The system calls ib_udata struct
+ *
+ * Used when there is no driver response data to return. Provides forward
+ * compatability by zeroing any buffer the user may have provided.
+ */
+static inline int ib_respond_empty_udata(struct ib_udata *udata)
+{
+	if (udata && udata->outlen && clear_user(udata->outbuf, udata->outlen))
+		return -EFAULT;
+	return 0;
+}
+
 #endif
-- 
2.43.0


