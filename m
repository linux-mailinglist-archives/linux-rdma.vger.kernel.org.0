Return-Path: <linux-rdma+bounces-17439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI4aByw8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666A1F66D4
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56316304C7F8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA46386567;
	Tue,  3 Mar 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqINFKpT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DC38655C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567429; cv=fail; b=J45suwI3/kqD3oSw35sXekbm8KRgZsmAZZEYKbxN0GOg1Q3RVdGe7isWzK+m20t4hcssmlyNpl2WozCU/FWjaLAWQXWwrx/ho0ypJheXMY/PtZZz0S2UqVFCpAXY3EUZoLVeABfREHlNt+cjcoLAz2nI5QctJGRXFxmDCouYRic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567429; c=relaxed/simple;
	bh=swUizTVbC9uGkmPw2nxIyOPUHErS0U54vdWHCu1L+cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ivmu9Q8f5JoVjqLTY9MYEGaiCxSY2uOZq5zGoBmOdkxrOO6BWXrnTkbMNwQFStv8rtPpncoEN028gMg5u6kpIVuqsSeNAn6Fsj4ctQnp4uxdA1mLMwMVN0aYWnhZqC/0wAE3lcKHyNXuHdy6dO6INCV2htaM6XoVR7pD6Fqxnns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqINFKpT; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/4nHqygV6TnfvDt8DvyPz8z1aqOUbXMrr1AN4lckaaNdXsvoMx9jguQJF1jVB1RiilwQeVyipe+/BHsDFmQwXeaGyN3rDR1//Kmz1mXmZBDa00eBOBWazkwWyV2nEUIk6JhnI7aSyqroiX48h11nkEh2iypIMyyszkkEChYr3jVZzIru4bF4o/q+FbJX45jSoiTBs4G9SPsWGTCkakbHQetRtzdKBbV/gV094zt4/UqGjy+723odJw0EX1SOxvdqF+IeG5a1jETErxK+r7t9R79nioW1iljCSU6QuZLRKhuTSJzwcMgF7ZDggrSzUMIJ+iee9U5szRNRexNG167+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if5m9X68kB5wsZZ0iT5/YwY4EQDcD6EJm41+DlAOUy0=;
 b=ZWLzEj5WQS+EQKq3jb1RlwkR1KvUWUd4WeEz7zARoXWiMTlFOTj7WgKrYUDKRWa9hEVyX6NdMXj1I4ZBQVtN1eHssNALuTKaxXaOohICb9ndG9M1xU7QB88jKgpex8Vbv68aAiXZMQJrLfXbf9g193RT3vgUqtvnfBsRCSLBXdAsZknF7eYOCCpZtChFNKLsKbG9coEEJKwKw5CrIHI0LbBWCFpu5/lu0aTLlp5KP8uk6ieUtaY6hM1gQ+CCiq2/37Pdo/LgH+ApwSAkG1UIii5qYkZmlTnFi8kdsAqiVTAZbwObAE8x9+1UFrsgR+yN1i2CkOT9CJsEE5HE7v6adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if5m9X68kB5wsZZ0iT5/YwY4EQDcD6EJm41+DlAOUy0=;
 b=hqINFKpTCqYaVUqVpGsIdwcl2CzD//BWfKj4fSX8b1brqCCUhttnA+dXM74F/RG3943odyJInEt2Nl29FRtEDEp0aLb0xMuUeb0mG1qiDwjUICYMcXQFdDvdzsPC0sYtDHN5uSoEFmjS7m65oKS5zy53SwclM4t50+FyfG0iQlNeHz4rknhxGsvAH7wo/QY9JOQLJAm2Pj2CW5kK1cvpMPDPpbM2/TUk9vd3UXrSh+FnHB7N1TtjOGnfNKEcDf6Loi4nHAe2pybr9Vjnq8ixl2QnyHFtVW0qx25rlX34oYJVu/1qL67anBkKEfL4vb3gikmvfGXG3IA6v7s/5s6t0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 08/13] RDMA/bnxt_re: Add compatibility checks to the uapi path
Date: Tue,  3 Mar 2026 15:50:05 -0400
Message-ID: <8-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d92585-6bb0-4cf2-fbb4-08de795e166e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	SNkrfBX0QH+1wlg7cAOEj6vTq84p9I0pv7QGLKlh9Qx5Lq/IU9GtJydLx8It+1l5+9nLuaH5LC2I0RT7bs/sM3Xj5+RXKTEq2ZGs6BC4+aewCnbF4I8Gn/5Qr+9Y4iQ3HinDeU/7hoO6f66YhqMXudYvlDL3A4g+izFyfqEF/ao9fBg/oPmXdGSncvJFC+EjgT24pUEZ5bm4HSn0EiaiCW9J/IQi3f4i3nfY+2RH/4+f9HrwoDe4VQ0x7tFa3f4adUW5dyL5HKz+YLVBY9ySRNqlbEfaKUsvageErycyB0jlOJ4guHr9ZzXLCN6k0mohPLFQTwqon/Om/hD6ze94PNXklIURTJT3OP7GkwIUO6Nt17eFB0VnojWeTEC1BET58fIwq1RfHl/nwsNemxAzSZCJgPBQWO5duJVvd2NyHMR502oDZtvz7+Xo2b6UVvOrBTc+0lkeiqa8uOmoPmA3JxanyHah2Om7PlqHu8O5uIKtAEPQbQlOQIQ6uutMSSfhXmVuWwjuqMyGti5A53ptO+CVJoMx2CYXPIPIcwxJnXA6qd6z+OrhPZO5MEs4SxJzJPDItiAzxJ6LSzkP2gJCggXFHcSpkt/1k1GvlLrMy23Y1Lxkuk7PHR2DrR0oklPJg/8GthnJJjTEj62jkaKhUa5CWomhZy4xyNo3I7y8x+CyEZuNwPeMLxC3CVrx+hh/xbEiYKtJ9K+BpyM7XA/wdvbwK9xbpOm4sZFhcdPr9DE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQnXv9gdiuWZDFukUwHOW6ta6U+lNG+cm/uQD2fZ4frOJ7kv4I+2UKXiDTtA?=
 =?us-ascii?Q?lDgIkWhKt2Nndz9vgMNBofRNr77NWkVBaJF3/iZf+RhkpdOK9YHjW1ysZbYF?=
 =?us-ascii?Q?A2RuzBdEgiWEHBidqLECrtmHmdwENlqOfIl1DiDWGqksF3ce0MkHwJPwIxK5?=
 =?us-ascii?Q?iIFbN8PwvQaqbKXH0dmx+OD6b525c5KjXF/VMoJl19Ioz9idnivMsYKWik54?=
 =?us-ascii?Q?sajtEetpT2b3WQsfd3Xemoq1AYvd38q2Bu/+mTIYgGx2RyXyyPouU1L1Kbim?=
 =?us-ascii?Q?AvlyySQJY8byavS5H8PmfDgytb3yOR9Q+sBQYUf8n/rhO6q7EAjMNLrVwf2l?=
 =?us-ascii?Q?Uuo4eRGpfyg47J/h5NQ1bLp+ld8tk1Qy6cRut5TeI+fWnQ+1sQ12fj74ILXS?=
 =?us-ascii?Q?J1aOhQHaBU/RAgj3BTbglYJeHm5DsCeSmxXo1OD8nOIeXsosKqtqnMTS5mc8?=
 =?us-ascii?Q?qwatK2CtmoEkZjyvSzh/PHIwgwvu4InoClybY/T4oxW1l0vWNYZ45WYgmk0S?=
 =?us-ascii?Q?u7D6bV/vynV19O5oSdsud48bYzB+qpGeRz+l62bPYlu9/9rgIk40E1McOlnA?=
 =?us-ascii?Q?zq4u1dfl0ZmlMSoakOEWv2WDCKJC80jxcqUZK/9uQRZ0gsSt+feOflupKzaX?=
 =?us-ascii?Q?dRXX/2os3YSH3zGiaGpVoGeTWvjlu/C0de0K/+EMPRx0YGGI4jeEpryoEw4o?=
 =?us-ascii?Q?bGUx/hOjg2GhGpNAb+8zWYr2ILd+0kr4WBmWCicESLxFzodEP+ZXeSikQsMd?=
 =?us-ascii?Q?MSImAaN9OxoDJ+LPHAY+np3+1Wjqvqlfd+jA2kZXwFi8ZFpYLIKlQfSOjsZX?=
 =?us-ascii?Q?zvUXEdzWEj0Qd+MCpBy0v2L2+fqoCWn2diPxHA6df7fffENg2FpEuliWek3R?=
 =?us-ascii?Q?Eadb3qHtyrLi3lwAYL4YUCrUXHM2u0PKUO8gbgIIOMTiRmLlxvqpA5Qyfygk?=
 =?us-ascii?Q?NLm5q01nh8/hfDLTfLC5qdwuMI5Gh3WLAtnvwIuhnDglfVdns6t/2MnYlILc?=
 =?us-ascii?Q?TUqSNJFAK2YkWpu1A9CWbGtgMsxliXk5CvQ6/sQS9aHegG+SSoGQk+hAVzwF?=
 =?us-ascii?Q?QazDhFQDW3HPYmEWqISPx57FZX8rPXLcyPQbFs+4U3rjcyrEy1lw1P3aVpuC?=
 =?us-ascii?Q?YnUdXJeKHw+v3XQxTxy+GJ96a99+NNHd8GaSlY75ttTjqGlVISvzB1D/xzcI?=
 =?us-ascii?Q?QAtfV7Ltt6Ne5Zef0+2eWwiEmDTrAR/Xth02JoxweihFEl5cXw84wjEt2bQF?=
 =?us-ascii?Q?SyeWuO/OrAFPUe6E0cgoTA13hzLIfSrJjHB+LLYIi+Z7+eZuZURM89ENb/ba?=
 =?us-ascii?Q?ml2bH2EIDOMx0+Gk+DQheeooXrkKGUaTaHIqdE5ZNm4PekdGwfUn0M1Gevve?=
 =?us-ascii?Q?eTEG0seZQ13yPX45wpAduNTpkiPxgcL09VKTvLXQxO2ZmvJgdARncVbNzCxj?=
 =?us-ascii?Q?KA8KaUquSnd5KGDi1fbwwI/oCytgCAXqZ8jAS5JTvv9qfDygUQmGzMaUFyYT?=
 =?us-ascii?Q?1/8IhONTLI6c52nqztELbD3UiG0GVbfrG0vn/xBTYKPgzTDkYmMtx0dXh0CX?=
 =?us-ascii?Q?oewVwYbTJJeeCCc84gc0u3A+JqkHxO1psY6Cj/1qyFgn4erMJAY4tYvEe8KD?=
 =?us-ascii?Q?PfAKotgVcY0+t8cmRkZ0yHs+YYNW1kfFPOUq8IdFbogR4m7UCNbDmfcQCc3p?=
 =?us-ascii?Q?eB9+MwLRvk1U2cyDg+UWcn8rXOjq6fu8AWACyUu3S3xuvWm8b/qJwTtJwVu6?=
 =?us-ascii?Q?FYJeXsb3vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d92585-6bb0-4cf2-fbb4-08de795e166e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:14.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v47cMXQ3m8jEpeI3mSfd0kskIf4mlZ9I58029BYa/8Xj7HRtCnYgFvgaXCbfYjnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 6666A1F66D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17439-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,broadcom.com:email]
X-Rspamd-Action: no action

Check that the driver data is properly sized and properly zeroed by
calling ib_copy_validate_udata_in().

Use git history to find the commit introducing each req struct and use
that to select the end member.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 5c5ecfacf50612..e1d72ae8261192 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1671,9 +1671,11 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	if (udata)
-		if (ib_copy_from_udata(&ureq, udata,  min(udata->inlen, sizeof(ureq))))
-			return -EFAULT;
+	if (udata) {
+		rc = ib_copy_validate_udata_in(udata, ureq, qp_handle);
+		if (rc)
+			return rc;
+	}
 
 	rc = bnxt_re_test_qp_limits(rdev, qp_init_attr, dev_attr);
 	if (!rc) {
@@ -1863,9 +1865,11 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,
 	int bytes = 0;
 	struct bnxt_re_ucontext *cntx = rdma_udata_to_drv_context(
 		udata, struct bnxt_re_ucontext, ib_uctx);
+	int rc;
 
-	if (ib_copy_from_udata(&ureq, udata, sizeof(ureq)))
-		return -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, ureq, srq_handle);
+	if (rc)
+		return rc;
 
 	bytes = (qplib_srq->max_wqe * qplib_srq->wqe_size);
 	bytes = PAGE_ALIGN(bytes);
@@ -3177,10 +3181,10 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
 	if (udata) {
 		struct bnxt_re_cq_req req;
-		if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-			rc = -EFAULT;
+
+		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+		if (rc)
 			goto fail;
-		}
 
 		cq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				       entries * sizeof(struct cq_base),
@@ -3309,10 +3313,9 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 		entries = dev_attr->max_cq_wqes + 1;
 
 	/* uverbs consumer */
-	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
-		rc = -EFAULT;
+	rc = ib_copy_validate_udata_in(udata, req, cq_va);
+	if (rc)
 		goto fail;
-	}
 
 	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
 				      entries * sizeof(struct cq_base),
@@ -4414,8 +4417,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2))
 		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED;
 
-	if (udata->inlen >= sizeof(ureq)) {
-		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
+	if (udata->inlen) {
+		rc = ib_copy_validate_udata_in(udata, ureq, comp_mask);
 		if (rc)
 			goto cfail;
 		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT) {
-- 
2.43.0


